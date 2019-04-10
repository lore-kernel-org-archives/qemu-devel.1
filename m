Received: from eggs.gnu.org ([209.51.188.92]:35231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hE14P-00055r-Te
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 20:26:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hE14N-0005Vi-VX
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 20:26:29 -0400
Date: Wed, 10 Apr 2019 08:16:40 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20190410001640.GA25214@xz-x1>
References: <20190409160219.19026-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190409160219.19026-1-eric.auger@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-4.1] hw/arm/smmuv3: Remove
 SMMUNotifierNode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org

On Tue, Apr 09, 2019 at 06:02:19PM +0200, Eric Auger wrote:
> The SMMUNotifierNode struct is not necessary and brings extra
> complexity so let's remove it. We now directly track the SMMUDevices
> which have registered IOMMU MR notifiers.
> 
> This is inspired from the same transformation on intel-iommu
> done in commit b4a4ba0d68f50f218ee3957b6638dbee32a5eeef
> ("intel-iommu: remove IntelIOMMUNotifierNode")
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
