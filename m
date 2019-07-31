Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B438DC433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 18:04:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85A61206A3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 18:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StW6f8DQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85A61206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hssxL-0006ec-Qj
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 14:04:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42814)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hssrG-0002Jo-MM
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 13:57:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hssrF-0002pm-Cl
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 13:57:50 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:33616)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hssrF-0002pZ-8w
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 13:57:49 -0400
Received: by mail-yb1-xb43.google.com with SMTP id c202so23398428ybf.0
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 10:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bcxzzQU+Os6mByThQeAgYZj1muTdUxSMU3AVuLL5+B0=;
 b=StW6f8DQdul/jG6usq7Ywo9EX1RAH0H9e26kALvJqh/XQGn+YKkyjHcWgtPsmLGuC/
 SMADZo/9fq7Oql4C+1wrr2DbYLYs4lC5RCoDI6j4obItFutk3zXR+j18V/HBXuQWgaSr
 YQ8jHOTQGFZ2LaSeeniCz73Syr3TFfgSYakK4cP4Mm1F2xCBT6LkCrq5o2OOY1zbDKk+
 cw6G2k+P62P75Vi1SiM4Svz437J1fOMzoCoXVgoR9AIBQaBiUnpXFeZvX9IUqP6Ka1kD
 PoToM9dX52q1pJNnkFQJclO4URIlhIklPEGYFkiopnf17e0m1f8kytzphGX81KJg6GAP
 p5Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bcxzzQU+Os6mByThQeAgYZj1muTdUxSMU3AVuLL5+B0=;
 b=fzESyhswolFqTJbDraSyPVRzV/FLIq9qUSbT4Ltw8FTiQB0aOklG9b1IOy8Yfzms4P
 nKY+irXS9O3JiWT5AySYqnBw86KbO8CIaSU/T44LUfcrg4Psfp9VmAPvSKzj5DI2cNiW
 I/HPOVUhu9m6eHSeCybQuLwbK7/+qvxz7RcxUMYaqwBj/FtsQ40lh/A7Yd+sL5tw1Bys
 XStVSEeN+vcsUVa+bh5mfG2KCmw0Lxchuw5oExIYEQn6obJuLaSGym2gMCuWQsy/QGts
 Q3KUC9LfYt5OKvRWZx4rrPgOdJjybSJ2h+Qj1gaUm7Ef5IYJwx3awavX1+rBTuBqODND
 nBKQ==
X-Gm-Message-State: APjAAAVfhE2KIpjNV8D/1bfO+1+3S/UtJnSOv/PKzowHOsQdeYiYJMEj
 KDyznTm5nLwvh6QOxHTocGuQOYvI
X-Google-Smtp-Source: APXvYqxAKVxjmu/8R4EwDeYdQpj/GUPt7NZ/iBhvLMiue/IyQDiln3brbt+ruFdO6XgNMF5v3gmgDw==
X-Received: by 2002:a25:9a82:: with SMTP id s2mr63225962ybo.369.1564595868472; 
 Wed, 31 Jul 2019 10:57:48 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id 206sm16077696ywk.44.2019.07.31.10.57.47
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 10:57:48 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 13:56:52 -0400
Message-Id: <20190731175702.4916-13-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190731175702.4916-1-jan.bobek@gmail.com>
References: <20190731175702.4916-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b43
Subject: [Qemu-devel] [RFC PATCH v1 12/22] target/i386: reimplement
 (V)PADD(B, W, D, Q)
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jan Bobek <jan.bobek@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use the gvec infrastructure to achieve the desired functionality.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 target/i386/ops_sse.h        |  6 ------
 target/i386/ops_sse_header.h |  5 -----
 target/i386/translate.c      | 33 +++++++++++++++++++++++++++++----
 3 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/target/i386/ops_sse.h b/target/i386/ops_sse.h
