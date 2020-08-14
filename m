Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C91C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 17:45:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0A6D20774
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 17:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="FYt3HFrs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0A6D20774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6dm6-0005YS-4w
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 13:45:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33168)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anup@brainfault.org>)
 id 1k6dlI-0004yF-EE
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 13:45:04 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:52979)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anup@brainfault.org>)
 id 1k6dlE-0001qj-QP
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 13:45:04 -0400
Received: by mail-wm1-x342.google.com with SMTP id x5so8135790wmi.2
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 10:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brainfault-org.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=f9+aDzu9oUPppk6ZVStJuzR6QVDfjB+EhDX+IpalXOs=;
 b=FYt3HFrsFG9PWomUJNDrZFrzieZJARi79Ear4EAYooGo7cd6MCxgGRuRoXl4Vs8i/q
 2ZEJjpf4oVw2WjhzoaruFSIqcylfD/mVdWn09w1h0Pe81pOF532m9xDoDXoJCXk5snv5
 2AdA+TX685ProI7R5U8iPl8qG6lBqtvbWRA8wRROLcUfzVdqvtkhgh9QLigzIbKmVPNa
 CV+gQ3jFseHw410lsLRQO1kKKIfsqe3j/0NmZYH1I1tFpFRVEZMPXbRaB0XIZv/LwVqI
 GeQF8PCi6cg/nTaM8TAYKRUL38a6GFyxD60KtcJdzCCobPsUP4Wfp8dY1oSOtQcukwz+
 P7mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=f9+aDzu9oUPppk6ZVStJuzR6QVDfjB+EhDX+IpalXOs=;
 b=P17ob9ZZ9QpYwbsr7MkyZHw1QcYrKfiD2EC0MyoQtnwpwibwBJaMpY/F8cOi8CJ4YE
 as9UJjCJEupMRYZFzOzba2DVktvwRy5biXGIDAY9zW0iJcrFcK5x+nJDJnRlyBKNWS8+
 JR27UA26D0he7BwXtxw2hYb/cfFsYx2tL5sPN9RZX3Q0JihQFf4aexf/UY3RmMFCov/Z
 9DUsIV4bG0oDQSsenxqIcfuFTy2EVvLg5ecPPqGI7vGIMP7IuP6vozQ4gS4vGme6CaEg
 NbpKv7OqS+CJs0cnSVexuAOU8m0hEjROvuVOGuyrBEK7E8QTM218KS/mLRe0H8Dv283H
 lxAA==
X-Gm-Message-State: AOAM532g2RLMH+mZTwKt5XngRl8lBjDK8A6AcC0TlaSus+vm9K7/2lt0
 j3LwHyrPtNF+gUzsbgIvHk2ywwI68eiFZ+AY/9/2cg==
X-Google-Smtp-Source: ABdhPJxrO5xkBAOSpO2oWrXPXSzq1oNb4b9bLjr+EazJKxVWmP8Q9D1U3UL3XkAfmy3tkMfJbIvWAnlCj+jqo+fMW9c=
X-Received: by 2002:a1c:6689:: with SMTP id a131mr3318205wmc.157.1597427098082; 
 Fri, 14 Aug 2020 10:44:58 -0700 (PDT)
MIME-Version: 1.0
References: <1597423256-14847-1-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1597423256-14847-1-git-send-email-bmeng.cn@gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 14 Aug 2020 23:14:46 +0530
Message-ID: <CAAhSdy2D=TcENAJDja4r6pnhz0LRi-T+A9k3Btrs_EuB4x0e4w@mail.gmail.com>
Subject: Re: [PATCH 00/18] hw/riscv: Add Microchip PolarFire SoC Icicle Kit
 board support
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: none client-ip=2a00:1450:4864:20::342;
 envelope-from=anup@brainfault.org; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>, qemu-block@nongnu.org,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, Bin Meng <bin.meng@windriver.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Jason Wang <jasowang@redhat.com>, Palmer Dabbelt <palmerdabbelt@google.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 14, 2020 at 10:12 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> From: Bin Meng <bin.meng@windriver.com>
