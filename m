Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C045C5B57D
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 03:03:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E7A921721
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 03:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="G6er8AzM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E7A921721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiVYH-0000Vk-9K
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 23:03:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35732)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hiVXA-0007tV-EN
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 23:02:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hiVX0-0007Du-5W
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 23:02:06 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:37107)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hiVWy-0006zq-6T; Tue, 02 Jul 2019 23:02:01 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45dm914NBYz9s8m; Wed,  3 Jul 2019 13:01:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1562122901;
 bh=rgCX0IrJYCxPv+qq1Hfy049nCoVrO9NBgLbWwx3lc4E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=G6er8AzMR2GiexQ8XQXLJ1IOtTnjB9ioz/ocnryCYmj6l0886vS0e6MEHbN1DAYXB
 wm+6Ol8kmAwF8n0yof/wwTANTDrFb5IFei2N286rXhUGlcgAQ1K1rycj0YgbdtXgOu
 EoXhs8nNzmbe3yqdvRG2IJKmR+pnCdy18lqsXP58=
Date: Wed, 3 Jul 2019 12:07:48 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Message-ID: <20190703020748.GD9442@umbus.fritz.box>
References: <20190630204601.30574-1-clg@kaod.org>
 <20190630204601.30574-9-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="k4f25fnPtRuIRUb3"
Content-Disposition: inline
In-Reply-To: <20190630204601.30574-9-clg@kaod.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH 08/10] ppc/xive: Extend XiveTCTX with an
 router object pointer
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
Cc: qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--k4f25fnPtRuIRUb3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 30, 2019 at 10:45:59PM +0200, C=E9dric Le Goater wrote:
> This is to perform lookups in the NVT table when a vCPU is dispatched
> and possibly resend interrupts.

I'm slightly confused by this one.  Aren't there multiple router
objects, each of which can deliver to any thread?  In which case what
router object is associated with a specific TCTX?

> Future XIVE chip will use a different class for the model of the
> interrupt controller. So use an 'Object *' instead of a 'XiveRouter *'.

This seems odd to me, shouldn't it be an interface pointer or
something in that case?

> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

