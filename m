Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4974EC2BABC
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 06:48:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 223B320692
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 06:48:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 223B320692
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLi2F-0000NS-81
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 02:48:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37128)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1jLi0x-0007PG-5k
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 02:47:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1jLi0w-00061G-0C
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 02:47:15 -0400
Received: from 4.mo1.mail-out.ovh.net ([46.105.76.26]:40687)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1jLi0v-00060o-RC
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 02:47:13 -0400
Received: from player796.ha.ovh.net (unknown [10.108.57.16])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id 338761BA5EA
 for <qemu-devel@nongnu.org>; Tue,  7 Apr 2020 08:47:11 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player796.ha.ovh.net (Postfix) with ESMTPSA id 06B58111FB81A;
 Tue,  7 Apr 2020 06:47:04 +0000 (UTC)
Subject: Re: [PATCH-for-5.1 v2 06/54] hw/arm/aspeed_soc: Move some code from
 realize() to init()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
References: <20200406174743.16956-1-f4bug@amsat.org>
 <20200406174743.16956-7-f4bug@amsat.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <4f59c4d6-14dd-3751-18ac-aea0052e7179@kaod.org>
Date: Tue, 7 Apr 2020 08:47:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200406174743.16956-7-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 2445173125435329456
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrudeggdduuddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpeegnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejleeirdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.76.26
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/6/20 7:46 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Coccinelle reported:
>=20
>   $ spatch ... --timeout 60 --sp-file \
>     scripts/coccinelle/simplify-init-realize-error_propagate.cocci
>   HANDLING: ./hw/arm/aspeed_soc.c
>   >>> possible moves from aspeed_soc_init() to aspeed_soc_realize() in =
./hw/arm/aspeed_soc.c:231
>=20
> Move the calls using &error_fatal which don't depend of input
> updated before realize() to init().
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.=20

> ---
>  hw/arm/aspeed_soc.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
> index 696c7fda14..debd7c8faa 100644
> --- a/hw/arm/aspeed_soc.c
> +++ b/hw/arm/aspeed_soc.c
> @@ -183,6 +183,7 @@ static void aspeed_soc_init(Object *obj)
>          snprintf(typename, sizeof(typename), "aspeed.spi%d-%s", i + 1,=
 socname);
>          sysbus_init_child_obj(obj, "spi[*]", OBJECT(&s->spi[i]),
>                                sizeof(s->spi[i]), typename);
> +        object_property_set_int(OBJECT(&s->spi[i]), 1, "num-cs", &erro=
r_abort);
>      }
> =20
>      for (i =3D 0; i < sc->ehcis_num; i++) {
> @@ -360,10 +361,7 @@ static void aspeed_soc_realize(DeviceState *dev, E=
rror **errp)
> =20
>      /* SPI */
>      for (i =3D 0; i < sc->spis_num; i++) {
> -        object_property_set_int(OBJECT(&s->spi[i]), 1, "num-cs", &err)=
;
> -        object_property_set_bool(OBJECT(&s->spi[i]), true, "realized",
> -                                 &local_err);
> -        error_propagate(&err, local_err);
> +        object_property_set_bool(OBJECT(&s->spi[i]), true, "realized",=
 &err);
>          if (err) {
>              error_propagate(errp, err);
>              return;
>=20


