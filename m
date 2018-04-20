Received: from eggs.gnu.org ([2001:4830:134:3::10]:50544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f9Reh-0004Yz-Ok
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 04:44:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f9Reg-0005Gh-WA
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 04:44:31 -0400
Date: Fri, 20 Apr 2018 16:44:20 +0800
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180420084420.GS15181@stefanha-x1.localdomain>
References: <20180416165849.28864-1-mreitz@redhat.com>
	<20180416165849.28864-6-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s9pXJW6w71JX4l3T"
Content-Disposition: inline
In-Reply-To: <20180416165849.28864-6-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 5/9] block/quorum: Support
 BDRV_REQ_WRITE_UNCHANGED
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>


--s9pXJW6w71JX4l3T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 16, 2018 at 06:58:45PM +0200, Max Reitz wrote:
> We just need to forward it to quorum's children (except in case of a
> rewrite because of corruption), but for that we first have to support
> flags in child requests at all.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/quorum.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--s9pXJW6w71JX4l3T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa2ahkAAoJEJykq7OBq3PI5dgH/RLLs2HgMrp5wWbcQ1V6FHxD
LQfHOzubHtPCsztuIUrhY2Df8T7d+0/2KSinv4RdMOCgxcWUlaAA2TR34A4tax4K
hXnWJnp1c5+asLyshcLirMVi9HYtuoXEg0GrQZ/Z+SQoMQDXu2Cw5gFoUbHOazEx
he979DkwEMMgZg4QWXNBt4P2jLdT1NC4AQpcJ16/2f05PcUuaX1xERh53UezbWeu
CXmY4b4aJXrY5XfiWgIRL2Kt7c1ruFsCsCVITCnZfB3OhIvCkjKLuoO+EfXG+AX1
mGWPPYNtCeOzlgtmcaUHs4enHrqgmuB3VrF2D5553UeIHidasOgLfHQXacsAvyk=
=/bnR
-----END PGP SIGNATURE-----

--s9pXJW6w71JX4l3T--
