Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9366BC433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 07:31:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F83B2071B
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 07:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jL7yH9nR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F83B2071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDjiG-0001qT-A7
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 03:31:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39568)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDjeB-0001wb-Ip
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 03:27:03 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:43825)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDje9-0001lr-5Z
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 03:27:03 -0400
Received: by mail-pg1-x543.google.com with SMTP id d19so1395634pgl.10
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 00:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Kusj55p8325/oDEQgpGxQ3r2MKxfevAciSjhYQr61NI=;
 b=jL7yH9nRPbbKnf1jrW6EC+bwpFhq7WX82NBwl/o+RmjeoksRLegNZ6+oIiLJSDUA0V
 CeLihgsB2ZDEDS3Zj6SfKJVWrzkOUWPRbiodwe06A+AZaOIBNZuZ41J6qG3pnKLYm+LX
 oZHc0/h2RXk/cUR8Shutieexy+TNq3tWr6OraBfa0cnkNbSshy1PeMk+QBZ7TcYCpJaZ
 ih58FSaOijIoYYUR6P44yZ/bTsdw2zEXtTw3CUXpdkbRBEawNpYWYrSxKd2dJ+vN8FJY
 WbnJhjCdmg6Q54TXALZSSIlqcrwMbY2NqP3R+1ZS9r5tlSlrmIEyySeQCMM6ktHZAnDh
 3ZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Kusj55p8325/oDEQgpGxQ3r2MKxfevAciSjhYQr61NI=;
 b=DvPR9R8I4PGwaMVDxQ8N1tL3zw5K0iseO672HZ82B0TTpHC8S/t88JPqNVp9nAMF/x
 VvLKxYpiDsnv6+GnRmXUgVvzeLTm+70VYt7aW4zo4RYEmzdgfl9ddmWFnThUyBPatea6
 zLlcevm5eZQvHmRlVysVCboNr1Y+st46o0IZTyuK1dAUiShmOgVrWke969/r5aFLen4V
 cll2s/yOFO2DnGNlGmVPPHlfHHA5v7vdpM3OBwJr3AQ057L3hCv+tCXzyNoQW0bNlaRw
 I3ZcvYbTOqYnyEowV/15gsDRODvWjjSvzLaAtduZz0qajnc2Sbp1q6YOe/Ja4T2meaCb
 sQBw==
X-Gm-Message-State: AOAM533GDIWJ6OTLwuG3wTq9gnsItxHCzDg27l0/eJA9/D3bGrOIu24r
 U+AwzUzh8e36v3ra3I8TUfks48wEUBN3GA==
X-Google-Smtp-Source: ABdhPJwfvWgYQBLB57Zgszv62gdLVsqOUjJqRajnWu4d7Ei4I1+oeOyBvvBu58YziBaFSArszJyYzA==
X-Received: by 2002:a62:5e04:: with SMTP id s4mr2596547pfb.85.1599118019451;
 Thu, 03 Sep 2020 00:26:59 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id x185sm1930229pfc.188.2020.09.03.00.26.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 00:26:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 05/12] target/microblaze: Fill in VMStateDescription for cpu
Date: Thu,  3 Sep 2020 00:26:43 -0700
Message-Id: <20200903072650.1360454-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200903072650.1360454-1-richard.henderson@linaro.org>
References: <20200903072650.1360454-1-richard.henderson@linaro.org>
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
Cc: edgar.iglesias@xilinx.com, thuth@redhat.com, f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/cpu.h       |   4 ++
 target/microblaze/cpu.c       |   8 +--
 target/microblaze/machine.c   | 112 ++++++++++++++++++++++++++++++++++
 target/microblaze/meson.build |   5 +-
 4 files changed, 121 insertions(+), 8 deletions(-)
 create mode 100644 target/microblaze/machine.c

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 20c2979396..133ebaa4d4 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -419,4 +419,8 @@ static inline int cpu_mmu_index(CPUMBState *env, bool ifetch)
     return MMU_KERNEL_IDX;
 }
 
+#ifndef CONFIG_USER_ONLY
+extern const VMStateDescription vmstate_mb_cpu;
+#endif
+
 #endif
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 6392524135..388605ccca 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -26,7 +26,6 @@
 #include "cpu.h"
 #include "qemu/module.h"
 #include "hw/qdev-properties.h"
-#include "migration/vmstate.h"
 #include "exec/exec-all.h"
 #include "fpu/softfloat-helpers.h"
 
@@ -254,11 +253,6 @@ static void mb_cpu_initfn(Object *obj)
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
@@ -338,8 +332,8 @@ static void mb_cpu_class_init(ObjectClass *oc, void *data)
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
index 0000000000..aad3c5d1d3
--- /dev/null
+++ b/target/microblaze/machine.c
@@ -0,0 +1,112 @@
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
+    VMSTATE_INT32(c_mmu, MicroBlazeMMU),
+    VMSTATE_INT32(c_mmu_tlb_access, MicroBlazeMMU),
+    VMSTATE_INT32(c_mmu_zones, MicroBlazeMMU),
+    VMSTATE_UINT64(c_addr_mask, MicroBlazeMMU),
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
+    VMSTATE_UINT32_ARRAY(pvr.regs, CPUMBState, 13),
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


