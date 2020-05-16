Return-Path: <SRS0=I9ML=66=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE752C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 07:27:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81DA62074D
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 07:27:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81DA62074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZrDp-0006Wg-OZ
	for qemu-devel@archiver.kernel.org; Sat, 16 May 2020 03:27:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1jZr7m-0006gU-7c
 for qemu-devel@nongnu.org; Sat, 16 May 2020 03:20:46 -0400
Received: from mailout08.t-online.de ([194.25.134.20]:38510)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1jZr7k-0004OR-SX
 for qemu-devel@nongnu.org; Sat, 16 May 2020 03:20:45 -0400
Received: from fwd16.aul.t-online.de (fwd16.aul.t-online.de [172.20.26.243])
 by mailout08.t-online.de (Postfix) with SMTP id 4D02B41C0B4B;
 Sat, 16 May 2020 09:20:43 +0200 (CEST)
Received: from linpower.localnet
 (ZkibeoZfrhRJLRV-A3NarHt0Or7r3MoQMYMz5Lek4GH4v1pX3gaYc5EEeHTZTEsgWi@[46.86.59.135])
 by fwd16.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1jZr7h-3KJu7c0; Sat, 16 May 2020 09:20:41 +0200
Received: by linpower.localnet (Postfix, from userid 1000)
 id EEF6E2006D9; Sat, 16 May 2020 09:20:14 +0200 (CEST)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: [PATCH v2 11/11] ui: increase min required GTK version to 3.22.0
Date: Sat, 16 May 2020 09:20:14 +0200
Message-Id: <20200516072014.7766-11-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <bea1a22a-1fb4-b49b-c089-e0a5c5cf55cd@t-online.de>
References: <bea1a22a-1fb4-b49b-c089-e0a5c5cf55cd@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ID: ZkibeoZfrhRJLRV-A3NarHt0Or7r3MoQMYMz5Lek4GH4v1pX3gaYc5EEeHTZTEsgWi
X-TOI-EXPURGATEID: 150726::1589613641-00007FCB-39028EDF/0/0 CLEAN NORMAL
X-TOI-MSGID: a3e70252-ac42-4572-be14-a1e34c3baaf6
Received-SPF: none client-ip=194.25.134.20;
 envelope-from=volker.ruemelin@t-online.de; helo=mailout08.t-online.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/16 03:20:19
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Based on a mail on the qemu-devel mailing list at
https://lists.nongnu.org/archive/html/qemu-devel/2020-05/msg02909.html
and some internet research the GTK3 versions on supported
platforms are:

    RHEL-7.4: 3.22.10
    RHEL-7.5: 3.22.26
    Debian (Stretch): 3.22.11
    Debian (Buster): 3.24.5
    OpenBSD (Ports): 3.22.30
    FreeBSD (Ports): 3.22.29
    OpenSUSE Leap 15: 3.22.30
    SLE12-SP2: Unknown
    SLE15: 3.22.30
    Ubuntu (Bionic): 3.22.30
    Ubuntu (Focal): 3.24.18
    macOS (Homebrew): 3.22.30

This justifies increasing the minimum required GTK version in
QEMU to 3.22.0.

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
---
 configure |  2 +-
 ui/gtk.c  | 91 +++++--------------------------------------------------
 2 files changed, 9 insertions(+), 84 deletions(-)

diff --git a/configure b/configure
index 26084fc53a..2fc05c4465 100755
--- a/configure
+++ b/configure
@@ -2897,7 +2897,7 @@ fi
 if test "$gtk" != "no"; then
     gtkpackage="gtk+-3.0"
     gtkx11package="gtk+-x11-3.0"
-    gtkversion="3.14.0"
+    gtkversion="3.22.0"
     if $pkg_config --exists "$gtkpackage >= $gtkversion"; then
         gtk_cflags=$($pkg_config --cflags $gtkpackage)
         gtk_libs=$($pkg_config --libs $gtkpackage)
