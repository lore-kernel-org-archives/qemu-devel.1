Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A844DC2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:48:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAFBC20735
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 03:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TyE0kEPg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAFBC20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kasjM-0007aB-Su
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 22:48:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kasSA-0005Wn-1k
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 22:30:19 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d]:38576)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kasS5-000795-TU
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 22:30:17 -0500
Received: by mail-pl1-x62d.google.com with SMTP id f21so26467plr.5
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 19:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jc6eykP6VpfCDyGHj3QveBxbyuogYi8aKD+vVVs4fs4=;
 b=TyE0kEPgtT1OOI3WZprO/Qa2EoxEkPjjAzrjAm+6PoxST2IF2Sax6ToQxVgDalj3mg
 WLEpcLNID+6qQdItWG3moDht+Mq5Bvxagro0Y5efVws9sCENEmTvUxdmFqHWP1RprM3K
 C0ghvOz1pK2WTm7Sp525TrxPt8KmWkTOuhOrIGDp7FPqFkqvf4vkRUH/YeWRW1NbTeCG
 ZuSLDGcpkDNdyTu59ARH80tO4n84qQGZEOO0dpcC9+2vnDnPxTF0d/Yrk0TnJs4W9KA/
 O02alKD1EmjfW8BWhjaA+dc/xEqhLgJV7XkB3auKJn4EN8CqbocDieZJ9BuMVrM2XAQg
 WuIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jc6eykP6VpfCDyGHj3QveBxbyuogYi8aKD+vVVs4fs4=;
 b=IoBzeiHmvJjSTC4RgNRlqiSvHY2O8JRElp4Np5mQjJrHK3X4QPuQVwNtHB1WAHCExq
 9akW0n0Hk5phf9MfAWznVRtHe+pRkS2hWvIyS25kmDIHuzR2RmC8J93NIXVwyCuY0J2Q
 zlbXBrP9Tf6P+Y8gxSvygNZShcPqYkih0BR/55gzL623kAWtfsNT/RSSakeKrYiMs4KD
 xbB6jLu39YdjbgXehR1ziJUo5wyxQ7bR2VZ6mR+PoviE0R8FSph7s4CZAlgGJMB6eXcb
 Bk6Yr0ChKlfaXjyOS8W/j+EcJV4vl4E3FpUKFOBxWg0W3mA5viHmZdG6Cm+PO1e6QgYk
 B7LQ==
X-Gm-Message-State: AOAM533RnF3+M+cFEckIsAl1287oqUndJm7tsSiJknSLlHNAUNHwv57J
 2KM3EtxHT1TqMzy0ar7rRxN5gmidY9uIXA==
X-Google-Smtp-Source: ABdhPJw+LyjkJbsodJMtWF/4WUteRHfjLTm2EvNhTKLG7C4U3e79rxVcxLCUdKYFr8f9ijgbV/HWAQ==
X-Received: by 2002:a17:902:7c8c:b029:d4:e5b2:fba4 with SMTP id
 y12-20020a1709027c8cb02900d4e5b2fba4mr34375pll.82.1604633403573; 
 Thu, 05 Nov 2020 19:30:03 -0800 (PST)
Received: from localhost.localdomain (76-14-210-194.or.wavecable.com.
 [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id i10sm40773pfd.60.2020.11.05.19.30.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 19:30:02 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 29/41] tcg/sparc: Support split-wx code generation
Date: Thu,  5 Nov 2020 19:29:09 -0800
Message-Id: <20201106032921.600200-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106032921.600200-1-richard.henderson@linaro.org>
References: <20201106032921.600200-1-richard.henderson@linaro.org>
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
Cc: j@getutm.app
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/sparc/tcg-target.h     |  2 +-
 tcg/sparc/tcg-target.c.inc | 24 +++++++++++++-----------
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/tcg/sparc/tcg-target.h b/tcg/sparc/tcg-target.h
index 517840705f..bb2505bfc7 100644
--- a/tcg/sparc/tcg-target.h
+++ b/tcg/sparc/tcg-target.h
@@ -181,6 +181,6 @@ static inline void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len)
 void tb_target_set_jmp_target(uintptr_t, uintptr_t, uintptr_t, uintptr_t);
 
 #define TCG_TARGET_NEED_POOL_LABELS
-#define TCG_TARGET_SUPPORT_MIRROR       0
+#define TCG_TARGET_SUPPORT_MIRROR       1
 
 #endif
