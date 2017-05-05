Received: from eggs.gnu.org ([2001:4830:134:3::10]:48025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d6jSq-0007qt-Fg
	for qemu-devel@nongnu.org; Fri, 05 May 2017 16:04:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d6jSp-0007MX-Kh
	for qemu-devel@nongnu.org; Fri, 05 May 2017 16:04:32 -0400
Date: Fri, 5 May 2017 22:04:16 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170505220416.03697c36@Igors-MacBook-Pro.local>
In-Reply-To: <20170505171226.GI3482@thinpad.lan.raisama.net>
References: <1493816238-33120-1-git-send-email-imammedo@redhat.com>
	<1493816238-33120-13-git-send-email-imammedo@redhat.com>
	<20170505014522.GK14413@umbus.fritz.box>
	<20170505100918.181acc8b@nial.brq.redhat.com>
	<20170505090602.c2u7ugdh65rdjrs6@hawk.localdomain>
	<20170505171226.GI3482@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 12/24] numa: add numa_[has_]node_id()
 wrappers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Andrew Jones <drjones@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Shannon Zhao <zhaoshenglong@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>

On Fri, 5 May 2017 14:12:26 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Fri, May 05, 2017 at 11:06:02AM +0200, Andrew Jones wrote:
> > On Fri, May 05, 2017 at 10:09:18AM +0200, Igor Mammedov wrote:
> > > On Fri, 5 May 2017 11:45:22 +1000
> > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > > 
> > > > On Wed, May 03, 2017 at 02:57:06PM +0200, Igor Mammedov wrote:
> > > > > wrappers should make access to [has]node_id fields more readable
> > > > > 
> > > > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>  
> > > > 
> > > > Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> > > > 
> > > > Correct, though I'm not sure it actually simplifies things that much.
> > > > Maybe more in future patches, though.
> > > that's what Drew insisted on, and even though I prefer other way around
> > > I won't stall series arguing about styling issues,
> > > so here this patch goes.
> > 
> > My argument in the last review of this series was that references like
> > 
> >  machine->possible_cpus->cpus[cs->cpu_index].props.has_node_id
> > and
> >  machine->possible_cpus->cpus[cs->cpu_index].props.node_id
> > 
> > are quite long, and only differ by 'has_', making it tough to
> > easily recognize.
> 
> If expression length is a problem, we can just use an extra
> variable:
> 
>  CPUArchId *slot = &machine->possible_cpus->cpus[cs->cpu_index];
>  if (slot->props.has_node_id && slot->props.node_id == FOO) ...
> 
> 
> >                   But, if nobody, but me, sees value in changing
> > them to
> > 
> >  numa_has_node_id(machine->possible_cpus, cs->cpu_index)
> > and
> >  numa_node_id(machine->possible_cpus, cs->cpu_index)
> > 
> > then I won't insist.
> 
> I don't mind that much, but I still prefer the version without
> the wrappers.
considering 3vs1 for wrapper less variant, I'll return it back.
but respin will have to wait till Tuesday due to holiday over here.
