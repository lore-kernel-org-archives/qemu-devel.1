Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F95C43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 19:17:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B04FB20684
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 19:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OcY92o6U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B04FB20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEHDb-0007YN-L4
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 15:17:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41868)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kEH5F-0002BC-6Z
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 15:09:13 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:46091)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kEH5C-0000rk-C2
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 15:09:12 -0400
Received: by mail-pg1-x543.google.com with SMTP id 31so4778225pgy.13
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 12:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Yxppty28CTEMjPkeyhnxd+40vdMGPYpycADEgKMrbsc=;
 b=OcY92o6UvvbdidoXAu1sbSQGtME97fCmqIdmRZENwqso6ydVPZbY+7U8qCRUerhWRX
 dNN5tNzcGRlo2fFNeZcqe5nezY4IioAPldGaIYjTXxRV/ntf9XqQ1NGdBdcJ7McUThJb
 /NmLauXZg8nf29XSBLN1zCcAojQL8ogl4s1ChqTG+HOCiqunUXiC6LIZ2A+/c3vMOOq3
 2YQOz3IH1iWJa8gEMULU8IBEwOfqfWQ7lrYA8sHwb0gf6amWXyRl0o6iFv+Znc6lEkog
 YjxEZLqnwbpb07eqJI5Or9Wsn808N2ZmieTll5rxMMqiL2E9EXR85DAc083KqmAQItga
 ssCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Yxppty28CTEMjPkeyhnxd+40vdMGPYpycADEgKMrbsc=;
 b=bTbqUVox1QfX3UwWsLde3NpW6xOxa55/pRt8LcbJ6HoAr6W7Qxd3mtrcCDZ2gOiAE0
 h2R5rirp2wgKItFzYMRAUzYJOYTA+ZCGozfyYy7yGCMO8mui+sd643M4osOt7cGTw3RA
 iDx4P4wZZtzG4UUR4x8bh1rNNZru32E+G4Ai0YhUg2qCG1bA5tK8Le/gzjTvYu1oa7Un
 qkGN4EtzSm0pT8uzGF7G+8Z48Cc6oLXBk6H/tcamr5oW4JlryLEAcGlZpTJjJzou1/mH
 K1AwnfmYE3pnUhXj1C75id59Y+300m3FYWUbgWB1pENegKzJvOVKEa6oufA07pC5cvQX
 jr0A==
X-Gm-Message-State: AOAM5330JEkZhtJheWUq6wsyBrAeKDT/JXF7NOceo1M7rVQvvgdIO68S
 H2mWJQlzkG0h3BCle8zN7h6EwqDqjxO3nA==
X-Google-Smtp-Source: ABdhPJx7PlhO4EDuGPIVe+8KyjdbZ8+I0Ek3qkH/IGPjNzooRRoVBusnzZlTSiZeEUuUyU9IXuHnnw==
X-Received: by 2002:a63:7c9:: with SMTP id 192mr8185606pgh.181.1599246548115; 
 Fri, 04 Sep 2020 12:09:08 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id x19sm1897941pge.22.2020.09.04.12.09.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 12:09:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 17/19] target/microblaze: Fill in VMStateDescription for cpu
Date: Fri,  4 Sep 2020 12:08:40 -0700
Message-Id: <20200904190842.2282109-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200904190842.2282109-1-richard.henderson@linaro.org>
References: <20200904190842.2282109-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
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
Cc: edgar.iglesias@xilinx.com, f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/cpu.h       |   4 ++
 target/microblaze/cpu.c       |   8 +--
 target/microblaze/machine.c   | 106 ++++++++++++++++++++++++++++++++++
 target/microblaze/meson.build |   5 +-
 4 files changed, 115 insertions(+), 8 deletions(-)
 create mode 100644 target/microblaze/machine.c

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index b54f99da61..297b36879a 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -429,4 +429,8 @@ static inline int cpu_mmu_index(CPUMBState *env, bool ifetch)
     return MMU_KERNEL_IDX;
 }
 
+#ifndef CONFIG_USER_ONLY
+extern const VMStateDescription vmstate_mb_cpu;
+#endif
+
 #endif
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index fde646a7ad..9b2482159d 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -26,7 +26,6 @@
 #include "cpu.h"
 #include "qemu/module.h"
 #include "hw/qdev-properties.h"
-#include "migration/vmstate.h"
 #include "exec/exec-all.h"
 #include "fpu/softfloat-helpers.h"
 
@@ -251,11 +250,6 @@ static void mb_cpu_initfn(Object *obj)
 #endif
 }
 
