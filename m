Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04748C33CB2
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 06:53:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C012E20705
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 06:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G9ArHoVM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C012E20705
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixQAu-0005Pj-TG
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 01:53:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44273)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gshan@redhat.com>) id 1ixQ9H-0003eZ-D0
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 01:51:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <gshan@redhat.com>) id 1ixQ9G-00081c-AZ
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 01:51:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41819
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <gshan@redhat.com>) id 1ixQ9G-00081B-50
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 01:51:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580453485;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ktm+s9iOoW5Y07EophjJ1TTSvJylUK4rTzqOdjlKC04=;
 b=G9ArHoVMLl0BYVhiPUwsTzv4NECpmqxaFgOpk/e0aCEX8SatwwQ5A4wGA7l+oYXy6ZziGs
 Wr1h0vvwot/EA2uuuyDBjJuiZDcIdk3g7krvGuitlOv2tyyJEkhI+GM1BIB/X5aY/fpEAO
 hM0GvHXpMK23mcnQBPpqSSunMDsLmOo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-bVjwnyfxNzyWyobIqSSqdw-1; Fri, 31 Jan 2020 01:51:21 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0CF2EA0CC4;
 Fri, 31 Jan 2020 06:51:20 +0000 (UTC)
Received: from localhost.localdomain (vpn2-54-25.bne.redhat.com [10.64.54.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3270D8D7A;
 Fri, 31 Jan 2020 06:51:07 +0000 (UTC)
Subject: Re: [RFC PATCH] hw/arm/virt: Support NMI injection
To: Marc Zyngier <maz@kernel.org>
References: <20191219040612.28431-1-gshan@redhat.com>
 <d972631d-7db7-b6d5-61b8-244ae2c85882@redhat.com>
 <f4699b81-26ac-fcd4-d3fc-f6e055beeb65@redhat.com>
 <9f82206e-0852-ae17-8c77-01d2a5cea97d@redhat.com>
 <51a83889-f2ef-5403-6661-710cfa1ffe01@redhat.com>
 <4a517e53-9a7c-903a-9fbc-e1aab1cccefb@redhat.com>
 <503f32a53fb1a81e2612bcf3eff965da@kernel.org>
From: Gavin Shan <gshan@redhat.com>
Message-ID: <d9e98e68-50e0-82fc-6736-8d39aa805e99@redhat.com>
Date: Fri, 31 Jan 2020 17:51:05 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <503f32a53fb1a81e2612bcf3eff965da@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: bVjwnyfxNzyWyobIqSSqdw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
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
Reply-To: Gavin Shan <gshan@redhat.com>
Cc: peter.maydell@linaro.org, drjones@redhat.com,
 Julien Thierry <jthierry@redhat.com>, aik@ozlabs.ru, qemu-devel@nongnu.org,
 eric.auger@redhat.com, qemu-arm@nongnu.org, shan.gavin@gmail.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/30/20 9:58 PM, Marc Zyngier wrote:
> On 2020-01-29 21:54, Gavin Shan wrote:
>> On 1/29/20 6:57 PM, Julien Thierry wrote:
>>> On 1/29/20 3:46 AM, Gavin Shan wrote:
>>>> On 1/28/20 7:29 PM, Julien Thierry wrote:
>>
>> .../...
>>
>>>>
>>>> Julien, thanks for the explanation. The question we're not sure if NMI=
 should
>>>> be injected on receiving HMP/QMP "nmi" command. It means it's not clea=
r what
>>>> behavior we should have for this command on ARM. However, I have one m=
ore
>>>> unrelated question: "pseudo" NMI on ARM64 should be PPI? I mean SPI ca=
n't
>>>> be "pseudo" NMI.
>>>>
>>>
>>> I'm not sure I understand why you say "SPI can't be "pseudo" NMI". Curr=
ently both PPI and SPI are supported in the "pseudo" NMI scheme. Do you thi=
nk that should not be the case? If so, can you elaborate?
>>>
>>> Thanks,
>>>
>>
>> Julien, NMI interrupt is connected to the system by request_nmi() where =
we have
>> a check as below. -EINVAL will be returned from request_nmi() on those
>> interrupts
>> whose descriptors aren't marked with IRQ_NOAUTOEN. SPI falls into this c=
ategory.
>=20
> The IRQ_NOAUTOEN is set on PPIs because you can't enable them all at once=
,
> for obvious reasons.
>=20
> This doesn't mean you cannot set it on other interrupt classes, including=
 SPIs.
> It is actually a fairly common thing to do when you want to decouple requ=
esting
> the interrupt from the enabling, if you do not want the interrupt to be a=
ble to
> fire right away.
>=20
>  =A0=A0=A0=A0=A0=A0=A0 M.

Marc, Ok, thanks for the details, which make things clear.

Thanks,
Gavin


