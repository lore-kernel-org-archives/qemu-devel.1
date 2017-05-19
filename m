Received: from eggs.gnu.org ([2001:4830:134:3::10]:44705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dBolF-00087y-RH
	for qemu-devel@nongnu.org; Fri, 19 May 2017 16:44:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dBolB-0002n0-VJ
	for qemu-devel@nongnu.org; Fri, 19 May 2017 16:44:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48958)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dBolB-0002mw-Os
	for qemu-devel@nongnu.org; Fri, 19 May 2017 16:44:29 -0400
Date: Fri, 19 May 2017 23:44:27 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170519234246-mutt-send-email-mst@kernel.org>
References: <1494578148-102868-1-git-send-email-wei.w.wang@intel.com>
	<a3f2cae3-5d3d-f620-4a8d-bb11470c0b08@redhat.com>
	<591AA65F.8080608@intel.com>
	<d6eb1d73-c791-b8d3-7ef3-a7653aef00d6@redhat.com>
	<7e1b48d5-83e6-a0ae-5d91-696d8db09d7c@redhat.com>
	<591D0EF5.9000807@intel.com>
	<d7df5484-7e08-4e1c-9e35-69d73858c736@redhat.com>
	<591EB435.4080109@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <591EB435.4080109@intel.com>
Subject: Re: [Qemu-devel] [virtio-dev] Re: [virtio-dev] Re: [PATCH v2 00/16]
 Vhost-pci for inter-VM communication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: Jason Wang <jasowang@redhat.com>, stefanha@gmail.com, marcandre.lureau@gmail.com, pbonzini@redhat.com, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org

On Fri, May 19, 2017 at 05:00:37PM +0800, Wei Wang wrote:
> > > 
> > > That being said, we compared to vhost-user, instead of vhost_net,
> > > because vhost-user is the one
> > > that is used in NFV, which we think is a major use case for vhost-pci.
> > 
> > If this is true, why not draft a pmd driver instead of a kernel one?
> 
> Yes, that's right. There are actually two directions of the vhost-pci driver
> implementation - kernel driver
> and dpdk pmd. The QEMU side device patches are first posted out for
> discussion, because when the device
> part is ready, we will be able to have the related team work on the pmd
> driver as well. As usual, the pmd
> driver would give a much better throughput.

For PMD to work though, the protocol will need to support vIOMMU.
Not asking you to add it right now since it's work in progress
for vhost user at this point, but something you will have to
keep in mind. Further, reviewing vhost user iommu patches might be
a good idea for you.

-- 
MST
