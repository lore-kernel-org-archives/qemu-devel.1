Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4A4C43461
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:25:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF11C208CA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VRHjJryl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF11C208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBadA-0005NY-4k
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 05:25:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45672)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBacN-0003jR-NL
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:24:19 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:36646)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBacL-0004CB-Mg
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:24:19 -0400
Received: by mail-wr1-x434.google.com with SMTP id x7so632613wro.3
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 02:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=djzxROywXETvEXbTAZgD0V33eG4XBAGoEVWBCeA5TI0=;
 b=VRHjJrylKMSTHhNnuS5RPIl0U3y7uQ8eWofrhWZWlqZ9aD4vJ2czE8pKnVge2qxZyE
 IIKP8NSRbd2WrQlnJ9Fh660xfKcRIsA46uUGdGqEF2J/0e+Qqpt1XolOaRyNmqOPclOQ
 SXTyGLS2RlIdcPLwbTWHY4FQFeukIKijQuCl0WE0XUkvIVF57sC16/MxttAmM9Q1gSzF
 853UHNwZijnF/v/V0xTrjCnArhedjXLgWH1/czw7dqsN8la9vZfUF5GHYQiUgGhZXzIH
 sf+FLzh+xWBWWSsgNAy/86Es6G5T1DpC6zT8tl2jnNkArUSBK35zIJkpneqWO3t+KRq8
 qaTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=djzxROywXETvEXbTAZgD0V33eG4XBAGoEVWBCeA5TI0=;
 b=k9tvQFS+O24vRSjNSrMeF0TQ0F3+7+NE+EHD55ygBHLt48/zIS19Tm645/AGW425Dv
 qO1r6T2DPK55poUPRowOOPfdtvzZi+HFz2I5q++IQZAEPsMu4+CX+bk324B/iRzgjRQB
 iyhH4cBsBGrzLhibnHm4NMBZUSel6MSl3/nAA6CsrNMFo8L///4oHXLGMysbcNRveE2o
 tPXoIMJZw1Ked+Vcywb1IXwhoSkjkjeLnVa9Vn6DbSvMw3/agE/gVIA6USEm4AvoJU3U
 p5v8kdK7PpaD1H+J5BLzDDwPWFx+FgLdJV8v2zGrtsjztKWVnvG5iv+zSDFxGb7X5NzX
 e45Q==
X-Gm-Message-State: AOAM531QeuUDLipYvLjVpVAYR7Z2l/UgMJZG23NC3f6kfGkcQC+gndW7
 8SxrdxHTDfhRqC+FhzQNt4mcqgwnG/bK5MIS
X-Google-Smtp-Source: ABdhPJzFKyD4emS+l6A6vpBtzIYOcgl7N8fVTNWNeMbHf5rkAY46JlMmQrVq2nAkMcYT4JSLY/U3lw==
X-Received: by 2002:adf:e7c3:: with SMTP id e3mr640960wrn.356.1598606655157;
 Fri, 28 Aug 2020 02:24:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t13sm912304wru.65.2020.08.28.02.24.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 02:24:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/35] target-arm queue
Date: Fri, 28 Aug 2020 10:23:38 +0100
Message-Id: <20200828092413.22206-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Nothing earth-shaking in here, just a lot of refactoring and cleanup
and a few bugfixes. I suspect I'll have another pullreq to come in
the early part of next week...

The following changes since commit 19591e9e0938ea5066984553c256a043bd5d822f:

  Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2020-08-27 16:59:02 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20200828

for you to fetch changes up to ed78849d9711805bda37ee026018d6ee7a606d0e:

  target/arm: Convert sq{, r}dmulh to gvec for aa64 advsimd (2020-08-28 10:02:50 +0100)

----------------------------------------------------------------
target-arm queue:
 * target/arm: Cleanup and refactoring preparatory to SVE2
 * armsse: Define ARMSSEClass correctly
 * hw/misc/unimp: Improve information provided in log messages
 * hw/qdev-clock: Avoid calling qdev_connect_clock_in after DeviceRealize
 * hw/arm/xilinx_zynq: Call qdev_connect_clock_in() before DeviceRealize
 * hw/net/allwinner-sun8i-emac: Use AddressSpace for DMA transfers
 * hw/sd/allwinner-sdhost: Use AddressSpace for DMA transfers
 * target/arm: Fill in the WnR syndrome bit in mte_check_fail
 * target/arm: Clarify HCR_EL2 ARMCPRegInfo type
 * hw/arm/musicpal: Use AddressSpace for DMA transfers
 * hw/clock: Minor cleanups
 * hw/arm/sbsa-ref: fix typo breaking PCIe IRQs

