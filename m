Received: from eggs.gnu.org ([2001:4830:134:3::10]:37160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1f6TLz-0006fi-OH
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 23:56:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1f6TLw-0001aj-MS
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 23:56:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56672 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1f6TLw-0001Zj-HG
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 23:56:52 -0400
References: <20180411072027.5656-1-tiwei.bie@intel.com>
	<fc66437c-ae8c-15fa-c8d3-6aa6bdb22a36@redhat.com>
	<20180411083853.qa6y6zevjpvamrdx@debian>
	<a6d0c105-5aa6-f578-a37f-39f1c2fed471@redhat.com>
	<20180411195957-mutt-send-email-mst@kernel.org>
	<8babe3ef-b401-58ec-b6d4-2b4a7e528560@redhat.com>
	<20180412063708-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c9ba4519-8576-0f53-019a-18280ca45144@redhat.com>
Date: Thu, 12 Apr 2018 11:56:37 +0800
MIME-Version: 1.0
In-Reply-To: <20180412063708-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC] vhost-user: introduce F_NEED_ALL_IOTLB
 protocol feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Tiwei Bie <tiwei.bie@intel.com>, dan.daly@intel.com, qemu-devel@nongnu.org, peterx@redhat.com, zhihong.wang@intel.com, cunming.liang@intel.com



On 2018=E5=B9=B404=E6=9C=8812=E6=97=A5 11:37, Michael S. Tsirkin wrote:
>>>>> Yeah, we are still using the existing IOTLB update messages
>>>>> to send the IOTLB messages to backend. The only difference
>>>>> is that, QEMU won't wait for the queries before sending the
>>>>> IOTLB update messages.
>>>> Yes, my question is not very clear. I mean why must need a new featu=
re bit?
>>>> It looks to me qemu code can work without this.
>>>>
>>>> Thanks
>>> Generally we avoid adding new messages without a protocol feature bit=
.
>>> While careful analysis might sometimes prove it's not a strict
>>> requirement, it's just overall a clean and robust approach.
>>>
>> Right but the looks like the patch does not introduce any new type of
>> messages.
>>
>> Thanks
> In this case remote needs to know that it will send these messages.
>
> -- MST

Ok, if some backend does not expect qemu will send without any query=20
from itself, I agree we need a new bit.

But it looks more like a workaround for buggy backend, at least vhost=20
kernel does not need to know about this.

Thanks
