Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E201C433FF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:41:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA011208C2
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KB6CSEk4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA011208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hy5hK-0001tn-Lt
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 22:41:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46980)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5De-0006Js-Cy
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hy5Dd-0000Eo-0E
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:26 -0400
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44]:34555)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hy5Db-0000Cj-Oy
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:10:24 -0400
Received: by mail-yw1-xc44.google.com with SMTP id n126so305419ywf.1
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 19:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZlioH6hGMavN5lo40XNXN+rXqiQDdeuysLOdHqsy6o8=;
 b=KB6CSEk4KP/brjj/dgygHAM2Z3Uu8qhIK4Mbh0chqEYG396fFw4Mox3hK5C5lDXlDK
 6dBvxnK9d/0A7cH1tCemixy27gT8gMBRLeqzujCOo1SS/so9YsA2HiSP3ank/dq7LFD2
 PJc9YQl0gmFxItfkR+R7kDjyWUxgvyErrgbhT0sCr6VoUdbAGuZ143chP+NcX2MRGwLu
 9g33yH8qI/rBYFK1oahspUP5K1P6Ze6v1TcNbVWgmOEifY3llV/gxRuZK9wdhGYJjtEv
 /rNLB/RiofiuMLwuRNC+1PqrUC2C8L6GYk2gPDplpPtUA6ST39uocW2ZpbOgENBK2ZsF
 n2KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZlioH6hGMavN5lo40XNXN+rXqiQDdeuysLOdHqsy6o8=;
 b=FbJjQyWwQ1wxCq9ju7qRSWfJoqiDsD341iKFzTSTcf7xObBvqmyeLGFRnlVmDOQQo3
 IhuOT9Yj0q2OjmTHjtuqg4IKSVlxYPqkycNx4oNIsQlA9y59ar6fERcjUBGuKGLCnDJi
 dHk1PF4076nl0JwTXryJXH7e3GU5fcKCX4+XXSusc3jcbl1QTdB2L5bc0pfTyCMOO9Nc
 f7+iMnBfj2xxlGopGcVj8xAjOKLjsyGw3r7h8waVVnq9Amc5a6oQpqBRemunMJrWg6YW
 8Dak/dUyvoDlWdEHcfi4/DDHa+PNHN1OVidHY2PUEcTseqDofJBJ4/2r8giJfO2v015x
 yO2A==
X-Gm-Message-State: APjAAAUvsauB4zBmcf9RJMn0BC14QVtrPEaTtq6d3spURI6nZwi7SDfs
 4eIxDhH6dduYHajiw0rvwbh3Wav1
X-Google-Smtp-Source: APXvYqy8sMIvMllomffAb1Y8laIpYFpzj/uqzdU/DgMb4m1zGDtQbQUpsV9wCw5R/Gc8q/t88mr2yw==
X-Received: by 2002:a0d:d596:: with SMTP id x144mr1546696ywd.69.1565835023095; 
 Wed, 14 Aug 2019 19:10:23 -0700 (PDT)
Received: from dionysus.attlocal.net ([2601:c0:c67f:e390:8a9a:e33f:caf8:f018])
 by smtp.gmail.com with ESMTPSA id
 j3sm374882ywk.21.2019.08.14.19.10.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2019 19:10:22 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 14 Aug 2019 22:09:13 -0400
Message-Id: <20190815020928.9679-32-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190815020928.9679-1-jan.bobek@gmail.com>
References: <20190815020928.9679-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c44
Subject: [Qemu-devel] [RFC PATCH v3 31/46] target/i386: introduce
 helper-based code generator macros
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

Code generators defined using these macros rely on a helper function
(as emitted by gen_helper_*).

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/translate.c | 106 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index b5f609e147..b28d651b82 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -5245,6 +5245,112 @@ INSNOP_LDST(xmm_t0, Mhq)
         insnop_arg_t(opT1) arg1, insnop_arg_t(opT2) arg2,       \
         insnop_arg_t(opT3) arg3, insnop_arg_t(opT4) arg4)
 
