Return-Path: <SRS0=e36u=CI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB863C433E6
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 12:57:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A20C2087D
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 12:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nuviainc-com.20150623.gappssmtp.com header.i=@nuviainc-com.20150623.gappssmtp.com header.b="taNMwxjm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A20C2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nuviainc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCMu6-0002rU-Q1
	for qemu-devel@archiver.kernel.org; Sun, 30 Aug 2020 08:57:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leif@nuviainc.com>) id 1kCMtU-0002Jn-KY
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 08:57:12 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33765)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <leif@nuviainc.com>) id 1kCMtP-0006y8-KQ
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 08:57:12 -0400
Received: by mail-wr1-x441.google.com with SMTP id m6so1127628wrn.0
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2020 05:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuviainc-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=FEux0AcCgP87lXx7X1i6s3a4CVMm2xXY57zH36YWp5k=;
 b=taNMwxjmK8W0VmfodqHKSlIp9WSNF70LothEWAucWiszmy7oJPiNe+pBRvmV9R91m7
 z1LJOZgll3DrlI2azXzWwq/+5YhFv/XsCkM5T7FLWNaWT75TMARN4c0ZX14Y6MCLrzyZ
 nvHi3zQt3gqaO97M9DWKIZeyQ6YOJdc5Nm/jJr/cDgd711G5xMdfR7UPe4+I2DoXhN0A
 oan+ZHXn1ThLYQRjf2aidBze3IsGD0QQGjE9H5DN1+eBTu9KXqtlIiNnakouCVCodqN0
 Zj1vJcARyccK7hQd7AffmcCKoUh/khzYcshmKnPzcfgIgVPpBOYswmyKyy1Xhmnv4wTX
 +ZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=FEux0AcCgP87lXx7X1i6s3a4CVMm2xXY57zH36YWp5k=;
 b=Dp5uaH2kzHnq74MiQfooXZUpHaWeGep8qa391SAq1H1PC7I9R6MR9nCI7191khb6wM
 ItSTP2CwG3mFxtE6gMlU8GKXOKO7fXmOmhTYNdamdwd0NN8VU131YPA1szWzYtAzBRNA
 Q/E8oHj5nkjjhN51QwkOuS/groysCGRL/xWR4dh3eb5I7xs6R3G+n/tR83jHugQfBWaa
 hO5Mb2y2QxoVeULfb6WNa7J5y4hKCo+i+uKgZjuYXaNIUry7Fj+5BvZ3XR4mMt1f7SAz
 jD+eROQlX4OnHyCX0YmBTgh1IDc6hd+KpFOGTL3TuOqclYDZB3hiNGEcu8obZ5QcXGUS
 8mDQ==
X-Gm-Message-State: AOAM532d1EjbMIdT04868KnNzCy4/lDmH2CEdUFHXLa3UT8PBAK1j20L
 dcQvigR7a/gmJ057P82obbgQ9w==
X-Google-Smtp-Source: ABdhPJwIXnhGTYpke5At/FMXYEsd2iUZOa+78M8ns/bLcQn68B0b8fepuu6YlElWodVciNP91OG74g==
X-Received: by 2002:adf:9125:: with SMTP id j34mr8099715wrj.157.1598792222766; 
 Sun, 30 Aug 2020 05:57:02 -0700 (PDT)
Received: from vanye ([2001:470:1f09:12f0:b26e:bfff:fea9:f1b8])
 by smtp.gmail.com with ESMTPSA id n124sm6933378wmn.29.2020.08.30.05.57.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2020 05:57:02 -0700 (PDT)
Date: Sun, 30 Aug 2020 13:56:59 +0100
From: Leif Lindholm <leif@nuviainc.com>
To: Bin Meng <bmeng.cn@gmail.com>
Subject: Re: [PATCH v2 00/16] hw/riscv: Add Microchip PolarFire SoC Icicle
 Kit board support
Message-ID: <20200830125659.GD20124@vanye>
References: <1598714261-8320-1-git-send-email-bmeng.cn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1598714261-8320-1-git-send-email-bmeng.cn@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=leif@nuviainc.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Alistair Francis <alistair@alistair23.me>, qemu-riscv@nongnu.org,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, Bin Meng <bin.meng@windriver.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Jason Wang <jasowang@redhat.com>, Palmer Dabbelt <palmerdabbelt@google.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Bin,

On Sat, Aug 29, 2020 at 23:17:24 +0800, Bin Meng wrote:
> From: Bin Meng <bin.meng@windriver.com>
> 
> This adds support for Microchip PolarFire SoC Icicle Kit board.
> The Icicle Kit board integrates a PolarFire SoC, with one SiFive's
> E51 plus four U54 cores and many on-chip peripherals and an FPGA.
> 
> For more details about Microchip PolarFire SoC, please see:
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
> - SiFive PDMA
> - Cadence eMMC/SDHCI controller
> - Cadence Gigabit Ethernet MAC
> 
> The BIOS image used by this machine is hss.bin, aka Hart Software
> Services, which can be built from:
> https://github.com/polarfire-soc/hart-software-services

Are there any version requirements, or additional qemu patches, that
need to be taken into account. Should I expect to see output on stdio?

I tried to build hss 3faaaaf8ce0d, using
https://github.com/riscv/riscv-gnu-toolchain (7f1f4ab5b0e0), which
ends up being a gcc 10.1. That caused me to raise
https://github.com/polarfire-soc/hart-software-services/issues/2.

Suppressing that warning gets me a hss.bin, but neither that, nor one
I build with Debian's 8.3 riscv64-linux-gnu- produces any output when
I apply this set on top of 39335fab59. (Even when I change the wait to
nowait.)

/
    Leif

