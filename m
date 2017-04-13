Received: from eggs.gnu.org ([2001:4830:134:3::10]:47416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <willy@infradead.org>) id 1cyiAO-00026Z-PH
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 13:04:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <willy@infradead.org>) id 1cyiAJ-0005L1-46
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 13:04:20 -0400
Received: from bombadil.infradead.org ([65.50.211.133]:49812)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <willy@infradead.org>) id 1cyiAI-00059s-VJ
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 13:04:15 -0400
Date: Thu, 13 Apr 2017 10:03:46 -0700
From: Matthew Wilcox <willy@infradead.org>
Message-ID: <20170413170346.GI784@bombadil.infradead.org>
References: <1492076108-117229-1-git-send-email-wei.w.wang@intel.com>
	<1492076108-117229-3-git-send-email-wei.w.wang@intel.com>
	<20170413184040-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170413184040-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH v9 2/5] virtio-balloon:
 VIRTIO_BALLOON_F_BALLOON_CHUNKS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Wei Wang <wei.w.wang@intel.com>, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, david@redhat.com, dave.hansen@intel.com, cornelia.huck@de.ibm.com, akpm@linux-foundation.org, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com

On Thu, Apr 13, 2017 at 07:34:19PM +0300, Michael S. Tsirkin wrote:
> So we don't need the bitmap to talk to host, it is just
> a data structure we chose to maintain lists of pages, right?
> OK as far as it goes but you need much better isolation for it.
> Build a data structure with APIs such as _init, _cleanup, _add, _clear,
> _find_first, _find_next.
> Completely unrelated to pages, it just maintains bits.
> Then use it here.

That sounds an awful lot like the xbitmap I wrote a few months ago ...

http://git.infradead.org/users/willy/linux-dax.git/commit/727e401bee5ad7d37e0077291d90cc17475c6392
