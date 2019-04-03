Received: from eggs.gnu.org ([209.51.188.92]:49845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hBnJm-0006Ps-EK
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 17:21:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hBnJi-0000p7-Eg
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 17:21:10 -0400
Received: from indium.canonical.com ([91.189.90.7]:52170)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hBnJa-0000Zz-HU
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 17:21:02 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hBnJS-0007EH-Ag
	for <qemu-devel@nongnu.org>; Wed, 03 Apr 2019 21:20:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 3C7272E80C8
	for <qemu-devel@nongnu.org>; Wed,  3 Apr 2019 21:20:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Apr 2019 21:07:54 -0000
From: =?utf-8?q?salvador_li=C3=A9bana?= <1821839@bugs.launchpad.net>
Reply-To: Bug 1821839 <1821839@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <155365513189.10025.3834324325375490887.malonedeb@wampee.canonical.com>
Message-Id: <155432567483.7949.4389703810646582266.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1821839] Re: qemu 4.0 doesnt support glsl 3.0 but
 yes older versions, that have no sense IMO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I didnt understand properly the output, it only can use opengl es 3.0.
you should put that info because when i compile qemu it pass and it
should if doesnt support my opengl setup.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1821839

Title:
  qemu 4.0 doesnt support glsl 3.0 but yes older versions, that have no
  sense IMO

Status in QEMU:
  New

Bug description:
  tested on qemu 4.0.rc1 on rpi3, mesa 19.x
  maybe I am a bit confused, but why it can use and older version from my m=
esa driver, it should pickup the right version instead of going to the late=
st.

  pi@pi:~/Desktop/armbian/windows_95_vdi $ qemu-system-i386 -cpu qemu32  -m=
 32 -display sdl,gl=3Don -device virtio-vga,virgl=3Don -soundhw sb16 =

  qemu_gl_create_compile_shader: compile vertex error
  0:2(10): error: GLSL ES 3.00 is not supported. Supported versions are: 1.=
10, 1.20, and 1.00 ES

  qemu_gl_create_compile_shader: compile fragment error
  0:2(10): error: GLSL ES 3.00 is not supported. Supported versions are: 1.=
10, 1.20, and 1.00 ES

  qemu_gl_create_compile_shader: compile vertex error
  0:2(10): error: GLSL ES 3.00 is not supported. Supported versions are: 1.=
10, 1.20, and 1.00 ES

  qemu_gl_create_compile_shader: compile fragment error
  0:2(10): error: GLSL ES 3.00 is not supported. Supported versions are: 1.=
10, 1.20, and 1.00 ES

  the sames happen on mesa 13.x (default mesa included on raspbian)

  GLXINFO

  pi@pi:~/Desktop/armbian/windows_95_vdi $ glxinfo
  name of display: :0
  display: :0  screen: 0
  direct rendering: Yes
  server glx vendor string: SGI
  server glx version string: 1.4
  server glx extensions:
      GLX_ARB_create_context, GLX_ARB_create_context_profile, =

      GLX_ARB_fbconfig_float, GLX_ARB_framebuffer_sRGB, GLX_ARB_multisample=
, =

      GLX_EXT_create_context_es2_profile, GLX_EXT_create_context_es_profile=
, =

      GLX_EXT_fbconfig_packed_float, GLX_EXT_framebuffer_sRGB, =

      GLX_EXT_import_context, GLX_EXT_libglvnd, GLX_EXT_texture_from_pixmap=
