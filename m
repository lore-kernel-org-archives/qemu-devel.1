Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98544C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 19:16:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ECBC20739
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 19:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKRVXMW2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ECBC20739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jldY4-0005uz-DT
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 15:16:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35482)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jldWv-00047s-3O
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 15:15:25 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:40810)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jldWt-0006Sk-2G
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 15:15:24 -0400
Received: by mail-ej1-x643.google.com with SMTP id q19so3731926eja.7
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 12:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0dYCgpXmXRlRUXY6LzyB3Nc5AAZnuU9yOrYUBejU6Wc=;
 b=BKRVXMW2w51DcWdtvNM0VLIowaSDEsykfstoyYqoklibXs9Sj3LpqnnoCbvy9CJmVD
 fahiSsNQI+Arl+RdG+NqjBmgv6WatQWwWiE5GC0+ELGiWPxyVFW3RL5YaPUjsDGXFlJc
 Nwk6xjbGp7C9g8yvGhPucTFcnNYccbyrhGP7A8oo5hWrIuzBtgAIMvgPpzedCrRKCMMR
 krP2Ajze6bRh9XeypvuO7jiuKDCyjZsZdrVAwGWffY9y4m4jD1WCufKl2zM+diP+U5az
 Xgok8rRBA1+lW/U7xSNySqIBKhD/aotdFkaQyTfubQyeGmX0A26arWQOLhdjSrgcVFGB
 /1pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=0dYCgpXmXRlRUXY6LzyB3Nc5AAZnuU9yOrYUBejU6Wc=;
 b=eHeYFTbXp5mjq9vv6D+yizTR/+HwNmO5vVbTyoc7eBJhO/LjSY/UYGUao6kl8Murx5
 6SFE2PrHBanH0tQlp+tzMYGmCg88W9LfT4nIvo0EoPQw3a7xVvwPkWshYE+rDfzXqbFk
 koXL1V8WhdJOVHeoX/Ert7609hE1VMnR6b6fAiirrjtKcUhVNlrnP9pbsr0dpMQv/9bS
 7wrxRO6YYtXht4t3ZL0XS3jtmQFKbbjqgQ6JuVBwkjkftGYHj12+mqpkuhRV2daZlEr5
 Bip/H7DR2Kb5NAqSNR7gXNWcncdtdRVsPFQ09LgEUlJVtYAwssrmFfXFpHKUfJNhJ4gQ
 FQXQ==
X-Gm-Message-State: AOAM530SQRpyQ1xVm6pBEQ9+CN0JEeD6VaNAAJmM9AFvhlVI7BhYhC7b
 Jrrdgc5LHrkdckfm0XpSlSQ=
X-Google-Smtp-Source: ABdhPJzdbEobhH7Pax5GgYSwExHVg+0NpFQBpWmK0sS0zMqm9U5/weq2SmF1t2eVtE2YLYZHrKYb5Q==
X-Received: by 2002:a17:906:19c8:: with SMTP id
 h8mr657461ejd.512.1592421321515; 
 Wed, 17 Jun 2020 12:15:21 -0700 (PDT)
Received: from x1w.redhat.com (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id y21sm324308edl.72.2020.06.17.12.15.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 12:15:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Richard Henderson <rth@twiddle.net>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
Subject: [PATCH rc1 00/15] hw: Renesas patches (SH4 and RX)
Date: Wed, 17 Jun 2020 21:15:04 +0200
Message-Id: <20200617191519.14842-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x643.google.com
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
Cc: Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Richard, Yoshinori,

This is a merger of the latest SH4 patches (add a common entry for
Renesas hardware in MAINTAINERS, an acceptance test from Thomas),
and Yoshinori's v32 [*] of the RX machine.
Call this release, or merge, candidate 1.

[*] https://www.mail-archive.com/qemu-devel@nongnu.org/msg682290.html

---

Richard,

A few months ago, I volunteered to integrate the RX port posted last
year on the list, to help you ease the burden of your heavy workload.

As it took a long time, at some point I suggested doing the integration
in two parts, first the architecture part (target/ directory), then the
hardware (hw/ directory). You disagreed, arguing that this approach
could be dangerous, as we don’t want to maintain a partly integrated
port. In hindsight I learned the hard way that you were right!

When I decided to send the architectural part first, I made the
commitment to you to finish the full integration before the following
release. The second part has been a painful experience.

With this series, I have now fulfilled this commitment. I don't plan
to continue working on the RX port.

Thank you for your support during this experiment, I learned a lot,
and I’d be grateful to work with you again in the future in other
parts of the project.

---

Yoshinori,

I appreciated integrating your work, which is of very good quality
overall. Despite the numerous iterations you had to go through, the
outcome has proven worthwhile.
Working with you has been a great experience.

I volunteered to help maintain the RX hardware in my leisure time.
Such hobby projects are supposed to be fun, and not have the same
level of pressure as paid work.

Sadly, my experience trying to get your work merged has not been fun:
too much aggressive criticism, and constant demands for more work.
The pressure has become too great for what is, essentially, unpaid
work.

---

Missing review: patches 2 and 12
- 02/15 MAINTAINERS: Add an entry for common Renesas peripherals
- 12/15 hw/rx: Register R5F562N7 and R5F562N8 MCUs

Changes since v32:

- Rebased on DeviceReset API change
- Renamed CPU -> MCU
- Renamed device -> microcontroller
- Rebased on device_class_set_parent_realize API change
- Split timer patch in two distincts: CMT and TMR
- Rebased on ramdev API change
- Use TYPE_RX62N_CPU definition
- Use RX62N_NR_TMR/CMT/SCI definitions
- Replace obsolete set_machine() by machine tag
- Split rx-virt patch in two distinct, MCU first, machine next
- Renamed machined as gdbsim
- Make TYPE_RX62N_MCU an abstract class,
  add TYPE_R5F562N7_MCU and TYPE_R5F562N8_MCU models
- Rename the machine gdbsim-r5f562n8, also add the gdbsim-r5f562n7
- Filled various VMStateField for migration
- Rebase on qdev/sysbus API change

CI:
https://travis-ci.org/github/philmd/qemu/builds/698974425

Philippe Mathieu-Daudé (7):
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
 include/hw/rx/rx62n.h                 |  78 +++++
 include/hw/sh4/sh.h                   |  12 +-
 include/hw/timer/renesas_cmt.h        |  40 +++
 include/hw/timer/renesas_tmr.h        |  55 +++
 include/hw/timer/tmu012.h             |  23 ++
 hw/char/renesas_sci.c                 | 350 +++++++++++++++++++
 hw/intc/rx_icu.c                      | 397 +++++++++++++++++++++
 hw/rx/rx-gdbsim.c                     | 196 +++++++++++
 hw/rx/rx62n.c                         | 318 +++++++++++++++++
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
 29 files changed, 2515 insertions(+), 13 deletions(-)
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

-- 
2.21.3


