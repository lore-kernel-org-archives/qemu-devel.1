Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EBEC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 14:07:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 033A4214F1
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 14:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sV/2Js5u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 033A4214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHp91-00041Z-KG
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 10:07:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45854)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHp8B-0002C4-E6
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:06:55 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:47063)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHp89-0007YW-Qk
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:06:55 -0400
Received: by mail-wr1-x433.google.com with SMTP id o5so18848231wrn.13
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 07:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=uhXKnXYG439EfLyUd9/2dMX94MN5ygNhQBpZxGoK2Ss=;
 b=sV/2Js5uZr0HXm33KdjcvvPKzAwvfs4R8thsNWpOamxlY+fdw0BCKdlEx8yzdsW5q7
 oq3vpZVFahDmJKKrZZ6b8NyBO4TcNgouobga1iRHUt4E6ZqpvqfPMCHaGTa8a56HkjU3
 FuVxKnImfTRdwpbEuTs0a6q98MR30hgtJgEjCodNUfK27hyc5ppeKBnLGQJbJN3K9UKb
 F2QmLjUKl4HKXFs0peZpupoHvx/VBnfrWdVC0tzEsGpnDDzm+4DcAxwE3XZwhkkTBihw
 H+Uv0UhMBxnzACQW6/TAn5+s/RdXBaFUssWbitNB/KmnVE2HJhwrExTBi9BPkziB57Oh
 M+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uhXKnXYG439EfLyUd9/2dMX94MN5ygNhQBpZxGoK2Ss=;
 b=cXOb6NP+O8rbZh9NmmN6m0i26VlDqDF+ruCSH0//5a+wBsHakndfVMCgSpHVSxVkK9
 tQh7SRsVahnj1Jzjt9SxK6FU4DfUybcuPwApi7PeQoXckSv1AYmB3PThX656w87kxcNL
 fly5tj1RSjMz01sMUjLEXbBLccmZ+5PXWoQwGfrD1xMy4tLmYiGjZxJD1vSKD7RuqUH9
 2oORASwpkmCNrVqSzJSDRaPoU1QYyimpBgyvI7pd6MgK42FkWtB6dryT5HjxiDG2J1j3
 N0vJLvZUVHJznXhbepEeth+pTG2h6ThQQgEWWZudvZUpTe2UMa4sgGCGaIdCjFLeXYxc
 iefw==
X-Gm-Message-State: AOAM533X+SqHUizgBtGIrk3icb1tIh3ny9WeP1fHf2YmK2kC0q14HO2x
 ndcMXfk+5WvH0DuI82J5PC9hN0XrjML2uGTL
X-Google-Smtp-Source: ABdhPJyEBGf//49GRYIxBecapcOFuKwu9UtyLQxGqtJ2PNv1GcQ1NhalSrlrYDPWBvreos6cFdg5gw==
X-Received: by 2002:adf:f011:: with SMTP id j17mr15514769wro.335.1600092412215; 
 Mon, 14 Sep 2020 07:06:52 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id x16sm20834041wrq.62.2020.09.14.07.06.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 07:06:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/36] target/arm: Convert Neon VCVT fp size field to MO_* in
 decode
Date: Mon, 14 Sep 2020 15:06:13 +0100
Message-Id: <20200914140641.21369-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200914140641.21369-1-peter.maydell@linaro.org>
References: <20200914140641.21369-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

Convert the insns using the 2reg_vcvt and 2reg_vcvt_f16 formats
to pass the size through to the trans function as a MO_* value
rather than the '0==f32, 1==f16' used in the fp 3-same encodings.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200903133209.5141-3-peter.maydell@linaro.org
---
 target/arm/neon-dp.decode       | 3 +--
 target/arm/translate-neon.c.inc | 4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index ea2f0dfcf16..51aa0f08194 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -256,9 +256,8 @@ VMINNM_fp_3s     1111 001 1 0 . 1 . .... .... 1111 ... 1 .... @3same_fp
 @2reg_shll_b     .... ... . . . 001 shift:3  .... .... 0 . . . .... \
                  &2reg_shift vm=%vm_dp vd=%vd_dp size=0 q=0
 
-# We use size=0 for fp32 and size=1 for fp16 to match the 3-same encodings.
 @2reg_vcvt       .... ... . . . 1 ..... .... .... . q:1 . . .... \
-                 &2reg_shift vm=%vm_dp vd=%vd_dp size=0 shift=%neon_rshift_i5
+                 &2reg_shift vm=%vm_dp vd=%vd_dp size=2 shift=%neon_rshift_i5
 @2reg_vcvt_f16   .... ... . . . 11 .... .... .... . q:1 . . .... \
                  &2reg_shift vm=%vm_dp vd=%vd_dp size=1 shift=%neon_rshift_i4
 
diff --git a/target/arm/translate-neon.c.inc b/target/arm/translate-neon.c.inc
index 255c1cf8a2a..213c1c2174a 100644
--- a/target/arm/translate-neon.c.inc
+++ b/target/arm/translate-neon.c.inc
@@ -1626,7 +1626,7 @@ static bool do_fp_2sh(DisasContext *s, arg_2reg_shift *a,
         return false;
     }
 
-    if (a->size != 0) {
+    if (a->size == MO_16) {
         if (!dc_isar_feature(aa32_fp16_arith, s)) {
             return false;
         }
@@ -1646,7 +1646,7 @@ static bool do_fp_2sh(DisasContext *s, arg_2reg_shift *a,
         return true;
     }
 
-    fpst = fpstatus_ptr(a->size ? FPST_STD_F16 : FPST_STD);
+    fpst = fpstatus_ptr(a->size == MO_16 ? FPST_STD_F16 : FPST_STD);
     tcg_gen_gvec_2_ptr(rd_ofs, rm_ofs, fpst, vec_size, vec_size, a->shift, fn);
     tcg_temp_free_ptr(fpst);
     return true;
-- 
2.20.1


