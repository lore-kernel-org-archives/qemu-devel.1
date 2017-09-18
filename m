Received: from eggs.gnu.org ([2001:4830:134:3::10]:55379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dtsMk-00082k-PL
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 05:29:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dtsMh-0007qX-9z
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 05:29:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60788)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dtsMh-0007pz-3j
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 05:29:19 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 26921356F0
	for <qemu-devel@nongnu.org>; Mon, 18 Sep 2017 09:29:18 +0000 (UTC)
Date: Mon, 18 Sep 2017 17:29:08 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170918092908.GF3617@pxdev.xzpeter.org>
References: <1505487877-22799-1-git-send-email-mgamal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1505487877-22799-1-git-send-email-mgamal@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/2] x86_iommu: Fix segfault when
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

On Fri, Sep 15, 2017 at 05:04:35PM +0200, Mohammed Gamal wrote:
> Starting qemu with
> qemu-system-x86_64 -S -M isapc -device {amd|intel}-iommu
> leads to a segfault. The code assume PCI bus is present and
> tries to access the bus structure without checking.
> 
> The patch series moves the error checks from vtd_realize()
> and amdvi_realize() to the generic x86_iommu_realize() and
> adds a check for PCI bus presence.
> 
> v1 --> v2:
> * Change error message with capitalized acronym
> 
> Mohammed Gamal (2):
>   x86_iommu: Move machine check to x86_iommu_realize()
>   x86_iommu: check if machine has PCI bus

I'm fine with even keeping object_dynamic_cast() there in patch 1, but
I agree with Eduardo's questioning.

For either case:

Reviewed-by: Peter Xu <peterx@redhat.com>

> 
>  hw/i386/amd_iommu.c   | 10 +---------
>  hw/i386/intel_iommu.c | 10 +---------
>  hw/i386/x86-iommu.c   | 13 +++++++++++++
>  3 files changed, 15 insertions(+), 18 deletions(-)
> 
> -- 
> 1.8.3.1
> 

-- 
Peter Xu
