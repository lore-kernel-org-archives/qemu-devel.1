Received: from eggs.gnu.org ([2001:4830:134:3::10]:51706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fQuMs-0005tM-48
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 08:50:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fQuMp-00028j-1Y
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 08:50:18 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:35464)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fQuMo-000289-LS
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 08:50:14 -0400
Received: by mail-wr0-x241.google.com with SMTP id l10-v6so9734447wrn.2
	for <qemu-devel@nongnu.org>; Thu, 07 Jun 2018 05:50:14 -0700 (PDT)
Date: Thu, 7 Jun 2018 13:50:11 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180607125011.GL19032@stefanha-x1.localdomain>
References: <1528291488-2586-1-git-send-email-xieyongji@baidu.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="m+jEI8cDoTn6Mu9E"
Content-Disposition: inline
In-Reply-To: <1528291488-2586-1-git-send-email-xieyongji@baidu.com>
Subject: Re: [Qemu-devel] [PATCH v2] vhost-user-blk: start vhost when guest
 kicks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongji Xie <elohimes@gmail.com>
Cc: mst@redhat.com, stefanha@redhat.com, changpeng.liu@intel.com, nixun@baidu.com, qemu-devel@nongnu.org, chaiwen@baidu.com


--m+jEI8cDoTn6Mu9E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 06, 2018 at 09:24:48PM +0800, Yongji Xie wrote:
> Some old guests (before commit 7a11370e5: "virtio_blk: enable VQs early")
> kick virtqueue before setting VIRTIO_CONFIG_S_DRIVER_OK. This violates
> the virtio spec. But virtio 1.0 transitional devices support this behavio=
ur.
> So we should start vhost when guest kicks in this case.
>=20
> Signed-off-by: Yongji Xie <xieyongji@baidu.com>
> Signed-off-by: Chai Wen <chaiwen@baidu.com>
> Signed-off-by: Ni Xun <nixun@baidu.com>
> ---
>  hw/block/vhost-user-blk.c |   25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--m+jEI8cDoTn6Mu9E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbGSoDAAoJEJykq7OBq3PIBBAIAK6nIUGUuFsa6H5nQ0wOlux+
XK38rbwnGIZH8TwTixfot5rmFueFbEYMrpMTHkGbq8tt/RlG3cv3uk2rnIzBWf+C
gg8Nu0/4vQH5GSsVxLZ1V9mVlNjMKX4IVrNZSL2WZskntZphkXH7aj+2bM2IfsIZ
Zl38IY2wUXqfI5QLDy9Fp87Zyido1pYUoE0IrFNIhiA11mlJM+dvLEaR9jWcqxmS
Q2yRBp0betmv029Z4PvUvOhW4Jqtal1YvgS/PLbRnVpbt/rMzxHnmzT4XdBRgeCo
Ypcqct5oRcVRaDyfuKN8IelLzFwQSq2bbsqQTkpgZnSId/Bnp8fZkpRlddhmNcA=
=3W7q
-----END PGP SIGNATURE-----

--m+jEI8cDoTn6Mu9E--
