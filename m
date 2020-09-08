Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850E7C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 08:15:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15AE021D20
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 08:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UN562Vwk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15AE021D20
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFYmZ-0008Bz-4m
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 04:15:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1kFYlG-0005pe-9V
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 04:13:54 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:33471)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1kFYlE-0000SG-8i
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 04:13:53 -0400
Received: by mail-pf1-x441.google.com with SMTP id c196so4851282pfc.0
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 01:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hvtYY966srnK5wG0YbtFj+vFvT8ZWyaFHw3B2vowdgs=;
 b=UN562VwkN4m/so7koho/gMRFletaKtsYpQDYr/Qs5O5VIF+hkVHSdTs9F48prIClND
 sqf8/ep/mt/JXaDfjzVN2Ma2/VLYxpuVKA/MM9poc3mBXgA0PE4vLIMAXp16L38J8Yjm
 bsfe8kXLAF0W3fgXrZ/lDYrJbdDWmskVc995fL1Lkp21hXLXAbVzKPp7al8HN201fUCT
 GiXZ2s6oU0ba+3OaKthBjfzJcvk2viX2FPGJ6V2MAnqBdhyS2s98ypgsFjm/4XXYCGly
 FChbXpw0rcdZwIoAFAliYoCjht4A8P9cOrcyJAJh+b7sFwqR+dsQJAd2MkVjyGVJJp7v
 IWkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hvtYY966srnK5wG0YbtFj+vFvT8ZWyaFHw3B2vowdgs=;
 b=jKVzaYdP6w0H6aoTEhpZTOuFiBzlNRsruL86qaFG4y1ravViAlNJPknd+umIihSIS5
 VpUAKVXANB5ZlakrMjQXuYzfBJLWpkQQkBJfgxNFaXqdAmcXzd1IDagi9Pd5EbHfpx6h
 Ei3pdzqgI9SeodTSt/Xs8LQYbWP9Le8kPaAlZNkVI2ivAxq5+XJFbgZ5Uq77s2HgPeGR
 4uO/3sgfIJPTcqohlYgAkUjnx2Uvx4+aI9xGnwXwe16xnXcNk1mH1zbRlUNw8Mjpilrj
 RNXF/gJqrx0LsTGM8ad/7zm1tu5G9tBxzE2AvLXfu6h3K6hQkXdxA/kpbf4oDFZ6PpTG
 Y04g==
X-Gm-Message-State: AOAM531bmpx7cEXTdhL3U/LcjKPv8fQqRCjb1eCU3WwR/g58ptbakuvS
 GMe+SgR2k9FUhvR35SLbOLhf
X-Google-Smtp-Source: ABdhPJxbsgXZZiwoTefUXQdHTKj8phvrN1Ubbof8tVKxLrFxcD/OPaYnXfeZ0UPVWrTXOM5X6ioB7Q==
X-Received: by 2002:a63:3841:: with SMTP id h1mr18425109pgn.38.1599552830846; 
 Tue, 08 Sep 2020 01:13:50 -0700 (PDT)
Received: from localhost.localdomain ([147.75.106.138])
 by smtp.gmail.com with ESMTPSA id m190sm16934788pfm.184.2020.09.08.01.13.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 01:13:50 -0700 (PDT)
From: Haibo Xu <haibo.xu@linaro.org>
To: drjones@redhat.com,
	richard.henderson@linaro.org
Subject: [PATCH v2 07/12] hw/arm/virt: Move post cpu realize check into its
 own function
Date: Tue,  8 Sep 2020 08:13:25 +0000
Message-Id: <04a3f2e202d9e84cefa431101eaf4c7e0cbd1a0d.1599549462.git.haibo.xu@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1599549462.git.haibo.xu@linaro.org>
References: <cover.1599549462.git.haibo.xu@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=haibo.xu@linaro.org; helo=mail-pf1-x441.google.com
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, philmd@redhat.com,
 qemu-devel@nongnu.org, Haibo Xu <haibo.xu@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Andrew Jones <drjones@redhat.com>

We'll add more to this new function in coming patches so we also
state the gic must be created and call it below create_gic().

No functional change intended.

Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 hw/arm/virt.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 3f6d26c531..2ffcb073af 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1672,6 +1672,26 @@ static void finalize_gic_version(VirtMachineState *vms)
     }
 }
 
+static void virt_cpu_post_init(VirtMachineState *vms)
+{
+    bool aarch64;
+
+    aarch64 = object_property_get_bool(OBJECT(first_cpu), "aarch64", NULL);
+
+    if (!kvm_enabled()) {
+        if (aarch64 && vms->highmem) {
+            int requested_pa_size = 64 - clz64(vms->highest_gpa);
+            int pamax = arm_pamax(ARM_CPU(first_cpu));
+
+            if (pamax < requested_pa_size) {
+                error_report("VCPU supports less PA bits (%d) than requested "
+                            "by the memory map (%d)", pamax, requested_pa_size);
+                exit(1);
+            }
+        }
+     }
+}
+
 static void machvirt_init(MachineState *machine)
 {
     VirtMachineState *vms = VIRT_MACHINE(machine);
@@ -1890,22 +1910,6 @@ static void machvirt_init(MachineState *machine)
     fdt_add_timer_nodes(vms);
     fdt_add_cpu_nodes(vms);
 
-   if (!kvm_enabled()) {
-        ARMCPU *cpu = ARM_CPU(first_cpu);
-        bool aarch64 = object_property_get_bool(OBJECT(cpu), "aarch64", NULL);
-
-        if (aarch64 && vms->highmem) {
-            int requested_pa_size, pamax = arm_pamax(cpu);
-
-            requested_pa_size = 64 - clz64(vms->highest_gpa);
-            if (pamax < requested_pa_size) {
-                error_report("VCPU supports less PA bits (%d) than requested "
-                            "by the memory map (%d)", pamax, requested_pa_size);
-                exit(1);
-            }
-        }
-    }
-
     memory_region_add_subregion(sysmem, vms->memmap[VIRT_MEM].base,
                                 machine->ram);
     if (machine->device_memory) {
@@ -1917,6 +1921,8 @@ static void machvirt_init(MachineState *machine)
 
     create_gic(vms);
 
+    virt_cpu_post_init(vms);
+
     fdt_add_pmu_nodes(vms);
 
     create_uart(vms, VIRT_UART, sysmem, serial_hd(0));
-- 
2.17.1


