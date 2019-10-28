Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E347CA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 17:08:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD09621721
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 17:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="GYFru5K/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD09621721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33061 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP8Uy-0000Ms-Ae
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 13:08:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34937)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@sifive.com>) id 1iP7Pr-0005kk-4c
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 11:58:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@sifive.com>) id 1iP7Pp-00043D-Cj
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 11:58:46 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432]:39512)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@sifive.com>) id 1iP7Pp-00042f-7J
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 11:58:45 -0400
Received: by mail-pf1-x432.google.com with SMTP id v4so7155631pff.6
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2019 08:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=PTy3sG1Wabo8cInblQzF3n4m9xQd4ThxU4ey9KR/Tjw=;
 b=GYFru5K/YUokoTPbQ5w3pNJuHDimW3SLfQviXB4EJUIWR5hIMwXvk9XsxV9Pq5qFd8
 ixmGgEZLOh5eMCHOQao+fNp2gP3WbwlzJfKjLtVm42BQ06x4DePMb78u2r7aycUdAiG3
 fE6NL4CWBACS59kAv9RPqZZdGUkBWB4esgHZ4TKHLpw12RSdQbw0j19E9YEMh0twXCVt
 k1Iq9S9mtRN+/7/96g+eGB4yNLLluEjm3piYgxz8mixpLEr2V5LGHH9k3aP6yWQ2zb98
 J+L/2w5d0cf5LFQXoPwEMoOuOf2rNozq/3hl/Is5hsa3iPUBN3QWG8g02Nw14XvMDaHZ
 5rdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=PTy3sG1Wabo8cInblQzF3n4m9xQd4ThxU4ey9KR/Tjw=;
 b=H6MvJBY+VBiUYmXFuYm6RyK+xsMmCPU4P1tYD8FCubpqkX8RH3tsm5cBr0uhn0eB7I
 2oCjAVJmD/By07paUh9EMZD6paWtCec+FSN/jHORQCIOBseC4TIGiIVwwfA+JN27/387
 PYpZ7VTUKQa8Iqp/3ZHKvOoYuWUcj/szY+hO0NF9jTl5rlWQo/pQZVLmiOu+G0j0mh8Z
 5Sd9Tp6h/or4Imd1SNmELOBxPvIGOF97qauvcOHbCZgXeI2KuM3gtKIzPP6bOaY5G439
 Y659rqTfVWlc/bFsN0Ht/hQjrTkPco3KOgtyZ6N17aCCYTfE17+TtQ5PmyNb0mdwXyGY
 KvOQ==
X-Gm-Message-State: APjAAAXjEDly3y5F0i4EOHMM6Dgf8XOSfXo1XWrhaccJI/y8A6SJhWf0
 By6xeRYrPrC/2bhdCW2o6AkU0u2rndhSKQ==
X-Google-Smtp-Source: APXvYqwsYQwvNtBvTahr+DwNE5pgjmCA3ZceiPYOMqk2v8nJ38Z3A3Sis7R+wfx/gTvpZUEFwS1cMQ==
X-Received: by 2002:a63:3108:: with SMTP id x8mr21438209pgx.339.1572278323168; 
 Mon, 28 Oct 2019 08:58:43 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id f26sm5171621pgf.22.2019.10.28.08.58.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2019 08:58:42 -0700 (PDT)
Subject: [PULL 15/18] target/riscv: Expose "priv" register for GDB for reads
Date: Mon, 28 Oct 2019 08:48:59 -0700
Message-Id: <20191028154902.32491-16-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191028154902.32491-1-palmer@sifive.com>
References: <20191028154902.32491-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::432
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
Cc: qemu-riscv@nongnu.org, Jonathan Behrens <jonathan@fintelia.io>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jonathan Behrens <jonathan@fintelia.io>

This patch enables a debugger to read the current privilege level via a virtual
"priv" register. When compiled with CONFIG_USER_ONLY the register is still
visible but always reports the value zero.

Signed-off-by: Jonathan Behrens <jonathan@fintelia.io>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
Tested-by: Bin Meng <bmeng.cn@gmail.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 configure                       |  4 ++--
 gdb-xml/riscv-32bit-virtual.xml | 11 +++++++++++
 gdb-xml/riscv-64bit-virtual.xml | 11 +++++++++++
 target/riscv/gdbstub.c          | 23 +++++++++++++++++++++++
 4 files changed, 47 insertions(+), 2 deletions(-)
 create mode 100644 gdb-xml/riscv-32bit-virtual.xml
 create mode 100644 gdb-xml/riscv-64bit-virtual.xml

