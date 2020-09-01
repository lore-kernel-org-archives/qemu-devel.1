Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C82C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 10:28:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3BBC2083B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 10:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cb2aGdQm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3BBC2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD3Wa-0007xI-QY
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 06:28:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53460)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kD3Vm-00071j-5x; Tue, 01 Sep 2020 06:27:34 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:43240)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kD3Vj-00007m-V9; Tue, 01 Sep 2020 06:27:33 -0400
Received: by mail-yb1-xb42.google.com with SMTP id p6so458273ybk.10;
 Tue, 01 Sep 2020 03:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=zItS4HOOYNFBnroam0jG4bAjH4nsqZQvvcun8sdHGV8=;
 b=Cb2aGdQmeY1kpl82pqARqzaMZoUHOdCNLfj9nVu3Oq6qIfPkWVyx8lOSNO9HJemMRw
 fxMDoi9vJwz188iW6i0wXygUrgJAXAgEMsYl1TBGKb4zFvE++5NdDL7VzLcVMV8eYV8A
 PkGpKa+6vrQ+ZQW8S+FWtAuFG5Or8hChqOtrFa9CKryMgf7aiFsxxqdTwgxpy4z/3XMD
 uhHCtOK4Z9kgA6bYYVQXEbWJ6SNsaEaHAWLGGZWcQnpBXN2lsMFf2c4Uhj7vJbBOkjM1
 yVIBtmcONV/lXPVkQPQXHxzMmyvFCQuKDLoIOqQ0UEuX18VEUJB2sqcjwKgAyf8OvtgH
 dUug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=zItS4HOOYNFBnroam0jG4bAjH4nsqZQvvcun8sdHGV8=;
 b=kGaHDSNDXSV3r2NfgcfxfKNeqLezgdt12zm6q1TuYD6FfpIidi8GVv8BY5V7236Bhl
 sVqwWxkFDVslyoZhnh0IfhyT/2TNLoSHEduSi3/gd+fj/P00kp4br8ocPPxMEIS/y1/S
 /ApvGAELnE5d+3io7BqO4JnuCuKUl3ceX4vn0jJnSiSMWW17cQ2Z+ir/rhHDvJ7kwyl3
 oM3xtKSzt3nLTzkkaneht/971eoiO1wwDZdxuK+mQBtNJFOu2Pg1OG6sG2AuxaenAu/F
 S6nVKEWafIfOGk6cq5HQEzEjCwRGiIIkq87yd+kZ8MO8AHDui2pyfH1GB1JbVcz6byLf
 jcBA==
X-Gm-Message-State: AOAM5338Zv21r03n1DUOhlR0AekrGvTz2mQPiW+o4DUzA7FPFTb8WKbO
 KJxMkYyNrPHJyEMRWK14P6IJkpithS3cxBMCOxI=
X-Google-Smtp-Source: ABdhPJx6Q0gBKoLBWlvFDR/KabEMtlYQ55g4wgJBa21P0s+B3URda58CG/qrzMFk/e8/F0MbQt8GpNsIyHLharWhhlg=
X-Received: by 2002:a25:4251:: with SMTP id p78mr1660545yba.306.1598956050515; 
 Tue, 01 Sep 2020 03:27:30 -0700 (PDT)
MIME-Version: 1.0
References: <1598924352-89526-1-git-send-email-bmeng.cn@gmail.com>
 <1598924352-89526-9-git-send-email-bmeng.cn@gmail.com>
 <df726657-6bac-dcfb-31b2-9293787957d7@amsat.org>
In-Reply-To: <df726657-6bac-dcfb-31b2-9293787957d7@amsat.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 1 Sep 2020 18:27:19 +0800
Message-ID: <CAEUhbmVJZ_3-STFL6JQsfYkhxN+2BaN0gWaKXWrNBfs_akjJjQ@mail.gmail.com>
Subject: Re: [PATCH v3 08/16] hw/riscv: microchip_pfsoc: Connect a Cadence
 SDHCI controller and an SD card
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b42;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Palmer Dabbelt <palmerdabbelt@google.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Bin Meng <bin.meng@windriver.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,

