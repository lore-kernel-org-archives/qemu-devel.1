Received: from eggs.gnu.org ([2001:4830:134:3::10]:49569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1gFEaA-0007ZX-Ci
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 04:32:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1gFESE-00055S-8C
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 04:23:53 -0400
Received: from mga09.intel.com ([134.134.136.24]:24804)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <changpeng.liu@intel.com>)
	id 1gFESD-00052s-M3
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 04:23:50 -0400
From: "Liu, Changpeng" <changpeng.liu@intel.com>
Date: Wed, 24 Oct 2018 08:23:40 +0000
Message-ID: <FF7FC980937D6342B9D289F5F3C7C2625B768443@SHSMSX103.ccr.corp.intel.com>
References: <1516003315-17878-1-git-send-email-changpeng.liu@intel.com>
	<1516003315-17878-2-git-send-email-changpeng.liu@intel.com>
	<7711f157-5863-fc75-0730-a631362ffd06@redhat.com>
	<20181023193613-mutt-send-email-mst@kernel.org>
In-Reply-To: <20181023193613-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [RFC v1] block/NVMe: introduce a new vhost NVMe
 host device to QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Harris, James R" <james.r.harris@intel.com>, "Busch, Keith" <keith.busch@intel.com>, "famz@redhat.com" <famz@redhat.com>, "stefanha@gmail.com" <stefanha@gmail.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "hch@infradead.org" <hch@infradead.org>, Daniel Verkamp <dverkamp@chromium.org>

The latest thread for supporting DISCARD and WRITE ZEROES feature for virti=
o-blk is here:

virtio_blk: add discard and write zeroes support
https://lists.linuxfoundation.org/pipermail/virtualization/2018-October/039=
534.html

I don't take further more steps about it, please go ahead and make the spec=
ification more clear, thanks.


> -----Original Message-----
> From: Michael S. Tsirkin [mailto:mst@redhat.com]
> Sent: Wednesday, October 24, 2018 1:39 AM
> To: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Liu, Changpeng <changpeng.liu@intel.com>; qemu-devel@nongnu.org; Harr=
is,
> James R <james.r.harris@intel.com>; Busch, Keith <keith.busch@intel.com>;
> famz@redhat.com; stefanha@gmail.com; stefanha@redhat.com
> Subject: Re: [RFC v1] block/NVMe: introduce a new vhost NVMe host device =
to
> QEMU
>=20
> On Tue, Jan 16, 2018 at 06:06:56PM +0100, Paolo Bonzini wrote:
> > Second, virtio-based vhost-user remains QEMU's preferred method for
> > high-performance I/O in guests.  Discard support is missing and that is
> > important for SSDs; that should be fixed in the virtio spec.
>=20
> BTW could you reply on the thread of the patch
> 	virtio_blk: add discard and write zeroes support
>=20
> Christoph Hellwig thinks we should change the spec and defer
> implementation until we do. What's your take on this?
>=20
>=20
> --
> MST
