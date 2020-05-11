Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A353C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 06:13:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1566B20720
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 06:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WpAi5HQd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1566B20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY1h5-00052k-5Q
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 02:13:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41174)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jY1gO-0004cb-3n
 for qemu-devel@nongnu.org; Mon, 11 May 2020 02:12:56 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42857)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jY1gM-0005GJ-Jx
 for qemu-devel@nongnu.org; Mon, 11 May 2020 02:12:55 -0400
Received: by mail-wr1-x442.google.com with SMTP id s8so9301404wrt.9
 for <qemu-devel@nongnu.org>; Sun, 10 May 2020 23:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Li7RVphi5h5A0MohYGs5ry0juk3NUSaOMhJnno8sD10=;
 b=WpAi5HQdy3CyZ9rG27UDFkhhvd62PPl9dPBSIk/uUc9lS+9+XrA6wtmIXFMvOzl6cP
 DJH9694nxW83TRQeXs33CnBlmBRpUFlOwKLOi6eUtP6B0/8kOn/BZdLEhzcSx9Wg5xfY
 YerY8WwFXlY55YA7DbxlfvtwSmcXw4AnqWr6h0hgAfPZ3lPEZHe1qJAmZaM9JdFDEsNZ
 ZjU/GPtlXuRms4A+HIL85dN/0FRCEnu7yh+mGtxiWJk6g/r3usaf6/liWZ32VGMyLWPG
 VuENqkn/5fGSyBOHHcH6JAUUKVVVtIMU5tIzFLd/BGgc00F8tXKm/WyHSDtiHucodpWI
 aD9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Li7RVphi5h5A0MohYGs5ry0juk3NUSaOMhJnno8sD10=;
 b=jubNnF1K2RZvd4aPslGNa1w4jLFB4Wjlhs2VdP/sxSlwQmsBx4MSRfnS6NheAYMxGd
 vS5aPXpXZZUA7/ndmdDQTA+3/1bmSbZnZ8ERTqRvMvRyLMbSFLixivMdQjnBpKgRshf+
 jO8Pu73zb5HPN1T4hePdJZFVOw/3/xbjXr2r0T/WHQ2GTupHWK7IeQCu20oxaE4T4lL2
 5SIT9DdThD6IPVqy5f0LZtIcwE19Bjon7f9GOubrQys1S2a6m0xPWBvEIXdIKx8wQ8Uy
 TKYGqNqLcAznklK9ynywrnP4nVrILRyb47uX+aJzb8LMcfE8wjWLTvzUr5qwfxD3dkJd
 c75g==
X-Gm-Message-State: AGi0PuYAlTWZLRhEMAlaJSzpv/EynKKiczd61BYISOVfVx+rWQTac6NP
 1on4/oqwm7HvSfcdBH/XjKol6074oe0paExwA3E=
X-Google-Smtp-Source: APiQypLEaicnI8exEcPkQqHzDPRaKenQTW9LB8jhF7sEsgDSyI4ytpMKwlTMH4usgRotG4m98lHF9mRu0z+1IEis1NY=
X-Received: by 2002:a5d:55c5:: with SMTP id i5mr11136934wrw.402.1589177572099; 
 Sun, 10 May 2020 23:12:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200510210128.18343-1-f4bug@amsat.org>
 <20200510210128.18343-10-f4bug@amsat.org>
In-Reply-To: <20200510210128.18343-10-f4bug@amsat.org>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Mon, 11 May 2020 08:12:39 +0200
Message-ID: <CAHiYmc4dt43BU41mFrHUv-dK_Xr34Ai8o3xtzXxYikhFaX-N2A@mail.gmail.com>
Subject: Re: [PATCH 09/12] hw/pci-host/bonito: Map the different PCI ranges
 more detailled
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Huacai Chen <chenhuacai@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Huacai Chen <chenhc@lemote.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D0=BD=D0=B5=D0=B4, 10. =D0=BC=D0=B0=D1=98 2020. =D1=83 23:01 Philippe Math=
ieu-Daud=C3=A9 <f4bug@amsat.org> =D1=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> Better describe the Bonito64 MEM HI/LO and I/O PCI ranges,
> add more PCI regions as unimplemented.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/pci-host/bonito.c | 30 ++++++++++++++++++++++++++----
>  1 file changed, 26 insertions(+), 4 deletions(-)
>
> diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
> index 9761780f44..90a6c52a38 100644
> --- a/hw/pci-host/bonito.c
> +++ b/hw/pci-host/bonito.c
> @@ -39,6 +39,7 @@
>   */
>
>  #include "qemu/osdep.h"
> +#include "qemu/units.h"
>  #include "qemu/error-report.h"
>  #include "hw/pci/pci.h"
>  #include "hw/irq.h"
> @@ -82,7 +83,7 @@
>  #define BONITO_PCILO1_BASE      0x14000000
>  #define BONITO_PCILO2_BASE      0x18000000
>  #define BONITO_PCIHI_BASE       0x20000000
> -#define BONITO_PCIHI_SIZE       0x20000000
> +#define BONITO_PCIHI_SIZE       0x60000000
>  #define BONITO_PCIHI_TOP        (BONITO_PCIHI_BASE + BONITO_PCIHI_SIZE -=
 1)
