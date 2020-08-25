Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0697C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:04:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8948D2074D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="r00aPaK5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8948D2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAeEy-0003Sr-Q2
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 15:04:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33322)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=49978a6e9=alistair.francis@wdc.com>)
 id 1kAe9t-0003Ue-0M
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 14:59:01 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:58813)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=49978a6e9=alistair.francis@wdc.com>)
 id 1kAe9p-0002w2-Tn
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 14:59:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1598381939; x=1629917939;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=k3OzarXmKJHHOzwb5GT+3SYchGKtfyOBgzGvOzCWm68=;
 b=r00aPaK5tg1VPcJ7H1ddQS5kPjdfadSRNcu7q0+3/74If2dFXhfvkY/y
 IhXCkc7Q2FSVYAg5xk5HGBTrHHAY9+bLOpIfisnMeOWKy7utNgT7fXGvm
 Ks1Jy3BP5Io6Yjm8LqoIxH+Cdb7YPowTNwIIunqf6ODTYqcKFo5/Kad0e
 UyGIdx/EOul/SvKJCQu002y2z6b1p4kcsVt9RbS9UwqHX2ANFO9+CtwFU
 q6wabEO7cr2YeWxRLhhjlVYl5n1tbt1rDAzEN9JON/GHU++GX5Fx7gTCj
 OXUGotXfVBJ3///QdLvEk3sfeMBecgpJR1NXQdpW5mPLXOHej8MN+TuAq A==;
IronPort-SDR: jZeqmls5HEfFPGsJH2nSRidNnD/npZ/w+QfZsyLJXxJNgkAEgeYYnVV9Z+59CdEhTZalwg1APO
 /tWlzZ9P9EQ975WU7gHkSmb2Um38uf/s8zsoCcnjK1QeV+Gb7J+oBT5iGbqoaVzbsroZvYj11L
 +4kiYxJ7R3wfaNMbjYwDWyYQ3J0NmnuiDfXQqQaqLL69cp9hatcSFxBgkOfjEM8pBy3eEKRAfb
 I1D0h+pFA8NDLs//aPi7t5VuTHqBkX6SiaL59k1CO08EaiZuK+i1qOgfRpgK76eu1K1JnoV3wR
 GmM=
X-IronPort-AV: E=Sophos;i="5.76,353,1592841600"; d="scan'208";a="150145284"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 26 Aug 2020 02:58:55 +0800
IronPort-SDR: DLOaKWXeVq/C1FKXaxekMgp73Vm9YGr6SwwJ7JDKvLSaHeg7TsgRW19CJwmjSvTvmcPWwa6Ez5
 1wOvmivOwppQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2020 11:46:30 -0700
IronPort-SDR: CCbdemD+pz3ss//+liwXnViCqgy31V/2CKE4zqFAg+U80GMdEDSYRJxhtLus5YK26yOfhg9ccf
 ouTyDcDhCjYg==
WDCIronportException: Internal
Received: from ind003389.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.125])
 by uls-op-cesaip02.wdc.com with ESMTP; 25 Aug 2020 11:58:53 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/18] hw/riscv: Allow creating multiple instances of PLIC
Date: Tue, 25 Aug 2020 11:48:20 -0700
Message-Id: <20200825184836.1282371-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200825184836.1282371-1-alistair.francis@wdc.com>
References: <20200825184836.1282371-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=49978a6e9=alistair.francis@wdc.com;
 helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 14:58:53
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
 Anup Patel <anup.patel@wdc.com>, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Anup Patel <anup.patel@wdc.com>

We extend PLIC emulation to allow multiple instances of PLIC in
a QEMU RISC-V machine. To achieve this, we remove first HART id
zero assumption from PLIC emulation.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20200616032229.766089-3-anup.patel@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/sifive_plic.h | 12 +++++++-----
 hw/riscv/sifive_e.c            |  2 +-
 hw/riscv/sifive_plic.c         | 24 +++++++++++++-----------
 hw/riscv/sifive_u.c            |  2 +-
 hw/riscv/virt.c                |  2 +-
 5 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/include/hw/riscv/sifive_plic.h b/include/hw/riscv/sifive_plic.h
