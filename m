Received: from eggs.gnu.org ([2001:4830:134:3::10]:59719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ciKOj-0001lP-Dy
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 07:27:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ciKOi-0003pT-Hh
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 07:27:25 -0500
References: <20170225170758.427066-1-vsementsov@virtuozzo.com>
	<20170225170758.427066-9-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <fec4aa12-6aaa-5e4e-3439-01578db31327@redhat.com>
Date: Mon, 27 Feb 2017 13:27:13 +0100
MIME-Version: 1.0
In-Reply-To: <20170225170758.427066-9-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ktKlGIhPG16RCU26tmGXXedgWnGbxaUTq"
Subject: Re: [Qemu-devel] [PATCH v16 08/22] qcow2: add bitmaps extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ktKlGIhPG16RCU26tmGXXedgWnGbxaUTq
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <fec4aa12-6aaa-5e4e-3439-01578db31327@redhat.com>
Subject: Re: [PATCH v16 08/22] qcow2: add bitmaps extension
References: <20170225170758.427066-1-vsementsov@virtuozzo.com>
 <20170225170758.427066-9-vsementsov@virtuozzo.com>
In-Reply-To: <20170225170758.427066-9-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 25.02.2017 18:07, Vladimir Sementsov-Ogievskiy wrote:
> Add bitmap extension as specified in docs/specs/qcow2.txt.
> For now, just mirror extension header into Qcow2 state and check
> constraints. Also, calculate refcounts for qcow2 bitmaps, to not break
> qemu-img check.
>=20
> For now, disable image resize if it has bitmaps. It will be fixed later=
=2E
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/Makefile.objs    |   2 +-
>  block/qcow2-bitmap.c   | 439 +++++++++++++++++++++++++++++++++++++++++=
++++++++
>  block/qcow2-refcount.c |   6 +
>  block/qcow2.c          | 124 +++++++++++++-
>  block/qcow2.h          |  27 +++
>  5 files changed, 592 insertions(+), 6 deletions(-)
>  create mode 100644 block/qcow2-bitmap.c

Somehow I have the feeling Kevin will find bad things in this patch, but
since I have already approved of all of the previous patches this one is
composed of and the changes on top of that look OK to me:

Reviewed-by: Max Reitz <mreitz@redhat.com>


--ktKlGIhPG16RCU26tmGXXedgWnGbxaUTq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAli0GyESHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AkegIAKE7j9RhVknAmIu+n2B3vqD5Ut/s5NyW
fFJNn+uFF1wBtQDZx23BwpRZ82jo+OVecXAWa7hexuus3a39uZT/WN0w+2Vo8m13
cJl7P2ZrxRHggYJZSGHUeOie48FLdyZBQEgke/9TCYsMFv9f1pijasBPGuj5uzuE
4RtmW9+Xoy9mLueulIZwW/15rIMwRd8aGRCSAuxXVpcmKzSjUuSaAokKo7guQYt3
iBAOOvZYxn9rNGbaSuQboZQPMITB2Qp1+DlEj3HjIhbuO4ZuzRsXcpbbXUux4+Cs
qgz3TMkW1JCAOguwROL1rJalDxw9p8L3ru5WGtnU8fJv2/1DWnriBxQ=
=ridQ
-----END PGP SIGNATURE-----

--ktKlGIhPG16RCU26tmGXXedgWnGbxaUTq--
