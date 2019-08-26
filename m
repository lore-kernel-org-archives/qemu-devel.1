Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0419C3A59F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 14:30:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E0DB2173E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 14:30:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E0DB2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2G0X-0005IC-78
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 10:30:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42620)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tony.nguyen@bt.com>) id 1i2FpY-0004OD-1l
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 10:18:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen@bt.com>) id 1i2FpW-0008MA-3e
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 10:18:47 -0400
Received: from nsstlmta35p.bpe.bigpond.com ([203.38.21.35]:50794)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tony.nguyen@bt.com>)
 id 1i2FpU-0008HU-R4; Mon, 26 Aug 2019 10:18:45 -0400
Received: from smtp.telstra.com ([10.10.24.4])
 by nsstlfep35p-svc.bpe.nexus.telstra.com.au with ESMTP id
 <20190826141839.CMQF29150.nsstlfep35p-svc.bpe.nexus.telstra.com.au@smtp.telstra.com>;
 Tue, 27 Aug 2019 00:18:39 +1000
X-RG-Spam: Unknown
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduvddrudehgedgjeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuuffpveftpgfvgffnuffvtfetpdfqfgfvnecuuegrihhlohhuthemucegtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhonhihucfpghhuhigvnhcuoehtohhnhidrnhhguhihvghnsegsthdrtghomheqnecukfhppeehkedrudejfedrleekrdeikeenucfrrghrrghmpehhvghlohepuggsiidrthgvlhhsthhrrgdrtghomhdrrghupdhinhgvthepheekrddujeefrdelkedrieekpdhmrghilhhfrhhomhepoehtohhnhidrnhhguhihvghnsegsthdrtghomheqpdhrtghpthhtohepoeetnhgurhgvfidruegruhhmrghnnhesmhhitghrohhsohhfthdrtghomheqpdhrtghpthhtohepoegvughgrghrrdhighhlvghsihgrshesghhmrghilhdrtghomheqpdhrtghpthhtohepoehfgegsuhhgsegrmhhsrghtrdhorhhgqedprhgtphhtthhopeeoghigthesmhhprhgtrdhpkhhurdgvughurdgtnheqpdhrtghpthhtohepoehmrghrkhdrtggrvhgvqdgrhihlrghnugesihhlrghnuggvrdgtohdruhhkqedprhgtphhtthhopeeomhhsthesrhgvughhrghtrdgtohhmqedprhgtphhtthhopeeophgsohhniihinhhisehrvgguhhgrthdrtghomheqpdhrtghpthhtohepoehpvghtvghrrdhm
 rgihuggvlhhlsehlihhnrghrohdrohhrgheqpdhrtghpthhtohepoehqvghmuhdqrghrmhesnhhonhhgnhhurdhorhhgqedprhgtphhtthhopeeoqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgheqpdhrtghpthhtohepoehtohhnhidrnhhguhihvghnsegsthdrtghomheqnecuvehluhhsthgvrhfuihiivgeptd
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RG-VS-CLASS: clean
X-Authentication-Info: Submitted using ID tony.nguyen.git@bigpond.com
Received: from dbz.telstra.com.au (58.173.98.68) by smtp.telstra.com (5.8.335)
 (authenticated as tony.nguyen.git@bigpond.com)
 id 5D2D117510588E84; Tue, 27 Aug 2019 00:18:38 +1000
From: Tony Nguyen <tony.nguyen@bt.com>
To: qemu-devel@nongnu.org
Date: Tue, 27 Aug 2019 00:21:32 +1000
Message-Id: <d62f14ca4a1bb5ea586a819d249000acb85853ce.1566829168.git.tony.nguyen@bt.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1566829168.git.tony.nguyen@bt.com>
References: <cover.1566829168.git.tony.nguyen@bt.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 203.38.21.35
Subject: [Qemu-devel] [PATCH 06/19] hw/dma: Declare device little or big
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
Cc: Tony Nguyen <tony.nguyen@bt.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
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
 hw/dma/bcm2835_dma.c |  4 ++--
 hw/dma/etraxfs_dma.c | 14 +++++++-------
 hw/dma/i8257.c       |  4 ++--
 hw/dma/pl080.c       |  2 +-
 hw/dma/pl330.c       |  2 +-
 hw/dma/puv3_dma.c    |  2 +-
 hw/dma/sparc32_dma.c |  2 +-
 7 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/hw/dma/bcm2835_dma.c b/hw/dma/bcm2835_dma.c
