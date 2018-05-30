Received: from eggs.gnu.org ([2001:4830:134:3::10]:40044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fO46X-0002Kx-I5
	for qemu-devel@nongnu.org; Wed, 30 May 2018 12:37:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fO46S-0002VJ-K2
	for qemu-devel@nongnu.org; Wed, 30 May 2018 12:37:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60464 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fO46S-0002V7-Es
	for qemu-devel@nongnu.org; Wed, 30 May 2018 12:37:36 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 107BE401EF10
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 16:37:36 +0000 (UTC)
Date: Wed, 30 May 2018 17:37:34 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180530163734.GH5973@stefanha-x1.localdomain>
References: <20180529055755.12404-1-peterx@redhat.com>
	<20180529055755.12404-7-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AqCDj3hiknadvR6t"
Content-Disposition: inline
In-Reply-To: <20180529055755.12404-7-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v9 6/7] monitor: move init global earlier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>


--AqCDj3hiknadvR6t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 29, 2018 at 01:57:54PM +0800, Peter Xu wrote:
> Before this patch, monitor fd helpers might be called even earlier than
> monitor_init_globals().  This can be problematic.
>=20
> After previous work, now monitor_init_globals() does not depend on
> accelerator initialization any more.  Call it earlier (before CLI
> parsing; that's where the monitor APIs might be called) to make sure it
> is called before any of the monitor APIs.
>=20
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  vl.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--AqCDj3hiknadvR6t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbDtNOAAoJEJykq7OBq3PI49oIALtBOMH9bK0TQl1KAzYvaqrx
L/e/OS/zUuNqaJZ0dTmF5hboAzYvIRrwyIIsvmP3A2wTpHrxTdnWm68RzKv3024q
CvVF1pphBZGLktXLy2cZpqukBkenwG2Ycu8XsmlSC+Z2OwT6LXY1TI6GCFUIM2Sr
OxNPZavoFXUhujo3PxW9wxQmK23q0Jb4xpcHYt+kA9oHbq7beCATCadZDODuqXsp
ssguq5mDO43aelmvLFLInChCsjWNjiDORSJLQp7ynqSKIvLBCmEI/SWlST9AEGVj
9FDnjJhrOAedYcaufDJHWqnu5ZKD8yprckUvmNiBelXeOwYILdLuOQaQUIfIw8M=
=AaDx
-----END PGP SIGNATURE-----

--AqCDj3hiknadvR6t--
