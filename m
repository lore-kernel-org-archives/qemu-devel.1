Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 658DFC00307
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 16:28:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 256B4206CD
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 16:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFE7Eg01"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 256B4206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6H61-00051m-Hb
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 12:28:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56149)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1i6GyN-00049Z-S8
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 12:20:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1i6GyK-00044f-5c
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 12:20:31 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:44842)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1i6GyJ-00043p-Rs; Fri, 06 Sep 2019 12:20:28 -0400
Received: by mail-pg1-x543.google.com with SMTP id i18so3749505pgl.11;
 Fri, 06 Sep 2019 09:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hQoPMi0xI+Bxta3rZL/d/qPTCGgCagXuifkhJm6KLJk=;
 b=jFE7Eg01dEfMux7RIRd1fsVDe3K4Y0XTeL2yY7paeg9sKtbSulhqp3xpb9LK8Ln2SU
 oq3UF05oWJak8+AN3zbNDGyyVpNAkTelTky0iwfwQ4TvfUyYeP4xP3eoUjFwqB08Y92U
 vx3Z3/NGvdrtQJUgDWAJIHOdcvjlvl1+vftydK4NwcEOyMRNNVZbdrVJ5+3e+BXUyTtu
 X5kmMcpPRcG+WfyIbAdAJZ0mdzntKl2K0XSxQoE3TA2I6ameQOpbgAhgatkLLePWg7Ub
 eL98GY8jSUtCQKpxdAvdgOYle0+MoVy6ZkxDxX9hK7QGOkIv7zcHZUdX0STO8Plpfsfy
 YiJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=hQoPMi0xI+Bxta3rZL/d/qPTCGgCagXuifkhJm6KLJk=;
 b=m2bpnDHpOgdCOLgMyHYssINLgFEUDy+dXkiCJMyZr9TJ0iwgmjMTKycF21Lk8gmLgR
 aK+PNh3NPOWGO0HnbO6EjlOAAb/96CuCvw8cSyv2XvOnOe/Tx2nBViQSUTYR/E9TbF7P
 jfb/pqx5MeQbb8MEohCnA/4e15b6EsEMBun+QTXL6ohg9w/cvSTJ8FIRPQHtBvSVtuhL
 hUqwM5UuJqIv/1HbUrlMCg2h4lvza+AdLhH0aF6pdXRHr7ADk+wI+Du/dLYRG2TK0A3J
 7FNdrg30F13OIqD5BXBsEgFdFtdUvXZSZylQvrTupG7qZEVI3L3lCZendWndJBlGv1jV
 9NQg==
X-Gm-Message-State: APjAAAXzpa1CFfD1E3AkVQZAnBRMM7gkZvteK4UntD4+QEYys1m4BkC7
 IxtC1GRYAiLDndWVmry/ekE=
X-Google-Smtp-Source: APXvYqyPlZtBhk55nYgUoYHHFtHhniP4+NU1RE8fjGYAKDxyvNFTfXG1kNOkkPXOhTqCXsmmMycKLQ==
X-Received: by 2002:a17:90a:9409:: with SMTP id
 r9mr10608316pjo.10.1567786826318; 
 Fri, 06 Sep 2019 09:20:26 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id f89sm11146228pje.20.2019.09.06.09.20.25
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Fri, 06 Sep 2019 09:20:25 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Fri,  6 Sep 2019 09:19:47 -0700
Message-Id: <1567786819-22142-1-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PATCH v8 00/32] riscv: sifive_u: Improve the
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

OpenSBI v0.4 image built for sifive/fu540 is included as the default
bios image for 'sifive_u' machine.

The series is tested against OpenSBI v0.4 image for sifive/fu540
paltform, U-Boot v2019.10-rc1 image for sifive_fu540_defconfig,
and Linux kernel v5.3-rc3 image with the following patch:

macb: Update compatibility string for SiFive FU540-C000 [1]

OpenSBI + U-Boot, ping/tftpboot with U-Boot MACB driver works well.
Boot Linux 64-bit defconfig image, verified that system console on
the serial 0 and ping host work pretty well.

An OpenSBI patch [2] was sent to drop the special "qemu/sifive_u" platform
support in OpenSBI. The original plan was to get the drop patch applied
after this QEMU series is merged. However after discussion in the OpenSBI
mailing list, it seems the best option for us is to let OpenSBI continue
shipping the special "qemu/sifive_u" platform support to work with QEMU
version <= 4.1 and deprecate the support sometime in the future. A patch
will need to be sent to OpenSBI mailing list to update its document.

v4 is now rebased on Palmer's QEMU RISC-V repo "for-master" branch.
Dropped the following v3 patch that was already done by someone else.
- riscv: sifive_u: Generate an aliases node in the device tree
- riscv: sifive_u: Support loading initramfs

