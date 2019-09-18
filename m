Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2717C4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 15:30:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC08921907
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 15:30:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC08921907
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAbus-0000lq-T8
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 11:30:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48864)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1iAbrm-00066y-BG
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:27:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1iAbrk-0006GF-KV
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:27:38 -0400
Received: from mail-pf1-f176.google.com ([209.85.210.176]:44337)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1iAbrk-0006Ft-Dk
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:27:36 -0400
Received: by mail-pf1-f176.google.com with SMTP id q21so180038pfn.11
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 08:27:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=UMKjol02Opn+UR0h1CJk7tiXz0/2GnPpU87VOXpaQCw=;
 b=ETOsj+KXJcwIHZ4Ynf2UP0CL6hKIM6yrwD9LMu0HRLOykh7qgPB2D7xrhLYxrr4MYF
 VKfP8oswH6CNOnh/IDxI3GCtOlKTkuEor7tij/el392lX6CGa2tIsWleRmB0x/ruLgZm
 eE7fdq8EtS/5ao9qPNvjFPn98sFRBb+c6PgVVj8sLedf+EOsQtOl8H9MeExT6sv4odTa
 nk2GNZEh5tQc1D2GYE3H7A/xw0ejeD5H0kKyrGvUhZK6/XrRR7g/EQgrC9N4DNJTqTiK
 tlD19uPh+FX2Nks5Xt7d8uMpTk8vwpPrQE/HbMCoAfvf2Zrc15gwe6tBlSOw3wn02uIh
 RrwQ==
X-Gm-Message-State: APjAAAVLq1A+9YkmizZQxCsYUzE2TuZNAo3asvoZ43qdBQu017tIe4x7
 huOfj5j2vOfkX8KZFCAPqLaXUg==
X-Google-Smtp-Source: APXvYqwrWKijxADRVS5uPU/Jie+gOE2fDx2zrHB/+VdRZaRv1WhuKv0SMPuSp8qyabWMm6ZJMw6SwA==
X-Received: by 2002:a63:4c64:: with SMTP id m36mr4350184pgl.229.1568820454451; 
 Wed, 18 Sep 2019 08:27:34 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id k3sm6467944pgl.9.2019.09.18.08.27.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2019 08:27:33 -0700 (PDT)
Date: Wed, 18 Sep 2019 07:55:52 -0700
Message-Id: <20190918145640.17349-1-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.176
Subject: [Qemu-devel] [PULL] RISC-V Patches for the 4.2 Soft Freeze, Part 1,
 v3
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
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit f8c3db33a5e863291182f8862ddf81618a7c6194:

  target/sparc: Switch to do_transaction_failed() hook (2019-09-17 12:01:00 +0100)

are available in the Git repository at:

  git://github.com/palmer-dabbelt/qemu.git tags/riscv-for-master-4.2-sf1-v3

for you to fetch changes up to b3e86929189c526d22ef49e18f2f5066535f6deb:

  gdbstub: riscv: fix the fflags registers (2019-09-17 08:42:50 -0700)

----------------------------------------------------------------
RISC-V Patches for the 4.2 Soft Freeze, Part 1, v3

This contains quite a few patches that I'd like to target for 4.2.
They're mostly emulation fixes for the sifive_u board, which now much
more closely matches the hardware and can therefor run the same fireware
as what gets loaded onto the board.  Additional user-visible
improvements include:

* support for loading initrd files from the command line into Linux, via
  /chosen/linux,initrd-{start,end} device tree nodes.
* The conversion of LOG_TRACE to trace events.
* The addition of clock DT nodes for our uart and ethernet.

This also includes some preliminary work for the H extension patches,
but does not include the H extension patches as I haven't had time to
review them yet.

This passes my OE boot test on 32-bit and 64-bit virt machines, as well
as a 64-bit upstream Linux boot on the sifive_u machine.  It has been
fixed to actually pass "make check" this time.

Changes since v2 (never made it to the list):

* Sets the sifive_u machine default core count to 2 instead of 5.

Changes since v1 <20190910190513.21160-1-palmer@sifive.com>:

* Sets the sifive_u machine default core count to 5 instead of 1, as
  it's impossible to have a single core sifive_u machine.

----------------------------------------------------------------
Alistair Francis (5):
      riscv: plic: Remove unused interrupt functions
      target/riscv: Create function to test if FP is enabled
      target/riscv: Update the Hypervisor CSRs to v0.4
      target/riscv: Fix mstatus dirty mask
      target/riscv: Use TB_FLAGS_MSTATUS_FS for floating point

Atish Patra (1):
      target/riscv: Use both register name and ABI name

