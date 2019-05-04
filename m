Return-Path: <SRS0=Uyhh=TE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963F0C43219
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 12:07:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62D40206DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 12:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEXDo7B+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62D40206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55670 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMtSA-0008Um-Gx
	for qemu-devel@archiver.kernel.org; Sat, 04 May 2019 08:07:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hMtQI-0007F9-2A
	for qemu-devel@nongnu.org; Sat, 04 May 2019 08:05:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hMtQE-0001FI-BY
	for qemu-devel@nongnu.org; Sat, 04 May 2019 08:05:44 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:44874)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1hMtQA-0001Ch-Cj; Sat, 04 May 2019 08:05:40 -0400
Received: by mail-ot1-x344.google.com with SMTP id d10so2529023otp.11;
	Sat, 04 May 2019 05:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=0TS4qEKmw4BOwv+KpHsCK8QIkMFbVbLGctn5J+3azt8=;
	b=YEXDo7B+eNmhUG2unvRXA9tvDkgK9aP+81UlIucm1mkXG6mRRt4Z9E+sPo592EpCpv
	RJKTgIdogs4/jwSfZe0hXRJA2ivtLmIJ+NguswMNkh9WGbaRYH+NaAnFNueBFEJPA5Hs
	ZF5y+PWorFQoOCTHNXFvG+Avj23y4aX7gBK4R4SwzOOrHUFYI8UGd9clKwBlU8iawfaR
	7HlRdNteXH+//6GSVE4mG+s4lZ2yGDspaf2EaI4F4TUVBg4GLvF0BDdMvEJSrqP7yw5x
	YobuQDpqGO51nCTxEKfC+fkEzW6QqIpjZ84Om32S0OaRnLEL5dr3184FCoOYOlA59kVr
	R2PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	bh=0TS4qEKmw4BOwv+KpHsCK8QIkMFbVbLGctn5J+3azt8=;
	b=MzHcSAJgcmCDKCAtaQ7tS1rQsdPXIFx0VmFxvXwpOE2Pws0E7GedaIVmkkAmXlLs+d
	BUUT9UIZBS/TFgqCbkJpHkLbe32YkUCykZL7CBTcrKeKlWVsI0jVL898i9tTuFmDfA+O
	tBPuCKTOJ0QDzWYFuXdR57pYv3y9ndQJL17qZThEwxCZhFSuYP9SiyEuQ6XaEGUDWGKP
	42FSLgtz8bZ3P/xyHszg1u9OiJ837nLMqBlLq1vvbyzgaDfmzX1yJDOB7xlRPROXo6PQ
	AdKZHMhNu2bgo6jGf48Lhgs0EnxywNOHDgNtkOtN0NDmxds4NU3g06XzwngJBMe23BAa
	iS2Q==
X-Gm-Message-State: APjAAAVWV9K8tytLSPRrdP4vWUDxwUfSP5ZR8mNr5ONMIZr/U7UmEjw1
	t5YzbZNIlH3qjo0Ms9aiz1xK7rwj
X-Google-Smtp-Source: APXvYqz1+oydh5bQXcmeOB86Dy8JWmKvwXNUea3I/l/tzyVW1o7Hs/ZQKewreZp7q1KP90L0rdXgbg==
X-Received: by 2002:a9d:5d03:: with SMTP id b3mr9796065oti.268.1556971535928; 
	Sat, 04 May 2019 05:05:35 -0700 (PDT)
Received: from localhost.localdomain ([198.59.53.9])
	by smtp.gmail.com with ESMTPSA id
	s26sm1844978otk.24.2019.05.04.05.05.35
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 04 May 2019 05:05:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Sat,  4 May 2019 06:05:23 -0600
Message-Id: <20190504120528.6389-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190504120528.6389-1-pbonzini@redhat.com>
References: <20190504120528.6389-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: [Qemu-devel] [PATCH 5/9] coroutine: add host specific coroutine
 backend for 64-bit s390
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
Message-ID: <20190504120523.vV8KxpFZcc1EZX5DPNQaAYVLwMANCWUS5axC-3SVTaI@z>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/coroutine-asm.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/util/coroutine-asm.c b/util/coroutine-asm.c
index de68e98622..a9a80e9c71 100644
--- a/util/coroutine-asm.c
+++ b/util/coroutine-asm.c
@@ -41,7 +41,7 @@ typedef struct {
     void *sp;
 
     /*
-     * aarch64: instruction pointer
+     * aarch64, s390x: instruction pointer
      */
     void *scratch;
 
@@ -161,6 +161,40 @@ static void start_switch_fiber(void **fake_stack_save,
   (to)->scratch = (void *) coroutine_trampoline;                                      \
   (void) CO_SWITCH_RET(from, to, (uintptr_t) to);                                     \
 } while(0)
+
+#elif defined __s390x__
+#define CO_SWITCH_RET(from, to, action) ({                                            \
+    register uintptr_t action_ __asm__("r2") = action;                                \
+    register void *from_ __asm__("r1") = from;                                        \
+    register void *to_ __asm__("r3") = to;                                            \
+    register void *pc_ __asm__("r4") = to->scratch;                                   \
+    void *save_r13;                                                                   \
+    asm volatile(                                                                     \
+        "stg %%r13, %[SAVE_R13]\n"                                                    \
+        "stg %%r15, %[SP](%%r1)\n"       /* save source SP */                         \
+        "lg %%r15, %[SP](%%r3)\n"        /* load destination SP */                    \
+        "bras %%r3, 1f\n"                /* source PC will be after the BR */         \
+        "1: aghi %%r3, 12\n"             /* 4 */                                      \
+        "stg %%r3, %[SCRATCH](%%r1)\n"   /* 6 save switch-back PC */                  \
+        "br %%r4\n"                      /* 2 jump to destination PC */               \
+        "lg %%r13, %[SAVE_R13]\n"                                                     \
+        : "+r" (action_), "+r" (from_), "+r" (to_), "+r" (pc_),                       \
+          [SAVE_R13] "+m" (r13)                                                       \
+        : [SP] "i" (offsetof(CoroutineAsm, sp)),                                      \
+          [SCRATCH] "i" (offsetof(CoroutineAsm, scratch))                             \
+        : "r0", "r5", "r6", "r7", "r8", "r9", "r10", "r11", "r12", "r14",             \
+          "a2", "a3", "a4", "a5", "a6", "a7",                                         \
+          "a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15",                       \
+          "f0", "f1", "f2", "f3", "f4", "f5", "f6", "f7",                             \
+          "f8", "f9", "f10", "f11", "f12", "f13", "f14", "f15", "memory");            \
+    action_;                                                                          \
+})
+
+#define CO_SWITCH_NEW(from, to) do {                                                  \
+  (to)->scratch = (void *) coroutine_trampoline;                                      \
+  (to)->sp -= 160;                                                                    \
+  (void) CO_SWITCH_RET(from, to, (uintptr_t) to);                                     \
+} while(0)
 #else
 #error coroutine-asm.c not ported to this architecture.
 #endif
-- 
2.21.0



