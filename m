Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6329C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 18:47:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A65521534
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 18:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uCGc2FeZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A65521534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJLPp-0000OM-6m
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 14:47:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLGy-0007yG-B4
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:38:16 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035]:53570)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLGw-00074a-Df
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:38:15 -0400
Received: by mail-pj1-x1035.google.com with SMTP id t7so3624118pjd.3
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 11:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7Vcs32PMGSC/nwjonAN6b6oQdS3irDyVBrqXX5IRByw=;
 b=uCGc2FeZaQ1SsHfWLbRfhZ0h/ow/SCe7YxO6NUHYCZ5ohIw9h21TWRqVdjV+0Bom1I
 9+y5FSoOKSCAE4fVacllVYWCO+0rZswwwmYYGbFHn/TfC/8W5bShtI0hlrx+BXv0R8a7
 hO3Uxo87IYRrc3km160cwCYaTy8xOt3bESa9N3McjNrhYFjuhFDdIAfvTPvAMUw5VVCf
 rZKLjYNSmOJaVVat2UymlvkyIlk6Iaj/OtjBD0TUNg56L0okQLNFuMRN0gjRgMDQxxWk
 KJMkvMZ09kCSKVleiZuJISv2Ct+Xx0/rYvarE6sSx9irt91NyAydW2ynMcY9SqcGrD4D
 xyZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7Vcs32PMGSC/nwjonAN6b6oQdS3irDyVBrqXX5IRByw=;
 b=LHR9MyA/D1RWzYPJj6FDvAKa3B7rO1fxW1LluYsIxYmwSJo4PqWLk16nJx2OkPZBfP
 nP9MCgESW8615fGJmF70VSTQT2ZH4/8WpwmGsONlS8j9Ip8o5aljX4Mn5tT1OAhLmNR4
 WLEwNZqV6ef7f6unlW+M7jniACfLj8OWQ3IerjwLLD7F7gZwTh+K/firHHrhhMF4fLYG
 q8+6d4omA0YsFjBePPcDcKfUEuih/1+roh1CvbTmBn379pcqtkJyF262wwiiIPH6e4pB
 ldtEX40nWEV3aUuWDtQOT+b7N+onxQKHpECQEoDur+nJYII62pHBrojC2Ooyg6JFZfzM
 83LA==
X-Gm-Message-State: AOAM530700Zv+Mj7Fumr6fy7luuYHHCTZgntdDJdVsTS+slI91+d+hm+
 rmDNRQSMgoPBevKRQrDblhxvN0ZCKkDgHQ==
X-Google-Smtp-Source: ABdhPJyc64u7kLXXujiZpnEP2C86L7HzBkfbwFJlnyTGjx0+/yLTyoGVXzJXMSu613DBsOm/LA7S8Q==
X-Received: by 2002:a17:90a:ea09:: with SMTP id
 w9mr13597807pjy.203.1600454292698; 
 Fri, 18 Sep 2020 11:38:12 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id f4sm3680723pfj.147.2020.09.18.11.38.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 11:38:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 14/81] target/arm: Implement SVE2 integer add/subtract
 interleaved long
Date: Fri, 18 Sep 2020 11:36:44 -0700
Message-Id: <20200918183751.2787647-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918183751.2787647-1-richard.henderson@linaro.org>
References: <20200918183751.2787647-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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
 target/arm/sve.decode      | 6 ++++++
 target/arm/translate-sve.c | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 70712039e4..a28172c017 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -1178,3 +1178,9 @@ SABDLB          01000101 .. 0 ..... 00 1100 ..... .....  @rd_rn_rm
 SABDLT          01000101 .. 0 ..... 00 1101 ..... .....  @rd_rn_rm
 UABDLB          01000101 .. 0 ..... 00 1110 ..... .....  @rd_rn_rm
 UABDLT          01000101 .. 0 ..... 00 1111 ..... .....  @rd_rn_rm
+
+## SVE2 integer add/subtract interleaved long
+
+SADDLBT         01000101 .. 0 ..... 1000 00 ..... .....  @rd_rn_rm
+SSUBLBT         01000101 .. 0 ..... 1000 10 ..... .....  @rd_rn_rm
+SSUBLTB         01000101 .. 0 ..... 1000 11 ..... .....  @rd_rn_rm
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index cbbce6a3e2..02eba872f9 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -6026,3 +6026,7 @@ DO_SVE2_ZZZ_TB(SABDLT, sabdl, true, true)
 DO_SVE2_ZZZ_TB(UADDLT, uaddl, true, true)
 DO_SVE2_ZZZ_TB(USUBLT, usubl, true, true)
 DO_SVE2_ZZZ_TB(UABDLT, uabdl, true, true)
+
+DO_SVE2_ZZZ_TB(SADDLBT, saddl, false, true)
+DO_SVE2_ZZZ_TB(SSUBLBT, ssubl, false, true)
+DO_SVE2_ZZZ_TB(SSUBLTB, ssubl, true, false)
-- 
2.25.1


