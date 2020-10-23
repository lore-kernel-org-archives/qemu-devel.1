Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50CE8C388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:12:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9E5C208B3
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lfJ9H/Jv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9E5C208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVzgL-0005gh-DB
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 12:12:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37410)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=558518344=alistair.francis@wdc.com>)
 id 1kVzFy-00031L-1Y; Fri, 23 Oct 2020 11:45:32 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:6195)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=558518344=alistair.francis@wdc.com>)
 id 1kVzFi-0003lZ-T7; Fri, 23 Oct 2020 11:45:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603467915; x=1635003915;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dA/j7k0iZxbv9GK+9DV55QACBClboYEOT9u77fvDdZA=;
 b=lfJ9H/JvTYuv6uE8MZqzo81B6qDPzn4ketyH5+prtKj8cURoIBLK5kFd
 P91PoHXxsD8Oh+nZihkpcp95GewdjhxtoUWKnohDaOuoUxqdiqanqrR3b
 4sTAfZUeWxyp1j2QjCdDdvTu27/eQR9pqIGGI5/Nxir89GMTxbwBbHFCs
 rkqv7D9J20c9XI2NsktPCRnfgYXZRgF9LcoDrvwF00LQykw0Q8wiemkZh
 32BNl90wD0xTIaSVf8GGaVjAD3f6qAOEmhboEP0JS2nKmrWFfWOHXUkQx
 Gfy+LK6DR/ZYFSCSii6kp6S295icnnriU6kdNyUQlrDmkMNfjeUyyrTJf A==;
IronPort-SDR: tLQlkx0hd4BduWbo8B+moMV2vUAs6kOLCJXpHdCU3n5NcMWFA+mb/RPcDKiZmaEX9kZsyT8tNT
 DoSp7LTP90jUxaxoEn5XZl8t6FZez8asQVOdPns6kstCl/Dh6HFdB++pXGOGTIMPmAooqWRbcI
 mAzFFBJz+ney3DhSiQW7zPAGejqCojIbXFVJxy8W97qus0EvHewHRmv77SU4D6E0P5VoUOzYM6
 t+bJS/QUvLrb39sIMMKxGZNN9Qkl9TseQuTfiMireCW+4rreiGMRoa0Lgyya/Pft6CJaM7sndd
 nGc=
X-IronPort-AV: E=Sophos;i="5.77,408,1596470400"; d="scan'208";a="151960175"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 23 Oct 2020 23:45:13 +0800
IronPort-SDR: iJ3wJ4M4QlsE5GAUMpS6lJqSuta7I7/lVPJowuMOk9GYCDEwu7jTKHMO1++SQrbD8RnZNwY6hi
 QnHyRGNqxv/K1nwIpK6+UgcDvVqNkg8N6mOVpwOAlPuYh5oT10WwD7XeXQM44srn7AFrP8Aqox
 5u3ihb9OJlMV3JwQ5OLC751+FQd5VQBx02GQnG/1jRj63+hMkamGnOQNNt/B0wDv7l0ksiax8/
 DGKbz7/IJGnY3Y5pRHzO9X54P6Rhri7IR/yopLd6d6iDLPYhHjclFzBEFK55wAsbj37HCzjpC+
 9mw2T09ezbH0eU+kUqQPrrjC
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2020 08:31:34 -0700
IronPort-SDR: jWPZWx1Z53PMeQvAJK++JyFPFpbODe+kXVSswPeMRMpa+kaDFDK3Z64dbPVTi4pzvdmHqYGfvA
 SuErD4Um9+3WJmXXwYNgFEVL1LTtGAXaVOCWfF1Pu1a2jlAoCg415IJaWLv0YhQfrqeceI+CTy
 gPvv7voUK0Jh2E9GI6bF+mEFmw9Jou01OmiItaIPE8VCMho4CVNMQLpvX2Vz2eYeJzftJaF4/m
 nkoIQPmaKf5DxNGSRuj4Mo4DjaQDZ8z4DJxVyvw11qMzdwetJpjHWkcuUOHhzEsMZvilWyDhZJ
 y0E=
