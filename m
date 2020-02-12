Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE792C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 17:32:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BB0921569
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 17:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XvPwfw86"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BB0921569
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1vrn-0003hn-Q8
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 12:32:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43238)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1j1vqM-0001sW-7g
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 12:30:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1j1vqK-0000GE-W5
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 12:30:34 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636]:37721)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1j1vqK-0000Fm-R4
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 12:30:32 -0500
Received: by mail-pl1-x636.google.com with SMTP id c23so1215647plz.4
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 09:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=/T6iNfRakf7rR0MOesM9nQQ57APbMmFf8sfGnZ8z00g=;
 b=XvPwfw86KEA7Y3fkZsIBqe4juaYV9B8+Ixc3CRpn4Mcxv8bV27YN1NOykDDRXDmuIk
 TVlA1IcM/cmUlimKCcX7MGKeLaOH8LPVoGnaM9jjl3v0eTADM2KU0WIIzURHbY17TSay
 yLxXvPHXFroYJz7PF6WUdU2d69nxB2B6b1Z+vPEdmpm19uqwzqF6W+szPhlpfW8BydAN
 FFyAT8iGYxVX2aO9H70Ise+mBReSGk/J/vx6W7uL38XDMyiTNlyur7jqOm69BoLHw8w9
 CWOtPBnUdzpzOM9OAzITkfPKLD4FIAU1e8fdtaLiha3yPyn7q5iobUnvmOkDMApysAMj
 lrvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=/T6iNfRakf7rR0MOesM9nQQ57APbMmFf8sfGnZ8z00g=;
 b=LhhVr/aOGrqKG0fONA7LgUvRTmuCInY1U+zM0moMl8kr220PfwqscwBnmW4/dns8yz
 +qIfyVUmhwbAQAlwFiGL6wZIFmkIwRiuRweaA6OYhvhoQQ28v/e9UPrS8EMFhedQkedi
 ik6cEyg4IMIE1HfLyHGYVZO3BBgZsVy/eCXhHIE8G9r6jVQnebkujMWc+RKHbH0+XKo4
 IXwLGQgWEKrSJcKdkot2yrq+N/ErcZAUQ1Mt1ULGcN9yCfOR2UgK5ZNmlklXnJVlrlUe
 j0/XsJ05mtnME0bi6w2IYMOBZyGZXfB9ZQS16pnK24Fn3T96hbGkqAbIohK1xCILiM5A
 f5jw==
X-Gm-Message-State: APjAAAUr6V0YEzfUhnYRo0YNklITVDW8nKYVKmY3CcIUa7OXaTyS4lJk
 oMF1+F0QVz1QkZCOFHoozgG1Rfr/j8A=
X-Google-Smtp-Source: APXvYqwX8X+OMdM7tMdfFwggISrd26/v3LFdleZJoTloqLkPem5XRVgGD3F3oF6UYp7reW7905liEg==
X-Received: by 2002:a17:902:6902:: with SMTP id
 j2mr9456509plk.235.1581528631339; 
 Wed, 12 Feb 2020 09:30:31 -0800 (PST)
Received: from localhost ([2620:0:1000:fd28:dc94:91b3:e554:4ae7])
 by smtp.gmail.com with ESMTPSA id e4sm1034582pgg.94.2020.02.12.09.30.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2020 09:30:30 -0800 (PST)
Subject: [PULL 2/5] riscv: Separate FPU register size from core register size
 in gdbstub [v2]
Date: Wed, 12 Feb 2020 09:29:18 -0800
Message-Id: <20200212172921.36796-3-palmerdabbelt@google.com>
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7-goog
In-Reply-To: <20200212172921.36796-1-palmerdabbelt@google.com>
References: <20200212172921.36796-1-palmerdabbelt@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: qemu-devel@nongnu.org,       qemu-riscv@nongnu.org,
 Keith Packard <keithp@keithp.com>, Palmer Dabbelt <palmerdabbelt@google.com>
From: Palmer Dabbelt <palmerdabbelt@google.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::636
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Keith Packard <keithp@keithp.com>