On Tue, Sep 1, 2020 at 5:42 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
>
> On 9/1/20 3:39 AM, Bin Meng wrote:
> > From: Bin Meng <bin.meng@windriver.com>
> >
> > Microchip PolarFire SoC integrates one Cadence SDHCI controller.
> > On the Icicle Kit board, one eMMC chip and an external SD card
> > connect to this controller depending on different configuration.
> >
> > As QEMU does not support eMMC yet, we just emulate the SD card
> > configuration. To test this, the Hart Software Services (HSS)
> > should choose the SD card configuration:
> >
> > $ cp boards/icicle-kit-es/def_config.sdcard .config
> > $ make BOARD=3Dicicle-kit-es
> >
> > The SD card image can be built from the Yocto BSP at:
> > https://github.com/polarfire-soc/meta-polarfire-soc-yocto-bsp
> >
> > Note the generated SD card image should be resized before use:
> > $ qemu-img resize /path/to/sdcard.img 4G
> >
> > Launch QEMU with the following command:
> > $ qemu-system-riscv64 -nographic -M microchip-icicle-kit -sd sdcard.img
> >
> > Signed-off-by: Bin Meng <bin.meng@windriver.com>
> >
> > ---
> >
> > (no changes since v2)
> >
> > Changes in v2:
> > - do not initialize TYPE_SYSBUS_SDHCI in the SoC instance_init(),
> >   instead move that to the cadence_sdhci model
> > - do not access generic-sdhci's state directly,
> >   instead move that to the cadence_sdhci model
> >
> >  include/hw/riscv/microchip_pfsoc.h |  4 ++++
> >  hw/riscv/microchip_pfsoc.c         | 23 +++++++++++++++++++++++
> >  hw/riscv/Kconfig                   |  1 +
> >  3 files changed, 28 insertions(+)
> >
> > diff --git a/include/hw/riscv/microchip_pfsoc.h b/include/hw/riscv/micr=
ochip_pfsoc.h
> > index a5efa1d..d810ee8 100644
> > --- a/include/hw/riscv/microchip_pfsoc.h
> > +++ b/include/hw/riscv/microchip_pfsoc.h
> > @@ -23,6 +23,7 @@
> >  #define HW_MICROCHIP_PFSOC_H
> >
> >  #include "hw/char/mchp_pfsoc_mmuart.h"
> > +#include "hw/sd/cadence_sdhci.h"
> >
> >  typedef struct MicrochipPFSoCState {
> >      /*< private >*/
> > @@ -39,6 +40,7 @@ typedef struct MicrochipPFSoCState {
> >      MchpPfSoCMMUartState *serial2;
> >      MchpPfSoCMMUartState *serial3;
> >      MchpPfSoCMMUartState *serial4;
> > +    CadenceSDHCIState sdhci;
> >  } MicrochipPFSoCState;
> >
> >  #define TYPE_MICROCHIP_PFSOC    "microchip.pfsoc"
> > @@ -74,6 +76,7 @@ enum {
> >      MICROCHIP_PFSOC_MMUART0,
> >      MICROCHIP_PFSOC_SYSREG,
> >      MICROCHIP_PFSOC_MPUCFG,
> > +    MICROCHIP_PFSOC_EMMC_SD,
> >      MICROCHIP_PFSOC_MMUART1,
> >      MICROCHIP_PFSOC_MMUART2,
> >      MICROCHIP_PFSOC_MMUART3,
> > @@ -85,6 +88,7 @@ enum {
> >  };
> >
> >  enum {
> > +    MICROCHIP_PFSOC_EMMC_SD_IRQ =3D 88,
> >      MICROCHIP_PFSOC_MMUART0_IRQ =3D 90,
> >      MICROCHIP_PFSOC_MMUART1_IRQ =3D 91,
> >      MICROCHIP_PFSOC_MMUART2_IRQ =3D 92,
> > diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
> > index cee959a..0b2e9ca 100644
> > --- a/hw/riscv/microchip_pfsoc.c
> > +++ b/hw/riscv/microchip_pfsoc.c
> > @@ -12,6 +12,7 @@
> >   * 1) PLIC (Platform Level Interrupt Controller)
> >   * 2) eNVM (Embedded Non-Volatile Memory)
> >   * 3) MMUARTs (Multi-Mode UART)
> > + * 4) Cadence eMMC/SDHC controller and an SD card connected to it
> >   *
> >   * This board currently generates devicetree dynamically that indicate=
s at least
> >   * two harts and up to five harts.
> > @@ -75,6 +76,7 @@ static const struct MemmapEntry {
> >      [MICROCHIP_PFSOC_MMUART0] =3D         { 0x20000000,     0x1000 },
> >      [MICROCHIP_PFSOC_SYSREG] =3D          { 0x20002000,     0x2000 },
> >      [MICROCHIP_PFSOC_MPUCFG] =3D          { 0x20005000,     0x1000 },
> > +    [MICROCHIP_PFSOC_EMMC_SD] =3D         { 0x20008000,     0x1000 },
> >      [MICROCHIP_PFSOC_MMUART1] =3D         { 0x20100000,     0x1000 },
> >      [MICROCHIP_PFSOC_MMUART2] =3D         { 0x20102000,     0x1000 },
> >      [MICROCHIP_PFSOC_MMUART3] =3D         { 0x20104000,     0x1000 },
> > @@ -111,6 +113,9 @@ static void microchip_pfsoc_soc_instance_init(Objec=
t *obj)
> >      qdev_prop_set_string(DEVICE(&s->u_cpus), "cpu-type",
> >                           TYPE_RISCV_CPU_SIFIVE_U54);
> >      qdev_prop_set_uint64(DEVICE(&s->u_cpus), "resetvec", RESET_VECTOR)=
;
> > +
> > +    object_initialize_child(obj, "sd-controller", &s->sdhci,
> > +                            TYPE_CADENCE_SDHCI);
> >  }
> >
> >  static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp=
)
> > @@ -223,6 +228,13 @@ static void microchip_pfsoc_soc_realize(DeviceStat=
e *dev, Error **errp)
> >          memmap[MICROCHIP_PFSOC_MPUCFG].base,
> >          memmap[MICROCHIP_PFSOC_MPUCFG].size);
> >
> > +    /* SDHCI */
> > +    sysbus_realize(SYS_BUS_DEVICE(&s->sdhci), errp);
> > +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->sdhci), 0,
> > +                    memmap[MICROCHIP_PFSOC_EMMC_SD].base);
> > +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->sdhci), 0,
> > +        qdev_get_gpio_in(DEVICE(s->plic), MICROCHIP_PFSOC_EMMC_SD_IRQ)=
);
> > +
> >      /* MMUARTs */
> >      s->serial0 =3D mchp_pfsoc_mmuart_create(system_memory,
> >          memmap[MICROCHIP_PFSOC_MMUART0].base,
> > @@ -290,6 +302,7 @@ static void microchip_icicle_kit_machine_init(Machi=
neState *machine)
> >      MicrochipIcicleKitState *s =3D MICROCHIP_ICICLE_KIT_MACHINE(machin=
e);
> >      MemoryRegion *system_memory =3D get_system_memory();
> >      MemoryRegion *main_mem =3D g_new(MemoryRegion, 1);
> > +    DriveInfo *dinfo =3D drive_get_next(IF_SD);
>
> Ideally this part should be in the machine, not the soc.
>
> Maybe you can alias the "drive" property as "sd-drive" in the soc,
> and move the card attach to the machine?

Thanks for the review.

I am not sure I understand your suggestion. Currently the SD card
attach codes are already in the machine codes
microchip_icicle_kit_machine_init()

>
> Can be done later if you prefer:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Regards,
Bin

