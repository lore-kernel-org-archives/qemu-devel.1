Received: from eggs.gnu.org ([2001:4830:134:3::10]:45448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cYZOM-0002WH-4N
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 09:26:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cYZOL-00020O-3J
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 09:26:42 -0500
Date: Tue, 31 Jan 2017 14:26:31 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170131142631.GL18804@stefanha-x1.localdomain>
References: <1482503344-6424-1-git-send-email-vsementsov@virtuozzo.com>
	<1482503344-6424-8-git-send-email-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kaF1vgn83Aa7CiXN"
Content-Disposition: inline
In-Reply-To: <1482503344-6424-8-git-send-email-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 07/21] backup: refactor: merge
 top/full/incremental backup code
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


--kaF1vgn83Aa7CiXN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 23, 2016 at 05:28:50PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> Merge top/full/incremental modes backup into one backup_loop.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/backup.c | 41 +++++++++--------------------------------
>  1 file changed, 9 insertions(+), 32 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--kaF1vgn83Aa7CiXN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYkJ6XAAoJEJykq7OBq3PI+LgIAI3dovtgkrDiBN1kl8Em/Lv3
fPH/BlcNkSGLcfZ9mvYpTaZld+NV8jmGTeOmfXsiUskfROF4JhFnpjMkuwa7m1zk
rBndJlBt41x0+ZtqO2L8HwENQLcFnlgQMmx1X++q1L4rDPcqsgfksHKs6Muw9lGy
trIitr2Oztp1/H8fGUn7QHpZ5OgqNVAkdbGDXO6swT5FMdc9SrHSXOxiUAiu1IbB
fv62B6NeOl1xQE87w9lDK5FrKJ8zv7oolFsvlwt8/LjmN7tptxrl+Nub23BWJ0is
/hf2QBMJHEZtQcl8rs0QnJAFykktc8yIJsP4J+u5a0ldARIsNQ48O0AcdjBX5lA=
=3cB3
-----END PGP SIGNATURE-----

--kaF1vgn83Aa7CiXN--
