Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21159C43457
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 00:30:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DB3E20EDD
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 00:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="V/Epmk6D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DB3E20EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSUgX-0001mF-GD
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 20:30:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51142)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=549b5cc2b=alistair.francis@wdc.com>)
 id 1kSUet-0000Mh-TK; Tue, 13 Oct 2020 20:28:49 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:47545)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=549b5cc2b=alistair.francis@wdc.com>)
 id 1kSUek-0003yw-F9; Tue, 13 Oct 2020 20:28:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1602635318; x=1634171318;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0fkUNXJQx/5v3ALiauIASwlTjXXnN9687TC81glFriI=;
 b=V/Epmk6Drx5fvdopQaecrgs2et0lad/2DUnHZdcuhA3s+XRuim/91ccf
 GCne93mGB5gP2D+qgJ1pbdIJFUx9QtdxWzBM1+pKgJvhA+uQKyJHe4zNn
 p77DYCaIpacvf6G+Dl79vZ8CROxLPc+h0SDlcLmiyQqXswICISB2SWlBO
 hp2NVOdhHH9URSkZ37MZwNXXI4bxJYu4bPYLhccGr5BiuRq5KBVpzdrOD
 Vt/gwUReuvU5z88tNkC3iLW/0Lf0S2LQHSvFo91ZXPblT5C5UtRo+IwK/
 +5ssXzpDg4oH6C8s3rROK81qHrexhmztQ92K2wPYeUEYkgNKec9hz2heS Q==;
IronPort-SDR: 6YywJ+mx/PJStG3aUstJJBZbiyojop8p8GwLqw8/ZL86Oi3LPj1jAEGHQeptBXa9qqWMN/VSfd
 fp8CgNBH19OEyVFwDYfzNdl44br33YVTUJIqg8JgrOgvUQjcpW2NM0m/OC57KZbuf5VGii5BV9
 BH1aEuUy758PHi7GQSAFrT207CmYy184IfLbU1f1UrpuR51N9C+8QO1TA5aKRjL/yIxA7hnE0x
 rmBdtkStYsgTbihJT0OrhMWHdEjaeYiGTkDE0wRhRTwuqCsNu3wkiJmnzLmP3y3XyUu/Ki+4b9
 +S8=
X-IronPort-AV: E=Sophos;i="5.77,372,1596470400"; d="scan'208";a="259612084"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 14 Oct 2020 08:28:36 +0800
IronPort-SDR: q/T3A70sJC5fOIhjQfRRdbkOmNM5X2JBvUfQwwWvoe+TwCXkoMpP4GU485ICoccUVdtP+JM+I+
 Zn2+sGK+vm8vsYtRs7l1u+eLT5FAQ54tTneILjVp349gfOtsNxUIxeaSCj6JP+aAinCP5qKFMD
 Q09INvQxtG9U86H7KmZDEGaFtvdNpH1fnTfN+dFR3jJZJ8ewt8FSw861bDDiJ7iKZ5G4OSDIIk
 pMYgPhL8M5ePJyvvGh0cq/iwbWQnz/fIZNPtWolprGQk7xoVI8Gckm8MkQ+z1UAw4QuYOCwSzu
 9TJlAgLiJH/anEqMa5jfKAhT
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2020 17:15:09 -0700
IronPort-SDR: PEi/9g+VNwzXt9PyJ6aYcmET4zhfgWGPDuetBB8WuIk153MLyfxoWUaq+L3EX36dOioKXl+RX3
 FuLrtjw3MGkofwhqWGoJoYO6bhYxRE8ZFbj0CQat+Mw2lYZUCQVMbk00WMmbik3fFT5LOTCJma
 dLyfDjQhcjzkGSyrqNAc9LKKXUd7FQwDKW3GFcJTGvZrmIug9kzrK/TY2qexZtk6j9/GG4nMoM
 XYsVTlxikhCzYvDjum+NxgOLFO3IQUucJjlZmxzFK9au6h2bJtiToBuH+hcIPMTo7GaI5FWZGp
 9XY=
WDCIronportException: Internal
Received: from cnf006900.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.55])
 by uls-op-cesaip02.wdc.com with ESMTP; 13 Oct 2020 17:28:36 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 1/4] hw/riscv: sifive_u: Allow specifying the CPU
Date: Tue, 13 Oct 2020 17:17:25 -0700
Message-Id: <b8412086c8aea0eff30fb7a17f0acf2943381b6a.1602634524.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1602634524.git.alistair.francis@wdc.com>
References: <cover.1602634524.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=549b5cc2b=alistair.francis@wdc.com;
 helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 20:28:34
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

