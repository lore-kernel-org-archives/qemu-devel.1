Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 541FFC433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:38:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A2A123A75
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OcaVJ9+m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A2A123A75
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6yGW-0000kx-Du
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 11:38:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6yFm-0008JZ-Pw; Sat, 15 Aug 2020 11:37:54 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:37681)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6yFk-0005tX-Sq; Sat, 15 Aug 2020 11:37:54 -0400
Received: by mail-ej1-x644.google.com with SMTP id qc22so12988061ejb.4;
 Sat, 15 Aug 2020 08:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Jwn93nCLQsLbsAInELikNQ4EGWhPisDaP4ZotgmSLIg=;
 b=OcaVJ9+mYdIl28SvAmUiCpMkRDaImQSE6JjT4xiJU74LmynB7SL26JegQL5RLkbLl9
 oy5DrGge9n6tgdi2kmKMZYUNp6gK6oVuZV4T73yxeNUiRlqRqZ0yf/kzKzgGupWN4Dtd
 kdOqJfVri5S/kX7wnMeknDrPSvnQY2ynikgpBntnpTDWCj0TJD3koGZekIxWqRRfKq4o
 CMIFY35vK8VL1Yd7UagMVao5YITuu8HY9nOZv+VSM/5Kn15U62LFZiMdGs7SOTxzUwcE
 kDXn7p5M31hDvBJw+lC7Qhi+5j6VaIJm35cxedn7w4ut6wJSMGSMN5dw83FffashYYZj
 5pmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Jwn93nCLQsLbsAInELikNQ4EGWhPisDaP4ZotgmSLIg=;
 b=orWnVe0hUrpFYCkpjdBIwWoDeUNnwHG8JebQWtzaBRi6PcVelZ2SOxMzg4cmzNGfMU
 XVdlBObI+dyBLs/aUrPUVMM6w4KT2aJCJ7eJo0a+t1SeSryeq5kEtcF3pDohdZwuPA7F
 hvS2Ryozn6KAqtC15i4TYPutfRGbSZ+S/DNt/DCHHkDnUWY28elpZe9vjQazP1eDRFOf
 IL4+dLMFNcexwH+/lxgFwVC6LBlnN2zVTAeYlxSAy/PtwBKtdllbLdtUtolTtq3rSBSO
 9FWdd8uuhmKpECnmMTVVhAp/kmPhSqjOO+xkD/KTwa9gQY/9xsKoQiZUoT6BNJngXNVq
 /hAg==
X-Gm-Message-State: AOAM532Lpe7nKNoK5WClTmwEo6ykx56KtuVruI1PsF9AF5EJH1Obqs6V
 NFpTeQXXFYMb63S9U079hRIrot21t4c=
X-Google-Smtp-Source: ABdhPJwnsl/fKYYDbNR1ZyKmU5PpV1hI1qWjRNNP0haEoj0MFTAQ/+L/JdvbWCvnFOv3PwmSovKXuw==
X-Received: by 2002:adf:e94c:: with SMTP id m12mr6143615wrn.109.1597481752708; 
 Sat, 15 Aug 2020 01:55:52 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id m8sm20005051wro.75.2020.08.15.01.55.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Aug 2020 01:55:52 -0700 (PDT)
Subject: Re: [PATCH 11/18] hw/riscv: microchip_pfsoc: Connect a Cadence SDHCI
 controller and an SD card
To: Bin Meng <bmeng.cn@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <1597423256-14847-1-git-send-email-bmeng.cn@gmail.com>
 <1597423256-14847-12-git-send-email-bmeng.cn@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6d6ca0b5-0cff-e76b-46a9-9a69bf6b0099@amsat.org>
