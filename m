Return-Path: <SRS0=NWXH=WU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73F2C3A5A3
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2019 00:08:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 981FF20850
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2019 00:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="B6EfHNDx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 981FF20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1Jbr-0002YK-Nv
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 20:08:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49976)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1JCa-0001Rp-PS
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 19:42:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1JCZ-0000P8-Ct
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 19:42:40 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:38476)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1314b2cac=alistair.francis@wdc.com>)
 id 1i1JCY-0000Il-Uq; Fri, 23 Aug 2019 19:42:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1566603760; x=1598139760;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bSg1Zkq8ZzQni09KJX5mI6uvxYi+5BNezHBmLct93A0=;
 b=B6EfHNDx1Sc4VwaFCG5hobhghCleuZ0GnLrL5zzBcQzjNX+dL63VDtlp
 3mzhPpBLgsDWpNxEsS7etV4X8KlbhU6FZsLi2VrFkmfWywdHhiu8+6Nur
 EeLNU6t2BaGMCJRO2sf6jv7luxtLfgxgNBLEGPVfhEwQRPLl1GFzk3WvH
 ZhrUn07BwnicaFWlc1aV6gBNlYCzHTuQuP0J5Xy7SXYwu+3ODF8Xwdxql
 7syUSICZPeeTOJ8oDkVC1MU6z4aO6A0+Rmwuox0+OEhdtCJlOYvktzH5p
 o+CF1GGdPM2ePOfMo+idY6A54nYmCCNTgJt/F5PlSuRa7Szxp3+rFlI+a g==;
IronPort-SDR: +GPxtk1aj8hcLamUk9Gtix53tXVhy0dK1xn7DIc9Ia1/Nje5c4mbCUbdD44ZkDDgTkKYReg7sc
 2YtxlIoGzqSiap7CTlUTDZrPr6TMggEfk7Qp2WXcI1IW/bkDUGUA47b2azQi9R31XdZ2akWHE0
 ZBXXwqGukWsvOv6QeTbzEcAjasY4L17xeoziLAMEaMYuJytaDQdsufK4H9F9TLtBmcZOwMfmrW
 e7jKiFndvr/odok+pmj7k9KpVHGepsHpW9sjFKAJW6gG+7j8WsC2WCi5rDTgxlkKa3nb/PYQc5
 1Do=
X-IronPort-AV: E=Sophos;i="5.64,422,1559491200"; d="scan'208";a="117486921"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 24 Aug 2019 07:42:39 +0800
IronPort-SDR: JB67y5N4G6jLpu2pdu/X56DcyJikeTro3okDasopgA6HNYS0xVCwWgm6ed3pbvvUvK4FIoUTjQ
 vTgp2o1dY3Gx4aGBHLXclJwLN+HzeFurHjqsyEaPj+ZEW1EujuJGFV1hjI+jnc4RdmOcKtcK+9
 y+FHKe/ZfKXeeIAvHGXb3zYetD/R9ZBcfXi0xp0aK/Syhywpcgf7c47WpVt8kz2pQWw3GTZzWF
 VGc16NdW5nktOu79jUoXOISe3mxCA8Au2deSzKr9p0fQQOQhVhaDdRvrK1TLQVFoF0r68CR7G2
 L6CfMfPeNVqH35LQi8W2qd5N
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2019 16:39:56 -0700
IronPort-SDR: D0w0J12ykULkSt0YsA9puseFk5LS2/430ZAZosLd2quHmfQSr71vcNjwV+M0Zugp+wQZ5A/2uy
 vMvsFg0BMoKZRPLcZ5jkyoJSx9q8S6aqDxpF+uOMkKEFr6PEkt1ljco2WwHLq4qhpdOXmimsG6
 P5LHn4Wft6zXVXdQ7W+UxzcMwdVPU0oOkW/IfDShPnip4OiAZULXypfhYTdcgX/N5/Z9xrbJdL
 x7vF1hWW507mJZjvpstdxALwUZsMO7V9qDarH4vHGEYOdBBGjcMQjJyquqljVqm9oyFi1+IUMB
 I3M=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip02.wdc.com with ESMTP; 23 Aug 2019 16:42:38 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Fri, 23 Aug 2019 16:38:58 -0700
Message-Id: <f4e877ca1f9fece2e25f1b8bc655d6e240208ae5.1566603412.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1566603412.git.alistair.francis@wdc.com>
References: <cover.1566603412.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.153.144
Subject: [Qemu-devel] [PATCH v1 26/28] target/riscv: Add support for the
 32-bit MSTATUSH CSR
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
Cc: alistair23@gmail.com, Anup.Patel@wdc.com, palmer@sifive.com,
 alistair.francis@wdc.com, Atish.Patra@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c        |  6 ++++++
 target/riscv/cpu.h        |  7 +++++++
 target/riscv/cpu_bits.h   |  3 +++
 target/riscv/cpu_helper.c |  7 +++++++
 target/riscv/csr.c        | 23 +++++++++++++++++++++++
 target/riscv/op_helper.c  |  4 ++++
 6 files changed, 50 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 371d5845af..06ee551ebe 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -229,6 +229,9 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 #ifndef CONFIG_USER_ONLY
     qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mhartid ", env->mhartid);
     qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mstatus ", *env->mstatus);
