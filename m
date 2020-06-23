Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74EABC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 20:13:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 305F32145D
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 20:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JHHPgyNn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 305F32145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnpI0-00055K-En
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 16:13:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43140)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jnokA-0005Vb-Er
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 15:38:06 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:42703)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jnok5-0005wz-1K
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 15:38:06 -0400
Received: by mail-pl1-x641.google.com with SMTP id k6so9533534pll.9
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 12:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zyEHdJWwYhTj12SKxTq5TMOt6kdP7E77bjUjnXgXSbo=;
 b=JHHPgyNn1RiHD56GsRLT2F1Q1xXhpVu7wlqf5du1IibbR5D9AetC9Ps1/lRWEdZ27J
 xkiGdlDyM391zzaoYTMgPNk4PPtObA7+LLo0sblGnqKDXGAhNjtCognGBBZ727rs6l2V
 Bi6ajgiBIVYO+kjid5p5W1ZbAXeVHtYOFeL+wOxrKDtkLpovW+lll/MkPsG/q0PtsFX7
 UhF1p9N05EJFt3R8dySgYb5uY8Kz+2eH18yRCQ+Hoes9LzjUbFjVbMz2Up+k86KLX/eG
 y3esBAxLWbUNoCUY5qTC12QU4bcyjDgdoAJkqtsqv8rTO3yEA3OIusqgP7zAUkNpC6JT
 +Row==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zyEHdJWwYhTj12SKxTq5TMOt6kdP7E77bjUjnXgXSbo=;
 b=fk9YeoFmSc6sy7wen1U+yp5zfRxEYlj1h/4Hcj+cjbT4DdEF9urG3jGdZ3/lgUB3HL
 9zDoip231oNtZATbpJ+MU8ZL+0XDcQWOX3DWph4Z4eFkLqV8orddRGgngpRzRP7iiiFa
 jkwhzkjCBYU7paEe+W40N6C2W2zwv4ZR5pt6IyTNtQfTmhHje/aNZM8li/bhGRsDUUZ1
 KfO3JsoEDYOsDJWujloZlciJAoX7mNOp2NKuXNseyFUpUeQ9SoqwTjmKwhbzVaFLPT07
 peT5uOgZxqeqrH2ga/JfqhuqF84n5S+1UV+QiBuc1WYdirqQpydTxJkRS4LPiyXkS27/
 AzSQ==
X-Gm-Message-State: AOAM530q7hzS1knuoyv0cRwWhm2mipQ0FQd2uRVbw2opHeBiusS2ayDH
 E3maYR6Nm1Qs/uarU/+M/z2qkaDhpJQ=
X-Google-Smtp-Source: ABdhPJw5ErH5ZInlORVYGepyLu/e/aplhtK6mkaLJ2+VxRRokiGz+BsYXXvv+5Gf9FYbRuzgy0aT8g==
X-Received: by 2002:a17:902:8b82:: with SMTP id
 ay2mr14248871plb.185.1592941079197; 
 Tue, 23 Jun 2020 12:37:59 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id p12sm17927642pfq.69.2020.06.23.12.37.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 12:37:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 43/45] target/arm: Create tagged ram when MTE is enabled
Date: Tue, 23 Jun 2020 12:36:56 -0700
Message-Id: <20200623193658.623279-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200623193658.623279-1-richard.henderson@linaro.org>
References: <20200623193658.623279-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, david.spickett@linaro.org,
 steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v5: Assign cs->num_ases to the final value first.
    Downgrade to ID_AA64PFR1.MTE=1 if tag memory is not available.
v6: Add secure tag memory for EL3.
v8: Add arm,armv8.5-memtag.
---
 include/hw/arm/boot.h |  3 +++
 target/arm/cpu.h      |  6 +++++
 hw/arm/boot.c         | 12 ++++++---
 hw/arm/virt.c         | 57 +++++++++++++++++++++++++++++++++++++++++--
 target/arm/cpu.c      | 51 +++++++++++++++++++++++++++++++++++---
 5 files changed, 121 insertions(+), 8 deletions(-)

