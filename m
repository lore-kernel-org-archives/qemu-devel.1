Return-Path: <SRS0=q9Vo=YU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B999ECA9EAF
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2019 17:30:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8350021726
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2019 17:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="X3D9dDUT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8350021726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOmN9-0004cQ-Rg
	for qemu-devel@archiver.kernel.org; Sun, 27 Oct 2019 13:30:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57407)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iOmJp-0004HD-SA
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 13:27:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iOmJo-0006hl-2s
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 13:27:09 -0400
Received: from ozlabs.org ([203.11.71.1]:35523)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iOmJn-0006aD-Be; Sun, 27 Oct 2019 13:27:08 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 471Psv6Xjwz9sPT; Mon, 28 Oct 2019 04:26:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1572197219;
 bh=Y4ThW7mhYzrYrrXOHtRawlyQSbfSTm1latgNYVAg7VQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=X3D9dDUT6qoMobdIz8iJJxod0W3fy2TNWCjMnWdyTLDzmOnlq2HCDYKIkZJgWuXN0
 uY+hNJu9EmymfpOlliR9/r3tFoy8oHnGvas1+3E2ZghrBiivJhBgaRkSW2qSQlCt0q
 GydnVcboyFDP6+hk5+uArWeka423l6qZACHXlP1Y=
Date: Sun, 27 Oct 2019 17:54:03 +0100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v5 4/7] ppc/pnv: Add a PnvChip pointer to PnvCore
Message-ID: <20191027165403.GC3552@umbus.metropole.lan>
References: <20191022163812.330-1-clg@kaod.org>
 <20191022163812.330-5-clg@kaod.org>
 <20191024023812.GO6439@umbus.fritz.box>
 <ed3b2931-7836-058d-6b93-d35eed3ff859@kaod.org>
 <20191024184823.522c02e6@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="E/DnYTRukya0zdZ1"