index 4421e81249..ace76d0f1b 100644
--- a/include/hw/riscv/sifive_plic.h
+++ b/include/hw/riscv/sifive_plic.h
@@ -48,6 +48,7 @@ typedef struct SiFivePLICState {
     /*< public >*/
     MemoryRegion mmio;
     uint32_t num_addrs;
+    uint32_t num_harts;
     uint32_t bitfield_words;
     PLICAddr *addr_config;
     uint32_t *source_priority;
@@ -58,6 +59,7 @@ typedef struct SiFivePLICState {
 
     /* config */
     char *hart_config;
+    uint32_t hartid_base;
     uint32_t num_sources;
     uint32_t num_priorities;
     uint32_t priority_base;
@@ -70,10 +72,10 @@ typedef struct SiFivePLICState {
 } SiFivePLICState;
 
 DeviceState *sifive_plic_create(hwaddr addr, char *hart_config,
-    uint32_t num_sources, uint32_t num_priorities,
-    uint32_t priority_base, uint32_t pending_base,
-    uint32_t enable_base, uint32_t enable_stride,
-    uint32_t context_base, uint32_t context_stride,
-    uint32_t aperture_size);
+    uint32_t hartid_base, uint32_t num_sources,
+    uint32_t num_priorities, uint32_t priority_base,
+    uint32_t pending_base, uint32_t enable_base,
+    uint32_t enable_stride, uint32_t context_base,
+    uint32_t context_stride, uint32_t aperture_size);
 
 #endif
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 01f661d00c..ca55cc438a 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -200,7 +200,7 @@ static void sifive_e_soc_realize(DeviceState *dev, Error **errp)
 
     /* MMIO */
     s->plic = sifive_plic_create(memmap[SIFIVE_E_PLIC].base,
-        (char *)SIFIVE_E_PLIC_HART_CONFIG,
+        (char *)SIFIVE_E_PLIC_HART_CONFIG, 0,
         SIFIVE_E_PLIC_NUM_SOURCES,
         SIFIVE_E_PLIC_NUM_PRIORITIES,
         SIFIVE_E_PLIC_PRIORITY_BASE,
diff --git a/hw/riscv/sifive_plic.c b/hw/riscv/sifive_plic.c
index c20c192034..11ef147606 100644
--- a/hw/riscv/sifive_plic.c
+++ b/hw/riscv/sifive_plic.c
@@ -361,6 +361,7 @@ static const MemoryRegionOps sifive_plic_ops = {
 
 static Property sifive_plic_properties[] = {
     DEFINE_PROP_STRING("hart-config", SiFivePLICState, hart_config),
+    DEFINE_PROP_UINT32("hartid-base", SiFivePLICState, hartid_base, 0),
     DEFINE_PROP_UINT32("num-sources", SiFivePLICState, num_sources, 0),
     DEFINE_PROP_UINT32("num-priorities", SiFivePLICState, num_priorities, 0),
     DEFINE_PROP_UINT32("priority-base", SiFivePLICState, priority_base, 0),
@@ -409,10 +410,12 @@ static void parse_hart_config(SiFivePLICState *plic)
     }
     hartid++;
 
-    /* store hart/mode combinations */
     plic->num_addrs = addrid;
+    plic->num_harts = hartid;
+
+    /* store hart/mode combinations */
     plic->addr_config = g_new(PLICAddr, plic->num_addrs);
-    addrid = 0, hartid = 0;
+    addrid = 0, hartid = plic->hartid_base;
     p = plic->hart_config;
     while ((c = *p++)) {
         if (c == ',') {
@@ -438,8 +441,6 @@ static void sifive_plic_irq_request(void *opaque, int irq, int level)
 
 static void sifive_plic_realize(DeviceState *dev, Error **errp)
 {
-    MachineState *ms = MACHINE(qdev_get_machine());
-    unsigned int smp_cpus = ms->smp.cpus;
     SiFivePLICState *plic = SIFIVE_PLIC(dev);
     int i;
 
@@ -460,8 +461,8 @@ static void sifive_plic_realize(DeviceState *dev, Error **errp)
      * lost a interrupt in the case a PLIC is attached. The SEIP bit must be
      * hardware controlled when a PLIC is attached.
      */
-    for (i = 0; i < smp_cpus; i++) {
-        RISCVCPU *cpu = RISCV_CPU(qemu_get_cpu(i));
+    for (i = 0; i < plic->num_harts; i++) {
+        RISCVCPU *cpu = RISCV_CPU(qemu_get_cpu(plic->hartid_base + i));
         if (riscv_cpu_claim_interrupts(cpu, MIP_SEIP) < 0) {
             error_report("SEIP already claimed");
             exit(1);
@@ -497,16 +498,17 @@ type_init(sifive_plic_register_types)
  * Create PLIC device.
  */
 DeviceState *sifive_plic_create(hwaddr addr, char *hart_config,
-    uint32_t num_sources, uint32_t num_priorities,
-    uint32_t priority_base, uint32_t pending_base,
-    uint32_t enable_base, uint32_t enable_stride,
-    uint32_t context_base, uint32_t context_stride,
-    uint32_t aperture_size)
+    uint32_t hartid_base, uint32_t num_sources,
+    uint32_t num_priorities, uint32_t priority_base,
+    uint32_t pending_base, uint32_t enable_base,
+    uint32_t enable_stride, uint32_t context_base,
+    uint32_t context_stride, uint32_t aperture_size)
 {
     DeviceState *dev = qdev_new(TYPE_SIFIVE_PLIC);
     assert(enable_stride == (enable_stride & -enable_stride));
     assert(context_stride == (context_stride & -context_stride));
     qdev_prop_set_string(dev, "hart-config", hart_config);
+    qdev_prop_set_uint32(dev, "hartid-base", hartid_base);
     qdev_prop_set_uint32(dev, "num-sources", num_sources);
     qdev_prop_set_uint32(dev, "num-priorities", num_priorities);
     qdev_prop_set_uint32(dev, "priority-base", priority_base);
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 8d2ee9d026..a48046c6a0 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -687,7 +687,7 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
 
     /* MMIO */
     s->plic = sifive_plic_create(memmap[SIFIVE_U_PLIC].base,
-        plic_hart_config,
+        plic_hart_config, 0,
         SIFIVE_U_PLIC_NUM_SOURCES,
         SIFIVE_U_PLIC_NUM_PRIORITIES,
         SIFIVE_U_PLIC_PRIORITY_BASE,
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 69cfca8501..8a66f43ee0 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -560,7 +560,7 @@ static void virt_machine_init(MachineState *machine)
 
     /* MMIO */
     s->plic = sifive_plic_create(memmap[VIRT_PLIC].base,
-        plic_hart_config,
+        plic_hart_config, 0,
         VIRT_PLIC_NUM_SOURCES,
         VIRT_PLIC_NUM_PRIORITIES,
         VIRT_PLIC_PRIORITY_BASE,
-- 
2.28.0


