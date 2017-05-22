Received: from eggs.gnu.org ([2001:4830:134:3::10]:33329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dCiEq-0003S7-PX
	for qemu-devel@nongnu.org; Mon, 22 May 2017 03:58:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dCiEq-0002pg-5U
	for qemu-devel@nongnu.org; Mon, 22 May 2017 03:58:48 -0400
Date: Mon, 22 May 2017 09:58:36 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170522095836.59149abc@nial.brq.redhat.com>
In-Reply-To: <20170518182039.GO4748@thinpad.lan.raisama.net>
References: <1495094971-177754-1-git-send-email-imammedo@redhat.com>
	<1495094971-177754-4-git-send-email-imammedo@redhat.com>
	<20170518182039.GO4748@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] numa: silence incomplete mapping
 warning under qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Andrew Jones <drjones@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On Thu, 18 May 2017 15:20:39 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Thu, May 18, 2017 at 10:09:31AM +0200, Igor Mammedov wrote:
> > Suggested-by: Markus Armbruster <armbru@redhat.com>
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>  
> 
> Where exactly is the test code that triggers those messages and
> requires this patch? I would like to document that in the commit
> message.

ok, I'll  mention test case in commit message on respin

> > ---
> > CC: Markus Armbruster <armbru@redhat.com>
> > 
> > ---
> >  hw/core/machine.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > index 2e91aa9..21ebef8 100644
> > --- a/hw/core/machine.c
> > +++ b/hw/core/machine.c
> > @@ -21,6 +21,7 @@
> >  #include "qemu/error-report.h"
> >  #include "qemu/cutils.h"
> >  #include "sysemu/numa.h"
> > +#include "sysemu/qtest.h"
> >  
> >  static char *machine_get_accel(Object *obj, Error **errp)
> >  {
> > @@ -732,7 +733,7 @@ static void machine_numa_finish_init(MachineState *machine)
> >              }
> >          }
> >      }
> > -    if (s->len) {
> > +    if (s->len && !qtest_enabled()) {
> >          error_report("warning: CPU(s) not present in any NUMA nodes: %s",
> >                       s->str);
> >          error_report("warning: All CPU(s) up to maxcpus should be described "
> > -- 
> > 2.7.4
> >   
> 
