Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99FADC49ED7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 19:36:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 623692084D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 19:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mqD3iIp9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 623692084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7lwH-0002lc-Rq
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 15:36:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58860)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i7lu1-0000vI-IZ
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 15:34:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i7lu0-0006jq-AQ
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 15:34:13 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54365)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i7lu0-0006jF-31
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 15:34:12 -0400
Received: by mail-wm1-x344.google.com with SMTP id p7so820158wmp.4
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 12:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LUki8oUUsALAZDBQ6UZLGbPGDE9cY6FFUsATWmaNRmY=;
 b=mqD3iIp9flGmjSzMcePgsI10+nNSL8bqW+4392/VoMZBMpqUZF0IiYrLp8LXWHQHok
 OFk4BImy9sfJMKBR3Q5b1vv/4nrOnfSD7zP5/E8DzNwnNqFKTYoyVW5xD/LV31hapSc3
 EXI+y5+IFTuXSwxuSutA454FRAbleotB0tNq/wJ1UtCQVglfHKoRM80v2NQ02iqQUOwU
 +lct8UNlzfB4vTaiw9iTujjDskXEL+DDRyPD1oThYRcYmwKOWAfepGnhDS8K8x3guNnV
 yY7uWkgzLwuKLFwojD92w8x1s5JYbRoHGIkfLtnmEaDfaSR/vzTdLdAd6uetChqKKL6k
 r1Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LUki8oUUsALAZDBQ6UZLGbPGDE9cY6FFUsATWmaNRmY=;
 b=TXUKWCVsU3juzO+T8IeyYVoyqWYM9ss0x8Xj3zSQh8Ix/Of0bxZd4sRRzSj7F0/dAV
 SKjLdSzBKLj1cKl+188MgS5uooBPN/1UAC5/zWTtuseochZNNNk13j6aYMRi5uJJMJPz
 ZqOzvDqQCqGwjH6bCQnBiUOwU1bjQDintfcZdRXM0DlauNHqW/tvYA7LbDrT35qnuHcg
 njezvCUSnZKIBp5nEwnNY3HYeFNcSkODAGRgF+ABzLdLplTIE1/D7VYlWX+5dUk88qpF
 ofgZ2lsjmRfFuQ/Flg0ya77emOuoJyVb+w8TOUxyIw3NVBtcsN81UcHqTGyNPbi9tkds
 ivdg==
X-Gm-Message-State: APjAAAUsJAFkNYRzNEP+ocnsP+L/6Cj4nmceGTKn8jsFPj/YMyHEvUpf
 ZJ0MtU1wfQFL44Q6pR1HV5+PgA==
X-Google-Smtp-Source: APXvYqz0g1B5iVKSO3l6aX7EXCpereE4MvK48B1KeHtSsZ3mh0raXD8Wr4isGiCvcabiM6OKmaAEpg==
X-Received: by 2002:a1c:a90b:: with SMTP id s11mr942248wme.92.1568144050864;
 Tue, 10 Sep 2019 12:34:10 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t13sm33012594wra.70.2019.09.10.12.34.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 12:34:09 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A4A901FF87;
 Tue, 10 Sep 2019 20:34:08 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 10 Sep 2019 20:34:04 +0100
Message-Id: <20190910193408.28917-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH  v1 0/4] ELF and (macro) safety
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
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This is a small re-factoring series which I'll be needing for adding
guest architecture awareness to plugins. There is a little clean up of
concerns by removing the "template" type behaviour from elf.h into a
new elf-types.inc.h file. I then rationalise the ELF related headers
to all be in the same place. Finally the actual useful piece of moving
the definition of ELF_ARCH out of the two loader files and into an
stand alone header.

