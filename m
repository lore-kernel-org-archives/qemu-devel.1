Received: from eggs.gnu.org ([2001:4830:134:3::10]:49132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dKgYA-0004yt-IM
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 03:47:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dKgY6-0005sJ-Mw
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 03:47:42 -0400
Received: from mga06.intel.com ([134.134.136.31]:25790)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1dKgY6-0005sB-Cm
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 03:47:38 -0400
Message-ID: <593F9921.7040708@intel.com>
Date: Tue, 13 Jun 2017 15:49:53 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
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
	<fce1c1be-4105-3fd9-c734-987b85376cf9@redhat.com>
	<593F827A.9000106@intel.com>
	<74c22cd1-391d-d6b2-03f1-b247c2f78ccf@redhat.com>
In-Reply-To: <74c22cd1-391d-d6b2-03f1-b247c2f78ccf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [virtio-dev] Re: [virtio-dev] Re: [PATCH v1]
 virtio-net: enable configurable tx queue size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "stefanha@gmail.com" <stefanha@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "jan.scheurich@ericsson.com" <jan.scheurich@ericsson.com>, "armbru@redhat.com" <armbru@redhat.com>, "marcandre.lureau@gmail.com" <marcandre.lureau@gmail.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>

On 06/13/2017 02:31 PM, Jason Wang wrote:
>
>
> On 2017年06月13日 14:13, Wei Wang wrote:
>> On 06/13/2017 11:59 AM, Jason Wang wrote:
>>>
>>> On 2017年06月13日 11:55, Jason Wang wrote:
>>>> The issue is what if there's a mismatch of max #sgs between qemu and
>>>> vhost?
>>>>
>>>>> When the vhost backend is used, QEMU is not involved in the data
>>>>> path. The vhost backend
>>>>> directly gets what is offered by the guest from the vq.
>>> FYI, qemu will try to fallback to userspace if there's something wrong
>>> with vhost-kernel (e.g the IOMMU support). This doesn't work for
>>> vhost-user actually, but it works for vhost-kernel.
>>>
>>> Thanks
>>>
>>
>> That wouldn't be a problem. When it falls back to the QEMU backend,
>> the "max_chain_size" will be set according to the QEMU backend
>> (e.g. 1023). Guest will read the max_chain_size register.
>
> What if there's backend that supports less than 1023? Or in the 
> future, we increase the limit to e.g 2048?
>

I agree the potential issue is that it's assumed (hardcoded) that the vhost
backend supports 1024 chain size. This only comes to be an issue if the 
vhost
backend implementation supports less than 1024 in the future, but that
can be solved by introducing another feature to support that.

If that's acceptable, some customers will be easy to upgrade their
already deployed products to use 1024 tx queue size.

Best,
Wei
