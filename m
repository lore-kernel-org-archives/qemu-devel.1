Received: from eggs.gnu.org ([2001:4830:134:3::10]:32902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6HUp-0002Lb-Bm
	for qemu-devel@nongnu.org; Thu, 04 May 2017 10:12:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6HUk-0004ta-DJ
	for qemu-devel@nongnu.org; Thu, 04 May 2017 10:12:43 -0400
Date: Thu, 4 May 2017 15:12:34 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170504141234.GQ32376@stefanha-x1.localdomain>
References: <20170420120058.28404-1-pbonzini@redhat.com>
	<20170420120058.28404-14-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZgGN478A9hzzvyZc"
Content-Disposition: inline
In-Reply-To: <20170420120058.28404-14-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 13/17] coroutine-lock: introduce
 qemu_co_mutex_lock_unlock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org


--ZgGN478A9hzzvyZc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 20, 2017 at 02:00:54PM +0200, Paolo Bonzini wrote:
> This primitive lets you lock/unlock a CoMutex, guaranteeing neither
> blocking nor cacheline bouncing if there is no qemu_co_mutex_lock
> critical section.

"Guaranteeing neither X nor Y" means "does not guarantee X or Y".  Did
you mean "Guarantees not X and not Y"?

>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/qemu/coroutine.h   |  6 ++++++
>  util/qemu-coroutine-lock.c | 36 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 42 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--ZgGN478A9hzzvyZc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZCzbSAAoJEJykq7OBq3PIuxsIAL/+kxlLqgZ0fwfOutLSYYaN
SFJ8Mf7IyIauE6/3w4C2BJztr+B7s0gbxzx0qiVKA6uMAqo9CI0N5LgA6QZ0t8ht
pQn9paNugucZNMvXwKw9DjJxMdwZ1T/HaHBF+mxqVfcrDHmVIkZFRn2x4nuvQspo
JeM5bvbZuxOuyDw5fKQ495bc9bMmYOHuywAFaBy70SQPUYQMIFcJ6Lqpl76lzbNr
yLZt3WSzWuNk/bFK9RDC2j/LffFjKLdfBLkhZ8ptmAXxVoKJNxVOE5xCmx5GIDQf
NEAV2R16NJe3lBW9CdaCJ2m4/PHHkDV4h8uN1Rv6j/9CrwCVOtgv9ZvoNqZPjtk=
=cQjc
-----END PGP SIGNATURE-----

--ZgGN478A9hzzvyZc--
