Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7C0C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 09:50:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34F802396E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 09:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z+IPDLCB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34F802396E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLNtG-00044j-82
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 05:50:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLNTt-0001Jx-85
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:24:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59297)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLNTo-00066P-Mz
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 05:24:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600939435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a0HGQw1MXerVeCfVWbsho895pJdZfvez29NetutVjys=;
 b=Z+IPDLCBvQYMd643lhXErb5Q2Iz2c3TKqCXYiEbxtDnjzqsMe6SLGILTQcROZWLy83VIpw
 SS3rTG5bTeiU+8t7EfIUzhK4clN+octYQyAvnNn/LuleGDvUW9OATQVfRqq2DB8g7Xa1FZ
 TYBZ4bENYJZ6C/1rJr10UeP/9XfLIDQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-KmrRWpcZP6SG2EJD78fEqQ-1; Thu, 24 Sep 2020 05:23:54 -0400
X-MC-Unique: KmrRWpcZP6SG2EJD78fEqQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 36CA2104D3E8
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 09:23:53 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E9FE15C22B;
 Thu, 24 Sep 2020 09:23:52 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 50/92] ui: relocate paths to icons and translations
Date: Thu, 24 Sep 2020 05:22:32 -0400
Message-Id: <20200924092314.1722645-51-pbonzini@redhat.com>
In-Reply-To: <20200924092314.1722645-1-pbonzini@redhat.com>
References: <20200924092314.1722645-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 ui/gtk.c  | 10 ++++++++--
 ui/sdl2.c |  9 +++++++--
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index 1c59de2af4..b11594d817 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -51,6 +51,7 @@
 #include <math.h>
 
 #include "trace.h"
+#include "qemu/cutils.h"
 #include "ui/input.h"
 #include "sysemu/runstate.h"
 #include "sysemu/sysemu.h"
@@ -2202,6 +2203,7 @@ static void gtk_display_init(DisplayState *ds, DisplayOptions *opts)
     GtkDisplayState *s = g_malloc0(sizeof(*s));
     GdkDisplay *window_display;
     GtkIconTheme *theme;
+    char *dir;
 
     if (!gtkinit) {
         fprintf(stderr, "gtk initialization failed\n");
@@ -2211,7 +2213,9 @@ static void gtk_display_init(DisplayState *ds, DisplayOptions *opts)
     s->opts = opts;
 
     theme = gtk_icon_theme_get_default();
-    gtk_icon_theme_prepend_search_path(theme, CONFIG_QEMU_ICONDIR);
+    dir = get_relocated_path(CONFIG_QEMU_ICONDIR);
+    gtk_icon_theme_prepend_search_path(theme, dir);
+    g_free(dir);
     g_set_prgname("qemu");
 
     s->window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
@@ -2227,7 +2231,9 @@ static void gtk_display_init(DisplayState *ds, DisplayOptions *opts)
      * sure that we don't accidentally break implicit assumptions.  */
     setlocale(LC_MESSAGES, "");
     setlocale(LC_CTYPE, "C.UTF-8");
-    bindtextdomain("qemu", CONFIG_QEMU_LOCALEDIR);
+    dir = get_relocated_path(CONFIG_QEMU_LOCALEDIR);
+    bindtextdomain("qemu", dir);
+    g_free(dir);
     bind_textdomain_codeset("qemu", "UTF-8");
     textdomain("qemu");
 
diff --git a/ui/sdl2.c b/ui/sdl2.c
index b23a8f0a8e..abad7f981e 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -25,6 +25,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/module.h"
+#include "qemu/cutils.h"
 #include "ui/console.h"
 #include "ui/input.h"
 #include "ui/sdl2.h"
@@ -795,6 +796,7 @@ static void sdl2_display_init(DisplayState *ds, DisplayOptions *o)
     int i;
     SDL_SysWMinfo info;
     SDL_Surface *icon = NULL;
+    char *dir;
 
     assert(o->type == DISPLAY_TYPE_SDL);
 
@@ -868,15 +870,18 @@ static void sdl2_display_init(DisplayState *ds, DisplayOptions *o)
     }
 
 #ifdef CONFIG_SDL_IMAGE
-    icon = IMG_Load(CONFIG_QEMU_ICONDIR "/hicolor/128x128/apps/qemu.png");
+    dir = get_relocated_path(CONFIG_QEMU_ICONDIR "/hicolor/128x128/apps/qemu.png");
+    icon = IMG_Load(dir);
 #else
     /* Load a 32x32x4 image. White pixels are transparent. */
-    icon = SDL_LoadBMP(CONFIG_QEMU_ICONDIR "/hicolor/32x32/apps/qemu.bmp");
+    dir = get_relocated_path(CONFIG_QEMU_ICONDIR "/hicolor/32x32/apps/qemu.bmp");
+    icon = SDL_LoadBMP(dir);
     if (icon) {
         uint32_t colorkey = SDL_MapRGB(icon->format, 255, 255, 255);
         SDL_SetColorKey(icon, SDL_TRUE, colorkey);
     }
 #endif
+    g_free(dir);
     if (icon) {
         SDL_SetWindowIcon(sdl2_console[0].real_window, icon);
     }
-- 
2.26.2



