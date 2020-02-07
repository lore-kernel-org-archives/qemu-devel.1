Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E530AC04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 15:42:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB20720720
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 15:42:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB20720720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j05lq-0003UJ-Uf
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 10:42:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44392)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1j05kb-0002QP-6C
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 10:41:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1j05kZ-0007qA-U7
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 10:41:00 -0500
Received: from 5.mo1.mail-out.ovh.net ([178.33.45.107]:33578)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1j05kZ-0007pW-NC
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 10:40:59 -0500
Received: from player763.ha.ovh.net (unknown [10.110.115.3])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id 921451ADECA
 for <qemu-devel@nongnu.org>; Fri,  7 Feb 2020 16:40:57 +0100 (CET)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player763.ha.ovh.net (Postfix) with ESMTPSA id 36D9AF1DE094;
 Fri,  7 Feb 2020 15:40:51 +0000 (UTC)
Subject: Re: [PATCH] hw/arm: ast2600: Wire up EHCI controllers
To: Guenter Roeck <linux@roeck-us.net>
References: <20200207144954.13634-1-linux@roeck-us.net>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <436fbb5b-e3b2-600b-79d6-469459eb947e@kaod.org>
Date: Fri, 7 Feb 2020 16:40:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200207144954.13634-1-linux@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 9586193285964729152
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrheehgdektdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrieegrddvhedtrddujedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeeifedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.45.107
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/7/20 3:49 PM, Guenter Roeck wrote:
> Initialize EHCI controllers on AST2600 using the existing
> TYPE_PLATFORM_EHCI. After this change, booting ast2600-evb
> into Linux successfully instantiates a USB interface after
> the necessary changes are made to its devicetree files.
>=20
> ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> ehci-platform: EHCI generic platform driver
> ehci-platform 1e6a3000.usb: EHCI Host Controller
> ehci-platform 1e6a3000.usb: new USB bus registered, assigned bus number=
 1
> ehci-platform 1e6a3000.usb: irq 25, io mem 0x1e6a3000
> ehci-platform 1e6a3000.usb: USB 2.0 started, EHCI 1.00
> usb usb1: Manufacturer: Linux 5.5.0-09825-ga0802f2d0ef5-dirty ehci_hcd
> usb 1-1: new high-speed USB device number 2 using ehci-platform
>=20
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

> ---
>  hw/arm/aspeed_ast2600.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>=20
> diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
> index 931887ac68..a528251c8d 100644
> --- a/hw/arm/aspeed_ast2600.c
> +++ b/hw/arm/aspeed_ast2600.c
> @@ -31,6 +31,8 @@ static const hwaddr aspeed_soc_ast2600_memmap[] =3D {
>      [ASPEED_FMC]       =3D 0x1E620000,
>      [ASPEED_SPI1]      =3D 0x1E630000,
>      [ASPEED_SPI2]      =3D 0x1E641000,
> +    [ASPEED_EHCI1]     =3D 0x1E6A1000,
> +    [ASPEED_EHCI2]     =3D 0x1E6A3000,
>      [ASPEED_MII1]      =3D 0x1E650000,
>      [ASPEED_MII2]      =3D 0x1E650008,
>      [ASPEED_MII3]      =3D 0x1E650010,
> @@ -77,6 +79,8 @@ static const int aspeed_soc_ast2600_irqmap[] =3D {
>      [ASPEED_ADC]       =3D 78,
>      [ASPEED_XDMA]      =3D 6,
>      [ASPEED_SDHCI]     =3D 43,
> +    [ASPEED_EHCI1]     =3D 5,
> +    [ASPEED_EHCI2]     =3D 9,
>      [ASPEED_GPIO]      =3D 40,
>      [ASPEED_GPIO_1_8V] =3D 11,
>      [ASPEED_RTC]       =3D 13,
> @@ -167,6 +171,11 @@ static void aspeed_soc_ast2600_init(Object *obj)
>                                sizeof(s->spi[i]), typename);
>      }
> =20
> +    for (i =3D 0; i < sc->ehcis_num; i++) {
> +        sysbus_init_child_obj(obj, "ehci[*]", OBJECT(&s->ehci[i]),
> +                              sizeof(s->ehci[i]), TYPE_PLATFORM_EHCI);
> +    }
> +
>      snprintf(typename, sizeof(typename), "aspeed.sdmc-%s", socname);
>      sysbus_init_child_obj(obj, "sdmc", OBJECT(&s->sdmc), sizeof(s->sdm=
c),
>                            typename);
> @@ -395,6 +404,19 @@ static void aspeed_soc_ast2600_realize(DeviceState=
 *dev, Error **errp)
>                          s->spi[i].ctrl->flash_window_base);
>      }
> =20
> +    /* EHCI */
> +    for (i =3D 0; i < sc->ehcis_num; i++) {
> +        object_property_set_bool(OBJECT(&s->ehci[i]), true, "realized"=
, &err);
> +        if (err) {
> +            error_propagate(errp, err);
> +            return;
> +        }
> +        sysbus_mmio_map(SYS_BUS_DEVICE(&s->ehci[i]), 0,
> +                        sc->memmap[ASPEED_EHCI1 + i]);
> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->ehci[i]), 0,
> +                           aspeed_soc_get_irq(s, ASPEED_EHCI1 + i));
> +    }
> +
>      /* SDMC - SDRAM Memory Controller */
>      object_property_set_bool(OBJECT(&s->sdmc), true, "realized", &err)=
;
>      if (err) {
> @@ -499,6 +521,7 @@ static void aspeed_soc_ast2600_class_init(ObjectCla=
ss *oc, void *data)
>      sc->silicon_rev  =3D AST2600_A0_SILICON_REV;
>      sc->sram_size    =3D 0x10000;
>      sc->spis_num     =3D 2;
> +    sc->ehcis_num    =3D 2;
>      sc->wdts_num     =3D 4;
>      sc->macs_num     =3D 4;
>      sc->irqmap       =3D aspeed_soc_ast2600_irqmap;
>=20


