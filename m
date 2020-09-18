Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37262C43465
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 19:18:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1DB62311A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 19:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LA7TRKyV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1DB62311A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJLu5-00085y-Oo
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 15:18:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48806)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLI9-0000zi-Eo
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:39:29 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032]:34499)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLHz-0007G4-W0
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:39:29 -0400
Received: by mail-pj1-x1032.google.com with SMTP id s14so4600284pju.1
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 11:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6pRicJYepiyqiE8M6Kw+idIsYMGa+wHuvAaulUdBdwc=;
 b=LA7TRKyVV+MSF0vedJX/wfNekYOcv+odUK+08KoI1/9saFwUXrXpxSvTQRJ+/LaHHk
 X55+OTA7EEjPwN1qL4KGklu+G09IwjAKmkS1/fOdpjOrIZFQVvUjDyQAhDk6NiLwtkgt
 OfWycUaRb3B6PfW1ydwDIE4ZV5A99Rudb3BCHgrOFTHiEc/B2Kf4lbXO6685rRvCH1jL
 4iKmW2iRthJ6OXDM3RPoxgoKjq+ZuGJ6y9DeR6DNlnGJ/YfBZ7hZT3/9Q8h2SXRuE6mu
 0EH6nZoNtIYCjKc/9PrciKcDkTKMouum8yiRWdnIYUfhXNjYJdrsNBbsiECtWRpZAuYF
 xkkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6pRicJYepiyqiE8M6Kw+idIsYMGa+wHuvAaulUdBdwc=;
 b=cM7JiNGINRlG7l5DKKMhH2HlMy49VQi119YA1Nqbyv/jqexfYEk7TBK6Lgh2Sh45rA
 lhYNVkkHVJ7L7YpiSloqh2qPi3iqQu3xl/+ySbO0lr3JNbb/Pr1l2n+3gmrWH0jkjbxu
 Vhv3V50w7X7awb5cb9JhUDKbP1v1J7zlhu9toINxU2qKC+Pa7MYYYvPSHQEBEHORShVJ
 /YBya8PyAgbtCPucbNkp96zIrWAZYq5l6oDXCW51GDDl8A4vHJ/17tn1nptblfosfAew
 YozPJ/enPXe5iDTbCY6acWRvIK6TkdghtYMJgyB2zGc/HSKyK7Rk8N+5hQwB2UwstniO
 CN8w==
X-Gm-Message-State: AOAM530G1ee1wHIyvkZ4Pxe9U153Ltpfo8KbDR/Gm5TVH1K7bK3rM5p2
 ZDay8oGGkWKob5SvuLnEGi71kwenIZWlJQ==
X-Google-Smtp-Source: ABdhPJz+jKNwop4NZVSYJN+ZYhnbnszzwXyPDxeAkRorYUR26OCHFHbGcomX0z4hzD4r8uJlZGv4pA==
X-Received: by 2002:a17:90a:d704:: with SMTP id
 y4mr14847592pju.159.1600454357440; 
 Fri, 18 Sep 2020 11:39:17 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id f4sm3680723pfj.147.2020.09.18.11.39.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 11:39:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 63/81] target/arm: Implement SVE2 multiply-add long
 (indexed)
