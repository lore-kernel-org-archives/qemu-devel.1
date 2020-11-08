Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B824BC388F9
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 16:44:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11A46206ED
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 16:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0pnyYi1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11A46206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbnnx-0004GQ-5D
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 11:44:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46628)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arvidjaar@gmail.com>)
 id 1kbnmy-0003Yt-Eo
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 11:43:36 -0500
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:46127)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <arvidjaar@gmail.com>)
 id 1kbnmv-0002pi-SH
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 11:43:36 -0500
Received: by mail-lf1-x141.google.com with SMTP id v144so8699985lfa.13
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2020 08:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lunJTUDxyOqv2RmEc8bcSbkffeYosx7V6chJrHps/8Q=;
 b=e0pnyYi1+HiViO7g3mr5KbTq6rWUja3dF2CMfrEypLQPZdJH145GwsToo6BIgG6vL2
 X0ugVmkHMp+7j7aH6ApbI9y6IPbpgUR67KsIe6k3iZCFWGylM3GRnA+XNgKUMNhJE7O7
 xLOHcPHxc/rrdmiQOWUwIOgPkQONn63YSrvJl5ghLmoNiBb3iEGWQvKSvYYAwAX2FY00
 BW0Htn9s26HSvX97pDM96tVy1xKWAg8UrryyShkk2VFmWlJJMYWcAgcejXjF0OwalYJJ
 BwqsoDagoEQuwL6TNWRDvejkzzNjB69+bSh5zjm8Np+85tIiIF+tJCNlXmgB84gwQ/jT
 stzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lunJTUDxyOqv2RmEc8bcSbkffeYosx7V6chJrHps/8Q=;
 b=blB78rMkxtZ2IYcuhT7W3SS2H0hz69Gb7r9S1eHpoSOdwJwQVaYkflJ26G8CJEtwt/
 3Z0KyUMMjXFQe+7mAl8m5TV74GXiSfjwnsgRC5lDNhLXSut407QmH8eE1v15Wrq1Z6n7
 6ghtLfmftsmZfXtFAwqEOaj8USdaZA/Zf0VSvHH6znrvhY63kYfdVGw+03DlXWkUGPHy
 iJBNd/CRmnfzH0G0Uv0kv2W727QU+jlaPHFNq/0Wuqhsw2IPaEolk5VEB4sPSXh23/bE
 Rl8digB4aRboB9nBf8qSnrjRMPNOumXUI2tffGyZi1nkcBlq7kZUPvyWglMbdoG9vbd0
 h+8A==
X-Gm-Message-State: AOAM530k4NuqM1yIFV5/1Pmze9eGvkYHVrYrII09NrJWh69zgkzHWcVO
 R8fluQx+LXDVtNVVtfrTaxY5QzCs3SY=
X-Google-Smtp-Source: ABdhPJxD0tRZ6OEtfqimkUmZM3fXV6gfLSljdOV9XWyrEhqFR1SqKnnaDkukJPRzF1g502iBItjt0Q==
X-Received: by 2002:a19:ad49:: with SMTP id s9mr4068472lfd.173.1604853811151; 
 Sun, 08 Nov 2020 08:43:31 -0800 (PST)
Received: from localhost.localdomain ([2a00:1370:812d:1e11:3065:63b:7259:386])
 by smtp.gmail.com with ESMTPSA id
 8sm722327lfk.246.2020.11.08.08.43.30 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2020 08:43:30 -0800 (PST)
From: Andrei Borzenkov <arvidjaar@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] ui/gtk: Fix guest absolute pointer position under Wayland
Date: Sun,  8 Nov 2020 19:43:29 +0300
Message-Id: <20201108164329.249482-1-arvidjaar@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::141;
 envelope-from=arvidjaar@gmail.com; helo=mail-lf1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ubuntu 20.04, GNOME Wayland desktop, QEMU 5.1.0 compiled from sources.

Absolute tablet/vmmouse location in guest window does not match
cursor - coordinates reported to guest are smaller than visible
mouse cursor location.

Adding debug print to ui/gtk.c:gd_motion_event() to print surface
and window szies and mouse coordinates and running guest with 1280x960
size I see the following.

