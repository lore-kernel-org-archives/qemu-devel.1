Received: from eggs.gnu.org ([2001:4830:134:3::10]:34083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eK1hE-0001Lz-KI
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 07:42:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eK1hB-0004Ar-HY
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 07:42:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33710)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eK1hB-0004AX-Ay
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 07:42:33 -0500
Date: Wed, 29 Nov 2017 20:42:17 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171129124217.GB2949@xz-mi>
References: <1511958793-15217-1-git-send-email-mgamal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1511958793-15217-1-git-send-email-mgamal@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RESEND 0/2] x86_iommu: Fix segfault when
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
Cc: qemu-devel@nongnu.org, mst@redhat.com, mjt@tls.msk.ru, lvivier@redhat.com, thuth@redhat.com, ehabkost@redhat.com, pbonzini@redhat.com

On Wed, Nov 29, 2017 at 01:33:11PM +0100, Mohammed Gamal wrote:
> [Resending for the second time]
> 
> Starting qemu with
> qemu-system-x86_64 -S -M isapc -device {amd|intel}-iommu
> leads to a segfault. The code assume PCI bus is present and
> tries to access the bus structure without checking.
> 
> The patch series moves the error checks from vtd_realize()
> and amdvi_realize() to the generic x86_iommu_realize() and
> adds a check for PCI bus presence.

Yes, IMHO this is ok even for 2.11.  Michael, what do you think?

> 
> 
> Mohammed Gamal (2):
>   x86_iommu: Move machine check to x86_iommu_realize()
>   x86_iommu: check if machine has PCI bus
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
