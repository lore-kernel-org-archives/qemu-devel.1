Return-Path: <SRS0=I9ML=66=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF14C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 17:26:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F24962065C
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 17:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hti7TEfK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F24962065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ja0Zy-0002vq-4J
	for qemu-devel@archiver.kernel.org; Sat, 16 May 2020 13:26:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ja0ZK-0002PT-A9
 for qemu-devel@nongnu.org; Sat, 16 May 2020 13:25:50 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:38464)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ja0ZJ-0002OD-45
 for qemu-devel@nongnu.org; Sat, 16 May 2020 13:25:49 -0400
Received: by mail-pf1-x444.google.com with SMTP id q8so792394pfu.5
 for <qemu-devel@nongnu.org>; Sat, 16 May 2020 10:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=MQuZWr48M3ssJYApkyVgMr2ePaUx57+QrviWYvaR2z4=;
 b=hti7TEfKHAbKJhA13mB+LzVz74bc290lVjtq8IybKQrOUaWg977FKOKlmYT8CKaMAb
 ptACP10W42tRswWtP/VAgd153MS68BQqIIQeXfloEph20uD1a4xmsz761XtYjDV724/S
 F4UjE7bRPYeUOCYoO6urDH1NudwWcS7tL4LXwzGPL3+tyGJKREq0+BhMzc5ynvrRfY4m
 E2B0VLcsFbYm/trqIPjkVXq3KZm4J7FLwB4Cl2BFiXNr0uuJ+bU9v0u5FZuU6pGw/B+/
 S9kLpjIz1FM4hg6pWxkBK/J++xy8b0QR+ufBZEv8MEd05fodlELVXs6Y4j/5hjhT+Mlg
 RDvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MQuZWr48M3ssJYApkyVgMr2ePaUx57+QrviWYvaR2z4=;
 b=je01knvDKo6PJg9JlsR1XV3XFkhrY4As9xQX9DiROY7UJx36Q7dadbdaCKwD2NPjEv
 UEZBKMf1x8BM8ABy4Ay9Lx7AX9EFLuwZQAuvkm3MrpST9fpNxVIQp7scV2/Y0vXEF/pO
 Gz4s8aC9OWcGhfTY1ckigxLabcr/6/2geQ5zmevJr3kSG5ACSJn+XAHOWKthgi48t0lA
 jqwpJGBU8Og4sjZ6in67UkCk45j3fSW7l5AbdFO8bvROh1o4uyuSdR2o51EzPnvg+hzm
 LDkQlCv+EmWtLQiIwicla9lK/bYplihby6TnLTPZQ/qOA4mXbxkue9oHmeo38xqSVI6J
 DRew==
X-Gm-Message-State: AOAM533f8Hoih2PSc9qgzQLW6ys9n6hdk+MzFJN6wjBmJg9qSlD5f6/P
 ELxQt8bkaXChCF+f70UdhRMVNA==
X-Google-Smtp-Source: ABdhPJwUq9f6VPYMa5A7W2ugIfsQvG4GnTdPb/v7AnEzCFlxhLMBufvx13XpGcdSWbxsymnPrBI9aw==
X-Received: by 2002:aa7:842b:: with SMTP id q11mr9209942pfn.302.1589649947225; 
 Sat, 16 May 2020 10:25:47 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id cc8sm4273989pjb.11.2020.05.16.10.25.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 16 May 2020 10:25:46 -0700 (PDT)
Subject: Re: [PATCH] linux-user/arm: Reset CPSR_E when entering a signal
 handler
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200507202429.1643202-1-amanieu@gmail.com>
 <CAFEAcA-n8-pOcwovsS1Z3T4AMa1Nueo2yik9zX5H16QAHeE05A@mail.gmail.com>
 <CA+y5pbSueV8HQKQEZnBS4DvOvMDXUY7HMaODNhY7v-fKkJJPYw@mail.gmail.com>
 <CAFEAcA8etD+V3KrCFwvqfDuZ0x4_cW-RN423WG13iVpJBRvq4g@mail.gmail.com>
 <47fd7f16-a7ed-e3ee-9a97-b2b21f43e7b7@linaro.org>
 <CAFEAcA_5_98BZfTbdLTR75w=qdOVVKra3eCM0YKX_gUEJSfkkw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6f45a4d8-844e-8c94-ebcd-af87d03c28d7@linaro.org>
Date: Sat, 16 May 2020 10:25:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_5_98BZfTbdLTR75w=qdOVVKra3eCM0YKX_gUEJSfkkw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Riku Voipio <riku.voipio@iki.fi>, qemu-arm <qemu-arm@nongnu.org>,
 Amanieu d'Antras <amanieu@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/16/20 5:58 AM, Peter Maydell wrote:
> On Sat, 16 May 2020 at 05:12, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 5/15/20 2:25 PM, Peter Maydell wrote:
>>>> You also need to call arm_rebuild_hflags() after modifying CPSR_E
>>>> otherwise the change doesn't take effect.
>>>
>>> Hmm. I was expecting cpsr_write() to take care of that if we
>>> updated a cpsr flag that was in the hflags, but it looks like
>>> the rebuild_hflags() is in the HELPER() wrapper but not in
>>> cpsr_write() itself. Richard, does anything go wrong if
>>> cpsr_write() proper does the hflags rebuild ?
>>
>> We wind up rebuilding hflags multiple times, is all.
>>
>> Most of the time we call cpsr_write we also do something else that also
>> requires a rebuild.  So we do it once after all updates.
> 
> The downside is that it leaves a trap which makes it really
> easy to introduce bugs where hflags aren't rebuilt: as
> a caller of cpsr_write() I don't really want to have to
> care which cpsr flags happen to be in the hflags or not,
> and it's particularly awkward that simply fixing which
> flags belong in CPSR_USER suddenly means that a call
> that happened to be OK before is now buggy.

I don't see any way around that.

As I said, if we put the rebuild in cpsr_write, then we should also rearrange
the code that calls cpsr_write to assume that's where the rebuild gets done.


r~

