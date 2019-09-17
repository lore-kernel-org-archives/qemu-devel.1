Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE99C4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 23:31:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A93C6206C2
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 23:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Y9ZAc2WO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A93C6206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAMwA-0007BH-PS
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 19:31:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50796)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=156d039a9=alistair.francis@wdc.com>)
 id 1iAMsL-0004D4-7c
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 19:27:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=156d039a9=alistair.francis@wdc.com>)
 id 1iAMsJ-0002eo-4e
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 19:27:12 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:35346)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=156d039a9=alistair.francis@wdc.com>)
 id 1iAMsI-0002eD-S6; Tue, 17 Sep 2019 19:27:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1568762830; x=1600298830;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2aGksb+6wpuxxwZws3oCDFLqyYmlLrKjPA5jBwu9NTY=;
 b=Y9ZAc2WORRg+YpS00iCnYrCLOXUaZYszRigOv0t/30N/fwz3PSQXtkFa
 dAmCbQo7frp3ag16nX77JILrFdOJ4ysAbOmQmHuQ8LTvpJV4FTjuWoadH
 qkQPC0AFVip69w3dz8tmiWpmDRWWGqzLaZHSyAiF7yrs5/YG1gbfGUuxz
 rXS+L9GPNA2PK1+dwo0l0RFpByb/qgKaIITKYF3M7xHtQtDcNDhiYeWc7
 HhnSLp7PjdLRUoZX8rEsWgU+2FVtLsSRo40NjFEoVZB0PHZoP9TSJZ8p8
 oHOUhCIja8R/DJWjCgNu3C/F/rxfiQ4xZDZ0oHWoHj8SyEIz0CsYjNGse A==;
IronPort-SDR: AI5nK1U84UGyIIDDEMf4RoB2X9DshPwcCtwhaI8eJNSuKCzsJekB5jOemkfb3MCVTcGW3JcBmx
 cHZhlnlYwK21sRO8EJ3FIr2FY4tCEEloQG/qdVZhG8mCi0hwS6mO4V3QuIcDi+wLDIrn/kbmep
 m1LZuTFuOlLEf0DapQj4vBAoSe2vaQBnI+MBkHQlKVGHHL5EI+5AwfzC8vS/k/iQYfsOyGBlNi
 S131maryacValclBeow1OaXiTZiigBQ5RIlGyKRkduvPqBleRfrkHGTO0RGy5Y1ibqr+DZHS+G
 ELk=
X-IronPort-AV: E=Sophos;i="5.64,518,1559491200"; d="scan'208";a="225302172"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 18 Sep 2019 07:27:05 +0800
IronPort-SDR: O5URhE8TvMq2t+Y4EKR9+nkGUtFsj6GOlGxNFWf//BFS9wfJXpgKWPs9j5QbOsYoLKeYeS/rfS
 G62onOETpyyX6L7VuiQTv+rg+OIzspTbcANxhKgnOLAuJWyxZJeb5Ds2W7dUQRqYqrD57Hqmgr
 vmr9n85TCCNqws8Jygem0/x/5W2wKTPRu20PN+SEvp1TpfpfHOXRFCwOeYoWS3hBigppRi2Lht
 BVZKKUnpWuznGsWbeARuu8FW6u7CCTByu6ArZOeX2Wfr0UZjEmeJVNBThUM0f2adaut732oUQ/
 kO3mxM9orwE3Jo/hcskdyqa+
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2019 16:23:41 -0700
IronPort-SDR: IRhbjgdMNR7UFyaMIsQfrocbBMmGagBFmaNQTNdjhZeYmn4NQXClG+1RcUtGI1hI7XCN8jsq1C
 HMfHtvKiXvehGoT71hWbQiOlZrtPMIL0zbUN9YWfO51ZaD58KXQi9MoPh09usI2YbE87RJuR7p
 T1AeS/YuMYY9YxsEHg0nHXbIRxAErX5NZr5nJMCpVNQlvg1DA/PBbZApFecEjtOGogjNVACiI4
 6MO7XW08XC2hB+jew/ACUOv4tF8yOT4H0yKaFHdKu3BduKHqRRuqKhsDfr8GtX1y8iiYNZDeNB
 reQ=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip01.wdc.com with ESMTP; 17 Sep 2019 16:27:05 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Tue, 17 Sep 2019 16:22:59 -0700
Message-Id: <dfb8bc9fb7cad494d53f89774a3a4a5f3e478792.1568762497.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1568762497.git.alistair.francis@wdc.com>
References: <cover.1568762497.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 68.232.141.245
Subject: [Qemu-devel] [PATCH v1 1/2] RISC-V: Handle bus errors in the page
 table walker
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
Cc: peter.maydell@linaro.org, palmer@sifive.com, alistair.francis@wdc.com,
 alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Palmer Dabbelt <palmer@sifive.com>

We directly access physical memory while walking the page tables on
RISC-V, but while doing so we were using cpu_ld*() which does not report
bus errors.  This patch converts the page table walker over to use
address_space_ld*(), which allows bus errors to be detected.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 87dd6a6ece..c82e7ed52b 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -169,7 +169,8 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
     /* NOTE: the env->pc value visible here will not be
      * correct, but the value visible to the exception handler
      * (riscv_cpu_do_interrupt) is correct */
-
+    MemTxResult res;
+    MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
     int mode = mmu_idx;
 
     if (mode == PRV_M && access_type != MMU_INST_FETCH) {
@@ -256,11 +257,16 @@ restart:
             1 << MMU_DATA_LOAD, PRV_S)) {
             return TRANSLATE_PMP_FAIL;
         }
+
 #if defined(TARGET_RISCV32)
-        target_ulong pte = ldl_phys(cs->as, pte_addr);
+        target_ulong pte = address_space_ldl(cs->as, pte_addr, attrs, &res);
 #elif defined(TARGET_RISCV64)
-        target_ulong pte = ldq_phys(cs->as, pte_addr);
+        target_ulong pte = address_space_ldq(cs->as, pte_addr, attrs, &res);
 #endif
+        if (res != MEMTX_OK) {
+            return TRANSLATE_FAIL;
+        }
+
         hwaddr ppn = pte >> PTE_PPN_SHIFT;
 
         if (!(pte & PTE_V)) {
-- 
2.23.0


