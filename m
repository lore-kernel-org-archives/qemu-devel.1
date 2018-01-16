Received: from eggs.gnu.org ([2001:4830:134:3::10]:39478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebZRP-00081L-H0
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 17:10:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebZRO-0001x3-EO
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 17:10:47 -0500
References: <cover.1513342045.git.berto@igalia.com>
	<91f760c0f3fd28e4baddf20c9bc7a9b9775eb593.1513342045.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <db1e9638-ce19-8b8e-b300-6104f8abe658@redhat.com>
Date: Tue, 16 Jan 2018 16:10:37 -0600
MIME-Version: 1.0
In-Reply-To: <91f760c0f3fd28e4baddf20c9bc7a9b9775eb593.1513342045.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="s5Mj2xYeAI1CG0HU8j0O8QUqtYhT36ZZk"
Subject: Re: [Qemu-devel] [PATCH v2 14/32] qcow2: Add
 offset_to_l2_slice_index()
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
--s5Mj2xYeAI1CG0HU8j0O8QUqtYhT36ZZk
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <db1e9638-ce19-8b8e-b300-6104f8abe658@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 14/32] qcow2: Add
 offset_to_l2_slice_index()
References: <cover.1513342045.git.berto@igalia.com>
 <91f760c0f3fd28e4baddf20c9bc7a9b9775eb593.1513342045.git.berto@igalia.com>
In-Reply-To: <91f760c0f3fd28e4baddf20c9bc7a9b9775eb593.1513342045.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/15/2017 06:53 AM, Alberto Garcia wrote:
> Similar to offset_to_l2_index(), this function takes a guest offset
> and returns the index in the L2 slice that contains its L2 entry.
>=20
> An L2 slice has currently the same size as an L2 table (one cluster),
> so both functions return the same value for now.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2.h | 5 +++++
>  1 file changed, 5 insertions(+)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

> +
>  static inline int64_t align_offset(int64_t offset, int n)
>  {
>      offset =3D (offset + n - 1) & ~(n - 1);
>=20

Unrelated to this commit, but should we switch this to use
QEMU_ALIGN_UP() instead of open-coding it?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--s5Mj2xYeAI1CG0HU8j0O8QUqtYhT36ZZk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpeeF0ACgkQp6FrSiUn
Q2qXeAf+NIPGcYF2p+QnUPX8JMlZBZLjqXNPS9CAHOgNGybMBLslm9bltzYPhwlE
VCGOpKm/RdzovUJv1LoJ6vwZr09qiBBsOMIhmFTmncYpLYKeLHBsPdd2irWNvv/P
inbh9nL60STtfEaflLAl7m19GwOxIEpk1nTcfa8ByGL7OG2T/APmoGRKw8pUFyfa
I/VWJkID8r/h3S+BwNtbAakWifID5jlVvZOoo/IKJ1r1/YVomEL52oINRyLG8TAh
3620eU0nrYW6cMydEJTO4aLMeK7gFZ+oge00i0PaVUzQVNe2bzsNZGShWYiN6143
xYhvia6LRcfizgdtaNvoZAkK3NF6Pg==
=QLJD
-----END PGP SIGNATURE-----

--s5Mj2xYeAI1CG0HU8j0O8QUqtYhT36ZZk--
