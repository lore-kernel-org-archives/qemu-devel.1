Received: from eggs.gnu.org ([2001:4830:134:3::10]:36879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1evMbn-0004X7-Vh
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 08:31:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1evMbk-0000vY-T1
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 08:31:19 -0400
Date: Mon, 12 Mar 2018 12:31:13 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180312123113.GD5681@stefanha-x1.localdomain>
References: <20180309165212.97144-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rz+pwK2yUstbofK6"
Content-Disposition: inline
In-Reply-To: <20180309165212.97144-1-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v6 0/2] block latency histogram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, armbru@redhat.com, mreitz@redhat.com, nshirokovskiy@virtuozzo.com, den@openvz.org


--rz+pwK2yUstbofK6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 09, 2018 at 07:52:10PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> v6:
>=20
> Use correct header qapi/qapi-builtin-types.h, to fix build again.
> Sorry for spam =3D(
>=20
>=20
> v5:
>=20
> Revert to v3 and just add qapi-types.h header.
>=20
>=20
> v4:
>=20
> Move block_latency_histogram_set from block/accounting.c to
> blockdev.c, as it uses qapi type uint64List and this fact breaks
> build.
>=20
>=20
> v3:
>=20
> - semantics, naming and wording changed a lot
> - x prefixes added to new qapi names
> - bug fixed about calculation of new_size (new_nbins now)
> - drop g_renew
> - in _clear() set nbinst to zero too
>=20
> v2:
>=20
> 01: add block_latency_histogram_clear()
> 02: fix spelling (sorry =3D()
>     some rewordings
>     remove histogram if latency parameter unspecified
>=20
> Vladimir Sementsov-Ogievskiy (2):
>   block/accounting: introduce latency histogram
>   qapi: add block latency histogram interface
>=20
>  qapi/block-core.json       | 111 +++++++++++++++++++++++++++++++++++++++=
+++++-
>  include/block/accounting.h |  35 ++++++++++++++
>  block/accounting.c         |  91 +++++++++++++++++++++++++++++++++++++
>  block/qapi.c               |  41 +++++++++++++++++
>  blockdev.c                 |  43 ++++++++++++++++++
>  5 files changed, 320 insertions(+), 1 deletion(-)
>=20
> --=20
> 2.11.1
>=20
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--rz+pwK2yUstbofK6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJapnMRAAoJEJykq7OBq3PI+UQH/isK7m8HSuppLJxPpYmI4LEh
C9zmKc/pEWIHZqpOhsFpx64yaaW2DuD1kH+FN4xuryplS7K+PP8NpfJgmN6smSmd
qJy5Prz1cSg8w7V1hp3PtQUHh6Fr9gHebN5ytqW6MB6QUMOX/f2IY5tcxUxoyPEo
/mKVztZpKDuVihegH4ypV9iYfK8msjOP/MkYCbc4g5ChCJr5W1OQ3XoDzvvg+zfO
724+0k7EcgVK1rRLTNKtO3q9bF8Qu7xHSZCaF0YvmnJb0/7J0LmOFeihxAd+aFFg
VMxz/1YHGk7QiB25yB7jhL/d/ENpegycy/1uDZI0OmflYeIA4xNCUoi+XdER73c=
=rn5F
-----END PGP SIGNATURE-----

--rz+pwK2yUstbofK6--
