Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7FDFC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 10:20:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A9A72065F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 10:20:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A9A72065F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkmE2-0008Pb-RN
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 06:20:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1jkmDA-0007Qs-9a; Mon, 15 Jun 2020 06:19:28 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2111 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1jkmD7-0004Cv-D0; Mon, 15 Jun 2020 06:19:27 -0400
Received: from lhreml707-chm.china.huawei.com (unknown [172.18.7.107])
 by Forcepoint Email with ESMTP id 3514C5B3BE7FD9DBE8A5;
 Mon, 15 Jun 2020 11:19:17 +0100 (IST)
Received: from lhreml703-chm.china.huawei.com (10.201.108.52) by
 lhreml707-chm.china.huawei.com (10.201.108.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Mon, 15 Jun 2020 11:19:16 +0100
Received: from lhreml703-chm.china.huawei.com ([10.201.68.198]) by
 lhreml703-chm.china.huawei.com ([10.201.68.198]) with mapi id 15.01.1913.007; 
 Mon, 15 Jun 2020 11:19:16 +0100
From: Salil Mehta <salil.mehta@huawei.com>
To: Marc Zyngier <maz@kernel.org>
Subject: RE: [PATCH RFC 00/22] Support of Virtual CPU Hotplug for ARMv8 Arch
Thread-Topic: [PATCH RFC 00/22] Support of Virtual CPU Hotplug for ARMv8 Arch
Thread-Index: AQHWQcvNstQMr4/nnU2Xs7zxVVwVQKjX8OAAgAATnQA=
Date: Mon, 15 Jun 2020 10:19:16 +0000
Message-ID: <8204e74fbb494af0adedada40b18c97e@huawei.com>
References: <20200613213629.21984-1-salil.mehta@huawei.com>
 <38a034f82da78b8861af6d25a83fddea@kernel.org>
In-Reply-To: <38a034f82da78b8861af6d25a83fddea@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.75.150]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.76.210;
 envelope-from=salil.mehta@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 06:19:17
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
 "drjones@redhat.com" <drjones@redhat.com>,
 "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
 "gshan@redhat.com" <gshan@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jiakernel2@gmail.com" <jiakernel2@gmail.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 zhukeqian <zhukeqian1@huawei.com>, "david@redhat.com" <david@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Linuxarm <linuxarm@huawei.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "james.morse@arm.com" <james.morse@arm.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "mehta.salil.lnk@gmail.com" <mehta.salil.lnk@gmail.com>,
 "maran.wilson@oracle.com" <maran.wilson@oracle.com>,
 "will@kernel.org" <will@kernel.org>,
 "wangxiongfeng \(C\)" <wangxiongfeng2@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Marc,
Thanks for the review.

