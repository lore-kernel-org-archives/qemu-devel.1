Received: from eggs.gnu.org ([2001:4830:134:3::10]:41932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cEXlz-0000EJ-52
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 03:40:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cEXlv-0003rT-Vx
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 03:40:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46462)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cEXlv-0003rM-Pf
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 03:40:15 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BF408624CB
	for <qemu-devel@nongnu.org>; Wed,  7 Dec 2016 08:40:14 +0000 (UTC)
Date: Wed, 7 Dec 2016 16:40:12 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20161207084012.GA2286@lemon>
References: <1481089965-3888-1-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1481089965-3888-1-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9 0/2] VT-d extend GAW to 48 bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, mst@redhat.com, pbonzini@redhat.com

On Wed, 12/07 13:52, Peter Xu wrote:
> The first patch did some check to make sure the CE GAW bits are always
> valid (it can overflow in old codes, I see it dangerous).
> 
> The second patch extended VT-d GAW (Guest Address Width) from 39 bits
> to 48 bits.
> 
> Please review. Thanks,
> 
> Peter Xu (2):
>   intel_iommu: check validity for GAW bits in CE
>   intel_iommu: extend supported guest aw to 48 bits
> 
>  hw/i386/intel_iommu.c          | 12 +++++++++++-
>  hw/i386/intel_iommu_internal.h |  7 +++++--
>  include/hw/i386/intel_iommu.h  |  2 +-
>  3 files changed, 17 insertions(+), 4 deletions(-)
> 
> -- 
> 2.7.4
> 

This makes "identical mapping" from virtual address to iova possible in a QEMU
VM and I no longer see the "DMAR: intel_iommu_map: iommu width (39) is not
sufficient for the mapped address (55a7d6557000)" error message when doing VFIO
dma mapping.

Tested-by: Fam Zheng <famz@redhat.com>