diff --git a/ui/gtk.c b/ui/gtk.c
index 68a5b901c7..d4b49bd7da 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -490,12 +490,7 @@ static void gd_refresh(DisplayChangeListener *dcl)
 
 static GdkDevice *gd_get_pointer(GdkDisplay *dpy)
 {
-#if GTK_CHECK_VERSION(3, 20, 0)
     return gdk_seat_get_pointer(gdk_display_get_default_seat(dpy));
-#else
-    return gdk_device_manager_get_client_pointer(
-        gdk_display_get_device_manager(dpy));
-#endif
 }
 
 static void gd_mouse_set(DisplayChangeListener *dcl,
@@ -877,27 +872,18 @@ static gboolean gd_motion_event(GtkWidget *widget, GdkEventMotion *motion,
 
     if (!qemu_input_is_absolute() && s->ptr_owner == vc) {
         GdkScreen *screen = gtk_widget_get_screen(vc->gfx.drawing_area);
+        GdkDisplay *dpy = gtk_widget_get_display(widget);
+        GdkWindow *win = gtk_widget_get_window(widget);
+        GdkMonitor *monitor = gdk_display_get_monitor_at_window(dpy, win);
+        GdkRectangle geometry;
         int screen_width, screen_height;
 
         int x = (int)motion->x_root;
         int y = (int)motion->y_root;
 
-#if GTK_CHECK_VERSION(3, 22, 0)
-        {
-            GdkDisplay *dpy = gtk_widget_get_display(widget);
-            GdkWindow *win = gtk_widget_get_window(widget);
-            GdkMonitor *monitor = gdk_display_get_monitor_at_window(dpy, win);
-            GdkRectangle geometry;
-            gdk_monitor_get_geometry(monitor, &geometry);
-            screen_width = geometry.width;
-            screen_height = geometry.height;
-        }
-#else
-        {
-            screen_width = gdk_screen_get_width(screen);
-            screen_height = gdk_screen_get_height(screen);
-        }
-#endif
+        gdk_monitor_get_geometry(monitor, &geometry);
+        screen_width = geometry.width;
+        screen_height = geometry.height;
 
         /* In relative mode check to see if client pointer hit
          * one of the screen edges, and if so move it back by
@@ -1026,13 +1012,8 @@ static const guint16 *gd_get_keymap(size_t *maplen)
 #ifdef GDK_WINDOWING_WIN32
     if (GDK_IS_WIN32_DISPLAY(dpy)) {
         trace_gd_keymap_windowing("win32");
-#if GTK_CHECK_VERSION(3, 22, 0)
         *maplen = qemu_input_map_atset1_to_qcode_len;
         return qemu_input_map_atset1_to_qcode;
-#else
-        *maplen = qemu_input_map_win32_to_qcode_len;
-        return qemu_input_map_win32_to_qcode;
-#endif
     }
 #endif
 
@@ -1080,7 +1061,7 @@ static int gd_map_keycode(int scancode)
 
 static int gd_get_keycode(GdkEventKey *key)
 {
-#if defined G_OS_WIN32 && GTK_CHECK_VERSION(3, 22, 0)
+#ifdef G_OS_WIN32
     int scancode = gdk_event_get_scancode((GdkEvent *)key);
 
     /* translate Windows native scancodes to atset1 keycodes */
@@ -1437,7 +1418,6 @@ static void gd_menu_zoom_fit(GtkMenuItem *item, void *opaque)
     gd_update_full_redraw(vc);
 }
 
-#if GTK_CHECK_VERSION(3, 20, 0)
 static void gd_grab_update(VirtualConsole *vc, bool kbd, bool ptr)
 {
     GdkDisplay *display = gtk_widget_get_display(vc->gfx.drawing_area);
@@ -1461,32 +1441,6 @@ static void gd_grab_update(VirtualConsole *vc, bool kbd, bool ptr)
         gdk_seat_ungrab(seat);
     }
 }
-#else
-static void gd_grab_devices(VirtualConsole *vc, bool grab,
-                            GdkInputSource source, GdkEventMask mask,
-                            GdkCursor *cursor)
-{
-    GdkDisplay *display = gtk_widget_get_display(vc->gfx.drawing_area);
-    GdkDeviceManager *mgr = gdk_display_get_device_manager(display);
-    GList *devs = gdk_device_manager_list_devices(mgr, GDK_DEVICE_TYPE_MASTER);
-    GList *tmp = devs;
-
-    for (tmp = devs; tmp; tmp = tmp->next) {
-        GdkDevice *dev = tmp->data;
-        if (gdk_device_get_source(dev) != source) {
-            continue;
-        }
-        if (grab) {
-            GdkWindow *win = gtk_widget_get_window(vc->gfx.drawing_area);
-            gdk_device_grab(dev, win, GDK_OWNERSHIP_NONE, FALSE,
-                            mask, cursor, GDK_CURRENT_TIME);
-        } else {
-            gdk_device_ungrab(dev, GDK_CURRENT_TIME);
-        }
-    }
-    g_list_free(devs);
-}
-#endif
 
 static void gd_grab_keyboard(VirtualConsole *vc, const char *reason)
 {
@@ -1499,13 +1453,7 @@ static void gd_grab_keyboard(VirtualConsole *vc, const char *reason)
     }
 
     win32_kbd_set_grab(true);
-#if GTK_CHECK_VERSION(3, 20, 0)
     gd_grab_update(vc, true, vc->s->ptr_owner == vc);
-#else
-    gd_grab_devices(vc, true, GDK_SOURCE_KEYBOARD,
-                   GDK_KEY_PRESS_MASK | GDK_KEY_RELEASE_MASK,
-                   NULL);
-#endif
     vc->s->kbd_owner = vc;
     gd_update_caption(vc->s);
     trace_gd_grab(vc->label, "kbd", reason);
@@ -1521,11 +1469,7 @@ static void gd_ungrab_keyboard(GtkDisplayState *s)
     s->kbd_owner = NULL;
 
     win32_kbd_set_grab(false);
-#if GTK_CHECK_VERSION(3, 20, 0)
     gd_grab_update(vc, false, vc->s->ptr_owner == vc);
-#else
-    gd_grab_devices(vc, false, GDK_SOURCE_KEYBOARD, 0, NULL);
-#endif
     gd_update_caption(s);
     trace_gd_ungrab(vc->label, "kbd");
 }
