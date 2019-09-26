Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BC8C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 01:31:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1700F222BE
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 01:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="d8GJZd90"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1700F222BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDIcy-00031b-Jl
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 21:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41194)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iDIam-0001Bq-Sz
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 21:29:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iDIal-0003vh-6A
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 21:29:12 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:32787 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iDIak-0003t1-Pp; Wed, 25 Sep 2019 21:29:11 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46dy4P490Vz9sPK; Thu, 26 Sep 2019 11:28:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1569461317;
 bh=XlXIbtyK5t3L9TCGbEOm7OaRGjMwyAcsPgZK/vScsvY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=d8GJZd90zPnP9TqkTZfvwBdegQqU2sQJ/M4ak8tG78iUoU6FMO/ZOytY72OZJXby6
 FldbtYFCEDgJVU4NjuSVyK2QpTcFD+YVEDJu4q2sx5hyDspNQ6tXCxqqpH6rTOLVIt
 gGgbLe3OpbZU0t5Yy6rtRfuuXEw3g7MuC2gxRYCk=
Date: Thu, 26 Sep 2019 10:56:46 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 06/20] xics: Create sPAPR specific ICS subtype
Message-ID: <20190926005646.GP17405@umbus>
References: <20190925064534.19155-1-david@gibson.dropbear.id.au>
 <20190925064534.19155-7-david@gibson.dropbear.id.au>
 <20190925104050.072877f1@bahia.lan>
 <86d6fe0c-28ab-89a1-fa5f-dbc1d1c024ed@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3bc47Eih9dS+biPM"
Content-Disposition: inline
In-Reply-To: <86d6fe0c-28ab-89a1-fa5f-dbc1d1c024ed@kaod.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--3bc47Eih9dS+biPM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2019 at 10:55:35AM +0200, C=E9dric Le Goater wrote:
> On 25/09/2019 10:40, Greg Kurz wrote:
> > On Wed, 25 Sep 2019 16:45:20 +1000
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >=20
> >> We create a subtype of TYPE_ICS specifically for sPAPR.  For now all t=
his
> >> does is move the setup of the PAPR specific hcalls and RTAS calls to
> >> the realize() function for this, rather than requiring the PAPR code to
> >> explicitly call xics_spapr_init().  In future it will have some more
> >> function.
> >>
> >> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> >> ---
> >=20
> > LGTM, but for extra safety I would also introduce a SpaprIcsState typed=
ef
>=20
> why ? we have ICS_SPAPR() for the checks already.

Eh.. using typedefs when we haven't actually extended a base type
isn't common QOM practice.  Yes, it's not as typesafe as it could be,
but I'm not really inclined to go to the extra effort here.

