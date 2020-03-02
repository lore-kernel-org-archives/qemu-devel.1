Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0833EC3F2D2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 05:50:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3B7A24695
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 05:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hp9Qcldj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3B7A24695
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8dxr-0001pZ-UY
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 00:50:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46910)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1j8dxE-00017U-Ow
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 00:49:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1j8dxB-0004Vi-Dj
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 00:49:23 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50719
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1j8dxB-0004VR-8W
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 00:49:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583128160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KWqCLGuOApLl8i4xhFrMQ0jM6htxzoLVqTtWO19ZfII=;
 b=hp9QcldjpvWgC6Qtz1oEDbEd9DByzUFySiXXToWrmOczwTtc3WKShX+9vLOaTBKSQrJ59y
 o9Chj1uVAksLL6o2Onc9IrmiN73nuB+93uMk5s1a0EILo9iwgYdLS9EYkXywUxmWHAz94M
 aXhpvyVMhcVGCLedBBPQrUbXQqn2g1c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-bc65Zh8bNOi2ZHTm_kvM0w-1; Mon, 02 Mar 2020 00:49:13 -0500
X-MC-Unique: bc65Zh8bNOi2ZHTm_kvM0w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7AADA107ACC4;
 Mon,  2 Mar 2020 05:49:11 +0000 (UTC)
Received: from [10.72.13.131] (ovpn-13-131.pek2.redhat.com [10.72.13.131])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CBB945C1C3;
 Mon,  2 Mar 2020 05:49:00 +0000 (UTC)
Subject: Re: [PATCH] l2tpv3: fix RFC number typo in qemu-options.hx
To: Stefan Weil <sw@weilnetz.de>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-devel@nongnu.org
References: <20200229111727.350893-1-stefanha@redhat.com>
 <ae5cd213-ada2-1b20-064c-a0bc63d3622d@weilnetz.de>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <189c4909-a269-6c4f-bb62-87b29a01ff83@redhat.com>
Date: Mon, 2 Mar 2020 13:48:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ae5cd213-ada2-1b20-064c-a0bc63d3622d@weilnetz.de>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Henrik Johansson <henrikjohansson@rocketmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/2/29 =E4=B8=8B=E5=8D=887:57, Stefan Weil wrote:
> Am 29.02.20 um 12:17 schrieb Stefan Hajnoczi:
>
>> The L2TPv3 RFC number is 3931:
>> https://tools.ietf.org/html/rfc3931
>>
>> Reported-by: Henrik Johansson <henrikjohansson@rocketmail.com>
>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>> ---
>>   qemu-options.hx | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/qemu-options.hx b/qemu-options.hx
>> index ac315c1ac4..55a539e04f 100644
>> --- a/qemu-options.hx
>> +++ b/qemu-options.hx
>> @@ -2330,7 +2330,7 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
>>       "                Linux kernel 3.3+ as well as most routers can tal=
k\n"
>>       "                L2TPv3. This transport allows connecting a VM to =
a VM,\n"
>>       "                VM to a router and even VM to Host. It is a nearl=
y-universal\n"
>> -    "                standard (RFC3391). Note - this implementation use=
s static\n"
>> +    "                standard (RFC3931). Note - this implementation use=
s static\n"
>>       "                pre-configured tunnels (same as the Linux kernel)=
.\n"
>>       "                use 'src=3D' to specify source address\n"
>>       "                use 'dst=3D' to specify destination address\n"
>> @@ -2737,7 +2737,7 @@ Example (send packets from host's 1.2.3.4):
>>   @end example
>>  =20
>>   @item -netdev l2tpv3,id=3D@var{id},src=3D@var{srcaddr},dst=3D@var{dsta=
ddr}[,srcport=3D@var{srcport}][,dstport=3D@var{dstport}],txsession=3D@var{t=
xsession}[,rxsession=3D@var{rxsession}][,ipv6][,udp][,cookie64][,counter][,=
pincounter][,txcookie=3D@var{txcookie}][,rxcookie=3D@var{rxcookie}][,offset=
=3D@var{offset}]
>> -Configure a L2TPv3 pseudowire host network backend. L2TPv3 (RFC3391) is=
 a
>> +Configure a L2TPv3 pseudowire host network backend. L2TPv3 (RFC3931) is=
 a
>>   popular protocol to transport Ethernet (and other Layer 2) data frames=
 between
>>   two systems. It is present in routers, firewalls and the Linux kernel
>>   (from version 3.3 onwards).
>
> Thank you, Stefan and Henrik.
>
> Reviewed-by: Stefan Weil <sw@weilnetz.de>
>

Applied.

Thanks


