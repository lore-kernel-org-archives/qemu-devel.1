Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF37C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 21:37:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E87D223C7
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 21:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="uUpwoPni"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E87D223C7
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVLnw-00054C-Pt
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 17:37:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48688)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3tamQXwsKCk4x80y33u24u3w44w1u.s426u2A-tuBu1343w3A.47w@flex--hskinnemoen.bounces.google.com>)
 id 1kVLlx-0003DJ-OQ
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 17:35:53 -0400
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a]:37583)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3tamQXwsKCk4x80y33u24u3w44w1u.s426u2A-tuBu1343w3A.47w@flex--hskinnemoen.bounces.google.com>)
 id 1kVLlv-00036w-Ks
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 17:35:53 -0400
Received: by mail-pj1-x104a.google.com with SMTP id y7so1945220pjt.2
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 14:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:message-id:mime-version:subject:from:to:cc;
 bh=ScjJWFhv2NX/VPNsattIHwK733aeo0c/y9UBZ2zVqfw=;
 b=uUpwoPniT75PwzBJLexNgelXa6ohCcxW7YcuzwopeDxiz1GTT/egjmJH25vjcjUtfp
 LdySthy9bDFFo+GiUvH/g6rj1ftK5UaYs3yUwRkfKfKuVEzqASOtp0eznfypsnhFqTT7
 qxZ7LyvsxXxOnK1DvNFk6Xx5brppLYt8u6SQzTq10Yx2q+tbBMzyY3hRLLawo4WGXF1K
 k+NXRx9MmX62pDgSYK3a76hWxkKshGQWStS4SXpph4Pk76Yz36kIAYIZfyqvvIcjDfma
 U4Su1E/rkM/s9xcG0GYyBPjKKiM0hLkULBj91TI8XyJhfwg1XOlp17N9xrLCdyeLrJc0
 rM4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
 :to:cc;
 bh=ScjJWFhv2NX/VPNsattIHwK733aeo0c/y9UBZ2zVqfw=;
 b=jZszJOuS2NBej6qhWn394p+sfiabbqyP7hLCa6rBK+Wyo8WtsD8hyezpsCx1uQagBc
 /sWb7FMxB9fiSHhEnwYzfNEcmbUUJfo/xxHntL2KbMkcgDty00V+RSy4bZJYoupHkDbd
 8lBk7c9qbfyWhTNrszCvS84GjB3Ak7uzS4tj8wMCoejZceUxiRHkiIDxJhnaXgR6bGF2
 J14dSexF6uEV8Zje7F9Uu0hK8fr41gEc5drtthCiVjUuqZnEXQokqXFEsXQfkOtrAFzU
 tvXic5V10k+979DOQ95uBgM1zKagzYMf9b5T0xCrbTNssJOSXTPDxMdbpkH+Tg7xzx0v
 B07A==
X-Gm-Message-State: AOAM532TYsSEXCLrmNhz0md7NPizdEeMI07ZeTQxksidPTpjhVN1xLOJ
 M/yk6BboQOqyQzGoFXZDxDupVjY86a51mXJwcQ==
X-Google-Smtp-Source: ABdhPJz/l8Z4dxpRv1C5Wp7nMEI3z3DZKl9OukfUQCJTIkkJman3DOKeJkgAPRrdXsD7bQPIad8U4l89TgoW7vsSCQ==
X-Received: from skybert.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:3107])
 (user=hskinnemoen job=sendgmr) by 2002:a17:90a:e00c:: with SMTP id
 u12mr5240012pjy.185.1603316149176;
 Wed, 21 Oct 2020 14:35:49 -0700 (PDT)
