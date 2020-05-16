Return-Path: <SRS0=I9ML=66=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3569AC433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 07:23:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09A0C2074D
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 07:23:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09A0C2074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZrA1-0001iK-6d
	for qemu-devel@archiver.kernel.org; Sat, 16 May 2020 03:23:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44506)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1jZr7Y-0006Ki-5d
 for qemu-devel@nongnu.org; Sat, 16 May 2020 03:20:32 -0400
Received: from mailout10.t-online.de ([194.25.134.21]:53926)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1jZr7X-0004FI-5o
 for qemu-devel@nongnu.org; Sat, 16 May 2020 03:20:31 -0400
Received: from fwd04.aul.t-online.de (fwd04.aul.t-online.de [172.20.26.149])
 by mailout10.t-online.de (Postfix) with SMTP id 8354241DC6E1;
 Sat, 16 May 2020 09:20:29 +0200 (CEST)
Received: from linpower.localnet
 (SmGOveZXghCfq5ciE08tKYkxvUDt3RWgAKckgONvd9zRUZUx4gniADGMbpsk4-2gx+@[46.86.59.135])
 by fwd04.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1jZr7P-2XDqiW0; Sat, 16 May 2020 09:20:23 +0200
Received: by linpower.localnet (Postfix, from userid 1000)
 id DF3952006D2; Sat, 16 May 2020 09:20:14 +0200 (CEST)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: [PATCH v2 04/11] ui/gtk: remove unused code
Date: Sat, 16 May 2020 09:20:07 +0200
Message-Id: <20200516072014.7766-4-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <bea1a22a-1fb4-b49b-c089-e0a5c5cf55cd@t-online.de>
References: <bea1a22a-1fb4-b49b-c089-e0a5c5cf55cd@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ID: SmGOveZXghCfq5ciE08tKYkxvUDt3RWgAKckgONvd9zRUZUx4gniADGMbpsk4-2gx+
X-TOI-EXPURGATEID: 150726::1589613623-00016E58-9E72D121/0/0 CLEAN NORMAL
X-TOI-MSGID: 27034aa1-e75f-4407-9312-ea9c0e9d1e92
Received-SPF: none client-ip=194.25.134.21;
 envelope-from=volker.ruemelin@t-online.de; helo=mailout10.t-online.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/16 03:20:29
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_DNSWL_NONE=-0.0001 autolearn=_AUTOLEARN
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

This code was last used before commit 2ec78706d1 "ui: convert
GTK and SDL1 frontends to keycodemapdb".

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
---
 ui/gtk.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index 655b26de38..0e9503a0d1 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -112,15 +112,6 @@
 # define VTE_CHECK_VERSION(a, b, c) 0
 #endif
 
-/* Some older mingw versions lack this constant or have
- * it conditionally defined */
-#ifdef _WIN32
-# ifndef MAPVK_VK_TO_VSC
-#  define MAPVK_VK_TO_VSC 0
-# endif
-#endif
-
-
 #define HOTKEY_MODIFIERS        (GDK_CONTROL_MASK | GDK_MOD1_MASK)
 
 static const guint16 *keycode_map;
-- 
2.26.1


