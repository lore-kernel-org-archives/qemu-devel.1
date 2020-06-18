Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFDEC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 05:12:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFA6D21852
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 05:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="blXvspUS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFA6D21852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlmqR-00068i-3e
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 01:12:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34344)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlmF1-0007Eo-Gs
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:33:31 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435]:44529)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlmEz-0003fz-Og
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:33:31 -0400
Received: by mail-pf1-x435.google.com with SMTP id 64so2184390pfv.11
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 21:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Afsa8YE1SU9yEO5SjjTLoHbXeJiFUQdZwQR7tGmaBDg=;
 b=blXvspUSxmC5+0slbJlOuc4vGpwgIiNCzCm1NwhJOKlbId8uuYs4M2ziosWoLD1EfV
 Y/Diml7lIxiOghZ60RPeS3ClsAOokOg1zo0RMZB22HlI/sTPztGsQFu6bDL1Fhz+Nr9u
 aJRVhCyZOuOxjA2Rx2FKeNKGVNLiuJIJxn4RWzcn2LF3OHIk2tWI6aVG8q+57ZIBzPB2
 Mg0d/DE+WYGJtBYVZSoh4ndH9mV/KZVuUwXihwPUpaw7RJuj9kH6Sghs0310lyW3mxPt
 syqbJIlfhRhusLLicIy8vBtezm5utE3c0hEH65J7WHALsWdmWnDpVPv/aZA1uoIkJ2u5
 EQUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Afsa8YE1SU9yEO5SjjTLoHbXeJiFUQdZwQR7tGmaBDg=;
 b=sai3x755HcwliHBTVxmG+AWBgC+1hhekoX6hNtuh4u5xqtdzAsmlg1oYe/l045MqYS
 NBWGWTTBxLq/mAsXkNkez22jLnOF1oWQLwGIvata2Fjao0IxhtsCkFlYKodS7mQNCtNr
 vc6arP29H9IrOkEtAzFm84wCSZtkJ9P5TNVhB9UEowiVT+mY79gs0BbxQWAtaSC12Qaz
 +4kyjhyyxMlZH6KX4DNmzB8nAaMQ80bTOiNXSuUc4yDRVNIqHTJ6P2vVGAGxi3os8wYB
 M93m1IZSTvpGThFgKX3/43/DcOlwcomYWKFcA1f223Xqi7eaxaFrBz+RiE3cH3MePjei
 qiFw==
X-Gm-Message-State: AOAM531s23y60DNIGBp0Y4TFG7tqxSFmD0aUKBWdfwpE0F91BW/41SaV
 NrU/x9ZXdkYUTcksdmuIUuNdY5S7fqg=
X-Google-Smtp-Source: ABdhPJx5204KMjW4ioXR+i2y3BSF/Cd3sEctx9iRgS0LtqaxHyekwGibzZTxQceelYODJUKXIULYpg==
X-Received: by 2002:a05:6a00:1510:: with SMTP id
 q16mr1868860pfu.164.1592454807959; 
 Wed, 17 Jun 2020 21:33:27 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id q22sm1288212pfg.192.2020.06.17.21.33.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 21:33:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 094/100] target/arm: Implement SVE2 FLOGB
Date: Wed, 17 Jun 2020 21:26:38 -0700
Message-Id: <20200618042644.1685561-95-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618042644.1685561-1-richard.henderson@linaro.org>
References: <20200618042644.1685561-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

From: Stephen Long <steplong@quicinc.com>

