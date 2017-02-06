Received: from eggs.gnu.org ([2001:4830:134:3::10]:46149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cakJG-0006Uw-O1
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 09:30:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cakJD-0007Wq-Gv
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 09:30:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:6229)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cakJD-0007Wb-BN
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 09:30:23 -0500
Message-ID: <1486391420.32329.26.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 06 Feb 2017 15:30:20 +0100
In-Reply-To: <5884626f.5b2f6b0a.1bfff.3037@mx.google.com>
References: <5884626f.5b2f6b0a.1bfff.3037@mx.google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] virtio-gpu: fix memory leak in set scanout
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org, Li Qiang <liqiang6-s@360.cn>

On Sa, 2017-01-21 at 23:42 -0800, Li Qiang wrote:
> From: Li Qiang <liqiang6-s@360.cn>
>=20
> In virtio_gpu_set_scanout function, when creating the 'rect'
> its refcount is set to 2, by pixman_image_create_bits and
> qemu_create_displaysurface_pixman function. This can lead=20
> a memory leak issues. This patch avoid this issue.
>=20
> Signed-off-by: Li Qiang <liqiang6-s@360.cn>

Added to vga patch queue.

thanks,
  Gerd
