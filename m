Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DD8C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 17:22:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91D0F20771
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 17:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qO0fly9Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91D0F20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5uSV-00083N-QL
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 13:22:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56866)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k5uPn-0003nH-R3
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 13:19:51 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c]:42743)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k5uPm-00017v-4P
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 13:19:51 -0400
Received: by mail-pl1-x62c.google.com with SMTP id f5so1400632plr.9
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 10:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LLtRMDyuZBiRd8gTdg99mHl24bM/N9b6c5HKt7k9iXk=;
 b=qO0fly9Z/NZnbtfm/Djw3EjCfHBvuL+rHOYzZ4qspxrG+94xZqgq6UmiICjX8VqQeu
 Wts5twrbrvfWlsMYCLrtGzJG65aEfehrm4ZYXU362UnY+jMYGmpJkIb7cqtGoJgWVdq2
 r0oSOjKii3FjYBbQQ2rCQpXR4GYjVYri4WBZRVIfXW3sjUq7HOlLgIPGuX3nAqyoJV6R
 2XpT6TYY4v2onT30CrAyZWEJOOtPWJpNOlTn3WvtWKGaUXXiOKolc1s8p3bT4USJl24J
 2+y9K43Dyj2uYsY6GGUirHRMP1yzOxyj5owiDSfRZW6APC+oCkowRtbC4VuXe0zmeXv6
 C9oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LLtRMDyuZBiRd8gTdg99mHl24bM/N9b6c5HKt7k9iXk=;
 b=OIQUkqrV+uP/tDoa/O7slHJXydR6uvJM4iOl9cDPKIw0+ZI5SC4iXwgWVVZN6VFDa0
 +MhYQUr0KFNCGPC4OUlrK/hQlRszMtGH0sasgPxU7/CxlhBnQyPI7edGd6wqqm04iaK1
 dZOwwa7ZfMAb96zbYy69rpPm3iXqSVUYPB7lOaOSQQ/nFIhUoy3Dt4ncug6eFTZhE/Cg
 BrXKWMGeK5g//hXgU2147jBJzdNMbcVZ/iyiX7WCqEZCG524AhulXRChbh1Eq1FyWKFi
 07wufAG1K21fMMXboiY921Y2AN+KrwSx9REDjj1/VJWj2iaxB2cS6QeE8xizvZlrdwg6
 5lQg==
X-Gm-Message-State: AOAM533nqeBO5JOJSYtnzssn4wIiFGsyPR8FZeWdXUH68BUhVv/UyAID
 ymBc61TuMBquxwQcnQXKFL3rAv8vkfw=
X-Google-Smtp-Source: ABdhPJy8HWHKW0DtLI8VTJE4Ae1JPEljDPUf3FZP9TNUSWId3uH+QMzlufXKYbsKrPOKQwzUb5L48w==
X-Received: by 2002:a17:90a:8c8f:: with SMTP id
 b15mr1091982pjo.84.1597252788175; 
 Wed, 12 Aug 2020 10:19:48 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id y79sm3097206pfb.65.2020.08.12.10.19.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2020 10:19:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] target/arm: Complete ISS for MTE tag check fail
Date: Wed, 12 Aug 2020 10:19:43 -0700
Message-Id: <20200812171946.2044791-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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
Cc: Andrey Konovalov <andreyknvl@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, alex.bennee@linaro.org,
 peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As reported by Andrey, I was missing the complete ISS info for
the Data Abort raised upon a synchronous tag check fail.

The following should fix that.  All the twisty little rules for
the ISS.ISV bit are already handled by merge_syn_data_abort.
Probably the most important bit that was missing was ISS.WnR,
as that is independent of ISS.ISV.

Andrey, will you please test?


r~


Richard Henderson (3):
  target/arm: Export merge_syn_data_abort from tlb_helper.c
  target/arm: Pass the entire mte descriptor to mte_check_fail
  target/arm: Merge ISS for data abort from tag check fail

 target/arm/internals.h  |  4 ++++
 target/arm/mte_helper.c | 24 ++++++++++++++----------
 target/arm/tlb_helper.c |  8 +++-----
 3 files changed, 21 insertions(+), 15 deletions(-)

-- 
2.25.1


