Return-Path: <SRS0=M+f9=AC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B58F8C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 12:50:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 821C72084D
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 12:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/Y4U4vf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 821C72084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmzQf-0000aH-Or
	for qemu-devel@archiver.kernel.org; Sun, 21 Jun 2020 08:50:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jmzOP-00050f-W6
 for qemu-devel@nongnu.org; Sun, 21 Jun 2020 08:48:14 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:55394)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jmzON-0002on-PU
 for qemu-devel@nongnu.org; Sun, 21 Jun 2020 08:48:13 -0400
Received: by mail-wm1-x333.google.com with SMTP id g75so4354646wme.5
 for <qemu-devel@nongnu.org>; Sun, 21 Jun 2020 05:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ao9CuPu2FLLdrFCOMJ9P9MaIINUQCoiWmF+vc+aq1q0=;
 b=D/Y4U4vf1J/6dNi+Qdupn5qr8de12JICm6RPMdTs1Wv5O8SjWwAM2+MyDzr908GIpr
 ZF0JR5QkJQ/Kl1iv509YxhnPVPARWzd6Pi7saQhS3yRy5ZpOg99vZanTfELZrz3v6tNr
 OO9KjH0+CwAD0IhvvbM/8b9c1vpda7/j/6iDPDYYcz/S7iwt97idYAIcnAyscYZbasfQ
 PfIAsKS5vhES0v+aaC+KuU0or8Cml/CLLNr9RgB0dib8+4F+kAW7mpQcNdCgFlf94u1g
 qaDRC716gaL27rGZKtKnpcZmwpO5R6DewvChm7NKF10CXXLcvi8OSoCVULbo+Udf78h1
 3/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=ao9CuPu2FLLdrFCOMJ9P9MaIINUQCoiWmF+vc+aq1q0=;
 b=Dw+N06fwZr/Mv0N+I7rCMpMcyPvNfkgTzD6OOsC7EXX2bt4Y7Xg+8kLokFcBHxCwOx
 RNiPB2y2TU9mupp8SOItqrq8rjl59AdquMEHn9x66vB9APqAJTn2qoBB31WUpHUWhxBo
 qAW9BX+TYg+k+gW+c05hHSbixhJylyFgiD9nsItWSR7bOLCYprFMh+z1BRvEJIccpHY1
 iec7lPhWyqYH7fU0Pu94po7fHbqIjXNX+VLmyjCaTvpCQ3kIVYno0O6mExvK1rImxYeB
 q8rQEyBhwxo/xrMZuToOyGqoDBL/8t2/LLDRy9K4GQKS6KIj0fA1EIenWqCXZevKXdFB
 1BPg==
X-Gm-Message-State: AOAM531CMHLwV2kCZ5qwszRq+HTbWQcTEMujBSRNDQR9j0/WlTf0ET/g
 uZ5oxkCPg+0k33rEJpzuw8fS9ejD
X-Google-Smtp-Source: ABdhPJyP2yN5q/2DaJ5vcJtAkHsRzo95kRC5SROHMGkB6X7qTsXQd3WUII09R6kap8CfHRGqi3u0lw==
X-Received: by 2002:a05:600c:210:: with SMTP id
 16mr14166504wmi.185.1592743690056; 
 Sun, 21 Jun 2020 05:48:10 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id o10sm13779362wrj.37.2020.06.21.05.48.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jun 2020 05:48:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/15] Renesas hardware patches for 2020-06-21
Date: Sun, 21 Jun 2020 14:47:52 +0200
Message-Id: <20200621124807.17226-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x333.google.com
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
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 06c4cc3660b366278bdc7bc8b6677032d7b1118c:

  qht: Fix threshold rate calculation (2020-06-19 18:29:11 +0100)

are available in the Git repository at:

  https://gitlab.com/philmd/qemu.git tags/renesas-hw-20200621

for you to fetch changes up to 730101266e4026fc19808c740ee4b8118eeaaafe:

  docs: Document the RX target (2020-06-21 01:21:47 +0200)

----------------------------------------------------------------
Renesas hardware patches

- Add a common entry for Renesas hardware in MAINTAINERS
- Trivial SH4 cleanups
- Add RX GDB simulator from Yoshinori Sato

The Renesas RX target emulation was added in commit c8c35e5f51,
these patches complete the target by adding the hardware emulation.

Thank you Yoshinori for adding this code to QEMU, and your patience
during the review process. Now your port is fully integrated.

Travis-CI:
https://travis-ci.org/github/philmd/qemu/builds/700461815
----------------------------------------------------------------

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
 hw/rx/rx-gdbsim.c                     | 196 +++++++++++
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
 29 files changed, 2518 insertions(+), 13 deletions(-)
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


