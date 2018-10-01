Received: from eggs.gnu.org ([2001:4830:134:3::10]:58736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g746I-0004aw-Lm
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 15:43:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g746H-0004T0-Bv
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 15:43:26 -0400
References: <20180821005843.5146-1-famz@redhat.com>
	<20180821005843.5146-3-famz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <2bacb426-daa4-8225-77a0-d30f44debe17@redhat.com>
Date: Mon, 1 Oct 2018 21:43:13 +0200
MIME-Version: 1.0
In-Reply-To: <20180821005843.5146-3-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="P3xHAmhcF1L0oaWLJ9QhUXZ9PPOx5w9V4"
Subject: Re: [Qemu-devel] [PATCH v4 2/3] file-posix: Drop s->lock_fd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--P3xHAmhcF1L0oaWLJ9QhUXZ9PPOx5w9V4
From: Max Reitz <mreitz@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Message-ID: <2bacb426-daa4-8225-77a0-d30f44debe17@redhat.com>
Subject: Re: [PATCH v4 2/3] file-posix: Drop s->lock_fd
References: <20180821005843.5146-1-famz@redhat.com>
 <20180821005843.5146-3-famz@redhat.com>
In-Reply-To: <20180821005843.5146-3-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 21.08.18 02:58, Fam Zheng wrote:
> The lock_fd field is not strictly necessary because transferring locked=

> bytes from old fd to the new one shouldn't fail anyway. This spares the=

> user one fd per image.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block/file-posix.c | 37 +++++++++++++------------------------
>  1 file changed, 13 insertions(+), 24 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--P3xHAmhcF1L0oaWLJ9QhUXZ9PPOx5w9V4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluyeNEACgkQ9AfbAGHV
z0AlLAgApsJA33uGcQkf2bIjcfbwEATpRM0ZIowT5Z0Zrfv8CgkDAmPeou9yhKNs
3jO4pJOllQlQdpQmHIHLSoO00IkphvAiIt+Qn3xiVtGJ3zZfHo7qE1E3OniKZe30
fHp82WwNC38N7+qlAAF+Q9emY0M4UkBN6OUn1yHrggeyeebgo8vzULq8PeUPXCdO
+S9n60DfwjUOhU/7QavAiLgmuKR6JRdrRhcSR04d2w22I/p26k5BvdfgWmoyMCkU
W7upCK2Y3irz4PCsZZTvkhr+S1HqWjXnU53n0bYMPGrKyZvwBNAVg2avYCakSex+
J0n+tGKGrz8kNHvz8No346Ur92Sulg==
=DMCi
-----END PGP SIGNATURE-----

--P3xHAmhcF1L0oaWLJ9QhUXZ9PPOx5w9V4--
