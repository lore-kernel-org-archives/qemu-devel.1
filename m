Received: from eggs.gnu.org ([2001:4830:134:3::10]:42610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePAwb-0003XY-SB
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 12:35:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePAwY-0003pK-P9
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 12:35:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59793)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ePAwY-0003oe-I7
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 12:35:42 -0500
Date: Wed, 13 Dec 2017 17:35:33 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171213173533.GE8317@stefanha-x1.localdomain>
References: <20171205055200.16305-1-peterx@redhat.com>
	<20171205055200.16305-15-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PGNNI9BzQDUtgA2J"
Content-Disposition: inline
In-Reply-To: <20171205055200.16305-15-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v5 14/26] monitor: introduce
 monitor_qmp_respond()
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


--PGNNI9BzQDUtgA2J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2017 at 01:51:48PM +0800, Peter Xu wrote:
> A tiny refactoring, preparing to split the QMP dispatcher away.
>=20
> Reviewed-by: Fam Zheng <famz@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  monitor.c | 48 +++++++++++++++++++++++++++++++-----------------
>  1 file changed, 31 insertions(+), 17 deletions(-)
>=20
> diff --git a/monitor.c b/monitor.c
> index 9666115259..35d8925636 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -3877,6 +3877,36 @@ static int monitor_can_read(void *opaque)
>      return (mon->suspend_cnt =3D=3D 0) ? 1 : 0;
>  }
> =20
> +/*
> + * When rsp/err/id is passed in, the function will be responsible for
> + * the cleanup.
> + */

Please document this function fully.  I had to look at the
implementation to learn how the arguments work:

1. This function takes ownership of rsp, err, and id.  (Please use this
exact wording because the function does not perform the "cleanup" when
refcount > 1.)
2. rsp, err, and id may be NULL.
3. If err !=3D NULL then rsp must be NULL.

--PGNNI9BzQDUtgA2J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaMWTlAAoJEJykq7OBq3PIFXkIAK6ceV/rs7u35jrisfYssQut
J6rCq4L7oNveE1C6YysWXMl1E491yDsYlmvfy8op2fC//BHFETIaxCdCRu88y9G4
iQYc1e8hcyaWlY1zpguggj/TUMX2WicRsTB2I4cYKARovcg2VMFY/c8DyoZk+hbD
ZeTbTk8CL6dFshFYbTNnbgLF3TsZGhdA0DwRhhDS3wxXiu0665YKXQP5YBQMPUof
KmucchdXSi6rK0ILQa/02lB0X0x9aZS5fiAFp2VVTmVNYYFvc9+o/REjja/j87EH
Uv3OpzfoRPhz2+aNUHentHnqWPocF2+BCpNlY9evRm69q84tLhE4HGDtdJ9JUV0=
=0lal
-----END PGP SIGNATURE-----

--PGNNI9BzQDUtgA2J--