The following v3 patch was dropped too due to a different cluster approach
suggested by Richard Henderson is used in v4:
- riscv: hart: Support heterogeneous harts population

v8 is now rebased again on Palmer's QEMU RISC-V repo "for-master" branch,
and resolved conflicts and build errors. To ease patch inter-dependencies,
v8 includes the following 2 patches so that all of them can be applied
cleanly on Palmer's QEMU RISC-V "for-master" branch.

- riscv: hw: Remove duplicated "hw/hw.h" inclusion [3]
- riscv: sifive_test: Add reset functionality [4]

The whole patch series is also available at
https://github.com/lbmeng/qemu repo, "sifive_u_cluster" branch.

[1]: https://patchwork.kernel.org/patch/11050003/
[2]: http://lists.infradead.org/pipermail/opensbi/2019-August/000335.html
[3]: http://patchwork.ozlabs.org/patch/1159063/
[4]: http://patchwork.ozlabs.org/patch/1158526/

Changes in v8:
- select UNIMP in sifive_e Kconfig due to applied commit
  "hw/misc: Add a config switch for the "unimplemented" device"
  in latest qemu/master
- Don't cast addr to an int, use the correct macros in
  sifive_u_otp_read() and sifive_u_otp_write()
- Include "hw/qdev-properties.h" in sifive_u_otp.c
- select UNIMP in sifive_u Kconfig due to applied commit
  "hw/misc: Add a config switch for the "unimplemented" device"
  in latest qemu/master

Changes in v7:
- use `s->hartid_base + idx` directly

Changes in v6:
- use s->hartid_base directly, instead of an extra variable
- generate u cpus unconditionally (not test ms->smp.cpus > 1)
  since the minimal required number of cpu is now 2, due to
  this patch is reordered
- fix incorrectly indented comment lines
- remove unneeded brackets around assignment

Changes in v5:
- new patch to change to use qemu_log_mask(LOG_GUEST_ERROR,...) instead
  in various sifive models
- new patch to remove the unnecessary include of target/riscv/cpu.h
- change to use defines instead of enums
- change to use qemu_log_mask(LOG_GUEST_ERROR,...) in sifive_u_prci
- creating a 32-bit val variable and using that instead of casting
  everywhere in sifive_u_prci_write()
- move all register initialization to sifive_u_prci_reset() function
- drop sifive_u_prci_create()
- s/codes that worked/code that works/g
- create sifive_u_prci block directly in the machine codes, instead
  of calling sifive_u_prci_create()
- change to use defines instead of enums
- change to use qemu_log_mask(LOG_GUEST_ERROR,...) in sifive_u_otp
- creating a 32-bit val variable and using that instead of casting
  everywhere in sifive_u_otp_write()
- move all register initialization to sifive_u_otp_reset() function
- drop sifive_u_otp_create()
- create sifive_u_otp block directly in the machine codes, instead
  of calling sifive_u_otp_create()
- add the missing "local-mac-address" property in the ethernet node

Changes in v4:
- remove 2 more "linux,phandle" instances in sifive_u.c and spike.c
  after rebasing on Palmer's QEMU RISC-V tree
- change create_fdt() to return void in sifive_u.c too, after rebasing
  on Palmer's QEMU RISC-V tree
- new patch to remove executable attribute of opensbi images
- prefix all macros/variables/functions with SIFIVE_E/sifive_e
  in the sifive_e_prci driver
- new patch to add a "hartid-base" property to RISC-V hart array
- changed to create clusters for each cpu type
- prefix all macros/variables/functions with SIFIVE_U/sifive_u
  in the sifive_u_prci driver
- prefix all macros/variables/functions with SIFIVE_U/sifive_u
  in the sifive_u_otp driver
- new patch to remove handcrafted clock nodes for UART and ethernet

Changes in v3:
- use management cpu count + 1 for the min_cpus
- changed to use macros for management and compute cpu count
- update IRQ numbers of both UARTs to match hardware as well

Changes in v2:
- fix build error in the "for-master" branch of Palmer's RISC-V repo
  that was rebased on QEMU master
- keep the PLIC compatible string unchanged as OpenSBI uses that
  for DT fix up
- drop patch "riscv: sifive: Move sifive_mmio_emulate() to a common place"
- new patch "riscv: sifive_e: Drop sifive_mmio_emulate()"
- update the file header to indicate at least 2 harts are created
- fixed the "interrupts-extended" property size
- use create_unimplemented_device() to create the GEM management
  block instead of sifive_mmio_emulate()
- add "phy-handle" property to the ethernet node

