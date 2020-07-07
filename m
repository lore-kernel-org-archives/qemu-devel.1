Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23EB0C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 18:18:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EABF8206CD
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 18:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHE9bF66"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EABF8206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jssAr-0000oo-4O
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 14:18:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35452)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jss9l-0007PM-4v
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 14:17:25 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:56231)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jss9j-0002rv-4S
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 14:17:24 -0400
Received: by mail-wm1-x32d.google.com with SMTP id g75so69553wme.5
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 11:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QHSNic8l2ySddu81tR7DiLA/qd/n5PuBuhlt3A3ynwU=;
 b=OHE9bF66HAHq9thuxoO3wecLJ2Qgg8Q/dk0srqnPvBM7t4ZRd/xEb+8US4kFYx0G3T
 nUjTbUGRrdyL0nWItCQUVtHjLD8o0itRYvU05AWzcfLUhfN4HVK+auGjYaQUxkyu3OYb
 FH9l4pY5jqyJkoK5dyrBcAGtS/pNUlqjcbnd+O4YN89gGIALOp9tWITVsCtzR7PVSKsR
 wE4ZVZJx3rX35KnCT7cF6iDY07AXmH1DmQN4Ql1IVLNaovcMq+i8katWW82BjkXn0yYG
 e1WP8lKBYaooxwD30+oknbsOTeUMfT6TITqdTBK+EnFTOoc3vq3DcGJ27YIgx6RChHJj
 awjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=QHSNic8l2ySddu81tR7DiLA/qd/n5PuBuhlt3A3ynwU=;
 b=klTo5l0IzsCpljPHlKKU0MGYnn/+Cn83tfXdqUHVrYSpl3AVIV5QJ2W1dmdQrVeR6Y
 kE9qGCD15/9LTJGmm7uZdbSLtbuDcwAkpis1EWwLya4REPCQU4hTzyJREOoKOWtdfRz2
 on2lLS0NDiXNmvyK+lPJnw56gpwKwZ3nyn2XFeCz3hTO3R+CW2t15Xu1IpXyxL+D1zXM
 XR/EOI4NVI1XUtozc+5wjLBaavBiWazLl0pKEAy2J+EqFCDndqNUrxim1pJsdACklBa1
 tT7jA2sbhdMOyMom72sztIJCuEvLzZ8WKC7fgStz++JycvQSGRUxLWBoE+Cmg+ol3i9h
 WYWA==
X-Gm-Message-State: AOAM532D5R0KKhve8ECvmo8ZP097PlfvvizAGrk+DboUjbBwAtp2pGBN
 9guOyuyySBWydg8TsG6psCBtFlE2
X-Google-Smtp-Source: ABdhPJzh1RY14Q1+/TJRJJMfONwvoYKw/hWBf1xr0BjZtDlYMxTHpUITIkzNamYnZWgi9DwoeH6hCw==
X-Received: by 2002:a05:600c:4109:: with SMTP id
 j9mr5279282wmi.157.1594145841555; 
 Tue, 07 Jul 2020 11:17:21 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id 65sm2253337wma.48.2020.07.07.11.17.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 11:17:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/32] target/avr: CPU class: Add migration support
Date: Tue,  7 Jul 2020 20:16:43 +0200
Message-Id: <20200707181710.30950-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200707181710.30950-1-f4bug@amsat.org>
References: <20200707181710.30950-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x32d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Sarah Harris <S.E.Harris@kent.ac.uk>,
 Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Cleber Rosa <crosa@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Michael Rolnik <mrolnik@gmail.com>

Add migration-related functions of AVR CPU class object.

[AM: Split a larger AVR introduction patch into logical units]
Suggested-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Co-developed-by: Michael Rolnik <mrolnik@gmail.com>
Co-developed-by: Sarah Harris <S.E.Harris@kent.ac.uk>
Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
Signed-off-by: Sarah Harris <S.E.Harris@kent.ac.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
Message-Id: <20200705140315.260514-6-huth@tuxfamily.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/avr/cpu.h     |   2 +
 target/avr/cpu.c     |   1 +
 target/avr/machine.c | 121 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 124 insertions(+)
 create mode 100644 target/avr/machine.c

diff --git a/target/avr/cpu.h b/target/avr/cpu.h
index bac12dc684..59b89a3a71 100644
--- a/target/avr/cpu.h
+++ b/target/avr/cpu.h
@@ -118,6 +118,8 @@ typedef struct AVRCPU {
     CPUAVRState env;
 } AVRCPU;
 
