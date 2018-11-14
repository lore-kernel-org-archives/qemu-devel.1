Received: from eggs.gnu.org ([2001:4830:134:3::10]:57335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yu.c.zhang@linux.intel.com>) id 1gMp0o-0005NN-Lo
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 01:50:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yu.c.zhang@linux.intel.com>) id 1gMp0l-0005fF-Bf
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 01:50:54 -0500
Received: from mga03.intel.com ([134.134.136.65]:20557)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yu.c.zhang@linux.intel.com>)
	id 1gMp0j-0005d8-Kt
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 01:50:51 -0500
Date: Wed, 14 Nov 2018 14:48:33 +0800
From: Yu Zhang <yu.c.zhang@linux.intel.com>
Message-ID: <20181114064833.wpx6rwfi4fnfmfb4@linux.intel.com>
References: <1542175484-2742-1-git-send-email-yu.c.zhang@linux.intel.com>
	<1542175484-2742-4-git-send-email-yu.c.zhang@linux.intel.com>
	<20181114064115.GF6846@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181114064115.GF6846@xz-x1>
Subject: Re: [Qemu-devel] [PATCH v2 3/3] intel-iommu: extend iotlb search
 logic to cover 57-bit IOVA.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

On Wed, Nov 14, 2018 at 02:41:15PM +0800, Peter Xu wrote:
> On Wed, Nov 14, 2018 at 02:04:44PM +0800, Yu Zhang wrote:
> > The 64-bit key used by vtd_lookup_iotlb() to search the cached
> > mappings is formed by combining the GFN, source id and the page
> > level. To cover 57-bit IOVA, the shift of source id and of page
> > level need to be enlarged by 9 - the stride of one paging structure
> > level.
> > 
> > Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> 
> But note that we should have this patch either squashed into previous
> patch, or at least it should appear earlier than patch 2 since
> otherwise patch 2 could possibly break.  I would prefer squashing
> since it's really part of patch 2, and please feel free to pick my r-b
> if you want to resent with a squashed version in the future.
> 

Got it. Thanks, Peter. Will send the squashed patch right after the release. :)

> Regards,
> 
> -- 
> Peter Xu

B.R.
Yu
