Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DAAC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 08:24:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44C8A206A4
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 08:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZgiQjDM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44C8A206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiD4t-00023a-Fg
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 04:24:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41962)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiD45-0001Vt-OF
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 04:23:29 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51448)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiD44-0006el-4j
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 04:23:29 -0400
Received: by mail-wm1-x343.google.com with SMTP id u13so14444209wml.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 01:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=CluOIz0riN27wfKLdOTSuleydyjJJicFPtYrZdQESlI=;
 b=QZgiQjDMorNqPs9e5dz4/O6N2rkjy1aCLLbly7dUz+1pc5xLBH3xoljgwynOPVtd5X
 /Q7hq1fivYt7h5oOqrLMbqaSNbYScpLT5HQvNFgdjm2T36DMvzhHkRBh0Q6KWrrDU9l6
 dIBM/LtDcUauI/oSyql3kwKaqUppDZeatEUaMnEMC+wNrFJjWMynFW6Zju2NNIjQDGsr
 jSKfOpvt0/lPwlUSXVTZCVk7obBVdrP7Dts1pxRRXWsmEMGnw/s1YTQ0x6DxIC/mVrsL
 Wo55lliCzy+l/ppda4+QZn6/3u67upt9WAoxOm6X5k8ZGx9VWluF6hdJ3aHzXxHrH8Zu
 PKsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CluOIz0riN27wfKLdOTSuleydyjJJicFPtYrZdQESlI=;
 b=BTysqAGwQKf1K9X3NNt0nD24iKayVXf71uBpQ3ug2L7lAbSiLn7UZXmdBWGYc/SyPJ
 jAU6Tn3LYEY4AenbXBtQGPVa/LyQP9ixsa6I5EuwtzZ3EAedkyZJc7CYl/hA9qH4WUqp
 daXaMWD0NL4aqharp6wLmauv7FP4Uy9400Wdp5UOmvHIhyLIc1Jf6Hsj9/q4LDLJpMeE
 M2SNQSd2dGFLxttwEHGYp7lHLiywGv0Q2eNRbw5z6wFNehwJxHkeIn1aibROk+oQqYZd
 N18OW6ssZt8vPD1LX6uNsRV01mj1KIi1dqC7X+yvl+4gm5EzEMibiP8uMUvNBHeLO3GJ
 wVuQ==
X-Gm-Message-State: AOAM5317Ik59Ev+fTkjKOKohoJYkTxuQqK6oWLRP3TAt/dQWJnqAfBhu
 xj8+L9+rCzi53SIGCQNxUeE=
X-Google-Smtp-Source: ABdhPJw1LVYjfcZy2+VXGnQ/xlOHnhIQ7ZYjFHd+AgxRJSJCHH91+Gk+1OQm4DU9vL8+9zMlkkM8aw==
X-Received: by 2002:a1c:1d44:: with SMTP id d65mr15116767wmd.179.1591604606238; 
 Mon, 08 Jun 2020 01:23:26 -0700 (PDT)
Received: from [192.168.1.43] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id t7sm22587702wrq.41.2020.06.08.01.23.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2020 01:23:25 -0700 (PDT)
Subject: Re: [PATCH] MAINTAINERS: Volunteer for maintaining the Renesas
 hardware
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20200601092057.10555-1-f4bug@amsat.org>
 <CAL1e-=ju88pJcXiK_KN1w5qbFR5MBNJqbGCo-ZtYnDmVo7O+ZQ@mail.gmail.com>
 <ee1b80b2-3d8c-4b73-1164-7beb4fa866d7@amsat.org>
 <CAL1e-=jqQ_GciNN3jjqV_u6MZMYRMWjwT_V6bUWYfaK6pGegkw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ae3396a4-2904-8055-25cb-ae2587567f98@amsat.org>
Date: Mon, 8 Jun 2020 10:23:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAL1e-=jqQ_GciNN3jjqV_u6MZMYRMWjwT_V6bUWYfaK6pGegkw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Aleksandar, Yoshinori, Aurelien.

On 6/1/20 12:34 PM, Aleksandar Markovic wrote:
> On Mon, Jun 1, 2020 at 12:23 PM Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> +Peter +Markus as neutral and experienced contributors.
>>
>> On 6/1/20 11:56 AM, Aleksandar Markovic wrote:
>>> On Mon, Jun 1, 2020 at 11:21 AM Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>>>
>>>> I don't have much clue about the Renesas hardware, but at least
>>>> I know now the source files a little bit, so I volunteer to pick
>>>> up patches and send pull-requests for them during my scarce
>>>> hobbyist time, until someone else with more knowledge steps up
>>>> to do this job instead.
>>>>
>>>> Suggested-by: Alex Bennée <alex.bennee@linaro.org>
>>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>>> ---
>>>
>>> There is alive and well Renesas target maintainer that obviously has
>>> the access to Renesas hardware, and I have no idea why you should
>>> be the maintainer for something that you say do not have much clue,
>>> while at the same time omitting the original Renesas contributor.
>>
>> The last time Magnus was active was more than 10years ago...
>>
>> commit fc8e320ef5831dc0b0d744e369537893a4379753
>> Author: Magnus Damm <damm@opensource.se>
>> Date:   Fri Nov 13 18:51:05 2009 +0900
>>
>>     fix make clean targets
>>
>>     This patch fixes clean in case of missing directories and
>>     also adds code to distclean that removes the following files:
>>      qemu-monitor.texi roms/seabios/config.mak roms/vgabios/config.mak
>>
>>     Signed-off-by: Magnus Damm <damm@opensource.se>
>>     Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
>>
>> There are SH4 patches on the list:
>> https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg08519.html
>>
>> Who is going to pick them?
>>
>>>
>>> Scandalous.
>>
>> I don't understand your attitude, I'm simply trying to help everyone by
>> giving time to the project, relieving overloaded maintainers. You only
>> keep tracking my activity and yelling about all my contributions. What
>> do you expect with all your critics? They are not very constructive and
>> don't improve much the project in general.
>>
> 
> You add the utter confusion to a clear thing.