Date: Wed, 21 Oct 2020 14:35:39 -0700
Message-Id: <20201021213544.3399271-1-hskinnemoen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH v2 0/5] Additional NPCM7xx features, devices and tests
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, venture@google.com, wuhaotsh@google.com, 
 Havard Skinnemoen <hskinnemoen@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::104a;
 envelope-from=3tamQXwsKCk4x80y33u24u3w44w1u.s426u2A-tuBu1343w3A.47w@flex--hskinnemoen.bounces.google.com;
 helo=mail-pj1-x104a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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
Reply-to: Havard Skinnemoen <hskinnemoen@google.com>
From: Havard Skinnemoen via <qemu-devel@nongnu.org>

This is an update to the initial NPCM7xx patch series adding

  - Watchdog timer support. This makes the reboot command work.
  - Random Number Generator device.
  - USB Host Controllers.
  - GPIO Controllers.

The watchdog was implemented by my new teammate Hao Wu. Expect to see more
patches from him in the near future.

This series has also been pushed to the npcm7xx-5.2-update branch of my github
repository at

  https://github.com/hskinnemoen/qemu

Changes since v1:

  - Dropped the timer test since it's already applied (thanks Peter).
  - Watchdog reset signaling is now using GPIOs instead of a custom API
    (thanks Peter for suggesting, and Hao for implementing it).
  - A few comment updates for the watchdog timer.
  - VMState added to GPIO device.
  - Missing VMstate terminator added to RNG device.
  - Include order in RNG test fixed.

Again, thanks a lot for reviewing!

Havard

Hao Wu (1):
  hw/timer: Adding watchdog for NPCM7XX Timer.

Havard Skinnemoen (4):
  Move npcm7xx_timer_reached_zero call out of npcm7xx_timer_pause
  hw/misc: Add npcm7xx random number generator
  hw/arm/npcm7xx: Add EHCI and OHCI controllers
  hw/gpio: Add GPIO model for Nuvoton NPCM7xx

 docs/system/arm/nuvoton.rst               |   6 +-
 hw/usb/hcd-ehci.h                         |   1 +
 include/hw/arm/npcm7xx.h                  |   8 +
 include/hw/gpio/npcm7xx_gpio.h            |  55 +++
 include/hw/misc/npcm7xx_clk.h             |   2 +
 include/hw/misc/npcm7xx_rng.h             |  34 ++
 include/hw/timer/npcm7xx_timer.h          |  48 ++-
 hw/arm/npcm7xx.c                          | 126 ++++++-
 hw/gpio/npcm7xx_gpio.c                    | 424 ++++++++++++++++++++++
 hw/misc/npcm7xx_clk.c                     |  28 ++
 hw/misc/npcm7xx_rng.c                     | 180 +++++++++
 hw/timer/npcm7xx_timer.c                  | 270 +++++++++++---
 hw/usb/hcd-ehci-sysbus.c                  |  19 +
 tests/qtest/npcm7xx_gpio-test.c           | 385 ++++++++++++++++++++
 tests/qtest/npcm7xx_rng-test.c            | 278 ++++++++++++++
 tests/qtest/npcm7xx_watchdog_timer-test.c | 313 ++++++++++++++++
 MAINTAINERS                               |   1 +
 hw/gpio/meson.build                       |   1 +
 hw/gpio/trace-events                      |   7 +
 hw/misc/meson.build                       |   1 +
 hw/misc/trace-events                      |   4 +
 tests/qtest/meson.build                   |   3 +
 22 files changed, 2133 insertions(+), 61 deletions(-)
 create mode 100644 include/hw/gpio/npcm7xx_gpio.h
 create mode 100644 include/hw/misc/npcm7xx_rng.h
 create mode 100644 hw/gpio/npcm7xx_gpio.c
 create mode 100644 hw/misc/npcm7xx_rng.c
 create mode 100644 tests/qtest/npcm7xx_gpio-test.c
 create mode 100644 tests/qtest/npcm7xx_rng-test.c
 create mode 100644 tests/qtest/npcm7xx_watchdog_timer-test.c

-- 
2.29.0.rc1.297.gfa9743e501-goog


