Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0010BC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 21:57:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C316220B1F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 21:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cbT3BU1D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C316220B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jowLQ-0008IK-Va
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 17:57:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=439617756=alistair.francis@wdc.com>)
 id 1jowI2-0002li-NH
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 17:53:42 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:52693)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=439617756=alistair.francis@wdc.com>)
 id 1jowHz-0002yn-NL
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 17:53:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593208420; x=1624744420;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=b1Ls40SLOrF/dDm3uwiXCXSUeExSWQX70TCAAQ9ReiI=;
 b=cbT3BU1DSE4UKt8tqQFqen23enxrDuj6ivjcZTEspfKbky6g+eMWJY9W
 w0453eoV/4tL2gYKYMUQP7DFIz1aCbM1AdjP82V754ZGwwL1zEBIxQHH/
 EPFxgLzNlXBlB1HtYLbAzuckJYuvV9cnHFtPszHGVzfxya7rPa5TypGnw
 cE8xkG5N2qZzE9i7+axNABwM8tdqvMO/Fq3Q6IjiBiAET4NVk4hFACx7t
 bZPznfFCBhBLAfdk4Fb70Pfir2pMrGBkM/eeGnmDjrYV7NoqA/xlTMFbp
 SnZJFji4TgfCP+P23J3SZV8KVSHU/yJNXBf1AKPk+PbcTLfhHSDTkRJ3P w==;
IronPort-SDR: JhzmCAbjjteLYLqQAZL09sz76j3UHS4sfu6Tdt8MMNAs+MtBi2IEvP1AH+rElQikmnMz0YrjOi
 PK+WlKuxm6iHlaGhnKSGX+/4sOmTZyzxVobXpduoWK53U9dyuYwgE6AEsnAD3UgMjf1jsAVdE8
 z2AU6PjK39gionXbkAWTV24836xdhTZZgKsurxzg7VnvIR5PEKtnMH8Y4AynzmOOiV/bvy+azM
 19J4gd64IAuraOiP3ePyHvOvijtQxs67O5bsWJtlVzPz9teBW7O1iJ+xA7e8wZZZJfoBfAiQIP
 42g=
X-IronPort-AV: E=Sophos;i="5.75,285,1589212800"; d="scan'208";a="145360014"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 27 Jun 2020 05:53:35 +0800
IronPort-SDR: Cf1MCNKaLSuqKSgGmqT/YGemDpr7lqOD4Aup5kATx/aOBsP4dQqNHVfo53PdiAYs5NATUnDItE
 rIEn9b56rdklcUlfkatbOFpuXMLyv9Qao=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2020 14:42:33 -0700
IronPort-SDR: XtjPWSqekKH3gmfi8R09PM9X/b6JLKxYXcdKpIjI2Z+XEsyHWo0QZcXBwi4QFyiMkaGzCtemzL
 3O8tzT0sdKjw==
WDCIronportException: Internal
Received: from 2hc7cg2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.206])
 by uls-op-cesaip01.wdc.com with ESMTP; 26 Jun 2020 14:53:34 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 01/63] riscv: plic: Honour source priorities
Date: Fri, 26 Jun 2020 14:43:08 -0700
Message-Id: <20200626214410.3613258-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200626214410.3613258-1-alistair.francis@wdc.com>
References: <20200626214410.3613258-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=439617756=alistair.francis@wdc.com;
 helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 17:53:34
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


