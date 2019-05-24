Return-Path: <SRS0=E2zY=TZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3A0C282E1
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 00:08:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 576E420862
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 00:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HCIMtlag"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 576E420862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33534 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUKF0-0006Yp-IU
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 20:08:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=040baf4f1=alistair.francis@wdc.com>)
	id 1hUK3x-0005Im-6T
	for qemu-devel@nongnu.org; Fri, 24 May 2019 19:57:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=040baf4f1=alistair.francis@wdc.com>)
	id 1hUJv8-0004eF-O9
	for qemu-devel@nongnu.org; Fri, 24 May 2019 19:48:19 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:5520)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=040baf4f1=alistair.francis@wdc.com>)
	id 1hUJv8-0004TN-8W; Fri, 24 May 2019 19:48:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
	t=1558741698; x=1590277698;
	h=from:to:cc:subject:date:message-id:in-reply-to:
	references:mime-version:content-transfer-encoding;
	bh=C5UgGc4V2pAKfw6v1wYMZEJGSRpC8Q7ki2tjMjGBTmM=;
	b=HCIMtlaggTn3+X+GxwAPn/FGyUfY+jsrVkrABtcl0gWC/k/WSWo4Qqhz
	uWlBQhD4FdH+gz2Zl9UPfmLg3ZhyxE7ltd5p/yEtNL5D3RGxMkGyBlf+3
	eIKwNmUtRyEFI2V9IqFDw5CWWZt08vp7404CmCSpGrw7jUS4/vHTCbjYb
	8FTqQ8EWiwFS6J7y6xTZ3cs724StwPWbgjQ6L2nnvUHFKX05H39MvlnWY
	ebU/NayfMWGQZ1J80VCeyN8SJA/+yHJNgao4ZuFkdBlt+C5MaLUsmee+C
	sRrFH2rpy8VuQYiBshrZ3y+QpOiyqS6CWyT2kECBFGs9fb1tJGewRM3rq A==;
X-IronPort-AV: E=Sophos;i="5.60,508,1549900800"; d="scan'208";a="215265026"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
	([199.255.45.15])
	by ob1.hgst.iphmx.com with ESMTP; 25 May 2019 07:48:17 +0800
IronPort-SDR: 1KyMA9vfDuVoFL1cp5qW2dNdD5mjxhRbuSNo03A1OrLltZBWwrKlYT/j28L+4plKp8m2uugDvc
	3gem/qgxcyC41Hlc/tS0td3oUqy9XzwusROm9DW8fqrdQd5z+2YwhdzNIhczpvs2ZPu8VNUq7B
	14WPNC5VMqfoEjfjA52qbIY050L1lAVaSNqKVkmPJNMqybD8RDVeM6Ilc48KC0DeSRaylxpR7K
	Upkt2aCbyS4jhDiKhLenarowY71wuO6u3+bdpxQN/oGJ8XLbghQqWkk5s9hJBcS/0beBSvzK9B
	mSWlubxtzH2EdA63WMaiLWB6
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
	by uls-op-cesaep02.wdc.com with ESMTP; 24 May 2019 16:25:57 -0700
IronPort-SDR: NmYa43uZ6yHTlFScaKaRWilrsdDFi/yS2evywLq6hxOpsXeZVX5QGF7xNfsTJWI3BcgLGZvcnJ
	wKsTxASjHYSpEoFOjAZvYsVM3791UGGoNTMt9NVPfKy8fSCUN07bfPoN//OJDL+WVImqTlv3Xn
	FTBBVLl67Nv0zSIAq+WJTRC2vTPtPKa3kzfPdNwS9w413IbtaF3XUnOknRKRgodsEOHwU9+qGZ
	jSGh0r6NAos6pc2U/K3/KZdXizOXPbVPSLU0XPncN5poqm3cg20NHEbYbKNMr7/JbVq1Iskoof
	Fnk=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
	risc6-mainframe.int.fusionio.com) ([10.196.157.140])
	by uls-op-cesaip02.wdc.com with ESMTP; 24 May 2019 16:48:17 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri, 24 May 2019 16:46:23 -0700
