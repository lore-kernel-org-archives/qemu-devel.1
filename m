Return-Path: <SRS0=60Ee=WH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC9FC433FF
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 08:07:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5B0B208C2
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 08:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbAgGbex"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5B0B208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwitO-000786-W9
	for qemu-devel@archiver.kernel.org; Sun, 11 Aug 2019 04:07:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59986)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hwisg-0005Qf-1h
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 04:07:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hwise-0003oY-Km
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 04:07:09 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:42731)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hwise-0003o0-D3; Sun, 11 Aug 2019 04:07:08 -0400
Received: by mail-pf1-x442.google.com with SMTP id q10so48227627pff.9;
 Sun, 11 Aug 2019 01:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=tnRe1xqxScKT89NoqnQ7QA0x07q5MUFFXGcHCq2Z2yk=;
 b=lbAgGbexlIWQum1f+CPqrzS4RaZT5NqzpPAvaXCxyB9s/atY/+QqMNaW2N+dlvFx/H
 USHzUSi3yShMyH0RO5viTSXWlQWgraelxiJE3HaAJwTRYBiphcnlzlUna9LIuaBq09Xa
 hfQJ0lxxXf3QcqWxARLflrG3fBjjwMYi8BZ2+/Cg6+k8LdiU6iV/k0jzASxhSMIzmytR
 1Jn25W+ZGPe+AMx00A6hUn6ASaX0kwfndfv8M2RzpuwM0h+TN6T1fDB0h2525ZwMlNMw
 HbTl4nPsRYkiGcydlYaHYAkZrO0zmwT6CLVg3+AmjJLI3bCo3Q/bEPjm8L1DTnOXckgM
 zDiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=tnRe1xqxScKT89NoqnQ7QA0x07q5MUFFXGcHCq2Z2yk=;
 b=Vciv8KDutaBTa6rCW4PWzV67B1A3oLRL0o7W+2eR9o25drRplxh2IfC7+NTlx6SiG3
 YP9CbMin9RXZGNvAfhnRgH/npYrMbI5xlLoJFH+Z/b+7GT+88QbMmqxVdO/H0NMO3DbC
 /jYsangxfl/40gEz47C7vE6E/QydyfEebgwCFdOOPXeTOSXQSRoktNNbpXVwpKOisxe/
 m7Q/SQz7r4Spe/VeSX10nVIUXhjqvELfT9H4FWeKedT2fLwV8IKLCUysu8W9upyreqqr
 wB/Ui60Vy6Fm5deAu3N3MPAZTI8DlTwOzA2/l7p1NovzMc3KCYk9Au4Bih2mbWm6luZV
 gO6g==
X-Gm-Message-State: APjAAAWjKleAunST1CpiB3D6bAo32rcPZMSBtlRfHmjAu/lxPgXcj8BS
 0A97pG5hIaOyNOqDXnnphs4=
X-Google-Smtp-Source: APXvYqyQrNWj9WJlruqi8QdKFKgn35T9i02Nb+l+wqkpePtvTWIouAQq90ntFNHbxlY8PmHCtIbd0A==
X-Received: by 2002:aa7:9293:: with SMTP id j19mr10725727pfa.90.1565510827278; 
 Sun, 11 Aug 2019 01:07:07 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id v8sm87339107pgs.82.2019.08.11.01.07.06
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Sun, 11 Aug 2019 01:07:06 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Sun, 11 Aug 2019 01:06:33 -0700
Message-Id: <1565510821-3927-1-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH v3 00/28] riscv: sifive_u: Improve the
 emulation fidelity of sifive_u machine
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

As of today, the QEMU 'sifive_u' machine is a special target that does
not boot the upstream OpenSBI/U-Boot firmware images built for the real
SiFive HiFive Unleashed board. Hence OpenSBI supports a special platform
"qemu/sifive_u". For U-Boot, the sifive_fu540_defconfig is referenced
in the OpenSBI doc as its payload, but that does not boot at all due
to various issues in current QEMU 'sifive_u' machine codes.

This series aims to improve the emulation fidelity of sifive_u machine,
so that the upstream OpenSBI, U-Boot and kernel images built for the
SiFive HiFive Unleashed board can be used out of the box without any
special hack.

The major changes include:
- Heterogeneous harts creation supported, so that we can create a CPU
  that exactly mirrors the real hardware: 1 E51 + 4 U54.
- Implemented a PRCI model for FU540
- Implemented an OTP model for FU540, primarily used for storing serial
  number of the board
- Fixed GEM support that was seriously broken on sifive_u
- Synced device tree with upstream Linux kernel on sifive_u
- Adding initramfs loading support on sifive_u

OpenSBI v0.4 image built for sifive/fu540 is included as the default
bios image for 'sifive_u' machine.

The series is tested against OpenSBI v0.4 image for sifive/fu540
paltform, U-Boot v2019.10-rc1 image for sifive_fu540_defconfig,
and Linux kernel v5.3-rc3 image with the following patch:

