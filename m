Received: from eggs.gnu.org ([2001:4830:134:3::10]:35407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dFn7Q-00025k-G0
	for qemu-devel@nongnu.org; Tue, 30 May 2017 15:47:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dFn7P-0008KZ-Qi
	for qemu-devel@nongnu.org; Tue, 30 May 2017 15:47:52 -0400
Date: Tue, 30 May 2017 16:47:42 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170530194742.GO32274@thinpad.lan.raisama.net>
References: <1496161442-96665-1-git-send-email-imammedo@redhat.com>
	<1496161442-96665-6-git-send-email-imammedo@redhat.com>
	<554eca2d-3c94-c341-299f-d71bcb020edd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <554eca2d-3c94-c341-299f-d71bcb020edd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 5/7] numa: move numa_node from CPUState
 into target specific classes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, Andrew Jones <drjones@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On Tue, May 30, 2017 at 11:30:27AM -0500, Eric Blake wrote:
> On 05/30/2017 11:24 AM, Igor Mammedov wrote:
> > Move vcpu's assocciated numa_node field out of generic CPUState
> 
> s/assocciated/associated/
> 
> > into inherited classes that actually care about cpu<->numa mapping,
> > i.e: ARMCPU, PowerPCCPU, X86CPU.
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> 
> > +++ b/target/arm/cpu.h
> > @@ -703,6 +703,8 @@ struct ARMCPU {
> >  
> >      ARMELChangeHook *el_change_hook;
> >      void *el_change_hook_opaque;
> > +
> > +    int32_t node_id; /* NUMA node this CPU is belonging to */
> 
> s/is belonging/belongs/  (multiple places in the patch)

I have fixed those while applying the patch.  Thanks!

-- 
Eduardo
