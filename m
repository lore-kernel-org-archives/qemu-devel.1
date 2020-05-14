Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08FDFC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:32:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCB79206A5
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n6kdaucB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCB79206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZEum-0006oD-PP
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 10:32:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39532)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZEkN-0003Mm-5z
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:22:03 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:35075)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZEkL-0005ZN-Ry
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:22:02 -0400
Received: by mail-wr1-x434.google.com with SMTP id j5so4393846wrq.2
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 07:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=4jeAT2gMKx/gnRHm0gFslQLsHFCncc1zicwSHYnYxXc=;
 b=n6kdaucBPOoiDWKKrcRr0HYzdgTL4YPW+jPdPcKHbw8w6jNjpd+G30lc0dlmWyMqra
 YYZqafYaZgHtstz2URXHN270ygpWuSaI8z3IKBp0Tv74Gfi/8rSmlYCmAuLhHg+K7zyP
 v7GLVBlxLHUA1/tlKVqvTL7uBwuxOlgI2QXhyo9E3T2l9noSfU0qdB/CogUBuUaOq+90
 oalaRKM+xE+MgpJCP75hp1bsOaHjtk4mLvJ3piA+4s/NkuoH8ttsgglavqb5ZAL5iz9N
 x64Wr6qB9lEyPi9d8p7VCv/HmJVECUwEidfKV6XZz7mId/GJoRVAMnanBazL9EfSWh7c
 MxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4jeAT2gMKx/gnRHm0gFslQLsHFCncc1zicwSHYnYxXc=;
 b=Cqh48XbJaqOLfGiQ76JCViQZBkhi8SQlgx1mFjnXFb361+MaDnzLfEJj/nesXJq9Qx
 Ekt0ohj+/GS2yuBZSCEJDyBqzVVRhF8wS1UtbheRgmCZ4iTHOiiDDxDCXOeoUEE9+6bC
 1Ks43zkkCcBEbu+/G05qHGATP6LElIRF7UMQqpjROaj8Adfzgi81hv6+WjtbPdCELVG0
 RHKMcu+Gqmp7cfbTj+yFy+tHTX9EaMyF6ZIK8OsQe4B+tkJ+3I4QJV6WQJocQP3iawPG
 hHWm/WcwTfJ6fG0kixjV8jEkiTaH8RlqcoaDEr8vKgMZqWAI6jK8fsYpRcX+HL/gHN8S
 7JIw==
X-Gm-Message-State: AOAM533ig2z2wI4SDEEeEydbGJWkmb/ReFr4bXjOeqpeOLo7xUpYdn3h
 mRl1dm3UG4rx9fAC4us2JI/wpOL4jMwt4w==
X-Google-Smtp-Source: ABdhPJz/kBQ+Pm/HxAucsFeMa3zqTBP7yvxZhKJf+RfHLC7b0lcIraIAEXwkCyy8/GVkoIZrgaJtmw==
X-Received: by 2002:adf:fac4:: with SMTP id a4mr5520963wrs.134.1589466120232; 
 Thu, 14 May 2020 07:22:00 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 88sm4077443wrq.77.2020.05.14.07.21.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 07:21:59 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/45] target/arm: Clear tail in gvec_fmul_idx_*,
 gvec_fmla_idx_*
Date: Thu, 14 May 2020 15:21:08 +0100
Message-Id: <20200514142138.20875-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514142138.20875-1-peter.maydell@linaro.org>
References: <20200514142138.20875-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

From: Richard Henderson <richard.henderson@linaro.org>

Must clear the tail for AdvSIMD when SVE is enabled.

Fixes: ca40a6e6e39
Cc: qemu-stable@nongnu.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200513163245.17915-15-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/vec_helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index 6aa2ca08271..a483841adda 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -747,6 +747,7 @@ void HELPER(NAME)(void *vd, void *vn, void *vm, void *stat, uint32_t desc) \
             d[i + j] = TYPE##_mul(n[i + j], mm, stat);                     \
         }                                                                  \
     }                                                                      \
+    clear_tail(d, oprsz, simd_maxsz(desc));                                \
 }
 
 DO_MUL_IDX(gvec_fmul_idx_h, float16, H2)
@@ -771,6 +772,7 @@ void HELPER(NAME)(void *vd, void *vn, void *vm, void *va,                  \
                                      mm, a[i + j], 0, stat);               \
         }                                                                  \
     }                                                                      \
+    clear_tail(d, oprsz, simd_maxsz(desc));                                \
 }
 
 DO_FMLA_IDX(gvec_fmla_idx_h, float16, H2)
-- 
2.20.1


