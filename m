Received: from eggs.gnu.org ([2001:4830:134:3::10]:42733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eoY3P-0006ud-0A
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 12:19:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eoY3K-0003Zq-3u
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 12:19:38 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35596 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eoY3J-0003ZU-LC
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 12:19:33 -0500
Date: Wed, 21 Feb 2018 17:19:31 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180221171931.GH21436@stefanha-x1.localdomain>
References: <20180124053957.29145-1-peterx@redhat.com>
	<20180124053957.29145-16-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rCwQ2Y43eQY6RBgR"
Content-Disposition: inline
In-Reply-To: <20180124053957.29145-16-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 15/23] qmp: add new event
 "command-dropped"
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


--rCwQ2Y43eQY6RBgR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2018 at 01:39:49PM +0800, Peter Xu wrote:
> This event will be emitted if one QMP command is dropped.  Along,
> declare an enum for the reasons.
>=20
> Reviewed-by: Fam Zheng <famz@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  qapi-schema.json | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--rCwQ2Y43eQY6RBgR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJajaojAAoJEJykq7OBq3PIyHEH/R6AgNO+hNkDZPsJU35li3pA
kmr45SWKVjBAxHqfpGEtS0Q/DrkPOlak2Boh23LbNh1X2y5xPhGbDPCLFip8kVMe
PLuefiGPc18Dh1uI+ScNsU8WFMRXNQLG5JgsugcmBlAXSzh+Y0ywJlVXS14g71LD
BOJOdshJa0g0HE4u6gDimZCak0TTbF91NGVY3eiF7wKO3/c3Q9E/dBgGc1nFRM95
e/aWc2AhlCSSYXYo8+pbacVHzAFh4QIvtlIi5D4+1mQQZqEaW5dJQLkh8wYYM8Z9
os/YbA2EQPefEKmXyVh45LeGUlk8qmP0Ld+GRLqVhLOTQ4z/36nDt5zJW6COiLk=
=tFCK
-----END PGP SIGNATURE-----

--rCwQ2Y43eQY6RBgR--
