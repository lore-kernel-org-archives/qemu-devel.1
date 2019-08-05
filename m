Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A764FC0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 16:06:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 714B32064A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 16:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4V2ZquL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 714B32064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hufVD-0001Ae-O4
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 12:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58187)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hufPT-0008Pc-B5
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 12:00:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hufPR-0002jI-MS
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 12:00:31 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:32805)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hufPR-0002hB-E8; Mon, 05 Aug 2019 12:00:29 -0400
Received: by mail-pl1-x641.google.com with SMTP id c14so36567129plo.0;
 Mon, 05 Aug 2019 09:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id;
 bh=TtE2TN8qJaX/qotNkH+V8ocOIPSa55Bf89V7FHWWfhI=;
 b=k4V2ZquL2qc0YwVsFTEv6YpQDfnSDeIwRGh7Pj4+hh84JAM3sjSVv3ePFi28QHZu5O
 fYUZaVC016UGcXEYW6EMEU7iAKOoSWB682NHALsZcINzHklMm2v2ZKxhKviMI4fKJqMs
 81taMcD2aZ1ca8IF9rtmViIivXcB4kATQs46xOC21kzC/YArFZRwcqSjkFTKvAqRp5nE
 UAo6Tslma+HGEfu/d35293G/YLh9DKkwilgYSTRCBeObzBm3tDFDTkJ8dZZ47kUxVvLl
 4rl64wwj36DMMkPHNJWRwy05t0bEeK8CTSTpn6leIzbSiK4SGYayP6Dkijs/bAHCvkLE
 OF7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id;
 bh=TtE2TN8qJaX/qotNkH+V8ocOIPSa55Bf89V7FHWWfhI=;
 b=ZqJL4jNGfGpPRT+Q9ealTR5koePwESfonS9nE43uspbdwJMi0i5XGMnEvGK6Co5XuJ
 fJJBlUzepmbNk5qgmKKsAAi66jhj/QWlm5gnmjmpKvjTDvDEUz/z+egttc1y4xyEEqCJ
 gZo6zAXP2yz1iwwoKjWo+jalOSoT8yGMBNWiPuGVYQVywviWNAC5ME1V/7A2naZocxtC
 KHWoe5nUf0apTdWl7p8qNpDjvuWoLYNtD/GeG8EOmlgQEWlg5690LfVNliyGxKCsQufO
 bSMST2oFBM/39in9C+Xw/kK9hPt9nJrUjJyPbPTwj7WTFVQkvU0sPV83nrCz36kY/PzJ
 084A==
X-Gm-Message-State: APjAAAULS5zL9k6W9W1YNS7hbHH2F9T/EHhAxMWBnkvB9hQvuU8ik0e5
 JkFChZYEEtZgSvN210RgOvs=
X-Google-Smtp-Source: APXvYqwwO9HgWPwF32EwEltptxLV+cmPifY0jRovZ38asf/kjB6rIj6GJUbyihqylDtsVgUJBruiZg==
X-Received: by 2002:a17:902:41:: with SMTP id
 59mr51438959pla.195.1565020828262; 
 Mon, 05 Aug 2019 09:00:28 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id d18sm47728793pgi.40.2019.08.05.09.00.27
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Mon, 05 Aug 2019 09:00:27 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Mon,  5 Aug 2019 08:59:55 -0700
Message-Id: <1565020823-24223-1-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [PATCH 00/28] riscv: sifive_u: Improve the emulation
 fidelity of sifive_u machine
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

The major changes are:
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
For Linux, only checked boot log of MACB probe success without error.


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
  riscv: sifive_u: Update UART base addresses
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
  riscv: sifive: Move sifive_mmio_emulate() to a common place
  riscv: sifive_u: Fix broken GEM support
  riscv: sifive_u: Support loading initramfs
  riscv: hw: Update PLIC device tree
  riscv: virt: Change create_fdt() to return void
  riscv: sifive_u: Update model and compatible strings in device tree

 hw/riscv/Makefile.objs                             |   4 +-
 hw/riscv/riscv_hart.c                              |  75 ++++++--
 hw/riscv/sifive_e.c                                |  12 +-
 hw/riscv/{sifive_prci.c => sifive_e_prci.c}        |  16 +-
 hw/riscv/sifive_u.c                                | 181 +++++++++++++------
 hw/riscv/sifive_u_otp.c                            | 194 +++++++++++++++++++++
 hw/riscv/sifive_u_prci.c                           | 163 +++++++++++++++++
 hw/riscv/virt.c                                    |  42 ++---
 include/hw/riscv/sifive_cpu.h                      |  39 +++++
 include/hw/riscv/sifive_e.h                        |   7 +-
 .../hw/riscv/{sifive_prci.h => sifive_e_prci.h}    |  16 +-
 include/hw/riscv/sifive_u.h                        |  15 +-
 include/hw/riscv/sifive_u_otp.h                    |  90 ++++++++++
 include/hw/riscv/sifive_u_prci.h                   | 100 +++++++++++
 pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin       | Bin 40968 -> 45064 bytes
 roms/Makefile                                      |   4 +-
 16 files changed, 824 insertions(+), 134 deletions(-)
 rename hw/riscv/{sifive_prci.c => sifive_e_prci.c} (88%)
 create mode 100644 hw/riscv/sifive_u_otp.c
 create mode 100644 hw/riscv/sifive_u_prci.c
 create mode 100644 include/hw/riscv/sifive_cpu.h
 rename include/hw/riscv/{sifive_prci.h => sifive_e_prci.h} (80%)
 create mode 100644 include/hw/riscv/sifive_u_otp.h
 create mode 100644 include/hw/riscv/sifive_u_prci.h

-- 
2.7.4


