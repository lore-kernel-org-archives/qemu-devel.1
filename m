Received: from eggs.gnu.org ([209.51.188.92]:46677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gyzEJ-0002oE-UD
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:26:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gyzEJ-0001RH-85
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:26:35 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:50328)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gyzEH-0001Nh-At
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:26:33 -0500
Received: by mail-wm1-x341.google.com with SMTP id x7so5809714wmj.0
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 05:26:24 -0800 (PST)
Date: Wed, 27 Feb 2019 13:26:21 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190227132621.GA22539@stefanha-x1.localdomain>
References: <20190222031413.20250-1-peterx@redhat.com>
	<20190222031413.20250-2-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
In-Reply-To: <20190222031413.20250-2-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/4] iothread: replace init_done_cond with
 a semaphore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 22, 2019 at 11:14:10AM +0800, Peter Xu wrote:
> Only sending an init-done message using lock+cond seems an overkill to
> me.  Replacing it with a simpler semaphore.
>=20
> Meanwhile, init the semaphore unconditionally, then we can destroy it
> unconditionally too in finalize which seems cleaner.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/sysemu/iothread.h |  3 +--
>  iothread.c                | 17 ++++-------------
>  2 files changed, 5 insertions(+), 15 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcdo/9AAoJEJykq7OBq3PIVmEH/0Gw1p4PYO3yXegyOaUZwy5A
tH75ppX8jTHnQ7Lki5+a0xxpYBA1uWJaUNbntr/U9eF5Z9xEHz36PW5vx5ZuLyK5
cnHx2v436oH806ONEg4/YgT06HZyAbi/U7gXNbajpX43CjPBuCVw220H2aDrHpkZ
MWAGcIIJxzwlKJONHOqbl1/75oT+JDS2UQG60rOAhINO7UFE0J/pjxggBv/Eva/T
JYg6ZJWwtInk7Tzjnu/VjZZeI200DUWCxNSu7hqK6j0vtU0hPsoLU/iDUBMqyLW1
5b5uJdK9xSA4o7bY/Fn37prht3vjApNzVNBrNAVralxCgSCv/mNnX6I50Fw1C7Y=
=/9fl
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
