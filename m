Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C80C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 22:13:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E278C207E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 22:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jI67h8YG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E278C207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53688 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZN7R-0002CN-NH
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 18:13:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48064)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=0547f94d1=alistair.francis@wdc.com>)
 id 1hZMsb-0004q5-39
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 17:58:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=0547f94d1=alistair.francis@wdc.com>)
 id 1hZMsX-0002ER-4X
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 17:58:31 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:38183)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=0547f94d1=alistair.francis@wdc.com>)
 id 1hZMsV-000284-2r; Fri, 07 Jun 2019 17:58:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1559944718; x=1591480718;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jX/RpI7uSP8KPd5AF5ZDxr9NUzaT3LJkLiKb3mUVKRc=;
 b=jI67h8YGs/sf8z9O3cp+0SghXE8CRl+JCXQdnLNSX8n4qJRF6e8d2OeW
 bPoLuu/5po3zbDFr94jGjvvgPtB22pf5vabHXsa82MleZRsD5BEPSMYpt
 oR7VUoFK8HHRam7Sr0QTZ2XZCSlWZSznSOaYdZHq6OWCt52ToPSn/nmn2
 diIJefPJuYFVHjuCfxLZkTs7cb1D/xK1bZ+tWVn/Bjw+YumsHVChBCHoq
 taaj/jXh2/kXctgy0AKDgENnFl8Zovw7BSMbFIB+tWGP3BP+e2pC0n4DA
 eFftJW1G1oDrikz7SIT+aJwPDsop68y8MEp9cFjLogTcS51Oc60t31QxK w==;
X-IronPort-AV: E=Sophos;i="5.63,564,1557158400"; d="scan'208";a="209711282"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 08 Jun 2019 05:58:23 +0800
IronPort-SDR: oP6G0jV6pkKFs9o7J8kCsp4G/VAV3FucPcTubDUcBQVTI4gRxDNnD8kVK7J6dJ1WU0OCPdZZTS
 KS4ws7ZTWUbBWMoAQb5LN2ngzH2Dv6B1U0+7b8gDI9GhYdNRDbLKKY8W/OKtr1a700pbgRNOOC
 lsvF0ds2tk4T2hR4nKvzcGH7OtYLTULOe0Rh14La5DcmBw3KzaC7LetpGHKVStoxkUchgsXWxU
 2RZPemGS6x3SXluA7cWLsg5/Ls5pmxYdNVPj2Ji5WEZ/FAcdIoPF1kr6t2tyOY5RI6aN2xb+bp
 k2iIa75OTMGmoyXe+NGvRNQx
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP; 07 Jun 2019 14:35:34 -0700
IronPort-SDR: LMbp+I0mC1SKxV2drNikd+PSO0pzqybNtku5SM8KRMBSMAFvkCA9cjXnzOkVp5pEXAdIIeU+ay
 tSC5H7FQmPnQDuBgAufEECv8vuwtRiA4JZLwRAFXuOfc0GDolEoFr15qnoV2pIgHI7folpbzBM
 6NOg3mXz16sl8R3nYw/kuWDXmzgY5cyoOym4GXQH4NJKbzvjnrfhWlYus2UdYtwvyMUZKtP4DH
 8T3dRcxXb+EvGlc5Ats6Pa2HaG+gKeWMl1vFGylwTdYbEG1sTGChIgTPkvGRlAiDiDAWa1Ehf9
 /L8=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.140])
 by uls-op-cesaip02.wdc.com with ESMTP; 07 Jun 2019 14:58:17 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri,  7 Jun 2019 14:56:07 -0700
Message-Id: <52f4e2607602fcd822a07632c6c56b32f05fdf4f.1559944445.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559944445.git.alistair.francis@wdc.com>
References: <cover.1559944445.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 68.232.143.124
Subject: [Qemu-devel] [PATCH v1 15/27] riscv: plic: Remove unused interrupt
 functions
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
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/sifive_plic.c         | 12 ------------
 include/hw/riscv/sifive_plic.h |  3 ---
 2 files changed, 15 deletions(-)

diff --git a/hw/riscv/sifive_plic.c b/hw/riscv/sifive_plic.c
index 07a032d93d..1e7e4c8d51 100644
--- a/hw/riscv/sifive_plic.c
+++ b/hw/riscv/sifive_plic.c
@@ -159,18 +159,6 @@ static void sifive_plic_update(SiFivePLICState *plic)
     }
 }
 
-void sifive_plic_raise_irq(SiFivePLICState *plic, uint32_t irq)
-{
-    sifive_plic_set_pending(plic, irq, true);
-    sifive_plic_update(plic);
-}
-
-void sifive_plic_lower_irq(SiFivePLICState *plic, uint32_t irq)
-{
-    sifive_plic_set_pending(plic, irq, false);
-    sifive_plic_update(plic);
-}
-
 static uint32_t sifive_plic_claim(SiFivePLICState *plic, uint32_t addrid)
 {
     int i, j;
diff --git a/include/hw/riscv/sifive_plic.h b/include/hw/riscv/sifive_plic.h
index ce8907f6aa..3b8a623919 100644
--- a/include/hw/riscv/sifive_plic.h
+++ b/include/hw/riscv/sifive_plic.h
@@ -69,9 +69,6 @@ typedef struct SiFivePLICState {
     uint32_t aperture_size;
 } SiFivePLICState;
 
-void sifive_plic_raise_irq(SiFivePLICState *plic, uint32_t irq);
-void sifive_plic_lower_irq(SiFivePLICState *plic, uint32_t irq);
-
 DeviceState *sifive_plic_create(hwaddr addr, char *hart_config,
     uint32_t num_sources, uint32_t num_priorities,
     uint32_t priority_base, uint32_t pending_base,
-- 
2.21.0


