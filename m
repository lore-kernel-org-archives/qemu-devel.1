Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFF0C34031
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 06:56:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F3E320801
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 06:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b9SwACyV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F3E320801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4flE-0005IE-5T
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 01:56:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59916)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1j4fkP-0004j5-Mu
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 01:55:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1j4fkO-0005Zb-J9
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 01:55:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23576
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1j4fkO-0005ZN-FC
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 01:55:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582181744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IJPoNQUbR9RRoPB45E+StQ4CvNnakAZc8GlNER0UANU=;
 b=b9SwACyVMRO5GMwOuw5EzgWghuQWA9/lUY/K4N6ZpVg3v9GF8eHwNFyBb0JZLkgWaWzlqh
 jCXXA0IeOIJ8itWGPgWKu7On6/NCJBTFOoahlqzYYPA698a4xBD2LaGqgSypvXO/WHDsj4
 HwzMQ4oOBpXz2/iQb37cnE07Voz0c/g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-c3AHMeO-PTycAMIoigWBqg-1; Thu, 20 Feb 2020 01:55:42 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF06F107ACCA;
 Thu, 20 Feb 2020 06:55:40 +0000 (UTC)
Received: from [10.72.12.159] (ovpn-12-159.pek2.redhat.com [10.72.12.159])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E3BC7790D6;
 Thu, 20 Feb 2020 06:55:35 +0000 (UTC)
Subject: Re: [PATCH v4 00/14] Fixes for DP8393X SONIC device emulation
To: Laurent Vivier <laurent@vivier.eu>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Finn Thain <fthain@telegraphics.com.au>
References: <cover.1580290069.git.fthain@telegraphics.com.au>
 <CAL1e-=iOQ52y0vbXAYaYDKqoepD09xO2=3d55WM32=9TFwFzAg@mail.gmail.com>
 <alpine.LNX.2.22.394.2002191150440.8@nippy.intranet>
 <CAL1e-=gaVz5K=JMg+iN53weESLORKEuXRJvq-SFqU7FERojP8Q@mail.gmail.com>
 <CAL1e-=iUHwE2_h0dxOE6vN_FoyRWyYA6LbL++T9BSB9X8heEcA@mail.gmail.com>
 <67b0565e-9f2c-7ef0-aca6-01cba798fad4@vivier.eu>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <b115af70-12bb-12f4-1d97-bbb8fbe5c67f@redhat.com>
Date: Thu, 20 Feb 2020 14:55:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <67b0565e-9f2c-7ef0-aca6-01cba798fad4@vivier.eu>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: c3AHMeO-PTycAMIoigWBqg-1
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/2/19 =E4=B8=8B=E5=8D=883:55, Laurent Vivier wrote:
> Le 19/02/2020 =C3=A0 02:57, Aleksandar Markovic a =C3=A9crit=C2=A0:
>> 2:54 AM Sre, 19.02.2020. Aleksandar Markovic
>> <aleksandar.m.mail@gmail.com <mailto:aleksandar.m.mail@gmail.com>> =D1=
=98=D0=B5
>> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>>> 2:06 AM Sre, 19.02.2020. Finn Thain <fthain@telegraphics.com.au
>> <mailto:fthain@telegraphics.com.au>> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=
=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>>>> On Tue, 18 Feb 2020, Aleksandar Markovic wrote:
>>>>
>>>>> On Wednesday, January 29, 2020, Finn Thain
>> <fthain@telegraphics.com.au <mailto:fthain@telegraphics.com.au>>
>>>>> wrote:
>>>>>
>>>>>> Hi All,
>>>>>>
>>>>>> There are bugs in the emulated dp8393x device that can stop packet
>>>>>> reception in a Linux/m68k guest (q800 machine).
>>>>>>
>>>>>> With a Linux/m68k v5.5 guest (q800), it's possible to remotely
>> trigger
>>>>>> an Oops by sending ping floods.
>>>>>>
>>>>>> With a Linux/mips guest (magnum machine), the driver fails to probe
>>>>>> the dp8393x device.
>>>>>>
>>>>>> With a NetBSD/arc 5.1 guest (magnum), the bugs in the device can be
>>>>>> fatal to the guest kernel.
>>>>>>
>>>>>> Whilst debugging the device, I found that the receiver algorithm
>>>>>> differs from the one described in the National Semiconductor
>>>>>> datasheet.
>>>>>>
>>>>>> This patch series resolves these bugs.
>>>>>>
>>>>>> AFAIK, all bugs in the Linux sonic driver were fixed in Linux v5.5.
>>>>>> ---
>>>>>
>>>>> Herve,
>>>>>
>>>>> Do your Jazz tests pass with these changes?
>>>>>
>>>> AFAIK those tests did not expose the NetBSD panic that is caused by
>>>> mainline QEMU (mentioned above).
>>>>
>>>> I have actually run the tests you requested (Herv=C3=A9 described them=
 in an
>>>> earlier thread). There was no regression. Quite the reverse -- it's no
>>>> longer possible to remotely crash the NetBSD kernel.
>>>>
>>>> Apparently my testing was also the first time that the jazzsonic drive=
r
>>>> (from the Linux/mips Magnum port) was tested successfully with QEMU. I=
t
>>>> doesn't work in mainline QEMU.
>>>>
>>> Well, I appologize if I missed all these facts. I just did not notice
>> them, at least not in this form. And, yes, some "Tested-by:" by Herve
>> would be desirable and nice.
>> Or, perhaps, even "Reviewed-by:".
>>
> It would be nice to have this merged before next release because q800
> machine networking is not reliable without them.


I will send the pull request that contains this series before the end of=20
this week.

Thanks


>
> And thank you to Finn for all his hard work on this device emulation.
>
> Laurent



>


