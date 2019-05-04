Return-Path: <SRS0=Uyhh=TE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A610C43219
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 06:11:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 612F0206BB
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 06:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XV1nax+F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 612F0206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51864 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMntN-00069g-HZ
	for qemu-devel@archiver.kernel.org; Sat, 04 May 2019 02:11:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMnbw-0007sU-6u
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMnbv-0004L5-1z
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:24 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d]:38961)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hMnbu-0004Kp-SM
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:53:22 -0400
Received: by mail-pl1-x62d.google.com with SMTP id e92so3730923plb.6
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 22:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=+vy3D5n9NVcZ5Oj9MBgVyI+mUUxTaLSYcOmzMokmrqg=;
	b=XV1nax+FMF84Szf8k89MeWYtZmaWr9uyOFZZ9IuYA1+nkqwnpUFkELNoXVbj2kduCt
	qmppro2+SFBMwaoFbyrUKZOmR7gRmVxfhYEcb3y4p1y2FRUnVffgXct0X90ljFi8BtVw
	SNBpCp0bzft70F70CCRZfLvKLIstPrS2IU0F1bje8CYkuoHl/m5GzVMhDq63Y+JZm22o
	RBBuHVrueq8e+CM1tNSmlvBrw+nJXs7ygvY1Sy+phTCceINesoZpNckTrEZiZ0OwVHrA
	MRyPiJXe2CBOqydbceXWrymy0gYk+DIodFtjLrJtZIzK/w13q9ihpmBdWGmSdc/4C+qM
	E1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=+vy3D5n9NVcZ5Oj9MBgVyI+mUUxTaLSYcOmzMokmrqg=;
	b=WRme8G9oG3mZge4DJv+7ShPzaRsBjv+5Wes46NDZpRd5EoBMHJJ/O1HNSg7VEyBjRB
	DE+V6nf9EGSAdu46ZZCK8/i0IeSTGJhAgLo6ZjiI18n75XzpR15ccqAUoqYl8IcRxUmW
	en4nd6Pu1m3LBFbVqXfatSlCgOVhwfPSyOKVqjUCCasjuVpcbGaCkR+4jWnb1gl0fI+J
	cbn2JpLTzAF9d207ST5JYPOO99tHl89qTIvZ+4rMwaWDnuVeujfSOqRTpcmcBiahqP+u
	aPhyVhzqzm5NqE1VOb6qxXO2q9rvErZDqNHvLpJUJH5iu0A81CJ4L5HF1LfnLIvFxHSo
	Kn1g==
X-Gm-Message-State: APjAAAU7+qajZ7KFkasrMXtqQ3F7jWkNye8RI1XCcXtjygFvdi6bROua
	0GYxxVn10nPd/mCbdJwU/9I8+lsYhcs=
X-Google-Smtp-Source: APXvYqzHMF+nUyH8tG47XgiXyws7E4YWMzyDwuPvksVQp6+9X1iR6+37fOPkDHoW1bKPaUWgCH2PqQ==
X-Received: by 2002:a17:902:2702:: with SMTP id
	c2mr15980098plb.277.1556949201625; 
	Fri, 03 May 2019 22:53:21 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	15sm6680423pfo.117.2019.05.03.22.53.20
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 03 May 2019 22:53:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri,  3 May 2019 22:52:45 -0700
Message-Id: <20190504055300.18426-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190504055300.18426-1-richard.henderson@linaro.org>
References: <20190504055300.18426-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::62d
Subject: [Qemu-devel] [PATCH v3 16/31] tcg/i386: Support vector variable
 shift opcodes
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
Message-ID: <20190504055245.reGsOBvzvsCXM8Y2U_3_nohU58nexoK18uQd_-REHUE@z>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.h     |  2 +-
 tcg/i386/tcg-target.inc.c | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 241bf19413..b240633455 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -184,7 +184,7 @@ extern bool have_avx2;
 #define TCG_TARGET_HAS_neg_vec          0
 #define TCG_TARGET_HAS_shi_vec          1
 #define TCG_TARGET_HAS_shs_vec          0
