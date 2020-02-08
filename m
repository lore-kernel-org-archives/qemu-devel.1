Return-Path: <SRS0=Z2zD=34=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8444EC35250
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 16:11:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5569921741
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 16:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EsbsnAih"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5569921741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0Si0-00077G-Fk
	for qemu-devel@archiver.kernel.org; Sat, 08 Feb 2020 11:11:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44051)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j0Sh4-0005Hc-Nu
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 11:10:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j0Sh3-000874-Q6
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 11:10:54 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:32965)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j0Sh3-00084B-Jw
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 11:10:53 -0500
Received: by mail-wr1-x443.google.com with SMTP id u6so2440985wrt.0
 for <qemu-devel@nongnu.org>; Sat, 08 Feb 2020 08:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IF1no8gDZSvKkX0JGnOQNf/3E5e3U8HxwXO56c6MsQY=;
 b=EsbsnAihxu5sY8c5VZLtDWF0bkerpgyZQAIS92rLkQRqe1Nne+uYSLdyyQdXwczGab
 ZtRKNwOS8xYsPdqG3494K6S7D7X3Rg711RIP1sSEJazWEfs349yEVheN/oZZ6DCHSfJO
 82aT+QHAsUexuxmeP35BdsjEE9NBC0yhcZSDwJ9+jANa1nKCI8c1Dyx3mQa78HF4a7+6
 GZJqOTiWKOGrRXdNLNIAk6711Yhui3c21PTxbQQscVyGNucrD38FzyHSzQCayWoc5T7/
 ERozqs9c3FCWllpWCkFHDB0A+2J3+dCGwzRNlV5sHk8JqMBPKJq+pNzhWypo+bG3EqDb
 hK+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=IF1no8gDZSvKkX0JGnOQNf/3E5e3U8HxwXO56c6MsQY=;
 b=klGD++ccpovhakDvSstSrma1n177uu8jL4Csrs5MVjSWjdQQNP9llktCSAle0NJd4C
 O7i36426hABmPTFvSgwaiZqarcPUsPLjuE/Vx6Y6oObM5Rqckj+/GZpijEtgoEfy04Jq
 ItPRO1pJVmzEUJ1m5kSSWB8JfJqI8f+Ky4iuMmI2NO1yDLydu8arUeMtd3XIKzm9jNI9
 wKigGQPxTZADcF71wK6Mb5Tgn5CehlGqKysEz/tCrmqbaQkLO5+p2QbBLguSR/N3t6SL
 8smixxIIAGPd5JmDmPL3RKy0u4p2aVn3EfUtFEAZeEFRzeSFInG2UTOTpTCb60Fnl4qF
 96Cg==
X-Gm-Message-State: APjAAAWhsVFjYvgozJx8DaJWHM+IYScmQt/vDEd9gLtuwxwK3O1R0zY5
 dB4KpFdxTEEubQQ9EVAEnLXh5yMY
X-Google-Smtp-Source: APXvYqx6gd9yvgkMnvGU2qe0rKK+yKp5Ue8GzVivjmge6XmRPX24XHyl4Z6CS5JpgdWZ8UC5m4ozBg==
X-Received: by 2002:adf:a285:: with SMTP id s5mr6320362wra.118.1581178252369; 
 Sat, 08 Feb 2020 08:10:52 -0800 (PST)
Received: from localhost.localdomain (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id l8sm7931669wmj.2.2020.02.08.08.10.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2020 08:10:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Jan Kiszka <jan.kiszka@web.de>
Subject: [PATCH v2 1/2] ui/gtk: Update gd_refresh_rate_millihz() to handle
 VirtualConsole
Date: Sat,  8 Feb 2020 17:10:47 +0100
Message-Id: <20200208161048.11311-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200208161048.11311-1-f4bug@amsat.org>
References: <20200208161048.11311-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Nikola Pavlica <pavlica.nikola@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 ui/gtk.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index d18892d1de..c59297ff4d 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1965,11 +1965,11 @@ static GtkWidget *gd_create_menu_machine(GtkDisplayState *s)
  * If available, return the refresh rate of the display in milli-Hertz,
  * else return 0.
  */
-static int gd_refresh_rate_millihz(GtkDisplayState *s)
+static int gd_refresh_rate_millihz(GtkWidget *window)
 {
 #ifdef GDK_VERSION_3_22
-    GdkDisplay *dpy = gtk_widget_get_display(s->window);
-    GdkWindow *win = gtk_widget_get_window(s->window);
+    GdkDisplay *dpy = gtk_widget_get_display(window);
+    GdkWindow *win = gtk_widget_get_window(window);
     GdkMonitor *monitor = gdk_display_get_monitor_at_window(dpy, win);
 
     return gdk_monitor_get_refresh_rate(monitor);
@@ -2045,7 +2045,8 @@ static GSList *gd_vc_gfx_init(GtkDisplayState *s, VirtualConsole *vc,
     vc->gfx.kbd = qkbd_state_init(con);
     vc->gfx.dcl.con = con;
 
-    refresh_rate_millihz = gd_refresh_rate_millihz(s);
+    refresh_rate_millihz = gd_refresh_rate_millihz(vc->window ?
+                                                   vc->window : s->window);
     if (refresh_rate_millihz) {
         vc->gfx.dcl.update_interval = MILLISEC_PER_SEC / refresh_rate_millihz;
     }
-- 
2.21.1


