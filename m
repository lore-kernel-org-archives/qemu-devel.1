Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96EC8C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 20:22:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6342020768
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 20:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MRh6hcUx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6342020768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqMm6-0006rI-KC
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 16:22:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=44328bdba=alistair.francis@wdc.com>)
 id 1jqMl6-0005VK-RW; Tue, 30 Jun 2020 16:21:36 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:36481)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=44328bdba=alistair.francis@wdc.com>)
 id 1jqMl2-0007iT-3L; Tue, 30 Jun 2020 16:21:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593548492; x=1625084492;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0+pISn8B5Cqa+3MVexHhrMyVOacv3IJ6UqgEj1CUxAU=;
 b=MRh6hcUxxkU45nB5BKJ3XQ/AHgVatuyLIiVeMofhUwDZJtMJNlLNcPos
 Ce6GKuNg1XI4WD5hFilM+WJTRv7vAB9KAQsoOZRYHPVyL/nPIKONCWAoq
 o4iRqXt3S3kiZUavZPOABQ2lfNAFkhdGELv+aOdNbD/0n4fzcqak0YOzc
 rmjSbQN4DX8n2PebNQfcQfsbuNjur//HSj3oqAxTY8Q8d0hhr/NS8OOAO
 scKYQweXE2jQktI+STfDdkeoH8r3OrdowTwJwRHdGoeSjDKD4NkLDK8th
 9bN7dfTwjyoh6CWomZtCjC1rTK4XKrogpFEztd22+AJ2zBdLSdrKa845k g==;
IronPort-SDR: SDQLaSr2mcT3AvDtgNqz4YzcufIIFa/VfvIq6FzPrSRyhwUGZokD7aiKRRE02lLp1cW1/K8FUi
 MJ9sYiGQS+cBVrbqc4iJukqTpNXCqSonme0IZfJ+T6cpFDPSpknkfrg5vwnzhrgHd/5/t326ct
 2Kr3tbigHC1XyqtgRmiL0tO/hGvAd2aNTwFTx0nQpeyt2L4+Y8YgmpIwM8BIJMJG/WSdhfROmG
 TKOBvS5lnNmZQOJSFT1UyGBCivnw2GuCy/gqlBf8NRhBOsTlOhwEZoM54BcS3u/EDA+HJMv5J5
 Qfo=
X-IronPort-AV: E=Sophos;i="5.75,298,1589212800"; d="scan'208";a="142665039"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 01 Jul 2020 04:21:29 +0800
IronPort-SDR: w99jhB40SuRgms7rerYLVgA9znZSN68eIMnS2n0MCd78wDxNC2cDWiNh5/p4RCMY+JdGv9uNL4
 DT0zTWSE1zkmD+4yPLNd2AdXTyomZewYk=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2020 13:10:20 -0700
IronPort-SDR: XElD7X+fg94vro0qHSBPkwwdYTO0miJsV4946VlzksYRM1ZvjneEke+6FC3qbVQpUf4nAQ+Mq+
 kvoyND+jfVzQ==
WDCIronportException: Internal
Received: from us6fgspc2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.58.109])
 by uls-op-cesaip01.wdc.com with ESMTP; 30 Jun 2020 13:21:30 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 2/3] hw/riscv: Allow 64 bit access to SiFive CLINT
Date: Tue, 30 Jun 2020 13:12:11 -0700
Message-Id: <122b78825b077e4dfd39b444d3a46fe894a7804c.1593547870.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1593547870.git.alistair.francis@wdc.com>
References: <cover.1593547870.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=44328bdba=alistair.francis@wdc.com;
 helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 16:21:24
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
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 5d971f9e672507210e77d020d89e0e89165c8fc9
"memory: Revert "memory: accept mismatching sizes in
memory_region_access_valid"" broke most RISC-V boards as they do 64 bit
accesses to the CLINT and QEMU would trigger a fault. Fix this failure
by allowing 8 byte accesses.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/sifive_clint.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_clint.c b/hw/riscv/sifive_clint.c
index b11ffa0edc..669c21adc2 100644
--- a/hw/riscv/sifive_clint.c
+++ b/hw/riscv/sifive_clint.c
@@ -181,7 +181,7 @@ static const MemoryRegionOps sifive_clint_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
         .min_access_size = 4,
-        .max_access_size = 4
+        .max_access_size = 8
     }
 };
 
-- 
2.27.0


