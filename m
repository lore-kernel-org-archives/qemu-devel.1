Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D601C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 04:53:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 816A122247
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 04:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Odh/43UL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 816A122247
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSvGJ-0007s6-FQ
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 00:53:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38520)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kSvFO-0006iH-Ap
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 00:52:14 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432]:44413)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kSvFM-0003OJ-C0
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 00:52:13 -0400
Received: by mail-pf1-x432.google.com with SMTP id f19so1224291pfj.11
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 21:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4soEDKJuibUN8OEzd0Fvdz96fBYe0QIe/zqDPhACTvE=;
 b=Odh/43UL/E7oeSXiLre96B8THbNXIuHORjI+ozsTMRQ7bSxW/iyWQKjAvOskQZcaNC
 ujUPGWX0lucE6P5xTwmWRnyiCwmyYQi9DRFXh4s4y9e48ToSKP65QpIn8MG3eZmyGEif
 GbaWHyuGGRI6+zgTiBYSI5oBlELooWiIgfx/3Bzu32GTVYJF/o2UPPWvbww4BZcH15NI
 saJAuv44quw9TFChNeYa1w/rS1MxGX8NxwXs4qe3Ry7LpIWtsO16BsMbYxcfzNrqQjNY
 PGbjGot+4pE89cVCe/D9Y4njYPOModK0fggsKOrZhXwE0UUIf8dVSjz8SHQX83KXJNal
 5v/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4soEDKJuibUN8OEzd0Fvdz96fBYe0QIe/zqDPhACTvE=;
 b=eqt2rV8wDF2h5/Z9+gI1UEz0liBgcSJQTpr4rAQzkE6nEPL3UpJfjSU1GDzH+gl5+k
 utLr7rO5PMjZcnLX6pL3YLbTb/uueHe5E8xkAQhdT2s76sloj+guT57i/ADo2gDt+HA6
 vtCqY3jiNUey5ixlLm6bIpPh7s8Jp5CfeTqG1PEte5TOV/LJBEnWOjROwUQEc1hteSB/
 oevdCpFYkml4ombIq0uC+FKkkNSI1eahJIiikfws04Uyf7+ok698LXC1yBpv+aD0nsL/
 Qx61LTjw+PsskYe5ts+E6tG5pdv0VvJ+tjlIuiB7dO7KPRChu2V2EptgibRE3ElBux13
 CAlw==
X-Gm-Message-State: AOAM531/6ShmYnxJFiXMEVMlPfZs/+bqKoj/1rlDxbvqu3fdMlOjavFg
 uTEl6Ru4gBh6xM+EwJfzHWAVAHNrGYGyMg==
X-Google-Smtp-Source: ABdhPJzX2sEOH++8rWDk5QcYQxt964uwB/+jVb0CmU/HTLsfcPjskbDJR4LDxU9xTES45eWYT0gA9Q==
X-Received: by 2002:a63:5352:: with SMTP id t18mr1909346pgl.51.1602737530255; 
 Wed, 14 Oct 2020 21:52:10 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id q66sm1407493pfc.109.2020.10.14.21.52.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2020 21:52:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/3] microblaze patch queue
Date: Wed, 14 Oct 2020 21:52:05 -0700
Message-Id: <20201015045208.595044-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 57c98ea9acdcef5021f5671efa6475a5794a51c4:

  Merge remote-tracking branch 'remotes/kraxel/tags/ui-20201014-pull-request' into staging (2020-10-14 13:56:06 +0100)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-mb-20201014

for you to fetch changes up to 49e258df83e2200847cd4b331f48d8d872fba51c:

  linux-user/microblaze: Remove non-rt signal frames (2020-10-14 21:19:56 -0700)

----------------------------------------------------------------
Implement rt signal frames for microblaze-linux-user
Adjust linux-user test for musl

----------------------------------------------------------------
Richard Henderson (3):
      tests/tcg/linux-test: Adjust getsockname for musl
      linux-user/microblaze: Implement rt signal frames
      linux-user/microblaze: Remove non-rt signal frames

 linux-user/microblaze/target_signal.h |   1 -
 linux-user/microblaze/signal.c        | 186 +++++++++++++++-------------------
 tests/tcg/multiarch/linux-test.c      |   2 +-
 3 files changed, 84 insertions(+), 105 deletions(-)

