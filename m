Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C54C352A5
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 13:28:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95E8C2080C
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 13:28:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95E8C2080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j197H-0006D3-Q6
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 08:28:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48064)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j196k-0005m4-QS
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 08:28:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j196j-0005OW-QU
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 08:28:14 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:55463)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1j196j-0005Ls-I2
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 08:28:13 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N5G1T-1jSTV41iY1-011BYT; Mon, 10 Feb 2020 14:22:55 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH] q800: fix coverity warning CID 1412799
Date: Mon, 10 Feb 2020 14:22:52 +0100
Message-Id: <20200210132252.381343-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:mjToN0+nErYIURh7M9W0/PzxUvFYNBW/Fe3RqK1+CdUoVLxFPV3
 MWiGBx0ztxYOGoKDPdP60AFxw5XDMV4ZIE/WqoKJZyoaySNQnkRlbO7nCHAVfgkwxOYte4g
 +KmJTl2mMsWfIhkBB5M7DmovYgudaQkwHVOLuXL6RhbmXtWXRpMJAIWJ4jpZn1dF/IbEQDo
 2Y0zpPsb6fkLJq/yQyo5g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jwaMWu8gU2c=:LcvtICKaTd9ADrkzqHPAp3
 MfSlIuFU53R1dlJ2X/nChCb0v+5WM01aK3erGHedHgf1JM00EcRITVyE3L7WMhdUiq6Iwr/Sw
 240PIILhHQ1MzQsNiD/JVz1ms5shdMd8vnEBq0DaSEQ+mwYPyqEZQyCrprbuFvyNrsR/GQ9Uy
 jcAIKbJg6vtJhu2Ch3o54U24SSog+4LPkESCIpWWOjk6zeqKTUR61fqnIZPsGmjYJeL+er2xl
 PvqLPlbKX6xExxK9A/ssHUxc0WLms3Raty66s2eZpaoFCNrOlytwtOYJrmyHt6ykloqkrWjkR
 oo/+QDrncIeKiPyEtnJ2NMz1YJWmnB3M+d0uxNHxU/dEEULtFrH6Vw5PhFMmwQfxlXm6nLEuI
 MwrMAkRf425kTNpHMpOdHKtdR0ETBZ5Chn8PkcALZrAqJhoOy8GADKRR4RsmyhRIVF+U9dVDK
 syYelWU+yxyiYp96PGfo6UlpCmC//Q2WfFmXsciVwTuJ7wNOs4/O63Qk0i5Bmeb/Lc4/PNlhj
 1G3zvr1wplYjohDsTRCCafvgHlzrIhN/Z1ZleqbOyH4DstvfbYJNfa6F1l7roVoJWDugVhXCa
 nvRSV9t00aj4fR6hEiBSQkc8YVo5jazvW14BCYzDvioBSZyDJbWTILjH5ndUBPYq6n94o+BwB
 QyeszDTR/hBMJ3yA/Q9vKX/B7YqYW6/cHlO2c9al+VQDCAzdcKLuu3lbH7pZNl1vgQ4x7BpyT
 M8+N5zw1Um26aH6GHfznRVgwojDXWIVsdnPJ1c16yO8NvWyCG4uBphiv9vZJXLkbBOPFOFpH0
 0aAZjKlRAJAzrdLk54GFFq7HXZXu9b/VGL3cXcaVJhjYANCvPmXrh5AHy+CDJWQQ0ms4XdO
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.13
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Check the return value of blk_write() and log an error if any

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/misc/mac_via.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
index b7d0012794..81343301b1 100644
--- a/hw/misc/mac_via.c
+++ b/hw/misc/mac_via.c
@@ -30,6 +30,7 @@
 #include "hw/qdev-properties.h"
 #include "sysemu/block-backend.h"
 #include "trace.h"
+#include "qemu/log.h"
 
 /*
  * VIAs: There are two in every machine,
@@ -381,8 +382,10 @@ static void via2_irq_request(void *opaque, int irq, int level)
 static void pram_update(MacVIAState *m)
 {
     if (m->blk) {
-        blk_pwrite(m->blk, 0, m->mos6522_via1.PRAM,
-                   sizeof(m->mos6522_via1.PRAM), 0);
+        if (blk_pwrite(m->blk, 0, m->mos6522_via1.PRAM,
+                       sizeof(m->mos6522_via1.PRAM), 0) < 0) {
+            qemu_log("pram_update: cannot write to file\n");
+        }
     }
 }
 
-- 
2.24.1


