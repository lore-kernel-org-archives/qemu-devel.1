Received: from eggs.gnu.org ([2001:4830:134:3::10]:33537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fQ6ZL-0000Mt-AT
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 03:39:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fQ6ZJ-0003by-NU
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 03:39:51 -0400
Date: Tue, 5 Jun 2018 15:39:37 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180605073937.GD9216@xz-mi>
References: <20180604152941.20374-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180604152941.20374-1-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v2 00/13] iommu: support txattrs,
 support TCG execution, implement TZ MPC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Eric Auger <eric.auger@redhat.com>

On Mon, Jun 04, 2018 at 04:29:28PM +0100, Peter Maydell wrote:
> Hi; this is v2 of my iommu patchset, which does:
>  * support IOMMUs that are aware of memory transaction attributes and
>    may generate different translations for different attributes
>  * support TCG execution out of memory which is behind an IOMMU
>  * implement the Arm TrustZone Memory Protection Controller
>    (which needs both the above features in the IOMMU core code)
>  * use the MPC in the mps2-an505 board
> 
> Patches 1-3 add the support for memory-transaction-aware
> IOMMUs. The general approach is that we have the concept of an
> IOMMU index (similar to the TCG MMU index), which selects which of
> multiple possible translation tables in the IOMMU we're trying to use.
> Most IOMMUs will support just a single index. When you register an
> IOMMU notifier and when you call the translate method you have to
> specify which IOMMU index you want. There's a method for getting the
> index that applies for a particular set of transaction attributes.
> All the current IOMMU implementations have just one iommu index, and
> all the current users of the notify API assume that.

Hi, Peter,

It seems that this series is still using the IOMMU index way.  In case
I missed anything... Could you elaborate a bit on why this IOMMU index
solution is preferred comparing to the way to pass in MemTxAttrs?  Or
was there any further discussion I missed on the topic?

My last post to previous series is here:

https://lists.gnu.org/archive/html/qemu-devel/2018-05/msg05702.html

In that, I was still confused on why we couldn't use the existing
MemTxAttrs directly instead of the new IOMMU index (and I explained on
why that was prefered at least to me). I didn't see replies
afterwards.

Frankly speaking I fully trust the expertise of you and all the
reviewers.  I am just afraid I missed any context along the way.

Thanks,

-- 
Peter Xu
