Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 576AAC43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 19:01:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB87021707
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 19:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WwSfg2Ly"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB87021707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJLdI-0006gN-R4
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 15:01:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLHA-0008TI-W1
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:38:29 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:44087)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLH9-00077E-8A
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:38:28 -0400
Received: by mail-pg1-x542.google.com with SMTP id 7so3962343pgm.11
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 11:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wCS+cVDKywQG7aSiFHHNebXlRWHY40+AHdDnJu3EQvg=;
 b=WwSfg2LyyJTsegKz+1o6Yqfwbq56Gsox3djP3zLOGYWSX+ASFU0EtMO1l28o8MNi5o
 tTrCXkCzEuAqMvVrgKC9De6gjtFaWDI5rOMvXM1tVEADdY+EcNZEaxkrvWPLqKJWDA4Y
 l14KCvPgBIxgipMBZ9dSaVRaFTGSlS9Q4DJQ/tfzgaJEXo6/tItadHlBkRGcmAxUfNir
 cB1PGEjOv2STUpYKFaLyO/3cJ0C7KsSibZDsWFlUdjNmyq+snVSXYNK9IbhucwX14sjB
 Nfl9uo7g30ztvWaPllzh0cd5/PZ+UZ91hazdMYHkUu+REXI1fchdH82Vy2uQSfT4KQVx
 FzKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wCS+cVDKywQG7aSiFHHNebXlRWHY40+AHdDnJu3EQvg=;
 b=Dq/XLmEHQG/P3RWeCOujRDS6CVMPZmfD469/YDxA0p0zhQk4OpS3lCV1AwUX19gkem
 xicy2PS9cMALCOxEX2e+qlNyrzoR3U7k/8W4zEz03X/Ep+Mz6ap4Q8T7hQNYaTaqGSpF
 DQW1IAB4kiU6kwzT65Ap6XWO+RDIBZUtiCMUVE2S7VN3ICX0yjN9KFPUhEB0+LHGqqfU
 tF60VGs+vdVct5qAR4z4rLNGlA04hxHTttiniU+JJUYLlLl/bjZ+nLiVqFlw32XNm4O6
 sW+hnOIWzwMBShvt3XnRkjurkA2BlZY78Ycsvb0j3wRMv+IvWjdpOpBiYu0r3Y5gTRbL
 3Whw==
X-Gm-Message-State: AOAM53207eXMrlloWWwA7GJuEvz9q1ALPH3XG++Y95z9d/lPEXIFMoAw
 IGzwl6iT3XyLyG8jrwZusBmC5R/7bafR+g==
X-Google-Smtp-Source: ABdhPJyvNUkb+i4BfPmNxxwqYzALqi2aO8OlVy2BrLa/eimvsqN2roDNM47XVfffn6b7x/YfRUfrMA==
X-Received: by 2002:a62:2985:0:b029:142:2501:34d6 with SMTP id
 p127-20020a6229850000b0290142250134d6mr16931074pfp.47.1600454305403; 
 Fri, 18 Sep 2020 11:38:25 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id f4sm3680723pfj.147.2020.09.18.11.38.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 11:38:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 24/81] target/arm: Implement SVE2 bitwise shift right and
 accumulate
Date: Fri, 18 Sep 2020 11:36:54 -0700
Message-Id: <20200918183751.2787647-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918183751.2787647-1-richard.henderson@linaro.org>
References: <20200918183751.2787647-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/sve.decode      |  8 ++++++++
 target/arm/translate-sve.c | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index f4f0c2ade6..7783e9f0d3 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -1253,3 +1253,11 @@ UABALT          01000101 .. 0 ..... 1100 11 ..... .....  @rda_rn_rm
 # ADC and SBC decoded via size in helper dispatch.
 ADCLB           01000101 .. 0 ..... 11010 0 ..... .....  @rda_rn_rm
 ADCLT           01000101 .. 0 ..... 11010 1 ..... .....  @rda_rn_rm
+
+## SVE2 bitwise shift right and accumulate
+
+# TODO: Use @rda and %reg_movprfx here.
+SSRA            01000101 .. 0 ..... 1110 00 ..... .....  @rd_rn_tszimm_shr
+USRA            01000101 .. 0 ..... 1110 01 ..... .....  @rd_rn_tszimm_shr
+SRSRA           01000101 .. 0 ..... 1110 10 ..... .....  @rd_rn_tszimm_shr
+URSRA           01000101 .. 0 ..... 1110 11 ..... .....  @rd_rn_tszimm_shr
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 4e23b6cedd..312a47f4b9 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -6404,3 +6404,37 @@ static bool trans_ADCLT(DisasContext *s, arg_rrrr_esz *a)
 {
     return do_adcl(s, a, true);
 }
+
+static bool do_sve2_fn2i(DisasContext *s, arg_rri_esz *a, GVecGen2iFn *fn)
+{
+    if (a->esz < 0 || !dc_isar_feature(aa64_sve2, s)) {
+        return false;
+    }
+    if (sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        unsigned rd_ofs = vec_full_reg_offset(s, a->rd);
+        unsigned rn_ofs = vec_full_reg_offset(s, a->rn);
+        fn(a->esz, rd_ofs, rn_ofs, a->imm, vsz, vsz);
+    }
+    return true;
+}
+
+static bool trans_SSRA(DisasContext *s, arg_rri_esz *a)
+{
+    return do_sve2_fn2i(s, a, gen_gvec_ssra);
+}
+
+static bool trans_USRA(DisasContext *s, arg_rri_esz *a)
+{
+    return do_sve2_fn2i(s, a, gen_gvec_usra);
+}
+
+static bool trans_SRSRA(DisasContext *s, arg_rri_esz *a)
+{
+    return do_sve2_fn2i(s, a, gen_gvec_srsra);
+}
+
+static bool trans_URSRA(DisasContext *s, arg_rri_esz *a)
+{
+    return do_sve2_fn2i(s, a, gen_gvec_ursra);
+}
-- 
2.25.1


