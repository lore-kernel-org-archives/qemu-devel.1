Received: from eggs.gnu.org ([2001:4830:134:3::10]:57396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dAsMX-0002UT-1E
	for qemu-devel@nongnu.org; Wed, 17 May 2017 02:23:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dAsMS-00075K-KA
	for qemu-devel@nongnu.org; Wed, 17 May 2017 02:23:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37724)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dAsMS-00075B-DV
	for qemu-devel@nongnu.org; Wed, 17 May 2017 02:23:04 -0400
References: <1494578148-102868-1-git-send-email-wei.w.wang@intel.com>
	<a3f2cae3-5d3d-f620-4a8d-bb11470c0b08@redhat.com>
	<591AA65F.8080608@intel.com>
	<d6eb1d73-c791-b8d3-7ef3-a7653aef00d6@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <7e1b48d5-83e6-a0ae-5d91-696d8db09d7c@redhat.com>
Date: Wed, 17 May 2017 14:22:53 +0800
MIME-Version: 1.0
In-Reply-To: <d6eb1d73-c791-b8d3-7ef3-a7653aef00d6@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [virtio-dev] Re: [PATCH v2 00/16] Vhost-pci for
 inter-VM communication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>, stefanha@gmail.com, marcandre.lureau@gmail.com, mst@redhat.com, pbonzini@redhat.com, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org



On 2017=E5=B9=B405=E6=9C=8817=E6=97=A5 14:16, Jason Wang wrote:
>
>
> On 2017=E5=B9=B405=E6=9C=8816=E6=97=A5 15:12, Wei Wang wrote:
>>>>
>>>
>>> Hi:
>>>
>>> Care to post the driver codes too?
>>>
>> OK. It may take some time to clean up the driver code before post it=20
>> out. You can first
>> have a check of the draft at the repo here:
>> https://github.com/wei-w-wang/vhost-pci-driver
>>
>> Best,
>> Wei
>
> Interesting, looks like there's one copy on tx side. We used to have=20
> zerocopy support for tun for VM2VM traffic. Could you please try to=20
> compare it with your vhost-pci-net by:
>
> - make sure zerocopy is enabled for vhost_net
> - comment skb_orphan_frags() in tun_net_xmit()
>
> Thanks
>

You can even enable tx batching for tun by ethtool -C tap0 rx-frames N.=20
This will greatly improve the performance according to my test.

Thanks
