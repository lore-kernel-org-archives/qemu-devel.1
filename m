Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE50C4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 09:03:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95EEF24680
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 09:03:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95EEF24680
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=adacore.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7F4u-0006lw-MO
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 04:03:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35866)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frederic.konrad@adacore.com>) id 1j7F49-0006F6-ET
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 04:02:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frederic.konrad@adacore.com>) id 1j7F47-00073x-Ns
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 04:02:45 -0500
Received: from mel.act-europe.fr ([2a02:2ab8:224:1::a0a:d2]:40683
 helo=smtp.eu.adacore.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
 id 1j7F44-0006fq-JW; Thu, 27 Feb 2020 04:02:40 -0500
Received: from localhost (localhost [127.0.0.1])
 by filtered-smtp.eu.adacore.com (Postfix) with ESMTP id BE4B98138A;
 Thu, 27 Feb 2020 10:02:35 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at eu.adacore.com
Received: from smtp.eu.adacore.com ([127.0.0.1])
 by localhost (smtp.eu.adacore.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Gpwi2i_A1Zjm; Thu, 27 Feb 2020 10:02:35 +0100 (CET)
Received: from localhost.localdomain (lfbn-tou-1-1471-22.w90-89.abo.wanadoo.fr
 [90.89.4.22])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp.eu.adacore.com (Postfix) with ESMTPSA id 38FCE81382;
 Thu, 27 Feb 2020 10:02:33 +0100 (CET)
Subject: Re: [PATCH v1 1/2] hw/arm: versal: Add support for the LPD ADMAs
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
References: <20200227154424.6849-1-edgar.iglesias@gmail.com>
 <20200227154424.6849-2-edgar.iglesias@gmail.com>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <8f5e9c5c-5ab9-fc17-5f4e-a11f7230db63@adacore.com>
Date: Thu, 27 Feb 2020 10:02:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200227154424.6849-2-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 2a02:2ab8:224:1::a0a:d2
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, alistair@alistair23.me,
 richard.henderson@linaro.org, qemu-arm@nongnu.org, philmd@redhat.com,
 luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



Le 2/27/20 =C3=A0 4:44 PM, Edgar E. Iglesias a =C3=A9crit=C2=A0:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>=20
> Add support for the Versal LPD ADMAs.
>=20
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Looks good to me.

Reviewed-by: KONRAD Frederic <frederic.konrad@adacore.com>

> ---
>   hw/arm/xlnx-versal.c         | 24 ++++++++++++++++++++++++
>   include/hw/arm/xlnx-versal.h |  6 ++++++
>   2 files changed, 30 insertions(+)
>=20
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index 1cf3daaf4f..f9beba07ed 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -193,6 +193,29 @@ static void versal_create_gems(Versal *s, qemu_irq=
 *pic)
>       }
>   }
>  =20
> +static void versal_create_admas(Versal *s, qemu_irq *pic)
> +{
> +    int i;
> +
> +    for (i =3D 0; i < ARRAY_SIZE(s->lpd.iou.adma); i++) {
> +        char *name =3D g_strdup_printf("adma%d", i);
> +        DeviceState *dev;
> +        MemoryRegion *mr;
> +
> +        dev =3D qdev_create(NULL, "xlnx.zdma");
> +        s->lpd.iou.adma[i] =3D SYS_BUS_DEVICE(dev);
> +        object_property_add_child(OBJECT(s), name, OBJECT(dev), &error=
_fatal);
> +        qdev_init_nofail(dev);
> +
> +        mr =3D sysbus_mmio_get_region(s->lpd.iou.adma[i], 0);
> +        memory_region_add_subregion(&s->mr_ps,
> +                                    MM_ADMA_CH0 + i * MM_ADMA_CH0_SIZE=
, mr);
> +
> +        sysbus_connect_irq(s->lpd.iou.adma[i], 0, pic[VERSAL_ADMA_IRQ_=
0 + i]);
> +        g_free(name);
> +    }
> +}
> +
>   /* This takes the board allocated linear DDR memory and creates alias=
es
>    * for each split DDR range/aperture on the Versal address map.
>    */
> @@ -274,6 +297,7 @@ static void versal_realize(DeviceState *dev, Error =
**errp)
>       versal_create_apu_gic(s, pic);
>       versal_create_uarts(s, pic);
>       versal_create_gems(s, pic);
> +    versal_create_admas(s, pic);
>       versal_map_ddr(s);
>       versal_unimp(s);
>  =20
> diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.=
h
> index d844c4ffe4..6c0a692b2f 100644
> --- a/include/hw/arm/xlnx-versal.h
> +++ b/include/hw/arm/xlnx-versal.h
> @@ -22,6 +22,7 @@
>   #define XLNX_VERSAL_NR_ACPUS   2
>   #define XLNX_VERSAL_NR_UARTS   2
>   #define XLNX_VERSAL_NR_GEMS    2
> +#define XLNX_VERSAL_NR_ADMAS   8
>   #define XLNX_VERSAL_NR_IRQS    192
>  =20
>   typedef struct Versal {
> @@ -50,6 +51,7 @@ typedef struct Versal {
>           struct {
>               SysBusDevice *uart[XLNX_VERSAL_NR_UARTS];
>               SysBusDevice *gem[XLNX_VERSAL_NR_GEMS];
> +            SysBusDevice *adma[XLNX_VERSAL_NR_ADMAS];
>           } iou;
>       } lpd;
>  =20
> @@ -74,6 +76,7 @@ typedef struct Versal {
>   #define VERSAL_GEM0_WAKE_IRQ_0     57
>   #define VERSAL_GEM1_IRQ_0          58
>   #define VERSAL_GEM1_WAKE_IRQ_0     59
> +#define VERSAL_ADMA_IRQ_0          60
>  =20
>   /* Architecturally reserved IRQs suitable for virtualization.  */
>   #define VERSAL_RSVD_IRQ_FIRST 111
> @@ -96,6 +99,9 @@ typedef struct Versal {
>   #define MM_GEM1                     0xff0d0000U
>   #define MM_GEM1_SIZE                0x10000
>  =20
> +#define MM_ADMA_CH0                 0xffa80000U
> +#define MM_ADMA_CH0_SIZE            0x10000
> +
>   #define MM_OCM                      0xfffc0000U
>   #define MM_OCM_SIZE                 0x40000
>  =20
>=20

