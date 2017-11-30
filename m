Received: from eggs.gnu.org ([2001:4830:134:3::10]:59537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eKQDW-000127-E1
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 09:53:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eKQDS-0001zW-G5
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 09:53:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47762)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eKQDS-0001zC-92
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 09:53:30 -0500
Date: Thu, 30 Nov 2017 14:53:27 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171130145327.GA15942@stefanha-x1.localdomain>
References: <20171129174428.27548-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
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
To: P J P <ppandit@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Cornelia Huck <cohuck@redhat.com>, zhangboxian <zhangboxian@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Prasad J Pandit <pjp@fedoraproject.org>


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2017 at 11:14:26PM +0530, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
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

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaIBtnAAoJEJykq7OBq3PIPz4H/0MfslPZUt4mCFRhefwrdfmd
vo4XQAg/pJiD66kWrWxGoRd/vhMI1QqWIx4agBZLYJKQo90vcFL+fG0cwcPJt+Rr
vzHzGycZ7mKeTgk3CvEK5qj4jBq3aKH2bHZqqfk3cD4UlZlzzVqaNBbfdsiebcXi
i3KjcloMXHZPnTnSw//k1yZ015PKDRsHHzJiFSlYpJnQhg1e39utLXBEd0dr8qPc
lbq84SeSY4g62eSSvidXAGsaXep38Gde/UCvXK8BFArGDPLhjzgxG+dGf+sPSebe
C1JgOFPiGVcbwUzhDE3zCsf+c6b1OABXq9kJbVG2UEj5tVTEYG0Dk7R+LEqvHBk=
=42lN
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
