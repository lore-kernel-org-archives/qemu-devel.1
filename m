Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11941C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:29:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA7ED20730
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:29:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA7ED20730
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izfLt-0000Lf-3O
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 06:29:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38454)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1izfJN-0005aK-Dd
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:27:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1izfJL-0007nL-Q0
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:27:09 -0500
Received: from 5.mo6.mail-out.ovh.net ([46.105.54.31]:49320)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1izfJL-0007jn-Je
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:27:07 -0500
Received: from player788.ha.ovh.net (unknown [10.108.35.215])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id 760691FD294
 for <qemu-devel@nongnu.org>; Thu,  6 Feb 2020 12:27:05 +0100 (CET)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player788.ha.ovh.net (Postfix) with ESMTPSA id AB865F1A6D58;
 Thu,  6 Feb 2020 11:26:56 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 1/2] aspeed/smc: Add some tracing
Date: Thu,  6 Feb 2020 12:26:44 +0100
Message-Id: <20200206112645.21275-2-clg@kaod.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200206112645.21275-1-clg@kaod.org>
References: <20200206112645.21275-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 17872816598246394641
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrheefgddviecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeevrogurhhitgcunfgvucfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrieegrddvhedtrddujedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeekkedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.54.31
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Andrew Geissler <geissonator@gmail.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 Makefile.objs       |  1 +
 hw/ssi/aspeed_smc.c | 17 +++++++++++++++++
 hw/ssi/trace-events |  9 +++++++++
 3 files changed, 27 insertions(+)
 create mode 100644 hw/ssi/trace-events

diff --git a/Makefile.objs b/Makefile.objs
index 26b9cff95436..9e4ba95794e9 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -168,6 +168,7 @@ trace-events-subdirs +=3D hw/scsi
 trace-events-subdirs +=3D hw/sd
 trace-events-subdirs +=3D hw/sparc
 trace-events-subdirs +=3D hw/sparc64
+trace-events-subdirs +=3D hw/ssi
 trace-events-subdirs +=3D hw/timer
 trace-events-subdirs +=3D hw/tpm
 trace-events-subdirs +=3D hw/usb
diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index 23c8d2f06245..e5621bf728ca 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -31,6 +31,7 @@
 #include "qapi/error.h"
 #include "exec/address-spaces.h"
 #include "qemu/units.h"
+#include "trace.h"
=20
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
@@ -513,6 +514,8 @@ static void aspeed_smc_flash_set_segment(AspeedSMCSta=
te *s, int cs,
=20
     s->ctrl->reg_to_segment(s, new, &seg);
=20
+    trace_aspeed_smc_flash_set_segment(cs, new, seg.addr, seg.addr + seg=
.size);
+
     /* The start address of CS0 is read-only */
     if (cs =3D=3D 0 && seg.addr !=3D s->ctrl->flash_window_base) {
         qemu_log_mask(LOG_GUEST_ERROR,
@@ -753,6 +756,8 @@ static uint64_t aspeed_smc_flash_read(void *opaque, h=
waddr addr, unsigned size)
                       __func__, aspeed_smc_flash_mode(fl));
     }
=20
+    trace_aspeed_smc_flash_read(fl->id, addr, size, ret,
+                                aspeed_smc_flash_mode(fl));
     return ret;
 }
=20
@@ -808,6 +813,9 @@ static bool aspeed_smc_do_snoop(AspeedSMCFlash *fl,  =
uint64_t data,
     AspeedSMCState *s =3D fl->controller;
     uint8_t addr_width =3D aspeed_smc_flash_is_4byte(fl) ? 4 : 3;
=20
+    trace_aspeed_smc_do_snoop(fl->id, s->snoop_index, s->snoop_dummies,
+                              (uint8_t) data & 0xff);
+
     if (s->snoop_index =3D=3D SNOOP_OFF) {
         return false; /* Do nothing */
=20
@@ -858,6 +866,9 @@ static void aspeed_smc_flash_write(void *opaque, hwad=
dr addr, uint64_t data,
     AspeedSMCState *s =3D fl->controller;
     int i;
=20
+    trace_aspeed_smc_flash_write(fl->id, addr, size, data,
+                                 aspeed_smc_flash_mode(fl));
+
     if (!aspeed_smc_is_writable(fl)) {
         qemu_log_mask(LOG_GUEST_ERROR, "%s: flash is not writable at 0x%=
"
                       HWADDR_PRIx "\n", __func__, addr);
@@ -972,6 +983,9 @@ static uint64_t aspeed_smc_read(void *opaque, hwaddr =
addr, unsigned int size)
         (s->ctrl->has_dma && addr =3D=3D R_DMA_CHECKSUM) ||
         (addr >=3D R_SEG_ADDR0 && addr < R_SEG_ADDR0 + s->ctrl->max_slav=
es) ||
         (addr >=3D s->r_ctrl0 && addr < s->r_ctrl0 + s->ctrl->max_slaves=
)) {
+
+        trace_aspeed_smc_read(addr, size, s->regs[addr]);
+
         return s->regs[addr];
     } else {
         qemu_log_mask(LOG_UNIMP, "%s: not implemented: 0x%" HWADDR_PRIx =
"\n",
@@ -1091,6 +1105,7 @@ static void aspeed_smc_dma_checksum(AspeedSMCState =
*s)
                           __func__, s->regs[R_DMA_FLASH_ADDR]);
             return;
         }
+        trace_aspeed_smc_dma_checksum(s->regs[R_DMA_FLASH_ADDR], data);
=20
         /*
          * When the DMA is on-going, the DMA registers are updated
@@ -1225,6 +1240,8 @@ static void aspeed_smc_write(void *opaque, hwaddr a=
ddr, uint64_t data,
=20
     addr >>=3D 2;
=20
+    trace_aspeed_smc_write(addr, size, data);
+
     if (addr =3D=3D s->r_conf ||
         (addr >=3D s->r_timings &&
          addr < s->r_timings + s->ctrl->nregs_timings) ||
diff --git a/hw/ssi/trace-events b/hw/ssi/trace-events
new file mode 100644
index 000000000000..ffe531a500aa
--- /dev/null
+++ b/hw/ssi/trace-events
@@ -0,0 +1,9 @@
+# aspeed_smc.c
+
+aspeed_smc_flash_set_segment(int cs, uint64_t reg, uint64_t start, uint6=
4_t end) "CS%d segreg=3D0x%"PRIx64" [ 0x%"PRIx64" - 0x%"PRIx64" ]"
+aspeed_smc_flash_read(int cs, uint64_t addr,  uint32_t size, uint64_t da=
ta, int mode) "CS%d @0x%" PRIx64 " size %u: 0x%" PRIx64" mode:%d"
+aspeed_smc_do_snoop(int cs, int index, int dummies, int data) "CS%d inde=
x:0x%x dummies:%d data:0x%x"
+aspeed_smc_flash_write(int cs, uint64_t addr,  uint32_t size, uint64_t d=
ata, int mode) "CS%d @0x%" PRIx64 " size %u: 0x%" PRIx64" mode:%d"
+aspeed_smc_read(uint64_t addr,  uint32_t size, uint64_t data) "@0x%" PRI=
x64 " size %u: 0x%" PRIx64
+aspeed_smc_dma_checksum(uint32_t addr, uint32_t data) "0x%08x: 0x%08x"
+aspeed_smc_write(uint64_t addr,  uint32_t size, uint64_t data) "@0x%" PR=
Ix64 " size %u: 0x%" PRIx64
--=20
2.21.1