> From: Marc Zyngier [mailto:maz@kernel.org]
> Sent: Sunday, June 14, 2020 12:55 PM
>=20
> Hi Salil,
>=20
> On 2020-06-13 22:36, Salil Mehta wrote:
> > This patch-set introduces the virtual cpu hotplug support for ARMv8
> > architecture in QEMU. Idea is to be able to hotplug and hot-unplug the
> > vcpus
> > while guest VM is running and no reboot is required. This does *not*
> > makes any
> > assumption of the physical cpu hotplug availability within the host
> > system but
> > rather tries to solve the problem at virtualizer/QEMU layer and by
> > introducing
> > cpu hotplug hooks and event handling within the guest kernel. No
> > changes are
> > required within the host kernel/KVM.
> >
> > Motivation:
> > This allows scaling the guest VM compute capacity on-demand which would
> > be
> > useful for the following example scenarios,
> > 1. Vertical Pod Autoscaling[3][4] in the cloud: Part of the
> > orchestration
> >    framework which could adjust resource requests (CPU and Mem
> > requests) for
> >    the containers in a pod, based on usage.
> > 2. Pay-as-you-grow Business Model: Infrastructure provider could
> > allocate and
> >    restrict the total number of compute resources available to the
> > guest VM
> >    according to the SLA(Service Level Agreement). VM owner could
> > request for
> >    more compute to be hot-plugged for some cost.
> >
> > Terminology:
> >
> > (*) Present cpus: Total cpus with which guest has/will boot and are
> > available
> >                   to guest for use and can be onlined. Qemu
> > parameter(-smp)
> > (*) Disabled cpus: Possible cpus which will not be available for the
> > guest to
> >                    use. These can be hotplugged and made present. These
> > can be
> > 		   thought of as un-plugged vcpus. These will be included as
> > 		   part of sizing.
> > (*) Posssible cpus: Total vcpus which could ever exist in VM. This
> > includes
> >                     booted cpus plus any cpus which could be later
> > plugged.
> > 		    - Qemu parameter(-maxcpus)
> > 	            - Possible vcpus =3D Present vcpus (+) Disabled vcpus
> >
> >
> > Limitations of ARMv8 Architecture:
> >
> > A. Physical Limitation to CPU Hotplug:
> > 1. ARMv8 architecture does not support the concept of the physical cpu
> > hotplug.
> >    The closest thing which is recomended to achieve the cpu hotplug on
> > ARM is
> >    to bring down power state of the cpu using PSCI.
>=20
> It isn't so much that the ARMv8 architecture doesn't support CPU
> hotplug. It is that CPU hotplug is largely out of the scope of the ARMv8
> architecture, which is a CPU architecture and not a system architecture.
> Yes, the lack of a comprehensive system architecture is *very* annoying,
> but let's put the blame where it belongs... ;-)


Sure.

=20
> > 2. Other ARM components like GIC etc. have not been designed to realize
> >    physical cpu hotplug capability as of now.
> >
> > B. Limitations of GIC to Support Virtual CPU Hotplug:
> > 1. GIC requires various resources(related to GICR/redistributor,
> > GICC/cpu
> >    interface etc) like memory regions to be fixed at the VM init time
> > and these
> >    could not be changed later on after VM has inited.
> > 2. Associations between GICC(GIC cpu interface) and vcpu get fixed at
> > the VM
> >    init time and GIC does not allows to change this association once
> > GIC has
> >    initialized.
>=20
> There isn't an association, really. the GIC CPU interface is part of the
> CPU itself, and not an external entity. KVM doesn't split the two
> either. It is the association between the CPU and its redistributor that
> is being done. There is no architectural way to set this up this, so KVM
> just statically configures these based on the number of vcpus and the
> number/size of redistributor ranges.


