Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC838C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 17:19:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6907020872
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 17:19:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6907020872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDttw-00013p-Ul
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 13:19:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39796)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iDsl3-0008Vn-9I
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 12:06:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iDsl1-0002F7-Dw
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 12:06:12 -0400
Received: from 8.mo177.mail-out.ovh.net ([46.105.61.98]:35570)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iDsl1-0002Ds-3W
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 12:06:11 -0400
Received: from player728.ha.ovh.net (unknown [10.108.57.53])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id 9263110ACEF
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 18:06:08 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player728.ha.ovh.net (Postfix) with ESMTPSA id F01CCA3DAB2F;
 Fri, 27 Sep 2019 16:05:57 +0000 (UTC)
Date: Fri, 27 Sep 2019 18:05:56 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 06/20] xics: Create sPAPR specific ICS subtype
Message-ID: <20190927180556.6e600342@bahia.lan>
In-Reply-To: <20190926005646.GP17405@umbus>
References: <20190925064534.19155-1-david@gibson.dropbear.id.au>
 <20190925064534.19155-7-david@gibson.dropbear.id.au>
 <20190925104050.072877f1@bahia.lan>
 <86d6fe0c-28ab-89a1-fa5f-dbc1d1c024ed@kaod.org>
 <20190926005646.GP17405@umbus>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/rtNd7Sv/Wp7qS5ANiTIV/ZT"; protocol="application/pgp-signature"
X-Ovh-Tracer-Id: 3706462496413227494
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrfeeigdelgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.61.98
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
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>,
 =?UTF-8?B?TWFy?= =?UTF-8?B?Yy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/rtNd7Sv/Wp7qS5ANiTIV/ZT
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 26 Sep 2019 10:56:46 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Wed, Sep 25, 2019 at 10:55:35AM +0200, C=C3=A9dric Le Goater wrote:
> > On 25/09/2019 10:40, Greg Kurz wrote:
> > > On Wed, 25 Sep 2019 16:45:20 +1000
> > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > >=20
> > >> We create a subtype of TYPE_ICS specifically for sPAPR.  For now all=
 this
> > >> does is move the setup of the PAPR specific hcalls and RTAS calls to
> > >> the realize() function for this, rather than requiring the PAPR code=
 to
> > >> explicitly call xics_spapr_init().  In future it will have some more
> > >> function.
> > >>
> > >> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > >> ---
> > >=20
> > > LGTM, but for extra safety I would also introduce a SpaprIcsState typ=
edef
> >=20
> > why ? we have ICS_SPAPR() for the checks already.
>=20
> Eh.. using typedefs when we haven't actually extended a base type
> isn't common QOM practice.  Yes, it's not as typesafe as it could be,
> but I'm not really inclined to go to the extra effort here.
>=20

I'll soon need to extend the base type with a nr_servers field,
and while here with an fd field as well in order to get rid of
the ugly global in xics.c. I'll go to the extra effort :)

