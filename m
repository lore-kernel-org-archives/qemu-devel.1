Received: from eggs.gnu.org ([2001:4830:134:3::10]:55467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gZG31-0000dy-Ol
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:08:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gZG2y-0002G6-Li
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:08:35 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:45969)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gZG2y-0002EX-Af
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:08:32 -0500
Received: by mail-wr1-x443.google.com with SMTP id t6so15861815wrr.12
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 06:08:31 -0800 (PST)
Date: Tue, 18 Dec 2018 13:12:41 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20181218131241.GC30223@stefanha-x1.localdomain>
References: <20181213210057.3676-1-quintela@redhat.com>
	<20181213210057.3676-12-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R+My9LyyhiUvIEro"
Content-Disposition: inline
In-Reply-To: <20181213210057.3676-12-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 11/16] virtio: split virtio blk bits rom
 virtio-pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Gonglei <arei.gonglei@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>


--R+My9LyyhiUvIEro
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 13, 2018 at 10:00:52PM +0100, Juan Quintela wrote:
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Laurent Vivier <lvivier@redhat.com>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  hw/virtio/Makefile.objs    |  1 +
>  hw/virtio/virtio-blk-pci.c | 97 ++++++++++++++++++++++++++++++++++++++
>  hw/virtio/virtio-pci.c     | 59 -----------------------
>  hw/virtio/virtio-pci.h     | 14 ------
>  tests/Makefile.include     |  4 +-
>  5 files changed, 100 insertions(+), 75 deletions(-)
>  create mode 100644 hw/virtio/virtio-blk-pci.c

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--R+My9LyyhiUvIEro
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcGPJJAAoJEJykq7OBq3PI+UMH/11t0BUoUX75ZINMn0xPFn0q
4fjiA5lC8ONqSc8o0+fV3wXE3bOEk5yb6RZu9RC0qx1N5ZGXWpHMp5BC7RzGQNUz
ArvGi+w0V4oQqn4oQPVYM3rPgRfh95qj4v/Vnq5Oh6U9xHMkhriqZDCTE1dkHYXF
qtdoD6PgeHx4K8Tm9oQ7ywJCRgR79Ddf1gL8Sc5PZ6j3Prr3V+mxHGeB1NZybfmT
G1MEINh9Khkbkp2ByKZ5jam1qXcLRurer6BIMiZMJE62M3ueNpb7eDHzg0xTcnRW
86+tBZoq4MIEcVjyze4OgGF0KpeSgPD99cFIL6IeINhcK1PAAI4JbsKBggbHKCQ=
=IwqP
-----END PGP SIGNATURE-----

--R+My9LyyhiUvIEro--
