Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D476C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 14:13:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C426207F9
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 14:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GsU/pvJ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C426207F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbPSt-0003y8-IS
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 10:12:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55188)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jbPM2-0008S8-2b
 for qemu-devel@nongnu.org; Wed, 20 May 2020 10:05:54 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:42853)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jbPM0-0001w4-No
 for qemu-devel@nongnu.org; Wed, 20 May 2020 10:05:53 -0400
Received: by mail-ed1-x544.google.com with SMTP id k19so3171064edv.9
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 07:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Qlw02NVecU/ZV81h9ZnM/tUYlZiIp12SHyZcSJattzs=;
 b=GsU/pvJ/JHy8w8Ig8FKbPM88bWyQGq4vVeUgJlAytd9wp1HL1+gUZC7Q5GJe9PkIDn
 AZ2AHbpneM034tY5zqEu0D17nBfZpCyKbDM79aKcQ6G3xQzvr09n3pBl+gppS8kU00BD
 bNFJpn2waToX2wc4ijSvJz9h5a5xEWDUM62YK9dDs04KsizFoVS7HrnHOFwpMacJp5/J
 TFQfz6fPVoFTZyCEtkAp045fofCHKfFEgX6e3cT1EL9NPot185bMY1SlVd1Y2UEjABPl
 5qnOrFHu2DTqyUsH9iQJ19o2Y7nQa84i5Whj2om3+69r6SB0aiWlqk3zk+1TvRyns0sq
 SaZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Qlw02NVecU/ZV81h9ZnM/tUYlZiIp12SHyZcSJattzs=;
 b=WSi+8917AeAQpih/Qet/GtrFPyW9nUrh4Y8oAfTymKuIOj18UrML3cXOTq77pND0s2
 vHkFwx1QmJif/y09yc+I3uBdnoqiH3ZaZdlVYH7dghosnCXC0qMhdrQ8vEyK+RC1VtLi
 AlvUgynU2Ls9CLBjjY4UU3QaqOFB0aaAJJzP2Q1nAw8qcjOgDKYYM7eKLCLkke//qaTG
 GLasr0GEd/UIEKrTJ+FyZp/rzX7b58IF5lDlFC0ev7P8IpfJUPANadqgEmY2dy6YIPP3
 lcrxf7o9e8kqr43/p0VIIldpMbFTXNGwr3/WdsX+oUaLRpTks/bbvwsO95fD6a/R69Xj
 K0xg==
X-Gm-Message-State: AOAM533QoyZ0ZaW7nC2iLM2sLYqIsqslEaxRVcY1v/ZSfDlOm4M5VjQC
 kzwWVgxyleSSn1H9bIpTs2U458/6mR0=
X-Google-Smtp-Source: ABdhPJzo4fzavfXL6hcnnvlYv1yluh6pGjaOaX03x3LyqQVd4vC1a+8sf16Brar8cTLUjIkvrQjbEA==
X-Received: by 2002:aa7:db45:: with SMTP id n5mr3355029edt.147.1589983550701; 
 Wed, 20 May 2020 07:05:50 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id gf25sm1973382ejb.54.2020.05.20.07.05.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2020 07:05:49 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A39DE1FF91;
 Wed, 20 May 2020 15:05:41 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 05/15] tests/fp: enable extf80_le_quite tests
Date: Wed, 20 May 2020 15:05:31 +0100
Message-Id: <20200520140541.30256-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200520140541.30256-1-alex.bennee@linaro.org>
References: <20200520140541.30256-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x544.google.com
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These have been fixed now so we no longer need a special version of
the le_quiet rule to skip the test.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/Makefile.include | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 03a74b60f6b..e6d87fcbf0e 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -741,13 +741,6 @@ check-softfloat-%: $(FP_TEST_BIN)
 SF_COMPARE_OPS=eq eq_signaling le le_quiet lt_quiet
 SF_COMPARE_RULES=$(patsubst %,check-softfloat-%, $(SF_COMPARE_OPS))
 
-# FIXME: extF80_le_quiet (broken)
-check-softfloat-le_quiet: $(FP_TEST_BIN)
-	$(call test-softfloat, 				\
-		f16_le_quiet f32_le_quiet f64_le_quiet  \
-		f128_le_quiet, 				\
-		le_quiet)
-
 # FIXME: extF80_lt_quiet (broken)
 check-softfloat-lt_quiet: $(FP_TEST_BIN)
 	$(call test-softfloat, 				\
-- 
2.20.1