+extern const struct VMStateDescription vms_avr_cpu;
+
 void avr_cpu_do_interrupt(CPUState *cpu);
 bool avr_cpu_exec_interrupt(CPUState *cpu, int int_req);
 hwaddr avr_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index a8636015a3..f4b2d6f55c 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -206,6 +206,7 @@ static void avr_cpu_class_init(ObjectClass *oc, void *data)
     cc->memory_rw_debug = avr_cpu_memory_rw_debug;
     cc->get_phys_page_debug = avr_cpu_get_phys_page_debug;
     cc->tlb_fill = avr_cpu_tlb_fill;
+    cc->vmsd = &vms_avr_cpu;
     cc->disas_set_info = avr_cpu_disas_set_info;
     cc->tcg_initialize = avr_cpu_tcg_init;
     cc->synchronize_from_tb = avr_cpu_synchronize_from_tb;
diff --git a/target/avr/machine.c b/target/avr/machine.c
new file mode 100644
index 0000000000..e61ea0519a
--- /dev/null
+++ b/target/avr/machine.c
@@ -0,0 +1,121 @@
+/*
+ * QEMU AVR CPU
+ *
+ * Copyright (c) 2016-2020 Michael Rolnik
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see
+ * <http://www.gnu.org/licenses/lgpl-2.1.html>
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "migration/cpu.h"
+
+static int get_sreg(QEMUFile *f, void *opaque, size_t size,
+    const VMStateField *field)
+{
+    CPUAVRState *env = opaque;
+    uint8_t sreg;
+
+    sreg = qemu_get_byte(f);
+    cpu_set_sreg(env, sreg);
+    return 0;
+}
+
+static int put_sreg(
+    QEMUFile *f, void *opaque, size_t size,
+    const VMStateField *field, QJSON *vmdesc)
+{
+    CPUAVRState *env = opaque;
+    uint8_t sreg = cpu_get_sreg(env);
+
+    qemu_put_byte(f, sreg);
+    return 0;
+}
+
+static const VMStateInfo vms_sreg = {
+    .name = "sreg",
+    .get = get_sreg,
+    .put = put_sreg,
+};
+
+static int get_segment(
+    QEMUFile *f, void *opaque, size_t size, const VMStateField *field)
+{
+    uint32_t *ramp = opaque;
+    uint8_t temp;
+
+    temp = qemu_get_byte(f);
+    *ramp = ((uint32_t)temp) << 16;
+    return 0;
+}
+
+static int put_segment(
+    QEMUFile *f, void *opaque, size_t size,
+    const VMStateField *field, QJSON *vmdesc)
+{
+    uint32_t *ramp = opaque;
+    uint8_t temp = *ramp >> 16;
+
+    qemu_put_byte(f, temp);
+    return 0;
+}
+
+static const VMStateInfo vms_rampD = {
+    .name = "rampD",
+    .get = get_segment,
+    .put = put_segment,
+};
+static const VMStateInfo vms_rampX = {
+    .name = "rampX",
+    .get = get_segment,
+    .put = put_segment,
+};
+static const VMStateInfo vms_rampY = {
+    .name = "rampY",
+    .get = get_segment,
+    .put = put_segment,
+};
+static const VMStateInfo vms_rampZ = {
+    .name = "rampZ",
+    .get = get_segment,
+    .put = put_segment,
+};
+static const VMStateInfo vms_eind = {
+    .name = "eind",
+    .get = get_segment,
+    .put = put_segment,
+};
+
+const VMStateDescription vms_avr_cpu = {
+    .name = "cpu",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(env.pc_w, AVRCPU),
+        VMSTATE_UINT32(env.sp, AVRCPU),
+        VMSTATE_UINT32(env.skip, AVRCPU),
+
+        VMSTATE_UINT32_ARRAY(env.r, AVRCPU, NUMBER_OF_CPU_REGISTERS),
+
+        VMSTATE_SINGLE(env, AVRCPU, 0, vms_sreg, CPUAVRState),
+        VMSTATE_SINGLE(env.rampD, AVRCPU, 0, vms_rampD, uint32_t),
+        VMSTATE_SINGLE(env.rampX, AVRCPU, 0, vms_rampX, uint32_t),
+        VMSTATE_SINGLE(env.rampY, AVRCPU, 0, vms_rampY, uint32_t),
+        VMSTATE_SINGLE(env.rampZ, AVRCPU, 0, vms_rampZ, uint32_t),
+        VMSTATE_SINGLE(env.eind, AVRCPU, 0, vms_eind, uint32_t),
+
+        VMSTATE_END_OF_LIST()
+    }
+};
-- 
2.21.3


