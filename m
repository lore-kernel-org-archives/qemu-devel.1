Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A50C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 00:07:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 858E520771
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 00:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SadJVhws"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 858E520771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJ3vs-0005iZ-OT
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 20:07:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJ3th-00044a-Ue
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 20:05:05 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:51278)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJ3tf-0007X3-FF
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 20:05:05 -0400
Received: by mail-pj1-x1043.google.com with SMTP id a9so2171714pjg.1
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 17:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lciLN6lb6WIm6k4jr55Hk/ny6QmXaUdY5X1z2Junh6Q=;
 b=SadJVhwsJHHm25L5x3dRYuXFdujuIYOMHAOIlgpgCwZtxrqYF/es6KCigWxzWZAvfA
 QbjxZ5a3nL4r7x+RpgM8a7tvPMbWW7vjaHfPxPV3CaXZRF/vtYX63vWnjQ1Y3kSsXgKm
 SKWc43XmNuk86rADXzlg53HceXMF9wnP6kNLddNzjohmJRyDOgX0KZeF/HkobUqVxNGz
 Ghl2iSoaiMZC/O+tWd0MhFQAgBKbM7QKsnJW8u1DNRLbOhWeN5/EGyQMLOoFOndneVcf
 xub1gUT6bpAAC+I4IbqqAJX+rMICy3NE0SvdUVZQmuW//How0nlCDkKWEwjBfiyST8Ai
 nkJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lciLN6lb6WIm6k4jr55Hk/ny6QmXaUdY5X1z2Junh6Q=;
 b=LAjWMupCHEQWZc3FbIHjzxam69jqlvUePzeRWeMiSL19cQJdCrah1USG7YrkqMy686
 elicy1J6R5bOTlOMNTrZmrZr+EPMvmxs8rNCWsYoQm5Haa51rJhYMaCdNGpllz1ez8y2
 ztVb9ElQhZFaX16tO1Zzyrkg3Bm27N0RK+BNi/rul0CNViuL8K4yeYBXZMIqnedJ38pv
 +OTce63XyC6Z2uTIVcTe41jZ4JpM3ZUEEFVnGESTLeD33P4zWi7ytmIZWPUxdSpNwWvv
 4ToF3RJ0KvAhQcV4OFbFW2MXkZGx5BrTe4KhOe5rvthuecoww7HQYx6F1KZJ6ebe8ts1
 e76Q==
X-Gm-Message-State: AOAM5339XB0Ukv68EwNvJT3sh3kTtiVzIq2vTDG4RRGNyqGX8ALO3Q94
 odJH8O/NhuB/hILwF3JO0syoVhfMRTfrwQ==
X-Google-Smtp-Source: ABdhPJzqy6psp31OM+XFuxi3EoUpqwNGaiTKOwZqGGb15YrwUAZfd4ZFb0Qv1Lqt0G84hYmGfeCL2w==
X-Received: by 2002:a17:902:7d8e:b029:d1:f2df:ad4 with SMTP id
 a14-20020a1709027d8eb02900d1f2df0ad4mr8615094plm.44.1600387501770; 
 Thu, 17 Sep 2020 17:05:01 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id i2sm785589pfq.89.2020.09.17.17.05.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2020 17:05:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/arm: Fix SVE splice
Date: Thu, 17 Sep 2020 17:05:00 -0700
Message-Id: <20200918000500.2690937-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: peter.maydell@linaro.org, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While converting to gen_gvec_ool_zzzp, we lost passing
a->esz as the data argument to the function.

Fixes: 36cbb7a8e71
Cc: qemu-stable@nongnu.org
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-sve.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 8233295391..b9f9e6f4ae 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -3182,7 +3182,7 @@ static bool trans_SPLICE(DisasContext *s, arg_rprr_esz *a)
 {
     if (sve_access_check(s)) {
         gen_gvec_ool_zzzp(s, gen_helper_sve_splice,
-                          a->rd, a->rn, a->rm, a->pg, 0);
+                          a->rd, a->rn, a->rm, a->pg, a->esz);
     }
     return true;
 }
-- 
2.25.1