Date: Sat, 15 Aug 2020 10:55:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1597423256-14847-12-git-send-email-bmeng.cn@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Bin Meng <bin.meng@windriver.com>, Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/14/20 6:40 PM, Bin Meng wrote:
> From: Bin Meng <bin.meng@windriver.com>
> 
> Microchip PolarFire SoC integrates one Cadence SDHCI controller.
> On the Icicle Kit board, one eMMC chip and an external SD card
> connect to this controller depending on different configuration.
> 
> As QEMU does not support eMMC yet, we just emulate the SD card
> configuration. To test this, the Hart Software Services (HSS)
> should choose the SD card configuration:
> 
> $ cp boards/icicle-kit-es/def_config.sdcard .config
> $ make BOARD=icicle-kit-es
> 
> The SD card image can be built from the Yocto BSP at:
> https://github.com/polarfire-soc/meta-polarfire-soc-yocto-bsp
> 
> Note the generated SD card image should be resized before use:
> $ qemu-img resize /path/to/sdcard.img 4G
> 
> Launch QEMU with the following command:
> $ qemu-system-riscv64 -nographic -M microchip-icicle-kit -sd sdcard.img
> 
> Signed-off-by: Bin Meng <bin.meng@windriver.com>
> ---
> 
>  hw/riscv/Kconfig                   |  1 +
>  hw/riscv/microchip_pfsoc.c         | 26 ++++++++++++++++++++++++++
>  include/hw/riscv/microchip_pfsoc.h |  4 ++++
>  3 files changed, 31 insertions(+)
> 
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index ceb7c16..7412db9 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -55,3 +55,4 @@ config MICROCHIP_PFSOC
>      select SIFIVE
>      select UNIMP
>      select MCHP_PFSOC_MMUART
> +    select CADENCE_SDHCI
> diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
> index f6b375c..7c09078 100644
> --- a/hw/riscv/microchip_pfsoc.c
> +++ b/hw/riscv/microchip_pfsoc.c
> @@ -12,6 +12,7 @@
>   * 1) PLIC (Platform Level Interrupt Controller)
>   * 2) eNVM (Embedded Non-Volatile Memory)
>   * 3) MMUARTs (Multi-Mode UART)
> + * 4) Cadence eMMC/SDHC controller and an SD card connected to it
>   *
>   * This board currently generates devicetree dynamically that indicates at least
>   * two harts and up to five harts.
> @@ -75,6 +76,7 @@ static const struct MemmapEntry {
>      [MICROCHIP_PFSOC_MMUART0] =         { 0x20000000,     0x1000 },
>      [MICROCHIP_PFSOC_SYSREG] =          { 0x20002000,     0x2000 },
>      [MICROCHIP_PFSOC_MPUCFG] =          { 0x20005000,     0x1000 },
> +    [MICROCHIP_PFSOC_EMMC_SD] =         { 0x20008000,     0x1000 },
>      [MICROCHIP_PFSOC_MMUART1] =         { 0x20100000,     0x1000 },
>      [MICROCHIP_PFSOC_MMUART2] =         { 0x20102000,     0x1000 },
>      [MICROCHIP_PFSOC_MMUART3] =         { 0x20104000,     0x1000 },
> @@ -111,6 +113,11 @@ static void microchip_pfsoc_soc_instance_init(Object *obj)
>      qdev_prop_set_string(DEVICE(&s->u_cpus), "cpu-type",
>                           TYPE_RISCV_CPU_SIFIVE_U54);
>      qdev_prop_set_uint64(DEVICE(&s->u_cpus), "resetvec", RESET_VECTOR);
> +
> +    object_initialize_child(obj, "sd-controller", &s->sdhci,
> +                            TYPE_CADENCE_SDHCI);
> +    object_initialize_child(OBJECT(&s->sdhci), "sd-controller.sdhci",
> +                            &s->sdhci.slot, TYPE_SYSBUS_SDHCI);

OK now I see this patch, so NAck. TYPE_SYSBUS_SDHCI has to be
initialized in TYPE_CADENCE_SDHCI, not in all TYPE_CADENCE_SDHCI
users.

>  }
>  
>  static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
> @@ -223,6 +230,13 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
>          memmap[MICROCHIP_PFSOC_MPUCFG].base,
>          memmap[MICROCHIP_PFSOC_MPUCFG].size);
>  
> +    /* SDHCI */

Consider setting the SDHCI DMA MR here.

