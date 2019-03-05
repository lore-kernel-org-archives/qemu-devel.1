Received: from eggs.gnu.org ([209.51.188.92]:37552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1h10Po-00020A-I7
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 22:06:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1h10Pn-0004Mz-Sk
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 22:06:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42902)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1h10Pn-0004Jv-MN
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 22:06:47 -0500
Date: Tue, 5 Mar 2019 11:06:36 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20190305030636.GF1657@xz-x1>
References: <1551753295-30167-1-git-send-email-yi.y.sun@linux.intel.com>
	<1551753295-30167-2-git-send-email-yi.y.sun@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1551753295-30167-2-git-send-email-yi.y.sun@linux.intel.com>
Subject: Re: [Qemu-devel] [PATCH v1 1/3] intel_iommu: scalable mode emulation
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

On Tue, Mar 05, 2019 at 10:34:53AM +0800, Yi Sun wrote:
> From: "Liu, Yi L" <yi.l.liu@intel.com>
> 
> Intel(R) VT-d 3.0 spec introduces scalable mode address translation to
> replace extended context mode. This patch extends current emulator to
> support Scalable Mode which includes root table, context table and new
> pasid table format change. Now intel_iommu emulates both legacy mode
> and scalable mode (with legacy-equivalent capability set).
> 
> The key points are below:
> 1. Extend root table operations to support both legacy mode and scalable
>    mode.
> 2. Extend context table operations to support both legacy mode and
>    scalable mode.
> 3. Add pasid tabled operations to support scalable mode.
> 
> Signed-off-by: Liu, Yi L <yi.l.liu@intel.com>
> [Yi Sun is co-developer to contribute much to refine the whole commit.]
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> ---
> RFC v2->v1
>     - revert unnecessary rename in 'vtd_ce_present".
>     - use 'ce_size' to judge if it is scalable mode in
>       'vtd_get_context_entry_from_root'.
>     - remove some 'inline' declarations.
>     - remove unnecessary scalable mode check in 'vtd_ce_type_check' and
>       make corresponding changes in 'vtd_dev_to_context_entry'.
>     - add 'VTD_FR_PASID_TABLE_INV' case in 'vtd_qualified_faults[]'.
>     - create a macro function to handle a repeated pattern about 'is_fpd_set'.
>     - explicitly print 'legacy mode' when calling 'trace_vtd_replay_ce_valid'.

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu
