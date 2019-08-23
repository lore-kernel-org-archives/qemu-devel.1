Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4A9C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 17:31:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A8BA206DD
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 17:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcLDbAci"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A8BA206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1DPF-0006Lu-2s
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 13:31:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58370)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1i1DN7-0004MB-Ne
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 13:29:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1i1DN4-0004nE-KN
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 13:29:08 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:40048)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1i1DN4-0004mY-54; Fri, 23 Aug 2019 13:29:06 -0400
Received: by mail-lj1-x242.google.com with SMTP id e27so9561760ljb.7;
 Fri, 23 Aug 2019 10:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2VU+kxBlU2QQUUQywu8aSQ3y8DCic03Vze9lrurFUrA=;
 b=NcLDbAcihAYDEExMdqxhrOajkIy3ROpXsB8b689FXsoS66oFo4T70b+AFPkiNPfVF6
 4fkPPVA6a579A5JOZ1wBhd0jM+POyTYd7w+5g4qIEjBy1J53drBYhicmSmxvVbLMc/hb
 omK4GDwQkjcVAj8Vg0/oeIR4upelm/renJpZOTfBoJwEM8o2vS8b0iQ+84fH8vs9dhoF
 RqG25waj167NB2xR1uaxg1ru1T0nb1PZIG8YK02Lo2WCuTq7HqfxlLmWR/YJhdCFiqrI
 5GvNCGPNTCw4h0i0jK8lFkFweAVs1t15vXK7U2GbEQwwf4CxbgYjrA6l9c7Y0MP1JMb8
 XYrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2VU+kxBlU2QQUUQywu8aSQ3y8DCic03Vze9lrurFUrA=;
 b=NfdMR9xGfU3aZwghQd7JBzc8rzGlnA1A1KuTddiVAMfGMCZS5gsrq9QzqLp9K8v7hM
 H/xikcNMW7vcN+juJn0bumg6308MEouCQHzpOLxnDuNz3USeqeTArVnNtFYW8LJlfu6d
 0CrUSu1qNM03yRCsFu72+PVnmGkSOQP6kbEkoKPWH0zYsCoB1eTCjzv1kX0xyL24ep11
 fui2QXIp6ob2FOZKoy3uInxsEZIdOt9ktGE8yvpUzxZPCXj6/gOok8ElZ2lCzWSEcGNV
 1ih03hJUIkGFwYLkfZ90Zcbv1blAvJTRvFeseeDIGAP7geoeJKyhHulMlyvHl7snFSte
 N3Sw==
X-Gm-Message-State: APjAAAWkCYDn+lE7+iy7LD+0psh1XW46x/NQj3sxhBo/Dn6wvUYkgtzb
 GGqdWEJJ0MtFPQGDU8bE23wsdFObnzgNYNw5aSw=
X-Google-Smtp-Source: APXvYqw9/1C/Mn4UuTSAJvETszqx0hh14/Q2CypEiNsNBQJi8DHZ9KO50qWbLdTkJWlfziOrw9P2J0Ml8Jl7RpauTYE=
X-Received: by 2002:a2e:8102:: with SMTP id d2mr3673659ljg.58.1566581344444;
 Fri, 23 Aug 2019 10:29:04 -0700 (PDT)
