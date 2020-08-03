Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70979C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 19:35:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2191207DF
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 19:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ghliLOsV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2191207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2gEs-0002GI-V5
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 15:35:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k2gDp-0001OT-1P
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 15:34:10 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:50619)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k2gDl-0003Z2-Tx
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 15:34:08 -0400
Received: by mail-wm1-x336.google.com with SMTP id c80so623866wme.0
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2020 12:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SBv00l6mJRRMDhisg/obEskNEKOL3W/QsgPF0XzvGeM=;
 b=ghliLOsVddvG/UHboO8BOI06TkJLemmokwrDtGcmDmiomLuCJLTKe0euXD6NOHbjcC
 mlWeF95KcbXyJWlahztqmQvTJp0pbDJPFX7cg4b4MBFPXiVi/+HPSDCmDnv0a9Qcf9Db
 AP7cI/NuKL7/2UT6858EJaZG7Qr4E5pOos13H1IE2dKW/anyLz9w95IP69OxMtXu1lA1
 QbmSDyQhZQ8mXqK2iiUKkl3Z3ADKpVpC0EF1Ih357QBAoVzmxEqas4MaZZ2mhrG+29Tw
 kLShWAJcaIRn/phIg3wdFjdxVL6jAHpZEE4NV5Q6OMELL1R4Rj4Q5oPSLVEw86harG6w
 wp7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SBv00l6mJRRMDhisg/obEskNEKOL3W/QsgPF0XzvGeM=;
 b=oUNgNKbZpYuE4hVZ9Cp8Bj+TzyA2wl+zbxGKNvvOomw73rpgSvr8NLMwnqELXQ0fz8
 4d9qOhhQui27/p4dqgpPciIlCFGGoOnR1YhNjj4Gh/2M+zDt5q0mUhH+XMjQUHZwqJ1f
 Jfuq8t8epsG8ILBDpIXxfPpnVF16ChuyKlX5j/rDeEyunoTgI/zT/2jvgDcRfa6Mqv+0
 PF2iI3Y950nYCamgKCGYf6mWpFtaKOHNnow2eUfibHHS02M5uc1SMX3cZR8liIgZ2i5B
 x+1h4TvX7Ws44i3AgEdBJvnKy0ae8PEaEa7pVG0J8MoF6M5bSg94UoaNxEzERAT7+Ccz
 Aj6Q==
X-Gm-Message-State: AOAM533nN2/yEpTdS1N8xhmdgiPWrOuWjvgh+RlB0s1XlVSeF1e1kzaH
 Nz+DI3av7wwvS5D/3/rwoYA3mfDNuYMpPQ==
X-Google-Smtp-Source: ABdhPJwEvIMVkjT1MqZ7DcJfTiVdr6FDYUZcpgd4rGYxpLAkCP9/16JJUZTWLTwzbbleOXEpiQzKxw==
X-Received: by 2002:a1c:3dc3:: with SMTP id k186mr643915wma.122.1596483243007; 
 Mon, 03 Aug 2020 12:34:03 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r206sm985565wma.6.2020.08.03.12.34.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2020 12:34:01 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/8] target-arm queue
Date: Mon,  3 Aug 2020 20:33:51 +0100
Message-Id: <20200803193359.12936-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Handful of bugfixes for rc2. None of these are particularly critical
or exciting.

-- PMM

The following changes since commit 45a150aa2b3492acf6691c7bdbeb25a8545d8345:

  Merge remote-tracking branch 'remotes/ericb/tags/pull-bitmaps-2020-08-03' into staging (2020-08-03 15:13:49 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20200803

for you to fetch changes up to 13557fd392890cbd985bceba7f717e01efd674b8:

  hw/timer/imx_epit: Avoid assertion when CR.SWR is written (2020-08-03 17:56:11 +0100)

----------------------------------------------------------------
target-arm queue:
 * hw/timer/imx_epit: Avoid assertion when CR.SWR is written
 * netduino2, netduinoplus2, microbit: set system_clock_scale so that
   SysTick running on the CPU clock works
 * target/arm: Avoid maybe-uninitialized warning with gcc 4.9
 * target/arm: Fix AddPAC error indication
 * Make AIRCR.SYSRESETREQ actually reset the system for the
   microbit, mps2-*, musca-*, netduino* boards

----------------------------------------------------------------
Kaige Li (1):
      target/arm: Avoid maybe-uninitialized warning with gcc 4.9

Peter Maydell (6):
      hw/arm/netduino2, netduinoplus2: Set system_clock_scale
      include/hw/irq.h: New function qemu_irq_is_connected()
      hw/intc/armv7m_nvic: Provide default "reset the system" behaviour for SYSRESETREQ
      msf2-soc, stellaris: Don't wire up SYSRESETREQ
      hw/arm/nrf51_soc: Set system_clock_scale
      hw/timer/imx_epit: Avoid assertion when CR.SWR is written

Richard Henderson (1):
      target/arm: Fix AddPAC error indication

 include/hw/arm/armv7m.h           |  4 +++-
 include/hw/irq.h                  | 18 ++++++++++++++++++
 hw/arm/msf2-soc.c                 | 11 -----------
 hw/arm/netduino2.c                | 10 ++++++++++
 hw/arm/netduinoplus2.c            | 10 ++++++++++
 hw/arm/nrf51_soc.c                |  5 +++++
 hw/arm/stellaris.c                | 12 ------------
 hw/intc/armv7m_nvic.c             | 17 ++++++++++++++++-
 hw/timer/imx_epit.c               | 13 ++++++++++---
 target/arm/pauth_helper.c         |  6 +++++-
 target/arm/translate-a64.c        |  2 +-
 tests/tcg/aarch64/pauth-5.c       | 33 +++++++++++++++++++++++++++++++++
 tests/tcg/aarch64/Makefile.target |  2 +-
 13 files changed, 112 insertions(+), 31 deletions(-)
 create mode 100644 tests/tcg/aarch64/pauth-5.c