Date: Fri, 18 Sep 2020 11:37:33 -0700
Message-Id: <20200918183751.2787647-64-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918183751.2787647-1-richard.henderson@linaro.org>
References: <20200918183751.2787647-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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
 target/arm/helper-sve.h    | 17 +++++++++++++++++
 target/arm/sve.decode      | 18 ++++++++++++++++++
 target/arm/sve_helper.c    | 16 ++++++++++++++++
 target/arm/translate-sve.c | 20 ++++++++++++++++++++
 4 files changed, 71 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index ff85e1327b..90872fa0e6 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -2698,3 +2698,20 @@ DEF_HELPER_FLAGS_4(sve2_sqdmull_idx_s, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2_sqdmull_idx_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sve2_smlal_idx_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_smlal_idx_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_smlsl_idx_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_smlsl_idx_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_umlal_idx_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_umlal_idx_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_umlsl_idx_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_umlsl_idx_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 80d76982e8..da77ad689f 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -825,6 +825,24 @@ SQDMLSLB_zzxw_d 01000100 .. 1 ..... 0011.0 ..... .....          @rrxw_d
 SQDMLSLT_zzxw_s 01000100 .. 1 ..... 0011.1 ..... .....          @rrxw_s
 SQDMLSLT_zzxw_d 01000100 .. 1 ..... 0011.1 ..... .....          @rrxw_d
 
+# SVE2 multiply-add long (indexed)
+SMLALB_zzxw_s   01000100 .. 1 ..... 1000.0 ..... .....          @rrxw_s
+SMLALB_zzxw_d   01000100 .. 1 ..... 1000.0 ..... .....          @rrxw_d
+SMLALT_zzxw_s   01000100 .. 1 ..... 1000.1 ..... .....          @rrxw_s
+SMLALT_zzxw_d   01000100 .. 1 ..... 1000.1 ..... .....          @rrxw_d
+UMLALB_zzxw_s   01000100 .. 1 ..... 1001.0 ..... .....          @rrxw_s
+UMLALB_zzxw_d   01000100 .. 1 ..... 1001.0 ..... .....          @rrxw_d
+UMLALT_zzxw_s   01000100 .. 1 ..... 1001.1 ..... .....          @rrxw_s
+UMLALT_zzxw_d   01000100 .. 1 ..... 1001.1 ..... .....          @rrxw_d
+SMLSLB_zzxw_s   01000100 .. 1 ..... 1010.0 ..... .....          @rrxw_s
+SMLSLB_zzxw_d   01000100 .. 1 ..... 1010.0 ..... .....          @rrxw_d
+SMLSLT_zzxw_s   01000100 .. 1 ..... 1010.1 ..... .....          @rrxw_s
+SMLSLT_zzxw_d   01000100 .. 1 ..... 1010.1 ..... .....          @rrxw_d
+UMLSLB_zzxw_s   01000100 .. 1 ..... 1011.0 ..... .....          @rrxw_s
+UMLSLB_zzxw_d   01000100 .. 1 ..... 1011.0 ..... .....          @rrxw_d
+UMLSLT_zzxw_s   01000100 .. 1 ..... 1011.1 ..... .....          @rrxw_s
+UMLSLT_zzxw_d   01000100 .. 1 ..... 1011.1 ..... .....          @rrxw_d
+
 # SVE2 integer multiply long (indexed)
 SMULLB_zzx_s    01000100 .. 1 ..... 1100.0 ..... .....          @rrxl_s
 SMULLB_zzx_d    01000100 .. 1 ..... 1100.0 ..... .....          @rrxl_d
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 926fe98eb5..f71df89cb7 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -1546,6 +1546,20 @@ void HELPER(NAME)(void *vd, void *vn, void *vm, void *va, uint32_t desc)  \
     }                                                                     \
 }
 
+#define DO_MLA(N, M, A)  (A + N * M)
+
+DO_ZZXW(sve2_smlal_idx_s, int32_t, int16_t, H1_4, H1_2, DO_MLA)
+DO_ZZXW(sve2_smlal_idx_d, int64_t, int32_t,     , H1_4, DO_MLA)
+DO_ZZXW(sve2_umlal_idx_s, uint32_t, uint16_t, H1_4, H1_2, DO_MLA)
+DO_ZZXW(sve2_umlal_idx_d, uint64_t, uint32_t,     , H1_4, DO_MLA)
+
+#define DO_MLS(N, M, A)  (A - N * M)
+
+DO_ZZXW(sve2_smlsl_idx_s, int32_t, int16_t, H1_4, H1_2, DO_MLS)
+DO_ZZXW(sve2_smlsl_idx_d, int64_t, int32_t,     , H1_4, DO_MLS)
+DO_ZZXW(sve2_umlsl_idx_s, uint32_t, uint16_t, H1_4, H1_2, DO_MLS)
+DO_ZZXW(sve2_umlsl_idx_d, uint64_t, uint32_t,     , H1_4, DO_MLS)
+
 #define DO_SQDMLAL_S(N, M, A)  DO_SQADD_S(A, do_sqdmull_s(N, M))
 #define DO_SQDMLAL_D(N, M, A)  do_sqadd_d(A, do_sqdmull_d(N, M))
 
