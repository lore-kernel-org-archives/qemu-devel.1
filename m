Received: from eggs.gnu.org ([2001:4830:134:3::10]:42463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fQPKJ-0003Ru-1r
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 23:41:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fQPKE-0007MG-54
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 23:41:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33576 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1fQPKD-0007Ln-W5
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 23:41:30 -0400
References: <1528225683-11413-1-git-send-email-wexu@redhat.com>
	<1528225683-11413-6-git-send-email-wexu@redhat.com>
	<f94057e1-5d6f-c90d-5b21-d1cd561d6d53@redhat.com>
	<20180606033815.GA3749@wei-ubt>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <04a61e4a-f0ae-0e7d-03aa-c488e89fd1ca@redhat.com>
Date: Wed, 6 Jun 2018 11:41:18 +0800
MIME-Version: 1.0
In-Reply-To: <20180606033815.GA3749@wei-ubt>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v2 5/8] virtio: queue pop for packed ring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Xu <wexu@redhat.com>
Cc: qemu-devel@nongnu.org, jfreimann@redhat.com, tiwei.bie@intel.com, mst@redhat.com



On 2018=E5=B9=B406=E6=9C=8806=E6=97=A5 11:38, Wei Xu wrote:
>>> +
>>> +    head =3D vq->last_avail_idx;
>>> +    i =3D head;
>>> +
>>> +    caches =3D vring_get_region_caches(vq);
>>> +    cache =3D &caches->desc;
>>> +    vring_packed_desc_read(vdev, &desc, cache, i);
>> I think we'd better find a way to avoid reading descriptor twice.
> Do you mean here and the read for empty check?
>
> Wei
>

Yes.

Thanks
