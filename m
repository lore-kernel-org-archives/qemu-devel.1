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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3417C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 18:05:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DE2E206A3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 18:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cp52Nzr+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DE2E206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hssz1-00011d-P2
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 14:05:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42949)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hssrL-0002bG-AQ
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 13:57:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hssrK-00031f-3v
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 13:57:55 -0400
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44]:34191)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hssrJ-00030J-W2
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 13:57:54 -0400
Received: by mail-yw1-xc44.google.com with SMTP id q128so25297391ywc.1
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 10:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mPS1RZO8DgeaiIxpzPUBfBtNhgDZ08sPwLWj65FslAM=;
 b=cp52Nzr+Q1OKZwQM/yhWDk2CN/eticPlhjmDaMR9pFr2xT24Golh+68lJrcPhKNjcQ
 LGsB9mLcEgel3sGnqqvPmOHY+0BLu8Tlm0lSITtvsVAAKMbeQhbjYJEVL5qWYfzSh3Mc
 tQySzUE48s/tv0u5rb4wuYRMzQXvxRPRmVhlImLStkL1RkCVKEBhdO7jlN4qqTIr69zq
 NW+viXr8frkgwY9sNIGd5742qLjCRas1FqjtiwSBe0ZcbDIVg5zFAHOn5woTXbqYQhzv
 fH73q49T7EcS0hH7iQSjshyI9pVA9lQqV7oWbw7HryUkjgveM2v1rcrs1ObRmQNpd/nL
 GYNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mPS1RZO8DgeaiIxpzPUBfBtNhgDZ08sPwLWj65FslAM=;
 b=N1pTOves9SNsBaEaSswnDbPAXA/6lYa/PsUHMPW+Ulkc0hoCEDMuDevR8eBZzkmdDN
 M73badYf5RiuYInZrw/+vwhk0SxL+00r3S75bGe5NKdji6f2ynyO4ccpaXt/0bwti/0c
 4UJHHFASLe+cOgIYphi5ysdWXtlddCcpOE7izn/NNd2yOtNhFckTDPUbXb3+S+DoCVfw
 ARS3EIqhmsfWDKvBTPtu9TOJvNzDFDJ3X7lM9JGnyUtStEgwRRrOXj49rqXQBb5E1Z5K
 0S2GREhv1f4Y/eZx5bvgb5wXzsArTqLrpbHRIKtYbojjmn42N1ZfoLDmsvVuAKQawM/T
 RVog==
X-Gm-Message-State: APjAAAVPCrV6VLzqqAn+Y5I5oSlBWAOIBIaEaLygO3zLl7BvkNpTFmPu
 PBWgaDO2MW8+D+ZZrWZ3eOp+6vgN
X-Google-Smtp-Source: APXvYqz6yyR58CdmLTm/YkVMTZzaPSJQy2pv+ZFm1+yDwjiw3U8XmyWVyPft4J4mIGaBnvmIBctPYA==
X-Received: by 2002:a81:1f44:: with SMTP id f65mr76358974ywf.217.1564595873396; 
 Wed, 31 Jul 2019 10:57:53 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id 206sm16077696ywk.44.2019.07.31.10.57.52
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 10:57:52 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 13:56:59 -0400
Message-Id: <20190731175702.4916-20-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190731175702.4916-1-jan.bobek@gmail.com>
References: <20190731175702.4916-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c44
Subject: [Qemu-devel] [RFC PATCH v1 19/22] target/i386: reimplement (V)PMINUB
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
index f57eaa2c77..058ed5cdfc 100644
--- a/target/i386/ops_sse.h
+++ b/target/i386/ops_sse.h
@@ -337,7 +337,6 @@ static inline int satsw(int x)
     }
 }
 
-#define FMINUB(a, b) ((a) < (b)) ? (a) : (b)
 #define FMAXUB(a, b) ((a) > (b)) ? (a) : (b)
 #define FMAXSW(a, b) ((int16_t)(a) > (int16_t)(b)) ? (a) : (b)
 
@@ -354,7 +353,6 @@ static inline int satsw(int x)
 #define FAVG(a, b) (((a) + (b) + 1) >> 1)
 #endif
 
-SSE_HELPER_B(helper_pminub, FMINUB)
 SSE_HELPER_B(helper_pmaxub, FMAXUB)
 
 SSE_HELPER_W(helper_pmaxsw, FMAXSW)
