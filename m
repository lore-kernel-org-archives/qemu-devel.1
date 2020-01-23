Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78332C33CAA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 22:11:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EECCD21D7E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 22:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cfW9yt3U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EECCD21D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iukhU-0002dI-Rt
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 17:11:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38960)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iukgU-0001tn-HL
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 17:10:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iukgS-0000AV-4u
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 17:10:42 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633]:36776)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iukgR-000070-Tt
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 17:10:40 -0500
Received: by mail-pl1-x633.google.com with SMTP id a6so1955980plm.3
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 14:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DaC+9U2WuhYLPRwpIUz3Ejy/vnz9s5o/9IJth5GyMYY=;
 b=cfW9yt3UeWLMCSj3G5+0aFUrO37flDjy4GcVlr0Qu+dDs9/74/GcGQ8Mkt6MBZiOyh
 5RQRaH4Yz+jcNPm97/2mHEzzMi+H+8Q8N4CZwja2zV+pHhnqeKQ2LDBssj6pjxVatvv+
 I5huW8GhreW2EFADm2JpMepeSpEOE215kcGguWBy7kcdlB0PZjtP1521gllv3FPXErV4
 sAQX9Gc5BK4pNivSCWwQ170ecyYs4lQacz3Kn+D4TWRstj5D91B9Cr5NCla8kIfmdvoT
 MHSVaRZp25afpyrG9zTST3dV5HuBln9LkmqTlws2sUMRoKFGZ4emA8zc2B1dm06D3mSr
 ZJIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DaC+9U2WuhYLPRwpIUz3Ejy/vnz9s5o/9IJth5GyMYY=;
 b=MiSOMgiRSODPGmtM1Hcxw+gAahe/gYmyP8XF9BuxfSJNHdJKxNE0bIDuwo7Z47xHSd
 8vhyBqToPB+1rA4jxvY76iZhhY1amTWC1xvXhC2BDDu/Hz5OYcXMviy3XkXEVSYZbMxN
 UCtiUc3ictVe6JV9kLeCEtfZ5+WX0+yz6MhQXqn7t55QsCo8Gjh9MiusGkZbMSmZILAK
 J13Mj1fp7sBz/QU7/vG0liCqhQCLsrngdQuXDH/+3klOFzUgKXEYq563LLCaC+IURp8u
 W52n6jIowNiAq9EHPLEywo2jWe6yUGllZm1JOCSA+yhzbwAbdelOZi6G4X+BGYxahzus
 6YYg==
X-Gm-Message-State: APjAAAVDtfYc3y4h3Uuw1cx4KXAOvM++phHGDO2YWx824pXlameFikVZ
 z4sXJAjUeKznPsE0DYvBYqMqLgY7KU8=
X-Google-Smtp-Source: APXvYqwSu1WhGX9QU510BhiKUxljLsHy1+cXwj28XlnAM7lFYbqtUFSZuuroSLKU1J9cH9I818nhhg==
X-Received: by 2002:a17:902:34d:: with SMTP id 71mr267075pld.316.1579817438280; 
 Thu, 23 Jan 2020 14:10:38 -0800 (PST)
Received: from localhost.localdomain (rrcs-173-198-77-92.west.biz.rr.com.
 [173.198.77.92])
 by smtp.gmail.com with ESMTPSA id r3sm3700796pfg.145.2020.01.23.14.10.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2020 14:10:37 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/11] target/hppa patch queue
Date: Thu, 23 Jan 2020 12:10:34 -1000
Message-Id: <20200123221035.20383-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::633
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

Change since v1:
  * Incorporate Phil's -vga none fix for boot-serial-test (patch 7).


r~


The following changes since commit 6918ab2570bcf942651e69f7ad975e137679738b:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200123-4' into staging (2020-01-23 16:36:55 +0000)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-pa-20200123

for you to fetch changes up to b670f6d717a6a1795358c07823b4e968c0b61a86:

  target/hppa: Allow, but diagnose, LDCW aligned only mod 4 (2020-01-23 10:55:20 -1000)

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
 hw/display/artist.c            | 1450 ++++++++++++++++++++++++++++++++++++++++
 hw/hppa/dino.c                 |   97 ++-
 hw/hppa/lasi.c                 |  368 ++++++++++
 hw/hppa/machine.c              |   33 +-
 hw/input/lasips2.c             |  289 ++++++++
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
 33 files changed, 3345 insertions(+), 28 deletions(-)
 create mode 100644 hw/net/i82596.h
 create mode 100644 include/hw/input/lasips2.h
 create mode 100644 include/hw/net/lasi_82596.h
 create mode 100644 hw/display/artist.c
 create mode 100644 hw/hppa/lasi.c
 create mode 100644 hw/input/lasips2.c
 create mode 100644 hw/net/i82596.c
 create mode 100644 hw/net/lasi_i82596.c