----------------------------------------------------------------
Eduardo Habkost (1):
      armsse: Define ARMSSEClass correctly

Graeme Gregory (1):
      hw/arm/sbsa-ref: fix typo breaking PCIe IRQs

Philippe Mathieu-Daudé (14):
      hw/clock: Remove unused clock_init*() functions
      hw/clock: Let clock_set() return boolean value
      hw/clock: Only propagate clock changes if the clock is changed
      hw/arm/musicpal: Use AddressSpace for DMA transfers
      target/arm: Clarify HCR_EL2 ARMCPRegInfo type
      hw/sd/allwinner-sdhost: Use AddressSpace for DMA transfers
      hw/net/allwinner-sun8i-emac: Use AddressSpace for DMA transfers
      hw/arm/xilinx_zynq: Uninline cadence_uart_create()
      hw/arm/xilinx_zynq: Call qdev_connect_clock_in() before DeviceRealize
      hw/qdev-clock: Uninline qdev_connect_clock_in()
      hw/qdev-clock: Avoid calling qdev_connect_clock_in after DeviceRealize
      hw/misc/unimp: Display value after offset
      hw/misc/unimp: Display the value with width of the access size
      hw/misc/unimp: Display the offset with width of the region size

Richard Henderson (19):
      target/arm: Pass the entire mte descriptor to mte_check_fail
      target/arm: Fill in the WnR syndrome bit in mte_check_fail
      qemu/int128: Add int128_lshift
      target/arm: Split out gen_gvec_fn_zz
      target/arm: Split out gen_gvec_fn_zzz, do_zzz_fn
      target/arm: Rearrange {sve,fp}_check_access assert
      target/arm: Merge do_vector2_p into do_mov_p
      target/arm: Clean up 4-operand predicate expansion
      target/arm: Use tcg_gen_gvec_bitsel for trans_SEL_pppp
      target/arm: Split out gen_gvec_ool_zzzp
      target/arm: Merge helper_sve_clr_* and helper_sve_movz_*
      target/arm: Split out gen_gvec_ool_zzp
      target/arm: Split out gen_gvec_ool_zzz
      target/arm: Split out gen_gvec_ool_zz
      target/arm: Tidy SVE tszimm shift formats
      target/arm: Generalize inl_qrdmlah_* helper functions
      target/arm: Convert integer multiply (indexed) to gvec for aa64 advsimd
      target/arm: Convert integer multiply-add (indexed) to gvec for aa64 advsimd
      target/arm: Convert sq{, r}dmulh to gvec for aa64 advsimd

 include/hw/arm/armsse.h               |   2 +-
 include/hw/char/cadence_uart.h        |  17 --
 include/hw/clock.h                    |  30 +--
 include/hw/misc/unimp.h               |   1 +
 include/hw/net/allwinner-sun8i-emac.h |   6 +
 include/hw/qdev-clock.h               |   8 +-
 include/hw/sd/allwinner-sdhost.h      |   6 +
 include/qemu/int128.h                 |  16 ++
 target/arm/helper-sve.h               |   5 -
 target/arm/helper.h                   |  28 +++
 target/arm/translate.h                |   1 +
 target/arm/sve.decode                 |  35 ++-
 hw/arm/allwinner-a10.c                |   2 +
 hw/arm/allwinner-h3.c                 |   4 +
 hw/arm/armsse.c                       |   1 +
 hw/arm/musicpal.c                     |  45 ++--
 hw/arm/sbsa-ref.c                     |   2 +-
 hw/arm/xilinx_zynq.c                  |  24 +-
 hw/core/clock.c                       |   7 +-
 hw/core/qdev-clock.c                  |   6 +
 hw/misc/unimp.c                       |  14 +-
 hw/net/allwinner-sun8i-emac.c         |  46 ++--
 hw/sd/allwinner-sdhost.c              |  37 +++-
 target/arm/helper.c                   |   1 -
 target/arm/mte_helper.c               |  19 +-
 target/arm/sve_helper.c               |  70 ++----
 target/arm/translate-a64.c            | 110 ++++++++--
 target/arm/translate-sve.c            | 399 ++++++++++++++--------------------
 target/arm/vec_helper.c               | 182 +++++++++++-----
 29 files changed, 629 insertions(+), 495 deletions(-)

