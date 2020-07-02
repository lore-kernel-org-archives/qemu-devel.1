Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8594C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 16:35:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9B7020720
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 16:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="V8SIm8p2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9B7020720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr2BF-0007CJ-Rj
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 12:35:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33442)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4451fe355=alistair.francis@wdc.com>)
 id 1jr29Z-0003X4-0y
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 12:33:37 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:44864)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4451fe355=alistair.francis@wdc.com>)
 id 1jr29V-00008e-L0
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 12:33:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593707613; x=1625243613;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=b1Ls40SLOrF/dDm3uwiXCXSUeExSWQX70TCAAQ9ReiI=;
 b=V8SIm8p2Uaz5PCnzjaDSnVkqsZJQ5LYdGHLmDfrqSRVaS8OCSxxyZXNL
 h3tXqZP9GRX117LZotdWeYyDjzePLQTF6qCtFJpjZUw0yHucMV0C4o9VL
 6m9mSFWAca59GBg2h66jw7LFzFgIkaNT+eMET8JuFDU2yUKvU6lh5Aphu
 WDmexMjdyz8gkMlUcXHxfX81uen+w1eVsPqNg/RKcvWIHcKVhk0r6/kMs
 XvUknfjYoZJ79r1fLZyZjwWxBN+Gatd+ABhtXZzoYE2YtJh3WeE1IcIsK
 NfOA/Qkurcy+r02jAF/EmoHEcsHLv0Ec06kl30a/nWWNQqUvHLcIadD8Y A==;
IronPort-SDR: iimmEOBg6Wl9SiJUdPbWJ1EVAdluE0Dhfl6AAbyYcqyeW5eIBdEU+Nx2iF9aFxQ9thEoumRe5/
 Ak/uqmEYTqp5oZbjG662hJ0t3O2zeRDXkHcOsGUb8H5fDWc2HBkr68IO8fjqGv5LeYsJ+K7BeC
 JpK/gwY8GlfSIvWpT9XxTBWosj8GytPpxT6EFR/H0GJrzuXwHb6wt57hU9Iuh2pgjh0vWEECvE
 rrMRdWybFnKmkBV8TmQjLCUFVuRPLjDULDdBYu9gA8I6RhytgZ74QSqWC/V/ryatfjBNsAevci
 y0k=
X-IronPort-AV: E=Sophos;i="5.75,304,1589212800"; d="scan'208";a="141498460"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2020 00:33:19 +0800
IronPort-SDR: E/14KFnljLZQtGZRpxdiTUUSWw1F/gzBIS6HxiVcIyosuF44PzeihmRkW9PRUqonwF+Ok0GW3b
 E57artNVfteP06Ekrd/5xJbKDvQFXEeoo=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 09:21:34 -0700
IronPort-SDR: 1BgRUGXq1Hlan9xTzf6daD2BQIod+mFniYxt/kBrljGZ5w4Q2dWOJRNiSWHuBtoQwe3HT9+0go
 eA/0dqQSkTtA==
WDCIronportException: Internal
Received: from 6hj08h2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.118])
 by uls-op-cesaip01.wdc.com with ESMTP; 02 Jul 2020 09:33:19 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 01/64] riscv: plic: Honour source priorities
Date: Thu,  2 Jul 2020 09:22:51 -0700
Message-Id: <20200702162354.928528-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200702162354.928528-1-alistair.francis@wdc.com>
References: <20200702162354.928528-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=4451fe355=alistair.francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 12:33:30
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>,
 Jessica Clarke <jrtc27@jrtc27.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jessica Clarke <jrtc27@jrtc27.com>

The source priorities can be used to order sources with respect to other
sources, not just as a way to enable/disable them based off a threshold.
We must therefore always claim the highest-priority source, rather than
the first source we find.

Signed-off-by: Jessica Clarke <jrtc27@jrtc27.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20200618202343.20455-1-jrtc27@jrtc27.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/sifive_plic.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/hw/riscv/sifive_plic.c b/hw/riscv/sifive_plic.c
index 4f216c5585..d91e82b8ab 100644
--- a/hw/riscv/sifive_plic.c
+++ b/hw/riscv/sifive_plic.c
@@ -166,6 +166,9 @@ static void sifive_plic_update(SiFivePLICState *plic)
 static uint32_t sifive_plic_claim(SiFivePLICState *plic, uint32_t addrid)
 {
     int i, j;
+    uint32_t max_irq = 0;
+    uint32_t max_prio = plic->target_priority[addrid];
+
     for (i = 0; i < plic->bitfield_words; i++) {
         uint32_t pending_enabled_not_claimed =
             (plic->pending[i] & ~plic->claimed[i]) &
@@ -177,14 +180,18 @@ static uint32_t sifive_plic_claim(SiFivePLICState *plic, uint32_t addrid)
             int irq = (i << 5) + j;
             uint32_t prio = plic->source_priority[irq];
             int enabled = pending_enabled_not_claimed & (1 << j);
-            if (enabled && prio > plic->target_priority[addrid]) {
-                sifive_plic_set_pending(plic, irq, false);
-                sifive_plic_set_claimed(plic, irq, true);
-                return irq;
+            if (enabled && prio > max_prio) {
+                max_irq = irq;
+                max_prio = prio;
             }
         }
     }
-    return 0;
+
+    if (max_irq) {
+        sifive_plic_set_pending(plic, max_irq, false);
+        sifive_plic_set_claimed(plic, max_irq, true);
+    }
+    return max_irq;
 }
 
 static uint64_t sifive_plic_read(void *opaque, hwaddr addr, unsigned size)
-- 
2.27.0


