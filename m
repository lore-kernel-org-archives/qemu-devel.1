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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5C5C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:18:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 875AE22D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 18:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sibHeTZe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 875AE22D6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0VBS-0005De-9p
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 14:18:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41121)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URS-0001OW-58
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1i0URQ-0007lg-BW
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:38 -0400
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44]:40394)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1i0URQ-0007lE-5d
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 13:30:36 -0400
Received: by mail-yw1-xc44.google.com with SMTP id z64so1236872ywe.7
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 10:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+uLJOL/RgAja9bJUYo0TBd45RJXP+ge2yD8CTS7XiW0=;
 b=sibHeTZeArQSl0BSqw/4+P1t+bv04UaCA6R5oG3l2yXVRVTXUHjPp4RUKfrLbJUcSj
 WreJZsXPu2d1A/vVbyYbKS/Khj0cCwU5cU1AlnxY2Yoguq+pXDB9aEGr6xkxcPxlpDSJ
 imh5z41W0E3AnT8HYxqCOfgQX6gSCPpcp3KPdihKsQNjzYDhnZ4Fx4VeJxj5TB5c5kha
 VNSRK8hEGccPBWaikaQp4Xq2dyX2yExpctucE361J+qtZoFJWYp9b9iuC33M2B9eIGSH
 S56YWNai62sLIxDBPeTtUluFep4GYpIVs9DSwGeSCz3d69JOYIAq9/aE4ilQI82nO7Ts
 /P5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+uLJOL/RgAja9bJUYo0TBd45RJXP+ge2yD8CTS7XiW0=;
 b=lOLH1qZbcDj7CA6st7Af1tDGG1yloIXQoKW/SwGrW2ImV04pP1tO4jbXuQ8MB3iUdy
 dklKUeOShZjGKX0LFjN/VnCnM33Bzun9bMfdcfNtr+os9pR1nKx0G5YMq7uWxjSkE4kD
 lCpMd0UYMkYAVhnUwHMn880mQVmqzSWpVvzwNs3VXoEFn0WSIvLZSz+0ZLI57ToewbcH
 /yPk5upY7oo73JGjbYtQXqK7xrv8KKAA2uitBjsTgTevbwoSvt3pyIIoKU2ckm8W7RRk
 nn9BpX9UdZsOi0RWRosFcOWD71UPfWT7A8G86IJFz35lbn0gqzB074Y58kHKy4JGqrRL
 cBkg==
X-Gm-Message-State: APjAAAWw8ca+JCA2fZ99ibV3aedmRw4KQOs3/d4zeXeKzyFx2lVdfCCz
 sLJg+ZMCf9KkJq1lgi+TbC0mG9lW
X-Google-Smtp-Source: APXvYqwbGkKCqkDDa8ztlsn/Zd3SJS1OFzi+p/u72LYxxpwkLcE3nouYjDuaUVcgq//7FV9rCqV6rw==
X-Received: by 2002:a81:494f:: with SMTP id w76mr23955219ywa.21.1566408635443; 
 Wed, 21 Aug 2019 10:30:35 -0700 (PDT)
Received: from localhost.localdomain ([2601:c0:c67f:e390::3])
 by smtp.gmail.com with ESMTPSA id l71sm2826167ywl.39.2019.08.21.10.30.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2019 10:30:34 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:29:11 -0400
Message-Id: <20190821172951.15333-36-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821172951.15333-1-jan.bobek@gmail.com>
References: <20190821172951.15333-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c44
Subject: [Qemu-devel] [RFC PATCH v4 35/75] target/i386: introduce
 instruction translator macros
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

Instruction "translators" are responsible for decoding and loading
instruction operands, calling the passed-in code generator, and
storing the operands back (if applicable). Once a translator returns,
the instruction has been translated to TCG ops, hence the name.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 272 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 272 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index eab36963c3..1c2502ff50 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -5562,6 +5562,262 @@ INSNOP_LDST(xmm, Mhq)
         gen_gvec_ ## gvec(arg1, arg2, arg3, arg4, ## __VA_ARGS__);      \
     }
 
