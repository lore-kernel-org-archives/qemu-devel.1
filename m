Received: from eggs.gnu.org ([208.118.235.92]:50950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gfNWJ-0001Bj-Kd
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 06:20:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gfNWI-0004S5-SI
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 06:20:07 -0500
Date: Fri, 4 Jan 2019 11:19:58 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190104111958.GC30381@stefanha-x1.localdomain>
References: <20190103114700.9686-1-npes87184@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="m51xatjYGsM+13rf"
Content-Disposition: inline
In-Reply-To: <20190103114700.9686-1-npes87184@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/3] dmg: fixing reading in dmg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yuchenlin <npes87184@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org


--m51xatjYGsM+13rf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 03, 2019 at 07:46:57PM +0800, yuchenlin wrote:
> There are two bugs in dmg reading.
>=20
> First, it may hang in binary search. this problem is solved by patch 1.
> Second, because of lacking zero chunk table, reading zero sector will
> return EIO. this problem is solved by patch 2 and 3.
>=20
> Thanks
>=20
> v2 -> v3:
> * fix potential overflow (Thanks Stefan)
> * add Reviewed tag in patch 2 and 3
>=20
> v1 -> v2:
> * fix typos in patch 1
> * add patch 2 and patch 3
>=20
> yuchenlin (3):
>   dmg: fix binary search
>   dmg: use enumeration type instead of hard coding number
>   dmg: don't skip zero chunk
>=20
>  block/dmg.c | 29 +++++++++++++++++++----------
>  1 file changed, 19 insertions(+), 10 deletions(-)
>=20
> --=20
> 2.17.1
>=20

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--m51xatjYGsM+13rf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcL0FeAAoJEJykq7OBq3PI0rAH/jihKBijXxIlgiJB/hzgUewF
fxsmcJTSQ81hYv/gXaCw43QYef2s6QfTBTYWI6w5b8YDsEohv+9NpSJuVOMomC5k
2w/OxUAdSPV3kLPdxuHm2V0kwNoqPYASXwJI/0YH8sStCkD2kLXn5Am51USOAMJj
eYSmIhjpG6GcceUEYqONDDOSTX8TAGZxwk3WOQmvAnmnryxruG82CID+yZCM+AAV
3KnDNB74CkZR8jt7GcSblZ7QhwBvg51ulZ5+J2x5czM3ynsNWxKiq1xryQjJjTeN
mV8adlJMuvAxjof37JXTnaJp3adv9eXZFUtgN7fkpnNB09zUep7uM3yw/YFprPo=
=ocy7
-----END PGP SIGNATURE-----

--m51xatjYGsM+13rf--
