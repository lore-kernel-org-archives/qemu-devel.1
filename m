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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D55BC32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 18:03:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CFF92067D
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 18:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqKujsqK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CFF92067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsswy-0005oK-J8
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 14:03:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42924)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hssrK-0002Y3-FR
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 13:57:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hssrJ-0002yW-91
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 13:57:54 -0400
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:38824)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hssrJ-0002xI-4h
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 13:57:53 -0400
Received: by mail-yb1-xb44.google.com with SMTP id j199so24745195ybg.5
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 10:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rpSf9DsyPi6aCjOpAfKCodbW7O9D1x8yH1l051ssV8E=;
 b=lqKujsqKKAfdVnxMh3Cszv4ht4yYPv7xy4Z3hX1doCl7DZEATqEm/iO6Ml0qpnNk74
 O4Sfpv1CnrAywXmE5BCdozxGP0AleA4sd1s6Ap+csaiHOtC5dj1ig/8EjTsIpU7J8atl
 3VWFA3N9SZzHslaGOn4dr6I8ePqawpUAFhTeRtm/qS6hBKl0x7rmZuMaaX7yFHoUr7l3
 LzdFkmToZSCNESTCivBbkIAGps6N5V/T/0freuuqbjPU8z8MFKM6qZI/fzFF499h9EMC
 ttQwAhyHfxndQ4DhsPBIhKo6vqqwRvnmXUGL2FEHHR1osxeqi+I+aInuA4n00zYXjnXg
 TsnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rpSf9DsyPi6aCjOpAfKCodbW7O9D1x8yH1l051ssV8E=;
 b=lyEzrcF43HAtq/nlcHaQQ1LQkbgZZaWrrf1orIU9n9NKFyamIohTJG8yc51Q7AgGEb
 TH8URmKKKpLcgskeJlMnDUkOb4xOVCt3m6Z+vc9CLcJSMjakSCns/uSyOGyjFKfvQaAf
 4j6XRLqMFkqbKjObavxS0XwwjaAgXZ65DNQYorsmhjHodJlmSLAcOhNYnm7I2+XKWGos
 TG5U3pv5jMpWQ09QHA55qtueM54HCOXU68zVQQsBADHen95VDs/A/xiB/AF+HLaKSpvO
 fmPoFx01HVMAc8unqKdxoyqZlKsNOPE7fUMRU7W/toMDNEXJxzLnzTEuHmMYTUP5038n
 uPsA==
X-Gm-Message-State: APjAAAUxRy3qa1xHQpGit2RyHz2UH3Z0QGlmxbS3J7quz5kMpSoBNQJv
 C6el+6vDHSLvIrfCPpOJIuhxtTiX
X-Google-Smtp-Source: APXvYqy+W9SnLEzYq8jsfiArWOtwfm55DViw6VqQxLk0yMSLDTzqnl0GXpdRhSf6SOfoTudVorheRw==
X-Received: by 2002:a25:bccd:: with SMTP id l13mr71614245ybm.48.1564595872442; 
 Wed, 31 Jul 2019 10:57:52 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id 206sm16077696ywk.44.2019.07.31.10.57.51
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 10:57:51 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 13:56:58 -0400
Message-Id: <20190731175702.4916-19-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190731175702.4916-1-jan.bobek@gmail.com>
References: <20190731175702.4916-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b44
Subject: [Qemu-devel] [RFC PATCH v1 18/22] target/i386: reimplement (V)PMINSW
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
 target/i386/ops_sse.h        |  2 --
 target/i386/ops_sse_header.h |  1 -
 target/i386/translate.c      | 12 +++++++++++-
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/target/i386/ops_sse.h b/target/i386/ops_sse.h
index 4f00f3273d..f57eaa2c77 100644
--- a/target/i386/ops_sse.h
+++ b/target/i386/ops_sse.h
@@ -338,7 +338,6 @@ static inline int satsw(int x)
 }
 
 #define FMINUB(a, b) ((a) < (b)) ? (a) : (b)
-#define FMINSW(a, b) ((int16_t)(a) < (int16_t)(b)) ? (a) : (b)
 #define FMAXUB(a, b) ((a) > (b)) ? (a) : (b)
 #define FMAXSW(a, b) ((int16_t)(a) > (int16_t)(b)) ? (a) : (b)
 
@@ -358,7 +357,6 @@ static inline int satsw(int x)
 SSE_HELPER_B(helper_pminub, FMINUB)
 SSE_HELPER_B(helper_pmaxub, FMAXUB)
 
-SSE_HELPER_W(helper_pminsw, FMINSW)
 SSE_HELPER_W(helper_pmaxsw, FMAXSW)
 
 SSE_HELPER_B(helper_pcmpgtb, FCMPGTB)
