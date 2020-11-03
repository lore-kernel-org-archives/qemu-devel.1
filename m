Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18106C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 14:31:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 990E82236F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 14:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bc4vUOPB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 990E82236F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZxL3-0007Om-M4
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 09:31:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58346)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kZxGW-0004Pj-Dd
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:26:29 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:33093)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kZxGT-0003fe-OE
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:26:27 -0500
Received: by mail-wm1-x343.google.com with SMTP id p19so21196wmg.0
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 06:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=R2t/Eu3a69wwhYeFS7ac1V9NHlbJG2eXeO6lnPUbVyM=;
 b=bc4vUOPBaPbzEBRdRrq8bu23a/kApa74/Uc76+IIuF6ODB1qPRZCQPnLYxS9lD8fNk
 igsdI4UCpZ+rNKS+wQa0Mtf0TBzeyhauzUzRlcaVk1xCDCmQR7gSvJEYQfda0KRvQ8h8
 Bx1J2a++LWSSZt5bPlaNKe2SUM+2/0dkA2x7SOap1q+X1svZ+LkUR6Y07V+KiK1HiKLL
 5a2cqQ3yWn/pn24jmYVRJO8rQC+ziexXjCD7kVqk2HeJG4RFYRJKDwQ2XFSvZB2suHJ7
 FiNmOYOIXtVUkmSXSXP0ySXUijvsHDk91gX9BWR7pVhZ8rnxzxWKTEG+3S3QRuRfbkiW
 YYrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=R2t/Eu3a69wwhYeFS7ac1V9NHlbJG2eXeO6lnPUbVyM=;
 b=IpvnJjUWHqvqi8eBvmoW7CcCdhROwaoTCBTarXi9rdnLxpAoiz8Ok9YhwYQ/eg735+
 XLGmiKeiCSCGqJ6TtmqGpUeZQnPmW4o6qJGjfdwKBpIYsr5LI6/ct0iedA0NoLnqMdHi
 seMcsxW00T+RdrtV9/uDfqaHdM/vbAKAJUFEOHk+9HMpVg72wrmyRzLI9GijaK7y2prJ
 ARz8Q6jpquA/qSnG9nosh7aovKrvhyfUU8p/Cbf4XcpgypYWsT2T2vO6chbCK1wtNyZ4
 HmUBKP0FrwkvCsx1Pa9ldL96zME2tiPvUOWX6i19//29l16hKGkBSgbSvIwH8YMhkpZs
 bjLQ==
X-Gm-Message-State: AOAM532QTjBRyrlVsHyYksyfIsPY905EDthDg1RXEjdhzA5uoGyUyblR
 WCRIwMEj1ZX8IN/hucEl540=
X-Google-Smtp-Source: ABdhPJxECIPPMpyLmDvAWsR+Rd9Sa91XhlpyBGAmHcTEOUs9hf+J5E91DNxYCrdS+WMKzvJOFTECYw==
X-Received: by 2002:a1c:6484:: with SMTP id y126mr3777067wmb.141.1604413582766; 
 Tue, 03 Nov 2020 06:26:22 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id t2sm9977455wrw.95.2020.11.03.06.26.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2020 06:26:22 -0800 (PST)
Subject: Re: [PATCH] hw/intc: Fix incorrect calculation of core in
 liointc_read() and liointc_write()
To: AlexChen <alex.chen@huawei.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <5FA12391.8090400@huawei.com>
 <ad70d1f3-ba98-3977-f2ac-a14d03c7e7ba@flygoat.com>
 <5FA163AF.2020007@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <0d169b57-9f3e-98a0-05d6-a5089675ecc8@amsat.org>
Date: Tue, 3 Nov 2020 15:26:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <5FA163AF.2020007@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.001,
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
Cc: zhengchuan@huawei.com, chenhc@lemote.com, QEMU <qemu-devel@nongnu.org>,
 zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/3/20 3:05 PM, AlexChen wrote:
> On 2020/11/3 17:53, Jiaxun Yang wrote:
>>
>>
>> 閸︼拷 2020/11/3 17:32, AlexChen 閸愭瑩浜�:
>>> According to the loongson spec
>>> (http://www.loongson.cn/uploadfile/cpu/3B1500/Loongson_3B1500_cpu_user_1.pdf)
>>> and the macro definition(#define R_PERCORE_ISR(x) (0x40 + 0x8 * x)), we know
>>> that the ISR size of per CORE is 8, so here we need to divide
>>> (addr - R_PERCORE_ISR(0)) by 8, not 4.
>> Hi Alex
>>
>> Thanks!
>>
>> That was my fault.. Per Core ISA is rarely used by kernel..

No board in QEMU use this device. So we are safe =)

>>
>> Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>>> Reported-by: Euler Robot <euler.robot@huawei.com>
>> Btw:
>> How can you discover this by robot?
>> Huawei owns real artifical intelligence technology lol :-閿涳拷
>>
>>
> 
> Thanks for your review.
> EulerRobot is a virtualization software quality automation project that
> integrates some tools and test suites such as gcc/clang make test, qemu ut,
> qtest, coccinelle scripts and avocado-vt.
> The code checking tool found there was a potential array out of bounds at
> 'r = p->per_core_isr[core]', since 'core' may be 7 which is bigger than
> 'per_core_isr' array size 3.
> So we found this bug.
> 
> Thanks,
> Alex
> 
>> - Jiaxun
>>> Signed-off-by: Alex Chen <alex.chen@huawei.com>
>>> ---
>>>   hw/intc/loongson_liointc.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/intc/loongson_liointc.c b/hw/intc/loongson_liointc.c
>>> index 30fb375b72..fbbfb57ee9 100644
>>> --- a/hw/intc/loongson_liointc.c
>>> +++ b/hw/intc/loongson_liointc.c
>>> @@ -130,7 +130,7 @@ liointc_read(void *opaque, hwaddr addr, unsigned int size)
>>>
>>>       if (addr >= R_PERCORE_ISR(0) &&
>>>           addr < R_PERCORE_ISR(NUM_CORES)) {
>>> -        int core = (addr - R_PERCORE_ISR(0)) / 4;
>>> +        int core = (addr - R_PERCORE_ISR(0)) / 8;
>>>           r = p->per_core_isr[core];
>>>           goto out;
>>>       }
>>> @@ -173,7 +173,7 @@ liointc_write(void *opaque, hwaddr addr,
>>>
>>>       if (addr >= R_PERCORE_ISR(0) &&
>>>           addr < R_PERCORE_ISR(NUM_CORES)) {
>>> -        int core = (addr - R_PERCORE_ISR(0)) / 4;
>>> +        int core = (addr - R_PERCORE_ISR(0)) / 8;
>>>           p->per_core_isr[core] = value;
>>>           goto out;
>>>       }
>> .
>>
> 
> 


