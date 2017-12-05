Received: from eggs.gnu.org ([2001:4830:134:3::10]:55920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eMEze-0002dJ-Ug
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 10:19:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eMEz2-0002uW-Bh
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 10:18:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:6962)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eMEz2-0002tl-2i
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 10:18:08 -0500
Date: Tue, 5 Dec 2017 17:17:34 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171205171420-mutt-send-email-mst@kernel.org>
References: <1512444796-30615-1-git-send-email-wei.w.wang@intel.com>
	<1512444796-30615-3-git-send-email-wei.w.wang@intel.com>
	<20171205145950.GF31150@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171205145950.GF31150@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [virtio-dev] [PATCH v3 2/7] vhost-pci-net: add
 vhost-pci-net
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Wei Wang <wei.w.wang@intel.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, marcandre.lureau@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, jan.kiszka@siemens.com, avi.cohen@huawei.com, zhiyong.yang@intel.com

On Tue, Dec 05, 2017 at 02:59:50PM +0000, Stefan Hajnoczi wrote:
> On Tue, Dec 05, 2017 at 11:33:11AM +0800, Wei Wang wrote:
> > Add the vhost-pci-net device emulation. The device uses bar 2 to expose
> > the remote VM's memory to the guest. The first 4KB of the the bar area
> > stores the metadata which describes the remote memory and vring info.
> 
> This device looks like the beginning of a new "vhost-pci" virtio device
> type.  There are layering violations:
> 
> 1. This has nothing to do with virtio-net or networking, it's purely
>    vhost-pci.  Why is it called vhost-pci-net instead of vhost-pci?
> 
> 2. VirtIODevice does not know about PCI.  It should work over virtio-ccw
>    or virtio-mmio.  This patch talks about BARs inside a VirtIODevice so
>    there is a problem here.
> 
> I'm concerned that there is no clear architecture and elements of the
> virtio architecture are being mixed up with no justification.
> 
> Can you explain what you're trying to do?

A specification was posted here:
https://lists.oasis-open.org/archives/virtio-comment/201606/msg00009.html

I gather there have been some changes since.

> Please post a specification for the vhost-pci device so the operation of
> the device can be discussed and is clear to reviewers.

I'm not sure a full respin of the spec is strictly required at this
point.  A list of differences with last spec posted would be
appreciated.

-- 
MST
