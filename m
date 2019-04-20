Return-Path: <SRS0=TjK1=SW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C4CC282DD
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 07:59:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84E452087F
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 07:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ni+RjTjG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84E452087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38392 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHkuC-0003rM-Ph
	for qemu-devel@archiver.kernel.org; Sat, 20 Apr 2019 03:59:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkXW-00010B-4r
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkXU-0000l0-Gp
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:57 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e]:42203)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hHkXT-00005G-UO
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:56 -0400
Received: by mail-pg1-x52e.google.com with SMTP id p6so3585750pgh.9
	for <qemu-devel@nongnu.org>; Sat, 20 Apr 2019 00:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=wLEaZTkk1NbZcHzSWXgsTBTywHt51Uv7RFioHP3q3zU=;
	b=ni+RjTjGK/dKzsY0d7JkK2+FvozFPeo+u0c9qEeWjdd8tVR/Sz4CABqYFNUpQuk8Ar
	yMnBEVrKkRfsZBOPm73xqj+kQ69TMJvJFudTNz7jSCOUnC59Q1Rdld67kOzkbWx2ue7V
	cnDH5nu7WjMFYrRC7M2pFhoOtpyiQWM5yl0C9BBNCo/voaskUHE1YxikFwUBU/IcssSB
	zCYNkwU186W1gvyuFi6IwpZ7RnPxIrInyxE/A9tlKkOFhP4y6ETBLuwGFWkMzXdhwVya
	Anr+GzLP/9VDxVLrRQ7cVJbhF3NEqzfrYUG4yOWBcJDsA9Y80SpIznD9YUDV8eQJTerU
	ebdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=wLEaZTkk1NbZcHzSWXgsTBTywHt51Uv7RFioHP3q3zU=;
	b=hUj0hUynoWQXs3YWAEGVVfdqg1Lmvbrtje9i1MxggWsEFCV7LAjIz/5TrMs+cntK31
	nn2pI+fguBk4fnmWEjbfyKFhycKMDioqp7wAEymiBHdtFpaaY2rkuARFMeiBacsl1pD6
	K/s0uNb+4CsASuYLY9jbqJ6ctk4gm8Hax836bvMILBMAwMJhV5XpdxMQRpE9/LZxBlpP
	Ny6XJkbB/l1oU1+G/RJ06UC4u3SdiHEwEGQOx173W3JqxgSxXaBE368JFij9T6ebyAR6
	rMAx31RC5F89hdGZ7Mn/UOPqNoksI2+He3X057QfrBe9v0F0YEF/f9rzWRq6TuGioEtU
	heeg==
X-Gm-Message-State: APjAAAWjs2K7R4Nhif/DhnGhox5omJLsc8eRUwKJjdJqSobqo9CwO1Ku
	YqG+Q1ylTgem68Sl2nc8lAJvQMIxAW0=
X-Google-Smtp-Source: APXvYqwFTJEPFhFYhDhFjV+xfbryJXIg5MJVeLH9VbsNEgE1HgmUOjBT4l0JCPhB187WJqtTEgbWUA==
X-Received: by 2002:a62:76c1:: with SMTP id r184mr8605049pfc.229.1555745727700;
	Sat, 20 Apr 2019 00:35:27 -0700 (PDT)
Received: from localhost.localdomain (rrcs-66-91-136-155.west.biz.rr.com.
	[66.91.136.155]) by smtp.gmail.com with ESMTPSA id
	z22sm7025492pgv.23.2019.04.20.00.35.26
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 20 Apr 2019 00:35:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 19 Apr 2019 21:34:30 -1000
Message-Id: <20190420073442.7488-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190420073442.7488-1-richard.henderson@linaro.org>
References: <20190420073442.7488-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::52e
Subject: [Qemu-devel] [PATCH 26/38] tcg/i386: Support vector absolute value
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
Cc: david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190420073430.xW7ECLYgaEtXcrjXIbAADwr0Yo8eVfGilHvqWw2ekyk@z>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.h     |  2 +-
 tcg/i386/tcg-target.inc.c | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 7445f05885..66f16fbe3c 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -182,7 +182,7 @@ extern bool have_avx2;
 #define TCG_TARGET_HAS_orc_vec          0
 #define TCG_TARGET_HAS_not_vec          0
 #define TCG_TARGET_HAS_neg_vec          0
-#define TCG_TARGET_HAS_abs_vec          0
+#define TCG_TARGET_HAS_abs_vec          1
 #define TCG_TARGET_HAS_shi_vec          1
 #define TCG_TARGET_HAS_shs_vec          1
 #define TCG_TARGET_HAS_shv_vec          have_avx2
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 85b68e4326..3dae0bf0c5 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -369,6 +369,9 @@ static inline int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define OPC_MOVSLQ	(0x63 | P_REXW)
 #define OPC_MOVZBL	(0xb6 | P_EXT)
 #define OPC_MOVZWL	(0xb7 | P_EXT)
+#define OPC_PABSB       (0x1c | P_EXT38 | P_DATA16)
+#define OPC_PABSW       (0x1d | P_EXT38 | P_DATA16)
+#define OPC_PABSD       (0x1e | P_EXT38 | P_DATA16)
 #define OPC_PACKSSDW    (0x6b | P_EXT | P_DATA16)
 #define OPC_PACKSSWB    (0x63 | P_EXT | P_DATA16)
 #define OPC_PACKUSDW    (0x2b | P_EXT38 | P_DATA16)
@@ -2739,6 +2742,10 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     static int const sars_insn[4] = {
         OPC_UD2, OPC_PSRAW, OPC_PSRAD, OPC_UD2
     };
+    static int const abs_insn[4] = {
+        /* TODO: AVX512 adds support for MO_64.  */
+        OPC_PABSB, OPC_PABSW, OPC_PABSD, OPC_UD2
+    };
 
     TCGType type = vecl + TCG_TYPE_V64;
     int insn, sub;
@@ -2827,6 +2834,11 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         insn = OPC_PUNPCKLDQ;
         goto gen_simd;
 #endif
+    case INDEX_op_abs_vec:
+        insn = abs_insn[vece];
+        a2 = a1;
+        a1 = 0;
+        goto gen_simd;
     gen_simd:
         tcg_debug_assert(insn != OPC_UD2);
         if (type == TCG_TYPE_V256) {
@@ -3204,6 +3216,7 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_dup2_vec:
 #endif
         return &x_x_x;
+    case INDEX_op_abs_vec:
     case INDEX_op_dup_vec:
     case INDEX_op_shli_vec:
     case INDEX_op_shri_vec:
@@ -3281,6 +3294,8 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_umin_vec:
     case INDEX_op_umax_vec:
         return vece <= MO_32 ? 1 : -1;
+    case INDEX_op_abs_vec:
+        return vece <= MO_32;
 
     default:
         return 0;
-- 
2.17.1


