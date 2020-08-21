Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC3FC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 19:43:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C79692072D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 19:43:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aRwx1CQZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C79692072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9Cww-0001L1-3V
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 15:43:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33520)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1k9Cw7-0000Us-8t; Fri, 21 Aug 2020 15:42:51 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:40905)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1k9Cw3-00019v-5O; Fri, 21 Aug 2020 15:42:50 -0400
Received: by mail-io1-xd43.google.com with SMTP id t187so1449522iod.7;
 Fri, 21 Aug 2020 12:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=I/KYhaCEuyqHKWQQ+Buz187FNDZmPGl3FrxUtpiL1SQ=;
 b=aRwx1CQZvTTdqZ/Xcmn9DAhqY44KNcNSjX2kpq6enNjymhSgq2EwdOP8SP4NqgYPBt
 A3L7k6Sb6hNFeyi3yTmDIK2aYNHZ1zaOsckMeMu3KL3chPqrWO9vKR8ZH+TzufZSmiR0
 AxKw6LgKpdqQqgqBNOsbeBzCBBDpIBmePiXMc/YXsF3k55MrBi3ygX1ByJt5EIzeKp4s
 hte9/NOQz4lmloAFQYZ1FVAcCop6AWqXftTJKCJY0sgRfZTy8fw8Z9vv74huobJDcoQO
 /kRCNZzyvjs544grL49D9KICT8GYpZOyV9Ze549ePXbqma1AAP/xFst0Fn4h3Qigmad2
 HFSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=I/KYhaCEuyqHKWQQ+Buz187FNDZmPGl3FrxUtpiL1SQ=;
 b=D4oLsuI1R01V8Ge2rCrsjLmBGTn+o6bs8yji39ddtRZASCI7IiV1UhLtw9p6QlDNbQ
 2AhnQWWsS2XvuX281jnTTaaJk+G5h3c+SCxOxbee8ZMKLX7n54pEGgaOOOikalTnIWSl
 f/MVy7yHPUt1CAxJc49zO+gTDUADIeKmOczflr46ew+yrAnRP2PNusFHBmm2cxlTxNkd
 pKLo5B0/bZYQ9T7OOL9vmiNVooy+dTbkNDcYSgmYtquj/103Q1qpyKMaXj7p4z0lKwWt
 Iu5I/tESoEqw77z/F8H+SyUHcR5xeRNLKKO4+tqQkABhsK8Z7XwSqX8uiFIfyeCOPnMr
 tDMw==
X-Gm-Message-State: AOAM530VzQMTJ9LSmhHqjrhFoxIgYM7O9Knaxbkp2AhhjOb1p/ha5Z+i
 5XXQhex1US6AlCgIbzAmqMrUgp00etMZ1/Dd6ow=
X-Google-Smtp-Source: ABdhPJxkd9Oz9DXrgrRfhenKIJ1YmCSrfzFiWlDDLhdjT+zpJpFvjw20HRKcMw04wWoro0zKvXT4RRsFhYZKKRZtCAQ=
X-Received: by 2002:a02:6d0e:: with SMTP id m14mr4010574jac.23.1598038964251; 
 Fri, 21 Aug 2020 12:42:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200820001236.1284548-1-ehabkost@redhat.com>
 <20200820001236.1284548-6-ehabkost@redhat.com>
In-Reply-To: <20200820001236.1284548-6-ehabkost@redhat.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Fri, 21 Aug 2020 21:42:32 +0200
Message-ID: <CAPan3Wrpp3q4yUcV3U7WhKf9R3SGgTOabz8Ou=xMYazFGKoMdg@mail.gmail.com>
Subject: Re: [PATCH v2 05/58] allwinner-h3: Rename memmap enum constants
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000cd2f0805ad6870b2"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d43;
 envelope-from=nieklinnenbank@gmail.com; helo=mail-io1-xd43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
 "Daniel P. Berrange" <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000cd2f0805ad6870b2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Op do 20 aug. 2020 02:12 schreef Eduardo Habkost <ehabkost@redhat.com>:

> Some of the enum constant names conflict with the QOM type check
> macros (AW_H3_CCU, AW_H3_SYSCTRL).  This needs to be addressed to
> allow us to transform the QOM type check macros into functions
> generated by OBJECT_DECLARE_TYPE().
>
> Rename all the constants to AW_H3_DEV_*, to avoid conflicts.
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
Reviewed-by: Niek Linnenbank <nieklinnenbank@gmail.com>

> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Changes v1 -> v2:
> * Added more details to commit message
>
> ---
> Cc: Beniamino Galvani <b.galvani@gmail.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Niek Linnenbank <nieklinnenbank@gmail.com>
> Cc: qemu-arm@nongnu.org
> Cc: qemu-devel@nongnu.org
> ---
>  include/hw/arm/allwinner-h3.h |  62 ++++++++---------
>  hw/arm/allwinner-h3.c         | 124 +++++++++++++++++-----------------
>  hw/arm/orangepi.c             |   6 +-
>  3 files changed, 96 insertions(+), 96 deletions(-)
>
> diff --git a/include/hw/arm/allwinner-h3.h b/include/hw/arm/allwinner-h3.=
h
> index 82e4e59216..626139dcb3 100644
> --- a/include/hw/arm/allwinner-h3.h
> +++ b/include/hw/arm/allwinner-h3.h
> @@ -61,37 +61,37 @@
>   * @see AwH3State
>   */
>  enum {
> -    AW_H3_SRAM_A1,
> -    AW_H3_SRAM_A2,
> -    AW_H3_SRAM_C,
> -    AW_H3_SYSCTRL,
> -    AW_H3_MMC0,
> -    AW_H3_SID,
> -    AW_H3_EHCI0,
> -    AW_H3_OHCI0,
> -    AW_H3_EHCI1,
> -    AW_H3_OHCI1,
> -    AW_H3_EHCI2,
> -    AW_H3_OHCI2,
> -    AW_H3_EHCI3,
> -    AW_H3_OHCI3,
> -    AW_H3_CCU,
> -    AW_H3_PIT,
> -    AW_H3_UART0,
> -    AW_H3_UART1,
> -    AW_H3_UART2,
> -    AW_H3_UART3,
> -    AW_H3_EMAC,
> -    AW_H3_DRAMCOM,
> -    AW_H3_DRAMCTL,
> -    AW_H3_DRAMPHY,
> -    AW_H3_GIC_DIST,
> -    AW_H3_GIC_CPU,
> -    AW_H3_GIC_HYP,
> -    AW_H3_GIC_VCPU,
> -    AW_H3_RTC,
> -    AW_H3_CPUCFG,
> -    AW_H3_SDRAM
> +    AW_H3_DEV_SRAM_A1,
> +    AW_H3_DEV_SRAM_A2,
> +    AW_H3_DEV_SRAM_C,
> +    AW_H3_DEV_SYSCTRL,
> +    AW_H3_DEV_MMC0,
> +    AW_H3_DEV_SID,
> +    AW_H3_DEV_EHCI0,
> +    AW_H3_DEV_OHCI0,
> +    AW_H3_DEV_EHCI1,
> +    AW_H3_DEV_OHCI1,
> +    AW_H3_DEV_EHCI2,
> +    AW_H3_DEV_OHCI2,
> +    AW_H3_DEV_EHCI3,
> +    AW_H3_DEV_OHCI3,
> +    AW_H3_DEV_CCU,
> +    AW_H3_DEV_PIT,
> +    AW_H3_DEV_UART0,
> +    AW_H3_DEV_UART1,
> +    AW_H3_DEV_UART2,
> +    AW_H3_DEV_UART3,
> +    AW_H3_DEV_EMAC,
> +    AW_H3_DEV_DRAMCOM,
> +    AW_H3_DEV_DRAMCTL,
> +    AW_H3_DEV_DRAMPHY,
> +    AW_H3_DEV_GIC_DIST,
> +    AW_H3_DEV_GIC_CPU,
> +    AW_H3_DEV_GIC_HYP,
> +    AW_H3_DEV_GIC_VCPU,
> +    AW_H3_DEV_RTC,
> +    AW_H3_DEV_CPUCFG,
> +    AW_H3_DEV_SDRAM
>  };
>
>  /** Total number of CPU cores in the H3 SoC */
> diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
> index ff92ded82c..341abe6718 100644
> --- a/hw/arm/allwinner-h3.c
> +++ b/hw/arm/allwinner-h3.c
> @@ -35,37 +35,37 @@
>
>  /* Memory map */
>  const hwaddr allwinner_h3_memmap[] =3D {
> -    [AW_H3_SRAM_A1]    =3D 0x00000000,
> -    [AW_H3_SRAM_A2]    =3D 0x00044000,
> -    [AW_H3_SRAM_C]     =3D 0x00010000,
> -    [AW_H3_SYSCTRL]    =3D 0x01c00000,
> -    [AW_H3_MMC0]       =3D 0x01c0f000,
> -    [AW_H3_SID]        =3D 0x01c14000,
> -    [AW_H3_EHCI0]      =3D 0x01c1a000,
> -    [AW_H3_OHCI0]      =3D 0x01c1a400,
> -    [AW_H3_EHCI1]      =3D 0x01c1b000,
> -    [AW_H3_OHCI1]      =3D 0x01c1b400,
> -    [AW_H3_EHCI2]      =3D 0x01c1c000,
> -    [AW_H3_OHCI2]      =3D 0x01c1c400,
> -    [AW_H3_EHCI3]      =3D 0x01c1d000,
> -    [AW_H3_OHCI3]      =3D 0x01c1d400,
> -    [AW_H3_CCU]        =3D 0x01c20000,
> -    [AW_H3_PIT]        =3D 0x01c20c00,
> -    [AW_H3_UART0]      =3D 0x01c28000,
> -    [AW_H3_UART1]      =3D 0x01c28400,
> -    [AW_H3_UART2]      =3D 0x01c28800,
> -    [AW_H3_UART3]      =3D 0x01c28c00,
> -    [AW_H3_EMAC]       =3D 0x01c30000,
> -    [AW_H3_DRAMCOM]    =3D 0x01c62000,
> -    [AW_H3_DRAMCTL]    =3D 0x01c63000,
> -    [AW_H3_DRAMPHY]    =3D 0x01c65000,
> -    [AW_H3_GIC_DIST]   =3D 0x01c81000,
> -    [AW_H3_GIC_CPU]    =3D 0x01c82000,
> -    [AW_H3_GIC_HYP]    =3D 0x01c84000,
> -    [AW_H3_GIC_VCPU]   =3D 0x01c86000,
> -    [AW_H3_RTC]        =3D 0x01f00000,
> -    [AW_H3_CPUCFG]     =3D 0x01f01c00,
> -    [AW_H3_SDRAM]      =3D 0x40000000
> +    [AW_H3_DEV_SRAM_A1]    =3D 0x00000000,
> +    [AW_H3_DEV_SRAM_A2]    =3D 0x00044000,
> +    [AW_H3_DEV_SRAM_C]     =3D 0x00010000,
> +    [AW_H3_DEV_SYSCTRL]    =3D 0x01c00000,
> +    [AW_H3_DEV_MMC0]       =3D 0x01c0f000,
> +    [AW_H3_DEV_SID]        =3D 0x01c14000,
> +    [AW_H3_DEV_EHCI0]      =3D 0x01c1a000,
> +    [AW_H3_DEV_OHCI0]      =3D 0x01c1a400,
> +    [AW_H3_DEV_EHCI1]      =3D 0x01c1b000,
> +    [AW_H3_DEV_OHCI1]      =3D 0x01c1b400,
> +    [AW_H3_DEV_EHCI2]      =3D 0x01c1c000,
> +    [AW_H3_DEV_OHCI2]      =3D 0x01c1c400,
> +    [AW_H3_DEV_EHCI3]      =3D 0x01c1d000,
> +    [AW_H3_DEV_OHCI3]      =3D 0x01c1d400,
> +    [AW_H3_DEV_CCU]        =3D 0x01c20000,
> +    [AW_H3_DEV_PIT]        =3D 0x01c20c00,
> +    [AW_H3_DEV_UART0]      =3D 0x01c28000,
> +    [AW_H3_DEV_UART1]      =3D 0x01c28400,
> +    [AW_H3_DEV_UART2]      =3D 0x01c28800,
> +    [AW_H3_DEV_UART3]      =3D 0x01c28c00,
> +    [AW_H3_DEV_EMAC]       =3D 0x01c30000,
> +    [AW_H3_DEV_DRAMCOM]    =3D 0x01c62000,
> +    [AW_H3_DEV_DRAMCTL]    =3D 0x01c63000,
> +    [AW_H3_DEV_DRAMPHY]    =3D 0x01c65000,
> +    [AW_H3_DEV_GIC_DIST]   =3D 0x01c81000,
> +    [AW_H3_DEV_GIC_CPU]    =3D 0x01c82000,
> +    [AW_H3_DEV_GIC_HYP]    =3D 0x01c84000,
> +    [AW_H3_DEV_GIC_VCPU]   =3D 0x01c86000,
> +    [AW_H3_DEV_RTC]        =3D 0x01f00000,
> +    [AW_H3_DEV_CPUCFG]     =3D 0x01f01c00,
> +    [AW_H3_DEV_SDRAM]      =3D 0x40000000
>  };
>
>  /* List of unimplemented devices */
> @@ -183,7 +183,7 @@ void allwinner_h3_bootrom_setup(AwH3State *s,
> BlockBackend *blk)
>      }
>
>      rom_add_blob("allwinner-h3.bootrom", buffer, rom_size,
> -                  rom_size, s->memmap[AW_H3_SRAM_A1],
> +                  rom_size, s->memmap[AW_H3_DEV_SRAM_A1],
>                    NULL, NULL, NULL, NULL, false);
>  }
>
> @@ -262,10 +262,10 @@ static void allwinner_h3_realize(DeviceState *dev,
> Error **errp)
>      qdev_prop_set_bit(DEVICE(&s->gic), "has-virtualization-extensions",
> true);
>      sysbus_realize(SYS_BUS_DEVICE(&s->gic), &error_fatal);
>
> -    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 0,
> s->memmap[AW_H3_GIC_DIST]);
> -    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 1, s->memmap[AW_H3_GIC_CPU]=
);
> -    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 2, s->memmap[AW_H3_GIC_HYP]=
);
> -    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 3,
> s->memmap[AW_H3_GIC_VCPU]);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 0,
> s->memmap[AW_H3_DEV_GIC_DIST]);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 1,
> s->memmap[AW_H3_DEV_GIC_CPU]);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 2,
> s->memmap[AW_H3_DEV_GIC_HYP]);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 3,
> s->memmap[AW_H3_DEV_GIC_VCPU]);
>
>      /*
>       * Wire the outputs from each CPU's generic timer and the GICv3
> @@ -312,7 +312,7 @@ static void allwinner_h3_realize(DeviceState *dev,
> Error **errp)
>
>      /* Timer */
>      sysbus_realize(SYS_BUS_DEVICE(&s->timer), &error_fatal);
> -    sysbus_mmio_map(SYS_BUS_DEVICE(&s->timer), 0, s->memmap[AW_H3_PIT]);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->timer), 0,
> s->memmap[AW_H3_DEV_PIT]);
>      sysbus_connect_irq(SYS_BUS_DEVICE(&s->timer), 0,
>                         qdev_get_gpio_in(DEVICE(&s->gic),
> AW_H3_GIC_SPI_TIMER0));
>      sysbus_connect_irq(SYS_BUS_DEVICE(&s->timer), 1,
> @@ -325,32 +325,32 @@ static void allwinner_h3_realize(DeviceState *dev,
> Error **errp)
>                              32 * KiB, &error_abort);
>      memory_region_init_ram(&s->sram_c, OBJECT(dev), "sram C",
>                              44 * KiB, &error_abort);
> -    memory_region_add_subregion(get_system_memory(),
> s->memmap[AW_H3_SRAM_A1],
> +    memory_region_add_subregion(get_system_memory(),
> s->memmap[AW_H3_DEV_SRAM_A1],
>                                  &s->sram_a1);
> -    memory_region_add_subregion(get_system_memory(),
> s->memmap[AW_H3_SRAM_A2],
> +    memory_region_add_subregion(get_system_memory(),
> s->memmap[AW_H3_DEV_SRAM_A2],
>                                  &s->sram_a2);
> -    memory_region_add_subregion(get_system_memory(),
> s->memmap[AW_H3_SRAM_C],
> +    memory_region_add_subregion(get_system_memory(),
> s->memmap[AW_H3_DEV_SRAM_C],
>                                  &s->sram_c);
>
>      /* Clock Control Unit */
>      sysbus_realize(SYS_BUS_DEVICE(&s->ccu), &error_fatal);
> -    sysbus_mmio_map(SYS_BUS_DEVICE(&s->ccu), 0, s->memmap[AW_H3_CCU]);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->ccu), 0, s->memmap[AW_H3_DEV_CCU]=
);
>
>      /* System Control */
>      sysbus_realize(SYS_BUS_DEVICE(&s->sysctrl), &error_fatal);
> -    sysbus_mmio_map(SYS_BUS_DEVICE(&s->sysctrl), 0,
> s->memmap[AW_H3_SYSCTRL]);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->sysctrl), 0,
> s->memmap[AW_H3_DEV_SYSCTRL]);
>
>      /* CPU Configuration */
>      sysbus_realize(SYS_BUS_DEVICE(&s->cpucfg), &error_fatal);
> -    sysbus_mmio_map(SYS_BUS_DEVICE(&s->cpucfg), 0,
> s->memmap[AW_H3_CPUCFG]);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->cpucfg), 0,
> s->memmap[AW_H3_DEV_CPUCFG]);
>
>      /* Security Identifier */
>      sysbus_realize(SYS_BUS_DEVICE(&s->sid), &error_fatal);
> -    sysbus_mmio_map(SYS_BUS_DEVICE(&s->sid), 0, s->memmap[AW_H3_SID]);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->sid), 0, s->memmap[AW_H3_DEV_SID]=
);
>
>      /* SD/MMC */
>      sysbus_realize(SYS_BUS_DEVICE(&s->mmc0), &error_fatal);
> -    sysbus_mmio_map(SYS_BUS_DEVICE(&s->mmc0), 0, s->memmap[AW_H3_MMC0]);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->mmc0), 0,
> s->memmap[AW_H3_DEV_MMC0]);
>      sysbus_connect_irq(SYS_BUS_DEVICE(&s->mmc0), 0,
>                         qdev_get_gpio_in(DEVICE(&s->gic),
> AW_H3_GIC_SPI_MMC0));
>
> @@ -364,63 +364,63 @@ static void allwinner_h3_realize(DeviceState *dev,
> Error **errp)
>          qdev_set_nic_properties(DEVICE(&s->emac), &nd_table[0]);
>      }
>      sysbus_realize(SYS_BUS_DEVICE(&s->emac), &error_fatal);
> -    sysbus_mmio_map(SYS_BUS_DEVICE(&s->emac), 0, s->memmap[AW_H3_EMAC]);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->emac), 0,
> s->memmap[AW_H3_DEV_EMAC]);
>      sysbus_connect_irq(SYS_BUS_DEVICE(&s->emac), 0,
>                         qdev_get_gpio_in(DEVICE(&s->gic),
> AW_H3_GIC_SPI_EMAC));
>
>      /* Universal Serial Bus */
> -    sysbus_create_simple(TYPE_AW_H3_EHCI, s->memmap[AW_H3_EHCI0],
> +    sysbus_create_simple(TYPE_AW_H3_EHCI, s->memmap[AW_H3_DEV_EHCI0],
>                           qdev_get_gpio_in(DEVICE(&s->gic),
>                                            AW_H3_GIC_SPI_EHCI0));
> -    sysbus_create_simple(TYPE_AW_H3_EHCI, s->memmap[AW_H3_EHCI1],
> +    sysbus_create_simple(TYPE_AW_H3_EHCI, s->memmap[AW_H3_DEV_EHCI1],
>                           qdev_get_gpio_in(DEVICE(&s->gic),
>                                            AW_H3_GIC_SPI_EHCI1));
> -    sysbus_create_simple(TYPE_AW_H3_EHCI, s->memmap[AW_H3_EHCI2],
> +    sysbus_create_simple(TYPE_AW_H3_EHCI, s->memmap[AW_H3_DEV_EHCI2],
>                           qdev_get_gpio_in(DEVICE(&s->gic),
>                                            AW_H3_GIC_SPI_EHCI2));
> -    sysbus_create_simple(TYPE_AW_H3_EHCI, s->memmap[AW_H3_EHCI3],
> +    sysbus_create_simple(TYPE_AW_H3_EHCI, s->memmap[AW_H3_DEV_EHCI3],
>                           qdev_get_gpio_in(DEVICE(&s->gic),
>                                            AW_H3_GIC_SPI_EHCI3));
>
> -    sysbus_create_simple("sysbus-ohci", s->memmap[AW_H3_OHCI0],
> +    sysbus_create_simple("sysbus-ohci", s->memmap[AW_H3_DEV_OHCI0],
>                           qdev_get_gpio_in(DEVICE(&s->gic),
>                                            AW_H3_GIC_SPI_OHCI0));
> -    sysbus_create_simple("sysbus-ohci", s->memmap[AW_H3_OHCI1],
> +    sysbus_create_simple("sysbus-ohci", s->memmap[AW_H3_DEV_OHCI1],
>                           qdev_get_gpio_in(DEVICE(&s->gic),
>                                            AW_H3_GIC_SPI_OHCI1));
> -    sysbus_create_simple("sysbus-ohci", s->memmap[AW_H3_OHCI2],
> +    sysbus_create_simple("sysbus-ohci", s->memmap[AW_H3_DEV_OHCI2],
>                           qdev_get_gpio_in(DEVICE(&s->gic),
>                                            AW_H3_GIC_SPI_OHCI2));
> -    sysbus_create_simple("sysbus-ohci", s->memmap[AW_H3_OHCI3],
> +    sysbus_create_simple("sysbus-ohci", s->memmap[AW_H3_DEV_OHCI3],
>                           qdev_get_gpio_in(DEVICE(&s->gic),
>                                            AW_H3_GIC_SPI_OHCI3));
>
>      /* UART0. For future clocktree API: All UARTS are connected to
> APB2_CLK. */
> -    serial_mm_init(get_system_memory(), s->memmap[AW_H3_UART0], 2,
> +    serial_mm_init(get_system_memory(), s->memmap[AW_H3_DEV_UART0], 2,
>                     qdev_get_gpio_in(DEVICE(&s->gic), AW_H3_GIC_SPI_UART0=
),
>                     115200, serial_hd(0), DEVICE_NATIVE_ENDIAN);
>      /* UART1 */
> -    serial_mm_init(get_system_memory(), s->memmap[AW_H3_UART1], 2,
> +    serial_mm_init(get_system_memory(), s->memmap[AW_H3_DEV_UART1], 2,
>                     qdev_get_gpio_in(DEVICE(&s->gic), AW_H3_GIC_SPI_UART1=
),
>                     115200, serial_hd(1), DEVICE_NATIVE_ENDIAN);
>      /* UART2 */
> -    serial_mm_init(get_system_memory(), s->memmap[AW_H3_UART2], 2,
> +    serial_mm_init(get_system_memory(), s->memmap[AW_H3_DEV_UART2], 2,
>                     qdev_get_gpio_in(DEVICE(&s->gic), AW_H3_GIC_SPI_UART2=
),
>                     115200, serial_hd(2), DEVICE_NATIVE_ENDIAN);
>      /* UART3 */
> -    serial_mm_init(get_system_memory(), s->memmap[AW_H3_UART3], 2,
> +    serial_mm_init(get_system_memory(), s->memmap[AW_H3_DEV_UART3], 2,
>                     qdev_get_gpio_in(DEVICE(&s->gic), AW_H3_GIC_SPI_UART3=
),
>                     115200, serial_hd(3), DEVICE_NATIVE_ENDIAN);
>
>      /* DRAMC */
>      sysbus_realize(SYS_BUS_DEVICE(&s->dramc), &error_fatal);
> -    sysbus_mmio_map(SYS_BUS_DEVICE(&s->dramc), 0,
> s->memmap[AW_H3_DRAMCOM]);
> -    sysbus_mmio_map(SYS_BUS_DEVICE(&s->dramc), 1,
> s->memmap[AW_H3_DRAMCTL]);
> -    sysbus_mmio_map(SYS_BUS_DEVICE(&s->dramc), 2,
> s->memmap[AW_H3_DRAMPHY]);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->dramc), 0,
> s->memmap[AW_H3_DEV_DRAMCOM]);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->dramc), 1,
> s->memmap[AW_H3_DEV_DRAMCTL]);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->dramc), 2,
> s->memmap[AW_H3_DEV_DRAMPHY]);
>
>      /* RTC */
>      sysbus_realize(SYS_BUS_DEVICE(&s->rtc), &error_fatal);
> -    sysbus_mmio_map(SYS_BUS_DEVICE(&s->rtc), 0, s->memmap[AW_H3_RTC]);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->rtc), 0, s->memmap[AW_H3_DEV_RTC]=
);
>
>      /* Unimplemented devices */
>      for (i =3D 0; i < ARRAY_SIZE(unimplemented); i++) {
> diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
> index 1679468232..17a568a2b4 100644
> --- a/hw/arm/orangepi.c
> +++ b/hw/arm/orangepi.c
> @@ -79,7 +79,7 @@ static void orangepi_init(MachineState *machine)
>      object_property_set_int(OBJECT(&h3->emac), "phy-addr", 1,
> &error_abort);
>
>      /* DRAMC */
> -    object_property_set_uint(OBJECT(h3), "ram-addr",
> h3->memmap[AW_H3_SDRAM],
> +    object_property_set_uint(OBJECT(h3), "ram-addr",
> h3->memmap[AW_H3_DEV_SDRAM],
>                               &error_abort);
>      object_property_set_int(OBJECT(h3), "ram-size", machine->ram_size /
> MiB,
>                              &error_abort);
> @@ -98,7 +98,7 @@ static void orangepi_init(MachineState *machine)
>      qdev_realize_and_unref(carddev, bus, &error_fatal);
>
>      /* SDRAM */
> -    memory_region_add_subregion(get_system_memory(),
> h3->memmap[AW_H3_SDRAM],
> +    memory_region_add_subregion(get_system_memory(),
> h3->memmap[AW_H3_DEV_SDRAM],
>                                  machine->ram);
>
>      /* Load target kernel or start using BootROM */
> @@ -106,7 +106,7 @@ static void orangepi_init(MachineState *machine)
>          /* Use Boot ROM to copy data from SD card to SRAM */
>          allwinner_h3_bootrom_setup(h3, blk);
>      }
> -    orangepi_binfo.loader_start =3D h3->memmap[AW_H3_SDRAM];
> +    orangepi_binfo.loader_start =3D h3->memmap[AW_H3_DEV_SDRAM];
>      orangepi_binfo.ram_size =3D machine->ram_size;
>      arm_load_kernel(ARM_CPU(first_cpu), machine, &orangepi_binfo);
>  }
> --
> 2.26.2
>
>

--000000000000cd2f0805ad6870b2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Op do 20 aug. 2020 02:12 schreef Eduardo Habkost &lt;<=
a href=3D"mailto:ehabkost@redhat.com">ehabkost@redhat.com</a>&gt;:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex">Some of the enum constant names conflict wi=
th the QOM type check<br>
macros (AW_H3_CCU, AW_H3_SYSCTRL).=C2=A0 This needs to be addressed to<br>
allow us to transform the QOM type check macros into functions<br>
generated by OBJECT_DECLARE_TYPE().<br>
<br>
Rename all the constants to AW_H3_DEV_*, to avoid conflicts.<br>
<br>
Reviewed-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.=
com" target=3D"_blank" rel=3D"noreferrer">berrange@redhat.com</a>&gt;<br></=
blockquote></div></div><div dir=3D"auto">Reviewed-by: Niek Linnenbank &lt;<=
a href=3D"mailto:nieklinnenbank@gmail.com">nieklinnenbank@gmail.com</a>&gt;=
</div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex">
Signed-off-by: Eduardo Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com" t=
arget=3D"_blank" rel=3D"noreferrer">ehabkost@redhat.com</a>&gt;<br>
---<br>
Changes v1 -&gt; v2:<br>
* Added more details to commit message<br>
<br>
---<br>
Cc: Beniamino Galvani &lt;<a href=3D"mailto:b.galvani@gmail.com" target=3D"=
_blank" rel=3D"noreferrer">b.galvani@gmail.com</a>&gt;<br>
Cc: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org" target=3D=
"_blank" rel=3D"noreferrer">peter.maydell@linaro.org</a>&gt;<br>
Cc: Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gmail.com" target=
=3D"_blank" rel=3D"noreferrer">nieklinnenbank@gmail.com</a>&gt;<br>
Cc: <a href=3D"mailto:qemu-arm@nongnu.org" target=3D"_blank" rel=3D"norefer=
rer">qemu-arm@nongnu.org</a><br>
Cc: <a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blank" rel=3D"noref=
errer">qemu-devel@nongnu.org</a><br>
---<br>
=C2=A0include/hw/arm/allwinner-h3.h |=C2=A0 62 ++++++++---------<br>
=C2=A0hw/arm/allwinner-h3.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 124 ++++++++=
+++++++++-----------------<br>
=C2=A0hw/arm/orangepi.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A06 +-<br>
=C2=A03 files changed, 96 insertions(+), 96 deletions(-)<br>
<br>
diff --git a/include/hw/arm/allwinner-h3.h b/include/hw/arm/allwinner-h3.h<=
br>
index 82e4e59216..626139dcb3 100644<br>
--- a/include/hw/arm/allwinner-h3.h<br>
+++ b/include/hw/arm/allwinner-h3.h<br>
@@ -61,37 +61,37 @@<br>
=C2=A0 * @see AwH3State<br>
=C2=A0 */<br>
=C2=A0enum {<br>
-=C2=A0 =C2=A0 AW_H3_SRAM_A1,<br>
-=C2=A0 =C2=A0 AW_H3_SRAM_A2,<br>
-=C2=A0 =C2=A0 AW_H3_SRAM_C,<br>
-=C2=A0 =C2=A0 AW_H3_SYSCTRL,<br>
-=C2=A0 =C2=A0 AW_H3_MMC0,<br>
-=C2=A0 =C2=A0 AW_H3_SID,<br>
-=C2=A0 =C2=A0 AW_H3_EHCI0,<br>
-=C2=A0 =C2=A0 AW_H3_OHCI0,<br>
-=C2=A0 =C2=A0 AW_H3_EHCI1,<br>
-=C2=A0 =C2=A0 AW_H3_OHCI1,<br>
-=C2=A0 =C2=A0 AW_H3_EHCI2,<br>
-=C2=A0 =C2=A0 AW_H3_OHCI2,<br>
-=C2=A0 =C2=A0 AW_H3_EHCI3,<br>
-=C2=A0 =C2=A0 AW_H3_OHCI3,<br>
-=C2=A0 =C2=A0 AW_H3_CCU,<br>
-=C2=A0 =C2=A0 AW_H3_PIT,<br>
-=C2=A0 =C2=A0 AW_H3_UART0,<br>
-=C2=A0 =C2=A0 AW_H3_UART1,<br>
-=C2=A0 =C2=A0 AW_H3_UART2,<br>
-=C2=A0 =C2=A0 AW_H3_UART3,<br>
-=C2=A0 =C2=A0 AW_H3_EMAC,<br>
-=C2=A0 =C2=A0 AW_H3_DRAMCOM,<br>
-=C2=A0 =C2=A0 AW_H3_DRAMCTL,<br>
-=C2=A0 =C2=A0 AW_H3_DRAMPHY,<br>
-=C2=A0 =C2=A0 AW_H3_GIC_DIST,<br>
-=C2=A0 =C2=A0 AW_H3_GIC_CPU,<br>
-=C2=A0 =C2=A0 AW_H3_GIC_HYP,<br>
-=C2=A0 =C2=A0 AW_H3_GIC_VCPU,<br>
-=C2=A0 =C2=A0 AW_H3_RTC,<br>
-=C2=A0 =C2=A0 AW_H3_CPUCFG,<br>
-=C2=A0 =C2=A0 AW_H3_SDRAM<br>
+=C2=A0 =C2=A0 AW_H3_DEV_SRAM_A1,<br>
+=C2=A0 =C2=A0 AW_H3_DEV_SRAM_A2,<br>
+=C2=A0 =C2=A0 AW_H3_DEV_SRAM_C,<br>
+=C2=A0 =C2=A0 AW_H3_DEV_SYSCTRL,<br>
+=C2=A0 =C2=A0 AW_H3_DEV_MMC0,<br>
+=C2=A0 =C2=A0 AW_H3_DEV_SID,<br>
+=C2=A0 =C2=A0 AW_H3_DEV_EHCI0,<br>
+=C2=A0 =C2=A0 AW_H3_DEV_OHCI0,<br>
+=C2=A0 =C2=A0 AW_H3_DEV_EHCI1,<br>
+=C2=A0 =C2=A0 AW_H3_DEV_OHCI1,<br>
+=C2=A0 =C2=A0 AW_H3_DEV_EHCI2,<br>
+=C2=A0 =C2=A0 AW_H3_DEV_OHCI2,<br>
+=C2=A0 =C2=A0 AW_H3_DEV_EHCI3,<br>
+=C2=A0 =C2=A0 AW_H3_DEV_OHCI3,<br>
+=C2=A0 =C2=A0 AW_H3_DEV_CCU,<br>
+=C2=A0 =C2=A0 AW_H3_DEV_PIT,<br>
+=C2=A0 =C2=A0 AW_H3_DEV_UART0,<br>
+=C2=A0 =C2=A0 AW_H3_DEV_UART1,<br>
+=C2=A0 =C2=A0 AW_H3_DEV_UART2,<br>
+=C2=A0 =C2=A0 AW_H3_DEV_UART3,<br>
+=C2=A0 =C2=A0 AW_H3_DEV_EMAC,<br>
+=C2=A0 =C2=A0 AW_H3_DEV_DRAMCOM,<br>
+=C2=A0 =C2=A0 AW_H3_DEV_DRAMCTL,<br>
+=C2=A0 =C2=A0 AW_H3_DEV_DRAMPHY,<br>
+=C2=A0 =C2=A0 AW_H3_DEV_GIC_DIST,<br>
+=C2=A0 =C2=A0 AW_H3_DEV_GIC_CPU,<br>
+=C2=A0 =C2=A0 AW_H3_DEV_GIC_HYP,<br>
+=C2=A0 =C2=A0 AW_H3_DEV_GIC_VCPU,<br>
+=C2=A0 =C2=A0 AW_H3_DEV_RTC,<br>
+=C2=A0 =C2=A0 AW_H3_DEV_CPUCFG,<br>
+=C2=A0 =C2=A0 AW_H3_DEV_SDRAM<br>
=C2=A0};<br>
<br>
=C2=A0/** Total number of CPU cores in the H3 SoC */<br>
diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c<br>
index ff92ded82c..341abe6718 100644<br>
--- a/hw/arm/allwinner-h3.c<br>
+++ b/hw/arm/allwinner-h3.c<br>
@@ -35,37 +35,37 @@<br>
<br>
=C2=A0/* Memory map */<br>
=C2=A0const hwaddr allwinner_h3_memmap[] =3D {<br>
-=C2=A0 =C2=A0 [AW_H3_SRAM_A1]=C2=A0 =C2=A0 =3D 0x00000000,<br>
-=C2=A0 =C2=A0 [AW_H3_SRAM_A2]=C2=A0 =C2=A0 =3D 0x00044000,<br>
-=C2=A0 =C2=A0 [AW_H3_SRAM_C]=C2=A0 =C2=A0 =C2=A0=3D 0x00010000,<br>
-=C2=A0 =C2=A0 [AW_H3_SYSCTRL]=C2=A0 =C2=A0 =3D 0x01c00000,<br>
-=C2=A0 =C2=A0 [AW_H3_MMC0]=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 0x01c0f000,<br>
-=C2=A0 =C2=A0 [AW_H3_SID]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0x01c14000,<br>
-=C2=A0 =C2=A0 [AW_H3_EHCI0]=C2=A0 =C2=A0 =C2=A0 =3D 0x01c1a000,<br>
-=C2=A0 =C2=A0 [AW_H3_OHCI0]=C2=A0 =C2=A0 =C2=A0 =3D 0x01c1a400,<br>
-=C2=A0 =C2=A0 [AW_H3_EHCI1]=C2=A0 =C2=A0 =C2=A0 =3D 0x01c1b000,<br>
-=C2=A0 =C2=A0 [AW_H3_OHCI1]=C2=A0 =C2=A0 =C2=A0 =3D 0x01c1b400,<br>
-=C2=A0 =C2=A0 [AW_H3_EHCI2]=C2=A0 =C2=A0 =C2=A0 =3D 0x01c1c000,<br>
-=C2=A0 =C2=A0 [AW_H3_OHCI2]=C2=A0 =C2=A0 =C2=A0 =3D 0x01c1c400,<br>
-=C2=A0 =C2=A0 [AW_H3_EHCI3]=C2=A0 =C2=A0 =C2=A0 =3D 0x01c1d000,<br>
-=C2=A0 =C2=A0 [AW_H3_OHCI3]=C2=A0 =C2=A0 =C2=A0 =3D 0x01c1d400,<br>
-=C2=A0 =C2=A0 [AW_H3_CCU]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0x01c20000,<br>
-=C2=A0 =C2=A0 [AW_H3_PIT]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0x01c20c00,<br>
-=C2=A0 =C2=A0 [AW_H3_UART0]=C2=A0 =C2=A0 =C2=A0 =3D 0x01c28000,<br>
-=C2=A0 =C2=A0 [AW_H3_UART1]=C2=A0 =C2=A0 =C2=A0 =3D 0x01c28400,<br>
-=C2=A0 =C2=A0 [AW_H3_UART2]=C2=A0 =C2=A0 =C2=A0 =3D 0x01c28800,<br>
-=C2=A0 =C2=A0 [AW_H3_UART3]=C2=A0 =C2=A0 =C2=A0 =3D 0x01c28c00,<br>
-=C2=A0 =C2=A0 [AW_H3_EMAC]=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 0x01c30000,<br>
-=C2=A0 =C2=A0 [AW_H3_DRAMCOM]=C2=A0 =C2=A0 =3D 0x01c62000,<br>
-=C2=A0 =C2=A0 [AW_H3_DRAMCTL]=C2=A0 =C2=A0 =3D 0x01c63000,<br>
-=C2=A0 =C2=A0 [AW_H3_DRAMPHY]=C2=A0 =C2=A0 =3D 0x01c65000,<br>
-=C2=A0 =C2=A0 [AW_H3_GIC_DIST]=C2=A0 =C2=A0=3D 0x01c81000,<br>
-=C2=A0 =C2=A0 [AW_H3_GIC_CPU]=C2=A0 =C2=A0 =3D 0x01c82000,<br>
-=C2=A0 =C2=A0 [AW_H3_GIC_HYP]=C2=A0 =C2=A0 =3D 0x01c84000,<br>
-=C2=A0 =C2=A0 [AW_H3_GIC_VCPU]=C2=A0 =C2=A0=3D 0x01c86000,<br>
-=C2=A0 =C2=A0 [AW_H3_RTC]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0x01f00000,<br>
-=C2=A0 =C2=A0 [AW_H3_CPUCFG]=C2=A0 =C2=A0 =C2=A0=3D 0x01f01c00,<br>
-=C2=A0 =C2=A0 [AW_H3_SDRAM]=C2=A0 =C2=A0 =C2=A0 =3D 0x40000000<br>
+=C2=A0 =C2=A0 [AW_H3_DEV_SRAM_A1]=C2=A0 =C2=A0 =3D 0x00000000,<br>
+=C2=A0 =C2=A0 [AW_H3_DEV_SRAM_A2]=C2=A0 =C2=A0 =3D 0x00044000,<br>
+=C2=A0 =C2=A0 [AW_H3_DEV_SRAM_C]=C2=A0 =C2=A0 =C2=A0=3D 0x00010000,<br>
+=C2=A0 =C2=A0 [AW_H3_DEV_SYSCTRL]=C2=A0 =C2=A0 =3D 0x01c00000,<br>
+=C2=A0 =C2=A0 [AW_H3_DEV_MMC0]=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 0x01c0f000,<b=
r>
+=C2=A0 =C2=A0 [AW_H3_DEV_SID]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0x01c14000,<b=
r>
+=C2=A0 =C2=A0 [AW_H3_DEV_EHCI0]=C2=A0 =C2=A0 =C2=A0 =3D 0x01c1a000,<br>
+=C2=A0 =C2=A0 [AW_H3_DEV_OHCI0]=C2=A0 =C2=A0 =C2=A0 =3D 0x01c1a400,<br>
+=C2=A0 =C2=A0 [AW_H3_DEV_EHCI1]=C2=A0 =C2=A0 =C2=A0 =3D 0x01c1b000,<br>
+=C2=A0 =C2=A0 [AW_H3_DEV_OHCI1]=C2=A0 =C2=A0 =C2=A0 =3D 0x01c1b400,<br>
+=C2=A0 =C2=A0 [AW_H3_DEV_EHCI2]=C2=A0 =C2=A0 =C2=A0 =3D 0x01c1c000,<br>
+=C2=A0 =C2=A0 [AW_H3_DEV_OHCI2]=C2=A0 =C2=A0 =C2=A0 =3D 0x01c1c400,<br>
+=C2=A0 =C2=A0 [AW_H3_DEV_EHCI3]=C2=A0 =C2=A0 =C2=A0 =3D 0x01c1d000,<br>
+=C2=A0 =C2=A0 [AW_H3_DEV_OHCI3]=C2=A0 =C2=A0 =C2=A0 =3D 0x01c1d400,<br>
+=C2=A0 =C2=A0 [AW_H3_DEV_CCU]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0x01c20000,<b=
r>
+=C2=A0 =C2=A0 [AW_H3_DEV_PIT]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0x01c20c00,<b=
r>
+=C2=A0 =C2=A0 [AW_H3_DEV_UART0]=C2=A0 =C2=A0 =C2=A0 =3D 0x01c28000,<br>
+=C2=A0 =C2=A0 [AW_H3_DEV_UART1]=C2=A0 =C2=A0 =C2=A0 =3D 0x01c28400,<br>
+=C2=A0 =C2=A0 [AW_H3_DEV_UART2]=C2=A0 =C2=A0 =C2=A0 =3D 0x01c28800,<br>
+=C2=A0 =C2=A0 [AW_H3_DEV_UART3]=C2=A0 =C2=A0 =C2=A0 =3D 0x01c28c00,<br>
+=C2=A0 =C2=A0 [AW_H3_DEV_EMAC]=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 0x01c30000,<b=
r>
+=C2=A0 =C2=A0 [AW_H3_DEV_DRAMCOM]=C2=A0 =C2=A0 =3D 0x01c62000,<br>
+=C2=A0 =C2=A0 [AW_H3_DEV_DRAMCTL]=C2=A0 =C2=A0 =3D 0x01c63000,<br>
+=C2=A0 =C2=A0 [AW_H3_DEV_DRAMPHY]=C2=A0 =C2=A0 =3D 0x01c65000,<br>
+=C2=A0 =C2=A0 [AW_H3_DEV_GIC_DIST]=C2=A0 =C2=A0=3D 0x01c81000,<br>
+=C2=A0 =C2=A0 [AW_H3_DEV_GIC_CPU]=C2=A0 =C2=A0 =3D 0x01c82000,<br>
+=C2=A0 =C2=A0 [AW_H3_DEV_GIC_HYP]=C2=A0 =C2=A0 =3D 0x01c84000,<br>
+=C2=A0 =C2=A0 [AW_H3_DEV_GIC_VCPU]=C2=A0 =C2=A0=3D 0x01c86000,<br>
+=C2=A0 =C2=A0 [AW_H3_DEV_RTC]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 0x01f00000,<b=
r>
+=C2=A0 =C2=A0 [AW_H3_DEV_CPUCFG]=C2=A0 =C2=A0 =C2=A0=3D 0x01f01c00,<br>
+=C2=A0 =C2=A0 [AW_H3_DEV_SDRAM]=C2=A0 =C2=A0 =C2=A0 =3D 0x40000000<br>
=C2=A0};<br>
<br>
=C2=A0/* List of unimplemented devices */<br>
@@ -183,7 +183,7 @@ void allwinner_h3_bootrom_setup(AwH3State *s, BlockBack=
end *blk)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0rom_add_blob(&quot;allwinner-h3.bootrom&quot;, buffer, =
rom_size,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rom_size, s=
-&gt;memmap[AW_H3_SRAM_A1],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rom_size, s=
-&gt;memmap[AW_H3_DEV_SRAM_A1],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, =
NULL, NULL, NULL, false);<br>
=C2=A0}<br>
<br>
@@ -262,10 +262,10 @@ static void allwinner_h3_realize(DeviceState *dev, Er=
ror **errp)<br>
=C2=A0 =C2=A0 =C2=A0qdev_prop_set_bit(DEVICE(&amp;s-&gt;gic), &quot;has-vir=
tualization-extensions&quot;, true);<br>
=C2=A0 =C2=A0 =C2=A0sysbus_realize(SYS_BUS_DEVICE(&amp;s-&gt;gic), &amp;err=
or_fatal);<br>
<br>
-=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;gic), 0, s-&gt;mem=
map[AW_H3_GIC_DIST]);<br>
-=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;gic), 1, s-&gt;mem=
map[AW_H3_GIC_CPU]);<br>
-=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;gic), 2, s-&gt;mem=
map[AW_H3_GIC_HYP]);<br>
-=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;gic), 3, s-&gt;mem=
map[AW_H3_GIC_VCPU]);<br>
+=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;gic), 0, s-&gt;mem=
map[AW_H3_DEV_GIC_DIST]);<br>
+=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;gic), 1, s-&gt;mem=
map[AW_H3_DEV_GIC_CPU]);<br>
+=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;gic), 2, s-&gt;mem=
map[AW_H3_DEV_GIC_HYP]);<br>
+=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;gic), 3, s-&gt;mem=
map[AW_H3_DEV_GIC_VCPU]);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 * Wire the outputs from each CPU&#39;s generic timer a=
nd the GICv3<br>
@@ -312,7 +312,7 @@ static void allwinner_h3_realize(DeviceState *dev, Erro=
r **errp)<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Timer */<br>
=C2=A0 =C2=A0 =C2=A0sysbus_realize(SYS_BUS_DEVICE(&amp;s-&gt;timer), &amp;e=
rror_fatal);<br>
-=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;timer), 0, s-&gt;m=
emmap[AW_H3_PIT]);<br>
+=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;timer), 0, s-&gt;m=
emmap[AW_H3_DEV_PIT]);<br>
=C2=A0 =C2=A0 =C2=A0sysbus_connect_irq(SYS_BUS_DEVICE(&amp;s-&gt;timer), 0,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 qdev_get_gpio_in(DEVICE(&amp;s-&gt;gic), AW_H3_GIC_SPI_TIMER0));=
<br>
=C2=A0 =C2=A0 =C2=A0sysbus_connect_irq(SYS_BUS_DEVICE(&amp;s-&gt;timer), 1,=
<br>
@@ -325,32 +325,32 @@ static void allwinner_h3_realize(DeviceState *dev, Er=
ror **errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A032 * KiB, &amp;error_abort);<br>
=C2=A0 =C2=A0 =C2=A0memory_region_init_ram(&amp;s-&gt;sram_c, OBJECT(dev), =
&quot;sram C&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A044 * KiB, &amp;error_abort);<br>
-=C2=A0 =C2=A0 memory_region_add_subregion(get_system_memory(), s-&gt;memma=
p[AW_H3_SRAM_A1],<br>
+=C2=A0 =C2=A0 memory_region_add_subregion(get_system_memory(), s-&gt;memma=
p[AW_H3_DEV_SRAM_A1],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;s-&gt;sram_a1);<br>
-=C2=A0 =C2=A0 memory_region_add_subregion(get_system_memory(), s-&gt;memma=
p[AW_H3_SRAM_A2],<br>
+=C2=A0 =C2=A0 memory_region_add_subregion(get_system_memory(), s-&gt;memma=
p[AW_H3_DEV_SRAM_A2],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;s-&gt;sram_a2);<br>
-=C2=A0 =C2=A0 memory_region_add_subregion(get_system_memory(), s-&gt;memma=
p[AW_H3_SRAM_C],<br>
+=C2=A0 =C2=A0 memory_region_add_subregion(get_system_memory(), s-&gt;memma=
p[AW_H3_DEV_SRAM_C],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;s-&gt;sram_c);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Clock Control Unit */<br>
=C2=A0 =C2=A0 =C2=A0sysbus_realize(SYS_BUS_DEVICE(&amp;s-&gt;ccu), &amp;err=
or_fatal);<br>
-=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;ccu), 0, s-&gt;mem=
map[AW_H3_CCU]);<br>
+=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;ccu), 0, s-&gt;mem=
map[AW_H3_DEV_CCU]);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* System Control */<br>
=C2=A0 =C2=A0 =C2=A0sysbus_realize(SYS_BUS_DEVICE(&amp;s-&gt;sysctrl), &amp=
;error_fatal);<br>
-=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;sysctrl), 0, s-&gt=
;memmap[AW_H3_SYSCTRL]);<br>
+=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;sysctrl), 0, s-&gt=
;memmap[AW_H3_DEV_SYSCTRL]);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* CPU Configuration */<br>
=C2=A0 =C2=A0 =C2=A0sysbus_realize(SYS_BUS_DEVICE(&amp;s-&gt;cpucfg), &amp;=
error_fatal);<br>
-=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;cpucfg), 0, s-&gt;=
memmap[AW_H3_CPUCFG]);<br>
+=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;cpucfg), 0, s-&gt;=
memmap[AW_H3_DEV_CPUCFG]);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Security Identifier */<br>
=C2=A0 =C2=A0 =C2=A0sysbus_realize(SYS_BUS_DEVICE(&amp;s-&gt;sid), &amp;err=
or_fatal);<br>
-=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;sid), 0, s-&gt;mem=
map[AW_H3_SID]);<br>
+=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;sid), 0, s-&gt;mem=
map[AW_H3_DEV_SID]);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* SD/MMC */<br>
=C2=A0 =C2=A0 =C2=A0sysbus_realize(SYS_BUS_DEVICE(&amp;s-&gt;mmc0), &amp;er=
ror_fatal);<br>
-=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;mmc0), 0, s-&gt;me=
mmap[AW_H3_MMC0]);<br>
+=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;mmc0), 0, s-&gt;me=
mmap[AW_H3_DEV_MMC0]);<br>
=C2=A0 =C2=A0 =C2=A0sysbus_connect_irq(SYS_BUS_DEVICE(&amp;s-&gt;mmc0), 0,<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 qdev_get_gpio_in(DEVICE(&amp;s-&gt;gic), AW_H3_GIC_SPI_MMC0));<b=
r>
<br>
@@ -364,63 +364,63 @@ static void allwinner_h3_realize(DeviceState *dev, Er=
ror **errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qdev_set_nic_properties(DEVICE(&amp;s-&gt=
;emac), &amp;nd_table[0]);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0sysbus_realize(SYS_BUS_DEVICE(&amp;s-&gt;emac), &amp;er=
ror_fatal);<br>
-=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;emac), 0, s-&gt;me=
mmap[AW_H3_EMAC]);<br>
+=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;emac), 0, s-&gt;me=
mmap[AW_H3_DEV_EMAC]);<br>
=C2=A0 =C2=A0 =C2=A0sysbus_connect_irq(SYS_BUS_DEVICE(&amp;s-&gt;emac), 0,<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 qdev_get_gpio_in(DEVICE(&amp;s-&gt;gic), AW_H3_GIC_SPI_EMAC));<b=
r>
<br>
=C2=A0 =C2=A0 =C2=A0/* Universal Serial Bus */<br>
-=C2=A0 =C2=A0 sysbus_create_simple(TYPE_AW_H3_EHCI, s-&gt;memmap[AW_H3_EHC=
I0],<br>
+=C2=A0 =C2=A0 sysbus_create_simple(TYPE_AW_H3_EHCI, s-&gt;memmap[AW_H3_DEV=
_EHCI0],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 qdev_get_gpio_in(DEVICE(&amp;s-&gt;gic),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0AW_H3_GIC_SPI_EHCI0));<br>
-=C2=A0 =C2=A0 sysbus_create_simple(TYPE_AW_H3_EHCI, s-&gt;memmap[AW_H3_EHC=
I1],<br>
+=C2=A0 =C2=A0 sysbus_create_simple(TYPE_AW_H3_EHCI, s-&gt;memmap[AW_H3_DEV=
_EHCI1],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 qdev_get_gpio_in(DEVICE(&amp;s-&gt;gic),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0AW_H3_GIC_SPI_EHCI1));<br>
-=C2=A0 =C2=A0 sysbus_create_simple(TYPE_AW_H3_EHCI, s-&gt;memmap[AW_H3_EHC=
I2],<br>
+=C2=A0 =C2=A0 sysbus_create_simple(TYPE_AW_H3_EHCI, s-&gt;memmap[AW_H3_DEV=
_EHCI2],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 qdev_get_gpio_in(DEVICE(&amp;s-&gt;gic),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0AW_H3_GIC_SPI_EHCI2));<br>
-=C2=A0 =C2=A0 sysbus_create_simple(TYPE_AW_H3_EHCI, s-&gt;memmap[AW_H3_EHC=
I3],<br>
+=C2=A0 =C2=A0 sysbus_create_simple(TYPE_AW_H3_EHCI, s-&gt;memmap[AW_H3_DEV=
_EHCI3],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 qdev_get_gpio_in(DEVICE(&amp;s-&gt;gic),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0AW_H3_GIC_SPI_EHCI3));<br>
<br>
-=C2=A0 =C2=A0 sysbus_create_simple(&quot;sysbus-ohci&quot;, s-&gt;memmap[A=
W_H3_OHCI0],<br>
+=C2=A0 =C2=A0 sysbus_create_simple(&quot;sysbus-ohci&quot;, s-&gt;memmap[A=
W_H3_DEV_OHCI0],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 qdev_get_gpio_in(DEVICE(&amp;s-&gt;gic),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0AW_H3_GIC_SPI_OHCI0));<br>
-=C2=A0 =C2=A0 sysbus_create_simple(&quot;sysbus-ohci&quot;, s-&gt;memmap[A=
W_H3_OHCI1],<br>
+=C2=A0 =C2=A0 sysbus_create_simple(&quot;sysbus-ohci&quot;, s-&gt;memmap[A=
W_H3_DEV_OHCI1],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 qdev_get_gpio_in(DEVICE(&amp;s-&gt;gic),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0AW_H3_GIC_SPI_OHCI1));<br>
-=C2=A0 =C2=A0 sysbus_create_simple(&quot;sysbus-ohci&quot;, s-&gt;memmap[A=
W_H3_OHCI2],<br>
+=C2=A0 =C2=A0 sysbus_create_simple(&quot;sysbus-ohci&quot;, s-&gt;memmap[A=
W_H3_DEV_OHCI2],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 qdev_get_gpio_in(DEVICE(&amp;s-&gt;gic),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0AW_H3_GIC_SPI_OHCI2));<br>
-=C2=A0 =C2=A0 sysbus_create_simple(&quot;sysbus-ohci&quot;, s-&gt;memmap[A=
W_H3_OHCI3],<br>
+=C2=A0 =C2=A0 sysbus_create_simple(&quot;sysbus-ohci&quot;, s-&gt;memmap[A=
W_H3_DEV_OHCI3],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 qdev_get_gpio_in(DEVICE(&amp;s-&gt;gic),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0AW_H3_GIC_SPI_OHCI3));<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* UART0. For future clocktree API: All UARTS are conne=
cted to APB2_CLK. */<br>
-=C2=A0 =C2=A0 serial_mm_init(get_system_memory(), s-&gt;memmap[AW_H3_UART0=
], 2,<br>
+=C2=A0 =C2=A0 serial_mm_init(get_system_memory(), s-&gt;memmap[AW_H3_DEV_U=
ART0], 2,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_=
get_gpio_in(DEVICE(&amp;s-&gt;gic), AW_H3_GIC_SPI_UART0),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 11520=
0, serial_hd(0), DEVICE_NATIVE_ENDIAN);<br>
=C2=A0 =C2=A0 =C2=A0/* UART1 */<br>
-=C2=A0 =C2=A0 serial_mm_init(get_system_memory(), s-&gt;memmap[AW_H3_UART1=
], 2,<br>
+=C2=A0 =C2=A0 serial_mm_init(get_system_memory(), s-&gt;memmap[AW_H3_DEV_U=
ART1], 2,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_=
get_gpio_in(DEVICE(&amp;s-&gt;gic), AW_H3_GIC_SPI_UART1),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 11520=
0, serial_hd(1), DEVICE_NATIVE_ENDIAN);<br>
=C2=A0 =C2=A0 =C2=A0/* UART2 */<br>
-=C2=A0 =C2=A0 serial_mm_init(get_system_memory(), s-&gt;memmap[AW_H3_UART2=
], 2,<br>
+=C2=A0 =C2=A0 serial_mm_init(get_system_memory(), s-&gt;memmap[AW_H3_DEV_U=
ART2], 2,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_=
get_gpio_in(DEVICE(&amp;s-&gt;gic), AW_H3_GIC_SPI_UART2),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 11520=
0, serial_hd(2), DEVICE_NATIVE_ENDIAN);<br>
=C2=A0 =C2=A0 =C2=A0/* UART3 */<br>
-=C2=A0 =C2=A0 serial_mm_init(get_system_memory(), s-&gt;memmap[AW_H3_UART3=
], 2,<br>
+=C2=A0 =C2=A0 serial_mm_init(get_system_memory(), s-&gt;memmap[AW_H3_DEV_U=
ART3], 2,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_=
get_gpio_in(DEVICE(&amp;s-&gt;gic), AW_H3_GIC_SPI_UART3),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 11520=
0, serial_hd(3), DEVICE_NATIVE_ENDIAN);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* DRAMC */<br>
=C2=A0 =C2=A0 =C2=A0sysbus_realize(SYS_BUS_DEVICE(&amp;s-&gt;dramc), &amp;e=
rror_fatal);<br>
-=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;dramc), 0, s-&gt;m=
emmap[AW_H3_DRAMCOM]);<br>
-=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;dramc), 1, s-&gt;m=
emmap[AW_H3_DRAMCTL]);<br>
-=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;dramc), 2, s-&gt;m=
emmap[AW_H3_DRAMPHY]);<br>
+=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;dramc), 0, s-&gt;m=
emmap[AW_H3_DEV_DRAMCOM]);<br>
+=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;dramc), 1, s-&gt;m=
emmap[AW_H3_DEV_DRAMCTL]);<br>
+=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;dramc), 2, s-&gt;m=
emmap[AW_H3_DEV_DRAMPHY]);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* RTC */<br>
=C2=A0 =C2=A0 =C2=A0sysbus_realize(SYS_BUS_DEVICE(&amp;s-&gt;rtc), &amp;err=
or_fatal);<br>
-=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;rtc), 0, s-&gt;mem=
map[AW_H3_RTC]);<br>
+=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;rtc), 0, s-&gt;mem=
map[AW_H3_DEV_RTC]);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Unimplemented devices */<br>
=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; ARRAY_SIZE(unimplemented); i++) {<=
br>
diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c<br>
index 1679468232..17a568a2b4 100644<br>
--- a/hw/arm/orangepi.c<br>
+++ b/hw/arm/orangepi.c<br>
@@ -79,7 +79,7 @@ static void orangepi_init(MachineState *machine)<br>
=C2=A0 =C2=A0 =C2=A0object_property_set_int(OBJECT(&amp;h3-&gt;emac), &quot=
;phy-addr&quot;, 1, &amp;error_abort);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* DRAMC */<br>
-=C2=A0 =C2=A0 object_property_set_uint(OBJECT(h3), &quot;ram-addr&quot;, h=
3-&gt;memmap[AW_H3_SDRAM],<br>
+=C2=A0 =C2=A0 object_property_set_uint(OBJECT(h3), &quot;ram-addr&quot;, h=
3-&gt;memmap[AW_H3_DEV_SDRAM],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;error_abort);<br>
=C2=A0 =C2=A0 =C2=A0object_property_set_int(OBJECT(h3), &quot;ram-size&quot=
;, machine-&gt;ram_size / MiB,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;error_abort);<br>
@@ -98,7 +98,7 @@ static void orangepi_init(MachineState *machine)<br>
=C2=A0 =C2=A0 =C2=A0qdev_realize_and_unref(carddev, bus, &amp;error_fatal);=
<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* SDRAM */<br>
-=C2=A0 =C2=A0 memory_region_add_subregion(get_system_memory(), h3-&gt;memm=
ap[AW_H3_SDRAM],<br>
+=C2=A0 =C2=A0 memory_region_add_subregion(get_system_memory(), h3-&gt;memm=
ap[AW_H3_DEV_SDRAM],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0machine-&gt;ram);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Load target kernel or start using BootROM */<br>
@@ -106,7 +106,7 @@ static void orangepi_init(MachineState *machine)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Use Boot ROM to copy data from SD card=
 to SRAM */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0allwinner_h3_bootrom_setup(h3, blk);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 orangepi_binfo.loader_start =3D h3-&gt;memmap[AW_H3_SDRAM];<=
br>
+=C2=A0 =C2=A0 orangepi_binfo.loader_start =3D h3-&gt;memmap[AW_H3_DEV_SDRA=
M];<br>
=C2=A0 =C2=A0 =C2=A0orangepi_binfo.ram_size =3D machine-&gt;ram_size;<br>
=C2=A0 =C2=A0 =C2=A0arm_load_kernel(ARM_CPU(first_cpu), machine, &amp;orang=
epi_binfo);<br>
=C2=A0}<br>
-- <br>
2.26.2<br>
<br>
</blockquote></div></div></div>

--000000000000cd2f0805ad6870b2--