Bin Meng (36):
      riscv: rv32: Root page table address can be larger than 32-bit
      riscv: Add a helper routine for finding firmware
      riscv: Resolve full path of the given bios image
      riscv: hmp: Add a command to show virtual memory mappings
      riscv: sifive_test: Add reset functionality
      riscv: hw: Remove duplicated "hw/hw.h" inclusion
      riscv: hw: Remove superfluous "linux, phandle" property
      riscv: hw: Use qemu_fdt_setprop_cell() for property with only 1 cell
      riscv: hw: Remove not needed PLIC properties in device tree
      riscv: hw: Change create_fdt() to return void
      riscv: hw: Change to use qemu_log_mask(LOG_GUEST_ERROR, ...) instead
      riscv: hw: Remove the unnecessary include of target/riscv/cpu.h
      riscv: roms: Remove executable attribute of opensbi images
      riscv: sifive_u: Remove the unnecessary include of prci header
      riscv: sifive: Rename sifive_prci.{c, h} to sifive_e_prci.{c, h}
      riscv: sifive_e: prci: Fix a typo of hfxosccfg register programming
      riscv: sifive_e: prci: Update the PRCI register block size
      riscv: sifive_e: Drop sifive_mmio_emulate()
      riscv: Add a sifive_cpu.h to include both E and U cpu type defines
      riscv: hart: Extract hart realize to a separate routine
      riscv: hart: Add a "hartid-base" property to RISC-V hart array
      riscv: sifive_u: Set the minimum number of cpus to 2
      riscv: sifive_u: Update hart configuration to reflect the real FU540 SoC
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

Guenter Roeck (3):
      riscv: sifive_u: Add support for loading initrd
      riscv: sivive_u: Add dummy serial clock and aliases entry for uart
      riscv: sifive_u: Fix clock-names property for ethernet node

KONRAD Frederic (1):
      gdbstub: riscv: fix the fflags registers

Philippe Mathieu-Daudé (2):
      target/riscv/pmp: Restrict priviledged PMP to system-mode emulation
      target/riscv/pmp: Convert qemu_log_mask(LOG_TRACE) to trace events

 hmp-commands-info.hx                         |   2 +-
 hw/riscv/Kconfig                             |   2 +
 hw/riscv/Makefile.objs                       |   4 +-
 hw/riscv/boot.c                              |  26 ++-
 hw/riscv/riscv_hart.c                        |  34 ++--
 hw/riscv/sifive_e.c                          |  27 ++-
 hw/riscv/sifive_e_prci.c                     | 124 +++++++++++++
 hw/riscv/sifive_plic.c                       |  12 --
 hw/riscv/sifive_prci.c                       | 125 -------------
 hw/riscv/sifive_test.c                       |  11 +-
 hw/riscv/sifive_u.c                          | 253 +++++++++++++++++++--------
 hw/riscv/sifive_u_otp.c                      | 191 ++++++++++++++++++++
 hw/riscv/sifive_u_prci.c                     | 169 ++++++++++++++++++
 hw/riscv/sifive_uart.c                       |  10 +-
 hw/riscv/spike.c                             |   1 -
 hw/riscv/virt.c                              |  40 ++---
 include/hw/riscv/boot.h                      |   1 +
 include/hw/riscv/riscv_hart.h                |   1 +
 include/hw/riscv/sifive_cpu.h                |  31 ++++
 include/hw/riscv/sifive_e.h                  |   7 +-
 include/hw/riscv/sifive_e_prci.h             |  71 ++++++++
 include/hw/riscv/sifive_plic.h               |   3 -
 include/hw/riscv/sifive_prci.h               |  71 --------
 include/hw/riscv/sifive_test.h               |   3 +-
 include/hw/riscv/sifive_u.h                  |  31 ++--
 include/hw/riscv/sifive_u_otp.h              |  80 +++++++++
 include/hw/riscv/sifive_u_prci.h             |  91 ++++++++++
 pc-bios/opensbi-riscv32-virt-fw_jump.bin     | Bin
 pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin | Bin 40968 -> 45064 bytes
 pc-bios/opensbi-riscv64-virt-fw_jump.bin     | Bin
 roms/Makefile                                |   4 +-
 target/riscv/Makefile.objs                   |   7 +-
 target/riscv/cpu.c                           |  19 +-
 target/riscv/cpu.h                           |   6 +-
 target/riscv/cpu_bits.h                      |  35 ++--
 target/riscv/cpu_helper.c                    |  20 ++-
 target/riscv/csr.c                           |  22 +--
 target/riscv/gdbstub.c                       |   6 +-
 target/riscv/monitor.c                       | 229 ++++++++++++++++++++++++
 target/riscv/pmp.c                           |  35 ++--
 target/riscv/trace-events                    |   6 +
 41 files changed, 1366 insertions(+), 444 deletions(-)
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
 create mode 100644 target/riscv/monitor.c
From Palmer Dabbelt <palmer@sifive.com> # This line is ignored.
From: Palmer Dabbelt <palmer@sifive.com>
Reply-To: 
Subject: 
In-Reply-To: 



