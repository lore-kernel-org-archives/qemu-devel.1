Received: from eggs.gnu.org ([2001:4830:134:3::10]:36460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cTsf3-00005j-Ni
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:00:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cTsez-00061Y-Su
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:00:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58444)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cTsez-00061K-Ma
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:00:29 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C237A444EC
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 16:00:29 +0000 (UTC)
Date: Wed, 18 Jan 2017 16:00:26 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170118160026.GP30347@stefanha-x1.localdomain>
References: <20170113131731.1246-1-pbonzini@redhat.com>
	<20170113131731.1246-16-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R3SAtXwgGp429mN7"
Content-Disposition: inline
In-Reply-To: <20170113131731.1246-16-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 15/16] async: remove unnecessary inc/dec
 pairs
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


--R3SAtXwgGp429mN7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 13, 2017 at 02:17:30PM +0100, Paolo Bonzini wrote:
> Pull the increment/decrement pair out of aio_bh_poll and into the
> callers.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  aio-posix.c |  8 +++-----
>  aio-win32.c |  8 ++++----
>  async.c     | 12 ++++++------
>  3 files changed, 13 insertions(+), 15 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--R3SAtXwgGp429mN7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYf5EaAAoJEJykq7OBq3PIp80IAJrVrEYl59zbvCKM+LMXw0iC
p0j6ioI2WRZoDEWT6tU57efaazpYMYX6KgjFDYzYLnUK1IY17KLDi8/cMSEYmHWD
AZynu+YkB9ZjrvLyhTBHgKU7SMN07UPqwRX0CAdaqX9L+ZF0qvR4vT90nR8DqS3v
JztMs50yBV6OPs4Vn6qTM4RggkrwIHmi+pqVBzgFvQQiHiG39qoViUom2w2utPwO
kOCrRWjWDzHfOAg5bzmK8QHJeWZFfWqQxkhO6NAwYjsILW+MdZ6l8snPlGr8LC9E
7wKrGuOZXhJZsT0dqMhosXY059g/eNWekf8IVBlKrFMF55D2mvSHO/mQYJUEZAE=
=Qqz4
-----END PGP SIGNATURE-----

--R3SAtXwgGp429mN7--
