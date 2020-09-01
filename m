Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A60C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 06:23:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B29CF2071B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 06:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cojidpyD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B29CF2071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCzh5-0002fm-TB
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 02:22:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44404)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kCzeh-00065f-Ja
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 02:20:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44534)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kCzef-0000o0-R5
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 02:20:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598941229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pI5Jy3OYPqm2Gv6FAxa1jk28yZeAxya6itFzgt9QAso=;
 b=cojidpyDBx+TD1iudd6Oc7PSEeSy9EgUcwsfwQmczPFPLrroaFFGSHkHbpZ7wunrUVKjXF
 0WxWhLV7703k38l+lsJ5HZFbUColJo/FwzJktpFovEn32+wJpALGMhZ0zHOY6t5csTeoSD
 QjpOcy8JgQjV/VGKqsLt9RxjoMwndng=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-HHOh4Mu1PU6GAwaVRrF4sg-1; Tue, 01 Sep 2020 02:20:27 -0400
X-MC-Unique: HHOh4Mu1PU6GAwaVRrF4sg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1BC071888A1F;
 Tue,  1 Sep 2020 06:20:26 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CD29B78B46;
 Tue,  1 Sep 2020 06:20:25 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 12/13] ui: relocate paths to icons and translations
Date: Tue,  1 Sep 2020 02:20:19 -0400
Message-Id: <20200901062020.26660-13-pbonzini@redhat.com>
In-Reply-To: <20200901062020.26660-1-pbonzini@redhat.com>
References: <20200901062020.26660-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 23:17:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 ui/gtk.c  | 10 ++++++++--
 ui/sdl2.c |  9 +++++++--
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index b0cc08ad6d..597f829ad9 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -51,6 +51,7 @@
 #include <math.h>
 
 #include "trace.h"
+#include "qemu/cutils.h"
 #include "ui/input.h"
 #include "sysemu/runstate.h"
 #include "sysemu/sysemu.h"
@@ -2200,6 +2201,7 @@ static void gtk_display_init(DisplayState *ds, DisplayOptions *opts)
     GtkDisplayState *s = g_malloc0(sizeof(*s));
     GdkDisplay *window_display;
     GtkIconTheme *theme;
+    char *dir;
 
     if (!gtkinit) {
         fprintf(stderr, "gtk initialization failed\n");
@@ -2209,7 +2211,9 @@ static void gtk_display_init(DisplayState *ds, DisplayOptions *opts)
     s->opts = opts;
 
     theme = gtk_icon_theme_get_default();
-    gtk_icon_theme_prepend_search_path(theme, CONFIG_QEMU_ICONDIR);
+    dir = get_relocated_path(CONFIG_QEMU_ICONDIR);
+    gtk_icon_theme_prepend_search_path(theme, dir);
+    g_free(dir);
     g_set_prgname("qemu");
 
     s->window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
@@ -2225,7 +2229,9 @@ static void gtk_display_init(DisplayState *ds, DisplayOptions *opts)
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



