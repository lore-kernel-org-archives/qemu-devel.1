Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9050BC2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 12:19:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 666A720665
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 12:19:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 666A720665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49512 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZDqR-0001gn-CI
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 08:19:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38358)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groug@kaod.org>) id 1hZC8b-0005kd-Lq
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 06:30:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1hZC8Z-00032v-CU
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 06:30:21 -0400
Received: from 4.mo2.mail-out.ovh.net ([87.98.172.75]:48564)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1hZC8X-0002yV-8O
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 06:30:17 -0400
Received: from player750.ha.ovh.net (unknown [10.109.146.19])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id 0EA4819E715
 for <qemu-devel@nongnu.org>; Fri,  7 Jun 2019 12:30:13 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player750.ha.ovh.net (Postfix) with ESMTPSA id 1E7F46B3AA63;
 Fri,  7 Jun 2019 10:30:05 +0000 (UTC)
Date: Fri, 7 Jun 2019 12:30:03 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190607123003.65750643@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20190607002240.GD3760@umbus.fritz.box>
References: <155910829070.13149.5215948335633966328.stgit@aravinda>
 <155910845769.13149.8097972239187020170.stgit@aravinda>
 <20190606030614.GK10319@umbus.fritz.box>
 <20190606080609.28b4dd15@bahia.lab.toulouse-stg.fr.ibm.com>
 <9a4291d3-2ae6-92f3-6922-e8924398cdb7@linux.vnet.ibm.com>
 <20190606141048.01e7d6be@bahia.lab.toulouse-stg.fr.ibm.com>
 <20190607002240.GD3760@umbus.fritz.box>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Vw/gxCIECsPoTlcdYtq3s/u"; protocol="application/pgp-signature"
X-Ovh-Tracer-Id: 4374402614701234662
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudegiedgvdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 87.98.172.75
Subject: Re: [Qemu-devel] [PATCH v9 6/6] migration: Include migration
 support for machine check handling
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
Cc: aik@au1.ibm.com, qemu-devel@nongnu.org, paulus@ozlabs.org,
 qemu-ppc@nongnu.org, Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/Vw/gxCIECsPoTlcdYtq3s/u
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 7 Jun 2019 10:22:40 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Thu, Jun 06, 2019 at 02:10:48PM +0200, Greg Kurz wrote:
> > On Thu, 6 Jun 2019 16:45:30 +0530
> > Aravinda Prasad <aravinda@linux.vnet.ibm.com> wrote:
> >  =20
> > > On Thursday 06 June 2019 11:36 AM, Greg Kurz wrote: =20
> > > > On Thu, 6 Jun 2019 13:06:14 +1000
> > > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > > >    =20
> > > >> On Wed, May 29, 2019 at 11:10:57AM +0530, Aravinda Prasad wrote:  =
 =20
