Received: from eggs.gnu.org ([2001:4830:134:3::10]:56644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1caUjm-0005Jy-NC
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 16:52:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1caUjm-0007vT-0e
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 16:52:46 -0500
References: <20170123123056.30383-1-famz@redhat.com>
	<20170123123056.30383-4-famz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <dba94e70-c4fd-4871-cdc1-0e0fc2d9522f@redhat.com>
Date: Sun, 5 Feb 2017 22:52:37 +0100
MIME-Version: 1.0
In-Reply-To: <20170123123056.30383-4-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="RQnGUj9KsvrPfFiF4ERRth3cPlSKTOx3h"
Subject: Re: [Qemu-devel] [PATCH v12 03/16] qemu-io: Set "share-rw" flag
 together with read-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-block@nongnu.org, eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, rjones@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RQnGUj9KsvrPfFiF4ERRth3cPlSKTOx3h
From: Max Reitz <mreitz@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-block@nongnu.org,
 eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, rjones@redhat.com
Message-ID: <dba94e70-c4fd-4871-cdc1-0e0fc2d9522f@redhat.com>
Subject: Re: [PATCH v12 03/16] qemu-io: Set "share-rw" flag together with
 read-only
References: <20170123123056.30383-1-famz@redhat.com>
 <20170123123056.30383-4-famz@redhat.com>
In-Reply-To: <20170123123056.30383-4-famz@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 23.01.2017 13:30, Fam Zheng wrote:
> qemu-io is a low level tool to read or modify guest visible data, which=

> implies the user knows very well what is being done. Allowing reading
> from a locked image is harmless in most cases, so do it.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  qemu-io.c | 2 ++
>  1 file changed, 2 insertions(+)

What about open_f()?

Max


--RQnGUj9KsvrPfFiF4ERRth3cPlSKTOx3h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliXnqUSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AlX0H/i4s4MiVmiYyo3yQJCScUCMSQzudG110
MrNzBMxteMFqPko2O0QT+GiCMWPxBsYxDj04vt6ZCF5MoLPKhqt1NjgIyvOcTYjw
9PDhVUt93HVDzwtO6Gc6H099AIt7uLFRcg2dS21NTNQnDu1+kNIIAmh1YEQ9xB2N
IOOTxW2tnKqKUBpbE1kdRysZ2d5REg5TFEaajhRkd9/AAY8W5hZ3fs0qFN/hL9sR
wH3GwTUdJrxaayxPpwBpC0yAeC+LNA2Fzfa1Hdu/vG/4J+nUwMsKg2BTEsZ2kmga
svsCMw3Xv45qmfz0bUoLCNsesvsi/7L/XRtROr9TtSo9bE0PjTWH7kQ=
=yC5l
-----END PGP SIGNATURE-----

--RQnGUj9KsvrPfFiF4ERRth3cPlSKTOx3h--
