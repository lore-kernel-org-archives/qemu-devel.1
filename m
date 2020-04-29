Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A30BC83006
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 18:50:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44D2820661
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 18:50:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44D2820661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTrmq-0002cA-CF
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 14:50:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38564)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <volker.ruemelin@t-online.de>) id 1jTrh3-0003xz-0t
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 14:44:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <volker.ruemelin@t-online.de>) id 1jTrfc-0006FG-KF
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 14:44:24 -0400
Received: from mailout10.t-online.de ([194.25.134.21]:55218)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1jTrfc-0005w6-3b
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 14:42:56 -0400
Received: from fwd13.aul.t-online.de (fwd13.aul.t-online.de [172.20.27.62])
 by mailout10.t-online.de (Postfix) with SMTP id C1CBF4174D14;
 Wed, 29 Apr 2020 20:42:52 +0200 (CEST)
Received: from linpower.localnet
 (ZehMggZdohLM7dz8Vr0OOfXCHX+zQkxCJHC7gO019PofqGWqOIQmoUb30gNdJImZMB@[46.86.59.135])
 by fwd13.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1jTrfW-4QM8MS0; Wed, 29 Apr 2020 20:42:50 +0200
Received: by linpower.localnet (Postfix, from userid 1000)
 id 72218200F41; Wed, 29 Apr 2020 20:42:50 +0200 (CEST)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 1/1] Fix win32 keycode for VK_OEM_102
Date: Wed, 29 Apr 2020 20:42:50 +0200
Message-Id: <20200429184250.8238-1-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <1862f332-a40e-2416-5ab4-37d885f87337@t-online.de>
References: <1862f332-a40e-2416-5ab4-37d885f87337@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ID: ZehMggZdohLM7dz8Vr0OOfXCHX+zQkxCJHC7gO019PofqGWqOIQmoUb30gNdJImZMB
X-TOI-MSGID: 9373f70b-6e07-404a-ba0b-155f282ea0cc
Received-SPF: none client-ip=194.25.134.21;
 envelope-from=volker.ruemelin@t-online.de; helo=mailout10.t-online.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 14:42:52
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Received-From: 194.25.134.21
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

The win32 keycode for VK_OEM_102 is 0xe2. The Microsoft docu-
mentation for virtual-key codes agrees with mingw32/winuser.h.

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
---
 data/keymaps.csv | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/data/keymaps.csv b/data/keymaps.csv
index bc2376c..8111047 100644
--- a/data/keymaps.csv
+++ b/data/keymaps.csv
@@ -145,7 +145,7 @@ KEY_KPDOT,83,ANSI_KeypadDecimal,0x41,0x53,0x71,0x71,99,VK_DECIMAL,0x6e,83,83,XK_
 KEY_KPDOT,83,ANSI_KeypadDecimal,0x41,0x53,0x71,0x71,99,VK_DECIMAL,0x6e,83,83,XK_KP_Decimal,0xffae,NumpadDecimal,KPDC,kp_decimal,0x32,0x41
 ,84,,,0x54,,,,,,,,,,,,,,
 KEY_ZENKAKUHANKAKU,85,,,0x76,0x5f,,148,,,,,,,Lang5,HZTG,,,
-KEY_102ND,86,,,0x56,0x61,0x13,100,VK_OEM_102,0xe1,86,86,,,IntlBackslash,LSGT,less,0x7c,
+KEY_102ND,86,,,0x56,0x61,0x13,100,VK_OEM_102,0xe2,86,86,,,IntlBackslash,LSGT,less,0x7c,
 KEY_F11,87,F11,0x67,0x57,0x78,0x56,68,VK_F11,0x7a,87,87,XK_F11,0xffc8,F11,FK11,f11,0x09,0x67
 KEY_F12,88,F12,0x6f,0x58,0x07,0x5e,69,VK_F12,0x7b,88,88,XK_F12,0xffc9,F12,FK12,f12,0x0b,0x6f
 KEY_RO,89,,,0x73,0x51,,135,,,,,,,IntlRo,AB11,ro,,
-- 
2.16.4