-static const VMStateDescription vmstate_mb_cpu = {
-    .name = "cpu",
-    .unmigratable = 1,
-};
-
 static Property mb_properties[] = {
     DEFINE_PROP_UINT32("base-vectors", MicroBlazeCPU, cfg.base_vectors, 0),
     DEFINE_PROP_BOOL("use-stack-protection", MicroBlazeCPU, cfg.stackprot,
@@ -335,8 +329,8 @@ static void mb_cpu_class_init(ObjectClass *oc, void *data)
 #ifndef CONFIG_USER_ONLY
     cc->do_transaction_failed = mb_cpu_transaction_failed;
     cc->get_phys_page_debug = mb_cpu_get_phys_page_debug;
-#endif
     dc->vmsd = &vmstate_mb_cpu;
+#endif
     device_class_set_props(dc, mb_properties);
     cc->gdb_num_core_regs = 32 + 27;
 
diff --git a/target/microblaze/machine.c b/target/microblaze/machine.c
new file mode 100644
index 0000000000..acdb8d0474
--- /dev/null
+++ b/target/microblaze/machine.c
@@ -0,0 +1,106 @@
+/*
+ *  Microblaze VMState for qemu.
+ *
+ *  Copyright (c) 2020 Linaro, Ltd.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "migration/cpu.h"
+
+
+static VMStateField vmstate_mmu_fields[] = {
+    VMSTATE_UINT64_2DARRAY(rams, MicroBlazeMMU, 2, TLB_ENTRIES),
+    VMSTATE_UINT8_ARRAY(tids, MicroBlazeMMU, TLB_ENTRIES),
+    VMSTATE_UINT32_ARRAY(regs, MicroBlazeMMU, 3),
+    VMSTATE_END_OF_LIST()
+};
+
+static const VMStateDescription vmstate_mmu = {
+    .name = "mmu",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .fields = vmstate_mmu_fields,
+};
+
+static int get_msr(QEMUFile *f, void *opaque, size_t size,
+                   const VMStateField *field)
+{
+    CPUMBState *env = container_of(opaque, CPUMBState, msr);
+
+    mb_cpu_write_msr(env, qemu_get_be32(f));
+    return 0;
+}
+
+static int put_msr(QEMUFile *f, void *opaque, size_t size,
+                   const VMStateField *field, QJSON *vmdesc)
+{
+    CPUMBState *env = container_of(opaque, CPUMBState, msr);
+
+    qemu_put_be32(f, mb_cpu_read_msr(env));
+    return 0;
+}
+
+static const VMStateInfo vmstate_msr = {
+    .name = "msr",
+    .get = get_msr,
+    .put = put_msr,
+};
+
+static VMStateField vmstate_env_fields[] = {
+    VMSTATE_UINT32_ARRAY(regs, CPUMBState, 32),
+
+    VMSTATE_UINT32(pc, CPUMBState),
+    VMSTATE_SINGLE(msr, CPUMBState, 0, vmstate_msr, uint32_t),
+    VMSTATE_UINT32(esr, CPUMBState),
+    VMSTATE_UINT32(fsr, CPUMBState),
+    VMSTATE_UINT32(btr, CPUMBState),
+    VMSTATE_UINT32(edr, CPUMBState),
+    VMSTATE_UINT32(slr, CPUMBState),
+    VMSTATE_UINT32(shr, CPUMBState),
+    VMSTATE_UINT64(ear, CPUMBState),
+
+    VMSTATE_UINT32(btarget, CPUMBState),
+    VMSTATE_UINT32(imm, CPUMBState),
+    VMSTATE_UINT32(iflags, CPUMBState),
+
+    VMSTATE_UINT32(res_val, CPUMBState),
+    VMSTATE_UINTTL(res_addr, CPUMBState),
+
+    VMSTATE_STRUCT(mmu, CPUMBState, 0, vmstate_mmu, MicroBlazeMMU),
+
+    VMSTATE_END_OF_LIST()
+};
+
+static const VMStateDescription vmstate_env = {
+    .name = "env",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .fields = vmstate_env_fields,
+};
+
+static VMStateField vmstate_cpu_fields[] = {
+    VMSTATE_CPU(),
+    VMSTATE_STRUCT(env, MicroBlazeCPU, 1, vmstate_env, CPUMBState),
+    VMSTATE_END_OF_LIST()
+};
+
+const VMStateDescription vmstate_mb_cpu = {
+    .name = "cpu",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .fields = vmstate_cpu_fields,
+};
diff --git a/target/microblaze/meson.build b/target/microblaze/meson.build
index 639c3f73a8..05ee0ec163 100644
--- a/target/microblaze/meson.build
+++ b/target/microblaze/meson.build
@@ -11,7 +11,10 @@ microblaze_ss.add(files(
 ))
 
 microblaze_softmmu_ss = ss.source_set()
-microblaze_softmmu_ss.add(files('mmu.c'))
+microblaze_softmmu_ss.add(files(
+  'mmu.c',
+  'machine.c',
+))
 
 target_arch += {'microblaze': microblaze_ss}
 target_softmmu_arch += {'microblaze': microblaze_softmmu_ss}
-- 
2.25.1


