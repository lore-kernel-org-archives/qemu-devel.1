Received: from eggs.gnu.org ([2001:4830:134:3::10]:58829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <willy@infradead.org>) id 1cyrRS-0006AB-Aq
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 22:58:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <willy@infradead.org>) id 1cyrRO-00056e-E6
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 22:58:34 -0400
Received: from bombadil.infradead.org ([65.50.211.133]:50249)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <willy@infradead.org>) id 1cyrRO-00056Y-5V
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 22:58:30 -0400
Date: Thu, 13 Apr 2017 19:58:24 -0700
From: Matthew Wilcox <willy@infradead.org>
Message-ID: <20170414025824.GK784@bombadil.infradead.org>
References: <1492076108-117229-1-git-send-email-wei.w.wang@intel.com>
	<1492076108-117229-4-git-send-email-wei.w.wang@intel.com>
	<20170413130217.2316b0394192d8677f5ddbdf@linux-foundation.org>
	<58F03443.9040202@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58F03443.9040202@intel.com>
Subject: Re: [Qemu-devel] [PATCH v9 3/5] mm: function to offer a page block
 on the free list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, david@redhat.com, dave.hansen@intel.com, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com

On Fri, Apr 14, 2017 at 10:30:27AM +0800, Wei Wang wrote:
> OK. What do you think if we add this:
> 
> #if defined(CONFIG_VIRTIO_BALLOON) || defined(CONFIG_VIRTIO_BALLOON_MODULE)

That's spelled "IS_ENABLED(CONFIG_VIRTIO_BALLOON)", FYI.
