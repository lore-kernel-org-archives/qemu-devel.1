Received: from eggs.gnu.org ([209.51.188.92]:33710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gk4hw-0001ep-LK
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 05:15:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gk4hu-0000ZN-OX
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 05:15:32 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42255)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gk4hs-0000Nx-8S
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 05:15:28 -0500
Received: by mail-wr1-x443.google.com with SMTP id q18so10299166wrx.9
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 02:15:26 -0800 (PST)
Date: Thu, 17 Jan 2019 10:15:23 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190117101523.GB27840@stefanha-x1.localdomain>
References: <1547691856-26675-1-git-send-email-changpeng.liu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s/l3CgOIzMHHjg/5"
Content-Disposition: inline
In-Reply-To: <1547691856-26675-1-git-send-email-changpeng.liu@intel.com>
Subject: Re: [Qemu-devel] [PATCH v3] vhost-user-blk: add discard/write
 zeroes features support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Changpeng Liu <changpeng.liu@intel.com>
Cc: qemu-devel@nongnu.org, sgazare@redhat.com, stefanha@redhat.com, mst@redhat.com


--s/l3CgOIzMHHjg/5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 17, 2019 at 10:24:16AM +0800, Changpeng Liu wrote:
> Linux commit 1f23816b8 "virtio_blk: add discard and write zeroes support"
> added the support in the Guest kernel, while here also enable the features
> support with vhost-user-blk driver. Also enable the test example utility
> with DISCARD and WRITE ZEROES commands.
>=20
> Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
> ---
>  contrib/vhost-user-blk/vhost-user-blk.c     | 134 +++++++++++++++++++++-=
------
>  hw/block/vhost-user-blk.c                   |   4 +
>  include/standard-headers/linux/virtio_blk.h |  54 +++++++++++
>  3 files changed, 159 insertions(+), 33 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--s/l3CgOIzMHHjg/5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcQFW7AAoJEJykq7OBq3PIqeIIALwXkC00F+D5uc1q4cJFUo9C
LXP43dcUhQ7wKyotZM5cDlQGkfpLb2pfaU4W3uwujTEYDtan79fAhLQPfvG1cHME
lExNAoAN00BbvdslQ9cPpim38FqqSZVNxdvuH1pUnxD5RvFvRkTLxCNkI/zsQutY
UV3QFSKEHGO0bwXh9RWdyrKFr1xKpK3fWX7ePo02l3n1bYg5PN4iXflIXPd/2CBz
nOK1rLyDV3AfqxL1+GNYoLuU08qUSxCI0X4HrxYvU6Bfhb42GXdz5MfQeIreeqO3
ftUFWbyhT59yx4xMhedW3zxTHATgMLZIQobic6lkS7eiIr5WAQLZR2joEfVRAWo=
=8R6M
-----END PGP SIGNATURE-----

--s/l3CgOIzMHHjg/5--
