Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16874C43465
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 19:05:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9803F21707
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 19:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SxywB5ra"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9803F21707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJLhC-0002N0-N6
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 15:05:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLHo-0000nl-J0
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:39:10 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:33105)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLHj-0007Cn-DN
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:39:08 -0400
Received: by mail-pl1-x642.google.com with SMTP id d19so3450878pld.0
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 11:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5ZRxRihoVdRLpqF0F3gozSyDHbCAhl2YZuePR17xmiA=;
 b=SxywB5ra8Z28Oz/tQ45mwVcuJ9sxykj8+VBSMyrkJ/qxFcJSx38rk3bna/VVXPK925
 Rbarsn6KHxwGeQ+ApT4aghgIcGPtMh6BoRdXFM2PwDSZnoIOlk8wu0EF7i24JiUrO/DK
 /Ah2d6Wj3JDJRxDPfedv7hwAS5H6CBNEiHkPtSfpNGH4zYYGugS88SYOxXyOZq5DOjyv
 l5x39Q9+zpDEu5zIOZ+whKluQBjvIi94YHwE0QuRkroGq5HwXrnQ++qf3VKY37WlR0GN
 W4MBhkGG34o0Sjmjuq2FgzqF+lezUgrC4TpqMRk4uMYBZfRgV8qlUkieYq4k7HJmE0JH
 TuMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5ZRxRihoVdRLpqF0F3gozSyDHbCAhl2YZuePR17xmiA=;
 b=awRI9ODdEpj0O1MN+NRyYQRo4CfAI15Bh8VqrHfXcUV0gwhQf2zLisLhxnuRkKndkA
 AdnqBVoQlGQ6DC7xEd8QADGi5B6WN5kYwdL8HbgRLwBxpgCh2cimpqpFxn2z0rMropKv
 3k/0x2OYt8b/bUzMas2iAx+NO/3VsvYbW8FnST+sGFJ+B49PVzxZ6SAdRiw8AU2TJmBm
 ECBfczLbdNveiZYMJ2XCw3apnf1IkqodClZc+4/gwzu8W7Gw4hXfxbZaS34TYSVuY4V4
 UZBiqgv7YIe/4YkVbS8aQfAZPuv6Ofk8Lho8h6PrAItsD5Jw7RHdI1GF35QQdx2B/lQO
 Cv8A==
X-Gm-Message-State: AOAM531Nd8Vpn+wlLgGKr+3Wh8kfrzsZzQq0OJdUb9P25McgfOY9G/Xe
 Woxw+yom7VBIWQT/tvvAkIeD1+DLs0a8Qg==
X-Google-Smtp-Source: ABdhPJzGdzG6PI8aVnOToVhOY+jyqJCDJlTsi33r2NzZ8BVtNiizwqfc/mH5LQJlE8Zql22scjNYCA==
X-Received: by 2002:a17:90a:9403:: with SMTP id
 r3mr14677177pjo.52.1600454338371; 
 Fri, 18 Sep 2020 11:38:58 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id f4sm3680723pfj.147.2020.09.18.11.38.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 11:38:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 50/81] target/arm: Implement SVE2 SPLICE, EXT
Date: Fri, 18 Sep 2020 11:37:20 -0700
Message-Id: <20200918183751.2787647-51-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918183751.2787647-1-richard.henderson@linaro.org>
References: <20200918183751.2787647-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org,
 Stephen Long <steplong@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stephen Long <steplong@quicinc.com>

