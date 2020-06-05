Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AEDAC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 01:30:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CB612067B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 01:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="G1r61BlH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CB612067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh1Br-0002aC-Jk
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 21:30:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4185f83b6=alistair.francis@wdc.com>)
 id 1jh1Au-0000sF-Sq; Thu, 04 Jun 2020 21:29:36 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:56242)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4185f83b6=alistair.francis@wdc.com>)
 id 1jh1At-0008Vw-MV; Thu, 04 Jun 2020 21:29:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1591320576; x=1622856576;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TlTFn5A9/iW5WPtFBqmtDPppcRtWzpovJLC7itAoYUo=;
 b=G1r61BlHr/N3AOJCNrVjrRhpmvOV74BglZL/yfYjkXkX2z4AJCdLoE3h
 xif2aiI2YMPV3loXr7xXzgOr4wOIemiHxnzF08ye7382ej+9aIWDBx91y
 zGsvSyjyu1Q8T3gj52ts06Fb8dBR3Yr9BfNRgNmzKWcgFoddv/bDVHoqN
 Bacsuxo4YDawMERA5e50Ypn1sBHzZln1yuWtq8DPNdgaIoQkCKfc9X2SD
 rz/UCM3GpMWr6QrOfQXNCGjWSNDXrokkKK2GmyKrdoPDSQt7UhT1FifjZ
 UPqqf3xZz6AYCfpkmpq2VfoxQDM0kKo3/C0VsuiHyr0AdWlUMIV6J+OD3 w==;
IronPort-SDR: zN6siZNowIBT3BV1vPOqIn5zTrsG20Rnc0DpKs1Ceu0BSENN9Tz9zp2TtisvFW+i2NzQi4b45/
 gqLESCJAJHyP4nwxfPUYXjOE5NckvoqWJ4YqFDXKG9xRi/P0m8Iz8IJy7cWVcAtV9VgWYo8sWq
 fwfrsVqqHG0GZyNdupvb9T+4Vpf+lMIi/pM3wmFvni7Sx43qAvAIAVJKmJsjpv26aK0LzN+PZ+
 b7D09pC/1L2CY53Zq8Ejs//68ENEZc3a2LZm2cMWen9pOhKpzqlISZvU4Rbiu46n8oMBtCIp8S
 R20=
X-IronPort-AV: E=Sophos;i="5.73,474,1583164800"; d="scan'208";a="139561707"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 05 Jun 2020 09:29:34 +0800
IronPort-SDR: vUoBS3FFE9QHHGxxwR0o6sTk+m2IXyR88/UtGLL4caDeOraUl/8LD20Vh2KL2rbwX6ePwj/DAD
 bK3cjGo8AqOv0YsoiX/sZAnG+u7OsAZu8=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2020 18:19:08 -0700
IronPort-SDR: hP1RvipYIbL4t06gCtJSSiR5qh9Nft3hbBcw01Y/8UM1JAPXZ7lIbhWMOeVzjYNul0n9iZ6l4j
 ryURQ1b4HhdQ==
WDCIronportException: Internal
Received: from cnf006056.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.57.233])
 by uls-op-cesaip01.wdc.com with ESMTP; 04 Jun 2020 18:29:33 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 01/17] target/riscv: Set access as data_load when
 validating stage-2 PTEs
Date: Thu,  4 Jun 2020 18:20:45 -0700
Message-Id: <5556f87b6d71a61f5e9113873d91132e08ac6b2f.1591319882.git.alistair@alistair23.me>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1591319882.git.alistair@alistair23.me>
References: <cover.1591319882.git.alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=4185f83b6=alistair.francis@wdc.com;
 helo=esa5.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 21:29:30
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
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
Cc: alistair.francis@wdc.com, anup.pate@wdc.com, palmer@dabbelt.com,
 alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 62fe1ecc8f..eda7057663 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -435,7 +435,7 @@ restart:
             hwaddr vbase;
 
             /* Do the second stage translation on the base PTE address. */
-            get_physical_address(env, &vbase, &vbase_prot, base, access_type,
+            get_physical_address(env, &vbase, &vbase_prot, base, MMU_DATA_LOAD,
                                  mmu_idx, false, true);
 
             pte_addr = vbase + idx * ptesize;
-- 
2.26.2


