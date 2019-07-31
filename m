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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 031D1C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 18:01:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7BE62067D
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 18:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Do4vEYQn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7BE62067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hssvD-0002LK-45
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 14:01:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42787)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hssrF-0002Gu-OW
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 13:57:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hssrE-0002oy-EP
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 13:57:49 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:43843)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hssrE-0002o5-9W
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 13:57:48 -0400
Received: by mail-yb1-xb42.google.com with SMTP id y123so21711716yby.10
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 10:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1ZMG70QtK9GLeaErFuDoQBPgLSJCesIXqA/tYDobWRA=;
 b=Do4vEYQniXhgsHXc4ZMrA4zVV/kJf5CsQSVIEbvjhqXDcPO2mc73F4/33XGTZ99fAM
 coTmYWHcZb3Jj+uvE20Vw3/BMBuJG/IqoVwDvfVVRUWUelXEc8E2KfrlfwpEXmEqkbcL
 kDQ/+YRncDIZwiO7XZfp5zBb0vM6C4pTXQFd5UJNHOBF90/FDFVIiIw5Mfls2EpDCXwj
 L1mLabX611Ue/Fs7OPS9n664p0tT0aHfXzK59egju5ZfZomRw+MfrnnneZvVLvbCxEyk
 jxNjdbvWRxJQDmbY3Hv7xOlbNwtL3cMNK9ZPh44WUYnm9ltaNgA4bBYG1Li4fLo0hxUi
 FNDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1ZMG70QtK9GLeaErFuDoQBPgLSJCesIXqA/tYDobWRA=;
 b=MoThi1S0yz+2+7Ak5BsGcdXOfiouzPOWxz/6UJW8s87LqGNWnevHn9VUTtDcVDoQrf
 9yp8QhH0kc0DoGPCV7KmP/WQphzPidmEF3/PaiEu/6aelBQoYDm0i29FlP70QebncvOM
 rAP5X5h8+gWOvFDbyZquHNU9hwXo4pUS6EBuxRiIeraIg/5GhkkLPJsx50diBcnSogPv
 1qCPITPKIPpZY8XtSCwZpRIdkMe81Iok6a38J+qswC2ze65Uula1etK7xpdVlBxEo6rw
 ApHbWgVmgf0PnJ2I6s5MDvUzFTnwEuQq5FRxfQsF7O95wAKMdKQYJL/fngiyblue8h3J
 zWjw==
X-Gm-Message-State: APjAAAWRFi+k16wQm/wPtT5xCawcu+hCYUyjlz/fgd2e/ByrobdxvpL5
 CkzlrLqP7RD84GrdZntrhjiLJh3r
X-Google-Smtp-Source: APXvYqwUtToOSEgj3bOyUPF1cR/TiZs2oIrrgSARYQyB7UkyhlALL67ZWmf8mwgniAj5jesRLg6X2A==
X-Received: by 2002:a25:d391:: with SMTP id
 e139mr70865666ybf.331.1564595867647; 
 Wed, 31 Jul 2019 10:57:47 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id 206sm16077696ywk.44.2019.07.31.10.57.47
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 10:57:47 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 13:56:51 -0400
Message-Id: <20190731175702.4916-12-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190731175702.4916-1-jan.bobek@gmail.com>
References: <20190731175702.4916-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b42
Subject: [Qemu-devel] [RFC PATCH v1 11/22] target/i386: reimplement (V)PANDN,
 (V)ANDNPS, (V)ANDNPD
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
 target/i386/translate.c      | 26 ++++++++++++++++++++++++--
 3 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/target/i386/ops_sse.h b/target/i386/ops_sse.h
index 68dbeda047..84562a4536 100644
--- a/target/i386/ops_sse.h
+++ b/target/i386/ops_sse.h
@@ -353,8 +353,6 @@ static inline int satsw(int x)
 #define FMAXUB(a, b) ((a) > (b)) ? (a) : (b)
 #define FMAXSW(a, b) ((int16_t)(a) > (int16_t)(b)) ? (a) : (b)
 
-#define FANDN(a, b) ((~(a)) & (b))
-
 #define FCMPGTB(a, b) ((int8_t)(a) > (int8_t)(b) ? -1 : 0)
 #define FCMPGTW(a, b) ((int16_t)(a) > (int16_t)(b) ? -1 : 0)
 #define FCMPGTL(a, b) ((int32_t)(a) > (int32_t)(b) ? -1 : 0)
@@ -394,8 +392,6 @@ SSE_HELPER_B(helper_pmaxub, FMAXUB)
 SSE_HELPER_W(helper_pminsw, FMINSW)
 SSE_HELPER_W(helper_pmaxsw, FMAXSW)
 
-SSE_HELPER_Q(helper_pandn, FANDN)
-
 SSE_HELPER_B(helper_pcmpgtb, FCMPGTB)
 SSE_HELPER_W(helper_pcmpgtw, FCMPGTW)
 SSE_HELPER_L(helper_pcmpgtl, FCMPGTL)
diff --git a/target/i386/ops_sse_header.h b/target/i386/ops_sse_header.h
index a98b9f8f3f..abd00ca69d 100644
--- a/target/i386/ops_sse_header.h
+++ b/target/i386/ops_sse_header.h
@@ -86,8 +86,6 @@ SSE_HELPER_B(pmaxub, FMAXUB)
 SSE_HELPER_W(pminsw, FMINSW)
 SSE_HELPER_W(pmaxsw, FMAXSW)
 
