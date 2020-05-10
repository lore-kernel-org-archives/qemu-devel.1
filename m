Return-Path: <SRS0=vfNf=6Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 846F1C54E8B
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 18:44:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 617972082E
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 18:44:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 617972082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXqvx-0000Yg-Ia
	for qemu-devel@archiver.kernel.org; Sun, 10 May 2020 14:44:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45862)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1jXquu-0007gh-Jk
 for qemu-devel@nongnu.org; Sun, 10 May 2020 14:43:12 -0400
Received: from mailout08.t-online.de ([194.25.134.20]:45010)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1jXqut-0005Kn-SL
 for qemu-devel@nongnu.org; Sun, 10 May 2020 14:43:12 -0400
Received: from fwd10.aul.t-online.de (fwd10.aul.t-online.de [172.20.26.152])
 by mailout08.t-online.de (Postfix) with SMTP id 52081410DE12;
 Sun, 10 May 2020 20:43:10 +0200 (CEST)
Received: from linpower.localnet
 (SarWkQZHghCqUVkN6wP8qHFtdnsP6l9FRK8cl2-NPruvS050obWFpTLP-7i5Hnhgnj@[46.86.59.135])
 by fwd10.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1jXqus-1vLm640; Sun, 10 May 2020 20:43:10 +0200
Received: by linpower.localnet (Postfix, from userid 1000)
 id 9A15A200627; Sun, 10 May 2020 20:43:04 +0200 (CEST)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 03/10] ui/gkt: release all keys on grab-broken-event
Date: Sun, 10 May 2020 20:42:57 +0200
Message-Id: <20200510184304.9267-3-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <2393388c-86c3-4d7e-178e-2c7e6d14a8de@t-online.de>
References: <2393388c-86c3-4d7e-178e-2c7e6d14a8de@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ID: SarWkQZHghCqUVkN6wP8qHFtdnsP6l9FRK8cl2-NPruvS050obWFpTLP-7i5Hnhgnj
X-TOI-MSGID: c579c7b6-edc9-4a60-90a5-8622e012e7c9
Received-SPF: none client-ip=194.25.134.20;
 envelope-from=volker.ruemelin@t-online.de; helo=mailout08.t-online.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/10 14:43:07
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001 autolearn=_AUTOLEARN
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

There is no way to grab the Ctrl-Alt-Del key combination on
Windows. This key combination will leave all three keys in a
stuck condition. This patch uses the grab-broken-event to
release the keys.

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
---
 ui/gtk.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/ui/gtk.c b/ui/gtk.c
index 68c63532b1..5de2a75691 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1132,6 +1132,20 @@ static gboolean gd_key_event(GtkWidget *widget, GdkEventKey *key, void *opaque)
     return TRUE;
 }
 
+static gboolean gd_grab_broken_event(GtkWidget *widget,
+                                     GdkEventGrabBroken *event, void *opaque)
+{
+#ifdef CONFIG_WIN32
+    if (event->keyboard) {
+        VirtualConsole *vc = opaque;
+        GtkDisplayState *s = vc->s;
+
+        gtk_release_modifiers(s);
+    }
+#endif
+    return TRUE;
+}
+
 static gboolean gd_event(GtkWidget *widget, GdkEvent *event, void *opaque)
 {
     if (event->type == GDK_MOTION_NOTIFY) {
@@ -1910,6 +1924,8 @@ static void gd_connect_vc_gfx_signals(VirtualConsole *vc)
                          G_CALLBACK(gd_focus_out_event), vc);
         g_signal_connect(vc->gfx.drawing_area, "configure-event",
                          G_CALLBACK(gd_configure), vc);
+        g_signal_connect(vc->gfx.drawing_area, "grab-broken-event",
+                         G_CALLBACK(gd_grab_broken_event), vc);
     } else {
         g_signal_connect(vc->gfx.drawing_area, "key-press-event",
                          G_CALLBACK(gd_text_key_down), vc);
-- 
2.26.1