index 84562a4536..31a761a89a 100644
--- a/target/i386/ops_sse.h
+++ b/target/i386/ops_sse.h
@@ -337,7 +337,6 @@ static inline int satsw(int x)
     }
 }
 
-#define FADD(a, b) ((a) + (b))
 #define FADDUB(a, b) satub((a) + (b))
 #define FADDUW(a, b) satuw((a) + (b))
 #define FADDSB(a, b) satsb((int8_t)(a) + (int8_t)(b))
@@ -366,11 +365,6 @@ static inline int satsw(int x)
 #define FAVG(a, b) (((a) + (b) + 1) >> 1)
 #endif
 
-SSE_HELPER_B(helper_paddb, FADD)
-SSE_HELPER_W(helper_paddw, FADD)
-SSE_HELPER_L(helper_paddl, FADD)
-SSE_HELPER_Q(helper_paddq, FADD)
-
 SSE_HELPER_B(helper_psubb, FSUB)
 SSE_HELPER_W(helper_psubw, FSUB)
 SSE_HELPER_L(helper_psubl, FSUB)
diff --git a/target/i386/ops_sse_header.h b/target/i386/ops_sse_header.h
index abd00ca69d..5c69ab91d4 100644
--- a/target/i386/ops_sse_header.h
+++ b/target/i386/ops_sse_header.h
@@ -60,11 +60,6 @@ DEF_HELPER_3(glue(pslldq, SUFFIX), void, env, Reg, Reg)
 #define SSE_HELPER_Q(name, F)\
     DEF_HELPER_3(glue(name, SUFFIX), void, env, Reg, Reg)
 
-SSE_HELPER_B(paddb, FADD)
-SSE_HELPER_W(paddw, FADD)
-SSE_HELPER_L(paddl, FADD)
-SSE_HELPER_Q(paddq, FADD)
-
 SSE_HELPER_B(psubb, FSUB)
 SSE_HELPER_W(psubw, FSUB)
 SSE_HELPER_L(psubl, FSUB)
