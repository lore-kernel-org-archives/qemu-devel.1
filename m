Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A06AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:43:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E2B6206EB
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D4Zrkdna"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E2B6206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAgij-0003Vi-8k
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 17:43:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg4a-0000mK-9x
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:01:40 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:44061)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg4U-00025G-DD
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:01:38 -0400
Received: by mail-pf1-x441.google.com with SMTP id p11so5119538pfn.11
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 14:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/v81xo2Oa10INQECM2V7ceku/8UgY141rA25N+r+rLA=;
 b=D4ZrkdnaxpNIEXYGaEYEQO2PUhsKUhwAPDSR1eUtbNKdlXq3cYhDWDjB03coFV45Ry
 fyI7EkdqoqK6xUU+Q5KSU//B0Xk+IH5oWKr+zJNXyA96k0bU2QtU0hVxQMR62/X9VDe/
 S5AiiHfBzlgvim8oDvTDmgXWzKZlJzlLaa8vM2UFw3EPR5Yk5/lNcx2PYYeu05ZAwd1S
 ENF+QdsMzAPB8zWMnFzyn/KL9q1dEzabasYoI69bgNwKe9SXiLohYWLvCmEC3Q08N+YK
 Lm3K5xyp2M8LHsT4bjrjM+7y8y86IzLQWK1JksaTPa8QcnX6Z/+fwjO64JDBGvbZ3EpG
 WwfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/v81xo2Oa10INQECM2V7ceku/8UgY141rA25N+r+rLA=;
 b=j3NLPs7TSbs3KY2p3EuI7j4Pu0CmFhp2vxLYMJ5Dyo4g4n07MvryrGGGqJgwuR4e6y
 DdTjaxv4zN2jeC+wWl2RN6ZSdfYC9JTCdtnzdo4VFgdey20WSgLsk5iTHqgs0a7JgtdH
 c6vecGe8zTx6ZWpVGMM3F4NHtOufxnEUETvxB+Cig4pwvor/NbAj3NeHn2BUdp16ObJI
 dLxZPH3hggl8QipX8OzDN/3s1h050khpFQGk+Q++na+7hiGSnhOpx19Qe6quck3lb15n
 ZqoxmiJGR+yih8fwhEuWZhGB9EZEPT+7leU8//cCJek2hkxWvch7jBCa90LmjoRSX0Te
 J22w==
X-Gm-Message-State: AOAM531hT0VvyWed7uqvSK6l26A9qSy2i+TCMzyGeIJpEZoO+caZeWLL
 6SGUHrDmthGUlUs++4r65JY+ARwXfNp+9Q==
X-Google-Smtp-Source: ABdhPJyEypa2GPtIaZR15xxg3c45j3PzdwH6MHCIdh4Tby8ITk/T1vH8gACo6S6y5hoRZi/W5DsT5g==
X-Received: by 2002:aa7:9552:: with SMTP id w18mr9378716pfq.150.1598389291895; 
 Tue, 25 Aug 2020 14:01:31 -0700 (PDT)
Received: from localhost.localdomain
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id k4sm16074pgr.87.2020.08.25.14.01.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 14:01:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 76/77] target/microblaze: Add flags markup to some helpers
Date: Tue, 25 Aug 2020 13:59:49 -0700
Message-Id: <20200825205950.730499-77-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200825205950.730499-1-richard.henderson@linaro.org>
References: <20200825205950.730499-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
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
Cc: edgar.iglesias@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The mmu_read, mmu_write, get, and put helpers do not touch the
general registers, or any of the other variables managed by tcg.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/helper.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/microblaze/helper.h b/target/microblaze/helper.h
index 3980fba797..f740835fcb 100644
--- a/target/microblaze/helper.h
+++ b/target/microblaze/helper.h
@@ -21,11 +21,11 @@ DEF_HELPER_FLAGS_3(fcmp_ge, TCG_CALL_NO_WG, i32, env, i32, i32)
 
 DEF_HELPER_FLAGS_2(pcmpbf, TCG_CALL_NO_RWG_SE, i32, i32, i32)
 #if !defined(CONFIG_USER_ONLY)
-DEF_HELPER_3(mmu_read, i32, env, i32, i32)
-DEF_HELPER_4(mmu_write, void, env, i32, i32, i32)
+DEF_HELPER_FLAGS_3(mmu_read, TCG_CALL_NO_RWG, i32, env, i32, i32)
+DEF_HELPER_FLAGS_4(mmu_write, TCG_CALL_NO_RWG, void, env, i32, i32, i32)
 #endif
 
 DEF_HELPER_FLAGS_2(stackprot, TCG_CALL_NO_WG, void, env, tl)
 
-DEF_HELPER_2(get, i32, i32, i32)
-DEF_HELPER_3(put, void, i32, i32, i32)
+DEF_HELPER_FLAGS_2(get, TCG_CALL_NO_RWG, i32, i32, i32)
+DEF_HELPER_FLAGS_3(put, TCG_CALL_NO_RWG, void, i32, i32, i32)
-- 
2.25.1