, =

      GLX_EXT_visual_info, GLX_EXT_visual_rating, GLX_INTEL_swap_event, =

      GLX_MESA_copy_sub_buffer, GLX_OML_swap_method, GLX_SGIS_multisample, =

      GLX_SGIX_fbconfig, GLX_SGIX_pbuffer, GLX_SGIX_visual_select_group, =

      GLX_SGI_make_current_read, GLX_SGI_swap_control
  client glx vendor string: Mesa Project and SGI
  client glx version string: 1.4
  client glx extensions:
      GLX_ARB_context_flush_control, GLX_ARB_create_context, =

      GLX_ARB_create_context_profile, GLX_ARB_create_context_robustness, =

      GLX_ARB_fbconfig_float, GLX_ARB_framebuffer_sRGB, =

      GLX_ARB_get_proc_address, GLX_ARB_multisample, GLX_EXT_buffer_age, =

      GLX_EXT_create_context_es2_profile, GLX_EXT_create_context_es_profile=
, =

      GLX_EXT_fbconfig_packed_float, GLX_EXT_framebuffer_sRGB, =

      GLX_EXT_import_context, GLX_EXT_texture_from_pixmap, GLX_EXT_visual_i=
nfo, =

      GLX_EXT_visual_rating, GLX_INTEL_swap_event, GLX_MESA_copy_sub_buffer=
, =

      GLX_MESA_multithread_makecurrent, GLX_MESA_query_renderer, =

      GLX_MESA_swap_control, GLX_OML_swap_method, GLX_OML_sync_control, =

      GLX_SGIS_multisample, GLX_SGIX_fbconfig, GLX_SGIX_pbuffer, =

      GLX_SGIX_visual_select_group, GLX_SGI_make_current_read, =

      GLX_SGI_swap_control, GLX_SGI_video_sync
  GLX version: 1.4
  GLX extensions:
      GLX_ARB_create_context, GLX_ARB_create_context_profile, =

      GLX_ARB_fbconfig_float, GLX_ARB_framebuffer_sRGB, =

      GLX_ARB_get_proc_address, GLX_ARB_multisample, GLX_EXT_buffer_age, =

      GLX_EXT_create_context_es2_profile, GLX_EXT_create_context_es_profile=
, =

      GLX_EXT_fbconfig_packed_float, GLX_EXT_framebuffer_sRGB, =

      GLX_EXT_import_context, GLX_EXT_texture_from_pixmap, GLX_EXT_visual_i=
nfo, =

      GLX_EXT_visual_rating, GLX_INTEL_swap_event, GLX_MESA_copy_sub_buffer=
, =

      GLX_MESA_query_renderer, GLX_MESA_swap_control, GLX_OML_swap_method, =

      GLX_OML_sync_control, GLX_SGIS_multisample, GLX_SGIX_fbconfig, =

      GLX_SGIX_pbuffer, GLX_SGIX_visual_select_group, GLX_SGI_make_current_=
read, =

      GLX_SGI_swap_control, GLX_SGI_video_sync
  Extended renderer info (GLX_MESA_query_renderer):
      Vendor: Broadcom (0x14e4)
      Device: VC4 V3D 2.1 (0xffffffff)
      Version: 19.1.0
      Accelerated: yes
      Video memory: 938MB
      Unified memory: yes
      Preferred profile: compat (0x2)
      Max core profile version: 0.0
      Max compat profile version: 2.1
      Max GLES1 profile version: 1.1
      Max GLES[23] profile version: 2.0
  OpenGL vendor string: Broadcom
  OpenGL renderer string: VC4 V3D 2.1
  OpenGL version string: 2.1 Mesa 19.1.0-devel (git-f1122f78b7)
  OpenGL shading language version string: 1.20
  OpenGL extensions:
      GL_AMD_shader_trinary_minmax, GL_APPLE_packed_pixels, =

      GL_ARB_ES2_compatibility, GL_ARB_buffer_storage, =

      GL_ARB_clear_buffer_object, GL_ARB_color_buffer_float, =

      GL_ARB_compressed_texture_pixel_storage, GL_ARB_copy_buffer, =

      GL_ARB_debug_output, GL_ARB_depth_texture, GL_ARB_draw_buffers, =

      GL_ARB_draw_elements_base_vertex, GL_ARB_explicit_attrib_location, =

      GL_ARB_explicit_uniform_location, GL_ARB_fragment_coord_conventions, =

      GL_ARB_fragment_program, GL_ARB_fragment_program_shadow, =

      GL_ARB_fragment_shader, GL_ARB_framebuffer_object, =

      GL_ARB_framebuffer_sRGB, GL_ARB_get_program_binary, =

      GL_ARB_get_texture_sub_image, GL_ARB_half_float_pixel, =

      GL_ARB_half_float_vertex, GL_ARB_internalformat_query, =

      GL_ARB_internalformat_query2, GL_ARB_invalidate_subdata, =

      GL_ARB_map_buffer_alignment, GL_ARB_map_buffer_range, GL_ARB_multi_bi=