Allow the user to specify the main application CPU for the sifive_u
machine.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Bin Meng <bin.meng@windriver.com>
---
 include/hw/riscv/sifive_u.h |  1 +
 hw/riscv/sifive_u.c         | 18 +++++++++++++-----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index 22e7e6efa1..a9f7b4a084 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -48,6 +48,7 @@ typedef struct SiFiveUSoCState {
     CadenceGEMState gem;
 
     uint32_t serial;
+    char *cpu_type;
 } SiFiveUSoCState;
 
 #define TYPE_RISCV_U_MACHINE MACHINE_TYPE_NAME("sifive_u")
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 6ad975d692..5f3ad9bc0f 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -424,6 +424,8 @@ static void sifive_u_machine_init(MachineState *machine)
     object_initialize_child(OBJECT(machine), "soc", &s->soc, TYPE_RISCV_U_SOC);
     object_property_set_uint(OBJECT(&s->soc), "serial", s->serial,
                              &error_abort);
+    object_property_set_str(OBJECT(&s->soc), "cpu-type", machine->cpu_type,
+                             &error_abort);
     qdev_realize(DEVICE(&s->soc), NULL, &error_abort);
 
     /* register RAM */
@@ -590,6 +592,11 @@ static void sifive_u_machine_class_init(ObjectClass *oc, void *data)
     mc->init = sifive_u_machine_init;
     mc->max_cpus = SIFIVE_U_MANAGEMENT_CPU_COUNT + SIFIVE_U_COMPUTE_CPU_COUNT;
     mc->min_cpus = SIFIVE_U_MANAGEMENT_CPU_COUNT + 1;
+#if defined(TARGET_RISCV32)
+    mc->default_cpu_type = TYPE_RISCV_CPU_SIFIVE_U34;
+#elif defined(TARGET_RISCV64)
+    mc->default_cpu_type = TYPE_RISCV_CPU_SIFIVE_U54;
+#endif
     mc->default_cpus = mc->min_cpus;
 
     object_class_property_add_bool(oc, "start-in-flash",
@@ -618,7 +625,6 @@ type_init(sifive_u_machine_init_register_types)
 
 static void sifive_u_soc_instance_init(Object *obj)
 {
-    MachineState *ms = MACHINE(qdev_get_machine());
     SiFiveUSoCState *s = RISCV_U_SOC(obj);
 
     object_initialize_child(obj, "e-cluster", &s->e_cluster, TYPE_CPU_CLUSTER);
@@ -636,10 +642,6 @@ static void sifive_u_soc_instance_init(Object *obj)
 
     object_initialize_child(OBJECT(&s->u_cluster), "u-cpus", &s->u_cpus,
                             TYPE_RISCV_HART_ARRAY);
-    qdev_prop_set_uint32(DEVICE(&s->u_cpus), "num-harts", ms->smp.cpus - 1);
-    qdev_prop_set_uint32(DEVICE(&s->u_cpus), "hartid-base", 1);
-    qdev_prop_set_string(DEVICE(&s->u_cpus), "cpu-type", SIFIVE_U_CPU);
-    qdev_prop_set_uint64(DEVICE(&s->u_cpus), "resetvec", 0x1004);
 
     object_initialize_child(obj, "prci", &s->prci, TYPE_SIFIVE_U_PRCI);
     object_initialize_child(obj, "otp", &s->otp, TYPE_SIFIVE_U_OTP);
@@ -661,6 +663,11 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
     int i;
     NICInfo *nd = &nd_table[0];
 
+    qdev_prop_set_uint32(DEVICE(&s->u_cpus), "num-harts", ms->smp.cpus - 1);
+    qdev_prop_set_uint32(DEVICE(&s->u_cpus), "hartid-base", 1);
+    qdev_prop_set_string(DEVICE(&s->u_cpus), "cpu-type", s->cpu_type);
+    qdev_prop_set_uint64(DEVICE(&s->u_cpus), "resetvec", 0x1004);
+
     sysbus_realize(SYS_BUS_DEVICE(&s->e_cpus), &error_abort);
     sysbus_realize(SYS_BUS_DEVICE(&s->u_cpus), &error_abort);
     /*
@@ -792,6 +799,7 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
 
 static Property sifive_u_soc_props[] = {
     DEFINE_PROP_UINT32("serial", SiFiveUSoCState, serial, OTP_SERIAL),
+    DEFINE_PROP_STRING("cpu-type", SiFiveUSoCState, cpu_type),
     DEFINE_PROP_END_OF_LIST()
 };
 
-- 
2.28.0


