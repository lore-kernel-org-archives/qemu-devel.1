Return-Path: <SRS0=Uyhh=TE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E93DC43219
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 12:07:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 587DD206DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 12:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1YDJoMk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 587DD206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55672 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMtSF-00008d-Fu
	for qemu-devel@archiver.kernel.org; Sat, 04 May 2019 08:07:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hMtQL-0007IV-DI
	for qemu-devel@nongnu.org; Sat, 04 May 2019 08:05:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hMtQJ-0001HQ-RK
	for qemu-devel@nongnu.org; Sat, 04 May 2019 08:05:49 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232]:33238)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1hMtQI-0001Dy-22; Sat, 04 May 2019 08:05:47 -0400
Received: by mail-oi1-x232.google.com with SMTP id m204so739982oib.0;
	Sat, 04 May 2019 05:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=clxKL3l8fCsJ+v+w3/bwQs1BkGuF1T6/oLLs/QaMqLg=;
	b=D1YDJoMk5/Ln1/8MOUmYG5JTgeCYii3zgtbHlGcXnVCMGyPsDxYKOpSJSTu6I/SYTt
	OnAkpIbIWSRyeVe5a2AYtbew0f5hcepyxsq9auUNQ1eeB8DNuv4U+IAuwhiB3/eFe7hh
	ApUVNBMr/Xv8NF3yK6/wHH1i5JqFhvI7P+MO7Aw8l6VzhCPMml4BbhV2yWMABsqswZ97
	9OsJbIw2kRkwJpuIGHLlRx8pexJphpoYSsjnOFAwAzirE7RAMtvpJVMtPJqNCfQmONnr
	uD0GVjDma/ubqZguZ7MFLea4Zw0XYobwT/FNmcubjWUF4Drf4bxma4+aYvuOIDnr49IV
	JwFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	bh=clxKL3l8fCsJ+v+w3/bwQs1BkGuF1T6/oLLs/QaMqLg=;
	b=PFNqiqtFi/w6ujdaqyUyqm/jlTutHDN/CmDeqqYMY33tp/oXWuVZGf16q20ikYUjx5
	Cj404QGwBuBFuQ76/vz+M40SLDw6VH7c8g9HocBp1auFye6/1szsKgIbtSUwiz/boUzo
	7Y0pVnZgd03egJ6/qL5QuvCxf83BCfbyVzWQunge8oXKEdmPhWSKTu7umCIhxwSkDAKV
	bXBnZ+1UfY68bRGLNgQqsXINqcnUvJnOOOiTGJd/vSUFB6+hy/pU1GCcoR/j3+J6xgRd
	54ITl05vcGeIajFbot5eVxrpnr5yHVl9T21L/lIbV7rwNhwzsuAO6+AvO5mUR2XCdJjT
	p8OQ==
X-Gm-Message-State: APjAAAUil6cVK3ZMC3eDBHJrJsB3RDf1L7toObCY8OjoaAWbfjDiXZ3l
	WZVwr1k2hOT96M466CXcCjm1JxRd
X-Google-Smtp-Source: APXvYqwqtmIgySlFr8l0sR/oulIvMNV5WLxQrx+USSA3VK5trR21YhqnIK7CdfXDS03mLthedxZUog==
X-Received: by 2002:aca:da07:: with SMTP id r7mr2428683oig.5.1556971538769;
	Sat, 04 May 2019 05:05:38 -0700 (PDT)
Received: from localhost.localdomain ([198.59.53.9])
	by smtp.gmail.com with ESMTPSA id
	s26sm1844978otk.24.2019.05.04.05.05.37
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 04 May 2019 05:05:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Sat,  4 May 2019 06:05:26 -0600
Message-Id: <20190504120528.6389-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190504120528.6389-1-pbonzini@redhat.com>
References: <20190504120528.6389-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::232
Subject: [Qemu-devel] [PATCH 8/9] tcg/i386: add support for IBT
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, cohuck@redhat.com, richard.henderson@linaro.org,
	qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190504120526.Uh6bTjzJMDbiJfB2ark7X8B7UNoSZVqNs1kVO7jgUuE@z>

Add endbr annotations before indirect branch targets.  This lets QEMU enable
IBT even for TCG-enabled builds.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile.target           |  2 ++
 configure                 |  9 +++++++++
 include/qemu/cpuid.h      |  5 +++++
 tcg/i386/tcg-target.inc.c | 19 +++++++++++++++++++
 4 files changed, 35 insertions(+)

diff --git a/Makefile.target b/Makefile.target
index 667682779b..d168ee7555 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -112,8 +112,10 @@ obj-y += accel/
 obj-$(CONFIG_TCG) += tcg/tcg.o tcg/tcg-op.o tcg/tcg-op-vec.o tcg/tcg-op-gvec.o
 obj-$(CONFIG_TCG) += tcg/tcg-common.o tcg/optimize.o
 ifeq ($(CONFIG_CF_PROTECTION),y)
