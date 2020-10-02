Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2302BC4363C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 15:52:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB42A2074B
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 15:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ANazuekE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB42A2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kONME-0004ZQ-2U
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 11:52:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48012)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=537b2d3de=alistair.francis@wdc.com>)
 id 1kONCE-0004Bl-OK; Fri, 02 Oct 2020 11:42:10 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:56198)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=537b2d3de=alistair.francis@wdc.com>)
 id 1kONCB-00045N-A6; Fri, 02 Oct 2020 11:42:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601653543; x=1633189543;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TC0Rre6PDSVGWrC6pMT7/cwluV53ut4KHlQPLQ1txFE=;
 b=ANazuekERHp5LbXZP32GmeipB4dNadPU1kPZVv2kpUc8XstLozkpLAWL
 I2VZJUtgJJd0HQZmQMto5amfJo5wOYB1w4EwrtfU0PUgTurfxHBM+qlaE
 D5J6ixRLL6U6Zs5VXUK5lzFNJhQY+mv+mqFrNbud1l+z0fYhv/4B3tYje
 IPalAmWz5MrZ3o52LTI16uo8DCkVTu116vybjx3zHkdvyX6sEZm6BLKZd
 eV2iM0TU2+9MUhgtBe+MwuwKIRsK1eZGJ/CUxbAdTojYHmN6V0koIgFdf
 fFxqVqtNEYvVbqTjpXkKCtEiugBSpY2Csu085SJB9l8ZVsSwT8t6Y60QW g==;
IronPort-SDR: 0QC2RxoQOeNXTD582H/ph+2Hj2JPhxm8hCzhJ3ByfK42n158aznhvhgSgckAapqRqYrvlQwlfv
 pRiaSfy8VcB2SIrT0En2/L1+e4b/51Jandi7eX3fWBTZN7cvpzdUq8dpDPr3BYqqFZC5RDNTQw
 WRRdMpqeXaGbZP1ssuS2trhSh9NLGF1yENT1ozv26O68tyYXQ9/O85EqVnCwjUA0UO/ZulTXgC
 jCmtMq4y2NEWMXsLPwBXkJxSAgOYOHT9f6eo8CkzUARXLhkL91hKeAEgBtoimiTuva9Y1GXAdo
 fzk=
X-IronPort-AV: E=Sophos;i="5.77,328,1596470400"; d="scan'208";a="252338159"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 02 Oct 2020 23:45:40 +0800
IronPort-SDR: VB6w5xC/iHhfb5gYCFZIbgiNXDprlsUF4qqcz+K/C0LPkjC/OvJHv8de9MG2REow+Os9vekvs0
 5xNZFqc3TyuQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2020 08:28:01 -0700
IronPort-SDR: fjU7uNNJGr/s2vH+lXVXcz0nhhdwbf/HI8dwecxfUAlTociVbn3sodn7RmhmXCeOx28X13lMyP
 tX8/OnJqyeDg==
WDCIronportException: Internal
Received: from dbzljc2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.174])
 by uls-op-cesaip01.wdc.com with ESMTP; 02 Oct 2020 08:42:04 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 1/4] hw/riscv: sifive_u: Allow specifying the CPU
Date: Fri,  2 Oct 2020 08:31:05 -0700
Message-Id: <3b114129fbe4416dce88c454b03c31d8405cc141.1601652616.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1601652616.git.alistair.francis@wdc.com>
References: <cover.1601652616.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=537b2d3de=alistair.francis@wdc.com;
 helo=esa2.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 11:42:05
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
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Allow the user to specify the main application CPU for the sifive_u
machine.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
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