diff --git a/tcg/sparc/tcg-target.c.inc b/tcg/sparc/tcg-target.c.inc
index 8f04fdf981..182124b96c 100644
--- a/tcg/sparc/tcg-target.c.inc
+++ b/tcg/sparc/tcg-target.c.inc
@@ -291,14 +291,15 @@ static inline int check_fit_i32(int32_t val, unsigned int bits)
 # define check_fit_ptr  check_fit_i32
 #endif
 
-static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
+static bool patch_reloc(tcg_insn_unit *src_rw, int type,
                         intptr_t value, intptr_t addend)
 {
-    uint32_t insn = *code_ptr;
+    const tcg_insn_unit *src_rx = tcg_splitwx_to_rx(src_rw);
+    uint32_t insn = *src_rw;
     intptr_t pcrel;
 
     value += addend;
-    pcrel = tcg_ptr_byte_diff((tcg_insn_unit *)value, code_ptr);
+    pcrel = tcg_ptr_byte_diff((tcg_insn_unit *)value, src_rx);
 
     switch (type) {
     case R_SPARC_WDISP16:
@@ -315,7 +316,7 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
         g_assert_not_reached();
     }
 
-    *code_ptr = insn;
+    *src_rw = insn;
     return true;
 }
 
@@ -868,8 +869,8 @@ static void tcg_out_mb(TCGContext *s, TCGArg a0)
 }
 
 #ifdef CONFIG_SOFTMMU
-static tcg_insn_unit *qemu_ld_trampoline[16];
-static tcg_insn_unit *qemu_st_trampoline[16];
+static const tcg_insn_unit *qemu_ld_trampoline[16];
+static const tcg_insn_unit *qemu_st_trampoline[16];
 
 static void emit_extend(TCGContext *s, TCGReg r, int op)
 {
@@ -930,7 +931,7 @@ static void build_trampolines(TCGContext *s)
         while ((uintptr_t)s->code_ptr & 15) {
             tcg_out_nop(s);
         }
-        qemu_ld_trampoline[i] = s->code_ptr;
+        qemu_ld_trampoline[i] = tcg_splitwx_to_rx(s->code_ptr);
 
         if (SPARC64 || TARGET_LONG_BITS == 32) {
             ra = TCG_REG_O3;
@@ -958,7 +959,7 @@ static void build_trampolines(TCGContext *s)
         while ((uintptr_t)s->code_ptr & 15) {
             tcg_out_nop(s);
         }
-        qemu_st_trampoline[i] = s->code_ptr;
+        qemu_st_trampoline[i] = tcg_splitwx_to_rx(s->code_ptr);
 
         if (SPARC64) {
             emit_extend(s, TCG_REG_O2, i);
@@ -1038,7 +1039,8 @@ static void tcg_target_qemu_prologue(TCGContext *s)
     tcg_out_nop(s);
 
     /* Epilogue for goto_ptr.  */
-    tcg_code_gen_epilogue = s->code_ptr;
+    /* TODO: Cast goes away when all hosts converted */
+    tcg_code_gen_epilogue = (void *)tcg_splitwx_to_rx(s->code_ptr);
     tcg_out_arithi(s, TCG_REG_G0, TCG_REG_I7, 8, RETURN);
     /* delay slot */
     tcg_out_movi_imm13(s, TCG_REG_O0, 0);
@@ -1163,7 +1165,7 @@ static void tcg_out_qemu_ld(TCGContext *s, TCGReg data, TCGReg addr,
 #ifdef CONFIG_SOFTMMU
     unsigned memi = get_mmuidx(oi);
     TCGReg addrz, param;
-    tcg_insn_unit *func;
+    const tcg_insn_unit *func;
     tcg_insn_unit *label_ptr;
 
     addrz = tcg_out_tlb_load(s, addr, memi, memop,
@@ -1245,7 +1247,7 @@ static void tcg_out_qemu_st(TCGContext *s, TCGReg data, TCGReg addr,
 #ifdef CONFIG_SOFTMMU
     unsigned memi = get_mmuidx(oi);
     TCGReg addrz, param;
-    tcg_insn_unit *func;
+    const tcg_insn_unit *func;
     tcg_insn_unit *label_ptr;
 
     addrz = tcg_out_tlb_load(s, addr, memi, memop,
-- 
2.25.1


