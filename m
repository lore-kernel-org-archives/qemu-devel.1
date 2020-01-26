Return-Path: <SRS0=sDSq=3P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84463C3F68F
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2020 23:03:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E50B20702
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2020 23:03:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E50B20702
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ivqwU-0000t9-H9
	for qemu-devel@archiver.kernel.org; Sun, 26 Jan 2020 18:03:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33466)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1ivqpr-0005eD-Hv
 for qemu-devel@nongnu.org; Sun, 26 Jan 2020 17:56:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1ivqpp-0000Tw-Rt
 for qemu-devel@nongnu.org; Sun, 26 Jan 2020 17:56:55 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:37704 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1ivqpp-00083h-Es
 for qemu-devel@nongnu.org; Sun, 26 Jan 2020 17:56:53 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 93A411A1D1F;
 Sun, 26 Jan 2020 23:55:50 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.14.106])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 6BF551A1CE0;
 Sun, 26 Jan 2020 23:55:50 +0100 (CET)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PATCH rc3 04/30] target/avr: Add GDB support
Date: Sun, 26 Jan 2020 23:54:45 +0100
Message-Id: <1580079311-20447-5-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580079311-20447-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1580079311-20447-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Sarah Harris <S.E.Harris@kent.ac.uk>, Michael Rolnik <mrolnik@gmail.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Michael Rolnik <mrolnik@gmail.com>

This includes GDB hooks for reading from wnd wrtiting to AVR
registers, and xml register definition file as well.

Co-developed-by: Michael Rolnik <mrolnik@gmail.com>
Co-developed-by: Sarah Harris <S.E.Harris@kent.ac.uk>
Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
Signed-off-by: Sarah Harris <S.E.Harris@kent.ac.uk>
Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
---
 gdb-xml/avr-cpu.xml  | 49 ++++++++++++++++++++++++++++++
 target/avr/cpu.c     |  4 +++
 target/avr/cpu.h     |  2 ++
 target/avr/gdbstub.c | 84 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++
 4 files changed, 139 insertions(+)
 create mode 100644 gdb-xml/avr-cpu.xml
 create mode 100644 target/avr/gdbstub.c

diff --git a/gdb-xml/avr-cpu.xml b/gdb-xml/avr-cpu.xml
new file mode 100644
index 0000000..c4747f5
--- /dev/null
+++ b/gdb-xml/avr-cpu.xml
@@ -0,0 +1,49 @@
+<?xml version=3D"1.0"?>
+<!-- Copyright (C) 2018-2019 Free Software Foundation, Inc.
+
+     Copying and distribution of this file, with or without modification=
,
+     are permitted in any medium without royalty provided the copyright
+     notice and this notice are preserved.  -->
+
+<!-- Register numbers are hard-coded in order to maintain backward
+     compatibility with older versions of tools that didn't use xml
+     register descriptions.  -->
+
+<!DOCTYPE feature SYSTEM "gdb-target.dtd">
+<feature name=3D"org.gnu.gdb.riscv.cpu">
+  <reg name=3D"r0" bitsize=3D"8" type=3D"int" regnum=3D"0"/>
+  <reg name=3D"r1" bitsize=3D"8" type=3D"int"/>
+  <reg name=3D"r2" bitsize=3D"8" type=3D"int"/>
+  <reg name=3D"r3" bitsize=3D"8" type=3D"int"/>
+  <reg name=3D"r4" bitsize=3D"8" type=3D"int"/>
+  <reg name=3D"r5" bitsize=3D"8" type=3D"int"/>
+  <reg name=3D"r6" bitsize=3D"8" type=3D"int"/>
+  <reg name=3D"r7" bitsize=3D"8" type=3D"int"/>
+  <reg name=3D"r8" bitsize=3D"8" type=3D"int"/>
+  <reg name=3D"r9" bitsize=3D"8" type=3D"int"/>
+  <reg name=3D"r10" bitsize=3D"8" type=3D"int"/>
+  <reg name=3D"r11" bitsize=3D"8" type=3D"int"/>
+  <reg name=3D"r12" bitsize=3D"8" type=3D"int"/>
+  <reg name=3D"r13" bitsize=3D"8" type=3D"int"/>
+  <reg name=3D"r14" bitsize=3D"8" type=3D"int"/>
+  <reg name=3D"r15" bitsize=3D"8" type=3D"int"/>
+  <reg name=3D"r16" bitsize=3D"8" type=3D"int"/>
+  <reg name=3D"r17" bitsize=3D"8" type=3D"int"/>
+  <reg name=3D"r18" bitsize=3D"8" type=3D"int"/>
+  <reg name=3D"r19" bitsize=3D"8" type=3D"int"/>
+  <reg name=3D"r20" bitsize=3D"8" type=3D"int"/>
+  <reg name=3D"r21" bitsize=3D"8" type=3D"int"/>
+  <reg name=3D"r22" bitsize=3D"8" type=3D"int"/>
+  <reg name=3D"r23" bitsize=3D"8" type=3D"int"/>
+  <reg name=3D"r24" bitsize=3D"8" type=3D"int"/>
+  <reg name=3D"r25" bitsize=3D"8" type=3D"int"/>
+  <reg name=3D"r26" bitsize=3D"8" type=3D"int"/>
+  <reg name=3D"r27" bitsize=3D"8" type=3D"int"/>
+  <reg name=3D"r28" bitsize=3D"8" type=3D"int"/>
+  <reg name=3D"r29" bitsize=3D"8" type=3D"int"/>
+  <reg name=3D"r30" bitsize=3D"8" type=3D"int"/>
+  <reg name=3D"r31" bitsize=3D"8" type=3D"int"/>
+  <reg name=3D"sreg" bitsize=3D"8" type=3D"int"/>
+  <reg name=3D"sp" bitsize=3D"8" type=3D"int"/>
+  <reg name=3D"pc" bitsize=3D"8" type=3D"int"/>
+</feature>
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 8a9b106..673a0ee 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -218,4 +218,8 @@ static void avr_cpu_class_init(ObjectClass *oc, void =
*data)
     cc->tlb_fill =3D avr_cpu_tlb_fill;
     cc->tcg_initialize =3D avr_cpu_tcg_init;
     cc->synchronize_from_tb =3D avr_cpu_synchronize_from_tb;
