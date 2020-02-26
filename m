Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC5CC4BA06
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 03:25:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 237D62082F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 03:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d8uk5r2Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 237D62082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6nKe-0001lL-AQ
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 22:25:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34576)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1j6nJx-0001E0-T0
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 22:25:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1j6nJw-00034q-5j
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 22:25:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24752
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1j6nJw-0002zg-1L
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 22:25:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582687510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v8PAdku5KbQVcUpwi3fOzrdOw5668tebkEQXiD+EhM0=;
 b=d8uk5r2Y90U8bcrs3Idu0HlxsC6MTAf1ckoEwdutOOBA2r870+0PfITrKdrX5FxLY+5kKE
 wcNpjU0xFY2jagQ9qAxeq/Yv5XQMdnYCyur3LccUG0n5SwoBVnjeSYrHE3ailBlNzF/JKi
 +yY80PCEiZOYQkqbE/wwROejC9DK4co=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-QhHlXdReMcyDAuD4BTIYXg-1; Tue, 25 Feb 2020 22:25:08 -0500
X-MC-Unique: QhHlXdReMcyDAuD4BTIYXg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81C70800D53;
 Wed, 26 Feb 2020 03:25:07 +0000 (UTC)
Received: from [10.72.13.217] (ovpn-13-217.pek2.redhat.com [10.72.13.217])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 840B85C28C;
 Wed, 26 Feb 2020 03:25:01 +0000 (UTC)
Subject: Re: [PATCH 1/1] hw/net/can: Introduce Xlnx ZynqMP CAN controller for
 QEMU
To: Vikram Garhwal <fnuv@xilinx.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <1580764010-310744-1-git-send-email-fnu.vikram@xilinx.com>
 <1580764010-310744-2-git-send-email-fnu.vikram@xilinx.com>
 <8aabde0d-62e9-96d5-0614-0e0ebff549ae@redhat.com>
 <DM6PR02MB5643F9E19DC0590E14612477BC190@DM6PR02MB5643.namprd02.prod.outlook.com>
 <b1b9932a-5566-5d2b-c333-8c466dcd322b@redhat.com>
 <BYAPR02MB5638E0507A08A3404D2AFB12BCED0@BYAPR02MB5638.namprd02.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <e20c4dbc-98d8-8a13-78fb-e203f4dbae71@redhat.com>
Date: Wed, 26 Feb 2020 11:24:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <BYAPR02MB5638E0507A08A3404D2AFB12BCED0@BYAPR02MB5638.namprd02.prod.outlook.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Francisco Eduardo Iglesias <figlesia@xilinx.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/2/25 =E4=B8=8B=E5=8D=882:22, Vikram Garhwal wrote:
> Hi Jason,
> Apologies for the delayed response. I tried plugging NetClientState in th=
e CAN which is required if we use qemu_send_packet but this will change the=
 underlying architecture of can-core, can-socketcan a lot. This means chang=
es the way CAN bus is created/works and socket CAN works. CAN Socket(CAN Ra=
w socket) is much different from Ethernet so plugging/using NetClient state=
 is not working here.


I get you.


>
> I apologize for still being a little confused about the filters but when =
looking into the code, I can only find them being used with ethernet frames=
. Since no other can controller uses NetClientState it makes me wonder if t=
his model perhaps was thought of being an ethernet NIC?


Nope NetclientState is not necessarily a NIC, it can be a peer of the=20
NIC (e.g network backend like tap, hubport etc).


> Or has the code in net/can/ which I referenced been obsoleted?


No :)


>
> Sharing this link for SocketCAN(in case you want to have a look): https:/=
/www.kernel.org/doc/Documentation/networking/can.txt. Section 4 talks on ho=
w CAN Socket is intended to work. Equivalent file is located as net/can-soc=
ketcan.c.


Thanks for the pointer.

I agree that there's no need to change that part. But we may consider to=20
unify the CanBusClientState and NetClientState in the future.


>  =20
> Regards,
> Vikram
>
>> -----Original Message-----
>> From: Jason Wang <jasowang@redhat.com>
>> Sent: Monday, February 10, 2020 7:09 PM
>> To: Vikram Garhwal <fnuv@xilinx.com>; qemu-devel@nongnu.org
>> Subject: Re: [PATCH 1/1] hw/net/can: Introduce Xlnx ZynqMP CAN controlle=
r
>> for QEMU
>>
>>
>> On 2020/2/11 =E4=B8=8A=E5=8D=885:45, Vikram Garhwal wrote:
>>>>> +                }
>>>>> +            } else {
>>>>> +                /* Normal mode Tx. */
>>>>> +                generate_frame(&frame, data);
>>>>> +
>>>>> +                can_bus_client_send(&s->bus_client, &frame, 1);
>>>> I had a quick glance at can_bus_client_send():
>>>>
>>>> It did:
>>>>
>>>>    =C2=A0=C2=A0=C2=A0 QTAILQ_FOREACH(peer, &bus->clients, next) {
>>>>    =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (peer->info->can_rece=
ive(peer)) {
>>>>    =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
if (peer =3D=3D client) {
>>>>    =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 /* No loopback support for now */
>>>>    =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 continue;
>>>>    =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
}
>>>>    =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
if (peer->info->receive(peer, frames, frames_cnt) > 0) {
>>>>    =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D 1;
>>>>    =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
}
>>>>    =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>    =C2=A0=C2=A0=C2=A0 }
>>>>
>>>> which looks not correct. We need to use qemu_send_packet() instead of
>>>> calling peer->info->receive() directly which bypasses filters complete=
ly.
>>> [Vikram Garhwal] Can you please elaborate it bit more on why do we need
>> to filter outgoing message? So, I can either add a filter before sending=
 the
>> packets. I am unable to understand the use case for it. For any message =
which
>> is incoming, we are filtering it for sure before storing in update_rx_fi=
fo().
>>
>>
>> I might be not clear, I meant the netfilters supported by qemu which all=
ows
>> you to attach a filter to a specific NetClientState, see
>> qemu_send_packet_async_with_flags. It doesn't mean the filter implemente=
d
>> in your own NIC model.
>>
>> Thanks
>>
>>
>>> Also, I can see existing CAN models like CAN sja1000 and CAN Kavser are
>> using it same can_bus_client_send() function. However, this doesn't mean
>> that it is the correct way to send & receive packets.


