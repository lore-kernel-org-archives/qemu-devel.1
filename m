Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD6BC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 19:19:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E4F52073E
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 19:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YS+OiUKa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E4F52073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnRz4-0000uL-Ir
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 15:19:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jnRxD-00072r-Js
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 15:18:03 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:34290)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jnRxB-0006au-LG
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 15:18:03 -0400
Received: by mail-wm1-x332.google.com with SMTP id u26so642968wmn.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 12:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jIZjNG0YKrVBRIpUDUk6QzuIBuAim6XRMXI9FL3IiXU=;
 b=YS+OiUKaqQLh5CuO53pAMaKqYQb2tnua0TcXd2bt1DvEtQYLrId5R5VUfM0QYOztPv
 cIRRIauk0VX4wpu9z9bcQe5APbGBtLRHdKI3got2XmFqYZf4fBxo/aictATDwxn7iB71
 J675AUyM17JGeM8yDCxduR4T8W2Qq3c93khMiFeUoQEANQjuQh/R/MWPE85lpboyQO1X
 nMwG6dZOVAe+5McM/CPglo0GyDRMLZymyoxAATDVB3xx86ighq8+Tz7Cb0JZG2PfuixF
 gQjRhnSB0O8c9GSGJeZp5tBm+MwsRa1ivQL4gTJ8lmR3a8mQQRm2C+4I67pBQsUZ1Rfs
 BIzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=jIZjNG0YKrVBRIpUDUk6QzuIBuAim6XRMXI9FL3IiXU=;
 b=ayjd/waxUh5HOku74Xeb/YMg8y3AgrhonltZngoDo6HJ4wOia9PF5ii7v5iedGJC+g
 VI7f3lQoVfRMAxCaLQifAENa7C42jnPVJ/5vWF5iY+bCO2feW5TJjp8/FBZPTyjIJMjT
 38S1CqRek7Vm2QYC0Qp46wGWyo8zHJAY8y9MPduITGNvaWsu0w6Ga6Iovi5czTBm2ybm
 d19SHwjJQUa0XYNwxGMa4Bbn3g7+6S6F0vGxzUOl+O0ekol/BZCS5olwwbLpk+PraGdX
 qI2PzdjOdAJKj8cTWCaqswUtUVuqj9uyNigI0WtT2VuMVBNcb4qjRXblP6igi8y3A5/q
 mL0w==
X-Gm-Message-State: AOAM533BLWHb/vGPBnrcqO3wQnWTag1n1Gzbv3oO6IDTlwo5ZLWQzUW5
 puLiaMHrv/r8F3oUSAtjLYsP+OV7
X-Google-Smtp-Source: ABdhPJxb08W4R+eh3WDFR9BPZWWseAWE8oRZoa7uvI9b6gxpBZ5yUj4A5zRICqXVRRUJyNHIaDphWQ==
X-Received: by 2002:a1c:6a01:: with SMTP id f1mr19479220wmc.52.1592853480027; 
 Mon, 22 Jun 2020 12:18:00 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id e12sm19133236wro.52.2020.06.22.12.17.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2020 12:17:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/15] Renesas hardware patches for 2020-06-22
Date: Mon, 22 Jun 2020 21:17:45 +0200
Message-Id: <20200622191746.18031-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x332.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 171199f56f5f9bdf1e5d670d09ef1351d8f01bae:

  Merge remote-tracking branch 'remotes/alistair/tags/pull-riscv-to-apply-202=
00619-3' into staging (2020-06-22 14:45:25 +0100)

are available in the Git repository at:

  https://gitlab.com/philmd/qemu.git tags/renesas-hw-20200622

for you to fetch changes up to 4adbfa45cc3793fa85157a4813306618f6009f52:

  docs: Document the RX target (2020-06-22 18:37:12 +0200)

Since v1:
- Fixed format-string issue on 32-bit platforms

----------------------------------------------------------------
- Add a common entry for Renesas hardware in MAINTAINERS
- Trivial SH4 cleanups
- Add RX GDB simulator from Yoshinori Sato

The Renesas RX target emulation was added in commit c8c35e5f51,
these patches complete the target by adding the hardware emulation.

Thank you Yoshinori for adding this code to QEMU, and your patience
during the review process. Now your port is fully integrated.

CI results:
. https://cirrus-ci.com/build/6140199509950464
. https://travis-ci.org/github/philmd/qemu/builds/700954881
. https://app.shippable.com/github/philmd/qemu/runs/812/summary/console
----------------------------------------------------------------

