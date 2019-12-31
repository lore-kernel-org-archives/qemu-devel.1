Return-Path: <SRS0=eTrL=2V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA79C2D0C2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 17:46:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 389FA205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 17:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rGGkY8YL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 389FA205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imLbI-0000XJ-DK
	for qemu-devel@archiver.kernel.org; Tue, 31 Dec 2019 12:46:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37936)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pavlica.nikola@gmail.com>) id 1imLaM-0008UD-PP
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 12:45:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pavlica.nikola@gmail.com>) id 1imLaL-0000ir-Ep
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 12:45:38 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:33170)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pavlica.nikola@gmail.com>)
 id 1imLaL-0000ft-6F
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 12:45:37 -0500
Received: by mail-wr1-x42c.google.com with SMTP id b6so35737523wrq.0
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 09:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:user-agent:mime-version
 :content-transfer-encoding;
 bh=gD4xDTxb2j2tgt4EokXc2JdIide3nx0PuHSHsqB6Z8A=;
 b=rGGkY8YLUuC2n6DhY8fangaHw7oqBiFulhVwL2GRzPYzslvgyAseWD+M1sB3aq+jck
 JQh4q5RMYdP6MPNI+y2DT+j19BObjkKrcxXUzzqDOqeiyvND88Bm3hEyEb4CLDvvi5Dh
 9l+1dW5F6a/IpdExD1XAEOqX5Ts4vFLQ6V+vWaTiNui6qMiFOS0BI2OatE+HUBBDtu+3
 eBXrRQtrvK91b8JtIkKerjCMNSGRz5EUhLEXJjifEXTjB/Z9G/qca/iGW4ILl8pYQqgf
 Cwbe1Hwyeni/KrfcZMJrwkSar1QGioNja0q38X3vgdhqqNiETSkp96x7NS1B25IvU/YL
 ctCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:user-agent
 :mime-version:content-transfer-encoding;
 bh=gD4xDTxb2j2tgt4EokXc2JdIide3nx0PuHSHsqB6Z8A=;
 b=q5UojYMdVzAVoZx30+4RuGxLeWaE0g9Q3w5Y9sMpIn0YOUuhaQcMrAQwefs7Tyd7ME
 W4n/RFohIRxyV6bNsnPOSmC8+GzwuUnlO9eZMBmcXXY/hBz4ZF2wkiEJcMyCqV0uUL02
 d+ApYRP+yRCG5nxQNKCJMktgB32+5eFVnP/Cz2g3zNXfjNUn02Y+cP1XQL7wwiMQCAMv
 UzCcGpvHsRd7MJO+5W1hUrAoYwYJuXHOHLYUzZQFBvAuvj2AYLqNBz1k2Q21kV/VvIYN
 FX1hX+gOimGFXSNi6eWaYyEPcsXNU7sDNfeoYqx0CnHfpWVDeH/cz9OfpivvqPc45V7R
 yPOg==
X-Gm-Message-State: APjAAAXeO6HrzVM8fYbPfUaGOn1R+TZlUIv80VZiQ3wWjo5+9FyAJMcv
 jJ1+eqlOwuV+xkOxuNSdPiYshba5JTXBTg==
X-Google-Smtp-Source: APXvYqwB6PlMuFVeOqyy0YneDvIpZqexOs7e0qt/f7bFAuyrVAOEAXe79RUD3xVw4cRxPlDr3EcWLA==
X-Received: by 2002:a5d:4fd0:: with SMTP id h16mr70099669wrw.255.1577814335492; 
 Tue, 31 Dec 2019 09:45:35 -0800 (PST)
Received: from HP-Laptop (93-139-26-156.adsl.net.t-com.hr. [93.139.26.156])
 by smtp.gmail.com with ESMTPSA id s10sm50382551wrw.12.2019.12.31.09.45.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Dec 2019 09:45:34 -0800 (PST)
