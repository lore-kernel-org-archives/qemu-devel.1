Received: from eggs.gnu.org ([2001:4830:134:3::10]:44047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dCzFh-0007so-9C
	for qemu-devel@nongnu.org; Mon, 22 May 2017 22:08:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dCzFc-0001uR-Qm
	for qemu-devel@nongnu.org; Mon, 22 May 2017 22:08:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35894)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dCzFc-0001uJ-HZ
	for qemu-devel@nongnu.org; Mon, 22 May 2017 22:08:44 -0400
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
From: Jason Wang <jasowang@redhat.com>
Message-ID: <7ff05785-6bca-a886-0eb0-aeeb0f8d8e1a@redhat.com>
Date: Tue, 23 May 2017 10:08:35 +0800
MIME-Version: 1.0
In-Reply-To: <286AC319A985734F985F78AFA26841F7392351DD@shsmsx102.ccr.corp.intel.com>
Content-Type: text/plain; charset=gbk; format=flowed
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
To: "Wang, Wei W" <wei.w.wang@intel.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "marcandre.lureau@gmail.com" <marcandre.lureau@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mst@redhat.com" <mst@redhat.com>



On 2017=C4=EA05=D4=C222=C8=D5 19:46, Wang, Wei W wrote:
> On Monday, May 22, 2017 10:28 AM, Jason Wang wrote:
>> On 2017=C4=EA05=D4=C219=C8=D5 23:33, Stefan Hajnoczi wrote:
>>> On Fri, May 19, 2017 at 11:10:33AM +0800, Jason Wang wrote:
>>>> On 2017=C4=EA05=D4=C218=C8=D5 11:03, Wei Wang wrote:
>>>>> On 05/17/2017 02:22 PM, Jason Wang wrote:
>>>>>> On 2017=C4=EA05=D4=C217=C8=D5 14:16, Jason Wang wrote:
>>>>>>> On 2017=C4=EA05=D4=C216=C8=D5 15:12, Wei Wang wrote:
>>>>>>>>> Hi:
>>>>>>>>>
>>>>>>>>> Care to post the driver codes too?
>>>>>>>>>
>>>>>>>> OK. It may take some time to clean up the driver code before pos=
t
>>>>>>>> it out. You can first have a check of the draft at the repo here=
:
>>>>>>>> https://github.com/wei-w-wang/vhost-pci-driver
>>>>>>>>
>>>>>>>> Best,
>>>>>>>> Wei
>>>>>>> Interesting, looks like there's one copy on tx side. We used to
>>>>>>> have zerocopy support for tun for VM2VM traffic. Could you please
>>>>>>> try to compare it with your vhost-pci-net by:
>>>>>>>
>>>>> We can analyze from the whole data path - from VM1's network stack
>>>>> to send packets -> VM2's network stack to receive packets. The
>>>>> number of copies are actually the same for both.
>>>> That's why I'm asking you to compare the performance. The only reaso=
n
>>>> for vhost-pci is performance. You should prove it.
>>> There is another reason for vhost-pci besides maximum performance:
>>>
>>> vhost-pci makes it possible for end-users to run networking or storag=
e
>>> appliances in compute clouds.  Cloud providers do not allow end-users
>>> to run custom vhost-user processes on the host so you need vhost-pci.
>>>
>>> Stefan
>> Then it has non NFV use cases and the question goes back to the perfor=
mance
>> comparing between vhost-pci and zerocopy vhost_net. If it does not per=
form
>> better, it was less interesting at least in this case.
>>
> Probably I can share what we got about vhost-pci and vhost-user:
> https://github.com/wei-w-wang/vhost-pci-discussion/blob/master/vhost_pc=
i_vs_vhost_user.pdf
> Right now, I don=A1=AFt have the environment to add the vhost_net test.

Thanks, the number looks good. But I have some questions:

- Is the number measured through your vhost-pci kernel driver code?
- Have you tested packet size other than 64B?
- Is zerocopy supported in OVS-dpdk? If yes, is it enabled in your test?

>
> Btw, do you have data about vhost_net v.s. vhost_user?

I haven't.

Thanks

>
> Best,
> Wei
>