-SSE_HELPER_Q(pandn, FANDN)
-
 SSE_HELPER_B(pcmpgtb, FCMPGTB)
 SSE_HELPER_W(pcmpgtw, FCMPGTW)
 SSE_HELPER_L(pcmpgtl, FCMPGTL)
diff --git a/target/i386/translate.c b/target/i386/translate.c
index cfe285e3e5..69e9514679 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -2757,7 +2757,7 @@ static const SSEFunc_0_epp sse_op_table1[256][4] = {
     [0x52] = { gen_helper_rsqrtps, NULL, gen_helper_rsqrtss, NULL },
     [0x53] = { gen_helper_rcpps, NULL, gen_helper_rcpss, NULL },
     [0x54] = { SSE_TOMBSTONE, SSE_TOMBSTONE }, /* andps, andpd */
-    [0x55] = { gen_helper_pandn_xmm, gen_helper_pandn_xmm }, /* andnps, andnpd */
+    [0x55] = { SSE_TOMBSTONE, SSE_TOMBSTONE }, /* andnps, andnpd */
     [0x56] = { SSE_TOMBSTONE, SSE_TOMBSTONE }, /* orps, orpd */
     [0x57] = { SSE_TOMBSTONE, SSE_TOMBSTONE }, /* xorps, xorpd */
     [0x58] = SSE_FOP(add),
@@ -2829,7 +2829,7 @@ static const SSEFunc_0_epp sse_op_table1[256][4] = {
     [0xdc] = MMX_OP2(paddusb),
     [0xdd] = MMX_OP2(paddusw),
     [0xde] = MMX_OP2(pmaxub),
-    [0xdf] = MMX_OP2(pandn),
+    [0xdf] = { SSE_TOMBSTONE, SSE_TOMBSTONE },
     [0xe0] = MMX_OP2(pavgb),
     [0xe1] = MMX_OP2(psraw),
     [0xe2] = MMX_OP2(psrad),
@@ -3177,6 +3177,17 @@ static inline void gen_gvec_ld_modrm_3(CPUX86State *env, DisasContext *s,
 #define gen_vandpd_xmm gen_vpand_xmm
 #define gen_vandpd_ymm gen_vpand_ymm
 
+#define gen_pandn_mm(env, s, modrm)   gen_gvec_ld_modrm_mm  ((env), (s), (modrm), MO_64, tcg_gen_gvec_andc, 0121)
+#define gen_pandn_xmm(env, s, modrm)  gen_gvec_ld_modrm_xmm ((env), (s), (modrm), MO_64, tcg_gen_gvec_andc, 0121)
+#define gen_vpandn_xmm(env, s, modrm) gen_gvec_ld_modrm_vxmm((env), (s), (modrm), MO_64, tcg_gen_gvec_andc, 0132)
+#define gen_vpandn_ymm(env, s, modrm) gen_gvec_ld_modrm_vymm((env), (s), (modrm), MO_64, tcg_gen_gvec_andc, 0132)
+#define gen_andnps_xmm  gen_pandn_xmm
+#define gen_vandnps_xmm gen_vpandn_xmm
+#define gen_vandnps_ymm gen_vpandn_ymm
+#define gen_andnpd_xmm  gen_pandn_xmm
+#define gen_vandnpd_xmm gen_vpandn_xmm
+#define gen_vandnpd_ymm gen_vpandn_ymm
+
 #define gen_por_mm(env, s, modrm)   gen_gvec_ld_modrm_mm  ((env), (s), (modrm), MO_64, tcg_gen_gvec_or, 0112)
 #define gen_por_xmm(env, s, modrm)  gen_gvec_ld_modrm_xmm ((env), (s), (modrm), MO_64, tcg_gen_gvec_or, 0112)
 #define gen_vpor_xmm(env, s, modrm) gen_gvec_ld_modrm_vxmm((env), (s), (modrm), MO_64, tcg_gen_gvec_or, 0123)
@@ -3301,6 +3312,17 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b)
     case 0x54 | M_0F | P_66 | VEX_128: gen_vandpd_xmm(env, s, modrm); return;
     case 0x54 | M_0F | P_66 | VEX_256: gen_vandpd_ymm(env, s, modrm); return;
 
+    case 0xdf | M_0F:                  gen_pandn_mm(env, s, modrm); return;
+    case 0xdf | M_0F | P_66:           gen_pandn_xmm(env, s, modrm); return;
+    case 0xdf | M_0F | P_66 | VEX_128: gen_vpandn_xmm(env, s, modrm); return;
+    case 0xdf | M_0F | P_66 | VEX_256: gen_vpandn_ymm(env, s, modrm); return;
+    case 0x55 | M_0F:                  gen_andnps_xmm(env, s, modrm); return;
+    case 0x55 | M_0F | VEX_128:        gen_vandnps_xmm(env, s, modrm); return;
+    case 0x55 | M_0F | VEX_256:        gen_vandnps_ymm(env, s, modrm); return;
+    case 0x55 | M_0F | P_66:           gen_andnpd_xmm(env, s, modrm); return;
+    case 0x55 | M_0F | P_66 | VEX_128: gen_vandnpd_xmm(env, s, modrm); return;
+    case 0x55 | M_0F | P_66 | VEX_256: gen_vandnpd_ymm(env, s, modrm); return;
+
     case 0xeb | M_0F:                  gen_por_mm(env, s, modrm); return;
     case 0xeb | M_0F | P_66:           gen_por_xmm(env, s, modrm); return;
     case 0xeb | M_0F | P_66 | VEX_128: gen_vpor_xmm(env, s, modrm); return;
-- 
2.20.1


