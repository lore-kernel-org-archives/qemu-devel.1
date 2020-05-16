Return-Path: <SRS0=I9ML=66=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 940E5C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 07:29:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11E8F2074D
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 07:29:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11E8F2074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZrGf-0000DK-7G
	for qemu-devel@archiver.kernel.org; Sat, 16 May 2020 03:29:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44558)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1jZr7i-0006Z3-0M
 for qemu-devel@nongnu.org; Sat, 16 May 2020 03:20:42 -0400
Received: from mailout06.t-online.de ([194.25.134.19]:34122)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1jZr7g-0004Nb-Ua
 for qemu-devel@nongnu.org; Sat, 16 May 2020 03:20:41 -0400
Received: from fwd28.aul.t-online.de (fwd28.aul.t-online.de [172.20.26.133])
 by mailout06.t-online.de (Postfix) with SMTP id 46B9C4187212;
 Sat, 16 May 2020 09:20:39 +0200 (CEST)
Received: from linpower.localnet
 (XjkBvUZGYhKLaWOscxl-JkxPerUhMl9z8CVN-k1YICE+wipz6U45wfbZLHXP6TAQDl@[46.86.59.135])
 by fwd28.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1jZr7R-3heaQK0; Sat, 16 May 2020 09:20:25 +0200
Received: by linpower.localnet (Postfix, from userid 1000)
 id E18272006D3; Sat, 16 May 2020 09:20:14 +0200 (CEST)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: [PATCH v2 05/11] ui/gtk: remove unused variable ignore_keys
Date: Sat, 16 May 2020 09:20:08 +0200
Message-Id: <20200516072014.7766-5-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <bea1a22a-1fb4-b49b-c089-e0a5c5cf55cd@t-online.de>
References: <bea1a22a-1fb4-b49b-c089-e0a5c5cf55cd@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ID: XjkBvUZGYhKLaWOscxl-JkxPerUhMl9z8CVN-k1YICE+wipz6U45wfbZLHXP6TAQDl
X-TOI-EXPURGATEID: 150726::1589613625-000183D0-81724907/0/0 CLEAN NORMAL
X-TOI-MSGID: 10fd7cad-d1a6-4c99-ba2a-d7fc2bb9007e
Received-SPF: none client-ip=194.25.134.19;
 envelope-from=volker.ruemelin@t-online.de; helo=mailout06.t-online.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/16 03:20:39
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001 autolearn=_AUTOLEARN
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

Since the removal of GTK2 code in commit 89d85cde75 the code
around ignore_keys is unused. See commit 1a01716a30 "gtk: Avoid
accel key leakage into guest on console switch" why it was only
needed for GTK2.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
---
 ui/gtk.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index 0e9503a0d1..354dd90e18 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -168,8 +168,6 @@ struct GtkDisplayState {
 
     bool external_pause_update;
 
-    bool ignore_keys;
-
     DisplayOptions *opts;
 };
 
@@ -1095,14 +1093,8 @@ static gboolean gd_text_key_down(GtkWidget *widget,
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
@@ -1204,7 +1196,6 @@ static void gd_menu_switch_vc(GtkMenuItem *item, void *opaque)
         gtk_notebook_set_current_page(nb, page);
         gtk_widget_grab_focus(vc->focus);
     }
-    s->ignore_keys = false;
 }
 
 static void gd_accel_switch_vc(void *opaque)
-- 
2.26.1


