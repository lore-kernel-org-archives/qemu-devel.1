Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046C5C48BD3
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 11:50:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3D1D204FD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 11:50:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3D1D204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg6RX-000397-4Q
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 07:50:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43613)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hg6NF-0001K9-Eq
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 07:46:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hg6NE-0005sR-9p
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 07:46:01 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:60650 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1hg6NE-0005o5-1f
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 07:46:00 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 9F61F1A457C;
 Wed, 26 Jun 2019 13:45:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 7E9C81A4651;
 Wed, 26 Jun 2019 13:45:56 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Wed, 26 Jun 2019 13:45:36 +0200
Message-Id: <1561549550-3501-4-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561549550-3501-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1561549550-3501-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PULL 03/17] hw/mips/gt64xxx_pci: Fix 'braces' coding
 style issues
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

Since we'll move this code around, fix its style first:

  ERROR: braces {} are necessary for all arms of this statement

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Message-Id: <20190624222844.26584-4-f4bug@amsat.org>
---
 hw/mips/gt64xxx_pci.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/hw/mips/gt64xxx_pci.c b/hw/mips/gt64xxx_pci.c
index bbd719f..cfd4979 100644
--- a/hw/mips/gt64xxx_pci.c
+++ b/hw/mips/gt64xxx_pci.c
@@ -257,19 +257,25 @@ static void check_reserved_space(hwaddr *start, hwa=
ddr *length)
     hwaddr begin =3D *start;
     hwaddr end =3D *start + *length;
=20
-    if (end >=3D 0x1e000000LL && end < 0x1f100000LL)
+    if (end >=3D 0x1e000000LL && end < 0x1f100000LL) {
         end =3D 0x1e000000LL;
-    if (begin >=3D 0x1e000000LL && begin < 0x1f100000LL)
+    }
+    if (begin >=3D 0x1e000000LL && begin < 0x1f100000LL) {
         begin =3D 0x1f100000LL;
-    if (end >=3D 0x1fc00000LL && end < 0x1fd00000LL)
+    }
+    if (end >=3D 0x1fc00000LL && end < 0x1fd00000LL) {
         end =3D 0x1fc00000LL;
-    if (begin >=3D 0x1fc00000LL && begin < 0x1fd00000LL)
+    }
+    if (begin >=3D 0x1fc00000LL && begin < 0x1fd00000LL) {
         begin =3D 0x1fd00000LL;
+    }
     /* XXX: This is broken when a reserved range splits the requested ra=
nge */
-    if (end >=3D 0x1f100000LL && begin < 0x1e000000LL)
+    if (end >=3D 0x1f100000LL && begin < 0x1e000000LL) {
         end =3D 0x1e000000LL;
-    if (end >=3D 0x1fd00000LL && begin < 0x1fc00000LL)
+    }
+    if (end >=3D 0x1fd00000LL && begin < 0x1fc00000LL) {
         end =3D 0x1fc00000LL;
+    }
=20
     *start =3D begin;
     *length =3D end - begin;
@@ -385,8 +391,9 @@ static void gt64120_writel (void *opaque, hwaddr addr=
,
     PCIHostState *phb =3D PCI_HOST_BRIDGE(s);
     uint32_t saddr;
=20
-    if (!(s->regs[GT_CPU] & 0x00001000))
+    if (!(s->regs[GT_CPU] & 0x00001000)) {
         val =3D bswap32(val);
+    }
=20
     saddr =3D (addr & 0xfff) >> 2;
     switch (saddr) {
@@ -937,8 +944,9 @@ static uint64_t gt64120_readl (void *opaque,
         break;
     }
=20
-    if (!(s->regs[GT_CPU] & 0x00001000))
+    if (!(s->regs[GT_CPU] & 0x00001000)) {
         val =3D bswap32(val);
+    }
=20
     return val;
 }
@@ -990,8 +998,9 @@ static void gt64120_pci_set_irq(void *opaque, int irq=
_num, int level)
         /* The pic level is the logical OR of all the PCI irqs mapped to=
 it. */
         pic_level =3D 0;
         for (i =3D 0; i < 4; i++) {
-            if (pic_irq =3D=3D piix4_dev->config[0x60 + i])
+            if (pic_irq =3D=3D piix4_dev->config[0x60 + i]) {
                 pic_level |=3D pci_irq_levels[i];
+            }
         }
         qemu_set_irq(pic[pic_irq], pic_level);
     }
--=20
2.7.4


