Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CEAAC432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 23:02:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8F882070E
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 23:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=reactos.org header.i=@reactos.org header.b="WWrC0etN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8F882070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=reactos.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYHwJ-0005oB-Ud
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 18:02:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46998)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <hpoussin@reactos.org>) id 1iYHva-0005D1-L2
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 18:01:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hpoussin@reactos.org>) id 1iYHvZ-0004Y0-As
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 18:01:26 -0500
Received: from iserv.reactos.org ([2a01:4f8:1c17:5ae1::1]:43040)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <hpoussin@reactos.org>)
 id 1iYHvY-0004Vg-Pz
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 18:01:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=reactos.org
 ; s=25047;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:
 Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ZTn5TzjJQS+I85YzY2Dm1lAkwuEybLaAcphIPvnScqE=; b=WWrC0etNJo66iysSDDZ6TBjfEA
 SYzAelDxkmcUMbPdKW1CuPANtvbagOe3Eg6G5Bpq4xRVMBB4KB7Bw5SwEOf3IizLTSBtFnq3S/wxR
 qTg4+hYGN2/95Jk3jttoP65mU9ACDvogUj0QyrBAkQyTaOMWJYIHIEFPVj0Pdge6Arls=;
Received: from [2a01:e35:2e3e:3c40:810c:5dc0:a5b7:d589]
 by iserv.reactos.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <hpoussin@reactos.org>)
 id 1iYHvJ-00060m-FG; Fri, 22 Nov 2019 23:01:10 +0000
Subject: Re: [PATCH v2 4/5] MAINTAINERS: Adjust maintainership for R4000
 systems
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <1573652826-23987-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1573652826-23987-5-git-send-email-aleksandar.markovic@rt-rk.com>
 <78b81f32-0eb0-6d51-6ecc-9c8045be3896@redhat.com>
 <CAL1e-=iWZszvg7pY=iL6j0bUch+gF5nhuk+XbGFkipkhzCHHug@mail.gmail.com>
 <a9ace386-33b5-b712-8ebe-25f1b8251771@redhat.com>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <17cb81e0-63cf-12e7-c37d-4e2e2f1860d2@reactos.org>
Date: Sat, 23 Nov 2019 00:01:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <a9ace386-33b5-b712-8ebe-25f1b8251771@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:4f8:1c17:5ae1::1
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 22/11/2019 à 16:29, Philippe Mathieu-Daudé a écrit :
> On 11/22/19 3:14 PM, Aleksandar Markovic wrote:
>> On Fri, Nov 22, 2019 at 2:58 PM Philippe Mathieu-Daudé
>> <philmd@redhat.com> wrote:
>>>
>>> Hi Aleksandar,
>>>
>>> On 11/13/19 2:47 PM, Aleksandar Markovic wrote:
>>>> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>>>>
>>>> Change the maintainership for R4000 systems to improve its quality.
>>>>
>>>> Acked-by: Aurelien Jarno <aurelien@aurel32.net>
>>>> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
>>>> ---
>>>>    MAINTAINERS | 5 +++--
>>>>    1 file changed, 3 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index 6afec32..ba9ca98 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -971,8 +971,9 @@ F: hw/mips/mips_mipssim.c
>>>>    F: hw/net/mipsnet.c
>>>>
>>>>    R4000
>>>> -M: Aurelien Jarno <aurelien@aurel32.net>
>>>> -R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
>>>> +M: Hervé Poussineau <hpoussin@reactos.org>
>>>
>>> Commit 0c10962a033 from Hervé was part of a bigger refactor series, so I
>>> don't think he is interested.
>>>
>>>> +R: Aurelien Jarno <aurelien@aurel32.net>
>>>> +R: Philippe Mathieu-Daudé <philmd@redhat.com>
>>>>    S: Maintained
>>>>    F: hw/mips/mips_r4k.c
>>>
>>> Now back to this board, I am having hard time to understand what it
>>> models. IIUC it predates the Malta board, and was trying to model a
>>> board able to run the first MIPS cpu when the port was added in 2005
>>> (see commit 6af0bf9c7c3a).
>>> The Malta board was added 1 year later (commit 5856de800df) and models a
>>> real hardware.
>>>
>>> As Aurelien acked to step down maintaining it, it seems the perfect
>>> timing to start its deprecation process. I'll prepare a patch for 5.0
>>> (unless someone is really using it and willing to maintain it).
>>>
>>
>> Philippe, hi.
>>
>> Herve told me a while ago that he does care about R4000 being
>> supported, as it is closely related to Jazz machines, so please
>> don't start any deprecation process.
> 
> I think what Hervé meant to say is he cares about the R4000 CPU (implementing the MIPSIII architecture). The Magnum and Pica boards indeed use a R4000 CPU. I also personally care about this CPU, and 
> don't want it to disappear.
> 
> Here we are talking about the some Frankenstein board. QEMU aims to model real hardware, with the exception of the 'Virt' boards that have specifications. Here I can't find any. I am not against Hervé 
> maintaining this file if he has some interest in it, but I think there are confusion and we are talking about 2 different topics.

Philippe is right.
I care about Magnum/PICA boards (which have a R4000 cpu).
I don't care about this the mips_r4k.c machine, and I think that deprecating mips_r4k.c machine is the right thing to do.

> 
>> Herve is the most familiar of all of us with R4000, and, for that
>> reason, my suggestion is to keep the patch as it is. Let me know
>> if you have any objections.
>>
>> One alternative approach would be to merge "R4000" and
>> "Jazz" sections. But, let's leave it for future as an option,
>> if nobody objects.

Jazz and mips_r4k machines have mostly nothing in common, except using a R4000 CPU and an ISA bus.

Regards,

Hervé

