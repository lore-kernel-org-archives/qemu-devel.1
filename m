Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44840C432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 07:27:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 174D32082F
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 07:27:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 174D32082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD1i9-0004HT-HQ
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 03:27:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43134)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iD1a8-0004iP-Dk
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 03:19:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iD1a4-0006d5-QV
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 03:19:24 -0400
Received: from 4.mo6.mail-out.ovh.net ([87.98.184.159]:47827)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iD1a4-0006cN-I4
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 03:19:20 -0400
Received: from player699.ha.ovh.net (unknown [10.108.54.203])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id 3D3171E1113
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 09:19:18 +0200 (CEST)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player699.ha.ovh.net (Postfix) with ESMTPSA id 9DD17A303DC2;
 Wed, 25 Sep 2019 07:19:07 +0000 (UTC)
Subject: Re: [PATCH 13/20] spapr: Eliminate SpaprIrq:get_nodename method
To: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
References: <20190925064534.19155-1-david@gibson.dropbear.id.au>
 <20190925064534.19155-14-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <977a953b-a23f-f653-5afd-3c87a44b9f93@kaod.org>
Date: Wed, 25 Sep 2019 09:19:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190925064534.19155-14-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 1510113254343019480
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrfedugdduvddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 87.98.184.159
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
Cc: Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 groug@kaod.org, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/09/2019 08:45, David Gibson wrote:
> This method is used to determine the name of the irq backend's node in =
the
> device tree, so that we can find its phandle (after SLOF may have modif=
ied
> it from the phandle we initially gave it).
>=20
> But, in the two cases the only difference between the node name is the
> presence of a unit address.  Searching for a node name without consider=
ing
> unit address is standard practice for the device tree, and
> fdt_subnode_offset() will do exactly that.
>=20
> So, the method is unnecessary.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

> ---
>  hw/ppc/spapr_irq.c         | 25 +++----------------------
>  include/hw/ppc/spapr_irq.h |  1 -
>  2 files changed, 3 insertions(+), 23 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 038bfffff4..79167ccc68 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -211,11 +211,6 @@ static void spapr_irq_reset_xics(SpaprMachineState=
 *spapr, Error **errp)
>      }
>  }
> =20
> -static const char *spapr_irq_get_nodename_xics(SpaprMachineState *spap=
r)
> -{
> -    return XICS_NODENAME;
> -}
> -
>  static void spapr_irq_init_kvm_xics(SpaprMachineState *spapr, Error **=
errp)
>  {
>      if (kvm_enabled()) {
> @@ -237,7 +232,6 @@ SpaprIrq spapr_irq_xics =3D {
>      .post_load   =3D spapr_irq_post_load_xics,
>      .reset       =3D spapr_irq_reset_xics,
>      .set_irq     =3D spapr_irq_set_irq_xics,
> -    .get_nodename =3D spapr_irq_get_nodename_xics,
>      .init_kvm    =3D spapr_irq_init_kvm_xics,
>  };
> =20
> @@ -362,11 +356,6 @@ static void spapr_irq_set_irq_xive(void *opaque, i=
nt irq, int val)
>      }
>  }
> =20
> -static const char *spapr_irq_get_nodename_xive(SpaprMachineState *spap=
r)
> -{
> -    return spapr->xive->nodename;
> -}
> -
>  static void spapr_irq_init_kvm_xive(SpaprMachineState *spapr, Error **=
errp)
>  {
>      if (kvm_enabled()) {
> @@ -393,7 +382,6 @@ SpaprIrq spapr_irq_xive =3D {
>      .post_load   =3D spapr_irq_post_load_xive,
>      .reset       =3D spapr_irq_reset_xive,
>      .set_irq     =3D spapr_irq_set_irq_xive,
> -    .get_nodename =3D spapr_irq_get_nodename_xive,
>      .init_kvm    =3D spapr_irq_init_kvm_xive,
>  };
> =20
> @@ -538,11 +526,6 @@ static void spapr_irq_set_irq_dual(void *opaque, i=
nt irq, int val)
>      spapr_irq_current(spapr)->set_irq(spapr, irq, val);
>  }
> =20
> -static const char *spapr_irq_get_nodename_dual(SpaprMachineState *spap=
r)
> -{
> -    return spapr_irq_current(spapr)->get_nodename(spapr);
> -}
> -
>  /*
>   * Define values in sync with the XIVE and XICS backend
>   */
> @@ -560,7 +543,6 @@ SpaprIrq spapr_irq_dual =3D {
>      .post_load   =3D spapr_irq_post_load_dual,
>      .reset       =3D spapr_irq_reset_dual,
>      .set_irq     =3D spapr_irq_set_irq_dual,
> -    .get_nodename =3D spapr_irq_get_nodename_dual,
>      .init_kvm    =3D NULL, /* should not be used */
>  };
> =20
> @@ -697,13 +679,13 @@ void spapr_irq_reset(SpaprMachineState *spapr, Er=
ror **errp)
> =20
>  int spapr_irq_get_phandle(SpaprMachineState *spapr, void *fdt, Error *=
*errp)
>  {
> -    const char *nodename =3D spapr->irq->get_nodename(spapr);
> +    const char *nodename =3D "interrupt-controller";
>      int offset, phandle;
> =20
>      offset =3D fdt_subnode_offset(fdt, 0, nodename);
>      if (offset < 0) {
> -        error_setg(errp, "Can't find node \"%s\": %s", nodename,
> -                   fdt_strerror(offset));
> +        error_setg(errp, "Can't find node \"%s\": %s",
> +                   nodename, fdt_strerror(offset));
>          return -1;
>      }
> =20
> @@ -787,6 +769,5 @@ SpaprIrq spapr_irq_xics_legacy =3D {
>      .post_load   =3D spapr_irq_post_load_xics,
>      .reset       =3D spapr_irq_reset_xics,
>      .set_irq     =3D spapr_irq_set_irq_xics,
> -    .get_nodename =3D spapr_irq_get_nodename_xics,
>      .init_kvm    =3D spapr_irq_init_kvm_xics,
>  };
> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> index a4e790ef60..9b60378e28 100644
> --- a/include/hw/ppc/spapr_irq.h
> +++ b/include/hw/ppc/spapr_irq.h
> @@ -52,7 +52,6 @@ typedef struct SpaprIrq {
>      int (*post_load)(SpaprMachineState *spapr, int version_id);
>      void (*reset)(SpaprMachineState *spapr, Error **errp);
>      void (*set_irq)(void *opaque, int srcno, int val);
> -    const char *(*get_nodename)(SpaprMachineState *spapr);
>      void (*init_kvm)(SpaprMachineState *spapr, Error **errp);
>  } SpaprIrq;
> =20
>=20


