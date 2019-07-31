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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC33C32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 18:07:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21956206A2
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 18:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NCTInTmr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21956206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hst0u-0005SB-Df
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 14:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42987)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hssrM-0002gk-P2
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 13:57:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hssrL-00034s-LI
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 13:57:56 -0400
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44]:40125)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hssrL-00034Q-GX
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 13:57:55 -0400
Received: by mail-yw1-xc44.google.com with SMTP id b143so25253974ywb.7
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 10:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qwNJraZExAiEk69izkYfz3uLADtLZ4vzJetI20/CgG4=;
 b=NCTInTmr+D3ZkZ/d2QQAYUN1e1Mk4EcAVMp2lFc9ptRPvzLsSoEWwNeAcp6w6fsgF4
 dsjj9Pj9Vwxdix3R7ykscerWlOnPuAHrYgavc7uMdG4aJnU7TIfp/GZe0BeLEtFT+ibH
 jOt3OmerpQrkJ60x9aPldR7ULviC+52mSFYP97l8O5PRGuF57HO/Ds02euwfpBfyZYof
 5fdTNYzr7Dqm8urWTllYc+IKwjv8RBQjaPnXKHm7Al1kDilQT8tHpLayXXRh7ORNJp0l
 xp9teXOUTYlluiSPIwxkIeygFKXGz+G6yHV3ZptSeBGFM7IfHlQwCjzANMT7um/0XeFK
 uLjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qwNJraZExAiEk69izkYfz3uLADtLZ4vzJetI20/CgG4=;
 b=Gde51l7eet2bVrryYjNXT4ZCmLwRyz0HwPv5cFihEXBhHdFEZsMZ1vwBAlIb/IYA6A
 6nloO3ITbnwRE7o0EYY9d/e2XKiD/V9vi4Rviy882QwbbbaElzLJGTljlxc/Jlhs93/X
 0QggjtcnNST5mLdCZSJGwrndkSKD8gcJpSp5eIU1Y13ze9nFDZ5LVFwCMbIkbOdE0mNK
 +FeaA/YpWNTXP4HMeGSzK34U4xswIce23bhT35obmQVCiT/HhCl7Nfw0igjJPB6Mnvvl
 qLdnoa4FlWcsyH2QSons1BhoufpIwpjQx2Oj21NsYA9VRtrDUtOPhLoCYpeSVNeOi1Rt
 udug==
X-Gm-Message-State: APjAAAWishxlhow6BxkrJt0iyu6/np+D9kf+tdIZuVpcyh4w0IC/vuEd
 jfvPEUxVxalhi9KDLSEVjI6qceSg
X-Google-Smtp-Source: APXvYqyH/lanD9JlxPxXsLddvMGzPSiPuQgg4z0aP7XpW1EeOhABSU2lAYR9YQBOKdMPtoFVpmOOQQ==
X-Received: by 2002:a81:a50c:: with SMTP id u12mr71761104ywg.287.1564595874902; 
 Wed, 31 Jul 2019 10:57:54 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id 206sm16077696ywk.44.2019.07.31.10.57.54
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 10:57:54 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 13:57:01 -0400
Message-Id: <20190731175702.4916-22-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190731175702.4916-1-jan.bobek@gmail.com>
References: <20190731175702.4916-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c44
Subject: [Qemu-devel] [RFC PATCH v1 21/22] target/i386: reimplement (V)PMAXUB
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
 target/i386/ops_sse.h        |  4 ----
 target/i386/ops_sse_header.h |  2 --
 target/i386/translate.c      | 12 +++++++++++-
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/target/i386/ops_sse.h b/target/i386/ops_sse.h
index 92d0544474..75ff686bb6 100644
--- a/target/i386/ops_sse.h
+++ b/target/i386/ops_sse.h
@@ -337,8 +337,6 @@ static inline int satsw(int x)
     }
 }
 
-#define FMAXUB(a, b) ((a) > (b)) ? (a) : (b)
-
 #define FCMPGTB(a, b) ((int8_t)(a) > (int8_t)(b) ? -1 : 0)
 #define FCMPGTW(a, b) ((int16_t)(a) > (int16_t)(b) ? -1 : 0)
 #define FCMPGTL(a, b) ((int32_t)(a) > (int32_t)(b) ? -1 : 0)
@@ -352,8 +350,6 @@ static inline int satsw(int x)
 #define FAVG(a, b) (((a) + (b) + 1) >> 1)
 #endif
 
-SSE_HELPER_B(helper_pmaxub, FMAXUB)
-
 SSE_HELPER_B(helper_pcmpgtb, FCMPGTB)
 SSE_HELPER_W(helper_pcmpgtw, FCMPGTW)
 SSE_HELPER_L(helper_pcmpgtl, FCMPGTL)
diff --git a/target/i386/ops_sse_header.h b/target/i386/ops_sse_header.h
index bf38738783..9c7451d28e 100644
--- a/target/i386/ops_sse_header.h
+++ b/target/i386/ops_sse_header.h
@@ -60,8 +60,6 @@ DEF_HELPER_3(glue(pslldq, SUFFIX), void, env, Reg, Reg)
 #define SSE_HELPER_Q(name, F)\
     DEF_HELPER_3(glue(name, SUFFIX), void, env, Reg, Reg)
 
-SSE_HELPER_B(pmaxub, FMAXUB)
-
 SSE_HELPER_B(pcmpgtb, FCMPGTB)
 SSE_HELPER_W(pcmpgtw, FCMPGTW)
 SSE_HELPER_L(pcmpgtl, FCMPGTL)
diff --git a/target/i386/translate.c b/target/i386/translate.c
index 48bfb4e47b..d08d2cedce 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -2828,7 +2828,7 @@ static const SSEFunc_0_epp sse_op_table1[256][4] = {
     [0xdb] = { SSE_TOMBSTONE, SSE_TOMBSTONE },
     [0xdc] = { SSE_TOMBSTONE, SSE_TOMBSTONE },
     [0xdd] = { SSE_TOMBSTONE, SSE_TOMBSTONE },
-    [0xde] = MMX_OP2(pmaxub),
+    [0xde] = { SSE_TOMBSTONE, SSE_TOMBSTONE },
     [0xdf] = { SSE_TOMBSTONE, SSE_TOMBSTONE },
     [0xe0] = MMX_OP2(pavgb),
     [0xe1] = MMX_OP2(psraw),
@@ -3211,6 +3211,11 @@ static inline void gen_gvec_ld_modrm_3(CPUX86State *env, DisasContext *s,
 #define gen_vpmaxs_xmm(env, s, modrm, vece) gen_gvec_ld_modrm_vxmm((env), (s), (modrm), (vece), tcg_gen_gvec_smax, 0123)
 #define gen_vpmaxs_ymm(env, s, modrm, vece) gen_gvec_ld_modrm_vymm((env), (s), (modrm), (vece), tcg_gen_gvec_smax, 0123)
 
+#define gen_pmaxu_mm(env, s, modrm, vece)   gen_gvec_ld_modrm_mm  ((env), (s), (modrm), (vece), tcg_gen_gvec_umax, 0112)
+#define gen_pmaxu_xmm(env, s, modrm, vece)  gen_gvec_ld_modrm_xmm ((env), (s), (modrm), (vece), tcg_gen_gvec_umax, 0112)
+#define gen_vpmaxu_xmm(env, s, modrm, vece) gen_gvec_ld_modrm_vxmm((env), (s), (modrm), (vece), tcg_gen_gvec_umax, 0123)
+#define gen_vpmaxu_ymm(env, s, modrm, vece) gen_gvec_ld_modrm_vymm((env), (s), (modrm), (vece), tcg_gen_gvec_umax, 0123)
+
 #define gen_pand_mm(env, s, modrm)   gen_gvec_ld_modrm_mm  ((env), (s), (modrm), MO_64, tcg_gen_gvec_and, 0112)
 #define gen_pand_xmm(env, s, modrm)  gen_gvec_ld_modrm_xmm ((env), (s), (modrm), MO_64, tcg_gen_gvec_and, 0112)
 #define gen_vpand_xmm(env, s, modrm) gen_gvec_ld_modrm_vxmm((env), (s), (modrm), MO_64, tcg_gen_gvec_and, 0123)
@@ -3436,6 +3441,11 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b)
     case 0xea | M_0F | P_66 | VEX_128: gen_vpmins_xmm(env, s, modrm, MO_16); return;
     case 0xea | M_0F | P_66 | VEX_256: gen_vpmins_ymm(env, s, modrm, MO_16); return;
 
+    case 0xde | M_0F:                  gen_pmaxu_mm(env, s, modrm, MO_8); return;
+    case 0xde | M_0F | P_66:           gen_pmaxu_xmm(env, s, modrm, MO_8); return;
+    case 0xde | M_0F | P_66 | VEX_128: gen_vpmaxu_xmm(env, s, modrm, MO_8); return;
+    case 0xde | M_0F | P_66 | VEX_256: gen_vpmaxu_ymm(env, s, modrm, MO_8); return;
+
     case 0xee | M_0F:                  gen_pmaxs_mm(env, s, modrm, MO_16); return;
     case 0xee | M_0F | P_66:           gen_pmaxs_xmm(env, s, modrm, MO_16); return;
     case 0xee | M_0F | P_66 | VEX_128: gen_vpmaxs_xmm(env, s, modrm, MO_16); return;
-- 
2.20.1