Message-Id: <68722b887546714923b1d23cea80042f0cd0b8ba.1558741334.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1558741334.git.alistair.francis@wdc.com>
References: <cover.1558741334.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 68.232.141.245
Subject: [Qemu-devel] [RFC v1 18/23] target/riscv: Add hfence instructions
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
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
 target/riscv/insn32.decode                    | 23 ++++++-----
 .../riscv/insn_trans/trans_privileged.inc.c   | 40 +++++++++++++++++++
 2 files changed, 54 insertions(+), 9 deletions(-)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 6f3ab7aa52..6c79c5fd0c 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -59,20 +59,25 @@
 @r2_rm   .......   ..... ..... ... ..... ....... %rs1 %rm %rd
 @r2      .......   ..... ..... ... ..... ....... %rs1 %rd
 
+@hfence_gvma ....... ..... .....   ... ..... ....... %rs2 %rs1
+@hfence_bvma ....... ..... .....   ... ..... ....... %rs2 %rs1
+
 @sfence_vma ....... ..... .....   ... ..... ....... %rs2 %rs1
 @sfence_vm  ....... ..... .....   ... ..... ....... %rs1
 
 
 # *** Privileged Instructions ***
-ecall      000000000000     00000 000 00000 1110011
-ebreak     000000000001     00000 000 00000 1110011
-uret       0000000    00010 00000 000 00000 1110011
-sret       0001000    00010 00000 000 00000 1110011
-hret       0010000    00010 00000 000 00000 1110011
-mret       0011000    00010 00000 000 00000 1110011
-wfi        0001000    00101 00000 000 00000 1110011
-sfence_vma 0001001    ..... ..... 000 00000 1110011 @sfence_vma
-sfence_vm  0001000    00100 ..... 000 00000 1110011 @sfence_vm
+ecall       000000000000     00000 000 00000 1110011
+ebreak      000000000001     00000 000 00000 1110011
+uret        0000000    00010 00000 000 00000 1110011
+sret        0001000    00010 00000 000 00000 1110011
+hret        0010000    00010 00000 000 00000 1110011
+mret        0011000    00010 00000 000 00000 1110011
+wfi         0001000    00101 00000 000 00000 1110011
+hfence_gvma 1010001    ..... ..... 000 00000 1110011 @hfence_gvma
+hfence_bvma 0010001    ..... ..... 000 00000 1110011 @hfence_bvma
+sfence_vma  0001001    ..... ..... 000 00000 1110011 @sfence_vma
+sfence_vm   0001000    00100 ..... 000 00000 1110011 @sfence_vm
 
 # *** RV32I Base Instruction Set ***
 lui      ....................       ..... 0110111 @u
diff --git a/target/riscv/insn_trans/trans_privileged.inc.c b/target/riscv/insn_trans/trans_privileged.inc.c
index 664d6ba3f2..ac953ad30d 100644
--- a/target/riscv/insn_trans/trans_privileged.inc.c
+++ b/target/riscv/insn_trans/trans_privileged.inc.c
@@ -108,3 +108,43 @@ static bool trans_sfence_vm(DisasContext *ctx, arg_sfence_vm *a)
 #endif
     return false;
 }
+
+static bool trans_hfence_gvma(DisasContext *ctx, arg_sfence_vma *a)
+{
+#ifndef CONFIG_USER_ONLY
+    if (ctx->priv_ver == PRIV_VERSION_1_10_0 &&
+        has_ext(ctx, RVH)) {
+        /* Hpervisor extensions exist */
+        /*
+         * if (env->priv == PRV_M ||
+         *   (env->priv == PRV_S &&
+         *    !riscv_cpu_virt_enabled(env) &&
+         *    get_field(ctx->mstatus_fs, MSTATUS_TVM))) {
+         */
+            gen_helper_tlb_flush(cpu_env);
+            return true;
+        /* } */
+    }
+#endif
+    return false;
+}
+
+static bool trans_hfence_bvma(DisasContext *ctx, arg_sfence_vma *a)
+{
+#ifndef CONFIG_USER_ONLY
+    if (ctx->priv_ver == PRIV_VERSION_1_10_0 &&
+        has_ext(ctx, RVH)) {
+        /* Hpervisor extensions exist */
+        /*
+         * if (env->priv == PRV_M ||
+         *   (env->priv == PRV_S &&
+         *    !riscv_cpu_virt_enabled(env) &&
+         *    get_field(ctx->mstatus_fs, MSTATUS_TVM))) {
+         */
+            gen_helper_tlb_flush(cpu_env);
+            return true;
+        /* } */
+    }
+#endif
+    return false;
+}
-- 
2.21.0


