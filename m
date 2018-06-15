Received: from eggs.gnu.org ([2001:4830:134:3::10]:46817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1fTqN1-0007ru-2J
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:10:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1fTqMx-0005Rx-PB
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:10:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47988)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.ibm.com>) id 1fTqMx-0005QX-Fu
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:10:31 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w5FF9IZg096317
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 11:10:29 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2jmdg9emkb-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 11:10:28 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.ibm.com>;
	Fri, 15 Jun 2018 09:10:28 -0600
References: <cover.1528832686.git.alifm@linux.ibm.com>
	<dd7e90c5b3de6f98218908c7f57d9d0286089ad5.1528832686.git.alifm@linux.ibm.com>
	<20180613093700.GG27901@redhat.com>
	<7b51465a-b7c1-58ec-1ef6-9fe791e96bbf@linux.ibm.com>
	<20180613150512.GA19901@redhat.com>
	<5833f4ec-dcd1-19ac-2848-facf31aec7cf@linux.ibm.com>
	<20180614082155.GI6355@redhat.com>
	<79597909-fdb5-2983-19ac-74332229c8ef@linux.ibm.com>
	<20180614151048.GA18967@redhat.com>
	<28dca328-6920-91a1-0962-b336a3ffcb5b@linux.ibm.com>
	<921fea52-8e68-57d3-154d-26cf063a164a@linux.vnet.ibm.com>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Fri, 15 Jun 2018 11:10:23 -0400
MIME-Version: 1.0
In-Reply-To: <921fea52-8e68-57d3-154d-26cf063a164a@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <ca88315c-75a0-ddc2-ba81-e1dfdb2d6d25@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v1 1/1] virtio-crypto: Allow disabling of
 cipher algorithms for virtio-crypto device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Viktor VM Mihajlovski <mihajlov@linux.vnet.ibm.com>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, qemu-devel@nongnu.org, frankja@linux.ibm.com, mst@redhat.com, borntraeger@de.ibm.com, arei.gonglei@huawei.com, longpeng2@huawei.com, mjrosato@linux.vnet.ibm.com



On 06/15/2018 09:17 AM, Viktor VM Mihajlovski wrote:
> On 14.06.2018 18:12, Farhan Ali wrote:
>>
>>
>> On 06/14/2018 11:10 AM, Daniel P. Berrang=C3=A9 wrote:
>>> On Thu, Jun 14, 2018 at 10:50:40AM -0400, Farhan Ali wrote:
>>>>
>>>>
>>>> On 06/14/2018 04:21 AM, Daniel P. Berrang=C3=A9 wrote:
>>>>> On Wed, Jun 13, 2018 at 07:28:08PM +0200, Halil Pasic wrote:
>>>>>>
>>>>>>
>>>>>> On 06/13/2018 05:05 PM, Daniel P. Berrang=C3=A9 wrote:
>>>>>>> On Wed, Jun 13, 2018 at 11:01:05AM -0400, Farhan Ali wrote:
>>>>>>>> Hi Daniel
>>>>>>>>
>>>>>>>> On 06/13/2018 05:37 AM, Daniel P. Berrang=C3=A9 wrote:
>>>>>>>>> On Tue, Jun 12, 2018 at 03:48:34PM -0400, Farhan Ali wrote:
>>>>>>>>>> The virtio-crypto driver currently propagates to the guest
>>>>>>>>>> all the cipher algorithms that the backend cryptodev can
>>>>>>>>>> support. But in certain cases where the guest has more
>>>>>>>>>> performant mechanism to handle some algorithms, it would be
>>>>>>>>>> useful to propagate only a subset of the algorithms.
>>>>>>>>>
>>>>>>>>> I'm not really convinced by this.
>>>>>>>>>
>>>>>>>>> The performance of crypto algorithms has many influencing
>>>>>>>>> factors, making it pretty hard to decide which is best
>>>>>>>>> without actively testing specific impls and comparing
>>>>>>>>> them in a manner which matches the application usage
>>>>>>>>> pattern. eg in theory the kernel crypto impl of an alg
>>>>>>>>> is faster than a userspace impl, if the kernel uses
>>>>>>>>> hardware accel and userspace does not. This, however,
>>>>>>>>> ignores the overhead of the kernel/userspace switch.
>>>>>>>>> The real world performance winner, thus depends on the
>>>>>>>>> amount of data being processed in each operation. Some
>>>>>>>>> times userspace can win & sometimes kernel space can
>>>>>>>>> win. This is even more relevant to virtio-crypto as
>>>>>>>>> it has more expensive context switches.
>>>>>>>>
>>>>>>>> True. But what if the guest can perform some crypto algorithms
>>>>>>>> without a
>>>>>>>> incurring a VM exit? For example in s390 we have the cpacf
>>>>>>>> instructions to
>>>>>>>> perform crypto and this instruction is implemented for us by our
>>>>>>>> hardware
>>>>>>>> virtualization technology. In such a case it would be better not
>>>>>>>> to use
>>>>>>>> virtio-crypto's implementation of such a crypto algorithm.
>>>>>>>>
>>>>>>>> At the same time we would like to take advantage of virtio-crypt=
o's
>>>>>>>> acceleration capabilities for certain crypto algorithms for whic=
h
>>>>>>>> there is
>>>>>>>> no hardware assistance.
>>>>>>>
>>>>>>> IIUC, the kernel's crypto layer can support multiple
>>>>>>> implementations of
>>>>>>> any algorithm. Providers can report a priority against
>>>>>>> implementations
>>>>>>> which influences which impl is used in practice. So if there's a
>>>>>>> native
>>>>>>> instruction for a partiuclar algorithm I would expect the impl
>>>>>>> registered
>>>>>>> for that to be designated higher priority than other impls, so
>>>>>>> that it is
>>>>>>> used in preference to other impls.
>>>>>>>
>>>>>>
>>>>>> AFAIR the problem here is that in (the guest) kernel the virtio-cr=
ypto
>>>>>> driver has to register it's crypto algo implementations with a
>>>>>> priority
>>>>>> (single number), which dictates if it's going to be the preferred
>>>>>> (used)
>>>>>> implementation of the algorithm or not. The virtio-crypto driver
>>>>>> does this
>>>>>> without having information about the (comparative or absolute)
>>>>>> performance
>>>>>> of it's implementation (which depends on the backend among others).
>>>>>> I don't think
>>>>>> any dynamic re-prioritization of the algorithms takes place (e.g.
>>>>>> based on how these
>>>>>> perform in for the given configuration).
>>>>>>
>>>>>> I think the strategy of the virtio-crypto is to rather overstate, =
than
>>>>>> understate the performance of it's implementation. If we were to '=
be
>>>>>> conservative' and say, 'hey we don't know nothing about the
>>>>>> performance,
>>>>>> let's make it lowest priority implementation' the implementations
>>>>>> provided
>>>>>> by virtio-crypto would end up being used only if there is no other
>>>>>> implementation. And that does not sound like a good idea either.
>>>>>
>>>>>
>>>>> This problem you describe, however, is something that applies to *a=
ny*
>>>>> kerenl code that is registering a crypto algo impl for accelerator
>>>>> hardware. A non-virtualized crypto cards in bare metal likewise can=
not
>>>>> assume that its AES impl is better then the host CPU's=C2=A0 aes-ni
>>>>> instruction.
>>>>>
>>>>>> So the idea is to give the user the power to effectively not provi=
de
>>>>>> an algorithm via virtio-crypto. That is, if the user observes a
>>>>>> performance
>>>>>> degradation because of virtio-crypto, he can turn off the bad
>>>>>> algorithms
>>>>>> at the device. That way overstatement becomes a much smaller probl=
em.
>>>>>> The user can turn off the bad algorithms for reasons other than
>>>>>> performance
>>>>>> too.
>>>>>>
>>>>>> Of course there are other ways to deal with the problem of
>>>>>> virtio-crypto
>>>>>> driver not knowing how good it's implementation of a given algo is=
. We
>>>>>> could make the in kernel crypto priorities dynamically adjustable
>>>>>> in general
>>>>>> or we could provide the user with means to specify the priorities
>>>>>> (e.g.
>>>>>> as module parameter) with which the virtio-crypto driver registers
>>>>>> each algo.
>>>>>> Both of these would be knobs in the guest. It's hard to tell if
>>>>>> these first
>>>>>> one would be useful in scenarios not involving virtualization. Sam=
e
>>>>>> goes
>>>>>> for some kind of dynamic priority management for crypto algorithm
>>>>>> implementations
>>>>>> in the Linux kernel. I assume the people involved with the respect=
ive
>>>>>> subsystem do not see the necessity for something like that.
>>>>>
>>>>> It still feels like this is a problem for the guest OS to solve. If=
 you
