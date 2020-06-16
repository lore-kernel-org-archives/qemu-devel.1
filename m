Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223F9C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 15:05:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E561220786
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 15:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNvEQ8B4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E561220786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlD9B-0003cE-0l
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 11:05:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58328)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCR3-0004Mt-Va; Tue, 16 Jun 2020 10:19:33 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:36793)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCR2-00072A-EG; Tue, 16 Jun 2020 10:19:33 -0400
Received: by mail-ot1-x344.google.com with SMTP id 97so16065216otg.3;
 Tue, 16 Jun 2020 07:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=3BFt3zvBmH3599GWUmBzmTB/ubSoG/ped8JbzfOjFXw=;
 b=kNvEQ8B4wVz1tV+sEO5jSOSA3DzQsWrbhzaNXYblj7yVmLs+VzrYpLEjlc5u6AE+KG
 NWHIXqYgDJMDdgpizSb9rN+YLnRbT6L1ltd/6muxIdWTlyB8asuA/ue3+JauMetGZIfS
 +c+9Dh8VDBTJFAPQRYQ439UORUrxATz2mtwfZVcBxz35ElMuMusVU6FNE9fkBkPgGrgk
 Bwm0LN7R0XJkZkY4O4Qr/4yX2pMzwnoSP1SpU0NYIfEfBnTHSf0va5CNDrkOwf4IEnOW
 j1c01cqO0RupiBT0aXXWoTI6J7hg5MCt84MIhV3MJKlnRay1eOvg2ozMVXqB++IluJu5
 /lAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=3BFt3zvBmH3599GWUmBzmTB/ubSoG/ped8JbzfOjFXw=;
 b=XXYObBI0xJxekcCOSNzYEerqmhJ9ehIc8gH2Kr3m+p1vvktE3umv/AizlRZFTDebK8
 8hmTQuwpGGSuu9a2g8G8hvUA2ow8WdWIIZP8HzckcCUDlIDAfDDo4PeeQmEanX2Qoo8C
 I9/CpmJgyRwCbrPNlcutx/4ssM2OxW8BQZtYPqUcdS0aHTfZIQMI1m1h/NrvgqRM34q4
 X/4INqNzgLDPfM/Zd+8olFRLP9O0qhvos/JTx2erV1au5OijKaEZhTU2HnhlSYybxftk
 HmL7g5tzCmrwjpXTyAG3/9fXjYbLev7XXPpb6v29Fh1U9r+fxB2WUsv/UJqpXpwOYAKR
 9JgA==
X-Gm-Message-State: AOAM530LiVhd3hLnGAqMFJHhy9KK6uzCeV5Rqo/ZwOv7sjHiHsSb5Egl
 11hg78O8MLpIp6yXKqXReCqG7vZmS3A=
X-Google-Smtp-Source: ABdhPJziESiRWNVMGaV/j3lpy7AuOr/WrHsfeG3MLEYDXtVIFX7qYPyTTUKq8U+3xCk7ctWg5ngnwg==
X-Received: by 2002:a05:6830:1e61:: with SMTP id
 m1mr2475536otr.13.1592317170646; 
 Tue, 16 Jun 2020 07:19:30 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id g51sm4042298otg.17.2020.06.16.07.19.29
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 16 Jun 2020 07:19:29 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 70/78] target/arm: Clear tail in gvec_fmul_idx_*,
 gvec_fmla_idx_*
Date: Tue, 16 Jun 2020 09:15:39 -0500
Message-Id: <20200616141547.24664-71-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
References: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=flukshun@gmail.com; helo=mail-ot1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-stable@nongnu.org
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
(cherry picked from commit 525d9b6d42844e187211d25b69be8b378785bc24)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 target/arm/vec_helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index dedef62403..a9f40ac78a 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -737,6 +737,7 @@ void HELPER(NAME)(void *vd, void *vn, void *vm, void *stat, uint32_t desc) \
             d[i + j] = TYPE##_mul(n[i + j], mm, stat);                     \
         }                                                                  \
     }                                                                      \
+    clear_tail(d, oprsz, simd_maxsz(desc));                                \
 }
 
 DO_MUL_IDX(gvec_fmul_idx_h, float16, H2)
@@ -761,6 +762,7 @@ void HELPER(NAME)(void *vd, void *vn, void *vm, void *va,                  \
                                      mm, a[i + j], 0, stat);               \
         }                                                                  \
     }                                                                      \
+    clear_tail(d, oprsz, simd_maxsz(desc));                                \
 }
 
 DO_FMLA_IDX(gvec_fmla_idx_h, float16, H2)
-- 
2.17.1


