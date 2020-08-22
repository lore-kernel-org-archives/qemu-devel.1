Return-Path: <SRS0=Iy1T=CA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B045AC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 06:07:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78EEC20724
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 06:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZGBoQlKS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78EEC20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9Mgu-0003fK-Mu
	for qemu-devel@archiver.kernel.org; Sat, 22 Aug 2020 02:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34158)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=49637c5a7=alistair.francis@wdc.com>)
 id 1k9MRd-0002rZ-Mo
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 01:52:02 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:25955)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=49637c5a7=alistair.francis@wdc.com>)
 id 1k9MRb-0000D6-EU
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 01:52:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1598075519; x=1629611519;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dHdymkxK2eCJ8OEQQg89j0/t4e6Yp5BPLgod0J6om/o=;
 b=ZGBoQlKSSaCH5RcRFezip82tkyYX5Pw5ycWvK7prYbu8xHv4ytcZ5fcV
 hcHWmzE3JJOoocWsTf8N0cpfTA5Eo4LiHmO11yL/Uzg3R8Ig4XX2FhaVG
 Ni0mZZgrcptMkL79ESxwk4S/HhxvGNgq0QYbVdr6U74KtVLEMFMM0M2Y1
 QnDwvjNR0qs7FFkoL6xA3nKwYfdTOp1cmrnyGgZEpaTuHL9GsjIRFqXa5
 t/SBX45G2Ehqvr2EWuadnlO6z5zsV9L4GJ6usuC7FgEdVFxvnYkttkpa1
 L7oxLiGOVeX2V95VRImtLkobuIe0xWqnIob6ZsHv4Z6pcZ2GpbLlKeZb7 w==;
IronPort-SDR: 596mbxuDnyCOeMeyAMLN9M07mg5Y98oswzLY21t381pqh57MH/ijsR0qwbdkyZ2fUlAfzsP6Zd
 wjzpHUzeWruv4XKsqPrtC7BiWQU/9RkyNaGKxRPXPtP0284K81MtAiE+oV6JZXFKv825hgzR99
 asu1pAysXuaU3yqvakoMEBUHK1iU7TjmhDOXwPGplJKNQCXKlSSF/Lb+h6IhIDIenJiSTNT9G0
 hnQm83Cr5mh8x/g4tbdYrbeeahyIsqqB3gFNRUVY0RYqnuLuKllZ+kIDxC7QwpzwwaQHcwtaKW
 9+g=
X-IronPort-AV: E=Sophos;i="5.76,339,1592841600"; d="scan'208";a="145571974"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 22 Aug 2020 13:51:22 +0800
IronPort-SDR: WVNir2vDJfZ46vmOCLJm3kbqlNFEjxbs+0cyL6C7ncPGd5TQJU3yYGgKamMKX8LLU/Q5nk3Xo/
 dm27UZpU+isA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2020 22:39:01 -0700
IronPort-SDR: WGgeG07KdrQzkSXAeXTh6tiRoFOmkgbyYBMXoJeVJuwMXhl4FYliEJK7s0eRzvQYWg5AZulH1H
 ec0is5U0QkFg==
WDCIronportException: Internal
Received: from 5zn13g2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.90])
 by uls-op-cesaip02.wdc.com with ESMTP; 21 Aug 2020 22:51:22 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 20/20] hw/intc: ibex_plic: Honour source priorities
Date: Fri, 21 Aug 2020 22:41:01 -0700
Message-Id: <20200822054101.1202175-21-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200822054101.1202175-1-alistair.francis@wdc.com>
References: <20200822054101.1202175-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=49637c5a7=alistair.francis@wdc.com;
 helo=esa5.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/22 01:43:18
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
Cc: alistair23@gmail.com, alistair.francis@wdc.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Jessica Clarke <jrtc27@jrtc27.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch follows what commit aa4d30f6618dc "riscv: plic: Honour source
priorities" does and ensures that the highest priority interrupt will be
serviced first.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Cc: Jessica Clarke <jrtc27@jrtc27.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <a697ca8a31eff8eb18a88e09a28206063cf85d48.1595655188.git.alistair.francis@wdc.com>
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
2.28.0


