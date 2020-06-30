Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD343C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 17:17:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DEFE20772
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 17:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kg0nvEeY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DEFE20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqJtE-0006pp-KZ
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 13:17:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqJsA-0006BX-2v
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 13:16:42 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:37006)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqJs8-0004DO-5c
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 13:16:41 -0400
Received: by mail-ej1-x643.google.com with SMTP id lx13so2768870ejb.4
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 10:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=9qHC4kqad8EJGR8w0LXs043fEXWkj1yg8TTpj4uagFU=;
 b=kg0nvEeYrI3DbqltfXH99+9B+EeynrzdYHTXRkSeJMfSoTAbrcn7eocWtrxl5bxstB
 zVYnKb8fWAtiV3529WumcLlZ/jszjQVZMMBwJudZC+gmV7cGa8msCdFpMNp7/38m38IK
 wffFN+wgSIJ4oBkaIrGO7e7W0qtVauPEGRb5U5rqTR7OuzVSgEmabLAtF9kivveNM027
 1vjPglZl0qZNy9w9/aqrfl9K9iZNXPnewNb5xlyrQ+mAaYHs9MNcMaMQ6C8lk2RnWXA/
 kOg4FiyLeRDVCZpo0CuJPg0zhilmYn8X4sq3mNNDXHeOLAtxk7iYsrTJ8umpNn8/a0hq
 rfUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9qHC4kqad8EJGR8w0LXs043fEXWkj1yg8TTpj4uagFU=;
 b=Fl/S817avR594ZdblMvBbvRVM1XWUxg4NwGQxPUH4ftYdt26DSFJdsg30jFIJScqO9
 5KW4KhGV/rfUcxXKAAa7i17LvimU8rzRZihhrbkkmWSAJS+28ia/s682xHWI6zbCQP5/
 GeV/IcvDhisw8uWL0l+YhHAFjnuRS1A1bX88QUecjJsRSIvZ3JaE1YIyYrizwcqF66Ra
 yru1ui3kjP94ODlAYkO3KTnomuFPrHimIXxQxmpV210GiTQVKs9nyyh9Bk1+cNcxITKc
 uvdGDl/BoRcTgCNjOqKE6erwRo49SObi+WMB4ut3DpWZinV0xfxnr2G8ZiSK4bkd3lEn
 qWoQ==
X-Gm-Message-State: AOAM530aKKLUh46dvbYR4n5137wryLZcAWDK8+XbaQaWdGClaPrPKEts
 iu5gCTL8GnESj8EbEIk0uNY=
X-Google-Smtp-Source: ABdhPJzGOgq7vUgB8zZ1qWB2OGif2gqHFtiGy1W5Qad2DbREgx/W9tj//6qHsuxC2YobVETdDCUQEg==
X-Received: by 2002:a17:906:a28b:: with SMTP id
 i11mr19005366ejz.524.1593537398577; 
 Tue, 30 Jun 2020 10:16:38 -0700 (PDT)
Received: from [192.168.1.40] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id x10sm2582255ejc.46.2020.06.30.10.16.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2020 10:16:37 -0700 (PDT)
Subject: Re: [PATCH v2 0/6] hw/mips/malta: Add the 'malta-strict' machine,
 matching Malta hardware
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
References: <20200630145236.27529-1-f4bug@amsat.org>
 <CAHiYmc4=pmzEyhVTHaqxBnCotE8V+vaptMFincyurvAyDHNn6g@mail.gmail.com>
 <5725b99b-b524-ab40-c74d-a615bb28d363@amsat.org>
 <CAHiYmc7AoJd7TMX_Beo3A2f3R1M=yrpe2ZydbsSysREf4Cx3Vw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a503201a-ed9f-dff6-6e3d-4729ed31ad98@amsat.org>
