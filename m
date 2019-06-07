Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4BB8C468BC
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 22:21:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 824202146E
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 22:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XswQsVbu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 824202146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53764 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZNEu-0002Qc-Qd
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 18:21:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48190)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=0547f94d1=alistair.francis@wdc.com>)
 id 1hZMsm-0004xW-NV
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 17:58:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=0547f94d1=alistair.francis@wdc.com>)
 id 1hZMsj-0002Mp-1Q
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 17:58:42 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:5597)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=0547f94d1=alistair.francis@wdc.com>)
 id 1hZMsb-0002G5-4s; Fri, 07 Jun 2019 17:58:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1559944713; x=1591480713;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=g/Uwz4lDVLWeFKaIssKUkLrYCwbb8YpdK08EwfG+Gdw=;
 b=XswQsVbue+rPDOu7WGxTqMapOv7m7wPCliLhCbLDgTWKDBOjf+7zWwfr
 JzNDKkYJ/Dt+HHB50aAoaSOGEETxuU1gYjR4yYAc6vHIcMkjO87V9TOWJ
 aHMEZNa0E38LT1Au0RUG2HCXwC9T6llPSapXL5NQ9n5FyXPmlb1029XW/
 xv/kHZRYGsmoWg2HBTXa0/MNfh6F8yEqF5RV1ZvegNEzJPvuF1MSzayN3
 HUYMFh77UzxeXZei6HcAkApbfAfptQ6OLhCoS08LuPAjnRlae0tGHuwar
 kr28NLZRz35/JPnfU8Ok+AoymnA9Pra2kwkQ4X3/30kOJA/re/mbMNDEL Q==;
X-IronPort-AV: E=Sophos;i="5.63,564,1557158400"; d="scan'208";a="110059639"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 08 Jun 2019 05:58:30 +0800
IronPort-SDR: eHVB5bLV7k5DMHDbI56eSzYyBneBU0fEesIZS1cBL0DgADTMQtOhDwEa/Zn3aYHDPTwAeW61j2
 ebXapWJP87+VJBLU+xVVoD5ZvJTMcNGB7WI+WnIoaWNnAee7lneeUeZtOMJHtuFH65ZHOxyfw5
 62i2dWKc0wJrS9KFDmf0xXT5BkEYtKCrERfhruYOeSc4y6AzFRYVYfc+EbyzFgSWSPQKK3qNr6
 rYRgTiWM1rSO10iVpCwjSn9J8NdklluWan40Ts57YHwlNixlI53WC19GaccfDGm4Dn/E+Vs1P+
 i8pMy3U6f16XYJysW32QzPF2
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP; 07 Jun 2019 14:35:47 -0700
IronPort-SDR: 0jtIU4J3x1e0SdRB6DAcOj92+ICDAAoH3eysqBXWqGsLOrvIir7/nleMujJ2PAbEhZsCtG034k
 UenJ0aUq0LjYu4139SZbsXCmfYUXdmIWbotLL2NQ3t8okrNsyYD/zp/GCPe2vK46hxnZJQ+4gj
 k5AyFPse51OMtMsgXfMOqIf9sVUfq+smxK86JXIZHl1YsGpmt0izXVN09D0umIcoUtOpmbXXWo
 tsCbYfiJWZCS0E7OZicbp74r1Fxx0MgBbymQJp8ljotVWsKslLUAL3wiYwDIPoQih16RC8nDxh
 rsk=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.140])
 by uls-op-cesaip02.wdc.com with ESMTP; 07 Jun 2019 14:58:30 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri,  7 Jun 2019 14:56:20 -0700
Message-Id: <7c96977698624556f5cfe6cc0e429cc465c7e5f6.1559944445.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559944445.git.alistair.francis@wdc.com>
References: <cover.1559944445.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 216.71.154.42
Subject: [Qemu-devel] [PATCH v1 19/27] target/riscv: Add hfence instructions
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
 target/riscv/insn32.decode                    | 23 ++++++-----
 .../riscv/insn_trans/trans_privileged.inc.c   | 40 +++++++++++++++++++
 2 files changed, 54 insertions(+), 9 deletions(-)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 77f794ed70..5bbf6add9c 100644
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


