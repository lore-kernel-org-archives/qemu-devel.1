Received: from eggs.gnu.org ([2001:4830:134:3::10]:53104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dAxmj-0005bC-Tv
	for qemu-devel@nongnu.org; Wed, 17 May 2017 08:10:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dAxmj-0004LL-1h
	for qemu-devel@nongnu.org; Wed, 17 May 2017 08:10:33 -0400
Date: Wed, 17 May 2017 13:10:24 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170517121024.GD8260@stefanha-x1.localdomain>
References: <1494842563-6534-1-git-send-email-pl@kamp.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DrWhICOqskFTAXiy"
Content-Disposition: inline
In-Reply-To: <1494842563-6534-1-git-send-email-pl@kamp.de>
Subject: Re: [Qemu-devel] [Qemu-block] [RFC PATCH] qemu-io: add
 drain/undrain cmd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>
Cc: qemu-block@nongnu.org, kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com


--DrWhICOqskFTAXiy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 15, 2017 at 12:02:43PM +0200, Peter Lieven wrote:
> I would like to add a feature to Qemu to drain all traffic from a block s=
o that
> I can take external snaphosts without the risk to that in the middle of a=
 write
> operation. Its meant for cases where where QGA freeze/thaw is not availab=
le.
>=20
> For me its enough to have this through qemu-io, but Kevin asked me to che=
ck
> if its not worth to have a stable API for it and present it via QMP/HMP.
>=20
> What are your thoughts?

Are the existing snapshot and blockjobs not sufficient for taking
external snapshots?

--DrWhICOqskFTAXiy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZHD2wAAoJEJykq7OBq3PIlYkH/2hNFZoVDELOZ9+8ddcabT+C
wVwPoE5W9K7eNwL3cvkOYAg4yYRk3pY8oravkzzAvo6JvnKyEMJRC4AG2o5dXDEz
EWpw/wnVwkaPWKuVp+qPTytCWO3/kOi2oJTIjMevbvlaUMFE00x5zxInV3YwTR9V
+AL+GzpVcJI8wQvewb8WBB6qCiTGoyCZWi3fCCXGl12V9n/EhgjHeaumSXHZH1k4
802Kjc4xDHTx65+gK8l11I9DvEiTeEPKZ1bMeAv6rB3STFXQhCbG4YY5xoLjQCvT
qonJ0sP+cgA20th5L1STrX6msQZoLyDBe585kXwIMbZ9bSrcf0yGWaK6lGkyv8c=
=e7ie
-----END PGP SIGNATURE-----

--DrWhICOqskFTAXiy--
