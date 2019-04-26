Received: from eggs.gnu.org ([209.51.188.92]:32783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hK8C6-0003Eh-OH
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 17:15:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hK8C5-0006Zz-Ps
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 17:15:42 -0400
References: <20190403143748.9790-1-berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <1663447c-f31a-fd34-b34d-1d665a46a9fd@redhat.com>
Date: Fri, 26 Apr 2019 23:15:32 +0200
MIME-Version: 1.0
In-Reply-To: <20190403143748.9790-1-berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="86IIHTZ61KVVGHI7yAR36na5kQzLH6J08"
Subject: Re: [Qemu-devel] [PATCH for-4.1] commit: Use bdrv_append() in
 commit_start()
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
--86IIHTZ61KVVGHI7yAR36na5kQzLH6J08
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <1663447c-f31a-fd34-b34d-1d665a46a9fd@redhat.com>
Subject: Re: [PATCH for-4.1] commit: Use bdrv_append() in commit_start()
References: <20190403143748.9790-1-berto@igalia.com>
In-Reply-To: <20190403143748.9790-1-berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03.04.19 16:37, Alberto Garcia wrote:
> This function combines bdrv_set_backing_hd() and bdrv_replace_node()
> so we can use it to simplify the code a bit in commit_start().
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/commit.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)

Thanks, applied to my block branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block

Max


--86IIHTZ61KVVGHI7yAR36na5kQzLH6J08
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzDdPQACgkQ9AfbAGHV
z0B/Wgf+J5nhip7QQHbwN+wF5N2Uexw3gNAmW1u8rb93ot+ikVPEuU6vClQf5pbM
wluNEkcHC/R1lrQuWa+SpsFQJ8baSI4P+suhY4TIKh2E9BfJYj4cz3v8k0ffGXVN
EW91VgdjJ3z40X2jrP3x4kZERc0LSob/CufQwLx+3lI37fE7d9RKpB4qdWwxWIqo
D8XartW4vszcMtzdYnu2SYpnW6TknQSfPxev7FaNkFAJHDP9zqudCzv0hxqX2tWm
YCVcE2jc3ynpMhYZXl/RiCTHPryj/osbT+p/UKqbAa4gt7KLf57QH/qu9U95FStH
CiOnymGAmaqOYpTSOfgSsAhuzdQRyQ==
=hRha
-----END PGP SIGNATURE-----

--86IIHTZ61KVVGHI7yAR36na5kQzLH6J08--
