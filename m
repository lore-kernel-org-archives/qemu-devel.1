Received: from eggs.gnu.org ([2001:4830:134:3::10]:54701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1da3yJ-0006eM-Fb
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 13:50:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1da3yI-0005wQ-IV
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 13:50:15 -0400
References: <20170725155644.20214-1-mreitz@redhat.com>
	<20170725155644.20214-3-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d6d4c3b9-7e9c-8ad6-9c6d-3a529c07d21a@redhat.com>
Date: Tue, 25 Jul 2017 12:50:03 -0500
MIME-Version: 1.0
In-Reply-To: <20170725155644.20214-3-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qVmDujCAL1ixCROADvudvNGfwalXSVeK8"
Subject: Re: [Qemu-devel] [PATCH 2/2] iotests: Redirect stderr to stdout in
 186
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qVmDujCAL1ixCROADvudvNGfwalXSVeK8
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <d6d4c3b9-7e9c-8ad6-9c6d-3a529c07d21a@redhat.com>
Subject: Re: [PATCH 2/2] iotests: Redirect stderr to stdout in 186
References: <20170725155644.20214-1-mreitz@redhat.com>
 <20170725155644.20214-3-mreitz@redhat.com>
In-Reply-To: <20170725155644.20214-3-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/25/2017 10:56 AM, Max Reitz wrote:
> Without redirecting qemu's stderr to stdout, _filter_qemu will not appl=
y
> to warnings.  This results in $QEMU_PROG not being replaced by QEMU_PRO=
G
> which is not great if your qemu executable is not called
> qemu-system-x86_64 (e.g. qemu-system-i386).
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/186     |  2 +-
>  tests/qemu-iotests/186.out | 12 ++++++------
>  2 files changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--qVmDujCAL1ixCROADvudvNGfwalXSVeK8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll3hMsACgkQp6FrSiUn
Q2rZ8Qf7B5gHe6DIG2vKQkYYABnxTCd6gj1CbKGeN1Pn0sumxL/G3Go+jBk4dUld
Hd7gRkWb735u+yx/cjqbgO52sJknoYSWc4O5d1LL6+jLKwJ9TpOBIO1Frdm0tKVY
1U0oaNcss1W7/Jt+ymCH080TcsDr+NgojaG0Xp+rvYJIFrUi2tk3mo33jkArSf2V
ehWC44dxNW2uwL0AkxZiw4GizYJ576JCwZmhPaTSCzDptu6J/AQvv4hZY6dXuwFD
Ift8e+exrKoovDdq8kw1p6/SpakUuLg2MGpDRskWUF9wQjl8D+tTCw1akBpmhoZs
x9hyCmp2aq1CoU+OcCoGH4ZZQAxCgg==
=QEdd
-----END PGP SIGNATURE-----

--qVmDujCAL1ixCROADvudvNGfwalXSVeK8--
