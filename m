Received: from eggs.gnu.org ([209.51.188.92]:41226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gzc8g-0000jJ-5e
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 01:59:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gzc8e-0000cP-8W
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 01:59:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39772)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gzc8c-0000ZD-7q
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 01:59:20 -0500
Date: Fri, 1 Mar 2019 14:59:00 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20190301065900.GB22229@xz-x1>
References: <1551361677-28933-1-git-send-email-yi.y.sun@linux.intel.com>
	<1551361677-28933-3-git-send-email-yi.y.sun@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1551361677-28933-3-git-send-email-yi.y.sun@linux.intel.com>
Subject: Re: [Qemu-devel] [RFC v2 2/3] intel_iommu: add 256 bits qi_desc
 support
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

On Thu, Feb 28, 2019 at 09:47:56PM +0800, Yi Sun wrote:
> From: "Liu, Yi L" <yi.l.liu@intel.com>
> 
> Per Intel(R) VT-d 3.0, the qi_desc is 256 bits in Scalable
> Mode. This patch adds emulation of 256bits qi_desc.
> 
> Signed-off-by: Liu, Yi L <yi.l.liu@intel.com>
> [Yi Sun is co-developer to rebase and refine the patch.]
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>

[...]

> @@ -2501,7 +2507,12 @@ static void vtd_handle_iqt_write(IntelIOMMUState *s)
>  {
>      uint64_t val = vtd_get_quad_raw(s, DMAR_IQT_REG);
>  
> -    s->iq_tail = VTD_IQT_QT(val);
> +    if (s->iq_dw && val & VTD_IQT_QT_256_RSV_BIT) {

Nit: Let's do (val & VTD_IQT_QT_256_RSV_BIT) to be clear.  With that:

Reviewed-by: Peter Xu <peterx@redhat.com>

Regards,

-- 
Peter Xu
