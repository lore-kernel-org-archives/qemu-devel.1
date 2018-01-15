Received: from eggs.gnu.org ([2001:4830:134:3::10]:50865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eb0EH-00062p-Le
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 03:34:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eb0ED-00013Z-OA
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 03:34:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36064)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1eb0ED-00012b-Hb
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 03:34:49 -0500
References: <20180110161438.GA28096@stefanha-x1.localdomain>
	<dcb849d4-82fb-de8a-5e81-23d47026c9eb@redhat.com>
	<20180111152345.GA7353@stefanha-x1.localdomain>
	<86106573-422b-fe4c-ec15-dad0edf05880@redhat.com>
	<20180112101807.GE7356@stefanha-x1.localdomain>
	<a45c1da8-03e8-140f-725c-af0f31e3da62@redhat.com>
	<5A5C5F7D.8070403@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <6b618d06-0891-fb3b-b845-8beae5649b22@redhat.com>
Date: Mon, 15 Jan 2018 16:34:42 +0800
MIME-Version: 1.0
In-Reply-To: <5A5C5F7D.8070403@intel.com>
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
To: Wei Wang <wei.w.wang@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org



On 2018=E5=B9=B401=E6=9C=8815=E6=97=A5 15:59, Wei Wang wrote:
> On 01/15/2018 02:56 PM, Jason Wang wrote:
>>
>>
>> On 2018=E5=B9=B401=E6=9C=8812=E6=97=A5 18:18, Stefan Hajnoczi wrote:
>>>
>>
>> I just fail understand why we can't do software defined network or=20
>> storage with exist virtio device/drivers (or are there any=20
>> shortcomings that force us to invent new infrastructure).
>>
>
> Existing virtio-net works with a host central vSwitch, and it has the=20
> following disadvantages:
> 1) long code/data path;
> 2) poor scalability; and
> 3) host CPU sacrifice

Please show me the numbers.

>
> Vhost-pci solves the above issues by providing a point-to-point=20
> communication between VMs. No matter how the control path would look=20
> like finally, the key point is that the data path is P2P between VMs.
>
> Best,
> Wei
>
>

Well, I think I've pointed out several times in the replies of previous=20
versions. Both vhost-pci-net and virtio-net is an ethernet device, which=20
is not tied to a central vswitch for sure. There're just too many=20
methods or tricks which can be used to build a point to point data path.

The problem is not whether or not you can build direct path between VMs=20
through vhost-pci, the problem is why you must do it through vhost-pci.

Thanks
