Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62C0C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 04:44:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72C48217A0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 04:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JLlKlYXW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72C48217A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlmPK-0002zg-Lz
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 00:44:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60356)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlmAn-0006Mg-P4
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:29:09 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d]:33076)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlmAl-0002pz-Im
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:29:09 -0400
Received: by mail-pj1-x102d.google.com with SMTP id b7so2992272pju.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 21:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Btw/zR3v/WcQMscyvUdDkvxOAuzTlZGL36/usijpg7k=;
 b=JLlKlYXWvWcByoVw8pHVLCCQ1hcy2etH2tlGbnzOxRGS/vec7bS2gEqb1AmYbt4rH9
 6zWZ+i2yKfN5RpcYccgYXiLrsmUXPmbvuNggZSXfDHdYEDZrGcIv2Ltgtu7kKPhINpRc
 7eKJsALy5bNthem+6Bs7IQcYDv2Ugr8CnAJ8j8Y2DivUTC0ITLPd8D3Ryd0F5IPe5wwt
 h1Z9p4i4zhJkqtYxk5faSW/GfMegRw128LsiHywk79Dj0WapqM384lPgIkc0wm1UDINE
 DqPSlIthQH2T1/3Psnhg9ogAEjZdX89cnB27MtMlfO+nPEu8KN3pekg8Wen8brxFX45H
 iWGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Btw/zR3v/WcQMscyvUdDkvxOAuzTlZGL36/usijpg7k=;
 b=kahisY4j2htap29LYduxiKIlf/qtnBTWo1ENNhWNcssZZgl7ZndeZT3g4ZoNmeYEU9
 8qFt5WJJmSxaP0fc9ZioakeP1t28fv8OpVHzgOpwJObTB64FiK/o2nmvfKusR2jkHsX1
 kmgn/Ut5PM2ptvNf3rMnAt3Ffedx9Ps1DNingsov+XPiHF+/dMKHxiB5TTSsWgV/lYsz
 Xmam3Ik0iFAtcdXfM9mRw5nDfl6DqO3JLBinJRcnC/FzOaol4ah7ecq1JtCs3uSEi4/b
 R7Xh0BTna6/WK71BuH3sv0p3f+nvdvPc5NZBaUnKtnNfPISW3Zaiq0F31Kd04eBPmyaN
 NvjA==
X-Gm-Message-State: AOAM533I8TIZtGnvrAP6C0bzS6hbngQlwL+hTeKAc1wBXFthRXTtwgtS
 6FuWVU5uWlY8sXMnrpbQQy+4sleaiLY=
X-Google-Smtp-Source: ABdhPJxOvVMdEwzhk8SKFIACEpYSHgMhOe2mRa9YWs/etV8dQ/x44vP19U+xavZB/przjOdAew2o1A==
X-Received: by 2002:a17:902:b60f:: with SMTP id
 b15mr2179926pls.248.1592454545877; 
 Wed, 17 Jun 2020 21:29:05 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id mu17sm972324pjb.53.2020.06.17.21.29.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 21:29:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 036/100] target/arm: Implement SVE2 bitwise shift right and
 accumulate
Date: Wed, 17 Jun 2020 21:25:40 -0700
Message-Id: <20200618042644.1685561-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618042644.1685561-1-richard.henderson@linaro.org>
References: <20200618042644.1685561-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-arm@nongnu.org, steplong@quicinc.com
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
index 9131b6d546..3dcc67740f 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -5960,3 +5960,37 @@ static bool trans_ADCLT(DisasContext *s, arg_rrrr_esz *a)
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