Content-Disposition: inline
In-Reply-To: <20191024184823.522c02e6@bahia.lan>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-ppc@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--E/DnYTRukya0zdZ1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2019 at 06:48:23PM +0200, Greg Kurz wrote:
> On Thu, 24 Oct 2019 11:57:05 +0200
> C=E9dric Le Goater <clg@kaod.org> wrote:
>=20
> > On 24/10/2019 04:38, David Gibson wrote:
> > > On Tue, Oct 22, 2019 at 06:38:09PM +0200, C=E9dric Le Goater wrote:
> > >> We will use it to reset the interrupt presenter from the CPU reset
> > >> handler.
> > >>
> > >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> > >> Reviewed-by: Greg Kurz <groug@kaod.org>
> > >> ---
> > >>  include/hw/ppc/pnv_core.h | 3 +++
> > >>  hw/ppc/pnv_core.c         | 3 ++-
> > >>  2 files changed, 5 insertions(+), 1 deletion(-)
> > >>
> > >> diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
> > >> index bfbd2ec42aa6..55eee95104da 100644
> > >> --- a/include/hw/ppc/pnv_core.h
> > >> +++ b/include/hw/ppc/pnv_core.h
> > >> @@ -31,6 +31,8 @@
> > >>  #define PNV_CORE_GET_CLASS(obj) \
> > >>       OBJECT_GET_CLASS(PnvCoreClass, (obj), TYPE_PNV_CORE)
> > >> =20
> > >> +typedef struct PnvChip PnvChip;
> > >> +
> > >>  typedef struct PnvCore {
> > >>      /*< private >*/
> > >>      CPUCore parent_obj;
> > >> @@ -38,6 +40,7 @@ typedef struct PnvCore {
> > >>      /*< public >*/
> > >>      PowerPCCPU **threads;
> > >>      uint32_t pir;
> > >> +    PnvChip *chip;
> > >=20
> > > I don't love having this as a redundant encoding of the information
> > > already in the property, since it raises the possibility of confusing
> > > bugs if they ever got out of sync.
> >=20
> > Indeed.
> >=20
> > > It's not a huge deal, but it would be nice to at least to at least
> > > consider either a) grabbing the property everywhere you need it (if
> > > there aren't too many places)=20
> >=20
> > We need the chip at core creation and core reset to call the=20
> > interrupt chip handlers. These are not hot path but the pointer
> > seemed practical.
> >=20
>=20
> FWIW this is also used at core destruction in this patch:
>=20
> [1/3] ppc: Add intc_destroy() handlers to SpaprInterruptController/PnvChip
> https://patchwork.ozlabs.org/patch/1183158/
>=20
> > > or b) customizing the property
> > > definition so it's written directly into that field.
> >=20
> > OK. That is better than just a link.
> >=20
>=20
> I think David is suggesting to use object_property_add_link()
> instead of object_property_add_const_link() actually. Something
> like that:

TBH, I hadn't looked into the mechanics of how to do this that
closely.  Change below looks pretty reasonable, though.

>=20
> diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
> index 55eee95104da..fce6d8d9b31b 100644
> --- a/include/hw/ppc/pnv_core.h
> +++ b/include/hw/ppc/pnv_core.h
> @@ -36,11 +36,11 @@ typedef struct PnvChip PnvChip;
>  typedef struct PnvCore {
>      /*< private >*/
>      CPUCore parent_obj;
> +    PnvChip *chip;
> =20
>      /*< public >*/
>      PowerPCCPU **threads;
>      uint32_t pir;
> -    PnvChip *chip;
> =20
>      MemoryRegion xscom_regs;
>  } PnvCore;
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 68cc3c81aa75..90449d33e422 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -1312,8 +1312,8 @@ static void pnv_chip_core_realize(PnvChip *chip, Er=
ror **errp)
>          object_property_set_int(OBJECT(pnv_core),
>                                  pcc->core_pir(chip, core_hwid),
>                                  "pir", &error_fatal);
> -        object_property_add_const_link(OBJECT(pnv_core), "chip",
> -                                       OBJECT(chip), &error_fatal);
> +        object_property_set_link(OBJECT(pnv_core), OBJECT(chip), "chip",
> +                                 &error_abort);
>          object_property_set_bool(OBJECT(pnv_core), true, "realized",
>                                   &error_fatal);
> =20
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index 61b3d3ce2250..8562a9961845 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -217,15 +217,6 @@ static void pnv_core_realize(DeviceState *dev, Error=
 **errp)
>      void *obj;
>      int i, j;
>      char name[32];
> -    Object *chip;
> -
> -    chip =3D object_property_get_link(OBJECT(dev), "chip", &local_err);
> -    if (!chip) {
> -        error_propagate_prepend(errp, local_err,
> -                                "required link 'chip' not found: ");
> -        return;
> -    }
> -    pc->chip =3D PNV_CHIP(chip);
> =20
>      pc->threads =3D g_new(PowerPCCPU *, cc->nr_threads);
>      for (i =3D 0; i < cc->nr_threads; i++) {
> @@ -323,6 +314,14 @@ static void pnv_core_class_init(ObjectClass *oc, voi=
d *data)
>      dc->props =3D pnv_core_properties;
>  }
> =20
> +static void pnv_core_instance_init(Object *obj)
> +{
> +    object_property_add_link(obj, "chip", TYPE_PNV_CHIP,
> +                             (Object **) &PNV_CORE(obj)->chip,
> +                             qdev_prop_allow_set_link_before_realize,
> +                             0, &error_abort);
> +}
> +
>  #define DEFINE_PNV_CORE_TYPE(family, cpu_model) \
>      {                                           \
>          .parent =3D TYPE_PNV_CORE,                \
> @@ -335,6 +334,7 @@ static const TypeInfo pnv_core_infos[] =3D {
>          .name           =3D TYPE_PNV_CORE,
>          .parent         =3D TYPE_CPU_CORE,
>          .instance_size  =3D sizeof(PnvCore),
> +        .instance_init  =3D pnv_core_instance_init,
>          .class_size     =3D sizeof(PnvCoreClass),
>          .class_init =3D pnv_core_class_init,
>          .abstract       =3D true,
> ----
>=20
> > C.=20
> >=20
> > >=20
> > >> =20
> > >>      MemoryRegion xscom_regs;
> > >>  } PnvCore;
> > >> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> > >> index 9f981a4940e6..cc17bbfed829 100644
> > >> --- a/hw/ppc/pnv_core.c
> > >> +++ b/hw/ppc/pnv_core.c
> > >> @@ -222,6 +222,7 @@ static void pnv_core_realize(DeviceState *dev, E=
rror **errp)
> > >>                                  "required link 'chip' not found: ");
> > >>          return;
> > >>      }
> > >> +    pc->chip =3D PNV_CHIP(chip);
> > >> =20
> > >>      pc->threads =3D g_new(PowerPCCPU *, cc->nr_threads);
> > >>      for (i =3D 0; i < cc->nr_threads; i++) {
> > >> @@ -243,7 +244,7 @@ static void pnv_core_realize(DeviceState *dev, E=
rror **errp)
> > >>      }
> > >> =20
> > >>      for (j =3D 0; j < cc->nr_threads; j++) {
> > >> -        pnv_realize_vcpu(pc->threads[j], PNV_CHIP(chip), &local_err=
);
> > >> +        pnv_realize_vcpu(pc->threads[j], pc->chip, &local_err);
> > >>          if (local_err) {
> > >>              goto err;
> > >>          }
> > >=20
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--E/DnYTRukya0zdZ1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl21y6sACgkQbDjKyiDZ
s5J+FRAAjqrOxZsJYdhlpiPI0poPcqkotlzSPR9JYgoTSDt2XdJ9qrgBq7m9Ur3O
ac6LHnwfAxbr+O3QHeKyNdYheyc8qW7/WJ3uYjUyEsxjWK5Oi0fTOpJz+WHwDS9S
nr4m4ZyUBixiXPs5smKmf7uWoaDg6lz5toX3aA/PxUBF+cJpT73U+fquwhKKFLlJ
l5DcofsKb4oGFwJhOKp9VFMvBfFghDk4RqwcaSD91ae+zG1mXgF74k4SnRGdth7P
4GPA9ntEzYuHTf28Osy3TRW7F8mArlldjmsP8nYRh0Ce7xYwoCuRJqdBWD7GthXk
rCf4XB4suqmmhocQJ7a3xkmS4fZMkD0BmdDeZq4Yl5/QD4CJsC/ulcJUmFKQAuqf
s1omU9jmO5SP5tv0aOhvdMrj2JCnO9Qm32ooUajnHZUYu1Ik9gwo+7y448fGKs1x
lnl0SvnwkWS5IJO9C3M3Bk/6q10Y1vWKk4LxN4YfuXvNYzt69IRzyISs3kpvpOA1
V6Osed9gzbQ1SGNql5Wjf88KNWRIhiLqn3BugAnwRLXNqFvP1FREtdjRlLvjs2le
9dRsH+djoWgXxbdf+LDuypIV8NZdar11jqs4LFOfhCmHZ/92sapmJjYF5Fsk1Q42
/tc8mOEVoW7S0KlNZ7WqOl7DGRRu0srP16Y4KB+1xdtxMOuBXRo=
=aAV0
-----END PGP SIGNATURE-----

--E/DnYTRukya0zdZ1--

