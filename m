Return-Path: <SRS0=Ju6v=UI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BACC28EBD
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Jun 2019 14:41:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78E5B20652
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Jun 2019 14:41:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78E5B20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36184 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZz1B-0003AY-P7
	for qemu-devel@archiver.kernel.org; Sun, 09 Jun 2019 10:41:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60677)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hZz0F-0002gb-1D
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 10:41:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hZz0E-00061t-2H
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 10:40:58 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:50987)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hZz0D-00061M-QA
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 10:40:58 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mofx1-1glFsp07VR-00p4uQ; Sun, 09 Jun 2019 16:35:30 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Sun,  9 Jun 2019 16:35:20 +0200
Message-Id: <20190609143521.19374-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:axjeEYyWh486XNPRI0n4/MXhjc6sP5YEcBOq09+7Gq9QnIp4QC3
 htwTimx6DJXm5A94XKbb8Mw1UW5Y62tqu75+qlciMqYVMs2Gwl+gGU+aMrxF4EfGQani9Lo
 BxNcQgfOH0LecCLAeOweAw177mJ6d6yiVgdJmEzqEQ7fyKeOZEFP1DTQw20Pvm92ruP4Abz
 VK9Pwp5WANMZJYff8rP4A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2BCs+7Neftg=:wkqQyqOxw6Jly0k8kEW6os
 +8sDQLpM/+3X/69yRP/JCXRMnAWth87N/ApCvoeyk2wOhXD5V/C0d43MUbW81aYzYQ4uGOC+g
 wqvG6exDaiT4gS228pCBAtpzT5CA7kTZOBYgyoeM4N3INwBiUhkuoH09m8hmWiuKdDgzOPMB0
 FoU/iAUz6RoY7G6tgVZLlYICvSBTmdVDqvqGhjzNpMCafq0bdad9KKg1RAXsXakIbFfLCh+YL
 MYy8OSiD3gx1kkSelrQY72P9+Zghv/j+hRGR0hv7mcJ8sOtmPyg9dRinuZH0qT0WSBxkqxlk+
 wQWRoR/VS/p+NJvKA5yL43Uf1XFHaNGiBI3yhfHxtg8kreEFTbHsPvPN4S8R1hiM9/tyuKTo2
 gfuF7aSuN1f7DacUiJTwkOfgbqqOVpez4a+zIqqSAYPcCg1CJkxYxE3YDXMsN9Ax1RxrL+QDQ
 katq/C43OiOmlIWpqss1/0ecmNykf0UoBcGGXcRnUfS3X89FfSfDTyXCqJIuyDdOzSjcvSAK8
 vopF9gPTjKd3+4K0wtLk1diNr11O69t4wgVBCTie53KyZuLMD022+HAyIKtsmG4mni5kFGH5g
 ndfHr5XkSoBeYJy+yWXQCA3pDUcsDyqqoC6mf2JWIIhlQUbY4kXP2SJLPETCT53rL/emaDuBa
 Z7UR4LlfOiY2jLAfNop5hcexQ1rdGft2WNe3tuAghMN9Kka5BkCHXEulRV2QtOlMw4U+G8m5b
 QWNmXMPDUVRmJUtt2Oeig/VeGcOK4SuIK88n0IznUIURLkZhVWI4FV+FvOFzQIifPFquhYE/e
 lY7aL4G
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.24
Subject: [Qemu-devel] [PATCH 1/2] linux-user: update PPC64 HWCAP2 feature
 list
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QEMU_PPC_FEATURE2_VEC_CRYPTO enables the use
of VSX instructions in libcrypto that are accelerated
by the TCG vector instructions now.

QEMU_PPC_FEATURE2_DARN allows to use the new builtin
qemu_guest_getrandom() function.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/elfload.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 5451d262ec8e..5751beff1b64 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -768,7 +768,13 @@ enum {
     QEMU_PPC_FEATURE2_HAS_EBB = 0x10000000, /* Event Base Branching */
     QEMU_PPC_FEATURE2_HAS_ISEL = 0x08000000, /* Integer Select */
     QEMU_PPC_FEATURE2_HAS_TAR = 0x04000000, /* Target Address Register */
+    QEMU_PPC_FEATURE2_VEC_CRYPTO = 0x02000000,
+    QEMU_PPC_FEATURE2_HTM_NOSC = 0x01000000,
     QEMU_PPC_FEATURE2_ARCH_3_00 = 0x00800000, /* ISA 3.00 */
+    QEMU_PPC_FEATURE2_HAS_IEEE128 = 0x00400000, /* VSX IEEE Bin Float 128-bit */
+    QEMU_PPC_FEATURE2_DARN = 0x00200000, /* darn random number insn */
+    QEMU_PPC_FEATURE2_SCV = 0x00100000, /* scv syscall */
+    QEMU_PPC_FEATURE2_HTM_NO_SUSPEND = 0x00080000, /* TM w/o suspended state */
 };
 
 #define ELF_HWCAP get_elf_hwcap()
@@ -822,8 +828,10 @@ static uint32_t get_elf_hwcap2(void)
     GET_FEATURE(PPC_ISEL, QEMU_PPC_FEATURE2_HAS_ISEL);
     GET_FEATURE2(PPC2_BCTAR_ISA207, QEMU_PPC_FEATURE2_HAS_TAR);
     GET_FEATURE2((PPC2_BCTAR_ISA207 | PPC2_LSQ_ISA207 | PPC2_ALTIVEC_207 |
-                  PPC2_ISA207S), QEMU_PPC_FEATURE2_ARCH_2_07);
-    GET_FEATURE2(PPC2_ISA300, QEMU_PPC_FEATURE2_ARCH_3_00);
+                  PPC2_ISA207S), QEMU_PPC_FEATURE2_ARCH_2_07 |
+                  QEMU_PPC_FEATURE2_VEC_CRYPTO);
+    GET_FEATURE2(PPC2_ISA300, QEMU_PPC_FEATURE2_ARCH_3_00 |
+                 QEMU_PPC_FEATURE2_DARN);
 
 #undef GET_FEATURE
 #undef GET_FEATURE2
-- 
2.21.0


