Received: from eggs.gnu.org ([2001:4830:134:3::10]:51847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dhbDP-0005te-Rx
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 08:45:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dhbDP-0006Kb-3f
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 08:44:59 -0400
Date: Tue, 15 Aug 2017 20:44:51 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170815124451.GD14412@lemon>
References: <20170815040454.4223-1-famz@redhat.com>
	<20170815040454.4223-2-famz@redhat.com>
	<4ebaff31-4480-576b-d14f-9e9e9a73ab0e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ebaff31-4480-576b-d14f-9e9e9a73ab0e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 1/4] stubs: Add vm state change
 handler stubs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On Tue, 08/15 07:26, Eric Blake wrote:
> On 08/14/2017 11:04 PM, Fam Zheng wrote:
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> 
> A bit sparse on the 'why' - presumably, upcoming patches will fail to
> compile if the stub is not present, but mentioning what dependency this
> solves never hurts.
> 
> > ---
> >  stubs/Makefile.objs          |  1 +
> >  stubs/change-state-handler.c | 14 ++++++++++++++
> >  2 files changed, 15 insertions(+)
> >  create mode 100644 stubs/change-state-handler.c
> > 
> 
> > +++ b/stubs/change-state-handler.c
> > @@ -0,0 +1,14 @@
> > +#include "qemu/osdep.h"
> > +#include "qemu-common.h"
> > +#include "sysemu/sysemu.h"
> > +
> > +VMChangeStateEntry *qemu_add_vm_change_state_handler(VMChangeStateHandler *cb,
> > +                                                     void *opaque)
> > +{
> > +    return g_malloc0(1);
> > +}
> 
> Hmm - this is NOT a VMChangeStateEntry; if it ever gets dereferenced,
> the caller is (probably) accessing memory out of bounds.  Presumably,
> since it is a stub, this should never be called - and if that's the
> case, can we just get away with returning NULL instead (I'd rather have
> the caller SEGFAULT than dereference out-of-bounds into the heap, if
> this stub gets used inappropriately).

Good point, will update this patch.

> 
> > +
> > +void qemu_del_vm_change_state_handler(VMChangeStateEntry *e)
> > +{
> > +    g_free(e);
> 
> And of course, if you don't allocate anything, this can be a no-op.
> 
> > +}
> > 
> 

Fam
