Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26659CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 23:50:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E145821D7F
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 23:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="i0Y9h7iU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E145821D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO9Lc-0002dk-3l
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 19:50:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50111)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=194c68654=alistair.francis@wdc.com>)
 id 1iO91Q-0005ds-Bt
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 19:29:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=194c68654=alistair.francis@wdc.com>)
 id 1iO91O-0004i8-SI
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 19:29:32 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:36814)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=194c68654=alistair.francis@wdc.com>)
 id 1iO91O-0004Yx-Kc; Fri, 25 Oct 2019 19:29:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1572046170; x=1603582170;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BA5fvA5aoIgFzhf1d94fNJ4m/Qu88LfaZFsp34tszgw=;
 b=i0Y9h7iUmZd1AbU+u4+0ehVGho3rKSjXvIC7H2n/4O3K9YofmkM9fB+k
 hDectbS7LUrqdCZ4Mo4Qivg8HIJP4wn9ojW/PyhidZQFthwwc7s+qZpdq
 aPRHfbmi04aXI+J2sjpaXqsR/SDE+zDgfaR6OL/vApGbxw+z3usZu2ykD
 uSEPYdNBju7++/MK7bxtM3PWVZwWTV26tIUw0Cv1F7VIPgOPbhpD9htzw
 /J9nNdfjDsyM9sw0yz2E/WMlaEAcH6SsV/b58vE1sWp6sE/L7C3egDHNJ
 /uaQzXUp+6OuLzWM2cCC4fae9Pf/x1GQiSFV/CkDCCH40pMzLTUDh4IOG A==;
IronPort-SDR: K+SA30MWdlpo/1NDmVcW8ngzT++xdYWxuuXTJaNkFz7B/0Phr5kdzvYoCDDrXhay3t5IRDZIaO
 W67GlJ/9PQcC/+EGfbnrQAVuYkc8Nh+kNgdd2m5wRoDIooHbWbYTKIhn11YhX9ux7vT1amWAEO
 q4/2weoTS4pEyaXtSD/jfPb1omcFpHGZm7TB0Ku0jlTQczMXOnBn5zcl+bY+SWo+ZjQdesm/lM
 ufSzxSTurV4U60H2deYwCvz9OjyAWMXVTkc03d9uR1OCcGXg/k1XQeu2ZGM0kp0U/bDR9sjjqJ
 iBU=
X-IronPort-AV: E=Sophos;i="5.68,230,1569254400"; d="scan'208";a="122956705"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 26 Oct 2019 07:29:30 +0800
IronPort-SDR: tK7oDX1Yx69JDVkAPMg52rodn7dzTmijxOj0oHdJ3RC0P047VJWXnzrVrgUMz/+4nBbb4PAIl3
 G0eZIM+dEUmeDN+N0iLEUJ6W+GD+B8KvzRjz9Mn61aNYuNE+ZgpkPraczbSoriFaz2s+2/DHn3
 iCXmqT2Gw+dMNkJk91r8vVCGE8nDpsHoACvcSjD8zk3XfHQosSHpug8R0jbvRr22xROshCuGzt
 ec0esog8rDqa9uDODjeOBsX892jbaKI/W7iJ9CuTCjv3M3WzYAgq1hUgxDV64vW/jpYXlIuWxT
 PqMfa3F9DlrcDxdTA3l6OVCi
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2019 16:24:56 -0700
IronPort-SDR: PMbTmgifm+7U+CbeM25KVoXXU2sowWTbw7XHTuXhj3H+0sbAdcRsz6Z/3X+iRsRleTJjI19MD1
 P8+EiXwXMco94iC4HqEF5Hz/Iww+zqvbCvRrVmPdqxOMPbeO2xDMBvP1o+r98c9tCEo+czv0cq
 kn+zShnD5Br1l+VVUZy/3ZLrAmME1fRfMtan6fgk1yIoD4u6gBdqJFGPOVmhp7hl/B9JW4nJ8s
 KEgAyDRsHwvDK4Agn/I4YI7JiItzH/NicwtftFEYgQwiofbk0H37skcpCQjACXVeF+OlKmMpGY
 hks=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip01.wdc.com with ESMTP; 25 Oct 2019 16:29:30 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 25/27] target/riscv: Add support for the 32-bit MSTATUSH CSR
Date: Fri, 25 Oct 2019 16:24:34 -0700
Message-Id: <c667ad7d7f9a2f89ba6859f01cf4e1adf7710f7d.1572045716.git.alistair.francis@wdc.com>
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
---
 target/riscv/cpu.c        |  6 ++++++
 target/riscv/cpu.h        |  7 +++++++
 target/riscv/cpu_bits.h   |  3 +++
 target/riscv/cpu_helper.c |  7 +++++++
 target/riscv/csr.c        | 25 +++++++++++++++++++++++++
 target/riscv/op_helper.c  |  4 ++++
 6 files changed, 52 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f75c709e35..03622825f3 100644
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
@@ -467,6 +470,9 @@ static void riscv_cpu_init(Object *obj)
 #ifndef CONFIG_USER_ONLY
     env->mie = &env->mie_novirt;
     env->mstatus = &env->mstatus_novirt;
+# ifdef TARGET_RISCV32
+    env->mstatush = &env->mstatush_novirt;
+# endif
 #endif
 }
 
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 0ea56f9059..b8b731df43 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -127,6 +127,10 @@ struct CPURISCVState {
     target_ulong mip;
     target_ulong mip_novirt;
 
+#ifdef TARGET_RISCV32
+    target_ulong *mstatush;
+#endif
+
     uint32_t miclaim;
 
     target_ulong *mie;
@@ -154,6 +158,9 @@ struct CPURISCVState {
      */
     target_ulong mie_novirt;
     target_ulong mstatus_novirt;
+#ifdef TARGET_RISCV32
+    target_ulong mstatush_novirt;
+#endif
 
     /* Hypervisor CSRs */
     target_ulong hstatus;
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 17d168852c..a2358c4956 100644
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
index b3ce345f81..79b2f30876 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -950,10 +950,17 @@ void riscv_cpu_do_interrupt(CPUState *cs)
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
             riscv_cpu_set_virt_enabled(env, 0);
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index a795a02968..8a093abdb2 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -364,6 +364,27 @@ static int write_mstatus(CPURISCVState *env, int csrno, target_ulong val)
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
+    val &= MSTATUS_MPV | MSTATUS_MTL;
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
@@ -1102,6 +1123,10 @@ static riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
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
index e5128570e6..a0a631d722 100644
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
2.23.0


