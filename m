Received: from eggs.gnu.org ([209.51.188.92]:50176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.y.sun@linux.intel.com>) id 1gzd38-0002f8-Ac
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 02:57:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.y.sun@linux.intel.com>) id 1gzd37-00077E-Ln
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 02:57:42 -0500
Received: from mga18.intel.com ([134.134.136.126]:18289)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.y.sun@linux.intel.com>)
	id 1gzd37-000769-DW
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 02:57:41 -0500
Date: Fri, 1 Mar 2019 15:54:17 +0800
From: Yi Sun <yi.y.sun@linux.intel.com>
Message-ID: <20190301075417.GE26129@yi.y.sun>
References: <1551361677-28933-1-git-send-email-yi.y.sun@linux.intel.com>
	<1551361677-28933-4-git-send-email-yi.y.sun@linux.intel.com>
	<20190301070414.GC22229@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190301070414.GC22229@xz-x1>
Subject: Re: [Qemu-devel] [RFC v2 3/3] intel_iommu: add scalable-mode option
 to make scalable mode work
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

On 19-03-01 15:04:14, Peter Xu wrote:

[...]

> > @@ -3540,6 +3555,15 @@ static void vtd_init(IntelIOMMUState *s)
> >          s->cap |= VTD_CAP_CM;
> >      }
> >  
> > +    /* TODO: read cap/ecap from host to decide which cap to be exposed. */
> > +    if (s->scalable_mode) {
> > +        if (!s->dma_drain) {
> > +            error_report("Need to set dma_drain for scalable mode");
> > +            exit(1);
> > +        }
> 
> This patch looks mostly good to me, only that can we move this check
> to vtd_decide_config()?  That's where most similar checks are done.
>
I think that is fine. Thanks!
