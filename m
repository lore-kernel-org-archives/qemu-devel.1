Received: from eggs.gnu.org ([2001:4830:134:3::10]:56954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dD3NS-0003VC-Cs
	for qemu-devel@nongnu.org; Tue, 23 May 2017 02:33:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dD3NP-0000pQ-4e
	for qemu-devel@nongnu.org; Tue, 23 May 2017 02:33:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58924)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dD3NO-0000oP-SQ
	for qemu-devel@nongnu.org; Tue, 23 May 2017 02:33:03 -0400
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
From: Jason Wang <jasowang@redhat.com>
Message-ID: <3d9e8375-fbaa-c011-8242-b37cd971069b@redhat.com>
Date: Tue, 23 May 2017 14:32:52 +0800
MIME-Version: 1.0
In-Reply-To: <5923CCF2.2000001@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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



On 2017=E5=B9=B405=E6=9C=8823=E6=97=A5 13:47, Wei Wang wrote:
> On 05/23/2017 10:08 AM, Jason Wang wrote:
>>
>>
>> On 2017=E5=B9=B405=E6=9C=8822=E6=97=A5 19:46, Wang, Wei W wrote:
>>> On Monday, May 22, 2017 10:28 AM, Jason Wang wrote:
>>>> On 2017=E5=B9=B405=E6=9C=8819=E6=97=A5 23:33, Stefan Hajnoczi wrote:
>>>>> On Fri, May 19, 2017 at 11:10:33AM +0800, Jason Wang wrote:
>>>>>> On 2017=E5=B9=B405=E6=9C=8818=E6=97=A5 11:03, Wei Wang wrote:
>>>>>>> On 05/17/2017 02:22 PM, Jason Wang wrote:
>>>>>>>> On 2017=E5=B9=B405=E6=9C=8817=E6=97=A5 14:16, Jason Wang wrote:
>>>>>>>>> On 2017=E5=B9=B405=E6=9C=8816=E6=97=A5 15:12, Wei Wang wrote:
>>>>>>>>>>> Hi:
>>>>>>>>>>>
>>>>>>>>>>> Care to post the driver codes too?
>>>>>>>>>>>
>>>>>>>>>> OK. It may take some time to clean up the driver code before=20
>>>>>>>>>> post
>>>>>>>>>> it out. You can first have a check of the draft at the repo=20
>>>>>>>>>> here:
>>>>>>>>>> https://github.com/wei-w-wang/vhost-pci-driver
>>>>>>>>>>
>>>>>>>>>> Best,
>>>>>>>>>> Wei
>>>>>>>>> Interesting, looks like there's one copy on tx side. We used to
>>>>>>>>> have zerocopy support for tun for VM2VM traffic. Could you plea=
se
>>>>>>>>> try to compare it with your vhost-pci-net by:
>>>>>>>>>
>>>>>>> We can analyze from the whole data path - from VM1's network stac=
k
>>>>>>> to send packets -> VM2's network stack to receive packets. The
>>>>>>> number of copies are actually the same for both.
>>>>>> That's why I'm asking you to compare the performance. The only=20
>>>>>> reason
>>>>>> for vhost-pci is performance. You should prove it.
>>>>> There is another reason for vhost-pci besides maximum performance:
>>>>>
>>>>> vhost-pci makes it possible for end-users to run networking or=20
>>>>> storage
>>>>> appliances in compute clouds.  Cloud providers do not allow end-use=
rs
>>>>> to run custom vhost-user processes on the host so you need vhost-pc=
i.
>>>>>
>>>>> Stefan
>>>> Then it has non NFV use cases and the question goes back to the=20
>>>> performance
>>>> comparing between vhost-pci and zerocopy vhost_net. If it does not=20
>>>> perform
>>>> better, it was less interesting at least in this case.
>>>>
>>> Probably I can share what we got about vhost-pci and vhost-user:
>>> https://github.com/wei-w-wang/vhost-pci-discussion/blob/master/vhost_=
pci_vs_vhost_user.pdf=20
>>>
>>> Right now, I don=E2=80=99t have the environment to add the vhost_net =
test.
>>
>> Thanks, the number looks good. But I have some questions:
>>
>> - Is the number measured through your vhost-pci kernel driver code?
>
> Yes, the kernel driver code.

Interesting, in the above link, "l2fwd" was used in vhost-pci testing. I=20
want to know more about the test configuration: If l2fwd is the one that=20
dpdk had, want to know how can you make it work for kernel driver.=20
(Maybe packet socket I think?) If not, want to know how do you configure=20
it (e.g through bridge or act_mirred or others). And in OVS dpdk, is=20
dpdk l2fwd + pmd used in the testing?

>
>> - Have you tested packet size other than 64B?
>
> Not yet.

Better to test more since the time spent on 64B copy should be very fast.

>
>> - Is zerocopy supported in OVS-dpdk? If yes, is it enabled in your tes=
t?
> zerocopy is not used in the test, but I don't think zerocopy can increa=
se
> the throughput to 2x.

I agree, but we need prove this with numbers.

Thanks

> On the other side, we haven't put effort to optimize
> the draft kernel driver yet.
>
> Best,
> Wei
>
