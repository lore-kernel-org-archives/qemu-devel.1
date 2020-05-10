Return-Path: <SRS0=vfNf=6Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA10C54E8A
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 18:44:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38F022082E
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 18:44:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38F022082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXqw1-0000hQ-D8
	for qemu-devel@archiver.kernel.org; Sun, 10 May 2020 14:44:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1jXqv1-0007qH-1K
 for qemu-devel@nongnu.org; Sun, 10 May 2020 14:43:19 -0400
Received: from mailout02.t-online.de ([194.25.134.17]:36484)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1jXqv0-0005Qj-1w
 for qemu-devel@nongnu.org; Sun, 10 May 2020 14:43:18 -0400
Received: from fwd32.aul.t-online.de (fwd32.aul.t-online.de [172.20.26.144])
 by mailout02.t-online.de (Postfix) with SMTP id 5D87941ACBAA;
 Sun, 10 May 2020 20:43:16 +0200 (CEST)
Received: from linpower.localnet
 (bHC234ZvYhqqiycqzb-FGY2RKNXtxkMVJ7AimXqY37O5ZudUwK4a4UPvwxe+uPiwcp@[46.86.59.135])
 by fwd32.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1jXqux-0uILmS0; Sun, 10 May 2020 20:43:15 +0200
Received: by linpower.localnet (Postfix, from userid 1000)
 id 9E4DC20062B; Sun, 10 May 2020 20:43:04 +0200 (CEST)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 05/10] ui/gtk: remove unused variable ignore_keys
Date: Sun, 10 May 2020 20:42:59 +0200
Message-Id: <20200510184304.9267-5-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <2393388c-86c3-4d7e-178e-2c7e6d14a8de@t-online.de>
References: <2393388c-86c3-4d7e-178e-2c7e6d14a8de@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ID: bHC234ZvYhqqiycqzb-FGY2RKNXtxkMVJ7AimXqY37O5ZudUwK4a4UPvwxe+uPiwcp
X-TOI-MSGID: 786493ba-6b4b-4b8a-accc-f216fa1b679f
Received-SPF: none client-ip=194.25.134.17;
 envelope-from=volker.ruemelin@t-online.de; helo=mailout02.t-online.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/10 14:43:16
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

Since the removal of GTK2 code the code around ignore_keys is
unused. See commit 1a01716a30 "gtk: Avoid accel key leakage
into guest on console switch" why it was needed before.

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
---
 ui/gtk.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index c70bfc2be4..5a25e3fa4c 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -168,8 +168,6 @@ struct GtkDisplayState {
 
     bool external_pause_update;
 
-    bool ignore_keys;
-
     DisplayOptions *opts;
 };
 
@@ -1085,14 +1083,8 @@ static gboolean gd_text_key_down(GtkWidget *widget,
 static gboolean gd_key_event(GtkWidget *widget, GdkEventKey *key, void *opaque)
 {
     VirtualConsole *vc = opaque;
-    GtkDisplayState *s = vc->s;
     int qcode;
 
-    if (s->ignore_keys) {
-        s->ignore_keys = (key->type == GDK_KEY_PRESS);
-        return TRUE;
-    }
-
 #ifdef WIN32
     /* on windows, we ought to ignore the reserved key event? */
     if (key->hardware_keycode == 0xff)
@@ -1189,7 +1181,6 @@ static void gd_menu_switch_vc(GtkMenuItem *item, void *opaque)
         gtk_notebook_set_current_page(nb, page);
         gtk_widget_grab_focus(vc->focus);
     }
-    s->ignore_keys = false;
 }
 
 static void gd_accel_switch_vc(void *opaque)
-- 
2.26.1


