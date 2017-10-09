Received: from eggs.gnu.org ([2001:4830:134:3::10]:48501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e1gUk-0000BR-9n
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:25:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e1gUj-0005Cx-7o
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:25:54 -0400
References: <20171009215533.12530-1-mreitz@redhat.com>
	<20171009215533.12530-2-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7e2e97b0-bca9-bd38-7641-c38f1e38c586@redhat.com>
Date: Mon, 9 Oct 2017 17:25:39 -0500
MIME-Version: 1.0
In-Reply-To: <20171009215533.12530-2-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="aF8JPXUJqwKSm8qMHQUg38DR4OH8qlqec"
Subject: Re: [Qemu-devel] [PATCH 1/3] qcow2: Fix unaligned preallocated
 truncation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Ping Li <pingl@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aF8JPXUJqwKSm8qMHQUg38DR4OH8qlqec
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Ping Li <pingl@redhat.com>
Message-ID: <7e2e97b0-bca9-bd38-7641-c38f1e38c586@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] qcow2: Fix unaligned preallocated
 truncation
References: <20171009215533.12530-1-mreitz@redhat.com>
 <20171009215533.12530-2-mreitz@redhat.com>
In-Reply-To: <20171009215533.12530-2-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/09/2017 04:55 PM, Max Reitz wrote:
> A qcow2 image file's length is not required to have a length that is a
> multiple of the cluster size.  However, qcow2_refcount_area() expects a=
n
> aligned value for its @start_offset parameter, so we need to round
> @old_file_size up to the next cluster boundary.
>=20
> Reported-by: pingl <pingl@redhat.com>

Should we use a real name? My autocomplete when adding cc suggests Ping L=
i.

(The upcoming git 2.15.0 adds my patch that auto-cc's anyone listed in
Reported-by, so we don't have to keep doing it manually:
https://github.com/git/git/commit/09ac6737 - but that doesn't help you
while you are still on 2.13.6)

> Bug: https://bugzilla.redhat.com/show_bug.cgi?id=3D1414049
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/qcow2.c | 1 +
>  1 file changed, 1 insertion(+)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--aF8JPXUJqwKSm8qMHQUg38DR4OH8qlqec
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnb92MACgkQp6FrSiUn
Q2o+iAgAo8LiQLRhY/grbkDD8c3rP+AFNYlN/N7dew9N9V3PzefVvtvig5Vw91fX
Fndu88p6UK6qbjN1W4HawG/MvgPgvX6f2uNwvG5vepZHb5KPtULuMR5unahS0Hlg
6vV3BYRXnBnyDawJugVKCaUpj3FZSFz2XkXoPCnAA2PQz3M0D20OwKz95IWOgv4D
MUlKpq+fEOAcS1F9lpwdrDPRaST3iAkGjClXwpxLDWkptTB0O9+cJ2opAIzJOyk5
3Q53wQ3OFwu7NcmlfJvL6mWQEytra6itFffQBpAhp+dqTTJbOlb85kPgRkLaSevI
Nrl2wqcESrnKEEfwp2HlqZ4Pxs7dMw==
=BKI3
-----END PGP SIGNATURE-----

--aF8JPXUJqwKSm8qMHQUg38DR4OH8qlqec--
