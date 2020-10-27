Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D018C55179
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 16:52:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDC4620727
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 16:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aO0jQoi8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDC4620727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXSDL-0004nw-QG
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 12:52:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56450)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kXSBu-0003HD-G3
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 12:51:23 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436]:42008)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kXSBr-0004RH-Rp
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 12:51:21 -0400
Received: by mail-pf1-x436.google.com with SMTP id x13so1243772pfa.9
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 09:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=htVRqbb7I8n2EhpJJNabhNF/ZVFeprwcL/kdHccA6cM=;
 b=aO0jQoi8BlPl30m9yNlhWvYZw74S1X6NYqp6BJERJUbLl1xKzb0YQrysiKwwcdj8Br
 ufVa6aKWXuBeJNgF5TfgtweHJuGLZ9LaixPC7xGKz1NNJuxF3Au7R93FqoSqGTNhpWxJ
 hwtxxj4FJxqtvwVCma8Rszbib3+7zFI+KVbX1RpfiWEueyz8eztRu1uiembOciCy1dA+
 ioIL6LqISNZ3eNHQN/iTsigQ8zkoGctx02N1/5nzbA/VjgKKNTGEwleSk+y24FK1KNTN
 dS8sTcSNAVYhEi3R1LQl6+ThY3Z3pII8pKiBjwRQro9+Gdq/920e2i30KAO4ypBOjgs0
 Hpbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=htVRqbb7I8n2EhpJJNabhNF/ZVFeprwcL/kdHccA6cM=;
 b=h5EH64uUVVbH+Y9pNbzD8GQ3BJ5I2VGZlIiWFZLNydMJE0FefUKhJ59NjX4q8CJsph
 DzWg678P20RMKidxSRO5Z3vrrVNoqBEW+ixolH15JcHgr+2jCPEmNe9qDtVDxucAkoAB
 yckrqIunTdCKgwCl3eJRLuDVRM7cuO7p60hsEt/7LgWP6AFyjsji6W3XkiWY9B+ODZxh
 sq45Gw7PIVU4aUlrqWFHmFN3Bg4FIMW1J+N7xk21jVHn36MTiYgIqFmQiCrCH3h2ZCeh
 qKcTyEahLs0zEo3f6aVfaRZWV7x9iZjKJ0GxOzfRyFB1eQtiD+2Jd94ZAZqK6VEYakrK
 AClQ==
X-Gm-Message-State: AOAM533fWto/SeTiaFA9p3jcZA5OdyFzez+ZJYZOjGibx/f2+YUjgbfz
 VkNEREf5hOu3CjeUjqn33Phjn3qu9OYWrQ==
X-Google-Smtp-Source: ABdhPJz6ac7fnw73pDsQZTAKTGdzPuIzm2+kf5fB35drJ3AvX9wUXvw/B40A9ReR2qWBPKsA7XUTAA==
X-Received: by 2002:a63:5458:: with SMTP id e24mr2641220pgm.73.1603817477057; 
 Tue, 27 Oct 2020 09:51:17 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id q16sm2955283pfj.117.2020.10.27.09.51.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 09:51:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/3] tcg patch queue
Date: Tue, 27 Oct 2020 09:51:11 -0700
Message-Id: <20201027165114.71508-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

The following changes since commit 4a74626970ab4ea475263d155b10fb75c9af0b33:

  Merge remote-tracking branch 'remotes/stefanha-gitlab/tags/tracing-pull-request' into staging (2020-10-27 11:28:46 +0000)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20201027

for you to fetch changes up to 1d705e8a5bbfe36294081baa45ab68a9ad987f33:

  accel/tcg: Add CPU_LOG_EXEC tracing for cpu_io_recompile() (2020-10-27 09:48:07 -0700)

----------------------------------------------------------------
Optimize across branches.
Add logging for cpu_io_recompile.

----------------------------------------------------------------
Peter Maydell (1):
      accel/tcg: Add CPU_LOG_EXEC tracing for cpu_io_recompile()

Richard Henderson (2):
      tcg: Do not kill globals at conditional branches
      tcg/optimize: Flush data at labels not TCG_OPF_BB_END

 include/tcg/tcg-opc.h     |  7 +++---
 include/tcg/tcg.h         |  4 +++-
 accel/tcg/translate-all.c |  4 ++++
 tcg/optimize.c            | 35 +++++++++++++++---------------
 tcg/tcg.c                 | 55 +++++++++++++++++++++++++++++++++++++++++++++--
 5 files changed, 82 insertions(+), 23 deletions(-)

