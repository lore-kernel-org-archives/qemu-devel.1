Received: from eggs.gnu.org ([209.51.188.92]:37602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1h10QE-0002Bn-W4
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 22:07:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1h10QE-0005ER-2L
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 22:07:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56116)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1h10QD-0005BG-Rn
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 22:07:14 -0500
Date: Tue, 5 Mar 2019 11:07:04 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20190305030704.GG1657@xz-x1>
References: <1551753295-30167-1-git-send-email-yi.y.sun@linux.intel.com>
	<1551753295-30167-4-git-send-email-yi.y.sun@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1551753295-30167-4-git-send-email-yi.y.sun@linux.intel.com>
Subject: Re: [Qemu-devel] [PATCH v1 3/3] intel_iommu: add scalable-mode
 option to make scalable mode work
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yi Sun <yi.y.sun@linux.intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com, jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com

On Tue, Mar 05, 2019 at 10:34:55AM +0800, Yi Sun wrote:
> This patch adds an option to provide flexibility for user to expose
> Scalable Mode to guest. User could expose Scalable Mode to guest by
> the config as below:
> 
> "-device intel-iommu,caching-mode=on,scalable-mode=on"
> 
> The Linux iommu driver has supported scalable mode. Please refer below
> patch set:
> 
>     https://www.spinics.net/lists/kernel/msg2985279.html
> 
> Signed-off-by: Liu, Yi L <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> ---
> RFC v2->v1:
>     - move 's->dma_drain' check from 'vtd_init' to 'vtd_decide_config'.

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