diff --git a/target/i386/ops_sse_header.h b/target/i386/ops_sse_header.h
index a7f99e5427..3d0e321230 100644
--- a/target/i386/ops_sse_header.h
+++ b/target/i386/ops_sse_header.h
@@ -60,7 +60,6 @@ DEF_HELPER_3(glue(pslldq, SUFFIX), void, env, Reg, Reg)
 #define SSE_HELPER_Q(name, F)\
     DEF_HELPER_3(glue(name, SUFFIX), void, env, Reg, Reg)
 
-SSE_HELPER_B(pminub, FMINUB)
 SSE_HELPER_B(pmaxub, FMAXUB)
 
 SSE_HELPER_W(pmaxsw, FMAXSW)
diff --git a/target/i386/translate.c b/target/i386/translate.c
index d601c6d4c2..893fe1253f 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -2824,7 +2824,7 @@ static const SSEFunc_0_epp sse_op_table1[256][4] = {
     [0xd7] = { SSE_SPECIAL, SSE_SPECIAL }, /* pmovmskb */
     [0xd8] = { SSE_TOMBSTONE, SSE_TOMBSTONE },
     [0xd9] = { SSE_TOMBSTONE, SSE_TOMBSTONE },
-    [0xda] = MMX_OP2(pminub),
+    [0xda] = { SSE_TOMBSTONE, SSE_TOMBSTONE },
     [0xdb] = { SSE_TOMBSTONE, SSE_TOMBSTONE },
     [0xdc] = { SSE_TOMBSTONE, SSE_TOMBSTONE },
     [0xdd] = { SSE_TOMBSTONE, SSE_TOMBSTONE },
@@ -3201,6 +3201,11 @@ static inline void gen_gvec_ld_modrm_3(CPUX86State *env, DisasContext *s,
 #define gen_vpmins_xmm(env, s, modrm, vece) gen_gvec_ld_modrm_vxmm((env), (s), (modrm), (vece), tcg_gen_gvec_smin, 0123)
 #define gen_vpmins_ymm(env, s, modrm, vece) gen_gvec_ld_modrm_vymm((env), (s), (modrm), (vece), tcg_gen_gvec_smin, 0123)
 
+#define gen_pminu_mm(env, s, modrm, vece)   gen_gvec_ld_modrm_mm  ((env), (s), (modrm), (vece), tcg_gen_gvec_umin, 0112)
+#define gen_pminu_xmm(env, s, modrm, vece)  gen_gvec_ld_modrm_xmm ((env), (s), (modrm), (vece), tcg_gen_gvec_umin, 0112)
+#define gen_vpminu_xmm(env, s, modrm, vece) gen_gvec_ld_modrm_vxmm((env), (s), (modrm), (vece), tcg_gen_gvec_umin, 0123)
+#define gen_vpminu_ymm(env, s, modrm, vece) gen_gvec_ld_modrm_vymm((env), (s), (modrm), (vece), tcg_gen_gvec_umin, 0123)
+
 #define gen_pand_mm(env, s, modrm)   gen_gvec_ld_modrm_mm  ((env), (s), (modrm), MO_64, tcg_gen_gvec_and, 0112)
 #define gen_pand_xmm(env, s, modrm)  gen_gvec_ld_modrm_xmm ((env), (s), (modrm), MO_64, tcg_gen_gvec_and, 0112)
 #define gen_vpand_xmm(env, s, modrm) gen_gvec_ld_modrm_vxmm((env), (s), (modrm), MO_64, tcg_gen_gvec_and, 0123)
@@ -3416,6 +3421,11 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b)
     case 0xe9 | M_0F | P_66 | VEX_128: gen_vpsubs_xmm(env, s, modrm, MO_16); return;
     case 0xe9 | M_0F | P_66 | VEX_256: gen_vpsubs_ymm(env, s, modrm, MO_16); return;
 
+    case 0xda | M_0F:                  gen_pminu_mm(env, s, modrm, MO_8); return;
+    case 0xda | M_0F | P_66:           gen_pminu_xmm(env, s, modrm, MO_8); return;
+    case 0xda | M_0F | P_66 | VEX_128: gen_vpminu_xmm(env, s, modrm, MO_8); return;
+    case 0xda | M_0F | P_66 | VEX_256: gen_vpminu_ymm(env, s, modrm, MO_8); return;
+
     case 0xea | M_0F:                  gen_pmins_mm(env, s, modrm, MO_16); return;
     case 0xea | M_0F | P_66:           gen_pmins_xmm(env, s, modrm, MO_16); return;
     case 0xea | M_0F | P_66 | VEX_128: gen_vpmins_xmm(env, s, modrm, MO_16); return;
-- 
2.20.1