> +    sysbus_realize(SYS_BUS_DEVICE(&s->sdhci), errp);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->sdhci), 0,
> +                    memmap[MICROCHIP_PFSOC_EMMC_SD].base);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->sdhci.slot), 0,
> +        qdev_get_gpio_in(DEVICE(s->plic), MICROCHIP_PFSOC_EMMC_SD_IRQ));
> +
>      /* MMUARTs */
>      s->serial0 = mchp_pfsoc_mmuart_create(system_memory,
>          memmap[MICROCHIP_PFSOC_MMUART0].base,
> @@ -290,6 +304,7 @@ static void microchip_icicle_kit_machine_init(MachineState *machine)
>      MicrochipIcicleKitState *s = MICROCHIP_ICICLE_KIT_MACHINE(machine);
>      MemoryRegion *system_memory = get_system_memory();
>      MemoryRegion *main_mem = g_new(MemoryRegion, 1);
> +    DriveInfo *dinfo = drive_get_next(IF_SD);
>  
>      /* Sanity check on RAM size */
>      if (machine->ram_size < mc->default_ram_size) {
> @@ -312,6 +327,17 @@ static void microchip_icicle_kit_machine_init(MachineState *machine)
>  
>      /* Load the firmware */
>      riscv_find_and_load_firmware(machine, BIOS_FILENAME, RESET_VECTOR, NULL);
> +
> +    /* Attach an SD card */
> +    if (dinfo) {
> +        SDHCIState *sdhci = &(s->soc.sdhci.slot);

NAck again, you are not supposed to access this field here.
This is why in the previous patch I asked why the "sd-bus" property
was not propagated from child to parent.

Thanks,

Phil.

> +        DeviceState *card = qdev_new(TYPE_SD_CARD);
> +        BusState *bus = qdev_get_child_bus(DEVICE(sdhci), "sd-bus");
> +
> +        qdev_prop_set_drive_err(card, "drive", blk_by_legacy_dinfo(dinfo),
> +                                &error_fatal);
> +        qdev_realize_and_unref(card, bus, &error_fatal);
> +    }
>  }
>  
>  static void microchip_icicle_kit_machine_class_init(ObjectClass *oc, void *data)
> diff --git a/include/hw/riscv/microchip_pfsoc.h b/include/hw/riscv/microchip_pfsoc.h
> index a5efa1d..d810ee8 100644
> --- a/include/hw/riscv/microchip_pfsoc.h
> +++ b/include/hw/riscv/microchip_pfsoc.h
> @@ -23,6 +23,7 @@
>  #define HW_MICROCHIP_PFSOC_H
>  
>  #include "hw/char/mchp_pfsoc_mmuart.h"
> +#include "hw/sd/cadence_sdhci.h"
>  
>  typedef struct MicrochipPFSoCState {
>      /*< private >*/
> @@ -39,6 +40,7 @@ typedef struct MicrochipPFSoCState {
>      MchpPfSoCMMUartState *serial2;
>      MchpPfSoCMMUartState *serial3;
>      MchpPfSoCMMUartState *serial4;
> +    CadenceSDHCIState sdhci;
>  } MicrochipPFSoCState;
>  
>  #define TYPE_MICROCHIP_PFSOC    "microchip.pfsoc"
> @@ -74,6 +76,7 @@ enum {
>      MICROCHIP_PFSOC_MMUART0,
>      MICROCHIP_PFSOC_SYSREG,
>      MICROCHIP_PFSOC_MPUCFG,
> +    MICROCHIP_PFSOC_EMMC_SD,
>      MICROCHIP_PFSOC_MMUART1,
>      MICROCHIP_PFSOC_MMUART2,
>      MICROCHIP_PFSOC_MMUART3,
> @@ -85,6 +88,7 @@ enum {
>  };
>  
>  enum {
> +    MICROCHIP_PFSOC_EMMC_SD_IRQ = 88,
>      MICROCHIP_PFSOC_MMUART0_IRQ = 90,
>      MICROCHIP_PFSOC_MMUART1_IRQ = 91,
>      MICROCHIP_PFSOC_MMUART2_IRQ = 92,
> 