Under X11

fbw = 1280, fbh = 960, ww = 1280, wh = 960, x = 1278.000000, y = 38.000000
fbw = 1280, fbh = 960, ww = 1280, wh = 960, x = 1276.000000, y = 38.000000

Guest surface size is the same as containing window, mouse coordinates
are reported relative to guest surface. It matches X11 window hierarchy:

    0x606f8f (has no name): ()  1300x1040+145+50  +145+50
        1 child:
        0x2e00009 "QEMU (Tumbleweed)": ("qemu" "Qemu-system-x86_64")  1280x985+10+45  +155+95
           2 children:
           0x2e00019 (has no name): ()  1280x960+0+25  +155+120
           0x2e0000a (has no name): ()  1x1+-1+-1  +154+94

So guest surface has matching window with 1280x960 size.

Under Wayland

[430579.942] wl_pointer@11.motion(183842180, 1314.042969, 90.894531)
...
[430680.056] wl_pointer@11.motion(183842288, 1306.355469, 91.171875)
[430697.031] wl_pointer@11.motion(183842300, 1305.722656, 91.171875)

[430735.908] wl_pointer@11.motion(183842347, 1304.832031, 91.171875)
fbw = 1280, fbh = 960, ww = 1332, wh = 1074, x = 1278.832031, y = 6.171875
[430783.750] wl_pointer@11.motion(183842395, 1304.500000, 91.171875)
fbw = 1280, fbh = 960, ww = 1332, wh = 1074, x = 1278.500000, y = 6.171875
[430863.804] wl_pointer@11.motion(183842467, 1303.492188, 91.527344)
fbw = 1280, fbh = 960, ww = 1332, wh = 1074, x = 1277.492188, y = 6.527344

While mouse coordinates are still reported relative to guest surface,
it seems that there is single (GDK) top level window with size 1332x1074
and all other widgets belong to this window. Mouse events are registered
as soon as pointer enters this top level window but are reported to application
only when they enter guest window surface. Because QEMU believes UI window
was resized, it attempts to adjust mouse position before reporting it
to guest.

This does not contradict GTK manual which does not require that every widget
has own window:

Note that all realized widgets have a non-NULL “window” pointer (gtk_widget_get_window()
never returns a NULL window when a widget is realized), but for many of them it’s actually
the GdkWindow of one of its parent widgets.

This patch replaces gdk_window_get_width/height(gtk_widget_get_window()) with
gtk_widget_get_allocated_width/height(). I tested it both under Wayland and X11
and it fixed mouse issue and did not introduce regressions for me.
I tested also UI resizing with fixed guest size and full screen which also
worked.

Signed-off-by: Andrei Borzenkov <arvidjaar@gmail.com>
---
 ui/gtk-egl.c | 12 ++++--------
 ui/gtk.c     | 21 ++++++++-------------
 2 files changed, 12 insertions(+), 21 deletions(-)

diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index 99231a3597..ce25db6d8e 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -61,16 +61,14 @@ void gd_egl_init(VirtualConsole *vc)
 
 void gd_egl_draw(VirtualConsole *vc)
 {
-    GdkWindow *window;
     int ww, wh;
 
     if (!vc->gfx.gls) {
         return;
     }
 
-    window = gtk_widget_get_window(vc->gfx.drawing_area);
-    ww = gdk_window_get_width(window);
-    wh = gdk_window_get_height(window);
+    ww = gtk_widget_get_allocated_width(vc->gfx.drawing_area);
+    wh = gtk_widget_get_allocated_height(vc->gfx.drawing_area);
 
     if (vc->gfx.scanout_mode) {
         gd_egl_scanout_flush(&vc->gfx.dcl, 0, 0, vc->gfx.w, vc->gfx.h);
@@ -255,7 +253,6 @@ void gd_egl_scanout_flush(DisplayChangeListener *dcl,
                           uint32_t x, uint32_t y, uint32_t w, uint32_t h)
 {
     VirtualConsole *vc = container_of(dcl, VirtualConsole, gfx.dcl);
-    GdkWindow *window;
     int ww, wh;
 
     if (!vc->gfx.scanout_mode) {
@@ -268,9 +265,8 @@ void gd_egl_scanout_flush(DisplayChangeListener *dcl,
     eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
                    vc->gfx.esurface, vc->gfx.ectx);
 
-    window = gtk_widget_get_window(vc->gfx.drawing_area);
-    ww = gdk_window_get_width(window);
-    wh = gdk_window_get_height(window);
+    ww = gtk_widget_get_allocated_width(vc->gfx.drawing_area);
+    wh = gtk_widget_get_allocated_height(vc->gfx.drawing_area);
     egl_fb_setup_default(&vc->gfx.win_fb, ww, wh);
     if (vc->gfx.cursor_fb.texture) {
         egl_texture_blit(vc->gfx.gls, &vc->gfx.win_fb, &vc->gfx.guest_fb,
diff --git a/ui/gtk.c b/ui/gtk.c
index b11594d817..f1aef1ff2d 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -393,8 +393,8 @@ static void gd_update_full_redraw(VirtualConsole *vc)
 {
     GtkWidget *area = vc->gfx.drawing_area;
     int ww, wh;
-    ww = gdk_window_get_width(gtk_widget_get_window(area));
-    wh = gdk_window_get_height(gtk_widget_get_window(area));
+    ww = gtk_widget_get_allocated_width(area);
+    wh = gtk_widget_get_allocated_height(area);
 #if defined(CONFIG_GTK_GL)
     if (vc->gfx.gls && gtk_use_gl_area) {
         gtk_gl_area_queue_render(GTK_GL_AREA(vc->gfx.drawing_area));
@@ -440,7 +440,6 @@ static void gd_update(DisplayChangeListener *dcl,
                       int x, int y, int w, int h)
 {
     VirtualConsole *vc = container_of(dcl, VirtualConsole, gfx.dcl);
-    GdkWindow *win;
     int x1, x2, y1, y2;
     int mx, my;
     int fbw, fbh;
@@ -467,12 +466,8 @@ static void gd_update(DisplayChangeListener *dcl,
     fbw = surface_width(vc->gfx.ds) * vc->gfx.scale_x;
     fbh = surface_height(vc->gfx.ds) * vc->gfx.scale_y;
 
-    win = gtk_widget_get_window(vc->gfx.drawing_area);
-    if (!win) {
-        return;
-    }
-    ww = gdk_window_get_width(win);
-    wh = gdk_window_get_height(win);
+    ww = gtk_widget_get_allocated_width(vc->gfx.drawing_area);
+    wh = gtk_widget_get_allocated_height(vc->gfx.drawing_area);
 
     mx = my = 0;
     if (ww > fbw) {
@@ -803,8 +798,8 @@ static gboolean gd_draw_event(GtkWidget *widget, cairo_t *cr, void *opaque)
     fbw = surface_width(vc->gfx.ds);
     fbh = surface_height(vc->gfx.ds);
 
-    ww = gdk_window_get_width(gtk_widget_get_window(widget));
-    wh = gdk_window_get_height(gtk_widget_get_window(widget));
+    ww = gtk_widget_get_allocated_width(widget);
+    wh = gtk_widget_get_allocated_height(widget);
 
     if (s->full_screen) {
         vc->gfx.scale_x = (double)ww / fbw;
@@ -865,8 +860,8 @@ static gboolean gd_motion_event(GtkWidget *widget, GdkEventMotion *motion,
     fbw = surface_width(vc->gfx.ds) * vc->gfx.scale_x;
     fbh = surface_height(vc->gfx.ds) * vc->gfx.scale_y;
 
-    ww = gdk_window_get_width(gtk_widget_get_window(vc->gfx.drawing_area));
-    wh = gdk_window_get_height(gtk_widget_get_window(vc->gfx.drawing_area));
+    ww = gtk_widget_get_allocated_width(vc->gfx.drawing_area);
+    wh = gtk_widget_get_allocated_height(vc->gfx.drawing_area);
 
     mx = my = 0;
     if (ww > fbw) {
-- 
2.25.1


