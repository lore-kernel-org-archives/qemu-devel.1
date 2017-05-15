Received: from eggs.gnu.org ([2001:4830:134:3::10]:57436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dAIjM-0000lz-Jn
	for qemu-devel@nongnu.org; Mon, 15 May 2017 12:20:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dAIjH-0006HA-KS
	for qemu-devel@nongnu.org; Mon, 15 May 2017 12:20:20 -0400
Received: from 8.mo69.mail-out.ovh.net ([46.105.56.233]:35970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dAIjH-0006G6-Dn
	for qemu-devel@nongnu.org; Mon, 15 May 2017 12:20:15 -0400
Received: from player699.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id D03671F9D6
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 18:20:13 +0200 (CEST)
Date: Mon, 15 May 2017 18:20:06 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170515182006.5748aaa2@bahia>
In-Reply-To: <adcf8e71-65c0-2952-6d01-cdaddb81d0f9@kaod.org>
References: <149484833874.20089.4164801378197848306.stgit@bahia.lan>
	<149484840466.20089.893964776019028654.stgit@bahia.lan>
	<a94cf0ed-3318-fb2d-f16c-4d2b12fff3bb@kaod.org>
	<20170515151602.61dc381d@bahia>
	<adcf8e71-65c0-2952-6d01-cdaddb81d0f9@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/RzYAUHdeVCRZ/iMmKQPAX93";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH 6/6] spapr: fix migration of ICP objects
 from/to older QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

--Sig_/RzYAUHdeVCRZ/iMmKQPAX93
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 15 May 2017 18:09:04 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> On 05/15/2017 03:16 PM, Greg Kurz wrote:
> > On Mon, 15 May 2017 14:22:32 +0200
> > C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> >  =20
> >> On 05/15/2017 01:40 PM, Greg Kurz wrote: =20
> >>> Commit 5bc8d26de20c ("spapr: allocate the ICPState object from under
> >>> sPAPRCPUCore") moved ICP objects from the machine to CPU cores. This
> >>> is an improvement since we no longer allocate ICP objects that will
> >>> never be used. But it has the side-effect of breaking migration of
> >>> older machine types from older QEMU versions.
> >>>
> >>> This patch introduces a compat flag in the sPAPR machine class so
> >>> that all pseries machine up to 2.9 go on with the previous behavior
> >>> of pre-allocating ICP objects.   =20
> >>
> >> I think this is a quite elegant way to a handle the migration=20
> >> regression. Thanks for taking care of it.
> >>
> >> Have you tried to simply reparent the ICPs objects to OBJECT(spapr)=20
> >> instead of the OBJECT(cpu)  ?=20
> >> =20
> >=20
> > Do you mean to reparent unconditionally to OBJECT(spapr) for all
> > machine versions ?  =20
>=20
> only in the case of smc->must_pre_allocate_icps
>=20
> > I'm not sure this would be beneficial, but I might be missing=20
> > something... =20
>=20
> I think that we would not need to allocate the legacy_icps array.=20
> Parenting the icp object to the spapr machine should be enough.=20
> I might be wrong. my expertise on the migration stream is very=20
> basic.
>=20

I don't think this would work because an older QEMU would still
send state for objects that don't exist in the destination.

> C.
> =20


--Sig_/RzYAUHdeVCRZ/iMmKQPAX93
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlkZ1TcACgkQAvw66wEB28Ie/QCeMo4dhEiQsBAmAU7nIz6tXhjy
ozsAn1dfiZeEgLXhgooWwKobJBN4qKib
=Zu5t
-----END PGP SIGNATURE-----

--Sig_/RzYAUHdeVCRZ/iMmKQPAX93--
