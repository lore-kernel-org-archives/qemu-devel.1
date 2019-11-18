Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D7EC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 19:48:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B5482230F
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 19:48:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B5482230F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWn0X-0005TG-4d
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 14:48:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50011)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iWmzA-0004cg-TB
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 14:47:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iWmyy-0008Se-PM
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 14:46:54 -0500
Received: from 2.mo68.mail-out.ovh.net ([46.105.52.162]:59568)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iWmyy-0008MJ-GL
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 14:46:44 -0500
Received: from player730.ha.ovh.net (unknown [10.109.146.50])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id 3A14514BCF4
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 20:46:21 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player730.ha.ovh.net (Postfix) with ESMTPSA id 28589C1EB369;
 Mon, 18 Nov 2019 19:46:11 +0000 (UTC)
Date: Mon, 18 Nov 2019 20:46:09 +0100
From: Greg Kurz <groug@kaod.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH for-5.0 2/2] aspeed: change the "nic" property definition
Message-ID: <20191118204609.33f06000@bahia.lan>
In-Reply-To: <20191118161712.6712-3-clg@kaod.org>
References: <20191118161712.6712-1-clg@kaod.org>
 <20191118161712.6712-3-clg@kaod.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 17657488241173961099
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudegiedguddtkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjqdffgfeufgfipdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtqhertdertdejnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejfedtrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.52.162
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

On Mon, 18 Nov 2019 17:17:12 +0100
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> The Aspeed MII model has a link pointing to its associated FTGMAC100
> NIC in the machine.
>=20
> Change the "nic" property definition so that it explicitly sets the
> pointer. The property isn't optional : not being able to set the link
> is a bug and QEMU should rather abort than exit in this case.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/arm/aspeed_ast2600.c |  5 ++---
>  hw/net/ftgmac100.c      | 19 +++++++++----------
>  2 files changed, 11 insertions(+), 13 deletions(-)
>=20
> diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
> index 810fd7de0c06..be88005dab8f 100644
> --- a/hw/arm/aspeed_ast2600.c
> +++ b/hw/arm/aspeed_ast2600.c
> @@ -183,9 +183,6 @@ static void aspeed_soc_ast2600_init(Object *obj)
> =20
>          sysbus_init_child_obj(obj, "mii[*]", &s->mii[i], sizeof(s->mii[i=
]),
>                                TYPE_ASPEED_MII);
> -        object_property_add_const_link(OBJECT(&s->mii[i]), "nic",
> -                                       OBJECT(&s->ftgmac100[i]),
> -                                       &error_abort);
>      }
> =20
>      sysbus_init_child_obj(obj, "xdma", OBJECT(&s->xdma), sizeof(s->xdma),
> @@ -441,6 +438,8 @@ static void aspeed_soc_ast2600_realize(DeviceState *d=
ev, Error **errp)
>          sysbus_connect_irq(SYS_BUS_DEVICE(&s->ftgmac100[i]), 0,
>                             aspeed_soc_get_irq(s, ASPEED_ETH1 + i));
> =20
> +        object_property_set_link(OBJECT(&s->mii[i]), OBJECT(&s->ftgmac10=
0[i]),
> +                                 "nic", &error_abort);
>          object_property_set_bool(OBJECT(&s->mii[i]), true, "realized",
>                                   &err);
>          if (err) {
> diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
> index eb8b441461a1..86ac25894a89 100644
> --- a/hw/net/ftgmac100.c
> +++ b/hw/net/ftgmac100.c
> @@ -1204,17 +1204,8 @@ static void aspeed_mii_realize(DeviceState *dev, E=
rror **errp)
>  {
>      AspeedMiiState *s =3D ASPEED_MII(dev);
>      SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
> -    Object *obj;
> -    Error *local_err =3D NULL;
> =20
> -    obj =3D object_property_get_link(OBJECT(dev), "nic", &local_err);
> -    if (!obj) {
> -        error_propagate(errp, local_err);
> -        error_prepend(errp, "required link 'nic' not found: ");
> -        return;
> -    }
> -
> -    s->nic =3D FTGMAC100(obj);
> +    assert(s->nic);
> =20
>      memory_region_init_io(&s->iomem, OBJECT(dev), &aspeed_mii_ops, s,
>                            TYPE_ASPEED_MII, 0x8);
> @@ -1231,6 +1222,13 @@ static const VMStateDescription vmstate_aspeed_mii=
 =3D {
>          VMSTATE_END_OF_LIST()
>      }
>  };
> +
> +static Property aspeed_mii_properties[] =3D {
> +    DEFINE_PROP_LINK("nic", AspeedMiiState, nic, TYPE_FTGMAC100,
> +                     FTGMAC100State *),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
>  static void aspeed_mii_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> @@ -1239,6 +1237,7 @@ static void aspeed_mii_class_init(ObjectClass *klas=
s, void *data)
>      dc->reset =3D aspeed_mii_reset;
>      dc->realize =3D aspeed_mii_realize;
>      dc->desc =3D "Aspeed MII controller";
> +    dc->props =3D aspeed_mii_properties;
>  }
> =20
>  static const TypeInfo aspeed_mii_info =3D {


