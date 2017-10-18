Received: from eggs.gnu.org ([2001:4830:134:3::10]:37522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e4pIq-0007Im-7E
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 10:26:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e4pIm-0001Fp-2x
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 10:26:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58320)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1e4pIl-0001FF-SS
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 10:26:31 -0400
Date: Wed, 18 Oct 2017 16:26:25 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171018162625.094cd3e1@nial.brq.redhat.com>
In-Reply-To: <f281298d-f9b3-7ffe-e223-ccd596bb0545@redhat.com>
References: <1508170976-96869-1-git-send-email-imammedo@redhat.com>
	<20171016163636.GI11975@redhat.com>
	<20171017092702.5b82103b@nial.brq.redhat.com>
	<20171017150759.GB31897@redhat.com>
	<32e47d96-0292-4511-adb2-24a4766b3027@redhat.com>
	<20171018122715.GF9719@redhat.com>
	<f281298d-f9b3-7ffe-e223-ccd596bb0545@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 0/6] enable numa configuration before
 machine_init() from HMP/QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, peter.maydell@linaro.org, pkrempa@redhat.com, ehabkost@redhat.com, cohuck@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com, david@gibson.dropbear.id.au

On Wed, 18 Oct 2017 14:33:49 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 18/10/2017 14:27, Daniel P. Berrange wrote:
> >>>   -object numa-node,id=numa0
> >>>   -object numa-node,id=numa1
> >>>   -object cpu,id=cpu0,node=numa0,socket=0,core=0,thread=0
> >>>   -object cpu,id=cpu1,node=numa0,socket=0,core=1,thread=0
> >>>   -object cpu,id=cpu2,node=numa0,socket=1,core=0,thread=0
> >>>   -object cpu,id=cpu3,node=numa0,socket=1,core=1,thread=0
> >>>   -object cpu,id=cpu4,node=numa1,socket=2,core=0,thread=0
> >>>   -object cpu,id=cpu5,node=numa1,socket=2,core=1,thread=0
> >>>   -object cpu,id=cpu6,node=numa1,socket=3,core=0,thread=0
> >>>   -object cpu,id=cpu7,node=numa1,socket=3,core=1,thread=0
> >>>
> >>> (perhaps -device instead of -object above, but that's a minor detail)  
> >> I understand that this is just an example, but wasn't this what is solved by
> >>
> >>   -smp 8,sockets=4,cores=2,thread=1
> >>   -numa node,nodeid=0 -numa cpu,node-id=0,socket-id=0-1
> >>   -numa node,nodeid=1 -numa cpu,node-id=0,socket-id=2-3  
> > IIUC, that lets you associate CPUs with NUMA nodes without having to know
> > the internal QEMU indexes. It won't help you with any monitor commands you
> > need to run later that expect the CPU index as input value.  My example
> > where lets you assign IDs to each CPU, which can then be used for montor
> > commands too - i should have illustrated that bit of it too.  
> 
> I guess query-hotpluggable-cpus could also grow a first-cpu-index in the
> returned data.
I guess query-cpus can/does provide cpu-index already,
for query-hotpluggable-cpus it would depend in what's shown there
(would work fro x86/arm/s390 as they publish there CPUState based objects,
but spapr puts cores there which themselves do not have cpu-index,
their children do though)


> 
> Paolo
> 
