Received: from eggs.gnu.org ([2001:4830:134:3::10]:60482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e5YvN-00029r-Cx
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 11:09:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e5YvH-0002lt-O2
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 11:09:25 -0400
References: <150845442031.425.10507461040547008222@b58463cdfd5f>
From: Eric Blake <eblake@redhat.com>
Message-ID: <97fab1e7-90b0-d322-cd35-481941412930@redhat.com>
Date: Fri, 20 Oct 2017 10:09:06 -0500
MIME-Version: 1.0
In-Reply-To: <150845442031.425.10507461040547008222@b58463cdfd5f>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LPiQjnAAwGfSl9kfmvWLNr2exqBRnRAtH"
Subject: Re: [Qemu-devel] [PATCH v5 00/11] nbd minimal structured read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, pbonzini@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LPiQjnAAwGfSl9kfmvWLNr2exqBRnRAtH
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, pbonzini@redhat.com, vsementsov@virtuozzo.com,
 qemu-block@nongnu.org
Message-ID: <97fab1e7-90b0-d322-cd35-481941412930@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 00/11] nbd minimal structured read
References: <150845442031.425.10507461040547008222@b58463cdfd5f>
In-Reply-To: <150845442031.425.10507461040547008222@b58463cdfd5f>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/19/2017 06:07 PM, no-reply@patchew.org wrote:
> Hi,
>=20
> This series failed automatic build test. Please find the testing comman=
ds and
> their output below. If you have docker installed, you can probably repr=
oduce it
> locally.
>=20

> 058         - output mismatch (see 058.out.bad)
> --- /tmp/qemu-test/src/tests/qemu-iotests/058.out	2017-10-19 22:57:03.0=
00000000 +0000
> +++ /tmp/qemu-test/build/tests/qemu-iotests/058.out.bad	2017-10-19 23:0=
3:05.321471050 +0000
> @@ -19,16 +19,16 @@
>  4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
>  =3D=3D verifying the exported snapshot with patterns, method 1 =3D=3D
> -read 4096/4096 bytes at offset 4096
> -4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -read 4096/4096 bytes at offset 8192
> -4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +Protocol error: simple reply when structuredreply chunk was expected
> +read failed: Invalid argument
> +Protocol error: simple reply when structuredreply chunk was expected
> +read failed: Invalid argument

Oops - I obviously didn't run iotests, or I would have caught this.  It
also points out a bug in the error message missing a space.  Will fix
for v6.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--LPiQjnAAwGfSl9kfmvWLNr2exqBRnRAtH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnqEZIACgkQp6FrSiUn
Q2onQwf/QxKSOAszimZP6gQb1o+ty50UWWswddSIVqy1fOZKdFqgs3L5rGVwjVCd
QhjMferozqYTdJDlZsc0brMl18c6DhG+I8emDJJQJymzAGAGvGp28bpU1THHKbmJ
upLlrjHsXdHePRJVPgonz6blXblD13MW2+HBWbxFLaI0KZfyNXe5UXuFJXj4Z4NB
S2fUCcXOlTH0q+gpC91HDTMcZ/kWnSkTu/srmXIilg7szKTlzTrFdk/cnSF8zq8M
RcMQuB00frNEezvKo4yIPwrNgPIKtbZXQzju/oez3iYG+kXAHOTzMl3kbGLsdWxZ
cCD1F6ZQij8pO1lWmDpn+D6o8yiemw==
=sutx
-----END PGP SIGNATURE-----

--LPiQjnAAwGfSl9kfmvWLNr2exqBRnRAtH--
