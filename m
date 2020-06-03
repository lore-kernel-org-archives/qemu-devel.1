Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE645C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 01:16:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8219420663
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 01:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L87U40S6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8219420663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgI1O-0000p8-J6
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 21:16:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48536)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgHy9-0003Lq-Ta
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 21:13:25 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:41032)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgHy9-0003WL-8I
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 21:13:25 -0400
Received: by mail-pl1-x642.google.com with SMTP id y17so193179plb.8
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 18:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ULSeXKjALQhZKETBeRDnYwgqeM3FCy75bsyu+BRJV8g=;
 b=L87U40S6DgDwLa4TQPLjCJMjehB3mpworJDCJbTwwqjBUFLMjbUyrT1SnPT5dPYnZO
 glUwErvnWjSn9RM94qL+KI2/zw7PCgtK3rf4g+HmsrmNa1z8uTUN5EvqBEYnkTJ3ljDr
 kBTRYFFsY/uKl3Gi/H5u+C/RO6sjAaoXwN/cWsTd+5EaE0B7FoCn9rPeYcQW6MmVBxJ+
 y5Xg2nPeAANL1vxAgCE5l4KWg/gIgkQi59BBfV8fO/c3PbxNHxEmT/9AmpKwJKW8qiqv
 k46SGHxBH2tPz29siOEL35jQFBVQdL6nz1Kda0PGFgvUuoA/dLW0dq++y+DqrAYh6hD2
 b67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ULSeXKjALQhZKETBeRDnYwgqeM3FCy75bsyu+BRJV8g=;
 b=hiiaCFt2y6ga4HcanEEJ2olNMfYW2W662KIab3QQPebZsF2geZhwJmd+5Oj8mFTLdQ
 Wdr24EtbXi4c9nefJbNfKirlcwpO/DpdMxXeZ9BxVbo7S7D9/rwPJe1mfnnGqU49GAk+
 3ktaH1oy6CjMrmeNrvRIjCAsJNtqW3HS3sLcrZis8O7QsGB3v1xSh52Lj31Pmr8Ka3Qv
 jmj7C94rq6yCOHgiF6P8lJMBCufPwprFwNAsuzmYAoikAFdRal7a341iK0pT31ojAQhU
 wNsTm1je8kbSJcvDmwQzXwFRdZjGL/POyRFuIZtQk2Hg6Fxt5nil7VNhYtUh60xlfHIJ
 149Q==
X-Gm-Message-State: AOAM530Q/DOSWmxtu3CtNIUz0ACmCcPfLwlCR+x6RDVSGKOh3NZEB5a1
 kBp9xiyAk/rWsuFVTv6WfGHI3hoPxrs=
X-Google-Smtp-Source: ABdhPJwXNW1AxZXEoN3VjvivSU8p1ObKqNSNihIY4mSVJWwCT734nfuFQANhgj0GchQCzF8ZLelomw==
X-Received: by 2002:a17:902:eb03:: with SMTP id
 l3mr25830622plb.49.1591146803556; 
 Tue, 02 Jun 2020 18:13:23 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id 3sm290067pfe.85.2020.06.02.18.13.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 18:13:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 04/42] target/arm: Add support for MTE to HCR_EL2 and
 SCR_EL3
Date: Tue,  2 Jun 2020 18:12:39 -0700
Message-Id: <20200603011317.473934-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200603011317.473934-1-richard.henderson@linaro.org>
References: <20200603011317.473934-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 7862bf502d..f2ead07ead 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2021,6 +2021,9 @@ static void scr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
         if (cpu_isar_feature(aa64_pauth, cpu)) {
             valid_mask |= SCR_API | SCR_APK;
         }
+        if (cpu_isar_feature(aa64_mte, cpu)) {
+            valid_mask |= SCR_ATA;
+        }
     } else {
         valid_mask &= ~(SCR_RW | SCR_ST);
     }
@@ -5248,6 +5251,9 @@ static void do_hcr_write(CPUARMState *env, uint64_t value, uint64_t valid_mask)
         if (cpu_isar_feature(aa64_pauth, cpu)) {
             valid_mask |= HCR_API | HCR_APK;
         }
+        if (cpu_isar_feature(aa64_mte, cpu)) {
+            valid_mask |= HCR_ATA | HCR_TID5;
+        }
     }
 
     /* Clear RES0 bits.  */
-- 
2.25.1


