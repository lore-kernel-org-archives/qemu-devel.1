Received: from eggs.gnu.org ([2001:4830:134:3::10]:49791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eICYm-00070j-DX
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 06:54:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eICYj-0008Mg-Au
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 06:54:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34352)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eICYj-0008LF-4X
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 06:54:17 -0500
Date: Fri, 24 Nov 2017 11:54:13 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171124115413.GC12490@stefanha-x1.localdomain>
References: <20171124075542.16979-1-ppandit@redhat.com>
	<20171124075542.16979-2-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Clx92ZfkiYIKRjnr"
Content-Disposition: inline
In-Reply-To: <20171124075542.16979-2-ppandit@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 1/2] virtio: check VirtQueue Vring
 object is set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, zhangboxian <zhangboxian@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Prasad J Pandit <pjp@fedoraproject.org>


--Clx92ZfkiYIKRjnr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 24, 2017 at 01:25:41PM +0530, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
>=20
> An user could attempt to use an uninitialised VirtQueue object
> or unset Vring.align leading to a arithmetic exception. Add check
> to avoid it.
>=20
> Reported-by: Zhangboxian <zhangboxian@huawei.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/virtio/virtio.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>=20
> Updated: add vring.num check to virtio_queue_update_rings
>   -> https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg04499.html

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Clx92ZfkiYIKRjnr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaGAhlAAoJEJykq7OBq3PI6A0H/3MO8U6hw+AXIX7OhUbU5vYC
lI4AiHu9Fd15+h7/nlmFidjMm25ZYwhAJ+odXAWYbKm6RRdPxbs1ajjoy+4JrqB9
t8U0p17fD2EOMUPsUZrqiDW+oXkAuzQT44Mjvod1110rVyTvboPdRI2ozoNzV8wZ
wK1sufcjEqhVHBieQWENmuJQbuNYtLExl2drgZ/rfqadle11IO29xirczqruZf09
3OxZQ2tH7ExY/mEt2BzfTPxA7Du9gRjC6H8pCmml6xC2gI+r+4BBGVs+EOSCJkNQ
LapbMm/VmDqT9F/8WCVug/wNgKvfYxfJ/1x4KNgL2pI6vuxIEq+F4WlBO+n36Rk=
=AB/H
-----END PGP SIGNATURE-----

--Clx92ZfkiYIKRjnr--
