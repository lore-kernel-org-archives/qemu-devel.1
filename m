Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAF4C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 18:20:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AA2D20663
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 18:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s9gG8r+S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AA2D20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jssCr-00043p-My
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 14:20:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jss9m-0007Sg-OE
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 14:17:26 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:38545)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jss9k-0002s7-Qr
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 14:17:26 -0400
Received: by mail-wr1-x434.google.com with SMTP id z13so46238862wrw.5
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 11:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Gw++hfDxiOesJTRlVbtIFcd0Zj1Q2dXv8rNLqheywRM=;
 b=s9gG8r+STOS5x1lu63k7shhrRZ+M+vBqSnDdhbEWbCneLmWEgyYhyC/+smA4acyw2o
 QvrCe4QvJncWXaZye0zgsIHfrZle1svAw1eSIfPUEQ0OvHciMLtzhJ/srDzvo0RiSsJ9
 GMOfsXcFusSHtHt+z9wtNbrh8GEN19j8Wk99SfMNesa+dJhStxr5YAD1qWJF57CIL3mh
 YvN8qDUhI2D9fBBYgvJxsNNhsr3hja++IjhRkI7FN62P+sXeQs0Ve1DLS9EMGG9mHqTW
 ljqY0REw2Dpbd2dqoSWKosMMgh33x3fsU0S/78Ol1eEcSoFBD7vqD3TeCxxGK+4R6nNj
 iBbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Gw++hfDxiOesJTRlVbtIFcd0Zj1Q2dXv8rNLqheywRM=;
 b=MWIzQs1OIfgnvR2I3bhayroziNoqjwCgnDz2x7++dOLHdBmvjR5ZVE8eCNefVEEixi
 A4S7pQltsEOMfe+mnzNbfC1cw9JTvU+LYaNHLH1ydUfITzet4XUjV0ETfbAdAntJl1Bu
 l7NdDS8YpzqusRwzzatkn0+iW7O8TSd0VK3etmwRSgYVQ+jIlQkB7/QAnSubDMlFw9c5
 tyXp+/aI5Lck9zOmJ7yggzBWJ/m42/HdapaNAHGiWX5EV0WVSjkaNFmtXX2zKAp14g+d
 v+eIkX+jQ8jFBdt48y2hfXcsGqBI1nSo0MvwJIlVBmzx7bMRYtxxS2+DuJddXqE0/ukX
 90Bw==
X-Gm-Message-State: AOAM533GylJ4QmVAHJVcVzGOEtZN/BHiriOTnZkzq9SDwOPbdTk4gVm/
 F5Twgj3xxeSELCXQJGLNdvGFaaU+
X-Google-Smtp-Source: ABdhPJxL3uwDn1xAG5OC4vTR+83JYQPu+GuwMPkp284YbnH3waO4ZRiWfuH4UL+RK+e0Q4rKthqbRw==
X-Received: by 2002:a5d:6748:: with SMTP id l8mr61151875wrw.347.1594145843102; 
 Tue, 07 Jul 2020 11:17:23 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id 65sm2253337wma.48.2020.07.07.11.17.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 11:17:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/32] target/avr: CPU class: Add GDB support
Date: Tue,  7 Jul 2020 20:16:44 +0200
Message-Id: <20200707181710.30950-7-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200707181710.30950-1-f4bug@amsat.org>
References: <20200707181710.30950-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x434.google.com
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

This includes GDB hooks for reading from wnd wrtiting to AVR
registers, and xml register definition file as well.

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
[thuth: Fixed avr_cpu_gdb_read_register() parameter]
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
Message-Id: <20200705140315.260514-7-huth@tuxfamily.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/avr/cpu.h     |  2 ++
 target/avr/cpu.c     |  4 +++
 target/avr/gdbstub.c | 84 ++++++++++++++++++++++++++++++++++++++++++++
 MAINTAINERS          |  1 +
 gdb-xml/avr-cpu.xml  | 49 ++++++++++++++++++++++++++
 5 files changed, 140 insertions(+)
 create mode 100644 target/avr/gdbstub.c
 create mode 100644 gdb-xml/avr-cpu.xml

diff --git a/target/avr/cpu.h b/target/avr/cpu.h
index 59b89a3a71..6f231d096c 100644
--- a/target/avr/cpu.h
+++ b/target/avr/cpu.h
@@ -123,6 +123,8 @@ extern const struct VMStateDescription vms_avr_cpu;
 void avr_cpu_do_interrupt(CPUState *cpu);
 bool avr_cpu_exec_interrupt(CPUState *cpu, int int_req);
 hwaddr avr_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
+int avr_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
+int avr_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 
 #define cpu_list avr_cpu_list
 #define cpu_signal_handler cpu_avr_signal_handler
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index f4b2d6f55c..ac496b8f03 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -210,4 +210,8 @@ static void avr_cpu_class_init(ObjectClass *oc, void *data)
     cc->disas_set_info = avr_cpu_disas_set_info;
     cc->tcg_initialize = avr_cpu_tcg_init;
     cc->synchronize_from_tb = avr_cpu_synchronize_from_tb;
+    cc->gdb_read_register = avr_cpu_gdb_read_register;
+    cc->gdb_write_register = avr_cpu_gdb_write_register;
+    cc->gdb_num_core_regs = 35;
+    cc->gdb_core_xml_file = "avr-cpu.xml";
 }
diff --git a/target/avr/gdbstub.c b/target/avr/gdbstub.c
new file mode 100644
index 0000000000..c28ed67efe
--- /dev/null
+++ b/target/avr/gdbstub.c
@@ -0,0 +1,84 @@
+/*
+ * QEMU AVR gdbstub
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
+#include "exec/gdbstub.h"
+
+int avr_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
+{
+    AVRCPU *cpu = AVR_CPU(cs);
+    CPUAVRState *env = &cpu->env;
+
+    /*  R */
+    if (n < 32) {
+        return gdb_get_reg8(mem_buf, env->r[n]);
+    }
+
+    /*  SREG */
+    if (n == 32) {
+        uint8_t sreg = cpu_get_sreg(env);
+
+        return gdb_get_reg8(mem_buf, sreg);
+    }
+
+    /*  SP */
+    if (n == 33) {
+        return gdb_get_reg16(mem_buf, env->sp & 0x0000ffff);
+    }
+
+    /*  PC */
+    if (n == 34) {
+        return gdb_get_reg32(mem_buf, env->pc_w * 2);
+    }
+
+    return 0;
+}
+
+int avr_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
+{
+    AVRCPU *cpu = AVR_CPU(cs);
+    CPUAVRState *env = &cpu->env;
+
+    /*  R */
+    if (n < 32) {
+        env->r[n] = *mem_buf;
+        return 1;
+    }
+
+    /*  SREG */
+    if (n == 32) {
+        cpu_set_sreg(env, *mem_buf);
+        return 1;
+    }
+
+    /*  SP */
+    if (n == 33) {
+        env->sp = lduw_p(mem_buf);
+        return 2;
+    }
+
+    /*  PC */
+    if (n == 34) {
+        env->pc_w = ldl_p(mem_buf) / 2;
+        return 4;
+    }
+
+    return 0;
+}
diff --git a/MAINTAINERS b/MAINTAINERS
index 6a012646eb..d439aa41b6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -171,6 +171,7 @@ AVR TCG CPUs
 M: Michael Rolnik <mrolnik@gmail.com>
 R: Sarah Harris <S.E.Harris@kent.ac.uk>
 S: Maintained
+F: gdb-xml/avr-cpu.xml
 F: target/avr/
 
 CRIS TCG CPUs
diff --git a/gdb-xml/avr-cpu.xml b/gdb-xml/avr-cpu.xml
new file mode 100644
index 0000000000..c4747f5b40
--- /dev/null
+++ b/gdb-xml/avr-cpu.xml
@@ -0,0 +1,49 @@
+<?xml version="1.0"?>
+<!-- Copyright (C) 2018-2019 Free Software Foundation, Inc.
+
+     Copying and distribution of this file, with or without modification,
+     are permitted in any medium without royalty provided the copyright
+     notice and this notice are preserved.  -->
+
+<!-- Register numbers are hard-coded in order to maintain backward
+     compatibility with older versions of tools that didn't use xml
+     register descriptions.  -->
+
+<!DOCTYPE feature SYSTEM "gdb-target.dtd">
+<feature name="org.gnu.gdb.riscv.cpu">
+  <reg name="r0" bitsize="8" type="int" regnum="0"/>
+  <reg name="r1" bitsize="8" type="int"/>
+  <reg name="r2" bitsize="8" type="int"/>
+  <reg name="r3" bitsize="8" type="int"/>
+  <reg name="r4" bitsize="8" type="int"/>
+  <reg name="r5" bitsize="8" type="int"/>
+  <reg name="r6" bitsize="8" type="int"/>
+  <reg name="r7" bitsize="8" type="int"/>
+  <reg name="r8" bitsize="8" type="int"/>
+  <reg name="r9" bitsize="8" type="int"/>
+  <reg name="r10" bitsize="8" type="int"/>
+  <reg name="r11" bitsize="8" type="int"/>
+  <reg name="r12" bitsize="8" type="int"/>
+  <reg name="r13" bitsize="8" type="int"/>
+  <reg name="r14" bitsize="8" type="int"/>
+  <reg name="r15" bitsize="8" type="int"/>
+  <reg name="r16" bitsize="8" type="int"/>
+  <reg name="r17" bitsize="8" type="int"/>
+  <reg name="r18" bitsize="8" type="int"/>
+  <reg name="r19" bitsize="8" type="int"/>
+  <reg name="r20" bitsize="8" type="int"/>
+  <reg name="r21" bitsize="8" type="int"/>
+  <reg name="r22" bitsize="8" type="int"/>
+  <reg name="r23" bitsize="8" type="int"/>
+  <reg name="r24" bitsize="8" type="int"/>
+  <reg name="r25" bitsize="8" type="int"/>
+  <reg name="r26" bitsize="8" type="int"/>
+  <reg name="r27" bitsize="8" type="int"/>
+  <reg name="r28" bitsize="8" type="int"/>
+  <reg name="r29" bitsize="8" type="int"/>
+  <reg name="r30" bitsize="8" type="int"/>
+  <reg name="r31" bitsize="8" type="int"/>
+  <reg name="sreg" bitsize="8" type="int"/>
+  <reg name="sp" bitsize="8" type="int"/>
+  <reg name="pc" bitsize="8" type="int"/>
+</feature>
-- 
2.21.3


