Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29AB2C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 17:06:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E07CE23AA0
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 17:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZXaSMdBA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E07CE23AA0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6zdQ-0002L9-5W
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 13:06:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42400)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6zck-0001uK-OF
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 13:05:42 -0400
Received: from mail-vs1-xe42.google.com ([2607:f8b0:4864:20::e42]:41300)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6zci-0001Fn-RZ
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 13:05:42 -0400
Received: by mail-vs1-xe42.google.com with SMTP id y8so6214799vsq.8
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2020 10:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=13iDMrHB1KJoXoePiZR2R7O74YXAoVM8bGBrZHlUo/Q=;
 b=ZXaSMdBA1dKdayya5wF/mC1h5ohEFE3DXamlItJIzh+iz1gwu1zhmY971tu5h1CEIV
 K+oB5ZrXfK82etO8HzqMYnhzZUEbEQ/scApzwXX8F6knQ++jQxkoPUBOihfuJrCWItQ6
 Smzlpy3xqMivwQtyJKv6beiwhpAH4ACg5r/v6hSzWekjl+tHKG6vd6cPy5gdJ6vNgfFO
 ULaMBMNZyd2cKsewyfS5O/ig759hktDgOusQTIxezlOpGw7PHEPAB+86pmziRNmZnuj7
 Wdh9PkM/hx3hxZteCNwy4j6Df1qwRnP/DHWMlg/4kkwQdJjS9mTUvPdeF7hMO7d61Xu0
 je1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=13iDMrHB1KJoXoePiZR2R7O74YXAoVM8bGBrZHlUo/Q=;
 b=Nl4PTEIcVP+dFfD44fLqNH7jMDZ3eBVnxtcWgzmFP97e5vVvr2itmd7MHgQ5f+ZQmJ
 sLuO/ci0RS63R6SXj/rapWfj7MGEVwgfMvQOfF2kyuDNXR68SFAe1Y/N7+h1M5S4TZjz
 ix6Zp91U4f485Mphq8CKbB5KD8dng99C8bCBC3DvC9XqJvAK2TypWIL2nqn2SiScZSNV
 xe0FnbITrg+3KZWYCmn3qV1sxO7t6nTSbGdhDg4+1wTtaCkp8g6QfvJIFaX2/cWvrl2X
 VT3dQ8HeTVZ+L7Uxp41YF/cRS710AMznyXhScIc5xlvfisOmhMc12pnv2Fj/le4+ZXmZ
 4Rgg==
X-Gm-Message-State: AOAM530+CFBqo2tKHHUulRSZ6HOGf6Q13aPHrH2/mZKRW1SDmL+ROOzv
 WD8R17oz6l/nrGruVEXwmQ4ltc6w2TlFNg==
X-Google-Smtp-Source: ABdhPJwaagQ+DJMkz++nuby27VgKrRCmUKLdrTR1B7mTLuv2eJuJyWbm0xiqfTipvP7gLuuDwDgOBw==
X-Received: by 2002:a62:17c1:: with SMTP id 184mr3619805pfx.136.1597455121146; 
 Fri, 14 Aug 2020 18:32:01 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id y196sm10625528pfc.202.2020.08.14.18.31.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2020 18:32:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/20] target/arm: Split out gen_gvec_ool_zzp
Date: Fri, 14 Aug 2020 18:31:35 -0700
Message-Id: <20200815013145.539409-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200815013145.539409-1-richard.henderson@linaro.org>
References: <20200815013145.539409-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::e42;
 envelope-from=richard.henderson@linaro.org; helo=mail-vs1-xe42.google.com
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Model after gen_gvec_fn_zzz et al.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-sve.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index ea6058f7ef..3361e1c01f 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -142,6 +142,17 @@ static int pred_gvec_reg_size(DisasContext *s)
     return size_for_gvec(pred_full_reg_size(s));
 }
 
+/* Invoke an out-of-line helper on 2 Zregs and a predicate. */
+static void gen_gvec_ool_zzp(DisasContext *s, gen_helper_gvec_3 *fn,
+                             int rd, int rn, int pg, int data)
+{
+    unsigned vsz = vec_full_reg_size(s);
+    tcg_gen_gvec_3_ool(vec_full_reg_offset(s, rd),
+                       vec_full_reg_offset(s, rn),
+                       pred_full_reg_offset(s, pg),
+                       vsz, vsz, data, fn);
+}
+
 /* Invoke an out-of-line helper on 3 Zregs and a predicate. */
 static void gen_gvec_ool_zzzp(DisasContext *s, gen_helper_gvec_4 *fn,
                               int rd, int rn, int rm, int pg, int data)
@@ -415,11 +426,7 @@ static bool do_zpz_ool(DisasContext *s, arg_rpr_esz *a, gen_helper_gvec_3 *fn)
         return false;
     }
     if (sve_access_check(s)) {
-        unsigned vsz = vec_full_reg_size(s);
-        tcg_gen_gvec_3_ool(vec_full_reg_offset(s, a->rd),
-                           vec_full_reg_offset(s, a->rn),
-                           pred_full_reg_offset(s, a->pg),
-                           vsz, vsz, 0, fn);
+        gen_gvec_ool_zzp(s, fn, a->rd, a->rn, a->pg, 0);
     }
     return true;
 }
@@ -603,11 +610,7 @@ static bool do_movz_zpz(DisasContext *s, int rd, int rn, int pg,
     };
 
     if (sve_access_check(s)) {
-        unsigned vsz = vec_full_reg_size(s);
-        tcg_gen_gvec_3_ool(vec_full_reg_offset(s, rd),
-                           vec_full_reg_offset(s, rn),
-                           pred_full_reg_offset(s, pg),
-                           vsz, vsz, invert, fns[esz]);
+        gen_gvec_ool_zzp(s, fns[esz], rd, rn, pg, invert);
     }
     return true;
 }
@@ -616,11 +619,7 @@ static bool do_zpzi_ool(DisasContext *s, arg_rpri_esz *a,
                         gen_helper_gvec_3 *fn)
 {
     if (sve_access_check(s)) {
-        unsigned vsz = vec_full_reg_size(s);
-        tcg_gen_gvec_3_ool(vec_full_reg_offset(s, a->rd),
-                           vec_full_reg_offset(s, a->rn),
-                           pred_full_reg_offset(s, a->pg),
-                           vsz, vsz, a->imm, fn);
+        gen_gvec_ool_zzp(s, fn, a->rd, a->rn, a->pg, a->imm);
     }
     return true;
 }
-- 
2.25.1


