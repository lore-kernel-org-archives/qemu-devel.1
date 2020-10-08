Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FD6C43467
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 10:52:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54947215A4
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 10:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AstTU3xZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54947215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQTX9-000054-8y
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 06:52:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40982)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kQTW9-0007gT-8r
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 06:51:25 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41628)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kQTW6-0008T8-7F
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 06:51:24 -0400
Received: by mail-wr1-x443.google.com with SMTP id w5so6057795wrp.8
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 03:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:from:to:cc:references:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Z+jjruOiyY30O8o3pHukKULPKevXRszaLR0vNuJhZUc=;
 b=AstTU3xZ27p6LGSRjabApafZ/kLV8HC4EI+0H3z+lCu2CCu37dSCpK7Vyg8wQCQejI
 5LrklUPXbjmK7oH0w7MH5BtMt1LWl9CZ18jOKVfY1PWF4qslYvQPAz1OAu+o40BJVen2
 5bANKZRft+JUOXORSC81KGFsvnNOQ90WcytXLvO/lXrqSgnzLIJaJpujLylK6SJvQlJn
 D0oMzjWT1zI3jlC9NaW6npEnVPXNKC4ge7d9GkqgbcCvFK7VbGLr17nLJLapECviROLh
 UcKjfayhrVNF5UTRmBE/MRW7VRSFuyO5/xj/ld47hGXLKbXpKm0BotuaYHhb/tMh3sl1
 CCzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:from:to:cc:references:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=Z+jjruOiyY30O8o3pHukKULPKevXRszaLR0vNuJhZUc=;
 b=YwUj3ZmjuHW380QkK/whJ0QPf96u7q584qiQ6nRFt9QWYeVgJOIwY9jLxHIWDvHwia
 HBPMbJEQ8ljZh0g3k4ufkBeQwMdpLwgE+bbtClfVAiZ8hVDHyflnEUT36EqehwJbjcWL
 y30JJThveOd2zDrVTz2hQ3K5/0dW1goFbKLJ/XQ1M+5lHXHyN7efLh0YBPoMJT5bsq+5
 /llw2CpkLC9aFTsDPmgSe6Pwc3Ed3sR/UN7q1hFj+ccXL+uPQ6RNflHb9zpfyVzz3PE2
 hsTAQniLo3U3wVyqVMrb+0zwzTsjWpaERfyZicBp6WM4SzfoQXPy1/Jhja5JGu1KqioT
 qU/g==
X-Gm-Message-State: AOAM533dOm5UHb8Xh3NOxyrKT3fm1939fpt1xjTD7MODoF+Edy8Q4eda
 44LeLoi+ZUVAXBEU5m5CBmk=
X-Google-Smtp-Source: ABdhPJxTQnlTr91MmkjhSiWlmYpCg25UZSFHXIpQPSLXmk9WpVxqp5fv/2cTufExcUAZpUucIyfSeA==
X-Received: by 2002:adf:e9c7:: with SMTP id l7mr8526351wrn.212.1602154280869; 
 Thu, 08 Oct 2020 03:51:20 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id l11sm7143336wrt.54.2020.10.08.03.51.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2020 03:51:20 -0700 (PDT)
Subject: Re: [PATCH v2 5/5] MAINTAINERS: Remove myself
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: chen huacai <zltjiangshi@gmail.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
References: <1602103041-32017-1-git-send-email-aleksandar.qemu.devel@gmail.com>
 <1602103041-32017-6-git-send-email-aleksandar.qemu.devel@gmail.com>
 <CABDp7VppBsH74X8rvFzYEdQ_nM7dxYndd1SSKqTpZGDNA2w86A@mail.gmail.com>
 <5a69fc78-2c9e-f8a4-7503-888e40e39bc7@amsat.org>
Autocrypt: addr=f4bug@amsat.org; keydata=
 mQINBDU8rLoBEADb5b5dyglKgWF9uDbIjFXU4gDtcwiga9wJ/wX6xdhBqU8tlQ4BroH7AeRl
 u4zXP0QnBDAG7EetxlQzcfYbPmxFISWjckDBFvDbFsojrZmwF2/LkFSzlvKiN5KLghzzJhLO
 HhjGlF8deEZz/d/G8qzO9mIw8GIBS8uuWh6SIcG/qq7+y+2+aifaj92EdwU79apZepT/U3vN
 YrfcAuo1Ycy7/u0hJ7rlaFUn2Fu5KIgV2O++hHYtCCQfdPBg/+ujTL+U+sCDawCyq+9M5+LJ
 ojCzP9rViLZDd/gS6jX8T48hhidtbtsFRj/e9QpdZgDZfowRMVsRx+TB9yzjFdMO0YaYybXp
 dg/wCUepX5xmDBrle6cZ8VEe00+UQCAU1TY5Hs7QFfBbjgR3k9pgJzVXNUKcJ9DYQP0OBH9P
 ZbZvM0Ut2Bk6bLBO5iCVDOco0alrPkX7iJul2QWBy3Iy9j02GnA5jZ1Xtjr9kpCqQT+sRXso
 Vpm5TPGWaWljIeLWy/qL8drX1eyJzwTB3A36Ck4r3YmjMjfmvltSZB1uAdo1elHTlFEULpU/
 HiwvvqXQ9koB15U154VCuguvx/Qnboz8GFb9Uw8VyawzVxYVNME7xw7CQF8FYxzj6eI7rBf2
 Dj/II6wxWPgDEy3oUzuNOxTB7sT3b/Ym76yOJzWX5BylXQIJ5wARAQABtDFQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoRjRCVUcpIDxmNGJ1Z0BhbXNhdC5vcmc+iQJVBBMBCAA/AhsPBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgBYhBPqr514SkXIh3P1rsuPjLCzercDeBQJd660aBQks
 klzgAAoJEOPjLCzercDe2iMP+gMG2dUf+qHz2uG8nTBGMjgK0aEJrKVPodFA+iedQ5Kp3BMo
 jrTg3/DG1HMYdcvQu/NFLYwamUfUasyor1k+3dB23hY09O4xOsYJBWdilkBGsJTKErUmkUO2
 3J/kawosvYtJJSHUpw3N6mwz/iWnjkT8BPp7fFXSujV63aZWZINueTbK7Y8skFHI0zpype9s
 loU8xc4JBrieGccy3n4E/kogGrTG5jcMTNHZ106DsQkhFnjhWETp6g9xOKrzZQbETeRBOe4P
 sRsY9YSG2Sj+ZqmZePvO8LyzGRjYU7T6Z80S1xV0lH6KTMvq7vvz5rd92f3pL4YrXq+e//HZ
 JsiLen8LH/FRhTsWRgBtNYkOsd5F9NvfJtSM0qbX32cSXMAStDVnS4U+H2vCVCWnfNug2TdY
 7v4NtdpaCi4CBBa3ZtqYVOU05IoLnlx0miKTBMqmI05kpgX98pi2QUPJBYi/+yNu3fjjcuS9
 K5WmpNFTNi6yiBbNjJA5E2qUKbIT/RwQFQvhrxBUcRCuK4x/5uOZrysjFvhtR8YGm08h+8vS
 n0JCnJD5aBhiVdkohEFAz7e5YNrAg6kOA5IVRHB44lTBOatLqz7ntwdGD0rteKuHaUuXpTYy
 CRqCVAKqFJtxhvJvaX0vLS1Z2dwtDwhjfIdgPiKEGOgCNGH7R8l+aaM4OPOd
Message-ID: <38475d43-b070-c6f5-2010-7a8e4caae97b@amsat.org>
Date: Thu, 8 Oct 2020 12:51:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <5a69fc78-2c9e-f8a4-7503-888e40e39bc7@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 qemu-level <qemu-devel@nongnu.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 hpoussin@reactos.org, Huacai Chen <chenhc@lemote.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/8/20 12:21 PM, Philippe Mathieu-Daudé wrote:
> On 10/8/20 9:21 AM, chen huacai wrote:
>> Hi, Aleksandar,
>>
>> On Thu, Oct 8, 2020 at 4:40 AM Aleksandar Markovic
>> <aleksandar.qemu.devel@gmail.com> wrote:
>>>
>>> I have been working on project other than QEMU for some time, and would
>>> like to devote myself to that project. It is imposible for me to find
>>> enough time to perform maintainer's duties with needed meticulousness
>>> and patience.
> 
> Thanks Aleksandar for your contributions and keeping MIPS in good
> shape during 2 years!
> 
>>>
>>> I wish prosperous future to QEMU and all colegues in QEMU community.
>> I'm very sorry to hear that. I hope you can be still here if possible...
>> I found that there are many reviewers, so, if it is a must that
>> Aleksandar will leave us, can these reviewers be maintainers?

