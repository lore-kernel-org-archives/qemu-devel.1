Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 406ABC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 09:11:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06E9D206E2
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 09:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lsK8JgwR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06E9D206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfgU1-0002QB-40
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 05:11:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jfgTS-0001uD-GU; Mon, 01 Jun 2020 05:11:14 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38019)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jfgTQ-0002ml-Uu; Mon, 01 Jun 2020 05:11:14 -0400
Received: by mail-wm1-x344.google.com with SMTP id f185so10580484wmf.3;
 Mon, 01 Jun 2020 02:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=0NHKCC2ZM3RNLuaUKMH/VgdKQS0ppaSfMzXAY8OLTr8=;
 b=lsK8JgwRzqjmiFc/npOdne9N3JOVIeQV1tRNu896E/tOTK3dx6kwcpuwsLhD3p0KdW
 HISfTdZoaUeTDEmuKh9qVWvHHPFAYyXZR5wxEIt1WOEj91VukYsGfddCEeH+SReqZofO
 7cU6PAZLsoc413fj91VFMix0wQ/7hgAKwHeFdoep5rNrRMGDx1OVvfP9yZYcTM6+Wy5M
 NdRYyDglOUHcDzBUQZ5I8kRCz+vhLdsC7o/3qYgqXXUoHhmoSY39lvKg4h1IVNt0IGtU
 0RuxWXFkRWcIXryzo29KrDo8+Zt5HNzd9+mkJ9L4vu+Eqec0trYuVKTn+wT32A3Z8z2n
 t18Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0NHKCC2ZM3RNLuaUKMH/VgdKQS0ppaSfMzXAY8OLTr8=;
 b=SICpBZYBrIZDTA4rGu/Mf9XAYb/Spx/fOY9HED3MrHalU8tnS/kHlwdP3EhONBl7Aw
 84H4qjpmJefZxwgAzz9ksGB7GMZ2RFDsP2FFUdyB1kFWH+GybKD/OZmFvq/TT9X9pFme
 g6hrI5oXTL3ugyQ1ZWDR7L2rb7YnAkurXz4Gdn7MlhqMB8CiWiuLz16/Ap0phwxzBpkr
 yYPOI8wYZTwasLHQ3++yDycEUjaoJaVd6XMqO1vFxIVmH/R8gQ3jL1AVWWneNVeUCs+T
 i5QKql9vG4lw52VR6ivjVIFGg8ETPirAT/WhBK1lDagfxMRXgdhbNNxvCchkmtEY6EVB
 Dqjw==
X-Gm-Message-State: AOAM533PzlzFqxdHMX7rOV+2/KesHdRikMQXUccblR7l81AiwGR626v9
 skt9AWGK9/MvNNRyO45Q3Ms=
X-Google-Smtp-Source: ABdhPJwEhNjZcBQDCJd7jvZrEijY8LbCG2LoH6Eo5LbKMKrpUHsLH3gXTz2bSd2d6R+U4eVsom9OAw==
X-Received: by 2002:a1c:6042:: with SMTP id u63mr20463260wmb.65.1591002671026; 
 Mon, 01 Jun 2020 02:11:11 -0700 (PDT)
Received: from [192.168.1.34] (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id 37sm20848156wrk.61.2020.06.01.02.11.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2020 02:11:10 -0700 (PDT)
Subject: Re: [PATCH 0/5] hw/sh4: current patch queue
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200530092306.26628-1-f4bug@amsat.org>
 <87eer0v25c.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8279188f-f6a7-4d0e-50d9-de1c66619e50@amsat.org>
Date: Mon, 1 Jun 2020 11:11:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87eer0v25c.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
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
Cc: Fam Zheng <fam@euphon.net>, qemu-trivial@nongnu.org,
 Magnus Damm <magnus.damm@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/31/20 12:18 PM, Alex Bennée wrote:
> 
> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
> 
>> Hi,
>>
>> As there is no SH4 active maintainer, I gathered various
>> patches in a single series, in case someone is willing to
>> apply them.
> 
> I'm sure you you could put yourself down as an "Odd Fixes" maintainer
> and put together a PR if you want?

  Odd Fixes: It has a maintainer but they don't have time to do
             much other than throw the odd patch in.

OK 'Odd Fixes' matches what I can offer as a hobbyist.
I'm happy to help avoiding this code to bitrot, as long as I don't get
the same pressure imposed on other targets.
After all this Renesas hardware has a lot in common with the RX I've
been looking at recently.

> 
>>
>> CI report:
>> https://travis-ci.org/github/philmd/qemu/builds/692828388
>>
>> Regards,
>>
>> Phil.
>>
>> Philippe Mathieu-Daudé (3):
>>   hw/sh4: Use MemoryRegion typedef
>>   hw/sh4: Extract timer definitions to 'hw/timer/tmu012.h'
>>   hw/timer/sh_timer: Remove unused 'qemu/timer.h' include
>>
>> Thomas Huth (2):
>>   tests/acceptance: Add boot tests for sh4 QEMU advent calendar image
>>   .travis.yml: Test SH4 QEMU advent calendar image
>>
>>  include/hw/sh4/sh.h                    | 12 +-----------
>>  include/hw/timer/tmu012.h              | 23 +++++++++++++++++++++++
>>  hw/sh4/sh7750.c                        |  1 +
>>  hw/timer/sh_timer.c                    |  3 ++-
>>  .travis.yml                            |  2 +-
>>  tests/acceptance/boot_linux_console.py | 13 +++++++++++--
>>  6 files changed, 39 insertions(+), 15 deletions(-)
>>  create mode 100644 include/hw/timer/tmu012.h
> 
> 

