Received: from eggs.gnu.org ([209.51.188.92]:36165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gj5M3-0002R9-W9
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:44:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gj5M3-0007bQ-3V
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:44:52 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35743)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gj5M2-0007aM-Ty
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:44:51 -0500
Received: by mail-wm1-f68.google.com with SMTP id t200so252283wmt.0
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 08:44:50 -0800 (PST)
References: <20190114140510.7161-1-chen.zhang@intel.com>
	<0b78cb56-aab1-aa20-3e38-bf7db25151af@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <21eec332-311f-b5df-e4bc-1e7781b3ff35@redhat.com>
Date: Mon, 14 Jan 2019 17:44:48 +0100
MIME-Version: 1.0
In-Reply-To: <0b78cb56-aab1-aa20-3e38-bf7db25151af@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] net/colo-compare.c: Remove duplicated code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Zhang Chen <chen.zhang@intel.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Zhang Chen <zhangckid@gmail.com>, Jason Wang <jasowang@redhat.com>, qemu-dev <qemu-devel@nongnu.org>

On 1/14/19 3:30 PM, Thomas Huth wrote:
> On 2019-01-14 15:05, Zhang Chen wrote:
>> From: Zhang Chen <chen.zhang@intel.com>
>>
>> Fix duplicated code:
>> https://bugs.launchpad.net/qemu/+bug/1811499
>>

Fixes: f449c9e549c

>> Signed-off-by: Zhang Chen <chen.zhang@intel.com>
>> ---
>>  net/colo-compare.c | 8 --------
>>  1 file changed, 8 deletions(-)
>>
>> diff --git a/net/colo-compare.c b/net/colo-compare.c
>> index 9156ab3349..fa3fd0632d 100644
>> --- a/net/colo-compare.c
>> +++ b/net/colo-compare.c
>> @@ -285,14 +285,6 @@ static bool colo_mark_tcp_pkt(Packet *ppkt, Packet *spkt,
>>  {
>>      *mark = 0;
>>  
>> -    if (ppkt->tcp_seq == spkt->tcp_seq && ppkt->seq_end == spkt->seq_end) {
>> -        if (colo_compare_packet_payload(ppkt, spkt,
>> -                                        ppkt->header_size, spkt->header_size,
>> -                                        ppkt->payload_size)) {
>> -            *mark = COLO_COMPARE_FREE_SECONDARY | COLO_COMPARE_FREE_PRIMARY;
>> -            return true;
>> -        }
>> -    }
>>      if (ppkt->tcp_seq == spkt->tcp_seq && ppkt->seq_end == spkt->seq_end) {
>>          if (colo_compare_packet_payload(ppkt, spkt,
>>                                          ppkt->header_size, spkt->header_size,
>>
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
