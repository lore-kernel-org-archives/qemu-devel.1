Received: from eggs.gnu.org ([2001:4830:134:3::10]:41990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSXZh-0002Px-A2
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 19:49:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSXZc-0006xg-Ez
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 19:49:45 -0400
Date: Wed, 5 Jul 2017 07:49:32 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170704234932.GB29382@lemon.lan>
References: <1499170866-9068-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1499170866-9068-1-git-send-email-jasowang@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] virtio-scsi: finalize IOMMU support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org

On Tue, 07/04 20:21, Jason Wang wrote:
> After converting to use DMA api for virtio devices, we should use
> dma_as instead of address_space_memory. Otherwise it won't work if
> IOMMU is enabled.
> 
> Fixes: commit 8607f5c3072c ("virtio: convert to use DMA api")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Reviewed-by: Fam Zheng <famz@redhat.com>