nd, =

      GL_ARB_multisample, GL_ARB_multitexture, GL_ARB_occlusion_query, =

      GL_ARB_occlusion_query2, GL_ARB_pixel_buffer_object, =

      GL_ARB_point_parameters, GL_ARB_point_sprite, =

      GL_ARB_program_interface_query, GL_ARB_provoking_vertex, =

      GL_ARB_robustness, GL_ARB_sampler_objects, GL_ARB_separate_shader_obj=
ects, =

      GL_ARB_shader_objects, GL_ARB_shading_language_100, GL_ARB_shadow, =

      GL_ARB_sync, GL_ARB_texture_barrier, GL_ARB_texture_border_clamp, =

      GL_ARB_texture_compression, GL_ARB_texture_cube_map, =

      GL_ARB_texture_env_add, GL_ARB_texture_env_combine, =

      GL_ARB_texture_env_crossbar, GL_ARB_texture_env_dot3, =

      GL_ARB_texture_mirrored_repeat, GL_ARB_texture_multisample, =

      GL_ARB_texture_non_power_of_two, GL_ARB_texture_rectangle, =

      GL_ARB_texture_storage, GL_ARB_texture_storage_multisample, =

      GL_ARB_texture_swizzle, GL_ARB_transpose_matrix, =

      GL_ARB_vertex_array_object, GL_ARB_vertex_attrib_binding, =

      GL_ARB_vertex_buffer_object, GL_ARB_vertex_program, GL_ARB_vertex_sha=
der, =

      GL_ARB_window_pos, GL_ATI_blend_equation_separate, GL_ATI_draw_buffer=
s, =

      GL_ATI_fragment_shader, GL_ATI_separate_stencil, =

      GL_ATI_texture_env_combine3, GL_EXT_abgr, GL_EXT_bgra, =

      GL_EXT_blend_color, GL_EXT_blend_equation_separate, =

      GL_EXT_blend_func_separate, GL_EXT_blend_minmax, GL_EXT_blend_subtrac=
t, =

      GL_EXT_compiled_vertex_array, GL_EXT_copy_texture, =

      GL_EXT_draw_range_elements, GL_EXT_fog_coord, GL_EXT_framebuffer_blit=
, =

      GL_EXT_framebuffer_multisample, GL_EXT_framebuffer_multisample_blit_s=
caled, =

      GL_EXT_framebuffer_object, GL_EXT_framebuffer_sRGB, =

      GL_EXT_gpu_program_parameters, GL_EXT_multi_draw_arrays, =

      GL_EXT_packed_depth_stencil, GL_EXT_packed_pixels, =

      GL_EXT_pixel_buffer_object, GL_EXT_point_parameters, =

      GL_EXT_provoking_vertex, GL_EXT_rescale_normal, GL_EXT_secondary_colo=
r, =

      GL_EXT_separate_specular_color, GL_EXT_shader_integer_mix, =

      GL_EXT_shadow_funcs, GL_EXT_stencil_two_side, GL_EXT_stencil_wrap, =

      GL_EXT_subtexture, GL_EXT_texture, GL_EXT_texture3D, =

      GL_EXT_texture_cube_map, GL_EXT_texture_edge_clamp, =

      GL_EXT_texture_env_add, GL_EXT_texture_env_combine, =

      GL_EXT_texture_env_dot3, GL_EXT_texture_lod_bias, GL_EXT_texture_obje=
