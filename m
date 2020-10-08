Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5F1C43467
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 10:23:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 073A42076B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 10:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evcJSi6M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 073A42076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQT5F-0003Sa-VY
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 06:23:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34304)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kQT30-0001Ua-Sn
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 06:21:18 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36139)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kQT2z-0003vb-0h
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 06:21:18 -0400
Received: by mail-wr1-x441.google.com with SMTP id z1so5960026wrt.3
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 03:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=kVNcupSJPs5zDcgWvxV3AS6oca/hcA8uS+fS/IY/ww0=;
 b=evcJSi6MRApUbFGv8UCjWb9g199ayHpVC58x1H2JrNCwQ4CYd3XmYoxx1vJeKvI5TK
 ASjirO3nkpIrljs5tP43y7RLoPCgtjuaLNK9dyt34FwQHT2H/BZDUw9Ua9szRTDMSgFw
 o4oAYYDcS+TykQ9L+gbSrFwBvHl7fgjTfBLc1PASPQS+SWjIiut07HzK8/feu+HVVwhw
 u2ZSCcSAw0ZCFJH4C5f+NPBxbMkMIGPRSo7ZO8In+zZKoJH/FCf3P1IBXrTRG3tcAzwm
 IQBb6l28Yz+bT57trXNLcdZynk+ev+Vw/Nxzia1CF/xkZR6eby9nLSyCijSZy765g613
 0Jvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kVNcupSJPs5zDcgWvxV3AS6oca/hcA8uS+fS/IY/ww0=;
 b=YZpAupiwArQbG9CkKBRgiDBWpHPjsBPL3JBlTBmd+ce1vb3byaKqgm6bZPEEvkZ4yF
 /9/ce0axIU2qur5DuUNpX6Dw7geJ1+TcwPhTeBbBkDMJqdo+u0xiWEvIOghKEp9gZZBA
 HjwYfIcpayJX6Pvs2WYKAKheReHUep36nknwCvgpZ1zx1GwE9RLhQ02KFT8oLzv1BCmK
 jDqabxLWXEsFkFGYTLeh1DwIl465abP7Sgt/nZF06naG2R3+0eLg38d9BVFYYn1l9K+N
 cMQ8QQMLvAUQ8cze5f0yDI6Jk3TQzshmQlb78FD7jE3Wjlfnc3y/eyiYJ39vzsRIk8Vq
 I3pg==
X-Gm-Message-State: AOAM532OkUNZHGp5r99mPfPcOFV/8qER+WFcu9l5ZL9Z0wKB4Ompplg0
 /QHQYsPbpmMikWy1+uaoHVg=
X-Google-Smtp-Source: ABdhPJwwOqPgD+/U1yUTP1z8bVuk1QoawjUGTLtg7Q2jA2o2NkXcKg1lku8MM3u+E2DvE8kjc3sFdg==
X-Received: by 2002:adf:d4c7:: with SMTP id w7mr8632945wrk.263.1602152474763; 
 Thu, 08 Oct 2020 03:21:14 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id z13sm6397342wro.97.2020.10.08.03.21.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2020 03:21:14 -0700 (PDT)
Subject: Re: [PATCH v2 5/5] MAINTAINERS: Remove myself
To: chen huacai <zltjiangshi@gmail.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
References: <1602103041-32017-1-git-send-email-aleksandar.qemu.devel@gmail.com>
 <1602103041-32017-6-git-send-email-aleksandar.qemu.devel@gmail.com>
 <CABDp7VppBsH74X8rvFzYEdQ_nM7dxYndd1SSKqTpZGDNA2w86A@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5a69fc78-2c9e-f8a4-7503-888e40e39bc7@amsat.org>
Date: Thu, 8 Oct 2020 12:21:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CABDp7VppBsH74X8rvFzYEdQ_nM7dxYndd1SSKqTpZGDNA2w86A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
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