I find it related.

I don't think what follow is the answer to "What do you expect with all
your critics?".

> 
> "Renesas" is not the same as "sh4". We had "sh4" as a target since
> forever, and now you suddenly want to change "sh4 hardware" to
> "Renesas hardware"??

QEMU makes a difference between hardware (peripherals) and architecture
(mostly ISA).

peripheral hardware is stored in hw/, while ISA in target/.

The SH4 architecture is stored in target/sh4/. The RX architecture is
stored in target/rx/.

Renesas produces chips implementing SH4 or RX.

It is common for a chip producer to reuse peripherals between
components. Renesas reused its UART & timers in its new RX-based
microcontroller series.

From a maintainer point of view, it makes sense to maintain similar
peripherals altogether.

Actually Yoshinori demostrated it, in his latest series:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg708102.html
Yoshinori Sato (10):
  hw/intc: RX62N interrupt controller (ICUa)
  hw/timer: Renesas 8bit timer module.
  hw/timer: Renesas TMU/CMT module.
  hw/char: Renesas SCI module.
  hw/rx: RX MCU and target
  Add rx-softmmu
  hw/sh4: Convert renesas_sci.
  hw/char: remove sh_serial.c
  hw/sh4: Convert to renesas_timer.c
  hw/timer: remove sh_timer.c

In this series the SH4 and RX based machines reuse the same Renesas
peripherals.

> 
> Today, "Renesas", as a company, is more oriented towards architectures
> that are similar to "sh4", but not the same - RX architectures. I find it
> surprising and interesting you don't know that, since you participated
> in introduction of "RX" target. BTW, you also dictate there Yoshimoto
> that to do and what not to do. Why?

I never intended to dictate anything, and I apologize if it sounds like
I did. I'm using my hobbyist free time to help others get their code
integrated into the mainstream QEMU.
I think we all try to do our best. Some contributors joined the project
recently and send big series. If a contributor has more experience,
he/she can suggest changes so the contribution is more likely to be
merged. The project is big and with various APIs, it is hard to see
what side-effect can have a single change that appears isolated on
a remote subsystem.

I spend a lot of my personal time trying to improve Yoshinori work
so while it would be useful for him, it would also help other users.

It took me time because adding a new target/machine involves a lot of
code. But at the end I delivered something, I did not abandon
Yoshinori and his work.

---

Yoshinori, since you have obvious knowledge of the Renesas hardware,
and you might have access to it, do you agree to be listed as its
maintainer?

Aurelien, is that still OK with you?

Thanks,

Phil.

> 
> Aleksandar
> 
>> Regards,
>>
>> Phil.
>>
>>>
>>> Regards,
>>> Aleksandar
>>>
>>>>  MAINTAINERS | 15 +++++++++++++--
>>>>  1 file changed, 13 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index 0944d9c731..cbba3ac757 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -298,9 +298,7 @@ SH4 TCG CPUs
>>>>  M: Aurelien Jarno <aurelien@aurel32.net>
>>>>  S: Odd Fixes
>>>>  F: target/sh4/
>>>> -F: hw/sh4/
>>>>  F: disas/sh4.c
>>>> -F: include/hw/sh4/
>>>>
>>>>  SPARC TCG CPUs
>>>>  M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>>> @@ -1238,6 +1236,18 @@ F: pc-bios/canyonlands.dt[sb]
>>>>  F: pc-bios/u-boot-sam460ex-20100605.bin
>>>>  F: roms/u-boot-sam460ex
>>>>
>>>> +Renesas Hardware
>>>> +----------------
>>>> +SH4 Hardware
>>>> +M: Aurelien Jarno <aurelien@aurel32.net>
>>>> +M: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>>> +S: Odd Fixes
>>>> +F: hw/sh4/
>>>> +F: hw/char/sh_serial.c
>>>> +F: hw/intc/sh_intc.c
>>>> +F: hw/timer/sh_timer.c
>>>> +F: include/hw/sh4/
>>>> +
>>>>  SH4 Machines
>>>>  ------------
>>>>  R2D
>>>> @@ -1246,6 +1256,7 @@ S: Maintained
>>>>  F: hw/sh4/r2d.c
>>>>  F: hw/intc/sh_intc.c
>>>>  F: hw/timer/sh_timer.c
>>>> +F: include/hw/sh4/sh_intc.h
>>>>
>>>>  Shix
>>>>  M: Magnus Damm <magnus.damm@gmail.com>
>>>> --
>>>> 2.21.3
>>>>
>>>>
>>>
> 

