Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F81C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 03:17:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8943020672
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 03:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z86x1mBE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8943020672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI1Tb-0000wz-EH
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 23:17:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48140)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1kI1OC-0000Pv-5t
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 23:12:16 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:33741)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1kI1OA-0001iv-3q
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 23:12:15 -0400
Received: by mail-pg1-x544.google.com with SMTP id s65so1254123pgb.0
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 20:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qMrkJnwKfU2uQTjfoYTo9jsqV6eugUKH6001G6BMUT0=;
 b=Z86x1mBEd1QyTVmkGgMQxgY8rgskBzugwuTn9QhK3xvN5fmvB3jP3ijor8g/jUpPHF
 O3R/i+BQDMxx8SR8qg98v0O6QxBOo2fIO6R7vyQA3oEL4sG+GxvPK3bB+68ANfRD4mJh
 LZeCsZbJmomR9AGepDWnvgqkwQ7QSvuwmxlfTm3rogpWW2MXwAaJKyyhEgD23GE/G87U
 CgN8tKi90v+C04boS8t04jKeAczmcESqhE5K0a9EZRgcYRiTV+Kzxer3SuWZ7eo/yTKw
 rAxVtoAeFDTutIS8zNxaeZMbxfNl1Db8fKkHbm0cSrhwVVfUv6QCAYy1EX1yETxa8OGI
 NoMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qMrkJnwKfU2uQTjfoYTo9jsqV6eugUKH6001G6BMUT0=;
 b=lw6g9s4UJ433ULE9MWXYu7M/q2BjbK8Naut03nl/a9iSv6ajDe1hh48qmmb6CAPJLS
 WLL3+zMClYHjaFkcM5ShKDNqjVYA4u88FgPaBx669i3CfKMXlPJqPd+k35boEY7mXS6P
 8oMyGLy7SXVHmO2mUYbxrkUM5W03qTJH/5scZrYyeKv40FqwaSkMjznDl6fkojwzIWYQ
 ntTPCuQmVdi5OKbUA4nxxcuHxwUjrWXneEDtAu243IAZYEBUiRXCEqrUQ2dAypfg2xSg
 Ps78nj2YXa4zx6TBjzrQ+iVXd8kp0xZSb+Auo20K5xV2rIfdFGNxkFQAQmLfImVczXh8
 zpOQ==
X-Gm-Message-State: AOAM5327zQ2cVrcT7hmEFmoJ5hCRnM/c7E9JaTGNHkUiPcBNAD6cH6rR
 SP0eEio/pZT62w97AOq+w1vO
X-Google-Smtp-Source: ABdhPJwkHEt+2WD2KBWd6Ng6NGEog9M5HfP9/0k8gydg92f29EGgt2yZ2d3T2y9sURRZX6YvMraGww==
X-Received: by 2002:a62:7747:0:b029:13f:d779:5f95 with SMTP id
 s68-20020a6277470000b029013fd7795f95mr9629392pfc.2.1600139532781; 
 Mon, 14 Sep 2020 20:12:12 -0700 (PDT)
Received: from localhost.localdomain ([147.75.106.138])
 by smtp.gmail.com with ESMTPSA id g23sm11551776pfh.133.2020.09.14.20.12.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 20:12:12 -0700 (PDT)
From: Haibo Xu <haibo.xu@linaro.org>
To: drjones@redhat.com,
	richard.henderson@linaro.org
Subject: [PATCH v3 07/12] hw/arm/virt: Move post cpu realize check into its
 own function
Date: Tue, 15 Sep 2020 03:11:43 +0000
Message-Id: <20eedb95441ecec7b23527cde78aa5b63c67b400.1600135462.git.haibo.xu@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1600135462.git.haibo.xu@linaro.org>
References: <cover.1600135462.git.haibo.xu@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=haibo.xu@linaro.org; helo=mail-pg1-x544.google.com
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
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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