diff --git a/include/hw/arm/boot.h b/include/hw/arm/boot.h
index ce2b48b88b..605446afe7 100644
--- a/include/hw/arm/boot.h
+++ b/include/hw/arm/boot.h
@@ -116,6 +116,9 @@ struct arm_boot_info {
      */
     bool secure_board_setup;
 
+    /* If set, all ram objects have tag memory objects. */
+    bool tag_memory;
+
     arm_endianness endianness;
 };
 
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 10c4d031b1..206e617c25 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -792,6 +792,10 @@ struct ARMCPU {
     /* MemoryRegion to use for secure physical accesses */
     MemoryRegion *secure_memory;
 
+    /* MemoryRegion to use for allocation tag accesses */
+    MemoryRegion *tag_memory;
+    MemoryRegion *secure_tag_memory;
+
     /* For v8M, pointer to the IDAU interface provided by board/SoC */
     Object *idau;
 
@@ -2985,6 +2989,8 @@ typedef enum ARMMMUIdxBit {
 typedef enum ARMASIdx {
     ARMASIdx_NS = 0,
     ARMASIdx_S = 1,
+    ARMASIdx_TagNS = 2,
+    ARMASIdx_TagS = 3,
 } ARMASIdx;
 
 /* Return the Exception Level targeted by debug exceptions. */
diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index fef4072db1..4f96ce42fe 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -427,7 +427,7 @@ static void set_kernel_args_old(const struct arm_boot_info *info,
 
 static int fdt_add_memory_node(void *fdt, uint32_t acells, hwaddr mem_base,
                                uint32_t scells, hwaddr mem_len,
-                               int numa_node_id)
+                               int numa_node_id, bool tag_memory)
 {
     char *nodename;
     int ret;
@@ -446,6 +446,10 @@ static int fdt_add_memory_node(void *fdt, uint32_t acells, hwaddr mem_base,
         ret = qemu_fdt_setprop_cell(fdt, nodename,
                                     "numa-node-id", numa_node_id);
     }
+    if (tag_memory) {
+        qemu_fdt_setprop(fdt, nodename, "arm,armv8.5-memtag", "", 0);
+    }
+
 out:
     g_free(nodename);
     return ret;
@@ -534,6 +538,7 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
     hwaddr mem_base, mem_len;
     char **node_path;
     Error *err = NULL;
+    bool tag_memory;
 
     if (binfo->dtb_filename) {
         char *filename;
@@ -599,12 +604,13 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
     }
     g_strfreev(node_path);
 
+    tag_memory = binfo->tag_memory;
     if (ms->numa_state != NULL && ms->numa_state->num_nodes > 0) {
         mem_base = binfo->loader_start;
         for (i = 0; i < ms->numa_state->num_nodes; i++) {
             mem_len = ms->numa_state->nodes[i].node_mem;
             rc = fdt_add_memory_node(fdt, acells, mem_base,
-                                     scells, mem_len, i);
+                                     scells, mem_len, i, tag_memory);
             if (rc < 0) {
                 fprintf(stderr, "couldn't add /memory@%"PRIx64" node\n",
                         mem_base);
@@ -615,7 +621,7 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
         }
     } else {
         rc = fdt_add_memory_node(fdt, acells, binfo->loader_start,
-                                 scells, binfo->ram_size, -1);
+                                 scells, binfo->ram_size, -1, tag_memory);
         if (rc < 0) {
             fprintf(stderr, "couldn't add /memory@%"PRIx64" node\n",
                     binfo->loader_start);
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index caceb1e4a0..0d81e0d3ac 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1390,8 +1390,19 @@ static void create_platform_bus(VirtMachineState *vms)
                                 sysbus_mmio_get_region(s, 0));
 }
 
+static void create_tag_ram(MemoryRegion *tag_sysmem,
+                           hwaddr base, hwaddr size,
+                           const char *name)
+{
+    MemoryRegion *tagram = g_new(MemoryRegion, 1);
+
+    memory_region_init_ram(tagram, NULL, name, size / 32, &error_fatal);
+    memory_region_add_subregion(tag_sysmem, base / 32, tagram);
+}
+
 static void create_secure_ram(VirtMachineState *vms,
-                              MemoryRegion *secure_sysmem)
+                              MemoryRegion *secure_sysmem,
+                              MemoryRegion *secure_tag_sysmem)
 {
     MemoryRegion *secram = g_new(MemoryRegion, 1);
     char *nodename;
@@ -1409,6 +1420,11 @@ static void create_secure_ram(VirtMachineState *vms,
     qemu_fdt_setprop_string(vms->fdt, nodename, "status", "disabled");
     qemu_fdt_setprop_string(vms->fdt, nodename, "secure-status", "okay");
 
+    if (secure_tag_sysmem) {
+        create_tag_ram(secure_tag_sysmem, base, size, "mach-virt.secure-tag");
+        qemu_fdt_setprop(vms->fdt, nodename, "arm,armv8.5-memtag", "", 0);
+    }
+
     g_free(nodename);
 }
 
@@ -1665,6 +1681,8 @@ static void machvirt_init(MachineState *machine)
     const CPUArchIdList *possible_cpus;
     MemoryRegion *sysmem = get_system_memory();
     MemoryRegion *secure_sysmem = NULL;
+    MemoryRegion *tag_sysmem = NULL;
+    MemoryRegion *secure_tag_sysmem = NULL;
     int n, virt_max_cpus;
     bool firmware_loaded;
     bool aarch64 = true;
@@ -1819,6 +1837,36 @@ static void machvirt_init(MachineState *machine)
                                      "secure-memory", &error_abort);
         }
 
