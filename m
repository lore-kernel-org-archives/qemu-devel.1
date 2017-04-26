Received: from eggs.gnu.org ([2001:4830:134:3::10]:42320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3Msu-0003Ut-8Z
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:21:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3Mss-0008Ib-Uz
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:21:32 -0400
References: <1493196046-5607-1-git-send-email-den@openvz.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <322af251-e486-4b32-a234-357f0d5e1e4a@redhat.com>
Date: Wed, 26 Apr 2017 08:21:18 -0500
MIME-Version: 1.0
In-Reply-To: <1493196046-5607-1-git-send-email-den@openvz.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="t46u4GUbOdiqCF8X5nNEWC7vFoENLa7uv"
Subject: Re: [Qemu-devel] [PATCH 1/1] block: fix alignment calculations in
 bdrv_co_do_zero_pwritev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--t46u4GUbOdiqCF8X5nNEWC7vFoENLa7uv
From: Eric Blake <eblake@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org
Message-ID: <322af251-e486-4b32-a234-357f0d5e1e4a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] block: fix alignment calculations in
 bdrv_co_do_zero_pwritev
References: <1493196046-5607-1-git-send-email-den@openvz.org>
In-Reply-To: <1493196046-5607-1-git-send-email-den@openvz.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/26/2017 03:40 AM, Denis V. Lunev wrote:
> tail_padding_bytes is calculated wrong. F.e. for
>     offset =3D 0
>     bytes =3D 2048
>     align =3D 512
> we will have tail_padding_bytes =3D 512 which is definitely wrong. The =
patch
> fixes that arithmetics.
>=20
> Fortunately this problem is harmless, we will have 1 extra allocation a=
nd
> free thus there is no need to put this into stable. The problem is here=

> from the very beginning.
>=20
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Stefan Hajnoczi <stefanha@redhat.com>
> CC: Fam Zheng <famz@redhat.com>
> ---
>  block/io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--t46u4GUbOdiqCF8X5nNEWC7vFoENLa7uv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZAJ7OAAoJEKeha0olJ0Nq/SQH/iLMGYDL6/Z6HKZBnI1sceSE
25D+3GB4L8rYna1HPO5tiuMCHNhqQvpNGjNFmZUTRDe5Gon0yDVyHqKlRbnJzvCC
JbUIVBGNeu72rtuLWkmJWJM8g8QCA80IWIcorfjJNGgGTuqEofaXIDPS6h9O7ktU
76hvouj4aL+zXCHQYBeinDyUX0XSvmRkxG0NFYxvTXLpk0eaV7OVRHqe2Wc2kpCr
A453Y2SusA20y04eyh+quAy5SyckQ3bhPmWF1Xyx57csA9pO4nYlWMe1GaJJqnqL
oNCdTXXbXZAFmERjAiI0HSssV2qPar7Xc9LD1r/1vFwF3eT5LXw8SNxrPknzI5Q=
=Bi0/
-----END PGP SIGNATURE-----

--t46u4GUbOdiqCF8X5nNEWC7vFoENLa7uv--