The size of the FPU registers is dictated by the 'f' and 'd' features,
not the core processor register size. Processors with the 'd' feature
have 64-bit FPU registers. Processors without the 'd' feature but with
the 'f' feature have 32-bit FPU registers.

Signed-off-by: Keith Packard <keithp@keithp.com>
[Palmer: This requires manually triggering a rebuild of
riscv32-softmmu/gdbstub-xml.c]
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 configure              |  4 ++--
 target/riscv/gdbstub.c | 20 +++++++++++---------
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/configure b/configure
index 115dc38085..d1b9e75676 100755
--- a/configure
+++ b/configure
@@ -7736,13 +7736,13 @@ case "$target_name" in
     TARGET_BASE_ARCH=riscv
     TARGET_ABI_DIR=riscv
     mttcg=yes
-    gdb_xml_files="riscv-32bit-cpu.xml riscv-32bit-fpu.xml riscv-32bit-csr.xml riscv-32bit-virtual.xml"
+    gdb_xml_files="riscv-32bit-cpu.xml riscv-32bit-fpu.xml riscv-64bit-fpu.xml riscv-32bit-csr.xml riscv-32bit-virtual.xml"
   ;;
   riscv64)
     TARGET_BASE_ARCH=riscv
     TARGET_ABI_DIR=riscv
     mttcg=yes
-    gdb_xml_files="riscv-64bit-cpu.xml riscv-64bit-fpu.xml riscv-64bit-csr.xml riscv-64bit-virtual.xml"
+    gdb_xml_files="riscv-64bit-cpu.xml riscv-32bit-fpu.xml riscv-64bit-fpu.xml riscv-64bit-csr.xml riscv-64bit-virtual.xml"
   ;;
   sh4|sh4eb)
     TARGET_ARCH=sh4
diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index 1a7947e019..1a72f7be9c 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -303,7 +303,12 @@ int riscv_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 static int riscv_gdb_get_fpu(CPURISCVState *env, uint8_t *mem_buf, int n)
 {
     if (n < 32) {
-        return gdb_get_reg64(mem_buf, env->fpr[n]);
+        if (env->misa & RVD) {
+            return gdb_get_reg64(mem_buf, env->fpr[n]);
+        }
+        if (env->misa & RVF) {
+            return gdb_get_reg32(mem_buf, env->fpr[n]);
+        }
     /* there is hole between ft11 and fflags in fpu.xml */
     } else if (n < 36 && n > 32) {
         target_ulong val = 0;
@@ -403,23 +408,20 @@ void riscv_cpu_register_gdb_regs_for_features(CPUState *cs)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
-#if defined(TARGET_RISCV32)
-    if (env->misa & RVF) {
+    if (env->misa & RVD) {
+        gdb_register_coprocessor(cs, riscv_gdb_get_fpu, riscv_gdb_set_fpu,
+                                 36, "riscv-64bit-fpu.xml", 0);
+    } else if (env->misa & RVF) {
         gdb_register_coprocessor(cs, riscv_gdb_get_fpu, riscv_gdb_set_fpu,
                                  36, "riscv-32bit-fpu.xml", 0);
     }
-
+#if defined(TARGET_RISCV32)
     gdb_register_coprocessor(cs, riscv_gdb_get_csr, riscv_gdb_set_csr,
                              240, "riscv-32bit-csr.xml", 0);
 
     gdb_register_coprocessor(cs, riscv_gdb_get_virtual, riscv_gdb_set_virtual,
                              1, "riscv-32bit-virtual.xml", 0);
 #elif defined(TARGET_RISCV64)
-    if (env->misa & RVF) {
-        gdb_register_coprocessor(cs, riscv_gdb_get_fpu, riscv_gdb_set_fpu,
-                                 36, "riscv-64bit-fpu.xml", 0);
-    }
-
     gdb_register_coprocessor(cs, riscv_gdb_get_csr, riscv_gdb_set_csr,
                              240, "riscv-64bit-csr.xml", 0);
 
-- 
2.25.0.225.g125e21ebc7-goog