+        /*
+         * The cpu adds the property if and only if MemTag is supported.
+         * If it is, we must allocate the ram to back that up.
+         */
+        if (object_property_find(cpuobj, "tag-memory", NULL)) {
+            if (!tag_sysmem) {
+                vms->bootinfo.tag_memory = true;
+                tag_sysmem = g_new(MemoryRegion, 1);
+                memory_region_init(tag_sysmem, OBJECT(machine),
+                                   "tag-memory", UINT64_MAX / 32);
+
+                if (vms->secure) {
+                    secure_tag_sysmem = g_new(MemoryRegion, 1);
+                    memory_region_init(secure_tag_sysmem, OBJECT(machine),
+                                       "secure-tag-memory", UINT64_MAX / 32);
+
+                    /* As with ram, secure-tag takes precedence over tag.  */
+                    memory_region_add_subregion_overlap(secure_tag_sysmem, 0,
+                                                        tag_sysmem, -1);
+                }
+            }
+
+            object_property_set_link(cpuobj, OBJECT(tag_sysmem),
+                                     "tag-memory", &error_abort);
+            if (vms->secure) {
+                object_property_set_link(cpuobj, OBJECT(secure_tag_sysmem),
+                                         "secure-tag-memory", &error_abort);
+            }
+        }
+
         qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
         object_unref(cpuobj);
     }
@@ -1857,10 +1905,15 @@ static void machvirt_init(MachineState *machine)
     create_uart(vms, VIRT_UART, sysmem, serial_hd(0));
 
     if (vms->secure) {
-        create_secure_ram(vms, secure_sysmem);
+        create_secure_ram(vms, secure_sysmem, secure_tag_sysmem);
         create_uart(vms, VIRT_SECURE_UART, secure_sysmem, serial_hd(1));
     }
 
+    if (tag_sysmem) {
+        create_tag_ram(tag_sysmem, vms->memmap[VIRT_MEM].base,
+                       machine->ram_size, "mach-virt.tag");
+    }
+
     vms->highmem_ecam &= vms->highmem && (!firmware_loaded || aarch64);
 
     create_rtc(vms);
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index f09efc4370..7159188247 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1249,6 +1249,25 @@ void arm_cpu_post_init(Object *obj)
     if (kvm_enabled()) {
         kvm_arm_add_vcpu_properties(obj);
     }
+
+#ifndef CONFIG_USER_ONLY
+    if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64) &&
+        cpu_isar_feature(aa64_mte, cpu)) {
+        object_property_add_link(obj, "tag-memory",
+                                 TYPE_MEMORY_REGION,
+                                 (Object **)&cpu->tag_memory,
+                                 qdev_prop_allow_set_link_before_realize,
+                                 OBJ_PROP_LINK_STRONG);
+
+        if (arm_feature(&cpu->env, ARM_FEATURE_EL3)) {
+            object_property_add_link(obj, "secure-tag-memory",
+                                     TYPE_MEMORY_REGION,
+                                     (Object **)&cpu->secure_tag_memory,
+                                     qdev_prop_allow_set_link_before_realize,
+                                     OBJ_PROP_LINK_STRONG);
+        }
+    }
+#endif
 }
 
 static void arm_cpu_finalizefn(Object *obj)
@@ -1739,17 +1758,43 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     MachineState *ms = MACHINE(qdev_get_machine());
     unsigned int smp_cpus = ms->smp.cpus;
 
-    if (cpu->has_el3 || arm_feature(env, ARM_FEATURE_M_SECURITY)) {
+    /*
+     * We must set cs->num_ases to the final value before
+     * the first call to cpu_address_space_init.
+     */
+    if (cpu->tag_memory != NULL) {
+        cs->num_ases = 4;
+    } else if (cpu->has_el3 || arm_feature(env, ARM_FEATURE_M_SECURITY)) {
         cs->num_ases = 2;
+    } else {
+        cs->num_ases = 1;
+    }
 
+    if (cpu->has_el3 || arm_feature(env, ARM_FEATURE_M_SECURITY)) {
         if (!cpu->secure_memory) {
             cpu->secure_memory = cs->memory;
         }
         cpu_address_space_init(cs, ARMASIdx_S, "cpu-secure-memory",
                                cpu->secure_memory);
-    } else {
-        cs->num_ases = 1;
     }
+
+    if (cpu->tag_memory != NULL) {
+        cpu_address_space_init(cs, ARMASIdx_TagNS, "cpu-tag-memory",
+                               cpu->tag_memory);
+        if (cpu->has_el3) {
+            cpu_address_space_init(cs, ARMASIdx_TagS, "cpu-tag-memory",
+                                   cpu->secure_tag_memory);
+        }
+    } else if (cpu_isar_feature(aa64_mte, cpu)) {
+        /*
+         * Since there is no tag memory, we can't meaningfully support MTE
+         * to its fullest.  To avoid problems later, when we would come to
+         * use the tag memory, downgrade support to insns only.
+         */
+        cpu->isar.id_aa64pfr1 =
+            FIELD_DP64(cpu->isar.id_aa64pfr1, ID_AA64PFR1, MTE, 1);
+    }
+
     cpu_address_space_init(cs, ARMASIdx_NS, "cpu-memory", cs->memory);
 
     /* No core_count specified, default to smp_cpus. */
-- 
2.25.1


