Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F41FC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:03:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39DB22133D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qAIf6BFv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39DB22133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36963 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hToJJ-0007I4-EF
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 10:03:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hToHM-000670-QF
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:01:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hToHJ-0004KW-OC
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:01:07 -0400
Received: from mail-ua1-x92f.google.com ([2607:f8b0:4864:20::92f]:33039)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hToHI-0004Iu-2d
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:01:05 -0400
Received: by mail-ua1-x92f.google.com with SMTP id 49so2222026uas.0
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 07:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=qb/2f8PjB1t01PVAR8gw5To3IKGJv/4oVS1AthmA/gc=;
	b=qAIf6BFv/tAWWEVHwTVAoNr6KZbRqWZ0wbe5EmDuhOTsVu5j4WM4EPjZx1ZySHWom7
	Nqgk6rIMMmMaL66u3Okn8YSkzpwJP6nLxmZfFknkovz3SjgUTCzkRp/5b0bl4mX38nvP
	gcR4OYyQoV/7VP2OoulRZvhjBrGjjsu31IP8fbfhntF7+gcTw1D0MhRW1mjNeZmf85TF
	IsSP5oFSp18V87SKJv1ti0FaW/abecISlNHR0/vye5J5lPq+qTMXvwIppZX7LZffVNR7
	DwkEhdddILKbWyJNQJ7A8WWdJnau5jujBCHpi3/jaxItTtDlbUk7Aynqj+HFxlOaRKs+
	CnRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=qb/2f8PjB1t01PVAR8gw5To3IKGJv/4oVS1AthmA/gc=;
	b=V1UkvB0LwfOf4qw2lRPLD2qmhPlOCdKb3F+8hBUQYiw3rP7s3MTjqgUjQI69aCgP+Y
	XVfOYSp3Eef32kfJis80kO3ntj/SHgTB5EUhoAwUQuPcFDWxYFhQnFemSDTZy44SAa2U
	CXDl0/Z0vSI/wOjMxAMIGCwsrcbja2AIUvJqFxUE+rR8AN2jh20/WuDxDPgBBAwxh6/Z
	oxEd9qTk1Gs75IPqv61BP5jghrq4DMdKq2Of93vOFF/rDF+hr3l5Fun2PNDUMSsLBZtk
	SPbSFhJl6wHUHd6cGnfSTV8mxtbCMzd2ytNKtzmXCx5eApR/vtC+X6Mp8F19OQquaITl
	Q6cw==
X-Gm-Message-State: APjAAAXmXdFNkCTcUQ0gc5hVnh+DhMA6jsqG8GB7wDnqKag+jPz+7fZt
	5A5YZOuJArax0F6IWZeCD3ZR5eoSOjM=
X-Google-Smtp-Source: APXvYqy9dSxCLYkQttrpvYHgXSp+DJXLjaho4OyWZL5d5EQBJKl4/SqNHQYJ8bOWNdBB+Y3PDsjcyg==
X-Received: by 2002:ab0:20b3:: with SMTP id y19mr47468679ual.74.1558620062390; 
	Thu, 23 May 2019 07:01:02 -0700 (PDT)
Received: from localhost.localdomain (ip-173-130-215-183.orldfl.spcsdns.net.
	[173.130.215.183]) by smtp.gmail.com with ESMTPSA id
	v133sm1984166vkv.5.2019.05.23.07.01.01
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 07:01:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 10:00:46 -0400
Message-Id: <20190523140059.18548-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::92f
Subject: [Qemu-devel] [PULL 00/13] Add RX architecture
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thanks to Sato-san for persevering through 14 iterations.


r~


The following changes since commit d418238dca7b4e0b124135827ead3076233052b1:

  Merge remote-tracking branch 'remotes/rth/tags/pull-rng-20190522' into staging (2019-05-23 12:57:17 +0100)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-rx-20190523

for you to fetch changes up to fe7ddbc2dade3daf767c9ac07b8569791b5376a8:

  MAINTAINERS: Add RX (2019-05-23 09:38:27 -0400)

----------------------------------------------------------------
Initial commit for the RX cpu.

----------------------------------------------------------------
Richard Henderson (1):
      target/rx: Convert to CPUClass::tlb_fill

