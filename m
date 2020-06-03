Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1212C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 13:49:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BD49207D5
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 13:49:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BD49207D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgTlM-0000Ua-UB
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 09:49:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55584)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1jgTkf-0008Br-2I; Wed, 03 Jun 2020 09:48:17 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2105 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1jgTkd-0002LI-HQ; Wed, 03 Jun 2020 09:48:16 -0400
Received: from lhreml707-chm.china.huawei.com (unknown [172.18.7.108])
 by Forcepoint Email with ESMTP id 638A09CB438B90F8D32B;
 Wed,  3 Jun 2020 14:48:11 +0100 (IST)
Received: from lhreml703-chm.china.huawei.com (10.201.108.52) by
 lhreml707-chm.china.huawei.com (10.201.108.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Wed, 3 Jun 2020 14:48:10 +0100
Received: from lhreml703-chm.china.huawei.com ([10.201.68.198]) by
 lhreml703-chm.china.huawei.com ([10.201.68.198]) with mapi id 15.01.1913.007; 
 Wed, 3 Jun 2020 14:48:10 +0100
From: Salil Mehta <salil.mehta@huawei.com>
To: Andrew Jones <drjones@redhat.com>
Subject: RE: [Question] Regarding PMU initialization within the QEMU for ARM
 VCPUs
Thread-Topic: [Question] Regarding PMU initialization within the QEMU for ARM
 VCPUs
Thread-Index: AdY3+/mIYt1+TQdDQmymnxAa7PkUWwBhkdKAAAS79tAAAMvMAAAC6ahg
Date: Wed, 3 Jun 2020 13:48:10 +0000
Message-ID: <5cb329f13566411eadfeca7c9a1b4bf5@huawei.com>
References: <b2e401cd17fe49d792d09b31bd726e35@huawei.com>
 <20200603093745.dwfb55ny34az7rez@kamzik.brq.redhat.com>
 <6bacdd359e504ed8924e67ed125bf15d@huawei.com>
 <20200603121606.bj3mjlqsstzbu7py@kamzik.brq.redhat.com>
In-Reply-To: <20200603121606.bj3mjlqsstzbu7py@kamzik.brq.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.30.55]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.76.210;
 envelope-from=salil.mehta@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 07:45:22
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, "mst@redhat.com" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Andrew,

