Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D399C432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 05:56:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E50121D7B
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 05:56:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E50121D7B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sjtu.edu.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD0Hp-0003bp-Hn
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 01:56:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60314)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Fan_Yang@sjtu.edu.cn>) id 1iD0Fe-0001Vo-Jk
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 01:54:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Fan_Yang@sjtu.edu.cn>) id 1iD0Fd-0005fl-5G
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 01:54:10 -0400
Received: from smtp180.sjtu.edu.cn ([202.120.2.180]:50848)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Fan_Yang@sjtu.edu.cn>)
 id 1iD0Fc-0005d5-7J
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 01:54:09 -0400
Received: from proxy01.sjtu.edu.cn (unknown [202.112.26.54])
 by smtp180.sjtu.edu.cn (Postfix) with ESMTPS id 0B50C1008CBC1;
 Wed, 25 Sep 2019 13:53:54 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
 by proxy01.sjtu.edu.cn (Postfix) with ESMTP id EFB9220066ABA;
 Wed, 25 Sep 2019 13:53:53 +0800 (CST)
X-Virus-Scanned: amavisd-new at proxy01.sjtu.edu.cn
Received: from proxy01.sjtu.edu.cn ([127.0.0.1])
 by localhost (proxy01.sjtu.edu.cn [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id obgHJSyU7lvn; Wed, 25 Sep 2019 13:53:53 +0800 (CST)
Received: from Fans-Air.ipads-lab.se.sjtu.edu.cn (unknown [202.120.40.82])
 (Authenticated sender: Fan_Yang)
 by proxy01.sjtu.edu.cn (Postfix) with ESMTPSA id C4DB220064664;
 Wed, 25 Sep 2019 13:53:53 +0800 (CST)
From: Fan Yang <Fan_Yang@sjtu.edu.cn>
To: Jason Wang <jasowang@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?= <philmd@redhat.com>, qemu-devel@nongnu.org, Zhang Chen
 <chen.zhang@intel.com>, Li Zhijian <lizhijian@cn.fujitsu.com>
Subject: Re: [PATCH] COLO-compare: Fix incorrect `if` logic
In-Reply-To: <413e09c6-9376-5021-bf69-c3797237ae9d@redhat.com>
References: <m2y2yd9482.fsf@Fans-Air.ipads-lab.se.sjtu.edu.cn>
 <6d23190f-e68a-3000-c288-84f2e0d50b07@redhat.com>
 <413e09c6-9376-5021-bf69-c3797237ae9d@redhat.com>
Date: Wed, 25 Sep 2019 13:53:53 +0800
Message-ID: <m2r2449b0u.fsf@Fans-Air.ipads-lab.se.sjtu.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 202.120.2.180
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

OK, thank you all :)

Jason Wang <jasowang@redhat.com> writes:

> On 2019/9/24 =E4=B8=8B=E5=8D=8811:35, Philippe Mathieu-Daud=C3=A9 wrote:
>> Hi Fan,
>>
>> you forgot to Cc the maintainers (doing that for you):
>>
>> ./scripts/get_maintainer.pl -f net/colo-compare.c
>> Zhang Chen <chen.zhang@intel.com> (supporter:COLO Proxy)
>> Li Zhijian <lizhijian@cn.fujitsu.com> (supporter:COLO Proxy)
>> Jason Wang <jasowang@redhat.com> (maintainer:Network device ba...)
>> qemu-devel@nongnu.org (open list:All patches CC here)
>>
>> On 9/24/19 4:08 PM, Fan Yang wrote:
>>> 'colo_mark_tcp_pkt' should return 'true' when packets are the same, and
>>> 'false' otherwise.  However, it returns 'true' when
>>> 'colo_compare_packet_payload' returns non-zero while
>>> 'colo_compare_packet_payload' is just a 'memcmp'.  The result is that
>>> COLO-compare reports inconsistent TCP packets when they are actually
>>> the same.
>>>
>> Fixes: f449c9e549c
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
>
> Applied.
>
> Thanks
>
>
>>
>>> Signed-off-by: Fan Yang <Fan_Yang@sjtu.edu.cn>
>>> ---
>>>  net/colo-compare.c | 6 +++---
>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/net/colo-compare.c b/net/colo-compare.c
>>> index 7489840bde..7ee17f2cf8 100644
>>> --- a/net/colo-compare.c
>>> +++ b/net/colo-compare.c
>>> @@ -319,7 +319,7 @@ static bool colo_mark_tcp_pkt(Packet *ppkt, Packet =
*spkt,
>>>      *mark =3D 0;
>>>=20=20
>>>      if (ppkt->tcp_seq =3D=3D spkt->tcp_seq && ppkt->seq_end =3D=3D spk=
t->seq_end) {
>>> -        if (colo_compare_packet_payload(ppkt, spkt,
>>> +        if (!colo_compare_packet_payload(ppkt, spkt,
>>>                                          ppkt->header_size, spkt->heade=
r_size,
>>>                                          ppkt->payload_size)) {
>>>              *mark =3D COLO_COMPARE_FREE_SECONDARY | COLO_COMPARE_FREE_=
PRIMARY;
>>> @@ -329,7 +329,7 @@ static bool colo_mark_tcp_pkt(Packet *ppkt, Packet =
*spkt,
>>>=20=20
>>>      /* one part of secondary packet payload still need to be compared =
*/
>>>      if (!after(ppkt->seq_end, spkt->seq_end)) {
>>> -        if (colo_compare_packet_payload(ppkt, spkt,
>>> +        if (!colo_compare_packet_payload(ppkt, spkt,
>>>                                          ppkt->header_size + ppkt->offs=
et,
>>>                                          spkt->header_size + spkt->offs=
et,
>>>                                          ppkt->payload_size - ppkt->off=
set)) {
>>> @@ -348,7 +348,7 @@ static bool colo_mark_tcp_pkt(Packet *ppkt, Packet =
*spkt,
>>>          /* primary packet is longer than secondary packet, compare
>>>           * the same part and mark the primary packet offset
>>>           */
>>> -        if (colo_compare_packet_payload(ppkt, spkt,
>>> +        if (!colo_compare_packet_payload(ppkt, spkt,
>>>                                          ppkt->header_size + ppkt->offs=
et,
>>>                                          spkt->header_size + spkt->offs=
et,
>>>                                          spkt->payload_size - spkt->off=
set)) {
>>>