diff --git a/configure b/configure
index 145fcabbb3..dc94026a3c 100755
--- a/configure
+++ b/configure
@@ -7526,13 +7526,13 @@ case "$target_name" in
     TARGET_BASE_ARCH=riscv
     TARGET_ABI_DIR=riscv
     mttcg=yes
-    gdb_xml_files="riscv-32bit-cpu.xml riscv-32bit-fpu.xml riscv-32bit-csr.xml"
+    gdb_xml_files="riscv-32bit-cpu.xml riscv-32bit-fpu.xml riscv-32bit-csr.xml riscv-32bit-virtual.xml"
   ;;
   riscv64)
     TARGET_BASE_ARCH=riscv
     TARGET_ABI_DIR=riscv
     mttcg=yes
-    gdb_xml_files="riscv-64bit-cpu.xml riscv-64bit-fpu.xml riscv-64bit-csr.xml"
+    gdb_xml_files="riscv-64bit-cpu.xml riscv-64bit-fpu.xml riscv-64bit-csr.xml riscv-64bit-virtual.xml"
   ;;
   sh4|sh4eb)
     TARGET_ARCH=sh4
diff --git a/gdb-xml/riscv-32bit-virtual.xml b/gdb-xml/riscv-32bit-virtual.xml
new file mode 100644
index 0000000000..905f1c555d
--- /dev/null
+++ b/gdb-xml/riscv-32bit-virtual.xml
@@ -0,0 +1,11 @@
+<?xml version="1.0"?>
+<!-- Copyright (C) 2018-2019 Free Software Foundation, Inc.
+
+     Copying and distribution of this file, with or without modification,
+     are permitted in any medium without royalty provided the copyright
+     notice and this notice are preserved.  -->
+
+<!DOCTYPE feature SYSTEM "gdb-target.dtd">
+<feature name="org.gnu.gdb.riscv.virtual">
+  <reg name="priv" bitsize="32"/>
+</feature>
diff --git a/gdb-xml/riscv-64bit-virtual.xml b/gdb-xml/riscv-64bit-virtual.xml
new file mode 100644
index 0000000000..62d86c237b
--- /dev/null
+++ b/gdb-xml/riscv-64bit-virtual.xml
@@ -0,0 +1,11 @@
+<?xml version="1.0"?>
+<!-- Copyright (C) 2018-2019 Free Software Foundation, Inc.
+
+     Copying and distribution of this file, with or without modification,
+     are permitted in any medium without royalty provided the copyright
+     notice and this notice are preserved.  -->
+
+<!DOCTYPE feature SYSTEM "gdb-target.dtd">
+<feature name="org.gnu.gdb.riscv.virtual">
+  <reg name="priv" bitsize="64"/>
+</feature>
diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index cb5bfd3d50..1f71604b78 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -373,6 +373,23 @@ static int riscv_gdb_set_csr(CPURISCVState *env, uint8_t *mem_buf, int n)
     return 0;
 }
 
+static int riscv_gdb_get_virtual(CPURISCVState *cs, uint8_t *mem_buf, int n)
+{
+    if (n == 0) {
+#ifdef CONFIG_USER_ONLY
+        return gdb_get_regl(mem_buf, 0);
+#else
+        return gdb_get_regl(mem_buf, cs->priv);
+#endif
+    }
+    return 0;
+}
+
+static int riscv_gdb_set_virtual(CPURISCVState *cs, uint8_t *mem_buf, int n)
+{
+    return 0;
+}
+
 void riscv_cpu_register_gdb_regs_for_features(CPUState *cs)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
@@ -385,6 +402,9 @@ void riscv_cpu_register_gdb_regs_for_features(CPUState *cs)
 
     gdb_register_coprocessor(cs, riscv_gdb_get_csr, riscv_gdb_set_csr,
                              240, "riscv-32bit-csr.xml", 0);
+
+    gdb_register_coprocessor(cs, riscv_gdb_get_virtual, riscv_gdb_set_virtual,
+                             1, "riscv-32bit-virtual.xml", 0);
 #elif defined(TARGET_RISCV64)
     if (env->misa & RVF) {
         gdb_register_coprocessor(cs, riscv_gdb_get_fpu, riscv_gdb_set_fpu,
@@ -393,5 +413,8 @@ void riscv_cpu_register_gdb_regs_for_features(CPUState *cs)
 
     gdb_register_coprocessor(cs, riscv_gdb_get_csr, riscv_gdb_set_csr,
                              240, "riscv-64bit-csr.xml", 0);
+
+    gdb_register_coprocessor(cs, riscv_gdb_get_virtual, riscv_gdb_set_virtual,
+                             1, "riscv-64bit-virtual.xml", 0);
 #endif
 }
-- 
2.21.0


