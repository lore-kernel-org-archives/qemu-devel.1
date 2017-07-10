Received: from eggs.gnu.org ([2001:4830:134:3::10]:36350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dUb4i-0006VI-F7
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:58:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dUb4h-0001nv-MJ
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:58:16 -0400
Date: Mon, 10 Jul 2017 16:58:08 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170710155808.GQ14195@stefanha-x1.localdomain>
References: <20170706163828.24082-1-pbonzini@redhat.com>
	<20170706163828.24082-8-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UJEqbsikIZBgizPR"
Content-Disposition: inline
In-Reply-To: <20170706163828.24082-8-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 07/11] block: do not acquire AioContext in
 check_to_replace_node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, qemu-block@nongnu.org


--UJEqbsikIZBgizPR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 06, 2017 at 06:38:24PM +0200, Paolo Bonzini wrote:
> The only caller does it already.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--UJEqbsikIZBgizPR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZY6QQAAoJEJykq7OBq3PIU9MH/2Q+AlWhs1tXkWIdcF6QYsRF
LQZKusCDFDJX5mtH738JQ/r5F/95J/99lnCLvUrRjGG3ruGELPZLEJzilvybeizQ
KY+FBib9eeMOUE90rg1q4dfQP8LIdQIDfQAQN6T9rPqTqF9nPFWGMLUh0LQTYqb/
OheNwY/49Hmqu4DO18QH3e8WgOk5yWoHAhAcXpL+quBeE6K6bHWdPmKJy87wyTjG
/ckbfTG25SVhwMxw+KrZNwhEdpYe7JGN8t+TxNun/wLqR3ihzI3aCNNHjTUTZQiN
f+blLvRChw2/0vU4aqIFqdLb4Dwd9EcEZC7jDILLQmdvY8YOG/HqJOvTuHIRZ/c=
=dD/X
-----END PGP SIGNATURE-----

--UJEqbsikIZBgizPR--