I stand corrected. Sorry for the horrible mix up and I realized that some
how I copied the same terminology at other 2 other places as well, maybe
under sleep duress :(. I will correct it in later versions.

To be frank, I actually meant association of "mp-affinity" and the
"proc number" as given by GICR_TYPER register for the vgic. I guess reading
this register using kvm_gicr_acces/KVM_DEV_ARM_VGIC_GRP_REDIST_REGS from
QEMU lands up in vgic vgic_mmio_read_v3r_typer() which forms the reg value
using "vcpu-id" and "mpidr"(fetched from MPIDR_EL1).

Also, value of the MPIDR for vcpu is set during KVM_ARM_VCPU_INIT IOCTL
from QEMU after the creation of the vcpus(using KVM_CREATE_VCPU). I guess
this is done during reset of all of the system regs  SYS_MPIDR_EL1 value
is also reset to default within function reset_mpidr() derived using below
logic:

                   +----+----+----+----+----+----+----+----+
          MPIDR   |||  Res   |   Aff2  |   Aff1   |  Aff0    |
                   +----+----+----+----+----+----+----+----+
                                \          \          \   |     |
                                 \   8bit   \   8bit  \  |4bit|
                                  \<------->\<------->\|<-->|
                                   \          \          \|     |
                   +----+----+----+----+----+----+----+----+
         VCPU-ID  |  Byte4  |  Byte2   |  Byte1   |  Byte0  |
                   +----+----+----+----+----+----+----+----+

Perhaps once the VM is inited the value present in the MPIDR_EL1 for vcpu c=
annot
be changed and hence the vgic GICR_TYPER will have fixed association betwee=
n
"vcpu-id" and "mpidr" as well.




> > C. Known Limitation of the KVM:
> > 1. As of now KVM allows to create VCPUs but does not allows to delete
> > the
> >    already created vcpus. QEMU already provides an interface to manage
> > created
> >    vcpus at KVM level and then to re-use them.
> > 2. Inconsistency in interpretation of the MPIDR generated by KVM for
> > vcpus
> >    vis-a-vis SMT/threads. This does not looks to be compliant to the
> > MPIDR
> >    format(SMT is present) as mentioned in the ARMv8 spec. (Please
> > correct my
> >    understanding if I am wrong here?)
>=20
> I'm unsure of which part of the architecture KVM doesn't follow when
> assigning a MPIDR to a vcpu. By having MPIDR_EL1.MT to 0, KVM tells the
> guest OS that vcpus having the same Aff3-1 fields are mostly
> independent.
>=20
> This is because:
> - we make no placement guarantee whatsoever (this is userspace's
> business)
> - ARMv8.2 CPUs designed by ARM (as opposed to architecture licensees)
> always set this bit to 1 as they can hypothetically be coupled to SMT
> CPUs in a big-little system. This makes MT totally meaningless.
> - the one SMT implementation available in the wild (ThunderX-2) is
> broken enough that you really should consider turning SMT off (see
> CAVIUM_TX2_ERRATUM_219)
> - KVM actively prevents the sharing of resources such as TLBs across
> vcpus
>=20
> Given the above, I fail to see the point in setting the SMT bit to
> anything but 0.


ok. effectively this also means that even in the upcoming SoCs, which
might have SMT capability, the value of MT bit should continue to be 0
at the KVM level for the MPIDR of the vcpus?


> > Workaround to the problems mentioned in Section B & C1:
> > 1. We pre-size the GIC with possible vcpus at VM init time
> > 2. Pre-create all possible vcpus at KVM and associate them with GICC
>=20
> Again, I'm not sure what you mean here. The CPU interface is by
> construction associated with the CPU. Do you mean the redistributor?


Sorry for this mix-up. Yes, I meant the association between the mp-affinity
and the proc number as given by GICR_TYPER for vgic as explained earlier.


>=20
> > 3. Park the unplugged vcpus (similar to x86)
> >
> >
> > (*) For all of above please refer to Marc's suggestion here[1]
> >
> >
> > Overview of the Approach:
> > At the time of machvirt_init() we pre-create all of the possible ARMCPU
> > objects along with the corresponding KVM vcpus at the host. Disabled
> > KVM vcpu
> > (which are *not* "present" vcpus but are part of "possible" vcpu list)
> > are
> > parked at per VM list "kvm_parked_vcpus" after their initialization.
> >
> > We create the ARMCPU objects(but these are not *realized* in QOM sense)
> > even
> > for the disabled vcpus to facilitate the GIC initialization (pre-sized
> > with
> > possible vcpus). After Initialization of the machine is complete we
> > release
> > the ARMCPU Objects for the disabled vcpus. These ARMCPU object shall be
> > re-created at the time when vcpu is hot plugged. This new object is
> > then
> > re-attached with the earlier parked KVM vcpu which also gets unparked.
> > The
> > ARMCPU object gets now "realized" in QEMU, which means creation of the
> > corresponding threads, pre_plug/plug phases, and event notification to
> > the
> > guest using ACPI GED etc. Similarly, hot-unplug leg will lead to the
> > "unrealization" of the vcpus and will lead to similar ACPI GED events
> > to the
> > guest for unplug and cleanup and eventually ARMCPU object shall be
> > released and
> > KVM vcpus shall be parked again.
> >
> > During machine init, ACPI MADT Table is sized with *possible* vcpus
> > GICC
> > entries. The unplugged/disabled vcpus are presented as MADT GICC
> > DISABLED
> > entries to the guest. This means the guest will have its resources
> > pre-sized
> > with possible vcpus(=3Dpresent+disabled)
> >
> > Other approaches to deal with ARMCPU object release(after machine
> > init):
> > 1. The ARMCPU objects for the disabled vcpus are released in context to
> > the
> >    virt_machine_done() notifier(approach adopted in this patch-set).
> > 2. Defer the release of current ARMCPU object till the new vcpu object
> > is
> >    hot plugged.
> > 3. Never release and keep on reusing them and release once at VM exit.
> > This
> >    solves many problems with above 2 approaches but requires change in
> > the way
> >    qdev_device_add() fetches/creates the ARMCPU object for the new
> > vcpus being
> >    hotplugged. For the arm cpu hotplug case we need to figure out way
> > how to
> >    get access to old object and use it to "re-realize" instead of the
> > new
> >    ARMCPU object.
> >
> > Concerns/Questions:
> > 1. In ARM arch a cpu is uniquely represented in hierarchy using various
> >    affinity levels which could represent thread, core, cluster,
> > package. This
> >    is generally represented by a value in MPIDR register as per the
> > format
> >    mentioned in specification. Now, the way MPIDR value is derived for
> > vcpus is
> >    done using vcpu-index. The concept of thread is not quite as same
> > and rather
> >    gets lost in the derivation of MPIDR for vcpus.
>=20
> I think we disagree on what a thread is when MPIDR_EL1.MT=3D=3D0.
>=20
> > 2. The topology info used to specify the vcpu while hot-plugging might
> > not
> >    match with the MPIDR value given back by the KVM for the vcpu at the
> > time of
> >    init. Concept of SMT bit in MPIDR gets lost as per the derivation
> > being done
> >    in the KVM. Hence, concept of thread-id, core-id, socket-id if used
> > as a
> >    topology info to derive MPIDR value as per ARM specification will
> > not match
> >    with MPIDR actually assigned by the KVM?
>=20
> The architecture doesn't map the affinity levels on any of these
> concepts. They merely imply increased independence as you look at higher
> affinity levels. I don't see any value in exposing any meaning to them
> unless you start moving some notion of placement into the kernel, or
> allow userspace to setup MPIDR_EL1 by itself.


MPIDR_EL1 of the vcpu is effectively being derived by KVM using the
'vcpu-id' provided by the QEMU during vcpu creation/init time. so isn't it
kind of being indirectly configured by QEMU even now?

Also. I was wondering if it was safe to present hardware threads as cores
in the virtual topology being set at the QEMU level?


> >    Perhaps need to carry forward work of Andrew? please check here[2]
> > 3. Further if this info is supplied to the guest using PPTT(once
> > introduced in
> >    QEMU) or even derived using MPIDR shall be inconsistent with the
> > host vcpu.
> > 4. Any possibilities of interrupts(SGI/PPI/LPI/SPI) always remaining in
> >    *pending* state for the cpus which have been hot-unplugged? IMHO it
> > looks
> >    okay but will need Marc's confirmation on this.
>=20
> I don't see why interrupts wouldn't be pending if the storage resource
> still exists. Given that distributor and redistributors are persistent,
> it seems logical that pending bits stick around.

wouldn't they be migrated to some other vcpu after current vcpu to which
they are associated gets offlined as part of the cpu hot-unplug action?

Like in case of the NIC, it gets notified about this and the affinity is
changed so the interrupts should not remain pending. Is it something
different about storage?=20


>=20
> Slightly more selfish question: is there any kernel change associated
> with this series? I'd be perfectly happy to hear a "no!"... ;-)


Requires minimalistic change which amounts to:
1. Allocation of the logical cpu-id and associating with acpi-id/hw-id
   coming from qemu/ACPI Tables.
2. During init time parsing the MADT Table entries to get the exact count
   of the possible and present cpus. This as you know shall be used to
   size up the guest data structures. Most of this infrastructure already
   exist in smp.c but still requires some adjustment of the code.

I will be sharing these changes this week.


Many thanks

>=20
> Thanks,
>=20
>          M.
> --
> Jazz is not dead. It just smells funny...

