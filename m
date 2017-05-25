Received: from eggs.gnu.org ([2001:4830:134:3::10]:49105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dDrvJ-0005I6-TR
	for qemu-devel@nongnu.org; Thu, 25 May 2017 08:31:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dDrvG-0007Uj-Qu
	for qemu-devel@nongnu.org; Thu, 25 May 2017 08:31:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35740)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dDrvG-0007UW-KT
	for qemu-devel@nongnu.org; Thu, 25 May 2017 08:31:22 -0400
From: Jason Wang <jasowang@redhat.com>
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
	<6a6ecbcd-e9ae-1cf0-ccd9-14294cd0cf86@redhat.com>
Message-ID: <5367a1b2-b3cc-8df2-c9ec-99fb60a57666@redhat.com>
Date: Thu, 25 May 2017 20:31:09 +0800
MIME-Version: 1.0
In-Reply-To: <6a6ecbcd-e9ae-1cf0-ccd9-14294cd0cf86@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [virtio-dev] Re: [virtio-dev] Re: [virtio-dev] Re:
 [PATCH v2 00/16] Vhost-pci for inter-VM communication
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



On 2017=E5=B9=B405=E6=9C=8825=E6=97=A5 20:22, Jason Wang wrote:
>>>
>>> Even with vhost-pci to virito-net configuration, I think rx zerocopy=20
>>> could be achieved but not implemented in your driver (probably more=20
>>> easier in pmd).
>>>
>> Yes, it would be easier with dpdk pmd. But I think it would not be=20
>> important in the NFV use case,
>> since the data flow goes to one direction often.
>>
>> Best,
>> Wei
>>
>
> I would say let's don't give up on any possible performance=20
> optimization now. You can do it in the future.
>
> If you still want to keep the copy in both tx and rx, you'd better:
>
> - measure the performance of larger packet size other than 64B
> - consider whether or not it's a good idea to do it in vcpu thread, or=20
> move it to another one(s)
>
> Thanks=20

And what's more important, since you care NFV seriously. I would really=20
suggest you to draft a pmd for vhost-pci and use it to for benchmarking.=20
It's real life case. OVS dpdk is known for not optimized for kernel drive=
rs.

Good performance number can help us to examine the correctness of both=20
design and implementation.

Thanks
