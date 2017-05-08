Received: from eggs.gnu.org ([2001:4830:134:3::10]:43689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1d7Xcl-0002hs-SR
	for qemu-devel@nongnu.org; Sun, 07 May 2017 21:38:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1d7Xci-0005q9-P3
	for qemu-devel@nongnu.org; Sun, 07 May 2017 21:38:07 -0400
Received: from mga02.intel.com ([134.134.136.20]:50540)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1d7Xci-0005nT-FL
	for qemu-devel@nongnu.org; Sun, 07 May 2017 21:38:04 -0400
Message-ID: <590FCC6D.9040005@intel.com>
Date: Mon, 08 May 2017 09:39:57 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <286AC319A985734F985F78AFA26841F7391EF490@shsmsx102.ccr.corp.intel.com>
	<5ec930ef-82e1-85ee-71bd-2d3f1b554a68@redhat.com>
	<590C1948.6010301@intel.com>
	<3f76f518-c157-822e-17c6-17d81f6ac62a@redhat.com>
In-Reply-To: <3f76f518-c157-822e-17c6-17d81f6ac62a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [virtio-dev] Vhost-pci RFC2.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>

On 05/05/2017 05:18 PM, Jason Wang wrote:
>
>
> On 2017年05月05日 14:18, Wei Wang wrote:
>> On 05/05/2017 12:05 PM, Jason Wang wrote:
>>>
>>>
>>> On 2017年04月19日 14:38, Wang, Wei W wrote:
>>>> Hi,
>>>> We made some design changes to the original vhost-pci design, and 
>>>> want to open
>>>> a discussion about the latest design (labelled 2.0) and its 
>>>> extension (2.1).
>>>> 2.0 design: One VM shares the entire memory of another VM
>>>> 2.1 design: One VM uses an intermediate memory shared with another 
>>>> VM for
>>>>                      packet transmission.
>>>> For the convenience of discussion, I have some pictures presented 
>>>> at this link:
>>>> _https://github.com/wei-w-wang/vhost-pci-discussion/blob/master/vhost-pci-rfc2.0.pdf_ 
>>>>
>>>
>>> Hi, is there any doc or pointer that describes the the design in 
>>> detail? E.g patch 4 in v1 
>>> https://lists.gnu.org/archive/html/qemu-devel/2016-05/msg05163.html.
>>>
>>> Thanks
>>
>> That link is kind of obsolete.
>>
>> We currently only have high level introduction of the design:
>>
>> For the device part design, please check slide 12:
>> http://www.linux-kvm.org/images/5/55/02x07A-Wei_Wang-Design_of-Vhost-pci.pdf 
>>
>> The vhost-pci protocol is changed to be an extension of vhost-user 
>> protocol.
>>
>> For the driver part design, please check Fig. 2:
>>
>> https://github.com/wei-w-wang/vhost-pci-discussion/blob/master/vhost-pci-rfc2.0.pdf 
>>
>
> Thanks for the pointers. It would be nice to have a doc like patch 4 
> in v1, this could ease reviewers, otherwise we may guess and ask for 
> them.
>

Thanks for joining the review. I'm preparing the v2 QEMU patches. I will 
have the code sent out first,
which would be helpful for understanding how the design works.

Best,
Wei