>  #define BONITO_PCIIO_BASE       0x1fd00000
>  #define BONITO_PCIIO_BASE_VA    0xbfd00000
> @@ -606,13 +607,25 @@ static void bonito_pcihost_realize(DeviceState *dev=
, Error **errp)
>      PCIHostState *phb =3D PCI_HOST_BRIDGE(dev);
>      BonitoState *bs =3D BONITO_PCI_HOST_BRIDGE(dev);
>
> -    memory_region_init(&bs->pci_mem, OBJECT(dev), "pci.mem", BONITO_PCIL=
O_SIZE);
> +    memory_region_init(&bs->pci_mem, OBJECT(dev), "pci.mem", BONITO_PCIH=
I_SIZE);
>      phb->bus =3D pci_register_root_bus(DEVICE(dev), "pci",
>                                       pci_bonito_set_irq, pci_bonito_map_=
irq,
>                                       dev, &bs->pci_mem, get_system_io(),
>                                       0x28, 32, TYPE_PCI_BUS);
> -    memory_region_add_subregion(get_system_memory(), BONITO_PCILO_BASE,
> -                                &bs->pci_mem);
> +
> +    MemoryRegion *pcimem_lo_alias =3D g_new(MemoryRegion, 3);
> +    for (size_t i =3D 0; i < 3; i++) {
> +        char *name =3D g_strdup_printf("pci.lomem%zu", i);
> +
> +        memory_region_init_alias(&pcimem_lo_alias[i], NULL, name,
> +                                 &bs->pci_mem, i * 64 * MiB, 64 * MiB);
> +        memory_region_add_subregion(get_system_memory(),
> +                                    BONITO_PCILO_BASE + i * 64 * MiB,
> +                                    &pcimem_lo_alias[i]);
> +        g_free(name);
> +    }
> +
> +    create_unimplemented_device("pci.io", 0x1fd00000, 1 * MiB);

Hi, Philippe.

I am delighted with the whole series, finally cleaning Bonito code feels go=
od.

I just want to ask you if it possible to get rid of constants like
0x1fd00000 (generally in this code, not limited to this patch), and
give the some nice "#define" names?

Yours,
Aleksandar

>  }
>
>  static void bonito_realize(PCIDevice *dev, Error **errp)
> @@ -620,6 +633,7 @@ static void bonito_realize(PCIDevice *dev, Error **er=
rp)
>      PCIBonitoState *s =3D PCI_BONITO(dev);
>      SysBusDevice *sysbus =3D SYS_BUS_DEVICE(s->pcihost);
>      PCIHostState *phb =3D PCI_HOST_BRIDGE(s->pcihost);
> +    BonitoState *bs =3D BONITO_PCI_HOST_BRIDGE(s->pcihost);
>
>      /*
>       * Bonito North Bridge, built on FPGA,
> @@ -652,6 +666,7 @@ static void bonito_realize(PCIDevice *dev, Error **er=
rp)
>      sysbus_init_mmio(sysbus, &s->iomem_ldma);
>      sysbus_mmio_map(sysbus, 3, 0x1fe00200);
>
> +    /* PCI copier */
>      memory_region_init_io(&s->iomem_cop, OBJECT(s), &bonito_cop_ops, s,
>                            "cop", 0x100);
>      sysbus_init_mmio(sysbus, &s->iomem_cop);
> @@ -669,6 +684,13 @@ static void bonito_realize(PCIDevice *dev, Error **e=
rrp)
>      sysbus_init_mmio(sysbus, &s->bonito_localio);
>      sysbus_mmio_map(sysbus, 6, BONITO_DEV_BASE);
>
> +    MemoryRegion *pcimem_alias =3D g_new(MemoryRegion, 1);
> +    memory_region_init_alias(pcimem_alias, NULL, "pci.mem.alias",
> +                             &bs->pci_mem, 0, BONITO_PCIHI_SIZE);
> +    memory_region_add_subregion(get_system_memory(),
> +                                0x20000000ul, pcimem_alias);
> +    create_unimplemented_device("PCI_2", 0x80000000ul, 2 * GiB); /* pci_=
hi */
> +
>      /* set the default value of north bridge pci config */
>      pci_set_word(dev->config + PCI_COMMAND, 0x0000);
>      pci_set_word(dev->config + PCI_STATUS, 0x0000);
> --
> 2.21.3
>

