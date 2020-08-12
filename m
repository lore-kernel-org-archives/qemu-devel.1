Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA1AC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 22:48:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A8C520838
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 22:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Tuw1IjAE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A8C520838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5zXa-0005a5-D7
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 18:48:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39738)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=486123ee4=alistair.francis@wdc.com>)
 id 1k5zQj-0002nF-JV
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 18:41:09 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:64105)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=486123ee4=alistair.francis@wdc.com>)
 id 1k5zQc-0005s1-JU
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 18:41:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597272062; x=1628808062;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ecw+uUu8ObD0NK1lt/f/vE+UcPdy47ApeZdTtie3FrA=;
 b=Tuw1IjAEuzt0kw/X+OP0DbXSbBnfuhZOwXMg3+OvpQCEJisTO5c1a8Ev
 O7Hkb4bjgaI1PaVa6VXcgoaRWMVPaicRHF5E07kzdpmsvlK/pVa5WDfQ5
 3elb5q0X4rW3++YBlT7pg5xxgEdVKbetq0KCYOziBcYhjUI4KINsv66zS
 bMl3y22dY05eQJziEsF1vHlNjrTlgOGG4D2F42jDU54Itk05TOTWxEtIN
 DHMMnzqs7J+eVEWuZR5CCV6ZbFPEISPto3K17AcZHRqfbRGmRqVEXuIRo
 +R9eMrJYyAew/YHPf/jSV8Kj5OySJAS9c2opliUYySAjlpcdG6GoFOxr4 w==;
IronPort-SDR: bn99zlAFSxUZY3nTh2EyclWJTgYhITzNktSHk2muct5VCqRVriMoRgO1SVF/eOTvTjR/KE2ATm
 xcmuSvS/KKuZwsGNExHxvjl/rPIiVMzFNCSmuhpXo9ZK3DO3qd6RnAAk9WXbCCQczyCVYLqghP
 OCcK95ztfBAwln9+Z7E5GS7MoKKuZqMgnlk6sTX+ktsVhCgKbm96b3RobE0IVYbY0ssa2ZQ/VR
 CLLoDbNPupu9lJXCLUDwldlsO9UHun5h/VSCd84zbPam3kdbkJhl8IGxcirKwDW8M4rYpfYAmT
 y2k=
X-IronPort-AV: E=Sophos;i="5.76,305,1592841600"; d="scan'208";a="144799071"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 13 Aug 2020 06:40:53 +0800
IronPort-SDR: I1adoBX9g2wZ2ErZZcY4rp+FyEJlQuV4D1kDjudx3gDmL4n5xEX78C3r5zHuy03ojpro3C1cjE
 iQ67TTswp/rw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2020 15:28:44 -0700
IronPort-SDR: rS/BsqfsaliAix2VApE+QKfmcCd/nECEY3UhgCvuFDAuOLxJi2BvDmGxtvZkeHlSURgSgito9w
 SNy6ZSpEUB9A==
WDCIronportException: Internal
Received: from jbfyk72.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.14])
 by uls-op-cesaip01.wdc.com with ESMTP; 12 Aug 2020 15:40:50 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL 20/20] hw/intc: ibex_plic: Honour source priorities
Date: Wed, 12 Aug 2020 15:30:45 -0700
Message-Id: <20200812223045.96803-21-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200812223045.96803-1-alistair.francis@wdc.com>
References: <20200812223045.96803-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=486123ee4=alistair.francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 18:40:52
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
Cc: Jessica Clarke <jrtc27@jrtc27.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
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
2.27.0