+/*
+ * Instruction translators
+ */
+#define translate_insn(argc, ...)               \
+    glue(translate_insn, argc)(__VA_ARGS__)
+#define translate_insn0()                       \
+    translate_insn_0
+#define translate_insn1(opT1)                   \
+    translate_insn_1 ## opT1
+#define translate_insn2(opT1, opT2)             \
+    translate_insn_2 ## opT1 ## opT2
+#define translate_insn3(opT1, opT2, opT3)       \
+    translate_insn_3 ## opT1 ## opT2 ## opT3
+#define translate_insn4(opT1, opT2, opT3, opT4)         \
+    translate_insn_4 ## opT1 ## opT2 ## opT3 ## opT4
+#define translate_insn5(opT1, opT2, opT3, opT4, opT5)           \
+    translate_insn_5 ## opT1 ## opT2 ## opT3 ## opT4 ## opT5
+#define translate_group(grpname)                \
+    translate_group_ ## grpname
+
+static void translate_insn0()(
+    CPUX86State *env, DisasContext *s, int modrm,
+    CheckCpuidFeat feat, unsigned int argc_wr,
+    void (*gen_insn_fp)(CPUX86State *, DisasContext *))
+{
+    if (!check_cpuid(env, s, feat)) {
+        gen_illegal_opcode(s);
+        return;
+    }
+
+    (*gen_insn_fp)(env, s);
+}
+
+#define DEF_TRANSLATE_INSN1(opT1)                                       \
+    static void translate_insn1(opT1)(                                  \
+        CPUX86State *env, DisasContext *s, int modrm,                   \
+        CheckCpuidFeat feat, unsigned int argc_wr,                      \
+        void (*gen_insn1_fp)(CPUX86State *, DisasContext *,             \
+                             insnop_arg_t(opT1)))                       \
+    {                                                                   \
+        insnop_ctxt_t(opT1) ctxt1;                                      \
+                                                                        \
+        const bool is_write1 = (1 <= argc_wr);                          \
+                                                                        \
+        if (check_cpuid(env, s, feat)                                   \
+            && insnop_init(opT1)(&ctxt1, env, s, modrm, is_write1)) {   \
+                                                                        \
+            const insnop_arg_t(opT1) arg1 =                             \
+                insnop_prepare(opT1)(&ctxt1, env, s, modrm, is_write1); \
+                                                                        \
+            (*gen_insn1_fp)(env, s, arg1);                              \
+                                                                        \
+            insnop_finalize(opT1)(&ctxt1, env, s, modrm, is_write1, arg1); \
+        } else {                                                        \
+            gen_illegal_opcode(s);                                      \
+        }                                                               \
+    }
+
+#define DEF_TRANSLATE_INSN2(opT1, opT2)                                 \
+    static void translate_insn2(opT1, opT2)(                            \
+        CPUX86State *env, DisasContext *s, int modrm,                   \
+        CheckCpuidFeat feat, unsigned int argc_wr,                      \
+        void (*gen_insn2_fp)(CPUX86State *, DisasContext *,             \
+                             insnop_arg_t(opT1), insnop_arg_t(opT2)))   \
+    {                                                                   \
+        insnop_ctxt_t(opT1) ctxt1;                                      \
+        insnop_ctxt_t(opT2) ctxt2;                                      \
+                                                                        \
+        const bool is_write1 = (1 <= argc_wr);                          \
+        const bool is_write2 = (2 <= argc_wr);                          \
+                                                                        \
+        if (check_cpuid(env, s, feat)                                   \
+            && insnop_init(opT1)(&ctxt1, env, s, modrm, is_write1)      \
+            && insnop_init(opT2)(&ctxt2, env, s, modrm, is_write2)) {   \
+                                                                        \
+            const insnop_arg_t(opT1) arg1 =                             \
+                insnop_prepare(opT1)(&ctxt1, env, s, modrm, is_write1); \
+            const insnop_arg_t(opT2) arg2 =                             \
+                insnop_prepare(opT2)(&ctxt2, env, s, modrm, is_write2); \
+                                                                        \
+            (*gen_insn2_fp)(env, s, arg1, arg2);                        \
+                                                                        \
+            insnop_finalize(opT1)(&ctxt1, env, s, modrm, is_write1, arg1); \
+            insnop_finalize(opT2)(&ctxt2, env, s, modrm, is_write2, arg2); \
+        } else {                                                        \
+            gen_illegal_opcode(s);                                      \
+        }                                                               \
+    }
+
+#define DEF_TRANSLATE_INSN3(opT1, opT2, opT3)                           \
+    static void translate_insn3(opT1, opT2, opT3)(                      \
+        CPUX86State *env, DisasContext *s, int modrm,                   \
+        CheckCpuidFeat feat, unsigned int argc_wr,                      \
+        void (*gen_insn3_fp)(CPUX86State *, DisasContext *,             \
+                             insnop_arg_t(opT1), insnop_arg_t(opT2),    \
+                             insnop_arg_t(opT3)))                       \
+    {                                                                   \
+        insnop_ctxt_t(opT1) ctxt1;                                      \
+        insnop_ctxt_t(opT2) ctxt2;                                      \
+        insnop_ctxt_t(opT3) ctxt3;                                      \
+                                                                        \
+        const bool is_write1 = (1 <= argc_wr);                          \
+        const bool is_write2 = (2 <= argc_wr);                          \
+        const bool is_write3 = (3 <= argc_wr);                          \
+                                                                        \
+        if (check_cpuid(env, s, feat)                                   \
+            && insnop_init(opT1)(&ctxt1, env, s, modrm, is_write1)      \
+            && insnop_init(opT2)(&ctxt2, env, s, modrm, is_write2)      \
+            && insnop_init(opT3)(&ctxt3, env, s, modrm, is_write3)) {   \
+                                                                        \
+            const insnop_arg_t(opT1) arg1 =                             \
+                insnop_prepare(opT1)(&ctxt1, env, s, modrm, is_write1); \
+            const insnop_arg_t(opT2) arg2 =                             \
+                insnop_prepare(opT2)(&ctxt2, env, s, modrm, is_write2); \
+            const insnop_arg_t(opT3) arg3 =                             \
+                insnop_prepare(opT3)(&ctxt3, env, s, modrm, is_write3); \
+                                                                        \
+            (*gen_insn3_fp)(env, s, arg1, arg2, arg3);                  \
+                                                                        \
+            insnop_finalize(opT1)(&ctxt1, env, s, modrm, is_write1, arg1); \
+            insnop_finalize(opT2)(&ctxt2, env, s, modrm, is_write2, arg2); \
+            insnop_finalize(opT3)(&ctxt3, env, s, modrm, is_write3, arg3); \
+        } else {                                                        \
+            gen_illegal_opcode(s);                                      \
+        }                                                               \
+    }
+
+#define DEF_TRANSLATE_INSN4(opT1, opT2, opT3, opT4)                     \
+    static void translate_insn4(opT1, opT2, opT3, opT4)(                \
+        CPUX86State *env, DisasContext *s, int modrm,                   \
+        CheckCpuidFeat feat, unsigned int argc_wr,                      \
+        void (*gen_insn4_fp)(CPUX86State *, DisasContext *,             \
+                             insnop_arg_t(opT1), insnop_arg_t(opT2),    \
+                             insnop_arg_t(opT3), insnop_arg_t(opT4)))   \
+    {                                                                   \
+        insnop_ctxt_t(opT1) ctxt1;                                      \
+        insnop_ctxt_t(opT2) ctxt2;                                      \
+        insnop_ctxt_t(opT3) ctxt3;                                      \
+        insnop_ctxt_t(opT4) ctxt4;                                      \
+                                                                        \
+        const bool is_write1 = (1 <= argc_wr);                          \
+        const bool is_write2 = (2 <= argc_wr);                          \
+        const bool is_write3 = (3 <= argc_wr);                          \
+        const bool is_write4 = (4 <= argc_wr);                          \
+                                                                        \
+        if (check_cpuid(env, s, feat)                                   \
+            && insnop_init(opT1)(&ctxt1, env, s, modrm, is_write1)      \
+            && insnop_init(opT2)(&ctxt2, env, s, modrm, is_write2)      \
+            && insnop_init(opT3)(&ctxt3, env, s, modrm, is_write3)      \
+            && insnop_init(opT4)(&ctxt4, env, s, modrm, is_write4)) {   \
+                                                                        \
+            const insnop_arg_t(opT1) arg1 =                             \
+                insnop_prepare(opT1)(&ctxt1, env, s, modrm, is_write1); \
+            const insnop_arg_t(opT2) arg2 =                             \
+                insnop_prepare(opT2)(&ctxt2, env, s, modrm, is_write2); \
+            const insnop_arg_t(opT3) arg3 =                             \
+                insnop_prepare(opT3)(&ctxt3, env, s, modrm, is_write3); \
+            const insnop_arg_t(opT4) arg4 =                             \
+                insnop_prepare(opT4)(&ctxt4, env, s, modrm, is_write4); \
+                                                                        \
+            (*gen_insn4_fp)(env, s, arg1, arg2, arg3, arg4);            \
+                                                                        \
+            insnop_finalize(opT1)(&ctxt1, env, s, modrm, is_write1, arg1); \
+            insnop_finalize(opT2)(&ctxt2, env, s, modrm, is_write2, arg2); \
+            insnop_finalize(opT3)(&ctxt3, env, s, modrm, is_write3, arg3); \
+            insnop_finalize(opT4)(&ctxt4, env, s, modrm, is_write4, arg4); \
+        } else {                                                        \
+            gen_illegal_opcode(s);                                      \
+        }                                                               \
+    }
+
+#define DEF_TRANSLATE_INSN5(opT1, opT2, opT3, opT4, opT5)               \
+    static void translate_insn5(opT1, opT2, opT3, opT4, opT5)(          \
+        CPUX86State *env, DisasContext *s, int modrm,                   \
+        CheckCpuidFeat feat, unsigned int argc_wr,                      \
+        void (*gen_insn5_fp)(CPUX86State *, DisasContext *,             \
+                             insnop_arg_t(opT1), insnop_arg_t(opT2),    \
+                             insnop_arg_t(opT3), insnop_arg_t(opT4),    \
+                             insnop_arg_t(opT5)))                       \
+    {                                                                   \
+        insnop_ctxt_t(opT1) ctxt1;                                      \
+        insnop_ctxt_t(opT2) ctxt2;                                      \
+        insnop_ctxt_t(opT3) ctxt3;                                      \
+        insnop_ctxt_t(opT4) ctxt4;                                      \
+        insnop_ctxt_t(opT5) ctxt5;                                      \
+                                                                        \
+        const bool is_write1 = (1 <= argc_wr);                          \
+        const bool is_write2 = (2 <= argc_wr);                          \
+        const bool is_write3 = (3 <= argc_wr);                          \
+        const bool is_write4 = (4 <= argc_wr);                          \
+        const bool is_write5 = (5 <= argc_wr);                          \
+                                                                        \
+        if (check_cpuid(env, s, feat)                                   \
+            && insnop_init(opT1)(&ctxt1, env, s, modrm, is_write1)      \
+            && insnop_init(opT2)(&ctxt2, env, s, modrm, is_write2)      \
+            && insnop_init(opT3)(&ctxt3, env, s, modrm, is_write3)      \
+            && insnop_init(opT4)(&ctxt4, env, s, modrm, is_write4)      \
+            && insnop_init(opT5)(&ctxt5, env, s, modrm, is_write5)) {   \
+                                                                        \
+            const insnop_arg_t(opT1) arg1 =                             \
+                insnop_prepare(opT1)(&ctxt1, env, s, modrm, is_write1); \
+            const insnop_arg_t(opT2) arg2 =                             \
+                insnop_prepare(opT2)(&ctxt2, env, s, modrm, is_write2); \
+            const insnop_arg_t(opT3) arg3 =                             \
+                insnop_prepare(opT3)(&ctxt3, env, s, modrm, is_write3); \
+            const insnop_arg_t(opT4) arg4 =                             \
+                insnop_prepare(opT4)(&ctxt4, env, s, modrm, is_write4); \
+            const insnop_arg_t(opT5) arg5 =                             \
+                insnop_prepare(opT5)(&ctxt5, env, s, modrm, is_write5); \
+                                                                        \
+            (*gen_insn5_fp)(env, s, arg1, arg2, arg3, arg4, arg5);      \
+                                                                        \
+            insnop_finalize(opT1)(&ctxt1, env, s, modrm, is_write1, arg1); \
+            insnop_finalize(opT2)(&ctxt2, env, s, modrm, is_write2, arg2); \
+            insnop_finalize(opT3)(&ctxt3, env, s, modrm, is_write3, arg3); \
+            insnop_finalize(opT4)(&ctxt4, env, s, modrm, is_write4, arg4); \
+            insnop_finalize(opT5)(&ctxt5, env, s, modrm, is_write5, arg5); \
+        } else {                                                        \
+            gen_illegal_opcode(s);                                      \
+        }                                                               \
+    }
+
+#define OPCODE_GRP_BEGIN(grpname)                                       \
+    static void translate_group(grpname)(                               \
+        CPUX86State *env, DisasContext *s, int modrm)                   \
+    {                                                                   \
+        bool ret;                                                       \
+        insnop_ctxt_t(modrm_reg) regctxt;                               \
+                                                                        \
+        ret = insnop_init(modrm_reg)(&regctxt, env, s, modrm, 0);       \
+        if (ret) {                                                      \
+            const insnop_arg_t(modrm_reg) reg =                         \
+                insnop_prepare(modrm_reg)(&regctxt, env, s, modrm, 0);  \
+                                                                        \
+            switch (reg & 7) {
+#define OPCODE_GRPMEMB(grpname, mnem, opcode, feat, fmt, ...)           \
+            case opcode:                                                \
+                translate_insn(FMT_ARGC(fmt), ## __VA_ARGS__)(          \
+                    env, s, modrm, CHECK_CPUID_ ## feat, FMT_ARGC_WR(fmt), \
+                    gen_insn(mnem, FMT_ARGC(fmt), ## __VA_ARGS__));     \
+                break;
+#define OPCODE_GRP_END(grpname)                                         \
+            default:                                                    \
+                ret = false;                                            \
+                break;                                                  \
+            }                                                           \
+                                                                        \
+            insnop_finalize(modrm_reg)(&regctxt, env, s, modrm, 0, reg); \
+        }                                                               \
+                                                                        \
+        if (!ret) {                                                     \
+            gen_illegal_opcode(s);                                      \
+        }                                                               \
+    }
+#include "sse-opcode.inc.h"
+
 static void gen_sse_ng(CPUX86State *env, DisasContext *s, int b)
 {
     enum {
@@ -5642,6 +5898,22 @@ static void gen_sse_ng(CPUX86State *env, DisasContext *s, int b)
             op = x86_ldub_code(env, s);
         } break;
 
+#define LEG(p, m, w, op)    CASES(op, 3, W, w, M, m, P, p)
+#define VEX(l, p, m, w, op) CASES(op, 4, W, w, M, m, P, p, VEX_L, l)
+#define OPCODE(mnem, cases, feat, fmt, ...)                             \
+        cases {                                                         \
+            const int modrm = 0 < FMT_ARGC(fmt) ? x86_ldub_code(env, s) : -1; \
+            translate_insn(FMT_ARGC(fmt), ## __VA_ARGS__)(              \
+                env, s, modrm, CHECK_CPUID_ ## feat, FMT_ARGC_WR(fmt),  \
+                gen_insn(mnem, FMT_ARGC(fmt), ## __VA_ARGS__));         \
+        } return;
+#define OPCODE_GRP(grpname, cases)                      \
+        cases {                                         \
+            const int modrm = x86_ldub_code(env, s);    \
+            translate_group(grpname)(env, s, modrm);    \
+        } return;
+#include "sse-opcode.inc.h"
+
         default: {
             if (m == M_0F38 || m == M_0F3A) {
                 /* rewind the advance_pc() x86_ldub_code() did */
-- 
2.20.1


