Received: from eggs.gnu.org ([2001:4830:134:3::10]:45751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fG1zp-0004va-C9
	for qemu-devel@nongnu.org; Tue, 08 May 2018 08:45:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fG1zj-0003aB-HJ
	for qemu-devel@nongnu.org; Tue, 08 May 2018 08:45:33 -0400
Date: Tue, 8 May 2018 13:45:24 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180508124524.GN19710@stefanha-x1.localdomain>
References: <20180426134305.642080-1-eblake@redhat.com>
	<20180426134305.642080-4-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8MZM6zh5Bb05FW+3"
Content-Disposition: inline
In-Reply-To: <20180426134305.642080-4-eblake@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 3/3] block: Removed unused
 sector-based blocking I/O
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>


--8MZM6zh5Bb05FW+3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 26, 2018 at 08:43:05AM -0500, Eric Blake wrote:
> We are gradually moving away from sector-based interfaces, towards
> byte-based.  Now that all callers of blocking I/O have been converted
> to use our preferred byte-based bdrv_p{read,write}(), we can
> delete the unused bdrv_{read,write}().
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  include/block/block.h |  4 ----
>  block/io.c            | 48 ++++++++-------------------------------------=
---
>  2 files changed, 8 insertions(+), 44 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--8MZM6zh5Bb05FW+3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa8ZvkAAoJEJykq7OBq3PI9VgIALiQtPQN09/prmByLwrH/EiJ
AqMJnNfX0NAJfr0u7dufxpWQeKxpNhyy6y0171DXRMbnO1yJeik28mAB+dcHiCD8
LbL/bWdQ8kJU3+HO3wLN8qYV8hSaJR0rvN99kh/BfUL+TeysvYf4SmFbQYuWGXlV
2IFeURu8G23D9xYsz8AnLcLLtDDiSGk6T0vNoJKlhrRtlM33jCgyujE7pVD/QjVq
EJ8DN21U7+t4ySHeq+UqelbTG9LVAQhNHeaBlTk7wc3wfD9l1YmuUxcjCsnFCdBh
vlSZlSynoCvAKIx/3GU6i01BF0PQBRYXTrUeSGy3f77/KDdyij94J0MnwtX7n1k=
=OFhE
-----END PGP SIGNATURE-----

--8MZM6zh5Bb05FW+3--
