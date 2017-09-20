Received: from eggs.gnu.org ([2001:4830:134:3::10]:44908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1duUvC-0007sF-MD
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 22:39:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1duUv7-0005He-DV
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 22:39:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55502)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1duUv7-0005FT-60
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 22:39:25 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B80BD85547
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 02:39:23 +0000 (UTC)
Date: Wed, 20 Sep 2017 10:39:15 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170920023915.GP3617@pxdev.xzpeter.org>
References: <1505745470-12208-1-git-send-email-mgamal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1505745470-12208-1-git-send-email-mgamal@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 0/3] x86_iommu: Fix segfault when
 starting on non-PCI machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mohammed Gamal <mgamal@redhat.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, mst@redhat.com, thuth@redhat.com, pbonzini@redhat.com

On Mon, Sep 18, 2017 at 04:37:47PM +0200, Mohammed Gamal wrote:
> Starting qemu with
> qemu-system-x86_64 -S -M isapc -device {amd|intel}-iommu
> leads to a segfault. The code assume PCI bus is present and
> tries to access the bus structure without checking.
> 
> The patch series moves the error checks from vtd_realize()
> and amdvi_realize() to the generic x86_iommu_realize() and
> adds a check for PCI bus presence.
> 
> v3 --> v4:
>   * Restore correct object_dynamic_cast() in x86_iommu_realize()
>   * Remove redundant casting in callee functions. Implemented in
>     a new patch
> 
> Mohammed Gamal (3):
>   x86_iommu: Move machine check to x86_iommu_realize()
>   intel_iommu, amd_iommu: Remove redundant object_dynamic_cast calls
>   x86_iommu: check if machine has PCI bus

After patch 2 squashed to patch 1 (patch 2 itself is not valid; the
problem only appears after patch 1):

Reviewed-by: Peter Xu <peterx@redhat.com>

> 
>  hw/i386/amd_iommu.c   | 13 ++-----------
>  hw/i386/intel_iommu.c | 13 ++-----------
>  hw/i386/x86-iommu.c   | 13 +++++++++++++
>  3 files changed, 17 insertions(+), 22 deletions(-)
> 
> -- 
> 1.8.3.1
> 

-- 
Peter Xu