On 10/8/20 9:21 AM, chen huacai wrote:
> Hi, Aleksandar,
> 
> On Thu, Oct 8, 2020 at 4:40 AM Aleksandar Markovic
> <aleksandar.qemu.devel@gmail.com> wrote:
>>
>> I have been working on project other than QEMU for some time, and would
>> like to devote myself to that project. It is imposible for me to find
>> enough time to perform maintainer's duties with needed meticulousness
>> and patience.

Thanks Aleksandar for your contributions and keeping MIPS in good
shape during 2 years!

>>
>> I wish prosperous future to QEMU and all colegues in QEMU community.
> I'm very sorry to hear that. I hope you can be still here if possible...
> I found that there are many reviewers, so, if it is a must that
> Aleksandar will leave us, can these reviewers be maintainers?

Thanks for volunteering! Aleksandar Rikalo hasn't sent anything
to the list since 4 months. Is Jiaxun Yang also volunteering?

Regards,

Phil.

> 
> Huacai
>>
>> Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
>> ---
>>  MAINTAINERS | 17 +++++------------
>>  1 file changed, 5 insertions(+), 12 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index e9d85cc..426f52c 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -221,11 +221,10 @@ F: hw/microblaze/
>>  F: disas/microblaze.c
>>
>>  MIPS TCG CPUs
>> -M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
>>  R: Aurelien Jarno <aurelien@aurel32.net>
>>  R: Jiaxun Yang <jiaxun.yang@flygoat.com>
>>  R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
>> -S: Maintained
>> +S: Orphaned
>>  F: target/mips/
>>  F: default-configs/*mips*
>>  F: disas/*mips*
>> @@ -387,7 +386,6 @@ F: target/arm/kvm.c
>>
>>  MIPS KVM CPUs
>>  M: Huacai Chen <chenhc@lemote.com>
>> -M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
>>  S: Odd Fixes
>>  F: target/mips/kvm.c
>>
>> @@ -1124,10 +1122,9 @@ F: hw/display/jazz_led.c
>>  F: hw/dma/rc4030.c
>>
>>  Malta
>> -M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
>>  M: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>  R: Aurelien Jarno <aurelien@aurel32.net>
>> -S: Maintained
>> +S: Odd Fixes
>>  F: hw/isa/piix4.c
>>  F: hw/acpi/piix4.c
>>  F: hw/mips/malta.c
>> @@ -1137,14 +1134,12 @@ F: tests/acceptance/linux_ssh_mips_malta.py
>>  F: tests/acceptance/machine_mips_malta.py
>>
>>  Mipssim
>> -M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
>>  R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
>> -S: Odd Fixes
>> +S: Orphaned
>>  F: hw/mips/mipssim.c
>>  F: hw/net/mipsnet.c
>>
>>  R4000
>> -M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
>>  R: Aurelien Jarno <aurelien@aurel32.net>
>>  R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
>>  S: Obsolete
>> @@ -1153,7 +1148,6 @@ F: hw/mips/r4k.c
>>  Fuloong 2E
>>  M: Huacai Chen <chenhc@lemote.com>
>>  M: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> -M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
>>  R: Jiaxun Yang <jiaxun.yang@flygoat.com>
>>  S: Odd Fixes
>>  F: hw/mips/fuloong2e.c
>> @@ -2821,12 +2815,11 @@ F: tcg/i386/
>>  F: disas/i386.c
>>
>>  MIPS TCG target
>> -M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
>>  R: Aurelien Jarno <aurelien@aurel32.net>
>>  R: Huacai Chen <chenhc@lemote.com>
>>  R: Jiaxun Yang <jiaxun.yang@flygoat.com>
>>  R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
>> -S: Maintained
>> +S: Orphaned
>>  F: tcg/mips/
>>
>>  PPC TCG target
>> @@ -3167,7 +3160,7 @@ S: Odd Fixes
>>  F: scripts/git-submodule.sh
>>
>>  UI translations
>> -M: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
>> +S: Orphaned
>>  F: po/*.po
>>
>>  Sphinx documentation configuration and build machinery
>> --
>> 2.7.4
>>
>>
> 
> 

