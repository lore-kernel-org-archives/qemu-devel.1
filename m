Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E3CC433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 18:45:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29FC92075B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 18:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OfaXH9av"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29FC92075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBjNi-0003u6-AZ
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 14:45:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBjCp-0002n4-H5
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 14:34:31 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41787)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBjCm-00061p-7x
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 14:34:30 -0400
Received: by mail-wr1-x442.google.com with SMTP id w5so47014wrp.8
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 11:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=LATnJEWO7P/MKdEPBDLegkR2imAlvCK9m77w5J9GprA=;
 b=OfaXH9avmFC+6lAjPrkqOaiZKPTTZ541dGcFZJqvbazLttMGcIvUw2TkvS9OsmpYBR
 XW+pOXJJeOZeud5bIzVjdZ+tdaCh+qkopRFCdYZAji8+6x4WMKl/Vh0bXzfAfjlP75sa
 IhYlobyZfkY5leMiZHwRTFcza3pFxXytoqe8FBAgLnh5mp0GUkyrFMHd3aVfSRO0l9ll
 7tgFz7B2dQglQWxtXVkYoKGVg7SEYaN9fFD3Wkx62f952OqRT6RYxapO8BCtNW0oxkeB
 oKM7cEfl5/yD8tTUWNmGKQyspHXzZxAOdABGWacG53xdlqDN7k3MHLcVlNpEA8xD92K3
 dbIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LATnJEWO7P/MKdEPBDLegkR2imAlvCK9m77w5J9GprA=;
 b=BFrW4eGdrnyqOg07AigDeqn/5fLdg/OG5C56vDw1OEBgN49dBUrGV9IacZGTJTLPFA
 5WtZ3HHmcaQRcCpSeTws3WiAqoRfrwe09DYPK7SCoh0kVyZ7DGKH+I8FhTjv5XO38gRp
 I2Ox3RpwY3XBUcPWAtHQu//yahqqzIUFpt/f61NPKO2+SWiUEzxnL6KUrJWvjgtPGaoe
 TYHlUKYBGuKvSDf07C3PyJAdUAbUIZONAFeQMr44sgZgOrw3SpKxRBXtzSDXUxJSIPYP
 w76M556ssOxcNNGj7mYWGViCZOuf+BmoYDZknru5XxC87A08p3/myn/56yVwM4Me2K5K
 BwTg==
X-Gm-Message-State: AOAM53214FICpwkmyb6ZlD5B4MaHFfhkya96EtgzLgztf7HCEV9b2478
 wHb57VnJ2eROe8WoV4MdqlgsKDtykhaWivmn
X-Google-Smtp-Source: ABdhPJwS46x2U17pP2vR2CGDdvtaQC1o0p+/oztuBv5rLOU64ZhU4JdTWbPPhDHU8BgSEp3IhZMJRw==
X-Received: by 2002:adf:edd0:: with SMTP id v16mr267891wro.271.1598639666902; 
 Fri, 28 Aug 2020 11:34:26 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s20sm356251wmh.21.2020.08.28.11.34.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 11:34:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 25/45] target/arm: Implement fp16 for Neon VABS,
 VNEG of floats
Date: Fri, 28 Aug 2020 19:33:34 +0100
Message-Id: <20200828183354.27913-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200828183354.27913-1-peter.maydell@linaro.org>
References: <20200828183354.27913-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x442.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rewrite Neon VABS/VNEG of floats to use gvec logical AND and XOR, so
that we can implement the fp16 version of the insns.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-neon.c.inc | 34 +++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/target/arm/translate-neon.c.inc b/target/arm/translate-neon.c.inc
index 872f093a1fc..a1bf8dcee09 100644
--- a/target/arm/translate-neon.c.inc
+++ b/target/arm/translate-neon.c.inc
@@ -3741,22 +3741,44 @@ static bool trans_VCNT(DisasContext *s, arg_2misc *a)
     return do_2misc(s, a, gen_helper_neon_cnt_u8);
 }
 
+static void gen_VABS_F(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
+                       uint32_t oprsz, uint32_t maxsz)
+{
+    tcg_gen_gvec_andi(vece, rd_ofs, rm_ofs,
+                      vece == MO_16 ? 0x7fff : 0x7fffffff,
+                      oprsz, maxsz);
+}
+
 static bool trans_VABS_F(DisasContext *s, arg_2misc *a)
 {
-    if (a->size != 2) {
+    if (a->size == 1) {
+        if (!dc_isar_feature(aa32_fp16_arith, s)) {
+            return false;
+        }
+    } else if (a->size != 2) {
         return false;
     }
-    /* TODO: FP16 : size == 1 */
-    return do_2misc(s, a, gen_helper_vfp_abss);
+    return do_2misc_vec(s, a, gen_VABS_F);
+}
+
+static void gen_VNEG_F(unsigned vece, uint32_t rd_ofs, uint32_t rm_ofs,
+                       uint32_t oprsz, uint32_t maxsz)
+{
+    tcg_gen_gvec_xori(vece, rd_ofs, rm_ofs,
+                      vece == MO_16 ? 0x8000 : 0x80000000,
+                      oprsz, maxsz);
 }
 
 static bool trans_VNEG_F(DisasContext *s, arg_2misc *a)
 {
-    if (a->size != 2) {
+    if (a->size == 1) {
+        if (!dc_isar_feature(aa32_fp16_arith, s)) {
+            return false;
+        }
+    } else if (a->size != 2) {
         return false;
     }
-    /* TODO: FP16 : size == 1 */
-    return do_2misc(s, a, gen_helper_vfp_negs);
+    return do_2misc_vec(s, a, gen_VNEG_F);
 }
 
 static bool trans_VRECPE(DisasContext *s, arg_2misc *a)
-- 
2.20.1


