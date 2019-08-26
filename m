Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E81BC3A59F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 14:37:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F54D20874
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 14:37:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F54D20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2G7a-0002Sh-Vt
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 10:37:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42768)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tony.nguyen@bt.com>) id 1i2Fpo-0004X0-BP
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 10:19:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen@bt.com>) id 1i2Fpm-0000Ju-QU
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 10:19:04 -0400
Received: from nsstlmta18p.bpe.bigpond.com ([203.38.21.18]:34232)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tony.nguyen@bt.com>)
 id 1i2Fpl-00008j-T3; Mon, 26 Aug 2019 10:19:02 -0400
Received: from smtp.telstra.com ([10.10.24.4])
 by nsstlfep18p-svc.bpe.nexus.telstra.com.au with ESMTP id
 <20190826141857.DCXX10803.nsstlfep18p-svc.bpe.nexus.telstra.com.au@smtp.telstra.com>;
 Tue, 27 Aug 2019 00:18:57 +1000
X-RG-Spam: Unknown
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduvddrudehgedgjeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuuffpveftpgfvgffnuffvtfetpdfqfgfvnecuuegrihhlohhuthemucegtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhonhihucfpghhuhigvnhcuoehtohhnhidrnhhguhihvghnsegsthdrtghomheqnecukfhppeehkedrudejfedrleekrdeikeenucfrrghrrghmpehhvghlohepuggsiidrthgvlhhsthhrrgdrtghomhdrrghupdhinhgvthepheekrddujeefrdelkedrieekpdhmrghilhhfrhhomhepoehtohhnhidrnhhguhihvghnsegsthdrtghomheqpdhrtghpthhtohepoegvughgrghrrdhighhlvghsihgrshesghhmrghilhdrtghomheqpdhrtghpthhtohepoehggihtsehmphhrtgdrphhkuhdrvgguuhdrtghnqedprhgtphhtthhopeeomhgrrhhkrdgtrghvvgdqrgihlhgrnhgusehilhgrnhguvgdrtghordhukheqpdhrtghpthhtohepoehpvghtvghrrdgthhhusggssehnihgtthgrrdgtohhmrdgruheqpdhrtghpthhtohepoehpvghtvghrrdhmrgihuggvlhhlsehlihhnrghrohdrohhrgheqpdhrtghpthhtohepoehqvghmuhdqrghrmhesnhhonhhgnhhurdhorhhgqedprhgtphhtthhopeeoqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgheqpdhrtghp
 thhtohepoehtohhnhidrnhhguhihvghnsegsthdrtghomheqnecuvehluhhsthgvrhfuihiivgeptd
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RG-VS-CLASS: clean
X-Authentication-Info: Submitted using ID tony.nguyen.git@bigpond.com
Received: from dbz.telstra.com.au (58.173.98.68) by smtp.telstra.com (5.8.335)
 (authenticated as tony.nguyen.git@bigpond.com)
 id 5D3581440DDB0FB8; Tue, 27 Aug 2019 00:18:56 +1000
