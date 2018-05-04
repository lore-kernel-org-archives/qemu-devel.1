Received: from eggs.gnu.org ([2001:4830:134:3::10]:57047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEQhc-0005uJ-Ta
	for qemu-devel@nongnu.org; Thu, 03 May 2018 22:44:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEQhY-0007Te-Mz
	for qemu-devel@nongnu.org; Thu, 03 May 2018 22:44:08 -0400
Date: Fri, 4 May 2018 05:44:02 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180504054007-mutt-send-email-mst@kernel.org>
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
	<1525376963-79623-63-git-send-email-mst@redhat.com>
	<20180504001701.GL13229@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180504001701.GL13229@umbus.fritz.box>
Subject: Re: [Qemu-devel] [PATCH 62/67] kvm: use include "kvm_ppc.h"
 consistently
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, berrange@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org

On Fri, May 04, 2018 at 10:17:01AM +1000, David Gibson wrote:
> On Thu, May 03, 2018 at 10:51:42PM +0300, Michael S. Tsirkin wrote:
> > Some places include kvm_ppc.h, others target/ppc/kvm_ppc.h.
> > Let's be consistent.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> One of your earlier patches in this series moved to using a full
> target/ppc/whatever.h for includers outside target/ppc itself.  So I'm
> not sure why you're standardizing on the short form here.

It's not a short form. The specific header is kvm_ppc.h.  That's how
most files used it so I selected a location minimizing the churn.

I also don't know why is it kvm_ppc.h and not just kvm.h.

> > ---
> >  hw/ppc/spapr_cpu_core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> > index 94afeb3..312d6ed 100644
> > --- a/hw/ppc/spapr_cpu_core.c
> > +++ b/hw/ppc/spapr_cpu_core.c
> > @@ -15,7 +15,7 @@
> >  #include "qapi/error.h"
> >  #include "sysemu/cpus.h"
> >  #include "sysemu/kvm.h"
> > -#include "target/ppc/kvm_ppc.h"
> > +#include "kvm_ppc.h"
> >  #include "hw/ppc/ppc.h"
> >  #include "target/ppc/mmu-hash64.h"
> >  #include "sysemu/numa.h"
> 
> -- 
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson
