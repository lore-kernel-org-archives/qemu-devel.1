Return-Path: <SRS0=vfNf=6Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C18C54E8A
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 18:46:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D8B22082E
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 18:46:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D8B22082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXqy2-0004RG-CI
	for qemu-devel@archiver.kernel.org; Sun, 10 May 2020 14:46:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1jXqv2-0007s3-2I
 for qemu-devel@nongnu.org; Sun, 10 May 2020 14:43:20 -0400
Received: from mailout06.t-online.de ([194.25.134.19]:58892)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1jXqv1-0005Qt-9D
 for qemu-devel@nongnu.org; Sun, 10 May 2020 14:43:19 -0400
Received: from fwd23.aul.t-online.de (fwd23.aul.t-online.de [172.20.26.128])
 by mailout06.t-online.de (Postfix) with SMTP id 1786C412B004;
 Sun, 10 May 2020 20:43:18 +0200 (CEST)
Received: from linpower.localnet
 (Gh9NZQZFQhuH0mfL3pChJ28OX01dW7wLS3WP2GNaZrgxM6KSKi2xrQ2ZCaGjc3sg8h@[46.86.59.135])
 by fwd23.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1jXquz-1VhHDU0; Sun, 10 May 2020 20:43:17 +0200
Received: by linpower.localnet (Postfix, from userid 1000)
 id A094B20062E; Sun, 10 May 2020 20:43:04 +0200 (CEST)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 06/10] ui/sdl2: fix handling of AltGr key on Windows
Date: Sun, 10 May 2020 20:43:00 +0200
Message-Id: <20200510184304.9267-6-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <2393388c-86c3-4d7e-178e-2c7e6d14a8de@t-online.de>
References: <2393388c-86c3-4d7e-178e-2c7e6d14a8de@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ID: Gh9NZQZFQhuH0mfL3pChJ28OX01dW7wLS3WP2GNaZrgxM6KSKi2xrQ2ZCaGjc3sg8h
X-TOI-MSGID: f270ecb2-bd2a-4931-ae7d-9bd289b80a3e
Received-SPF: none client-ip=194.25.134.19;
 envelope-from=volker.ruemelin@t-online.de; helo=mailout06.t-online.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/10 14:43:11
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

Wire up the keyboard hooking code on Windows to fix the AltGr
key and improve keyboard grabbing.

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
---
 ui/sdl2.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index 3c9424eb42..ec1cb8131f 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -30,6 +30,9 @@
 #include "ui/sdl2.h"
 #include "sysemu/runstate.h"
 #include "sysemu/sysemu.h"
+#ifdef CONFIG_WIN32
+#include "win32-kbd-hook.h"
+#endif
 
 static int sdl2_num_outputs;
 static struct sdl2_console *sdl2_console;
@@ -220,6 +223,9 @@ static void sdl_grab_start(struct sdl2_console *scon)
     }
     SDL_SetWindowGrab(scon->real_window, SDL_TRUE);
     gui_grab = 1;
+#ifdef CONFIG_WIN32
+    win32_kbd_set_grab(true);
+#endif
     sdl_update_caption(scon);
 }
 
@@ -227,6 +233,9 @@ static void sdl_grab_end(struct sdl2_console *scon)
 {
     SDL_SetWindowGrab(scon->real_window, SDL_FALSE);
     gui_grab = 0;
+#ifdef CONFIG_WIN32
+    win32_kbd_set_grab(false);
+#endif
     sdl_show_cursor(scon);
     sdl_update_caption(scon);
 }
@@ -532,6 +541,18 @@ static void handle_windowevent(SDL_Event *ev)
         sdl2_redraw(scon);
         break;
     case SDL_WINDOWEVENT_FOCUS_GAINED:
+#ifdef CONFIG_WIN32
+        if (qemu_console_is_graphic(scon->dcl.con)) {
+            SDL_SysWMinfo info;
+
+            SDL_VERSION(&info.version);
+            if (SDL_GetWindowWMInfo(scon->real_window, &info)) {
+                win32_kbd_set_grab(gui_grab);
+                win32_kbd_set_window(info.info.win.window);
+            }
+        }
+#endif
+        /* fall through */
     case SDL_WINDOWEVENT_ENTER:
         if (!gui_grab && (qemu_input_is_absolute() || absolute_enabled)) {
             absolute_mouse_grab(scon);
@@ -546,6 +567,11 @@ static void handle_windowevent(SDL_Event *ev)
         scon->ignore_hotkeys = get_mod_state();
         break;
     case SDL_WINDOWEVENT_FOCUS_LOST:
+#ifdef CONFIG_WIN32
+        if (qemu_console_is_graphic(scon->dcl.con)) {
+            win32_kbd_set_window(NULL);
+        }
+#endif
         if (gui_grab && !gui_fullscreen) {
             sdl_grab_end(scon);
         }
-- 
2.26.1


