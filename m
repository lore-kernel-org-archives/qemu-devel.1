Received: from eggs.gnu.org ([209.51.188.92]:48622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h1viQ-0004gM-DQ
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 11:17:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h1viP-0006cI-JU
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 11:17:50 -0500
References: <20190307151046.15086-1-philmd@redhat.com>
	<20190307151046.15086-3-philmd@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <208f5374-eef9-f467-9040-a576179e3ca4@redhat.com>
Date: Thu, 7 Mar 2019 10:17:39 -0600
MIME-Version: 1.0
In-Reply-To: <20190307151046.15086-3-philmd@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Zxw3KU7fqeudQvSqfCLo238oMLtqCCMhk"
Subject: Re: [Qemu-devel] [PATCH v4 2/2] qemu-iotests: Add dependency to
 qemu-nbd tool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Zxw3KU7fqeudQvSqfCLo238oMLtqCCMhk
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <208f5374-eef9-f467-9040-a576179e3ca4@redhat.com>
Subject: Re: [PATCH v4 2/2] qemu-iotests: Add dependency to qemu-nbd tool
References: <20190307151046.15086-1-philmd@redhat.com>
 <20190307151046.15086-3-philmd@redhat.com>
In-Reply-To: <20190307151046.15086-3-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 3/7/19 9:10 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Since a9660664fde, some iotests use qemu-nbd.
> Add a dependency to build it before using it.
> This fixes:
>=20
>   $ make check-block
>     GEN     qemu-img-cmds.h
>     CC      qemu-img.o
>     LINK    qemu-img
>     CC      qemu-io.o
>     LINK    qemu-io
>     CC      tests/qemu-iotests/socket_scm_helper.o
>     LINK    tests/qemu-iotests/socket_scm_helper
>   tests/qemu-iotests-quick.sh
>   check: qemu-nbd not found
>   make: *** [tests/Makefile.include:1059: check-tests/qemu-iotests-quic=
k.sh] Error 1
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  tests/Makefile.include | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I still have an NBD pull request coming up before soft freeze. Should I
be planning to take this patch (as it is NBD-related) or the whole
series (even though the first is more of a stretch), or is there a
better tree for this to be staged through?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--Zxw3KU7fqeudQvSqfCLo238oMLtqCCMhk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlyBRCMACgkQp6FrSiUn
Q2pnsAf9HjLJLuP7PEvD8rpYmPiSAX0d5jsGrts/PXdQQNsVdy9Qyi1eyk11rWAg
zLa53jFBeeU4l5JOLvti7SDvbNSoLtK5lbmN++Iv3YfWShiwZTbh8N39h9r2FeWU
vKWUKDDRJDvN93yZm888qGU0FbvUTmDC/ZyDa8qX1M/JuCXHX8HMqQV1KqE1QGLA
MeI2hxnBOFLbLfcyY7cGvvndEZN/FDmb153g95IcOs5wAm5ljBH91oKQ650V8idP
LbzFEKDyarPXZoNRRUks/pU0nBTuspc9NcssfLGXSvELrDPmuyYN/eQRVkEMp/Nx
DfAl0zBQ8EiAMZnSN36MehULLt8YUw==
=sFul
-----END PGP SIGNATURE-----

--Zxw3KU7fqeudQvSqfCLo238oMLtqCCMhk--