WDCIronportException: Internal
Received: from cnf006900.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.46])
 by uls-op-cesaip02.wdc.com with ESMTP; 23 Oct 2020 08:45:12 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 14/16] target/riscv: cpu: Set XLEN independently from target
Date: Fri, 23 Oct 2020 08:33:51 -0700
Message-Id: <0316e1e7b7d81d1e6265fc125983a1e2872c0fe1.1603467169.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1603467169.git.alistair.francis@wdc.com>
References: <cover.1603467169.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=558518344=alistair.francis@wdc.com;
 helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 11:44:34
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: alistair.francis@wdc.com, bmeng.cn@gmail.com, palmer@dabbelt.com,
 alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 1b3efc1c81..c77687ccb2 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -150,14 +150,14 @@ static void riscv_any_cpu_init(Object *obj)
     set_priv_version(env, PRIV_VERSION_1_11_0);
 }
 
-static void riscv_base_cpu_init(Object *obj)
+#if defined(TARGET_RISCV64)
+static void rv64_base_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
     /* We set this in the realise function */
-    set_misa(env, 0);
+    set_misa(env, RV64);
 }
 
-#ifdef TARGET_RISCV64
 static void rv64_sifive_u_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
@@ -173,6 +173,13 @@ static void rv64_sifive_e_cpu_init(Object *obj)
     qdev_prop_set_bit(DEVICE(obj), "mmu", false);
 }
 #else
+static void rv32_base_cpu_init(Object *obj)
+{
+    CPURISCVState *env = &RISCV_CPU(obj)->env;
+    /* We set this in the realise function */
+    set_misa(env, RV32);
+}
+
 static void rv32_sifive_u_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
@@ -369,7 +376,7 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
     RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(dev);
     int priv_version = PRIV_VERSION_1_11_0;
     int vext_version = VEXT_VERSION_0_07_1;
-    target_ulong target_misa = 0;
+    target_ulong target_misa = env->misa;
     Error *local_err = NULL;
 
     cpu_exec_realizefn(cs, &local_err);
@@ -404,8 +411,8 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
 
     set_resetvec(env, cpu->cfg.resetvec);
 
-    /* If misa isn't set (rv32 and rv64 machines) set it here */
-    if (!env->misa) {
+    /* If only XLEN is set for misa, then set misa from properties */
+    if (env->misa == RV32 || env->misa == RV64) {
         /* Do some ISA extension error checking */
         if (cpu->cfg.ext_i && cpu->cfg.ext_e) {
             error_setg(errp,
@@ -501,7 +508,7 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
             set_vext_version(env, vext_version);
         }
 
-        set_misa(env, RVXLEN | target_misa);
+        set_misa(env, target_misa);
     }
 
     riscv_cpu_register_gdb_regs_for_features(cs);
@@ -659,13 +666,13 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     },
     DEFINE_CPU(TYPE_RISCV_CPU_ANY,              riscv_any_cpu_init),
 #if defined(TARGET_RISCV32)
-    DEFINE_CPU(TYPE_RISCV_CPU_BASE32,           riscv_base_cpu_init),
+    DEFINE_CPU(TYPE_RISCV_CPU_BASE32,           rv32_base_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_IBEX,             rv32_ibex_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E31,       rv32_sifive_e_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E34,       rv32_imafcu_nommu_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U34,       rv32_sifive_u_cpu_init),
 #elif defined(TARGET_RISCV64)
-    DEFINE_CPU(TYPE_RISCV_CPU_BASE64,           riscv_base_cpu_init),
+    DEFINE_CPU(TYPE_RISCV_CPU_BASE64,           rv64_base_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_E51,       rv64_sifive_e_cpu_init),
     DEFINE_CPU(TYPE_RISCV_CPU_SIFIVE_U54,       rv64_sifive_u_cpu_init),
 #endif
-- 
2.28.0


