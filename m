Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598E6C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 15:40:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ECC22222D
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 15:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PbbJ3wcm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ECC22222D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIw1n-00063r-KR
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 11:40:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36054)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kIvv2-0006WN-Dp
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 11:33:56 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:46092)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kIvuw-0007SH-LN
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 11:33:55 -0400
Received: by mail-pf1-x444.google.com with SMTP id b124so1419582pfg.13
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 08:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=gzT4rpVgLlQznvuXLMgqlzQk0medGO7o37UVhPCFga8=;
 b=PbbJ3wcmUAxQ4Ybzb2aXk0ACOn5i5JWvchxhWrnad8/i2nM54eXsy66bfVAiSst5Qx
 I4fQu97TOtJZ16mtCGoVzUC85Z9geA6fqEf4zS8nRfsR6FQFa/mjzhyr3b8CDuvu/06G
 b/T/xr/7BdZTsQBM5UDs6vLOHN4MkXk7yisH7vQU1wu3q7c+l6OnZ9AopmE2lHAT+DoW
 LkTfBU8WL07zSkx5zSeaYIqXJzxmIkeVSyJp1uMTMLgdfx1jdKSQc5GFeLPc0r9LLMMD
 /9wZKQOX7/BBTlZQPxUixiRLQegROEabdLX4gew0E2ihWcn2R+KujckWELOM5FOfL2g8
 wfIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gzT4rpVgLlQznvuXLMgqlzQk0medGO7o37UVhPCFga8=;
 b=ejjAKIkb5lBmbSWW4ZkP5DXSJRZX4L3VQoseBJmqxDWz6fVSwZFdINexGwHaqoPIxJ
 1GmmnaA0EYd2Ixcyrm6niibPKvrdxXuLP2dDYtKbApuT5eBAt+HpiuislLUbOtytCVyz
 DJqGiiGTfDuJN6qu4rbJMWAxdF+2yoDX871Vbm7gvgpeH5wEu8k0U1M9aKnW8eeNDgcC
 nckcHBm0lNa2sOT6PRoOcssgUSkumEQCatqnRtej0v/6WkvuIPu6VyoX/guvdtdV+NFQ
 UtryDUZmp6sWiydPoV275/Xv9OF+LdhWbLye2fLdCwSOEn2BSWUAhWBS/CnXio0DZkgF
 LIhQ==
X-Gm-Message-State: AOAM533QiEPEp+Qe4a4GLqKXaXDXJ6J7XCH051oHYEoRfAv26zEtExqt
 qno50P/cPrbJJ1NBVT0+n0ATxQ==
X-Google-Smtp-Source: ABdhPJy/yvxlpGRIxOOSAea9oXGBb9WdgRwgF8EtyhgxHfXyDmr50oPI/xhpJ6xAWjtvKXH6VALpPg==
X-Received: by 2002:a63:e645:: with SMTP id p5mr22491016pgj.276.1600356827624; 
 Thu, 17 Sep 2020 08:33:47 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id a27sm20864367pfk.52.2020.09.17.08.33.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Sep 2020 08:33:46 -0700 (PDT)
Subject: Re: [PATCH v1] s390x/tcg: Implement MONITOR CALL
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20200917115447.10503-1-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <17b2cca5-f21d-1323-1003-3d9731a698cc@linaro.org>
Date: Thu, 17 Sep 2020 08:33:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200917115447.10503-1-david@redhat.com>
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
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/17/20 4:54 AM, David Hildenbrand wrote:
> Recent upstream Linux uses the MONITOR CALL instruction for things like
> BUG_ON() and WARN_ON(). We currently inject an operation exception when
> we hit a MONITOR CALL instruction - which is wrong, as the instruction
> is not glued to specific CPU features.
> 
> Doing a simple WARN_ON_ONCE() currently results in a panic:
>   [   18.162801] illegal operation: 0001 ilc:2 [#1] SMP
>   [   18.162889] Modules linked in:
>   [...]
>   [   18.165476] Kernel panic - not syncing: Fatal exception: panic_on_oops
> 
> With a proper implementation, we now get:
>   [   18.242754] ------------[ cut here ]------------
>   [   18.242855] WARNING: CPU: 7 PID: 1 at init/main.c:1534 [...]
>   [   18.242919] Modules linked in:
>   [...]
>   [   18.246262] ---[ end trace a420477d71dc97b4 ]---
>   [   18.259014] Freeing unused kernel memory: 4220K
> 
> To be able to translate it to a NOP easily, mangle the 16 monitor masks
> bits from the cr8 into the TB flags.

This is a rare situation that does not warrant the use of TB flags.  Better to
unconditionally call helper_monitor_event, and have the helper function test
the runtime value of cr8.  If the event is disabled, the helper simply returns.

It should be simpler to write, as well, not having to do this:

> +    /* Copy over the monitor mask bits (16) as two separate bytes. */
> +    byte = (env->cregs[8] & CR8_MONITOR_MASK) >> 8;
> +    *flags |= (uint32_t)byte << FLAG_SHIFT_MM0_7;
> +    byte = env->cregs[8] & CR8_MONITOR_MASK;
> +    *flags |= (uint32_t)byte << FLAG_SHIFT_MM8_15;
> +
> +    QEMU_BUILD_BUG_ON((FLAG_MASK_AFP | FLAG_MASK_VECTOR | FLAG_MASK_MM0_7 |
> +                       FLAG_MASK_MM8_15) & FLAG_MASK_PSW);


r~

