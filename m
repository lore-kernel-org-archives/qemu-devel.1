Received: from eggs.gnu.org ([2001:4830:134:3::10]:33674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eYO2p-0000EM-Gd
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 22:24:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eYO2l-0006Ze-E2
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 22:24:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56738)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1eYO2l-0006XC-4x
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 22:24:11 -0500
References: <20171222064151.29266-1-tiwei.bie@intel.com>
	<fcf3858e-6643-350c-37b9-71698f1d26a5@redhat.com>
	<20180104061853.jkdzbueashv2klka@debian-xvivbkq.sh.intel.com>
	<aca10596-f8d4-417e-26b6-ed09ef766552@redhat.com>
	<D0158A423229094DA7ABF71CF2FA0DA34E845FAD@SHSMSX104.ccr.corp.intel.com>
	<a1319915-6492-af8d-a35d-5aedad61eb76@redhat.com>
	<D0158A423229094DA7ABF71CF2FA0DA34E84629B@SHSMSX104.ccr.corp.intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <238ebde1-0fca-9472-ae4e-1d5e67ff6606@redhat.com>
Date: Mon, 8 Jan 2018 11:23:48 +0800
MIME-Version: 1.0
In-Reply-To: <D0158A423229094DA7ABF71CF2FA0DA34E84629B@SHSMSX104.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [virtio-dev] [RFC 0/3] Extend vhost-user to
 support VFIO based accelerators
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liang, Cunming" <cunming.liang@intel.com>, "Bie, Tiwei" <tiwei.bie@intel.com>
Cc: "Tan, Jianfeng" <jianfeng.tan@intel.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "mst@redhat.com" <mst@redhat.com>, "Daly, Dan" <dan.daly@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "Wang, Xiao W" <xiao.w.wang@intel.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "Wang, Zhihong" <zhihong.wang@intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>



On 2018=E5=B9=B401=E6=9C=8805=E6=97=A5 18:25, Liang, Cunming wrote:
>
>> -----Original Message-----
>> From: Jason Wang [mailto:jasowang@redhat.com]
>> Sent: Friday, January 5, 2018 4:39 PM
>> To: Liang, Cunming <cunming.liang@intel.com>; Bie, Tiwei
>> <tiwei.bie@intel.com>
>> Cc: Tan, Jianfeng <jianfeng.tan@intel.com>; virtio-dev@lists.oasis-ope=
n.org;
>> mst@redhat.com; qemu-devel@nongnu.org; alex.williamson@redhat.com;
>> Wang, Xiao W <xiao.w.wang@intel.com>; stefanha@redhat.com; Wang,
>> Zhihong <zhihong.wang@intel.com>; pbonzini@redhat.com; Daly, Dan
>> <dan.daly@intel.com>
>> Subject: Re: [Qemu-devel] [virtio-dev] [RFC 0/3] Extend vhost-user to =
support
>> VFIO based accelerators
>>
>>
>>
>> On 2018=E5=B9=B401=E6=9C=8805=E6=97=A5 14:58, Liang, Cunming wrote:
>>>> Thanks for the pointer. Looks rather interesting.
>>>>
>>>>> We're also working on it (including defining a standard device for
>>>>> vhost data path acceleration based on mdev to hide vendor specific
>>>>> details).
>>>> This is exactly what I mean. Form my point of view, there's no need
>>>> for any extension for vhost protocol, we just need to reuse qemu
>>>> iothread to implement a userspace vhost dataplane and do the mdev
>> inside that thread.
>>> On functional perspective, it makes sense to have qemu native support=
 of
>> those certain usage. However, qemu doesn't have to take responsibility=
 for
>> dataplane. There're already huge amounts of codes for different device=
s
>> emulation, leveraging external dataplane library is an effective way t=
o
>> introduce more.
>>
>> This does not mean to drop external dataplane library. Actually, you c=
an link
>> dpdk to qemu directly.
> It's not a bad idea, then the interface comes to be new API/ABI definit=
ion of external dataplane library instead of existing vhost protocol.

These API/ABI should be qemu internal which should be much flexible than=20
vhost-user.

>   dpdk as a library is not a big deal to link with, customized applicat=
ion is.
> In addition, it will ask for qemu to provide flexible process model the=
n. Lots of application level features (e.g. hot upgrade/fix) becomes burd=
en.

Don't quite get this, I think we can solve this by migration. Even if a=20
dpdk userspace backend can do this, it can only do upgrade and fix for=20
network datapath. This is not a complete solution obviously.

It's nice to discuss this but it was a little bit out of the topic.

