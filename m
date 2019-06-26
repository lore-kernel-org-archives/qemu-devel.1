Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71DDC48BD6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 11:53:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1CFD20663
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 11:53:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1CFD20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg6UG-00070b-3B
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 07:53:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43623)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hg6NF-0001KA-Rh
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 07:46:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hg6NE-0005t1-Dt
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 07:46:01 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:60633 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1hg6NE-0005nW-1X
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 07:46:00 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 8785F1A20B4;
 Wed, 26 Jun 2019 13:45:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 676131A2276;
 Wed, 26 Jun 2019 13:45:56 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Wed, 26 Jun 2019 13:45:34 +0200
Message-Id: <1561549550-3501-2-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561549550-3501-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1561549550-3501-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PULL 01/17] hw/mips/gt64xxx_pci: Fix multiline
 comment syntax
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
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Since commit 8c06fbdf36b checkpatch.pl enforce a new multiline
comment syntax. Since we'll move this code around, fix its style
first.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Message-Id: <20190624222844.26584-2-f4bug@amsat.org>
---
 hw/mips/gt64xxx_pci.c | 64 ++++++++++++++++++++++++++++-----------------=
------
 1 file changed, 35 insertions(+), 29 deletions(-)

diff --git a/hw/mips/gt64xxx_pci.c b/hw/mips/gt64xxx_pci.c
index f707e59..c092464 100644
--- a/hw/mips/gt64xxx_pci.c
+++ b/hw/mips/gt64xxx_pci.c
@@ -248,10 +248,11 @@ typedef struct GT64120State {
 } GT64120State;
=20
 /* Adjust range to avoid touching space which isn't mappable via PCI */
-/* XXX: Hardcoded values for Malta: 0x1e000000 - 0x1f100000
-                                    0x1fc00000 - 0x1fd00000  */
-static void check_reserved_space (hwaddr *start,
-                                  hwaddr *length)
+/*
+ * XXX: Hardcoded values for Malta: 0x1e000000 - 0x1f100000
+ *                                  0x1fc00000 - 0x1fd00000
+ */
+static void check_reserved_space(hwaddr *start, hwaddr *length)
 {
     hwaddr begin =3D *start;
     hwaddr end =3D *start + *length;
@@ -650,8 +651,10 @@ static void gt64120_writel (void *opaque, hwaddr add=
r,
     case GT_SDRAM_B1:
     case GT_SDRAM_B2:
     case GT_SDRAM_B3:
-        /* We don't simulate electrical parameters of the SDRAM.
-           Accept, but ignore the values. */
+        /*
+         * We don't simulate electrical parameters of the SDRAM.
+         * Accept, but ignore the values.
+         */
         s->regs[saddr] =3D val;
         break;
=20
@@ -674,8 +677,10 @@ static uint64_t gt64120_readl (void *opaque,
=20
     /* CPU Configuration */
     case GT_MULTI:
-        /* Only one GT64xxx is present on the CPU bus, return
-           the initial value */
+        /*
+         * Only one GT64xxx is present on the CPU bus, return
+         * the initial value.
+         */
         val =3D s->regs[saddr];
         break;
=20
@@ -685,17 +690,18 @@ static uint64_t gt64120_readl (void *opaque,
     case GT_CPUERR_DATALO:
     case GT_CPUERR_DATAHI:
     case GT_CPUERR_PARITY:
-        /* Emulated memory has no error, always return the initial
-           values */
+        /* Emulated memory has no error, always return the initial value=
s. */
         val =3D s->regs[saddr];
         break;
=20
     /* CPU Sync Barrier */
     case GT_PCI0SYNC:
     case GT_PCI1SYNC:
-        /* Reading those register should empty all FIFO on the PCI
-           bus, which are not emulated. The return value should be
-           a random value that should be ignored. */
+        /*
+         * Reading those register should empty all FIFO on the PCI
+         * bus, which are not emulated. The return value should be
+         * a random value that should be ignored.
+         */
         val =3D 0xc000ffee;
         break;
=20
@@ -705,8 +711,7 @@ static uint64_t gt64120_readl (void *opaque,
     case GT_ECC_MEM:
     case GT_ECC_CALC:
     case GT_ECC_ERRADDR:
-        /* Emulated memory has no error, always return the initial
-           values */
+        /* Emulated memory has no error, always return the initial value=
s. */
         val =3D s->regs[saddr];
         break;
=20
@@ -785,8 +790,10 @@ static uint64_t gt64120_readl (void *opaque,
     case GT_SDRAM_B1:
     case GT_SDRAM_B2:
     case GT_SDRAM_B3:
-        /* We don't simulate electrical parameters of the SDRAM.
-           Just return the last written value. */
+        /*
+         * We don't simulate electrical parameters of the SDRAM.
+         * Just return the last written value.
+         */
         val =3D s->regs[saddr];
         break;
=20
@@ -949,20 +956,20 @@ static int gt64120_pci_map_irq(PCIDevice *pci_dev, =
int irq_num)
     slot =3D (pci_dev->devfn >> 3);
=20
     switch (slot) {
-      /* PIIX4 USB */
-      case 10:
+    /* PIIX4 USB */
+    case 10:
         return 3;
-      /* AMD 79C973 Ethernet */
-      case 11:
+    /* AMD 79C973 Ethernet */
+    case 11:
         return 1;
-      /* Crystal 4281 Sound */
-      case 12:
+    /* Crystal 4281 Sound */
+    case 12:
         return 2;
-      /* PCI slot 1 to 4 */
-      case 18 ... 21:
+    /* PCI slot 1 to 4 */
+    case 18 ... 21:
         return ((slot - 18) + irq_num) & 0x03;
-      /* Unknown device, don't do any translation */
-      default:
+    /* Unknown device, don't do any translation */
+    default:
         return irq_num;
     }
 }
@@ -980,8 +987,7 @@ static void gt64120_pci_set_irq(void *opaque, int irq=
_num, int level)
     /* XXX: optimize */
     pic_irq =3D piix4_dev->config[0x60 + irq_num];
     if (pic_irq < 16) {
-        /* The pic level is the logical OR of all the PCI irqs mapped
-           to it */
+        /* The pic level is the logical OR of all the PCI irqs mapped to=
 it. */
         pic_level =3D 0;
         for (i =3D 0; i < 4; i++) {
             if (pic_irq =3D=3D piix4_dev->config[0x60 + i])
--=20
2.7.4


