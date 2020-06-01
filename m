Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29828C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 10:26:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7300206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 10:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="duEmt+yF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7300206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfheL-0006F0-VT
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 06:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36858)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jfhbZ-00038q-8D
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 06:23:41 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39239)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jfhbY-0000KG-5A
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 06:23:40 -0400
Received: by mail-wr1-x444.google.com with SMTP id t18so10936732wru.6
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 03:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=BaaEAR4+T1nNevZCI9Kr7D12LbrysM/iuYkv4CH3Wz8=;
 b=duEmt+yF+7s8l1wmEorJStS3VWQc8pRG4vY5hG1n1SSrzCVsOEmXutLrVhZFrdtEqc
 ZXF1BJmYP5Zx3m1CusS9ejpCNZrj/GBe+eyuAmfdUfH2QIQC8RuCYvT1522Xpgnj1zC2
 bQAB4f9AIlEgwFu+1DtRBcxK6a5vcIf8nqAiGecAgFrqwZO7LejBrEY5ZPl2VCpp8XEq
 NLnCe+KgzmDZ0w8QO+o9wOPbzNuQVRfVd1B4x1ZYWqy39rliaQXU7WhuxLjtDNMWSWEB
 GIon7odpbKDs1gP+aetid9EQgEY3iWl5u3/ikthsH36Mhat1tej/bDf7Ru88dg26HeEL
 3d5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BaaEAR4+T1nNevZCI9Kr7D12LbrysM/iuYkv4CH3Wz8=;
 b=UjyptHJEr9/tvI+mlpXC/oEDr7T/W2HE2M54tIL2dzi667a2Hso6Uecu/TDm25++Ug
 jqBg2f+IjPh4YrtjZgR924rGltSieuK8wiw+ikTE4kxV2DNFu+mTlU2Sf018ztuMiSKU
 Q4qkRRbiD3dshFWA0ln4vWXoQmo2p7d8rngw+qXq1Jsbb7QkHwhiPuEnEy1k4wjLY9ei
 sq4Y3TDjMEmongxj0CRBwVmAcG8F4bn0szuofBMQBKk7SoObwDlDgppYu85Q3Dog7EPx
 NWnXsbQOCZsvYJsoXQOOmsq4Ig//S9pCIApTTNwHZxhjgSdK80unQcU5CMJYhKLG8hc8
 qIIw==
X-Gm-Message-State: AOAM533Ux5JDK+gtpCRhr1C81OAV3+ojW5V9VcrLgVXC7ALi45hpmq4F
 yk7Ik/NFK+FKuObvsfmhOyg=
X-Google-Smtp-Source: ABdhPJywIpafIc4PSdZi7z2zt2f5JQinHiB4PJhMO4ndPVFA2ocr8l8t5paX6XqK5Pvkoodjeukq5w==
X-Received: by 2002:adf:eec2:: with SMTP id a2mr20402066wrp.136.1591007018628; 
 Mon, 01 Jun 2020 03:23:38 -0700 (PDT)
Received: from [192.168.1.34] (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id a126sm8543147wme.28.2020.06.01.03.23.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2020 03:23:38 -0700 (PDT)
Subject: Re: [PATCH] MAINTAINERS: Volunteer for maintaining the Renesas
 hardware
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20200601092057.10555-1-f4bug@amsat.org>
 <CAL1e-=ju88pJcXiK_KN1w5qbFR5MBNJqbGCo-ZtYnDmVo7O+ZQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ee1b80b2-3d8c-4b73-1164-7beb4fa866d7@amsat.org>
Date: Mon, 1 Jun 2020 12:23:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAL1e-=ju88pJcXiK_KN1w5qbFR5MBNJqbGCo-ZtYnDmVo7O+ZQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+Peter +Markus as neutral and experienced contributors.

On 6/1/20 11:56 AM, Aleksandar Markovic wrote:
> On Mon, Jun 1, 2020 at 11:21 AM Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> I don't have much clue about the Renesas hardware, but at least
>> I know now the source files a little bit, so I volunteer to pick
>> up patches and send pull-requests for them during my scarce
>> hobbyist time, until someone else with more knowledge steps up
>> to do this job instead.
>>
>> Suggested-by: Alex Bennée <alex.bennee@linaro.org>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
> 
> There is alive and well Renesas target maintainer that obviously has
> the access to Renesas hardware, and I have no idea why you should
> be the maintainer for something that you say do not have much clue,
> while at the same time omitting the original Renesas contributor.

The last time Magnus was active was more than 10years ago...

commit fc8e320ef5831dc0b0d744e369537893a4379753
Author: Magnus Damm <damm@opensource.se>
Date:   Fri Nov 13 18:51:05 2009 +0900

    fix make clean targets

    This patch fixes clean in case of missing directories and
    also adds code to distclean that removes the following files:
     qemu-monitor.texi roms/seabios/config.mak roms/vgabios/config.mak

    Signed-off-by: Magnus Damm <damm@opensource.se>
    Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>

There are SH4 patches on the list:
https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg08519.html

Who is going to pick them?

> 
> Scandalous.

I don't understand your attitude, I'm simply trying to help everyone by
giving time to the project, relieving overloaded maintainers. You only
keep tracking my activity and yelling about all my contributions. What
do you expect with all your critics? They are not very constructive and
don't improve much the project in general.

Regards,

Phil.

> 
> Regards,
> Aleksandar
> 
>>  MAINTAINERS | 15 +++++++++++++--
>>  1 file changed, 13 insertions(+), 2 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 0944d9c731..cbba3ac757 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -298,9 +298,7 @@ SH4 TCG CPUs
>>  M: Aurelien Jarno <aurelien@aurel32.net>
>>  S: Odd Fixes
>>  F: target/sh4/
>> -F: hw/sh4/
>>  F: disas/sh4.c
>> -F: include/hw/sh4/
>>
>>  SPARC TCG CPUs
>>  M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> @@ -1238,6 +1236,18 @@ F: pc-bios/canyonlands.dt[sb]
>>  F: pc-bios/u-boot-sam460ex-20100605.bin
>>  F: roms/u-boot-sam460ex
>>
>> +Renesas Hardware
>> +----------------
>> +SH4 Hardware
>> +M: Aurelien Jarno <aurelien@aurel32.net>
>> +M: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> +S: Odd Fixes
>> +F: hw/sh4/
>> +F: hw/char/sh_serial.c
>> +F: hw/intc/sh_intc.c
>> +F: hw/timer/sh_timer.c
>> +F: include/hw/sh4/
>> +
>>  SH4 Machines
>>  ------------
>>  R2D
>> @@ -1246,6 +1256,7 @@ S: Maintained
>>  F: hw/sh4/r2d.c
>>  F: hw/intc/sh_intc.c
>>  F: hw/timer/sh_timer.c
>> +F: include/hw/sh4/sh_intc.h
>>
>>  Shix
>>  M: Magnus Damm <magnus.damm@gmail.com>
>> --
>> 2.21.3
>>
>>
> 