Signed-off-by: Stephen Long <steplong@quicinc.com>
Message-Id: <20200430191405.21641-1-steplong@quicinc.com>
[rth: Fixed esz index and c++ comments]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-sve.h    |  4 ++++
 target/arm/sve.decode      |  3 +++
 target/arm/sve_helper.c    | 49 ++++++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c |  9 +++++++
 4 files changed, 65 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 935655d07a..aa7d113232 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -2256,3 +2256,7 @@ DEF_HELPER_FLAGS_5(sve2_fcvtlt_hs, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve2_fcvtlt_sd, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(flogb_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(flogb_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(flogb_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 6c0e39d553..6808ff4194 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -1581,3 +1581,6 @@ FCVTNT_sh       01100100 10 0010 00 101 ... ..... .....  @rd_pg_rn_e0
 FCVTLT_hs       01100100 10 0010 01 101 ... ..... .....  @rd_pg_rn_e0
 FCVTNT_ds       01100100 11 0010 10 101 ... ..... .....  @rd_pg_rn_e0
 FCVTLT_sd       01100100 11 0010 11 101 ... ..... .....  @rd_pg_rn_e0
+
+### SVE2 floating-point convert to integer
+FLOGB           01100101 00 011 esz:2 0101 pg:3 rn:5 rd:5  &rpr_esz
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 8bfc9393a1..1b92f203c2 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -1121,6 +1121,55 @@ DO_ZPZ_D(sve2_sqneg_d, uint64_t, DO_SQNEG)
 DO_ZPZ(sve2_urecpe_s, uint32_t, H1_4, helper_recpe_u32)
 DO_ZPZ(sve2_ursqrte_s, uint32_t, H1_4, helper_rsqrte_u32)
 
+static int16_t do_float16_logb_as_int(float16 a)
+{
+    if (float16_is_normal(a)) {
+        return extract16(a, 10, 5) - 15;
+    } else if (float16_is_infinity(a)) {
+        return INT16_MAX;
+    } else if (float16_is_any_nan(a) || float16_is_zero(a)) {
+        return INT16_MIN;
+    } else {
+        /* denormal */
+        int shift = 6 - clz32(extract16(a, 0, 10)) - 16;
+        return -15 - shift + 1;
+    }
+}
+
+static int32_t do_float32_logb_as_int(float32 a)
+{
+    if (float32_is_normal(a)) {
+        return extract32(a, 23, 8) - 127;
+    } else if (float32_is_infinity(a)) {
+        return INT32_MAX;
+    } else if (float32_is_any_nan(a) || float32_is_zero(a)) {
+        return INT32_MIN;
+    } else {
+        /* denormal */
+        int shift = 9 - clz32(extract32(a, 0, 23));
+        return -127 - shift + 1;
+    }
+}
+
+static int64_t do_float64_logb_as_int(float64 a)
+{
+    if (float64_is_normal(a)) {
+        return extract64(a, 52, 11) - 1023;
+    } else if (float64_is_infinity(a)) {
+        return INT64_MAX;
+    } else if (float64_is_any_nan(a) || float64_is_zero(a)) {
+        return INT64_MIN;
+    } else {
+        /* denormal */
+        int shift = 12 - clz64(extract64(a, 0, 52));
+        return -1023 - shift + 1;
+    }
+}
+
+DO_ZPZ(flogb_h, float16, H1_2, do_float16_logb_as_int)
+DO_ZPZ(flogb_s, float32, H1_4, do_float32_logb_as_int)
+DO_ZPZ(flogb_d, float64,     , do_float64_logb_as_int)
+
 /* Three-operand expander, unpredicated, in which the third operand is "wide".
  */
 #define DO_ZZW(NAME, TYPE, TYPEW, H, OP)                       \
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 0232381500..f3b2463b7c 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -7841,3 +7841,12 @@ static bool trans_FCVTXNT_ds(DisasContext *s, arg_rpr_esz *a)
     }
     return do_frint_mode(s, a, float_round_to_odd, gen_helper_sve2_fcvtnt_ds);
 }
+
+static bool trans_FLOGB(DisasContext *s, arg_rpr_esz *a)
+{
+    static gen_helper_gvec_3 * const fns[] = {
+        NULL,               gen_helper_flogb_h,
+        gen_helper_flogb_s, gen_helper_flogb_d
+    };
+    return do_sve2_zpz_ool(s, a, fns[a->esz]);
+}
-- 
2.25.1


