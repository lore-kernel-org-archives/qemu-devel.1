Received: from eggs.gnu.org ([2001:4830:134:3::10]:47529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dDrmx-000115-2L
	for qemu-devel@nongnu.org; Thu, 25 May 2017 08:22:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dDrmt-0003S7-Sx
	for qemu-devel@nongnu.org; Thu, 25 May 2017 08:22:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56460)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dDrmt-0003QU-KA
	for qemu-devel@nongnu.org; Thu, 25 May 2017 08:22:43 -0400
References: <1494578148-102868-1-git-send-email-wei.w.wang@intel.com>
	<a3f2cae3-5d3d-f620-4a8d-bb11470c0b08@redhat.com>
	<591AA65F.8080608@intel.com>
	<d6eb1d73-c791-b8d3-7ef3-a7653aef00d6@redhat.com>
	<7e1b48d5-83e6-a0ae-5d91-696d8db09d7c@redhat.com>
	<591D0EF5.9000807@intel.com>
	<d7df5484-7e08-4e1c-9e35-69d73858c736@redhat.com>
	<20170519153329.GA30573@stefanha-x1.localdomain>
	<ec3c391c-6f0a-b316-e7d9-8f5e431b5e45@redhat.com>
	<286AC319A985734F985F78AFA26841F7392351DD@shsmsx102.ccr.corp.intel.com>
	<7ff05785-6bca-a886-0eb0-aeeb0f8d8e1a@redhat.com>
	<5923CCF2.2000001@intel.com>
	<3d9e8375-fbaa-c011-8242-b37cd971069b@redhat.com>
	<5924136A.4090004@intel.com>
	<7636d3d0-a0de-f9a6-47f8-2d09a448b978@redhat.com>
	<592544D9.5010100@intel.com>
	<23dac05e-ba3d-df6d-4831-feab9be1c6d2@redhat.com>
	<5926C7AC.4080603@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <6a6ecbcd-e9ae-1cf0-ccd9-14294cd0cf86@redhat.com>
Date: Thu, 25 May 2017 20:22:34 +0800
MIME-Version: 1.0
In-Reply-To: <5926C7AC.4080603@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [virtio-dev] Re: [virtio-dev] Re: [PATCH v2 00/16]
 Vhost-pci for inter-VM communication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "mst@redhat.com" <mst@redhat.com>, "marcandre.lureau@gmail.com" <marcandre.lureau@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>



