Received: from eggs.gnu.org ([2001:4830:134:3::10]:46039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eOOX5-00039d-VR
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:54:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eOOX2-0004QR-2o
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:54:12 -0500
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:44893)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eOOX1-0004Q0-SE
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:54:08 -0500
Received: by mail-wm0-x22a.google.com with SMTP id t8so14579211wmc.3
	for <qemu-devel@nongnu.org>; Mon, 11 Dec 2017 05:54:07 -0800 (PST)
Date: Mon, 11 Dec 2017 13:54:05 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171211135405.GB5962@stefanha-x1.localdomain>
References: <1512455239-8296-1-git-send-email-changpeng.liu@intel.com>
	<1512455239-8296-3-git-send-email-changpeng.liu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wq9mPyueHGvFACwf"
Content-Disposition: inline
In-Reply-To: <1512455239-8296-3-git-send-email-changpeng.liu@intel.com>
Subject: Re: [Qemu-devel] [PATCH v6 2/4] vhost-user-blk: introduce a new
 vhost-user-blk host device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Changpeng Liu <changpeng.liu@intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mst@redhat.com, marcandre.lureau@redhat.com, felipe@nutanix.com, james.r.harris@intel.com


--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2017 at 02:27:17PM +0800, Changpeng Liu wrote:
> This commit introduces a new vhost-user device for block, it uses a
> chardev to connect with the backend, same with Qemu virito-blk device,
> Guest OS still uses the virtio-blk frontend driver.
>=20
> To use it, start QEMU with command line like this:
>=20
> qemu-system-x86_64 \
>     -chardev socket,id=3Dchar0,path=3D/path/vhost.socket \
>     -device vhost-user-blk-pci,chardev=3Dchar0,num-queues=3D2, \
>             bootindex=3D2... \
>=20
> Users can use different parameters for `num-queues` and `bootindex`.
>=20
> Different with exist Qemu virtio-blk host device, it makes more easy
> for users to implement their own I/O processing logic, such as all
> user space I/O stack against hardware block device. It uses the new
> vhost messages(VHOST_USER_GET_CONFIG) to get block virtio config
> information from backend process.
>=20
> Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
> ---
>  default-configs/pci.mak            |   1 +
>  hw/block/Makefile.objs             |   3 +
>  hw/block/vhost-user-blk.c          | 357 +++++++++++++++++++++++++++++++=
++++++
>  hw/virtio/virtio-pci.c             |  55 ++++++
>  hw/virtio/virtio-pci.h             |  18 ++
>  include/hw/virtio/vhost-user-blk.h |  41 +++++
>  6 files changed, 475 insertions(+)
>  create mode 100644 hw/block/vhost-user-blk.c
>  create mode 100644 include/hw/virtio/vhost-user-blk.h

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaLo39AAoJEJykq7OBq3PIe+cH/36vndZrHP03DBwjCjuYniZE
Jmij0cSlfkBbcn9Amv/7t/qr4OmSW4Yia9+h+0LsacVLDYuP6mlpr2zQA9mLM3Il
h347GgG5Yu1IKsCl1f9XDaPYZ2zMZ4wS5t1kAHlEgLImH6S7V3n0OsGB7BDBU3mv
ZJvRm5rBiBM1NMUfBt0UYDroAD3xyApWhTi94617nbosTeEgDTZEyGixdhoXAOFh
0WNgNfvNtSvgoEw6gRo+89uvv1fVZQI7f2nlUetAtC/79XAtsBtRrxzfG9vFz0tf
6Ya4fBchosnQv6KbTy2KcaqS8lRcvbnB3QbTpMAhfsw110BwV1AneJVzyooLbUE=
=7DzT
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--