Date: Tue, 30 Jun 2020 19:16:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAHiYmc7AoJd7TMX_Beo3A2f3R1M=yrpe2ZydbsSysREf4Cx3Vw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Yunqiang Su <ysu@wavecomp.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Igor Mammedov <imammedo@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/30/20 6:55 PM, Aleksandar Markovic wrote:
> уто, 30. јун 2020. у 18:46 Philippe Mathieu-Daudé <f4bug@amsat.org> је
> написао/ла:
>>
>> On 6/30/20 5:38 PM, Aleksandar Markovic wrote:
>>> уто, 30. јун 2020. у 16:52 Philippe Mathieu-Daudé <f4bug@amsat.org> је
>>> написао/ла:
>>>>
>>>> Hi,
>>>>
>>>> This series add a new 'malta-strict' machine, that aims to properly
>>>> model the real hardware (which is not what the current 'malta'
>>>> machine models).
>>>>
>>>> As a bonus for Debian builders, a 'malta-unleashed' machine RFC
>>>> patch is included. This might start another endless discussion
>>>> upstream, but this is not the point of, so I still include it
>>>> for people to test. The rest of the series is candidate for merging
>>>> in mainstream QEMU.
>>>>
>>>> Philippe Mathieu-Daudé (6):
>>>>   hw/mips/malta: Trivial code movement
>>>>   hw/mips/malta: Register the machine as a TypeInfo
>>>>   hw/mips/malta: Introduce MaltaMachineClass::max_ramsize
>>>>   hw/mips/malta: Introduce the 'malta-strict' machine
>>>>   hw/mips/malta: Verify malta-strict machine uses correct DIMM sizes
>>>>   hw/mips/malta: Introduce the 'malta-unleashed' 64-bit machine
>>>>
>>>>  hw/mips/malta.c | 125 ++++++++++++++++++++++++++++++++++++++++++------
>>>>  1 file changed, 111 insertions(+), 14 deletions(-)
>>>>
>>>> --
>>>
>>> This whole series is based on idea of emulating physically
>>> non-existing feature, and as such violates the fundamental principles
>>> of QEMU.
>>>
>>> As such, not acceptable for upstreaming.
>>>
>>> I don't see the point of sending again the same series, in just
>>> cosmetically different form, if it was said to you that the concept is
>>> wrong.
>>
>> Have you looked at the patches? What "violates the fundamental
>> principles of QEMU" is the code currently in mainstream. Should
>> we remove it? I can send a patch for it if it pleases you, but
>> you will make QEMU unuseful for many distribution users.
>>
> 
> Past mistakes are past mistakes. We have to live with them. And not
> make them in the future.
> 
> I see the whole series as a precursor for your change that repeats
> past mistakes, a "wolf in sheep clothing".
> 
> That's why I reject the series as a whole.

As a co-maintainer I don't accept that.

The 'malta' machine is not changed, the series adds the 'malta-strict'
machine which check the RAM restriction:

$ qemu-system-mips -M malta-strict -bios /dev/null -m 512
qemu-system-mips: Too much memory for this machine: 512 MiB, maximum 256 MiB

$ qemu-system-mips -M malta-strict -bios /dev/null -m 252
qemu-system-mips: RAM size must be the combination of 4 powers of 2

$ qemu-system-mips -M malta-strict -monitor stdio -S -bios /dev/null -m 100
QEMU 5.0.50 monitor - type 'help' for more information
(qemu) info mtree
address-space: memory
  0000000000000000-ffffffffffffffff (prio 0, i/o): system
    0000000000000000-00000000063fffff (prio 0, ram): alias
mips_malta_low_preio.ram @mips_malta.ram 0000000000000000-00000000063fffff

100 = 64 + 32 + 2 + 2

> 
> Yours,
> Aleksandar
> 
>> What this series does is emulate the physically existing feature
>> that are not yet emulated in QEMU.
>>
>> Please refer to the datasheet 'MIPS Document Number: MD00051
>> Revision 01.07' before rejecting this series, and find the
>> correct arguments.
>>
>> Thanks.
>>
>>>
>>> Regards,
>>> Aleksandar
>>>
>>>
>>>> 2.21.3
>>>>
>>>
> 

