Received: from eggs.gnu.org ([2001:4830:134:3::10]:33285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebZ7X-00079A-SF
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 16:50:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebZ7X-0002f8-2a
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 16:50:15 -0500
References: <cover.1513342045.git.berto@igalia.com>
	<8512f9f7a0afd366b2e951617cf553b1f16e8be6.1513342045.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ec3ae772-a108-3844-df7f-8e0dcb297f13@redhat.com>
Date: Tue, 16 Jan 2018 15:50:01 -0600
MIME-Version: 1.0
In-Reply-To: <8512f9f7a0afd366b2e951617cf553b1f16e8be6.1513342045.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="YkLPP1svD6G2XQ5nQAcioR4JLjuNQET4w"
Subject: Re: [Qemu-devel] [PATCH v2 10/32] qcow2: Remove BDS parameter from
 qcow2_cache_discard()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YkLPP1svD6G2XQ5nQAcioR4JLjuNQET4w
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <ec3ae772-a108-3844-df7f-8e0dcb297f13@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 10/32] qcow2: Remove BDS parameter from
 qcow2_cache_discard()
References: <cover.1513342045.git.berto@igalia.com>
 <8512f9f7a0afd366b2e951617cf553b1f16e8be6.1513342045.git.berto@igalia.com>
In-Reply-To: <8512f9f7a0afd366b2e951617cf553b1f16e8be6.1513342045.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/15/2017 06:53 AM, Alberto Garcia wrote:
> This function was only using the BlockDriverState parameter to pass it
> to qcow2_cache_get_table_idx() and qcow2_cache_table_release(). This
> is no longer necessary so this parameter can be removed.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-cache.c    | 2 +-
>  block/qcow2-refcount.c | 6 +++---
>  block/qcow2.h          | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--YkLPP1svD6G2XQ5nQAcioR4JLjuNQET4w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpec4kACgkQp6FrSiUn
Q2pSCAf+LR0WMouA9Sc0Wm5/40APMjSEum/CBsud9677Q6Ss4r3WORZ9smhOhqwb
nVt5vP04QyI5jD4NMAiNB7khczJbYEFrWCJ5uLBWew2tH99hVIbk4PkLrIa5kQ2L
TMR3VX5uQ+Mdr9AZEDHyOG3ydGXjejTyJokxJZlHWOCH22zj638FvsBD6mARHOVM
4Bh4oLahQtdfIWfiMIw25hCwU9z7zgukkjIRXGV08hHKaTvuDUc8K6X0q3i9GQPu
COes8DEEt2EUglYHbBQaAO7IQF9Fm7Mn72VivYEyb/eHpspZi2XLSUS0R62sGxIX
2E+qsc/8ou5GlM0AQdk9T230C73Z0w==
=4g/M
-----END PGP SIGNATURE-----

--YkLPP1svD6G2XQ5nQAcioR4JLjuNQET4w--
