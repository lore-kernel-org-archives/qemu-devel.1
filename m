Received: from eggs.gnu.org ([209.51.188.92]:49684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.y.sun@linux.intel.com>) id 1gzd0S-00017a-QG
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 02:54:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.y.sun@linux.intel.com>) id 1gzd0R-0005io-0C
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 02:54:56 -0500
Received: from mga06.intel.com ([134.134.136.31]:49825)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.y.sun@linux.intel.com>)
	id 1gzd0Q-0005i6-OR
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 02:54:54 -0500
Date: Fri, 1 Mar 2019 15:51:30 +0800
From: Yi Sun <yi.y.sun@linux.intel.com>
Message-ID: <20190301075130.GD26129@yi.y.sun>
References: <1551361677-28933-1-git-send-email-yi.y.sun@linux.intel.com>
	<1551361677-28933-3-git-send-email-yi.y.sun@linux.intel.com>
	<20190301065900.GB22229@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190301065900.GB22229@xz-x1>
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
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com, jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com

On 19-03-01 14:59:00, Peter Xu wrote:
> On Thu, Feb 28, 2019 at 09:47:56PM +0800, Yi Sun wrote:
> > From: "Liu, Yi L" <yi.l.liu@intel.com>
> > 
> > Per Intel(R) VT-d 3.0, the qi_desc is 256 bits in Scalable
> > Mode. This patch adds emulation of 256bits qi_desc.
> > 
> > Signed-off-by: Liu, Yi L <yi.l.liu@intel.com>
> > [Yi Sun is co-developer to rebase and refine the patch.]
> > Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> 
> [...]
> 
> > @@ -2501,7 +2507,12 @@ static void vtd_handle_iqt_write(IntelIOMMUState *s)
> >  {
> >      uint64_t val = vtd_get_quad_raw(s, DMAR_IQT_REG);
> >  
> > -    s->iq_tail = VTD_IQT_QT(val);
> > +    if (s->iq_dw && val & VTD_IQT_QT_256_RSV_BIT) {
> 
> Nit: Let's do (val & VTD_IQT_QT_256_RSV_BIT) to be clear.  With that:
> 
Sure. Thanks!

> Reviewed-by: Peter Xu <peterx@redhat.com>
> 
> Regards,
> 
> -- 
> Peter Xu
