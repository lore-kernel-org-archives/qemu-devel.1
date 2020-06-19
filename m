Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EBDC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:11:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3C0C20DD4
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gowrHUmr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3C0C20DD4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmKYY-0002bR-3D
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 13:11:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58182)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmKUF-0000iV-DB
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 13:07:31 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:24431)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmKUD-0004Pk-EV
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 13:07:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592586453; x=1624122453;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=MwmhX+QruCR5bliKSXbiubjgtbRSUKmWFEdzq1sWRbI=;
 b=gowrHUmrmPT4DdocCxvxzeIAztUl61pPRekJpOXy94tqT7FGyUeUvumW
 icKcvcEY/FeQAVq41If0klcZzvRH9HE/X0QgiTtAh72VC0uiuyy3ZsrMa
 b+s6HQkRWUs40K3HVCFE3uHDb554YHUaJB4Ha5ug+X+JbUWfzH/3t3Kc9
 aQf8Jwh+ELgm/SYXyCDvK2GHOp+ZQsdUzIxocqSsqfyYylTgtdepCcm9f
 KxWN8w3LyzevOufUzpd0XD4Z6RXknlJMD3a55v7F3G4f9iimDi/spjmlU
 dVhdxX0tL6jOhhISbrd8wJrDyCqkoIt5NzLet89D6xgTU6gCrOa6bhUan g==;
IronPort-SDR: dnBY5G2Zz8vf7uc2lapTXqwYL0ZIuY58pOJYkfzXVHFosrFVH7GIw4trbUzM142z6EXz6cvi8E
 QPZ+ucfWU7h2tvpUReTSzeD4JDUm402HL3+tsI0VlrwMJtHVnR8x8pkg1GM2XvFAn71plNZXA4
 Gcu1M2gMbdBJX/Zr2NoYSlaiVdTXiHBRiI8xyzeLi7wyYquAfhWC/hpO+7tHb4G/0bJtykuQbJ
 joFfJaGXoMALUPoMj2G1kEklgu+4/mKFyKpQt0zeX2Ep8PGCY8ci00otEj5uiTy9kFKWnTlwlk
 48o=
X-IronPort-AV: E=Sophos;i="5.75,256,1589212800"; d="scan'208";a="243416997"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2020 01:07:26 +0800
IronPort-SDR: RXXytb5BPqj34mYwVLTMoQmKpEpf1tgFHfxT57nJ9qgvJ21ZP1l1lW77wwqasuf1lEd64SQAVG
 MD7Y0qT03lnimfxW/OI9KpGpdNH8akPb0=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2020 09:56:02 -0700
IronPort-SDR: Al99hpR9yDSAOBFdqEN5ZPZjJHrMI3XsefXbAspR7Zt+3GvlErbMia4l5lxoCs5w6Bap/pcide
 jqUt7HTgGmtA==
WDCIronportException: Internal
Received: from unknown (HELO risc6-mainframe.hgst.com) ([10.86.58.142])
 by uls-op-cesaip02.wdc.com with ESMTP; 19 Jun 2020 10:07:25 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 17/32] hw/riscv: sifive_e: Remove the riscv_ prefix of the
 machine* and soc* functions
Date: Fri, 19 Jun 2020 09:58:02 -0700
Message-Id: <20200619165817.4144200-18-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619165817.4144200-1-alistair.francis@wdc.com>
References: <20200619165817.4144200-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=4324eb4de=alistair.francis@wdc.com;
 helo=esa2.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 13:07:24
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: alistair23@gmail.com, Bin Meng <bin.meng@windriver.com>,
 Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

This was done in the virt & sifive_u codes, but sifive_e codes were
missed. Remove the riscv_ prefix of the machine* and soc* functions.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 1591625864-31494-2-git-send-email-bmeng.cn@gmail.com
Message-Id: <1591625864-31494-2-git-send-email-bmeng.cn@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/sifive_e.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 36486b72d2..01626820bb 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -75,7 +75,7 @@ static const struct MemmapEntry {
     [SIFIVE_E_DTIM] =     { 0x80000000,     0x4000 }
 };
 
-static void riscv_sifive_e_init(MachineState *machine)
+static void sifive_e_machine_init(MachineState *machine)
 {
     const struct MemmapEntry *memmap = sifive_e_memmap;
 
@@ -147,7 +147,7 @@ static void sifive_e_machine_class_init(ObjectClass *oc, void *data)
     MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->desc = "RISC-V Board compatible with SiFive E SDK";
-    mc->init = riscv_sifive_e_init;
+    mc->init = sifive_e_machine_init;
     mc->max_cpus = 1;
     mc->default_cpu_type = SIFIVE_E_CPU;
 }
@@ -167,7 +167,7 @@ static void sifive_e_machine_init_register_types(void)
 
 type_init(sifive_e_machine_init_register_types)
 
-static void riscv_sifive_e_soc_init(Object *obj)
+static void sifive_e_soc_init(Object *obj)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
     SiFiveESoCState *s = RISCV_E_SOC(obj);
@@ -179,7 +179,7 @@ static void riscv_sifive_e_soc_init(Object *obj)
                             TYPE_SIFIVE_GPIO);
 }
 
-static void riscv_sifive_e_soc_realize(DeviceState *dev, Error **errp)
+static void sifive_e_soc_realize(DeviceState *dev, Error **errp)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
     const struct MemmapEntry *memmap = sifive_e_memmap;
@@ -262,26 +262,26 @@ static void riscv_sifive_e_soc_realize(DeviceState *dev, Error **errp)
         &s->xip_mem);
 }
 
-static void riscv_sifive_e_soc_class_init(ObjectClass *oc, void *data)
+static void sifive_e_soc_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
-    dc->realize = riscv_sifive_e_soc_realize;
+    dc->realize = sifive_e_soc_realize;
     /* Reason: Uses serial_hds in realize function, thus can't be used twice */
     dc->user_creatable = false;
 }
 
-static const TypeInfo riscv_sifive_e_soc_type_info = {
+static const TypeInfo sifive_e_soc_type_info = {
     .name = TYPE_RISCV_E_SOC,
     .parent = TYPE_DEVICE,
     .instance_size = sizeof(SiFiveESoCState),
-    .instance_init = riscv_sifive_e_soc_init,
-    .class_init = riscv_sifive_e_soc_class_init,
+    .instance_init = sifive_e_soc_init,
+    .class_init = sifive_e_soc_class_init,
 };
 
-static void riscv_sifive_e_soc_register_types(void)
+static void sifive_e_soc_register_types(void)
 {
-    type_register_static(&riscv_sifive_e_soc_type_info);
+    type_register_static(&sifive_e_soc_type_info);
 }
 
-type_init(riscv_sifive_e_soc_register_types)
+type_init(sifive_e_soc_register_types)
-- 
2.27.0


