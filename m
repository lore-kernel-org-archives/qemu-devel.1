Received: from eggs.gnu.org ([2001:4830:134:3::10]:60967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1eslSR-0007kG-Nk
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 03:26:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1eslSN-0007PI-MQ
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 03:26:55 -0500
Received: from mga18.intel.com ([134.134.136.126]:62972)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@linux.intel.com>)
	id 1eslSN-0007Om-Dc
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 03:26:51 -0500
Date: Mon, 5 Mar 2018 16:10:02 +0800
From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Message-ID: <20180305081002.GC2482@sky-dev>
References: <1519900415-30314-1-git-send-email-yi.l.liu@linux.intel.com>
	<1519900415-30314-4-git-send-email-yi.l.liu@linux.intel.com>
	<8d038bf4-4333-f010-4280-8c5ca26b2acd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d038bf4-4333-f010-4280-8c5ca26b2acd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 03/12] hw/core: introduce
 IOMMUSVAContext for virt-SVA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, david@gibson.dropbear.id.au, alex.williamson@redhat.com, eric.auger.pro@gmail.com, yi.l.liu@intel.com, peterx@redhat.com, kevin.tian@intel.com, jasowang@redhat.com

On Fri, Mar 02, 2018 at 04:13:17PM +0100, Paolo Bonzini wrote:
> On 01/03/2018 11:33, Liu, Yi L wrote:
> > +void iommu_sva_notifier_unregister(IOMMUSVAContext *sva_ctx,
> > +                                   IOMMUSVANotifier *notifier)
> > +{
> > +    IOMMUSVANotifier *cur, *next;
> > +
> > +    QLIST_FOREACH_SAFE(cur, &sva_ctx->sva_notifiers, node, next) {
> > +        if (cur == notifier) {
> > +            QLIST_REMOVE(cur, node);
> > +            break;
> > +        }
> > +    }
> > +}
> 
> It's enough to just do QLIST_REMOVE(notifier, node) here.

Thanks, will apply in next version.

Regards,
Yi Liu 
