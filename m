Received: from eggs.gnu.org ([2001:4830:134:3::10]:59951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eKQEY-0001dP-O0
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 09:54:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eKQEY-0002iP-1I
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 09:54:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45158)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eKQEX-0002hp-Qa
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 09:54:37 -0500
Date: Thu, 30 Nov 2017 14:54:20 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171130145420.GB15942@stefanha-x1.localdomain>
References: <20171129174428.27548-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XF85m9dhOBO43t/C"
Content-Disposition: inline
In-Reply-To: <20171129174428.27548-1-ppandit@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 0/2] check VirtiQueue Vring objects
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Cornelia Huck <cohuck@redhat.com>, zhangboxian <zhangboxian@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Prasad J Pandit <pjp@fedoraproject.org>, P J P <ppandit@redhat.com>


--XF85m9dhOBO43t/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2017 at 11:14:26PM +0530, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>

Michael is the virtio maintainer.  I have added him to this email
thread so the patch series can be merged.

>=20
> Hello,
>=20
> A guest could attempt to use an uninitialised VirtQueue object
> or set Vring object with undue values, raising an unexpected
> exception in Qemu. This patch set fixes this issue and also adds
> a unit test to the suite.
>=20
> Thank you.
> --
> Prasad J Pandit (2):
>   virtio: check VirtQueue Vring object is set
>   tests: add test to check VirtQueue object
>=20
>  hw/virtio/virtio.c      | 14 +++++++++++---
>  tests/virtio-blk-test.c | 25 +++++++++++++++++++++++++
>  2 files changed, 36 insertions(+), 3 deletions(-)
>=20
> --
> 2.13.6

--XF85m9dhOBO43t/C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaIBucAAoJEJykq7OBq3PIEPkH/RtInoDEObjlTF8FLxRiY8vn
5y94I+5YdJgIgiW0/qRPrwpcUk3ZUMI58PNtzvsf2s5GpSC32yA2gmy+sTyvZT4a
WrjgSD1eqrfqi2PrhdRWNvs5nj6XaU1NRPYDtX+2HXYWKKi2yZPtDcbmO2nOLEpP
agPmZECaL0STYccUo93QDBIF+qyKnDUOV2rlg0ylfv9imIOQjvxoxkYR7n/uhBg0
Zq2y6NLlByhB1EB26WZx1JqHKe80HnASJ8o80zhoH5qwBeiEIA3lLEKAPSmNYY9g
wDp17Zgg5pVGAeD4CdNaRRSI2+9J9cOFI5QBYbmOwfF3ttKKH+8ameeIkK1Y/Zw=
=ZRRn
-----END PGP SIGNATURE-----

--XF85m9dhOBO43t/C--
