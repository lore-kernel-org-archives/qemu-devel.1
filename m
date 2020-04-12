Return-Path: <SRS0=Byls=54=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6912DC2BB85
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 22:37:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 269C1206E5
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 22:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcKgdj2G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 269C1206E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNlEK-0006p6-8i
	for qemu-devel@archiver.kernel.org; Sun, 12 Apr 2020 18:37:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47069)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlDK-0004tM-6U
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 18:36:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlDI-0001mG-5u
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 18:36:30 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36397)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlDH-0001l8-J0; Sun, 12 Apr 2020 18:36:28 -0400
Received: by mail-wm1-x342.google.com with SMTP id a201so8009293wme.1;
 Sun, 12 Apr 2020 15:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=O9DVxnJIdTKjCwxywR9qxji3Q0BtyKw5Rq6FDdEjMX4=;
 b=bcKgdj2G5dcGHI/taGqt6SJmDDHYp8NjlA/n51/kci3Ejs50CU02jtQQmxvBUHJ5Xy
 g1r5E+oSMSNlwg/9QWbuZwE/lY5KgAv1FINYhiKFl5f0Kclg0hZnYUtJAk7PhL4uLeo5
 5NuKeq9oUQ5hVjSqcOQn7wjVbqpTViGYAOI3PempLhSif4hlNORocx08xlbtnLEzv8Iy
 xhqV2DPXcbrA3f1rTs32egW8cMGqhBgrx17c/nOHDLFjTlXH2sVhpFpVCxHlOUSB8fZJ
 pbKqoETm/J5XUHsCsLHihpsRS05/a01GS10LUxJ+9xp7A+yJ10yabcgUlm4AGm2PgA+y
 pkTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=O9DVxnJIdTKjCwxywR9qxji3Q0BtyKw5Rq6FDdEjMX4=;
 b=G4UG8nEYoprHURVLWz79ezlAq2TAQUSRpXilI9BjdVKp6ZEmBw+C3SgeEYJwm7w612
 jgVt9BCyJrmVC2iGepNW/2qp1TaFB9bRS5lBfFBJUzmpizoBEbAFqlKofGqWE2chTj0Z
 oAsnDlqeLlckjfqL6mrIgRoXkJVvychG04+tkXp6Zi2jGkMUh7rSx01fAPLwT0BuKdvI
 IIcIXxOdVvXbmXFcpmud92s7ME8dLUOcETNnGXnYvj2drokfQZfWLeHZYUKcZsaKQ+sX
 8aw3W0/Mg1nTTBBuSGHSMfF8bf7Qb6CppKq2RlkCXHoDSy7Qwi6qKMoxO8POpcji0krY
 2wlw==
X-Gm-Message-State: AGi0PuaR10BpGOaoPs4JLjgvx4z57PK+1c0dQzdtlSsS6ipZokEa2D8z
 3xLuVLc912nHJPp/T29IxlPG/qUvIuogUQ==
X-Google-Smtp-Source: APiQypJvvtcUJDqdYeNSOxHeoHZ059BKv4U4AQaaG1JUVHscWMaZJzol3gpsvjuVDmfwxlJpd4rRPw==
X-Received: by 2002:a1c:7ed7:: with SMTP id z206mr14925481wmc.64.1586730984452; 
 Sun, 12 Apr 2020 15:36:24 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id d13sm12563559wrv.34.2020.04.12.15.36.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2020 15:36:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1 v3 00/24] various: Fix error-propagation with
 Coccinelle scripts (part 1)
Date: Mon, 13 Apr 2020 00:35:55 +0200
Message-Id: <20200412223619.11284-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jeff Cody <codyprime@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 qemu-riscv@nongnu.org, Andrew Jeffery <andrew@aj.id.au>,
 Wen Congyang <wencongyang2@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-ppc@nongnu.org,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series is inspired of Peter Maydell fix [1]:
"hw/arm/xlnx-zynqmp.c: fix some error-handling code",
but grew after v1 [2] review :/

