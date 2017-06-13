Received: from eggs.gnu.org ([2001:4830:134:3::10]:40785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dKczj-0006JQ-3t
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 23:59:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dKczg-0003da-3q
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 23:59:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53338)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dKczf-0003dJ-UI
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 23:59:52 -0400
From: Jason Wang <jasowang@redhat.com>
References: <1496653049-44530-1-git-send-email-wei.w.wang@intel.com>
	<20170605182514-mutt-send-email-mst@kernel.org>
	<5937511D.5070205@intel.com>
	<20170608220006-mutt-send-email-mst@kernel.org>
	<593A0F47.5080806@intel.com> <593E5F46.5080704@intel.com>
	<20170612234035-mutt-send-email-mst@kernel.org>
	<593F57C0.9080701@intel.com>
	<4639c51b-32a6-3528-2ed6-c5f6296b6300@redhat.com>
	<593F6133.9050804@intel.com>
	<65faf3f9-a839-0b04-c740-6b2a60a51cf6@redhat.com>
Message-ID: <fce1c1be-4105-3fd9-c734-987b85376cf9@redhat.com>
Date: Tue, 13 Jun 2017 11:59:34 +0800
MIME-Version: 1.0
In-Reply-To: <65faf3f9-a839-0b04-c740-6b2a60a51cf6@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [virtio-dev] Re: [PATCH v1] virtio-net: enable
 configurable tx queue size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, stefanha@gmail.com, armbru@redhat.com, jan.scheurich@ericsson.com, qemu-devel@nongnu.org, marcandre.lureau@gmail.com, pbonzini@redhat.com



On 2017=E5=B9=B406=E6=9C=8813=E6=97=A5 11:55, Jason Wang wrote:
>
>
> On 2017=E5=B9=B406=E6=9C=8813=E6=97=A5 11:51, Wei Wang wrote:
>> On 06/13/2017 11:19 AM, Jason Wang wrote:
>>>
>>>
>>> On 2017=E5=B9=B406=E6=9C=8813=E6=97=A5 11:10, Wei Wang wrote:
>>>> On 06/13/2017 04:43 AM, Michael S. Tsirkin wrote:
>>>>> On Mon, Jun 12, 2017 at 05:30:46PM +0800, Wei Wang wrote:
>>>>>> Ping for comments, thanks.
>>>>> This was only posted a week ago, might be a bit too short for some
>>>>> people.
>>>> OK, sorry for the push.
>>>>> A couple of weeks is more reasonable before you ping.  Also, I
>>>>> sent a bunch of comments on Thu, 8 Jun 2017.  You should probably
>>>>> address these.
>>>>>
>>>> I responded to the comments. The main question is that I'm not sure
>>>> why we need the vhost backend to support VIRTIO_F_MAX_CHAIN_SIZE.
>>>> IMHO, that should be a feature proposed to solve the possible issue
>>>> caused by the QEMU implemented backend.
>>>
>>> The issue is what if there's a mismatch of max #sgs between qemu and=20
>>> vhost?
>>>
>>
>> When the vhost backend is used, QEMU is not involved in the data=20
>> path. The vhost backend
>> directly gets what is offered by the guest from the vq.

FYI, qemu will try to fallback to userspace if there's something wrong=20
with vhost-kernel (e.g the IOMMU support). This doesn't work for=20
vhost-user actually, but it works for vhost-kernel.

Thanks

>> Why would there be a mismatch of
>> max #sgs between QEMU and vhost, and what is the QEMU side max #sgs=20
>> used for? Thanks.
>
> You need query the backend max #sgs in this case at least. no? If not=20
> how do you know the value is supported by the backend?
>
> Thanks
>
>>
>> Best,
>> Wei
>>
>>
>
>
