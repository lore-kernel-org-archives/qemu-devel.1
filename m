Received: from eggs.gnu.org ([2001:4830:134:3::10]:52126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e41kK-00015r-61
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 05:31:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e41kF-0003NH-82
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 05:31:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47798)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1e41kF-0003Mz-2C
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 05:31:35 -0400
Date: Mon, 16 Oct 2017 17:31:25 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171016093125.GG4166@pxdev.xzpeter.org>
References: <1508144783-18792-1-git-send-email-mgamal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1508144783-18792-1-git-send-email-mgamal@redhat.com>
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
To: Mohammed Gamal <mgamal@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, ehabkost@redhat.com, pbonzini@redhat.com, mjt@tls.msk.ru

On Mon, Oct 16, 2017 at 11:06:21AM +0200, Mohammed Gamal wrote:
> Starting qemu with
> qemu-system-x86_64 -S -M isapc -device {amd|intel}-iommu
> leads to a segfault. The code assume PCI bus is present and
> tries to access the bus structure without checking.
> 
> The patch series moves the error checks from vtd_realize()
> and amdvi_realize() to the generic x86_iommu_realize() and
> adds a check for PCI bus presence.

Hi, Michael,

Would you like to pick Mohammed's two patches in your next pull
request?

Each of the patches has got 2 acks, and it does fix a problem.

Thanks,

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
