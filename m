Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E64C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 15:35:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E9032087D
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 15:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IqJ2FBs3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E9032087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRzrg-0008NF-Q8
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 11:35:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56298)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRzq3-0006Lc-6L
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:34:15 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:53377)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRzq1-0007D9-0z
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:34:14 -0400
Received: by mail-wm1-x32b.google.com with SMTP id f21so17498836wml.3
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 08:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uOFoZu1In90IQ/7mmNLwUBRcHp1HA2VeP+OkYjMIn7M=;
 b=IqJ2FBs3WvZD6BvFPJhn6j2YefDALfKZWtre398LuM4e7oFJdK673oLz/HXZvdbDvD
 HUJ3peg1NjFH7uqda1iZjxAs4Q4FbVN7hkeTVQ+Sj/QDHJ/rNfolxzYiUCgUmb9rv1xn
 MQnUdEbQOOhEfHPA9h5LQ058POxKwVXaqtqa6BFstdNYsWXlWSHFwU077KW6hnPmk9fu
 DpZh8iAUxyT8OJ0jKzjMhFo5uaiayUEP12OAzDGnKR0IaZpIymJG9v8vyJQHdbIK7tlT
 FWj/0RnbUxVbkwIU4tbgL5CUmHgbqp1R4exgkpw5711s2iZ+48DrgkUYoY6PaKz+9KRD
 J3HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uOFoZu1In90IQ/7mmNLwUBRcHp1HA2VeP+OkYjMIn7M=;
 b=jL/0ccpJGTTi39fd5PVcce644W8IT0ILSe9C95w86QKlw+UiNeCZqIft6DwaR+cPvb
 1+QDldXKm0L6rpg0XqzObboZSrTvA+t3DLhdUsgFEYZmymvVzpFtP6TvIp6xGre21SLx
 UkuuUIXAQag9Fu0W3E+bItQqEKnc0tKxwriiJ3vOMdwqoyGujfT6NAMeXXBrwnwkrWg3
 0VrDKKwHCKbSxvb2bPG+2tTQ9I8xwVvzmfKiwXSQS7LiOn/yD9f2KzKHkegVRoC98xYc
 09MVNsVckZAywA3LnaxL/z+PtmEKyCnS08+8iDZpGfgEawK3NoShm0J2o5glJrK28T+i
 RiIw==
X-Gm-Message-State: AOAM530ZOCGGZEn+/hOJE/i6a0eqUWTxKe47+sA31aVGHxnnVWGFZwIf
 lMBA9Pa1jnWfdoi5XNJEXmljUw==
X-Google-Smtp-Source: ABdhPJyIizfWjoh2AG+Vjd2wxB/id85jfytgHyh5jYcA3QGtEz5QqOWurz8wC0kl5ngMuzDF+ZYd3w==
X-Received: by 2002:a7b:cc89:: with SMTP id p9mr11798293wma.4.1602516850497;
 Mon, 12 Oct 2020 08:34:10 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y10sm19675284wrq.73.2020.10.12.08.34.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 08:34:09 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 00/10] target/arm: Various v8.1M minor features
Date: Mon, 12 Oct 2020 16:33:23 +0100
Message-Id: <20201012153408.9747-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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