Markus: I added the cocci patches to your Error section, I hope
that's fine :)

Part 1: Simplify error propagation by moving some code from
        DeviceClass::realize() to DeviceClass:initfn().

Regards,

Phil.

[1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg691636.html
[2] https://www.mail-archive.com/qemu-devel@nongnu.org/msg692155.html
Supersedes: <20200406174743.16956-1-f4bug@amsat.org>

Philippe Mathieu-Daud=C3=A9 (24):
  various: Remove suspicious '\' character outside of #define in C code
  scripts/coccinelle: Script to simplify DeviceClass error propagation
  hw/arm/allwinner-a10: Move some code from realize() to init()
  hw/arm/aspeed_ast2600: Simplify use of Error*
  hw/arm/aspeed_ast2600: Move some code from realize() to init()
  hw/arm/aspeed_soc: Move some code from realize() to init()
  hw/arm/aspeed_soc: Simplify use of Error*
  hw/arm/fsl-imx6: Simplify checks on 'smp_cpus' count
  hw/arm/fsl-imx6: Move some code from realize() to init()
  hw/arm/fsl-imx31: Move some code from realize() to init()
  hw/arm/msf2-soc: Store MemoryRegion in MSF2State
  hw/arm/stm32f205_soc: Store MemoryRegion in STM32F205State
  hw/arm/stm32f205_soc: Move some code from realize() to init()
  hw/arm/xlnx-zynqmp: Use single propagate_error() call
  hw/arm/xlnx-zynqmp: Split xlnx_zynqmp_create_rpu() as init + realize
  hw/arm/xlnx-zynqmp: Move some code from realize() to init()
  hw/microblaze/xlnx-zynqmp-pmu: Move some code from realize() to init()
  hw/pci-host/pnv_phb3: Move some code from realize() to init()
  hw/riscv/sifive_e: Move some code from realize() to init()
  hw/riscv/sifive_u: Use single type_init()
  hw/riscv/sifive_u: Move some code from realize() to init()
  hw/riscv/sifive_u: Store MemoryRegion in SiFiveUSoCState
  hw/riscv/sifive_u: Move some code from realize() to init()
  hw/riscv/sifive_u: Rename MachineClass::init()

 ...implify-init-realize-error_propagate.cocci |  69 ++++++++++
 include/hw/arm/msf2-soc.h                     |   4 +
 include/hw/arm/stm32f205_soc.h                |   4 +
 include/hw/riscv/sifive_u.h                   |   2 +
 block/replication.c                           |   4 +-
 block/vhdx.c                                  |   8 +-
 dump/dump.c                                   |   2 +-
 hw/arm/allwinner-a10.c                        |  26 ++--
 hw/arm/aspeed_ast2600.c                       |  61 +++++----
 hw/arm/aspeed_soc.c                           |  19 +--
 hw/arm/fsl-imx31.c                            |   4 +-
 hw/arm/fsl-imx6.c                             |  55 ++++----
 hw/arm/msf2-soc.c                             |  18 +--
 hw/arm/stm32f205_soc.c                        |  28 ++--
 hw/arm/xlnx-zynqmp.c                          | 126 +++++++++---------
 hw/microblaze/xlnx-zynqmp-pmu.c               |  46 +++----
 hw/net/virtio-net.c                           |   2 +-
 hw/pci-host/pnv_phb3.c                        |   8 +-
 hw/riscv/sifive_e.c                           |  26 ++--
 hw/riscv/sifive_u.c                           |  66 +++++----
 hw/scsi/scsi-disk.c                           |   2 +-
 hw/sd/sdhci.c                                 |   2 +-
 target/i386/cpu.c                             |  18 +--
 target/microblaze/cpu.c                       |  14 +-
 target/ppc/translate_init.inc.c               |   4 +-
 MAINTAINERS                                   |   1 +
 26 files changed, 342 insertions(+), 277 deletions(-)
 create mode 100644 scripts/coccinelle/simplify-init-realize-error_propagate.=
cocci

--=20
2.21.1