index 192bd377a0..550e67f686 100644
--- a/hw/dma/bcm2835_dma.c
+++ b/hw/dma/bcm2835_dma.c
@@ -290,7 +290,7 @@ static void bcm2835_dma15_write(void *opaque, hwaddr offset, uint64_t value,
 static const MemoryRegionOps bcm2835_dma0_ops = {
     .read = bcm2835_dma0_read,
     .write = bcm2835_dma0_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .valid.min_access_size = 4,
     .valid.max_access_size = 4,
 };
@@ -298,7 +298,7 @@ static const MemoryRegionOps bcm2835_dma0_ops = {
 static const MemoryRegionOps bcm2835_dma15_ops = {
     .read = bcm2835_dma15_read,
     .write = bcm2835_dma15_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .valid.min_access_size = 4,
     .valid.max_access_size = 4,
 };
diff --git a/hw/dma/etraxfs_dma.c b/hw/dma/etraxfs_dma.c
index 47e1c6df12..ee3b92437a 100644
--- a/hw/dma/etraxfs_dma.c
+++ b/hw/dma/etraxfs_dma.c
@@ -698,13 +698,13 @@ dma_write(void *opaque, hwaddr addr,
 }
 
 static const MemoryRegionOps dma_ops = {
-	.read = dma_read,
-	.write = dma_write,
-	.endianness = DEVICE_NATIVE_ENDIAN,
-	.valid = {
-		.min_access_size = 1,
-		.max_access_size = 4
-	}
+    .read = dma_read,
+    .write = dma_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4
+    }
 };
 
 static int etraxfs_dmac_run(void *opaque)
diff --git a/hw/dma/i8257.c b/hw/dma/i8257.c
index 792f617eb4..e68736fa44 100644
--- a/hw/dma/i8257.c
+++ b/hw/dma/i8257.c
@@ -476,7 +476,7 @@ static int i8257_phony_handler(void *opaque, int nchan, int dma_pos,
 static const MemoryRegionOps channel_io_ops = {
     .read = i8257_read_chan,
     .write = i8257_write_chan,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_HOST_ENDIAN,
     .impl = {
         .min_access_size = 1,
         .max_access_size = 1,
@@ -500,7 +500,7 @@ static const MemoryRegionPortio pageh_portio_list[] = {
 static const MemoryRegionOps cont_io_ops = {
     .read = i8257_read_cont,
     .write = i8257_write_cont,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_HOST_ENDIAN,
     .impl = {
         .min_access_size = 1,
         .max_access_size = 1,
diff --git a/hw/dma/pl080.c b/hw/dma/pl080.c
index 52ba23f4bf..cbdd1849cd 100644
--- a/hw/dma/pl080.c
+++ b/hw/dma/pl080.c
@@ -350,7 +350,7 @@ static void pl080_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps pl080_ops = {
     .read = pl080_read,
     .write = pl080_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static void pl080_reset(DeviceState *dev)
diff --git a/hw/dma/pl330.c b/hw/dma/pl330.c
index f2bb2d9ac1..a9216680ef 100644
--- a/hw/dma/pl330.c
+++ b/hw/dma/pl330.c
@@ -1496,7 +1496,7 @@ static uint64_t pl330_iomem_read(void *opaque, hwaddr offset,
 static const MemoryRegionOps pl330_ops = {
     .read = pl330_iomem_read,
     .write = pl330_iomem_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .impl = {
         .min_access_size = 4,
         .max_access_size = 4,
diff --git a/hw/dma/puv3_dma.c b/hw/dma/puv3_dma.c
index 5488d388a9..1577056715 100644
--- a/hw/dma/puv3_dma.c
+++ b/hw/dma/puv3_dma.c
@@ -74,7 +74,7 @@ static const MemoryRegionOps puv3_dma_ops = {
         .min_access_size = 4,
         .max_access_size = 4,
     },
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static void puv3_dma_realize(DeviceState *dev, Error **errp)
diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
index 0e5bbcdc7f..bf76f2e558 100644
--- a/hw/dma/sparc32_dma.c
+++ b/hw/dma/sparc32_dma.c
@@ -226,7 +226,7 @@ static void dma_mem_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps dma_mem_ops = {
     .read = dma_mem_read,
     .write = dma_mem_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_BIG_ENDIAN,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
-- 
2.23.0