$ git backport-diff -u renesas-hw-20200621
Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/15:[----] [--] 'MAINTAINERS: Cover sh_intc files in the R2D/Shix machine sections'
002/15:[----] [--] 'MAINTAINERS: Add an entry for common Renesas peripherals'
003/15:[----] [--] 'hw/sh4: Use MemoryRegion typedef'
004/15:[----] [--] 'hw/sh4: Extract timer definitions to 'hw/timer/tmu012.h''
005/15:[----] [--] 'hw/timer/sh_timer: Remove unused 'qemu/timer.h' include'
006/15:[----] [--] 'hw/intc: RX62N interrupt controller (ICUa)'
007/15:[----] [--] 'hw/timer: RX62N 8-Bit timer (TMR)'
008/15:[----] [--] 'hw/timer: RX62N compare match timer (CMT)'
009/15:[----] [--] 'hw/char: RX62N serial communication interface (SCI)'
010/15:[----] [--] 'hw/rx: RX62N microcontroller (MCU)'
011/15:[----] [--] 'hw/rx: Honor -accel qtest'
012/15:[----] [--] 'hw/rx: Register R5F562N7 and R5F562N8 MCUs'
013/15:[0006] [FC] 'hw/rx: Add RX GDB simulator'
014/15:[----] [--] 'BootLinuxConsoleTest: Test the RX GDB simulator'
015/15:[----] [--] 'docs: Document the RX target'

Philippe Mathieu-Daud=C3=A9 (7):
  MAINTAINERS: Cover sh_intc files in the R2D/Shix machine sections
  MAINTAINERS: Add an entry for common Renesas peripherals
  hw/sh4: Use MemoryRegion typedef
  hw/sh4: Extract timer definitions to 'hw/timer/tmu012.h'
  hw/timer/sh_timer: Remove unused 'qemu/timer.h' include
  hw/rx: Register R5F562N7 and R5F562N8 MCUs
  BootLinuxConsoleTest: Test the RX GDB simulator

Richard Henderson (1):
  hw/rx: Honor -accel qtest

Yoshinori Sato (7):
  hw/intc: RX62N interrupt controller (ICUa)
  hw/timer: RX62N 8-Bit timer (TMR)
  hw/timer: RX62N compare match timer (CMT)
  hw/char: RX62N serial communication interface (SCI)
  hw/rx: RX62N microcontroller (MCU)
  hw/rx: Add RX GDB simulator
  docs: Document the RX target

 docs/system/target-rx.rst             |  36 ++
 docs/system/targets.rst               |   1 +
 default-configs/rx-softmmu.mak        |   1 +
 include/hw/char/renesas_sci.h         |  51 +++
 include/hw/intc/rx_icu.h              |  76 ++++
 include/hw/rx/rx62n.h                 |  76 ++++
 include/hw/sh4/sh.h                   |  12 +-
 include/hw/timer/renesas_cmt.h        |  40 +++
 include/hw/timer/renesas_tmr.h        |  55 +++
 include/hw/timer/tmu012.h             |  23 ++
 hw/char/renesas_sci.c                 | 350 +++++++++++++++++++
 hw/intc/rx_icu.c                      | 397 +++++++++++++++++++++
 hw/rx/rx-gdbsim.c                     | 198 +++++++++++
 hw/rx/rx62n.c                         | 323 +++++++++++++++++
 hw/sh4/sh7750.c                       |   1 +
 hw/timer/renesas_cmt.c                | 283 +++++++++++++++
 hw/timer/renesas_tmr.c                | 477 ++++++++++++++++++++++++++
 hw/timer/sh_timer.c                   |   3 +-
 MAINTAINERS                           |  33 +-
 hw/Kconfig                            |   1 +
 hw/char/Kconfig                       |   3 +
 hw/char/Makefile.objs                 |   1 +
 hw/intc/Kconfig                       |   3 +
 hw/intc/Makefile.objs                 |   1 +
 hw/rx/Kconfig                         |  10 +
 hw/rx/Makefile.objs                   |   2 +
 hw/timer/Kconfig                      |   6 +
 hw/timer/Makefile.objs                |   2 +
 tests/acceptance/machine_rx_gdbsim.py |  68 ++++
 29 files changed, 2520 insertions(+), 13 deletions(-)
 create mode 100644 docs/system/target-rx.rst
 create mode 100644 include/hw/char/renesas_sci.h
 create mode 100644 include/hw/intc/rx_icu.h
 create mode 100644 include/hw/rx/rx62n.h
 create mode 100644 include/hw/timer/renesas_cmt.h
 create mode 100644 include/hw/timer/renesas_tmr.h
 create mode 100644 include/hw/timer/tmu012.h
 create mode 100644 hw/char/renesas_sci.c
 create mode 100644 hw/intc/rx_icu.c
 create mode 100644 hw/rx/rx-gdbsim.c
 create mode 100644 hw/rx/rx62n.c
 create mode 100644 hw/timer/renesas_cmt.c
 create mode 100644 hw/timer/renesas_tmr.c
 create mode 100644 hw/rx/Kconfig
 create mode 100644 hw/rx/Makefile.objs
 create mode 100644 tests/acceptance/machine_rx_gdbsim.py

--=20
2.21.3


