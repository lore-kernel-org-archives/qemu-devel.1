Received: from eggs.gnu.org ([2001:4830:134:3::10]:34524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <willy@infradead.org>) id 1eBklB-0006eR-Fj
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 12:00:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <willy@infradead.org>) id 1eBkl7-0004Vz-KN
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 12:00:29 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:59598)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <willy@infradead.org>) id 1eBkl7-0004L0-97
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 12:00:25 -0500
Date: Mon, 6 Nov 2017 09:00:00 -0800
From: Matthew Wilcox <willy@infradead.org>
Message-ID: <20171106170000.GA1195@bombadil.infradead.org>
References: <1509696786-1597-1-git-send-email-wei.w.wang@intel.com>
	<1509696786-1597-3-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1509696786-1597-3-git-send-email-wei.w.wang@intel.com>
Subject: Re: [Qemu-devel] [PATCH v17 2/6] radix tree test suite: add tests
 for xbitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com, david@redhat.com, penguin-kernel@I-love.SAKURA.ne.jp, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu@aliyun.com

On Fri, Nov 03, 2017 at 04:13:02PM +0800, Wei Wang wrote:
> From: Matthew Wilcox <mawilcox@microsoft.com>
> 
> Add the following tests for xbitmap:
> 1) single bit test: single bit set/clear/find;
> 2) bit range test: set/clear a range of bits and find a 0 or 1 bit in
> the range.
> 
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> Cc: Matthew Wilcox <mawilcox@microsoft.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> ---
>  tools/include/linux/bitmap.h            |  34 ++++
>  tools/include/linux/kernel.h            |   2 +
>  tools/testing/radix-tree/Makefile       |   7 +-
>  tools/testing/radix-tree/linux/kernel.h |   2 -
>  tools/testing/radix-tree/main.c         |   5 +
>  tools/testing/radix-tree/test.h         |   1 +
>  tools/testing/radix-tree/xbitmap.c      | 278 ++++++++++++++++++++++++++++++++

Umm.  No.  You've duplicated xbitmap.c into the test framework, so now it can
slowly get out of sync with the one in lib/.  That's not OK.

Put it back the way it was, with the patch I gave you as patch 1/n
(relocating xbitmap.c from tools/testing/radix-tree to lib/).
Then add your enhancements as patch 2/n.  All you should need to
change in your 1/n from
http://git.infradead.org/users/willy/linux-dax.git/commit/727e401bee5ad7d37e0077291d90cc17475c6392
is a bit of Makefile tooling.  Leave the test suite embedded in the file;
that way people might remember to update the test suite when adding
new functionality.
