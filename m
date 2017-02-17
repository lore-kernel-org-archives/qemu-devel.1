Received: from eggs.gnu.org ([2001:4830:134:3::10]:39926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ceYKl-0005Yc-Jt
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 21:31:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ceYKi-0007gg-D5
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 21:31:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44108)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1ceYKi-0007fg-7x
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 21:31:40 -0500
References: <20170215083143.15897-1-famz@redhat.com>
	<7A52E0CB-9F86-4BFF-B641-C820CB9107FE@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <2411552e-f32f-6f71-e6cf-142b10c5991e@redhat.com>
Date: Fri, 17 Feb 2017 10:31:35 +0800
MIME-Version: 1.0
In-Reply-To: <7A52E0CB-9F86-4BFF-B641-C820CB9107FE@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] net: Remove useless local var pkt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dmitry Fleytman <dmitry@daynix.com>, Fam Zheng <famz@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>



On 2017=E5=B9=B402=E6=9C=8815=E6=97=A5 16:58, Dmitry Fleytman wrote:
> Reviewed-by: Dmitry Fleytman <dmitry@daynix.com>
>
> This patch also fixes compilation with NET_RX_PKT_DEBUG defined.
>
>> On 15 Feb 2017, at 10:31 AM, Fam Zheng <famz@redhat.com> wrote:
>>
>> This has been pointless since commit 605d52e62, which was a
>> search-and-replace, overlooked the redundancy.
>>
>> Signed-off-by: Fam Zheng <famz@redhat.com>
>> ---
>> hw/net/net_rx_pkt.c | 1 -
>> 1 file changed, 1 deletion(-)
>>
>> diff --git a/hw/net/net_rx_pkt.c b/hw/net/net_rx_pkt.c
>> index 1019b50..7f928d7 100644
>> --- a/hw/net/net_rx_pkt.c
>> +++ b/hw/net/net_rx_pkt.c
>> @@ -159,7 +159,6 @@ void net_rx_pkt_attach_iovec_ex(struct NetRxPkt *p=
kt,
>> void net_rx_pkt_dump(struct NetRxPkt *pkt)
>> {
>> #ifdef NET_RX_PKT_DEBUG
>> -    NetRxPkt *pkt =3D (NetRxPkt *)pkt;
>>      assert(pkt);
>>
>>      printf("RX PKT: tot_len: %d, vlan_stripped: %d, vlan_tag: %d\n",
>> --=20
>> 2.9.3
>>

Applied, thanks.
