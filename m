Received: from eggs.gnu.org ([2001:4830:134:3::10]:42702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <willy@infradead.org>) id 1cylbH-0008NZ-UN
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 16:44:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <willy@infradead.org>) id 1cylbE-0003QZ-1o
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 16:44:20 -0400
Received: from bombadil.infradead.org ([65.50.211.133]:60157)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <willy@infradead.org>) id 1cylbD-0003Pi-Qj
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 16:44:15 -0400
Date: Thu, 13 Apr 2017 13:44:11 -0700
From: Matthew Wilcox <willy@infradead.org>
Message-ID: <20170413204411.GJ784@bombadil.infradead.org>
References: <1492076108-117229-1-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1492076108-117229-1-git-send-email-wei.w.wang@intel.com>
Subject: Re: [Qemu-devel] [PATCH v9 0/5] Extend virtio-balloon for fast
 (de)inflating & fast live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, david@redhat.com, dave.hansen@intel.com, cornelia.huck@de.ibm.com, akpm@linux-foundation.org, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com

On Thu, Apr 13, 2017 at 05:35:03PM +0800, Wei Wang wrote:
> 2) transfer the guest unused pages to the host so that they
> can be skipped to migrate in live migration.

I don't understand this second bit.  You leave the pages on the free list,
and tell the host they're free.  What's preventing somebody else from
allocating them and using them for something?  Is the guest semi-frozen
at this point with just enough of it running to ask the balloon driver
to do things?
