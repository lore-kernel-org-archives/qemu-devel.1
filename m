Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B52A9C433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 17:20:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE47E2226B
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 17:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qFAsYMdc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE47E2226B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQw4M-0002Ui-WA
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 13:20:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQvs3-0004XW-GV
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 13:07:55 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37001)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQvrz-0001JW-EN
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 13:07:55 -0400
Received: by mail-wr1-x441.google.com with SMTP id h7so11082426wre.4
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 10:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pVGos9EbHmRXYbz3qRIK1jaiJNEvYqAW/+RsvPeauPw=;
 b=qFAsYMdcTpBCmOh9/3J5NemDL5dnpKqMrny6ocFEV/P9rbc9onrcBlSeR5UVuaddVb
 D8yhXXiVzDGAXnm9Y2oLtLz0mbyRB31ZntBftPdm8U9M+DZTLi1LZHlD6pzDRztnTzo/
 7cDgjcLXdr/LVmMDvf36UIVSlmfNGWcJAxNz09zoarbfL+lVwVUAbMFMPrjGh2HHX220
 fx+3uQ1nvPtsGeKnePPq7guNf3I6zDXnhFY9LffFjRrDETAjkBzti13d8ktu5unjOvYf
 wJorUlyDQ28vc3uARlr9uJYOnTaDiMjZFW+PtwCOtvEnz7jX3xkQIsltHYfaKW/86LF+
 UNkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pVGos9EbHmRXYbz3qRIK1jaiJNEvYqAW/+RsvPeauPw=;
 b=jQxkwuxKlHKX3LX+eoTS/TmnUmXMEWbII1b952/hTP+L/HWE/Bgr5ps7E5WK5Appyr
 ucb5s1bG7j+GavtNn38pySfRnNMiR0xYqvtXZxXibGqw2E56wOqNiCMEyfMYJMpg4E7o
 rJRlusb6lq8oGDCbHpWabpr/oLmhb9rfCp7kOaOdOLJmjSQ5PxeC8RhIx9HP7eJPVa1N
 4B/rMgPp/ljnzevJTaIHLPvxEzkD6wJerOaoUJswSwUIVwU5FLVQu0o3xwlmSWJsY2Oo
 kKDc7N2Ny+t86/geG/i3twnTFjhhVP8GYIb8735EbYpq4ZR/KK+g4kRogR2NCOuBlglX
 7mTQ==
X-Gm-Message-State: AOAM533F+YOCp41Rq4pepKAZOTMegHROHPp5UhofIDQDhDS+MdtHC9ov
 G/Hxds36sMZjsRCBFECgN7CiOw==
X-Google-Smtp-Source: ABdhPJxqz3FcCg+BeLLdSWLfdcXfHo2jwj55aB14XAFd2kiyonCGrOX9H2Y469JHO1pvREGR17uRQw==
X-Received: by 2002:adf:f482:: with SMTP id l2mr3740305wro.26.1602263269840;
 Fri, 09 Oct 2020 10:07:49 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f12sm12304274wmf.26.2020.10.09.10.07.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2020 10:07:43 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1D6DA1FF87;
 Fri,  9 Oct 2020 18:07:43 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 1/4] hw/board: promote fdt from ARM VirtMachineState to
 MachineState
Date: Fri,  9 Oct 2020 18:07:39 +0100
Message-Id: <20201009170742.23695-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201009170742.23695-1-alex.bennee@linaro.org>
References: <20201009170742.23695-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, julien@xen.org,
 Eduardo Habkost <ehabkost@redhat.com>, masami.hiramatsu@linaro.org,
 andre.przywara@arm.com, stefano.stabellini@linaro.org,
 takahiro.akashi@linaro.org, "open list:Virt" <qemu-arm@nongnu.org>,
 stefano.stabellini@xilinx.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 stratos-dev@op-lists.linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The use of FDT's is quite common across our various platforms. To
allow the generic loader to tweak it we need to make it available in
the generic state. This creates the field and migrates the initial
user to use the generic field. Other boards will be updated in later
patches.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/hw/arm/virt.h |   1 -
 include/hw/boards.h   |   1 +
 hw/arm/virt.c         | 322 ++++++++++++++++++++++--------------------
 3 files changed, 170 insertions(+), 154 deletions(-)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index aad6d69841..648e5d6791 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -152,7 +152,6 @@ struct VirtMachineState {
     char *pciehb_nodename;
     const int *irqmap;
     int smp_cpus;
-    void *fdt;
     int fdt_size;
     uint32_t clock_phandle;
     uint32_t gic_phandle;
diff --git a/include/hw/boards.h b/include/hw/boards.h
index bf53e8a16e..4da71decf2 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -257,6 +257,7 @@ struct MachineState {
 
     /*< public >*/
 
+    void *fdt;
     char *dtb;
     char *dumpdtb;
     int phandle_start;
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index e465a988d6..1ca04c597e 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -216,14 +216,14 @@ static bool cpu_type_valid(const char *cpu)
     return false;
 }
 
-static void create_kaslr_seed(VirtMachineState *vms, const char *node)
+static void create_kaslr_seed(MachineState *ms, const char *node)
 {
     uint64_t seed;
 
     if (qemu_guest_getrandom(&seed, sizeof(seed), NULL)) {
         return;
     }
-    qemu_fdt_setprop_u64(vms->fdt, node, "kaslr-seed", seed);
+    qemu_fdt_setprop_u64(ms->fdt, node, "kaslr-seed", seed);
 }
 
 static void create_fdt(VirtMachineState *vms)
@@ -237,7 +237,7 @@ static void create_fdt(VirtMachineState *vms)
         exit(1);
     }
 
-    vms->fdt = fdt;
+    ms->fdt = fdt;
 
     /* Header */
     qemu_fdt_setprop_string(fdt, "/", "compatible", "linux,dummy-virt");
@@ -246,11 +246,11 @@ static void create_fdt(VirtMachineState *vms)
 
     /* /chosen must exist for load_dtb to fill in necessary properties later */
     qemu_fdt_add_subnode(fdt, "/chosen");
