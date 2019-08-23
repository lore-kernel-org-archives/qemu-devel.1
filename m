Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1284C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 19:31:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F77821874
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 19:31:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F77821874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1FH2-0006Nw-2X
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 15:31:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43294)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tony.nguyen@bt.com>) id 1i1EhT-0003oC-Px
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 14:54:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen@bt.com>) id 1i1EhS-0003Sg-2M
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 14:54:15 -0400
Received: from nsstlmta01p.bpe.bigpond.com ([203.38.21.1]:50842)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tony.nguyen@bt.com>)
 id 1i1EhR-0003Og-6N; Fri, 23 Aug 2019 14:54:14 -0400
Received: from smtp.telstra.com ([10.10.24.4])
 by nsstlfep01p-svc.bpe.nexus.telstra.com.au with ESMTP id
 <20190823185408.KAEC21386.nsstlfep01p-svc.bpe.nexus.telstra.com.au@smtp.telstra.com>;
 Sat, 24 Aug 2019 04:54:08 +1000
X-RG-Spam: Unknown
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduvddrudegkedguddvkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfupfevtfgpvffgnffuvffttedpqfgfvfenuceurghilhhouhhtmecugedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvohhnhicupfhguhihvghnuceothhonhihrdhnghhuhigvnhessghtrdgtohhmqeenucfkphepheekrddujeefrdelkedrieeknecurfgrrhgrmhephhgvlhhopegusgiirdhtvghlshhtrhgrrdgtohhmrdgruhdpihhnvghtpeehkedrudejfedrleekrdeikedpmhgrihhlfhhrohhmpeeothhonhihrdhnghhuhigvnhessghtrdgtohhmqedprhgtphhtthhopeeorghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgvqedprhgtphhtthhopeeorghnughrvgifsegrjhdrihgurdgruheqpdhrtghpthhtohepoegrthgrrhegqhgvmhhusehgmhgrihhlrdgtohhmqedprhgtphhtthhopeeotghhohhuthgvrghusegruggrtghorhgvrdgtohhmqedprhgtphhtthhopeeotghlgheskhgrohgurdhorhhgqedprhgtphhtthhopeeovggughgrrhdrihhglhgvshhirghssehgmhgrihhlrdgtohhmqedprhgtphhtthhopeeofhhrvgguvghrihgtrdhkohhnrhgrugesrggurggtohhrvgdrtghomheqpdhrtghpthhtohepoehjohgvlhesjhhmshdrihgurdgruheq
 pdhrtghpthhtohepoehmihgthhgrvghlseifrghllhgvrdgttgeqpdhrtghpthhtohepoehmshhtsehrvgguhhgrthdrtghomheqpdhrtghpthhtohepoehpsghonhiiihhnihesrhgvughhrghtrdgtohhmqedprhgtphhtthhopeeophgvthgvrhdrtghhuhgssgesnhhitghtrgdrtghomhdrrghuqedprhgtphhtthhopeeophgvthgvrhdrmhgrhiguvghllheslhhinhgrrhhordhorhhgqedprhgtphhtthhopeeoqhgvmhhuqdgrrhhmsehnohhnghhnuhdrohhrgheqpdhrtghpthhtohepoehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgqedprhgtphhtthhopeeoshhunhguvggvphdrlhhkmhhlsehgmhgrihhlrdgtohhmqedprhgtphhtthhopeeothhonhihrdhnghhuhigvnhessghtrdgtohhmqeenucevlhhushhtvghrufhiiigvpedutd
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RG-VS-CLASS: clean
X-Authentication-Info: Submitted using ID tony.nguyen.git@bigpond.com
Received: from dbz.telstra.com.au (58.173.98.68) by smtp.telstra.com (5.8.335)
 (authenticated as tony.nguyen.git@bigpond.com)
 id 5D3692920C8C21E3; Sat, 24 Aug 2019 04:54:07 +1000
From: Tony Nguyen <tony.nguyen@bt.com>
To: qemu-devel@nongnu.org
Date: Sat, 24 Aug 2019 04:56:37 +1000
Message-Id: <6c4515574804b699e3a35fe3590453178fef039b.1566467963.git.tony.nguyen@bt.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1566467963.git.tony.nguyen@bt.com>
References: <cover.1566467963.git.tony.nguyen@bt.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 203.38.21.1
Subject: [Qemu-devel] [RFC PATCH 16/17] hw/timer: Declare device little or
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
Cc: Tony Nguyen <tony.nguyen@bt.com>, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@aj.id.au>, Alistair Francis <alistair@alistair23.me>,
 Michael Walle <michael@walle.cc>, Fabien Chouteau <chouteau@adacore.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Peter Chubb <peter.chubb@nicta.com.au>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Joel Stanley <joel@jms.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For each device declared with DEVICE_NATIVE_ENDIAN, find the set of
