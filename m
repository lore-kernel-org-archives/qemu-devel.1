Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750D6C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:05:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44125214DA
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3Ek/Dbc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44125214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Uzb-0005cw-N0
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 14:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40919)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URC-00011o-Pu
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URB-0007Kf-K5
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:22 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:40494)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1i0URB-0007Jj-FA
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:21 -0400
Received: by mail-yb1-xb42.google.com with SMTP id g7so1338231ybd.7
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=i/Nisqp4PZPuP7Q0R+kpy6leP61SyzgXDzHcbhyn0mU=;
 b=M3Ek/DbcHLz4YcNRyUpcsXOgonQWD8kWJcjNfLsgiNPTZXhyhhmZjcDfZwxVRTWrWO
 BSFuYFAGZNDWoyHmE0w+xodZdjfS55GpTwMFjbZ628m4dHEk72j4t+kVYnH++ZyEDSSz
 GfziXcQdctFMUTHqtgb8UoGtw8y54rRhJ4Mf3ThR1W8ggamj1+5paamHmubqMoG31Lrt
 2MOFVvD7YKNo1BVIhKNRiJAIYS/IiYTT/8YfJZ0EYfoPNQmbz80uncKFylj3qWG5h/Ut
 6XOa75EKDehKpVACQybI+v9iYf6Y4cX/KIwNLwuGWLhDxt95irX3EQEgCCoEIkEMc2w4
 yIDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=i/Nisqp4PZPuP7Q0R+kpy6leP61SyzgXDzHcbhyn0mU=;
 b=XJQxP9GHXheC2emoHJTG1f+Kgsm3wPegJwwSvgYvb0gW1pLU4rfFnvRV2GL0YQaMqP
 SQNx7shuBBBT3jrRbiLjG2eXH6vzErM45zseVuo2f6Llb8aw3eLflARoHS/XCLZxHheP
 GE7pBwsTX+Fy28el8OGFJdyYF5SRBWoCnU9s6gXT4q5mFN4+d/3bVIbniWyh/Q+rlyhF
 EPAt07QivdQkyjQiaKA0mXB7N1v9IGPQS1u0yEh3xbnJedm6Isg8wAbQQLh0fokxiF44
 ofmqnqDDLOcFPxQjEFzbdsS5ebavmGTEBDSwNkqybMHT57XS8a/W6ayknp+fGGzbcFnb
 HVRA==
X-Gm-Message-State: APjAAAXnwg9iZf+B42tEcZq1xGgB5XsN8lNF4wwBM82xb4PoZcVjKi7c
 vI23feyP3iwk8WO+Fcnwas9UFhmM
X-Google-Smtp-Source: APXvYqyWABG0NkqDKp0p3deEUjyuT7JDWJi4fkjslISxLj0UAY9jObhYg5iBpcqvqfUj4GQXIDpCXg==
X-Received: by 2002:a5b:612:: with SMTP id d18mr3124392ybq.475.1566408620847; 
 Wed, 21 Aug 2019 10:30:20 -0700 (PDT)
Received: from localhost.localdomain ([2601:c0:c67f:e390::3])
 by smtp.gmail.com with ESMTPSA id l71sm2826167ywl.39.2019.08.21.10.30.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2019 10:30:20 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:28:56 -0400
Message-Id: <20190821172951.15333-21-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821172951.15333-1-jan.bobek@gmail.com>
References: <20190821172951.15333-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b42
Subject: [Qemu-devel] [RFC PATCH v4 20/75] target/i386: introduce generic
 load-store operand
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
Cc: Jan Bobek <jan.bobek@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This operand attempts to capture the "indirect" or "memory" operand in
a generic way. It significatly reduces the amount code that needs to
be written in order to read operands from memory to temporary storage
and write them back.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 57 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 68c6b7d16b..1be6176934 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4670,6 +4670,63 @@ static bool check_cpuid(CPUX86State *env, DisasContext *s, CheckCpuidFeat feat)
                                  env, s, modrm, is_write, arg));        \
     }
 
+/*
+ * Generic load-store operand
+ */
+#define insnop_ldst(opTarg, opTptr)             \
+    insnop_ldst_ ## opTarg ## opTptr
+
+#define INSNOP_LDST(opTarg, opTptr)                                     \
+    static void insnop_ldst(opTarg, opTptr)(CPUX86State *env,           \
+                                            DisasContext *s,            \
+                                            bool is_write,              \
+                                            insnop_arg_t(opTarg) arg,   \
+                                            insnop_arg_t(opTptr) ptr)
+
+#define DEF_INSNOP_LDST(opT, opTarg, opTptr)                            \
+    typedef insnop_arg_t(opTarg) insnop_arg_t(opT);                     \
+    typedef struct {                                                    \
+        insnop_ctxt_t(opTarg) arg_ctxt;                                 \
+        insnop_ctxt_t(opTptr) ptr_ctxt;                                 \
+        insnop_arg_t(opTptr) ptr;                                       \
+    } insnop_ctxt_t(opT);                                               \
+                                                                        \
+    /* forward declaration */                                           \
+    INSNOP_LDST(opTarg, opTptr);                                        \
+                                                                        \
+    INSNOP_INIT(opT)                                                    \
+    {                                                                   \
+        return insnop_init(opTarg)(&ctxt->arg_ctxt,                     \
+                                   env, s, modrm, is_write)             \
+            && insnop_init(opTptr)(&ctxt->ptr_ctxt,                     \
+                                   env, s, modrm, is_write);            \
+    }                                                                   \
+    INSNOP_PREPARE(opT)                                                 \
+    {                                                                   \
+        const insnop_arg_t(opTarg) arg =                                \
+            insnop_prepare(opTarg)(&ctxt->arg_ctxt,                     \
+                                   env, s, modrm, is_write);            \
+        ctxt->ptr =                                                     \
+            insnop_prepare(opTptr)(&ctxt->ptr_ctxt,                     \
+                                   env, s, modrm, is_write);            \
+        if (!is_write) {                                                \
+            insnop_ldst(opTarg, opTptr)(env, s, is_write,               \
+                                        arg, ctxt->ptr);                \
+        }                                                               \
+        return arg;                                                     \
+    }                                                                   \
+    INSNOP_FINALIZE(opT)                                                \
+    {                                                                   \
+        if (is_write) {                                                 \
+            insnop_ldst(opTarg, opTptr)(env, s, is_write,               \
+                                        arg, ctxt->ptr);                \
+        }                                                               \
+        insnop_finalize(opTptr)(&ctxt->ptr_ctxt,                        \
+                                env, s, modrm, is_write, ctxt->ptr);    \
+        insnop_finalize(opTarg)(&ctxt->arg_ctxt,                        \
+                                env, s, modrm, is_write, arg);          \
+    }
+
 static void gen_sse_ng(CPUX86State *env, DisasContext *s, int b)
 {
     enum {
-- 
2.20.1


