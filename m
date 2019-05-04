Return-Path: <SRS0=Uyhh=TE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0725DC43219
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 12:12:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6BF0206DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 12:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DlhuQB22"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6BF0206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55750 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMtX5-0004W1-Vx
	for qemu-devel@archiver.kernel.org; Sat, 04 May 2019 08:12:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hMtQD-0007BQ-Sl
	for qemu-devel@nongnu.org; Sat, 04 May 2019 08:05:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hMtQA-0001Dd-EB
	for qemu-devel@nongnu.org; Sat, 04 May 2019 08:05:40 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:35930)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1hMtQ8-0001CW-Ko; Sat, 04 May 2019 08:05:37 -0400
Received: by mail-ot1-x32b.google.com with SMTP id b18so7642080otq.3;
	Sat, 04 May 2019 05:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=ahvxSVh2QRrmKy4BCWONH7xM6dTvjNFat384VGW5p48=;
	b=DlhuQB22RV1+3Fd5TonZaG+STyJJDViJefRG+GqcluWwvMh3UG8r7XIjHMr4QibUuM
	QkA0I+WfdBOGDRFfXFeuKbYFL0LgkhKhXw/Nb/7dshKXPTgaKwI7CWcyUh46wFsXOrSV
	bD2o5tJTReYJWdXZgpjbfJz22wBrqzaN/P5mQSaFYyFc7FaP3/7ozq9sCzULtPjY6hK9
	KShiX2Az+87XsIREe6bu30FshS31mOe6P7Z+4IxxBCvQSLscz5qC7W983wwifbUvJCp0
	jcS6utiq5+YVGR//dQPLx221dr14hlPG8yD7G7aQweKqpEGeGWFffn3bhi93Ys5NajHm
	xTUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	bh=ahvxSVh2QRrmKy4BCWONH7xM6dTvjNFat384VGW5p48=;
	b=l21mOjprKJPDceTuz3tAzaRyRNDsbyq2BDO1ee02wo4wG4AFzISA3ZRVbBEH5cEM49
	grgfzkHXewE23MR4HuDB3f9fqisDA2M4Zj3ugUYYZLEnJxTD2S+Lsjo8mtK/6eQnMQZE
	re6QkxZCIb0ZJjw9PGa257mOkg4XuDIYV4oZcIOiqO8O92DH55h/SwM1MoqMm+EywYH0
	8PMVxb/OkwhWcQjrvEcJ+XAds2fFM5yyl8UXJo6JyoioPPBN4dcrZDre7jhGD2dsy/Jy
	JGothV/Pjrtm5K4wZ3560psKnaWPays0I+HL+Lw0hoUWN0WhxgUcswxAzInufzp1PxJb
	XXQQ==
X-Gm-Message-State: APjAAAX874+jL/7EhvL1p7cijLGCsExTMo9gKY7VmPiHqCQJMHayNB4z
	TuF5XHVUbd4Z0KblZScQy1YLLjwx
X-Google-Smtp-Source: APXvYqzQKTNLeqe5MBi7n5ye0an2mSuXMLB7grlxz4GH47D5Z4jl7b8X8VWuM06BHcDbDOP0V+Zj9A==
X-Received: by 2002:a05:6830:16ce:: with SMTP id
	l14mr9987365otr.108.1556971534966; 
	Sat, 04 May 2019 05:05:34 -0700 (PDT)
Received: from localhost.localdomain ([198.59.53.9])
	by smtp.gmail.com with ESMTPSA id
	s26sm1844978otk.24.2019.05.04.05.05.33
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 04 May 2019 05:05:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Sat,  4 May 2019 06:05:22 -0600
Message-Id: <20190504120528.6389-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190504120528.6389-1-pbonzini@redhat.com>
References: <20190504120528.6389-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::32b
Subject: [Qemu-devel] [PATCH 4/9] coroutine: add host specific coroutine
 backend for 64-bit ARM
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
Message-ID: <20190504120522.YKPNMednFkpoqajoh4XXmZTINGaFc-U1fsianzJqbPI@z>

The speedup is similar to x86, 120 ns vs 180 ns on an APM Mustang.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure                        |  2 +-
 scripts/qemugdb/coroutine_asm.py |  6 ++++-
 util/Makefile.objs               |  2 ++
 util/coroutine-asm.c             | 45 ++++++++++++++++++++++++++++++++
 4 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index c01f57a3ae..26e62a4ab1 100755
--- a/configure
+++ b/configure
@@ -5200,7 +5200,7 @@ fi
 if test "$coroutine" = ""; then
   if test "$mingw32" = "yes"; then
     coroutine=win32
-  elif test "$cpu" = "x86_64"; then
+  elif test "$cpu" = "x86_64" || test "$cpu" = "aarch64"; then
      coroutine=asm
   elif test "$ucontext_works" = "yes"; then
     coroutine=ucontext