+#define DEF_GEN_INSN0_HELPER(mnem, helper)      \
+    GEN_INSN0(mnem)                             \
+    {                                           \
+        gen_helper_ ## helper(cpu_env);         \
+    }
+
+#define DEF_GEN_INSN2_HELPER_EPD(mnem, helper, opT1, opT2)      \
+    GEN_INSN2(mnem, opT1, opT2)                                 \
+    {                                                           \
+        const TCGv_ptr arg1_ptr = tcg_temp_new_ptr();           \
+                                                                \
+        tcg_gen_addi_ptr(arg1_ptr, cpu_env, arg1);              \
+        gen_helper_ ## helper(cpu_env, arg1_ptr, arg2);         \
+                                                                \
+        tcg_temp_free_ptr(arg1_ptr);                            \
+    }
+#define DEF_GEN_INSN2_HELPER_DEP(mnem, helper, opT1, opT2)      \
+    GEN_INSN2(mnem, opT1, opT2)                                 \
+    {                                                           \
+        const TCGv_ptr arg2_ptr = tcg_temp_new_ptr();           \
+                                                                \
+        tcg_gen_addi_ptr(arg2_ptr, cpu_env, arg2);              \
+        gen_helper_ ## helper(arg1, cpu_env, arg2_ptr);         \
+                                                                \
+        tcg_temp_free_ptr(arg2_ptr);                            \
+    }
+#ifdef TARGET_X86_64
+#define DEF_GEN_INSN2_HELPER_EPQ(mnem, helper, opT1, opT2)      \
+    DEF_GEN_INSN2_HELPER_EPD(mnem, helper, opT1, opT2)
+#define DEF_GEN_INSN2_HELPER_QEP(mnem, helper, opT1, opT2)      \
+    DEF_GEN_INSN2_HELPER_DEP(mnem, helper, opT1, opT2)
+#else /* !TARGET_X86_64 */
+#define DEF_GEN_INSN2_HELPER_EPQ(mnem, helper, opT1, opT2)      \
+    GEN_INSN2(mnem, opT1, opT2)                                 \
+    {                                                           \
+        g_assert_not_reached();                                 \
+    }
+#define DEF_GEN_INSN2_HELPER_QEP(mnem, helper, opT1, opT2)      \
+    GEN_INSN2(mnem, opT1, opT2)                                 \
+    {                                                           \
+        g_assert_not_reached();                                 \
+    }
+#endif /* !TARGET_X86_64 */
+#define DEF_GEN_INSN2_HELPER_EPP(mnem, helper, opT1, opT2)      \
+    GEN_INSN2(mnem, opT1, opT2)                                 \
+    {                                                           \
+        const TCGv_ptr arg1_ptr = tcg_temp_new_ptr();           \
+        const TCGv_ptr arg2_ptr = tcg_temp_new_ptr();           \
+                                                                \
+        tcg_gen_addi_ptr(arg1_ptr, cpu_env, arg1);              \
+        tcg_gen_addi_ptr(arg2_ptr, cpu_env, arg2);              \
+        gen_helper_ ## helper(cpu_env, arg1_ptr, arg2_ptr);     \
+                                                                \
+        tcg_temp_free_ptr(arg1_ptr);                            \
+        tcg_temp_free_ptr(arg2_ptr);                            \
+    }
+
+#define DEF_GEN_INSN3_HELPER_EPP(mnem, helper, opT1, opT2, opT3)        \
+    GEN_INSN3(mnem, opT1, opT2, opT3)                                   \
+    {                                                                   \
+        const TCGv_ptr arg1_ptr = tcg_temp_new_ptr();                   \
+        const TCGv_ptr arg3_ptr = tcg_temp_new_ptr();                   \
+                                                                        \
+        assert(arg1 == arg2);                                           \
+        tcg_gen_addi_ptr(arg1_ptr, cpu_env, arg1);                      \
+        tcg_gen_addi_ptr(arg3_ptr, cpu_env, arg3);                      \
+        gen_helper_ ## helper(cpu_env, arg1_ptr, arg3_ptr);             \
+                                                                        \
+        tcg_temp_free_ptr(arg1_ptr);                                    \
+        tcg_temp_free_ptr(arg3_ptr);                                    \
+    }
+#define DEF_GEN_INSN3_HELPER_PPI(mnem, helper, opT1, opT2, opT3)        \
+    GEN_INSN3(mnem, opT1, opT2, opT3)                                   \
+    {                                                                   \
+        const TCGv_ptr arg1_ptr = tcg_temp_new_ptr();                   \
+        const TCGv_ptr arg2_ptr = tcg_temp_new_ptr();                   \
+        const TCGv_i32 arg3_r32 = tcg_temp_new_i32();                   \
+                                                                        \
+        tcg_gen_addi_ptr(arg1_ptr, cpu_env, arg1);                      \
+        tcg_gen_addi_ptr(arg2_ptr, cpu_env, arg2);                      \
+        tcg_gen_movi_i32(arg3_r32, arg3);                               \
+        gen_helper_ ## helper(arg1_ptr, arg2_ptr, arg3_r32);            \
+                                                                        \
+        tcg_temp_free_ptr(arg1_ptr);                                    \
+        tcg_temp_free_ptr(arg2_ptr);                                    \
+        tcg_temp_free_i32(arg3_r32);                                    \
+    }
+
+#define DEF_GEN_INSN4_HELPER_PPI(mnem, helper, opT1, opT2, opT3, opT4)  \
+    GEN_INSN4(mnem, opT1, opT2, opT3, opT4)                             \
+    {                                                                   \
+        const TCGv_ptr arg1_ptr = tcg_temp_new_ptr();                   \
+        const TCGv_ptr arg3_ptr = tcg_temp_new_ptr();                   \
+        const TCGv_i32 arg4_r32 = tcg_temp_new_i32();                   \
+                                                                        \
+        assert(arg1 == arg2);                                           \
+        tcg_gen_addi_ptr(arg1_ptr, cpu_env, arg1);                      \
+        tcg_gen_addi_ptr(arg3_ptr, cpu_env, arg3);                      \
+        tcg_gen_movi_i32(arg4_r32, arg4);                               \
+        gen_helper_ ## helper(arg1_ptr, arg3_ptr, arg4_r32);            \
+                                                                        \
+        tcg_temp_free_ptr(arg1_ptr);                                    \
+        tcg_temp_free_ptr(arg3_ptr);                                    \
+        tcg_temp_free_i32(arg4_r32);                                    \
+    }
+
 static void gen_sse_ng(CPUX86State *env, DisasContext *s, int b)
 {
     enum {
-- 
2.20.1