>=20
> > and use it everywhere where we only expect this subtype. Especially in
> > the definition of SpaprMachineState.
> >=20
> >>  hw/intc/xics_spapr.c        | 34 +++++++++++++++++++++++++++++++++-
> >>  hw/ppc/spapr_irq.c          |  6 ++----
> >>  include/hw/ppc/xics_spapr.h |  4 +++-
> >>  3 files changed, 38 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
> >> index 3e9444813a..e6dd004587 100644
> >> --- a/hw/intc/xics_spapr.c
> >> +++ b/hw/intc/xics_spapr.c
> >> @@ -283,8 +283,18 @@ static void rtas_int_on(PowerPCCPU *cpu, SpaprMac=
hineState *spapr,
> >>      rtas_st(rets, 0, RTAS_OUT_SUCCESS);
> >>  }
> >> =20
> >> -void xics_spapr_init(SpaprMachineState *spapr)
> >> +static void ics_spapr_realize(DeviceState *dev, Error **errp)
> >>  {
> >> +    ICSState *ics =3D ICS_SPAPR(dev);
> >> +    ICSStateClass *icsc =3D ICS_GET_CLASS(ics);
> >> +    Error *local_err =3D NULL;
> >> +
> >> +    icsc->parent_realize(dev, &local_err);
> >> +    if (local_err) {
> >> +        error_propagate(errp, local_err);
> >> +        return;
> >> +    }
> >> +
> >>      spapr_rtas_register(RTAS_IBM_SET_XIVE, "ibm,set-xive", rtas_set_x=
ive);
> >>      spapr_rtas_register(RTAS_IBM_GET_XIVE, "ibm,get-xive", rtas_get_x=
ive);
> >>      spapr_rtas_register(RTAS_IBM_INT_OFF, "ibm,int-off", rtas_int_off=
);
> >> @@ -319,3 +329,25 @@ void spapr_dt_xics(SpaprMachineState *spapr, uint=
32_t nr_servers, void *fdt,
> >>      _FDT(fdt_setprop_cell(fdt, node, "linux,phandle", phandle));
> >>      _FDT(fdt_setprop_cell(fdt, node, "phandle", phandle));
> >>  }
> >> +
> >> +static void ics_spapr_class_init(ObjectClass *klass, void *data)
> >> +{
> >> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> >> +    ICSStateClass *isc =3D ICS_CLASS(klass);
> >> +
> >> +    device_class_set_parent_realize(dc, ics_spapr_realize,
> >> +                                    &isc->parent_realize);
> >> +}
> >> +
> >> +static const TypeInfo ics_spapr_info =3D {
> >> +    .name =3D TYPE_ICS_SPAPR,
> >> +    .parent =3D TYPE_ICS,
> >> +    .class_init =3D ics_spapr_class_init,
> >> +};
> >> +
> >> +static void xics_spapr_register_types(void)
> >> +{
> >> +    type_register_static(&ics_spapr_info);
> >> +}
> >> +
> >> +type_init(xics_spapr_register_types)
> >> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> >> index 6c45d2a3c0..8c26fa2d1e 100644
> >> --- a/hw/ppc/spapr_irq.c
> >> +++ b/hw/ppc/spapr_irq.c
> >> @@ -98,7 +98,7 @@ static void spapr_irq_init_xics(SpaprMachineState *s=
papr, int nr_irqs,
> >>      Object *obj;
> >>      Error *local_err =3D NULL;
> >> =20
> >> -    obj =3D object_new(TYPE_ICS);
> >> +    obj =3D object_new(TYPE_ICS_SPAPR);
> >>      object_property_add_child(OBJECT(spapr), "ics", obj, &error_abort=
);
> >>      object_property_add_const_link(obj, ICS_PROP_XICS, OBJECT(spapr),
> >>                                     &error_fatal);
> >> @@ -109,9 +109,7 @@ static void spapr_irq_init_xics(SpaprMachineState =
*spapr, int nr_irqs,
> >>          return;
> >>      }
> >> =20
> >> -    spapr->ics =3D ICS(obj);
> >> -
> >> -    xics_spapr_init(spapr);
> >> +    spapr->ics =3D ICS_SPAPR(obj);
> >>  }
> >> =20
> >>  static int spapr_irq_claim_xics(SpaprMachineState *spapr, int irq, bo=
ol lsi,
> >> diff --git a/include/hw/ppc/xics_spapr.h b/include/hw/ppc/xics_spapr.h
> >> index 5dabc9a138..691a6d00f7 100644
> >> --- a/include/hw/ppc/xics_spapr.h
> >> +++ b/include/hw/ppc/xics_spapr.h
> >> @@ -31,11 +31,13 @@
> >> =20
> >>  #define XICS_NODENAME "interrupt-controller"
> >> =20
> >> +#define TYPE_ICS_SPAPR "ics-spapr"
> >> +#define ICS_SPAPR(obj) OBJECT_CHECK(ICSState, (obj), TYPE_ICS_SPAPR)
> >> +
> >>  void spapr_dt_xics(SpaprMachineState *spapr, uint32_t nr_servers, voi=
d *fdt,
> >>                     uint32_t phandle);
> >>  int xics_kvm_connect(SpaprMachineState *spapr, Error **errp);
> >>  void xics_kvm_disconnect(SpaprMachineState *spapr, Error **errp);
> >>  bool xics_kvm_has_broken_disconnect(SpaprMachineState *spapr);
> >> -void xics_spapr_init(SpaprMachineState *spapr);
> >> =20
> >>  #endif /* XICS_SPAPR_H */
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3bc47Eih9dS+biPM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl2MDM4ACgkQbDjKyiDZ
s5J6sQ/9HoM0omMkKY0DjmPoAneWSsTUNEwbzqRNjLos7slJx7lUmjTKcz5mNfD1
W01UFmAivo+LXNs6UVFUZYYHu2X752L7P+gPH3WekpCxQoqO803JRqjKwbgPtCn0
H2tAvHrTXCwZq3/gA05tu14VIawKD4s6/59pXFD3D2oUT01yRXRCJd3Y6Jz94cX9
/sudJ28O8inztnnoW5kXh/u4Bu/8WcDSmkJKHd5EtnhyFbANgGxcc3vk8xEN+y5p
ZozlolQqKpRpOGToO+ju83Z3IP5oyipNqiaFkIwaayy0nnhdqVsc1YzQjD0jfvNC
3NhLy2jyjDEbKzTtgQh85GJ7rRN0iYyfTgO97V5KxbQj9Yj06mN4WzTDQZ34F9VD
29pX9BW7qzwjUE1MMoPv0wNNsrkhMJ5nsmvFUgXOvaqimIThuWnByq1G03UHfCmr
b5dy6iqsRBJGkSb3LPjwkGdMIukIom7+tStBuhfIQlXgOJZALuB85ZKcNyoz/7Cy
cznpqKnf4wO3ZVWA2mSUfCVcd43gqIcYdynECSsf1TtT84er1ZpAfSpeVRG9yL8U
iCoxpDam19yGAIof67ONpUNQKUYuGM1Ky0b2CvO/d/t8mz0f7LlEg/+gKh087MnS
NU1E56Ul01nZXmiIPiy/1crZav3G71k8clU9dzEID5jDAJ7jJKY=
=h59y
-----END PGP SIGNATURE-----

--3bc47Eih9dS+biPM--

