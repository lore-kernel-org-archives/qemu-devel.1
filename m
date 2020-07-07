Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589A5C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 18:20:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BA7420675
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 18:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WReSKE5z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BA7420675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jssCu-00049v-Bl
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 14:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35400)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jss9h-0007IT-O4
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 14:17:21 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:37530)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jss9f-0002ra-V6
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 14:17:21 -0400
Received: by mail-wm1-x32a.google.com with SMTP id o2so80421wmh.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 11:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ichXtR2ApWBMbBOUtSJ92e100ic02T9JWOfwFxKCIKc=;
 b=WReSKE5zlMJDLpHWtvT5zQYbOoODOdihNMsTtgceJjDEa1q/cUXNWq+BekRn6eDIU+
 iWb3HZ7PRjF3s//UqyIHf6gHCKBPBo93/Lktpxq4lxD+02dGGTt5M3mZ63JQ0RMJNweD
 dqk+Cmc0di3pkNRjMbtwqkocWs3/v92wG+d17hxXOv0SNDFNo6SUu6DDOCwWVuXov2Ln
 o5V6/aVr5/yUg9150jKJ+b2U7NI2mEDeK2+Uoqj1CBetP6xAYgbTUnBxrw/QChFByHC6
 RqJLfl3d0m2NGP0W/fdi/iawkSIEQM4LnSbdvzUZUR9C0cDwRS7wyWSJJIxGbfyGAF08
 ERMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=ichXtR2ApWBMbBOUtSJ92e100ic02T9JWOfwFxKCIKc=;
 b=THilm+zVLsEan/LFseF2nraSqtMIFBe52IJm+9hd+Q2XzrvKsKhMVQmb8rIOZYthIA
 iytwSHj9OiGmO0nEUBE9026E+1AyFSgyXYCRVZ8L5/Q0UBGbTl1EgYgOJ+mZGjnfJy1U
 snh9JmC4UA/SPIjmASM4NY5waq7K/akxIbgs4nTrh6Mhq1+y2a/EitNPmdDhbOLB/Fnj
 Jib43qNs3GvvdD/ImZZG4N/CBzDD1FuRHNjZmcMdheTF36FBf90E9ZBpFI0sbiqWPa4c
 7gunTBfXJUgwNF0oxK2cYa43GqJ/6Km0BrWUT46hyQLryQ/DkE020/1FvwW086VncmtA
 osKA==
X-Gm-Message-State: AOAM5310YZKsugGxbiI11k8p81y+Kdy1E5GlMg6POg+Ihr4D6nuKsoKF
 WOaYO62qISq3w3bQH6BbjyQdjxRg
X-Google-Smtp-Source: ABdhPJxGqur8Ask/nFbVxC573J3QQC4idL9tI1e/mimlYn/WxWL8IQQ76GGEtgsErlXi9x5KMk+ktA==
X-Received: by 2002:a1c:a949:: with SMTP id s70mr5887278wme.137.1594145838321; 
 Tue, 07 Jul 2020 11:17:18 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id 65sm2253337wma.48.2020.07.07.11.17.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 11:17:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/32] target/avr: CPU class: Add interrupt handling support
Date: Tue,  7 Jul 2020 20:16:41 +0200
Message-Id: <20200707181710.30950-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200707181710.30950-1-f4bug@amsat.org>
References: <20200707181710.30950-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x32a.google.com
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

This patch introduces functions avr_cpu_do_interrupt() and
avr_cpu_exec_interrupt() that are part of AVR CPU class object.

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
Message-Id: <20200705140315.260514-4-huth@tuxfamily.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/avr/cpu.c    |  2 +
 target/avr/helper.c | 89 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+)
 create mode 100644 target/avr/helper.c

diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 7895a5ecaa..864cb6b102 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -199,6 +199,8 @@ static void avr_cpu_class_init(ObjectClass *oc, void *data)
     cc->class_by_name = avr_cpu_class_by_name;
 
     cc->has_work = avr_cpu_has_work;
+    cc->do_interrupt = avr_cpu_do_interrupt;
+    cc->cpu_exec_interrupt = avr_cpu_exec_interrupt;
     cc->dump_state = avr_cpu_dump_state;
     cc->set_pc = avr_cpu_set_pc;
     cc->disas_set_info = avr_cpu_disas_set_info;
diff --git a/target/avr/helper.c b/target/avr/helper.c
new file mode 100644
index 0000000000..7174e4858e
--- /dev/null
+++ b/target/avr/helper.c
@@ -0,0 +1,89 @@
+/*
+ * QEMU AVR CPU helpers
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
+#include "exec/exec-all.h"
+#include "exec/helper-proto.h"
+
+bool avr_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
+{
+    bool ret = false;
+    CPUClass *cc = CPU_GET_CLASS(cs);
+    AVRCPU *cpu = AVR_CPU(cs);
+    CPUAVRState *env = &cpu->env;
+
+    if (interrupt_request & CPU_INTERRUPT_RESET) {
+        if (cpu_interrupts_enabled(env)) {
+            cs->exception_index = EXCP_RESET;
+            cc->do_interrupt(cs);
+
+            cs->interrupt_request &= ~CPU_INTERRUPT_RESET;
+
+            ret = true;
+        }
+    }
+    if (interrupt_request & CPU_INTERRUPT_HARD) {
+        if (cpu_interrupts_enabled(env) && env->intsrc != 0) {
+            int index = ctz32(env->intsrc);
+            cs->exception_index = EXCP_INT(index);
+            cc->do_interrupt(cs);
+
+            env->intsrc &= env->intsrc - 1; /* clear the interrupt */
+            cs->interrupt_request &= ~CPU_INTERRUPT_HARD;
+
+            ret = true;
+        }
+    }
+    return ret;
+}
+
+void avr_cpu_do_interrupt(CPUState *cs)
+{
+    AVRCPU *cpu = AVR_CPU(cs);
+    CPUAVRState *env = &cpu->env;
+
+    uint32_t ret = env->pc_w;
+    int vector = 0;
+    int size = avr_feature(env, AVR_FEATURE_JMP_CALL) ? 2 : 1;
+    int base = 0;
+
+    if (cs->exception_index == EXCP_RESET) {
+        vector = 0;
+    } else if (env->intsrc != 0) {
+        vector = ctz32(env->intsrc) + 1;
+    }
+
+    if (avr_feature(env, AVR_FEATURE_3_BYTE_PC)) {
+        cpu_stb_data(env, env->sp--, (ret & 0x0000ff));
+        cpu_stb_data(env, env->sp--, (ret & 0x00ff00) >> 8);
+        cpu_stb_data(env, env->sp--, (ret & 0xff0000) >> 16);
+    } else if (avr_feature(env, AVR_FEATURE_2_BYTE_PC)) {
+        cpu_stb_data(env, env->sp--, (ret & 0x0000ff));
+        cpu_stb_data(env, env->sp--, (ret & 0x00ff00) >> 8);
+    } else {
+        cpu_stb_data(env, env->sp--, (ret & 0x0000ff));
+    }
+
+    env->pc_w = base + vector * size;
+    env->sregI = 0; /* clear Global Interrupt Flag */
+
+    cs->exception_index = -1;
+}
-- 
2.21.3