diff --git a/target/i386/translate.c b/target/i386/translate.c
index 69e9514679..1dbeb49066 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -2818,7 +2818,7 @@ static const SSEFunc_0_epp sse_op_table1[256][4] = {
     [0xd1] = MMX_OP2(psrlw),
     [0xd2] = MMX_OP2(psrld),
     [0xd3] = MMX_OP2(psrlq),
-    [0xd4] = MMX_OP2(paddq),
+    [0xd4] = { SSE_TOMBSTONE, SSE_TOMBSTONE },
     [0xd5] = MMX_OP2(pmullw),
     [0xd6] = { NULL, SSE_SPECIAL, SSE_SPECIAL, SSE_SPECIAL },
     [0xd7] = { SSE_SPECIAL, SSE_SPECIAL }, /* pmovmskb */
@@ -2859,9 +2859,9 @@ static const SSEFunc_0_epp sse_op_table1[256][4] = {
     [0xf9] = MMX_OP2(psubw),
     [0xfa] = MMX_OP2(psubl),
     [0xfb] = MMX_OP2(psubq),
-    [0xfc] = MMX_OP2(paddb),
-    [0xfd] = MMX_OP2(paddw),
-    [0xfe] = MMX_OP2(paddl),
+    [0xfc] = { SSE_TOMBSTONE, SSE_TOMBSTONE },
+    [0xfd] = { SSE_TOMBSTONE, SSE_TOMBSTONE },
+    [0xfe] = { SSE_TOMBSTONE, SSE_TOMBSTONE },
 };
 
 static const SSEFunc_0_epp sse_op_table2[3 * 8][2] = {
@@ -3166,6 +3166,11 @@ static inline void gen_gvec_ld_modrm_3(CPUX86State *env, DisasContext *s,
                         gen_ld_modrm_VxHxWx,                            \
                         gen_gvec_2_fp, (opctl))
 
+#define gen_padd_mm(env, s, modrm, vece)   gen_gvec_ld_modrm_mm  ((env), (s), (modrm), (vece), tcg_gen_gvec_add, 0112)
+#define gen_padd_xmm(env, s, modrm, vece)  gen_gvec_ld_modrm_xmm ((env), (s), (modrm), (vece), tcg_gen_gvec_add, 0112)
+#define gen_vpadd_xmm(env, s, modrm, vece) gen_gvec_ld_modrm_vxmm((env), (s), (modrm), (vece), tcg_gen_gvec_add, 0123)
+#define gen_vpadd_ymm(env, s, modrm, vece) gen_gvec_ld_modrm_vymm((env), (s), (modrm), (vece), tcg_gen_gvec_add, 0123)
+
 #define gen_pand_mm(env, s, modrm)   gen_gvec_ld_modrm_mm  ((env), (s), (modrm), MO_64, tcg_gen_gvec_and, 0112)
 #define gen_pand_xmm(env, s, modrm)  gen_gvec_ld_modrm_xmm ((env), (s), (modrm), MO_64, tcg_gen_gvec_and, 0112)
 #define gen_vpand_xmm(env, s, modrm) gen_gvec_ld_modrm_vxmm((env), (s), (modrm), MO_64, tcg_gen_gvec_and, 0123)
@@ -3301,6 +3306,26 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b)
            | (s->prefix & PREFIX_REPZ ? P_F3 : 0)
            | (s->prefix & PREFIX_REPNZ ? P_F2 : 0)
            | (s->prefix & PREFIX_VEX ? (s->vex_l ? VEX_256 : VEX_128) : 0)) {
+    case 0xfc | M_0F:                  gen_padd_mm(env, s, modrm, MO_8); return;
+    case 0xfc | M_0F | P_66:           gen_padd_xmm(env, s, modrm, MO_8); return;
+    case 0xfc | M_0F | P_66 | VEX_128: gen_vpadd_xmm(env, s, modrm, MO_8); return;
+    case 0xfc | M_0F | P_66 | VEX_256: gen_vpadd_ymm(env, s, modrm, MO_8); return;
+
+    case 0xfd | M_0F:                  gen_padd_mm(env, s, modrm, MO_16); return;
+    case 0xfd | M_0F | P_66:           gen_padd_xmm(env, s, modrm, MO_16); return;
+    case 0xfd | M_0F | P_66 | VEX_128: gen_vpadd_xmm(env, s, modrm, MO_16); return;
+    case 0xfd | M_0F | P_66 | VEX_256: gen_vpadd_ymm(env, s, modrm, MO_16); return;
+
+    case 0xfe | M_0F:                  gen_padd_mm(env, s, modrm, MO_32); return;
+    case 0xfe | M_0F | P_66:           gen_padd_xmm(env, s, modrm, MO_32); return;
+    case 0xfe | M_0F | P_66 | VEX_128: gen_vpadd_xmm(env, s, modrm, MO_32); return;
+    case 0xfe | M_0F | P_66 | VEX_256: gen_vpadd_ymm(env, s, modrm, MO_32); return;
+
+    case 0xd4 | M_0F:                  gen_padd_mm(env, s, modrm, MO_64); return;
+    case 0xd4 | M_0F | P_66:           gen_padd_xmm(env, s, modrm, MO_64); return;
+    case 0xd4 | M_0F | P_66 | VEX_128: gen_vpadd_xmm(env, s, modrm, MO_64); return;
+    case 0xd4 | M_0F | P_66 | VEX_256: gen_vpadd_ymm(env, s, modrm, MO_64); return;
+
     case 0xdb | M_0F:                  gen_pand_mm(env, s, modrm); return;
     case 0xdb | M_0F | P_66:           gen_pand_xmm(env, s, modrm); return;
     case 0xdb | M_0F | P_66 | VEX_128: gen_vpand_xmm(env, s, modrm); return;
-- 
2.20.1


