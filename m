Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D45AC433E4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 09:55:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C35D2071E
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 09:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iJZGVD7y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C35D2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kA9C3-00027J-HJ
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 05:55:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kA95t-0005oI-FU
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 05:48:49 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:33564)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kA95q-0004qG-O0
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 05:48:49 -0400
Received: by mail-wm1-x32c.google.com with SMTP id y8so1860415wma.0
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 02:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=MO+LUQ5wKXjbzpP+WR/DhW7XRCUf7wjkORTiMAEjiYg=;
 b=iJZGVD7yFVrgSZ6IBzvG6vMYSKgMNKWR+s4K9rVbdMQDfggIL4yGgNdSurMTyGuWBC
 PxrvzSIKwDkITxnN+fIgFtpsXW/6e/T7uvhLQ3qn3E0AIJ/C9R5KrDdMlyJkpbEPGGwU
 nwIXkhDx0aqTgRl5SQc7RXWbSMtwdCZABLVlvrYXU9yGFvkGcY0q3s0e464JK1Ohmn6t
 54ZfmSl5nVrS8u6Z6ukiSNoI9IEEUdgvHHwQVPzG9t/+zP28L+DJvtWCFeiQaSKuiJz7
 Xz64uDqz623KkC/DwUUJ+JW2ewmOebUtMe6rYGYXFbAdc/+DNQyfhmtIl1bUsfRtOMww
 fTsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MO+LUQ5wKXjbzpP+WR/DhW7XRCUf7wjkORTiMAEjiYg=;
 b=QqsbdtEpI+Rqn5It6nrKxujZev+ODzDaJkM3fi7vJnpMm1Ypc1t/7XcVfRkM2j5vJw
 lbpgQ0X3RNyr6Upc9l9Pu1Z5VyxOIxkIwxz2Ax3vrUOwCSzw4v01SklWfDBMff3l6hNv
 eORmEHxUZAq5A+YjO+5a8+0FZg8ZBNfj9FIfawVhRBDcglwNOiICV5cIhyaCEYG08qew
 DuC60xMnodx9cVzV4SBGSQSYc6kcOBFZoe9eDIPihvKNGwsJBHslGtqxb68lPUE6cd9g
 lltH3RlEt9XsYuZCb8mGMjxnLK2gzjJZRVo5W1s8Bbs+GepYWD/Wfn8S5hr0AEVLhvYS
 6MuA==
X-Gm-Message-State: AOAM530GOuHunvg4wNEWT9a/RbgKctErO/F+XiZoS1BSFzB408hDmpKU
 ZLsEwAOo2Ns+TadDGF+lfX0HxhKxuO0rbvqT
X-Google-Smtp-Source: ABdhPJysf457axYMxmJp1kxV6Kn05LGzez9Df79tXsE+B9612a/Tj4tZq29xfWoboGv0ooiALoWuVg==
X-Received: by 2002:a7b:cd88:: with SMTP id y8mr4739021wmj.14.1598262525070;
 Mon, 24 Aug 2020 02:48:45 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q6sm24877057wma.22.2020.08.24.02.48.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2020 02:48:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/27] target/arm: Use correct FPST for VCMLA, VCADD on fp16
Date: Mon, 24 Aug 2020 10:48:11 +0100
Message-Id: <20200824094811.15439-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200824094811.15439-1-peter.maydell@linaro.org>
References: <20200824094811.15439-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

When we implemented the VCMLA and VCADD insns we put in the
code to handle fp16, but left it using the standard fp status
flags. Correct them to use FPST_STD_F16 for fp16 operations.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20200806104453.30393-5-peter.maydell@linaro.org
---
 target/arm/translate-neon.c.inc | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/translate-neon.c.inc b/target/arm/translate-neon.c.inc
index f8f2cb1869f..9879731a521 100644
--- a/target/arm/translate-neon.c.inc
+++ b/target/arm/translate-neon.c.inc
@@ -181,7 +181,7 @@ static bool trans_VCMLA(DisasContext *s, arg_VCMLA *a)
     }
 
     opr_sz = (1 + a->q) * 8;
-    fpst = fpstatus_ptr(FPST_STD);
+    fpst = fpstatus_ptr(a->size == 0 ? FPST_STD_F16 : FPST_STD);
     fn_gvec_ptr = a->size ? gen_helper_gvec_fcmlas : gen_helper_gvec_fcmlah;
     tcg_gen_gvec_3_ptr(vfp_reg_offset(1, a->vd),
                        vfp_reg_offset(1, a->vn),
@@ -218,7 +218,7 @@ static bool trans_VCADD(DisasContext *s, arg_VCADD *a)
     }
 
     opr_sz = (1 + a->q) * 8;
-    fpst = fpstatus_ptr(FPST_STD);
+    fpst = fpstatus_ptr(a->size == 0 ? FPST_STD_F16 : FPST_STD);
     fn_gvec_ptr = a->size ? gen_helper_gvec_fcadds : gen_helper_gvec_fcaddh;
     tcg_gen_gvec_3_ptr(vfp_reg_offset(1, a->vd),
                        vfp_reg_offset(1, a->vn),
@@ -322,7 +322,7 @@ static bool trans_VCMLA_scalar(DisasContext *s, arg_VCMLA_scalar *a)
     fn_gvec_ptr = (a->size ? gen_helper_gvec_fcmlas_idx
                    : gen_helper_gvec_fcmlah_idx);
     opr_sz = (1 + a->q) * 8;
-    fpst = fpstatus_ptr(FPST_STD);
+    fpst = fpstatus_ptr(a->size == 0 ? FPST_STD_F16 : FPST_STD);
     tcg_gen_gvec_3_ptr(vfp_reg_offset(1, a->vd),
                        vfp_reg_offset(1, a->vn),
                        vfp_reg_offset(1, a->vm),
-- 
2.20.1