macb: Update compatibility string for SiFive FU540-C000
https://patchwork.kernel.org/patch/11050003/

OpenSBI + U-Boot, ping/tftpboot with U-Boot MACB driver works well.
Boot Linux 64-bit defconfig image, verified that system console on
the serial 0 and ping host work pretty well.

An OpenSBI patch was sent to drop the special "qemu/sifive_u" platform
support in OpenSBI. It will be applied after this QEMU series is merged.
http://lists.infradead.org/pipermail/opensbi/2019-August/000335.html

Changes in v3:
- changed to use macros for management and compute cpu count
- use management cpu count + 1 for the min_cpus
- update IRQ numbers of both UARTs to match hardware as well

Changes in v2:
- fixed the "interrupts-extended" property size
- update the file header to indicate at least 2 harts are created
- use create_unimplemented_device() to create the GEM management
  block instead of sifive_mmio_emulate()
- add "phy-handle" property to the ethernet node
- keep the PLIC compatible string unchanged as OpenSBI uses that
  for DT fix up
- drop patch "riscv: sifive: Move sifive_mmio_emulate() to a common place"
- new patch "riscv: sifive_e: Drop sifive_mmio_emulate()"

Bin Meng (28):
  riscv: hw: Remove superfluous "linux,phandle" property
  riscv: hw: Use qemu_fdt_setprop_cell() for property with only 1 cell
  riscv: Add a sifive_cpu.h to include both E and U cpu type defines
  riscv: hart: Extract hart realize to a separate routine
  riscv: hart: Support heterogeneous harts population
  riscv: sifive_u: Update hart configuration to reflect the real FU540
    SoC
  riscv: sifive_u: Set the minimum number of cpus to 2
  riscv: sifive_u: Update PLIC hart topology configuration string
  riscv: sifive_u: Update UART base addresses and IRQs
  riscv: sifive_u: Remove the unnecessary include of prci header
  riscv: sifive: Rename sifive_prci.{c,h} to sifive_e_prci.{c,h}
  riscv: sifive_e: prci: Fix a typo of hfxosccfg register programming
  riscv: sifive_e: prci: Update the PRCI register block size
  riscv: sifive: Implement PRCI model for FU540
  riscv: sifive_u: Generate hfclk and rtcclk nodes
  riscv: sifive_u: Add PRCI block to the SoC
  riscv: sifive_u: Change UART node name in device tree
  riscv: hw: Implement a model for SiFive FU540 OTP
  riscv: sifive_u: Instantiate OTP memory with a serial number
  riscv: roms: Update default bios for sifive_u machine
  riscv: sifive_u: Update UART and ethernet node clock properties
  riscv: sifive_u: Generate an aliases node in the device tree
  riscv: sifive_u: Fix broken GEM support
  riscv: sifive_u: Support loading initramfs
  riscv: hw: Remove not needed PLIC properties in device tree
  riscv: sifive_e: Drop sifive_mmio_emulate()
  riscv: virt: Change create_fdt() to return void
  riscv: sifive_u: Update model and compatible strings in device tree

 hw/riscv/Makefile.objs                             |   4 +-
 hw/riscv/riscv_hart.c                              |  75 ++++++--
 hw/riscv/sifive_e.c                                |  27 ++-
 hw/riscv/{sifive_prci.c => sifive_e_prci.c}        |  16 +-
 hw/riscv/sifive_u.c                                | 185 ++++++++++++++------
 hw/riscv/sifive_u_otp.c                            | 194 +++++++++++++++++++++
 hw/riscv/sifive_u_prci.c                           | 163 +++++++++++++++++
 hw/riscv/virt.c                                    |  40 ++---
 include/hw/riscv/sifive_cpu.h                      |  31 ++++
 include/hw/riscv/sifive_e.h                        |   7 +-
 .../hw/riscv/{sifive_prci.h => sifive_e_prci.h}    |  16 +-
 include/hw/riscv/sifive_u.h                        |  22 +--
 include/hw/riscv/sifive_u_otp.h                    |  90 ++++++++++
 include/hw/riscv/sifive_u_prci.h                   | 100 +++++++++++
 pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin       | Bin 40968 -> 45064 bytes
 roms/Makefile                                      |   4 +-
 16 files changed, 830 insertions(+), 144 deletions(-)
 rename hw/riscv/{sifive_prci.c => sifive_e_prci.c} (88%)
 create mode 100644 hw/riscv/sifive_u_otp.c
 create mode 100644 hw/riscv/sifive_u_prci.c
 create mode 100644 include/hw/riscv/sifive_cpu.h
 rename include/hw/riscv/{sifive_prci.h => sifive_e_prci.h} (80%)
 create mode 100644 include/hw/riscv/sifive_u_otp.h
 create mode 100644 include/hw/riscv/sifive_u_prci.h

-- 
2.7.4


