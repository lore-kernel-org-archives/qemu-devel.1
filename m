Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179A8CA9EA0
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 00:43:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E06A205ED
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 00:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PDXOLoG5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E06A205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOAAx-0005XJ-I8
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 20:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49841)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=194c68654=alistair.francis@wdc.com>)
 id 1iO91B-00059A-1E
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 19:29:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=194c68654=alistair.francis@wdc.com>)
 id 1iO917-0004U7-GD
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 19:29:15 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:36801)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=194c68654=alistair.francis@wdc.com>)
 id 1iO914-0004Sy-1d; Fri, 25 Oct 2019 19:29:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1572046150; x=1603582150;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dMKqeONfKcctIWBRru6Nk23YmXDldC/KGUfehKsR0KY=;
 b=PDXOLoG5QfCvC7wUCyGyMQdjBgyqbsHta7LY4SeACaJ8IO7rKxN+xntc
 5Bcx2Zd3KdVwohja9siaPVD6KDonQsIRtGBEZkSl9dtrxUw4JVU+iugxr
 mlfjlPlE7JWF/kyIax30wJor+i09t10NCS4kcX7XY0xPR9enCa6OZGu7e
 NmohxI/Tud5fOPwzbj+Pc1cC7NGhDK9ux18Xj9HCRU/nQqfJuoICPCe9e
 IWL5mLfH92+9U0e9+LITNgUNguub7cQW+eQM7QVPzMVtb7IYfUiq/WMo7
 /OUyEuyp+PDYrIyrb2ow+B70FEYPH+DwsaM6RRnLFF0Y6+VmE4gSgVlPE g==;
IronPort-SDR: 0rbuNeuXF6rdV+bQM853tcoqfOKyYByGC3tBCENodf8lN6dly495qN7WbuIeYBS6bgtQjytdAh
 IZhRxxSJx1ENMw041MXrJpnosbvufugUboMa10R3vD1ikOQl5hJLT9UP6kqlKh2T5etKBrO5Pp
 089VT6oMlzKo/wNWTRasu+l10raDoop9dQRUu9HUXq7j30vutd7QD/cO7XeBLB8y8At9GdfUEu
 pQtBg4Quu07+nx2YSGl3x8G2F2XDzWNNt8al74jdKZoIJ3f1guckr7Aty3m3+WXQpIU9UK6LtE
 HFk=
X-IronPort-AV: E=Sophos;i="5.68,230,1569254400"; d="scan'208";a="122956680"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 26 Oct 2019 07:29:09 +0800
IronPort-SDR: w4RoC75gdiYQXCzXk/7nwb67McwtBOSlPp+2Tfg2p6+2O8XROP1E2AjYQK2y0iO4ThgCB1VsDK
 K/UYBss53qJWCnvVyI1jl2EIfAO8XkFaCbh1GiCeX5TWkD7+qbWIv40m017uO4sWb+JrIR6bfb
 YmUuW8J1bg+srOljHsQJ4NnON3moEcPpku3VO9bRfZPCZRPJehvPYXNfe7MisJ9uJpWbFkzUsH
 Ya+p5qeP3UEnPs/n0uuIAWzD7bJYDt41FoTdv3DzRCMJVicRC+qmr8zjOSnKGY+wqgZeAlwBnN
 4UKpSAwvkytKtezZGpK4QhMw
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2019 16:24:35 -0700
IronPort-SDR: UQISS66IE+rA+uCpRMrcdMKu7CEvkJkSJiM/5ebQfNi0RHnB8sXiMUyFNAASbq74YzuYqKi89o
 6kdUiTsYLyKDYokRUK/uZLoARiY0e5Z6ekOlFl1uCtDA6dhJ62mDnwMjzYNVw5YM1w3yG+EoWf
 mwZCNY1F5JlFjQmSow5sF0ci7A9RO2vMm1EJLIC7rGPpBFACKUrRH/YWAAbmFSHRGvlI192TJQ
 q3tfsoamngr2CQVp5o7+LmTAoN0TRMbSXA/X7AKldHgC6/YhGjPz5HERqXa2gxDoYAZwUtDQ/b
 g9Y=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip01.wdc.com with ESMTP; 25 Oct 2019 16:29:09 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 19/27] target/riscv: Add hfence instructions
Date: Fri, 25 Oct 2019 16:24:13 -0700
Message-Id: <13c3cf8969b1c4c2a8c593501d4148041881a5f5.1572045716.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1572045716.git.alistair.francis@wdc.com>
References: <cover.1572045716.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.154.45
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
2.23.0


