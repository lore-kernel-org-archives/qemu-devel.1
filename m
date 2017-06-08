Received: from eggs.gnu.org ([2001:4830:134:3::10]:54805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dItCm-0004r3-54
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 04:54:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dItCi-0007Jz-UJ
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 04:54:12 -0400
Received: from 3.mo178.mail-out.ovh.net ([46.105.44.197]:41251)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dItCi-0007Jh-Oc
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 04:54:08 -0400
Received: from player728.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 08F0532C2D
	for <qemu-devel@nongnu.org>; Thu,  8 Jun 2017 10:54:07 +0200 (CEST)
Date: Thu, 8 Jun 2017 10:54:02 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170608105402.5b19af21@bahia.ttt.fr.ibm.com>
In-Reply-To: <3a0cab6c-a913-e7e8-4a07-fbd7509731db@kaod.org>
References: <149685579678.12025.9278446121024037161.stgit@bahia.lan>
	<149685582923.12025.13700165807436904935.stgit@bahia.lan>
	<c632e0a3-c6bb-2637-40c3-5098937476a5@kaod.org>
	<20170607225507.5d2c6c33@bahia.ttt.fr.ibm.com>
	<3a0cab6c-a913-e7e8-4a07-fbd7509731db@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/R9eH9Qbl1Wl7g6VW=+hFlFQ";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v3 3/5] xics: setup cpu at realize time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

--Sig_/R9eH9Qbl1Wl7g6VW=+hFlFQ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 8 Jun 2017 07:50:08 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> On 06/07/2017 10:55 PM, Greg Kurz wrote:
> [...]
> >>> +    obj =3D object_new(TYPE_PNV_ICP);
> >>> +    object_property_add_child(child, "icp", obj, NULL);
> >>> +    object_unref(obj);
> >>> +    object_property_add_const_link(obj, "xics", OBJECT(xi), &error_a=
bort);
> >>> +    object_property_add_const_link(obj, "cs", child, &error_abort); =
  =20
> >>
> >> may be link the cpu object instead ?=20
> >> =20
> >=20
> > I'm not sure to understand... isn't child supposed to be a CPU index he=
re ? =20
>=20
> I meant linking the 'PowerPCCPU *cpu' object and not the CPUState.
> That's minor.
>=20

Well, cpu =3D=3D cs =3D=3D child and object_property_add_const_link() expec=
ts
an Object *. Passing child avoids a not-really-useful OBJECT() dynamic
cast.

--Sig_/R9eH9Qbl1Wl7g6VW=+hFlFQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlk5EKoACgkQAvw66wEB28Ja2ACfViFWAYwd51NM+KD62DsCyJOI
PCEAn1/lfUd/gdOsKZTyDqXKIYnbwFAE
=DfS1
-----END PGP SIGNATURE-----

--Sig_/R9eH9Qbl1Wl7g6VW=+hFlFQ--
