Received: from eggs.gnu.org ([2001:4830:134:3::10]:39740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dO6C7-0001Kr-H7
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 13:47:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dO6C2-0000ng-LH
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 13:47:03 -0400
Received: from 5.mo5.mail-out.ovh.net ([87.98.173.103]:46963)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dO6C2-0000nO-Eo
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 13:46:58 -0400
Received: from player695.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 9C58B10C395
	for <qemu-devel@nongnu.org>; Thu, 22 Jun 2017 19:46:56 +0200 (CEST)
Date: Thu, 22 Jun 2017 19:46:49 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170622194649.6d251753@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20170622172555.GE2100@work-vm>
References: <149814756006.27338.8723356702388175951.stgit@bahia>
	<CAFEAcA8yqb8ykP8nCnoVNQUZd851RhOLFf2TfkHZmL2je+pP=Q@mail.gmail.com>
	<20170622184255.2d44e3bd@bahia.lab.toulouse-stg.fr.ibm.com>
	<87injo6jla.fsf@secure.mitica>
	<CAFEAcA-g-=AkH3t8jOTFY_9zA6ECS57-3MS=cHPb+Q6sePzNsw@mail.gmail.com>
	<20170622172555.GE2100@work-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/Ol4==XrB/U=/M=FrZCsBREQ";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH] Separate function types from opaque types
 in include/qemu/typedefs.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Juan Quintela <quintela@redhat.com>

--Sig_/Ol4==XrB/U=/M=FrZCsBREQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 22 Jun 2017 18:25:55 +0100
"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:

> * Peter Maydell (peter.maydell@linaro.org) wrote:
> > On 22 June 2017 at 18:03, Juan Quintela <quintela@redhat.com> wrote: =20
> > > Greg Kurz <groug@kaod.org> wrote: =20
> > >> On Thu, 22 Jun 2017 17:14:08 +0100
> > >> Peter Maydell <peter.maydell@linaro.org> wrote:
> > >> =20
> > >>> On 22 June 2017 at 17:06, Greg Kurz <groug@kaod.org> wrote: =20
> > >>> > Function types cannot reside in the same sorted list as opaque ty=
pes since
> > >>> > they may depend on a type which would be defined later.
> > >>> >
> > >>> > Of course, the same problem could arise if a function type depend=
s on
> > >>> > another function type with greater alphabetical order. Hopefully =
we
> > >>> > don't have that at this time. =20
> > >>>
> > >>> The other approach would be to put function types somewhere
> > >>> else and leave typedefs.h for the simple 'opaque types
> > >>> for structures' that it was started as.
> > >>>
> > >>> For instance we have include/qemu/fprintf-fn.h as a precedent.
> > >>> =20
> > >>
> > >> Indeed, and I'm not quite sure why Juan decided to put these types i=
nto
> > >> typedefs.h instead of a dedicated header file in include/migration..=
. is
> > >> it only because it was the quickest fix ? =20
> > >
> > > All other typedefs were defined there.  I can create a different incl=
ude
> > > file, but I think that is "overengineering", no?  They are typedefs,
> > > just not of structs.  But I agree that they are the only ones. =20
> >=20
> > Well, the comment in the file says "opaque types so that device init
> > declarations don't have to pull in all the real definitions", whereas
> > the ones you've added aren't opaque types, they are the real
> > definitions. They're also only used by a very small subset of .c
> > files, whereas typedefs.h goes everywhere. =20
>=20
> mv fprintf-fn.f   fn-typedefs.h
>=20
> move those two defs into that?
>=20

Wouldn't it be more appropriate to put them in a dedicated
include/migration/handler-fn.h header included by both
vmstate.h and register.h ?

> Dave
>=20
> > thanks
> > -- PMM =20
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>=20


--Sig_/Ol4==XrB/U=/M=FrZCsBREQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAllMAokACgkQAvw66wEB28I1tACfQfSrELMjojbo/CgXMVG/KnU1
HtAAmQEgpzV7Udkju1qAg7tYm7BmnZD1
=XuXV
-----END PGP SIGNATURE-----

--Sig_/Ol4==XrB/U=/M=FrZCsBREQ--
