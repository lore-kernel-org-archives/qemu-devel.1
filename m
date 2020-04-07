Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41ED6C2BA16
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 06:51:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04C4420692
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 06:51:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04C4420692
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLi4l-0003nL-7T
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 02:51:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37174)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1jLi16-0007k8-F3
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 02:47:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1jLi15-00067w-AM
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 02:47:24 -0400
Received: from 12.mo7.mail-out.ovh.net ([178.33.107.167]:51530)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1jLi15-00066V-4x
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 02:47:23 -0400
Received: from player746.ha.ovh.net (unknown [10.110.115.36])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id 86CF015DFE0
 for <qemu-devel@nongnu.org>; Tue,  7 Apr 2020 08:47:21 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player746.ha.ovh.net (Postfix) with ESMTPSA id 845451140AC3C;
 Tue,  7 Apr 2020 06:47:09 +0000 (UTC)
Subject: Re: [PATCH-for-5.1 v2 07/54] hw/arm/aspeed_soc: Simplify use of Error*
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
References: <20200406174743.16956-1-f4bug@amsat.org>
 <20200406174743.16956-8-f4bug@amsat.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <dafe223c-c314-c4d6-ad8d-ea5879b8fd1c@kaod.org>
Date: Tue, 7 Apr 2020 08:47:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200406174743.16956-8-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 2447987873965378480
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrudeggdduuddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejgeeirdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.107.167
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
> In the previous commit we noticed we don't need two different
> Error*, drop the one less used.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

It seems that the 'return' are badly aligned ?

Thanks,

C.=20


> ---
>  hw/arm/aspeed_soc.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
> index debd7c8faa..aa6d739ad0 100644
> --- a/hw/arm/aspeed_soc.c
> +++ b/hw/arm/aspeed_soc.c
> @@ -234,7 +234,7 @@ static void aspeed_soc_realize(DeviceState *dev, Er=
ror **errp)
>      int i;
>      AspeedSoCState *s =3D ASPEED_SOC(dev);
>      AspeedSoCClass *sc =3D ASPEED_SOC_GET_CLASS(s);
> -    Error *err =3D NULL, *local_err =3D NULL;
> +    Error *err =3D NULL;
> =20
>      /* IO space */
>      create_unimplemented_device("aspeed_soc.io", sc->memmap[ASPEED_IOM=
EM],
> @@ -413,9 +413,12 @@ static void aspeed_soc_realize(DeviceState *dev, E=
rror **errp)
>          qdev_set_nic_properties(DEVICE(&s->ftgmac100[i]), &nd_table[i]=
);
>          object_property_set_bool(OBJECT(&s->ftgmac100[i]), true, "aspe=
ed",
>                                   &err);
> +        if (err) {
> +            error_propagate(errp, err);
> +           return;
> +        }
>          object_property_set_bool(OBJECT(&s->ftgmac100[i]), true, "real=
ized",
> -                                 &local_err);
> -        error_propagate(&err, local_err);
> +                                 &err);
>          if (err) {
>              error_propagate(errp, err);
>             return;
>=20


