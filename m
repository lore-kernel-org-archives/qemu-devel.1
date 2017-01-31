Received: from eggs.gnu.org ([2001:4830:134:3::10]:52607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cYZs0-0000PM-2c
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 09:57:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cYZrz-0004ju-9m
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 09:57:20 -0500
Date: Tue, 31 Jan 2017 14:57:11 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170131145711.GP18804@stefanha-x1.localdomain>
References: <1482503344-6424-1-git-send-email-vsementsov@virtuozzo.com>
	<1482503344-6424-11-git-send-email-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Sk71+Upln2BLuDmg"
Content-Disposition: inline
In-Reply-To: <1482503344-6424-11-git-send-email-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 10/21] backup: refactor
 backup_copy_cluster()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, pbonzini@redhat.com, jcody@redhat.com


--Sk71+Upln2BLuDmg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 23, 2016 at 05:28:53PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
>     Split out read and write functions.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/backup.c     | 53 +++++++++++++++++++++++++++++++++++++++---------=
-----
>  block/trace-events |  4 ++--
>  2 files changed, 41 insertions(+), 16 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Sk71+Upln2BLuDmg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYkKXHAAoJEJykq7OBq3PI0cQH/1JkAfpuZCG5yFWsdWexiCOI
cCWPpbb5w0Xj02r1rZteBUhtXnXSu6Da8s75U3/N38Cpttswo3WEywCJDgt2IkGw
N61EH1f4bBghbzdd+0xR6PeGtDdeMOZcS5SxB/YR2O0syT7LolTax8SJB645EICe
lU3xrj6+wpiQatYPz7mznXh4RAAxx/mxwgYpqw7EZp35RXxk4aSBKMEKWrFHvlZW
PAsTeYiLPQqY8LU7V1DUnh71iotu0PRquakW7UD1GecH+FLpZObNne6faInEcq69
PwHj4ADnCm+U0jaso084TXEKhXCgIarh6/q0sry9DCMwR9IVaYUaIJYfVeiFGZs=
=pIMz
-----END PGP SIGNATURE-----

--Sk71+Upln2BLuDmg--
