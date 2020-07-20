Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E28C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 12:57:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7C5622B4D
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 12:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R5y95QPp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7C5622B4D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxVMI-0003xM-07
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 08:57:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55724)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxVLK-0002HT-4j
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 08:56:30 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:39483)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxVLH-0007Ht-0R
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 08:56:29 -0400
Received: by mail-wm1-x32f.google.com with SMTP id w3so25053640wmi.4
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 05:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=emW1nc2AzE5wKcpJ7qyQJo3pUf29WqEBvvdvJOV3mSo=;
 b=R5y95QPpKEVXD4vSCW2b1QDx4CNXB8UEBAGEp+hTEpOXE/Z/w/X3CQPTgu3GP+fWot
 YJ5fHlAsD3E8vuvYBE8fRftBkrQj7VyjFpiLPg0O9j+fvIgYREcr4Sy/VG+o0UfhOsOs
 UDO+0sldi6o/RtG7uz9/RLaZNaC5nJb1w7lwjb/jfogM04115Zf7e73gzyElx5SsbG/t
 Yfp8Mk8fwxhI92cMwpKviHEX6P9edm8OiIoQTSW1f2OaRNnJhPa5Pb9i3/WZfNpwlRzX
 YNbQqolEUaCOTGXvR1s7dCVzKnhaQmBOPHjj4UjuD69MeZprYP43PxpHtBeDvOgqM5zb
 0jHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=emW1nc2AzE5wKcpJ7qyQJo3pUf29WqEBvvdvJOV3mSo=;
 b=shLgCl0Hq63z3zLLzO3LZMRHZa+LiFbt8TiLDGM2BM/y1HhTQO4xl7XZ2Q5Qk+AcIi
 OUVmlhAFPSQMNjWk6I5t4GjvWrXdLhzGa/TWxfrPSFU4jsXoB0KqsJu2Ih7vRsRkYu7N
 roJhNvP7HK/DhdIUv0Mcndjy6t3qWYX5uQI3R3aXpami2krzXZGbKf/I3JaaU/E++I+1
 yFVtsLKTZVS9c3G24fZjtErJ+3GbwF4G6piuPxYYtqlH1tVPr3N/n2V0D0mSXskWSLJm
 XbYPZcKBmyY+3ludfqHHdKG9c5aXzii/DW19dFC44LCbYI72U3v5U1lnt0akQyQyJCa6
 +uHQ==
X-Gm-Message-State: AOAM533bKLREXJ8NPvyBbj6BZeLW1eUatLeQYchvwzsjqfOaqNlot15J
 Vrzj7b8B10PWiUs+RLWwPbLHFndS95VAwQ==
X-Google-Smtp-Source: ABdhPJzZs6qzdoZJINY3TltC4bz+juMdTkBRWc6TvDRwffOzQLCM7b7d4m5vYtNj7LzrNF+5X8utyQ==
X-Received: by 2002:a1c:a7c4:: with SMTP id q187mr21146857wme.0.1595249785149; 
 Mon, 20 Jul 2020 05:56:25 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p29sm34025403wmi.43.2020.07.20.05.56.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2020 05:56:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/12] hw/arm/virt: Enable MTE via a machine property
Date: Mon, 20 Jul 2020 13:56:10 +0100
Message-Id: <20200720125621.13460-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200720125621.13460-1-peter.maydell@linaro.org>
References: <20200720125621.13460-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Control this cpu feature via a machine property, much as we do
with secure=on, since both require specialized support in the
machine setup to be functional.

Default MTE to off, since this feature implies extra overhead.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200713213341.590275-2-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/virt.h |  1 +
 hw/arm/virt.c         | 39 ++++++++++++++++++++++++++++++++++-----
 target/arm/cpu.c      | 19 +++++++++++--------
 target/arm/cpu64.c    |  5 +++--
 4 files changed, 49 insertions(+), 15 deletions(-)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 54bcf17afd3..dff67e1bef0 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -140,6 +140,7 @@ typedef struct {
     bool its;
     bool virt;
     bool ras;
+    bool mte;
     OnOffAuto acpi;
     VirtGICType gic_version;
     VirtIOMMUType iommu;
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 9005dae356b..5866c4ce202 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1837,12 +1837,19 @@ static void machvirt_init(MachineState *machine)
                                      OBJECT(secure_sysmem), &error_abort);
         }
 
