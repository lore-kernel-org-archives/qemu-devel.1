Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5283FC3A59F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 14:40:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DD23217F5
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 14:40:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DD23217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2GAU-0005Ok-0n
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 10:40:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42846)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tony.nguyen@bt.com>) id 1i2Fq3-0004bH-Av
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 10:19:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen@bt.com>) id 1i2Fq1-0000fW-El
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 10:19:19 -0400
Received: from nsstlmta28p.bpe.bigpond.com ([203.38.21.28]:44188)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tony.nguyen@bt.com>)
 id 1i2Fpx-0000OX-Mv; Mon, 26 Aug 2019 10:19:15 -0400
Received: from smtp.telstra.com ([10.10.24.4])
 by nsstlfep28p-svc.bpe.nexus.telstra.com.au with ESMTP id
 <20190826141905.LAPZ9614.nsstlfep28p-svc.bpe.nexus.telstra.com.au@smtp.telstra.com>;
 Tue, 27 Aug 2019 00:19:05 +1000
X-RG-Spam: Unknown
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduvddrudehgedgjeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuuffpveftpgfvgffnuffvtfetpdfqfgfvnecuuegrihhlohhuthemucegtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhonhihucfpghhuhigvnhcuoehtohhnhidrnhhguhihvghnsegsthdrtghomheqnecukfhppeehkedrudejfedrleekrdeikeenucfrrghrrghmpehhvghlohepuggsiidrthgvlhhsthhrrgdrtghomhdrrghupdhinhgvthepheekrddujeefrdelkedrieekpdhmrghilhhfrhhomhepoehtohhnhidrnhhguhihvghnsegsthdrtghomheqpdhrtghpthhtohepoegurghvihgusehgihgsshhonhdrughrohhpsggvrghrrdhiugdrrghuqedprhgtphhtthhopeeofhegsghughesrghmshgrthdrohhrgheqpdhrtghpthhtohepoehggihtsehmphhrtgdrphhkuhdrvgguuhdrtghnqedprhgtphhtthhopeeojhhslhgrsgihsehsuhhsvgdrtgiiqedprhgtphhtthhopeeomhgrrhhkrdgtrghvvgdqrgihlhgrnhgusehilhgrnhguvgdrtghordhukheqpdhrtghpthhtohepoehpvghtvghrrdhmrgihuggvlhhlsehlihhnrghrohdrohhrgheqpdhrtghpthhtohepoehqvghmuhdqrghrmhesnhhonhhgnhhurdhorhhgqedprhgtphhtthhopeeoqhgvmhhuqdguvghv
 vghlsehnohhnghhnuhdrohhrgheqpdhrtghpthhtohepoehqvghmuhdqphhptgesnhhonhhgnhhurdhorhhgqedprhgtphhtthhopeeothhonhihrdhnghhuhigvnhessghtrdgtohhmqeenucevlhhushhtvghrufhiiigvpedv
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RG-VS-CLASS: clean
X-Authentication-Info: Submitted using ID tony.nguyen.git@bigpond.com
Received: from dbz.telstra.com.au (58.173.98.68) by smtp.telstra.com (5.8.335)
 (authenticated as tony.nguyen.git@bigpond.com)
 id 5D3581440DDB1246; Tue, 27 Aug 2019 00:19:05 +1000
From: Tony Nguyen <tony.nguyen@bt.com>
To: qemu-devel@nongnu.org
Date: Tue, 27 Aug 2019 00:21:39 +1000
Message-Id: <98939505e0aede2a4c907301b21d1f348e29b9d2.1566829168.git.tony.nguyen@bt.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1566829168.git.tony.nguyen@bt.com>
References: <cover.1566829168.git.tony.nguyen@bt.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 203.38.21.28
Subject: [Qemu-devel] [PATCH 13/19] hw/misc: Declare device little or big
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
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 Jiri Slaby <jslaby@suse.cz>, David Gibson <david@gibson.dropbear.id.au>
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
 hw/misc/a9scu.c                | 2 +-
 hw/misc/applesmc.c             | 6 +++---
 hw/misc/arm11scu.c             | 2 +-
 hw/misc/arm_integrator_debug.c | 2 +-
 hw/misc/arm_l2x0.c             | 2 +-
 hw/misc/edu.c                  | 2 +-
 hw/misc/mos6522.c              | 2 +-
 hw/misc/puv3_pm.c              | 2 +-
 hw/misc/unimp.c                | 2 +-
 9 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/hw/misc/a9scu.c b/hw/misc/a9scu.c
