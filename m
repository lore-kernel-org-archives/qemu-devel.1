Received: from eggs.gnu.org ([2001:4830:134:3::10]:44156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eoY7p-00009B-Bj
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 12:24:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eoY7l-0005Y0-DA
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 12:24:13 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35808 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eoY7l-0005Xg-4b
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 12:24:09 -0500
Date: Wed, 21 Feb 2018 17:23:46 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180221172346.GI21436@stefanha-x1.localdomain>
References: <20180124053957.29145-1-peterx@redhat.com>
	<20180124053957.29145-17-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="16qp2B0xu0fRvRD7"
Content-Disposition: inline
In-Reply-To: <20180124053957.29145-17-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 16/23] monitor: send event when command
 queue full
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


--16qp2B0xu0fRvRD7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2018 at 01:39:50PM +0800, Peter Xu wrote:
> Set maximum QMP command queue length to 8.  If queue full, instead of
> queue the command, we directly return a "command-dropped" event, telling
> client that specific command is dropped.
>=20
> Note that this flow control mechanism is only valid if OOB is enabled.
> If it's not, the effective queue length will always be 1, which strictly
> follows original behavior of QMP command handling (which never drop
> messages).
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  monitor.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--16qp2B0xu0fRvRD7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJajasiAAoJEJykq7OBq3PIoh4IAIXiS/7HAcBHwfj9NRX4fxXN
f9/T7wPHvelEmVMaOpqtOqz7LG8AxL51qo6HrkMX9Zn0xrl9Icsb+4ovIiqg5a21
wRS50SVB8SE5CnJAgle60vbv+yVjAnR8Cr/gGKEoDL5gDRyEyOHxgEYvGh1Z5q6N
VklrfGqnfuseFkpQ5LxD74xEu68E8LViloTZfQck096Wj6qmvcO5n2ymDcom9Iwl
S9yNtA0hlfMPTtgC1sGNj0rtSZiGQZkfcQU+xCVKNk+an0IbcMPZZbwfYhiPAnoZ
VvjvDfig+TcNbDsYuCBj7OGpCz3kBRVoA/fBUCPJO3LRYxS4aJEr8hNqMN91ukM=
=sgp3
-----END PGP SIGNATURE-----

--16qp2B0xu0fRvRD7--
