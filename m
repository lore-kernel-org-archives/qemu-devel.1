Received: from eggs.gnu.org ([2001:4830:134:3::10]:54335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gMokJ-0001sU-Io
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 01:33:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gMokG-0004PR-1P
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 01:33:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36148)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gMokF-0004NQ-NK
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 01:33:47 -0500
Date: Wed, 14 Nov 2018 14:33:40 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20181114063340.GD6846@xz-x1>
References: <1542175484-2742-1-git-send-email-yu.c.zhang@linux.intel.com>
	<1542175484-2742-2-git-send-email-yu.c.zhang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1542175484-2742-2-git-send-email-yu.c.zhang@linux.intel.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/3] intel-iommu: differentiate host
 address width from IOVA address width.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yu Zhang <yu.c.zhang@linux.intel.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

On Wed, Nov 14, 2018 at 02:04:42PM +0800, Yu Zhang wrote:
> Currently, vIOMMU is using the value of IOVA address width, instead of
> the host address width(HAW) to calculate the number of reserved bits in
> data structures such as root entries, context entries, and entries of
> DMA paging structures etc.
> 
> However values of IOVA address width and of the HAW may not equal. For
> example, a 48-bit IOVA can only be mapped to host addresses no wider than
> 46 bits. Using 48, instead of 46 to calculate the reserved bit may result
> in an invalid IOVA being accepted.
> 
> To fix this, a new field - haw_bits is introduced in struct IntelIOMMUState,
> whose value is initialized based on the maximum physical address set to
> guest CPU. Also, definitions such as VTD_HOST_AW_39/48BIT etc. are renamed
> to clarify.
> 
> Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
