Received: from eggs.gnu.org ([2001:4830:134:3::10]:44136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <willy@infradead.org>) id 1ePuxW-0007HI-VD
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:43:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <willy@infradead.org>) id 1ePuxT-0000lA-Mt
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:43:46 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:47775)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <willy@infradead.org>) id 1ePuxS-0000W0-TQ
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:43:43 -0500
Date: Fri, 15 Dec 2017 10:42:56 -0800
From: Matthew Wilcox <willy@infradead.org>
Message-ID: <20171215184256.GA27160@bombadil.infradead.org>
References: <1513079759-14169-1-git-send-email-wei.w.wang@intel.com>
	<1513079759-14169-4-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1513079759-14169-4-git-send-email-wei.w.wang@intel.com>
Subject: Re: [Qemu-devel] [PATCH v19 3/7] xbitmap: add more operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com, david@redhat.com, penguin-kernel@I-love.SAKURA.ne.jp, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu@aliyun.com, nilal@redhat.com, riel@redhat.com

On Tue, Dec 12, 2017 at 07:55:55PM +0800, Wei Wang wrote:
> +int xb_preload_and_set_bit(struct xb *xb, unsigned long bit, gfp_t gfp);

I'm struggling to understand when one would use this.  The xb_ API
requires you to handle your own locking.  But specifying GFP flags
here implies you can sleep.  So ... um ... there's no locking?

> +void xb_clear_bit_range(struct xb *xb, unsigned long start, unsigned long end);

That's xb_zero() which you deleted with the previous patch ... remember,
keep things as close as possible to the bitmap API.
