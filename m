Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA3DCA9EB9
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 03:17:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 046B720640
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 03:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="VUIxVMbl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 046B720640
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNTcH-0002EJ-Ee
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 23:16:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53944)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iNTTO-0006cN-8p
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 23:07:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iNTTL-0002vv-SF
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 23:07:38 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:45919)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iNTTL-0002sf-2z; Wed, 23 Oct 2019 23:07:35 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46zBxS61Rgz9sPv; Thu, 24 Oct 2019 14:07:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1571886444;
 bh=8tfwom2iWshrFEhgDB2A2OeMO6343uDBx4EsgoXR7cw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VUIxVMblAHDQFtol/3+s3+xI4jQNsk2g/zFzHbGyo1CAfH0uqfaOFCQUFG0Ps9YJb
 /tKdifYB1ZV7XodPtNK2ftuKDdktlUbdq7QmUcUz2qPwS18rszSsrKtu4l1AzMJDnI
 AP6rX3oxy7emSnxBZxOc5ZeGyj3M1Swi1TtingxU=
Date: Thu, 24 Oct 2019 13:58:41 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 3/6] ppc: Reparent presenter objects to the interrupt
 controller object
Message-ID: <20191024025841.GT6439@umbus.fritz.box>
References: <157184231371.3053790.17713393349394736594.stgit@bahia.lan>
 <157184233056.3053790.13073641279894392321.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="9r3HF47jptiQlX4s"
Content-Disposition: inline
In-Reply-To: <157184233056.3053790.13073641279894392321.stgit@bahia.lan>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--9r3HF47jptiQlX4s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2019 at 04:52:10PM +0200, Greg Kurz wrote:
> Each VCPU is associated to a presenter object within the interrupt
> controller, ie. TCTX for XIVE and ICP for XICS, but our current
> models put these objects below the VCPU, and we rely on CPU_FOREACH()
> to do anything that involves presenters.
>=20
> This recently bit us with the CAM line matching logic in XIVE because
> CPU_FOREACH() can race with CPU hotplug and we ended up considering a
> VCPU that wasn't associated to a TCTX object yet. Other users of
> CPU_FOREACH() are 'info pic' for both XICS and XIVE. It is again very
> easy to crash QEMU with concurrent VCPU hotplug/unplug and 'info pic'.
>=20
> Reparent the presenter objects to the corresponding interrupt controller
> object, ie. XIVE router or ICS, to make it clear they are not some extra
> data hanging from the CPU but internal XIVE or XICS entities. The CPU
> object now needs to explicitely take a reference on the presenter to
> ensure its pointer remains valid until unrealize time.
>=20
> This will allow to get rid of CPU_FOREACH() and ease further improvements
> to the XIVE model.
>=20
> This change doesn't impact section ids and is thus transparent to
> migration.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>


Urgh.  I see why we want something like this, but reparenting the
presenters to the source modules (particularly for XICS) makes me
uncomfortable.

AFAICT the association here is *purely* about managing lifetimes, not
because those ICPs inherently have something to do with those ICSes.
Same with XIVE, although since they'll be on the same chip there's a
bit more logic to it.

For spapr we kinda-sorta treat the (single) ICS or XiveRouter object
as the "master" of the interrupt controller.  But that's not really
accurate to the hardware, so I don't really want to push that way of
looking at it any further than it already is.

If we could make the presenters children of the machine (spapr) or
chip (pnv) that might make more sense?

I'm also not totally convinced that having the presenter as a child of
the cpu is inherently bad.  Yes we have bugs now, but maybe the right
fix *is* actually to do the NULL check on every CPU_FOREACH().

For comparison, the lapic on x86 machines is a child of the cpu, and I
believe they do have NULL checks on cpu->apic_state in various places
they use CPU_FOREACH().

