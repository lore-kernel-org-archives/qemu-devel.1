Received: from eggs.gnu.org ([2001:4830:134:3::10]:45448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dGK9m-0001lV-Dy
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 03:04:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dGK9i-0003f4-5x
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 03:04:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47394)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dGK9h-0003ek-WA
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 03:04:26 -0400
References: <20170526142858.19931-1-maxime.coquelin@redhat.com>
	<20170530211819-mutt-send-email-mst@kernel.org>
	<7d4af4dd-270b-605f-9535-7bf8323e74c2@redhat.com>
	<a14b541b-ef48-9531-5697-4b5f213e53d9@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <477d61d4-6654-b1fa-fd86-1876737c886e@redhat.com>
Date: Thu, 1 Jun 2017 15:04:10 +0800
MIME-Version: 1.0
In-Reply-To: <a14b541b-ef48-9531-5697-4b5f213e53d9@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/6] vhost-user: Specify and implement
 device IOTLB support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Maxime Coquelin <maxime.coquelin@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: yuanhan.liu@linux.intel.com, qemu-devel@nongnu.org, peterx@redhat.com, marcandre.lureau@gmail.com, wexu@redhat.com, vkaplans@redhat.com, jfreiman@redhat.com



On 2017=E5=B9=B405=E6=9C=8831=E6=97=A5 23:32, Maxime Coquelin wrote:
>>>> [0]:https://gitlab.com/mcoquelin/dpdk-next-virtio/commits/vhost_iotl=
b_proto_v2=20
>>>>
>>>> [1]:https://lists.gnu.org/archive/html/qemu-devel/2016-04/msg00095.h=
tml=20
>>>>
>>> Overall, this looks good to me. I do think patch 3 isn't a good idea
>>> though, if slave wants something let it request it.
>>>
>>> Need to find out why does vhost in kernel want the used ring iotlb at
>>> start time - especially considering we aren't even guaranteed one ent=
ry
>>> covers the whole ring, and invalidates should affect all addresses at
>>> least in theory.
>>>
>>>
>>
>> The reason is probably we want to verify whether or not we could=20
>> correctly access used ring in vhost_vq_init_access(). It was there=20
>> since vhost_net is introduced. We can think to remove this limitation=20
>> maybe.
>
> Even if we remove the limitation on Kernel side, we will still have to
> keep this workaround for compatibility with older kernels. Having done=20
> the test, I can confirm it is currently necessary.
>
> Thanks,
> Maxime=20

Right, it was probably too late for the change.

Thanks
