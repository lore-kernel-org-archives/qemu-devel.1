Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDEDC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 19:02:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCEEC206D3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 19:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ic5BR19h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCEEC206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw9eh-0003co-1R
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 14:02:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49517)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iw9du-00036f-0I
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 14:01:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iw9ds-0002b5-MW
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 14:01:49 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435]:33143)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iw9ds-0002ad-Eh
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 14:01:48 -0500
Received: by mail-pf1-x435.google.com with SMTP id n7so5307831pfn.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 11:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=af70wvBu/k7kvNWn4RArOZ1aiEsUV5AMEaXjzI76zfY=;
 b=Ic5BR19hQ3DehtMLoO8cPPtDq+4URPEpJxxshdJCJoEnnTr7ZH+S3mCHbn/SSBVVYR
 oBHyQR+N8MSpKpc3c4JBHFADksbvtHffgGwtGDDnsgO4EkLxiV6ib33kmdzhqNdvv62m
 OkYLpulxn48WZy2R/Z6UbJV6mR2bqh1zF6b4vnGaGx5idj0I2cAtmYYw8ze0eZWgcb5Z
 q20i/PZXs30+9Z15XBUrRcPA3j+12apom4tmI3KLHjNoADp6d2vda5rDy1zbA8/pmAS5
 N4USrYv478zGNEQQ/b4q/ULA2Zf0S5aQ2S6u/pmfqOlcsNOdPUN3essIx86Pz6F30RKw
 souQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=af70wvBu/k7kvNWn4RArOZ1aiEsUV5AMEaXjzI76zfY=;
 b=AR9wz8NieMmYY9CVq16CDWslwRKodU1dMitetB9v0dmvyuFw0rP6qMhZEMamYT5Vtu
 TaPk44OzLyHh3atQ0Zpup8cjIhYVaf+houV3jWAuPAUzsJ7GMHA0tDpJblhv754jJWvt
 WYPE9I9pQuXE24xK0hcsq7dQKg6PqAYMIZ4y/tZQCnDywSzxWZjB6zLF9rqPTFHZduCZ
 E7jLCxXr1hpPMjHo6hOdBZA7Vvb6Z/LsavQRhFMSMZy2TUz0rhxvq+v4cjRxShqFYLkG
 56TJz8HllUVuYV8dpwtQQqXaQjidoAzsiU/hDKeoE1jLDpJ9P28+2AQVjWE+YwxIUnnI
 P/CA==
X-Gm-Message-State: APjAAAXDopM0JQNL91pwAeoKjBSKiyvYkyyOrTir3ZqIgWwj5CwDp8xO
 BtA0sjHdblFPda+tylrc0aUULFa+Mgc=
X-Google-Smtp-Source: APXvYqwA5kv86JvQ8XpsFkJmCyUqED/lusLQknenAfgXVL2Wo4L+lMc/cPxTHliH3d24vFbBkqxi/Q==
X-Received: by 2002:a63:484b:: with SMTP id x11mr21179072pgk.148.1580151706757; 
 Mon, 27 Jan 2020 11:01:46 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id h3sm16311726pji.9.2020.01.27.11.01.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2020 11:01:45 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/11] target/hppa patch queue
Date: Mon, 27 Jan 2020 11:01:44 -0800
Message-Id: <20200127190144.1456-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::435
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

Version 4 fixes trivial conflicts with 

commit 4f67d30b5e74e060b8dbe10528829b47345cd6e8
Author: Marc-André Lureau <marcandre.lureau@redhat.com>
Date:   Fri Jan 10 19:30:32 2020 +0400

    qdev: set properties with device_class_set_props()


r~


The following changes since commit 105b07f1ba462ec48b27e5cb74ddf81c6a79364c:

  Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20200127' into staging (2020-01-27 13:02:36 +0000)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-pa-20200127

for you to fetch changes up to b1af755c33bf0d690553a5ccd93689dfd15a98e8:

  target/hppa: Allow, but diagnose, LDCW aligned only mod 4 (2020-01-27 10:49:51 -0800)

----------------------------------------------------------------
Improve LASI emulation
Add Artist graphics
Fix main memory allocation
Improve LDCW emulation wrt real hw

----------------------------------------------------------------
Helge Deller (3):
      hw/hppa/dino.c: Improve emulation of Dino PCI chip
      hppa: Add support for LASI chip with i82596 NIC
      hppa: Switch to tulip NIC by default

Philippe Mathieu-Daudé (3):
      hw/hppa/machine: Correctly check the firmware is in PDC range
      hw/hppa/machine: Restrict the total memory size to 3GB
      hw/hppa/machine: Map the PDC memory region with higher priority

Richard Henderson (1):
      target/hppa: Allow, but diagnose, LDCW aligned only mod 4

Sven Schnelle (4):
      ps2: accept 'Set Key Make and Break' commands
      hppa: add emulation of LASI PS2 controllers
      seabios-hppa: update to latest version
      hppa: Add emulation of Artist graphics

 hw/hppa/hppa_hardware.h        |    1 +
 hw/hppa/hppa_sys.h             |    2 +
 hw/net/i82596.h                |   55 ++
 include/hw/input/lasips2.h     |   16 +
 include/hw/input/ps2.h         |    1 +
 include/hw/net/lasi_82596.h    |   29 +
 target/hppa/helper.h           |    2 +
 hw/display/artist.c            | 1454 ++++++++++++++++++++++++++++++++++++++++
 hw/hppa/dino.c                 |   97 ++-
 hw/hppa/lasi.c                 |  368 ++++++++++
 hw/hppa/machine.c              |   33 +-
 hw/input/lasips2.c             |  291 ++++++++
 hw/input/ps2.c                 |   15 +
 hw/net/i82596.c                |  734 ++++++++++++++++++++
 hw/net/lasi_i82596.c           |  188 ++++++
 target/hppa/op_helper.c        |    9 +
 target/hppa/translate.c        |   15 +-
 tests/qtest/boot-serial-test.c |    3 +-
 MAINTAINERS                    |    4 +-
 hw/display/Kconfig             |    4 +
 hw/display/Makefile.objs       |    1 +
 hw/display/trace-events        |    9 +
 hw/hppa/Kconfig                |    3 +
 hw/hppa/Makefile.objs          |    2 +-
 hw/hppa/trace-events           |   10 +
 hw/input/Kconfig               |    3 +
 hw/input/Makefile.objs         |    1 +
 hw/input/trace-events          |    5 +
 hw/net/Kconfig                 |    7 +
 hw/net/Makefile.objs           |    2 +
 hw/net/trace-events            |   13 +
 pc-bios/hppa-firmware.img      |  Bin 783724 -> 766136 bytes
 roms/seabios-hppa              |    2 +-
 33 files changed, 3351 insertions(+), 28 deletions(-)
 create mode 100644 hw/net/i82596.h
 create mode 100644 include/hw/input/lasips2.h
 create mode 100644 include/hw/net/lasi_82596.h
 create mode 100644 hw/display/artist.c
 create mode 100644 hw/hppa/lasi.c
 create mode 100644 hw/input/lasips2.c
 create mode 100644 hw/net/i82596.c
 create mode 100644 hw/net/lasi_i82596.c