targets from the set of target/hw/*/device.o.

If the set of targets are all little or all big endian, re-declare
the device endianness as DEVICE_LITTLE_ENDIAN or DEVICE_BIG_ENDIAN
respectively.

This *naive* deduction may result in genuinely native endian devices
being incorrectly declared as little or big endian, but should not
introduce regressions for current targets.

These devices should be re-declared as DEVICE_NATIVE_ENDIAN if 1) it
has a new target with an opposite endian or 2) someone informed knows
better =)

Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
---
 hw/timer/a9gtimer.c         | 4 ++--
 hw/timer/arm_mptimer.c      | 4 ++--
 hw/timer/arm_timer.c        | 4 ++--
 hw/timer/armv7m_systick.c   | 2 +-
 hw/timer/aspeed_rtc.c       | 2 +-
 hw/timer/cadence_ttc.c      | 2 +-
 hw/timer/grlib_gptimer.c    | 2 +-
 hw/timer/hpet.c             | 2 +-
 hw/timer/imx_epit.c         | 2 +-
 hw/timer/imx_gpt.c          | 2 +-
 hw/timer/lm32_timer.c       | 2 +-
 hw/timer/milkymist-sysctl.c | 2 +-
 hw/timer/mss-timer.c        | 2 +-
 hw/timer/pl031.c            | 2 +-
 hw/timer/stm32f2xx_timer.c  | 2 +-
 hw/timer/sun4v-rtc.c        | 2 +-
 16 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/hw/timer/a9gtimer.c b/hw/timer/a9gtimer.c
index 75f1867174..ffdc78f383 100644
--- a/hw/timer/a9gtimer.c
+++ b/hw/timer/a9gtimer.c
@@ -258,7 +258,7 @@ static const MemoryRegionOps a9_gtimer_this_ops = {
         .min_access_size = 4,
         .max_access_size = 4,
     },
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static const MemoryRegionOps a9_gtimer_ops = {
@@ -268,7 +268,7 @@ static const MemoryRegionOps a9_gtimer_ops = {
         .min_access_size = 4,
         .max_access_size = 4,
     },
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static void a9_gtimer_reset(DeviceState *dev)
diff --git a/hw/timer/arm_mptimer.c b/hw/timer/arm_mptimer.c
index 983e61847e..bf6295add1 100644
--- a/hw/timer/arm_mptimer.c
+++ b/hw/timer/arm_mptimer.c
@@ -194,7 +194,7 @@ static const MemoryRegionOps arm_thistimer_ops = {
         .min_access_size = 4,
         .max_access_size = 4,
     },
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static const MemoryRegionOps timerblock_ops = {
@@ -204,7 +204,7 @@ static const MemoryRegionOps timerblock_ops = {
         .min_access_size = 4,
         .max_access_size = 4,
     },
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static void timerblock_reset(TimerBlock *tb)
diff --git a/hw/timer/arm_timer.c b/hw/timer/arm_timer.c
index c2e6211188..f95c897d05 100644
--- a/hw/timer/arm_timer.c
+++ b/hw/timer/arm_timer.c
@@ -267,7 +267,7 @@ static void sp804_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps sp804_ops = {
     .read = sp804_read,
     .write = sp804_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static const VMStateDescription vmstate_sp804 = {
@@ -348,7 +348,7 @@ static void icp_pit_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps icp_pit_ops = {
     .read = icp_pit_read,
     .write = icp_pit_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static void icp_pit_init(Object *obj)
diff --git a/hw/timer/armv7m_systick.c b/hw/timer/armv7m_systick.c
index 85d122dbcb..b8003e2962 100644
--- a/hw/timer/armv7m_systick.c
+++ b/hw/timer/armv7m_systick.c
@@ -193,7 +193,7 @@ static MemTxResult systick_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps systick_ops = {
     .read_with_attrs = systick_read,
     .write_with_attrs = systick_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .valid.min_access_size = 4,
     .valid.max_access_size = 4,
 };
diff --git a/hw/timer/aspeed_rtc.c b/hw/timer/aspeed_rtc.c
index 5313017353..e3bd196dc0 100644
--- a/hw/timer/aspeed_rtc.c
+++ b/hw/timer/aspeed_rtc.c
@@ -131,7 +131,7 @@ static void aspeed_rtc_reset(DeviceState *d)
 static const MemoryRegionOps aspeed_rtc_ops = {
     .read = aspeed_rtc_read,
     .write = aspeed_rtc_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static const VMStateDescription vmstate_aspeed_rtc = {
diff --git a/hw/timer/cadence_ttc.c b/hw/timer/cadence_ttc.c
index 5e3128c1e3..6155d0055f 100644
--- a/hw/timer/cadence_ttc.c
+++ b/hw/timer/cadence_ttc.c
@@ -391,7 +391,7 @@ static void cadence_ttc_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps cadence_ttc_ops = {
     .read = cadence_ttc_read,
     .write = cadence_ttc_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static void cadence_timer_reset(CadenceTimerState *s)
diff --git a/hw/timer/grlib_gptimer.c b/hw/timer/grlib_gptimer.c
index 32dbf870d4..df84735197 100644
--- a/hw/timer/grlib_gptimer.c
+++ b/hw/timer/grlib_gptimer.c
@@ -315,7 +315,7 @@ static void grlib_gptimer_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps grlib_gptimer_ops = {
     .read = grlib_gptimer_read,
     .write = grlib_gptimer_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_BIG_ENDIAN,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 1ddae4e7d7..380abeb709 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -676,7 +676,7 @@ static const MemoryRegionOps hpet_ram_ops = {
         .min_access_size = 4,
         .max_access_size = 4,
     },
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static void hpet_reset(DeviceState *d)
diff --git a/hw/timer/imx_epit.c b/hw/timer/imx_epit.c
index f54e059910..7e605d29c7 100644
--- a/hw/timer/imx_epit.c
+++ b/hw/timer/imx_epit.c
@@ -284,7 +284,7 @@ static void imx_epit_cmp(void *opaque)
 static const MemoryRegionOps imx_epit_ops = {
     .read = imx_epit_read,
     .write = imx_epit_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static const VMStateDescription vmstate_imx_timer_epit = {
diff --git a/hw/timer/imx_gpt.c b/hw/timer/imx_gpt.c
index 49a441f451..27bacdb758 100644
--- a/hw/timer/imx_gpt.c
+++ b/hw/timer/imx_gpt.c
@@ -476,7 +476,7 @@ static void imx_gpt_timeout(void *opaque)
 static const MemoryRegionOps imx_gpt_ops = {
     .read = imx_gpt_read,
     .write = imx_gpt_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 
diff --git a/hw/timer/lm32_timer.c b/hw/timer/lm32_timer.c
index ac3edaff4f..4c0d3275e7 100644
--- a/hw/timer/lm32_timer.c
+++ b/hw/timer/lm32_timer.c
@@ -146,7 +146,7 @@ static void timer_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps timer_ops = {
     .read = timer_read,
     .write = timer_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_BIG_ENDIAN,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
diff --git a/hw/timer/milkymist-sysctl.c b/hw/timer/milkymist-sysctl.c
index 958350767a..cb117f944e 100644
--- a/hw/timer/milkymist-sysctl.c
+++ b/hw/timer/milkymist-sysctl.c
@@ -223,7 +223,7 @@ static const MemoryRegionOps sysctl_mmio_ops = {
         .min_access_size = 4,
         .max_access_size = 4,
     },
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_BIG_ENDIAN,
 };
 
 static void timer0_hit(void *opaque)
diff --git a/hw/timer/mss-timer.c b/hw/timer/mss-timer.c
index 45f1cf42f9..b9edb39837 100644
--- a/hw/timer/mss-timer.c
+++ b/hw/timer/mss-timer.c
@@ -200,7 +200,7 @@ timer_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps timer_ops = {
     .read = timer_read,
     .write = timer_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
         .min_access_size = 1,
         .max_access_size = 4
diff --git a/hw/timer/pl031.c b/hw/timer/pl031.c
index 2b3e261006..7ac2a0ca37 100644
--- a/hw/timer/pl031.c
+++ b/hw/timer/pl031.c
@@ -178,7 +178,7 @@ static void pl031_write(void * opaque, hwaddr offset,
 static const MemoryRegionOps pl031_ops = {
     .read = pl031_read,
     .write = pl031_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static void pl031_init(Object *obj)
diff --git a/hw/timer/stm32f2xx_timer.c b/hw/timer/stm32f2xx_timer.c
index edc557a4b9..88ae286b14 100644
--- a/hw/timer/stm32f2xx_timer.c
+++ b/hw/timer/stm32f2xx_timer.c
@@ -268,7 +268,7 @@ static void stm32f2xx_timer_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps stm32f2xx_timer_ops = {
     .read = stm32f2xx_timer_read,
     .write = stm32f2xx_timer_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static const VMStateDescription vmstate_stm32f2xx_timer = {
diff --git a/hw/timer/sun4v-rtc.c b/hw/timer/sun4v-rtc.c
index 54272a822f..0e831c91b1 100644
--- a/hw/timer/sun4v-rtc.c
+++ b/hw/timer/sun4v-rtc.c
@@ -47,7 +47,7 @@ static void sun4v_rtc_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps sun4v_rtc_ops = {
     .read = sun4v_rtc_read,
     .write = sun4v_rtc_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_BIG_ENDIAN,
 };
 
 void sun4v_rtc_init(hwaddr addr)
-- 
2.23.0


