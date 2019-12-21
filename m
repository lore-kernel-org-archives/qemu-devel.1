Return-Path: <SRS0=aHsE=2L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBF1C2D0C0
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2019 10:29:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA9CA2070C
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2019 10:29:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA9CA2070C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iic11-0000C2-PL
	for qemu-devel@archiver.kernel.org; Sat, 21 Dec 2019 05:29:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57716)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iic0J-000887-HA
 for qemu-devel@nongnu.org; Sat, 21 Dec 2019 05:29:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iic0I-0002Nb-1J
 for qemu-devel@nongnu.org; Sat, 21 Dec 2019 05:28:59 -0500
Received: from 2.mo177.mail-out.ovh.net ([178.33.109.80]:39541)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iic0H-0002D3-K1
 for qemu-devel@nongnu.org; Sat, 21 Dec 2019 05:28:57 -0500
Received: from player715.ha.ovh.net (unknown [10.109.143.146])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id 0C29D115031
 for <qemu-devel@nongnu.org>; Sat, 21 Dec 2019 11:28:54 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player715.ha.ovh.net (Postfix) with ESMTPSA id 3A403D624DBC;
 Sat, 21 Dec 2019 10:28:50 +0000 (UTC)
Date: Sat, 21 Dec 2019 11:28:49 +0100
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 2/2] ppc/pnv: Use the CPU topology to compute the
 default number of chips
Message-ID: <20191221112849.68769d69@bahia.lan>
In-Reply-To: <20191221003906.GC15511@umbus.fritz.box>
References: <157686069624.97184.12603452056634667288.stgit@bahia.lan>
 <157686070815.97184.16561911770080665569.stgit@bahia.lan>
 <20191221003906.GC15511@umbus.fritz.box>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/E9YtRvApOS+NI+8hMEmGyKr";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Ovh-Tracer-Id: 17574734599740430822
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdduhedgudehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtsehgtderreertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejudehrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.33.109.80
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
Cc: qemu-ppc@nongnu.org, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/E9YtRvApOS+NI+8hMEmGyKr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 21 Dec 2019 11:39:06 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Fri, Dec 20, 2019 at 05:51:48PM +0100, Greg Kurz wrote:
> > Multi TCG mandates the CPU topology to be dimensioned to the actual
> > number of CPUs, depending on the number of chips the user asked for.
> > That is, '-machine num-chips=3DN' should always have a '-smp' companion
> > with a topology that meats the resulting number of CPUs, typically
> > '-smp sockets=3DN'.
> >=20
> > Simplify the command line for these setups by computing the default
> > number of chips based on the CPU topology, ie. no need to explicitely
> > set "num-chips" anymore. This must be done at machine init because
> > smp_parse() is called after instance init.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
>=20
> Is there actually any reason to retain num-chips at all?  Or could we
> just set the number of chips equal to the number of sockets, which
> seems to make sense to me.
>=20

I don't quite know why "num-chips" was introduced in the first place... so
yes, if it turns out it isn't needed, I'll gladly drop the property.

> > ---
> >  hw/ppc/pnv.c |   23 ++++++++++++++++-------
> >  1 file changed, 16 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> > index f8cf2b6d760f..9b777b7084a0 100644
> > --- a/hw/ppc/pnv.c
> > +++ b/hw/ppc/pnv.c
> > @@ -768,6 +768,19 @@ static void pnv_init(MachineState *machine)
> >          exit(1);
> >      }
> > =20
> > +    if (!pnv->num_chips) {
> > +        uint32_t num_chips =3D
> > +            machine->smp.max_cpus / (machine->smp.cores * machine->smp=
.threads);
> > +        Error *local_err =3D NULL;
> > +
> > +        object_property_set_uint(OBJECT(pnv), num_chips, "num-chips",
> > +                                 &local_err);
> > +        if (local_err) {
> > +            error_report_err(local_err);
> > +            exit(1);
> > +        }
> > +    }
> > +
> >      pnv->chips =3D g_new0(PnvChip *, pnv->num_chips);
> >      for (i =3D 0; i < pnv->num_chips; i++) {
> >          char chip_name[32];
> > @@ -1722,6 +1735,9 @@ static void pnv_set_num_chips(Object *obj, Visito=
r *v, const char *name,
> >       */
> >      if (!is_power_of_2(num_chips) || num_chips > 4) {
> >          error_setg(errp, "invalid number of chips: '%d'", num_chips);
> > +        error_append_hint(errp,
> > +                          "Set 'num-chips' implicitely with '-smp sock=
ets=3DN'. "
> > +                          "Valid values are : 1, 2 or 4.\n");
> >          return;
> >      }
> > =20
> > @@ -1735,12 +1751,6 @@ static void pnv_set_num_chips(Object *obj, Visit=
or *v, const char *name,
> >      pnv->num_chips =3D num_chips;
> >  }
> > =20
> > -static void pnv_machine_instance_init(Object *obj)
> > -{
> > -    PnvMachineState *pnv =3D PNV_MACHINE(obj);
> > -    pnv->num_chips =3D 1;
> > -}
> > -
> >  static void pnv_machine_class_props_init(ObjectClass *oc)
> >  {
> >      object_class_property_add(oc, "num-chips", "uint32",
> > @@ -1874,7 +1884,6 @@ static const TypeInfo types[] =3D {
> >          .parent        =3D TYPE_MACHINE,
> >          .abstract       =3D true,
> >          .instance_size =3D sizeof(PnvMachineState),
> > -        .instance_init =3D pnv_machine_instance_init,
> >          .class_init    =3D pnv_machine_class_init,
> >          .class_size    =3D sizeof(PnvMachineClass),
> >          .interfaces =3D (InterfaceInfo[]) {
> >=20
>=20


--Sig_/E9YtRvApOS+NI+8hMEmGyKr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAl398+EACgkQcdTV5YIv
c9bYjQ/+Onbpnxy+3JPjYH2APiYsfTx0vQUtVUDn8GGoQF+Bw6QViGuIcKYEoNbh
9Q3F99r7PF0QzPfBfwU8CqANVHYZF+mJZmwb0gC8Bwm9RbpVooxfMUDssrlyQbt3
Q67tqi8FLhIo2hfB4/TAxQLNxb4osfsA+PJZalKsq9/EkKIfzI80FJYkKf6e8Z3r
DMf8pulRVz75R9NaCaZuS3B3lRVlmwboPaBVWAVNyt8E/ee71RBh22LnS2n64dRI
24JBnL6QeA/wFOwWwIkRN+8m+stZMkhCm7CH7zFec3cOddk7kCjZKvCNKFYv8Q4s
dIunhHw0zkOAIlJMSKd6VCeLkaPDlMenM/8gNh0WfSlnJzy5DnibUQXuzHprjg6o
t25CwXBgJvlwtP4FhKxQ32k/n+2S7xTsibe7102dxDWguh5K2JWO4GDeXW8vwi7G
v/1CQKX4DlP2LzX9GsFDrq6mTww2JI5M+nZnc+2ZfNdJoMqHXg6ik5BriQa8sM8C
0Eiur+4NgnsFxxkn0tRsw/eXYTUTG6hZm7k7PULSxTf+J9r28bk962YM5ljkS7ws
j2TCkoSkiQ8uAsZcIWjvf8Xkk7/VbKrKQtidEStSOh23+xE6+o+cCPR8nOw17V0K
NbGr70OyhB1LH/LDMJBs0OAvdEXLIg1D6l3III2BVf5PlDb+qW0=
=Si3t
-----END PGP SIGNATURE-----

--Sig_/E9YtRvApOS+NI+8hMEmGyKr--

