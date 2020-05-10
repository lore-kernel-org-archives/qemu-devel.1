Return-Path: <SRS0=vfNf=6Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A9BC54E8A
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 18:48:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BC06206B8
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 18:48:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BC06206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXr0Q-0007bh-Nh
	for qemu-devel@archiver.kernel.org; Sun, 10 May 2020 14:48:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1jXqv3-0007uu-Iz
 for qemu-devel@nongnu.org; Sun, 10 May 2020 14:43:21 -0400
Received: from mailout06.t-online.de ([194.25.134.19]:58962)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1jXqv2-0005R2-PS
 for qemu-devel@nongnu.org; Sun, 10 May 2020 14:43:21 -0400
Received: from fwd13.aul.t-online.de (fwd13.aul.t-online.de [172.20.27.62])
 by mailout06.t-online.de (Postfix) with SMTP id 16F9B412B005;
 Sun, 10 May 2020 20:43:19 +0200 (CEST)
Received: from linpower.localnet
 (X7H34aZlZhPe0kHioGJmNp9z7PjBwteoz9OM883n20cISuyiQR6vdbCayze57P+gzC@[46.86.59.135])
 by fwd13.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1jXquu-0r4RE00; Sun, 10 May 2020 20:43:12 +0200
Received: by linpower.localnet (Postfix, from userid 1000)
 id 9C379200629; Sun, 10 May 2020 20:43:04 +0200 (CEST)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 04/10] ui/gtk: remove unused code
Date: Sun, 10 May 2020 20:42:58 +0200
Message-Id: <20200510184304.9267-4-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <2393388c-86c3-4d7e-178e-2c7e6d14a8de@t-online.de>
References: <2393388c-86c3-4d7e-178e-2c7e6d14a8de@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ID: X7H34aZlZhPe0kHioGJmNp9z7PjBwteoz9OM883n20cISuyiQR6vdbCayze57P+gzC
X-TOI-MSGID: 87158edc-5690-4c38-b3b7-a2cfe7a7c11e
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

This code was last used before commit 2ec78706d1 "ui: convert
GTK and SDL1 frontends to keycodemapdb".

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
---
 ui/gtk.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index 5de2a75691..c70bfc2be4 100644
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