-    create_kaslr_seed(vms, "/chosen");
+    create_kaslr_seed(ms, "/chosen");
 
     if (vms->secure) {
         qemu_fdt_add_subnode(fdt, "/secure-chosen");
-        create_kaslr_seed(vms, "/secure-chosen");
+        create_kaslr_seed(ms, "/secure-chosen");
     }
 
     /* Clock node, for the benefit of the UART. The kernel device tree
@@ -314,6 +314,7 @@ static void fdt_add_timer_nodes(const VirtMachineState *vms)
     ARMCPU *armcpu;
     VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
     uint32_t irqflags = GIC_FDT_IRQ_FLAGS_LEVEL_HI;
+    MachineState *ms = MACHINE(vms);
 
     if (vmc->claim_edge_triggered_timers) {
         irqflags = GIC_FDT_IRQ_FLAGS_EDGE_LO_HI;
@@ -325,19 +326,19 @@ static void fdt_add_timer_nodes(const VirtMachineState *vms)
                              (1 << vms->smp_cpus) - 1);
     }
 
-    qemu_fdt_add_subnode(vms->fdt, "/timer");
+    qemu_fdt_add_subnode(ms->fdt, "/timer");
 
     armcpu = ARM_CPU(qemu_get_cpu(0));
     if (arm_feature(&armcpu->env, ARM_FEATURE_V8)) {
         const char compat[] = "arm,armv8-timer\0arm,armv7-timer";
-        qemu_fdt_setprop(vms->fdt, "/timer", "compatible",
+        qemu_fdt_setprop(ms->fdt, "/timer", "compatible",
                          compat, sizeof(compat));
     } else {
-        qemu_fdt_setprop_string(vms->fdt, "/timer", "compatible",
+        qemu_fdt_setprop_string(ms->fdt, "/timer", "compatible",
                                 "arm,armv7-timer");
     }
-    qemu_fdt_setprop(vms->fdt, "/timer", "always-on", NULL, 0);
-    qemu_fdt_setprop_cells(vms->fdt, "/timer", "interrupts",
+    qemu_fdt_setprop(ms->fdt, "/timer", "always-on", NULL, 0);
+    qemu_fdt_setprop_cells(ms->fdt, "/timer", "interrupts",
                        GIC_FDT_IRQ_TYPE_PPI, ARCH_TIMER_S_EL1_IRQ, irqflags,
                        GIC_FDT_IRQ_TYPE_PPI, ARCH_TIMER_NS_EL1_IRQ, irqflags,
                        GIC_FDT_IRQ_TYPE_PPI, ARCH_TIMER_VIRT_IRQ, irqflags,
@@ -372,36 +373,36 @@ static void fdt_add_cpu_nodes(const VirtMachineState *vms)
         }
     }
 
-    qemu_fdt_add_subnode(vms->fdt, "/cpus");
-    qemu_fdt_setprop_cell(vms->fdt, "/cpus", "#address-cells", addr_cells);
-    qemu_fdt_setprop_cell(vms->fdt, "/cpus", "#size-cells", 0x0);
+    qemu_fdt_add_subnode(ms->fdt, "/cpus");
+    qemu_fdt_setprop_cell(ms->fdt, "/cpus", "#address-cells", addr_cells);
+    qemu_fdt_setprop_cell(ms->fdt, "/cpus", "#size-cells", 0x0);
 
     for (cpu = vms->smp_cpus - 1; cpu >= 0; cpu--) {
         char *nodename = g_strdup_printf("/cpus/cpu@%d", cpu);
         ARMCPU *armcpu = ARM_CPU(qemu_get_cpu(cpu));
         CPUState *cs = CPU(armcpu);
 
-        qemu_fdt_add_subnode(vms->fdt, nodename);
-        qemu_fdt_setprop_string(vms->fdt, nodename, "device_type", "cpu");
-        qemu_fdt_setprop_string(vms->fdt, nodename, "compatible",
+        qemu_fdt_add_subnode(ms->fdt, nodename);
+        qemu_fdt_setprop_string(ms->fdt, nodename, "device_type", "cpu");
+        qemu_fdt_setprop_string(ms->fdt, nodename, "compatible",
                                     armcpu->dtb_compatible);
 
         if (vms->psci_conduit != QEMU_PSCI_CONDUIT_DISABLED
             && vms->smp_cpus > 1) {
-            qemu_fdt_setprop_string(vms->fdt, nodename,
+            qemu_fdt_setprop_string(ms->fdt, nodename,
                                         "enable-method", "psci");
         }
 
         if (addr_cells == 2) {
-            qemu_fdt_setprop_u64(vms->fdt, nodename, "reg",
+            qemu_fdt_setprop_u64(ms->fdt, nodename, "reg",
                                  armcpu->mp_affinity);
         } else {
-            qemu_fdt_setprop_cell(vms->fdt, nodename, "reg",
+            qemu_fdt_setprop_cell(ms->fdt, nodename, "reg",
                                   armcpu->mp_affinity);
         }
 
         if (ms->possible_cpus->cpus[cs->cpu_index].props.has_node_id) {
-            qemu_fdt_setprop_cell(vms->fdt, nodename, "numa-node-id",
+            qemu_fdt_setprop_cell(ms->fdt, nodename, "numa-node-id",
                 ms->possible_cpus->cpus[cs->cpu_index].props.node_id);
         }
 
@@ -412,71 +413,74 @@ static void fdt_add_cpu_nodes(const VirtMachineState *vms)
 static void fdt_add_its_gic_node(VirtMachineState *vms)
 {
     char *nodename;
+    MachineState *ms = MACHINE(vms);
 
-    vms->msi_phandle = qemu_fdt_alloc_phandle(vms->fdt);
+    vms->msi_phandle = qemu_fdt_alloc_phandle(ms->fdt);
     nodename = g_strdup_printf("/intc/its@%" PRIx64,
                                vms->memmap[VIRT_GIC_ITS].base);
-    qemu_fdt_add_subnode(vms->fdt, nodename);
-    qemu_fdt_setprop_string(vms->fdt, nodename, "compatible",
+    qemu_fdt_add_subnode(ms->fdt, nodename);
+    qemu_fdt_setprop_string(ms->fdt, nodename, "compatible",
                             "arm,gic-v3-its");
-    qemu_fdt_setprop(vms->fdt, nodename, "msi-controller", NULL, 0);
-    qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "reg",
+    qemu_fdt_setprop(ms->fdt, nodename, "msi-controller", NULL, 0);
+    qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg",
                                  2, vms->memmap[VIRT_GIC_ITS].base,
                                  2, vms->memmap[VIRT_GIC_ITS].size);
-    qemu_fdt_setprop_cell(vms->fdt, nodename, "phandle", vms->msi_phandle);
+    qemu_fdt_setprop_cell(ms->fdt, nodename, "phandle", vms->msi_phandle);
     g_free(nodename);
 }
 
 static void fdt_add_v2m_gic_node(VirtMachineState *vms)
 {
+    MachineState *ms = MACHINE(vms);
     char *nodename;
 
     nodename = g_strdup_printf("/intc/v2m@%" PRIx64,
                                vms->memmap[VIRT_GIC_V2M].base);
-    vms->msi_phandle = qemu_fdt_alloc_phandle(vms->fdt);
-    qemu_fdt_add_subnode(vms->fdt, nodename);
-    qemu_fdt_setprop_string(vms->fdt, nodename, "compatible",
+    vms->msi_phandle = qemu_fdt_alloc_phandle(ms->fdt);
+    qemu_fdt_add_subnode(ms->fdt, nodename);
+    qemu_fdt_setprop_string(ms->fdt, nodename, "compatible",
                             "arm,gic-v2m-frame");
-    qemu_fdt_setprop(vms->fdt, nodename, "msi-controller", NULL, 0);
-    qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "reg",
+    qemu_fdt_setprop(ms->fdt, nodename, "msi-controller", NULL, 0);
+    qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg",
                                  2, vms->memmap[VIRT_GIC_V2M].base,
                                  2, vms->memmap[VIRT_GIC_V2M].size);
-    qemu_fdt_setprop_cell(vms->fdt, nodename, "phandle", vms->msi_phandle);
+    qemu_fdt_setprop_cell(ms->fdt, nodename, "phandle", vms->msi_phandle);
     g_free(nodename);
 }
 
 static void fdt_add_gic_node(VirtMachineState *vms)
 {
+    MachineState *ms = MACHINE(vms);
     char *nodename;
 
-    vms->gic_phandle = qemu_fdt_alloc_phandle(vms->fdt);
-    qemu_fdt_setprop_cell(vms->fdt, "/", "interrupt-parent", vms->gic_phandle);
+    vms->gic_phandle = qemu_fdt_alloc_phandle(ms->fdt);
+    qemu_fdt_setprop_cell(ms->fdt, "/", "interrupt-parent", vms->gic_phandle);
 
     nodename = g_strdup_printf("/intc@%" PRIx64,
                                vms->memmap[VIRT_GIC_DIST].base);
-    qemu_fdt_add_subnode(vms->fdt, nodename);
-    qemu_fdt_setprop_cell(vms->fdt, nodename, "#interrupt-cells", 3);
-    qemu_fdt_setprop(vms->fdt, nodename, "interrupt-controller", NULL, 0);
-    qemu_fdt_setprop_cell(vms->fdt, nodename, "#address-cells", 0x2);
-    qemu_fdt_setprop_cell(vms->fdt, nodename, "#size-cells", 0x2);
-    qemu_fdt_setprop(vms->fdt, nodename, "ranges", NULL, 0);
+    qemu_fdt_add_subnode(ms->fdt, nodename);
+    qemu_fdt_setprop_cell(ms->fdt, nodename, "#interrupt-cells", 3);
+    qemu_fdt_setprop(ms->fdt, nodename, "interrupt-controller", NULL, 0);
+    qemu_fdt_setprop_cell(ms->fdt, nodename, "#address-cells", 0x2);
+    qemu_fdt_setprop_cell(ms->fdt, nodename, "#size-cells", 0x2);
+    qemu_fdt_setprop(ms->fdt, nodename, "ranges", NULL, 0);
     if (vms->gic_version == VIRT_GIC_VERSION_3) {
         int nb_redist_regions = virt_gicv3_redist_region_count(vms);
 
-        qemu_fdt_setprop_string(vms->fdt, nodename, "compatible",
+        qemu_fdt_setprop_string(ms->fdt, nodename, "compatible",
                                 "arm,gic-v3");
 
-        qemu_fdt_setprop_cell(vms->fdt, nodename,
+        qemu_fdt_setprop_cell(ms->fdt, nodename,
                               "#redistributor-regions", nb_redist_regions);
 
         if (nb_redist_regions == 1) {
-            qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "reg",
+            qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg",
                                          2, vms->memmap[VIRT_GIC_DIST].base,
                                          2, vms->memmap[VIRT_GIC_DIST].size,
                                          2, vms->memmap[VIRT_GIC_REDIST].base,
                                          2, vms->memmap[VIRT_GIC_REDIST].size);
         } else {
-            qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "reg",
+            qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg",
                                  2, vms->memmap[VIRT_GIC_DIST].base,
                                  2, vms->memmap[VIRT_GIC_DIST].size,
                                  2, vms->memmap[VIRT_GIC_REDIST].base,
@@ -486,22 +490,22 @@ static void fdt_add_gic_node(VirtMachineState *vms)
         }
 
         if (vms->virt) {
-            qemu_fdt_setprop_cells(vms->fdt, nodename, "interrupts",
+            qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupts",
                                    GIC_FDT_IRQ_TYPE_PPI, ARCH_GIC_MAINT_IRQ,
                                    GIC_FDT_IRQ_FLAGS_LEVEL_HI);
         }
     } else {
         /* 'cortex-a15-gic' means 'GIC v2' */
