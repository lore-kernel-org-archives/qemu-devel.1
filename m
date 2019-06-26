Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FDFDC48BD6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 11:54:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB64420663
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 11:54:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB64420663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg6Uz-0007Sg-8I
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 07:54:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43763)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hg6NR-0001cV-PR
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 07:46:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hg6NQ-0006MW-1Z
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 07:46:13 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:60764 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1hg6NP-0005tJ-LA
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 07:46:11 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id C33F91A46A8;
 Wed, 26 Jun 2019 13:45:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 9A3E91A469C;
 Wed, 26 Jun 2019 13:45:56 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Wed, 26 Jun 2019 13:45:39 +0200
Message-Id: <1561549550-3501-7-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561549550-3501-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1561549550-3501-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PULL 06/17] hw/mips/gt64xxx_pci: Convert debug
 printf()s to trace events
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
Message-Id: <20190624222844.26584-7-f4bug@amsat.org>
---
 Makefile.objs         |  1 +
 hw/mips/gt64xxx_pci.c | 29 ++++++++++-------------------
 hw/mips/trace-events  |  4 ++++
 3 files changed, 15 insertions(+), 19 deletions(-)
 create mode 100644 hw/mips/trace-events

diff --git a/Makefile.objs b/Makefile.objs
index 658cfc9..3b83621 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -163,6 +163,7 @@ trace-events-subdirs +=3D hw/input
 trace-events-subdirs +=3D hw/intc
 trace-events-subdirs +=3D hw/isa
 trace-events-subdirs +=3D hw/mem
+trace-events-subdirs +=3D hw/mips
 trace-events-subdirs +=3D hw/misc
 trace-events-subdirs +=3D hw/misc/macio
 trace-events-subdirs +=3D hw/net
diff --git a/hw/mips/gt64xxx_pci.c b/hw/mips/gt64xxx_pci.c
index f44326f..815ef07 100644
--- a/hw/mips/gt64xxx_pci.c
+++ b/hw/mips/gt64xxx_pci.c
@@ -30,14 +30,7 @@
 #include "hw/pci/pci_host.h"
 #include "hw/i386/pc.h"
 #include "exec/address-spaces.h"
-
-//#define DEBUG
-
-#ifdef DEBUG
-#define DPRINTF(fmt, ...) fprintf(stderr, "%s: " fmt, __func__, ##__VA_A=
RGS__)
-#else
-#define DPRINTF(fmt, ...)
-#endif
+#include "trace.h"
=20
 #define GT_REGS                 (0x1000 >> 2)
=20
@@ -294,9 +287,7 @@ static void gt64120_isd_mapping(GT64120State *s)
     check_reserved_space(&start, &length);
     length =3D 0x1000;
     /* Map new address */
-    DPRINTF("ISD: "TARGET_FMT_plx"@"TARGET_FMT_plx
-        " -> "TARGET_FMT_plx"@"TARGET_FMT_plx"\n",
-        s->ISD_length, s->ISD_start, length, start);
+    trace_gt64120_isd_remap(s->ISD_length, s->ISD_start, length, start);
     s->ISD_start =3D start;
     s->ISD_length =3D length;
     memory_region_add_subregion(get_system_memory(), s->ISD_start, &s->I=
SD_mem);
@@ -648,19 +639,19 @@ static void gt64120_writel(void *opaque, hwaddr add=
r,
         /* not really implemented */
         s->regs[saddr] =3D ~(~(s->regs[saddr]) | ~(val & 0xfffffffe));
         s->regs[saddr] |=3D !!(s->regs[saddr] & 0xfffffffe);
-        DPRINTF("INTRCAUSE %" PRIx64 "\n", val);
+        trace_gt64120_write("INTRCAUSE", size << 1, val);
         break;
     case GT_INTRMASK:
         s->regs[saddr] =3D val & 0x3c3ffffe;
-        DPRINTF("INTRMASK %" PRIx64 "\n", val);
+        trace_gt64120_write("INTRMASK", size << 1, val);
         break;
     case GT_PCI0_ICMASK:
         s->regs[saddr] =3D val & 0x03fffffe;
-        DPRINTF("ICMASK %" PRIx64 "\n", val);
+        trace_gt64120_write("ICMASK", size << 1, val);
         break;
     case GT_PCI0_SERR0MASK:
         s->regs[saddr] =3D val & 0x0000003f;
-        DPRINTF("SERR0MASK %" PRIx64 "\n", val);
+        trace_gt64120_write("SERR0MASK", size << 1, val);
         break;
=20
     /* Reserved when only PCI_0 is configured. */
@@ -936,19 +927,19 @@ static uint64_t gt64120_readl(void *opaque,
     /* Interrupts */
     case GT_INTRCAUSE:
         val =3D s->regs[saddr];
-        DPRINTF("INTRCAUSE %x\n", val);
+        trace_gt64120_read("INTRCAUSE", size << 1, val);
         break;
     case GT_INTRMASK:
         val =3D s->regs[saddr];
-        DPRINTF("INTRMASK %x\n", val);
+        trace_gt64120_read("INTRMASK", size << 1, val);
         break;
     case GT_PCI0_ICMASK:
         val =3D s->regs[saddr];
-        DPRINTF("ICMASK %x\n", val);
+        trace_gt64120_read("ICMASK", size << 1, val);
         break;
     case GT_PCI0_SERR0MASK:
         val =3D s->regs[saddr];
-        DPRINTF("SERR0MASK %x\n", val);
+        trace_gt64120_read("SERR0MASK", size << 1, val);
         break;
=20
     /* Reserved when only PCI_0 is configured. */
diff --git a/hw/mips/trace-events b/hw/mips/trace-events
new file mode 100644
index 0000000..75d4c73
--- /dev/null
+++ b/hw/mips/trace-events
@@ -0,0 +1,4 @@
+# gt64xxx.c
+gt64120_read(const char *regname, int width, uint64_t value) "gt64120 re=
ad %s value:0x%0*" PRIx64
+gt64120_write(const char *regname, int width, uint64_t value) "gt64120 w=
rite %s value:0x%0*" PRIx64
+gt64120_isd_remap(uint64_t from_length, uint64_t from_addr, uint64_t to_=
length, uint64_t to_addr) "ISD: 0x%08" PRIx64 "@0x%08" PRIx64 " -> 0x%08"=
 PRIx64 "@0x%08" PRIx64
--=20
2.7.4