ct, =

      GL_EXT_texture_rectangle, GL_EXT_texture_sRGB, GL_EXT_texture_sRGB_de=
code, =

      GL_EXT_texture_swizzle, GL_EXT_vertex_array, GL_IBM_multimode_draw_ar=
rays, =

      GL_IBM_rasterpos_clip, GL_IBM_texture_mirrored_repeat, =

      GL_INGR_blend_func_separate, GL_KHR_context_flush_control, GL_KHR_deb=
ug, =

      GL_KHR_no_error, GL_KHR_texture_compression_astc_ldr, =

      GL_KHR_texture_compression_astc_sliced_3d, GL_MESA_pack_invert, =

      GL_MESA_tile_raster_order, GL_MESA_window_pos, GL_NV_blend_square, =

      GL_NV_fog_distance, GL_NV_light_max_exponent, GL_NV_packed_depth_sten=
cil, =

      GL_NV_texgen_reflection, GL_NV_texture_barrier, =

      GL_NV_texture_env_combine4, GL_NV_texture_rectangle, GL_OES_EGL_image=
, =

      GL_OES_read_format, GL_SGIS_generate_mipmap, GL_SGIS_texture_border_c=
lamp, =

      GL_SGIS_texture_edge_clamp, GL_SGIS_texture_lod, GL_SUN_multi_draw_ar=
rays

  OpenGL ES profile version string: OpenGL ES 2.0 Mesa 19.1.0-devel (git-f1=
122f78b7)
  OpenGL ES profile shading language version string: OpenGL ES GLSL ES 1.0.=
16
  OpenGL ES profile extensions:
      GL_APPLE_texture_max_level, GL_EXT_blend_minmax, =

      GL_EXT_compressed_ETC1_RGB8_sub_texture, GL_EXT_discard_framebuffer, =

      GL_EXT_draw_buffers, GL_EXT_draw_elements_base_vertex, GL_EXT_frag_de=
pth, =

      GL_EXT_map_buffer_range, GL_EXT_multi_draw_arrays, =

      GL_EXT_occlusion_query_boolean, GL_EXT_read_format_bgra, =

      GL_EXT_separate_shader_objects, GL_EXT_texture_border_clamp, =

      GL_EXT_texture_format_BGRA8888, GL_EXT_unpack_subimage, =

      GL_KHR_context_flush_control, GL_KHR_debug, GL_KHR_no_error, =

      GL_KHR_texture_compression_astc_ldr, =

      GL_KHR_texture_compression_astc_sliced_3d, GL_MESA_tile_raster_order, =

      GL_NV_draw_buffers, GL_NV_fbo_color_attachments, GL_NV_read_buffer, =

      GL_NV_read_depth, GL_NV_read_depth_stencil, GL_NV_read_stencil, =

      GL_OES_EGL_image, GL_OES_EGL_image_external, GL_OES_EGL_sync, =

      GL_OES_compressed_ETC1_RGB8_texture, GL_OES_depth24, GL_OES_depth_tex=
ture, =

      GL_OES_draw_elements_base_vertex, GL_OES_element_index_uint, =

      GL_OES_fbo_render_mipmap, GL_OES_get_program_binary, GL_OES_mapbuffer=
, =

      GL_OES_packed_depth_stencil, GL_OES_required_internalformat, =

      GL_OES_rgb8_rgba8, GL_OES_stencil8, GL_OES_surfaceless_context, =

      GL_OES_texture_3D, GL_OES_texture_border_clamp, GL_OES_texture_npot, =

      GL_OES_vertex_array_object, GL_OES_vertex_half_float

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1821839/+subscriptions
