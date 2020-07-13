Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0004C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 21:34:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D8D32089D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 21:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vXzvmOTK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D8D32089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv65o-0000QX-UL
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 17:34:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39376)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jv657-0007yg-In
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 17:33:49 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:38937)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jv655-0004Wj-GS
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 17:33:49 -0400
Received: by mail-pf1-x443.google.com with SMTP id x72so6617967pfc.6
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 14:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=T+RRv2+U9t+cg4c0rxOURe6KAEVhcGBktXAW6b9dt0M=;
 b=vXzvmOTKaHqsPejZd/IywWSEskA6XBndoWV1oyO1MWYkK1vN1vZrC3YQa6CUixOtiQ
 iqERKKmOrs7H/rNahc7QsvhxZNrrRvF1p6NpXy9CZ6yLE0/VYz3/Kx0ke56mj1USz+Qd
 da/2llcqO6eAW77C95smPieDqlr8BxrX3wzjOci/WdZ94dR4QjRjr3TYK6I57ZJx9jQ5
 Af7p4ol1LBZbu6MPT0uItGbY73d4UdKjD4/lB6phKx02MT4XmMFNT6UgJUVDYqOIfJCq
 C6uMabsFai3TT87NzRNwA1+HrqVuo4v9kpc2Rc8YEQGp4dW0EPtdvv/+2ovLH/k6PNuc
 lpfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=T+RRv2+U9t+cg4c0rxOURe6KAEVhcGBktXAW6b9dt0M=;
 b=jAIdW6+myARdNkd+8TYpyfjb8ZQPdIcckNk9alvOYc/Q394omxv/ZUp4rF7yVFWQwP
 NAgvUR3KwHFLl282L3eIyKCNJlDxsbGndGimRaqdpAXbRUNQtH8zc8vX7fmvoeqfh1bx
 +WoWUgrHm0IFFnaZ3IAIGLAV122LaMsVkdIc9I/eJh/N8/GpWoLXQQp9mz+/fXgZQxmp
 u/ZpE6522OlMYhXVjY2Ozm0iXWCr3QlKATx93RrlVYCb5LWqcir+MbdQD4ayvNrKEWMS
 j+1OtDuwz64gdFv1PGthcbDEZtHR9qBseaK5i9UN0bClbbZH/qspdUq9Ono32KHC8H/G
 2mUQ==
X-Gm-Message-State: AOAM532sDMXLEm9Zz/zcYBdvF5uNt1Yve1GU45SJ+OdX7KxjPrKxOBcL
 cBl2M1wcpQ/u5R6VFfwcSDD7CzQ5Eww=
X-Google-Smtp-Source: ABdhPJyIRI9yG4hZLpS5h7+4K04Ch59H0xMvyvPo00gwZ4rVrIUczvnImwi/rQ9HNrtTNt7kbSejLg==
X-Received: by 2002:a65:63d4:: with SMTP id n20mr917349pgv.213.1594676025616; 
 Mon, 13 Jul 2020 14:33:45 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id l207sm3591565pfd.79.2020.07.13.14.33.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 14:33:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] hw/arm/virt: Enable MTE via a machine property
Date: Mon, 13 Jul 2020 14:33:39 -0700
Message-Id: <20200713213341.590275-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200713213341.590275-1-richard.henderson@linaro.org>
References: <20200713213341.590275-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Control this cpu feature via a machine property, much as we do
with secure=on, since both require specialized support in the
machine setup to be functional.

Default MTE to off, since this feature implies extra overhead.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/arm/virt.h |  1 +
 hw/arm/virt.c         | 39 ++++++++++++++++++++++++++++++++++-----
 target/arm/cpu.c      | 19 +++++++++++--------
 target/arm/cpu64.c    |  5 +++--
 4 files changed, 49 insertions(+), 15 deletions(-)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 54bcf17afd..dff67e1bef 100644
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
index 9005dae356..5866c4ce20 100644
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
index 5050e1843a..111579554f 100644
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
index 15494002d2..dd696183df 100644
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
2.25.1


