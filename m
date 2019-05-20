Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9831C04AAF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 07:17:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F5462081C
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 07:17:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F5462081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59327 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hScYK-0001qi-Hz
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 03:17:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hScXK-0001Tk-Ng
	for qemu-devel@nongnu.org; Mon, 20 May 2019 03:16:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hScXG-0000yB-PV
	for qemu-devel@nongnu.org; Mon, 20 May 2019 03:16:42 -0400
Received: from 17.mo7.mail-out.ovh.net ([188.165.35.227]:48824)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1hScXF-0000xI-3a
	for qemu-devel@nongnu.org; Mon, 20 May 2019 03:16:37 -0400
Received: from player699.ha.ovh.net (unknown [10.109.146.106])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id 7E55511D1B3
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 09:16:33 +0200 (CEST)
Received: from kaod.org (lfbn-1-10649-41.w90-89.abo.wanadoo.fr [90.89.235.41])
	(Authenticated sender: clg@kaod.org)
	by player699.ha.ovh.net (Postfix) with ESMTPSA id A3C7E5EB9E62;
	Mon, 20 May 2019 07:16:26 +0000 (UTC)
To: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
	aik@ozlabs.ru, lvivier@redhat.com
References: <20190520060550.29481-1-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <b3b1e319-cc19-54e1-2aa8-de8eb7d03f73@kaod.org>
Date: Mon, 20 May 2019 09:16:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190520060550.29481-1-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 6075637375202397020
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddruddtjedguddvudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 188.165.35.227
Subject: Re: [Qemu-devel] [PATCH] Fix phb_placement backwards compatibility
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: gkurz@kaod.org, alex.williamson@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/20/19 8:05 AM, David Gibson wrote:
> When we added support for NVLink2 passthrough devices, we changed the
> phb_placement hook to handle the placement of NVLink2 bridges' specific
> resources.  For compatibility we use a version that doesn't do this
> allocation  for old machine types.
>=20
> However, because of the delay between when the patch was posted and whe=
n
> it was merged, we ended up with that compatibility hook applying for
> machine versions 3.1 and earlier whereas it should apply for 4.0 and
> earlier (since the patch was applied early in the 4.1 tree).
>=20
> Fixes: ec132efaa81 "spapr: Support NVIDIA V100 GPU with NVLink2"
>=20
> Reported-by: Laurent Vivier <lvivier@redhat.com>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>



Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>  hw/ppc/spapr.c | 28 +++++++++++++++-------------
>  1 file changed, 15 insertions(+), 13 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index bcae30ad26..39e698e9b0 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4411,18 +4411,7 @@ DEFINE_SPAPR_MACHINE(4_1, "4.1", true);
>  /*
>   * pseries-4.0
>   */
> -static void spapr_machine_4_0_class_options(MachineClass *mc)
> -{
> -    spapr_machine_4_1_class_options(mc);
> -    compat_props_add(mc->compat_props, hw_compat_4_0, hw_compat_4_0_le=
n);
> -}
> -
> -DEFINE_SPAPR_MACHINE(4_0, "4.0", false);
> -
> -/*
> - * pseries-3.1
> - */
> -static void phb_placement_3_1(SpaprMachineState *spapr, uint32_t index=
,
> +static void phb_placement_4_0(SpaprMachineState *spapr, uint32_t index=
,
>                                uint64_t *buid, hwaddr *pio,
>                                hwaddr *mmio32, hwaddr *mmio64,
>                                unsigned n_dma, uint32_t *liobns,
> @@ -4434,6 +4423,20 @@ static void phb_placement_3_1(SpaprMachineState =
*spapr, uint32_t index,
>      *nv2atsd =3D 0;
>  }
> =20
> +static void spapr_machine_4_0_class_options(MachineClass *mc)
> +{
> +    SpaprMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
> +
> +    spapr_machine_4_1_class_options(mc);
> +    compat_props_add(mc->compat_props, hw_compat_4_0, hw_compat_4_0_le=
n);
> +    smc->phb_placement =3D phb_placement_4_0;
> +}
> +
> +DEFINE_SPAPR_MACHINE(4_0, "4.0", false);
> +
> +/*
> + * pseries-3.1
> + */
>  static void spapr_machine_3_1_class_options(MachineClass *mc)
>  {
>      SpaprMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
> @@ -4449,7 +4452,6 @@ static void spapr_machine_3_1_class_options(Machi=
neClass *mc)
>      smc->default_caps.caps[SPAPR_CAP_SBBC] =3D SPAPR_CAP_BROKEN;
>      smc->default_caps.caps[SPAPR_CAP_IBS] =3D SPAPR_CAP_BROKEN;
>      smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] =3D SPAPR_CAP_=
OFF;
> -    smc->phb_placement =3D phb_placement_3_1;
>  }
> =20
>  DEFINE_SPAPR_MACHINE(3_1, "3.1", false);
>=20


