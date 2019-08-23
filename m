Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC42C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 19:09:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92A1B20850
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 19:09:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92A1B20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1Ewf-0002Mw-MJ
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 15:09:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42905)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tony.nguyen@bt.com>) id 1i1Egp-0002ou-L1
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 14:53:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen@bt.com>) id 1i1Ego-00037b-Kv
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 14:53:35 -0400
Received: from nsstlmta09p.bpe.bigpond.com ([203.38.21.9]:38158)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tony.nguyen@bt.com>)
 id 1i1Ego-00036H-1Y; Fri, 23 Aug 2019 14:53:34 -0400
Received: from smtp.telstra.com ([10.10.24.4])
 by nsstlfep09p-svc.bpe.nexus.telstra.com.au with ESMTP id
 <20190823185329.BCAA7749.nsstlfep09p-svc.bpe.nexus.telstra.com.au@smtp.telstra.com>;
 Sat, 24 Aug 2019 04:53:29 +1000
X-RG-Spam: Unknown
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduvddrudegkedguddvkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfupfevtfgpvffgnffuvffttedpqfgfvfenuceurghilhhouhhtmecugedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvohhnhicupfhguhihvghnuceothhonhihrdhnghhuhigvnhessghtrdgtohhmqeenucfkphepheekrddujeefrdelkedrieeknecurfgrrhgrmhephhgvlhhopegusgiirdhtvghlshhtrhgrrdgtohhmrdgruhdpihhnvghtpeehkedrudejfedrleekrdeikedpmhgrihhlfhhrohhmpeeothhonhihrdhnghhuhigvnhessghtrdgtohhmqedprhgtphhtthhopeeosggrlhhrohhgghesghhmrghilhdrtghomheqpdhrtghpthhtohepoehpvghtvghrrdhmrgihuggvlhhlsehlihhnrghrohdrohhrgheqpdhrtghpthhtohepoehqvghmuhdqrghrmhesnhhonhhgnhhurdhorhhgqedprhgtphhtthhopeeoqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgheqpdhrtghpthhtohepoehtohhnhidrnhhguhihvghnsegsthdrtghomheqnecuvehluhhsthgvrhfuihiivgeptd
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RG-VS-CLASS: clean
X-Authentication-Info: Submitted using ID tony.nguyen.git@bigpond.com
Received: from dbz.telstra.com.au (58.173.98.68) by smtp.telstra.com (5.8.335)
 (authenticated as tony.nguyen.git@bigpond.com)
 id 5D3692920C8C188D; Sat, 24 Aug 2019 04:53:29 +1000
From: Tony Nguyen <tony.nguyen@bt.com>
To: qemu-devel@nongnu.org
Date: Sat, 24 Aug 2019 04:56:27 +1000
Message-Id: <985f1f2ff3f9359b12b0df2368d3712c865f6c53.1566467963.git.tony.nguyen@bt.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1566467963.git.tony.nguyen@bt.com>
References: <cover.1566467963.git.tony.nguyen@bt.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 203.38.21.9
Subject: [Qemu-devel] [RFC PATCH 06/17] hw/gpio: Declare device little or
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
Cc: Tony Nguyen <tony.nguyen@bt.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
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
 hw/gpio/pl061.c  | 2 +-
 hw/gpio/zaurus.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/gpio/pl061.c b/hw/gpio/pl061.c
index 2a828260bd..25371d6c5a 100644
--- a/hw/gpio/pl061.c
+++ b/hw/gpio/pl061.c
@@ -341,7 +341,7 @@ static void pl061_set_irq(void * opaque, int irq, int level)
 static const MemoryRegionOps pl061_ops = {
     .read = pl061_read,
     .write = pl061_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static void pl061_luminary_init(Object *obj)
diff --git a/hw/gpio/zaurus.c b/hw/gpio/zaurus.c
index 9a12c68342..60bbbb8564 100644
--- a/hw/gpio/zaurus.c
+++ b/hw/gpio/zaurus.c
@@ -157,7 +157,7 @@ static void scoop_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps scoop_ops = {
     .read = scoop_read,
     .write = scoop_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static void scoop_gpio_set(void *opaque, int line, int level)
-- 
2.23.0