> I'm open to that option, keep eyes on any proposal there.
>
>>> The beauty of vhost_user is to open a door for variable userland
>> workloads(e.g. vswitch). The dataplane connected with VM usually need =
to
>> be close integrated with those userland workloads, a control place
>> interface(vhost-user) is better than a datapath interface(e.g. provide=
d by
>> dataplace in qemu iothread).
>>
>> Do we really need vswitch for vDPA?
> Accelerators come into the picture of vswitch, which usually provides i=
n-chip EMC for early classification. It gives a fast path for those throu=
ghput sensitive(SLA) VNF to bypass the further table lookup. It co-exists=
 other VNF whose SLA level is best effort but requires more functions(e.g=
. stateful conntrack, security check, even higher layer WAF support) supp=
ort, DPDK based datapath still boost the throughput there. It's not used =
to be a single choice of dedicated or shared datapath, usually they're co=
-exist.

So if I understand this correctly, the "vswtich" here is a hardware=20
function (something like smart NICs or OVS offloaded). So the question=20
still, is vhost-user a must in this case?

>
>>>    On workloads point of view, it's not excited to be part of qemu pr=
ocess.
>> Don't see why, qemu have dataplane for virtio-blk/scsi.
> Qemu has vhost-user for scsi too. I'm not saying which one is bad, just=
 point out sometime it's very workloads driven. Network is different with=
 blk/scsi/crypto.

What's the main difference from your point of view which makes=20
vhost-user a must in this case?

>>> That comes up with the idea of vhost-user extension. Userland workloa=
ds
>> decides to enable accelerators or not, qemu provides the common contro=
l
>> plane infrastructure.
>>
>> It brings extra complexity: endless new types of messages and a huge b=
runch
>> of bugs. And what's more important, the split model tends to be less e=
fficient
>> in some cases, e.g guest IOMMU integration. I'm pretty sure we will me=
et
>> more in the future.
> vIOMMU relevant message has been supported by vhost protocol. It's inde=
pendent effort there.

The point is vIOMMU integration is very inefficient in vhost-user for=20
some cases. If you have lots of dynamic mappings, it can have only=20
5%-10% performance compared to vIOMMU disabled. A huge amount of=20
translation request will be generated in this case. The main issue here=20
is you can not offload datapath completely to vhost-user backends=20
completely, IOMMU translations were still done in qemu. This is one of=20
the defect of vhost-user when datapath need to access the device state.

> I don't see this patch introduce endless new types.

Not this patch but we can imagine vhost-user protocol will become=20
complex in the future.

> My taking of your fundamental concern is about continues adding new fea=
tures on vhost-user.
> Feel free to correct me if I misunderstood your point.

Unfortunately not, endless itself is not a problem but we'd better only=20
try to extend it only when it was really needed. The main questions are:

1) whether or not we need to split things like what you suggested here?
2) if needed, is vhost-user the best method?

>
>>>>> And IMO it's also not a bad idea to extend vhost-user protocol to
>>>>> support the accelerators if possible. And it could be more flexible
>>>>> because it could support (for example) below things easily without
>>>>> introducing any complex command line options or monitor commands to
>>>>> QEMU:
>>>> Maybe I was wrong but I don't think we care about the complexity of
>>>> command line or monitor command in this case.
>>>>
>>>>> - the switching among different accelerators and software version
>>>>>      can be done at runtime in vhost process;
>>>>> - use different accelerators to accelerate different queue pairs
>>>>>      or just accelerate some (instead of all) queue pairs;
>>>> Well, technically, if we want, these could be implemented in qemu to=
o.
>>> You're right if just considering I/O. The ways to consume those I/O i=
s
>> another perspective.
>>> Simply 1:1 associating guest virtio-net and accelerator w/ SW datapat=
h
>> fallback is not the whole picture.
>>
>> Pay attention:
>>
>> 1) What I mean is not a fallback here. You can still do a lot of trick=
s e.g
>> offloading datapath to hardware or doorbell map.
>> 2) Qemu supports (very old and inefficient) a split model of device em=
ulation
>> and network backend. This means we can switch between backends (though
>> not implemented).
> Accelerator won't be defined in the same device layout, it means there'=
re different kinds of drivers.

Well, you can still use different drivers if you link dpdk or whatever=20
other dataplane library to qemu.

> Qemu definitely won't like to have HW relevant driver there,

Why not? We've already had userspace NVME driver.

>   that's end up with another vhost-vfio in my slides.

I don't get why we can't implement it purely through a userspace driver=20
inside qemu.

>   A mediated device can help to unify the device layout definition, and=
 leave the driver part in its own place.

The point is not about mediated device but why you must use vhost-user=20
to do it.

Thanks

> This approach is quite good when application doesn't need to put userla=
nd SW datapath and accelerator datapath in the same picture as which I me=
ntioned(vswitch cases).
>
>>>    It's variable usages on workload side to abstract the device (e.g.=
 port re-
>> presenter for vswitch) and etc. I don't think qemu is interested for a=
ll bunch
>> of things there.
>> Again, you can link any dataplane to qemu directly instead of using vh=
ost-
>> user if vhost-user tends to be less useful in some cases (vDPA is one =
of the
>> case I think).
> See my previous words.
>
>> Thanks