> ---
>  hw/intc/spapr_xive.c  |    6 +++++-
>  hw/intc/xics.c        |    7 +++++--
>  hw/intc/xics_spapr.c  |    8 ++++++--
>  hw/intc/xive.c        |    4 +++-
>  hw/ppc/pnv.c          |   17 +++++++++++++----
>  include/hw/ppc/xics.h |    2 +-
>  6 files changed, 33 insertions(+), 11 deletions(-)
>=20
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index b09cc48bcb61..d74ee71e76b4 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -526,6 +526,7 @@ static int spapr_xive_cpu_intc_create(SpaprInterruptC=
ontroller *intc,
>          return -1;
>      }
> =20
> +    object_ref(obj);
>      spapr_cpu->tctx =3D XIVE_TCTX(obj);
>      return 0;
>  }
> @@ -558,7 +559,10 @@ static void spapr_xive_cpu_intc_reset(SpaprInterrupt=
Controller *intc,
>  static void spapr_xive_cpu_intc_destroy(SpaprInterruptController *intc,
>                                          PowerPCCPU *cpu)
>  {
> -    xive_tctx_destroy(spapr_cpu_state(cpu)->tctx);
> +    XiveTCTX *tctx =3D spapr_cpu_state(cpu)->tctx;
> +
> +    object_unref(OBJECT(tctx));
> +    xive_tctx_destroy(tctx);
>  }
> =20
>  static void spapr_xive_set_irq(SpaprInterruptController *intc, int irq, =
int val)
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index 5f746079be46..d5e4db668a4b 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -380,13 +380,16 @@ static const TypeInfo icp_info =3D {
>      .class_size =3D sizeof(ICPStateClass),
>  };
> =20
> -Object *icp_create(Object *cpu, const char *type, XICSFabric *xi, Error =
**errp)
> +Object *icp_create(Object *cpu, const char *type, ICSState *ics, XICSFab=
ric *xi,
> +                   Error **errp)
>  {
>      Error *local_err =3D NULL;
> +    g_autofree char *name =3D NULL;
>      Object *obj;
> =20
>      obj =3D object_new(type);
> -    object_property_add_child(cpu, type, obj, &error_abort);
> +    name =3D g_strdup_printf("%s[%d]", type, CPU(cpu)->cpu_index);
> +    object_property_add_child(OBJECT(ics), name, obj, &error_abort);
>      object_unref(obj);
>      object_ref(OBJECT(xi));
>      object_property_add_const_link(obj, ICP_PROP_XICS, OBJECT(xi),
> diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
> index 5977d1bdb73f..080ed73aad64 100644
> --- a/hw/intc/xics_spapr.c
> +++ b/hw/intc/xics_spapr.c
> @@ -337,11 +337,12 @@ static int xics_spapr_cpu_intc_create(SpaprInterrup=
tController *intc,
>      Object *obj;
>      SpaprCpuState *spapr_cpu =3D spapr_cpu_state(cpu);
> =20
> -    obj =3D icp_create(OBJECT(cpu), TYPE_ICP, ics->xics, errp);
> +    obj =3D icp_create(OBJECT(cpu), TYPE_ICP, ics, ics->xics, errp);
>      if (!obj) {
>          return -1;
>      }
> =20
> +    object_ref(obj);
>      spapr_cpu->icp =3D ICP(obj);
>      return 0;
>  }
> @@ -355,7 +356,10 @@ static void xics_spapr_cpu_intc_reset(SpaprInterrupt=
Controller *intc,
>  static void xics_spapr_cpu_intc_destroy(SpaprInterruptController *intc,
>                                          PowerPCCPU *cpu)
>  {
> -    icp_destroy(spapr_cpu_state(cpu)->icp);
> +    ICPState *icp =3D spapr_cpu_state(cpu)->icp;
> +
> +    object_unref(OBJECT(icp));
> +    icp_destroy(icp);
>  }
> =20
>  static int xics_spapr_claim_irq(SpaprInterruptController *intc, int irq,
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 952a461d5329..8d2da4a11163 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -677,10 +677,12 @@ static const TypeInfo xive_tctx_info =3D {
>  Object *xive_tctx_create(Object *cpu, XiveRouter *xrtr, Error **errp)
>  {
>      Error *local_err =3D NULL;
> +    g_autofree char *name =3D NULL;
>      Object *obj;
> =20
>      obj =3D object_new(TYPE_XIVE_TCTX);
> -    object_property_add_child(cpu, TYPE_XIVE_TCTX, obj, &error_abort);
> +    name =3D g_strdup_printf(TYPE_XIVE_TCTX "[%d]", CPU(cpu)->cpu_index);
> +    object_property_add_child(OBJECT(xrtr), name, obj, &error_abort);
>      object_unref(obj);
>      object_ref(cpu);
>      object_property_add_const_link(obj, "cpu", cpu, &error_abort);
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index bd17c3536dd5..cbeabf98bff6 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -767,14 +767,16 @@ static void pnv_chip_power8_intc_create(PnvChip *ch=
ip, PowerPCCPU *cpu,
>      Error *local_err =3D NULL;
>      Object *obj;
>      PnvCPUState *pnv_cpu =3D pnv_cpu_state(cpu);
> +    Pnv8Chip *chip8 =3D PNV8_CHIP(chip);
> =20
> -    obj =3D icp_create(OBJECT(cpu), TYPE_PNV_ICP, XICS_FABRIC(qdev_get_m=
achine()),
> -                     &local_err);
> +    obj =3D icp_create(OBJECT(cpu), TYPE_PNV_ICP, &chip8->psi.ics,
> +                     XICS_FABRIC(qdev_get_machine()), &local_err);

Here, the association of the ICPs with the PSI ICS is particularly arbitrar=
y.

>      if (local_err) {
>          error_propagate(errp, local_err);
>          return;
>      }
> =20
> +    object_ref(obj);
>      pnv_cpu->intc =3D obj;
>  }
> =20
> @@ -788,7 +790,10 @@ static void pnv_chip_power8_intc_reset(PnvChip *chip=
, PowerPCCPU *cpu)
> =20
>  static void pnv_chip_power8_intc_destroy(PnvChip *chip, PowerPCCPU *cpu)
>  {
> -    icp_destroy(ICP(pnv_cpu_state(cpu)->intc));
> +    Object *intc =3D pnv_cpu_state(cpu)->intc;
> +
> +    object_unref(intc);
> +    icp_destroy(ICP(intc));
>  }
> =20
>  /*
> @@ -825,6 +830,7 @@ static void pnv_chip_power9_intc_create(PnvChip *chip=
, PowerPCCPU *cpu,
>          return;
>      }
> =20
> +    object_ref(obj);
>      pnv_cpu->intc =3D obj;
>  }
> =20
> @@ -837,7 +843,10 @@ static void pnv_chip_power9_intc_reset(PnvChip *chip=
, PowerPCCPU *cpu)
> =20
>  static void pnv_chip_power9_intc_destroy(PnvChip *chip, PowerPCCPU *cpu)
>  {
> -    xive_tctx_destroy(XIVE_TCTX(pnv_cpu_state(cpu)->intc));
> +    Object *intc =3D pnv_cpu_state(cpu)->intc;
> +
> +    object_unref(intc);
> +    xive_tctx_destroy(XIVE_TCTX(intc));
>  }
> =20
>  /*
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index 48a75aa4ab75..f4827e748fd8 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -179,7 +179,7 @@ void ics_pic_print_info(ICSState *ics, Monitor *mon);
>  void ics_resend(ICSState *ics);
>  void icp_resend(ICPState *ss);
> =20
> -Object *icp_create(Object *cpu, const char *type, XICSFabric *xi,
> +Object *icp_create(Object *cpu, const char *type, ICSState *ics, XICSFab=
ric *xi,
>                     Error **errp);
>  void icp_destroy(ICPState *icp);
> =20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--9r3HF47jptiQlX4s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2xE2EACgkQbDjKyiDZ
s5KRnhAAr2jaZ6D3i1/fUuInxfnC7KfPCD/N72GpHIKGVq8+4aIafJ4Cx2zdJRzF
Wd3jt5wKuZahzxHFf62CMcKNLpsYsU3Bp39ErDIoov/yi9z66SQyG/nTrdrRveut
YK0zLlNstNd7ZOfE9iSiuN8LfRrKoPO5VV7hCoYZNOb6F4JkOOIF385+VF/r78BB
y9Gty6gNHsLQy+A55MQoTKH0c9fVAkwus8sNmuYiupe4eTXx0xmiv1ZvWOMnuAXn
ntq3Gx0PvdCZndTcewrG8agREOGL0u7ay3lb+U5yZTZmW3z2OFeiBYgLqZcaMajg
REEQpPNcRgu7jdi4uIgegRzdWSeng8gHuonYwlj004RwI6Y05xz9PUtar1sCNwnt
cx4KGW+bFY7DnP5dSS4VhBR3lOIZlw/0fhqL2e4tSVV9ne/t3QkvKBsD5Wj+relU
TKMnVhz0FtATY7CEgrP8Rei+YSEp5Rm6sDuBtohTQiChp9rptfyCrHQVNHBLvWNv
rA1V00iCSLLPRJRMbA0Vi72UIHKiisOByMaUii/jjxbltsu0BDHIbe35YOZJys8p
dZQAyavUqux11KWPIo6zc08JcnYs7RdDxxFvhDHUJKa8ytBbf3Uw0IDksXg01sre
FKvZ6k2xbYYo61wKnzWAvN5psiz93YJA48qi9sNttOb4U8fPG9E=
=v6bF
-----END PGP SIGNATURE-----

--9r3HF47jptiQlX4s--