> From: Andrew Jones [mailto:drjones@redhat.com]
> Sent: Wednesday, June 3, 2020 1:16 PM
> To: Salil Mehta <salil.mehta@huawei.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>; mst@redhat.com;
> qemu-devel@nongnu.org; eric.auger@redhat.com; qemu-arm@nongnu.org; Igor
> Mammedov <imammedo@redhat.com>
> Subject: Re: [Question] Regarding PMU initialization within the QEMU for =
ARM
> VCPUs
>=20
> On Wed, Jun 03, 2020 at 11:45:22AM +0000, Salil Mehta wrote:
> > Hi Andrew,
> > Many thanks for the reply.
> >
> > > From: Andrew Jones [mailto:drjones@redhat.com]
> > > Sent: Wednesday, June 3, 2020 10:38 AM
> > > To: Salil Mehta <salil.mehta@huawei.com>
> > > Cc: qemu-devel@nongnu.org; qemu-arm@nongnu.org; Peter Maydell
> > > <peter.maydell@linaro.org>; Igor Mammedov <imammedo@redhat.com>;
> > > mst@redhat.com
> > > Subject: Re: [Question] Regarding PMU initialization within the QEMU =
for ARM
> > > VCPUs
> > >
> > > On Mon, Jun 01, 2020 at 03:04:33PM +0000, Salil Mehta wrote:
> > > > Hello,
> > > > I could see below within function fdt_add_pmu_nodes() part of
> > > > hw/arm/virt.c during virt machine initialization time:
> > > >
> > > > Observation:
> > > > In below function, support of PMU feature is being checked for
> > > > each vcpu and if the PMU is found part of the features then PMU
> > > > is initialized with in the host/KVM. But if there is even one
> > > > vcpu which is found to not support the PMU then loop is exited
> > > > and PMU is not initialized for the rest of the vcpus as well.
> > > >
> > > > Questions:
> > > > Q1. Not sure what is the logic of the premature exit and not
> > > >     continuing with further checks and initialization of other
> > > >     VCPU PMUs?
> > >
> > > KVM requires all VCPUs to have a PMU if one does. If the ARM ARM
> > > says it's possible to have PMUs for only some CPUs, then, for TCG,
> > > the restriction could be relaxed. I expect it will take more than
> > > just removing the check for things to work though.
> >
> > Got it. Many thanks for this info.
> >
> > During virt machine init we take cpu type from (-cpu <cpu-type>)
> > option and it should apply evenly to all of the vcpus. Therefore,
> > I can assume all of the processors to be identical for now. This
> > combined with the KVM restriction you mentioned above means for
> > PMU we could only have Enable-for-All OR Enable-for-none config
> > for all of the vcpus being booted even though we at different
> > places do have per-vcpu specific check like below available
> >
> > /* MADT */
> > static void
> > build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vm=
s)
> > {
> > [...]
> >
> >     for (i =3D 0; i < vms->smp_cpus; i++) {
> >         AcpiMadtGenericCpuInterface *gicc =3D acpi_data_push(table_data=
,
> >                                                            sizeof(*gicc=
));
> >         [...]
> >
> >         if (arm_feature(&armcpu->env, ARM_FEATURE_PMU)) {---> This chec=
k
> >             gicc->performance_interrupt =3D
> cpu_to_le32(PPI(VIRTUAL_PMU_IRQ));
> >         }
> >  [...]
> > }
> >
> > Do per-vcpu feature check for PMU even makes sense till we allow
> > heterogeneous support of processors or relax the PMU enablement
> > on the per-vcpu basis within the KVM?
>=20
> It may not be necessary now or ever to test more than one CPU for the
> PMU feature, but without a good reason to change it to a machine
> property then I'd prefer we always to the N-1 pointless checks. The
> feature is a CPU feature, not a machine feature, so, IMO, it should
> remain something configured and tested at the CPU level, not the machine
> level.


I do understand this and all looks logical what you have said.

Yes, there is a reason for this (but not sure if that is
convincing enough) but having an added flag at per-machine level
will help in supporting ARM VCPU Hotplug feature I am dealing with.

Just a summary to give you a context of vcpu hotplug design:

As per the design, at the time of machvirt_init() we pre-create
the ARMCPU objects along with the corresponding KVM vcpus at the
host. KVM vcpu initialized context(struct kvm_parked_vcpus) for the
disabled vcpus is parked at per VM list kvm_parked_vcpus.=20

We create the ARMCPU objects(but these are not *realized* in qdev
sense) to facilitate the GIC initialization (pre-sized with possible
vcpus) with minimum change. After Initialization of the machine is
complete we release the ARMCPU Objects for the disabled vcpus(which
shall be re-created at the time when vcpu is hot plugged and
at that time we re-attach this new ARMCPU object with already
parked KVM VCPU context).=20

So we have few options related to ARMCPU object release:
1. The ARMCPU objects for the disabled vcpus are released in
   context to the virt_machine_done() notifier.=20
2. Defer release till a new vcpu object is hot plugged.
3. Never release and keep on reusing them and release once
   at VM exit.

Each of the above approaches come with  their own pros and cons.
(And I have prototyped each)

1st case looks more cleaner but the only problem we are facing
is after ARMCPUs are released and later during UEFI takes over,
it could again call the QEMU virt_acpi_build_update() to update
the ACPI tables(which UEFI has patched) which further ends up in
build_dsdt()->build_madt() path and leads to a problem since
disabled ARMCPU object are not available as they were released
earlier in context of virt_machine_done().=20

The problem happens in MADT which  needs per-vcpu PMU feature
check  to decide whether to enable it in the GICC MDAT entry.

Perhaps the problem is that maybe we are going against some
design expectations and we should not be releasing the ARMCPU
at all as firmware is dependent on it. And maybe UEFI and QEMU
have some sort of coupled design which does not helps.



> > > > Q2. Does it even makes sense to have PMUs initialized for some
> > > >     vcpus and not for others unless we have heterogeneous system?
> > >
> > > I don't know, but it doesn't sound like a configuration I'd like
> > > to see.
> >
> >
> > sure. but in the existing code we do prematurely exit after we
> > discover first vcpu amongst the possible vcpus not supporting
> > PMU feature. This looks abnormal as well?
>=20
> Are you trying to configure heterogeneous mach-virt machines? Or machines
> that only provide PMUs to some CPUs?

No, I am not rather assuming identical/homogenous processing.

 If not, then I'm not sure why this
> would be a problem. Indeed it's likely a pointless check and, instead of
> silently returning, it should output a warning or even assert. Otherwise,
> I don't see a problem with it, since we want to be sure we're dealing wit=
h
> the type of configuration we expect, i.e. one where each CPU has a PMU if
> any CPU has a PMU.

It is not exactly a problem and as you said a rather pointless check
present. But as explained I was trying to check if we could have
a per-machine flag to devise a workaround for the PMU for now and have
the design(above 3 approaches discussed) of the vcpu hotplug discussed
as part of the patches which I have almost prepared.

(Maybe I should float the ARM VCPU Hotplug patches and let this
 discussion be held over there?)

Many thanks,
Salil.

