Received: from eggs.gnu.org ([2001:4830:134:3::10]:56689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1dAXhl-0005Dy-UM
	for qemu-devel@nongnu.org; Tue, 16 May 2017 04:19:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1dAXhh-0007Mf-0T
	for qemu-devel@nongnu.org; Tue, 16 May 2017 04:19:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:10435)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1dAXhg-0007Kv-Q8
	for qemu-devel@nongnu.org; Tue, 16 May 2017 04:19:36 -0400
From: Maxime Coquelin <maxime.coquelin@redhat.com>
References: <20170511123246.31308-1-maxime.coquelin@redhat.com>
	<20170511123246.31308-7-maxime.coquelin@redhat.com>
	<20170511203345-mutt-send-email-mst@kernel.org>
	<62516ce5-9d4c-d021-c4ab-a767c7f07b31@redhat.com>
Message-ID: <8a34fb04-ec0e-5aaf-08a0-3cfceecb7e6a@redhat.com>
Date: Tue, 16 May 2017 10:19:24 +0200
MIME-Version: 1.0
In-Reply-To: <62516ce5-9d4c-d021-c4ab-a767c7f07b31@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 6/6] spec/vhost-user spec: Add IOMMU support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: peterx@redhat.com, marcandre.lureau@gmail.com, vkaplans@redhat.com, jasowang@redhat.com, wexu@redhat.com, yuanhan.liu@linux.intel.com, qemu-devel@nongnu.org, jfreiman@redhat.com



On 05/12/2017 04:21 PM, Maxime Coquelin wrote:
> 
> 
> On 05/11/2017 08:25 PM, Michael S. Tsirkin wrote:
>> On Thu, May 11, 2017 at 02:32:46PM +0200, Maxime Coquelin wrote:
>>> This patch specifies and implements the master/slave communication
>>> to support device IOTLB in slave.
>>>
>>> The vhost_iotlb_msg structure introduced for kernel backends is
>>> re-used, making the design close between the two backends.
>>>
>>> An exception is the use of the secondary channel to enable the
>>> slave to send IOTLB miss requests to the master.
>>>
>>> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
>>> ---
>>>   docs/specs/vhost-user.txt | 75 
>>> +++++++++++++++++++++++++++++++++++++++++++++++
>>>   hw/virtio/vhost-user.c    | 31 ++++++++++++++++++++
>>>   2 files changed, 106 insertions(+)
>>>
>>> diff --git a/docs/specs/vhost-user.txt b/docs/specs/vhost-user.txt
>>> index 5fa7016..4a1f0c3 100644
>>> --- a/docs/specs/vhost-user.txt
>>> +++ b/docs/specs/vhost-user.txt
>>> @@ -97,6 +97,23 @@ Depending on the request type, payload can be:
>>>      log offset: offset from start of supplied file descriptor
>>>          where logging starts (i.e. where guest address 0 would be 
>>> logged)
>>> + * An IOTLB message
>>> +   ---------------------------------------------------------
>>> +   | iova | size | user address | permissions flags | type |
>>> +   ---------------------------------------------------------
>>> +
>>> +   IOVA: a 64-bit guest I/O virtual address
>>
>> guest -> VM
> 
> Ok.

It seems that VM is never used in the doc, but guest is:
$ grep -i guest docs/specs/vhost-user.txt | wc -l
13
grep -i vm docs/specs/vhost-user.txt | wc -l
0

I think I should keep "guest" for consistency?

Thanks,
Maxime
