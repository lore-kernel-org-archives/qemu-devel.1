Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DF3C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 18:01:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5ED720771
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 18:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D7cGcoqW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5ED720771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5v4Q-00074W-Tv
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 14:01:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38100)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k5v34-0006Jk-U3
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 14:00:27 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:46929)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k5v32-0006B7-2c
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 14:00:26 -0400
Received: by mail-pg1-x544.google.com with SMTP id 189so799143pgg.13
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 11:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=5nEq4D3BwpC54IVy2oXje/yotT7EA7h7UfDLcLGP4Ls=;
 b=D7cGcoqWKO95yKT/Z7lDBNwUD/Z8AsJ7XqpL0OD14bdtkqEIgf/zaBELiFlwk+xBFE
 HuVQxUbuAUk5tLzyJ4VFSZsnyFnYkVSgNLI++DEoTpYfKyCYnhd5LkziNPnwO11BQw2G
 QOVcvuDHvw40qEXy2c8wpzqSWvQLkvpU5fguQk4CnPOMk175+8ul/q2qQb5ofqSuduuI
 HdDn+WjrOLgJUYGnOrzTrvA4Px8ZrhLFObuMgPjPKxtVZBZMaHeRHK8NJr3JUCZuo7pP
 ZGr+x+CUUYyWLYKD1TTpzb8wIe9UqYXytdbV0q/WmE4SJnTM6HEJ+AQKJeHaD7PCoJFA
 qSXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5nEq4D3BwpC54IVy2oXje/yotT7EA7h7UfDLcLGP4Ls=;
 b=E8aOb8oxcE6KtEITGafWgRSxlfKETxFFwTpeEMbVDfdvwsDQr98NlxooZvLGlCtoEx
 zr/nuArH6kcWI1l1g7RMa1w3es9M+cjdPTPEyiDbQuc2xci5j1eJhg9zajNmVnufsY7I
 91nEibMGUmYs8mthdQrPtAgzBl0MvwgLCc41/sjvvseFNa0bS7isLnOQBnSrdPUOwS8P
 fbgFn+/zFqiv9O9Wn8dkZ3vADQHInGmohqSlzUJtZIz7otlI/F7AWzOjkCfvYznjYAqE
 VnznqsCZHCxxgHOuhs3++Xjo65Kf7wxm6MukxjITX4bXdDLgPxpzS6Nh4a9CETU7+QT1
 AXDQ==
X-Gm-Message-State: AOAM530fzR33aC8pmKMpyJxedkYYIHrku7tiX/9tkJC3uEzGUuYbJwUQ
 bysCZ0hJWOZF5c+q3e7BrMtzDQ==
X-Google-Smtp-Source: ABdhPJyaNwl9CGT9XHxnnJsmfdHrLQnf9DpljTGeg4vtR03Jl+WZQRZEITxP9fJyOfW+F0oY9MVSvQ==
X-Received: by 2002:a63:4956:: with SMTP id y22mr290729pgk.380.1597255222466; 
 Wed, 12 Aug 2020 11:00:22 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j94sm2905221pje.44.2020.08.12.11.00.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2020 11:00:21 -0700 (PDT)
Subject: Re: [PATCH 0/3] target/arm: Complete ISS for MTE tag check fail
From: Richard Henderson <richard.henderson@linaro.org>
To: Andrey Konovalov <andreyknvl@google.com>
References: <20200812171946.2044791-1-richard.henderson@linaro.org>
 <CAAeHK+z=CU5dQepy+SBtVMAp-=k8BODorG768CYwoR3NEKCWFg@mail.gmail.com>
 <b2d524a2-1523-d03a-72a9-407ab03fa897@linaro.org>
Message-ID: <a3d0f05e-1e76-5c5a-4be9-506dab0e6e9d@linaro.org>
Date: Wed, 12 Aug 2020 11:00:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b2d524a2-1523-d03a-72a9-407ab03fa897@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, Vincenzo Frascino <vincenzo.frascino@arm.com>,
 alex.bennee@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/12/20 10:52 AM, Richard Henderson wrote:
> On 8/12/20 10:38 AM, Andrey Konovalov wrote:
>> On Wed, Aug 12, 2020 at 7:19 PM Richard Henderson
>> <richard.henderson@linaro.org> wrote:
>>>
>>> As reported by Andrey, I was missing the complete ISS info for
>>> the Data Abort raised upon a synchronous tag check fail.
>>>
>>> The following should fix that.  All the twisty little rules for
>>> the ISS.ISV bit are already handled by merge_syn_data_abort.
>>> Probably the most important bit that was missing was ISS.WnR,
>>> as that is independent of ISS.ISV.
>>>
>>> Andrey, will you please test?
>>
>> Looks like WnR is now being set properly, but SAS is still always 0.
> 
> Are you looking at ESR_EL1?
> 
> On page D13-2992 of revision F.a:
> 
> # ISV is 0 for all faults reported in ESR_EL1 or ESR_EL3.
> 
> which means that ISS[23:14] are RES0, which includes SAS.

Actually, note that AArch64.TagCheckFault never fills in anything except WnR.
So the final patch here merging the recorded syndrome information is wrong.  I
was only missing WnR in the original implementation.


r~