Signed-off-by: Stephen Long <steplong@quicinc.com>
Message-Id: <20200423180347.9403-1-steplong@quicinc.com>
[rth: Rename the trans_* functions to *_sve2.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/sve.decode      | 11 +++++++++--
 target/arm/translate-sve.c | 35 ++++++++++++++++++++++++++++++-----
 2 files changed, 39 insertions(+), 7 deletions(-)

diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 11e724d3a2..0688dae450 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -494,10 +494,14 @@ CPY_z_i         00000101 .. 01 .... 00 . ........ .....   @rdn_pg4 imm=%sh8_i8s
 
 ### SVE Permute - Extract Group
 
-# SVE extract vector (immediate offset)
+# SVE extract vector (destructive)
 EXT             00000101 001 ..... 000 ... rm:5 rd:5 \
                 &rrri rn=%reg_movprfx imm=%imm8_16_10
 
+# SVE2 extract vector (constructive)
+EXT_sve2        00000101 011 ..... 000 ... rn:5 rd:5 \
+                &rri imm=%imm8_16_10
+
 ### SVE Permute - Unpredicated Group
 
 # SVE broadcast general register
@@ -588,9 +592,12 @@ REVH            00000101 .. 1001 01 100 ... ..... .....         @rd_pg_rn
 REVW            00000101 .. 1001 10 100 ... ..... .....         @rd_pg_rn
 RBIT            00000101 .. 1001 11 100 ... ..... .....         @rd_pg_rn
 
-# SVE vector splice (predicated)
+# SVE vector splice (predicated, destructive)
 SPLICE          00000101 .. 101 100 100 ... ..... .....         @rdn_pg_rm
 
+# SVE2 vector splice (predicated, constructive)
+SPLICE_sve2     00000101 .. 101 101 100 ... ..... .....         @rd_pg_rn
+
 ### SVE Select Vectors Group
 
 # SVE select vector elements (predicated)
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 63acb25921..5e8291e44b 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -2266,18 +2266,18 @@ static bool trans_CPY_z_i(DisasContext *s, arg_CPY_z_i *a)
  *** SVE Permute Extract Group
  */
 
-static bool trans_EXT(DisasContext *s, arg_EXT *a)
+static bool do_EXT(DisasContext *s, int rd, int rn, int rm, int imm)
 {
     if (!sve_access_check(s)) {
         return true;
     }
 
     unsigned vsz = vec_full_reg_size(s);
-    unsigned n_ofs = a->imm >= vsz ? 0 : a->imm;
+    unsigned n_ofs = imm >= vsz ? 0 : imm;
     unsigned n_siz = vsz - n_ofs;
-    unsigned d = vec_full_reg_offset(s, a->rd);
-    unsigned n = vec_full_reg_offset(s, a->rn);
-    unsigned m = vec_full_reg_offset(s, a->rm);
+    unsigned d = vec_full_reg_offset(s, rd);
+    unsigned n = vec_full_reg_offset(s, rn);
+    unsigned m = vec_full_reg_offset(s, rm);
 
     /* Use host vector move insns if we have appropriate sizes
      * and no unfortunate overlap.
@@ -2296,6 +2296,19 @@ static bool trans_EXT(DisasContext *s, arg_EXT *a)
     return true;
 }
 
+static bool trans_EXT(DisasContext *s, arg_EXT *a)
+{
+    return do_EXT(s, a->rd, a->rn, a->rm, a->imm);
+}
+
+static bool trans_EXT_sve2(DisasContext *s, arg_rri *a)
+{
+    if (!dc_isar_feature(aa64_sve2, s)) {
+        return false;
+    }
+    return do_EXT(s, a->rd, a->rn, (a->rn + 1) % 32, a->imm);
+}
+
 /*
  *** SVE Permute - Unpredicated Group
  */
@@ -3023,6 +3036,18 @@ static bool trans_SPLICE(DisasContext *s, arg_rprr_esz *a)
     return true;
 }
 
+static bool trans_SPLICE_sve2(DisasContext *s, arg_rpr_esz *a)
+{
+    if (!dc_isar_feature(aa64_sve2, s)) {
+        return false;
+    }
+    if (sve_access_check(s)) {
+        gen_gvec_ool_zzzp(s, gen_helper_sve_splice,
+                          a->rd, a->rn, (a->rn + 1) % 32, a->pg, a->esz);
+    }
+    return true;
+}
+
 /*
  *** SVE Integer Compare - Vectors Group
  */
-- 
2.25.1


