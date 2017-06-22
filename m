Received: from eggs.gnu.org ([2001:4830:134:3::10]:51275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dO5CE-00079I-BE
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 12:43:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dO5CB-0001VB-8D
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 12:43:06 -0400
Received: from 4.mo5.mail-out.ovh.net ([178.33.111.247]:56954)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dO5CB-0001TS-0w
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 12:43:03 -0400
Received: from player695.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 772A410C57D
	for <qemu-devel@nongnu.org>; Thu, 22 Jun 2017 18:43:01 +0200 (CEST)
Date: Thu, 22 Jun 2017 18:42:55 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170622184255.2d44e3bd@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <CAFEAcA8yqb8ykP8nCnoVNQUZd851RhOLFf2TfkHZmL2je+pP=Q@mail.gmail.com>
References: <149814756006.27338.8723356702388175951.stgit@bahia>
	<CAFEAcA8yqb8ykP8nCnoVNQUZd851RhOLFf2TfkHZmL2je+pP=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/l6UDZ_XfHgpvO.GVsI_IG1d";
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>

--Sig_/l6UDZ_XfHgpvO.GVsI_IG1d
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 22 Jun 2017 17:14:08 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On 22 June 2017 at 17:06, Greg Kurz <groug@kaod.org> wrote:
> > Function types cannot reside in the same sorted list as opaque types si=
nce
> > they may depend on a type which would be defined later.
> >
> > Of course, the same problem could arise if a function type depends on
> > another function type with greater alphabetical order. Hopefully we
> > don't have that at this time. =20
>=20
> The other approach would be to put function types somewhere
> else and leave typedefs.h for the simple 'opaque types
> for structures' that it was started as.
>=20
> For instance we have include/qemu/fprintf-fn.h as a precedent.
>=20

Indeed, and I'm not quite sure why Juan decided to put these types into
typedefs.h instead of a dedicated header file in include/migration... is
it only because it was the quickest fix ?

> thanks
> -- PMM


--Sig_/l6UDZ_XfHgpvO.GVsI_IG1d
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAllL848ACgkQAvw66wEB28KHpACdEKMhm+2wFlTmol5zFp5iEwqk
N+wAoJqM1m9VLLOrPoTak37EP+gCTy/E
=X6OY
-----END PGP SIGNATURE-----

--Sig_/l6UDZ_XfHgpvO.GVsI_IG1d--
