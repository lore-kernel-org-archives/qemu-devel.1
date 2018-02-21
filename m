Received: from eggs.gnu.org ([2001:4830:134:3::10]:59840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eoXWE-00043U-C3
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 11:45:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eoXWD-0001UZ-Hu
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 11:45:22 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34584 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eoXWD-0001UD-D4
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 11:45:21 -0500
Date: Wed, 21 Feb 2018 16:45:19 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180221164519.GE21436@stefanha-x1.localdomain>
References: <20180124053957.29145-1-peterx@redhat.com>
	<20180124053957.29145-13-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FEz7ebHBGB6b2e8X"
Content-Disposition: inline
In-Reply-To: <20180124053957.29145-13-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 12/23] monitor: let suspend_cnt be
 thread safe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>


--FEz7ebHBGB6b2e8X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2018 at 01:39:46PM +0800, Peter Xu wrote:
> Monitor code now can be run in more than one thread.  Let it be thread
> safe when accessing suspend_cnt counter.
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  monitor.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--FEz7ebHBGB6b2e8X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJajaIfAAoJEJykq7OBq3PIzbsH/0ZRkSBsS565vDxrSRkZ7yTr
2l6WmZLp5f3EcCDg+5qPVNCSfaCZ+jVvQpWu0H6045MWVYt2obtvZ+Y5l5ty9wgO
F+ScGf5DCEK6XDK6PRPZYGLap26IRKYaVfrPQ52TF5uM+kMVlUfS0IDkvtKbSXyQ
v19495bFaDxKGWxHwd+jop/Y+CejRWMEO/XAH9kWvy4R8CVTj4CyCsaDHG/bDgwY
e+Ao0f67pX7AFT389XZNhSUsRlFzep25gz2lawPE3nsBTZZUfGLCwDM6nI+iQ7ik
HVPqqxFisOhCK18cPW7P3FA+y82uDsLGS2cvZrx+nfR7PHUridHAIdy/EfCLKNM=
=sonx
-----END PGP SIGNATURE-----

--FEz7ebHBGB6b2e8X--
