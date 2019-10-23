Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9676CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 15:28:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F52A20650
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 15:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PI8SmEt0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F52A20650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNIYl-0005jU-9P
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 11:28:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35340)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iNI8v-0008Cl-OM
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:01:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iNI8r-0001HJ-Uy
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:01:45 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:34709)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iNI8r-00019T-Na
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:01:41 -0400
Received: by mail-qt1-x844.google.com with SMTP id e14so12965632qto.1
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 08:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LNnrsVkwlgJ6QoJB/sOp9/3FjmMcP/pJsCavmGVFX6A=;
 b=PI8SmEt0aWF4SMPYVp+5sC2i8RM3azhNXYGSc+CvtQ8YlR5iFc2AxLG0r4mM5pCgmy
 c5WNM9XNMFvTP6LfK69OIwvCqLYqlVcrFaE2k2xIak8XvzOFkcnQAvNIt2KkJlj+yP7q
 V4SMg2kudwbrWNcnK+TQEziGrSOntG92jqw6CgWPjTfPQehw366erv8H4ZBWrWc3t+SN
 Is27wco728zLE0P/jaBR+MLCvnxgydHRb1NzbnzokNAx/TcZvzRd5tsqwOSWJHhH214R
 HQlkhNrc9eaeNuL2XoNCe1v/hEfAftaXkdRzJH06lgvWGKLDTxdBpC9WtUW0+6AKmkbW
 3aLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LNnrsVkwlgJ6QoJB/sOp9/3FjmMcP/pJsCavmGVFX6A=;
 b=qbf6aCU++pMmirTLICLl8ZtaJMMnuDsDCygKCWiw4eWPxVZpuyoeaesukkRZQ0grOG
 LIunIkndEBy28jIGfIzd5hUB2hu3Wj0MHZ+llHG9P4Qu4mQEPysx2at3/ASC5E1Q/OQk
 IuqWDXEshtlPaNZBrurCUEUnfl7a9bpyRTqLb/3SB4kzicrVyMXkh2R0YPF09M14iqir
 4Vc79JtLKmnVNi5C7yhJTvhcWi1dduiDuS6hFiAdXNV2g4r9FagB4s4lPbYf0OAaWiZk
 f2i5kS1KeQvIOxU9PGl6gPbxBySlr3AHtEiuXsLrUSdXAovOlK/JSnkIA8+S0RfZTivS
 FYhA==
X-Gm-Message-State: APjAAAX1C41JkqqtzeE6ri4qxOqWxSd5FgPOB8sQNGPxsJ3nJCRoPEtD
 swa93mQ3fqkwJfV5C3Wt1qS/QZPu1So=
X-Google-Smtp-Source: APXvYqzfmMNJdYqK29hN/+0l7tBJjQJOeRsrax52S1jkYwx392S9hpJDlZXyjOQcWBG+8goJli8fsg==
X-Received: by 2002:ac8:40c5:: with SMTP id f5mr9979337qtm.344.1571842885143; 
 Wed, 23 Oct 2019 08:01:25 -0700 (PDT)
Received: from localhost.localdomain (198-4-20-64.static.cosmoweb.net.
 [64.20.4.198])
 by smtp.gmail.com with ESMTPSA id l189sm11030168qke.69.2019.10.23.08.01.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2019 08:01:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 17/24] target/arm: Rebuild hflags at MSR writes
Date: Wed, 23 Oct 2019 11:00:50 -0400
Message-Id: <20191023150057.25731-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191023150057.25731-1-richard.henderson@linaro.org>
References: <20191023150057.25731-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::844
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Continue setting, but not relying upon, env->hflags.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 13 +++++++++++--
 target/arm/translate.c     | 28 +++++++++++++++++++++++-----
 2 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 2d6cd09634..d4bebbe629 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1789,8 +1789,17 @@ static void handle_sys(DisasContext *s, uint32_t insn, bool isread,
     if ((tb_cflags(s->base.tb) & CF_USE_ICOUNT) && (ri->type & ARM_CP_IO)) {
         /* I/O operations must end the TB here (whether read or write) */
         s->base.is_jmp = DISAS_UPDATE;
-    } else if (!isread && !(ri->type & ARM_CP_SUPPRESS_TB_END)) {
-        /* We default to ending the TB on a coprocessor register write,
+    }
+    if (!isread && !(ri->type & ARM_CP_SUPPRESS_TB_END)) {
+        /*
+         * A write to any coprocessor regiser that ends a TB
+         * must rebuild the hflags for the next TB.
+         */
+        TCGv_i32 tcg_el = tcg_const_i32(s->current_el);
+        gen_helper_rebuild_hflags_a64(cpu_env, tcg_el);
+        tcg_temp_free_i32(tcg_el);
+        /*
+         * We default to ending the TB on a coprocessor register write,
          * but allow this to be suppressed by the register definition
          * (usually only necessary to work around guest bugs).
          */
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 96340520ee..46a0bf51c9 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -6890,6 +6890,8 @@ static int disas_coproc_insn(DisasContext *s, uint32_t insn)
     ri = get_arm_cp_reginfo(s->cp_regs,
             ENCODE_CP_REG(cpnum, is64, s->ns, crn, crm, opc1, opc2));
     if (ri) {
+        bool need_exit_tb;
+
         /* Check access permissions */
         if (!cp_access_ok(s->current_el, ri, isread)) {
             return 1;
@@ -7068,14 +7070,30 @@ static int disas_coproc_insn(DisasContext *s, uint32_t insn)
             }
         }
 
-        if ((tb_cflags(s->base.tb) & CF_USE_ICOUNT) && (ri->type & ARM_CP_IO)) {
-            /* I/O operations must end the TB here (whether read or write) */
-            gen_lookup_tb(s);
-        } else if (!isread && !(ri->type & ARM_CP_SUPPRESS_TB_END)) {
-            /* We default to ending the TB on a coprocessor register write,
+        /* I/O operations must end the TB here (whether read or write) */
+        need_exit_tb = ((tb_cflags(s->base.tb) & CF_USE_ICOUNT) &&
+                        (ri->type & ARM_CP_IO));
+
+        if (!isread && !(ri->type & ARM_CP_SUPPRESS_TB_END)) {
+            /*
+             * A write to any coprocessor regiser that ends a TB
+             * must rebuild the hflags for the next TB.
+             */
+            TCGv_i32 tcg_el = tcg_const_i32(s->current_el);
+            if (arm_dc_feature(s, ARM_FEATURE_M)) {
+                gen_helper_rebuild_hflags_m32(cpu_env, tcg_el);
+            } else {
+                gen_helper_rebuild_hflags_a32(cpu_env, tcg_el);
+            }
+            tcg_temp_free_i32(tcg_el);
+            /*
+             * We default to ending the TB on a coprocessor register write,
              * but allow this to be suppressed by the register definition
              * (usually only necessary to work around guest bugs).
              */
+            need_exit_tb = true;
+        }
+        if (need_exit_tb) {
             gen_lookup_tb(s);
         }
 
-- 
2.17.1


