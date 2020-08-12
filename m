Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884EAC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 22:52:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C6BA20771
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 22:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HnpMgmQa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C6BA20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5zbb-00043N-3E
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 18:52:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39666)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=486123ee4=alistair.francis@wdc.com>)
 id 1k5zQc-0002Vh-Bu
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 18:41:02 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:64105)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=486123ee4=alistair.francis@wdc.com>)
 id 1k5zQa-0005s1-EI
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 18:41:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597272060; x=1628808060;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uwlOCs0TigAYqcOkVWOmrQqtoKu/av8RoK/zaQpBVm0=;
 b=HnpMgmQaVNDOIA10ULBnAsbLomOI6Xx2oNHhigueXzMd/4XgoelKgK5I
 TRheJ1MsvIdnd0TJG68/Kkgxcb0c4r5o1FVVlUiyps9SMU2b0xnflS0QZ
 tvwzQy9AlR7Ko6MAM9PF8jRtA8Iuc4Yajq7uprwj2c+/emfylXELhviTa
 3UpSnSSLzvKPsTut1FFBJSluHCj/EmNnkLnyZO4c1Gkzml1QQcPJV2IoX
 osXPveSAwFDCCY5q/qEo5fxDhujGYPAaLitV1e/ZX6dJqfPayrzTgDTG6
 WQXKt2b67fKostZ9cWYcFP/9HKa36Qr4rFzotnr7sHt0EMKZRPlusLbL1 g==;
IronPort-SDR: 0YnxPfJmfDMoBy3/rgL3FA1UofknjBglYqu94/higO1RsB6InD7y8Q4Tf29/+3xLV4Ryl4rMzY
 LWf6UJMCtAoRYcubWB6OggL7OcqbBcesHH+QKYHkJZpJVBQdkB5f3FKTuHpgKIQ0wNb9n5efoC
 6sJJZM9sQXM9Di/jbdM0wwLZ1qGyuY/wDLbG5xsWEI+DpUsoyaR2YqQ4yM111rEQy07xgrMV6S
 ZCZtqniK4AFKWdCjhnpoHef6uwBXwZoylzlFh1jQFYXqmFvc6r7S2MNgc3bM5IMlw+Z7fi+Sa0
 5Nk=
X-IronPort-AV: E=Sophos;i="5.76,305,1592841600"; d="scan'208";a="144799067"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 13 Aug 2020 06:40:52 +0800
IronPort-SDR: mX7zh4T7K4jmLuonTA0YzyFhsw8MBt4vSZxyn8uW6cZzBclrOFXxUBzYx+35kICSbn6rn6qFct
 OtnScLCfe5UQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2020 15:28:43 -0700
IronPort-SDR: oPFmAF5AGu0z6pw6aiCz3UsLvV/75a37jnVaER4IjxdNzcyXpVBhFiSeUfzaO87jRMa4lcuayQ
 BtWV5QVlY1NQ==
WDCIronportException: Internal
Received: from jbfyk72.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.14])
 by uls-op-cesaip01.wdc.com with ESMTP; 12 Aug 2020 15:40:50 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL 18/20] hw/intc: ibex_plic: Update the pending irqs
Date: Wed, 12 Aug 2020 15:30:43 -0700
Message-Id: <20200812223045.96803-19-alistair.francis@wdc.com>
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

After a claim or a priority change we need to update the pending
interrupts. This is based on the same patch for the SiFive PLIC:
55765822804f5a58594e "riscv: plic: Add a couple of mising
sifive_plic_update calls"

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Cc: Jessica Clarke <jrtc27@jrtc27.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <0693aa700a4c67c49b3f1c973a82b257fdb7198d.1595655188.git.alistair.francis@wdc.com>
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


