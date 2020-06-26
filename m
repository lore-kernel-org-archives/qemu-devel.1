Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1943AC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 03:45:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB19020709
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 03:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QWApUtdg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB19020709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jofIX-00079D-2z
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 23:45:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jof6d-0001Sk-Ga
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 23:32:47 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:46889)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jof6b-00028I-Ow
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 23:32:47 -0400
Received: by mail-pl1-x641.google.com with SMTP id u9so148568pls.13
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 20:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1F/w81UrqNnn4VlReFv/WgmS1f6+AVRfCF0bHgwnqgo=;
 b=QWApUtdgePTL32oeZOg8DhN/DZVzuJNvm/9klxW93B3MfHLupBfxAhHV+aiFUY1gYD
 574U1qURu7whZ12j/SsdygnL7whSvWadpmlWlZbDRgdyu6hUNpQiVDrcoexBpIC8jRPM
 DNbQ1W9XQdOaQcWpSUHY21nhejaxc47bFHTzb0d0jIrHDNaRsn0sxh0lTTgG5UNEUFLt
 73i+nnXQtHfTz0YTRDaL7yrDLm5zzUo3i44XWJB5BEoYT1lztFfi3fJxrvYitEWAHeuG
 aqeDgtiCn4GvdrUVHCVIJwM4MG3VWO4xWNJZTHMpZoAk6GP5NDal5QzEU3PIAvjCOvaC
 K0XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1F/w81UrqNnn4VlReFv/WgmS1f6+AVRfCF0bHgwnqgo=;
 b=TLHD12MlTfN4dP+SXACImrLf+hISjB89bU8Y3kREu8GMTnIp9qtN/69k2e4RjXQC9J
 peRvNbQ1cCRg1c0AJYigWXCKnN5lcyhLHjWyQ70MlKwnmylEPqtkg8x9Erh2+XTjwdO5
 MbgOAeBxpjHMPxPi+s3CvG7TXmuH9SLec99NI21ayMnMlZIIa1ImrQ9H9BN9tFSEmEfW
 AfIwmDuidxazMwJRjbSqaizDJd72b6fHvBgXCR7aMs+MtofaLUnz2TmovgrbpKrv7ICg
 Cd8SBu1KTV2IeugvYLUCVO2LoHYMsaycU+AnIL1DqpZNoL6ZOMYcwFXjEaARC33PtuH3
 02FA==
X-Gm-Message-State: AOAM533x+skhkEUvlSZTjBRjOGDAP9Ur2wDgf/UET7ckCne/AASUGU7G
 c93QlNnqPL4aQtSaWVNhrUmrrJdt6aM=
X-Google-Smtp-Source: ABdhPJwGebuejprRZCbcdkIFCdxEZxlWiMk23dCVpmBdgGCdkjonzY2YD6SysbaxhHi9NjdVUv5Cvg==
X-Received: by 2002:a17:902:7288:: with SMTP id d8mr921347pll.18.1593142364011; 
 Thu, 25 Jun 2020 20:32:44 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id y27sm1605256pgc.56.2020.06.25.20.32.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 20:32:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 43/46] target/arm: Create tagged ram when MTE is enabled
Date: Thu, 25 Jun 2020 20:31:41 -0700
Message-Id: <20200626033144.790098-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200626033144.790098-1-richard.henderson@linaro.org>
References: <20200626033144.790098-1-richard.henderson@linaro.org>
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
v9: Split arm,armv8.5-memtag to another patch;
    adjust how address spaces are allocated.
---
 target/arm/cpu.h |  6 ++++++
 hw/arm/virt.c    | 55 ++++++++++++++++++++++++++++++++++++++++++++++--
 target/arm/cpu.c | 52 +++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 107 insertions(+), 6 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 513c38970c..cf99dcca9f 100644
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
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 402c362c14..22ce6d6199 100644
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
@@ -1409,6 +1420,10 @@ static void create_secure_ram(VirtMachineState *vms,
     qemu_fdt_setprop_string(vms->fdt, nodename, "status", "disabled");
     qemu_fdt_setprop_string(vms->fdt, nodename, "secure-status", "okay");
 
+    if (secure_tag_sysmem) {
+        create_tag_ram(secure_tag_sysmem, base, size, "mach-virt.secure-tag");
+    }
+
     g_free(nodename);
 }
 
@@ -1665,6 +1680,8 @@ static void machvirt_init(MachineState *machine)
     const CPUArchIdList *possible_cpus;
     MemoryRegion *sysmem = get_system_memory();
     MemoryRegion *secure_sysmem = NULL;
+    MemoryRegion *tag_sysmem = NULL;
+    MemoryRegion *secure_tag_sysmem = NULL;
     int n, virt_max_cpus;
     bool firmware_loaded;
     bool aarch64 = true;
@@ -1819,6 +1836,35 @@ static void machvirt_init(MachineState *machine)
                                      "secure-memory", &error_abort);
         }
 
+        /*
+         * The cpu adds the property if and only if MemTag is supported.
+         * If it is, we must allocate the ram to back that up.
+         */
+        if (object_property_find(cpuobj, "tag-memory", NULL)) {
+            if (!tag_sysmem) {
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
@@ -1857,10 +1903,15 @@ static void machvirt_init(MachineState *machine)
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
index afe81e9b6c..5050e1843a 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1252,6 +1252,25 @@ void arm_cpu_post_init(Object *obj)
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
@@ -1741,18 +1760,43 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
 #ifndef CONFIG_USER_ONLY
     MachineState *ms = MACHINE(qdev_get_machine());
     unsigned int smp_cpus = ms->smp.cpus;
+    bool has_secure = cpu->has_el3 || arm_feature(env, ARM_FEATURE_M_SECURITY);
 
-    if (cpu->has_el3 || arm_feature(env, ARM_FEATURE_M_SECURITY)) {
-        cs->num_ases = 2;
+    /*
+     * We must set cs->num_ases to the final value before
+     * the first call to cpu_address_space_init.
+     */
+    if (cpu->tag_memory != NULL) {
+        cs->num_ases = 3 + has_secure;
+    } else {
+        cs->num_ases = 1 + has_secure;
+    }
 
+    if (has_secure) {
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
+        if (has_secure) {
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


