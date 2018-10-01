# - Find kokkos
# Creates a Kokkos::kokkos imported target
#
#  KOKKOS_INCLUDE_DIRS  - where to find kokkos.h, etc.
#  KOKKOS_LIBRARIES     - List of libraries when using kokkos.
#  KOKKOS_FOUND         - True if kokkos found.
#  KOKKOS_SETTINGS_DIR - path to kokkos_generated_settings.cmake
#

find_path(KOKKOS_SETTINGS_DIR kokkos_generated_settings.cmake)

find_path(KOKKOS_INCLUDE_DIR Kokkos_Core.hpp)
find_library(KOKKOS_LIBRARY NAMES kokkos)

include(FindPackageHandleStandardArgs)
# handle the QUIETLY and REQUIRED arguments and set KOKKOS_FOUND to TRUE
# if all listed variables are TRUE
find_package_handle_standard_args(KOKKOS DEFAULT_MSG KOKKOS_SETTINGS_DIR KOKKOS_INCLUDE_DIR KOKKOS_LIBRARY)

mark_as_advanced(KOKKOS_SETTINGS_DIR KOKKOS_INCLUDE_DIR KOKKOS_LIBRARY)

if(KOKKOS_SETTINGS_DIR AND KOKKOS_INCLUDE_DIR AND KOKKOS_LIBRARY)
  include(${KOKKOS_SETTINGS_DIR}/kokkos_generated_settings.cmake)
  add_library(Kokkos::kokkos UNKNOWN IMPORTED)
  set_target_properties(Kokkos::kokkos PROPERTIES
    IMPORTED_LOCATION ${KOKKOS_LIBRARY}
    INTERFACE_INCLUDE_DIRECTORIES ${KOKKOS_INCLUDE_DIR}
    INTERFACE_COMPILE_OPTIONS "${KOKKOS_CXX_FLAGS}"
    INTERFACE_LINK_LIBRARIES "${KOKKOS_LINK_FLAGS} ${KOKKOS_EXTRA_LIBS}")
endif()