>
> This adds support for Microchip PolarFire SoC Icicle Kit board.
> The Icicle Kit board integrates a PolarFire SoC, with one SiFive's
> E51 plus four U54 cores and many on-chip peripherals and an FPGA.

Nice Work !!! This is very helpful.

>
> For more details about Microchip PolarFire Soc, please see:
> https://www.microsemi.com/product-directory/soc-fpgas/5498-polarfire-soc-fpga
>
> The Icicle Kit board information can be found here:
> https://www.microsemi.com/existing-parts/parts/152514
>
> Unlike SiFive FU540, the RISC-V core resect vector is at 0x20220000.
> The RISC-V CPU and HART codes has been updated to set the core's
> reset vector based on a configurable property from machine codes.
>
> The following perepherals are created as an unimplemented device:
>
> - Bus Error Uint 0/1/2/3/4
> - L2 cache controller
> - SYSREG
> - MPUCFG
> - IOSCBCFG
> - GPIO
>
> The following perepherals are emulated:
> - SiFive CLINT
> - SiFive PLIC
> - PolarFire SoC Multi-Mode UART
> - PolarFire SoC DMA
> - Cadence eMMC/SDHCI controller
> - Cadence Gigabit Ethernet MAC
>
> Some bugs in the SD card codes are fixed during the development.
>
> The BIOS image used by this machine is hss.bin, aka Hart Software
> Services, which can be built from:
> https://github.com/polarfire-soc/hart-software-services
>
> To launch this machine:
> $ qemu-system-riscv64 -M microchip-icicle-kit -smp 5 \
>     -bios path/to/hss.bin -sd path/to/sdcard.img \
>     -nic tap,ifname=tap,script=no,model=cadence_gem \
>     -display none -serial stdio \
>     -chardev socket,id=serial1,path=serial1.sock,server,wait \
>     -serial chardev:serial1

Currently, it is fine to use HSS (with OpenSBI v0.6 as a library) but
this is not aligned with the existing booting flow of many RISC-V
systems.

It will be nice to have standard U-Boot RISC-V boot-flow working
on Microchip PolarFire SoC:
U-Boot SPL (BIOS) => FW_DYNAMIC (Generic) => U-Boot S-mode

The Microchip HSS is quite convoluted. It has:
1. DDR Init
2. Boot device support
3. SBI support using OpenSBI as library
4. Simple TEE support

I think point 1) and 2) above should be part of U-Boot SPL.
The point 3) can be OpenSBI FW_DYNAMIC.

Lastly,for point 4), we are working on a new OpenSBI feature using
which we can run independent Secure OS and Non-Secure OS using
U-Boot_SPL+OpenSBI (for both SiFive Unleashed and Microchip
PolarFire).

Do you have plans for adding U-Boot SPL support for this board ??

Regards,
Anup

