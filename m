Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA26C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 05:10:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41FC82089D
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 05:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bq3Sbt53"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41FC82089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlmom-0002B4-Cu
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 01:10:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlmEO-0006Az-89
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:32:52 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633]:39804)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlmEK-0003cD-IT
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:32:51 -0400
Received: by mail-pl1-x633.google.com with SMTP id v24so1911933plo.6
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 21:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GZBbnaxB7i6AoU1J9iHbjE+vcVUDvNuwTLQXvUiepxA=;
 b=bq3Sbt53GRzT8DBuVTAPG41JxS9n3rDVuiAL6prssjVjnK9/RRxnxDeF62ONOC1dpW
 MxUzCcFwDLpm0uxJWrzgMBivY7oo2Mo8abgwfB164rjfwO9U/pXfRSXrlTmEXjBvRq+8
 QmkEsfARCINLdskwfid/D0qqGL2x9drKsvEqpIf4rWno/EmFojyTQ1c/9gE+fZ4LkVPG
 WaGafYz7Tz5KBBQcV/2W5UOe+wA2gtDggAefU2RdCpbgy97YdR5kmO5aVxnRAw05/CNq
 a+wkwdBThf0EPMze+BqWF/pxStsbW4sT7t+2zlRdaOYZ9oISvG5wdJJhQyafWzB2TNRY
 ApVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GZBbnaxB7i6AoU1J9iHbjE+vcVUDvNuwTLQXvUiepxA=;
 b=MLuS3PWP7tn//WqvfcAi1cXYU+veYLNo009Rk+JE5O5L9iJq6xYRM8p37/hF4ekSW8
 VCe8GHrBTLEvX7JzpKUobbipa4dLxYv0yHDVrthc/E567TmrRdzbw5zjYqD6CHMXBShF
 cy+RquxT9C2qOuNuDUby7qbSQO2WY2CEtCc5rsHdCWI8tQ7jang7m3TgNdkd4U0PvGun
 ZqdZcT2etespVtG46L+byhC5MHs2yVf7et2UTn0O9fBy4RWWD0pKPseoVtl73LAo3hlu
 322E0LaH4SFyCRUTrpoDRI84CDXFvYsEkp7ea0ZAKSfs/iArzHOWyZysgSZFd3lSywrQ
 TAbw==
X-Gm-Message-State: AOAM532e9nONCv5DlCuO7jUOkUdojPuC66kEyivPWC5o7Gh7fqKFwUT5
 ysugMa2BFd5ggwJxDBt1KDy9YHnY8dE=
X-Google-Smtp-Source: ABdhPJzMgVXYt0su2h72WRJCGejJWd7moA0yeVoUqAZbLiNz6yNdp13YfDOej0HI6bGsE9CaQNAhhw==
X-Received: by 2002:a17:902:502:: with SMTP id 2mr2272016plf.62.1592454765874; 
 Wed, 17 Jun 2020 21:32:45 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id d2sm1165766pgp.56.2020.06.17.21.32.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 21:32:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 085/100] target/arm: Implement SVE mixed sign dot product
Date: Wed, 17 Jun 2020 21:26:29 -0700
Message-Id: <20200618042644.1685561-86-richard.henderson@linaro.org>
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
 target/arm/helper.h        |  2 ++
 target/arm/sve.decode      |  4 ++++
 target/arm/translate-sve.c | 16 ++++++++++++++++
 target/arm/vec_helper.c    | 18 ++++++++++++++++++
 4 files changed, 40 insertions(+)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 6fac613dfc..bfeb327272 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -578,6 +578,8 @@ DEF_HELPER_FLAGS_5(gvec_sdot_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_udot_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_sdot_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_udot_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_usdot_b, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_5(gvec_sdot_idx_b, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 51acbfa797..0be8a020f6 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -1523,6 +1523,10 @@ UMLSLT_zzzw     01000100 .. 0 ..... 010 111 ..... .....  @rda_rn_rm
 CMLA_zzzz       01000100 esz:2 0 rm:5 0010 rot:2 rn:5 rd:5  ra=%reg_movprfx
 SQRDCMLAH_zzzz  01000100 esz:2 0 rm:5 0011 rot:2 rn:5 rd:5  ra=%reg_movprfx
 
+## SVE mixed sign dot product
+
+USDOT_zzzz      01000100 .. 0 ..... 011 110 ..... .....  @rda_rn_rm
+
 ### SVE2 floating point matrix multiply accumulate
 
 FMMLA           01100100 .. 1 ..... 111001 ..... .....  @rda_rn_rm
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index fe4b4b7387..152b0b605d 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -7666,3 +7666,19 @@ static bool trans_SQRDCMLAH_zzzz(DisasContext *s, arg_SQRDCMLAH_zzzz *a)
     }
     return true;
 }
+
+static bool trans_USDOT_zzzz(DisasContext *s, arg_USDOT_zzzz *a)
+{
+    if (a->esz != 2 || !dc_isar_feature(aa64_sve2_i8mm, s)) {
+        return false;
+    }
+    if (sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        tcg_gen_gvec_4_ool(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn),
+                           vec_full_reg_offset(s, a->rm),
+                           vec_full_reg_offset(s, a->ra),
+                           vsz, vsz, 0, gen_helper_gvec_usdot_b);
+    }
+    return true;
+}
diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index e1689d730f..a51cbf2c7e 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -580,6 +580,24 @@ void HELPER(gvec_udot_b)(void *vd, void *vn, void *vm, void *va, uint32_t desc)
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
 
+void HELPER(gvec_usdot_b)(void *vd, void *vn, void *vm,
+                          void *va, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    int32_t *d = vd, *a = va;
+    uint8_t *n = vn;
+    int8_t *m = vm;
+
+    for (i = 0; i < opr_sz / 4; ++i) {
+        d[i] = (a[i] +
+                n[i * 4 + 0] * m[i * 4 + 0] +
+                n[i * 4 + 1] * m[i * 4 + 1] +
+                n[i * 4 + 2] * m[i * 4 + 2] +
+                n[i * 4 + 3] * m[i * 4 + 3]);
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
 void HELPER(gvec_sdot_h)(void *vd, void *vn, void *vm, void *va, uint32_t desc)
 {
     intptr_t i, opr_sz = simd_oprsz(desc);
-- 
2.25.1


