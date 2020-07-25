Return-Path: <SRS0=thXK=BE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36018C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 05:45:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE92C2065F
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 05:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bwvc4OSM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE92C2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzD0N-0005Ff-4x
	for qemu-devel@archiver.kernel.org; Sat, 25 Jul 2020 01:45:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=46842bc30=alistair.francis@wdc.com>)
 id 1jzCz1-0003qX-B8; Sat, 25 Jul 2020 01:44:31 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:4665)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=46842bc30=alistair.francis@wdc.com>)
 id 1jzCyy-00054c-GY; Sat, 25 Jul 2020 01:44:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1595655869; x=1627191869;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yat/4F+Ac/cA5mvkOHze9b1OlBey1fQI6/rSOkeqLbA=;
 b=bwvc4OSMtBoJdKH5fObGRk1coMmA1Xth6Wj5WaE0Gco6Sa8QTzyhO7kM
 +e0rjp127YpRHcP20BrV3GJsQ2Q0ZyhND9D8UkZzm7ng/+d97k9YJMqig
 4LAkf4a3kmstye9I+CWRlsmkTPTA6JgcV6b5kjy+UCvVbGjnZ5vkmULfy
 k05gCgrzChctVokzQl7AnB42esbWXgIeSvEhDY7SsNeA9D657whUq+dz6
 vy/SwwqRtAdnTQ8hvbqegkCdO2cgRjrrUcc9BYRuT77oVyRS6xYYnbVkc
 2jP6RRnDlB60Seo73e5NKj50klZA+ryw5W6cPp6pXahCLg/vCgMWUIjQa w==;
IronPort-SDR: G0AUMufRQ14EljeUM/CyFqfcxr3ncH4n+eerCRmQZ6oX9i8Q9dZLN84oQCmSxmERih9XKto3E5
 ycHTXqSmUul8xmdsGRXWrN1I5fQd4MZkxnNWEx2Uh7+3eSXocghiDN/7MIAQUN8AV+gx57hNs6
 1edpxCRVYfMTihRTCMS40/+b6w3DWelKKah7rA7xyhmaawhiHa7nI1QJ4UAQjG/i64J2GRtKGm
 etwDW/HJ1WTrx8u6TF1H+6kcU63JSSGm7KV0bMXvLLBvtZCmzpYmLOGmX+Ln2XZUsQzaBM4RGv
 flw=
X-IronPort-AV: E=Sophos;i="5.75,392,1589212800"; d="scan'208";a="144611249"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 25 Jul 2020 13:44:26 +0800
IronPort-SDR: e4Q703NC550Uv76eKasNUV08xNRLEoUfLlXzllcqO8WcGNwxs4aqybBzu70tfFVlTMDA8l3V6d
 sEHn46AU6ErbF9dj61JQQkGSY2qMfX6DY=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jul 2020 22:32:39 -0700
IronPort-SDR: 8otWBHcKCa0sKw2WUuyNrShvLYwRylUgQa+B7mSU1Di0ZVmbQSJhcaiVd9SbQ9eNY4Acm0XOl+
 boDxfWqFplHA==
WDCIronportException: Internal
Received: from cnf007830.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.124])
 by uls-op-cesaip02.wdc.com with ESMTP; 24 Jul 2020 22:44:25 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 1/3] hw/intc: ibex_plic: Update the pending irqs
Date: Fri, 24 Jul 2020 22:34:40 -0700
Message-Id: <0693aa700a4c67c49b3f1c973a82b257fdb7198d.1595655188.git.alistair.francis@wdc.com>
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

After a claim or a priority change we need to update the pending
interrupts. This is based on the same patch for the SiFive PLIC:
55765822804f5a58594e "riscv: plic: Add a couple of mising
sifive_plic_update calls"

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Cc: Jessica Clarke <jrtc27@jrtc27.com>
---
 hw/intc/ibex_plic.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/intc/ibex_plic.c b/hw/intc/ibex_plic.c
index 41079518c6..578edd2ce0 100644
--- a/hw/intc/ibex_plic.c
+++ b/hw/intc/ibex_plic.c
@@ -121,6 +121,9 @@ static uint64_t ibex_plic_read(void *opaque, hwaddr addr,
         s->pending[pending_num] &= ~(1 << (s->claim % 32));
 
         ret = s->claim;
+
+        /* Update the interrupt status after the claim */
+        ibex_plic_update(s);
     }
 
     return ret;
@@ -140,6 +143,7 @@ static void ibex_plic_write(void *opaque, hwaddr addr,
     } else if (addr_between(addr, s->priority_base, s->priority_num)) {
         uint32_t irq = ((addr - s->priority_base) >> 2) + 1;
         s->priority[irq] = value & 7;
+        ibex_plic_update(s);
     } else if (addr_between(addr, s->enable_base, s->enable_num)) {
         uint32_t enable_reg = (addr - s->enable_base) / 4;
 
-- 
2.27.0


