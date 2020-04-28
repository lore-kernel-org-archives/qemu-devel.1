Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D171FC83008
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 17:20:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7C3D2082E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 17:20:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7C3D2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=adacore.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTTuJ-0005lo-Pq
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 13:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40288)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frederic.konrad@adacore.com>) id 1jTTt3-000430-JF
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 13:19:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <frederic.konrad@adacore.com>) id 1jTTt2-0003aY-JM
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 13:19:13 -0400
Received: from mel.act-europe.fr ([194.98.77.210]:37241
 helo=smtp.eu.adacore.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frederic.konrad@adacore.com>)
 id 1jTTt2-0003aB-18
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 13:19:12 -0400
Received: from localhost (localhost [127.0.0.1])
 by filtered-smtp.eu.adacore.com (Postfix) with ESMTP id 870218137A;
 Tue, 28 Apr 2020 19:19:10 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at eu.adacore.com
Received: from smtp.eu.adacore.com ([127.0.0.1])
 by localhost (smtp.eu.adacore.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bN-fJuC4b0b8; Tue, 28 Apr 2020 19:19:10 +0200 (CEST)
Received: from localhost.localdomain.localdomain
 (lfbn-tou-1-1471-22.w90-89.abo.wanadoo.fr [90.89.4.22])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by smtp.eu.adacore.com (Postfix) with ESMTPSA id 525EF81353;
 Tue, 28 Apr 2020 19:19:10 +0200 (CEST)
From: KONRAD Frederic <frederic.konrad@adacore.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] target/m68k: fix gdb for m68xxx
Date: Tue, 28 Apr 2020 19:17:58 +0200
Message-Id: <1588094279-17913-3-git-send-email-frederic.konrad@adacore.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1588094279-17913-1-git-send-email-frederic.konrad@adacore.com>
References: <1588094279-17913-1-git-send-email-frederic.konrad@adacore.com>
Received-SPF: pass client-ip=194.98.77.210;
 envelope-from=frederic.konrad@adacore.com; helo=smtp.eu.adacore.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 12:46:33
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Received-From: 194.98.77.210
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
Cc: philmd@redhat.com, frederic.konrad@adacore.com, alex.bennee@linaro.org,
 laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently "cf-core.xml" is sent to GDB when using any m68k flavor.  Thing is
it uses the "org.gnu.gdb.coldfire.core" feature name and gdb 8.3 then expects
a coldfire FPU instead of the default m68881 FPU.

This is not OK because the m68881 floats registers are 96 bits wide so it
crashes GDB with the following error message:

(gdb) target remote localhost:7960
Remote debugging using localhost:7960
warning: Register "fp0" has an unsupported size (96 bits)
warning: Register "fp1" has an unsupported size (96 bits)
...
Remote 'g' packet reply is too long (expected 148 bytes, got 180 bytes):    \
  00000000000[...]0000

With this patch: qemu-system-m68k -M none -cpu m68020 -s -S

(gdb) tar rem :1234
Remote debugging using :1234
warning: No executable has been specified and target does not support
determining executable automatically.  Try using the "file" command.
0x00000000 in ?? ()
(gdb) p $fp0
$1 = nan(0xffffffffffffffff)

Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
---
 configure             |  2 +-
 gdb-xml/m68k-core.xml | 29 ++++++++++++++++++++++++++++
 target/m68k/cpu.c     | 52 ++++++++++++++++++++++++++++++++++++---------------
 3 files changed, 67 insertions(+), 16 deletions(-)
 create mode 100644 gdb-xml/m68k-core.xml

diff --git a/configure b/configure
index 23b5e93..2b07b85 100755
--- a/configure
+++ b/configure
@@ -7825,7 +7825,7 @@ case "$target_name" in
   ;;
   m68k)
     bflt="yes"
-    gdb_xml_files="cf-core.xml cf-fp.xml m68k-fp.xml"
+    gdb_xml_files="cf-core.xml cf-fp.xml m68k-core.xml m68k-fp.xml"
     TARGET_SYSTBL_ABI=common
   ;;
   microblaze|microblazeel)