On 2017=E5=B9=B405=E6=9C=8825=E6=97=A5 20:01, Wei Wang wrote:
> On 05/25/2017 03:59 PM, Jason Wang wrote:
>>
>>
>> On 2017=E5=B9=B405=E6=9C=8824=E6=97=A5 16:31, Wei Wang wrote:
>>> On 05/24/2017 11:24 AM, Jason Wang wrote:
>>>>
>>>>
>>>> On 2017=E5=B9=B405=E6=9C=8823=E6=97=A5 18:48, Wei Wang wrote:
>>>>> On 05/23/2017 02:32 PM, Jason Wang wrote:
>>>>>>
>>>>>>
>>>>>> On 2017=E5=B9=B405=E6=9C=8823=E6=97=A5 13:47, Wei Wang wrote:
>>>>>>> On 05/23/2017 10:08 AM, Jason Wang wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 2017=E5=B9=B405=E6=9C=8822=E6=97=A5 19:46, Wang, Wei W wrote:
>>>>>>>>> On Monday, May 22, 2017 10:28 AM, Jason Wang wrote:
>>>>>>>>>> On 2017=E5=B9=B405=E6=9C=8819=E6=97=A5 23:33, Stefan Hajnoczi =
wrote:
>>>>>>>>>>> On Fri, May 19, 2017 at 11:10:33AM +0800, Jason Wang wrote:
>>>>>>>>>>>> On 2017=E5=B9=B405=E6=9C=8818=E6=97=A5 11:03, Wei Wang wrote=
:
>>>>>>>>>>>>> On 05/17/2017 02:22 PM, Jason Wang wrote:
>>>>>>>>>>>>>> On 2017=E5=B9=B405=E6=9C=8817=E6=97=A5 14:16, Jason Wang w=
rote:
>>>>>>>>>>>>>>> On 2017=E5=B9=B405=E6=9C=8816=E6=97=A5 15:12, Wei Wang wr=
ote:
>>>>>>>>>>>>>>>>> Hi:
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> Care to post the driver codes too?
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> OK. It may take some time to clean up the driver code=20
>>>>>>>>>>>>>>>> before post
>>>>>>>>>>>>>>>> it out. You can first have a check of the draft at the=20
>>>>>>>>>>>>>>>> repo here:
>>>>>>>>>>>>>>>> https://github.com/wei-w-wang/vhost-pci-driver
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Best,
>>>>>>>>>>>>>>>> Wei
>>>>>>>>>>>>>>> Interesting, looks like there's one copy on tx side. We=20
>>>>>>>>>>>>>>> used to
>>>>>>>>>>>>>>> have zerocopy support for tun for VM2VM traffic. Could=20
>>>>>>>>>>>>>>> you please
>>>>>>>>>>>>>>> try to compare it with your vhost-pci-net by:
>>>>>>>>>>>>>>>
>>>>>>>>>>>>> We can analyze from the whole data path - from VM1's=20
>>>>>>>>>>>>> network stack
>>>>>>>>>>>>> to send packets -> VM2's network stack to receive packets.=20
>>>>>>>>>>>>> The
>>>>>>>>>>>>> number of copies are actually the same for both.
>>>>>>>>>>>> That's why I'm asking you to compare the performance. The=20
>>>>>>>>>>>> only reason
>>>>>>>>>>>> for vhost-pci is performance. You should prove it.
>>>>>>>>>>> There is another reason for vhost-pci besides maximum=20
>>>>>>>>>>> performance:
>>>>>>>>>>>
>>>>>>>>>>> vhost-pci makes it possible for end-users to run networking=20
>>>>>>>>>>> or storage
>>>>>>>>>>> appliances in compute clouds.  Cloud providers do not allow=20
>>>>>>>>>>> end-users
>>>>>>>>>>> to run custom vhost-user processes on the host so you need=20
>>>>>>>>>>> vhost-pci.
>>>>>>>>>>>
>>>>>>>>>>> Stefan
>>>>>>>>>> Then it has non NFV use cases and the question goes back to=20
>>>>>>>>>> the performance
>>>>>>>>>> comparing between vhost-pci and zerocopy vhost_net. If it=20
>>>>>>>>>> does not perform
>>>>>>>>>> better, it was less interesting at least in this case.
>>>>>>>>>>
>>>>>>>>> Probably I can share what we got about vhost-pci and vhost-user=
:
>>>>>>>>> https://github.com/wei-w-wang/vhost-pci-discussion/blob/master/=
vhost_pci_vs_vhost_user.pdf=20
>>>>>>>>>
>>>>>>>>> Right now, I don=E2=80=99t have the environment to add the vhos=
t_net=20
>>>>>>>>> test.
>>>>>>>>
>>>>>>>> Thanks, the number looks good. But I have some questions:
>>>>>>>>
>>>>>>>> - Is the number measured through your vhost-pci kernel driver=20
>>>>>>>> code?
>>>>>>>
>>>>>>> Yes, the kernel driver code.
>>>>>>
>>>>>> Interesting, in the above link, "l2fwd" was used in vhost-pci=20
>>>>>> testing. I want to know more about the test configuration: If=20
>>>>>> l2fwd is the one that dpdk had, want to know how can you make it=20
>>>>>> work for kernel driver. (Maybe packet socket I think?) If not,=20
>>>>>> want to know how do you configure it (e.g through bridge or=20
>>>>>> act_mirred or others). And in OVS dpdk, is dpdk l2fwd + pmd used=20
>>>>>> in the testing?
>>>>>>
>>>>>
>>>>> Oh, that l2fwd is a kernel module from OPNFV vsperf
>>>>> (http://artifacts.opnfv.org/vswitchperf/docs/userguide/quickstart.h=
tml)=20
>>>>>
>>>>> For both legacy and vhost-pci cases, they use the same l2fwd module=
.
>>>>> No bridge is used, the module already works at L2 to forward packet=
s
>>>>> between two net devices.
>>>>
>>>> Thanks for the pointer. Just to confirm, I think virtio-net kernel=20
>>>> driver is used in OVS-dpdk test?
>>>
>>> Yes. In both cases, the guests are using kernel drivers.
>>>
>>>>
>>>> Another question is, can we manage to remove the copy in tx? If=20
>>>> not, is it a limitation of virtio protocol?
>>>>
>>>
>>> No, we can't. Use this example, VM1's Vhost-pci<->virtio-net of VM2,=20
>>> VM1 sees VM2's memory, but
>>> VM2 only sees its own memory.
>>> What this copy achieves is to get data from VM1's memory to VM2's=20
>>> memory, so that VM2 can deliver it's
>>> own memory to its network stack.
>>
>> Then, as has been pointed out. Should we consider a vhost-pci to=20
>> vhost-pci peer?
> I think that's another direction or future extension.
> We already have the vhost-pci to virtio-net model on the way, so I=20
> think it would be better to start from here.
>

If vhost-pci to vhost-pci is obvious superior, why not try this consider=20
we're at rather early stage for vhost-pci?

>
>>
>> Even with vhost-pci to virito-net configuration, I think rx zerocopy=20
>> could be achieved but not implemented in your driver (probably more=20
>> easier in pmd).
>>
> Yes, it would be easier with dpdk pmd. But I think it would not be=20
> important in the NFV use case,
> since the data flow goes to one direction often.
>
> Best,
> Wei
>

I would say let's don't give up on any possible performance optimization=20
now. You can do it in the future.

If you still want to keep the copy in both tx and rx, you'd better:

- measure the performance of larger packet size other than 64B
- consider whether or not it's a good idea to do it in vcpu thread, or=20
move it to another one(s)

Thanks