MIME-Version: 1.0
References: <1566537069-22741-1-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1566537069-22741-1-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 23 Aug 2019 10:24:58 -0700
Message-ID: <CAKmqyKOnEtyzW-=Lpe3kWPkQ2OwwPShtC7E=wmaUGRmns97D2w@mail.gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
Subject: Re: [Qemu-devel] [PATCH v5 00/30] riscv: sifive_u: Improve the
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Palmer Dabbelt <palmer@sifive.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 22, 2019 at 10:15 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> As of today, the QEMU 'sifive_u' machine is a special target that does
> not boot the upstream OpenSBI/U-Boot firmware images built for the real
> SiFive HiFive Unleashed board. Hence OpenSBI supports a special platform
> "qemu/sifive_u". For U-Boot, the sifive_fu540_defconfig is referenced
> in the OpenSBI doc as its payload, but that does not boot at all due
> to various issues in current QEMU 'sifive_u' machine codes.
>
> This series aims to improve the emulation fidelity of sifive_u machine,
> so that the upstream OpenSBI, U-Boot and kernel images built for the
> SiFive HiFive Unleashed board can be used out of the box without any
> special hack.
>
> The major changes include:
> - Heterogeneous harts creation supported, so that we can create a CPU
>   that exactly mirrors the real hardware: 1 E51 + 4 U54.
> - Implemented a PRCI model for FU540
> - Implemented an OTP model for FU540, primarily used for storing serial
>   number of the board
> - Fixed GEM support that was seriously broken on sifive_u
> - Synced device tree with upstream Linux kernel on sifive_u
>
> OpenSBI v0.4 image built for sifive/fu540 is included as the default
> bios image for 'sifive_u' machine.
>
> The series is tested against OpenSBI v0.4 image for sifive/fu540
> paltform, U-Boot v2019.10-rc1 image for sifive_fu540_defconfig,
> and Linux kernel v5.3-rc3 image with the following patch:
>
> macb: Update compatibility string for SiFive FU540-C000 [1]
>
> OpenSBI + U-Boot, ping/tftpboot with U-Boot MACB driver works well.
> Boot Linux 64-bit defconfig image, verified that system console on
> the serial 0 and ping host work pretty well.
>
> An OpenSBI patch [2] was sent to drop the special "qemu/sifive_u" platform
> support in OpenSBI. The original plan was to get the drop patch applied
> after this QEMU series is merged. However after discussion in the OpenSBI
> mailing list, it seems the best option for us is to let OpenSBI continue
> shipping the special "qemu/sifive_u" platform support to work with QEMU
> version <= 4.1 and deprecate the support sometime in the future. A patch
> will need to be sent to OpenSBI mailing list to update its document.
>
> v4 is now rebased on Palmer's QEMU RISC-V repo "for-master" branch.
> Dropped the following v3 patch that was already done by someone else.
> - riscv: sifive_u: Generate an aliases node in the device tree
> - riscv: sifive_u: Support loading initramfs
>
> The following v3 patch was dropped too due to a different cluster approach
> suggested by Richard Henderson is used in v4:
> - riscv: hart: Support heterogeneous harts population
>
> [1]: https://patchwork.kernel.org/patch/11050003/
> [2]: http://lists.infradead.org/pipermail/opensbi/2019-August/000335.html
>
> Changes in v5:
> - new patch to change to use qemu_log_mask(LOG_GUEST_ERROR,...) instead
>   in various sifive models
> - new patch to remove the unnecessary include of target/riscv/cpu.h
> - change to use defines instead of enums
> - change to use qemu_log_mask(LOG_GUEST_ERROR,...) in sifive_u_prci
> - creating a 32-bit val variable and using that instead of casting
>   everywhere in sifive_u_prci_write()
> - move all register initialization to sifive_u_prci_reset() function
> - drop sifive_u_prci_create()
> - s/codes that worked/code that works/g
> - create sifive_u_prci block directly in the machine codes, instead
>   of calling sifive_u_prci_create()
> - change to use defines instead of enums
> - change to use qemu_log_mask(LOG_GUEST_ERROR,...) in sifive_u_otp
> - creating a 32-bit val variable and using that instead of casting
>   everywhere in sifive_u_otp_write()
> - move all register initialization to sifive_u_otp_reset() function
> - drop sifive_u_otp_create()
> - create sifive_u_otp block directly in the machine codes, instead
>   of calling sifive_u_otp_create()
> - add the missing "local-mac-address" property in the ethernet node
>
> Changes in v4:
> - remove 2 more "linux,phandle" instances in sifive_u.c and spike.c
>   after rebasing on Palmer's QEMU RISC-V tree
> - change create_fdt() to return void in sifive_u.c too, after rebasing
>   on Palmer's QEMU RISC-V tree
> - new patch to remove executable attribute of opensbi images
> - prefix all macros/variables/functions with SIFIVE_E/sifive_e
>   in the sifive_e_prci driver
> - new patch to add a "hartid-base" property to RISC-V hart array
> - changed to create clusters for each cpu type
> - prefix all macros/variables/functions with SIFIVE_U/sifive_u
>   in the sifive_u_prci driver
> - prefix all macros/variables/functions with SIFIVE_U/sifive_u
>   in the sifive_u_otp driver
> - new patch to remove handcrafted clock nodes for UART and ethernet
>
> Changes in v3:
> - changed to use macros for management and compute cpu count
> - use management cpu count + 1 for the min_cpus
> - update IRQ numbers of both UARTs to match hardware as well
>
> Changes in v2:
> - keep the PLIC compatible string unchanged as OpenSBI uses that
>   for DT fix up
> - drop patch "riscv: sifive: Move sifive_mmio_emulate() to a common place"
> - new patch "riscv: sifive_e: Drop sifive_mmio_emulate()"
> - fixed the "interrupts-extended" property size
> - update the file header to indicate at least 2 harts are created
> - use create_unimplemented_device() to create the GEM management
>   block instead of sifive_mmio_emulate()
> - add "phy-handle" property to the ethernet node
>
> Bin Meng (30):
>   riscv: hw: Remove superfluous "linux,phandle" property
>   riscv: hw: Use qemu_fdt_setprop_cell() for property with only 1 cell
>   riscv: hw: Remove not needed PLIC properties in device tree
>   riscv: hw: Change create_fdt() to return void
>   riscv: hw: Change to use qemu_log_mask(LOG_GUEST_ERROR,...) instead
>   riscv: hw: Remove the unnecessary include of target/riscv/cpu.h
>   riscv: roms: Remove executable attribute of opensbi images
>   riscv: sifive_u: Remove the unnecessary include of prci header
>   riscv: sifive: Rename sifive_prci.{c,h} to sifive_e_prci.{c,h}
>   riscv: sifive_e: prci: Fix a typo of hfxosccfg register programming
>   riscv: sifive_e: prci: Update the PRCI register block size
>   riscv: sifive_e: Drop sifive_mmio_emulate()
>   riscv: Add a sifive_cpu.h to include both E and U cpu type defines
>   riscv: hart: Extract hart realize to a separate routine
>   riscv: hart: Add a "hartid-base" property to RISC-V hart array
>   riscv: sifive_u: Update hart configuration to reflect the real FU540
>     SoC
>   riscv: sifive_u: Set the minimum number of cpus to 2
>   riscv: sifive_u: Update PLIC hart topology configuration string
>   riscv: sifive: Implement PRCI model for FU540
>   riscv: sifive_u: Generate hfclk and rtcclk nodes
>   riscv: sifive_u: Add PRCI block to the SoC
>   riscv: sifive_u: Reference PRCI clocks in UART and ethernet nodes
>   riscv: sifive_u: Update UART base addresses and IRQs
>   riscv: sifive_u: Change UART node name in device tree
>   riscv: roms: Update default bios for sifive_u machine
>   riscv: sifive: Implement a model for SiFive FU540 OTP
>   riscv: sifive_u: Instantiate OTP memory with a serial number
>   riscv: sifive_u: Fix broken GEM support
>   riscv: sifive_u: Remove handcrafted clock nodes for UART and ethernet
>   riscv: sifive_u: Update model and compatible strings in device tree

