Return-Path: <SRS0=M8gQ=CP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D74C43461
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2020 01:09:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1D402078D
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2020 01:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nuviainc-com.20150623.gappssmtp.com header.i=@nuviainc-com.20150623.gappssmtp.com header.b="WD0FM9dc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1D402078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nuviainc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEjBT-0000Uu-Ki
	for qemu-devel@archiver.kernel.org; Sat, 05 Sep 2020 21:09:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leif@nuviainc.com>) id 1kEjAU-0008KJ-56
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 21:08:30 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55618)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <leif@nuviainc.com>) id 1kEjAM-000500-A9
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 21:08:29 -0400
Received: by mail-wm1-x341.google.com with SMTP id a65so9946315wme.5
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2020 18:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuviainc-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=uNRqwkv8hT3eCpKnBnomPKbDQRB6vtwjP0a/+dQsLns=;
 b=WD0FM9dcybQ8PnYxP8TGa/02MVbknHObn8wkUrC/dqD+gk8Ggruw81/bXJ03tMmJim
 1H9Q9NifB0tPw4G45vaWL+H6xMNqinkUYvKbIDXokoveahsK6g3UllA61T5AN+D6BuQb
 dGj9+X3BkMxZFp2rEWLIqrDNbVlZJm5ShAgl4raRvM0jsV+E90Wf8o2bG5dIYYp5hud9
 deFeeaiknosopOCxWepEY15nW9kuH7zbzw+p8GSo/diHq4RtXG3DahilhA306zYp/CY2
 To8LM9VUpaTTI+4bwcYNIBESIU+MuNzcPusKAxAQiDLFdchdcdKSuGyOxak9Y3zzbPYK
 9cew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=uNRqwkv8hT3eCpKnBnomPKbDQRB6vtwjP0a/+dQsLns=;
 b=LGksDWm+8DLytIeFpqTxCdAKQ2tu/C7ZMgxlDftFCdtE2JBXazQBhqwxAWqT1sqGhu
 aCNyz0iHxwvO9aGGteckTOPGZH7D6C/d52/E1yzuks0ewdcKk77VxVoNfNw50TQTLix+
 5prEM2NyJzCF6okw2BKXtEU+rltzKakPx0BQ+cz1i+uupHQBaQVlcW0X1op+MfrzV7Xf
 Kgi6TkwlyGnhiPqcCCVXdGtMBtcJVnaPjRsDXH/zWQzpctYbsl4soj5JZDXbBORBPNRP
 AQLNoyAC84tcu2n10MNiU1N3CoxLvOilednXkNfTSNdhPwemRAZ78zgMgts6NacBicP8
 9HBQ==
X-Gm-Message-State: AOAM533Jxfko2+6hi7AafNXBhW0wyQbvfLrYGsNROiLNBKgljB0pGkt1
 89ebvOuP2ccoaw3wC2hnpkAOJg==
X-Google-Smtp-Source: ABdhPJyYdb7fiuzogvMmX0bOmniZPhikXlC2qoiZfcgBQutD2xrMk5nBPrvL3I8YTQW0+h5bWRnhWw==
X-Received: by 2002:a1c:9a57:: with SMTP id c84mr13894906wme.136.1599354500402; 
 Sat, 05 Sep 2020 18:08:20 -0700 (PDT)
Received: from vanye ([2001:470:1f09:12f0:7853:73ff:fecf:b3e3])
 by smtp.gmail.com with ESMTPSA id v3sm19452423wmh.6.2020.09.05.18.08.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2020 18:08:19 -0700 (PDT)
Date: Sun, 6 Sep 2020 02:08:11 +0100
From: Leif Lindholm <leif@nuviainc.com>
To: Bin Meng <bmeng.cn@gmail.com>
Subject: Re: [PATCH v3 00/16] hw/riscv: Add Microchip PolarFire SoC Icicle
 Kit board support
Message-ID: <20200906010811.GA1546@vanye>
References: <1598924352-89526-1-git-send-email-bmeng.cn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1598924352-89526-1-git-send-email-bmeng.cn@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=leif@nuviainc.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Sep 01, 2020 at 09:38:55 +0800, Bin Meng wrote:
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
> 
> To launch this machine:
> $ qemu-system-riscv64 -M microchip-icicle-kit -smp 5 \
>     -bios path/to/hss.bin -sd path/to/sdcard.img \
>     -nic tap,ifname=tap,script=no,model=cadence_gem \
>     -display none -serial stdio \
>     -chardev socket,id=serial1,path=serial1.sock,server,wait \
>     -serial chardev:serial1

I finally got around to building the sd image from
https://github.com/polarfire-soc/polarfire-soc-buildroot-sdk,
and I can successfully boot to prompt using that, and the (hacked)
hss.bin I verified previously - also with this v3.

However, unless I add the "-nic user,model=cadence_gem \" shown in
https://wiki.qemu.org/Documentation/Platforms/RISCV#Microchip_PolarFire_SoC_Icicle_Kit
but not here, I do not have functioning networking. (It is not obvious
to me why this is needed.)

> The memory is set to 1 GiB by default to match the hardware.

Which hardware is this?
https://www.crowdsupply.com/microchip/polarfire-soc-icicle-kit lists
2GiB.

> A sanity check on ram size is performed in the machine init routine
> to prompt user to increase the RAM size to > 1 GiB when less than
> 1 GiB ram is detected.

There is currently no visible effect in firmware from setting memory size to >
1GiB (hss says 1GB, u-boot says 1GB, Linux sees 1GB).
Are there any plans to address this in future versions?

Best Regards,

Leif

> HSS output is on the first serial port (stdio) and U-Boot/Linux
> outputs on the 2nd serial port. OpenSBI outputs on a random serial
> port due to the lottery mechanism used during the multi-core boot.
> 
> Please check the QEMU WiKi page for the target specific information:
> https://wiki.qemu.org/Documentation/Platforms/RISCV#Microchip_PolarFire_SoC_Icicle_Kit
> 
> Changes in v3:
> - rebase on qemu/master
> - change MCHP_PFSOC_DMA to SIFIVE_PDMA
> - use the correct (Object *) to set the 'phy-addr' in xlnx-zynqmp.c
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
>  hw/arm/xlnx-zynqmp.c                |   2 +
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
>  37 files changed, 1459 insertions(+), 29 deletions(-)
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

