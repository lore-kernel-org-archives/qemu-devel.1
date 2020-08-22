Return-Path: <SRS0=Iy1T=CA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 660F7C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 05:59:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3194F2072D
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 05:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jZYqcr4Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3194F2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9MZB-00073b-Fp
	for qemu-devel@archiver.kernel.org; Sat, 22 Aug 2020 01:59:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33928)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=49637c5a7=alistair.francis@wdc.com>)
 id 1k9MR3-0001mc-0F
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 01:51:25 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:12936)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=49637c5a7=alistair.francis@wdc.com>)
 id 1k9MR0-0000D0-5T
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 01:51:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1598075482; x=1629611482;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QE5+Q8WnNxcFLz0UlhOsysZROVN+wh9Bd5K1kz6O39c=;
 b=jZYqcr4YCFSd92KJ1RsMdIXITJ9hRaONv5gsqlTCvHTTmt4HHOmCVw3v
 NjxEcyXmU5Wd2V1MVNQcxjmUdCHv7paIONtyBV1b7B3u5rFfDMe805VYe
 IqaT2kmGyqyAaXrOfdELBd2/7hpGrjfGiTiw0wvU3FMQRFI8EQTtT/mmV
 uBTK2W7/GkLaOZopl4SKU91HB9COKidIUEieM/3DgEQXtltMjl/auJ34w
 biTFvsKZ+xVuyQEosvuGmNv4lOMG4OB8q+er/o1K3JsHEUZSDp/gLmftD
 NG+gcqRnlRdRofrM/g9Dy3mHI80okRfeEU28WSPrCBzm/rQvqznaRNbWb w==;
IronPort-SDR: 6p/6VSDHnmzrWTKY8HY9GWIDBZQK2wrJOVbfc5k9u4RTsohyTpLkMmz3JsdY/mjjpdG7hxOV12
 ZWHysgwkInrR/3wt06MJJFQxoo6qokC9+Z6JuUsyDhkyy03+f3lLcNIKQ4GLx13BVFr0kqRdGD
 ikia+trmTpsOLZdcy+u57JVImH5V12c9uTmWmE6rJt8LsDHb6F9VWfo4LbHioxfsLfphE+OPx2
 1hPeI6pUpL37Dz71Y0YHio5/SUYjfxhw4958COYhyqEDUuNNkJNOrK6i8p2FiyGWRijoir08w6
 650=
X-IronPort-AV: E=Sophos;i="5.76,339,1592841600"; d="scan'208";a="145571956"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 22 Aug 2020 13:51:18 +0800
IronPort-SDR: B39CM39cBOnHarEjNiteXQOGpIdp6aJe0SSQUjeUcO5MhVag19EEYYHn/dG/2qcMTiA/xMFYbO
 qp6MRoZz3EmQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2020 22:38:58 -0700
IronPort-SDR: uXsIukbGmELCtOFEXY8qPU0zC+KIHeS8vcCWs5VKERpCPESo9k+qq7tZufhewIFnHl3D0lY7Dq
 gzQMLRM4TlnQ==
WDCIronportException: Internal
Received: from 5zn13g2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.90])
 by uls-op-cesaip02.wdc.com with ESMTP; 21 Aug 2020 22:51:18 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 09/20] riscv: Fix bug in setting pmpcfg CSR for RISCV64
Date: Fri, 21 Aug 2020 22:40:50 -0700
Message-Id: <20200822054101.1202175-10-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200822054101.1202175-1-alistair.francis@wdc.com>
References: <20200822054101.1202175-1-alistair.francis@wdc.com>
MIME-Version: 1.0
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
Cc: Hou Weiying <weiying_hou@outlook.com>, alistair23@gmail.com,
 alistair.francis@wdc.com, Hongzheng-Li <Ethan.Lee.QNL@gmail.com>,
 Myriad-Dreamin <camiyoru@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Hou Weiying <weiying_hou@outlook.com>

First, sizeof(target_ulong) equals to 4 on riscv32, so this change
does not change the function on riscv32. Second, sizeof(target_ulong)
equals to 8 on riscv64, and 'reg_index * 8 + i' is not a legal
pmp_index (we will explain later), which should be 'reg_index * 4 + i'.

If the parameter reg_index equals to 2 (means that we will change the
value of pmpcfg2, or the second pmpcfg on riscv64), then
pmpcfg_csr_write(env, 2, val) will map write tasks to
pmp_write_cfg(env, 2 * 8 + [0...7], val). However, no cfg csr is indexed
by value 16 or 23 on riscv64, so we consider it as a bug.

We are looking for constant (e.g., define a new constant named
RISCV_WORD_SIZE) in QEMU to help others understand code better,
but none was found. A possible good explanation of this literal is it is
the minimum word length on riscv is 4 bytes (32 bit).

Signed-off-by: Hongzheng-Li <Ethan.Lee.QNL@gmail.com>
Signed-off-by: Hou Weiying <weiying_hou@outlook.com>
Signed-off-by: Myriad-Dreamin <camiyoru@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <SG2PR02MB263420036254AC8841F66CE393460@SG2PR02MB2634.apcprd02.prod.outlook.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/pmp.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 2a2b9f5363..b14feeb7da 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -320,8 +320,7 @@ void pmpcfg_csr_write(CPURISCVState *env, uint32_t reg_index,
 
     for (i = 0; i < sizeof(target_ulong); i++) {
         cfg_val = (val >> 8 * i)  & 0xff;
-        pmp_write_cfg(env, (reg_index * sizeof(target_ulong)) + i,
-            cfg_val);
+        pmp_write_cfg(env, (reg_index * 4) + i, cfg_val);
     }
 }
 
@@ -336,7 +335,7 @@ target_ulong pmpcfg_csr_read(CPURISCVState *env, uint32_t reg_index)
     target_ulong val = 0;
 
     for (i = 0; i < sizeof(target_ulong); i++) {
-        val = pmp_read_cfg(env, (reg_index * sizeof(target_ulong)) + i);
+        val = pmp_read_cfg(env, (reg_index * 4) + i);
         cfg_val |= (val << (i * 8));
     }
     trace_pmpcfg_csr_read(env->mhartid, reg_index, cfg_val);
-- 
2.28.0