+ifneq ($(CONFIG_CF_PROTECTION_TCG),y)
 tcg/tcg.o-cflags := -fcf-protection=return
 endif
+endif
 obj-$(CONFIG_TCG_INTERPRETER) += tcg/tci.o
 obj-$(CONFIG_TCG_INTERPRETER) += disas/tci.o
 obj-$(CONFIG_TCG) += fpu/softfloat.o
diff --git a/configure b/configure
index 946ff7825a..c02a5f4b79 100755
--- a/configure
+++ b/configure
@@ -5200,6 +5200,11 @@ fi
 if test "$cf_protection" = "yes"; then
   QEMU_CFLAGS="-fcf-protection $QEMU_CFLAGS"
 fi
+if test "$cpu" = "x86_64"; then
+  cf_protection_tcg=yes
+else
+  cf_protection_tcg=no
+fi
 
 ##########################################
 # check and set a backend for coroutine
@@ -6395,6 +6400,7 @@ echo "TCG support       $tcg"
 if test "$tcg" = "yes" ; then
     echo "TCG debug enabled $debug_tcg"
     echo "TCG interpreter   $tcg_interpreter"
+    echo "TCG CF protection $cf_protection_tcg"
 fi
 echo "malloc trim support $malloc_trim"
 echo "RDMA support      $rdma"
@@ -6600,6 +6606,9 @@ fi
 if test "$cf_protection" = "yes" ; then
   echo "CONFIG_CF_PROTECTION=y" >> $config_host_mak
 fi
+if test "$cf_protection_tcg" = "yes" ; then
+  echo "CONFIG_CF_PROTECTION_TCG=y" >> $config_host_mak
+fi
 if test "$slirp" != "no"; then
   echo "CONFIG_SLIRP=y" >> $config_host_mak
   echo "CONFIG_SMBD_COMMAND=\"$smbd\"" >> $config_host_mak
diff --git a/include/qemu/cpuid.h b/include/qemu/cpuid.h
index 69301700bd..e32fb209f5 100644
--- a/include/qemu/cpuid.h
+++ b/include/qemu/cpuid.h
@@ -49,6 +49,11 @@
 #define bit_BMI2        (1 << 8)
 #endif
 
+/* Leaf 7, %edx */
+#ifndef bit_IBT
+#define bit_IBT         (1 << 20)
+#endif
+
 /* Leaf 0x80000001, %ecx */
 #ifndef bit_LZCNT
 #define bit_LZCNT       (1 << 5)
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index b210977800..cb3de2f7ac 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -159,10 +159,12 @@ bool have_avx2;
 static bool have_movbe;
 static bool have_bmi2;
 static bool have_lzcnt;
+static bool have_ibt;
 #else
 # define have_movbe 0
 # define have_bmi2 0
 # define have_lzcnt 0
+# define have_ibt 1
 #endif
 
 static tcg_insn_unit *tb_ret_addr;
@@ -809,6 +811,19 @@ static inline void tgen_arithr(TCGContext *s, int subop, int dest, int src)
     tcg_out_modrm(s, OPC_ARITH_GvEv + (subop << 3) + ext, dest, src);
 }
 
+static void tcg_out_endbr(TCGContext *s)
+{
+    if (have_ibt) {
+#if defined __CET__ && (__CET__ & 1)
+#ifdef __x86_64__
+        tcg_out32(s, 0xfa1e0ff3);
+#else
+        tcg_out32(s, 0xfb1e0ff3);
+#endif
+#endif
+    }
+}
+
 static void tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
 {
     int rexw = 0;
@@ -3512,6 +3527,7 @@ static const int tcg_target_callee_save_regs[] = {
 
 static inline void tcg_out_start(TCGContext *s)
 {
+    tcg_out_endbr(s);
 }
 
 /* Generate global QEMU prologue and epilogue code */
@@ -3520,6 +3536,7 @@ static void tcg_target_qemu_prologue(TCGContext *s)
     int i, stack_addend;
 
     /* TB prologue */
+    tcg_out_endbr(s);
 
     /* Reserve some stack space, also for TCG temps.  */
     stack_addend = FRAME_SIZE - PUSH_SIZE;
@@ -3566,6 +3583,7 @@ static void tcg_target_qemu_prologue(TCGContext *s)
      * and fall through to the rest of the epilogue.
      */
     s->code_gen_epilogue = s->code_ptr;
+    tcg_out_endbr(s);
     tcg_out_movi(s, TCG_TYPE_REG, TCG_REG_EAX, 0);
 
     /* TB epilogue */
@@ -3598,6 +3616,7 @@ static void tcg_target_init(TCGContext *s)
         __cpuid_count(7, 0, a, b7, c, d);
         have_bmi1 = (b7 & bit_BMI) != 0;
         have_bmi2 = (b7 & bit_BMI2) != 0;
+        have_ibt = (d & bit_IBT) != 0;
     }
 
     if (max >= 1) {
-- 
2.21.0



