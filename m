Received: from eggs.gnu.org ([2001:4830:134:3::10]:55673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cTsBB-0000KL-9K
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 10:29:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cTsB8-0000BP-5F
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 10:29:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34770)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cTsB7-0000AR-VV
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 10:29:38 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EE34273C60
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 15:29:37 +0000 (UTC)
Date: Wed, 18 Jan 2017 15:29:35 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170118152935.GJ30347@stefanha-x1.localdomain>
References: <20170113131731.1246-1-pbonzini@redhat.com>
	<20170113131731.1246-10-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nywXBoy70X0GaB8B"
Content-Disposition: inline
In-Reply-To: <20170113131731.1246-10-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 09/16] aio: push
 aio_context_acquire/release down to dispatching
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com


--nywXBoy70X0GaB8B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 13, 2017 at 02:17:24PM +0100, Paolo Bonzini wrote:
> The AioContext data structures are now protected by list_lock and/or
> they are walked with FOREACH_RCU primitives.  There is no need anymore
> to acquire the AioContext for the entire duration of aio_dispatch.
> Instead, just acquire it before and after invoking the callbacks.
> The next step is then to push it further down.
>=20
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  aio-posix.c | 25 +++++++++++--------------
>  aio-win32.c | 15 +++++++--------
>  async.c     |  2 ++
>  3 files changed, 20 insertions(+), 22 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--nywXBoy70X0GaB8B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYf4nfAAoJEJykq7OBq3PI6fUH/Ax2ShOwtmjqnOMsdy0Jp2dG
IQlDFUHUv0inVMhFe/wZrSCKnMqil5OGHHDiuwaE5qvkXbXFjBD26Ti8slfCvElc
mYe+Z0ypMAxgngSW3NJ54XSWbFoANWwPyYVK484ulI+3/iiDuEE/p22v2yB8T/gl
tl9up23alaDyzoPrzspclW3j6HjZPmrT97gYt5aYEjBFXGs4wpPuVnOQWNqav/h0
LSLaWnB0T52WJHh2ZzFDqTblSlQuocB55rfFroisuW6URcbJgpvHBma4R+LQM+XJ
q8SxCoB4o4i49y1pBS3xmt6b0vuiHrenJ0kFScm1im1MRhMDPHCz99gTcuXjpeo=
=Jjte
-----END PGP SIGNATURE-----

--nywXBoy70X0GaB8B--
