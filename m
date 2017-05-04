Received: from eggs.gnu.org ([2001:4830:134:3::10]:33816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1d6ML0-0000Ya-PI
	for qemu-devel@nongnu.org; Thu, 04 May 2017 15:22:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1d6MKw-0007p0-NZ
	for qemu-devel@nongnu.org; Thu, 04 May 2017 15:22:54 -0400
Received: from 1.mo5.mail-out.ovh.net ([188.165.57.91]:60499)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1d6MKw-0007oP-Gv
	for qemu-devel@nongnu.org; Thu, 04 May 2017 15:22:50 -0400
Received: from player786.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 84ADFEADB4
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 21:22:48 +0200 (CEST)
Date: Thu, 4 May 2017 21:22:37 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170504212237.341bf8ef@bahia>
In-Reply-To: <1493908379.4214.8.camel@redhat.com>
References: <20170427072843.8089-1-david@gibson.dropbear.id.au>
	<1493908379.4214.8.camel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/+9PD+CfrVxQ/Ta=7JnzivGI";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCHv3 0/4] Clean up compatibility
 mode handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrea Bolognani <abologna@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, clg@kaod.org, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, armbru@redhat.com

--Sig_/+9PD+CfrVxQ/Ta=7JnzivGI
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 04 May 2017 16:32:59 +0200
Andrea Bolognani <abologna@redhat.com> wrote:

> On Thu, 2017-04-27 at 17:28 +1000, David Gibson wrote:
> > This is a rebased and revised version of my patches revising CPU
> > compatiblity mode handling on ppc, last posted in November.=C2=A0=C2=A0=
Since
> > then, many of the patches have already been merged (some for 2.9, some
> > since).=C2=A0=C2=A0This is what's left.
> >=C2=A0
> >=C2=A0=C2=A0* There was conceptual confusion about what a compatibility =
mode
> >=C2=A0=C2=A0=C2=A0=C2=A0means, and how it interacts with the machine typ=
e.=C2=A0=C2=A0This cleans
> >=C2=A0=C2=A0=C2=A0=C2=A0that up, clarifying that a compatibility mode (a=
s an externally set
> >=C2=A0=C2=A0=C2=A0=C2=A0option) only makes sense on machine types that d=
on't permit the
> >=C2=A0=C2=A0=C2=A0=C2=A0guest hypervisor privilege (i.e. 'pseries')
> >=C2=A0
> >=C2=A0=C2=A0* It was previously the user's (or management layer's) respo=
nsibility
> >=C2=A0=C2=A0=C2=A0=C2=A0to determine compatibility of CPUs on either end=
 for migration.
> >=C2=A0=C2=A0=C2=A0=C2=A0This uses the compatibility modes to check that =
properly during an
> >=C2=A0=C2=A0=C2=A0=C2=A0incoming migration. =20
>=20
> I started playing with this, mostly with libvirt integration
> in mind of course, and quickly ran into a behavior that I
> believe was not intentional and unfortunately managed to slip
> into 2.9, I assume through the patches which were initially
> part of this series (mentioned above).
>=20
> More specifically, when I run a guest with
>=20
> =C2=A0 -M pseries-2.8 -cpu host
>=20
> using QEMU 2.8, the CPU in the guest is reported as
>=20
> =C2=A0 POWER8E (raw), altivec supported
>=20
> However, when using QEMU 2.9 with the very same command line,
> including explicitly using the pseries-2.8 machine type, I
> get
>=20
> =C2=A0 POWER8 (architected), altivec supported
>=20

The goal of this series is indeed to switch from raw to architected but I
agree that it shouldn't affect existing machine types. This probably calls
for some compat prop.

> instead. The same happens with current master + your patches
> applied on top.
>=20
> I'm not sure how much real trouble that will actually cause
> for guests, but it's a guest-visible change as a result of
> upgrading QEMU, which should just not happen.
>=20
>=20
> I'll keep testing your series and get back to you as soon as
> I have more feedback or questions.
>=20
> --=C2=A0
> Andrea Bolognani / Red Hat / Virtualization
>=20


--Sig_/+9PD+CfrVxQ/Ta=7JnzivGI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlkLf30ACgkQAvw66wEB28IpQgCfSejn80qzOcyUf4UFf1ERbwB7
nNEAnAhe66nNGCKYhJPjjKV+7cnI8IYI
=5U8P
-----END PGP SIGNATURE-----

--Sig_/+9PD+CfrVxQ/Ta=7JnzivGI--
