Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F75DC388F7
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:38:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 148C220729
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XbfKkVLa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 148C220729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kasaC-0001DT-Vl
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 22:38:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kasRW-0004cy-K4
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 22:29:38 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d]:37432)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kasRU-0006v4-Lw
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 22:29:38 -0500
Received: by mail-pf1-x42d.google.com with SMTP id 13so52227pfy.4
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 19:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kmX00pdaVuC+SHXGXI/iAqpTaWv1k3LGabjYAKxqLXM=;
 b=XbfKkVLaa+IAQqdBtN2XUCkLzdXNr01ySCVVkwO/shkGiqT25WpNBGCEMdwxo3fGLa
 6wgzsRCcGYeRDGzXK3y4eT8EWjxoeS1v1C4qhSqWV2K3UqNZ0eoPe2RHhg98S+jOF5LL
 PYpk5oWzYenqVx0xVelAiXZNSs3vbM7iii4DWIpqJktn2j9Tk1VsVX5yjpym71Gf4acM
 Ir1p5MSKbSVQLA2zmiN+NhZy7WsH6qiR/Fp8jueu3DRLvdUhM1VxH5Fekm8hkby7SnHc
 ttIpYvOb4rTXywlCVKlN7CI/CKl+Lz+uMJX/j09qc1Ad5+vtUNBDPPrtEU/SFEFqeTqO
 KZeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kmX00pdaVuC+SHXGXI/iAqpTaWv1k3LGabjYAKxqLXM=;
 b=Mh9NfWfutaEfzWly6Y4O2kOehqMJzE1RqF0dbguoTm7FcztPQyJoA+dckWvZ4ysmjC
 FhA+sWRhhb8+0OEI9Z9rOchs3UpvhSXUpMYyY7xAOqwCZZkOg9pVGYE9EVSQecacfnxJ
 i6vxZSj+HWx+4jNov2qjG/YKKgzIYM2oIMpFh817jeb/PnUoEN3+mgYGu5T2KOmgD3wt
 jve/zbXa5uDL3YCJXvNFsRncro54lx3M+YbPW8lMNyaCFzsxHNCFsrFzB0jBN4wBWXro
 M/CkdJDl0uyp1PoHYH3UysqK2BeFSK4R6Ku4HyxiuPzq71PrdhvG/0f1QE2K+wU9x1Gf
 JIbg==
X-Gm-Message-State: AOAM530GzP5HoJSISW8yMt8zeBgh2C7FlBWMG3Qw42382Djxfgz3rwY6
 GApodgQzjUYNZTDaFoBNBtOpqsNCBEJ0Rw==
X-Google-Smtp-Source: ABdhPJxwQOhRBeBZcIbB19oHb1A8H/Mdkh4Zqd70ACLLbbvWSshHthZqRbMEX7zoKy4SsBUTReosqQ==
X-Received: by 2002:a05:6a00:8ca:b029:15d:7af3:8360 with SMTP id
 s10-20020a056a0008cab029015d7af38360mr12261pfu.12.1604633374845; 
 Thu, 05 Nov 2020 19:29:34 -0800 (PST)
Received: from localhost.localdomain (76-14-210-194.or.wavecable.com.
 [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id i10sm40773pfd.60.2020.11.05.19.29.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 19:29:34 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 09/41] tcg: Adjust tcg_register_jit for const
Date: Thu,  5 Nov 2020 19:28:49 -0800
Message-Id: <20201106032921.600200-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106032921.600200-1-richard.henderson@linaro.org>
References: <20201106032921.600200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: j@getutm.app
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We must change all targets at once, since all must match
the declaration in tcg.c.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h            |  2 +-
 tcg/tcg.c                    | 10 +++++-----
 tcg/aarch64/tcg-target.c.inc |  2 +-
 tcg/arm/tcg-target.c.inc     |  2 +-
 tcg/i386/tcg-target.c.inc    |  2 +-
 tcg/mips/tcg-target.c.inc    |  2 +-
 tcg/ppc/tcg-target.c.inc     |  2 +-
 tcg/riscv/tcg-target.c.inc   |  2 +-
 tcg/s390/tcg-target.c.inc    |  2 +-
 tcg/sparc/tcg-target.c.inc   |  2 +-
 10 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index b2ba16ea8c..67d57695c2 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -1250,7 +1250,7 @@ typedef uintptr_t tcg_prologue_fn(CPUArchState *env, const void *tb_ptr);
 extern tcg_prologue_fn *tcg_qemu_tb_exec;
 #endif
 
-void tcg_register_jit(void *buf, size_t buf_size);
+void tcg_register_jit(const void *buf, size_t buf_size);
 
 #if TCG_TARGET_MAYBE_vec
 /* Return zero if the tuple (opc, type, vece) is unsupportable;
diff --git a/tcg/tcg.c b/tcg/tcg.c
index e5d2208e88..07a4bd2c57 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -96,7 +96,7 @@ typedef struct QEMU_PACKED {
     DebugFrameFDEHeader fde;
 } DebugFrameHeader;
 
-static void tcg_register_jit_int(void *buf, size_t size,
+static void tcg_register_jit_int(const void *buf, size_t size,
                                  const void *debug_frame,
                                  size_t debug_frame_size)
     __attribute__((unused));
@@ -1134,7 +1134,7 @@ void tcg_prologue_init(TCGContext *s)
     total_size -= prologue_size;
     s->code_gen_buffer_size = total_size;
 
-    tcg_register_jit(s->code_gen_buffer, total_size);
+    tcg_register_jit(tcg_splitwx_to_rx(s->code_gen_buffer), total_size);
 
 #ifdef DEBUG_DISAS
     if (qemu_loglevel_mask(CPU_LOG_TB_OUT_ASM)) {
@@ -4502,7 +4502,7 @@ static int find_string(const char *strtab, const char *str)
     }
 }
 
-static void tcg_register_jit_int(void *buf_ptr, size_t buf_size,
+static void tcg_register_jit_int(const void *buf_ptr, size_t buf_size,
                                  const void *debug_frame,
                                  size_t debug_frame_size)
 {
@@ -4704,13 +4704,13 @@ static void tcg_register_jit_int(void *buf_ptr, size_t buf_size,
 /* No support for the feature.  Provide the entry point expected by exec.c,
    and implement the internal function we declared earlier.  */
 
-static void tcg_register_jit_int(void *buf, size_t size,
+static void tcg_register_jit_int(const void *buf, size_t size,
                                  const void *debug_frame,
                                  size_t debug_frame_size)
 {
 }
 
-void tcg_register_jit(void *buf, size_t buf_size)
+void tcg_register_jit(const void *buf, size_t buf_size)
 {
 }
 #endif /* ELF_HOST_MACHINE */
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 6d8152c468..9ace859db3 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2964,7 +2964,7 @@ static const DebugFrame debug_frame = {
     }
 };
 
-void tcg_register_jit(void *buf, size_t buf_size)
+void tcg_register_jit(const void *buf, size_t buf_size)
 {
     tcg_register_jit_int(buf, buf_size, &debug_frame, sizeof(debug_frame));
 }
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index a197e6bc45..9b9400f164 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -2353,7 +2353,7 @@ static const DebugFrame debug_frame = {
     }
 };
 
