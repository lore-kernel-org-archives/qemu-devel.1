Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58ACC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 05:14:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9982121852
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 05:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LdCiMoiS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9982121852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlmt5-0003oc-Qz
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 01:14:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlmEH-00064t-K0
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:32:45 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633]:33301)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlmEF-0003aR-TI
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:32:45 -0400
Received: by mail-pl1-x633.google.com with SMTP id 35so1927468ple.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 21:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ycG9g1s3mduMY9hWzScWfx1bwEWGWiFwXWWwJAgTBBw=;
 b=LdCiMoiS1tiy69RoFDnAW1e8TsaODjmP/3fyBqpw93xABp40wWiuesrbQ41IUvnngT
 JsPjB8DkO+WZf/HnMyvmepO8fegyFhj/u24o2KN242Kqm+zDqapzbhTcNxg7uFgZbdoS
 SBq5eksUqvkFhO6rD8PUbuOsQT9oZPFNAwFDNH+3KUUq/SMcGC/7vIUCrbczGvclVYjf
 sG+jmpYsvsXofK3yArnwYCMrQYqGT0lsWe39kbvrNSYpBj+0kRo9wXGgrG/Gv4nqJrmh
 CKD3kVjypgeWKiHVQD/ZNOZLkvPxlTNfJAWIOjGYWcTC5g/keq36a9fhOlvVZkWKiExE
 ldGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ycG9g1s3mduMY9hWzScWfx1bwEWGWiFwXWWwJAgTBBw=;
 b=FE6Jj7bDLhQakATsBep2o8JcKfSBYOhFdWy976FLw81JJuZPWiIHLCCh6B7Dci26qO
 qfMdfv7+M8fUoWCFCWrJdvAspFVy75C/ocB3rDWEhCATaZYN+86J6eNXbKf8k1sSkXC8
 4Z78HoZv301u05FB1K2Jot3bdN3uNEWCip+33y/keBSGvG8svfQ0eojApPV5q/C+NzKS
 5rli/2UjE8x95wO2Q9O5nZt3Ssp9vt2EwdFTu9yG/uVKHqn+oEJuY30ocicSk+EuCYKD
 atEAX9VnZctDlxXQF1+2N6WznnwZmEb1PTYd7fiaWmWt3YjEhPK/jJtLcoUW1tm2cNN4
 SunQ==
X-Gm-Message-State: AOAM530px3CDcZo2J2gXDS/tmysh2Km+eO0/5bVIphN562gm4xYSH8Dm
 huA1WRrAlpmrsVRpwhDsTLuXVk3o1hY=
X-Google-Smtp-Source: ABdhPJy5khfW4JK9ZIkTJlxpmyBL8B3H6qR7BSxbykrYeVB646k9JAe9phUCDd3GzWMP2hSUESeLjg==
X-Received: by 2002:a17:90b:e02:: with SMTP id
 ge2mr2097578pjb.205.1592454761618; 
 Wed, 17 Jun 2020 21:32:41 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id d2sm1165766pgp.56.2020.06.17.21.32.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 21:32:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 082/100] target/arm: Implement SVE2 multiply-add long
 (indexed)
Date: Wed, 17 Jun 2020 21:26:26 -0700
Message-Id: <20200618042644.1685561-83-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618042644.1685561-1-richard.henderson@linaro.org>
References: <20200618042644.1685561-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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
 target/arm/helper-sve.h    | 17 +++++++++++++++++
 target/arm/sve.decode      | 18 ++++++++++++++++++
 target/arm/sve_helper.c    | 16 ++++++++++++++++
 target/arm/translate-sve.c | 20 ++++++++++++++++++++
 4 files changed, 71 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index e8e616a247..f309753620 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -2210,3 +2210,20 @@ DEF_HELPER_FLAGS_4(sve2_sqdmull_idx_s, TCG_CALL_NO_RWG,
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
index 52a235826c..479fffa16c 100644
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
+#define DO_MLS(A, N, M)  (A - N * M)
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
index fa28f011b6..4105a7977a 100644
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


