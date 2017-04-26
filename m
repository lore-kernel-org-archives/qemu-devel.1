Received: from eggs.gnu.org ([2001:4830:134:3::10]:34074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d3KkT-0000wA-G3
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 07:04:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d3KkS-0007DX-LO
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 07:04:41 -0400
Date: Wed, 26 Apr 2017 08:04:32 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170426110432.GT3482@thinpad.lan.raisama.net>
References: <1490189568-167621-1-git-send-email-imammedo@redhat.com>
	<1490189568-167621-11-git-send-email-imammedo@redhat.com>
	<20170412211529.GD27126@thinpad.lan.raisama.net>
	<20170419115245.5855f624@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170419115245.5855f624@nial.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 10/23] numa: mirror cpu to node
 mapping in MachineState::possible_cpus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Shannon Zhao <zhaoshenglong@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On Wed, Apr 19, 2017 at 11:52:45AM +0200, Igor Mammedov wrote:
> On Wed, 12 Apr 2017 18:15:29 -0300
> Eduardo Habkost <ehabkost@redhat.com> wrote:
> 
> > On Wed, Mar 22, 2017 at 02:32:35PM +0100, Igor Mammedov wrote:
> > > Introduce machine_set_cpu_numa_node() helper that stores
> > > node mapping for CPU in MachineState::possible_cpus.
> > > CPU and node it belongs to is specified by 'props' argument.
> > > 
> > > Patch doesn't remove old way of storing mapping in
> > > numa_info[X].node_cpu as removing it at the same time
> > > makes patch rather big. Instead it just mirrors mapping
> > > in possible_cpus and follow up per target patches will
> > > switch to possible_cpus and numa_info[X].node_cpu will
> > > be removed once there isn't any users left.
> > > 
> > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>  
> > 
> > So, this patch is the one that makes "-numa" and "-numa cpu"
> > affect query-hotpluggable-cpus output.
> that was intent behind series.
> 
> [...]
> > As noted in another message, I am not sure we really should make
> > "-numa" affect query-hotpluggable-cpus output unconditionally (I
> > believe we shouldn't). But we do, we need to document this very
> > clearly.
> What place would you suggest to document this at?

qemu-options.hx documentation for -numa cpu, NumaCpuOptions docs
on qapi-schema, and/or query-hotpluggable-cpus docs on
qapi-schema.

-- 
Eduardo
