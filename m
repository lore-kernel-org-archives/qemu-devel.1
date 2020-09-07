Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B9EC433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 18:09:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 078B5206B5
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 18:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mq27g1oD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 078B5206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFLZm-0001mq-1W
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 14:09:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38840)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFLVy-0003sU-85
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 14:05:14 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:37283)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFLVw-0002ON-7K
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 14:05:13 -0400
Received: by mail-pj1-x1043.google.com with SMTP id kk9so4409914pjb.2
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 11:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dWk0u18HrFWEmO0Ek4pDOwsIb2E0YHnrPgMxsDRW+cA=;
 b=mq27g1oDg7Fa7RsvStGUPmszuAwud6AtXZVjqdWaEceJH7zleAqfadJIuF/GfJgZf1
 umQCuni7SmZrs27cIIBSaeQWpU3GmuvlI0s37d/QAKvgZl3UIT9Lm0EWq90tm++HgVXN
 aw5SUAa1WEX/36mN+EbYFreWua8MxDTyT9cIbgJtJVLWo0Lm7vBo6kuydj6qFXN0AOxa
 eYlaIoG07KxbOgyuO7EE7fFSPNkQLOWFEd50HgxFvUoGxDyu0xloyLCQTQ/Nt26kb09L
 TmZrMVXDtr9+/pP9mA6BgWakplVCqFeoo2j/6nVqmoMD+xBIVr4ZlAlH/AMkmb+aoOYs
 F8Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dWk0u18HrFWEmO0Ek4pDOwsIb2E0YHnrPgMxsDRW+cA=;
 b=sylZcjOuKZ84h9YdXgV2K5bfeUuosPB7Nu6TFOf3C6qG90o+0uGrp1l6qDLk1FRmUu
 3WzNWlggpSbiRmIMY7/CDLRtDoB27ekyiaO9ZxN4idC9Rth33IMkxIJZbT49TgfbwW5W
 ssOOfT7QtweayJY8uwdOaUa6sP7fjtftuT14wZSItEg+zSNoTIiwFM1iWdPRfBZ8xwIO
 dW6c1ibHZGkpLm4z8omxo1LhdAgKIwaQkoLkqI9IlwCS0tN9CrGQ8PkXpl0b2/aFqWd6
 9aPljS78MZ8LXVVdjlT8967Y9WcjmXDRaRr1gAZuHyMgE9e3IpArLyJdG2gK2sEun7OP
 kdCQ==
X-Gm-Message-State: AOAM5335rVJa4qVI76QEFmTZ1Z5TlaiRfjwz0l2VOHWp7B34iFd/LXfp
 zgmJd2uo6VyYaxrwqrTFyRE8eaiwCgXYZw==
X-Google-Smtp-Source: ABdhPJwVYX5Czt1wXjZuX9eJwKDG5jVZ+wcm83BZD1w9ptTEclLG1NpfkXkhVloBnzksa9e2620MWQ==
X-Received: by 2002:a17:902:7895:b029:d0:89f4:621c with SMTP id
 q21-20020a1709027895b02900d089f4621cmr19090697pll.4.1599501910454; 
 Mon, 07 Sep 2020 11:05:10 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id v6sm11367768pfi.38.2020.09.07.11.05.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2020 11:05:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/19] target/microblaze: Fill in VMStateDescription for cpu
Date: Mon,  7 Sep 2020 11:04:57 -0700
Message-Id: <20200907180459.29025-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200907180459.29025-1-richard.henderson@linaro.org>
References: <20200907175102.28027-1-richard.henderson@linaro.org>
 <20200907180459.29025-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
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


