Received: from eggs.gnu.org ([2001:4830:134:3::10]:35763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dUb3i-0005ZJ-Kt
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:57:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dUb3h-0000xL-Uf
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:57:14 -0400
Date: Mon, 10 Jul 2017 16:57:07 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170710155707.GO14195@stefanha-x1.localdomain>
References: <20170706163828.24082-1-pbonzini@redhat.com>
	<20170706163828.24082-6-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6zipuvUKAEymKn2g"
Content-Disposition: inline
In-Reply-To: <20170706163828.24082-6-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 05/11] block-backup: add reqs_lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, qemu-block@nongnu.org


--6zipuvUKAEymKn2g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 06, 2017 at 06:38:22PM +0200, Paolo Bonzini wrote:
> Protect the list of inflight reqs and the CoQueues for dependent
> requests.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block/backup.c               | 20 +++++++++++++++-----
>  block/replication.c          |  2 +-
>  include/block/block_backup.h |  2 +-
>  3 files changed, 17 insertions(+), 7 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--6zipuvUKAEymKn2g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZY6PTAAoJEJykq7OBq3PIsdsH/2eZh8Bfj8pDhXu/YjhWNDbM
0LKHHykzTxBJPc0LK2VI4grna5eVgGV8iYd1bTDfW5aH03ZiJZrK/9Mx5tHZ623s
+MmoIQ82RW1nT0F5pvkBOsxi6n0yrnmb5molc+SM4sCPD14tJsKEJTyRDbwpRBj5
gzpOfH6Git8VeufWkCDFpRFGrfMU7lNBymJhcMBseF94m2d+WyJ5Wbn2ctpHMrGk
XGBPWMoOq4VOM61Qw0pGZ/41CzF5R9+LP9j86PLmCQSBHYswWW7EP6h4AFp9R1Ev
vIk/Qy/xi+SUzjFQtC0mXhUOeevjsQ0HynzLWSHtIneGSSTHB3PRM0BHkmldFJM=
=++iU
-----END PGP SIGNATURE-----

--6zipuvUKAEymKn2g--
