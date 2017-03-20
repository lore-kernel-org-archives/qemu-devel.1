Received: from eggs.gnu.org ([2001:4830:134:3::10]:46238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cpvPF-0006cK-2U
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 07:23:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cpvPE-0001pH-9u
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 07:23:21 -0400
Date: Mon, 20 Mar 2017 11:23:11 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170320112311.GL17887@stefanha-x1.localdomain>
References: <20170313214001.26339-1-mreitz@redhat.com>
	<20170313214117.27350-2-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Mit9XoPEfICDqq/V"
Content-Disposition: inline
In-Reply-To: <20170313214117.27350-2-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.10 11/16] block/qcow2:
 Metadata preallocation for truncate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org


--Mit9XoPEfICDqq/V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 13, 2017 at 10:41:12PM +0100, Max Reitz wrote:
> We can support PREALLOC_MODE_METADATA by invoking preallocate() in
> qcow2_truncate().
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/qcow2.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Mit9XoPEfICDqq/V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYz7ufAAoJEJykq7OBq3PI9+YH/1vxBHEsje8NF25nnjqHtf2P
eNo6ksaE0Wg8Skv7N4IeqRKPGa2jb+kg3OtmUd+Q91XTpqdl6rhSIu+PlN60JMUb
WoX9GeXPJleOf18P+6L+/xYnBMpk21P+ZupfZ1z+pL7i81ZVolpNMbos82PZmnvO
VoWV/5H3DtiFAX3OblE7YgZ3veypsW2fjgCNq0SaQQmn2H8hx/CFTmRxjGm7qave
m8u9t2E2Z06IJIx0azsePKyIBdTQc0LL0UhRX1VB49IS1NqM0uzpJmf0VF62xDjC
Oef2eJ1VKqDUqy36JZO38KDy7yI0/F1sN4CGTtp69uFOObYudXPjv0aNIzqUU0g=
=psoh
-----END PGP SIGNATURE-----

--Mit9XoPEfICDqq/V--