diff --git a/target/i386/ops_sse_header.h b/target/i386/ops_sse_header.h
index 829c132ae4..a7f99e5427 100644
--- a/target/i386/ops_sse_header.h
+++ b/target/i386/ops_sse_header.h
@@ -63,7 +63,6 @@ DEF_HELPER_3(glue(pslldq, SUFFIX), void, env, Reg, Reg)
 SSE_HELPER_B(pminub, FMINUB)
 SSE_HELPER_B(pmaxub, FMAXUB)
 
-SSE_HELPER_W(pminsw, FMINSW)
 SSE_HELPER_W(pmaxsw, FMAXSW)
 
 SSE_HELPER_B(pcmpgtb, FCMPGTB)
diff --git a/target/i386/translate.c b/target/i386/translate.c
index 5b19e9ac4b..d601c6d4c2 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -2840,7 +2840,7 @@ static const SSEFunc_0_epp sse_op_table1[256][4] = {
     [0xe7] = { SSE_SPECIAL , SSE_SPECIAL },  /* movntq, movntq */
     [0xe8] = { SSE_TOMBSTONE, SSE_TOMBSTONE },
     [0xe9] = { SSE_TOMBSTONE, SSE_TOMBSTONE },
-    [0xea] = MMX_OP2(pminsw),
+    [0xea] = { SSE_TOMBSTONE, SSE_TOMBSTONE },
     [0xeb] = { SSE_TOMBSTONE, SSE_TOMBSTONE },
     [0xec] = { SSE_TOMBSTONE, SSE_TOMBSTONE },
     [0xed] = { SSE_TOMBSTONE, SSE_TOMBSTONE },
@@ -3196,6 +3196,11 @@ static inline void gen_gvec_ld_modrm_3(CPUX86State *env, DisasContext *s,
 #define gen_vpsubus_xmm(env, s, modrm, vece) gen_gvec_ld_modrm_vxmm((env), (s), (modrm), (vece), tcg_gen_gvec_ussub, 0123)
 #define gen_vpsubus_ymm(env, s, modrm, vece) gen_gvec_ld_modrm_vymm((env), (s), (modrm), (vece), tcg_gen_gvec_ussub, 0123)
 
+#define gen_pmins_mm(env, s, modrm, vece)   gen_gvec_ld_modrm_mm  ((env), (s), (modrm), (vece), tcg_gen_gvec_smin, 0112)
+#define gen_pmins_xmm(env, s, modrm, vece)  gen_gvec_ld_modrm_xmm ((env), (s), (modrm), (vece), tcg_gen_gvec_smin, 0112)
+#define gen_vpmins_xmm(env, s, modrm, vece) gen_gvec_ld_modrm_vxmm((env), (s), (modrm), (vece), tcg_gen_gvec_smin, 0123)
+#define gen_vpmins_ymm(env, s, modrm, vece) gen_gvec_ld_modrm_vymm((env), (s), (modrm), (vece), tcg_gen_gvec_smin, 0123)
+
 #define gen_pand_mm(env, s, modrm)   gen_gvec_ld_modrm_mm  ((env), (s), (modrm), MO_64, tcg_gen_gvec_and, 0112)
 #define gen_pand_xmm(env, s, modrm)  gen_gvec_ld_modrm_xmm ((env), (s), (modrm), MO_64, tcg_gen_gvec_and, 0112)
 #define gen_vpand_xmm(env, s, modrm) gen_gvec_ld_modrm_vxmm((env), (s), (modrm), MO_64, tcg_gen_gvec_and, 0123)
@@ -3411,6 +3416,11 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b)
     case 0xe9 | M_0F | P_66 | VEX_128: gen_vpsubs_xmm(env, s, modrm, MO_16); return;
     case 0xe9 | M_0F | P_66 | VEX_256: gen_vpsubs_ymm(env, s, modrm, MO_16); return;
 
+    case 0xea | M_0F:                  gen_pmins_mm(env, s, modrm, MO_16); return;
+    case 0xea | M_0F | P_66:           gen_pmins_xmm(env, s, modrm, MO_16); return;
+    case 0xea | M_0F | P_66 | VEX_128: gen_vpmins_xmm(env, s, modrm, MO_16); return;
+    case 0xea | M_0F | P_66 | VEX_256: gen_vpmins_ymm(env, s, modrm, MO_16); return;
+
     case 0xdb | M_0F:                  gen_pand_mm(env, s, modrm); return;
     case 0xdb | M_0F | P_66:           gen_pand_xmm(env, s, modrm); return;
     case 0xdb | M_0F | P_66 | VEX_128: gen_vpand_xmm(env, s, modrm); return;
-- 
2.20.1


