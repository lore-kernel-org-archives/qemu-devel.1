Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B37C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 12:40:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D206206E3
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 12:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/j/7Yp2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D206206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxrZj-0001Bs-6Z
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 08:40:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34512)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jxrYa-0000ON-C2
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 08:39:40 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38205)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jxrYY-0004ie-P8
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 08:39:40 -0400
Received: by mail-wr1-x444.google.com with SMTP id a14so6196434wra.5
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 05:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=v1yU5YNoiCXGfLriNVz+CjOsDDRYqZY6fYZst/7L2TA=;
 b=B/j/7Yp23rEEV5KlWOwLLFPDB/HhVlVbsRV25FYe4uHWUw6/2UNbuveQ1TuJ728wDX
 WLxy7wyxsXToh1wJWsff9otIYtNCWoKrA58qgyuyu9l0mdRKV20HcFKtn7ZTXDTN36G2
 W9/7cvgdNmhf8n73GPmfqAfSlVG2EUrOB9MwYMOEl/C2tKMAOjhjv5G/KLMVNI6Ze6a3
 TYVx/5dCgohnzMJKt5QMoFFQaJzzjcLfvebZvXEWCKEgvyR/an9M45zZBD6jFppyiPqX
 jsKGbJ+Hzfxs1Ueq1eMrHubFEBDfHcVXux8K/+XMvsvri8vbgyK1m3cHzMx6gjYgjIm0
 YISQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=v1yU5YNoiCXGfLriNVz+CjOsDDRYqZY6fYZst/7L2TA=;
 b=mp1DToo6PYEqa5NyAJwvAePq0qqSHc0XL8d8if4ueJ2oIkK5y0ruoR9/KbT3/EGi1a
 XWuhTzb3yMoqOxIF+G3Gl4Xpmii2Y5hx2QZ/geryG0ukZemhXW7DxxbLh92w7/QhOChb
 vYUEDQvPBQ9t4FP2cv16iL3lTqbLXD7hSc9vofsYL/I1aMpDz+l0ylJNKgSEMZZTjVDD
 MrFo99M/2fxGNA5x6SIAL84DS1C1om9TRzFs2N/zPMc8HlB/2T8dhkGc14J3nLyrpL3i
 1o6Tk9AHq6Sc71olqsnM7i6qFdOfVS18eE1XjfH3U5AOBgGzVrURd18dCfnOkW6dsXWi
 1uqg==
X-Gm-Message-State: AOAM533wJzWRRCDXFRrYBx4IB061z++zaz+pv9pftIe+YbJ3krfc3Mwe
 ypyXO5xqocSC9HacPkYUbfc=
X-Google-Smtp-Source: ABdhPJyifyZmhVeGaWnrgYgjtWX2zu3KBeqtAolG/ZWmDsdoMxXsnzzbvUL+aUCj0N/d9RDkxiW9+Q==
X-Received: by 2002:a5d:684f:: with SMTP id o15mr27012789wrw.148.1595335177146; 
 Tue, 21 Jul 2020 05:39:37 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id w12sm40316473wrm.79.2020.07.21.05.39.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2020 05:39:36 -0700 (PDT)
Subject: Re: [RFC PATCH-for-5.1? v3 1/2] memory: Allow monkey-patching
 MemoryRegion access sizes
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200721123154.5302-1-f4bug@amsat.org>
 <20200721123154.5302-2-f4bug@amsat.org>
 <CAFEAcA_C1C-5oSrEZgJoufCc_91TdC3vv5+SUSBHHnWDGVyOCg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1e60f58f-b4b1-3490-5485-d51f4584caf4@amsat.org>
Date: Tue, 21 Jul 2020 14:39:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_C1C-5oSrEZgJoufCc_91TdC3vv5+SUSBHHnWDGVyOCg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: "Daniel P . Berrange" <berrange@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, QEMU Developers <qemu-devel@nongnu.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/21/20 2:33 PM, Peter Maydell wrote:
> On Tue, 21 Jul 2020 at 13:31, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> To fixes CVE-2020-13754, commit 5d971f9e67 refuses mismatching
>> sizes in memory_region_access_valid(). This gives troubles when
>> a device is on an ISA bus, because the CPU is free to use
>> 8/16-bit accesses on the bus (or up to 32-bit on EISA bus),
>> regardless what range is valid for the device.
>>
>> To allow surgical change for the 5.1 release, allow monkey
>> patching of the MemoryRegionOps (by making the MemoryRegion
>> field not const). This should be reverted after the release
>> and fixed in a more elegant manner.
>>
>> Fixes: 5d971f9e67 ('memory: Revert "accept mismatching sizes in memory_region_access_valid"')
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  include/exec/memory.h |  7 ++++++-
>>  softmmu/memory.c      | 12 ++++++++----
>>  2 files changed, 14 insertions(+), 5 deletions(-)
>>
>> diff --git a/softmmu/memory.c b/softmmu/memory.c
>> index 9200b20130..84b5c617e2 100644
>> --- a/softmmu/memory.c
>> +++ b/softmmu/memory.c
>> @@ -1218,7 +1218,7 @@ static void memory_region_initfn(Object *obj)
>>      MemoryRegion *mr = MEMORY_REGION(obj);
>>      ObjectProperty *op;
>>
>> -    mr->ops = &unassigned_mem_ops;
>> +    mr->ops = g_memdup(&unassigned_mem_ops, sizeof(MemoryRegionOps));
>>      mr->enabled = true;
>>      mr->romd_mode = true;
>>      mr->global_locking = true;
> 
> Don't you now need to g_memfree() mr->ops somewhere? Otherwise
> you've leaked it if the device which owned this MemoryRegion
> is hot-unplugged, I think.

I haven't thinking of hot-unplug. I went with the simplest fix
considering we are in freeze, and fixing the bug was more
important that a leak at this point.
I'll have a look at freeing this memory, hoping it is still less
disruptive than a proper architectural change to fix this problem.

> 
> thanks
> -- PMM
> 