+#ifdef TARGET_RISCV32
+    qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mstatush ", *env->mstatush);
+#endif
     if (riscv_has_ext(env, RVH)) {
         qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "hstatus ", env->hstatus);
         qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "bstatus ", env->vsstatus);
@@ -468,6 +471,9 @@ static void riscv_cpu_init(Object *obj)
 #ifndef CONFIG_USER_ONLY
     env->mie = &env->mie_novirt;
     env->mstatus = &env->mstatus_novirt;
+# ifdef TARGET_RISCV32
+    env->mstatush = &env->mstatush_novirt;
+# endif
 #endif
 }
 
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 05957f32a8..b63f1f3cdc 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -124,6 +124,10 @@ struct CPURISCVState {
     target_ulong mhartid;
     target_ulong *mstatus;
 
+#ifdef TARGET_RISCV32
+    target_ulong *mstatush;
+#endif
+
     /*
      * CAUTION! Unlike the rest of this struct, mip and mip_novirt is accessed
      * asynchonously by I/O threads. It should be read with atomic_read. It should
@@ -164,6 +168,9 @@ struct CPURISCVState {
      */
     target_ulong mie_novirt;
     target_ulong mstatus_novirt;
+#ifdef TARGET_RISCV32
+    target_ulong mstatush_novirt;
+#endif
 
     /* Hypervisor CSRs */
     target_ulong hstatus;
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 353fc9a24a..55e20af6d9 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -135,6 +135,9 @@
 #define CSR_MTVEC           0x305
 #define CSR_MCOUNTEREN      0x306
 
+/* 32-bit only */
+#define CSR_MSTATUSH        0x310
+
 /* Legacy Counter Setup (priv v1.9.1) */
 /* Update to #define CSR_MCOUNTINHIBIT 0x320 for 1.11.0 */
 #define CSR_MUCOUNTEREN     0x320
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 0761191f11..8c80486dd0 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -949,10 +949,17 @@ void riscv_cpu_do_interrupt(CPUState *cs)
             if (riscv_cpu_virt_enabled(env)) {
                 riscv_cpu_swap_hypervisor_regs(env);
             }
+#ifdef TARGET_RISCV32
+            *env->mstatush = set_field(*env->mstatush, MSTATUS_MPV,
+                                       riscv_cpu_virt_enabled(env));
+            *env->mstatush = set_field(*env->mstatush, MSTATUS_MTL,
+                                       riscv_cpu_force_hs_excep_enabled(env));
+#else
             *env->mstatus = set_field(*env->mstatus, MSTATUS_MPV,
                                       riscv_cpu_virt_enabled(env));
             *env->mstatus = set_field(*env->mstatus, MSTATUS_MTL,
                                       riscv_cpu_force_hs_excep_enabled(env));
+#endif
 
             /* Trapping to M mode, virt is disabled */
             riscv_cpu_set_virt_enabled(env, VIRT_OFF);
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 47be4b1d42..b7d6d009dc 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -364,6 +364,25 @@ static int write_mstatus(CPURISCVState *env, int csrno, target_ulong val)
     return 0;
 }
 
+#ifdef TARGET_RISCV32
+static int read_mstatush(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = *env->mstatush;
+    return 0;
+}
+
+static int write_mstatush(CPURISCVState *env, int csrno, target_ulong val)
+{
+    if ((val ^ *env->mstatush) & (MSTATUS_MPV)) {
+        tlb_flush(env_cpu(env));
+    }
+
+    *env->mstatush = val;
+
+    return 0;
+}
+#endif
+
 static int read_misa(CPURISCVState *env, int csrno, target_ulong *val)
 {
     *val = env->misa;
@@ -1095,6 +1114,10 @@ static riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_MTVEC] =               { any,  read_mtvec,       write_mtvec       },
     [CSR_MCOUNTEREN] =          { any,  read_mcounteren,  write_mcounteren  },
 
+#if defined(TARGET_RISCV32)
+    [CSR_MSTATUSH] =            { any,  read_mstatush,    write_mstatush    },
+#endif
+
     /* Legacy Counter Setup (priv v1.9.1) */
     [CSR_MUCOUNTEREN] =         { any,  read_mucounteren, write_mucounteren },
     [CSR_MSCOUNTEREN] =         { any,  read_mscounteren, write_mscounteren },
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 5bcf5d2ff7..8dec1aee99 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -153,7 +153,11 @@ target_ulong helper_mret(CPURISCVState *env, target_ulong cpu_pc_deb)
         get_field(mstatus, MSTATUS_MPIE));
     mstatus = set_field(mstatus, MSTATUS_MPIE, 1);
     mstatus = set_field(mstatus, MSTATUS_MPP, 0);
+#ifdef TARGET_RISCV32
+    *env->mstatush = set_field(*env->mstatush, MSTATUS_MPV, 0);
+#else
     mstatus = set_field(mstatus, MSTATUS_MPV, 0);
+#endif
     *env->mstatus = mstatus;
     riscv_cpu_set_mode(env, prev_priv);
 
-- 
2.22.0


