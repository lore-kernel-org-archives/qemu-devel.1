Received: from eggs.gnu.org ([209.51.188.92]:44151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gwMhn-0001CN-26
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 02:54:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gwMhm-0007sC-7k
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 02:54:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57508)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gwMhm-0007qH-0J
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 02:54:10 -0500
References: <1550118402-4057-1-git-send-email-wexu@redhat.com>
	<1550118402-4057-10-git-send-email-wexu@redhat.com>
	<1c16f234-af83-23c8-2194-94be63574299@redhat.com>
	<20190219105155.GD15343@wei-ubt>
	<b6469e59-0db7-5f6d-8b21-355ffdebb689@redhat.com>
	<20190220015441.GB23868@wei-ubt>
	<9a9751aa-0cfc-151a-890c-ae70a9a37d64@redhat.com>
	<20190220040109.GD23868@wei-ubt>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <13582233-ada9-7d7f-a250-5cc1640b51de@redhat.com>
Date: Wed, 20 Feb 2019 15:53:56 +0800
MIME-Version: 1.0
In-Reply-To: <20190220040109.GD23868@wei-ubt>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 09/11] virtio-net: update the head
 descriptor in a chain lastly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Xu <wexu@redhat.com>
Cc: jfreiman@redhat.com, maxime.coquelin@redhat.com, qemu-devel@nongnu.org, tiwei.bie@intel.com, mst@redhat.com


On 2019/2/20 =E4=B8=8B=E5=8D=8812:01, Wei Xu wrote:
>>
>>> AFAICT, virtqueue_fill() is a generic API for all relevant userspace =
virtio
>>> devices that do not support batching , without touching virtqueue_fil=
l(),
>>> supporting batching changes the meaning of the parameter 'idx' which =
should
>>> be kept overall.
>>>
>>> To fix it, I got two proposals so far:
>>> 1). batching support(two APIs needed to keep compatibility)
>>> 2). save a head elem for a vq instead of caching an array of elems li=
ke vhost,
>>>      and introduce a new API(virtqueue_chain_fill()) functioning with=
 an
>>>      additional parameter 'more' to the current virtqueue_fill() to i=
ndicate if
>>>      there are more descriptor(s) coming in a chain.
>>>
>>> Either way it changes the API somehow and it does not seem to be clea=
n and clear
>>> as wanted.
>> It's as simple as accepting an array of elems in e.g
>> virtqueue_fill_batched()?
> It is trivial for both, my concern is an array elements need to be allo=
cated dynamically
> due to vq size which no any other devices are using, a head would be en=
ough for 2.
>

Do you see any issue for this?

Thanks
