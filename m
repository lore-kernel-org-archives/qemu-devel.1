Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A93C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 13:34:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80B1F222F2
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 13:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GfA2wqpc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80B1F222F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX3eK-00059S-JH
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 08:34:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36115)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iX3bk-0003Lr-Rl
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 08:31:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iX3bj-00049y-1Q
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 08:31:52 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:40940)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iX3bi-00049D-RP
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 08:31:50 -0500
Received: by mail-wm1-x331.google.com with SMTP id f3so3603427wmc.5
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 05:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6PeGfh5MCg2KsIn9b3qx2FjkDH2ZN6ac4tJhf2EpZy4=;
 b=GfA2wqpcjTBWIuyJENDwoJnn2m8Xu7I8igsfSnH0j+W1b3fM+5WsFGniGDPDukgkH2
 4bBdv8O66PoeIgeJ/16RbBUVgYfZUuk6K2eqhedtPY0NMZy7EAuShMWU/ruQuvamoCpY
 EhvFKUpSfVBaGEB4M0n+VsUI3aJIAthH4Xp0TtSECSRPvBc3eTdpd3LV3/XDyua2xm+E
 ymUxmlM3jkygm6Sk/hUdEVfPxWobfRMdTn7Kh2ro77WkTASxBBVOl0p2NB7hMwRUiQBh
 3/vBjO7MsEpXZV03kgxW/blybqzJcqbKpkRVAYB0GMD13yFOZIMFDuSl6BbfXuhj/NJX
 4efg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6PeGfh5MCg2KsIn9b3qx2FjkDH2ZN6ac4tJhf2EpZy4=;
 b=ISMHOykmbF7WMOW8LT2x2y9ARC8jKUmdHBvK9/WdkafdWov0OFFLcf/x0M2FuEgeYb
 QzbdOGZUwfQfWYd4tDAB8CD5E8kKQDok98Et4CKVLdKeK9lw9OQL/ltFj/odUWwshbM9
 TOO7OlNIswTtbhZdQeniupqa+1ZrCTktiwuE9EnRZN6e7KLgqDTaBVoRoQYUOWjIz4qm
 jUoPdZ8a7qHau3J/RBqgfVdygfx/yUpCdO24BRMlrjoK3OQZq7/hNQh0/gcV5y/K1FmB
 Pu61tL++BgHEgVzmluBjjJ/Vbk3TFgZF4MRbch1+FGjLa/j70P+ip6yNp8y0W8BOquUK
 Pc4Q==
X-Gm-Message-State: APjAAAV7EBk/l6DZ1/9x2SPaeTnklWiWpGjx5jpQ4gpvGy1j80jSQ7He
 AKxEs9PCjzPlPho2kIZlHJBAxYBzNaAW1A==
X-Google-Smtp-Source: APXvYqydQWqmHta7YuZ+1P1sgcESQRC187yZhbsikWbJTRU1xAtDOWa3h7lo6ZawKY1EIYXcJH+ZtQ==
X-Received: by 2002:a05:600c:3cc:: with SMTP id
 z12mr6033866wmd.151.1574170308133; 
 Tue, 19 Nov 2019 05:31:48 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id g8sm3094905wmk.23.2019.11.19.05.31.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2019 05:31:47 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/7] target-arm queue
Date: Tue, 19 Nov 2019 13:31:38 +0000
Message-Id: <20191119133145.31466-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::331
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Target-arm queue for rc2 -- just some minor bugfixes.

thanks
-- PMM

The following changes since commit 6e5d4999c761ffa082f60d72a14e5c953515b417:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-monitor-2019-11-19' into staging (2019-11-19 11:29:01 +0000)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20191119

for you to fetch changes up to 04c9c81b8fa2ee33f59a26265700fae6fc646062:

  target/arm: Support EL0 v7m msr/mrs for CONFIG_USER_ONLY (2019-11-19 13:20:28 +0000)

----------------------------------------------------------------
target-arm queue:
 * Support EL0 v7m msr/mrs for CONFIG_USER_ONLY
 * Relax r13 restriction for ldrex/strex for v8.0
 * Do not reject rt == rt2 for strexd
 * net/cadence_gem: Set PHY autonegotiation restart status
 * ssi: xilinx_spips: Skip spi bus update for a few register writes
 * pl031: Expose RTCICR as proper WC register

----------------------------------------------------------------
Alexander Graf (1):
      pl031: Expose RTCICR as proper WC register

Linus Ziegert (1):
      net/cadence_gem: Set PHY autonegotiation restart status

Richard Henderson (4):
      target/arm: Merge arm_cpu_vq_map_next_smaller into sole caller
      target/arm: Do not reject rt == rt2 for strexd
      target/arm: Relax r13 restriction for ldrex/strex for v8.0
      target/arm: Support EL0 v7m msr/mrs for CONFIG_USER_ONLY

Sai Pavan Boddu (1):
      ssi: xilinx_spips: Skip spi bus update for a few register writes

 target/arm/cpu.h       |   5 +--
 hw/net/cadence_gem.c   |   9 ++--
 hw/rtc/pl031.c         |   6 +--
 hw/ssi/xilinx_spips.c  |  22 ++++++++--
 target/arm/cpu64.c     |  15 -------
 target/arm/helper.c    |   9 +++-
 target/arm/m_helper.c  | 114 ++++++++++++++++++++++++++++++-------------------
 target/arm/translate.c |  14 +++---
 8 files changed, 113 insertions(+), 81 deletions(-)

