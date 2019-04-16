Received: from eggs.gnu.org ([209.51.188.92]:47269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hGQW6-0001uB-5n
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 12:01:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hGQW5-0001TH-5s
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 12:01:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1hGQW1-0001NL-Gt
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 12:00:59 -0400
Date: Tue, 16 Apr 2019 17:00:43 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190416160043.GA11895@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
Subject: [Qemu-devel] [ANNOUNCE] virtio-fs v0.2 host<->guest file system
 released
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kvm@vger.kernel.org, qemu-devel@nongnu.org, libvir-list@redhat.com
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Miklos Szeredi <mszeredi@redhat.com>


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Dear QEMU, KVM, and libvirt communities,
virtio-fs is a shared file system that lets virtual machines access a
directory tree on the host.  Unlike existing approaches, it is designed
to offer local file system semantics and performance.  The guest can
take advantage of Linux DAX to access file contents directly from the
host page cache, eliminating the need to copy data into guest memory.

We hope virtio-fs will become widely available and easily accessible
through libvirt, Kata Containers, and popular management tools.

For more information, visit https://virtio-fs.gitlab.io/.
Mailing list: https://www.redhat.com/mailman/listinfo/virtio-fs
IRC: #virtio-fs on chat.freenode.net

The v0.2 release incorporates stabilization, performance, and sandboxing
improvements that now make virtio-fs suitable for testing and
performance evaluation.

Please do not rely on virtio-fs for production data yet.  Consider it
experimental.

Guides are available for:
 * Manually running QEMU with virtio-fs
   https://virtio-fs.gitlab.io/howto-qemu.html
 * Booting from virtio-fs (no disk images!)
   https://virtio-fs.gitlab.io/howto-boot.html
 * Running Kata Containers with virtio-fs
   https://virtio-fs.gitlab.io/howto-kata.html

Stefan

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJctfwrAAoJEJykq7OBq3PI9u4H/0HZ7lKuuCVJuBizuc4t8xeY
fdGJz7r1Q4A2ZTl6ajKeTCaKKJfIuyoxjj2rdgeORxU9D6F/LXYoKQdAWep8SToj
xxK5Cai7FVvn+e6/8TkhtNnOd5HEKUjSobNv8EtS0vVZSgXXzREFERSi7rmx8vK+
+eT/2+HVA0JsdCLfdA+zllcBjy7igWoid77D+vS5d0OIcl4L3DlJ30eLMgP+vnLG
nYn0F14IbVPMYmYiFgefI4uYSjVxiAlsrX25sDDp01Roh6OtRdJJi0SrjOrFXhaP
5f2O98XTtK/ehyK5Xtk98DqWAZdN+ewjYDYbUYIR1DR1mpUO8VzrcjuZ8jH+q/Y=
=HvHJ
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
