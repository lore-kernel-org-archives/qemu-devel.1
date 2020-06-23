Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B7AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 09:57:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE7D420724
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 09:57:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE7D420724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnfgO-00048c-5r
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 05:57:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44970)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1jnffo-0003dR-98; Tue, 23 Jun 2020 05:57:00 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2117 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1jnffl-0005VA-N4; Tue, 23 Jun 2020 05:57:00 -0400
Received: from lhreml708-chm.china.huawei.com (unknown [172.18.7.107])
 by Forcepoint Email with ESMTP id D015DC1205F14913C897;
 Tue, 23 Jun 2020 10:56:54 +0100 (IST)
Received: from lhreml703-chm.china.huawei.com (10.201.108.52) by
 lhreml708-chm.china.huawei.com (10.201.108.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 23 Jun 2020 10:56:54 +0100
Received: from lhreml703-chm.china.huawei.com ([10.201.68.198]) by
 lhreml703-chm.china.huawei.com ([10.201.68.198]) with mapi id 15.01.1913.007; 
 Tue, 23 Jun 2020 10:56:54 +0100
From: Salil Mehta <salil.mehta@huawei.com>
To: Andrew Jones <drjones@redhat.com>
Subject: RE: [PATCH RFC 00/22] Support of Virtual CPU Hotplug for ARMv8 Arch
Thread-Topic: [PATCH RFC 00/22] Support of Virtual CPU Hotplug for ARMv8 Arch
Thread-Index: AQHWQcvNstQMr4/nnU2Xs7zxVVwVQKjl6FsAgAAbB4A=
Date: Tue, 23 Jun 2020 09:56:54 +0000
Message-ID: <ae90783d37454d8b9f5a189098e6bbb7@huawei.com>
References: <20200613213629.21984-1-salil.mehta@huawei.com>
 <20200623091202.pbcbvwnk3pdvwyyy@kamzik.brq.redhat.com>
In-Reply-To: <20200623091202.pbcbvwnk3pdvwyyy@kamzik.brq.redhat.com>
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

> From: Andrew Jones [mailto:drjones@redhat.com]
> Sent: Tuesday, June 23, 2020 10:12 AM
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
> Subject: Re: [PATCH RFC 00/22] Support of Virtual CPU Hotplug for ARMv8 A=
rch
>=20
> On Sat, Jun 13, 2020 at 10:36:07PM +0100, Salil Mehta wrote:
> > This patch-set introduces the virtual cpu hotplug support for ARMv8
> > architecture in QEMU. Idea is to be able to hotplug and hot-unplug the =
vcpus
> > while guest VM is running and no reboot is required. This does *not* ma=
kes
> any
> > assumption of the physical cpu hotplug availability within the host sys=
tem
> but
> > rather tries to solve the problem at virtualizer/QEMU layer and by intr=
oducing
> > cpu hotplug hooks and event handling within the guest kernel. No change=
s are
> > required within the host kernel/KVM.
> >
> > Motivation:
> > This allows scaling the guest VM compute capacity on-demand which would=
 be
> > useful for the following example scenarios,
> > 1. Vertical Pod Autoscaling[3][4] in the cloud: Part of the orchestrati=
on
> >    framework which could adjust resource requests (CPU and Mem requests=
) for
> >    the containers in a pod, based on usage.
> > 2. Pay-as-you-grow Business Model: Infrastructure provider could alloca=
te and
> >    restrict the total number of compute resources available to the gues=
t VM
> >    according to the SLA(Service Level Agreement). VM owner could reques=
t for
> >    more compute to be hot-plugged for some cost.
> >
> > Terminology:
> >
> > (*) Present cpus: Total cpus with which guest has/will boot and are ava=
ilable
> >                   to guest for use and can be onlined. Qemu parameter(-=
smp)
> > (*) Disabled cpus: Possible cpus which will not be available for the gu=
est
> to
> >                    use. These can be hotplugged and made present. These=
 can be
> > 		   thought of as un-plugged vcpus. These will be included as
> > 		   part of sizing.
> > (*) Posssible cpus: Total vcpus which could ever exist in VM. This incl=
udes
> >                     booted cpus plus any cpus which could be later plug=
ged.
> > 		    - Qemu parameter(-maxcpus)
> > 	            - Possible vcpus =3D Present vcpus (+) Disabled vcpus
> >
> >
> > Limitations of ARMv8 Architecture:
> >
> > A. Physical Limitation to CPU Hotplug:
> > 1. ARMv8 architecture does not support the concept of the physical cpu =
hotplug.
> >    The closest thing which is recomended to achieve the cpu hotplug on =
ARM
> is
> >    to bring down power state of the cpu using PSCI.
> > 2. Other ARM components like GIC etc. have not been designed to realize
> >    physical cpu hotplug capability as of now.
> >
> > B. Limitations of GIC to Support Virtual CPU Hotplug:
> > 1. GIC requires various resources(related to GICR/redistributor, GICC/c=
pu
> >    interface etc) like memory regions to be fixed at the VM init time a=
nd these
> >    could not be changed later on after VM has inited.
> > 2. Associations between GICC(GIC cpu interface) and vcpu get fixed at t=
he VM
> >    init time and GIC does not allows to change this association once GI=
C has
> >    initialized.
> >
> > C. Known Limitation of the KVM:
> > 1. As of now KVM allows to create VCPUs but does not allows to delete t=
he
> >    already created vcpus. QEMU already provides an interface to manage =
created
> >    vcpus at KVM level and then to re-use them.
> > 2. Inconsistency in interpretation of the MPIDR generated by KVM for vc=
pus
> >    vis-a-vis SMT/threads. This does not looks to be compliant to the MP=
IDR
> >    format(SMT is present) as mentioned in the ARMv8 spec. (Please corre=
ct my
> >    understanding if I am wrong here?)
> >
> >
> > Workaround to the problems mentioned in Section B & C1:
> > 1. We pre-size the GIC with possible vcpus at VM init time
> > 2. Pre-create all possible vcpus at KVM and associate them with GICC
> > 3. Park the unplugged vcpus (similar to x86)
> >
> >
> > (*) For all of above please refer to Marc's suggestion here[1]
> >
> >
> > Overview of the Approach:
> > At the time of machvirt_init() we pre-create all of the possible ARMCPU
> > objects along with the corresponding KVM vcpus at the host. Disabled KV=
M vcpu
> > (which are *not* "present" vcpus but are part of "possible" vcpu list) =
are
> > parked at per VM list "kvm_parked_vcpus" after their initialization.
> >
> > We create the ARMCPU objects(but these are not *realized* in QOM sense)=
 even
> > for the disabled vcpus to facilitate the GIC initialization (pre-sized =
with
> > possible vcpus). After Initialization of the machine is complete we rel=
ease
> > the ARMCPU Objects for the disabled vcpus. These ARMCPU object shall be
> > re-created at the time when vcpu is hot plugged. This new object is the=
n
> > re-attached with the earlier parked KVM vcpu which also gets unparked. =
The
> > ARMCPU object gets now "realized" in QEMU, which means creation of the
> > corresponding threads, pre_plug/plug phases, and event notification to =
the
> > guest using ACPI GED etc. Similarly, hot-unplug leg will lead to the
> > "unrealization" of the vcpus and will lead to similar ACPI GED events t=
o the
> > guest for unplug and cleanup and eventually ARMCPU object shall be rele=
ased
> and
> > KVM vcpus shall be parked again.
> >
> > During machine init, ACPI MADT Table is sized with *possible* vcpus GIC=
C
> > entries. The unplugged/disabled vcpus are presented as MADT GICC DISABL=
ED
> > entries to the guest. This means the guest will have its resources pre-=
sized
> > with possible vcpus(=3Dpresent+disabled)
> >
> > Other approaches to deal with ARMCPU object release(after machine init)=
:
> > 1. The ARMCPU objects for the disabled vcpus are released in context to=
 the
> >    virt_machine_done() notifier(approach adopted in this patch-set).
> > 2. Defer the release of current ARMCPU object till the new vcpu object =
is
> >    hot plugged.
> > 3. Never release and keep on reusing them and release once at VM exit. =
This
> >    solves many problems with above 2 approaches but requires change in =
the
> way
> >    qdev_device_add() fetches/creates the ARMCPU object for the new vcpu=
s being
> >    hotplugged. For the arm cpu hotplug case we need to figure out way h=
ow to
> >    get access to old object and use it to "re-realize" instead of the n=
ew
> >    ARMCPU object.
> >
> > Concerns/Questions:
> > 1. In ARM arch a cpu is uniquely represented in hierarchy using various
> >    affinity levels which could represent thread, core, cluster, package=
. This
> >    is generally represented by a value in MPIDR register as per the for=
mat
> >    mentioned in specification. Now, the way MPIDR value is derived for =
vcpus
> is
> >    done using vcpu-index. The concept of thread is not quite as same an=
d rather
> >    gets lost in the derivation of MPIDR for vcpus.
> > 2. The topology info used to specify the vcpu while hot-plugging might =
not
> >    match with the MPIDR value given back by the KVM for the vcpu at the=
 time
> of
> >    init. Concept of SMT bit in MPIDR gets lost as per the derivation be=
ing
> done
> >    in the KVM. Hence, concept of thread-id, core-id, socket-id if used =
as a
> >    topology info to derive MPIDR value as per ARM specification will no=
t match
> >    with MPIDR actually assigned by the KVM?
> >    Perhaps need to carry forward work of Andrew? please check here[2]
> > 3. Further if this info is supplied to the guest using PPTT(once introd=
uced
> in
> >    QEMU) or even derived using MPIDR shall be inconsistent with the hos=
t vcpu.
> > 4. Any possibilities of interrupts(SGI/PPI/LPI/SPI) always remaining in
> >    *pending* state for the cpus which have been hot-unplugged? IMHO it =
looks
> >    okay but will need Marc's confirmation on this.
> > 5. If the ARMCPU object is released after the machine init, UEFI could =
call
> >    back virt_update_table() to re-build the ACPI tables which might nee=
d an
> >    ARMCPU object. Please check the discussion here[5]
> >
> >
> > Commands Used:
> >
> > A. Qemu launch commands to init the machine
> >
> > $ qemu-system-aarch64 --enable-kvm -machine virt,gic-version=3D3 \
> > -cpu host -smp cpus=3D4,maxcpus=3D6 \
> > -m 300M \
> > -kernel Image \
> > -initrd rootfs.cpio.gz \
> > -append "console=3DttyAMA0 root=3D/dev/ram rdinit=3D/init maxcpus=3D2 a=
cpi=3Dforce" \
> > -nographic \
> > -bios  QEMU_EFI.fd \
> >
> > B. Hot-(un)plug related commands
> >
> > # Hotplug a host vcpu(accel=3Dkvm)
> > $ device_add host-arm-cpu,id=3Dcore4,core-id=3D4
> >
> > # Hotplug a vcpu(accel=3Dtcg)
> > $ device_add cortex-a57-arm-cpu,id=3Dcore4,core-id=3D4
> >
> > # Delete the vcpu
> > $ device_del core4
> >
> > NOTE: I have not tested the current solution with '-device' interface. =
The
> use
> >       is suggested by Igor here[6]. I will test this in coming times bu=
t looks
> >       it should work with existing changes.
> >
> >
> > Sample output on guest after boot:
> >
> > $ cat /sys/devices/system/cpu/possible
> > 0-5
> > $ cat /sys/devices/system/cpu/present
> > 0-3
> > $ cat /sys/devices/system/cpu/online
> > 0-1
> > $ cat /sys/devices/system/cpu/offline
> > 2-5
> >
> >
> > Sample output on guest after hotplug of vcpu=3D4:
> >
> > $ cat /sys/devices/system/cpu/possible
> > 0-5
> > $ cat /sys/devices/system/cpu/present
> > 0-4
> > $ cat /sys/devices/system/cpu/online
> > 0-1,4
> > $ cat /sys/devices/system/cpu/offline
> > 2-3,5
> >
> > Note: vcpu=3D4 was explicitly 'onlined' after hot-plug
> > $ echo 1 > /sys/devices/system/cpu/cpu4/online
> >
> >
> > Repository:
> >  (*) QEMU changes for vcpu hotplug could be cloned from below site,
> >      https://github.com/salil-mehta/qemu.git virt-cpuhp-armv8/rfc-v1
> >
> >  (*) Guest Kernel changes required to co-work with the QEMU shall be po=
sted
> soon
> >      and repo made available at above site.
> >
> >
> > THINGS TO DO:
> >  (*) Migration support
> >  (*) TCG/Emulation support is not proper right now. Works to a certain =
extent
> >      but is not complete. especially the unrealize part in which there =
is a
> >      overflow of tcg contexts. The last is due to the fact tcg maintain=
s a
> >      count on number of context(per thread instance) so as we hotplug t=
he vcpus
> >      this counter keeps on incrementing. But during hot-unplug the coun=
ter
> is
> >      not decremented.
> >  (*) Support of hotplug with NUMA is not proper
> >  (*) CPU Topology right now is not specified using thread/core/socket b=
ut
> >      rather flatly indexed using core-id. This needs consideration[2].
> >  (*) Do we need PPTT Support for to specify right topology info to gues=
t about
> >      hot-plugged or unplugged vcpus?
> >  (*) Test cases
> >  (*) Docs need to be updated.
> >
> >
>=20
> Hi Salil,
>=20
> I realize this is just a preliminary posting and the approach hasn't been
> finalized, but maybe in a future posting we can put a lot of this
> information into a doc patch. I think we'll need good documentation for
> this feature to ensure we get it right and keep in maintained correctly.


Sure, let us do it once we converge on the concept.

Thanks
Salil.

