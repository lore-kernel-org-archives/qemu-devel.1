Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE29EC4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 08:28:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3626215EA
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 08:28:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3626215EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGIwr-0007Zo-Rr
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 04:28:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40320)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iGIw6-00078W-OK
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 04:27:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iGIw5-0005O7-Bz
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 04:27:38 -0400
Received: from 4.mo68.mail-out.ovh.net ([46.105.59.63]:54401)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iGIw5-0005KB-61
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 04:27:37 -0400
Received: from player715.ha.ovh.net (unknown [10.108.54.237])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id B675D145B76
 for <qemu-devel@nongnu.org>; Fri,  4 Oct 2019 10:27:27 +0200 (CEST)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player715.ha.ovh.net (Postfix) with ESMTPSA id DE788A640419;
 Fri,  4 Oct 2019 08:27:20 +0000 (UTC)
Subject: Re: [PATCH] xive: Make some device types not user creatable
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <157017473006.331610.2983143972519884544.stgit@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <c107d745-15a9-180a-b810-ba15ddaf7b6c@kaod.org>
Date: Fri, 4 Oct 2019 10:27:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <157017473006.331610.2983143972519884544.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 175358912191630144
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrhedtgdeijecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.59.63
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/10/2019 09:38, Greg Kurz wrote:
> Some device types of the XIVE model are exposed to the QEMU command
> line:
>=20
> $ ppc64-softmmu/qemu-system-ppc64 -device help | grep xive
> name "xive-end-source", desc "XIVE END Source"
> name "xive-source", desc "XIVE Interrupt Source"
> name "xive-tctx", desc "XIVE Interrupt Thread Context"
>=20
> These are internal devices that shouldn't be instantiable by the
> user. By the way, they can't be because their respective realize
> functions expect link properties that can't be set from the command
> line:
>=20
> qemu-system-ppc64: -device xive-source: required link 'xive' not found:
>  Property '.xive' not found
> qemu-system-ppc64: -device xive-end-source: required link 'xive' not fo=
und:
>  Property '.xive' not found
> qemu-system-ppc64: -device xive-tctx: required link 'cpu' not found:
>  Property '.cpu' not found
>=20
> Hide them by setting dc->user_creatable to false in their respective
> class init functions.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>


Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

> ---
>  hw/intc/xive.c |    3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 29df06df1136..6c54a35fd4bb 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -670,6 +670,7 @@ static void xive_tctx_class_init(ObjectClass *klass=
, void *data)
>      dc->realize =3D xive_tctx_realize;
>      dc->unrealize =3D xive_tctx_unrealize;
>      dc->vmsd =3D &vmstate_xive_tctx;
> +    dc->user_creatable =3D false;
>  }
> =20
>  static const TypeInfo xive_tctx_info =3D {
> @@ -1118,6 +1119,7 @@ static void xive_source_class_init(ObjectClass *k=
lass, void *data)
>      dc->props   =3D xive_source_properties;
>      dc->realize =3D xive_source_realize;
>      dc->vmsd    =3D &vmstate_xive_source;
> +    dc->user_creatable =3D false;
>  }
> =20
>  static const TypeInfo xive_source_info =3D {
> @@ -1853,6 +1855,7 @@ static void xive_end_source_class_init(ObjectClas=
s *klass, void *data)
>      dc->desc    =3D "XIVE END Source";
>      dc->props   =3D xive_end_source_properties;
>      dc->realize =3D xive_end_source_realize;
> +    dc->user_creatable =3D false;
>  }
> =20
>  static const TypeInfo xive_end_source_info =3D {
>=20