Bin Meng (32):
  riscv: hw: Remove duplicated "hw/hw.h" inclusion
  riscv: sifive_test: Add reset functionality
  riscv: hw: Remove superfluous "linux,phandle" property
  riscv: hw: Use qemu_fdt_setprop_cell() for property with only 1 cell
  riscv: hw: Remove not needed PLIC properties in device tree
  riscv: hw: Change create_fdt() to return void
  riscv: hw: Change to use qemu_log_mask(LOG_GUEST_ERROR,...) instead
  riscv: hw: Remove the unnecessary include of target/riscv/cpu.h
  riscv: roms: Remove executable attribute of opensbi images
  riscv: sifive_u: Remove the unnecessary include of prci header
  riscv: sifive: Rename sifive_prci.{c,h} to sifive_e_prci.{c,h}
  riscv: sifive_e: prci: Fix a typo of hfxosccfg register programming
  riscv: sifive_e: prci: Update the PRCI register block size
  riscv: sifive_e: Drop sifive_mmio_emulate()
  riscv: Add a sifive_cpu.h to include both E and U cpu type defines
  riscv: hart: Extract hart realize to a separate routine
  riscv: hart: Add a "hartid-base" property to RISC-V hart array
  riscv: sifive_u: Set the minimum number of cpus to 2
  riscv: sifive_u: Update hart configuration to reflect the real FU540
    SoC
  riscv: sifive_u: Update PLIC hart topology configuration string
  riscv: sifive: Implement PRCI model for FU540
  riscv: sifive_u: Generate hfclk and rtcclk nodes
  riscv: sifive_u: Add PRCI block to the SoC
  riscv: sifive_u: Reference PRCI clocks in UART and ethernet nodes
  riscv: sifive_u: Update UART base addresses and IRQs
  riscv: sifive_u: Change UART node name in device tree
  riscv: roms: Update default bios for sifive_u machine
  riscv: sifive: Implement a model for SiFive FU540 OTP
  riscv: sifive_u: Instantiate OTP memory with a serial number
  riscv: sifive_u: Fix broken GEM support
  riscv: sifive_u: Remove handcrafted clock nodes for UART and ethernet
  riscv: sifive_u: Update model and compatible strings in device tree

 hw/riscv/Kconfig                             |   2 +
 hw/riscv/Makefile.objs                       |   4 +-
 hw/riscv/riscv_hart.c                        |  34 ++--
 hw/riscv/sifive_e.c                          |  27 ++-
 hw/riscv/sifive_e_prci.c                     | 124 +++++++++++++
 hw/riscv/sifive_prci.c                       | 125 -------------
 hw/riscv/sifive_test.c                       |  11 +-
 hw/riscv/sifive_u.c                          | 255 ++++++++++++++++++---------
 hw/riscv/sifive_u_otp.c                      | 191 ++++++++++++++++++++
 hw/riscv/sifive_u_prci.c                     | 169 ++++++++++++++++++
 hw/riscv/sifive_uart.c                       |  10 +-
 hw/riscv/spike.c                             |   1 -
 hw/riscv/virt.c                              |  40 ++---
 include/hw/riscv/riscv_hart.h                |   1 +
 include/hw/riscv/sifive_cpu.h                |  31 ++++
 include/hw/riscv/sifive_e.h                  |   7 +-
 include/hw/riscv/sifive_e_prci.h             |  71 ++++++++
 include/hw/riscv/sifive_prci.h               |  71 --------
 include/hw/riscv/sifive_test.h               |   3 +-
 include/hw/riscv/sifive_u.h                  |  31 ++--
 include/hw/riscv/sifive_u_otp.h              |  80 +++++++++
 include/hw/riscv/sifive_u_prci.h             |  91 ++++++++++
 pc-bios/opensbi-riscv32-virt-fw_jump.bin     | Bin
 pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin | Bin 40968 -> 45064 bytes
 pc-bios/opensbi-riscv64-virt-fw_jump.bin     | Bin
 roms/Makefile                                |   4 +-
 26 files changed, 1017 insertions(+), 366 deletions(-)
 create mode 100644 hw/riscv/sifive_e_prci.c
 delete mode 100644 hw/riscv/sifive_prci.c
 create mode 100644 hw/riscv/sifive_u_otp.c
 create mode 100644 hw/riscv/sifive_u_prci.c
 create mode 100644 include/hw/riscv/sifive_cpu.h
 create mode 100644 include/hw/riscv/sifive_e_prci.h
 delete mode 100644 include/hw/riscv/sifive_prci.h
 create mode 100644 include/hw/riscv/sifive_u_otp.h
 create mode 100644 include/hw/riscv/sifive_u_prci.h
 mode change 100755 => 100644 pc-bios/opensbi-riscv32-virt-fw_jump.bin
 mode change 100755 => 100644 pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin
 mode change 100755 => 100644 pc-bios/opensbi-riscv64-virt-fw_jump.bin

-- 
2.7.4


