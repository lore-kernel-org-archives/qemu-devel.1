Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A798C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 09:51:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0B212073B
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 09:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fehhkiyJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0B212073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdWEt-0006F6-W9
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 05:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57342)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdWEH-0005ad-Rv; Tue, 26 May 2020 05:50:37 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:38974)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdWEG-0006uA-VV; Tue, 26 May 2020 05:50:37 -0400
Received: by mail-ej1-x641.google.com with SMTP id nr22so6758327ejb.6;
 Tue, 26 May 2020 02:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=osMxfOAZGK1ldmxSaFEoNdUdGLmkh5WsFbCrvMUrxC4=;
 b=fehhkiyJArNikKnmQ5xTRpPC9x4XgbYzN6jOkJ4GUpDBbdhjGUfF3P8vKfb5/7zruk
 qtkIlFRNs6d8AMWgROD8cxTIy2Neilsw7jRkhzp3wYgFswVe8XVUDD/CQk3M00lauwVc
 iQqrIz7eQJrlGSPXc4pL6FKJRu+ANrbVsw4Ap8fYvqcfWzomH2KezA8EwC5qIDpELYK1
 rmzgFzk97U/Tdsr4Ngz9SoDg804d1LRsEbNNI8JP5rPsy+7jrnn0ZHIA/t8bwNUG7DYD
 df5n8t5lXzTKrGtt8MPL5RV0xSMRAUhLdN8M3IpKEuYVPIkjcV0z7e5Ku+QNkWFjXhKN
 FtEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=osMxfOAZGK1ldmxSaFEoNdUdGLmkh5WsFbCrvMUrxC4=;
 b=QJMNtM78R+yPj97UV7v91xJAXjF6JECiF1nefNyd9eGqm+za2s5DOEJVM91gpJKPJr
 rDKJV75nQRso3FpKTMJWd1TDwP/TF1/Qd0ojdZCw3zUcJCijLM9TBLXwAfIXhqFYLRz4
 6FrM9jHceWqdKPfPlj9D2caN6VhTFIHdfVk58vkLRjCdSHF5wXfe1VxbwRWtv1OOgV4H
 9utvTwZvgF3oQ8N6saKz/7DC58tK5aMb63lqxDf/1kDTwzLU3mwBPLitZq8wFW++XynO
 lrCL33JtRHhVbL9uaR+5S/AKHAdw6eycOiL35/P2TSE+4udzq+qLUm8v2T1awmRUQGq3
 wvZQ==
X-Gm-Message-State: AOAM533zj0y4aInY8wo7mTjfJBEd7taStEBsjV+vG2D92g1gLcf2ZcwA
 ji7HmGdL3JSv+eP7MMmXe7c=
X-Google-Smtp-Source: ABdhPJzRfTvPBDJnvghPTEoH41/+dd2eXxAdjfTcG4SI6WZKZK6Tc/t5qCxulI0F1ZkE1JJ88oYLGQ==
X-Received: by 2002:a17:906:a44f:: with SMTP id
 cb15mr344938ejb.219.1590486635086; 
 Tue, 26 May 2020 02:50:35 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id m27sm17741869eji.45.2020.05.26.02.50.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2020 02:50:34 -0700 (PDT)
Subject: Re: [PATCH 0/7] hw/sparc/leon3: Few fixes and disable HelenOS test
To: Fred Konrad <konrad@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-devel@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20200331105048.27989-1-f4bug@amsat.org>
 <81737d76-06c6-4c83-1287-b0d14db4ce2f@amsat.org>
 <989bf2f5-0e23-f9c3-e9e1-0bd8c03f3231@adacore.com>
 <1b7a4c63-5a31-6efe-d807-7092e3ee0ffb@amsat.org>
 <230dbf6b-120a-f1f0-d48d-9fa4a04e05cd@adacore.com>
 <23588fda-b95b-45a9-b788-e846d26a3bc3@amsat.org>
 <7f673b61-7565-f79a-0ec6-043c44d1df77@amsat.org>
 <08b73f34-4cab-1133-e5e5-5b1e9fc7b5d0@adacore.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <344c9260-e448-feea-3b37-7860dd09cd8a@amsat.org>
Date: Tue, 26 May 2020 11:50:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <08b73f34-4cab-1133-e5e5-5b1e9fc7b5d0@adacore.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x641.google.com
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
 QEMU Trivial <qemu-trivial@nongnu.org>, Fabien Chouteau <chouteau@adacore.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Jiri Gaisler <jiri@gaisler.se>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/25/20 1:02 PM, Fred Konrad wrote:
