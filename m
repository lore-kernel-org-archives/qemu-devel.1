Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DF9C2D0CE
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 23:21:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FD682077C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 23:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v155pzll"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FD682077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv8GR-0005Jz-5X
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 18:21:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58497)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iv8FM-00048c-Gx
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 18:20:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iv8FK-0005WD-S2
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 18:20:16 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a]:39497)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iv8FK-0005Ue-Kp
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 18:20:14 -0500
Received: by mail-pj1-x102a.google.com with SMTP id e11so491953pjt.4
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 15:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bsWQWdfCMNy/PRb3cJQvCp2v9hP5/oTK5wfykEmGUU8=;
 b=v155pzlln7IQg9gJ2+6XMXM7LD+ssajDrdwivPbA+7g9OBbphwCJgv2sb70s4aAary
 bHsQfyS8x76usuJ0gu28TGFasVzwBImmzlha8x42NQ7UL6znfNhpZRnXmPOqrJwK2z8I
 rf79iQ1XnjiwHh8IyLpntm7GTugKC1QkbsDboZDetXdDuDyfIyyZWa+8OgoxH35nVPr5
 BRgVREM/xQ70xa/OTsuke+Yuv4Be9iM6VUIW3axRti+MlUbYKDW1AfP9bs+BYyx9TwEw
 3cK0R/xj9QuqLRxL6bM4hxrDJ7klWItv/LhNyGHi35rKYbcAUs4dNBLrRkQkVzZ6ut4v
 ylCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bsWQWdfCMNy/PRb3cJQvCp2v9hP5/oTK5wfykEmGUU8=;
 b=Mm8Qk9OVijCmxj0J7eZuGhEWP9o5xkQzoGTUb/KzS/FbAyLYN7bbRkAQvqpy8F1VKu
 5MnIzJu3lND+luiBlXuXfRPghcr1pLuVJHKbJbkkPvr7TkmHjJeD/F7UcryHhvf9Linu
 fNFuXdloG0xR2p/zDsk0yFTKuWfVB29alkN960qScm8IaSHCx1faPJS/N/g1j0VbjouK
 bDipmNWpStA/m0eUcIRCP3shwcIcfTgopGZs1XJf2pnpGYEWC28DkpqIzExQSvrOzMEs
 9xlrSttQ5tM4kK4CTNczTrinQow19SOscwleLzaiL7RqWUjA0tPRMtt1KgeF3x1FMKAx
 9eWw==
X-Gm-Message-State: APjAAAX4OEJ6w98d7zBghmKbEl9wBrd4dL3C1tVpz3Knjd6kH3ILyDGy
 IH5GmbDOo+rOuhqdngfw96o0DxCJRMM=
X-Google-Smtp-Source: APXvYqzP1uqb/KSXd3XOUDMhADghxnBqAjHEfZriSnO3X7rNURmbSmUena0XHP9SMdtgU7DtVLWGcQ==
X-Received: by 2002:a17:90a:246c:: with SMTP id
 h99mr1864503pje.134.1579908013033; 
 Fri, 24 Jan 2020 15:20:13 -0800 (PST)
Received: from localhost.localdomain (rrcs-173-198-77-92.west.biz.rr.com.
 [173.198.77.92])
 by smtp.gmail.com with ESMTPSA id v4sm8377880pgo.63.2020.01.24.15.20.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2020 15:20:12 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v3 00/11] target/hppa patch queue
Date: Fri, 24 Jan 2020 13:19:58 -1000
Message-Id: <20200124232009.12928-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::102a
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
Cc: peter.maydell@linaro.org, deller@gmx.de, svens@stackframe.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Version 3 fixes printf formatting errors, and some indentation
errors, in artist.c, lasips2.c, and i82596.c.


r~


The following changes since commit ba2ed84fe6a78f64b2da441750fc6e925d94106a:

  Merge remote-tracking branch 'remotes/palmer/tags/riscv-for-master-5.0-sf1' into staging (2020-01-24 12:34:04 +0000)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-pa-20200124

for you to fetch changes up to 5b33eecce852658121b1190fee466f01a69e1910:

  target/hppa: Allow, but diagnose, LDCW aligned only mod 4 (2020-01-24 14:35:58 -0800)

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