> > > >>> This patch includes migration support for machine check
> > > >>> handling. Especially this patch blocks VM migration
> > > >>> requests until the machine check error handling is
> > > >>> complete as (i) these errors are specific to the source
> > > >>> hardware and is irrelevant on the target hardware,
> > > >>> (ii) these errors cause data corruption and should
> > > >>> be handled before migration.
> > > >>>
> > > >>> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> > > >>> ---
> > > >>>  hw/ppc/spapr.c         |   20 ++++++++++++++++++++
> > > >>>  hw/ppc/spapr_events.c  |   17 +++++++++++++++++
> > > >>>  hw/ppc/spapr_rtas.c    |    4 ++++
> > > >>>  include/hw/ppc/spapr.h |    2 ++
> > > >>>  4 files changed, 43 insertions(+)
> > > >>>
> > > >>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > >>> index e8a77636..31c4850 100644
> > > >>> --- a/hw/ppc/spapr.c
> > > >>> +++ b/hw/ppc/spapr.c
> > > >>> @@ -2104,6 +2104,25 @@ static const VMStateDescription vmstate_sp=
apr_dtb =3D {
> > > >>>      },
> > > >>>  };
> > > >>> =20
> > > >>> +static bool spapr_fwnmi_needed(void *opaque)
> > > >>> +{
> > > >>> +    SpaprMachineState *spapr =3D (SpaprMachineState *)opaque;
> > > >>> +
> > > >>> +    return (spapr->guest_machine_check_addr =3D=3D -1) ? 0 : 1; =
    =20
> > > >>
> > > >> Since we're introducing a PAPR capability to enable this, it would
> > > >> actually be better to check that here, rather than the runtime sta=
te.
> > > >> That leads to less cases and easier to understand semantics for the
> > > >> migration stream.
> > > >>   =20
> > > >=20
> > > > Hmmm... the purpose of needed() VMState callbacks is precisely about
> > > > runtime state: the subsection should only be migrated if an MCE is
> > > > pending, ie. spapr->guest_machine_check_addr !=3D -1.   =20
> > >=20
> > > spapr->guest_machine_check_addr is set when fwnmi is registered. Hence
> > > an MCE might not be pending if it is set.
> > >  =20
> >=20
> > Oops sorry, got confused... should have written "if the guest has
> > registered FWNMI", but the idea is the same. We only need to migrate
> > the subsection if the state is different from reset. This is the way
> > needed() callbacks are generally implemented. =20
>=20
> Yes, but usually that's because we need to omit the section if it's
> not actively in use in order to maintain backwards compatiblity with
> old migration streams.  If the cap is enabled we already need
> something that implements it at both ends to have a sane migration.
>=20

I see it the opposite way. A subsection is something that is optional
for the destination only. In the present case, an older QEMU wont send
the "spapr_machine_check" subsection, which is interpreted by a newer
QEMU as "the guest didn't register FWNMI".

On the source side, if some internal state got used it should always
be migrated. We maintain backwards compatibility to an older QEMU
by not using the new state at all, thanks to the versioned machine
property.

> > > I am fine with both the approaches (checking for
> > > guest_machine_check_addr or for SPAPR_CAP_FWNMI_MCE).
> > >  =20
> >=20
> > I would find ackward to migrate this always for new machine types,
> > even if the guest doesn't register FWNMI... =20
>=20
> How so?
>=20

Well, I just don't see the point in migrating something that
is not state since its value is the reset default that the
destination already knows.

This being said, I won't make more fuss about it, as long as
it works :)

--Sig_/Vw/gxCIECsPoTlcdYtq3s/u
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAlz6PKsACgkQcdTV5YIv
c9ariBAAj4JQO+nll0Af2VOqJZra1nFjcYVYLgNmoOSRxJvrvTCLFFDYeFPaHy4J
OqpFPJyZrnbomOAc8vxdlcjNK4KQF+WCdXBjcA6Znvy819xzg0RpEsQM+uny84RG
FlerbH1LW6TpIj+3oh/oiX+XJZgaI9EFjjJ1INGndRLcEwAP9WYgupi3wzMmFCFo
KtF7Gt08ZOAwpmqt7xglf4tdys3fL0DA/uCevhmjkNe4c3yez68VFg1XbxKyxLsJ
/RHQRBZP+toCkb5sEcjmvkXx+7LWtcLCSioPCtEsZ3NXj+mwdQ0cZeZVbTCgoZ5E
zVlZ1v/2GW49QPN38yDW9frNjJSxAVtA4fZ7YsXZ5+TQoxAxWZMJVP0ZZZPkh7by
3Lo1Y928VbAaDdtEwdH1QeKrz6YvEO49333+MujXVE0gKjEomydfC2CUpiyhK0Y6
wE+TSc+nz0luJ1zy5rRLl3imK2xfwOYE/BTiIKz8VoVZYCVvHLNVcjtK1efTSeny
jA1Pn4NofTZL9j0flaAuKI+XkxsNtygkEE8ibK82bYXARNxKu94TSWx6EaaGjuJb
jskDXA3ZotdCS9kKJzNJR8+fGCWd3aTc5Uej51/AI4yfQ1lXoxl1xby+BsEvSjPR
3y4x6XJK/Nl4o2qEst1Qls60J0GeVonFQYfYUNocunH5XOzVXN0=
=vl74
-----END PGP SIGNATURE-----

--Sig_/Vw/gxCIECsPoTlcdYtq3s/u--

