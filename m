Received: from eggs.gnu.org ([2001:4830:134:3::10]:50227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gF6GU-0002Nm-5P
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 19:39:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gF6GQ-000529-Ow
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 19:39:10 -0400
Received: from [185.30.24.106] (port=12318
	helo=hotspot.internet-for-guests.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gF6GP-0004rA-Jw
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 19:39:06 -0400
Date: Tue, 23 Oct 2018 19:39:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181023193613-mutt-send-email-mst@kernel.org>
References: <1516003315-17878-1-git-send-email-changpeng.liu@intel.com>
	<1516003315-17878-2-git-send-email-changpeng.liu@intel.com>
	<7711f157-5863-fc75-0730-a631362ffd06@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7711f157-5863-fc75-0730-a631362ffd06@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Changpeng Liu <changpeng.liu@intel.com>, qemu-devel@nongnu.org, james.r.harris@intel.com, keith.busch@intel.com, famz@redhat.com, stefanha@gmail.com, stefanha@redhat.com

On Tue, Jan 16, 2018 at 06:06:56PM +0100, Paolo Bonzini wrote:
> Second, virtio-based vhost-user remains QEMU's preferred method for
> high-performance I/O in guests.  Discard support is missing and that is
> important for SSDs; that should be fixed in the virtio spec.

BTW could you reply on the thread of the patch
	virtio_blk: add discard and write zeroes support

Christoph Hellwig thinks we should change the spec and defer
implementation until we do. What's your take on this?


-- 
MST
