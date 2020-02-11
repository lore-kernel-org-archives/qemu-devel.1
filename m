Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEBDEC352A4
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 03:09:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AE0A20714
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 03:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="be3cdmoG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AE0A20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1Lvu-0000bu-MJ
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 22:09:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43189)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1j1LvK-00008H-8x
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 22:09:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1j1LvI-000806-6c
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 22:09:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56612
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1j1LvH-0007pH-Qp
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 22:09:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581390554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Q7Hqr3sITkWEi8tRLqnHuyAR1xm70j8p0t1g5D37cY=;
 b=be3cdmoGIlCxCvGMCElQDc/OGCtG/uF9jQ4SzKxFg/M6DYLsK59XNp7MLMsHE/kJUlGQQl
 vDhZ0cRaoNroErdeJ8Xh2UMpzG7EhbM1B0kLVA++WT6UMuBD0i7Yy3F4dIvm+AmGSaH3y2
 uXu2lO0NZa+off2+BbWlnPX3fx0GT10=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-wTrOblwqNtequMEJNU1hfw-1; Mon, 10 Feb 2020 22:09:11 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8E2D107ACC7;
 Tue, 11 Feb 2020 03:09:09 +0000 (UTC)
Received: from [10.72.12.184] (ovpn-12-184.pek2.redhat.com [10.72.12.184])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E423A1001B09;
 Tue, 11 Feb 2020 03:09:08 +0000 (UTC)
Subject: Re: [PATCH 1/1] hw/net/can: Introduce Xlnx ZynqMP CAN controller for
 QEMU
To: Vikram Garhwal <fnuv@xilinx.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <1580764010-310744-1-git-send-email-fnu.vikram@xilinx.com>
 <1580764010-310744-2-git-send-email-fnu.vikram@xilinx.com>
 <8aabde0d-62e9-96d5-0614-0e0ebff549ae@redhat.com>
 <DM6PR02MB5643F9E19DC0590E14612477BC190@DM6PR02MB5643.namprd02.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <b1b9932a-5566-5d2b-c333-8c466dcd322b@redhat.com>
Date: Tue, 11 Feb 2020 11:09:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <DM6PR02MB5643F9E19DC0590E14612477BC190@DM6PR02MB5643.namprd02.prod.outlook.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: wTrOblwqNtequMEJNU1hfw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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


On 2020/2/11 =E4=B8=8A=E5=8D=885:45, Vikram Garhwal wrote:
>>> +                }
>>> +            } else {
>>> +                /* Normal mode Tx. */
>>> +                generate_frame(&frame, data);
>>> +
>>> +                can_bus_client_send(&s->bus_client, &frame, 1);
>> I had a quick glance at can_bus_client_send():
>>
>> It did:
>>
>>   =C2=A0=C2=A0=C2=A0 QTAILQ_FOREACH(peer, &bus->clients, next) {
>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (peer->info->can_receive=
(peer)) {
>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if =
(peer =3D=3D client) {
>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 /* No loopback support for now */
>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 continue;
>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if =
(peer->info->receive(peer, frames, frames_cnt) > 0) {
>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ret =3D 1;
>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>   =C2=A0=C2=A0=C2=A0 }
>>
>> which looks not correct. We need to use qemu_send_packet() instead of
>> calling peer->info->receive() directly which bypasses filters completely=
.
> [Vikram Garhwal] Can you please elaborate it bit more on why do we need t=
o filter outgoing message? So, I can either add a filter before sending the=
 packets. I am unable to understand the use case for it. For any message wh=
ich is incoming, we are filtering it for sure before storing in update_rx_f=
ifo().


I might be not clear, I meant the netfilters supported by qemu which=20
allows you to attach a filter to a specific NetClientState, see=20
qemu_send_packet_async_with_flags. It doesn't mean the filter=20
implemented in your own NIC model.

Thanks


> Also, I can see existing CAN models like CAN sja1000 and CAN Kavser are u=
sing it same can_bus_client_send() function. However, this doesn't mean tha=
t it is the correct way to send & receive packets.


