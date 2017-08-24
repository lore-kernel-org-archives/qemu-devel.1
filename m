Received: from eggs.gnu.org ([2001:4830:134:3::10]:35318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dknbw-0008NN-Hc
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 04:35:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dknbr-0003dp-Kq
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 04:35:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53420)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dknbr-0003ce-Fe
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 04:35:27 -0400
Date: Thu, 24 Aug 2017 10:35:20 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170824103520.5a6362c4.cohuck@redhat.com>
In-Reply-To: <3e2bce11-90f5-c1e3-6286-bad3478976da@redhat.com>
References: <20170823155458.19601-1-cohuck@redhat.com>
	<20170823155458.19601-3-cohuck@redhat.com>
	<3e2bce11-90f5-c1e3-6286-bad3478976da@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 2/9] kvm: remove hard dependency on pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.de, david@redhat.com, pmorel@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com

On Thu, 24 Aug 2017 03:13:46 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 23.08.2017 17:54, Cornelia Huck wrote:
> > The msi routing code in kvm calls some pci functions: provide
> > some stubs to enable builds without pci.
> > 
> > Also, to make this more obvious, guard them via a pci_available boolean
> > (which also can be reused in other places).
> > 
> > Fixes: e1d4fb2de ("kvm-irqchip: x86: add msi route notify fn")
> > Fixes: 767a554a0 ("kvm-all: Pass requester ID to MSI routing functions")
> > Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> >  accel/kvm/kvm-all.c  |  6 +++---
> >  hw/pci/pci-stub.c    | 16 +++++++++++++++-
> >  hw/pci/pci.c         |  2 ++
> >  include/hw/pci/pci.h |  2 ++
> >  4 files changed, 22 insertions(+), 4 deletions(-)

> > diff --git a/hw/pci/pci-stub.c b/hw/pci/pci-stub.c
> > index ecad664946..2d3b32c6ab 100644
> > --- a/hw/pci/pci-stub.c
> > +++ b/hw/pci/pci-stub.c
> > @@ -23,10 +23,11 @@
> >  #include "monitor/monitor.h"
> >  #include "qapi/qmp/qerror.h"
> >  #include "hw/pci/pci.h"
> > -#include "qmp-commands.h"
> >  #include "hw/pci/msi.h"
> > +#include "qmp-commands.h"  
> 
> Nit: Unnecessary movement of the #include statement.

Seems to have slipped in during the various rebases. Fixed.

> 
> If you fix that:
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Thanks!