+    cc->gdb_read_register =3D avr_cpu_gdb_read_register;
+    cc->gdb_write_register =3D avr_cpu_gdb_write_register;
+    cc->gdb_num_core_regs =3D 35;
+    cc->gdb_core_xml_file =3D "avr-cpu.xml";
 }
diff --git a/target/avr/cpu.h b/target/avr/cpu.h
index 9d08bff..b358e94 100644
--- a/target/avr/cpu.h
+++ b/target/avr/cpu.h
@@ -122,6 +122,8 @@ extern const struct VMStateDescription vms_avr_cpu;
 void avr_cpu_do_interrupt(CPUState *cpu);
 bool avr_cpu_exec_interrupt(CPUState *cpu, int int_req);
 hwaddr avr_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
+int avr_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
+int avr_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
=20
 #define cpu_list avr_cpu_list
 #define cpu_signal_handler cpu_avr_signal_handler
diff --git a/target/avr/gdbstub.c b/target/avr/gdbstub.c
new file mode 100644
index 0000000..733184c
--- /dev/null
+++ b/target/avr/gdbstub.c
@@ -0,0 +1,84 @@
+/*
+ * QEMU AVR CPU
+ *
+ * Copyright (c) 2019 Michael Rolnik
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
+int avr_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
+{
+    AVRCPU *cpu =3D AVR_CPU(cs);
+    CPUAVRState *env =3D &cpu->env;
+
+    /*  R */
+    if (n < 32) {
+        return gdb_get_reg8(mem_buf, env->r[n]);
+    }
+
+    /*  SREG */
+    if (n =3D=3D 32) {
+        uint8_t sreg =3D cpu_get_sreg(env);
+
+        return gdb_get_reg8(mem_buf, sreg);
+    }
+
+    /*  SP */
+    if (n =3D=3D 33) {
+        return gdb_get_reg16(mem_buf, env->sp & 0x0000ffff);
+    }
+
+    /*  PC */
+    if (n =3D=3D 34) {
+        return gdb_get_reg32(mem_buf, env->pc_w * 2);
+    }
+
+    return 0;
+}
+
+int avr_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
+{
+    AVRCPU *cpu =3D AVR_CPU(cs);
+    CPUAVRState *env =3D &cpu->env;
+
+    /*  R */
+    if (n < 32) {
+        env->r[n] =3D *mem_buf;
+        return 1;
+    }
+
+    /*  SREG */
+    if (n =3D=3D 32) {
+        cpu_set_sreg(env, *mem_buf);
+        return 1;
+    }
+
+    /*  SP */
+    if (n =3D=3D 33) {
+        env->sp =3D lduw_p(mem_buf);
+        return 2;
+    }
+
+    /*  PC */
+    if (n =3D=3D 34) {
+        env->pc_w =3D ldl_p(mem_buf) / 2;
+        return 4;
+    }
+
+    return 0;
+}
--=20
2.7.4


