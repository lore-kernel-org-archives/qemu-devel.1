Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C90C43457
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 09:54:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3923520776
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 09:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKRXysxs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3923520776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRuWm-0006v6-0G
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 05:54:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44672)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRuVX-0005lU-OO
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 05:52:43 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:50724)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRuVV-000250-1h
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 05:52:42 -0400
Received: by mail-wm1-x343.google.com with SMTP id 13so16640918wmf.0
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 02:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=7itYNF9rtSSREjE7Irl9Vri1on7EUKnhDbaMUV+FlSo=;
 b=JKRXysxs0hhY0PMEp8hChap3sSxuIGeY7gpjfq7/l41Scs5vWfgH1ur0CvPcN4d0fN
 CTcf9UlDMKRTcujLsnwwFrM2sUJ2CW6Ti3Ru7UwAxhVIsADdVnsyMdlVk5itZsq+WQK9
 Z2Ce9ADTh/NbfoBWaYDIE63EPqglxyVoAWgmKwDgyN2nsNff7wiEAMb847cpUt1AG2Dz
 zibWOqCub52V5+TvudL0jPIlkfr2jAQUp8FUfuQGfxzLg38rEglI3/vBHrTdo1iFtm46
 hHl+ljHxwEyjAA8QB95D7T3Sv5T+dq/RnnbT1UEPO4a1eljB2bkCIVTr6Q9gBhQ55DEY
 jRBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7itYNF9rtSSREjE7Irl9Vri1on7EUKnhDbaMUV+FlSo=;
 b=tdWTzwyC3J6/3czgeI659+beOzWqZ4f2agskXA3cgwu8+0xQJ4rl1ivJZx0OuLqGkk
 j7Mq/oGBRStMUzzxOMSxA3TJzRt5oOuLpWxsMPfvMsXwZ1+TuOyMoPZeJKF7sqnF2VCa
 c0uiEqDg0bc1vl602gtXp+mabv6EbDv/nF41MjrzH3ziiYrC3LVaUV7aYeYtThuzzffP
 gh//u+2Vya5ySsQplDg759Nj8uPLPZXyvMVdX/tL0BP7P9+47GRh372U4Ji1wg+aT3aq
 fynABa4EFEZtwKYnc6+Dc7KigNiBhmPtXRPgo42+/aztngflFv/NN7JPLXdTAkK8YYFo
 XH0Q==
X-Gm-Message-State: AOAM532gVW/FR9jhPTods2KRLEFDEH5NM0B/Lm2njmq5ASaeZ0AmfANc
 3t06JMkg1rX2WIQzqr3OqKU=
X-Google-Smtp-Source: ABdhPJxxDoCVwayAoPGj4y7hcwm9bs2p1HBvGB6mrfqB/1eqezHQJU95BkevOirpCq1ub0UsuVxn7A==
X-Received: by 2002:a05:600c:258:: with SMTP id
 24mr9792556wmj.167.1602496359409; 
 Mon, 12 Oct 2020 02:52:39 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id t6sm27352219wre.30.2020.10.12.02.52.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Oct 2020 02:52:38 -0700 (PDT)
Subject: Re: [PATCH 3/5] MAINTAINERS: Downgrade status of MIPS Boston to "Odd
 Fixes"
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20201009165208.2905569-1-f4bug@amsat.org>
 <20201009165208.2905569-4-f4bug@amsat.org>
 <945e6bbe-51a3-6bf6-8387-e2acf0901738@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <32c3ca4a-8127-8d6e-8ab1-7c36c1d773cd@amsat.org>
Date: Mon, 12 Oct 2020 11:52:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <945e6bbe-51a3-6bf6-8387-e2acf0901738@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Chen Huacai <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Paul Burton <paulburton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/12/20 9:40 AM, Thomas Huth wrote:
> On 09/10/2020 18.52, Philippe Mathieu-Daudé wrote:
>> Paul's Wavecomp email has been bouncing for months. He told us
>> he "no longer has access to modern MIPS CPUs or Boston hardware,
>> and wouldn't currently have time to spend on them if he did." [1]
>> but "perhaps that might change in the future." [2].
>> Be fair and downgrade the status of the Boston board to "Odd Fixes"
>> (has a maintainer but they don't have time to do much other).
> 
> When I read this patch description ("email bouncing"), I wondered why you
> did not also update Paul's email address here. Then I saw that you're doing
> this in the next patch. So I'd recommend to either scratch the first
> sentence of your patch description here, or to merge the two patches.

I don't want to scratch it here because this justifies the downgrade.
I'll merge with the next, hoping nobody will complain these are
unrelated changes and has to be split =)

> 
>   Thomas
> 
>> [1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg718739.html
>> [1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg728605.html
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>   MAINTAINERS | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 2de5943e388..782743b7ef0 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1163,7 +1163,7 @@ F: hw/intc/loongson_liointc.c
>>   Boston
>>   M: Paul Burton <pburton@wavecomp.com>
>>   R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
>> -S: Maintained
>> +S: Odd Fixes
>>   F: hw/core/loader-fit.c
>>   F: hw/mips/boston.c
>>   F: hw/pci-host/xilinx-pcie.c
>>
> 
> 

