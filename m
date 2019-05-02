Received: from eggs.gnu.org ([209.51.188.92]:40384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hMJgl-0003yM-UW
	for qemu-devel@nongnu.org; Thu, 02 May 2019 17:56:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hMJgk-0007As-24
	for qemu-devel@nongnu.org; Thu, 02 May 2019 17:56:23 -0400
References: <68cc5bbc-ed6f-e001-e376-ccd986683b88@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f1dfe2c3-2d61-e477-ac3d-37ad26d9236d@redhat.com>
Date: Thu, 2 May 2019 16:56:16 -0500
MIME-Version: 1.0
In-Reply-To: <68cc5bbc-ed6f-e001-e376-ccd986683b88@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="htJ3JxAhi77Np0kEDLvUKYg7sHdllJV5b"
Subject: Re: [Qemu-devel] Failing QEMU iotest 175
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Nir Soffer <nirsof@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--htJ3JxAhi77Np0kEDLvUKYg7sHdllJV5b
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Nir Soffer <nirsof@gmail.com>
Message-ID: <f1dfe2c3-2d61-e477-ac3d-37ad26d9236d@redhat.com>
Subject: Re: Failing QEMU iotest 175
References: <68cc5bbc-ed6f-e001-e376-ccd986683b88@redhat.com>
In-Reply-To: <68cc5bbc-ed6f-e001-e376-ccd986683b88@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/28/19 10:18 AM, Thomas Huth wrote:
> QEMU iotest 175 is failing for me when I run it with -raw:
>=20

>  =3D=3D creating image with default preallocation =3D=3D
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576
> -size=3D1048576, blocks=3D0
> +size=3D1048576, blocks=3D2

What filesystem? It should be fairly obvious that 'stat -c blocks=3D%b' i=
s
file-system dependent (some allocate slightly more or less space, based
on granularities and on predictions of future use), so we may need to
update the test to apply a filter or otherwise allow a bit of fuzz in
the answer. But 0/2 is definitely different than...
>=20
>  =3D=3D creating image with preallocation off =3D=3D
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576 preallocat=
ion=3Doff
> -size=3D1048576, blocks=3D0
> +size=3D1048576, blocks=3D2
>=20
>  =3D=3D creating image with preallocation full =3D=3D
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576 preallocat=
ion=3Dfull
> -size=3D1048576, blocks=3D2048
> +size=3D1048576, blocks=3D2050

2048/2050, so we DO have some indication of whether the file is sparse
or fully allocated.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--htJ3JxAhi77Np0kEDLvUKYg7sHdllJV5b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzLZ4AACgkQp6FrSiUn
Q2odjQf+JHrJqseIHIJZQQB9W1pnUI0Tw/5vM1hppVwUG9xi1bAd01BssvIAFSYe
kCaPGCqLxZoJHM2IOXoQKb9uRERUeDAwci8aWzS+slfjOfUpeNgF1XzUCyjWiHUB
S6vsMmBpHoucrbXhNdXoT3Z3+VizQKY7w9RLLpeOFqURlyG8FKKT1RJEoxYwgeeI
EqcYQbD4Ql6eygDXG7tGgv2kmB/8mqkW3LsGzV6rkwxwXbEvTDkLwgNUH6OZUFdN
TI2pEMVJjMsufJpTr81TGA3RXphxkzgTrvILZt2Orc1XG2IYSbqnvdJpePwctqHf
ctjK1lRtR9kA0tPyp4wPVDAGaRUTSw==
=+Des
-----END PGP SIGNATURE-----

--htJ3JxAhi77Np0kEDLvUKYg7sHdllJV5b--