diff --git a/gdb-xml/m68k-core.xml b/gdb-xml/m68k-core.xml
new file mode 100644
index 0000000..5b092d2
--- /dev/null
+++ b/gdb-xml/m68k-core.xml
@@ -0,0 +1,29 @@
+<?xml version="1.0"?>
+<!-- Copyright (C) 2008 Free Software Foundation, Inc.
+
+     Copying and distribution of this file, with or without modification,
+     are permitted in any medium without royalty provided the copyright
+     notice and this notice are preserved.  -->
+<!DOCTYPE feature SYSTEM "gdb-target.dtd">
+<feature name="org.gnu.gdb.m68k.core">
+  <reg name="d0" bitsize="32"/>
+  <reg name="d1" bitsize="32"/>
+  <reg name="d2" bitsize="32"/>
+  <reg name="d3" bitsize="32"/>
+  <reg name="d4" bitsize="32"/>
+  <reg name="d5" bitsize="32"/>
+  <reg name="d6" bitsize="32"/>
+  <reg name="d7" bitsize="32"/>
+  <reg name="a0" bitsize="32" type="data_ptr"/>
+  <reg name="a1" bitsize="32" type="data_ptr"/>
+  <reg name="a2" bitsize="32" type="data_ptr"/>
+  <reg name="a3" bitsize="32" type="data_ptr"/>
+  <reg name="a4" bitsize="32" type="data_ptr"/>
+  <reg name="a5" bitsize="32" type="data_ptr"/>
+  <reg name="fp" bitsize="32" type="data_ptr"/>
+  <reg name="sp" bitsize="32" type="data_ptr"/>
+
+  <reg name="ps" bitsize="32"/>
+  <reg name="pc" bitsize="32" type="code_ptr"/>
+
+</feature>
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 9445fcd..72c5451 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -292,16 +292,38 @@ static void m68k_cpu_class_init(ObjectClass *c, void *data)
     cc->tcg_initialize = m68k_tcg_init;
 
     cc->gdb_num_core_regs = 18;
-    cc->gdb_core_xml_file = "cf-core.xml";
 
     dc->vmsd = &vmstate_m68k_cpu;
 }
 
-#define DEFINE_M68K_CPU_TYPE(cpu_model, initfn) \
-    {                                           \
-        .name = M68K_CPU_TYPE_NAME(cpu_model),  \
-        .instance_init = initfn,                \
-        .parent = TYPE_M68K_CPU,                \
+static void m68k_cpu_class_init_cf_core(ObjectClass *c, void *data)
+{
+    CPUClass *cc = CPU_CLASS(c);
+
+    cc->gdb_core_xml_file = "cf-core.xml";
+}
+
+#define DEFINE_M68K_CPU_TYPE_CF(model)               \
+    {                                                \
+        .name = M68K_CPU_TYPE_NAME(#model),          \
+        .instance_init = model##_cpu_initfn,         \
+        .parent = TYPE_M68K_CPU,                     \
+        .class_init = m68k_cpu_class_init_cf_core    \
+    }
+
+static void m68k_cpu_class_init_m68k_core(ObjectClass *c, void *data)
+{
+    CPUClass *cc = CPU_CLASS(c);
+
+    cc->gdb_core_xml_file = "m68k-core.xml";
+}
+
+#define DEFINE_M68K_CPU_TYPE_M68K(model)             \
+    {                                                \
+        .name = M68K_CPU_TYPE_NAME(#model),          \
+        .instance_init = model##_cpu_initfn,         \
+        .parent = TYPE_M68K_CPU,                     \
+        .class_init = m68k_cpu_class_init_m68k_core  \
     }
 
 static const TypeInfo m68k_cpus_type_infos[] = {
@@ -314,15 +336,15 @@ static const TypeInfo m68k_cpus_type_infos[] = {
         .class_size = sizeof(M68kCPUClass),
         .class_init = m68k_cpu_class_init,
     },
-    DEFINE_M68K_CPU_TYPE("m68000", m68000_cpu_initfn),
-    DEFINE_M68K_CPU_TYPE("m68020", m68020_cpu_initfn),
-    DEFINE_M68K_CPU_TYPE("m68030", m68030_cpu_initfn),
-    DEFINE_M68K_CPU_TYPE("m68040", m68040_cpu_initfn),
-    DEFINE_M68K_CPU_TYPE("m68060", m68060_cpu_initfn),
-    DEFINE_M68K_CPU_TYPE("m5206", m5206_cpu_initfn),
-    DEFINE_M68K_CPU_TYPE("m5208", m5208_cpu_initfn),
-    DEFINE_M68K_CPU_TYPE("cfv4e", cfv4e_cpu_initfn),
-    DEFINE_M68K_CPU_TYPE("any", any_cpu_initfn),
+    DEFINE_M68K_CPU_TYPE_M68K(m68000),
+    DEFINE_M68K_CPU_TYPE_M68K(m68020),
+    DEFINE_M68K_CPU_TYPE_M68K(m68030),
+    DEFINE_M68K_CPU_TYPE_M68K(m68040),
+    DEFINE_M68K_CPU_TYPE_M68K(m68060),
+    DEFINE_M68K_CPU_TYPE_CF(m5206),
+    DEFINE_M68K_CPU_TYPE_CF(m5208),
+    DEFINE_M68K_CPU_TYPE_CF(cfv4e),
+    DEFINE_M68K_CPU_TYPE_CF(any),
 };
 
 DEFINE_TYPES(m68k_cpus_type_infos)
-- 
1.8.3.1


