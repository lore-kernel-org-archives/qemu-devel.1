Received: from eggs.gnu.org ([2001:4830:134:3::10]:46834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eoYIC-0003q7-5v
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 12:34:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eoYI8-0002aG-7K
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 12:34:56 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54480 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eoYI8-0002a4-21
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 12:34:52 -0500
Date: Wed, 21 Feb 2018 17:34:30 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180221173430.GJ21436@stefanha-x1.localdomain>
References: <20180124053957.29145-1-peterx@redhat.com>
	<20180124053957.29145-19-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wRtZRu2mMGBZ6YQ7"
Content-Disposition: inline
In-Reply-To: <20180124053957.29145-19-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 18/23] qmp: support out-of-band (oob)
 execution
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


--wRtZRu2mMGBZ6YQ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2018 at 01:39:52PM +0800, Peter Xu wrote:
> Having "allow-oob" to true for a command does not mean that this command
> will always be run in out-of-band mode.  The out-of-band quick path will
> only be executed if we specify the extra "run-oob" flag when sending the
> QMP request:
>=20
>     { "execute":   "command-that-allows-oob",
>       "arguments": { ... },
>       "control":   { "run-oob": true } }
>=20
> The "control" key is introduced to store this extra flag.  "control"
> field is used to store arguments that are shared by all the commands,
> rather than command specific arguments.  Let "run-oob" be the first.
>=20
> Note that in the patch I exported qmp_dispatch_check_obj() to be used to
> check the request earlier, and at the same time allowed "id" field to be
> there since actually we always allow that.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/qapi/qmp/dispatch.h |  2 ++
>  monitor.c                   | 84 +++++++++++++++++++++++++++++++++++++++=
+-----
>  qapi/qmp-dispatch.c         | 32 ++++++++++++++++-
>  trace-events                |  2 ++
>  4 files changed, 110 insertions(+), 10 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--wRtZRu2mMGBZ6YQ7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaja2mAAoJEJykq7OBq3PIfwAH/j9DtJ1M5bHicIGUvFgYvAfY
oxIu8yBKtBMNB+MYdCX5T1OnHIJhQXq9G341Ccp9euGa7tFXAsuBGmOWAUm0DuOk
NeYFICmG9+/2Ci28eFVEGB0G35SOcmNSOexl3ojGAEh/aSs0pbiovV7nKDxf15p9
xVVXLD7BiztrwfduzeqZu+o+/s1bTQ+D52gomlDrrSJYmMEw7PNkqNvqJ16BZIKc
hy/FIqwvdlnhrPZH3hIfAxEu3ocJ4joN+IMmhxfgmmCzWm9FrRqBpaH7SF0qiena
hPAXtmxqEk4AlT7e4+F9+bfYUKwMneaGJ4CvGjS058id0eNMEdjx7ow2g47U5IE=
=sKVr
-----END PGP SIGNATURE-----

--wRtZRu2mMGBZ6YQ7--
