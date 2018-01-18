Received: from eggs.gnu.org ([2001:4830:134:3::10]:54636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ec8jr-00039y-Vp
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 06:52:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ec8jo-0008C9-Ts
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 06:52:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44568)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1ec8jo-0008BW-Ks
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 06:52:08 -0500
References: <20180110161438.GA28096@stefanha-x1.localdomain>
	<dcb849d4-82fb-de8a-5e81-23d47026c9eb@redhat.com>
	<20180111152345.GA7353@stefanha-x1.localdomain>
	<86106573-422b-fe4c-ec15-dad0edf05880@redhat.com>
	<20180112101807.GE7356@stefanha-x1.localdomain>
	<a45c1da8-03e8-140f-725c-af0f31e3da62@redhat.com>
	<20180115135620.GG13238@stefanha-x1.localdomain>
	<9fad276a-d17b-6a45-6cd6-50899934b7a1@redhat.com>
	<20180118105103.GC19831@stefanha-x1.localdomain>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <78448708-8d53-70ca-d079-424caabc3a35@redhat.com>
Date: Thu, 18 Jan 2018 19:51:49 +0800
MIME-Version: 1.0
In-Reply-To: <20180118105103.GC19831@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] vhost-pci and virtio-vhost-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: wei.w.wang@intel.com, qemu-devel@nongnu.org



On 2018=E5=B9=B401=E6=9C=8818=E6=97=A5 18:51, Stefan Hajnoczi wrote:
> On Tue, Jan 16, 2018 at 01:41:37PM +0800, Jason Wang wrote:
>>
>> On 2018=E5=B9=B401=E6=9C=8815=E6=97=A5 21:56, Stefan Hajnoczi wrote:
>>> On Mon, Jan 15, 2018 at 02:56:31PM +0800, Jason Wang wrote:
>>>> On 2018=E5=B9=B401=E6=9C=8812=E6=97=A5 18:18, Stefan Hajnoczi wrote:
>>>>>> And what's more important, according to the kvm 2016 slides of vho=
st-pci,
>>>>>> the motivation of vhost-pci is not building SDN but a chain of VNF=
s. So
>>>>>> bypassing the central vswitch through a private VM2VM path does ma=
ke sense.
>>>>>> (Though whether or not vhost-pci is the best choice is still quest=
ionable).
>>>>> This is probably my fault.  Maybe my networking terminology is wron=
g.  I
>>>>> consider "virtual network functions" to be part of "software-define=
d
>>>>> networking" use cases.  I'm not implying there must be a central vi=
rtual
>>>>> switch.
>>>>>
>>>>> To rephrase: vhost-pci enables exitless VM2VM communication.
>>>> The problem is, exitless is not what vhost-pci invents, it could be =
achieved
>>>> now when both sides are doing busypolling.
>>> The only way I'm aware of is ivshmem.  But ivshmem lacks a family of
>>> standard device types that allows different implementations to
>>> interoperate.  We already have the virtio family of device types, so =
it
>>> makes sense to work on a virtio-based solution.
>>>
>>> Perhaps I've missed a different approach for exitless VM2VM
>>> communication.  Please explain how VM1 and VM2 can do exitless networ=
k
>>> communication today?
>> I'm not sure we're talking the same thing. For VM2VM, do you mean only=
 for
>> shared memory? I thought we can treat any backends that can transfer d=
ata
>> directly between two VMs for a VM2VM solution. In this case, if virtqu=
eue
>> notifications were disabled by all sides (e.g busy polling), there wil=
l be
>> no exits at all.
>>
>> And if you want a virtio version of shared memory, it's another kind o=
f
>> motivation at least from my point of view.
> I'm confused, we're probably not talking about the same thing.
>
> You said that exitless "could be achieved now when both sides are doing
> busypolling".  Can you post a QEMU command-line that does this?

If exitless means no virtqueue kick and interrupt. It does not require=20
any special command line, just start a testpmd in both guest and host.

>
> In other words, what exactly are you proposing as an alternative to
> vhost-pci?

I don't propose any new idea. I just want to know what's the advantage=20
of vhost-pci over zerocopy. Both needs one time of copy, the difference=20
is the vhost-pci did it inside a guest but zerocopy did in on host.

Thanks

>
> Stefan
