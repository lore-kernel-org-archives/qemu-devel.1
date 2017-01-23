Received: from eggs.gnu.org ([2001:4830:134:3::10]:55890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1cVYSq-0005Tr-KJ
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 01:50:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1cVYSm-0003KV-Ku
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 01:50:52 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55092
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1cVYSm-0003JT-EM
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 01:50:48 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0N6nBxx171126
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 01:50:46 -0500
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2858ujq27u-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 01:50:45 -0500
Received: from localhost
	by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Mon, 23 Jan 2017 12:20:39 +0530
Received: from d28relay06.in.ibm.com (d28relay06.in.ibm.com [9.184.220.150])
	by d28dlp02.in.ibm.com (Postfix) with ESMTP id 3544C3940062
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 12:20:36 +0530 (IST)
Received: from d28av07.in.ibm.com (d28av07.in.ibm.com [9.184.220.146])
	by d28relay06.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v0N6oa7Q28311742
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 12:20:36 +0530
Received: from d28av07.in.ibm.com (localhost [127.0.0.1])
	by d28av07.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v0N6oY0M023735
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 12:20:35 +0530
Date: Mon, 23 Jan 2017 12:20:33 +0530
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Reply-To: bharata@linux.vnet.ibm.com
References: <1484759609-264075-1-git-send-email-imammedo@redhat.com>
	<1484759609-264075-9-git-send-email-imammedo@redhat.com>
	<20170118185713.GK3491@thinpad.lan.raisama.net>
	<20170119160423.761d2c57@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170119160423.761d2c57@nial.brq.redhat.com>
Message-Id: <20170123065033.GD21081@in.ibm.com>
Subject: Re: [Qemu-devel] [RFC 08/13] pc: add writeonly 'cpu' property to
 PCMachine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, Dou Liyang <douly.fnst@cn.fujitsu.com>, fanc.fnst@cn.fujitsu.com, caoj.fnst@cn.fujitsu.com, stefanha@redhat.com, izumi.taku@jp.fujitsu.com, vilanova@ac.upc.edu, peter.maydell@linaro.org, Andrew Jones <drjones@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>

On Thu, Jan 19, 2017 at 04:04:23PM +0100, Igor Mammedov wrote:
> On Wed, 18 Jan 2017 16:57:13 -0200
> Eduardo Habkost <ehabkost@redhat.com> wrote:
> 
> > On Wed, Jan 18, 2017 at 06:13:24PM +0100, Igor Mammedov wrote:
> > > it will allow generic numa code to set cpu to numa node mapping
> > > in target independent manner in the next patch.
> > > 
> > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > > ---
> > >  hw/i386/pc.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 56 insertions(+)
> > > 
> > > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > > index f8ea635..1d33a5e 100644
> > > --- a/hw/i386/pc.c
> > > +++ b/hw/i386/pc.c
> > > @@ -2201,6 +2201,56 @@ static void pc_machine_set_pit(Object *obj, bool value, Error **errp)
> > >      pcms->pit = value;
> > >  }
> > >  
> > > +static void pc_machine_set_cpu(Object *obj, Visitor *v, const char *name,
> > > +                               void *opaque, Error **errp)
> > > +{
> > > +    uint32_t apic_id;
> > > +    X86CPUTopoInfo topo;
> > > +    CPUArchId *cpu_slot;
> > > +    Error *local_err = NULL;
> > > +    CpuInstanceProperties *cpu_props = NULL;
> > > +    PCMachineState *pcms = PC_MACHINE(obj);
> > > +    MachineClass *mc = MACHINE_GET_CLASS(obj);
> > > +
> > > +    visit_type_CpuInstanceProperties(v, name, &cpu_props, &local_err);
> > > +    if (local_err) {
> > > +        goto out;
> > > +    }
> > > +
> > > +    if (!cpu_props->has_node_id) {
> > > +        error_setg(&local_err, "node-id property is not specified");
> > > +        goto out;
> > > +    }
> > > +
> > > +    /*
> > > +     * make sure that possible_cpus is initialized
> > > +     * as property setter might be called before machine init is called
> > > +     */
> > > +    mc->possible_cpu_arch_ids(MACHINE(obj));
> > > +
> > > +    topo.pkg_id = cpu_props->socket_id;
> > > +    topo.core_id = cpu_props->core_id;
> > > +    topo.smt_id = cpu_props->thread_id;
> > > +    apic_id = apicid_from_topo_ids(smp_cores, smp_threads, &topo);
> > > +    cpu_slot = pc_find_cpu_slot(pcms, apic_id, NULL);  
> > 
> > If we make TYPE_MACHINE provide an API to query CPU slots, e.g.:
> >   CPUArchId *machine_find_cpu_slot(MachineState *m, CpuInstanceProperties *props)
> so if there is no objections, 
> I'll move possible_cpus to MachineState
> and add to MachineClass above callback so target machine
> would be able to provide arch specific lookup function.
> it should work for both x86 and ARM.

The need for possible_cpus in MachineState for sPAPR isn't immediately
apparent to me. In the context of this new numa "cpu" property, PC target
seems to use possible_cpus to store and later lookup the numa node id for
a given CPU. Wondering if that could be achieved w/o needing possible_cpus
in MachineState ?

Regards,
Bharata.
