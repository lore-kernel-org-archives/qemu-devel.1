Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495B8C46470
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 12:02:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16AF920989
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 12:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="APNkJD9/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16AF920989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45604 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNyo3-0000Pt-3n
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 08:02:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hNylm-0007T9-GR
	for qemu-devel@nongnu.org; Tue, 07 May 2019 08:00:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hNylk-0003Vp-Sp
	for qemu-devel@nongnu.org; Tue, 07 May 2019 08:00:26 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:37068)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hNylh-0003Mn-1m
	for qemu-devel@nongnu.org; Tue, 07 May 2019 08:00:23 -0400
Received: by mail-wr1-x431.google.com with SMTP id a12so11836809wrn.4
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 05:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=KaqMUdZIvo1p3+0snWz1rB7TqjtotCzx/m9HuR9akU8=;
	b=APNkJD9/M31qj9NRoOTh3SuNk/oTWBEkTG9ccfQ8hVBQ2GVTXcrKvE4dxdE6sRJS+6
	+vpX2pLicWEdIcLhmekm0DXDt+Yh+uY0hUBM2Xm8tfPyArpOmy3jzJ9APKV+T0+l+vib
	Nolm4jqJ3MQkbIP4phQHcEqqgXzX1Rsp5gqSFqnRl0gLQqkjfpmIyyx2ixnevQnQFAgK
	vprdD1NhwGVERioceKcBql8Z3FJhKgKdaGJeaCpKG9xk/bwMh8t5R4OusD+nWYHzEIOj
	nJgqV3lNJrDff25ElGC0w9/GbZmq57eY2nhgmBdSx9An0X/Hq+urkGXlIhkHXcYkTJdZ
	j56w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=KaqMUdZIvo1p3+0snWz1rB7TqjtotCzx/m9HuR9akU8=;
	b=AEWa3xGBx0tMDN/ZF0n31qah08jrCv4wnq9x3qmboMK84B7GOv/2vVAhcwkM85nsJr
	83taBXY7wdfrtHWfTmWDPuewWyGqCBdBtEiy5S9o5OotCblWQLpTBP4nGbNANL1UDQ4z
	UBWehsk51jI5baqKijLeKLZ8ItLgVZptsxTDgTEj6SqnLMA60ewDnnEdget2WD4ODJss
	92UvdvaIswjwJ9y0NLDTcZQfd6cUK0WJ/zX9RkxkrNgxZBYDkY5GwId3ipGFrNo0F/Az
	7T+M9LRv0DcEYueFKzqRBqg12NFSwOIi0gEQzsgoIp+NmvgozE5pJMrihwKwD1bmDQkr
	KrOg==
X-Gm-Message-State: APjAAAWNo+Aurz2B3/IWhAyS9nnc/GVnAdLkXldHP+Heghfy1s2uGCc4
	XP1JMvXLHZ+22jxlg+qNmQQObKligf0=
X-Google-Smtp-Source: APXvYqw6oC1FcVB/aYeFPxtxgMbgiLvHV/L5ZXiKK2VqCT2Wfxe5EbTcnjf/qZFIAbO0vPqvvZ/q9Q==
X-Received: by 2002:adf:dd8e:: with SMTP id x14mr21274644wrl.252.1557230414646;
	Tue, 07 May 2019 05:00:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id g3sm12348596wmf.9.2019.05.07.05.00.12
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 07 May 2019 05:00:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  7 May 2019 12:59:56 +0100
Message-Id: <20190507120011.18100-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::431
Subject: [Qemu-devel] [PULL 00/15] target-arm queue
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A mixed bag, all bug fixes or similar small stuff.

thanks
-- PMM


The following changes since commit 19eb2d4e736dc895f31fbd6b520e514f10cc08e0:

  Merge remote-tracking branch 'remotes/thibault/tags/samuel-thibault' into staging (2019-05-07 10:43:32 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20190507

for you to fetch changes up to 63159601fb3e396b28da14cbb71e50ed3f5a0331:

  target/arm: Stop using variable length array in dc_zva (2019-05-07 12:55:04 +0100)

----------------------------------------------------------------
target-arm queue:
 * Stop using variable length array in dc_zva
 * Implement M-profile XPSR GE bits
 * Don't enable ARMV7M_EXCP_DEBUG from reset
 * armv7m_nvic: NS BFAR and BFSR are RAZ/WI if BFHFNMINS == 0
 * armv7m_nvic: Check subpriority in nvic_recompute_state_secure()
 * fix various minor issues to allow building for Windows-on-ARM64
 * aspeed: Set SDRAM size
 * Allow system registers for KVM guests to be changed by QEMU code
 * raspi: Diagnose requests for too much RAM
 * virt: Support firmware configuration with -blockdev

----------------------------------------------------------------
Cao Jiaxi (4):
      QEMU_PACKED: Remove gcc_struct attribute in Windows non x86 targets
      qga: Fix mingw compilation warnings on enum conversion
      util/cacheinfo: Use uint64_t on LLP64 model to satisfy Windows ARM64
      osdep: Fix mingw compilation regarding stdio formats

Joel Stanley (1):
      arm: aspeed: Set SDRAM size

Markus Armbruster (3):
      pc: Rearrange pc_system_firmware_init()'s legacy -drive loop
      pflash_cfi01: New pflash_cfi01_legacy_drive()
      hw/arm/virt: Support firmware configuration with -blockdev

Peter Maydell (7):
      hw/arm/raspi: Diagnose requests for too much RAM
      arm: Allow system registers for KVM guests to be changed by QEMU code
      hw/arm/armv7m_nvic: Check subpriority in nvic_recompute_state_secure()
      hw/intc/armv7m_nvic: NS BFAR and BFSR are RAZ/WI if BFHFNMINS == 0
      hw/intc/armv7m_nvic: Don't enable ARMV7M_EXCP_DEBUG from reset
      target/arm: Implement XPSR GE bits
      target/arm: Stop using variable length array in dc_zva

 contrib/libvhost-user/libvhost-user.h |   2 +-
 include/hw/arm/aspeed.h               |   1 +
 include/hw/arm/virt.h                 |   2 +
 include/hw/block/flash.h              |   1 +
 include/qemu/compiler.h               |   2 +-
 include/qemu/osdep.h                  |  10 +-
 scripts/cocci-macro-file.h            |   7 +-
 target/arm/cpu.h                      |  13 ++-
 hw/arm/aspeed.c                       |   8 ++
 hw/arm/raspi.c                        |   7 ++
 hw/arm/virt.c                         | 202 ++++++++++++++++++++++------------
 hw/block/pflash_cfi01.c               |  28 +++++
 hw/i386/pc_sysfw.c                    |  18 +--
 hw/intc/armv7m_nvic.c                 |  40 ++++++-
 qga/commands-win32.c                  |   2 +-
 target/arm/helper.c                   |  47 +++++++-
 target/arm/kvm.c                      |   8 ++
 target/arm/kvm32.c                    |  20 +---
 target/arm/kvm64.c                    |   2 +
 target/arm/machine.c                  |   2 +-
 util/cacheinfo.c                      |   2 +-
 21 files changed, 294 insertions(+), 130 deletions(-)

