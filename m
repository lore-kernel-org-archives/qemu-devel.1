Received: from eggs.gnu.org ([2001:4830:134:3::10]:53752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1essqI-00016y-LP
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 11:20:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1essqH-0002gE-Ko
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 11:20:02 -0500
References: <20180305161824.7188-1-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <e62b530b-e5cf-fe75-4b50-62933552b218@redhat.com>
Date: Mon, 5 Mar 2018 17:19:55 +0100
MIME-Version: 1.0
In-Reply-To: <20180305161824.7188-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kAw5cAwlPO90nWfiMr5e04ltdqkOLRMmr"
Subject: Re: [Qemu-devel] [PATCH v2] iotests: Mark all tests executable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kAw5cAwlPO90nWfiMr5e04ltdqkOLRMmr
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org
Message-ID: <e62b530b-e5cf-fe75-4b50-62933552b218@redhat.com>
Subject: Re: [PATCH v2] iotests: Mark all tests executable
References: <20180305161824.7188-1-eblake@redhat.com>
In-Reply-To: <20180305161824.7188-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-03-05 17:18, Eric Blake wrote:
> The majority of our iotests have the executable bit set; fix the
> few outliers for consistency.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> ---
> v2: fix missing test [Max]
>=20
> Note that checkpatch.pl complains that this doesn't look like a patch,
> because it is only changing mode bits.
> ---
>  tests/qemu-iotests/096 | 0
>  tests/qemu-iotests/124 | 0
>  tests/qemu-iotests/129 | 0
>  tests/qemu-iotests/132 | 0
>  tests/qemu-iotests/136 | 0
>  tests/qemu-iotests/139 | 0
>  tests/qemu-iotests/148 | 0
>  tests/qemu-iotests/152 | 0
>  tests/qemu-iotests/163 | 0
>  tests/qemu-iotests/205 | 0
>  10 files changed, 0 insertions(+), 0 deletions(-)
>  mode change 100644 =3D> 100755 tests/qemu-iotests/096
>  mode change 100644 =3D> 100755 tests/qemu-iotests/124
>  mode change 100644 =3D> 100755 tests/qemu-iotests/129
>  mode change 100644 =3D> 100755 tests/qemu-iotests/132
>  mode change 100644 =3D> 100755 tests/qemu-iotests/136
>  mode change 100644 =3D> 100755 tests/qemu-iotests/139
>  mode change 100644 =3D> 100755 tests/qemu-iotests/148
>  mode change 100644 =3D> 100755 tests/qemu-iotests/152
>  mode change 100644 =3D> 100755 tests/qemu-iotests/163
>  mode change 100644 =3D> 100755 tests/qemu-iotests/205

Thanks, applied to my block branch:

https://github.com/XanClic/qemu/commits/block

Max


--kAw5cAwlPO90nWfiMr5e04ltdqkOLRMmr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqdbisSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AZrsIAIUQArGhDDzc44CMWcOOkX087t+Jz3oD
eHhpNYMlUfK8+hTO0NRJG4ew/CLtVwyqr5MvAg8B1ZR4bSW74YDd5oEPudf0X4pZ
JlI6hYP+qdTYLRjck8PJSPTKXvPooDx8vgDeDLzcCuSSaqEsHcwy9JdvRy5Xdcj8
Y8E+YcxnbhSAbZ9ZfKVsEetNopWfBR2UIll64hhEfPBsgzmVpffCuKrYeJ8Zr8e3
gK3QEaSEb8KnSHvWYvISASz35HSmJaPXu74ywTXygOIL+K/HOy6B/OpkBPrdV5FE
biTfLAVudjtmNVMVqdyxVbj/QT1l+hkK9Ho1FT8qYA4ytG7rGoNtrHQ=
=DkcT
-----END PGP SIGNATURE-----

--kAw5cAwlPO90nWfiMr5e04ltdqkOLRMmr--