>
> The memory is set to 1 GiB by default to match the hardware.
> A sanity check on ram size is performed in the machine init routine
> to prompt user to increase the RAM size to > 1 GiB when less than
> 1 GiB ram is detected.
>
> HSS output is on the first serial port (stdio) and U-Boot/Linux
> outputs on the 2nd serial port. OpenSBI outputs on a random serial
> port due to the lottery mechanism used during the multi-core boot.
>
>
> Bin Meng (18):
>   target/riscv: cpu: Add a new 'resetvec' property
>   hw/riscv: hart: Add a new 'resetvec' property
>   target/riscv: cpu: Set reset vector based on the configured property
>     value
>   hw/riscv: Initial support for Microchip PolarFire SoC Icicle Kit board
>   hw/char: Add Microchip PolarFire SoC MMUART emulation
>   hw/riscv: microchip_pfsoc: Connect 5 MMUARTs
>   hw/sd: sd: Fix incorrect populated function switch status data
>     structure
>   hw/sd: sd: Correctly set the high capacity bit
>   hw/sd: sdhci: Make sdhci_poweron_reset() internal visible
>   hw/sd: Add Cadence SDHCI emulation
>   hw/riscv: microchip_pfsoc: Connect a Cadence SDHCI controller and an
>     SD card
>   hw/dma: Add Microchip PolarFire Soc DMA controller emulation
>   hw/riscv: microchip_pfsoc: Connect a DMA controller
>   hw/net: cadence_gem: Add a new 'phy-addr' property
>   hw/riscv: microchip_pfsoc: Connect 2 Cadence GEMs
>   hw/riscv: microchip_pfsoc: Hook GPIO controllers
>   hw/riscv: clint: Avoid using hard-coded timebase frequency
>   hw/riscv: microchip_pfsoc: Document the software used for testing
>
>  MAINTAINERS                         |  11 +
>  default-configs/riscv64-softmmu.mak |   1 +
>  hw/char/Kconfig                     |   3 +
>  hw/char/Makefile.objs               |   1 +
>  hw/char/mchp_pfsoc_mmuart.c         |  82 +++++++
>  hw/dma/Kconfig                      |   3 +
>  hw/dma/Makefile.objs                |   1 +
>  hw/dma/mchp_pfsoc_dma.c             | 322 +++++++++++++++++++++++++
>  hw/net/cadence_gem.c                |   7 +-
>  hw/riscv/Kconfig                    |   9 +
>  hw/riscv/Makefile.objs              |   1 +
>  hw/riscv/microchip_pfsoc.c          | 456 ++++++++++++++++++++++++++++++++++++
>  hw/riscv/opentitan.c                |   1 +
>  hw/riscv/riscv_hart.c               |   3 +
>  hw/riscv/sifive_clint.c             |  25 +-
>  hw/riscv/sifive_e.c                 |   4 +-
>  hw/riscv/sifive_u.c                 |   5 +-
>  hw/riscv/spike.c                    |   2 +-
>  hw/riscv/virt.c                     |   3 +-
>  hw/sd/Kconfig                       |   4 +
>  hw/sd/Makefile.objs                 |   1 +
>  hw/sd/cadence_sdhci.c               | 162 +++++++++++++
>  hw/sd/sd.c                          |   8 +-
>  hw/sd/sdhci-internal.h              |   1 +
>  hw/sd/sdhci.c                       |   2 +-
>  include/hw/char/mchp_pfsoc_mmuart.h |  61 +++++
>  include/hw/dma/mchp_pfsoc_dma.h     |  57 +++++
>  include/hw/net/cadence_gem.h        |   2 +
>  include/hw/riscv/microchip_pfsoc.h  | 125 ++++++++++
>  include/hw/riscv/riscv_hart.h       |   1 +
>  include/hw/riscv/sifive_clint.h     |   3 +-
>  include/hw/sd/cadence_sdhci.h       |  65 +++++
>  target/riscv/cpu.c                  |   8 +-
>  target/riscv/cpu.h                  |   7 +-
>  target/riscv/cpu_helper.c           |   4 +-
>  target/riscv/csr.c                  |   4 +-
>  36 files changed, 1424 insertions(+), 31 deletions(-)
>  create mode 100644 hw/char/mchp_pfsoc_mmuart.c
>  create mode 100644 hw/dma/mchp_pfsoc_dma.c
>  create mode 100644 hw/riscv/microchip_pfsoc.c
>  create mode 100644 hw/sd/cadence_sdhci.c
>  create mode 100644 include/hw/char/mchp_pfsoc_mmuart.h
>  create mode 100644 include/hw/dma/mchp_pfsoc_dma.h
>  create mode 100644 include/hw/riscv/microchip_pfsoc.h
>  create mode 100644 include/hw/sd/cadence_sdhci.h
>
> --
> 2.7.4
>
>

