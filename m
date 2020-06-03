Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73270C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 15:14:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38AF5206E6
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 15:14:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38AF5206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgV6D-0003m1-F9
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 11:14:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1jgV5C-0002cy-Cd; Wed, 03 Jun 2020 11:13:34 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2107 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1jgV5A-000723-6N; Wed, 03 Jun 2020 11:13:33 -0400
Received: from lhreml703-chm.china.huawei.com (unknown [172.18.7.108])
 by Forcepoint Email with ESMTP id DCA0DF28C3F27F1FD47F;
 Wed,  3 Jun 2020 16:13:26 +0100 (IST)
Received: from lhreml703-chm.china.huawei.com (10.201.108.52) by
 lhreml703-chm.china.huawei.com (10.201.108.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Wed, 3 Jun 2020 16:13:26 +0100
Received: from lhreml703-chm.china.huawei.com ([10.201.68.198]) by
 lhreml703-chm.china.huawei.com ([10.201.68.198]) with mapi id 15.01.1913.007; 
 Wed, 3 Jun 2020 16:13:26 +0100
From: Salil Mehta <salil.mehta@huawei.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: RE: [Question] Regarding containers "unattached/peripheral/anonymous"
 - their relation with hot(un)plug of devices
Thread-Topic: [Question] Regarding containers
 "unattached/peripheral/anonymous" - their relation with hot(un)plug of
 devices
Thread-Index: AdXSpuyfn6DVS59zTi+rGkiX0i4oLAAFtBwAAADWJeAAA8wjgAACyCnAAJHlbgAAZ8bfMA==
Date: Wed, 3 Jun 2020 15:13:26 +0000
Message-ID: <ab94a6dec7b9435cbb36ca9d488a0daa@huawei.com>
References: <70446b6cbf5442488a40fe809f38c3c8@huawei.com>
 <20200124145404.1d15209e@redhat.com>
 <77dbc712482545078986adcd72567630@huawei.com>
 <20200124170645.3d794ac6@redhat.com>
 <b8fccc99d7344b2485c0db76886af9c8@huawei.com>
 <20200127160352.54f95875@redhat.com>
In-Reply-To: <20200127160352.54f95875@redhat.com>
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
Cc: Andrew Jones <drjones@redhat.com>, "gshan@redhat.com" <gshan@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, pbonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Igor,
My sincere Apologies, I just realized that I missed to reply this mail.
I was distracted to something else in  the month of the February and
had only resumed working on hotplug in march. But will still reply to
this mail. Also, I have incorporated most of the below points as in the
vcpu hotplug patches as per your suggestions.


> From: Qemu-arm [mailto:qemu-arm-bounces+salil.mehta=3Dhuawei.com@nongnu.o=
rg]
> On Behalf Of Igor Mammedov
> Sent: Monday, January 27, 2020 3:04 PM
> To: Salil Mehta <salil.mehta@huawei.com>
>=20
> On Fri, 24 Jan 2020 18:44:16 +0000
> Salil Mehta <salil.mehta@huawei.com> wrote:
>=20
> > > From: Igor Mammedov [mailto:imammedo@redhat.com]
> > > Sent: Friday, January 24, 2020 4:07 PM
> > >
> > > On Fri, 24 Jan 2020 15:02:10 +0000
> > > Salil Mehta <salil.mehta@huawei.com> wrote:
> > >
> > > > > From: Igor Mammedov [mailto:imammedo@redhat.com]
> > > > > Sent: Friday, January 24, 2020 1:54 PM
> > > > > To: Salil Mehta <salil.mehta@huawei.com>
> > > > >
> > > > > On Fri, 24 Jan 2020 11:20:15 +0000
> > > > > Salil Mehta <salil.mehta@huawei.com> wrote:
> > > > >
> > > > > > Hello,
> > > > > > I am working on vCPU Hotplug feature for ARM64 and I am in mid =
of understanding
> > > > > > some aspect of device_add/device_del interface of the QEMU.
> > > > > >
> > > > > > Observations:
> > > > > > 1. Any object initialised by qmp_device_add() gets into /machin=
e/unattached
> > > > > > container. I traced the flow to code leg inside  device_set_rea=
lized()
> > > > > > 2. I could see the reverse qmp_device_del() expects the device =
to be in
> > > > > > /machine/peripheral container.
> > > > > > 3. I could see any object initially added to unattached contain=
er did not had
> > > > > > their parents until object_add_property_child() was called furt=
her in the leg.
> > > > > > which effectively meant a new property was created and property=
 table
> > > > > > populated and child was parented.
> > > > > > 4. Generally, container  /machine/peripheral was being used whe=
rever
> > > > > > DEVICE(dev)->id was present and non-null.
> > > > > >
> > > > > > Question:
> > > > > > 1. Wanted to confirm my understanding about the use of having s=
eparate
> > > > > > containers like unattached, peripheral and anonymous.
> > > > >
> > > > > > 2. At init time all the vcpus goes under *unattached* container=
. Now,
> > > > > > qmp_device_del() cannot be used to unplug them. I am wondering
> > > > >
> > > > > device is put into 'unattached' in case it wasn't assigned a pare=
nt.
> > > > > Usually it happens when board creates device directly.
> > > >
> > > >
> > > > Sure, but if we decide that certain number(N) of vcpus are hotpluga=
bble
> > > > and certain subset of N (say 'n' < 'N') should be allowed to be pre=
sent
> > > > or cold-plugged at the init time then I wonder which of the followi=
ng
> > > > is correct approach:
> > > >
> > > > 1. Bring all of N vcpus at boot time under "peripheral" container
> > > >                                    OR
> > > > 2. Just bring subset 'n' of 'N' under "peripheral" container and re=
st
> > > >     under "unattached" container? And later as and when rest of the
> > > >     vcpus are hotplugged they should be transferred from "unattache=
d"
> > > >     container to "peripheral" container?
> > >
> > > issue with that is that to put device into "peripheral" container,
> > > 'the user' must provide 'id'. (currently QEMU isn't able to do it on =
its own
> > > [1])
> > >
> > > But it doesn't mean that cold-plugged CPUs can't be unpluged.
> > > What current users could do is start QEMU like this (simplified versi=
on):
> > >
> > >  $QEMU -smp 1,maxcpus=3DN -device foo-cpu-type,id=3DCPU00 -device
> > > foo-cpu-type,id=3DCPU01 ...
> > >
> > > i.e. 1st CPU is not manageable due to lack if 'id' and is created by =
board code,
> > > the rest have 'id' and could be managed.
> >
> >
> > I understand, that we can somehow assign ids from the QMP interface but
> > above will not push vcpus into "peripheral" container. They will appear
> > in "unattached" container but with specified names and as-far-as I can
> > see in the code 'device_del' can only delete objects/devices from the
> > 'peripheral' container?
>=20
> qemu-system-x86_64 -monitor stdio \
>     -smp 1,maxcpus=3D3 \
>     -device qemu64-x86_64-cpu,id=3Dfoo,socket-id=3D1,core-id=3D0,thread-i=
d=3D0 \
>     -device qemu64-x86_64-cpu,socket-id=3D2,core-id=3D0,thread-id=3D0
>=20
> (qemu) info hotpluggable-cpus
> Hotpluggable CPUs:
>   type: "qemu64-x86_64-cpu"
>   vcpus_count: "1"
>   qom_path: "/machine/peripheral-anon/device[0]"
>                       ^^^^^^^^^^^^^^^
>   CPUInstance Properties:
>     socket-id: "2"
>     core-id: "0"
>     thread-id: "0"
>   type: "qemu64-x86_64-cpu"
>   vcpus_count: "1"
>   qom_path: "/machine/peripheral/foo"
>                       ^^^^^^^^^^
>=20
> in gist, if device is created with any variant of device_add,
> it goes to "peripheral[-anon]" including cold-plugged one.


I am not sure why you said "including cold-plugged one"? I hope by
cold-plug'ging you mean here are the CPUs which already exist at
the boot time of the Guest VM and plugged using -device?


>   CPUInstance Properties:
>     socket-id: "1"
>     core-id: "0"
>     thread-id: "0"
>   type: "qemu64-x86_64-cpu"
>   vcpus_count: "1"
>   qom_path: "/machine/unattached/device[0]"
                          ^^^^^^^^^^^^^

Unless you have pasted wrongly here, above output also shows qom path
as 'unattached' for cold-plugged CPUs. Am I missing something? :)


