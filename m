Received: from eggs.gnu.org ([2001:4830:134:3::10]:59241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fOKNd-0007Oj-36
	for qemu-devel@nongnu.org; Thu, 31 May 2018 06:00:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fOKNY-0003Le-Rr
	for qemu-devel@nongnu.org; Thu, 31 May 2018 06:00:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39412 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fOKNY-0003Kp-2o
	for qemu-devel@nongnu.org; Thu, 31 May 2018 06:00:20 -0400
Date: Thu, 31 May 2018 11:00:17 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180531100017.GA27838@stefanha-x1.localdomain>
References: <1527557075-3411-1-git-send-email-changpeng.liu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline
In-Reply-To: <1527557075-3411-1-git-send-email-changpeng.liu@intel.com>
Subject: Re: [Qemu-devel] [PATCH v2] vhost-blk: turn on pre-defined RO
 feature bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Changpeng Liu <changpeng.liu@intel.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 29, 2018 at 09:24:35AM +0800, Changpeng Liu wrote:
> Read only feature shouldn't be negotiable, because if the
> backend device reported Read only feature supported, QEMU
> host driver shouldn't change backend's RO attribute. While
> here, also enable the vhost-user-blk test utility to test
> RO feature.
>=20
> Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
> ---
>  contrib/vhost-user-blk/vhost-user-blk.c | 48 ++++++++++++++++++++++++---=
------
>  hw/block/vhost-user-blk.c               |  5 +---
>  include/hw/virtio/vhost-user-blk.h      |  1 -
>  3 files changed, 36 insertions(+), 18 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbD8exAAoJEJykq7OBq3PIKwIIALHGYNHVRB2sMgHp3j3Rgna7
2DjFcn2RxjeA2friAWVwny8355lNSX0NqWAgHf3sp03e0pyo6ilf4UakhyYhUCq6
not/BKZjDEGGr1RmMw5gYrp7Kkl6/Jvg/Asdu+GfdAJDpzRBbA2fnAfZZUBvhXQg
6Xy3BVFinYD/AOByo9qB49OOWFbNYwEJ8+6N7/wygcp334ResH6LSZryuPKC1neD
pj4MSmffH7xwf6P9XWQFKtRFUC32sNcKvwHkKXJ7W02ZhcGMPm+XRBEWQ4Ev8wK2
vKmkhDtKwnZ9rZsqHrNL5oBer7rhTffYZWb7XJ31oMMycXoh8m2YfVYMwlsa24c=
=sXW1
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--
