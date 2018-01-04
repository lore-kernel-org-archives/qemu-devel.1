Received: from eggs.gnu.org ([2001:4830:134:3::10]:57820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eX0ed-0004WC-5I
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 03:13:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eX0eY-0000Hx-IU
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 03:13:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48738)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1eX0eY-0000GS-8u
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 03:13:30 -0500
References: <cover.1514169758.git.maozy.fnst@cn.fujitsu.com>
	<16edd8d2-92e5-702c-f698-0b798db16580@cn.fujitsu.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a51f896c-8e71-6737-3a5c-19fb6529807d@redhat.com>
Date: Thu, 4 Jan 2018 16:13:24 +0800
MIME-Version: 1.0
In-Reply-To: <16edd8d2-92e5-702c-f698-0b798db16580@cn.fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?B?TGksIFpoaWppYW4v5p2OIOaZuuWdmg==?= <lizhijian@cn.fujitsu.com>, Zhang Chen <zhangckid@gmail.com>



On 2018=E5=B9=B401=E6=9C=8804=E6=97=A5 15:42, Mao Zhongyi wrote:
> Hi, Jason
>
> Long time no news, Ping...
>
> Thanks,
> Mao
>

Sorry for the delay.

Queued.

Thanks

> On 12/25/2017 10:54 AM, Mao Zhongyi wrote:
>> v4:
>> =C2=A0 p2: fix some typo
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [Zhang Chen]
>> v3:
>> =C2=A0 p1: merged the patch1 and patch2 from v2
>> =C2=A0 p2: -merged the patch3 and patch4 from v2
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -implement the same process flow for tc=
p, udp and icmp
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [Zhang Chen]
>> v2:
>> =C2=A0 p1: a new patch
>> =C2=A0 p2: a new patch
>> =C2=A0 p3: -rename the fill_pkt_seq to fill_pkt_tcp_info
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -rename pdsize & hdsize to payload_size=
 & header_size
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -reuse duplicated code
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -modified colo_packet_compare_common() =
to suit the tcp packet
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 comparison instead of build a new=
 function service for tcp.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -add more comments for the 'max_ack'
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [Zhang Chen]
>>
>> Cc: Zhang Chen <zhangckid@gmail.com>
>> Cc: Li Zhijian <lizhijian@cn.fujitsu.com>
>> Cc: Jason Wang <jasowang@redhat.com>
>>
>> Mao Zhongyi (2):
>> =C2=A0 colo: modified the payload compare function
>> =C2=A0 colo: compare the packet based on the tcp sequence number
>>
>> =C2=A0net/colo-compare.c | 411=20
>> +++++++++++++++++++++++++++++++++--------------------
>> =C2=A0net/colo.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0 9 ++
>> =C2=A0net/colo.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 15 ++
>> =C2=A0net/trace-events=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
>> =C2=A04 files changed, 284 insertions(+), 153 deletions(-)
>>
>
>
>