Yoshinori Sato (12):
      target/rx: TCG translation
      target/rx: TCG helper
      target/rx: CPU definition
      target/rx: RX disassembler
      hw/intc: RX62N interrupt controller (ICUa)
      hw/timer: RX62N internal timer modules
      hw/char: RX62N serial communication interface (SCI)
      hw/rx: RX Target hardware definition
      qemu/bitops.h: Add extract8 and extract16
      hw/registerfields.h: Add 8bit and 16bit register macros
      Add rx-softmmu
      MAINTAINERS: Add RX

 include/disas/dis-asm.h        |    5 +
 include/hw/char/renesas_sci.h  |   45 +
 include/hw/intc/rx_icu.h       |   56 +
 include/hw/registerfields.h    |   32 +-
 include/hw/rx/rx.h             |    7 +
 include/hw/rx/rx62n.h          |   94 ++
 include/hw/timer/renesas_cmt.h |   38 +
 include/hw/timer/renesas_tmr.h |   53 +
 include/qemu/bitops.h          |   38 +
 include/sysemu/arch_init.h     |    1 +
 target/rx/cpu.h                |  227 ++++
 target/rx/helper.h             |   31 +
 arch_init.c                    |    2 +
 hw/char/renesas_sci.c          |  340 ++++++
 hw/intc/rx_icu.c               |  376 +++++++
 hw/rx/rx-virt.c                |  105 ++
 hw/rx/rx62n.c                  |  238 ++++
 hw/timer/renesas_cmt.c         |  275 +++++
 hw/timer/renesas_tmr.c         |  455 ++++++++
 target/rx/cpu.c                |  236 ++++
 target/rx/disas.c              | 1480 ++++++++++++++++++++++++
 target/rx/gdbstub.c            |  112 ++
 target/rx/helper.c             |  148 +++
 target/rx/monitor.c            |   38 +
 target/rx/op_helper.c          |  470 ++++++++
 target/rx/translate.c          | 2432 ++++++++++++++++++++++++++++++++++++++++
 MAINTAINERS                    |   19 +
 configure                      |    8 +
 default-configs/rx-softmmu.mak |    3 +
 hw/Kconfig                     |    1 +
 hw/char/Kconfig                |    3 +
 hw/char/Makefile.objs          |    1 +
 hw/intc/Kconfig                |    3 +
 hw/intc/Makefile.objs          |    1 +
 hw/rx/Kconfig                  |   14 +
 hw/rx/Makefile.objs            |    2 +
 hw/timer/Kconfig               |    6 +
 hw/timer/Makefile.objs         |    3 +
 target/rx/Makefile.objs        |   12 +
 target/rx/insns.decode         |  621 ++++++++++
 40 files changed, 8030 insertions(+), 1 deletion(-)
 create mode 100644 include/hw/char/renesas_sci.h
 create mode 100644 include/hw/intc/rx_icu.h
 create mode 100644 include/hw/rx/rx.h
 create mode 100644 include/hw/rx/rx62n.h
 create mode 100644 include/hw/timer/renesas_cmt.h
 create mode 100644 include/hw/timer/renesas_tmr.h
 create mode 100644 target/rx/cpu.h
 create mode 100644 target/rx/helper.h
 create mode 100644 hw/char/renesas_sci.c
 create mode 100644 hw/intc/rx_icu.c
 create mode 100644 hw/rx/rx-virt.c
 create mode 100644 hw/rx/rx62n.c
 create mode 100644 hw/timer/renesas_cmt.c
 create mode 100644 hw/timer/renesas_tmr.c
 create mode 100644 target/rx/cpu.c
 create mode 100644 target/rx/disas.c
 create mode 100644 target/rx/gdbstub.c
 create mode 100644 target/rx/helper.c
 create mode 100644 target/rx/monitor.c
 create mode 100644 target/rx/op_helper.c
 create mode 100644 target/rx/translate.c
 create mode 100644 default-configs/rx-softmmu.mak
 create mode 100644 hw/rx/Kconfig
 create mode 100644 hw/rx/Makefile.objs
 create mode 100644 target/rx/Makefile.objs
 create mode 100644 target/rx/insns.decode