I can't see patch 12 and it looks like it didn't make it to the list either:

https://patchew.org/QEMU/1566537069-22741-1-git-send-email-bmeng.cn@gmail.com/

Alistair

>
>  hw/riscv/Makefile.objs                       |   4 +-
>  hw/riscv/riscv_hart.c                        |  35 ++--
>  hw/riscv/sifive_e.c                          |  27 +--
>  hw/riscv/sifive_e_prci.c                     | 123 +++++++++++++
>  hw/riscv/sifive_prci.c                       | 123 -------------
>  hw/riscv/sifive_test.c                       |   6 +-
>  hw/riscv/sifive_u.c                          | 262 ++++++++++++++++++---------
>  hw/riscv/sifive_u_otp.c                      | 190 +++++++++++++++++++
>  hw/riscv/sifive_u_prci.c                     | 171 +++++++++++++++++
>  hw/riscv/sifive_uart.c                       |  10 +-
>  hw/riscv/spike.c                             |   1 -
>  hw/riscv/virt.c                              |  40 ++--
>  include/hw/riscv/riscv_hart.h                |   1 +
>  include/hw/riscv/sifive_cpu.h                |  31 ++++
>  include/hw/riscv/sifive_e.h                  |   7 +-
>  include/hw/riscv/sifive_e_prci.h             |  71 ++++++++
>  include/hw/riscv/sifive_prci.h               |  69 -------
>  include/hw/riscv/sifive_u.h                  |  31 ++--
>  include/hw/riscv/sifive_u_otp.h              |  80 ++++++++
>  include/hw/riscv/sifive_u_prci.h             |  91 ++++++++++
>  pc-bios/opensbi-riscv32-virt-fw_jump.bin     | Bin
>  pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin | Bin 40968 -> 45064 bytes
>  pc-bios/opensbi-riscv64-virt-fw_jump.bin     | Bin
>  roms/Makefile                                |   4 +-
>  24 files changed, 1018 insertions(+), 359 deletions(-)
>  create mode 100644 hw/riscv/sifive_e_prci.c
>  delete mode 100644 hw/riscv/sifive_prci.c
>  create mode 100644 hw/riscv/sifive_u_otp.c
>  create mode 100644 hw/riscv/sifive_u_prci.c
>  create mode 100644 include/hw/riscv/sifive_cpu.h
>  create mode 100644 include/hw/riscv/sifive_e_prci.h
>  delete mode 100644 include/hw/riscv/sifive_prci.h
>  create mode 100644 include/hw/riscv/sifive_u_otp.h
>  create mode 100644 include/hw/riscv/sifive_u_prci.h
>  mode change 100755 => 100644 pc-bios/opensbi-riscv32-virt-fw_jump.bin
>  mode change 100755 => 100644 pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin
>  mode change 100755 => 100644 pc-bios/opensbi-riscv64-virt-fw_jump.bin
>
> --
> 2.7.4
>
>

