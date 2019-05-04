Return-Path: <SRS0=Uyhh=TE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29AD1C43219
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 06:07:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E893F20675
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 06:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mxDjQCt3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E893F20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51800 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMnpB-0001ec-T4
	for qemu-devel@archiver.kernel.org; Sat, 04 May 2019 02:07:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMnc3-00081I-E8
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMnc2-0004R2-De
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:31 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435]:45108)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hMnc2-0004P3-6z
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:30 -0400
Received: by mail-pf1-x435.google.com with SMTP id e24so3956563pfi.12
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 22:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=4RamRVLS6CpSQqwq41FPx2oK0CgrkzF+uLuaNa5g2S4=;
	b=mxDjQCt37mE5J5Cvzs64RuNxY5zDhXZ3MIuN5y3PUi5nR5boLTrL0qW6YrH++IjGvZ
	QkuAUtbaqGMRK/31fbornlNW91M5vFI9+5a1nznsE1jF9Va6XFa17EpPNvqA6/lv/BvX
	VQmC1Ifc88lMAtucCyMS80eIz5Qya5EE/Ybvk2zX+xH24fLj02avXdmuehwEjJ0bzwNe
	/l5U2jKA+KX2uAuw0Yw88kpD/DcFbIYKusEnkqUE+ZZEEA06O5hxz0jDs+T+SObhhqRs
	b+aG3Bs+aJMPlrdb2uTY/JX3PWQBgoCurlOgmbPnGwh9U6nkfUOKc3rtiY/oM/nmqiBS
	XCSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=4RamRVLS6CpSQqwq41FPx2oK0CgrkzF+uLuaNa5g2S4=;
	b=d/1pGY3JnA9UjyMRGzFUPA6IivZVsc1DAiYsOFfvQ2Ri0WFw0XOf9HnoUP7ywYJKvq
	rfKxbMxqXJwcAHp3KvPz5z/m8EXGkWI0LUVOL7B2KyJo4R9owEvw4TQzfSuweOuYo5nl
	3RZw06hVFXZuwCkAFMzSvJ3kT3lZlcnjXm1Gx3LZJyb9PJj6G2xIuOd6q2pvS8cgOclE
	8FKaJxByD2R9PlSL4B+80Ok1llhRligNcsA/fVE9/NPPoC/46h3g+bLVILnp2i0NJT+b
	i5JDl5Jyy0X8wAtk7KfhOrJKAw+fa69TsrXqwAHDqmkgzjB8+XCiWqb/z2FQ0L0oUnH8
	HzYg==
X-Gm-Message-State: APjAAAX4JGLbnb/zgEU3MSRiQDQmUfhcp2komIq1XLsOgp+R/P+ZAN4H
	VSdX00Bsfe3PbS6cTZFHw0I4Jydv7RQ=
X-Google-Smtp-Source: APXvYqwj2eqALYh/e7Jzd6LUS8iB8p8RcP0KHc4R8tcLbEQDEjsk0yDSjKMwmo3qRRpaI5zljO6htQ==
X-Received: by 2002:a63:6849:: with SMTP id d70mr15670892pgc.21.1556949208817; 
	Fri, 03 May 2019 22:53:28 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	15sm6680423pfo.117.2019.05.03.22.53.27
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 03 May 2019 22:53:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri,  3 May 2019 22:52:51 -0700
Message-Id: <20190504055300.18426-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190504055300.18426-1-richard.henderson@linaro.org>
References: <20190504055300.18426-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::435
Subject: [Qemu-devel] [PATCH v3 22/31] tcg/i386: Support vector absolute
 value
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
Cc: alex.bennee@linaro.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190504055251.dsHuwpfCuKT9N_ULSYpPC0qUbJJ6Yem0gIX8q8iaX1U@z>

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
index 0ba1587da4..aafd01cb49 100644
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
@@ -2741,6 +2744,10 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     static int const sars_insn[4] = {
         OPC_UD2, OPC_PSRAW, OPC_PSRAD, OPC_UD2
     };
+    static int const abs_insn[4] = {
+        /* TODO: AVX512 adds support for MO_64.  */
+        OPC_PABSB, OPC_PABSW, OPC_PABSD, OPC_UD2
+    };
 
     TCGType type = vecl + TCG_TYPE_V64;
     int insn, sub;
@@ -2829,6 +2836,11 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
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
@@ -3206,6 +3218,7 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_dup2_vec:
 #endif
         return &x_x_x;
+    case INDEX_op_abs_vec:
     case INDEX_op_dup_vec:
     case INDEX_op_shli_vec:
     case INDEX_op_shri_vec:
@@ -3283,6 +3296,8 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_umin_vec:
     case INDEX_op_umax_vec:
         return vece <= MO_32 ? 1 : -1;
+    case INDEX_op_abs_vec:
+        return vece <= MO_32;
 
     default:
         return 0;
-- 
2.17.1


