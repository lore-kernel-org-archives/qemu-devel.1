Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65F5C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 22:49:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A861A20771
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 22:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Zp/J0e96"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A861A20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5zYy-00004w-Vn
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 18:49:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39596)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=486123ee4=alistair.francis@wdc.com>)
 id 1k5zQY-0002NH-03
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 18:40:58 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:56476)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=486123ee4=alistair.francis@wdc.com>)
 id 1k5zQV-0005lp-KA
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 18:40:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597272055; x=1628808055;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=PnPVgupWkcTye0mgiZsmJRw6xGGap8+1yaKVcLcBTOY=;
 b=Zp/J0e966D1uU8TtzPMn1QmhaGjEbEIDFaEcpQ3wSq7PZgVsIvoxPPRW
 0gEbrPSOf0/EdyU0AEQEM9IdOwXsIH5p092/FjSfSUAyeTKYSx+NJ8lWW
 CPe3vpgSLBf7/lcq9qtLisAh/cYBABnjjy1Q1koK/bCfUJWK/wOTEDVG2
 KRUUzUwvnj+N9LsnDv9Os2P1dXLcib7hC3Kdaf7kwgKQdcEbUuO52RM7T
 IuSYV6+2TBhONLwyWjt9Ew1Wii1rEVlfBPUNt07MeIQWZxaJFPMM2xaFK
 kdqHs9fRVlqqrsuHj/9pqWIX9yBVTX8YUnvtpYRV/fA7v8i5Rx9w6FRDN Q==;
IronPort-SDR: jbG+2png/LKJOqPC3pWupRTwMjh/qMrTkjW8MPx0DofgbUqhyTahUzCsqpv7/CPuBZ9XXlpNsj
 BX2C77d8g2EGGp51bmtKXCx5j6LIN2t9qi456m28y/l/4qbwb9tb8FO//PQubCIu7hzlqgPCVG
 WFoWRbGhmbnd9TKSE9bGFBj32ds/FgffoVrq7hCuiL/20p57pX3oglV6F7SGG8ntF3mqZ4wRut
 aqQK0Rzc6TvlOxFcn3lL4xu/vXgvrIuFQl7HGHA4hPEn7TEOAHIS1omuTn+GNca7BaSq1Tj0yE
 t8M=
X-IronPort-AV: E=Sophos;i="5.76,305,1592841600"; d="scan'208";a="144853396"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 13 Aug 2020 06:40:49 +0800
IronPort-SDR: PYAbyFbbETv/ej0io35gQIMTOyfzbtNfRYrhdVSlsB2sT29QPIPVfOBBjuBGS4wJjCdSLewh4/
 EWG51TcC4IBg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2020 15:28:40 -0700
IronPort-SDR: vLwM17/dD+hKzw7kLr+9L3OVl62KLToTEbUcmJqslXrmN912/QfsqDfOg1P0ynRzXgxEEnQhVV
 NC/mLPgBK7XQ==
WDCIronportException: Internal
Received: from jbfyk72.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.14])
 by uls-op-cesaip01.wdc.com with ESMTP; 12 Aug 2020 15:40:47 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/20] configure: Create symbolic links for pc-bios/*.elf files
Date: Wed, 12 Aug 2020 15:30:35 -0700
Message-Id: <20200812223045.96803-11-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200812223045.96803-1-alistair.francis@wdc.com>
References: <20200812223045.96803-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=486123ee4=alistair.francis@wdc.com;
 helo=esa5.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 18:40:47
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
Cc: Bin Meng <bin.meng@windriver.com>,
 Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

Now we need to ship the OpenSBI fw_dynamic.elf image for the
RISC-V Spike machine, it requires us to create symbolic links
for pc-bios/*.elf files.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <1596439832-29238-2-git-send-email-bmeng.cn@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 configure | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configure b/configure
index 2acc4d1465..790b21d4a5 100755
--- a/configure
+++ b/configure
@@ -8545,6 +8545,7 @@ LINKS="$LINKS tests/qemu-iotests/check"
 LINKS="$LINKS python"
 for bios_file in \
     $source_path/pc-bios/*.bin \
+    $source_path/pc-bios/*.elf \
     $source_path/pc-bios/*.lid \
     $source_path/pc-bios/*.rom \
     $source_path/pc-bios/*.dtb \
-- 
2.27.0


