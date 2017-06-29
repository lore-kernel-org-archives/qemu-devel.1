Received: from eggs.gnu.org ([2001:4830:134:3::10]:47644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dQVGn-0002C6-1D
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 04:57:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dQVGm-0003Gr-8n
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 04:57:49 -0400
Date: Thu, 29 Jun 2017 16:57:36 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170629085729.GB28654@lemon.lan>
References: <20170628184724.21378-1-stefanha@redhat.com>
	<20170628184724.21378-7-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170628184724.21378-7-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 6/6] virtio-pci: use ioeventfd even when
 KVM is disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

On Wed, 06/28 19:47, Stefan Hajnoczi wrote:
> Old kvm.ko versions only supported a tiny number of ioeventfds so
> virtio-pci avoids ioeventfds when kvm_has_many_ioeventfds() returns 0.
> 
> Do not check kvm_has_many_ioeventfds() when KVM is disabled since it
> always returns 0.  Since commit 8c56c1a592b5092d91da8d8943c17777d6462a6f
> ("memory: emulate ioeventfd") it has been possible to use ioeventfds in
> qtest or TCG mode.
> 
> This patch makes -device virtio-blk-pci,iothread=iothread0 work even
> when KVM is disabled.
> 
> I have tested that virtio-blk-pci works under TCG both with and without
> iothread.
> 
> This patch fixes qemu-iotests 068, which was accidentally merged early
> despite the dependency on ioeventfd.
> 
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Message-id: 20170615163813.7255-2-stefanha@redhat.com
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Fam Zheng <famz@redhat.com>