index 45c91db303..59335ca72f 100644
--- a/hw/misc/a9scu.c
+++ b/hw/misc/a9scu.c
@@ -96,7 +96,7 @@ static void a9_scu_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps a9_scu_ops = {
     .read = a9_scu_read,
     .write = a9_scu_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static void a9_scu_reset(DeviceState *dev)
diff --git a/hw/misc/applesmc.c b/hw/misc/applesmc.c
index 24d57e8677..cd60f458de 100644
--- a/hw/misc/applesmc.c
+++ b/hw/misc/applesmc.c
@@ -285,7 +285,7 @@ static void qdev_applesmc_isa_reset(DeviceState *dev)
 static const MemoryRegionOps applesmc_data_io_ops = {
     .write = applesmc_io_data_write,
     .read = applesmc_io_data_read,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_HOST_ENDIAN,
     .impl = {
         .min_access_size = 1,
         .max_access_size = 1,
@@ -295,7 +295,7 @@ static const MemoryRegionOps applesmc_data_io_ops = {
 static const MemoryRegionOps applesmc_cmd_io_ops = {
     .write = applesmc_io_cmd_write,
     .read = applesmc_io_cmd_read,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_HOST_ENDIAN,
     .impl = {
         .min_access_size = 1,
         .max_access_size = 1,
@@ -305,7 +305,7 @@ static const MemoryRegionOps applesmc_cmd_io_ops = {
 static const MemoryRegionOps applesmc_err_io_ops = {
     .write = applesmc_io_err_write,
     .read = applesmc_io_err_read,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_HOST_ENDIAN,
     .impl = {
         .min_access_size = 1,
         .max_access_size = 1,
diff --git a/hw/misc/arm11scu.c b/hw/misc/arm11scu.c
index 3023284d6f..dd690dc985 100644
--- a/hw/misc/arm11scu.c
+++ b/hw/misc/arm11scu.c
@@ -58,7 +58,7 @@ static void mpcore_scu_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps mpcore_scu_ops = {
     .read = mpcore_scu_read,
     .write = mpcore_scu_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static void arm11_scu_realize(DeviceState *dev, Error **errp)
diff --git a/hw/misc/arm_integrator_debug.c b/hw/misc/arm_integrator_debug.c
index 3e23201ae6..c392067332 100644
--- a/hw/misc/arm_integrator_debug.c
+++ b/hw/misc/arm_integrator_debug.c
@@ -72,7 +72,7 @@ static void intdbg_control_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps intdbg_control_ops = {
     .read = intdbg_control_read,
     .write = intdbg_control_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static void intdbg_control_init(Object *obj)
diff --git a/hw/misc/arm_l2x0.c b/hw/misc/arm_l2x0.c
index af2c7af4a0..cd1747b7a1 100644
--- a/hw/misc/arm_l2x0.c
+++ b/hw/misc/arm_l2x0.c
@@ -159,7 +159,7 @@ static void l2x0_priv_reset(DeviceState *dev)
 static const MemoryRegionOps l2x0_mem_ops = {
     .read = l2x0_priv_read,
     .write = l2x0_priv_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
  };
 
 static void l2x0_priv_init(Object *obj)
diff --git a/hw/misc/edu.c b/hw/misc/edu.c
index d5e2bdbb57..c014ea2443 100644
--- a/hw/misc/edu.c
+++ b/hw/misc/edu.c
@@ -295,7 +295,7 @@ static void edu_mmio_write(void *opaque, hwaddr addr, uint64_t val,
 static const MemoryRegionOps edu_mmio_ops = {
     .read = edu_mmio_read,
     .write = edu_mmio_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 8,
diff --git a/hw/misc/mos6522.c b/hw/misc/mos6522.c
index 57f13db266..7831fa60f9 100644
--- a/hw/misc/mos6522.c
+++ b/hw/misc/mos6522.c
@@ -365,7 +365,7 @@ void mos6522_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
 static const MemoryRegionOps mos6522_ops = {
     .read = mos6522_read,
     .write = mos6522_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_HOST_ENDIAN,
     .valid = {
         .min_access_size = 1,
         .max_access_size = 1,
diff --git a/hw/misc/puv3_pm.c b/hw/misc/puv3_pm.c
index c213500d9c..b04950ecb9 100644
--- a/hw/misc/puv3_pm.c
+++ b/hw/misc/puv3_pm.c
@@ -117,7 +117,7 @@ static const MemoryRegionOps puv3_pm_ops = {
         .min_access_size = 4,
         .max_access_size = 4,
     },
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static void puv3_pm_realize(DeviceState *dev, Error **errp)
diff --git a/hw/misc/unimp.c b/hw/misc/unimp.c
index 0e1cb24629..4aca34ff45 100644
--- a/hw/misc/unimp.c
+++ b/hw/misc/unimp.c
@@ -46,7 +46,7 @@ static const MemoryRegionOps unimp_ops = {
     .impl.max_access_size = 8,
     .valid.min_access_size = 1,
     .valid.max_access_size = 8,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_HOST_ENDIAN,
 };
 
 static void unimp_realize(DeviceState *dev, Error **errp)
-- 
2.23.0


