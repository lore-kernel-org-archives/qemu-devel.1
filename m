Received: from eggs.gnu.org ([2001:4830:134:3::10]:41047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f3fAd-00073a-00
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 05:57:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f3fAX-0007OJ-VQ
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 05:57:35 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:45339)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1f3fAX-0007O0-Nt
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 05:57:29 -0400
Received: by mail-wr0-x22f.google.com with SMTP id u11so21599930wri.12
	for <qemu-devel@nongnu.org>; Wed, 04 Apr 2018 02:57:29 -0700 (PDT)
Date: Wed, 4 Apr 2018 10:57:26 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180404095726.GL4467@stefanha-x1.localdomain>
References: <20180328173238.507470-1-vsementsov@virtuozzo.com>
	<20180328173238.507470-2-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2OzUYMsT4j3Kc+NU"
Content-Disposition: inline
In-Reply-To: <20180328173238.507470-2-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 1/4] scripts/qemugdb: get pthread_self from
 "info threads" command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, stefanha@redhat.com, den@openvz.org


--2OzUYMsT4j3Kc+NU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 28, 2018 at 08:32:35PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> When debugging a coredump, pthread_self can't be obtained from
> function arch_prctl. Moreover if qemu crashed in coroutine, we
> can't find 'start_thread' in current stack-trace. So, add a method,
> actually proposed in 1138f24645e9e, which should work for gdb
> version >=3D 7.3.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  scripts/qemugdb/coroutine.py | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--2OzUYMsT4j3Kc+NU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaxKGGAAoJEJykq7OBq3PI3PcH/1BaDtyr9JmskMUW9xLUVcHn
kXbSQC99skRn+sJtiUeQRImnk/PuGExmBDOEEQtIHzQ7YlzScDN8zbh0R+1QpIqm
sWfARPi2348O+dAjA3ZnXCDTsSm/w4sT6pyreZ2TTmPqD4Ln96l/mpWRL1rzJ6Rf
8n4B/hkyK4AUtEFrtM4E9Dal8A1XOsrGtEQjE2pCGioLjKBKBWpSrtGEmuPlOc2L
t8DkN9qzLSoVcz8zSHoNgnbdMbPgdQ6BjWS7Wl4YAirtFcWwdOx6rXBNdxJQd76Y
hxym8ME2Xc2JOlFfdbnZG6AGuPikj377zlGzn3FBfoMkA6V5K+68jJzDFQBELx4=
=+1hc
-----END PGP SIGNATURE-----

--2OzUYMsT4j3Kc+NU--
