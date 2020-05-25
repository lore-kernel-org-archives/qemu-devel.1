Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7FECC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 11:03:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81337207CB
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 11:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=adacore-com.20150623.gappssmtp.com header.i=@adacore-com.20150623.gappssmtp.com header.b="D8tGrPPu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81337207CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=adacore.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdAt5-0005cO-PN
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 07:03:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56084)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <konrad@adacore.com>)
 id 1jdAsI-00055b-UB
 for qemu-devel@nongnu.org; Mon, 25 May 2020 07:02:30 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35376)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <konrad@adacore.com>)
 id 1jdAsH-0005Rx-LW
 for qemu-devel@nongnu.org; Mon, 25 May 2020 07:02:30 -0400
Received: by mail-wm1-x343.google.com with SMTP id n5so16293081wmd.0
 for <qemu-devel@nongnu.org>; Mon, 25 May 2020 04:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=VnDCLR6yzg17UFTJm6DmylYAtQYVdcVQ9aEjg3duVMU=;
 b=D8tGrPPuVs1/352XRLaPiCC94VSzxXQHHeNKhZLP9YFmpxIJhFsDAQyGAlaTGneGh8
 yj8ZvIA0ASTv6BO+VmZ8iVBb9liWSgyMwCYPobUzg1tl+kzbZWr71SiuQxI97duZFsRX
 28UhyDAQJ9vxiA6noYOql1yNXc/nfGC27qzqxg3Vd66LaxjBWf2znsiuKmllLXkPpXJv
 re2zYxIu9zZiKXbkFsPmUOmsjmFf6TeMFqoljzp0Ivobu8m+7aUqKHa4Ymr2kQ1VcYq1
 LLHzXNbHn7Q/W9RJrUkUEuFzjzHRh0xiIvcg/2LF0MyZnYAZ5g2lqzW/H9Jh3VSD9lHc
 u+tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VnDCLR6yzg17UFTJm6DmylYAtQYVdcVQ9aEjg3duVMU=;
 b=gqq6kjc7ibXxSGsI/eBMXtDaUGIvpGma+eiOgrkP537zeeTdmulIfLRiz7mk+Ef4W1
 S5AhCSubPFo25zGrBtu7iqmKzssh5UHuBA5cWyi3yGKqlWccf5aylUgTqyuTcSX4UoWK
 6KSafULvet3zbIVtE3M8Hj7ccOTWAnu8ZGnJn54gyU3kd41HqlAuvMI8ZBontp53/Ldx
 NjO0k4VoPfO/8tGTVEXqKwdHFSlxwEPanaCf9pmNnEuVjy5M4f2wd0hw44EQPNSmS9yA
 6HdFCnU/mUNUp2a0W3aAVHlNrkcvXjNhbyLa/TUb4JX3E6PDdEePkHcmFb+k+fJHVCd0
 flEA==
X-Gm-Message-State: AOAM5313GQUtKAMJXBfHbJ4PDN9NlokVqGCbLIAE9GJI8pAQPGuY7MGU
 Zst3bnM5f2kOOjVd2OxtT9rsTA==
X-Google-Smtp-Source: ABdhPJxrXDzJadmgKDM6CbaK37WNjFa1Tk4hGy+kYu/143r1yd2zsKyesh8opdUaZ8ty7b5FnF9A7A==
X-Received: by 2002:a1c:b7d5:: with SMTP id h204mr5651630wmf.100.1590404547611; 
 Mon, 25 May 2020 04:02:27 -0700 (PDT)
Received: from localhost.localdomain
 (apoitiers-259-1-38-10.w90-55.abo.wanadoo.fr. [90.55.221.10])
 by smtp.gmail.com with ESMTPSA id r11sm16702806wre.25.2020.05.25.04.02.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 May 2020 04:02:27 -0700 (PDT)
Subject: Re: [PATCH 0/7] hw/sparc/leon3: Few fixes and disable HelenOS test
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-devel@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20200331105048.27989-1-f4bug@amsat.org>
 <81737d76-06c6-4c83-1287-b0d14db4ce2f@amsat.org>
 <989bf2f5-0e23-f9c3-e9e1-0bd8c03f3231@adacore.com>
 <1b7a4c63-5a31-6efe-d807-7092e3ee0ffb@amsat.org>
 <230dbf6b-120a-f1f0-d48d-9fa4a04e05cd@adacore.com>
 <23588fda-b95b-45a9-b788-e846d26a3bc3@amsat.org>
 <7f673b61-7565-f79a-0ec6-043c44d1df77@amsat.org>
