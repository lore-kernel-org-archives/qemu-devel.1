Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04BCDC43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 19:21:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AFED20797
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 19:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rfrGbaq/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AFED20797
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEHGr-00049P-Ik
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 15:21:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kEHFb-0002sh-Bw; Fri, 04 Sep 2020 15:19:55 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:36227)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kEHFZ-0002C4-88; Fri, 04 Sep 2020 15:19:54 -0400
Received: by mail-io1-xd43.google.com with SMTP id d190so8273859iof.3;
 Fri, 04 Sep 2020 12:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pP7iO7ntIZfxVbioWU2+lnG7XSvtKjf3vslR62sBxmc=;
 b=rfrGbaq/pJ8jtjqA/4GH1kZIZ5miAJykW3dQepohrLV9VDRS3w9sCjtq5syf2iV5zO
 gR0pWEiD3SVLGvU95FoXoZMrjQgnPv/B39Sgb3LhioEspp/8mipXfMjhN2NzZvunG7JC
 QHT8nyXR1IlHNxI3mje3myNZonJwaMeZPNIg8yV1UpWxPAld/+NQyhT40xm+UqIO6p/+
 MN+UXuSCgQOnIbXx5LbCqne4wqNpcR82qt9SmEPhiUft6fW6hjq/vCLpZmypxWHZAFkY
 RMotyvtRrJJIcwQbmr8vGUqiXJP8m/85HpNOqy5tFm0wZrnYBmXk/ym7HMo1dZJZaLLP
 5keA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pP7iO7ntIZfxVbioWU2+lnG7XSvtKjf3vslR62sBxmc=;
 b=VL0I+AKBYTsfOTAHsS7W45cNU3QKDWuCfrXgk15dCe9Pxiwyf0T5oajcgaWx/WIEt/
 GCZ8rAda/my0eeDL4/ZCBRiBt5bx6NKjVJyEiJ5hNlMr2Wy33Nzc1Z40JN7qcvOs96HQ
 KPco/8mCboukwim5Ip2r+xdYF/BuJkcq/7uXk/fJqeG9HkWCF2ElFqvrqpb5GV2yR+OD
 MV1cWFPAWPeBKOtvOHD62/kzZePJj5pL54mkNRJUcKFp35UMHRxsq9Y4Beo/W9GszFAI
 LL+iWvf+gdPlR1aSn+fgRCiWhyJqt7vgxwXbWvZRYG7aZOOcYu2KGX/B7/McQLVX3hJH
 84TA==
X-Gm-Message-State: AOAM5330exSD7rei3dXdw+DydHfZmZEDFC7zpNIaEJGaho/lDFF4Anso
 Jm027z2u1XnodbFSc8M0f9VU8LHRz2G051CFcGk=
X-Google-Smtp-Source: ABdhPJwrLtgMdo4TF8Q8MLiKR7mCa3vhrNmaqY9i8an97zDA9mQzJJlGuQxVAn0+YrILmeIoCAmjDO0qpmxg4QBfX48=
X-Received: by 2002:a02:85e1:: with SMTP id d88mr9674239jai.8.1599247191754;
 Fri, 04 Sep 2020 12:19:51 -0700 (PDT)
MIME-Version: 1.0
References: <1598924352-89526-1-git-send-email-bmeng.cn@gmail.com>
 <1598924352-89526-9-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1598924352-89526-9-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 4 Sep 2020 12:08:56 -0700
Message-ID: <CAKmqyKNcDtCsfToVf3tagwH66j6Hd_4-k0=VmS2RWELfOW6Ejg@mail.gmail.com>
Subject: Re: [PATCH v3 08/16] hw/riscv: microchip_pfsoc: Connect a Cadence
 SDHCI controller and an SD card
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Bin Meng <bin.meng@windriver.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 31, 2020 at 6:47 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
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

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

>
> ---
>
> (no changes since v2)
>
> Changes in v2:
> - do not initialize TYPE_SYSBUS_SDHCI in the SoC instance_init(),
>   instead move that to the cadence_sdhci model
> - do not access generic-sdhci's state directly,
>   instead move that to the cadence_sdhci model
>
>  include/hw/riscv/microchip_pfsoc.h |  4 ++++
>  hw/riscv/microchip_pfsoc.c         | 23 +++++++++++++++++++++++
>  hw/riscv/Kconfig                   |  1 +
>  3 files changed, 28 insertions(+)
>
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
> diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
> index cee959a..0b2e9ca 100644
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
> @@ -111,6 +113,9 @@ static void microchip_pfsoc_soc_instance_init(Object *obj)
>      qdev_prop_set_string(DEVICE(&s->u_cpus), "cpu-type",
>                           TYPE_RISCV_CPU_SIFIVE_U54);
>      qdev_prop_set_uint64(DEVICE(&s->u_cpus), "resetvec", RESET_VECTOR);
> +
> +    object_initialize_child(obj, "sd-controller", &s->sdhci,
> +                            TYPE_CADENCE_SDHCI);
>  }
>
>  static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
> @@ -223,6 +228,13 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
>          memmap[MICROCHIP_PFSOC_MPUCFG].base,
>          memmap[MICROCHIP_PFSOC_MPUCFG].size);
>
> +    /* SDHCI */
> +    sysbus_realize(SYS_BUS_DEVICE(&s->sdhci), errp);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->sdhci), 0,
> +                    memmap[MICROCHIP_PFSOC_EMMC_SD].base);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->sdhci), 0,
> +        qdev_get_gpio_in(DEVICE(s->plic), MICROCHIP_PFSOC_EMMC_SD_IRQ));
> +
>      /* MMUARTs */
>      s->serial0 = mchp_pfsoc_mmuart_create(system_memory,
>          memmap[MICROCHIP_PFSOC_MMUART0].base,
> @@ -290,6 +302,7 @@ static void microchip_icicle_kit_machine_init(MachineState *machine)
>      MicrochipIcicleKitState *s = MICROCHIP_ICICLE_KIT_MACHINE(machine);
>      MemoryRegion *system_memory = get_system_memory();
>      MemoryRegion *main_mem = g_new(MemoryRegion, 1);
> +    DriveInfo *dinfo = drive_get_next(IF_SD);
>
>      /* Sanity check on RAM size */
>      if (machine->ram_size < mc->default_ram_size) {
> @@ -312,6 +325,16 @@ static void microchip_icicle_kit_machine_init(MachineState *machine)
>
>      /* Load the firmware */
>      riscv_find_and_load_firmware(machine, BIOS_FILENAME, RESET_VECTOR, NULL);
> +
> +    /* Attach an SD card */
> +    if (dinfo) {
> +        CadenceSDHCIState *sdhci = &(s->soc.sdhci);
> +        DeviceState *card = qdev_new(TYPE_SD_CARD);
> +
> +        qdev_prop_set_drive_err(card, "drive", blk_by_legacy_dinfo(dinfo),
> +                                &error_fatal);
> +        qdev_realize_and_unref(card, sdhci->bus, &error_fatal);
> +    }
>  }
>
>  static void microchip_icicle_kit_machine_class_init(ObjectClass *oc, void *data)
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index ceb7c16..7412db9 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -55,3 +55,4 @@ config MICROCHIP_PFSOC
>      select SIFIVE
>      select UNIMP
>      select MCHP_PFSOC_MMUART
> +    select CADENCE_SDHCI
> --
> 2.7.4
>
>