Alex Bennée (4):
  target/ppc: fix signal delivery for ppc64abi32
  elf: move elf.h to elf/elf.h and split out types
  elf: move elf_ops.h into include/elf/ and rename
  elf: move ELF_ARCH definition to elf-arch.h

 bsd-user/elfload.c                          |  15 +--
 contrib/elf2dmp/qemu_elf.h                  |   2 +-
 disas.c                                     |   2 +-
 dump/dump.c                                 |   2 +-
 dump/win_dump.c                             |   2 +-
 hw/alpha/dp264.c                            |   2 +-
 hw/arm/armv7m.c                             |   2 +-
 hw/arm/boot.c                               |   2 +-
 hw/core/loader.c                            |   7 +-
 hw/cris/axis_dev88.c                        |   2 +-
 hw/cris/boot.c                              |   2 +-
 hw/hppa/machine.c                           |   2 +-
 hw/i386/multiboot.c                         |   2 +-
 hw/i386/pc.c                                |   2 +-
 hw/lm32/lm32_boards.c                       |   2 +-
 hw/lm32/milkymist.c                         |   2 +-
 hw/m68k/an5206.c                            |   2 +-
 hw/m68k/mcf5208.c                           |   2 +-
 hw/microblaze/boot.c                        |   2 +-
 hw/mips/mips_fulong2e.c                     |   2 +-
 hw/mips/mips_malta.c                        |   2 +-
 hw/mips/mips_mipssim.c                      |   2 +-
 hw/mips/mips_r4k.c                          |   2 +-
 hw/moxie/moxiesim.c                         |   2 +-
 hw/nios2/boot.c                             |   2 +-
 hw/openrisc/openrisc_sim.c                  |   2 +-
 hw/pci-host/prep.c                          |   2 +-
 hw/ppc/e500.c                               |   2 +-
 hw/ppc/mac_newworld.c                       |   2 +-
 hw/ppc/mac_oldworld.c                       |   2 +-
 hw/ppc/ppc440_bamboo.c                      |   2 +-
 hw/ppc/prep.c                               |   2 +-
 hw/ppc/sam460ex.c                           |   2 +-
 hw/ppc/spapr.c                              |   2 +-
 hw/ppc/spapr_vio.c                          |   2 +-
 hw/ppc/virtex_ml507.c                       |   2 +-
 hw/riscv/boot.c                             |   2 +-
 hw/s390x/ipl.c                              |   2 +-
 hw/sparc/leon3.c                            |   2 +-
 hw/sparc/sun4m.c                            |   2 +-
 hw/sparc64/sun4u.c                          |   2 +-
 hw/tricore/tricore_testboard.c              |   2 +-
 hw/xtensa/sim.c                             |   2 +-
 hw/xtensa/xtfpga.c                          |   2 +-
 include/elf/elf-arch.h                      | 109 ++++++++++++++++++++
 include/elf/elf-types.inc.h                 |  63 +++++++++++
 include/{ => elf}/elf.h                     |  42 --------
 include/{hw/elf_ops.h => elf/elf_ops.inc.h} |   9 ++
 include/hw/core/generic-loader.h            |   2 +-
 linux-user/arm/cpu_loop.c                   |   2 +-
 linux-user/elfload.c                        |  32 ++----
 linux-user/main.c                           |   2 +-
 linux-user/mips/cpu_loop.c                  |   2 +-
 linux-user/ppc/signal.c                     |   4 +-
 linux-user/riscv/cpu_loop.c                 |   2 +-
 target/arm/arch_dump.c                      |   2 +-
 target/i386/arch_dump.c                     |   2 +-
 target/ppc/arch_dump.c                      |   2 +-
 target/ppc/kvm.c                            |   2 +-
 target/s390x/arch_dump.c                    |   2 +-
 tcg/arm/tcg-target.inc.c                    |   2 +-
 tcg/ppc/tcg-target.inc.c                    |   2 +-
 tcg/s390/tcg-target.inc.c                   |   2 +-
 tcg/tcg.c                                   |   5 +-
 tests/tcg/configure.sh                      |   1 +
 tests/tcg/multiarch/Makefile.target         |   5 -
 util/getauxval.c                            |   2 +-
 67 files changed, 258 insertions(+), 146 deletions(-)
 create mode 100644 include/elf/elf-arch.h
 create mode 100644 include/elf/elf-types.inc.h
 rename include/{ => elf}/elf.h (98%)
 rename include/{hw/elf_ops.h => elf/elf_ops.inc.h} (98%)

-- 
2.20.1


