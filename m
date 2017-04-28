Received: from eggs.gnu.org ([2001:4830:134:3::10]:60784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d4AvJ-0000vF-Lc
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 14:47:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d4AvI-0001tY-UB
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 14:47:21 -0400
References: <20170428165517.30341-1-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <08e1ab58-90a0-e470-4038-30939c767e29@redhat.com>
Date: Fri, 28 Apr 2017 13:47:12 -0500
MIME-Version: 1.0
In-Reply-To: <20170428165517.30341-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2ooI0dakxujvhnb7DjqCtqQIDbqeu4Wkn"
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Add qemu-progress to the
 block layer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2ooI0dakxujvhnb7DjqCtqQIDbqeu4Wkn
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <08e1ab58-90a0-e470-4038-30939c767e29@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Add qemu-progress to the block
 layer
References: <20170428165517.30341-1-mreitz@redhat.com>
In-Reply-To: <20170428165517.30341-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/28/2017 11:55 AM, Max Reitz wrote:
> util/qemu-progress.c is currently unmaintained. The only user of its
> functionality is qemu-img, so it effectively is part of the block layer=
=2E
>=20
> Suggested-by: Fam Zheng <famz@redhat.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a1d2b3a4d3..768b4d94ec 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1168,6 +1168,7 @@ F: include/block/
>  F: qemu-img*
>  F: qemu-io*
>  F: tests/qemu-iotests/
> +F: util/qemu-progress.c
>  T: git git://repo.or.cz/qemu/kevin.git block
> =20
>  Block I/O path
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--2ooI0dakxujvhnb7DjqCtqQIDbqeu4Wkn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZA44wAAoJEKeha0olJ0NqjZQH/jhAwyx+9wXo0qiKL61OCY22
XPIIbJHj/nSJQ8jIzU5U1FwR8K7E173e3kJhaI144PTaN/Twjjc7HDIXKdTxJKXA
5Z31gXCa0E1XaLPEMeYWYqQnbVjcDGuPTWNPSb/5zMz69FNQeivbvObRIhzeTdhC
1WOp8W+CyM7KhWLBeR/Rxu1dRH74wwoa1t3BZhZl+nLyDB20IoOqPcxgvNfUxkca
8Gga6OcupnCaQtnm1lDNzfer/LltAiuQl859T6/0GoD4iziNPEmL8ZAJZ73Qtcfq
cf8KDiZGylG/ILXS9g8potQejJLNo8QGlmR9QPnBkoM4x2U5U19uknTq1YW3rp8=
=EiVN
-----END PGP SIGNATURE-----

--2ooI0dakxujvhnb7DjqCtqQIDbqeu4Wkn--
