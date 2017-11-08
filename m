Received: from eggs.gnu.org ([2001:4830:134:3::10]:35119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eCZNE-000146-B5
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 18:03:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eCZNB-0003qC-3y
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 18:03:08 -0500
Received: from mail-cys01nam02on0067.outbound.protection.outlook.com
	([104.47.37.67]:6176
	helo=NAM02-CY1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1eCZNA-0003po-OW
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 18:03:05 -0500
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 8 Nov 2017 14:58:59 -0800
Message-ID: <3c6c24cb01f7d4812addd84bd170337459c9e95b.1510181732.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1510181732.git.alistair.francis@xilinx.com>
References: <cover.1510181732.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 43/45] ui: Replace fprintf(stderr,
 "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, armbru@redhat.com, Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>

Replace a large number of the fprintf(stderr, "*\n" calls with
error_report(). The functions were renamed with these commands and then
compiler issues where manually fixed.

find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>
---

 ui/cocoa.m         |  6 +++---
 ui/console.c       |  2 +-
 ui/curses.c        |  2 +-
 ui/cursor.c        | 10 +++++-----
 ui/gtk.c           | 10 +++++-----
 ui/input-linux.c   |  3 ++-
 ui/keymaps.c       |  4 ++--
 ui/sdl.c           | 14 +++++++-------
 ui/sdl2.c          |  8 ++++----
 ui/sdl_zoom.c      |  3 ++-
 ui/shader.c        |  9 +++++----
 ui/spice-display.c | 10 +++++-----
 ui/vnc-enc-tight.c |  4 ++--
 ui/vnc-enc-zlib.c  |  4 ++--
 ui/vnc-enc-zrle.c  |  4 ++--
 ui/vnc.c           |  2 +-
 16 files changed, 49 insertions(+), 46 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 330ccebf90..fd3686bfd1 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -235,7 +235,7 @@ const int mac_to_qkeycode_map[] = {
 static int cocoa_keycode_to_qemu(int keycode)
 {
     if (ARRAY_SIZE(mac_to_qkeycode_map) <= keycode) {
-        fprintf(stderr, "(cocoa) warning unknown keycode 0x%x\n", keycode);
+        error_report("(cocoa) warning unknown keycode 0x%x", keycode);
         return 0;
     }
     return mac_to_qkeycode_map[keycode];
@@ -945,7 +945,7 @@ QemuCocoaView *cocoaView;
         // create a view and add it to the window
         cocoaView = [[QemuCocoaView alloc] initWithFrame:NSMakeRect(0.0, 0.0, 640.0, 480.0)];
         if(!cocoaView) {
-            fprintf(stderr, "(cocoa) can't create a view\n");
+            error_report("(cocoa) can't create a view");
             exit(1);
         }
 
@@ -954,7 +954,7 @@ QemuCocoaView *cocoaView;
             styleMask:NSWindowStyleMaskTitled|NSWindowStyleMaskMiniaturizable|NSWindowStyleMaskClosable
             backing:NSBackingStoreBuffered defer:NO];
         if(!normalWindow) {
-            fprintf(stderr, "(cocoa) can't create window\n");
+            error_report("(cocoa) can't create window");
             exit(1);
         }
         [normalWindow setAcceptsMouseMovedEvents:YES];
diff --git a/ui/console.c b/ui/console.c
index eca854cbd5..b58336c7b2 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1422,7 +1422,7 @@ void register_displaychangelistener(DisplayChangeListener *dcl)
         /* display has opengl support */
         assert(dcl->con);
         if (dcl->con->gl) {
-            fprintf(stderr, "can't register two opengl displays (%s, %s)\n",
+            error_report("can't register two opengl displays (%s, %s)",
                     dcl->ops->dpy_name, dcl->con->gl->ops->dpy_name);
             exit(1);
         }
diff --git a/ui/curses.c b/ui/curses.c
index 85503876c0..11c862520f 100644
--- a/ui/curses.c
+++ b/ui/curses.c
@@ -438,7 +438,7 @@ void curses_display_init(DisplayState *ds, int full_screen)
 {
 #ifndef _WIN32
     if (!isatty(1)) {
-        fprintf(stderr, "We need a terminal output\n");
+        error_report("We need a terminal output");
         exit(1);
     }
 #endif
diff --git a/ui/cursor.c b/ui/cursor.c
index f3da0cee79..9d847031ec 100644
--- a/ui/cursor.c
+++ b/ui/cursor.c
@@ -18,12 +18,12 @@ static QEMUCursor *cursor_parse_xpm(const char *xpm[])
     /* parse header line: width, height, #colors, #chars */
     if (sscanf(xpm[line], "%u %u %u %u",
                &width, &height, &colors, &chars) != 4) {
-        fprintf(stderr, "%s: header parse error: \"%s\"\n",
-                __func__, xpm[line]);
+        error_report("%s: header parse error: \"%s\"",
+                     __func__, xpm[line]);
         return NULL;
     }
     if (chars != 1) {
-        fprintf(stderr, "%s: chars != 1 not supported\n", __func__);
+        error_report("%s: chars != 1 not supported", __func__);
         return NULL;
     }
     line++;
@@ -40,7 +40,7 @@ static QEMUCursor *cursor_parse_xpm(const char *xpm[])
                 continue;
             }
         }
-        fprintf(stderr, "%s: color parse error: \"%s\"\n",
+        error_report("%s: color parse error: \"%s\"",
                 __func__, xpm[line]);
         return NULL;
     }
@@ -75,7 +75,7 @@ void cursor_print_ascii_art(QEMUCursor *c, const char *prefix)
                 fprintf(stderr, "o"); /* other */
             }
         }
-        fprintf(stderr, "|\n");
+        error_report("|");
     }
 }
 
