Received: from eggs.gnu.org ([209.51.188.92]:47582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gjJkM-00041U-EP
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 03:06:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gjJkL-0002AS-IW
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 03:06:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35084)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gjJkL-00029w-B8
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 03:06:53 -0500
References: <20190114140510.7161-1-chen.zhang@intel.com>
	<0b78cb56-aab1-aa20-3e38-bf7db25151af@redhat.com>
	<21eec332-311f-b5df-e4bc-1e7781b3ff35@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <cadce6f6-c624-152f-ef10-40a338b60271@redhat.com>
Date: Tue, 15 Jan 2019 16:06:45 +0800
MIME-Version: 1.0
In-Reply-To: <21eec332-311f-b5df-e4bc-1e7781b3ff35@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] net/colo-compare.c: Remove duplicated code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Thomas Huth <thuth@redhat.com>, Zhang Chen <chen.zhang@intel.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Zhang Chen <zhangckid@gmail.com>, qemu-dev <qemu-devel@nongnu.org>


On 2019/1/15 =E4=B8=8A=E5=8D=8812:44, Philippe Mathieu-Daud=C3=A9 wrote:
> On 1/14/19 3:30 PM, Thomas Huth wrote:
>> On 2019-01-14 15:05, Zhang Chen wrote:
>>> From: Zhang Chen <chen.zhang@intel.com>
>>>
>>> Fix duplicated code:
>>> https://bugs.launchpad.net/qemu/+bug/1811499
>>>
> Fixes: f449c9e549c
>
>>> Signed-off-by: Zhang Chen <chen.zhang@intel.com>
>>> ---
>>>   net/colo-compare.c | 8 --------
>>>   1 file changed, 8 deletions(-)
>>>
>>> diff --git a/net/colo-compare.c b/net/colo-compare.c
>>> index 9156ab3349..fa3fd0632d 100644
>>> --- a/net/colo-compare.c
>>> +++ b/net/colo-compare.c
>>> @@ -285,14 +285,6 @@ static bool colo_mark_tcp_pkt(Packet *ppkt, Pack=
et *spkt,
>>>   {
>>>       *mark =3D 0;
>>>  =20
>>> -    if (ppkt->tcp_seq =3D=3D spkt->tcp_seq && ppkt->seq_end =3D=3D s=
pkt->seq_end) {
>>> -        if (colo_compare_packet_payload(ppkt, spkt,
>>> -                                        ppkt->header_size, spkt->hea=
der_size,
>>> -                                        ppkt->payload_size)) {
>>> -            *mark =3D COLO_COMPARE_FREE_SECONDARY | COLO_COMPARE_FRE=
E_PRIMARY;
>>> -            return true;
>>> -        }
>>> -    }
>>>       if (ppkt->tcp_seq =3D=3D spkt->tcp_seq && ppkt->seq_end =3D=3D =
spkt->seq_end) {
>>>           if (colo_compare_packet_payload(ppkt, spkt,
>>>                                           ppkt->header_size, spkt->he=
ader_size,
>>>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>

Applied.

Thanks
