Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974DCC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 14:56:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BC4420748
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 14:56:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BC4420748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZFnL-0004Px-Kd
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 09:56:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55423)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iZFmh-0003vQ-Qa
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 09:56:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iZFmg-0006lP-NI
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 09:56:15 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:33749)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iZFmg-0006j3-Dy; Mon, 25 Nov 2019 09:56:14 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1Mz9lL-1hd2Wq2TMR-00wAae; Mon, 25 Nov 2019 15:56:07 +0100
Subject: Re: [PATCH] mos6522: update counters when timer interrupts are off
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191125141414.5015-1-laurent@vivier.eu>
 <a274a621-b9ed-1090-23af-cf4d46a266b3@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <3c49973f-ef70-27ec-342a-de722a05e257@vivier.eu>
Date: Mon, 25 Nov 2019 15:56:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <a274a621-b9ed-1090-23af-cf4d46a266b3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:gbX+fcR0tqzrtNhAHjXtJJdHy08JGXvTA+yOpUY5gnnBxW0esgw
 6Z2znGoXLpE40vA2bl5fO11VuRq7s5MSk/gQdSPxaDP/0uY6Qk/yd1wojhnHmRpay7DoZT6
 z2i9GnuAdTgc+GMPOA4NtrZY02Xwi82s6nNKKczXrn2jPCCaM6FV4A4m5jc+4ykhLPj6lDx
 FHVU50TL2evs72OIqqTdA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1xZ3bUEKjbk=:u+uq81tlN3o0atrcCk3Mvp
 jRATfrmBxYeNcaNDTCgu/oluFsxQDQNoXBRQGrhOcVwTv6lDaRbCEvNPRRijg/opo2KlhTbSk
 JqWTeXMaW4QdnsJO2YYOFLxJaX0nGY6KDSbna3EOb402/wE2fKfN9gss7//KTvxq4hX5oFxUs
 q34sXEmo98QSEMJBG+IPvTjxaA/TKtBRvDuNVXIzaIKusbGb+eMR/jfuG/26ZQaXuz8RyYg3a
 c2JAaRvjocjejw/j/Zdr40Zmp15FafBcsQEgTqBfsOu+IsSvXJBgFkG04g6AT8sbywvS1t/gE
 2J5Nig5vUnN8SxaAqj0Vauj06F/ywHAIXBMAiCJcl3MFXUlzA3gKltfH4Jx5lCM6frphxLM1x
 qYU+u35QWDdvq7AD13fql8Yh8LsLmqJ6urM3eO93fmITHBbU04emX93doJOAftcSo8nKAS1BP
 ucgWRV7z0IVA6nRuWuRS4qtuW6OINBhMksTlS6Xc5Sm1Kw82gOXebZ9qRmKg+EcRwkkSKo1V4
 VXK1tp+tYH5Zjmi0iyLwdGBJkD9I+2lMO95VSSS/zAn8kMyDwKgFn7u3IyBZbOCvSjI6qBthf
 qG7wWcNc8xnQx3e5Kl2786qldE/zdGomJ/Vd1pe+8BO0PGJRgFoq6tg9gAgAfS4YaLASBu8V7
 JLgba4r2TUsE4zhR/2ZqP8Tsc1CEgqpBQYfgkDa+xJfOBz8WQGTzR+klJhyDXRHb44HZZFKt1
 MNfXXZshaieQf8Gkumpj2L1JxD9ORRFjp5462I6lFqp135ir11FxKdAUU8uWu9Zgixp9tVKMm
 +HYKlww7SOdSqMZzVlvxQveklefPwEbtw7CrAsXa15DQHnj3rEP3DvyW2nG0PtxpYrqZNg4Of
 G2vkfxky/23YdRr3wkQFEw6DWfdK9XMZKzgqFEKx8=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.133
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
Cc: qemu-ppc@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Andrew Randrianasulu <randrianasulu@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 25/11/2019 à 15:37, Philippe Mathieu-Daudé a écrit :
> On 11/25/19 3:14 PM, Laurent Vivier wrote:
>> Even if the interrupts are off, counters must be updated because
>> they are running anyway and kernel can try to read them
>> (it's the case with g3beige kernel).
>>
>> Reported-by: Andrew Randrianasulu <randrianasulu@gmail.com>
>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>> ---
>>   hw/misc/mos6522.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/misc/mos6522.c b/hw/misc/mos6522.c
>> index aa3bfe1afd..cecf0be59e 100644
>> --- a/hw/misc/mos6522.c
>> +++ b/hw/misc/mos6522.c
>> @@ -113,6 +113,10 @@ static int64_t get_next_irq_time(MOS6522State *s,
>> MOS6522Timer *ti,
>>       int64_t d, next_time;
>>       unsigned int counter;
>>   
> 
> Can you add a comment here such "Clock disabled. This is the longest
> time before expiration" or better?
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
>> +    if (ti->frequency == 0) {
>> +        return INT64_MAX;
>> +    }
>> +


In fact this is here for a deeper problem:

frequency is not correctly initialized on reset.

ti->frequency are initialized by cuda/pmu/mac_via after the parent reset
(mos6522) but the parent reset calls set_counter() that uses
ti->frequency to set the counters. The mos6522 reset initialize the
ti->frequency from s->frequency but s->frequency is never initialized.

It was hidden before because the timers were not updated if the
interrupts are disabled, and now they are always updated.

I didn't want to add a such complicated comment in the code and I will
try to fix the problem later.

Thanks,
Laurent