From: Fred Konrad <konrad@adacore.com>
Message-ID: <08b73f34-4cab-1133-e5e5-5b1e9fc7b5d0@adacore.com>
Date: Mon, 25 May 2020 13:02:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <7f673b61-7565-f79a-0ec6-043c44d1df77@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=konrad@adacore.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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

Sorry Philippe I missed that.

Would be happy to do a PR if needed but:
   * I never did that.
   * Looking at https://wiki.qemu.org/Contribute/SubmitAPullRequest, I don't have
     the signed GPG key either.

Cheers,
Fred

Le 5/23/20 à 7:26 PM, Philippe Mathieu-Daudé a écrit :
> ping?
> 
> On 5/11/20 9:03 AM, Philippe Mathieu-Daudé wrote:
>> On 4/14/20 12:00 PM, KONRAD Frederic wrote:
>>> Le 4/13/20 à 11:07 PM, Philippe Mathieu-Daudé a écrit :
>>>> [Cc'ing Peter]
>>>>
>>>> On 4/13/20 12:12 PM, KONRAD Frederic wrote:
>>>>> Le 4/11/20 à 7:30 PM, Philippe Mathieu-Daudé a écrit :
>>>>>> On 3/31/20 12:50 PM, Philippe Mathieu-Daudé wrote:
>>>>>>> Philippe Mathieu-Daudé (7):
>>>>>>>      hw/misc/grlib_ahb_apb_pnp: Avoid crash when writing to AHB PnP
>>>>>>>        registers
>>>>>>>      hw/misc/grlib_ahb_apb_pnp: Fix AHB PnP 8-bit accesses
>>>>>>
>>>>>> Ping ^^^ for 5.0?
>>>>>
>>>>> Hi Philippe,
>>>>>
>>>>> You already have my rb tag for those one, and IMHO they should be good
>>>>> candidate
>>>>> for 5.0 (if it's not too late).
>>>>
>>>> Yes, thanks for the reviews. I see Mark Cave-Ayland merged this file
>>>> first, but you are listed as maintainer :) I was hoping you could send a
>>>> pull request.
>>>
>>> Yes that's usually Mark who take the patches, sorry I didn't get it.
>>
>> No worries. As there are other sparc64 patches on the list, maybe Mark
>> will prepare a pull request now.
>>
>>>
>>>>
>>>> $ scripts/get_maintainer.pl -f hw/misc/grlib_ahb_apb_pnp.c
>>>> Fabien Chouteau <chouteau@adacore.com> (maintainer:Leon3)
>>>> KONRAD Frederic <frederic.konrad@adacore.com> (maintainer:Leon3)
>>>> qemu-devel@nongnu.org (open list:All patches CC here)
>>>>
>>>
>>>> This is a bug but not 'security critical', so it might wait 5.1 and go
>>>> via qemu-trivial tree.
>>>
>>> Well let's do that then if you're ok.
>>
>> OK, then ping? :)
>>
>>>
>>> Best Regards,
>>> Fred
>>>
>>>>
>>>> Regards,
>>>>
>>>> Phil.
>>>>
>>>>>
>>>>> Cheers,
>>>>> Fred
>>>>>
>>>>>>
>>>>>>>      hw/misc/grlib_ahb_apb_pnp: Add trace events on read accesses
>>>>>>>      hw/timer/grlib_gptimer: Display frequency in decimal
>>>>>>>      target/sparc/int32_helper: Remove DEBUG_PCALL definition
>>>>>>>      target/sparc/int32_helper: Extract and use excp_name_str()
>>>>>>>
>>>>>>>     hw/misc/grlib_ahb_apb_pnp.c             | 24
>>>>>>> ++++++++++++++++++++++--
>>>>>>>     target/sparc/int32_helper.c             | 23
>>>>>>> ++++++++++++-----------
>>>>>>>     hw/misc/trace-events                    |  4 ++++
>>>>>>>     hw/timer/trace-events                   |  2 +-
>>>>>>>     tests/acceptance/machine_sparc_leon3.py |  4 ++++
>>>>>>>     5 files changed, 43 insertions(+), 14 deletions(-)
>>>>>>>
>>>>>
>>>
>>