>   CPUInstance Properties:
>     socket-id: "0"
>     core-id: "0"
>     thread-id: "0"



> > Plus, having those many ids specified for over large number of vcpus
> > does not looks very practical solution. We need interface like auto
> number of IDs is not a problem since it's usually handled by management
> software just fine (ex: libvirt does it)
>=20
> > Generation of ids even at the boot time. I could see from the link you
> > have shared that it is already being used by ID_BLOCK subsystem. Can we
> > create a new subsystem for cpus under this and do the auto Generation
> > of vcpu ids as well?
>=20
> I'm not sure that auto ids was actually merged.
> (I thought it wasn't)


Well if you were referring to below then it has been part of qemu for quite
long now:

Patch: util - add automated ID generation utility
File: https://github.com/qemu/qemu/blob/master/util/id.c
Commit-id: https://github.com/qemu/qemu/commit/a0f1913637e6


> Anyway auto IDs are not directly related to enabling CPU hotplug for ARM,
> if you feel they should be generated you can try to propose patches.

Sure.=20


> > Plus, there is another unique requirement specifically for realizing
> > vcpu hotplug for ARM64.
> >
> > Summary:
> > Right now ARM architecture does not allows reinitializing the GIC
> > after VM has booted. Therefore, we are planning to pre-size the GIC
> > interfaces at init time by initializing all of the possible vcpus
> > and keep them in 'realized' but 'unavailable' state to the Guest
> > VM. They shall be made available as-and-when vcpus are hot-plugged
> > later-on. Therefore, current efforts are to be able to plug and
> > unplug from the qemu QOM without destroying the existing state of
> > the devices/objects representing vcpus. These all possible vcpus
> > shall be created once at the boot time of the VM. The vcpus which
> > are not available to the Guest VM can be Parked.
> >
> > Once the vcpus are hot-(un)plug'ged only the (pre-)plug/unplug(-request=
)
> > interfaces are used to convey this even information to the Guest
> > VM.
> >
> > I have tested this solution and it works but I wanted to make sure
> > that I am not doing anything which breaks any of the existing Qemu
> > QOM interfaces and basic fundamental idea behind being able to attach
> > and detach from the Qemu QOM is okay?
> >
> > Any suggestion are welcome in this regard?
>=20
> From discussion with Drew [CCed], I got that kvm/arm isn't designed
> to support vCPU hotplug (and it would require heavy refactoring to
> separate GIC and VCPUs, which probably won't be welcomed by maintainers).

Agreed. I have pre-sized GIC with possible vcpus. I think Marc did
mention about this earlier.

>=20
> But that's only KVM side of the equation. Assuming that we don't
> touch KVM much, the only QEMU side is left.
>=20
> Further lets call
>  * vCPU - a kvm's part of CPU
>  * CPU - QEMU object which is linked to vCPU via file descriptor.
>=20
> In QEMU we have CPU devices which optionally might create vCPUs
> during device realize time (if QEMU runs with KVM accelerator).
>=20
> So from design point of view, I'd suggest to dynamically
> create/remove CPU devices on demand using existing
>  -device/device_add/device_del interface
> like we do for other architectures.
>=20
> But in case of running with KVM accelerator, to accommodate
> current non dynamic ARM/KVM, I'd move vCPU creation to "kvm_init()"
> time or board init time, so it would pre-create vCPUs in
> KVM early in parked state and put them in 'kvm_parked_vcpus' list
> but won't create CPU devices for them.


Something similar. But I am doing it from virt machine init.


> Then later when management adds CPU device either with
> '-device' or 'device_add', a new CPU device will pick up
> pre-created parked vCPU file descriptor and re-use it.
>=20
> Parked vCPU infrastructure is already exists in QEMU as we use it
> for hot-unplugged CPUs for the same reasons (it needs too much
> refactoring on KVM side to really remove vCPU).

Agreed with respect to KVM change. I have added some new in qemu/kvm
layer but some re-factoring might be needed later to extract common
code. Also, ARM arch specific functions had to be introduced.

>=20
> So when CPU is hot-unplugged, we put linked vCPU file descriptor
> into kvm_parked_vcpus (see: kvm_destroy_vcpu) and completely delete
> CPU device on QEMU side. Then when the same CPU is hot-plugged again,
> we reuse previously parked vCPU file descriptor (see: kvm_get_vcpu).


Yes, I have done exactly this and perhaps this approach was discussed
in earlier mail-chains as well involving you. So taken your suggestion
and many thanks for this :)