-        qemu_fdt_setprop_string(vms->fdt, nodename, "compatible",
+        qemu_fdt_setprop_string(ms->fdt, nodename, "compatible",
                                 "arm,cortex-a15-gic");
         if (!vms->virt) {
-            qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "reg",
+            qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg",
                                          2, vms->memmap[VIRT_GIC_DIST].base,
                                          2, vms->memmap[VIRT_GIC_DIST].size,
                                          2, vms->memmap[VIRT_GIC_CPU].base,
                                          2, vms->memmap[VIRT_GIC_CPU].size);
         } else {
-            qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "reg",
+            qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg",
                                          2, vms->memmap[VIRT_GIC_DIST].base,
                                          2, vms->memmap[VIRT_GIC_DIST].size,
                                          2, vms->memmap[VIRT_GIC_CPU].base,
@@ -510,13 +514,13 @@ static void fdt_add_gic_node(VirtMachineState *vms)
                                          2, vms->memmap[VIRT_GIC_HYP].size,
                                          2, vms->memmap[VIRT_GIC_VCPU].base,
                                          2, vms->memmap[VIRT_GIC_VCPU].size);
-            qemu_fdt_setprop_cells(vms->fdt, nodename, "interrupts",
+            qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupts",
                                    GIC_FDT_IRQ_TYPE_PPI, ARCH_GIC_MAINT_IRQ,
                                    GIC_FDT_IRQ_FLAGS_LEVEL_HI);
         }
     }
 
