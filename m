Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FC6C33C9E
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 11:22:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4B80206DB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 11:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FESHySM+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4B80206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip9Ps-0003cK-Px
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 06:22:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49271)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pavlica.nikola@gmail.com>) id 1ip9P8-0002pp-Pz
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 06:21:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pavlica.nikola@gmail.com>) id 1ip9P6-0003xL-8R
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 06:21:37 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:34770)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pavlica.nikola@gmail.com>)
 id 1ip9P6-0003wO-0d
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 06:21:36 -0500
Received: by mail-wm1-x342.google.com with SMTP id w5so1006669wmi.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 03:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mE2lnlrRD/lR6rpbLiZ24E0msmA8lV+tPD7M/Fd7f3M=;
 b=FESHySM+6CfufVwmvbg6DtXwO1OL3g2eWhDMnzDJ1b16bXlaWNyzxe3sLmMxgF9YGB
 sYJSriiX2II7rUbO7SWymRzrfoDbeiuJrOkezQ4bs4DGxpDudBmwjpHX3q1t5Uumqz1c
 nF3QqMo7geeIFxl3lS5sHAEz2G1WiDR+DmE3Tp1+/3ZPZPSADLTd1ttCjPlqrxe5hvZX
 ogWX7vQBqer46ADGxoRnZplcAiGZD711IPjExDbMO9HEgUx5xVA3LNLt0brRQJpxli0W
 RrhxgOvomuLe0zkdgyl7rC9v3HEHJNNy+C0sWaPQfwGCsrAv+caXrSMLPjM45iOtZXAF
 Fn6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mE2lnlrRD/lR6rpbLiZ24E0msmA8lV+tPD7M/Fd7f3M=;
 b=tMRUVmkLIiChykssOz1Spizmv5MT5euxgykWxRK7p1KAMPo43WdPAsBQ+wiGv6pq3j
 XARW2HfLggNdX2570QyiJR5RaNQ2NrcYWxss4NZf1BLKS5pyK4SVxtAq5b4+TfKg+Km0
 Jg7iTZ2zlJ52mQi3Jy72l6cYtoWCDidoJf7ipdsbqrvo02vySyH14O5om0cTyYHq86UL
 fLBvMyxq6RCBTz7AIIBVyRaGZDJFoTCX6lvvjJWeC4aPc5SmUBsb3F5gfGK5l4VVkWC9
 WjAsGicdDwv5aCU6z0pDm2NrmoP3hStO0JqHc6JrVYAy8bpOrymYwfe8xdXxmdcQ6k08
 ABIQ==
X-Gm-Message-State: APjAAAV7kpgY3lg5kyVV9ATqxbvQZELfzYUyAB9CiT8LnK/lBkMvUWg7
 2B5h+UHVh8B2vzzFLurNQCVLEAjaKBS+bA==
X-Google-Smtp-Source: APXvYqzz4/6HP2S5xi9XPhpb48t7ijr9XurqfGBxyH49aq+eHiJbpZQtQSQTIqdhD1LC2y0aBW8iDw==
X-Received: by 2002:a05:600c:2150:: with SMTP id
 v16mr3002845wml.156.1578482494608; 
 Wed, 08 Jan 2020 03:21:34 -0800 (PST)
Received: from localhost.localdomain (93-139-26-156.adsl.net.t-com.hr.
 [93.139.26.156])
 by smtp.gmail.com with ESMTPSA id w20sm3318177wmk.34.2020.01.08.03.21.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2020 03:21:34 -0800 (PST)
From: pavlica.nikola@gmail.com
To: qemu-devel@nongnu.org
Subject: [PATCH v4] display/gtk: get proper refreshrate
Date: Wed,  8 Jan 2020 12:20:41 +0100
Message-Id: <20200108112041.24447-1-pavlica.nikola@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: kraxel@redhat.com, Nikola Pavlica <pavlica.nikola@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Nikola Pavlica <pavlica.nikola@gmail.com>

Hi,
QEMU mailing list.

This is the fourth revision of the patch involving the GTK display
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
v4: fixed wrapping and repositioned variable names

Signed-off-by: Nikola Pavlica <pavlica.nikola@gmail.com>
---
 include/ui/gtk.h |  2 ++
 ui/gtk.c         | 10 ++++++++++
 2 files changed, 12 insertions(+)

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
index 692ccc7bbb..eb0efc70ee 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1966,6 +1966,10 @@ static GSList *gd_vc_gfx_init(GtkDisplayState *s, VirtualConsole *vc,
                               GSList *group, GtkWidget *view_menu)
 {
     bool zoom_to_fit = false;
+    int refresh_rate_millihz;
+    GdkDisplay *dpy = gtk_widget_get_display(s->window);
+    GdkWindow *win = gtk_widget_get_window(s->window);
+    GdkMonitor *monitor = gdk_display_get_monitor_at_window(dpy, win);
 
     vc->label = qemu_console_get_label(con);
     vc->s = s;
@@ -2026,6 +2030,12 @@ static GSList *gd_vc_gfx_init(GtkDisplayState *s, VirtualConsole *vc,
 
     vc->gfx.kbd = qkbd_state_init(con);
     vc->gfx.dcl.con = con;
+
+    refresh_rate_millihz = gdk_monitor_get_refresh_rate(monitor);
+    if (refresh_rate_millihz) {
+        vc->gfx.dcl.update_interval = MILLISEC_PER_SEC / refresh_rate_millihz;
+    }
+
     register_displaychangelistener(&vc->gfx.dcl);
 
     gd_connect_vc_gfx_signals(vc);
-- 
2.24.1


