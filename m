Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85C2C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 19:25:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2F8C20838
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 19:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HNqUTAXN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2F8C20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5wNq-0001Yc-T8
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 15:25:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59592)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=486123ee4=alistair.francis@wdc.com>)
 id 1k5wLb-0005AE-Jl; Wed, 12 Aug 2020 15:23:39 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:4837)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=486123ee4=alistair.francis@wdc.com>)
 id 1k5wLZ-0000UE-Th; Wed, 12 Aug 2020 15:23:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597260218; x=1628796218;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=LpK/Kkf+fwylS840kCf3NVSFUj6Cc/XdSH0z+Sq7yuI=;
 b=HNqUTAXNDm/WqNRsPlroYTbW91RvXt12wwW/Z9yAG722ejA21J6qtwAe
 vF9W91IxrbxfzrMxLHlRQjqXRP/9OJuS1Xzcva7QyyVpm5fViSJZsn5kJ
 rdNLS6Rk9eQTD02KN4wbaf21FOidAZitXqDSfdbA5kEfr+0YMba634D7L
 3zg++aqwdvLUMaq62UJmfZ87WwFBaU9DrJS+ENDkMBlsRtmekOb52tL9j
 aWI/A4vZS1KIAum0XtzSzThE2sEucayxBLu04HWn6TgquCJOCdL6T26sA
 Q15zi26K+yFM9dA94FPvUyw9gTBPnqlhvT3XE3ujam+fq7bEmyBfZY3fq g==;
IronPort-SDR: Lnr/1QQiU3I+u5jLoh56sjbPqlkKTzJelZKrmzst7rDSvAUQ7OsM/idSOfLuy8E8CzCRoZjfbD
 YCQzh+EsYRH2PrPvDzukkJu+g7sLNjVcDNsRrdd7d75wO9ArkEPh50BLd9vus7Qx6Cmn/BMRR6
 HGg+PWVt4ny/vmKTv9X9GkOplCr5ekqah/AA9dDc8Z9QRmPxNsinTamXCw4r8eY+dG4LIR/M0V
 6kFQ1oYRg+P5sBXevP4hfxlQCnzkipgW/C1Z+TJz9LY09KB20HEZGOeZwCZiSzv5H9/DzWs9mM
 6Mw=
X-IronPort-AV: E=Sophos;i="5.76,305,1592841600"; d="scan'208";a="146029209"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 13 Aug 2020 03:23:36 +0800
IronPort-SDR: mCNlwNiAcf29vLpdbkdkQhi9h+viX6j+2m5ISF8zLLyVmrHQIlfjdxV0nTS+7cNdnOHiPcuVQy
 5h1wQa+qhFbw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2020 12:10:44 -0700
IronPort-SDR: QVLEhwbHRxQkgXlhOLRE7I8q0+ucx8R2opMC9tP2o+qLuU4KnwR0H0AQk5HNs+m9oNAJmRnI1q
 LPDbrZ+dAGXA==
WDCIronportException: Internal
Received: from jbfyk72.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.14])
 by uls-op-cesaip02.wdc.com with ESMTP; 12 Aug 2020 12:23:37 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v3 08/13] target/riscv: Update the CSRs to the v0.6 Hyp
 extension
Date: Wed, 12 Aug 2020 12:13:36 -0700
Message-Id: <4f227b30cb1816795296c0994f1123fab143666a.1597259519.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1597259519.git.alistair.francis@wdc.com>
References: <cover.1597259519.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=486123ee4=alistair.francis@wdc.com;
 helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 15:23:20
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
Cc: alistair.francis@wdc.com, anup.patel@wdc.com, palmer@dabbelt.com,
 alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_bits.h | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index fb6a3e9092..573d85da41 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -437,15 +437,17 @@
 #endif
 
 /* hstatus CSR bits */
-#define HSTATUS_SPRV         0x00000001
+#define HSTATUS_VSBE         0x00000020
+#define HSTATUS_GVA          0x00000040
 #define HSTATUS_SPV          0x00000080
-#define HSTATUS_SP2P         0x00000100
-#define HSTATUS_SP2V         0x00000200
+#define HSTATUS_SPVP         0x00000100
+#define HSTATUS_HU           0x00000200
+#define HSTATUS_VGEIN        0x0003F000
 #define HSTATUS_VTVM         0x00100000
 #define HSTATUS_VTSR         0x00400000
-#define HSTATUS_HU           0x00000200
-#define HSTATUS_GVA          0x00000040
-#define HSTATUS_SPVP         0x00000100
+#if defined(TARGET_RISCV64)
+#define HSTATUS_VSXL        0x300000000
+#endif
 
 #define HSTATUS32_WPRI       0xFF8FF87E
 #define HSTATUS64_WPRI       0xFFFFFFFFFF8FF87EULL
-- 
2.27.0


