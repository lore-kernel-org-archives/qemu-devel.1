Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D1D4C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:43:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D51320706
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nKqRn2BE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D51320706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joqVe-0002vY-FA
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 11:43:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36348)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq4o-0003gi-F0
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:15:38 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:35869)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq4l-0006lZ-CA
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:15:38 -0400
Received: by mail-wm1-x332.google.com with SMTP id 17so9712872wmo.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 08:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=h/3DnkQWRTMLrqyNSK2kflfIoP8tD7HC02FZ4qjgwGY=;
 b=nKqRn2BEx0Pk/As1vlr+J/qXUpS/5OVCLpAdmD4Mxyr+4W6KkV9gLti/cHhi5hfhFp
 tYM4daSIsgpERZRjHSBzxP3DnHYWGbXG5SItF2IamMZMKrs+NFrctJov/qt1JP6VhO6l
 AX7eApFPfm15Rf6SrYQk24/Ms5PCfo/U3nIshGAp7S5FpTCpiPFmE+mQBpe0NjN1q0+Y
 k4thl8lHFqxqlFvHOuBXLqzPdfQ5BxP4eUZyxB64UPqWuNyWH9LNC2wZ7If0qr+9Qbha
 1ePVaVmBhNhOBYIrvBx4LpoG71P6KY/CUrJlv3yxNxPoXzXk36zIVRwx1/5i1rpGWrXZ
 hipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=h/3DnkQWRTMLrqyNSK2kflfIoP8tD7HC02FZ4qjgwGY=;
 b=KZYA+DIh66ZpSDdjU9/QIAM1A0L26QeLbxNL3d9gPmlImGIOBPJOQM6eTxEo94o/mU
 Wj5VRtNWwLId+SZguR9ALqauO9h43cjRuvr5iy/IQbdRC8e+r9BHD7eee5Dc2G1I+f5M
 axyUi6q8EF+LjNUW5UOQZjKg2XSHFtiYU+z3vdD4lOAVykct/OxLPa/APkegcozr/v7X
 Mokzh0wJn5bIOMKhLSgvIcOo2ZTZc7SUuElTb5UKBDTKnnK1+qz3vsX1kZdA1le/CD0S
 1Zhd1QGbL+flS3VndlUqrPtC8NU3hSL0net0KflS2JMzzKsNHxwJP1vTPiQHI/nXSiS5
 zHMA==
X-Gm-Message-State: AOAM532LxdEv6mEr5ICjfTXbf+ufRQwQC+1E3ZQfkjgCuxhbiCYiCwyv
 xR/Yz68PDRd3FQW83/jDawfuLSHYD4/FMg==
X-Google-Smtp-Source: ABdhPJwf3nw1LBHHaJPT6lIPM40snq7hIt0aDXls3tFAZ5EXaihrV8oiuml/9QzWJe1l1NwrCjl6Zg==
X-Received: by 2002:a1c:9911:: with SMTP id b17mr1063817wme.135.1593184533640; 
 Fri, 26 Jun 2020 08:15:33 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w13sm37838852wrr.67.2020.06.26.08.15.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 08:15:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 55/57] target/arm: Create tagged ram when MTE is enabled
Date: Fri, 26 Jun 2020 16:14:22 +0100
Message-Id: <20200626151424.30117-56-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200626151424.30117-1-peter.maydell@linaro.org>
References: <20200626151424.30117-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20200626033144.790098-44-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h |  6 ++++++
 hw/arm/virt.c    | 55 ++++++++++++++++++++++++++++++++++++++++++++++--
 target/arm/cpu.c | 52 +++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 107 insertions(+), 6 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 513c38970cc..cf99dcca9f3 100644
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
index 402c362c144..22ce6d61998 100644
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
index afe81e9b6c0..5050e1843a8 100644
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
2.20.1


