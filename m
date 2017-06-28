Received: from eggs.gnu.org ([2001:4830:134:3::10]:57739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <willy@infradead.org>) id 1dQEWy-0006vf-7k
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 11:05:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <willy@infradead.org>) id 1dQEWu-0001XL-3m
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 11:05:24 -0400
Received: from bombadil.infradead.org ([65.50.211.133]:55194)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <willy@infradead.org>) id 1dQEWt-0001K9-S0
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 11:05:20 -0400
Date: Wed, 28 Jun 2017 08:04:50 -0700
From: Matthew Wilcox <willy@infradead.org>
Message-ID: <20170628150450.GA1402@bombadil.infradead.org>
References: <1497004901-30593-1-git-send-email-wei.w.wang@intel.com>
	<1497004901-30593-4-git-send-email-wei.w.wang@intel.com>
	<20170613200049-mutt-send-email-mst@kernel.org>
	<594240E9.2070705@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <594240E9.2070705@intel.com>
Subject: Re: [Qemu-devel] [virtio-dev] Re: [PATCH v11 3/6] virtio-balloon:
 VIRTIO_BALLOON_F_PAGE_CHUNKS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, david@redhat.com, dave.hansen@intel.com, cornelia.huck@de.ibm.com, akpm@linux-foundation.org, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com

On Thu, Jun 15, 2017 at 04:10:17PM +0800, Wei Wang wrote:
> > So you still have a home-grown bitmap. I'd like to know why
> > isn't xbitmap suggested for this purpose by Matthew Wilcox
> > appropriate. Please add a comment explaining the requirements
> > from the data structure.
> 
> I didn't find his xbitmap being upstreamed, did you?

It doesn't have any users in the tree yet.  Can't add code with new users.
You should be the first!
