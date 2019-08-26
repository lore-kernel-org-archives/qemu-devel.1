Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A4BAC3A59F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 14:25:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FB2E2173E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 14:25:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FB2E2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53599 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2FwA-0001Zm-U2
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 10:25:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42549)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tony.nguyen@bt.com>) id 1i2FpB-00042g-Gy
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 10:18:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen@bt.com>) id 1i2FpA-00086U-E6
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 10:18:25 -0400
Received: from nsstlmta14p.bpe.bigpond.com ([203.38.21.14]:37778)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tony.nguyen@bt.com>) id 1i2Fp9-00083l-Qs
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 10:18:24 -0400
Received: from smtp.telstra.com ([10.10.24.4])
 by nsstlfep14p-svc.bpe.nexus.telstra.com.au with ESMTP id
 <20190826141819.HJYK1555.nsstlfep14p-svc.bpe.nexus.telstra.com.au@smtp.telstra.com>;
 Tue, 27 Aug 2019 00:18:19 +1000
X-RG-Spam: Unknown
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduvddrudehgedgjeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuuffpveftpgfvgffnuffvtfetpdfqfgfvnecuuegrihhlohhuthemucegtddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvohhnhicupfhguhihvghnuceothhonhihrdhnghhuhigvnhessghtrdgtohhmqeenucfkphepheekrddujeefrdelkedrieeknecurfgrrhgrmhephhgvlhhopegusgiirdhtvghlshhtrhgrrdgtohhmrdgruhdpihhnvghtpeehkedrudejfedrleekrdeikedpmhgrihhlfhhrohhmpeeothhonhihrdhnghhuhigvnhessghtrdgtohhmqedprhgtphhtthhopeeoqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgheqpdhrtghpthhtohepoehtohhnhidrnhhguhihvghnsegsthdrtghomheqnecuvehluhhsthgvrhfuihiivgeptd
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RG-VS-CLASS: clean
X-Authentication-Info: Submitted using ID tony.nguyen.git@bigpond.com
Received: from dbz.telstra.com.au (58.173.98.68) by smtp.telstra.com (5.8.335)
 (authenticated as tony.nguyen.git@bigpond.com)
 id 5D2D1175105889D6; Tue, 27 Aug 2019 00:18:19 +1000
From: Tony Nguyen <tony.nguyen@bt.com>
To: qemu-devel@nongnu.org
Date: Tue, 27 Aug 2019 00:21:30 +1000
Message-Id: <5f28bb686a0c4e339bcff2df63492a1aee509c1c.1566829168.git.tony.nguyen@bt.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1566829168.git.tony.nguyen@bt.com>
References: <cover.1566829168.git.tony.nguyen@bt.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 203.38.21.14
Subject: [Qemu-devel] [PATCH 04/19] hw/core: Declare device little or big
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
Cc: Tony Nguyen <tony.nguyen@bt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For each device declared with DEVICE_NATIVE_ENDIAN, find the set of
targets from the set of target/hw/*/device.o.

If the set of targets are all little or all big endian, re-declare
as DEVICE_LITTLE_ENDIAN or DEVICE_BIG_ENDIAN respectively.

Then, on inspection:
- if ununsed, re-declare as DEVICE_HOST_ENDIAN.
- if max/min size=1, re-declare as DEVICE_HOST_ENDIAN.
- if just a bit bucket, re-delcare as DEVICE_HOST_ENDIAN
- if PCI, re-declare as DEVICE_LITTLE_ENDIAN.
- if for {ARM|unicore32} only, re-declare as DEVICE_LITTLE_ENDIAN.
- if for SPARC only, re-declare as DEVICE_BIG_ENDIAN.

Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
---
 hw/core/empty_slot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/core/empty_slot.c b/hw/core/empty_slot.c
index 3ba450e1ca..2785b6acf9 100644
--- a/hw/core/empty_slot.c
+++ b/hw/core/empty_slot.c
@@ -49,7 +49,7 @@ static void empty_slot_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps empty_slot_ops = {
     .read = empty_slot_read,
     .write = empty_slot_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_HOST_ENDIAN,
 };
 
 void empty_slot_init(hwaddr addr, uint64_t slot_size)
-- 
2.23.0


