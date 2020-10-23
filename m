Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B03C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:01:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC91121527
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GZuBTbb3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC91121527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVzVj-0007Yp-TF
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 12:01:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60384)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=558518344=alistair.francis@wdc.com>)
 id 1kVyyx-0004Kc-9b
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:27:56 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:26168)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=558518344=alistair.francis@wdc.com>)
 id 1kVyys-0001Xq-Ai
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:27:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603466870; x=1635002870;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=L0zM4Ec9Du3VjXk0D2sog4reuXMCNB9GtHWmH3J6P3k=;
 b=GZuBTbb3cIHolxnaPFStoS4eC0HoMUj5U5ObvYL3KUKhQFnTQrLQjRz/
 oca+w251DedqVYSHCp+2mtj2g4MHbBXfAU6S2pZa1SoYnEvMF7J13mgUG
 3iQOCcvES7ikYCbUbwX573D/+1HpB1keqZcb2zgx+hOwjLIlk1rVbj2XK
 mZb6Hh/C65B3Kelnxh5PduPwFltaGSi7x7CvtNEOsShqlRQu/lRUyuN1X
 d618Tt7dDG3ba1Hy0ZzM01ZnJS8rwQnGWTkFmoKEyrV/4fIKW08Aik+ik
 vl4Dks+Aln4BprPjyBkkgR4Jv4DDh6ApRDZ1ygpgvQneGWw0jDWKHuKOi Q==;
IronPort-SDR: UMbbNC47FlWlQ+M2QWDO0uPKrBzYgSwVItxQkrM421y/4eD+Tbh2MDVL2+8Xm6X6WcSfHAXfBH
 qA9pBFHSYhvW1uH32Nc9GVJingpkX427Wpi2zDB9ZCDGtkDygYgtfCAA4d1d7OzY0WXnmm3BDW
 uY/x6c1ldvH6IRzABqFLGGOcvS7BMDHCSwFG0pZPmdhUq9R8jtEf+h5czphu2rd7stXMRurmAA
 4v+z1N0lyPuwxvGHeE7w+WDyDKeyw5TyQq7OOdpFuivnMA4mwepIKUK0i2+Z4NcWXa3XrOY65A
 bKw=
X-IronPort-AV: E=Sophos;i="5.77,408,1596470400"; d="scan'208";a="150652322"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 23 Oct 2020 23:27:44 +0800
IronPort-SDR: 6vlaS1SwUQfTgvr9iBQcmHOghXT+3t9JDbjZyogKVY6TQvf6wSCKLKkeIuzRIPmkhN2tMoNvgN
 ebPrEWZcJLMU3aLG6ertfDIBRripthAWvf6EZYGDo5so1h5lYXUjzz4Bfm785yzdiWNsWi2m++
 RA/61t/7EbFYna31Zvz2/hVOVA0cqWO/XlfFDvh3lceea4PkRwD7Xth9dHyjLVM62e3K1GRpJh
 4c1MqzHtn3UNNNKloCy3Z+f65coNbr58P7r3akDhFWj5kdrxenHn3/VLnRJqZAcW18tK1dHEo0
 c0Xa28GQ5cBFoDWGwCMZ+lC5
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2020 08:12:59 -0700
IronPort-SDR: t2cAvG8Sx08WNpBvsnm8plfJY/ZJziv+H+p/CXj4KOjPUWepWsxV1PQcfOc/GkEPlvwbJXegsG
 5e87cdYNDJF/r1GgRGk43uhxF7cb0YQidDMk52oaFVRk2UyceNMELUijJOmJMRJHScORDxn5xu
 Gp7X/bdwvdYIv1IHVwkl6EnBjMwgP73Ium2jswVGnqjgcrHido4zht8xaXewrosIU11DH6BA5T
 oZIXVn8mf/SS/PLQmz6HDGR+ZFGeDh5snxXMZ2oyYt2+K05bxmTP46zD7fUeNxD/ZKhCxVR1i8
 1eU=
WDCIronportException: Internal
Received: from cnf006900.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.46])
 by uls-op-cesaip02.wdc.com with ESMTP; 23 Oct 2020 08:27:44 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 06/12] hw/riscv: sifive_u: Allow specifying the CPU
Date: Fri, 23 Oct 2020 08:16:13 -0700
Message-Id: <20201023151619.3175155-7-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201023151619.3175155-1-alistair.francis@wdc.com>
References: <20201023151619.3175155-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=558518344=alistair.francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 11:27:42
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
Cc: Palmer Dabbelt <palmerdabbelt@google.com>, alistair23@gmail.com,
 Bin Meng <bin.meng@windriver.com>, Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Allow the user to specify the main application CPU for the sifive_u
machine.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Tested-by: Bin Meng <bin.meng@windriver.com>
Message-id: b8412086c8aea0eff30fb7a17f0acf2943381b6a.1602634524.git.alistair.francis@wdc.com
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