-void tcg_register_jit(void *buf, size_t buf_size)
+void tcg_register_jit(const void *buf, size_t buf_size)
 {
     tcg_register_jit_int(buf, buf_size, &debug_frame, sizeof(debug_frame));
 }
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 0ac1ef3d82..7f74c77d7f 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -3998,7 +3998,7 @@ static const DebugFrame debug_frame = {
 #endif
 
 #if defined(ELF_HOST_MACHINE)
-void tcg_register_jit(void *buf, size_t buf_size)
+void tcg_register_jit(const void *buf, size_t buf_size)
 {
     tcg_register_jit_int(buf, buf_size, &debug_frame, sizeof(debug_frame));
 }
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 6d2c369a85..e9c8c24741 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -2703,7 +2703,7 @@ static const DebugFrame debug_frame = {
     }
 };
 
-void tcg_register_jit(void *buf, size_t buf_size)
+void tcg_register_jit(const void *buf, size_t buf_size)
 {
     tcg_register_jit_int(buf, buf_size, &debug_frame, sizeof(debug_frame));
 }
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 36129b976f..ff667b1531 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -3847,7 +3847,7 @@ static DebugFrame debug_frame = {
     }
 };
 
-void tcg_register_jit(void *buf, size_t buf_size)
+void tcg_register_jit(const void *buf, size_t buf_size)
 {
     uint8_t *p = &debug_frame.fde_reg_ofs[3];
     int i;
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 4416a93e1f..025e3cd0bb 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -1907,7 +1907,7 @@ static const DebugFrame debug_frame = {
     }
 };
 
-void tcg_register_jit(void *buf, size_t buf_size)
+void tcg_register_jit(const void *buf, size_t buf_size)
 {
     tcg_register_jit_int(buf, buf_size, &debug_frame, sizeof(debug_frame));
 }
diff --git a/tcg/s390/tcg-target.c.inc b/tcg/s390/tcg-target.c.inc
index 37f4dc4cfd..1444914428 100644
--- a/tcg/s390/tcg-target.c.inc
+++ b/tcg/s390/tcg-target.c.inc
@@ -2620,7 +2620,7 @@ static const DebugFrame debug_frame = {
     }
 };
 
-void tcg_register_jit(void *buf, size_t buf_size)
+void tcg_register_jit(const void *buf, size_t buf_size)
 {
     tcg_register_jit_int(buf, buf_size, &debug_frame, sizeof(debug_frame));
 }
diff --git a/tcg/sparc/tcg-target.c.inc b/tcg/sparc/tcg-target.c.inc
index 1a40911660..4c81d5f1c2 100644
--- a/tcg/sparc/tcg-target.c.inc
+++ b/tcg/sparc/tcg-target.c.inc
@@ -1816,7 +1816,7 @@ static const DebugFrame debug_frame = {
     .fde_ret_save = { 9, 15, 31 },      /* DW_CFA_register o7, i7 */
 };
 
-void tcg_register_jit(void *buf, size_t buf_size)
+void tcg_register_jit(const void *buf, size_t buf_size)
 {
     tcg_register_jit_int(buf, buf_size, &debug_frame, sizeof(debug_frame));
 }
-- 
2.25.1