> ---
>  include/hw/ppc/xive.h |  4 +++-
>  hw/intc/xive.c        | 11 ++++++++++-
>  hw/ppc/pnv.c          |  2 +-
>  hw/ppc/spapr_irq.c    |  2 +-
>  4 files changed, 15 insertions(+), 4 deletions(-)
>=20
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index d922524982d3..b764e1e4e6d4 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -321,6 +321,8 @@ typedef struct XiveTCTX {
>      qemu_irq    os_output;
> =20
>      uint8_t     regs[XIVE_TM_RING_COUNT * XIVE_TM_RING_SIZE];
> +
> +    Object      *xrtr;
>  } XiveTCTX;
> =20
>  /*
> @@ -416,7 +418,7 @@ void xive_tctx_tm_write(XiveTCTX *tctx, hwaddr offset=
, uint64_t value,
>  uint64_t xive_tctx_tm_read(XiveTCTX *tctx, hwaddr offset, unsigned size);
> =20
>  void xive_tctx_pic_print_info(XiveTCTX *tctx, Monitor *mon);
> -Object *xive_tctx_create(Object *cpu, XiveRouter *xrtr, Error **errp);
> +Object *xive_tctx_create(Object *cpu, Object *xrtr, Error **errp);
> =20
>  static inline uint32_t xive_nvt_cam_line(uint8_t nvt_blk, uint32_t nvt_i=
dx)
>  {
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index f7ba1c3b622f..56700681884f 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -573,6 +573,14 @@ static void xive_tctx_realize(DeviceState *dev, Erro=
r **errp)
>      Object *obj;
>      Error *local_err =3D NULL;
> =20
> +    obj =3D object_property_get_link(OBJECT(dev), "xrtr", &local_err);
> +    if (!obj) {
> +        error_propagate(errp, local_err);
> +        error_prepend(errp, "required link 'xrtr' not found: ");
> +        return;
> +    }
> +    tctx->xrtr =3D obj;
> +
>      obj =3D object_property_get_link(OBJECT(dev), "cpu", &local_err);
>      if (!obj) {
>          error_propagate(errp, local_err);
> @@ -657,7 +665,7 @@ static const TypeInfo xive_tctx_info =3D {
>      .class_init    =3D xive_tctx_class_init,
>  };
> =20
> -Object *xive_tctx_create(Object *cpu, XiveRouter *xrtr, Error **errp)
> +Object *xive_tctx_create(Object *cpu, Object *xrtr, Error **errp)
>  {
>      Error *local_err =3D NULL;
>      Object *obj;
> @@ -666,6 +674,7 @@ Object *xive_tctx_create(Object *cpu, XiveRouter *xrt=
r, Error **errp)
>      object_property_add_child(cpu, TYPE_XIVE_TCTX, obj, &error_abort);
>      object_unref(obj);
>      object_property_add_const_link(obj, "cpu", cpu, &error_abort);
> +    object_property_add_const_link(obj, "xrtr", xrtr, &error_abort);
>      object_property_set_bool(obj, true, "realized", &local_err);
>      if (local_err) {
>          goto error;
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index b87e01e5b925..11916dc273c2 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -765,7 +765,7 @@ static void pnv_chip_power9_intc_create(PnvChip *chip=
, PowerPCCPU *cpu,
>       * controller object is initialized afterwards. Hopefully, it's
>       * only used at runtime.
>       */
> -    obj =3D xive_tctx_create(OBJECT(cpu), XIVE_ROUTER(&chip9->xive), &lo=
cal_err);
> +    obj =3D xive_tctx_create(OBJECT(cpu), OBJECT(&chip9->xive), &local_e=
rr);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          return;
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index b2b01e850de8..5b3c3c50967b 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -353,7 +353,7 @@ static void spapr_irq_cpu_intc_create_xive(SpaprMachi=
neState *spapr,
>      Object *obj;
>      SpaprCpuState *spapr_cpu =3D spapr_cpu_state(cpu);
> =20
> -    obj =3D xive_tctx_create(OBJECT(cpu), XIVE_ROUTER(spapr->xive), &loc=
al_err);
> +    obj =3D xive_tctx_create(OBJECT(cpu), OBJECT(spapr->xive), &local_er=
r);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          return;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--k4f25fnPtRuIRUb3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0cDfIACgkQbDjKyiDZ
s5LdPA/8C/KS/TbnO0IIXGTtq4uZ5Zwj7Am+3T+PopFEzheHmOMDJEfPGyoJNB/K
bVQtWMaiR5OR6ScvdIBrJ+LgyMBpVo3Ff3bR/5c/EWA1dYxA/aUXMktyI2Q8/5Ez
YMHOnUMFqke7OeUfBkPdKMqdBiYLrfmynur5UHPlK/H4/JuFg16FjSfZJWWiFcBO
hObKwZdIfwrNx3stfbJMBLHu/xJAa7Ko0Na4gjPt3jGnIp9EVpt2MFlau6Q/6zqV
XMPbT3dI0aCHIvwXidfZ52nvhlhof2zL/QpICcso6l2MP7lJC21H9IJ+0p5S/+Hf
g7gpt03pZcN+GwnVEgafWNJc1Ia73Z9GZJy0i+3xlbOX1R/qoA3KBSu623vCBq+9
niT2lhEbAXjzpfXVxWWrMxj/TRAuBI7GGy1rWZA6+sl136xOYN+gF7L4LrG2h9Lt
UsFABVLT1xbB0ZIObTBbivFzZLi50niD9d3iP6soNP0JkizVJsa31fpNV0auxpQR
RazOndEPLqItJt9tOK4xpxyEaiFMxuz0KOuzxGFToJnUPDvFDk0LmrBF/j43033d
1b7LCvHmE3l6M22jXWgyQ2nJQf5aGTzMQ9Ixh4SHExjBDxV+pSyij6rVVzpjCoWp
B4mh4jd0UCpgqEkSzK2r+tpERxtBpc8ieN4dxKVmiS6LoWwCp/4=
=aRKw
-----END PGP SIGNATURE-----

--k4f25fnPtRuIRUb3--

