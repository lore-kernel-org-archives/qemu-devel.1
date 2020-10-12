Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384A6C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 16:02:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1C422074A
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 16:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="abJFFijJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1C422074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS0Gx-0001Dc-NN
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 12:02:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58030)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRztg-0003d1-LY
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:38:00 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:42820)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRztW-0007ku-9q
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:38:00 -0400
Received: by mail-wr1-x42c.google.com with SMTP id e18so19682303wrw.9
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 08:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xP7RYtiStIWwohnsCkXsA5s/UDVdCQBRgpCwB9l5Xb0=;
 b=abJFFijJW9RLhCr7A6Uo/HaFEtqhjwDlKOR8miTvYsT7Vr0NCtOSHMyvcED3sBm84N
 y5ghhpI9ftafjkklGUjSehXAFPcz2VB7R7EvsEwO7qiiV7Bii9jxQ6sI4nj4Vkbv9cIm
 erQgdbZQmRITCK0+YTfIw3+V8y36NNoCt5h6XBUWJet8ui+2dAzOywXjWJPb2/QoRnVS
 M7jW2YYBjra+Rt+r256E1SazFaQcjjTGhE0qXivLWRzvAUxmaX6E0GHNrKKW9ejf0ph2
 gzEITM7xiFXEZPrAR25VXcW7+d8Rz2U4J0iDjBSwEXLD2jdEHn/MoZ6R0inROeYIdb53
 3Xxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xP7RYtiStIWwohnsCkXsA5s/UDVdCQBRgpCwB9l5Xb0=;
 b=RUNQ7y0L3Yr/y+q6eeyIwik4sW4TfL5uLrfp0SeJShbrEnJw1yeZ0pcfZiPBzxaAfz
 K8olyw5/rA9h06OVXysHBkiiByVw6ftVJk5yzzXpp23qpeG1l/9M3lDSV9GSKEb0Gcbm
 100BvHwTlVSnCZuplYsOGG6Ma6i9GdmIbVw/UWiFBFgMj+OVnk55/J6mUQWIokCPgTAY
 UBjTyngwRZEW3JAf7Tll2KklCUIe9M4IcSQfHIiYm4Xgm1cAJpDPBvgMZl7ndOe1uYMb
 XJBWwmSOS+QwR+oIwhSbisLO5LjzyxvTjVwsmAOWm0XoBeIQZIwWvzALY+5Nf5PTSATe
 /S7g==
X-Gm-Message-State: AOAM530Al12OZW2qqzfQX1uf1d0Q77QRwEE3a2RcTAQQq5sfF8LzXTQY
 ukO66VC95yry/30dgR3hNbM5jw==
X-Google-Smtp-Source: ABdhPJxWCtDbvvuUD6kgTD4LssnVNdBeMVmyH7yHOiQlrbT3c2leMcJ74r9115BlxrlcEITPnW97Iw==
X-Received: by 2002:a5d:678d:: with SMTP id v13mr19131862wru.148.1602517068713; 
 Mon, 12 Oct 2020 08:37:48 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y66sm7095961wmd.14.2020.10.12.08.37.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 08:37:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 00/10] target/arm: Various v8.1M minor features
Date: Mon, 12 Oct 2020 16:37:36 +0100
Message-Id: <20201012153746.9996-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patchseries implements various minor v8.1M new features,
notably the branch-future and low-overhead-loop extensions.

(None of this will get enabled until we have enough to implement
a CPU model which has v8.1M, which will be the Cortex-M55, but
as usual we can get stuff into the tree gradually.)

Patch 1 is a decodetree fix suggested by Richard that is
necessary to avoid wrong-decode of the changes to t32.decode
by later patches.

(Apologies for the accidental mailbombing of the list with
stale patches due to a mangled command line on my first attempt
at sending this :-(  )

thanks
-- PMM

Peter Maydell (10):
  decodetree: Fix codegen for non-overlapping group inside overlapping
    group
  target/arm: Implement v8.1M NOCP handling
  target/arm: Implement v8.1M conditional-select insns
  target/arm: Make the t32 insn[25:23]=111 group non-overlapping
  target/arm: Don't allow BLX imm for M-profile
  target/arm: Implement v8.1M branch-future insns (as NOPs)
  target/arm: Implement v8.1M low-overhead-loop instructions
  target/arm: Fix has_vfp/has_neon ID reg squashing for M-profile
  target/arm: Implement FPSCR.LTPSIZE for M-profile LOB extension
  target/arm: Fix writing to FPSCR.FZ16 on M-profile

 target/arm/cpu.h               |   7 ++
 target/arm/m-nocp.decode       |  10 ++-
 target/arm/t32.decode          |  50 +++++++----
 target/arm/cpu.c               |  34 ++++---
 target/arm/translate.c         | 157 +++++++++++++++++++++++++++++++++
 target/arm/vfp_helper.c        |  30 +++++--
 scripts/decodetree.py          |   2 +-
 target/arm/translate-vfp.c.inc |  17 +++-
 8 files changed, 268 insertions(+), 39 deletions(-)

-- 
2.20.1