> To launch this machine:
> $ qemu-system-riscv64 -M microchip-icicle-kit -smp 5 \
>     -bios path/to/hss.bin -sd path/to/sdcard.img \
>     -nic tap,ifname=tap,script=no,model=cadence_gem \
>     -display none -serial stdio \
>     -chardev socket,id=serial1,path=serial1.sock,server,wait \
>     -serial chardev:serial1
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
> Please check the QEMU WiKi page for the target specific information:
> https://wiki.qemu.org/Documentation/Platforms/RISCV#Microchip_PolarFire_SoC_Icicle_Kit
> 
> Changes in v2:
> - change to update hw/char/meson.build
> - add impl.min_access_size and impl.max_access_size as part of
>   MemoryRegionOps and remove the allignment check
> - change to update hw/sd/meson.build
> - change the name to "generic-sdhci" when calling object_initialize_child()
> - add a container MR to simplify out-of-bounds access checks
> - do not initialize TYPE_SYSBUS_SDHCI in the SoC instance_init(),
>   instead move that to the cadence_sdhci model
> - do not access generic-sdhci's state directly,
>   instead move that to the cadence_sdhci model
> - change to update hw/dma/meson.build
> - rename the file names to sifive_pdma.[c|h]
> - update irq number to 8 per the SiFive FU540 manual
> - fix the register offset for channel 1/2/3 in the read/write ops
> - connect 8 IRQs to the PLIC
> - change "phy-addr" default value to BOARD_PHY_ADDRESS
> 
> Bin Meng (16):
>   target/riscv: cpu: Add a new 'resetvec' property
>   hw/riscv: hart: Add a new 'resetvec' property
>   target/riscv: cpu: Set reset vector based on the configured property
>     value
>   hw/riscv: Initial support for Microchip PolarFire SoC Icicle Kit board
>   hw/char: Add Microchip PolarFire SoC MMUART emulation
>   hw/riscv: microchip_pfsoc: Connect 5 MMUARTs
>   hw/sd: Add Cadence SDHCI emulation
>   hw/riscv: microchip_pfsoc: Connect a Cadence SDHCI controller and an
>     SD card
>   hw/dma: Add SiFive platform DMA controller emulation
>   hw/riscv: microchip_pfsoc: Connect a DMA controller
>   hw/net: cadence_gem: Add a new 'phy-addr' property
>   hw/arm: xlnx: Set all boards' GEM 'phy-addr' property value to 23
>   hw/riscv: microchip_pfsoc: Connect 2 Cadence GEMs
>   hw/riscv: microchip_pfsoc: Hook GPIO controllers
>   hw/riscv: clint: Avoid using hard-coded timebase frequency
>   hw/riscv: sifive_u: Connect a DMA controller
> 
>  default-configs/riscv64-softmmu.mak |   1 +
>  include/hw/char/mchp_pfsoc_mmuart.h |  61 +++++
>  include/hw/dma/sifive_pdma.h        |  57 +++++
>  include/hw/net/cadence_gem.h        |   2 +
>  include/hw/riscv/microchip_pfsoc.h  | 133 +++++++++++
>  include/hw/riscv/riscv_hart.h       |   1 +
>  include/hw/riscv/sifive_clint.h     |   4 +-
>  include/hw/riscv/sifive_u.h         |  11 +
>  include/hw/sd/cadence_sdhci.h       |  47 ++++
>  target/riscv/cpu.h                  |   7 +-
>  hw/arm/xilinx_zynq.c                |   1 +
>  hw/arm/xlnx-versal.c                |   1 +
>  hw/arm/xlnx-zynqmp.c                |   1 +
>  hw/char/mchp_pfsoc_mmuart.c         |  86 +++++++
>  hw/dma/sifive_pdma.c                | 313 ++++++++++++++++++++++++++
>  hw/net/cadence_gem.c                |   7 +-
>  hw/riscv/microchip_pfsoc.c          | 437 ++++++++++++++++++++++++++++++++++++
>  hw/riscv/opentitan.c                |   1 +
>  hw/riscv/riscv_hart.c               |   3 +
>  hw/riscv/sifive_clint.c             |  26 ++-
>  hw/riscv/sifive_e.c                 |   4 +-
>  hw/riscv/sifive_u.c                 |  35 ++-
>  hw/riscv/spike.c                    |   3 +-
>  hw/riscv/virt.c                     |   3 +-
>  hw/sd/cadence_sdhci.c               | 193 ++++++++++++++++
>  target/riscv/cpu.c                  |   8 +-
>  target/riscv/cpu_helper.c           |   4 +-
>  target/riscv/csr.c                  |   4 +-
>  MAINTAINERS                         |   9 +
>  hw/char/Kconfig                     |   3 +
>  hw/char/meson.build                 |   1 +
>  hw/dma/Kconfig                      |   3 +
>  hw/dma/meson.build                  |   1 +
>  hw/riscv/Kconfig                    |  10 +
>  hw/riscv/meson.build                |   1 +
>  hw/sd/Kconfig                       |   4 +
>  hw/sd/meson.build                   |   1 +
>  37 files changed, 1458 insertions(+), 29 deletions(-)
>  create mode 100644 include/hw/char/mchp_pfsoc_mmuart.h
>  create mode 100644 include/hw/dma/sifive_pdma.h
>  create mode 100644 include/hw/riscv/microchip_pfsoc.h
>  create mode 100644 include/hw/sd/cadence_sdhci.h
>  create mode 100644 hw/char/mchp_pfsoc_mmuart.c
>  create mode 100644 hw/dma/sifive_pdma.c
>  create mode 100644 hw/riscv/microchip_pfsoc.c
>  create mode 100644 hw/sd/cadence_sdhci.c
> 
> -- 
> 2.7.4
> 
> 

