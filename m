Received: from eggs.gnu.org ([2001:4830:134:3::10]:47321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eJHNy-0004mR-PC
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 06:15:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eJHNv-0005xo-Jb
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 06:15:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54714)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eJHNv-0005xH-CS
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 06:15:35 -0500
Date: Mon, 27 Nov 2017 11:15:32 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171127111532.GI16527@stefanha-x1.localdomain>
References: <20171124183446.7308-1-ppandit@redhat.com>
	<20171124183446.7308-2-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xQR6quUbZ63TTuTU"
Content-Disposition: inline
In-Reply-To: <20171124183446.7308-2-ppandit@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/2] virtio: check VirtQueue Vring
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
Cc: Qemu Developers <qemu-devel@nongnu.org>, zhangboxian <zhangboxian@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Prasad J Pandit <pjp@fedoraproject.org>


--xQR6quUbZ63TTuTU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Nov 25, 2017 at 12:04:45AM +0530, P J P wrote:
> @@ -1426,6 +1429,9 @@ hwaddr virtio_queue_get_addr(VirtIODevice *vdev, int n)
>  void virtio_queue_set_rings(VirtIODevice *vdev, int n, hwaddr desc,
>                              hwaddr avail, hwaddr used)
>  {
> +    if (!vdev->vq[n].vring.num || !desc || !vdev->vq[n].vring.align) {

Why !desc?

--xQR6quUbZ63TTuTU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaG/PUAAoJEJykq7OBq3PIbusIALwHZCmbRS3703I61Jfyp2Yn
JzxKagS0zdmvNmUk/PUr5Qx0nbylvkBPZ56kB+4nVQyfyE7bgeAK16jLYNRqsJJB
nATxE7ClQxAuZp5N5BjEIuLJPxHDfPralDhZDqzJLU2+uWQewEq2sWlhcmyo8B/D
UixlzEtQj+apZpnPBJGhmsTltdifYNwE+Am+EplD2TJzYlpBKOQJqpYbno0ZRORq
PO4MOaZz91dGswZl6tKDuE+3kVB1Ls1NvtD0cCTU9AL2QYKScBREPNCXP0RiyyIv
3qM1iaChjSIbUg+teN4KnO00/TBlt4s1Or7W++o47Gh/rmfwPHDo9DSWm4VpDTk=
=YF4k
-----END PGP SIGNATURE-----

--xQR6quUbZ63TTuTU--