diff --git a/scripts/qemugdb/coroutine_asm.py b/scripts/qemugdb/coroutine_asm.py
index b4ac1291db..181b77287b 100644
--- a/scripts/qemugdb/coroutine_asm.py
+++ b/scripts/qemugdb/coroutine_asm.py
@@ -17,4 +17,8 @@ U64_PTR = gdb.lookup_type('uint64_t').pointer()
 def get_coroutine_regs(addr):
     addr = addr.cast(gdb.lookup_type('CoroutineAsm').pointer())
     rsp = addr['sp'].cast(U64_PTR)
-    return {'sp': rsp, 'pc': rsp.dereference()}
+    arch = gdb.selected_frame().architecture.name().split(':'):
+    if arch[0] == 'i386' and arch[1] == 'x86-64':
+        return {'rsp': rsp, 'pc': rsp.dereference()}
+    else:
+        return {'sp': rsp, 'pc': addr['scratch'].cast(U64_PTR) }
diff --git a/util/Makefile.objs b/util/Makefile.objs
index 41a10539cf..2167ffc862 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -39,7 +39,9 @@ util-obj-$(CONFIG_MEMBARRIER) += sys_membarrier.o
 util-obj-y += qemu-coroutine.o qemu-coroutine-lock.o qemu-coroutine-io.o
 util-obj-y += qemu-coroutine-sleep.o
 util-obj-y += coroutine-$(CONFIG_COROUTINE_BACKEND).o
+ifeq ($(ARCH),x86_64)
 coroutine-asm.o-cflags := -mno-red-zone
+endif
 util-obj-y += buffer.o
 util-obj-y += timed-average.o
 util-obj-y += base64.o
diff --git a/util/coroutine-asm.c b/util/coroutine-asm.c
index a06ecbcb0a..de68e98622 100644
--- a/util/coroutine-asm.c
+++ b/util/coroutine-asm.c
@@ -40,6 +40,11 @@ typedef struct {
     Coroutine base;
     void *sp;
 
+    /*
+     * aarch64: instruction pointer
+     */
+    void *scratch;
+
     void *stack;
     size_t stack_size;
 
@@ -116,6 +121,49 @@ static void start_switch_fiber(void **fake_stack_save,
 /* Use "call" to ensure the stack  is aligned correctly.  */
 #define CO_SWITCH_NEW(from, to) CO_SWITCH(from, to, 0, "call coroutine_trampoline")
 #define CO_SWITCH_RET(from, to, action) CO_SWITCH(from, to, action, "ret")
+
+#elif defined __aarch64__
+/*
+ * GCC does not support clobbering the frame pointer, so we save it ourselves.
+ * Saving the link register as well generates slightly better code because then
+ * qemu_coroutine_switch can be treated as a leaf procedure.
+ */
+#define CO_SWITCH_RET(from, to, action) ({                                            \
+    register uintptr_t action_ __asm__("x0") = action;                                \
+    register void *from_ __asm__("x16") = from;                                       \
+    register void *to_ __asm__("x1") = to;                                            \
+    asm volatile(                                                                     \
+        ".cfi_remember_state\n"                                                       \
+        "stp x29, x30, [sp, #-16]!\n"    /* GCC does not save it, do it ourselves */  \
+        ".cfi_adjust_cfa_offset 16\n"                                                 \
+        ".cfi_def_cfa_register sp\n"                                                  \
+        "adr x30, 2f\n"                  /* source PC will be after the BR */         \
+        "str x30, [x16, %[SCRATCH]]\n"   /* save it */                                \
+        "mov x30, sp\n"                  /* save source SP */                         \
+        "str x30, [x16, %[SP]]\n"                                                     \
+        "ldr x30, [x1, %[SCRATCH]]\n"    /* load destination PC */                    \
+        "ldr x1, [x1, %[SP]]\n"          /* load destination SP */                    \
+        "mov sp, x1\n"                                                                \
+        "br x30\n"                                                                    \
+        "2: \n"                                                                       \
+        "ldp x29, x30, [sp], #16\n"                                                   \
+        ".cfi_restore_state\n"                                                        \
+        : "+r" (action_), "+r" (from_), "+r" (to_)                                    \
+        : [SP] "i" (offsetof(CoroutineAsm, sp)),                                      \
+          [SCRATCH] "i" (offsetof(CoroutineAsm, scratch))                             \
+        : "x2", "x3", "x4", "x5", "x6", "x7", "x8", "x9", "x10", "x11", "x12",        \
+          "x13", "x14", "x15", "x17", "x18", "x19", "x20", "x21", "x22", "x23",       \
+          "x24", "x25", "x26", "x27", "x28",                                          \
+          "v0", "v1", "v2", "v3", "v4", "v5", "v6", "v7", "v8", "v9", "v10", "v11",   \
+          "v12", "v13", "v14", "v15", v16", "v17", "v18", "v19", "v20", "v21", "v22", \
+          "v23", "v24", "v25", "v26", "v27", "v28", "v29", "v30", "v31", "memory",    \
+    action_;                                                                          \
+})
+
+#define CO_SWITCH_NEW(from, to) do {                                                  \
+  (to)->scratch = (void *) coroutine_trampoline;                                      \
+  (void) CO_SWITCH_RET(from, to, (uintptr_t) to);                                     \
+} while(0)
 #else
 #error coroutine-asm.c not ported to this architecture.
 #endif
-- 
2.21.0