-    qemu_fdt_setprop_cell(vms->fdt, nodename, "phandle", vms->gic_phandle);
+    qemu_fdt_setprop_cell(ms->fdt, nodename, "phandle", vms->gic_phandle);
     g_free(nodename);
 }
 
@@ -524,6 +528,7 @@ static void fdt_add_pmu_nodes(const VirtMachineState *vms)
 {
     ARMCPU *armcpu = ARM_CPU(first_cpu);
     uint32_t irqflags = GIC_FDT_IRQ_FLAGS_LEVEL_HI;
+    MachineState *ms = MACHINE(vms);
 
     if (!arm_feature(&armcpu->env, ARM_FEATURE_PMU)) {
         assert(!object_property_get_bool(OBJECT(armcpu), "pmu", NULL));
@@ -536,12 +541,12 @@ static void fdt_add_pmu_nodes(const VirtMachineState *vms)
                              (1 << vms->smp_cpus) - 1);
     }
 
-    qemu_fdt_add_subnode(vms->fdt, "/pmu");
+    qemu_fdt_add_subnode(ms->fdt, "/pmu");
     if (arm_feature(&armcpu->env, ARM_FEATURE_V8)) {
         const char compat[] = "arm,armv8-pmuv3";
-        qemu_fdt_setprop(vms->fdt, "/pmu", "compatible",
+        qemu_fdt_setprop(ms->fdt, "/pmu", "compatible",
                          compat, sizeof(compat));
-        qemu_fdt_setprop_cells(vms->fdt, "/pmu", "interrupts",
+        qemu_fdt_setprop_cells(ms->fdt, "/pmu", "interrupts",
                                GIC_FDT_IRQ_TYPE_PPI, VIRTUAL_PMU_IRQ, irqflags);
     }
 }
@@ -747,6 +752,7 @@ static void create_uart(const VirtMachineState *vms, int uart,
     const char clocknames[] = "uartclk\0apb_pclk";
     DeviceState *dev = qdev_new(TYPE_PL011);
     SysBusDevice *s = SYS_BUS_DEVICE(dev);
+    MachineState *ms = MACHINE(vms);
 
     qdev_prop_set_chr(dev, "chardev", chr);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
@@ -755,28 +761,28 @@ static void create_uart(const VirtMachineState *vms, int uart,
     sysbus_connect_irq(s, 0, qdev_get_gpio_in(vms->gic, irq));
 
     nodename = g_strdup_printf("/pl011@%" PRIx64, base);
-    qemu_fdt_add_subnode(vms->fdt, nodename);
+    qemu_fdt_add_subnode(ms->fdt, nodename);
     /* Note that we can't use setprop_string because of the embedded NUL */
-    qemu_fdt_setprop(vms->fdt, nodename, "compatible",
+    qemu_fdt_setprop(ms->fdt, nodename, "compatible",
                          compat, sizeof(compat));
-    qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "reg",
+    qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg",
                                      2, base, 2, size);
-    qemu_fdt_setprop_cells(vms->fdt, nodename, "interrupts",
+    qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupts",
                                GIC_FDT_IRQ_TYPE_SPI, irq,
                                GIC_FDT_IRQ_FLAGS_LEVEL_HI);
-    qemu_fdt_setprop_cells(vms->fdt, nodename, "clocks",
+    qemu_fdt_setprop_cells(ms->fdt, nodename, "clocks",
                                vms->clock_phandle, vms->clock_phandle);
-    qemu_fdt_setprop(vms->fdt, nodename, "clock-names",
+    qemu_fdt_setprop(ms->fdt, nodename, "clock-names",
                          clocknames, sizeof(clocknames));
 
     if (uart == VIRT_UART) {
-        qemu_fdt_setprop_string(vms->fdt, "/chosen", "stdout-path", nodename);
+        qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", nodename);
     } else {
         /* Mark as not usable by the normal world */
-        qemu_fdt_setprop_string(vms->fdt, nodename, "status", "disabled");
-        qemu_fdt_setprop_string(vms->fdt, nodename, "secure-status", "okay");
+        qemu_fdt_setprop_string(ms->fdt, nodename, "status", "disabled");
+        qemu_fdt_setprop_string(ms->fdt, nodename, "secure-status", "okay");
 
-        qemu_fdt_setprop_string(vms->fdt, "/secure-chosen", "stdout-path",
+        qemu_fdt_setprop_string(ms->fdt, "/secure-chosen", "stdout-path",
                                 nodename);
     }
 
@@ -790,19 +796,20 @@ static void create_rtc(const VirtMachineState *vms)
     hwaddr size = vms->memmap[VIRT_RTC].size;
     int irq = vms->irqmap[VIRT_RTC];
     const char compat[] = "arm,pl031\0arm,primecell";
+    MachineState *ms = MACHINE(vms);
 
     sysbus_create_simple("pl031", base, qdev_get_gpio_in(vms->gic, irq));
 
     nodename = g_strdup_printf("/pl031@%" PRIx64, base);
-    qemu_fdt_add_subnode(vms->fdt, nodename);
-    qemu_fdt_setprop(vms->fdt, nodename, "compatible", compat, sizeof(compat));
-    qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "reg",
+    qemu_fdt_add_subnode(ms->fdt, nodename);
+    qemu_fdt_setprop(ms->fdt, nodename, "compatible", compat, sizeof(compat));
+    qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg",
                                  2, base, 2, size);
-    qemu_fdt_setprop_cells(vms->fdt, nodename, "interrupts",
+    qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupts",
                            GIC_FDT_IRQ_TYPE_SPI, irq,
                            GIC_FDT_IRQ_FLAGS_LEVEL_HI);
-    qemu_fdt_setprop_cell(vms->fdt, nodename, "clocks", vms->clock_phandle);
-    qemu_fdt_setprop_string(vms->fdt, nodename, "clock-names", "apb_pclk");
+    qemu_fdt_setprop_cell(ms->fdt, nodename, "clocks", vms->clock_phandle);
+    qemu_fdt_setprop_string(ms->fdt, nodename, "clock-names", "apb_pclk");
     g_free(nodename);
 }
 
@@ -827,38 +834,39 @@ static void create_gpio(const VirtMachineState *vms)
     hwaddr size = vms->memmap[VIRT_GPIO].size;
     int irq = vms->irqmap[VIRT_GPIO];
     const char compat[] = "arm,pl061\0arm,primecell";
+    MachineState *ms = MACHINE(vms);
 
     pl061_dev = sysbus_create_simple("pl061", base,
                                      qdev_get_gpio_in(vms->gic, irq));
 
-    uint32_t phandle = qemu_fdt_alloc_phandle(vms->fdt);
+    uint32_t phandle = qemu_fdt_alloc_phandle(ms->fdt);
     nodename = g_strdup_printf("/pl061@%" PRIx64, base);
-    qemu_fdt_add_subnode(vms->fdt, nodename);
-    qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "reg",
+    qemu_fdt_add_subnode(ms->fdt, nodename);
+    qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg",
                                  2, base, 2, size);
-    qemu_fdt_setprop(vms->fdt, nodename, "compatible", compat, sizeof(compat));
-    qemu_fdt_setprop_cell(vms->fdt, nodename, "#gpio-cells", 2);
-    qemu_fdt_setprop(vms->fdt, nodename, "gpio-controller", NULL, 0);
-    qemu_fdt_setprop_cells(vms->fdt, nodename, "interrupts",
+    qemu_fdt_setprop(ms->fdt, nodename, "compatible", compat, sizeof(compat));
+    qemu_fdt_setprop_cell(ms->fdt, nodename, "#gpio-cells", 2);
+    qemu_fdt_setprop(ms->fdt, nodename, "gpio-controller", NULL, 0);
+    qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupts",
                            GIC_FDT_IRQ_TYPE_SPI, irq,
                            GIC_FDT_IRQ_FLAGS_LEVEL_HI);
-    qemu_fdt_setprop_cell(vms->fdt, nodename, "clocks", vms->clock_phandle);
-    qemu_fdt_setprop_string(vms->fdt, nodename, "clock-names", "apb_pclk");
-    qemu_fdt_setprop_cell(vms->fdt, nodename, "phandle", phandle);
+    qemu_fdt_setprop_cell(ms->fdt, nodename, "clocks", vms->clock_phandle);
+    qemu_fdt_setprop_string(ms->fdt, nodename, "clock-names", "apb_pclk");
+    qemu_fdt_setprop_cell(ms->fdt, nodename, "phandle", phandle);
 
     gpio_key_dev = sysbus_create_simple("gpio-key", -1,
                                         qdev_get_gpio_in(pl061_dev, 3));
-    qemu_fdt_add_subnode(vms->fdt, "/gpio-keys");
-    qemu_fdt_setprop_string(vms->fdt, "/gpio-keys", "compatible", "gpio-keys");
-    qemu_fdt_setprop_cell(vms->fdt, "/gpio-keys", "#size-cells", 0);
-    qemu_fdt_setprop_cell(vms->fdt, "/gpio-keys", "#address-cells", 1);
+    qemu_fdt_add_subnode(ms->fdt, "/gpio-keys");
+    qemu_fdt_setprop_string(ms->fdt, "/gpio-keys", "compatible", "gpio-keys");
+    qemu_fdt_setprop_cell(ms->fdt, "/gpio-keys", "#size-cells", 0);
+    qemu_fdt_setprop_cell(ms->fdt, "/gpio-keys", "#address-cells", 1);
 
-    qemu_fdt_add_subnode(vms->fdt, "/gpio-keys/poweroff");
-    qemu_fdt_setprop_string(vms->fdt, "/gpio-keys/poweroff",
+    qemu_fdt_add_subnode(ms->fdt, "/gpio-keys/poweroff");
+    qemu_fdt_setprop_string(ms->fdt, "/gpio-keys/poweroff",
                             "label", "GPIO Key Poweroff");
-    qemu_fdt_setprop_cell(vms->fdt, "/gpio-keys/poweroff", "linux,code",
+    qemu_fdt_setprop_cell(ms->fdt, "/gpio-keys/poweroff", "linux,code",
                           KEY_POWER);
-    qemu_fdt_setprop_cells(vms->fdt, "/gpio-keys/poweroff",
+    qemu_fdt_setprop_cells(ms->fdt, "/gpio-keys/poweroff",
                            "gpios", phandle, 3, 0);
     g_free(nodename);
 }
@@ -867,6 +875,7 @@ static void create_virtio_devices(const VirtMachineState *vms)
 {
     int i;
     hwaddr size = vms->memmap[VIRT_MMIO].size;
+    MachineState *ms = MACHINE(vms);
 
     /* We create the transports in forwards order. Since qbus_realize()
      * prepends (not appends) new child buses, the incrementing loop below will
@@ -916,15 +925,15 @@ static void create_virtio_devices(const VirtMachineState *vms)
         hwaddr base = vms->memmap[VIRT_MMIO].base + i * size;
 
         nodename = g_strdup_printf("/virtio_mmio@%" PRIx64, base);
-        qemu_fdt_add_subnode(vms->fdt, nodename);
-        qemu_fdt_setprop_string(vms->fdt, nodename,
+        qemu_fdt_add_subnode(ms->fdt, nodename);
+        qemu_fdt_setprop_string(ms->fdt, nodename,
                                 "compatible", "virtio,mmio");
-        qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "reg",
+        qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg",
                                      2, base, 2, size);
-        qemu_fdt_setprop_cells(vms->fdt, nodename, "interrupts",
+        qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupts",
                                GIC_FDT_IRQ_TYPE_SPI, irq,
                                GIC_FDT_IRQ_FLAGS_EDGE_LO_HI);
-        qemu_fdt_setprop(vms->fdt, nodename, "dma-coherent", NULL, 0);
+        qemu_fdt_setprop(ms->fdt, nodename, "dma-coherent", NULL, 0);
         g_free(nodename);
     }
 }
@@ -1005,17 +1014,18 @@ static void virt_flash_fdt(VirtMachineState *vms,
 {
     hwaddr flashsize = vms->memmap[VIRT_FLASH].size / 2;
     hwaddr flashbase = vms->memmap[VIRT_FLASH].base;
+    MachineState *ms = MACHINE(vms);
     char *nodename;
 
     if (sysmem == secure_sysmem) {
         /* Report both flash devices as a single node in the DT */
         nodename = g_strdup_printf("/flash@%" PRIx64, flashbase);
-        qemu_fdt_add_subnode(vms->fdt, nodename);
-        qemu_fdt_setprop_string(vms->fdt, nodename, "compatible", "cfi-flash");
-        qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "reg",
+        qemu_fdt_add_subnode(ms->fdt, nodename);
+        qemu_fdt_setprop_string(ms->fdt, nodename, "compatible", "cfi-flash");
+        qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg",
                                      2, flashbase, 2, flashsize,
                                      2, flashbase + flashsize, 2, flashsize);
-        qemu_fdt_setprop_cell(vms->fdt, nodename, "bank-width", 4);
+        qemu_fdt_setprop_cell(ms->fdt, nodename, "bank-width", 4);
         g_free(nodename);
     } else {
         /*
@@ -1023,21 +1033,21 @@ static void virt_flash_fdt(VirtMachineState *vms,
          * only visible to the secure world.
          */
         nodename = g_strdup_printf("/secflash@%" PRIx64, flashbase);
-        qemu_fdt_add_subnode(vms->fdt, nodename);
-        qemu_fdt_setprop_string(vms->fdt, nodename, "compatible", "cfi-flash");
-        qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "reg",
+        qemu_fdt_add_subnode(ms->fdt, nodename);
+        qemu_fdt_setprop_string(ms->fdt, nodename, "compatible", "cfi-flash");
+        qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg",
                                      2, flashbase, 2, flashsize);
-        qemu_fdt_setprop_cell(vms->fdt, nodename, "bank-width", 4);
-        qemu_fdt_setprop_string(vms->fdt, nodename, "status", "disabled");
-        qemu_fdt_setprop_string(vms->fdt, nodename, "secure-status", "okay");
+        qemu_fdt_setprop_cell(ms->fdt, nodename, "bank-width", 4);
+        qemu_fdt_setprop_string(ms->fdt, nodename, "status", "disabled");
+        qemu_fdt_setprop_string(ms->fdt, nodename, "secure-status", "okay");
         g_free(nodename);
 
         nodename = g_strdup_printf("/flash@%" PRIx64, flashbase);
-        qemu_fdt_add_subnode(vms->fdt, nodename);
-        qemu_fdt_setprop_string(vms->fdt, nodename, "compatible", "cfi-flash");
-        qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "reg",
+        qemu_fdt_add_subnode(ms->fdt, nodename);
+        qemu_fdt_setprop_string(ms->fdt, nodename, "compatible", "cfi-flash");
+        qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg",
                                      2, flashbase + flashsize, 2, flashsize);
-        qemu_fdt_setprop_cell(vms->fdt, nodename, "bank-width", 4);
+        qemu_fdt_setprop_cell(ms->fdt, nodename, "bank-width", 4);
         g_free(nodename);
     }
 }
@@ -1102,17 +1112,17 @@ static FWCfgState *create_fw_cfg(const VirtMachineState *vms, AddressSpace *as)
     fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, (uint16_t)ms->smp.cpus);
 
     nodename = g_strdup_printf("/fw-cfg@%" PRIx64, base);
