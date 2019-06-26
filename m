Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F11C48BD6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 12:13:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2022420663
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 12:13:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2022420663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg6o9-0007Mn-Ci
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 08:13:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49865)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hg6mP-0005ZI-Ql
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 08:12:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hg6mN-0000XF-Ay
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 08:12:01 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:59925)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hg6mM-0000PJ-5f
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 08:11:59 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MqJuP-1iJ0FC1rKF-00nQ8d; Wed, 26 Jun 2019 14:11:49 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Wed, 26 Jun 2019 14:11:38 +0200
Message-Id: <20190626121139.19114-6-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190626121139.19114-1-laurent@vivier.eu>
References: <20190626121139.19114-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:DY24OluJBP6dpVY2Eewm/U9gPbN5GvyYdhzTNOe/HppzORaXKxh
 zA/G9+SPII72PWHbujM0lU5/BXAh7Inda8WtlI7yU7PciKlWX9tSv1EUbgldiWFDOc5G1fO
 +/KaO2XbUyqZc4j9MOLyhArbh3rqBIZjI9gl5JjLnGmWg59wIY0lW5a/PpJP0VmHAdiQRYP
 WwKpYgNQirWtiQC8y3Z9w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Nv+gFETMw6I=:yY7qBbTXmbS8zRVMd6084k
 L25dtkQr+dExPko6TBTPstDcYjA9CrMYRegga1D9fR1ovpwzHUJIFJrym3552lu8Sf068KAvV
 AXWXaIMON0BXJKhdhlu3QfKfGR6AwbTGBDtuUuRmqs11gbhd5sM6P3DTh/ZB/5RdurrS2HKRU
 w3DB3Hsvg0zbgIK4GWEflo2X3675tHZS3zndz8j4rVsYMbkHYUXHaMxhxQhTKfBoZ7tDMpGNq
 uRP84RqekLuN6xavV+O0pT51YoIP/gxlIFEuCXUTZ7+04iC7u3i1u5FGFIUZ7xoXvmGBMKza1
 wvGso+ifJO2JZY0i6knL5CSuoENHr/0P29KNZQvdR2XQK3o4AF2QOBhvhhZ7I0wjLETDKDYkN
 6jczXBTpJ+KDVhy5mecMb4B+o5WQrTGqd75gJvX8/uhOUhmM4PI/wn3cjstyy3pi++qc4G/PU
 B8MrxxJLjCNiGS0OXtmNoet1ZIlV6uZ6WBcjnjHnKtM2KRgWg+4/Hpd1k+50eNXgQP9Kwn621
 VkAh7m9LAUMPCzlkIbCusBhrG76sdCxXP0L7N0qW1F4Gv/G3FegTZRL8Pke4bgbmJCO5JTgLb
 3DJ3jJTBivfLPpOyKz0nyHePEKUAa/BkbW/DbKH3Ps9R8YmtUs815GYUg7Ra7nqfwaDyG+bmL
 IgDfJ9yP4hcSAl8sv4QG0mAlv2BGAr2MV6TbDVUskHZ8hE/aWTz8cqcC5f2rzdli1g26IFuM/
 xk4e8etRoGxipc8PwRPFbpHI02v3jHk47vdBgw==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.75
Subject: [Qemu-devel] [PULL 5/6] linux-user: update PPC64 HWCAP2 feature list
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
Message-Id: <20190609143521.19374-1-laurent@vivier.eu>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/elfload.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 9fd65708c4c4..bd43c4817df8 100644
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


