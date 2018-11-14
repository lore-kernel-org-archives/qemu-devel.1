Received: from eggs.gnu.org ([2001:4830:134:3::10]:55519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gMorh-0003m8-UU
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 01:41:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gMore-00027O-Cw
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 01:41:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39298)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gMore-00027B-7N
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 01:41:26 -0500
Date: Wed, 14 Nov 2018 14:41:15 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20181114064115.GF6846@xz-x1>
References: <1542175484-2742-1-git-send-email-yu.c.zhang@linux.intel.com>
	<1542175484-2742-4-git-send-email-yu.c.zhang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1542175484-2742-4-git-send-email-yu.c.zhang@linux.intel.com>
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
To: Yu Zhang <yu.c.zhang@linux.intel.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

On Wed, Nov 14, 2018 at 02:04:44PM +0800, Yu Zhang wrote:
> The 64-bit key used by vtd_lookup_iotlb() to search the cached
> mappings is formed by combining the GFN, source id and the page
> level. To cover 57-bit IOVA, the shift of source id and of page
> level need to be enlarged by 9 - the stride of one paging structure
> level.
> 
> Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

But note that we should have this patch either squashed into previous
patch, or at least it should appear earlier than patch 2 since
otherwise patch 2 could possibly break.  I would prefer squashing
since it's really part of patch 2, and please feel free to pick my r-b
if you want to resent with a squashed version in the future.

Regards,

-- 
Peter Xu