>>>>> put a physical crypto accelerator in a bare metal machine, that has=
 the
>>>>> same problem you describe here, so the kernel surely already needs
>>>>> to find
>>>>> a viable solution for this problem.
>>>>>
>>>>
>>>> How would the guest OS know which algo is better? As you mentioned i=
t
>>>> does
>>>> depend on few factors and the best the kernel can do is use some sor=
t of
>>>> heuristics. Such a solution might not be very dynamic and might not
>>>> work for
>>>> all the cases for a user.
>>>
>>> Which is better will likely depend on the application using it. One m=
ight
>>> be better for use by the kernel, while another is better for use by a
>>> userspace application, or two userspace apps might have different
>>> preferences.
>>>
>>>> Shouldn't we use virtualization to give us the flexibility that we d=
on't
>>>> have with physical crypto accelerator? The crypto accelerator might
>>>> not know
>>>> if it's implementation is any better, but the user can experiment an=
d
>>>> see
>>>> what works better.
>>>
>>> It is better to provide it all to the guest and let the guest decide
>>> which
>>> is best to use.=C2=A0 If nothing else the virtio-crypto kernel module=
 itself
>>> can have module parameters to control the priority it gives to each
>>> algorithm, or can avoid registering certain algorithms.=C2=A0 Doing i=
t guest
>>> side is more flexible, because realistically many virt host deploymen=
ts
>>> will never give the guest admin ability to control this from the host
>>> side, so a guest kernel config ability will be the only thing availab=
le.
>>>
>>
>> I am not sure if putting all that complexity on the guest OS is the
>> right approach. I thought it would be better to let the user decide
>> through device definition what algorithms should be available to the
>> guest. But I am open to other approaches and suggestion :)
>>
>> I would like to know if Arei or Longpeng(Mike) has any suggestion
>> regarding this?
>>
>> Thanks
>> Farhan
>>
>=20
> With the current virtio-crypto backend functionality offered (CBC AES
> only) it may seem a bit over-engineered to offer a configuration option
> to remove the only supported algorithm...
>=20
> What I could imagine to be useful though, would be to allow the backend
> to advertise its capabilities to the guest virtio-crypto device, so tha=
t
> the guest driver can register the algorithms supported dynamically.
> Currently, the algorithms are hard-coded on both sides which makes it a
> bit hard to extend the backends to support new algorithms (or write new
> backends if so desired).

I posted some kernel patches=20
(https://www.spinics.net/lists/kvm/msg170332.html), that takes care of=20
registering algorithms based on what the backend advertises.


>=20
> Whether the backend itself was configurable would be of less importance
> then (but still could make sense).
>=20
