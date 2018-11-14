Received: from eggs.gnu.org ([2001:4830:134:3::10]:54803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gMonE-0002cy-1S
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 01:36:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gMonA-0007vp-Uu
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 01:36:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:23437)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gMonA-0007vM-Pn
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 01:36:48 -0500
Date: Wed, 14 Nov 2018 14:36:40 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20181114063640.GE6846@xz-x1>
References: <1542175484-2742-1-git-send-email-yu.c.zhang@linux.intel.com>
	<1542175484-2742-3-git-send-email-yu.c.zhang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1542175484-2742-3-git-send-email-yu.c.zhang@linux.intel.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/3] intel-iommu: extend VTD emulation
 to allow 57-bit IOVA address width.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yu Zhang <yu.c.zhang@linux.intel.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

On Wed, Nov 14, 2018 at 02:04:43PM +0800, Yu Zhang wrote:
> A 5-level paging capable VM may choose to use 57-bit IOVA address width.
> E.g. guest applications may prefer to use its VA as IOVA when performing
> VFIO map/unmap operations, to avoid the burden of managing the IOVA space.
> 
> This patch extends the current vIOMMU logic to cover the extended address
> width. When creating a VM with 5-level paging feature, one can choose to
> create a virtual VTD with 5-level paging capability, with configurations
> like "-device intel-iommu,x-aw-bits=57".
> 
> Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
