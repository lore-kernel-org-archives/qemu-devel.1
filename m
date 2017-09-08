Received: from eggs.gnu.org ([2001:4830:134:3::10]:33292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.ivanov@cambridgegreys.com>) id 1dqMzS-0006qn-G8
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 13:22:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.ivanov@cambridgegreys.com>) id 1dqMzN-0007Xv-Hu
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 13:22:50 -0400
Received: from ivanoab5.miniserver.com ([78.31.111.25]:39707
	helo=www.kot-begemot.co.uk)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1dqMzN-0007UO-BI
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 13:22:45 -0400
References: <20170718170819.28494-1-anton.ivanov@cambridgegreys.com>
	<20170718170819.28494-4-anton.ivanov@cambridgegreys.com>
	<e31eb033-a770-e5fd-97b0-0b50f268c22c@redhat.com>
	<b1194532-a97a-33d3-92d4-8531674d358d@cambridgegreys.com>
	<2c69da12-2b18-2272-6eff-c6223667aad0@redhat.com>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <d1ccdbc2-9126-fcb1-e646-88cc90f7706e@cambridgegreys.com>
Date: Fri, 8 Sep 2017 18:22:38 +0100
MIME-Version: 1.0
In-Reply-To: <2c69da12-2b18-2272-6eff-c6223667aad0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/3] Unified Datagram Socket Transport -
 raw support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org

On 24/07/17 05:03, Jason Wang wrote:
>
>
> On 2017年07月22日 02:50, Anton Ivanov wrote:
>>
>> [snip]
>>
>>>> +    "-netdev raw,id=str,ifname=ifname\n"
>>>> +    "                configure a network backend with ID 'str'
>>>> connected to\n"
>>>> +    "                an Ethernet interface named ifname via raw
>>>> socket.\n"
>>>> +    "                This backend does not change the interface
>>>> settings.\n"
>>>> +    "                Most interfaces will require being set into
>>>> promisc mode,\n"
>>>> +    "                as well having most offloads (TSO, etc)
>>>> turned off.\n"
>>>> +    "                Some virtual interfaces like tap support only
>>>> RX.\n"
>>>
>>> Pay attention that qemu supports vnet header. So any reason to turn
>>> off e.g TSO here?
>>
>> I am not aware of any means to get extra info like checksums, etc
>> show up on raw socket read.
>>
>> If you know a way to make them show up, this is worth investigating.
>
> See packet_rcv_vnet(). But a known 'issue' for raw socket is that it
> forbids change vnet header length after creation, we may need some
> workaround in qemu.

There are a couple of other issues - if I understand the situation
correctly, probing the vnet header size relies on tap ioctls.

I have some support for this working now. I will try to get around to
redo the patches as per your last comments + initial vnet header support
and re-submit.

One definitive advantage of having it is that it allows to detect if
GSO/TSO is enabled on the interface as this is not something that gets
along very well with fixed buffer size vector IO.

A.

[snip]
>>>
>
>


-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
