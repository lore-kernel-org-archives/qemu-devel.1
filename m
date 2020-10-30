Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E3BC2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 01:17:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92A4020724
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 01:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EVSW04QX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92A4020724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYJ2j-00044D-5z
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 21:17:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kYIby-0004Iy-EL
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 20:49:46 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d]:38649)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kYIbn-0001qT-E5
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 20:49:46 -0400
Received: by mail-pl1-x62d.google.com with SMTP id f21so2145895plr.5
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 17:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=48p8W0cP5+rHGeUcp39fHqqdSqoVJv3RUP5dQwok3FU=;
 b=EVSW04QXijdyT9lJn2iOx9GOAKCYdkPPWKlZs9QxmVfJ+eJeChTQ0OchqbzFm7ofno
 M49qEF0ribLjryIziboRic6OJGt+WeMpxaNOrTTuwKHP7kacJ02JeMtXeF3LKQLAYZmP
 nLL8b9F1VVJ+Gj1+Au/YgVpWlfHKXwRHWUfI4H0Ze8rNJEBOxoIghNgdOC21due6RKEm
 WK6/oTKE8CEtwNXGjbgmw/JyqL33x4Up34YaKdZEjQHLKYNUoc9gcdh+j1KraaeUaYAd
 xi25q+K/RBmuKxZFdBpLic6CwzjVV7a/4yufBe8JGGC5gP5J7MUzwTuhxuOTGz2s2kXK
 3Niw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=48p8W0cP5+rHGeUcp39fHqqdSqoVJv3RUP5dQwok3FU=;
 b=l9f3mvzpgbiRNTjQvIep6gClxhoDeGFvufz0oUne+QKNowXQstz/HOGxXFrip8Gygw
 dytJEjeOEG0if/wIZTxTbeSXuGjqhKzy+ZCH17b5NrulHPayQO+obR9KBLEsU+nxhy/w
 5RA0nQGTKVAjfqSZkZjFR72sel2E5z6WVzoRI6/H6ZTKa6DtpaJUYr7BnbaR4y8g5CBG
 lZ51kj9tq8pgH9PJ/DAlm4jkg2JkEY+riz7e8ByJAalk43YDvtUAU/eNvifG8a6u1T0K
 zBWfG3BLyFZ5/m7f+zqRmfxIvRhCSdJpqkdFmDhP69nkm7JoeBR9h68vvcAcItkszK7h
 ITZQ==
X-Gm-Message-State: AOAM530qBhlQS4EQSPjJ+PpmYVwOSmumM5bfwoKChSiwJrUV18eI07Re
 VzU6K5jz67t2t1v4W+nx7PLzGXD3jagxCw==
X-Google-Smtp-Source: ABdhPJx4Me6fwyb7kFA4uZxMn6LVATTd1giQGiQP8e9UoZbHGjVdZljjlq7uN7uFU4abCMbyGIQwAw==
X-Received: by 2002:a17:902:ee53:b029:d6:ff1:d569 with SMTP id
 19-20020a170902ee53b02900d60ff1d569mr6497836plo.23.1604018973110; 
 Thu, 29 Oct 2020 17:49:33 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id b6sm3557264pgq.58.2020.10.29.17.49.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2020 17:49:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 07/19] tcg: Adjust tcg_register_jit for const
Date: Thu, 29 Oct 2020 17:49:09 -0700
Message-Id: <20201030004921.721096-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201030004921.721096-1-richard.henderson@linaro.org>
References: <20201030004921.721096-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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
Cc: pbonzini@redhat.com, j@getutm.app, laurent@vivier.eu
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
index f6f84421b2..76717b358b 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -1242,7 +1242,7 @@ typedef uintptr_t tcg_prologue_fn(CPUArchState *env, const void *tb_ptr);
 extern tcg_prologue_fn *tcg_qemu_tb_exec;
 #endif
 
-void tcg_register_jit(void *buf, size_t buf_size);
+void tcg_register_jit(const void *buf, size_t buf_size);
 
 #if TCG_TARGET_MAYBE_vec
 /* Return zero if the tuple (opc, type, vece) is unsupportable;
diff --git a/tcg/tcg.c b/tcg/tcg.c
index da16378d1c..4d5c95526c 100644
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
@@ -1133,7 +1133,7 @@ void tcg_prologue_init(TCGContext *s)
     total_size -= prologue_size;
     s->code_gen_buffer_size = total_size;
 
-    tcg_register_jit(s->code_gen_buffer, total_size);
+    tcg_register_jit(tcg_mirror_rw_to_rx(s->code_gen_buffer), total_size);
 
 #ifdef DEBUG_DISAS
     if (qemu_loglevel_mask(CPU_LOG_TB_OUT_ASM)) {
@@ -4449,7 +4449,7 @@ static int find_string(const char *strtab, const char *str)
     }
 }
 
-static void tcg_register_jit_int(void *buf_ptr, size_t buf_size,
+static void tcg_register_jit_int(const void *buf_ptr, size_t buf_size,
                                  const void *debug_frame,
                                  size_t debug_frame_size)
 {
@@ -4651,13 +4651,13 @@ static void tcg_register_jit_int(void *buf_ptr, size_t buf_size,
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
index d6dfe2b428..431af3107c 100644
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
index 064f46fc6d..b74dc15b86 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -2702,7 +2702,7 @@ static const DebugFrame debug_frame = {
     }
 };
 
-void tcg_register_jit(void *buf, size_t buf_size)
+void tcg_register_jit(const void *buf, size_t buf_size)
 {
     tcg_register_jit_int(buf, buf_size, &debug_frame, sizeof(debug_frame));
 }
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 513d784a83..bdaffeabb3 100644
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
index 7983befd96..2444511177 100644
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