> Sorry Philippe I missed that.
> 
> Would be happy to do a PR if needed but:
>   * I never did that.
>   * Looking at https://wiki.qemu.org/Contribute/SubmitAPullRequest, I
> don't have
>     the signed GPG key either.

Thanks Fred for following this series.

I am not insisting for you to do the pull request, I was waiting for
Artyom (sparc32) and Mark (sparc64) who usually handle the pull requests.

Artyom seems busy lately.

Mark, do you plan to send a hw/sparc* pull request soon? Do you prefer I
ask to trivial@ for this series?

FYI there is another sparc32 candidate patch:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg701850.html

Regards,

Phil.

> 
> Cheers,
> Fred
> 
> Le 5/23/20 à 7:26 PM, Philippe Mathieu-Daudé a écrit :
>> ping?
>>
>> On 5/11/20 9:03 AM, Philippe Mathieu-Daudé wrote:
>>> On 4/14/20 12:00 PM, KONRAD Frederic wrote:
>>>> Le 4/13/20 à 11:07 PM, Philippe Mathieu-Daudé a écrit :
>>>>> [Cc'ing Peter]
>>>>>
>>>>> On 4/13/20 12:12 PM, KONRAD Frederic wrote:
>>>>>> Le 4/11/20 à 7:30 PM, Philippe Mathieu-Daudé a écrit :
>>>>>>> On 3/31/20 12:50 PM, Philippe Mathieu-Daudé wrote:
>>>>>>>> Philippe Mathieu-Daudé (7):
>>>>>>>>      hw/misc/grlib_ahb_apb_pnp: Avoid crash when writing to AHB PnP
>>>>>>>>        registers
>>>>>>>>      hw/misc/grlib_ahb_apb_pnp: Fix AHB PnP 8-bit accesses
>>>>>>>
>>>>>>> Ping ^^^ for 5.0?
>>>>>>
>>>>>> Hi Philippe,
>>>>>>
>>>>>> You already have my rb tag for those one, and IMHO they should be
>>>>>> good
>>>>>> candidate
>>>>>> for 5.0 (if it's not too late).
>>>>>
>>>>> Yes, thanks for the reviews. I see Mark Cave-Ayland merged this file
>>>>> first, but you are listed as maintainer :) I was hoping you could
>>>>> send a
>>>>> pull request.
>>>>
>>>> Yes that's usually Mark who take the patches, sorry I didn't get it.
>>>
>>> No worries. As there are other sparc64 patches on the list, maybe Mark
>>> will prepare a pull request now.
>>>
>>>>
>>>>>
>>>>> $ scripts/get_maintainer.pl -f hw/misc/grlib_ahb_apb_pnp.c
>>>>> Fabien Chouteau <chouteau@adacore.com> (maintainer:Leon3)
>>>>> KONRAD Frederic <frederic.konrad@adacore.com> (maintainer:Leon3)
>>>>> qemu-devel@nongnu.org (open list:All patches CC here)
>>>>>
>>>>
>>>>> This is a bug but not 'security critical', so it might wait 5.1 and go
>>>>> via qemu-trivial tree.
>>>>
>>>> Well let's do that then if you're ok.
>>>
>>> OK, then ping? :)
>>>
>>>>
>>>> Best Regards,
>>>> Fred
>>>>
>>>>>
>>>>> Regards,
>>>>>
>>>>> Phil.
>>>>>
>>>>>>
>>>>>> Cheers,
>>>>>> Fred
>>>>>>
>>>>>>>
>>>>>>>>      hw/misc/grlib_ahb_apb_pnp: Add trace events on read accesses
>>>>>>>>      hw/timer/grlib_gptimer: Display frequency in decimal
>>>>>>>>      target/sparc/int32_helper: Remove DEBUG_PCALL definition
>>>>>>>>      target/sparc/int32_helper: Extract and use excp_name_str()
>>>>>>>>
>>>>>>>>     hw/misc/grlib_ahb_apb_pnp.c             | 24
>>>>>>>> ++++++++++++++++++++++--
>>>>>>>>     target/sparc/int32_helper.c             | 23
>>>>>>>> ++++++++++++-----------
>>>>>>>>     hw/misc/trace-events                    |  4 ++++
>>>>>>>>     hw/timer/trace-events                   |  2 +-
>>>>>>>>     tests/acceptance/machine_sparc_leon3.py |  4 ++++
>>>>>>>>     5 files changed, 43 insertions(+), 14 deletions(-)
>>>>>>>>
>>>>>>
>>>>
>>>
> 