> >=20
> > > and use it everywhere where we only expect this subtype. Especially in
> > > the definition of SpaprMachineState.
> > >=20
> > >>  hw/intc/xics_spapr.c        | 34 +++++++++++++++++++++++++++++++++-
> > >>  hw/ppc/spapr_irq.c          |  6 ++----
> > >>  include/hw/ppc/xics_spapr.h |  4 +++-
> > >>  3 files changed, 38 insertions(+), 6 deletions(-)
> > >>
> > >> diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
> > >> index 3e9444813a..e6dd004587 100644
> > >> --- a/hw/intc/xics_spapr.c
> > >> +++ b/hw/intc/xics_spapr.c
> > >> @@ -283,8 +283,18 @@ static void rtas_int_on(PowerPCCPU *cpu, SpaprM=
achineState *spapr,
> > >>      rtas_st(rets, 0, RTAS_OUT_SUCCESS);
> > >>  }
> > >> =20
> > >> -void xics_spapr_init(SpaprMachineState *spapr)
> > >> +static void ics_spapr_realize(DeviceState *dev, Error **errp)
> > >>  {
> > >> +    ICSState *ics =3D ICS_SPAPR(dev);
> > >> +    ICSStateClass *icsc =3D ICS_GET_CLASS(ics);
> > >> +    Error *local_err =3D NULL;
> > >> +
> > >> +    icsc->parent_realize(dev, &local_err);
> > >> +    if (local_err) {
> > >> +        error_propagate(errp, local_err);
> > >> +        return;
> > >> +    }
> > >> +
> > >>      spapr_rtas_register(RTAS_IBM_SET_XIVE, "ibm,set-xive", rtas_set=
_xive);
> > >>      spapr_rtas_register(RTAS_IBM_GET_XIVE, "ibm,get-xive", rtas_get=
_xive);
> > >>      spapr_rtas_register(RTAS_IBM_INT_OFF, "ibm,int-off", rtas_int_o=
ff);
> > >> @@ -319,3 +329,25 @@ void spapr_dt_xics(SpaprMachineState *spapr, ui=
nt32_t nr_servers, void *fdt,
> > >>      _FDT(fdt_setprop_cell(fdt, node, "linux,phandle", phandle));
> > >>      _FDT(fdt_setprop_cell(fdt, node, "phandle", phandle));
> > >>  }
> > >> +
> > >> +static void ics_spapr_class_init(ObjectClass *klass, void *data)
> > >> +{
> > >> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > >> +    ICSStateClass *isc =3D ICS_CLASS(klass);
> > >> +
> > >> +    device_class_set_parent_realize(dc, ics_spapr_realize,
> > >> +                                    &isc->parent_realize);
> > >> +}
> > >> +
> > >> +static const TypeInfo ics_spapr_info =3D {
> > >> +    .name =3D TYPE_ICS_SPAPR,
> > >> +    .parent =3D TYPE_ICS,
> > >> +    .class_init =3D ics_spapr_class_init,
> > >> +};
> > >> +
> > >> +static void xics_spapr_register_types(void)
> > >> +{
> > >> +    type_register_static(&ics_spapr_info);
> > >> +}
> > >> +
> > >> +type_init(xics_spapr_register_types)
> > >> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> > >> index 6c45d2a3c0..8c26fa2d1e 100644
> > >> --- a/hw/ppc/spapr_irq.c
> > >> +++ b/hw/ppc/spapr_irq.c
> > >> @@ -98,7 +98,7 @@ static void spapr_irq_init_xics(SpaprMachineState =
*spapr, int nr_irqs,
> > >>      Object *obj;
> > >>      Error *local_err =3D NULL;
> > >> =20
> > >> -    obj =3D object_new(TYPE_ICS);
> > >> +    obj =3D object_new(TYPE_ICS_SPAPR);
> > >>      object_property_add_child(OBJECT(spapr), "ics", obj, &error_abo=
rt);
> > >>      object_property_add_const_link(obj, ICS_PROP_XICS, OBJECT(spapr=
),
> > >>                                     &error_fatal);
> > >> @@ -109,9 +109,7 @@ static void spapr_irq_init_xics(SpaprMachineStat=
e *spapr, int nr_irqs,
> > >>          return;
> > >>      }
> > >> =20
> > >> -    spapr->ics =3D ICS(obj);
> > >> -
> > >> -    xics_spapr_init(spapr);
> > >> +    spapr->ics =3D ICS_SPAPR(obj);
> > >>  }
> > >> =20
> > >>  static int spapr_irq_claim_xics(SpaprMachineState *spapr, int irq, =
bool lsi,
> > >> diff --git a/include/hw/ppc/xics_spapr.h b/include/hw/ppc/xics_spapr=
.h
> > >> index 5dabc9a138..691a6d00f7 100644
> > >> --- a/include/hw/ppc/xics_spapr.h
> > >> +++ b/include/hw/ppc/xics_spapr.h
> > >> @@ -31,11 +31,13 @@
> > >> =20
> > >>  #define XICS_NODENAME "interrupt-controller"
> > >> =20
> > >> +#define TYPE_ICS_SPAPR "ics-spapr"
> > >> +#define ICS_SPAPR(obj) OBJECT_CHECK(ICSState, (obj), TYPE_ICS_SPAPR)
> > >> +
> > >>  void spapr_dt_xics(SpaprMachineState *spapr, uint32_t nr_servers, v=
oid *fdt,
> > >>                     uint32_t phandle);
> > >>  int xics_kvm_connect(SpaprMachineState *spapr, Error **errp);
> > >>  void xics_kvm_disconnect(SpaprMachineState *spapr, Error **errp);
> > >>  bool xics_kvm_has_broken_disconnect(SpaprMachineState *spapr);
> > >> -void xics_spapr_init(SpaprMachineState *spapr);
> > >> =20
> > >>  #endif /* XICS_SPAPR_H */
> > >=20
> >=20
>=20


--Sig_/rtNd7Sv/Wp7qS5ANiTIV/ZT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAl2OM2QACgkQcdTV5YIv
c9afIg//e71pYixxqc88AyuiCQjb9JAZBdHJtle8S2K7QkvU8h9HB5hBnPeWQlFe
Z6Rg5bxiOv+p90+S3PX56YL5+2INiTm0gWuYiD/CF+M+6P21mS8WFnxl+LYH0QyU
s7UIU50SqiPp31bD364bHzWWP40hQlTZex9GsEQMZbLbc9zjjydU1hr2KK+4CX/E
AIqE+Qa4babCdTa2Icz1mZGN3XfDrUiz5yLONWe1ohu3dnCRCieorq0NrwaMIyBH
hvHkq7dKcknMRNt0gyVmzdNUuXoJz1EsBB9lPZBVlXElkPwMIIpmMWl8vElAvaEH
j13No95GAbfl6T7TzyuVhskosL6fjJ4Yaeh6BYxWU9qt88hQ511Kv3UbBkY2Nols
McaObnHsXD2oOWZusAmkxNAAGYyxD2RtpP/CPYWBYtmtj5J28I31l/ete56IvjK7
/7bLL6M5FN7GCoYAoj36ZbtyKE/dYTxVxFq8oT18rUwUB/zQ+VYldQrEDtPJ0RYV
lU3PWg4mAyZwTMmKk5JNkmNauphFaj68V9zrCNe6Aal4w59UQvkLwysN+YawZkyA
RVXEoMP9xV4IZXFpWxCuzyyD02CNTIXaT81VWMz9/k7XizLz94kYANVV5qefDq5N
bpklFActeWhX6Jp0Jm2OZ4APcU9VPNwBal9W36Ei03uTbgldsig=
=RivA
-----END PGP SIGNATURE-----

--Sig_/rtNd7Sv/Wp7qS5ANiTIV/ZT--

