Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095A8C48BD6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 11:56:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D488C2080C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 11:56:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D488C2080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg6Xn-0002Ux-Vj
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 07:56:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43663)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hg6NH-0001KJ-0f
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 07:46:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hg6NF-0005vu-Ge
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 07:46:02 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:60760 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1hg6NF-0005sn-5A
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 07:46:01 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id BEA211A4608;
 Wed, 26 Jun 2019 13:45:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 90B381A464F;
 Wed, 26 Jun 2019 13:45:56 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Wed, 26 Jun 2019 13:45:38 +0200
Message-Id: <1561549550-3501-6-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561549550-3501-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1561549550-3501-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PULL 05/17] hw/mips/gt64xxx_pci: Use qemu_log_mask()
 instead of debug printf()
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

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Message-Id: <20190624222844.26584-6-f4bug@amsat.org>
---
 hw/mips/gt64xxx_pci.c | 48 +++++++++++++++++++++++++++++++++++++--------=
---
 1 file changed, 37 insertions(+), 11 deletions(-)

diff --git a/hw/mips/gt64xxx_pci.c b/hw/mips/gt64xxx_pci.c
index 0b9fb02..f44326f 100644
--- a/hw/mips/gt64xxx_pci.c
+++ b/hw/mips/gt64xxx_pci.c
@@ -23,6 +23,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/log.h"
 #include "hw/hw.h"
 #include "hw/mips/mips.h"
 #include "hw/pci/pci.h"
@@ -466,12 +467,20 @@ static void gt64120_writel(void *opaque, hwaddr add=
r,
     case GT_CPUERR_DATAHI:
     case GT_CPUERR_PARITY:
         /* Read-only registers, do nothing */
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "gt64120: Read-only register write "
+                      "reg:0x03%x size:%u value:0x%0*" PRIx64 "\n",
+                      saddr << 2, size, size << 1, val);
         break;
=20
     /* CPU Sync Barrier */
     case GT_PCI0SYNC:
     case GT_PCI1SYNC:
         /* Read-only registers, do nothing */
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "gt64120: Read-only register write "
+                      "reg:0x03%x size:%u value:0x%0*" PRIx64 "\n",
+                      saddr << 2, size, size << 1, val);
         break;
=20
     /* SDRAM and Device Address Decode */
@@ -510,7 +519,10 @@ static void gt64120_writel(void *opaque, hwaddr addr=
,
     case GT_DEV_B3:
     case GT_DEV_BOOT:
         /* Not implemented */
-        DPRINTF ("Unimplemented device register offset 0x%x\n", saddr <<=
 2);
+        qemu_log_mask(LOG_UNIMP,
+                      "gt64120: Unimplemented device register write "
+                      "reg:0x03%x size:%u value:0x%0*" PRIx64 "\n",
+                      saddr << 2, size, size << 1, val);
         break;
=20
     /* ECC */
@@ -520,6 +532,10 @@ static void gt64120_writel(void *opaque, hwaddr addr=
,
     case GT_ECC_CALC:
     case GT_ECC_ERRADDR:
         /* Read-only registers, do nothing */
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "gt64120: Read-only register write "
+                      "reg:0x03%x size:%u value:0x%0*" PRIx64 "\n",
+                      saddr << 2, size, size << 1, val);
         break;
=20
     /* DMA Record */
@@ -543,23 +559,20 @@ static void gt64120_writel(void *opaque, hwaddr add=
r,
     case GT_DMA1_CUR:
     case GT_DMA2_CUR:
     case GT_DMA3_CUR:
-        /* Not implemented */
-        DPRINTF ("Unimplemented DMA register offset 0x%x\n", saddr << 2)=
;
-        break;
=20
     /* DMA Channel Control */
     case GT_DMA0_CTRL:
     case GT_DMA1_CTRL:
     case GT_DMA2_CTRL:
     case GT_DMA3_CTRL:
-        /* Not implemented */
-        DPRINTF ("Unimplemented DMA register offset 0x%x\n", saddr << 2)=
;
-        break;
=20
     /* DMA Arbiter */
     case GT_DMA_ARB:
         /* Not implemented */
-        DPRINTF ("Unimplemented DMA register offset 0x%x\n", saddr << 2)=
;
+        qemu_log_mask(LOG_UNIMP,
+                      "gt64120: Unimplemented DMA register write "
+                      "reg:0x03%x size:%u value:0x%0*" PRIx64 "\n",
+                      saddr << 2, size, size << 1, val);
         break;
=20
     /* Timer/Counter */
@@ -569,7 +582,10 @@ static void gt64120_writel(void *opaque, hwaddr addr=
,
     case GT_TC3:
     case GT_TC_CONTROL:
         /* Not implemented */
-        DPRINTF ("Unimplemented timer register offset 0x%x\n", saddr << =
2);
+        qemu_log_mask(LOG_UNIMP,
+                      "gt64120: Unimplemented timer register write "
+                      "reg:0x03%x size:%u value:0x%0*" PRIx64 "\n",
+                      saddr << 2, size, size << 1, val);
         break;
=20
     /* PCI Internal */
@@ -610,6 +626,10 @@ static void gt64120_writel(void *opaque, hwaddr addr=
,
     case GT_PCI1_CFGADDR:
     case GT_PCI1_CFGDATA:
         /* not implemented */
+        qemu_log_mask(LOG_UNIMP,
+                      "gt64120: Unimplemented timer register write "
+                      "reg:0x03%x size:%u value:0x%0*" PRIx64 "\n",
+                      saddr << 2, size, size << 1, val);
         break;
     case GT_PCI0_CFGADDR:
         phb->config_reg =3D val & 0x80fffffc;
@@ -666,7 +686,10 @@ static void gt64120_writel(void *opaque, hwaddr addr=
,
         break;
=20
     default:
-        DPRINTF ("Bad register offset 0x%x\n", (int)addr);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "gt64120: Illegal register write "
+                      "reg:0x03%x size:%u value:0x%0*" PRIx64 "\n",
+                      saddr << 2, size, size << 1, val);
         break;
     }
 }
@@ -940,7 +963,10 @@ static uint64_t gt64120_readl(void *opaque,
=20
     default:
         val =3D s->regs[saddr];
-        DPRINTF ("Bad register offset 0x%x\n", (int)addr);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "gt64120: Illegal register read "
+                      "reg:0x03%x size:%u value:0x%0*x\n",
+                      saddr << 2, size, size << 1, val);
         break;
     }
=20
--=20
2.7.4


