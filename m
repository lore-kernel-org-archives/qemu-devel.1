Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD2FC3A5A4
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 14:44:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B39C420874
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 14:44:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B39C420874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2GEf-0000mY-JH
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 10:44:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42913)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tony.nguyen@bt.com>) id 1i2FqD-0004cj-2Q
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 10:19:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen@bt.com>) id 1i2FqB-0000mh-0g
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 10:19:28 -0400
Received: from nsstlmta09p.bpe.bigpond.com ([203.38.21.9]:36335)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tony.nguyen@bt.com>)
 id 1i2Fq9-0000hk-Mh; Mon, 26 Aug 2019 10:19:26 -0400
Received: from smtp.telstra.com ([10.10.24.4])
 by nsstlfep09p-svc.bpe.nexus.telstra.com.au with ESMTP id
 <20190826141919.NTWB7749.nsstlfep09p-svc.bpe.nexus.telstra.com.au@smtp.telstra.com>;
 Tue, 27 Aug 2019 00:19:19 +1000
X-RG-Spam: Unknown
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduvddrudehgedgjeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuuffpveftpgfvgffnuffvtfetpdfqfgfvnecuuegrihhlohhuthemucegtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhonhihucfpghhuhigvnhcuoehtohhnhidrnhhguhihvghnsegsthdrtghomheqnecukfhppeehkedrudejfedrleekrdeikeenucfrrghrrghmpehhvghlohepuggsiidrthgvlhhsthhrrgdrtghomhdrrghupdhinhgvthepheekrddujeefrdelkedrieekpdhmrghilhhfrhhomhepoehtohhnhidrnhhguhihvghnsegsthdrtghomheqpdhrtghpthhtohepoegrmhgrrhhkohhvihgtseifrghvvggtohhmphdrtghomheqpdhrtghpthhtohepoegrrhhikhgrlhhoseifrghvvggtohhmphdrtghomheqpdhrtghpthhtohepoehmrghrtggvlhdrrghpfhgvlhgsrghumhesghhmrghilhdrtghomheqpdhrtghpthhtohepoehmshhtsehrvgguhhgrthdrtghomheqpdhrtghpthhtohepoehpvghtvghrrdhmrgihuggvlhhlsehlihhnrghrohdrohhrgheqpdhrtghpthhtohepoehqvghmuhdqrghrmhesnhhonhhgnhhurdhorhhgqedprhgtphhtthhopeeoqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgheqpdhrtghpthhtohepoehtohhnhidrnhhguhih
 vghnsegsthdrtghomheqnecuvehluhhsthgvrhfuihiivgeptd
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RG-VS-CLASS: clean
X-Authentication-Info: Submitted using ID tony.nguyen.git@bigpond.com
Received: from dbz.telstra.com.au (58.173.98.68) by smtp.telstra.com (5.8.335)
 (authenticated as tony.nguyen.git@bigpond.com)
 id 5D3692920D8AE225; Tue, 27 Aug 2019 00:19:19 +1000
From: Tony Nguyen <tony.nguyen@bt.com>
To: qemu-devel@nongnu.org
Date: Tue, 27 Aug 2019 00:21:41 +1000
Message-Id: <87cd1574f808550f03e784f327245dc5c0afa061.1566829168.git.tony.nguyen@bt.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1566829168.git.tony.nguyen@bt.com>
References: <cover.1566829168.git.tony.nguyen@bt.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 203.38.21.9
Subject: [Qemu-devel] [PATCH 15/19] hw/pci-host: Declare device little or
 big endian
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
Cc: Tony Nguyen <tony.nguyen@bt.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org
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
 hw/pci-host/bonito.c    | 2 +-
 hw/pci-host/q35.c       | 2 +-
 hw/pci-host/versatile.c | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index ceee463a11..c4bb9239b0 100644
--- a/hw/pci-host/bonito.c
+++ b/hw/pci-host/bonito.c
@@ -526,7 +526,7 @@ static const MemoryRegionOps bonito_spciconf_ops = {
     .valid.max_access_size = 4,
     .impl.min_access_size = 1,
     .impl.max_access_size = 4,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 #define BONITO_IRQ_BASE 32
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index 158d270b9f..485e2a02af 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -289,7 +289,7 @@ static void tseg_blackhole_write(void *opaque, hwaddr addr, uint64_t val,
 static const MemoryRegionOps tseg_blackhole_ops = {
     .read = tseg_blackhole_read,
     .write = tseg_blackhole_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .valid.min_access_size = 1,
     .valid.max_access_size = 4,
     .impl.min_access_size = 4,
diff --git a/hw/pci-host/versatile.c b/hw/pci-host/versatile.c
index b731d0544f..df7212237d 100644
--- a/hw/pci-host/versatile.c
+++ b/hw/pci-host/versatile.c
@@ -243,7 +243,7 @@ static uint64_t pci_vpb_reg_read(void *opaque, hwaddr addr,
 static const MemoryRegionOps pci_vpb_reg_ops = {
     .read = pci_vpb_reg_read,
     .write = pci_vpb_reg_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
@@ -309,7 +309,7 @@ static uint64_t pci_vpb_config_read(void *opaque, hwaddr addr,
 static const MemoryRegionOps pci_vpb_config_ops = {
     .read = pci_vpb_config_read,
     .write = pci_vpb_config_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static int pci_vpb_map_irq(PCIDevice *d, int irq_num)
-- 
2.23.0


