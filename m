Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0445BC38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:41:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8BF121841
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SASCfKKQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8BF121841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX57g-0001PQ-QD
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 11:41:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34928)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX4pG-0004TB-Dn
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:22:10 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:53720)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX4pF-00074W-Gm
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:22:10 -0400
Received: by mail-pj1-x1041.google.com with SMTP id hi11so4406718pjb.3
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 08:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=P8q6V0iik55UUDqAciuD8of8rt9ZSjxKLPBKIwVKE6U=;
 b=SASCfKKQNfB4YH8qYJvppHPRmjaTeg8nyvXp1tYN4R6JQlKj9ocdu2JxPxPntXL36O
 rMKuTTczpRiDZJbKaTMeXoE+Az9Pe7NkENqELts71YtQbUdwWhgQZLlkMlBTiyqKPngF
 UHERB4wVdoZJSIyy1igzSsYES5qmlAUIkMYfV+U6eMS0os+LdM0b7xBAkhjvcjk14fVh
 bePQ4Pkel192dW2AovobBxGBj8bbMDpoaOYWWR+U9gpk46TrbWAXOuA+OIbQP7f+0m3/
 YueXxiCcwGCNhmmjLGRUTC84lrSY5wRU2KDCdiwOGLWTnl93eeqT/6M00+LsiGCSf9BH
 qlSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=P8q6V0iik55UUDqAciuD8of8rt9ZSjxKLPBKIwVKE6U=;
 b=HNuoGEbISOYlqZ5GT0iyw7pMwpJkzMwVLcgI4gLAurKeabB3XIFIy6GbCi8Bd4naQM
 xnn7ZxIdJkgCRiqwKLEFobZtyV9r6EJxCVbDmMAUrnSLc77lVHh6VkPoJ/gMkazba19k
 DHJbbanNL0v0/k2sUvK6jwQ3SFx9/32qZVgUFiakut/Zoi4AdgiqctR5ZQHM644EcbF0
 aUbWZPTA/K9aw3hnhIxj9Ki9feic2ZBsH01SWlptV0d25J4gRGXo34EBdRdE1Mc1G5XF
 0C72/hDQDmGpAXS+gPX/+e6FzQMUZHM2wDLFn/LcJyHkWhd7PVPcc2bCM4xlHmR/rPHY
 sK2A==
X-Gm-Message-State: AGi0PuYfMgpTSZK446WhBVgZZ+OqpKR+iQ+GLW70PxkbSp0FHDpTLIPs
 NKqsfK5Sj1OXBeWZigjZ2PqICdB2oXk=
X-Google-Smtp-Source: APiQypINqrlXamFYkTMHgDkf8s/3hHFfkaVLA/KUHLvgc85GlSTuf4+MKdKa4IeGdRcYn5Q7ntA3rg==
X-Received: by 2002:a17:90a:2e82:: with SMTP id
 r2mr6809299pjd.128.1588951327715; 
 Fri, 08 May 2020 08:22:07 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id n16sm2104575pfq.61.2020.05.08.08.22.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 08:22:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 04/16] target/arm: Remove unnecessary range check for VSHL
Date: Fri,  8 May 2020 08:21:48 -0700
Message-Id: <20200508152200.6547-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200508152200.6547-1-richard.henderson@linaro.org>
References: <20200508152200.6547-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In 1dc8425e551, while converting to gvec, I added an extra range check
against the shift count.  This was unnecessary because the encoding of
the shift count produces 0 to the element size - 1.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index e221d0c959..967108b3f4 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5750,16 +5750,8 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                         gen_gvec_sli(size, rd_ofs, rm_ofs, shift,
                                      vec_size, vec_size);
                     } else { /* VSHL */
-                        /* Shifts larger than the element size are
-                         * architecturally valid and results in zero.
-                         */
-                        if (shift >= 8 << size) {
-                            tcg_gen_gvec_dup_imm(size, rd_ofs,
-                                                 vec_size, vec_size, 0);
-                        } else {
-                            tcg_gen_gvec_shli(size, rd_ofs, rm_ofs, shift,
-                                              vec_size, vec_size);
-                        }
+                        tcg_gen_gvec_shli(size, rd_ofs, rm_ofs, shift,
+                                          vec_size, vec_size);
                     }
                     return 0;
                 }
-- 
2.20.1