-#define TCG_TARGET_HAS_shv_vec          0
+#define TCG_TARGET_HAS_shv_vec          have_avx2
 #define TCG_TARGET_HAS_cmp_vec          1
 #define TCG_TARGET_HAS_mul_vec          1
 #define TCG_TARGET_HAS_sat_vec          1
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 5b33bbd99b..c9448b6d84 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -467,6 +467,11 @@ static inline int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define OPC_VPBROADCASTQ (0x59 | P_EXT38 | P_DATA16)
 #define OPC_VPERMQ      (0x00 | P_EXT3A | P_DATA16 | P_REXW)
 #define OPC_VPERM2I128  (0x46 | P_EXT3A | P_DATA16 | P_VEXL)
+#define OPC_VPSLLVD     (0x47 | P_EXT38 | P_DATA16)
+#define OPC_VPSLLVQ     (0x47 | P_EXT38 | P_DATA16 | P_REXW)
+#define OPC_VPSRAVD     (0x46 | P_EXT38 | P_DATA16)
+#define OPC_VPSRLVD     (0x45 | P_EXT38 | P_DATA16)
+#define OPC_VPSRLVQ     (0x45 | P_EXT38 | P_DATA16 | P_REXW)
 #define OPC_VZEROUPPER  (0x77 | P_EXT)
 #define OPC_XCHG_ax_r32	(0x90)
 
@@ -2707,6 +2712,18 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     static int const umax_insn[4] = {
         OPC_PMAXUB, OPC_PMAXUW, OPC_PMAXUD, OPC_UD2
     };
+    static int const shlv_insn[4] = {
+        /* TODO: AVX512 adds support for MO_16.  */
+        OPC_UD2, OPC_UD2, OPC_VPSLLVD, OPC_VPSLLVQ
+    };
+    static int const shrv_insn[4] = {
+        /* TODO: AVX512 adds support for MO_16.  */
+        OPC_UD2, OPC_UD2, OPC_VPSRLVD, OPC_VPSRLVQ
+    };
+    static int const sarv_insn[4] = {
+        /* TODO: AVX512 adds support for MO_16, MO_64.  */
+        OPC_UD2, OPC_UD2, OPC_VPSRAVD, OPC_UD2
+    };
 
     TCGType type = vecl + TCG_TYPE_V64;
     int insn, sub;
@@ -2759,6 +2776,15 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_umax_vec:
         insn = umax_insn[vece];
         goto gen_simd;
+    case INDEX_op_shlv_vec:
+        insn = shlv_insn[vece];
+        goto gen_simd;
+    case INDEX_op_shrv_vec:
+        insn = shrv_insn[vece];
+        goto gen_simd;
+    case INDEX_op_sarv_vec:
+        insn = sarv_insn[vece];
+        goto gen_simd;
     case INDEX_op_x86_punpckl_vec:
         insn = punpckl_insn[vece];
         goto gen_simd;
@@ -3136,6 +3162,9 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_umin_vec:
     case INDEX_op_smax_vec:
     case INDEX_op_umax_vec:
+    case INDEX_op_shlv_vec:
+    case INDEX_op_shrv_vec:
+    case INDEX_op_sarv_vec:
     case INDEX_op_cmp_vec:
     case INDEX_op_x86_shufps_vec:
     case INDEX_op_x86_blend_vec:
@@ -3193,6 +3222,12 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
         }
         return 1;
 
+    case INDEX_op_shlv_vec:
+    case INDEX_op_shrv_vec:
+        return have_avx2 && vece >= MO_32;
+    case INDEX_op_sarv_vec:
+        return have_avx2 && vece == MO_32;
+
     case INDEX_op_mul_vec:
         if (vece == MO_8) {
             /* We can expand the operation for MO_8.  */
-- 
2.17.1


