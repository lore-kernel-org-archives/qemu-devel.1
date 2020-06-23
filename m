Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789F8C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 09:43:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C7D520679
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 09:43:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C7D520679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnfSu-0004I1-Hs
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 05:43:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35668)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1jnfQW-00089V-Es; Tue, 23 Jun 2020 05:41:12 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2115 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1jnfQP-0005T6-Op; Tue, 23 Jun 2020 05:41:12 -0400
Received: from lhreml707-chm.china.huawei.com (unknown [172.18.7.106])
 by Forcepoint Email with ESMTP id 639625B962EF103F83A1;
 Tue, 23 Jun 2020 10:40:59 +0100 (IST)
Received: from lhreml703-chm.china.huawei.com (10.201.108.52) by
 lhreml707-chm.china.huawei.com (10.201.108.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 23 Jun 2020 10:40:58 +0100
Received: from lhreml703-chm.china.huawei.com ([10.201.68.198]) by
 lhreml703-chm.china.huawei.com ([10.201.68.198]) with mapi id 15.01.1913.007; 
 Tue, 23 Jun 2020 10:40:59 +0100
From: Salil Mehta <salil.mehta@huawei.com>
To: Andrew Jones <drjones@redhat.com>
Subject: RE: [PATCH RFC 01/22] arm/cpuhp: Add QMP vcpu params validation
 support
Thread-Topic: [PATCH RFC 01/22] arm/cpuhp: Add QMP vcpu params validation
 support
Thread-Index: AQHWQcvP5xOa2jCJCEaicIhkNVfTfKjl4RiAgAAP/MA=
Date: Tue, 23 Jun 2020 09:40:58 +0000
Message-ID: <0126fb3d008d4690950cf843d6ece70b@huawei.com>
References: <20200613213629.21984-1-salil.mehta@huawei.com>
 <20200613213629.21984-2-salil.mehta@huawei.com>
 <20200623084603.i4kv3udz3dlcxlak@kamzik.brq.redhat.com>
In-Reply-To: <20200623084603.i4kv3udz3dlcxlak@kamzik.brq.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.79.3]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.76.210;
 envelope-from=salil.mehta@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 05:40:59
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "mehta.salil.lnk@gmail.com" <mehta.salil.lnk@gmail.com>,
 "gshan@redhat.com" <gshan@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jiakernel2@gmail.com" <jiakernel2@gmail.com>,
 "maz@kernel.org" <maz@kernel.org>, "david@redhat.com" <david@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Linuxarm <linuxarm@huawei.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "will@kernel.org" <will@kernel.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "james.morse@arm.com" <james.morse@arm.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "maran.wilson@oracle.com" <maran.wilson@oracle.com>,
 zhukeqian <zhukeqian1@huawei.com>,
 "wangxiongfeng \(C\)" <wangxiongfeng2@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Andrew,

