Received: from eggs.gnu.org ([2001:4830:134:3::10]:34798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1eX0qn-0000Es-UB
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 03:26:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1eX0qj-0001MX-Vw
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 03:26:09 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:24809
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1eX0qj-0001J7-JZ
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 03:26:05 -0500
References: <cover.1514169758.git.maozy.fnst@cn.fujitsu.com>
	<16edd8d2-92e5-702c-f698-0b798db16580@cn.fujitsu.com>
	<a51f896c-8e71-6737-3a5c-19fb6529807d@redhat.com>
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Message-ID: <98f5762a-d668-9b38-0bf0-59fed953b5eb@cn.fujitsu.com>
Date: Thu, 4 Jan 2018 16:21:03 +0800
MIME-Version: 1.0
In-Reply-To: <a51f896c-8e71-6737-3a5c-19fb6529807d@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 0/2] Rewrite TCP packet comparison in
 colo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?B?TGksIFpoaWppYW4v5p2OIOaZuuWdmg==?= <lizhijian@cn.fujitsu.com>, Zhang Chen <zhangckid@gmail.com>



On 01/04/2018 04:13 PM, Jason Wang wrote:
>
>
> On 2018年01月04日 15:42, Mao Zhongyi wrote:
>> Hi, Jason
>>
>> Long time no news, Ping...
>>
>> Thanks,
>> Mao
>>
>
> Sorry for the delay.

No worries, thanks :)

>
> Queued.
>
> Thanks
>
>> On 12/25/2017 10:54 AM, Mao Zhongyi wrote:
>>> v4:
>>>   p2: fix some typo
>>>                                                 [Zhang Chen]
>>> v3:
>>>   p1: merged the patch1 and patch2 from v2
>>>   p2: -merged the patch3 and patch4 from v2
>>>       -implement the same process flow for tcp, udp and icmp
>>>
>>>                                                 [Zhang Chen]
>>> v2:
>>>   p1: a new patch
>>>   p2: a new patch
>>>   p3: -rename the fill_pkt_seq to fill_pkt_tcp_info
>>>       -rename pdsize & hdsize to payload_size & header_size
>>>       -reuse duplicated code
>>>       -modified colo_packet_compare_common() to suit the tcp packet
>>>        comparison instead of build a new function service for tcp.
>>>       -add more comments for the 'max_ack'
>>>                                                 [Zhang Chen]
>>>
>>> Cc: Zhang Chen <zhangckid@gmail.com>
>>> Cc: Li Zhijian <lizhijian@cn.fujitsu.com>
>>> Cc: Jason Wang <jasowang@redhat.com>
>>>
>>> Mao Zhongyi (2):
>>>   colo: modified the payload compare function
>>>   colo: compare the packet based on the tcp sequence number
>>>
>>>  net/colo-compare.c | 411 +++++++++++++++++++++++++++++++++--------------------
>>>  net/colo.c         |   9 ++
>>>  net/colo.h         |  15 ++
>>>  net/trace-events   |   2 +-
>>>  4 files changed, 284 insertions(+), 153 deletions(-)
>>>
>>
>>
>>
>
>
>
>