Message-ID: <df077a591cc6d4cd20178ba0829c1f37f891ae4e.camel@gmail.com>
Subject: [PATCH v3] display/gtk: get proper refreshrate
From: Nikola Pavlica <pavlica.nikola@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>
Date: Tue, 31 Dec 2019 18:45:32 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
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
Cc: philmd@redhat.com, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From 2d85b4a0edba0bf3fa3c221dcbde7e82a6a771fa Mon Sep 17 00:00:00 2001
From: Nikola Pavlica <pavlica.nikola@gmail.com>
Date: Tue, 31 Dec 2019 18:16:28 +0100
Subject: [PATCH v3] display/gtk: get proper refreshrate

Hi,
QEMU mailing list.

This is the third revision of the patch involving the GTK display
output getting the proper refresh rate for your particular display
output.

Because some VMs in QEMU can get GPU virtualization (using technologies
such as iGVT-g, as mentioned previously), they could produce a video
output that had a higher display refresh rate than of what the GTK
display was displaying. (fxp. Playing a video game inside of a Windows
VM at 60 Hz, while the output stood locked at 33 Hz because of defaults
set in include/ui/console.h)

Since QEMU does indeed have internal systems for determining frame
times as defined in ui/console.c.
The code checks for a variable called update_interval that it later
uses for time calculation. This variable, however, isn't defined
anywhere in ui/gtk.c and instead ui/console.c just sets it to
GUI_REFRESH_INTERVAL_DEFAULT which is 30

update_interval represents the number of milliseconds per display
refresh, and by doing some math we get that 1000/30 = 33.33... Hz

This creates the mentioned problem and what this patch does is that it
checks for the display refresh rate reported by GTK itself (we can take
this as a safe value) and just converts it back to a number of
milliseconds per display refresh.

Explinations of each revision:
v1: initial patch
v2: moved code to a more appropriate place and reduced overhead and
memory usage (by not creating a new GdkDisplay)
v3: removed magic value and turned it into something more readable and
added checks for an error state where GTK was unable to get the refresh
rate, in which case we use the already existing default

P.S. Big thanks to Phil (philmd@redhat.com) for mentioning these issues
and for teaching me on how to work with mailing lists.
P.S.S. Happy new years :)

Signed-off-by: Nikola Pavlica <pavlica.nikola@gmail.com>
---
 include/ui/gtk.h |  2 ++
 ui/gtk.c         | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/ui/gtk.h b/include/ui/gtk.h
index d9eedad976..d1b230848a 100644
--- a/include/ui/gtk.h
+++ b/include/ui/gtk.h
@@ -28,6 +28,8 @@
 #include "ui/egl-context.h"
 #endif
 
+#define MILLISEC_PER_SEC 1000000
+
 typedef struct GtkDisplayState GtkDisplayState;
 
 typedef struct VirtualGfxConsole {
diff --git a/ui/gtk.c b/ui/gtk.c
index 692ccc7bbb..197d962e3e 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1967,6 +1967,12 @@ static GSList *gd_vc_gfx_init(GtkDisplayState
*s, VirtualConsole *vc,
 {
     bool zoom_to_fit = false;
 
+    int refresh_rate_millihz = 0;
+
+    GdkDisplay *dpy = gtk_widget_get_display(s->window);
+    GdkWindow *win = gtk_widget_get_window(s->window);
+    GdkMonitor *monitor = gdk_display_get_monitor_at_window(dpy, win);
+
     vc->label = qemu_console_get_label(con);
     vc->s = s;
     vc->gfx.scale_x = 1.0;
@@ -2026,6 +2032,12 @@ static GSList *gd_vc_gfx_init(GtkDisplayState
*s, VirtualConsole *vc,
 
     vc->gfx.kbd = qkbd_state_init(con);
     vc->gfx.dcl.con = con;
+
+    refresh_rate_millihz = gdk_monitor_get_refresh_rate(monitor);
+    if (refresh_rate_millihz) {
+        vc->gfx.dcl.update_interval = MILLISEC_PER_SEC /
refresh_rate_millihz;
+    }
+
     register_displaychangelistener(&vc->gfx.dcl);
 
     gd_connect_vc_gfx_signals(vc);
-- 
2.24.0