Note the problem with QEMU MIPS is not there is few maintainers,
is really there are no reviewers... See, there are about 25 patches
unreviewed on the list since various weeks. I don't have problem
merging/testing them once reviewed and doing maintenance, but I
can not review them all (in particular the one I send...).

Maintaining is not about merging your own area patches, it is
also about trying to understand what the other are doing,
eventually having to verify the specs, understand the use case,
and so on. Like I intend to do with your Loongson-3 series.

Note that I do that in my free time, and I certainly do not want
to be the single maintainer, I don't have the bandwidth.

> 
> Thanks for volunteering! Aleksandar Rikalo hasn't sent anything
> to the list since 4 months. Is Jiaxun Yang also volunteering?
> 
> Regards,
> 
> Phil.
> 
>>
>> Huacai
>>>
>>> Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
>>> ---
>>>  MAINTAINERS | 17 +++++------------
>>>  1 file changed, 5 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index e9d85cc..426f52c 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -221,11 +221,10 @@ F: hw/microblaze/
>>>  F: disas/microblaze.c
>>>
>>>  MIPS TCG CPUs
>>> -M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
>>>  R: Aurelien Jarno <aurelien@aurel32.net>
>>>  R: Jiaxun Yang <jiaxun.yang@flygoat.com>
>>>  R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
>>> -S: Maintained
>>> +S: Orphaned
>>>  F: target/mips/
>>>  F: default-configs/*mips*
>>>  F: disas/*mips*
>>> @@ -387,7 +386,6 @@ F: target/arm/kvm.c
>>>
>>>  MIPS KVM CPUs
>>>  M: Huacai Chen <chenhc@lemote.com>
>>> -M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
>>>  S: Odd Fixes
>>>  F: target/mips/kvm.c
>>>
>>> @@ -1124,10 +1122,9 @@ F: hw/display/jazz_led.c
>>>  F: hw/dma/rc4030.c
>>>
>>>  Malta
>>> -M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
>>>  M: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>>  R: Aurelien Jarno <aurelien@aurel32.net>
>>> -S: Maintained
>>> +S: Odd Fixes
>>>  F: hw/isa/piix4.c
>>>  F: hw/acpi/piix4.c
>>>  F: hw/mips/malta.c
>>> @@ -1137,14 +1134,12 @@ F: tests/acceptance/linux_ssh_mips_malta.py
>>>  F: tests/acceptance/machine_mips_malta.py
>>>
>>>  Mipssim
>>> -M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
>>>  R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
>>> -S: Odd Fixes
>>> +S: Orphaned
>>>  F: hw/mips/mipssim.c
>>>  F: hw/net/mipsnet.c
>>>
>>>  R4000
>>> -M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
>>>  R: Aurelien Jarno <aurelien@aurel32.net>
>>>  R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
>>>  S: Obsolete
>>> @@ -1153,7 +1148,6 @@ F: hw/mips/r4k.c
>>>  Fuloong 2E
>>>  M: Huacai Chen <chenhc@lemote.com>
>>>  M: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>> -M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
>>>  R: Jiaxun Yang <jiaxun.yang@flygoat.com>
>>>  S: Odd Fixes
>>>  F: hw/mips/fuloong2e.c
>>> @@ -2821,12 +2815,11 @@ F: tcg/i386/
>>>  F: disas/i386.c
>>>
>>>  MIPS TCG target
>>> -M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
>>>  R: Aurelien Jarno <aurelien@aurel32.net>
>>>  R: Huacai Chen <chenhc@lemote.com>
>>>  R: Jiaxun Yang <jiaxun.yang@flygoat.com>
>>>  R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
>>> -S: Maintained
>>> +S: Orphaned
>>>  F: tcg/mips/
>>>
>>>  PPC TCG target
>>> @@ -3167,7 +3160,7 @@ S: Odd Fixes
>>>  F: scripts/git-submodule.sh
>>>
>>>  UI translations
>>> -M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
>>> +S: Orphaned
>>>  F: po/*.po
>>>
>>>  Sphinx documentation configuration and build machinery
>>> --
>>> 2.7.4
>>>
>>>
>>
>>
> 