From: Tony Nguyen <tony.nguyen@bt.com>
To: qemu-devel@nongnu.org
Date: Tue, 27 Aug 2019 00:21:36 +1000
Message-Id: <554a2f98479cd6dbf0d0a1c019fe728b0902d0de.1566829168.git.tony.nguyen@bt.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1566829168.git.tony.nguyen@bt.com>
References: <cover.1566829168.git.tony.nguyen@bt.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 203.38.21.18
Subject: [Qemu-devel] [PATCH 10/19] hw/intc: Declare device little or big
 endian
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
Cc: Tony Nguyen <tony.nguyen@bt.com>, Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For each device declared with DEVICE_NATIVE_ENDIAN, find the set of
targets from the set of target/hw/*/device.o.

If the set of targets are all little or all big endian, re-declare
as DEVICE_LITTLE_ENDIAN or DEVICE_BIG_ENDIAN respectively.

Then, on inspection:
- if not used, re-declare as DEVICE_HOST_ENDIAN.
- if max/min size=1, re-declare as DEVICE_HOST_ENDIAN.
- if just a bit bucket, re-declare as DEVICE_HOST_ENDIAN
- if PCI, re-declare as DEVICE_LITTLE_ENDIAN.
- if for {ARM|unicore32} only, re-declare as DEVICE_LITTLE_ENDIAN.
- if for SPARC only, re-declare as DEVICE_BIG_ENDIAN.

Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
---
 hw/intc/arm_gic.c              | 12 ++++++------
 hw/intc/arm_gicv3.c            |  4 ++--
 hw/intc/arm_gicv3_its_common.c |  2 +-
 hw/intc/etraxfs_pic.c          |  2 +-
 hw/intc/imx_avic.c             |  2 +-
 hw/intc/imx_gpcv2.c            |  2 +-
 hw/intc/pl190.c                |  2 +-
 hw/intc/puv3_intc.c            |  2 +-
 hw/intc/slavio_intctl.c        |  4 ++--
 9 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index 1d7da7baa2..009933952c 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -2000,38 +2000,38 @@ static const MemoryRegionOps gic_ops[2] = {
     {
         .read_with_attrs = gic_dist_read,
         .write_with_attrs = gic_dist_write,
-        .endianness = DEVICE_NATIVE_ENDIAN,
+        .endianness = DEVICE_LITTLE_ENDIAN,
     },
     {
         .read_with_attrs = gic_thiscpu_read,
         .write_with_attrs = gic_thiscpu_write,
-        .endianness = DEVICE_NATIVE_ENDIAN,
+        .endianness = DEVICE_LITTLE_ENDIAN,
     }
 };
 
 static const MemoryRegionOps gic_cpu_ops = {
     .read_with_attrs = gic_do_cpu_read,
     .write_with_attrs = gic_do_cpu_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static const MemoryRegionOps gic_virt_ops[2] = {
     {
         .read_with_attrs = gic_thiscpu_hyp_read,
         .write_with_attrs = gic_thiscpu_hyp_write,
-        .endianness = DEVICE_NATIVE_ENDIAN,
+        .endianness = DEVICE_LITTLE_ENDIAN,
     },
     {
         .read_with_attrs = gic_thisvcpu_read,
         .write_with_attrs = gic_thisvcpu_write,
-        .endianness = DEVICE_NATIVE_ENDIAN,
+        .endianness = DEVICE_LITTLE_ENDIAN,
     }
 };
 
 static const MemoryRegionOps gic_viface_ops = {
     .read_with_attrs = gic_do_hyp_read,
     .write_with_attrs = gic_do_hyp_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static void arm_gic_realize(DeviceState *dev, Error **errp)
diff --git a/hw/intc/arm_gicv3.c b/hw/intc/arm_gicv3.c
index 66eaa97198..9b4d5bad69 100644
--- a/hw/intc/arm_gicv3.c
+++ b/hw/intc/arm_gicv3.c
@@ -352,12 +352,12 @@ static const MemoryRegionOps gic_ops[] = {
     {
         .read_with_attrs = gicv3_dist_read,
         .write_with_attrs = gicv3_dist_write,
-        .endianness = DEVICE_NATIVE_ENDIAN,
+        .endianness = DEVICE_LITTLE_ENDIAN,
     },
     {
         .read_with_attrs = gicv3_redist_read,
         .write_with_attrs = gicv3_redist_write,
-        .endianness = DEVICE_NATIVE_ENDIAN,
+        .endianness = DEVICE_LITTLE_ENDIAN,
     }
 };
 
diff --git a/hw/intc/arm_gicv3_its_common.c b/hw/intc/arm_gicv3_its_common.c
index 66c4c6a188..97ff537bf1 100644
--- a/hw/intc/arm_gicv3_its_common.c
+++ b/hw/intc/arm_gicv3_its_common.c
@@ -96,7 +96,7 @@ static MemTxResult gicv3_its_trans_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps gicv3_its_trans_ops = {
     .read_with_attrs = gicv3_its_trans_read,
     .write_with_attrs = gicv3_its_trans_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 void gicv3_its_init_mmio(GICv3ITSState *s, const MemoryRegionOps *ops)
diff --git a/hw/intc/etraxfs_pic.c b/hw/intc/etraxfs_pic.c
index 77f652acec..5895b671b1 100644
--- a/hw/intc/etraxfs_pic.c
+++ b/hw/intc/etraxfs_pic.c
@@ -112,7 +112,7 @@ static void pic_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps pic_ops = {
     .read = pic_read,
     .write = pic_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4
diff --git a/hw/intc/imx_avic.c b/hw/intc/imx_avic.c
index 63fc602a1a..15ed512e86 100644
--- a/hw/intc/imx_avic.c
+++ b/hw/intc/imx_avic.c
@@ -310,7 +310,7 @@ static void imx_avic_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps imx_avic_ops = {
     .read = imx_avic_read,
     .write = imx_avic_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static void imx_avic_reset(DeviceState *dev)
diff --git a/hw/intc/imx_gpcv2.c b/hw/intc/imx_gpcv2.c
index 17007a4078..3df4a443b8 100644
--- a/hw/intc/imx_gpcv2.c
+++ b/hw/intc/imx_gpcv2.c
@@ -65,7 +65,7 @@ static void imx_gpcv2_write(void *opaque, hwaddr offset,
 static const struct MemoryRegionOps imx_gpcv2_ops = {
     .read = imx_gpcv2_read,
     .write = imx_gpcv2_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .impl = {
         /*
          * Our device would not work correctly if the guest was doing
diff --git a/hw/intc/pl190.c b/hw/intc/pl190.c
index e3bd3dd121..1b474d25b9 100644
--- a/hw/intc/pl190.c
+++ b/hw/intc/pl190.c
@@ -222,7 +222,7 @@ static void pl190_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps pl190_ops = {
     .read = pl190_read,
     .write = pl190_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static void pl190_reset(DeviceState *d)
diff --git a/hw/intc/puv3_intc.c b/hw/intc/puv3_intc.c
index e018955ce8..1c8ddbd70d 100644
--- a/hw/intc/puv3_intc.c
+++ b/hw/intc/puv3_intc.c
@@ -101,7 +101,7 @@ static const MemoryRegionOps puv3_intc_ops = {
         .min_access_size = 4,
         .max_access_size = 4,
     },
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static void puv3_intc_realize(DeviceState *dev, Error **errp)
diff --git a/hw/intc/slavio_intctl.c b/hw/intc/slavio_intctl.c
index c4cf9096eb..d12e10374c 100644
--- a/hw/intc/slavio_intctl.c
+++ b/hw/intc/slavio_intctl.c
@@ -136,7 +136,7 @@ static void slavio_intctl_mem_writel(void *opaque, hwaddr addr,
 static const MemoryRegionOps slavio_intctl_mem_ops = {
     .read = slavio_intctl_mem_readl,
     .write = slavio_intctl_mem_writel,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_BIG_ENDIAN,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
@@ -206,7 +206,7 @@ static void slavio_intctlm_mem_writel(void *opaque, hwaddr addr,
 static const MemoryRegionOps slavio_intctlm_mem_ops = {
     .read = slavio_intctlm_mem_readl,
     .write = slavio_intctlm_mem_writel,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_BIG_ENDIAN,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
-- 
2.23.0