> > NOTE: I plan to share the patches with the community which includes
> > both the changes of the Linux Kernel and the QEMU in near future.


Plan to share a RFC within a week for sure.=20


> > > 1) here is what I could find on IDs topic
> > >    https://lists.gnu.org/archive/html/qemu-block/2015-09/msg00011.htm=
l
> > >
> > > > > >    if all the hotplug devices need to go under the *peripheral*=
 container while
> > > > > > they are hotplugged and during object init time as well?
> > > > >
> > > > > theoretically device_del may use QOM path (the later users can ge=
t with
> > > > > query-hotpluggable-cpus),
> > > > > but I think it's mostly debugging feature.
> > > >
> > > >
> > > > Sure.
> > > >
> > > >
> > > > > users are supposed to specify 'id' during -device/device_add if t=
hey are going
> > > > > to manage that device.
> > > > > afterwards (like unplugging it). Then they could use that 'id' in=
 other commands
> > > > > (including device_del)
> > > > >
> > > > > So 'id'-ed devices end up in 'peripheral' container.
> > > >
> > > >
> > > > Sure, what if hotplugged device is removed and then added again? It=
 looks
> > > > qmp_device_add() interface will again end up calling the device_set=
_realized()
> > > > which eventually would put hotplugged devices under "unattached" co=
ntainer?
> > >
> > > it won't, see call chain:
> > >
> > >   qmp_device_add()
> > >       -> qdev_device_add()
> > >           -> qdev_set_id()
> >
> > Ok, sure. I did see the qdev_set_id() interface. Infact, earlier I was =
actually
> > trying to play with it by making it more generic and adding even the 'u=
nattached'
> > container handling to it(which is missing right now) and calling it ins=
ide the
> > device_set_realized()  instead of below code:
> >
> >         if (!obj->parent) {
> >             gchar *name =3D g_strdup_printf("device[%d]", unattached_co=
unt++);
> >
> >             object_property_add_child(container_get(qdev_get_machine(),
> >                                                     "/unattached"),
> >                                       name, obj, &error_abort);
> >             unattached_parent =3D true;
> >             g_free(name);
> >         }
> >
> > Idea of above dabbling was to have common interface for 'unattached' co=
ntainer
> > and call it from virt.c from machvirt_init() where possible vcpus are b=
eing
> > created. Force them to be located either inside 'unttached' or 'periphe=
ral'
> > container akin to the example you had given.
> >
> > If we look at qdev_device_add() function, after setting dev->id using
> > qdev_set_id() (which would also result in parenting of an object under
> > 'peripheral' container), it calls the function to 'realize' the device/=
object
> > which would end up in hitting above shared code excerpt and now because
> > it will have the parent already set, the object won't go into 'unattach=
ed'
> > container.
> >
> > Currently, later cannot be controlled for the cold-lugged vcpus. Theref=
ore,
> > before this discussion my initial thought process was to either make
> > qdev_set_id() universal (i.e. include handling for all type of containe=
rs
> > unattached/peripheral/anonymous in qdev_set_id()). Then call it from
> > machvirt_init() just before the vcpus have been 'realized' so that
> > cold-plugged cpus could get into 'peripheral' container. This would hel=
p
> > in hot-unplugging using the standard 'device_del' interface.
>=20
> I think we understand cold-plugged vcpus differently.
> From QEMU point of view there are 2 kinds of cold-plugged CPU devices.
>=20
> Ones that are currently created by board directly following pattern
>=20
>  object_new()
>  set properties
>  relalize
>=20
> these are created (lets call them builtin) in amount specified by -smp X
> and are not manageable by external applications.
>=20
> The second kind of cold-plugged CPUs are the ones created on command
> line with help of:
>=20
>  -device cpu-type-foo
>=20
> these are created by management applications and could be hot-removed
> if management supplied 'id'. For example libvirt starts qemu with 1
> built-in cpu in paused mode (-s) QEMU, then it hotplugs via QMP N cpus
> and lets VM run (it's essentially the same as using -device on CLI).
> This way it can remove all CPUs except of 1st one which is good enough
> in almost all the cases.
>=20

Sure, I can see your point. I have tried to incorporate part of it.
Maybe you would like to check the code which will be sent soon.


Many thanks
Salil


