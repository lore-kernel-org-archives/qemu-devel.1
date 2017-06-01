Received: from eggs.gnu.org ([2001:4830:134:3::10]:40201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1dGLdn-0005ah-57
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 04:39:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1dGLdk-0006XP-35
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 04:39:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44124)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1dGLdj-0006X5-Sz
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 04:39:32 -0400
References: <20170526142858.19931-1-maxime.coquelin@redhat.com>
	<20170530211819-mutt-send-email-mst@kernel.org>
	<7d4af4dd-270b-605f-9535-7bf8323e74c2@redhat.com>
	<a14b541b-ef48-9531-5697-4b5f213e53d9@redhat.com>
	<477d61d4-6654-b1fa-fd86-1876737c886e@redhat.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Message-ID: <efbd5e56-b26a-bf9e-d360-fd529981167e@redhat.com>
Date: Thu, 1 Jun 2017 10:39:19 +0200
MIME-Version: 1.0
In-Reply-To: <477d61d4-6654-b1fa-fd86-1876737c886e@redhat.com>
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
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: yuanhan.liu@linux.intel.com, qemu-devel@nongnu.org, peterx@redhat.com, marcandre.lureau@gmail.com, wexu@redhat.com, vkaplans@redhat.com, jfreiman@redhat.com



On 06/01/2017 09:04 AM, Jason Wang wrote:
>=20
>=20
> On 2017=E5=B9=B405=E6=9C=8831=E6=97=A5 23:32, Maxime Coquelin wrote:
>>>>> [0]:https://gitlab.com/mcoquelin/dpdk-next-virtio/commits/vhost_iot=
lb_proto_v2=20
>>>>>
>>>>> [1]:https://lists.gnu.org/archive/html/qemu-devel/2016-04/msg00095.=
html=20
>>>>>
>>>> Overall, this looks good to me. I do think patch 3 isn't a good idea
>>>> though, if slave wants something let it request it.
>>>>
>>>> Need to find out why does vhost in kernel want the used ring iotlb a=
t
>>>> start time - especially considering we aren't even guaranteed one en=
try
>>>> covers the whole ring, and invalidates should affect all addresses a=
t
>>>> least in theory.
>>>>
>>>>
>>>
>>> The reason is probably we want to verify whether or not we could=20
>>> correctly access used ring in vhost_vq_init_access(). It was there=20
>>> since vhost_net is introduced. We can think to remove this limitation=
=20
>>> maybe.
>>
>> Even if we remove the limitation on Kernel side, we will still have to
>> keep this workaround for compatibility with older kernels. Having done=
=20
>> the test, I can confirm it is currently necessary.
>>
>> Thanks,
>> Maxime=20
>=20
> Right, it was probably too late for the change.

So, I wonder if we could keep patch 3, that just extends this
workaround for vhost-user. Else, we would need to do the ring-related=20
translations in the data path, which will be costly.

Michael, what do you think?

Thanks,
Maxime
