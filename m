Received: from eggs.gnu.org ([2001:4830:134:3::10]:40954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fO48W-0003yN-EO
	for qemu-devel@nongnu.org; Wed, 30 May 2018 12:39:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fO48V-0003TL-I6
	for qemu-devel@nongnu.org; Wed, 30 May 2018 12:39:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51580 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fO48V-0003T1-CA
	for qemu-devel@nongnu.org; Wed, 30 May 2018 12:39:43 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ED72676F91
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 16:39:42 +0000 (UTC)
Date: Wed, 30 May 2018 17:39:37 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180530163937.GI5973@stefanha-x1.localdomain>
References: <20180529055755.12404-1-peterx@redhat.com>
	<20180529055755.12404-8-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rCb8EA+9TsBVtA92"
Content-Disposition: inline
In-Reply-To: <20180529055755.12404-8-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v9 7/7] monitor: add lock to protect
 mon_fdsets
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


--rCb8EA+9TsBVtA92
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 29, 2018 at 01:57:55PM +0800, Peter Xu wrote:
> Introduce a new global big lock for mon_fdsets.  Take it where needed.
>=20
> The monitor_fdset_get_fd() handling is a bit tricky: now we need to call
> qemu_mutex_unlock() which might pollute errno, so we need to make sure
> the correct errno be passed up to the callers.  To make things simpler,
> we let monitor_fdset_get_fd() return the -errno directly when error
> happens, then in qemu_open() we move it back into errno.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  monitor.c     | 52 +++++++++++++++++++++++++++++++++++++++++----------
>  stubs/fdset.c |  2 +-
>  util/osdep.c  |  3 ++-
>  3 files changed, 45 insertions(+), 12 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--rCb8EA+9TsBVtA92
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbDtPJAAoJEJykq7OBq3PIDWoIALEXAEADMLTh53wRyFNj8vsT
XcF0ke8S/xF40IH4xpEUMXUaaWjpgWEhsEv/PXzYA+NaP5shdXvUp1hCTJUr1X82
77ppoh6nfywGVQEUzou91wBYiOp9dg7+iluX7CHUlWzhdZdygyVbbOj0MutvdWGC
/hqes+7vcKvkcdHZMol47F96Xgtu0s4gx3gM5WD3eihkXhDloAJr4DW5UiCezWuq
EDs/oBAJ0s4bytYjkxXFvT4J7/DcrtBGMXhrZOFZqG12xw34B+IVD3bo+38jxUGd
hefjrkAWAPUvl0hOmPJkZRZp8juOIRrsSFZaYSGs+wFBq214dAxBK0PEWMFVO1U=
=wgrv
-----END PGP SIGNATURE-----

--rCb8EA+9TsBVtA92--