@@ -1558,6 +1572,8 @@ DO_ZZXW(sve2_sqdmlal_idx_d, int64_t, int32_t,     , H1_4, DO_SQDMLAL_D)
 DO_ZZXW(sve2_sqdmlsl_idx_s, int32_t, int16_t, H1_4, H1_2, DO_SQDMLSL_S)
 DO_ZZXW(sve2_sqdmlsl_idx_d, int64_t, int32_t,     , H1_4, DO_SQDMLSL_D)
 
+#undef DO_MLA
+#undef DO_MLS
 #undef DO_ZZXW
 
 #define DO_ZZX(NAME, TYPEW, TYPEN, HW, HN, OP) \
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index bdee644c78..248fe4de42 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -3944,6 +3944,26 @@ DO_SVE2_RRXR_TB(trans_SQDMLSLB_zzxw_d, gen_helper_sve2_sqdmlsl_idx_d, false)
 DO_SVE2_RRXR_TB(trans_SQDMLSLT_zzxw_s, gen_helper_sve2_sqdmlsl_idx_s, true)
 DO_SVE2_RRXR_TB(trans_SQDMLSLT_zzxw_d, gen_helper_sve2_sqdmlsl_idx_d, true)
 
+DO_SVE2_RRXR_TB(trans_SMLALB_zzxw_s, gen_helper_sve2_smlal_idx_s, false)
+DO_SVE2_RRXR_TB(trans_SMLALB_zzxw_d, gen_helper_sve2_smlal_idx_d, false)
+DO_SVE2_RRXR_TB(trans_SMLALT_zzxw_s, gen_helper_sve2_smlal_idx_s, true)
+DO_SVE2_RRXR_TB(trans_SMLALT_zzxw_d, gen_helper_sve2_smlal_idx_d, true)
+
+DO_SVE2_RRXR_TB(trans_UMLALB_zzxw_s, gen_helper_sve2_umlal_idx_s, false)
+DO_SVE2_RRXR_TB(trans_UMLALB_zzxw_d, gen_helper_sve2_umlal_idx_d, false)
+DO_SVE2_RRXR_TB(trans_UMLALT_zzxw_s, gen_helper_sve2_umlal_idx_s, true)
+DO_SVE2_RRXR_TB(trans_UMLALT_zzxw_d, gen_helper_sve2_umlal_idx_d, true)
+
+DO_SVE2_RRXR_TB(trans_SMLSLB_zzxw_s, gen_helper_sve2_smlsl_idx_s, false)
+DO_SVE2_RRXR_TB(trans_SMLSLB_zzxw_d, gen_helper_sve2_smlsl_idx_d, false)
+DO_SVE2_RRXR_TB(trans_SMLSLT_zzxw_s, gen_helper_sve2_smlsl_idx_s, true)
+DO_SVE2_RRXR_TB(trans_SMLSLT_zzxw_d, gen_helper_sve2_smlsl_idx_d, true)
+
+DO_SVE2_RRXR_TB(trans_UMLSLB_zzxw_s, gen_helper_sve2_umlsl_idx_s, false)
+DO_SVE2_RRXR_TB(trans_UMLSLB_zzxw_d, gen_helper_sve2_umlsl_idx_d, false)
+DO_SVE2_RRXR_TB(trans_UMLSLT_zzxw_s, gen_helper_sve2_umlsl_idx_s, true)
+DO_SVE2_RRXR_TB(trans_UMLSLT_zzxw_d, gen_helper_sve2_umlsl_idx_d, true)
+
 #undef DO_SVE2_RRXR_TB
 
 /*
-- 
2.25.1


