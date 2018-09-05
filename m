Received: from eggs.gnu.org ([2001:4830:134:3::10]:53530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fxX3j-0001fw-Cc
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 08:37:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fxX3i-00034A-Hr
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 08:37:23 -0400
References: <cover.1535983918.git.berto@igalia.com>
	<9d8847a58f91ffafb732e89f6196fe00b7d0ec3f.1535983918.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <60e01d50-bf3c-aafb-6341-ee8c955e7b9c@redhat.com>
Date: Wed, 5 Sep 2018 14:37:12 +0200
MIME-Version: 1.0
In-Reply-To: <9d8847a58f91ffafb732e89f6196fe00b7d0ec3f.1535983918.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="FRENEyGUE4NS26BD7pp8habfcU0iVnXqn"
Subject: Re: [Qemu-devel] [PATCH v2 03/10] block: Remove child references
 from bs->{options, explicit_options}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FRENEyGUE4NS26BD7pp8habfcU0iVnXqn
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <60e01d50-bf3c-aafb-6341-ee8c955e7b9c@redhat.com>
Subject: Re: [PATCH v2 03/10] block: Remove child references from
 bs->{options,explicit_options}
References: <cover.1535983918.git.berto@igalia.com>
 <9d8847a58f91ffafb732e89f6196fe00b7d0ec3f.1535983918.git.berto@igalia.com>
In-Reply-To: <9d8847a58f91ffafb732e89f6196fe00b7d0ec3f.1535983918.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-09-03 16:34, Alberto Garcia wrote:
> Block drivers allow opening their children using a reference to an
> existing BlockDriverState. These references remain stored in the
> 'options' and 'explicit_options' QDicts, but we don't need to keep
> them once everything is open.
>=20
> What is more important, these values can become wrong if the children
> change:
>=20
>     $ qemu-img create -f qcow2 hd0.qcow2 10M
>     $ qemu-img create -f qcow2 hd1.qcow2 10M
>     $ qemu-img create -f qcow2 hd2.qcow2 10M
>     $ $QEMU -drive if=3Dnone,file=3Dhd0.qcow2,node-name=3Dhd0 \
>             -drive if=3Dnone,file=3Dhd1.qcow2,node-name=3Dhd1,backing=3D=
hd0 \
>             -drive file=3Dhd2.qcow2,node-name=3Dhd2,backing=3Dhd1
>=20
> After this hd2 has hd1 as its backing file. Now let's remove it using
> block_stream:
>=20
>     (qemu) block_stream hd2 0 hd0.qcow2
>=20
> Now hd0 is the backing file of hd2, but hd2's options QDicts still
> contain backing=3Dhd1.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--FRENEyGUE4NS26BD7pp8habfcU0iVnXqn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluPzfgACgkQ9AfbAGHV
z0CWxQf+NLWYlkImYWNb4BhC70Wyxr8GEn7QYPVUECR8ud7JK9j0ws+xDJAn33rX
yHWNAjjW+lnVOpBpsWpys2kjhE6rdketrC1BAI46egdyND3i8hsqlQ5lt1FSVhOw
V09twgJyqYs9SY+grU2NRZ2TX6t/usVIeCROvqhWRL3VQEsZut5SI0JTRUAjPPam
w121T98J58NKm/Ow3V10JUcogtLDLEaZcbCrNfunvswpKDPSKsl/Lkf4agPNjtte
38d7bOSfk8EvWRwQwJz+ilEBs25j6pcwA5cnVf+U8u4vetot5dEMN5OEsHFBjsZq
QcutLwXcE9KUCqKTUr+XEg7YwpqE1A==
=9ao8
-----END PGP SIGNATURE-----

--FRENEyGUE4NS26BD7pp8habfcU0iVnXqn--
