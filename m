Received: from eggs.gnu.org ([2001:4830:134:3::10]:40055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1d8OMt-0004Dt-0k
	for qemu-devel@nongnu.org; Wed, 10 May 2017 05:57:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1d8OMp-0002Oc-5Z
	for qemu-devel@nongnu.org; Wed, 10 May 2017 05:57:15 -0400
Received: from mga11.intel.com ([192.55.52.93]:32741)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1d8OMo-0002O6-Sg
	for qemu-devel@nongnu.org; Wed, 10 May 2017 05:57:11 -0400
Message-ID: <5912E469.8020609@intel.com>
Date: Wed, 10 May 2017 17:59:05 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <286AC319A985734F985F78AFA26841F7391FDD30@shsmsx102.ccr.corp.intel.com>
	<056500d7-6a91-12e5-be1d-2b2beebd0430@redhat.com>
	<20170505233541-mutt-send-email-mst@kernel.org>
	<286AC319A985734F985F78AFA26841F7391FFC13@shsmsx102.ccr.corp.intel.com>
	<3ae2bfc4-f0ff-a5db-cc9a-bd844b42d2ba@redhat.com>
In-Reply-To: <3ae2bfc4-f0ff-a5db-cc9a-bd844b42d2ba@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] virtio-net: configurable TX queue size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Stefan Hajnoczi <stefanha@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Jan Scheurich <jan.scheurich@ericsson.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>

On 05/10/2017 05:00 PM, Jason Wang wrote:
>
>
> On 2017年05月07日 12:39, Wang, Wei W wrote:
>> On 05/06/2017 04:37 AM, Michael S. Tsirkin wrote:
>>> On Fri, May 05, 2017 at 10:27:13AM +0800, Jason Wang wrote:
>>>>
>>>> On 2017年05月04日 18:58, Wang, Wei W wrote:
>>>>> Hi,
>>>>>
>>>>> I want to re-open the discussion left long time ago:
>>>>> https://lists.gnu.org/archive/html/qemu-devel/2015-11/msg06194.html
>>>>> , and discuss the possibility of changing the hardcoded (256) TX
>>>>> queue size to be configurable between 256 and 1024.
>>>> Yes, I think we probably need this.
>>>>
>>>>> The reason to propose this request is that a severe issue of packet
>>>>> drops in TX direction was observed with the existing hardcoded 256
>>>>> queue size, which causes performance issues for packet drop
>>>>> sensitive guest applications that cannot use indirect descriptor
>>>>> tables. The issue goes away with 1K queue size.
>>>> Do we need even more, what if we find 1K is even not sufficient in the
>>>> future? Modern nics has size up to ~8192.
>>>>
>>>>> The concern mentioned in the previous discussion (please check the
>>>>> link
>>>>> above) is that the number of chained descriptors would exceed
>>>>> UIO_MAXIOV (1024) supported by the Linux.
>>>> We could try to address this limitation but probably need a new
>>>> feature bit to allow more than UIO_MAXIOV sgs.
>>> I'd say we should split the queue size and the sg size.
>>>
>> I think we can just split the iov size in the virtio-net backend,
>> that is, split the large iov[] into multiple iov[1024] to send to 
>> writev.
>>
>> Best,
>> Wei
>
> Maybe, but let's first clarify the limitation and new ability in the 
> spec. Want to send a patch?
>
Hi Jason,

I just posted a new discussion in another email. Please have a check if 
it's possible to solve the
issue from the existing implementation.

Best,
Wei