> From: Andrew Jones [mailto:drjones@redhat.com]
> Sent: Tuesday, June 23, 2020 9:46 AM
> To: Salil Mehta <salil.mehta@huawei.com>
> Cc: qemu-devel@nongnu.org; qemu-arm@nongnu.org; peter.maydell@linaro.org;
> sudeep.holla@arm.com; gshan@redhat.com; mst@redhat.com; jiakernel2@gmail.=
com;
> maz@kernel.org; zhukeqian <zhukeqian1@huawei.com>; david@redhat.com;
> richard.henderson@linaro.org; Linuxarm <linuxarm@huawei.com>;
> eric.auger@redhat.com; james.morse@arm.com; catalin.marinas@arm.com;
> imammedo@redhat.com; pbonzini@redhat.com; mehta.salil.lnk@gmail.com;
> maran.wilson@oracle.com; will@kernel.org; wangxiongfeng (C)
> <wangxiongfeng2@huawei.com>
> Subject: Re: [PATCH RFC 01/22] arm/cpuhp: Add QMP vcpu params validation =
support
>=20
> On Sat, Jun 13, 2020 at 10:36:08PM +0100, Salil Mehta wrote:
> > For now, vcpu hotplug is only supported with single socket single threa=
d,
> > single die. NUMA is not supported either and everthing falls into singl=
e
> > node. Work to properly support these could be taken later once communit=
y
> > agrees with the base framework changes being presented to support ARM v=
cpu
> > hotplug in QEMU. Hence, these checks.
> >
> > Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
> > Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> > ---
> >  hw/arm/virt.c | 41 +++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 41 insertions(+)
> >
> > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > index 37462a6f78..5d1afdd031 100644
> > --- a/hw/arm/virt.c
> > +++ b/hw/arm/virt.c
> > @@ -2201,6 +2201,46 @@ static HotplugHandler
> *virt_machine_get_hotplug_handler(MachineState *machine,
> >      return NULL;
> >  }
> >
> > +static void virt_smp_parse(MachineState *ms, QemuOpts *opts)
> > +{
> > +    if (opts) {
> > +        unsigned cpus    =3D qemu_opt_get_number(opts, "cpus", 1);
> > +        unsigned sockets =3D qemu_opt_get_number(opts, "sockets", 1);
> > +        unsigned cores   =3D qemu_opt_get_number(opts, "cores", cpus);
> > +        unsigned threads =3D qemu_opt_get_number(opts, "threads", 1);
> > +        unsigned int max_cpus;
> > +
> > +        if (sockets > 1 || threads > 1) {
> > +            error_report("does not support more than one socket or thr=
ead");
> > +            exit(1);
> > +        }
> > +
> > +        if (cores !=3D cpus) {
> > +            error_report("cpu topology: "
> > +                         "sockets (%u) * cores (%u) * threads (%u) < "
> > +                         "smp_cpus (%u)",
> > +                         sockets, cores, threads, cpus);
> > +            exit(1);
> > +        }
> > +
> > +        max_cpus =3D qemu_opt_get_number(opts, "maxcpus", cpus);
> > +        if (sockets * cores * threads > max_cpus) {
> > +            error_report("cpu topology: "
> > +                         "sockets (%u) * cores (%u) * threads (%u) > "
> > +                         "maxcpus (%u)",
> > +                         sockets, cores, threads,
> > +                         max_cpus);
> > +            exit(1);
> > +        }
> > +
> > +        ms->smp.max_cpus =3D max_cpus;
> > +        ms->smp.sockets =3D sockets;
> > +        ms->smp.cpus =3D cpus;
> > +        ms->smp.cores =3D cores;
> > +        ms->smp.threads =3D threads;
> > +    }
> > +}
> > +
> >  /*
> >   * for arm64 kvm_type [7-0] encodes the requested number of bits
> >   * in the IPA address space
> > @@ -2266,6 +2306,7 @@ static void virt_machine_class_init(ObjectClass *=
oc,
> void *data)
> >      mc->nvdimm_supported =3D true;
> >      mc->auto_enable_numa_with_memhp =3D true;
> >      mc->default_ram_id =3D "mach-virt.ram";
> > +    mc->smp_parse =3D virt_smp_parse;
> >
> >      object_class_property_add(oc, "acpi", "OnOffAuto",
> >          virt_get_acpi, virt_set_acpi,
> > --
> > 2.17.1
> >
> >
> >
>=20
> Hi Salil,
>=20
> This patch and the whole series has inspired me to pick up the vcpu
> topology work again.=20


Thanks for looking into this QEMU series. I am glad to hear that this
work looks sensible at least :)


> In fact, I think it may be necessary in order
> to properly describe a cpu when hot[un]plugging.


Agreed. it is required. Since, MPIDR derived using topo specified by
the user should match that assigned by the KVM/Host(which derives it
using vcpu-id).=20


? I'll try to pull
> together an RFC soon, at least for TCG. For KVM, we may need to
> change KVM in order to allow user-controlled MPIDR. Although I'm
> not sure about that anymore, because, as you stated somewhere else,
> we already have user-controlled MPIDR to some degree, since KVM simply
> transforms the cpu index.


Yes, kind-of, if you actually see the KVM logic and how it derives the
MPIDR for vcpu in reset_mpidr() you will know that the only variable
it is using is vcpu-id which is specified by QEMU during the vcpu
creation time. This clearly means end MPIDR value is actually dependent
on QEMU and KVM/host just programs it. Of course user of the QEMU does
not have any direct interface and this is as of now done implicitly
at QEMU level.=20

But the thing which concerned me was the idea of threads. Marc recently
clarified about that aspect as well, that KVM always(with some exception
of thunderX) uses MT=3D0(a bit in MPIDR register) even for the hardware
which support threads. IMHO there has to be some way to distinguish
between threads and cores at the QEMU level whether QEMU fetches this
info using sysfs interface like lscpu etc does or devise some other way.
But QEMU should ensure that right thread/core info is being facilitated
to the guest kernel. This could either be done wrapped as part of the
MPIDR or PPTT Table.


>=20
> Regarding this patch specifically, I would change this to allow
> sockets, but prefer cores (i.e. when only '-smp N' is given, then
> N is the number of cores, not sockets). Also I would allow threads,
> but only for !kvm_enabled(). Then the function would be similar to
> something I think I once posted long ago, or at least wrote and maybe
> never posted...


Ok. We need to modify the logic to derive the arch-id/MPIDR using the
topology info instead of just vcpu-id. Hope you will be doing that
as well for TCG? and this will require check to distinguish the KVM and
TCG part there as well. I am specifically talking about {pre|post}_plug
functions. BTW, can 'N' (in -smp N) ever be sockets?


In case you require my help for anything like testing on real ARM64
server hardware or anything else please give a nudge and we can co-work
from here :)


Regarding kernel part, I will be posting the guest kernel changes
today to the community. If you have time please have a look at them
as well.


Many thanks
Salil.