-        /*
-         * The cpu adds the property if and only if MemTag is supported.
-         * If it is, we must allocate the ram to back that up.
-         */
-        if (object_property_find(cpuobj, "tag-memory", NULL)) {
+        if (vms->mte) {
+            /* Create the memory region only once, but link to all cpus. */
             if (!tag_sysmem) {
+                /*
+                 * The property exists only if MemTag is supported.
+                 * If it is, we must allocate the ram to back that up.
+                 */
+                if (!object_property_find(cpuobj, "tag-memory", NULL)) {
+                    error_report("MTE requested, but not supported "
+                                 "by the guest CPU");
+                    exit(1);
+                }
+
                 tag_sysmem = g_new(MemoryRegion, 1);
                 memory_region_init(tag_sysmem, OBJECT(machine),
                                    "tag-memory", UINT64_MAX / 32);
@@ -2061,6 +2068,20 @@ static void virt_set_ras(Object *obj, bool value, Error **errp)
     vms->ras = value;
 }
 
+static bool virt_get_mte(Object *obj, Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+
+    return vms->mte;
+}
+
+static void virt_set_mte(Object *obj, bool value, Error **errp)
+{
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+
+    vms->mte = value;
+}
+
 static char *virt_get_gic_version(Object *obj, Error **errp)
 {
     VirtMachineState *vms = VIRT_MACHINE(obj);
@@ -2481,6 +2502,14 @@ static void virt_instance_init(Object *obj)
                                     "Set on/off to enable/disable reporting host memory errors "
                                     "to a KVM guest using ACPI and guest external abort exceptions");
 
+    /* MTE is disabled by default.  */
+    vms->mte = false;
+    object_property_add_bool(obj, "mte", virt_get_mte, virt_set_mte);
+    object_property_set_description(obj, "mte",
+                                    "Set on/off to enable/disable emulating a "
+                                    "guest CPU which implements the ARM "
+                                    "Memory Tagging Extension");
+
     vms->irqmap = a15irqmap;
 
     virt_flash_create(vms);
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 5050e1843a8..111579554fb 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1698,6 +1698,17 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         cpu->id_pfr1 &= ~0xf000;
     }
 
+#ifndef CONFIG_USER_ONLY
+    if (cpu->tag_memory == NULL && cpu_isar_feature(aa64_mte, cpu)) {
+        /*
+         * Disable the MTE feature bits if we do not have tag-memory
+         * provided by the machine.
+         */
+        cpu->isar.id_aa64pfr1 =
+            FIELD_DP64(cpu->isar.id_aa64pfr1, ID_AA64PFR1, MTE, 0);
+    }
+#endif
+
     /* MPU can be configured out of a PMSA CPU either by setting has-mpu
      * to false or by setting pmsav7-dregion to 0.
      */
@@ -1787,14 +1798,6 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
             cpu_address_space_init(cs, ARMASIdx_TagS, "cpu-tag-memory",
                                    cpu->secure_tag_memory);
         }
-    } else if (cpu_isar_feature(aa64_mte, cpu)) {
-        /*
-         * Since there is no tag memory, we can't meaningfully support MTE
-         * to its fullest.  To avoid problems later, when we would come to
-         * use the tag memory, downgrade support to insns only.
-         */
-        cpu->isar.id_aa64pfr1 =
-            FIELD_DP64(cpu->isar.id_aa64pfr1, ID_AA64PFR1, MTE, 1);
     }
 
     cpu_address_space_init(cs, ARMASIdx_NS, "cpu-memory", cs->memory);
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 15494002d20..dd696183dfb 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -646,8 +646,9 @@ static void aarch64_max_initfn(Object *obj)
         t = cpu->isar.id_aa64pfr1;
         t = FIELD_DP64(t, ID_AA64PFR1, BT, 1);
         /*
-         * Begin with full support for MTE; will be downgraded to MTE=1
-         * during realize if the board provides no tag memory.
+         * Begin with full support for MTE. This will be downgraded to MTE=0
+         * during realize if the board provides no tag memory, much like
+         * we do for EL2 with the virtualization=on property.
          */
         t = FIELD_DP64(t, ID_AA64PFR1, MTE, 2);
         cpu->isar.id_aa64pfr1 = t;
-- 
2.20.1