-    qemu_fdt_add_subnode(vms->fdt, nodename);
-    qemu_fdt_setprop_string(vms->fdt, nodename,
+    qemu_fdt_add_subnode(ms->fdt, nodename);
+    qemu_fdt_setprop_string(ms->fdt, nodename,
                             "compatible", "qemu,fw-cfg-mmio");
-    qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "reg",
+    qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg",
                                  2, base, 2, size);
-    qemu_fdt_setprop(vms->fdt, nodename, "dma-coherent", NULL, 0);
+    qemu_fdt_setprop(ms->fdt, nodename, "dma-coherent", NULL, 0);
     g_free(nodename);
     return fw_cfg;
 }
 
-static void create_pcie_irq_map(const VirtMachineState *vms,
+static void create_pcie_irq_map(const MachineState *ms,
                                 uint32_t gic_phandle,
                                 int first_irq, const char *nodename)
 {
@@ -1140,10 +1150,10 @@ static void create_pcie_irq_map(const VirtMachineState *vms,
         }
     }
 
-    qemu_fdt_setprop(vms->fdt, nodename, "interrupt-map",
+    qemu_fdt_setprop(ms->fdt, nodename, "interrupt-map",
                      full_irq_map, sizeof(full_irq_map));
 
-    qemu_fdt_setprop_cells(vms->fdt, nodename, "interrupt-map-mask",
+    qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupt-map-mask",
                            0x1800, 0, 0, /* devfn (PCI_SLOT(3)) */
                            0x7           /* PCI irq */);
 }
@@ -1159,6 +1169,7 @@ static void create_smmu(const VirtMachineState *vms,
     hwaddr size = vms->memmap[VIRT_SMMU].size;
     const char irq_names[] = "eventq\0priq\0cmdq-sync\0gerror";
     DeviceState *dev;
+    MachineState *ms = MACHINE(vms);
 
     if (vms->iommu != VIRT_IOMMU_SMMUV3 || !vms->iommu_phandle) {
         return;
@@ -1176,26 +1187,26 @@ static void create_smmu(const VirtMachineState *vms,
     }
 
     node = g_strdup_printf("/smmuv3@%" PRIx64, base);
-    qemu_fdt_add_subnode(vms->fdt, node);
-    qemu_fdt_setprop(vms->fdt, node, "compatible", compat, sizeof(compat));
-    qemu_fdt_setprop_sized_cells(vms->fdt, node, "reg", 2, base, 2, size);
+    qemu_fdt_add_subnode(ms->fdt, node);
+    qemu_fdt_setprop(ms->fdt, node, "compatible", compat, sizeof(compat));
+    qemu_fdt_setprop_sized_cells(ms->fdt, node, "reg", 2, base, 2, size);
 
-    qemu_fdt_setprop_cells(vms->fdt, node, "interrupts",
+    qemu_fdt_setprop_cells(ms->fdt, node, "interrupts",
             GIC_FDT_IRQ_TYPE_SPI, irq    , GIC_FDT_IRQ_FLAGS_EDGE_LO_HI,
             GIC_FDT_IRQ_TYPE_SPI, irq + 1, GIC_FDT_IRQ_FLAGS_EDGE_LO_HI,
             GIC_FDT_IRQ_TYPE_SPI, irq + 2, GIC_FDT_IRQ_FLAGS_EDGE_LO_HI,
             GIC_FDT_IRQ_TYPE_SPI, irq + 3, GIC_FDT_IRQ_FLAGS_EDGE_LO_HI);
 
-    qemu_fdt_setprop(vms->fdt, node, "interrupt-names", irq_names,
+    qemu_fdt_setprop(ms->fdt, node, "interrupt-names", irq_names,
                      sizeof(irq_names));
 
-    qemu_fdt_setprop_cell(vms->fdt, node, "clocks", vms->clock_phandle);
-    qemu_fdt_setprop_string(vms->fdt, node, "clock-names", "apb_pclk");
-    qemu_fdt_setprop(vms->fdt, node, "dma-coherent", NULL, 0);
+    qemu_fdt_setprop_cell(ms->fdt, node, "clocks", vms->clock_phandle);
+    qemu_fdt_setprop_string(ms->fdt, node, "clock-names", "apb_pclk");
+    qemu_fdt_setprop(ms->fdt, node, "dma-coherent", NULL, 0);
 
-    qemu_fdt_setprop_cell(vms->fdt, node, "#iommu-cells", 1);
+    qemu_fdt_setprop_cell(ms->fdt, node, "#iommu-cells", 1);
 
-    qemu_fdt_setprop_cell(vms->fdt, node, "phandle", vms->iommu_phandle);
+    qemu_fdt_setprop_cell(ms->fdt, node, "phandle", vms->iommu_phandle);
     g_free(node);
 }
 
@@ -1203,22 +1214,23 @@ static void create_virtio_iommu_dt_bindings(VirtMachineState *vms)
 {
     const char compat[] = "virtio,pci-iommu";
     uint16_t bdf = vms->virtio_iommu_bdf;
+    MachineState *ms = MACHINE(vms);
     char *node;
 
-    vms->iommu_phandle = qemu_fdt_alloc_phandle(vms->fdt);
+    vms->iommu_phandle = qemu_fdt_alloc_phandle(ms->fdt);
 
     node = g_strdup_printf("%s/virtio_iommu@%d", vms->pciehb_nodename, bdf);
-    qemu_fdt_add_subnode(vms->fdt, node);
-    qemu_fdt_setprop(vms->fdt, node, "compatible", compat, sizeof(compat));
-    qemu_fdt_setprop_sized_cells(vms->fdt, node, "reg",
+    qemu_fdt_add_subnode(ms->fdt, node);
+    qemu_fdt_setprop(ms->fdt, node, "compatible", compat, sizeof(compat));
+    qemu_fdt_setprop_sized_cells(ms->fdt, node, "reg",
                                  1, bdf << 8, 1, 0, 1, 0,
                                  1, 0, 1, 0);
 
-    qemu_fdt_setprop_cell(vms->fdt, node, "#iommu-cells", 1);
-    qemu_fdt_setprop_cell(vms->fdt, node, "phandle", vms->iommu_phandle);
+    qemu_fdt_setprop_cell(ms->fdt, node, "#iommu-cells", 1);
+    qemu_fdt_setprop_cell(ms->fdt, node, "phandle", vms->iommu_phandle);
     g_free(node);
 
-    qemu_fdt_setprop_cells(vms->fdt, vms->pciehb_nodename, "iommu-map",
+    qemu_fdt_setprop_cells(ms->fdt, vms->pciehb_nodename, "iommu-map",
                            0x0, vms->iommu_phandle, 0x0, bdf,
                            bdf + 1, vms->iommu_phandle, bdf + 1, 0xffff - bdf);
 }
@@ -1243,6 +1255,7 @@ static void create_pcie(VirtMachineState *vms)
     char *nodename;
     int i, ecam_id;
     PCIHostState *pci;
+    MachineState *ms = MACHINE(vms);
 
     dev = qdev_new(TYPE_GPEX_HOST);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
@@ -1302,27 +1315,27 @@ static void create_pcie(VirtMachineState *vms)
     }
 
     nodename = vms->pciehb_nodename = g_strdup_printf("/pcie@%" PRIx64, base);
-    qemu_fdt_add_subnode(vms->fdt, nodename);
-    qemu_fdt_setprop_string(vms->fdt, nodename,
+    qemu_fdt_add_subnode(ms->fdt, nodename);
+    qemu_fdt_setprop_string(ms->fdt, nodename,
                             "compatible", "pci-host-ecam-generic");
-    qemu_fdt_setprop_string(vms->fdt, nodename, "device_type", "pci");
-    qemu_fdt_setprop_cell(vms->fdt, nodename, "#address-cells", 3);
-    qemu_fdt_setprop_cell(vms->fdt, nodename, "#size-cells", 2);
-    qemu_fdt_setprop_cell(vms->fdt, nodename, "linux,pci-domain", 0);
-    qemu_fdt_setprop_cells(vms->fdt, nodename, "bus-range", 0,
+    qemu_fdt_setprop_string(ms->fdt, nodename, "device_type", "pci");
+    qemu_fdt_setprop_cell(ms->fdt, nodename, "#address-cells", 3);
+    qemu_fdt_setprop_cell(ms->fdt, nodename, "#size-cells", 2);
+    qemu_fdt_setprop_cell(ms->fdt, nodename, "linux,pci-domain", 0);
+    qemu_fdt_setprop_cells(ms->fdt, nodename, "bus-range", 0,
                            nr_pcie_buses - 1);
-    qemu_fdt_setprop(vms->fdt, nodename, "dma-coherent", NULL, 0);
+    qemu_fdt_setprop(ms->fdt, nodename, "dma-coherent", NULL, 0);
 
     if (vms->msi_phandle) {
-        qemu_fdt_setprop_cells(vms->fdt, nodename, "msi-parent",
+        qemu_fdt_setprop_cells(ms->fdt, nodename, "msi-parent",
                                vms->msi_phandle);
     }
 
-    qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "reg",
+    qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg",
                                  2, base_ecam, 2, size_ecam);
 
     if (vms->highmem) {
-        qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "ranges",
+        qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "ranges",
                                      1, FDT_PCI_RANGE_IOPORT, 2, 0,
                                      2, base_pio, 2, size_pio,
                                      1, FDT_PCI_RANGE_MMIO, 2, base_mmio,
@@ -1331,23 +1344,23 @@ static void create_pcie(VirtMachineState *vms)
                                      2, base_mmio_high,
                                      2, base_mmio_high, 2, size_mmio_high);
     } else {
-        qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "ranges",
+        qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "ranges",
                                      1, FDT_PCI_RANGE_IOPORT, 2, 0,
                                      2, base_pio, 2, size_pio,
                                      1, FDT_PCI_RANGE_MMIO, 2, base_mmio,
                                      2, base_mmio, 2, size_mmio);
     }
 
-    qemu_fdt_setprop_cell(vms->fdt, nodename, "#interrupt-cells", 1);
-    create_pcie_irq_map(vms, vms->gic_phandle, irq, nodename);
+    qemu_fdt_setprop_cell(ms->fdt, nodename, "#interrupt-cells", 1);
+    create_pcie_irq_map(ms, vms->gic_phandle, irq, nodename);
 
     if (vms->iommu) {
-        vms->iommu_phandle = qemu_fdt_alloc_phandle(vms->fdt);
+        vms->iommu_phandle = qemu_fdt_alloc_phandle(ms->fdt);
 
         switch (vms->iommu) {
         case VIRT_IOMMU_SMMUV3:
             create_smmu(vms, pci->bus);
-            qemu_fdt_setprop_cells(vms->fdt, nodename, "iommu-map",
+            qemu_fdt_setprop_cells(ms->fdt, nodename, "iommu-map",
                                    0x0, vms->iommu_phandle, 0x0, 0x10000);
             break;
         default:
@@ -1399,17 +1412,18 @@ static void create_secure_ram(VirtMachineState *vms,
     char *nodename;
     hwaddr base = vms->memmap[VIRT_SECURE_MEM].base;
     hwaddr size = vms->memmap[VIRT_SECURE_MEM].size;
+    MachineState *ms = MACHINE(vms);
 
     memory_region_init_ram(secram, NULL, "virt.secure-ram", size,
                            &error_fatal);
     memory_region_add_subregion(secure_sysmem, base, secram);
 
     nodename = g_strdup_printf("/secram@%" PRIx64, base);
-    qemu_fdt_add_subnode(vms->fdt, nodename);
-    qemu_fdt_setprop_string(vms->fdt, nodename, "device_type", "memory");
-    qemu_fdt_setprop_sized_cells(vms->fdt, nodename, "reg", 2, base, 2, size);
-    qemu_fdt_setprop_string(vms->fdt, nodename, "status", "disabled");
-    qemu_fdt_setprop_string(vms->fdt, nodename, "secure-status", "okay");
+    qemu_fdt_add_subnode(ms->fdt, nodename);
+    qemu_fdt_setprop_string(ms->fdt, nodename, "device_type", "memory");
+    qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg", 2, base, 2, size);
+    qemu_fdt_setprop_string(ms->fdt, nodename, "status", "disabled");
+    qemu_fdt_setprop_string(ms->fdt, nodename, "secure-status", "okay");
 
     if (secure_tag_sysmem) {
         create_tag_ram(secure_tag_sysmem, base, size, "mach-virt.secure-tag");
@@ -1422,9 +1436,11 @@ static void *machvirt_dtb(const struct arm_boot_info *binfo, int *fdt_size)
 {
     const VirtMachineState *board = container_of(binfo, VirtMachineState,
                                                  bootinfo);
+    MachineState *ms = MACHINE(board);
+
 
     *fdt_size = board->fdt_size;
-    return board->fdt;
+    return ms->fdt;
 }
 
 static void virt_build_smbios(VirtMachineState *vms)
@@ -1472,7 +1488,7 @@ void virt_machine_done(Notifier *notifier, void *data)
      * while qemu takes charge of the qom stuff.
      */
     if (info->dtb_filename == NULL) {
-        platform_bus_add_all_fdt_nodes(vms->fdt, "/intc",
+        platform_bus_add_all_fdt_nodes(ms->fdt, "/intc",
                                        vms->memmap[VIRT_PLATFORM_BUS].base,
                                        vms->memmap[VIRT_PLATFORM_BUS].size,
                                        vms->irqmap[VIRT_PLATFORM_BUS]);
-- 
2.20.1


