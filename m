Received: from eggs.gnu.org ([2001:4830:134:3::10]:37897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1db0oW-0000wp-34
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 04:40:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1db0oS-0002ri-2C
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 04:40:04 -0400
Received: from 8.mo7.mail-out.ovh.net ([46.105.77.114]:49773)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1db0oR-0002qg-P9
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 04:40:00 -0400
Received: from player762.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id 45087657EE
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 10:39:58 +0200 (CEST)
Date: Fri, 28 Jul 2017 10:39:45 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170728103945.3ad4713f@bahia.lan>
In-Reply-To: <cd9ef0ba-c329-bac2-6b94-a8397d7b45cc@kaod.org>
References: <150100547373.27487.3154210751350595400.stgit@bahia>
	<07a10650-f216-99ea-fb48-286887279bf1@linux.vnet.ibm.com>
	<20170727183926.246b5beb@bahia.lan>
	<20bc63c9-0649-5b82-5042-61e7313cf833@ozlabs.ru>
	<20170728034042.GD3098@umbus.fritz.box>
	<cd9ef0ba-c329-bac2-6b94-a8397d7b45cc@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/85hzzIK/jSZ.jfI2eXQQ4GH";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [Qemu-ppc] [for-2.11 PATCH 00/26] spapr: add
 support for PHB hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, Alexey Kardashevskiy <aik@ozlabs.ru>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>

--Sig_/85hzzIK/jSZ.jfI2eXQQ4GH
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 28 Jul 2017 07:35:34 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> On 07/28/2017 05:40 AM, David Gibson wrote:
> > On Fri, Jul 28, 2017 at 01:27:05PM +1000, Alexey Kardashevskiy wrote: =
=20
> >> On 28/07/17 02:39, Greg Kurz wrote: =20
> >>> On Wed, 26 Jul 2017 17:31:17 -0300
> >>> Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com> wrote:
> >>> =20
> >>>> I've tested the patch set using Greg's Github branch. It worked fine=
 in=20
> >>>> my tests
> >>>> using a Fedora 26 and an Ubuntu 17.04 guests. I have two observations
> >>>> though:
> >>>>
> >>>> 1 - This is not related to this patch set per se because it is=20
> >>>> reproducible on master, but
> >>>> I think it is interfering with this new feature.  There is a=20
> >>>> warning/error message in
> >>>> the kernel right after SLOF that goes:
> >>>>
> >>>> (...) =20
> >>>>   -> smp_release_cpus()   =20
> >>>> spinning_secondaries =3D 0
> >>>>   <- smp_release_cpus()
> >>>> Linux ppc64le
> >>>> #1 SMP Mon Jul 1[    0.030450] pci 0000:00:02.0: of_irq_parse_pci:=20
> >>>> failed with rc=3D-22
> >>>> [    0.030552] pci 0000:00:0f.0: of_irq_parse_pci: failed with rc=3D=
-22
> >>>> [  OK  ] Started Security Auditing Service.
> >>>> (...)
> >>>> =20
> >>>
> >>> This is a regression in QEMU master introduced by this commit:
> >>>
> >>> commit b87680427e8a3ff682f66514e99a8344e7437247
> >>> Author: C=C3=A9dric Le Goater <clg@kaod.org>
> >>> Date:   Wed Jul 5 19:13:15 2017 +0200
> >>>
> >>>     spapr: populate device tree depending on XIVE_EXPLOIT option
> >>>    =20
> >>>     When XIVE is supported, the device tree should be populated
> >>>     accordingly and the XIVE memory regions mapped to activate MMIOs.
> >>>    =20
> >>>     Depending on the design we choose, we could also allocate differe=
nt
> >>>     ICS and ICP objects, or switch between objects. This needs to be
> >>>     discussed.
> >>>    =20
> >>>     Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> >>>     Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> >>>
> >>> It is very similar to the issue that motivated the new KVMPPC_H_UPDAT=
E_PHANDLE
> >>> hcall (see patch 24 and 26 in this series):
> >>>
> >>> - QEMU creates an "interrupt-controller" node with a phandle property
> >>>   with the value 0x1111
> >>> - QEMU passes the FDT to SLOF
> >>> - SLOF converts all references to the phandle to an SLOF internal val=
ue
> >>> =20
> >>> =3D> from now on (ie, until the next machine reset), the guest only k=
nows =20
> >>>    the OF phandle.
> >>>
> >>> - during CAS, if we go XICS, we send back an updated FDT with the
> >>>   phandle of the "interrupt-controller" node reverted to 0x1111
> >>> =20
> >>> =3D> the guest complains because all cold-plugged devices nodes refer=
 =20
> >>>    to the OF phandle, not 0x1111
> >>>
> >>> A solution is to use the value set by KVMPPC_H_UPDATE_PHANDLE during =
CAS
> >>> instead of 0x1111. I could verify it makes the guest warning disappea=
r.
> >>>
> >>> I'll send a dedicated patchset to fix this in 2.10. =20
> >>
> >>
> >> The SLOF I pushed for 2.10 does not have it though. And the rest of XI=
VE is
> >> not targeted for 2.10 anyway. So imho the solution is reverting "spapr:
> >> populate device tree depending on XIVE_EXPLOIT option" for 2.10. =20
> >=20
> > I agree, I've applied the revert to ppc-for-2.10 now. =20
>=20
> Sure.=20
>=20
> Greg, have you found a solution to get around this problem or do we need
> to populate the device tree with the interrupt controller node for SLOF ?=
=20
>=20

With commit b87680427e8a, spapr_dt_xics() is called twice actually: first
time during machine reset and a second time during CAS.

The first call means we start in XICS mode by default. But I don't understa=
nd
why it is also called during CAS: if the guest didn't advertise XIVE, then
we don't have anything to do, do we ?

Cheers,

--
Greg

> Thanks,
>=20
> C. =20
>=20


--Sig_/85hzzIK/jSZ.jfI2eXQQ4GH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAll6+FEACgkQAvw66wEB28KvXgCfaiv7meIOZgeqMo6WO1xW0pCG
l2QAn0n+trpl5FVsN9/9OSpqiGh5BNr5
=unDM
-----END PGP SIGNATURE-----

--Sig_/85hzzIK/jSZ.jfI2eXQQ4GH--
