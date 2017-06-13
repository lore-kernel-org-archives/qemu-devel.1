Received: from eggs.gnu.org ([2001:4830:134:3::10]:48694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dKqyF-0008UI-UD
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 14:55:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dKqyD-0006Xj-V3
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 14:55:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dKqyD-0006XB-PJ
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 14:55:17 -0400
Date: Tue, 13 Jun 2017 21:55:05 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170613215454-mutt-send-email-mst@kernel.org>
References: <1497004901-30593-1-git-send-email-wei.w.wang@intel.com>
	<1497004901-30593-4-git-send-email-wei.w.wang@intel.com>
	<20170613200049-mutt-send-email-mst@kernel.org>
	<fb67359c-3d19-f67f-ec47-3cf868b8d9e8@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb67359c-3d19-f67f-ec47-3cf868b8d9e8@intel.com>
Subject: Re: [Qemu-devel] [PATCH v11 3/6] virtio-balloon:
 VIRTIO_BALLOON_F_PAGE_CHUNKS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Wei Wang <wei.w.wang@intel.com>, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, david@redhat.com, cornelia.huck@de.ibm.com, akpm@linux-foundation.org, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, Matthew Wilcox <willy@infradead.org>

On Tue, Jun 13, 2017 at 10:59:07AM -0700, Dave Hansen wrote:
> On 06/13/2017 10:56 AM, Michael S. Tsirkin wrote:
> >> +/* The size of one page_bmap used to record inflated/deflated pages. */
> >> +#define VIRTIO_BALLOON_PAGE_BMAP_SIZE	(8 * PAGE_SIZE)
> > At this size, you probably want alloc_pages to avoid kmalloc
> > overhead.
> 
> For slub, at least, kmalloc() just calls alloc_pages() basically
> directly.  There's virtually no overhead.
> 
> 

OK then.

-- 
MST