diff --git a/ui/gtk.c b/ui/gtk.c
index 342e96fbe9..91b269d9d0 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1254,7 +1254,7 @@ static gboolean gd_win_grab(void *opaque)
 {
     VirtualConsole *vc = opaque;
 
-    fprintf(stderr, "%s: %s\n", __func__, vc->label);
+    error_report("%s: %s", __func__, vc->label);
     if (vc->s->ptr_owner) {
         gd_ungrab_pointer(vc->s);
     } else {
@@ -2215,12 +2215,12 @@ static void gd_set_keycode_type(GtkDisplayState *s)
             keycodes = XGetAtomName(x11_display, desc->names->keycodes);
         }
         if (keycodes == NULL) {
-            fprintf(stderr, "could not lookup keycode name\n");
+            error_report("could not lookup keycode name");
         } else if (strstart(keycodes, "evdev", NULL)) {
             s->has_evdev = true;
         } else if (!strstart(keycodes, "xfree86", NULL)) {
-            fprintf(stderr, "unknown keycodes `%s', please report to "
-                    "qemu-devel@nongnu.org\n", keycodes);
+            error_report("unknown keycodes `%s', please report to "
+                    "qemu-devel@nongnu.org", keycodes);
         }
 
         if (desc) {
@@ -2244,7 +2244,7 @@ void gtk_display_init(DisplayState *ds, bool full_screen, bool grab_on_hover)
     GdkDisplay *window_display;
 
     if (!gtkinit) {
-        fprintf(stderr, "gtk initialization failed\n");
+        error_report("gtk initialization failed");
         exit(1);
     }
 
diff --git a/ui/input-linux.c b/ui/input-linux.c
index 9720333b2c..edc5273476 100644
--- a/ui/input-linux.c
+++ b/ui/input-linux.c
@@ -5,6 +5,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "qemu/config-file.h"
@@ -241,7 +242,7 @@ static void input_linux_event(void *opaque)
         rc = read(il->fd, &p[il->read_offset], read_size);
         if (rc != read_size) {
             if (rc < 0 && errno != EAGAIN) {
-                fprintf(stderr, "%s: read: %s\n", __func__, strerror(errno));
+                error_report("%s: read: %s", __func__, strerror(errno));
                 qemu_set_fd_handler(il->fd, NULL, NULL, NULL);
                 close(il->fd);
             } else if (rc > 0) {
diff --git a/ui/keymaps.c b/ui/keymaps.c
index f9762d1497..41c5e42553 100644
--- a/ui/keymaps.c
+++ b/ui/keymaps.c
@@ -105,7 +105,7 @@ static kbd_layout_t *parse_keyboard_layout(const name2keysym_t *table,
     f = filename ? fopen(filename, "r") : NULL;
     g_free(filename);
     if (!f) {
-        fprintf(stderr, "Could not read keymap file: '%s'\n", language);
+        error_report("Could not read keymap file: '%s'", language);
         return NULL;
     }
 
@@ -150,7 +150,7 @@ static kbd_layout_t *parse_keyboard_layout(const name2keysym_t *table,
                     if (strstr(rest, "numlock")) {
                         add_to_key_range(&k->keypad_range, keycode);
                         add_to_key_range(&k->numlock_range, keysym);
-                        /* fprintf(stderr, "keypad keysym %04x keycode %d\n",
+                        /* error_report("keypad keysym %04x keycode %d",
                                    keysym, keycode); */
                     }
 
diff --git a/ui/sdl.c b/ui/sdl.c
index 7b71a9ac58..29db4c68ad 100644
--- a/ui/sdl.c
+++ b/ui/sdl.c
@@ -91,7 +91,7 @@ static void sdl_update(DisplayChangeListener *dcl,
             SDL_BlitSurface(guest_screen, &rec, real_screen, &rec);
         } else {
             if (sdl_zoom_blit(guest_screen, real_screen, SMOOTHING_ON, &rec) < 0) {
-                fprintf(stderr, "Zoom blit failed\n");
+                error_report("Zoom blit failed");
                 exit(1);
             }
         }
@@ -120,7 +120,7 @@ static void do_sdl_resize(int width, int height, int bpp)
     tmp_screen = SDL_SetVideoMode(width, height, bpp, flags);
     if (!real_screen) {
         if (!tmp_screen) {
-            fprintf(stderr, "Could not open SDL display (%dx%dx%d): %s\n",
+            error_report("Could not open SDL display (%dx%dx%d): %s",
                     width, height, bpp, SDL_GetError());
             exit(1);
         }
@@ -130,7 +130,7 @@ static void do_sdl_resize(int width, int height, int bpp)
          * resolution failed.
          */
         if (!tmp_screen) {
-            fprintf(stderr, "Failed to set SDL display (%dx%dx%d): %s\n",
+            error_report("Failed to set SDL display (%dx%dx%d): %s",
                     width, height, bpp, SDL_GetError());
             return;
         }
@@ -241,12 +241,12 @@ static int check_for_evdev(void)
                      XkbKeycodesNameMask, desc) == Success)) {
         keycodes = XGetAtomName(info.info.x11.display, desc->names->keycodes);
         if (keycodes == NULL) {
-            fprintf(stderr, "could not lookup keycode name\n");
+            error_report("could not lookup keycode name");
         } else if (strstart(keycodes, "evdev", NULL)) {
             has_evdev = 1;
         } else if (!strstart(keycodes, "xfree86", NULL)) {
-            fprintf(stderr, "unknown keycodes `%s', please report to "
-                    "qemu-devel@nongnu.org\n", keycodes);
+            error_report("unknown keycodes `%s', please report to "
+                    "qemu-devel@nongnu.org", keycodes);
         }
     }
 
@@ -988,7 +988,7 @@ void sdl_display_init(DisplayState *ds, int full_screen, int no_frame)
 
     flags = SDL_INIT_VIDEO | SDL_INIT_NOPARACHUTE;
     if (SDL_Init (flags)) {
-        fprintf(stderr, "Could not initialize SDL(%s) - exiting\n",
+        error_report("Could not initialize SDL(%s) - exiting",
                 SDL_GetError());
         exit(1);
     }
diff --git a/ui/sdl2.c b/ui/sdl2.c
index 53dd447fd2..f6700e70f5 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -400,7 +400,7 @@ static void handle_keydown(SDL_Event *ev)
                             160);
                 height = (surface_height(scon->surface) * width) /
                     surface_width(scon->surface);
-                fprintf(stderr, "%s: scale to %dx%d\n",
+                error_report("%s: scale to %dx%d",
                         __func__, width, height);
                 sdl_scale(scon, width, height);
                 sdl2_redraw(scon);
@@ -686,13 +686,13 @@ static void sdl_mouse_define(DisplayChangeListener *dcl,
                                  0xff0000, 0x00ff00, 0xff, 0xff000000);
 
     if (!guest_sprite_surface) {
-        fprintf(stderr, "Failed to make rgb surface from %p\n", c);
+        error_report("Failed to make rgb surface from %p", c);
         return;
     }
     guest_sprite = SDL_CreateColorCursor(guest_sprite_surface,
                                          c->hot_x, c->hot_y);
     if (!guest_sprite) {
-        fprintf(stderr, "Failed to make color cursor from %p\n", c);
+        error_report("Failed to make color cursor from %p", c);
         return;
     }
     if (guest_cursor &&
@@ -783,7 +783,7 @@ void sdl_display_init(DisplayState *ds, int full_screen, int no_frame)
 
     flags = SDL_INIT_VIDEO | SDL_INIT_NOPARACHUTE;
     if (SDL_Init(flags)) {
-        fprintf(stderr, "Could not initialize SDL(%s) - exiting\n",
+        error_report("Could not initialize SDL(%s) - exiting",
                 SDL_GetError());
         exit(1);
     }
diff --git a/ui/sdl_zoom.c b/ui/sdl_zoom.c
index b96196bac5..bf73d1f1f9 100644
--- a/ui/sdl_zoom.c
+++ b/ui/sdl_zoom.c
@@ -12,6 +12,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "sdl_zoom.h"
 
 static void sdl_zoom_rgb16(SDL_Surface *src, SDL_Surface *dst, int smooth,
@@ -81,7 +82,7 @@ int sdl_zoom_blit(SDL_Surface *src_sfc, SDL_Surface *dst_sfc, int smooth,
     else if (src_sfc->format->BitsPerPixel == 16)
         sdl_zoom_rgb16(src_sfc, dst_sfc, smooth, &zoom);
     else {
-        fprintf(stderr, "pixel format not supported\n");
+        error_report("pixel format not supported");
         return -1;
     }
 
diff --git a/ui/shader.c b/ui/shader.c
index 008458bf94..54afd3fbb6 100644
--- a/ui/shader.c
+++ b/ui/shader.c
@@ -25,6 +25,7 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qemu-common.h"
 #include "ui/shader.h"
 
@@ -96,9 +97,9 @@ static GLuint qemu_gl_create_compile_shader(GLenum type, const GLchar *src)
         glGetShaderiv(shader, GL_INFO_LOG_LENGTH, &length);
         errmsg = g_malloc(length);
         glGetShaderInfoLog(shader, length, &length, errmsg);
-        fprintf(stderr, "%s: compile %s error\n%s\n", __func__,
-                (type == GL_VERTEX_SHADER) ? "vertex" : "fragment",
-                errmsg);
+        error_report("%s: compile %s error: %s", __func__,
+                     (type == GL_VERTEX_SHADER) ? "vertex" : "fragment",
+                     errmsg);
         g_free(errmsg);
         return 0;
     }
@@ -121,7 +122,7 @@ static GLuint qemu_gl_create_link_program(GLuint vert, GLuint frag)
         glGetProgramiv(program, GL_INFO_LOG_LENGTH, &length);
         errmsg = g_malloc(length);
         glGetProgramInfoLog(program, length, &length, errmsg);
-        fprintf(stderr, "%s: link program: %s\n", __func__, errmsg);
+        error_report("%s: link program: %s", __func__, errmsg);
         g_free(errmsg);
         return 0;
     }
diff --git a/ui/spice-display.c b/ui/spice-display.c
index 586f058f1b..bb6a1af68e 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -630,13 +630,13 @@ static int interface_req_cursor_notification(QXLInstance *sin)
 
 static void interface_notify_update(QXLInstance *sin, uint32_t update_id)
 {
-    fprintf(stderr, "%s: abort()\n", __func__);
+    error_report("%s: abort()", __func__);
     abort();
 }
 
 static int interface_flush_resources(QXLInstance *sin)
 {
-    fprintf(stderr, "%s: abort()\n", __func__);
+    error_report("%s: abort()", __func__);
     abort();
     return 0;
 }
@@ -646,7 +646,7 @@ static void interface_update_area_complete(QXLInstance *sin,
         QXLRect *dirty, uint32_t num_updated_rects)
 {
     /* should never be called, used in qxl native mode only */
-    fprintf(stderr, "%s: abort()\n", __func__);
+    error_report("%s: abort()", __func__);
     abort();
 }
 
@@ -671,7 +671,7 @@ static void interface_async_complete(QXLInstance *sin, uint64_t cookie_token)
 #endif
     default:
         /* should never be called, used in qxl native mode only */
-        fprintf(stderr, "%s: abort()\n", __func__);
+        error_report("%s: abort()", __func__);
         abort();
     }
     g_free(cookie);
@@ -955,7 +955,7 @@ static void qemu_spice_gl_scanout_texture(DisplayChangeListener *dcl,
     assert(tex_id);
     fd = egl_get_fd_for_texture(tex_id, &stride, &fourcc);
     if (fd < 0) {
-        fprintf(stderr, "%s: failed to get fd for texture\n", __func__);
+        error_report("%s: failed to get fd for texture", __func__);
         return;
     }
     dprint(1, "%s: %dx%d (stride %d, fourcc 0x%x)\n", __func__,
diff --git a/ui/vnc-enc-tight.c b/ui/vnc-enc-tight.c
index f38aceb4da..7ac957057d 100644
--- a/ui/vnc-enc-tight.c
+++ b/ui/vnc-enc-tight.c
@@ -800,7 +800,7 @@ static int tight_init_stream(VncState *vs, int stream_id,
                            MAX_MEM_LEVEL, strategy);
 
         if (err != Z_OK) {
-            fprintf(stderr, "VNC: error initializing zlib\n");
+            error_report("VNC: error initializing zlib");
             return -1;
         }
 
@@ -865,7 +865,7 @@ static int tight_compress_data(VncState *vs, int stream_id, size_t bytes,
 
     /* start encoding */
     if (deflate(zstream, Z_SYNC_FLUSH) != Z_OK) {
-        fprintf(stderr, "VNC: error during tight compression\n");
+        error_report("VNC: error during tight compression");
         return -1;
     }
 
diff --git a/ui/vnc-enc-zlib.c b/ui/vnc-enc-zlib.c
index 33e9df2f6a..437cfb1307 100644
--- a/ui/vnc-enc-zlib.c
+++ b/ui/vnc-enc-zlib.c
@@ -80,7 +80,7 @@ static int vnc_zlib_stop(VncState *vs)
                            MAX_MEM_LEVEL, Z_DEFAULT_STRATEGY);
 
         if (err != Z_OK) {
-            fprintf(stderr, "VNC: error initializing zlib\n");
+            error_report("VNC: error initializing zlib");
             return -1;
         }
 
@@ -109,7 +109,7 @@ static int vnc_zlib_stop(VncState *vs)
 
     // start encoding
     if (deflate(zstream, Z_SYNC_FLUSH) != Z_OK) {
-        fprintf(stderr, "VNC: error during zlib compression\n");
+        error_report("VNC: error during zlib compression");
         return -1;
     }
 
diff --git a/ui/vnc-enc-zrle.c b/ui/vnc-enc-zrle.c
index fd63d4f688..a3af8a1c5d 100644
--- a/ui/vnc-enc-zrle.c
+++ b/ui/vnc-enc-zrle.c
@@ -85,7 +85,7 @@ static int zrle_compress_data(VncState *vs, int level)
                            MAX_MEM_LEVEL, Z_DEFAULT_STRATEGY);
 
         if (err != Z_OK) {
-            fprintf(stderr, "VNC: error initializing zlib\n");
+            error_report("VNC: error initializing zlib");
             return -1;
         }
 
@@ -104,7 +104,7 @@ static int zrle_compress_data(VncState *vs, int level)
 
     /* start encoding */
     if (deflate(zstream, Z_SYNC_FLUSH) != Z_OK) {
-        fprintf(stderr, "VNC: error during zrle compression\n");
+        error_report("VNC: error during zrle compression");
         return -1;
     }
 
diff --git a/ui/vnc.c b/ui/vnc.c
index 9f8d5a1b1f..05fd3922a5 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -71,7 +71,7 @@ static void vnc_set_share_mode(VncState *vs, VncShareMode mode)
         [VNC_SHARE_MODE_EXCLUSIVE]    = "exclusive",
         [VNC_SHARE_MODE_DISCONNECTED] = "disconnected",
     };
-    fprintf(stderr, "%s/%p: %s -> %s\n", __func__,
+    error_report("%s/%p: %s -> %s", __func__,
             vs->ioc, mn[vs->share_mode], mn[mode]);
 #endif
 
-- 
2.14.1
