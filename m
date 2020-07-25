Return-Path: <SRS0=thXK=BE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D95C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 05:47:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E6F22065F
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 05:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="f7xnuxAa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E6F22065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzD1e-00076r-CX
	for qemu-devel@archiver.kernel.org; Sat, 25 Jul 2020 01:47:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47992)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=46842bc30=alistair.francis@wdc.com>)
 id 1jzCz4-0003ui-A7; Sat, 25 Jul 2020 01:44:34 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:4667)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=46842bc30=alistair.francis@wdc.com>)
 id 1jzCz2-00054k-J8; Sat, 25 Jul 2020 01:44:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1595655873; x=1627191873;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IXjQaYSKp/KRab7qi0wsM5kCyfMdF4d7gzReheNEn6M=;
 b=f7xnuxAadjPhsk5ARb55xraUf8Npklx2ojDLz4yltY3uCPrwZdXCFP4s
 Yl920I2T+LuQH8yaxHj7IvLZFOUkWxdePNrnV0fGuYHwsIFCy0JgRKWck
 /qfdh5Eoqw7lSsVONXAVsh9ybAtlCS0d09grYJwUGULKgEOaVnM16/F7l
 SKFvsecOdSZp9tbPnC7cg261WzphqICyhgTUpyNp+9SAoPZUFNaRfypJQ
 yYknHowBd+edSipf5jq1VC9o3ef49sED92hz2B5ezSM3HNPtHAKRqYlBT
 mkQnbHe3t5BWcljmw3OMok0VHL5RG62ivD9tKcZVsCfCL+dRwSaXQ1Fj4 g==;
IronPort-SDR: NyR4QwrnUdXkSnZ5RcNW4M4IfmzIcV3fD+KrCo+q8nVQd0PS+FFmwx4owgQh83UpfPtEvO6CLT
 mtJcTyJvDHtEC1IOQoJUPIeMHi97j2RH0GML0wg9FvZH02LzXaLR5Ot2yQd5Xr8JEBh71+qPTW
 67rvdWCuzukZI3Px7R0lC5PajtKf14zN0nLC6SRXyKptYZQkzDbyqCd5LbjjuU1jr5beOy8bvI
 hN2AanuZZFlX0L7lNxhf6bWbCKU8EzP+WqKAe6mG9aN+JbwBPjr6rbok77flPwXCW32smz/Usv
 bjE=
X-IronPort-AV: E=Sophos;i="5.75,392,1589212800"; d="scan'208";a="144611254"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 25 Jul 2020 13:44:32 +0800
IronPort-SDR: YmBQGBCbEYcIZ4vQhZkUgdREXquX7Jyap0HuHmGwLa6hJjCdu+GXLLsMqHbjDeEnXJTzKxoDgi
 vliSsUdDGI3suhbMlM7u/nMIqt17ppsFY=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jul 2020 22:32:45 -0700
IronPort-SDR: zDMKS1vp1ZUrUZkzrts89+KXoclUMYL6tKC8DNGylqbCFiiY+mUEIerUE3L08+uYt8LMXZp8kT
 y13TFJJRJzlw==
WDCIronportException: Internal
Received: from cnf007830.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.124])
 by uls-op-cesaip02.wdc.com with ESMTP; 24 Jul 2020 22:44:31 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 3/3] hw/intc: ibex_plic: Honour source priorities
Date: Fri, 24 Jul 2020 22:34:45 -0700
Message-Id: <a697ca8a31eff8eb18a88e09a28206063cf85d48.1595655188.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1595655188.git.alistair.francis@wdc.com>
References: <cover.1595655188.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=46842bc30=alistair.francis@wdc.com;
 helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/25 01:44:23
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch follows what commit aa4d30f6618dc "riscv: plic: Honour source
priorities" does and ensures that the highest priority interrupt will be
serviced first.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Cc: Jessica Clarke <jrtc27@jrtc27.com>
---
 hw/intc/ibex_plic.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/hw/intc/ibex_plic.c b/hw/intc/ibex_plic.c
index 669247ef08..f49fa67c91 100644
--- a/hw/intc/ibex_plic.c
+++ b/hw/intc/ibex_plic.c
@@ -57,6 +57,8 @@ static void ibex_plic_irqs_set_pending(IbexPlicState *s, int irq, bool level)
 static bool ibex_plic_irqs_pending(IbexPlicState *s, uint32_t context)
 {
     int i;
+    uint32_t max_irq = 0;
+    uint32_t max_prio = s->threshold;
 
     for (i = 0; i < s->pending_num; i++) {
         uint32_t irq_num = ctz64(s->pending[i]) + (i * 32);
@@ -66,14 +68,17 @@ static bool ibex_plic_irqs_pending(IbexPlicState *s, uint32_t context)
             continue;
         }
 
-        if (s->priority[irq_num] > s->threshold) {
-            if (!s->claim) {
-                s->claim = irq_num;
-            }
-            return true;
+        if (s->priority[irq_num] > max_prio) {
+            max_irq = irq_num;
+            max_prio = s->priority[irq_num];
         }
     }
 
+    if (max_irq) {
+        s->claim = max_irq;
+        return true;
+    }
+
     return false;
 }
 
-- 
2.27.0


