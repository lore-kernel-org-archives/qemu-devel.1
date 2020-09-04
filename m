Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDD9C28E83
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 07:02:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CED5B206D4
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 07:02:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CED5B206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kE5k3-0003Hu-Tl
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 03:02:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58540)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kE5iu-00024k-Gg
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 03:01:24 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47154
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kE5is-0002Jn-2z
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 03:01:23 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-ffWXZQ-ONy2CTbyOZ3RI5w-1; Fri, 04 Sep 2020 03:01:18 -0400
X-MC-Unique: ffWXZQ-ONy2CTbyOZ3RI5w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 40D7E802B48;
 Fri,  4 Sep 2020 07:01:17 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-62.ams2.redhat.com
 [10.36.112.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EA1A51A914;
 Fri,  4 Sep 2020 07:01:13 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 20F3A31E63; Fri,  4 Sep 2020 09:01:13 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 4/4] ui/gtk: Update refresh interval after widget is realized
Date: Fri,  4 Sep 2020 09:01:12 +0200
Message-Id: <20200904070112.7315-5-kraxel@redhat.com>
In-Reply-To: <20200904070112.7315-1-kraxel@redhat.com>
References: <20200904070112.7315-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 01:57:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Nikola Pavlica <pavlica.nikola@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Nikola reported on Windows when gd_vc_gfx_init() is called, the
window is not yet realized, so we run gd_refresh_rate_millihz(NULL)
which returns 0 milli-Hertz.
When a Widget is realized, it fires a 'realized' event. We already
have the gd_draw_event() handler registered for this even, so simply
move the gd_refresh_rate_millihz() there. When the event fires, the
window is known to exist.
This completes commit c4c00922cc original intention.

Reported-by: Nikola Pavlica <pavlica.nikola@gmail.com>
Tested-by: Nikola Pavlica <pavlica.nikola@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20200817172331.598255-1-philmd@redhat.com
Suggested-by: Nikola Pavlica <pavlica.nikola@gmail.com>
Tested-by: Nikola Pavlica <pavlica.nikola@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/gtk.c | 52 ++++++++++++++++++++++++++--------------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index b0cc08ad6da7..7a717ce8e5e4 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -744,6 +744,25 @@ static void gd_resize_event(GtkGLArea *area,
 
 #endif
 
+/*
+ * If available, return the refresh rate of the display in milli-Hertz,
+ * else return 0.
+ */
+static int gd_refresh_rate_millihz(GtkWidget *window)
+{
+#ifdef GDK_VERSION_3_22
+    GdkWindow *win = gtk_widget_get_window(window);
+
+    if (win) {
+        GdkDisplay *dpy = gtk_widget_get_display(window);
+        GdkMonitor *monitor = gdk_display_get_monitor_at_window(dpy, win);
+
+        return gdk_monitor_get_refresh_rate(monitor);
+    }
+#endif
+    return 0;
+}
+
 static gboolean gd_draw_event(GtkWidget *widget, cairo_t *cr, void *opaque)
 {
     VirtualConsole *vc = opaque;
@@ -751,6 +770,7 @@ static gboolean gd_draw_event(GtkWidget *widget, cairo_t *cr, void *opaque)
     int mx, my;
     int ww, wh;
     int fbw, fbh;
+    int refresh_rate_millihz;
 
 #if defined(CONFIG_OPENGL)
     if (vc->gfx.gls) {
@@ -771,6 +791,12 @@ static gboolean gd_draw_event(GtkWidget *widget, cairo_t *cr, void *opaque)
         return FALSE;
     }
 
+    refresh_rate_millihz = gd_refresh_rate_millihz(vc->window ?
+                                                   vc->window : s->window);
+    if (refresh_rate_millihz) {
+        vc->gfx.dcl.update_interval = MILLISEC_PER_SEC / refresh_rate_millihz;
+    }
+
     fbw = surface_width(vc->gfx.ds);
     fbh = surface_height(vc->gfx.ds);
 
@@ -1949,31 +1975,11 @@ static GtkWidget *gd_create_menu_machine(GtkDisplayState *s)
     return machine_menu;
 }
 
-/*
- * If available, return the refresh rate of the display in milli-Hertz,
- * else return 0.
- */
-static int gd_refresh_rate_millihz(GtkWidget *window)
-{
-#ifdef GDK_VERSION_3_22
-    GdkWindow *win = gtk_widget_get_window(window);
-
-    if (win) {
-        GdkDisplay *dpy = gtk_widget_get_display(window);
-        GdkMonitor *monitor = gdk_display_get_monitor_at_window(dpy, win);
-
-        return gdk_monitor_get_refresh_rate(monitor);
-    }
-#endif
-    return 0;
-}
-
 static GSList *gd_vc_gfx_init(GtkDisplayState *s, VirtualConsole *vc,
                               QemuConsole *con, int idx,
                               GSList *group, GtkWidget *view_menu)
 {
     bool zoom_to_fit = false;
-    int refresh_rate_millihz;
 
     vc->label = qemu_console_get_label(con);
     vc->s = s;
@@ -2031,12 +2037,6 @@ static GSList *gd_vc_gfx_init(GtkDisplayState *s, VirtualConsole *vc,
     vc->gfx.kbd = qkbd_state_init(con);
     vc->gfx.dcl.con = con;
 
-    refresh_rate_millihz = gd_refresh_rate_millihz(vc->window ?
-                                                   vc->window : s->window);
-    if (refresh_rate_millihz) {
-        vc->gfx.dcl.update_interval = MILLISEC_PER_SEC / refresh_rate_millihz;
-    }
-
     register_displaychangelistener(&vc->gfx.dcl);
 
     gd_connect_vc_gfx_signals(vc);
-- 
2.27.0