@@ -1542,21 +1486,9 @@ static void gd_grab_pointer(VirtualConsole *vc, const char *reason)
         }
     }
 
-#if GTK_CHECK_VERSION(3, 20, 0)
     gd_grab_update(vc, vc->s->kbd_owner == vc, true);
     gdk_device_get_position(gd_get_pointer(display),
                             NULL, &vc->s->grab_x_root, &vc->s->grab_y_root);
-#else
-    gd_grab_devices(vc, true, GDK_SOURCE_MOUSE,
-                    GDK_POINTER_MOTION_MASK |
-                    GDK_BUTTON_PRESS_MASK |
-                    GDK_BUTTON_RELEASE_MASK |
-                    GDK_BUTTON_MOTION_MASK |
-                    GDK_SCROLL_MASK,
-                    vc->s->null_cursor);
-    gdk_device_get_position(gd_get_pointer(display),
-                            NULL, &vc->s->grab_x_root, &vc->s->grab_y_root);
-#endif
     vc->s->ptr_owner = vc;
     gd_update_caption(vc->s);
     trace_gd_grab(vc->label, "ptr", reason);
@@ -1573,17 +1505,10 @@ static void gd_ungrab_pointer(GtkDisplayState *s)
     s->ptr_owner = NULL;
 
     display = gtk_widget_get_display(vc->gfx.drawing_area);
-#if GTK_CHECK_VERSION(3, 20, 0)
     gd_grab_update(vc, vc->s->kbd_owner == vc, false);
     gdk_device_warp(gd_get_pointer(display),
                     gtk_widget_get_screen(vc->gfx.drawing_area),
                     vc->s->grab_x_root, vc->s->grab_y_root);
-#else
-    gd_grab_devices(vc, false, GDK_SOURCE_MOUSE, 0, NULL);
-    gdk_device_warp(gd_get_pointer(display),
-                    gtk_widget_get_screen(vc->gfx.drawing_area),
-                    vc->s->grab_x_root, vc->s->grab_y_root);
-#endif
     gd_update_caption(s);
     trace_gd_ungrab(vc->label, "ptr");
 }
-- 
2.26.1


