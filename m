Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB95C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:39:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49BCF205C9
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="psCN3Lvv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49BCF205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieNwd-0004U3-1f
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 13:39:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35006)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNb7-0007ql-Nv
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:17:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNb6-0007d1-D8
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:17:29 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:7440)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNb6-0007bZ-1j; Mon, 09 Dec 2019 13:17:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1575915467; x=1607451467;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vN6o0dZpHm0oV+OSAmW+Ui7wdnFhydJVMrrsosLmgDU=;
 b=psCN3LvvM0kkLI+V/VHLck8tYrSD5nRXnOBZ3B0pE6Ecw9Az5zMFmDq9
 MUy4iaG6AwuXWIMmtzbcClOW6+JZI9cif//qmRskJfAaz6g0YmuaE8MyP
 NjhMPpmbU8p/EeyKvWl4iaMukm+DtnyD5bAyJCZ6xJB+XtIuEVXTz6HFg
 e18pGlQ8drqROKDdkO1Yghc6HUhgAbHsIEN3yHnCQz6yIbbyv+cEk84nb
 VFBb78K8n0e++kjwsZpmE7LlzvP6/TlNNyRsfZ+PKWyQf/s3NdlcjA9ew
 vto5aTIp5dBjWGeSFPcSjJgLUC7j5kuuaDOjSEX/v2C82UFRG7UoHmeFu w==;
IronPort-SDR: 5Lvvnut/voEQczWCHVQ9A3vVF42R5ZjRG1Ysn8lxDD3HI12QhskPQ8W+hYdpAv2aWiHEpr92vZ
 oNEAMaKxtoomsQJBDmEx16fLjOeM6Aj/KZNUM0tdP9R3kngek/OzrhF/ZspST8cAa8dzlFiXvN
 KY/vZC1LwuczVhbmS1CK8PBCfqCtUuEkH/njDX2aIJgCUNnnE78eQR2i35VgqG+wJtV0eWOP3a
 5yAdo0jIEGovUXTUDdgOTkPH5/tbU9HuZ2g/VKRrVvxeLht7tsFnypzEI2eBZEb+tP3HXSL31S
 oX0=
X-IronPort-AV: E=Sophos;i="5.69,296,1571673600"; d="scan'208";a="226412012"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2019 02:17:46 +0800
IronPort-SDR: SdQIKaryrTY9BE/2Obu9/YWAUrpQm/bpXrRsKOX2cWs9Rk57a198Enx1+n4RF2W4teBn/zkPdR
 QEWguLJS+XMhLsJN7TNbLAwrdxdg+AFjQuDaMRMt7aZztGrQmLVuRqCKdZfRm1p6Ro3PQouPY2
 HBTd2MQOweI9ONCzyL4x88eiyVQdiVeU/ZS3VsbIr1decokl/+f5y0HplVLEd9Z7leSFZrSoKz
 4R9ujPFnIWs7WCqHMlqPKBGjHeyjGBimyJ2sXNkTffoI9HIWb0Yo7pqEg/bCsFj2gBWmqHZ+RT
 ZPHJcxukOcgjIMwsxJAgLlPD
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2019 10:12:05 -0800
IronPort-SDR: RHky0IevzGlWBoH1MQwOGPK2ASya4yX+9XwkcVJnwWagfL1oXxYW1MFzUb2M984t7iA7FiLUCz
 Sa5ZTfkR3LR7lfJvjzGT93BF5oXkmMAu7nj6PmLCDmTggFFDUVGd8YJNi/SBlxiWWPMkqyre9f
 VRYgiys59SPd42Tuwbjvmwjcac+mbZ5Qj5XGMqppfoX/QAcjfpcFdSqnvNdr+W+typjAjpydca
 RBMZNAJd5mcEFTvokYHC/r3OHbPJzC1IAP/8LpFD4/zgBaUJT/qUqCDIpBHD9RutvGUR+/Tc6o
 Jn0=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip01.wdc.com with ESMTP; 09 Dec 2019 10:17:28 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 25/36] target/riscv: Add hfence instructions
Date: Mon,  9 Dec 2019 10:11:46 -0800
Message-Id: <9b873349204749fb786fe4801d0b67f9d20933fc.1575914822.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1575914822.git.alistair.francis@wdc.com>
References: <cover.1575914822.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 68.232.143.124
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

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/insn32.decode                    | 23 ++++++-----
 .../riscv/insn_trans/trans_privileged.inc.c   | 40 +++++++++++++++++++
 2 files changed, 54 insertions(+), 9 deletions(-)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 77f794ed70..cfd9ca6d2b 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -63,20 +63,25 @@
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
+hfence_gvma 0110001    ..... ..... 000 00000 1110011 @hfence_gvma
+hfence_bvma 0010001    ..... ..... 000 00000 1110011 @hfence_bvma
+sfence_vma  0001001    ..... ..... 000 00000 1110011 @sfence_vma
+sfence_vm   0001000    00100 ..... 000 00000 1110011 @sfence_vm
 
 # *** RV32I Base Instruction Set ***
 lui      ....................       ..... 0110111 @u
diff --git a/target/riscv/insn_trans/trans_privileged.inc.c b/target/riscv/insn_trans/trans_privileged.inc.c
index c5e4b3e49a..b9b5a89b52 100644
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
+    if (ctx->priv_ver >= PRIV_VERSION_1_10_0 &&
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
+    if (ctx->priv_ver >= PRIV_VERSION_1_10_0 &&
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
2.24.0


