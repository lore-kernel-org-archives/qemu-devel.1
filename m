Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D614BC433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 22:02:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2B3C212CC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 22:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lfW7yKwN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2B3C212CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSoqZ-0005dz-I3
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 18:02:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44898)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kSopc-0005Ay-TT
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 18:01:13 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:42028)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kSopa-000500-Ue
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 18:01:12 -0400
Received: by mail-pg1-x544.google.com with SMTP id n9so494188pgf.9
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 15:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=OCXZh73OA5T3jNOQtD6dspfjOgFA13c+ecn55BzYfCg=;
 b=lfW7yKwNUSt2C96jqe7BBFlzFkAheeMl09t4pDHJr/2ROsyqUtFL0mwJFrQ3j3fXSx
 7SIJlmW+Z4IhCoUSX03gX4tf76clUgMTUKkMGU7PHJ/2Zn0v+KnDI5xovPtWVvw2hyvi
 pWi6MP14c7vTVQ5aL12nUARMFj7EILnDb8Ul0MtTdxMniQEy4qWEv9WL0vLLK7UWEe3Q
 8VikfAz6GgSsiM0zydjP3AXmejDb2s6RN4a2RvDklN1hVUs/4IyH5TWiDaT49aU74Z9k
 gH/qWwB5Ee4hoUTyddQX9DiGYz09jqnZChZ5YjkQybuLzA6+YnVKE9xfYhwzCnaDgZye
 SRsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OCXZh73OA5T3jNOQtD6dspfjOgFA13c+ecn55BzYfCg=;
 b=Xum4Z94REfNvpCX3rz/5VVWPdMG+h/R0QTFzivDg7Wj8LilXy0n+4XWhZ9kxCyCWMh
 S5n6TF9WjlctDAz9j+ckpvjMaIOhVuFxjt4vk9/heqDnmfRg01c4U6QmR7iIleR0YIuE
 UIynXiiA43qQOEZmgKaGe2wAoOhLUnB7f+EiwFKkxFZB9cTrB4dLcP2sviJ2UO1MhM8y
 lYlGBTArpIM4dFWTgaTG1mcgPLcMJMqgl3abpjdGO4zCuyiSqsNNBjtieblA3A1IyRh1
 7HDJKo1SdfxJUEshOBdhH4R6jLYaOioHvSjV8Uw2QXcESU0P2yEJMM0krnkEyEZCuJEE
 vnVw==
X-Gm-Message-State: AOAM5321NJbWOmeXAkKKiPIVPW5P0Krw6bcCrLRxnFlsWLpIcF+0xKap
 V21AImZm8Oqp88LNmzNkfAVA/R5kC7Lpyw==
X-Google-Smtp-Source: ABdhPJzl3WlX3hy4xvQutTKSFcdDfar8Ai+9gss9lqbZMUJoCTMXJeY78E2wEMwmU0PbCSAv1vqG2w==
X-Received: by 2002:a65:5c85:: with SMTP id a5mr819771pgt.145.1602712868746;
 Wed, 14 Oct 2020 15:01:08 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id s8sm552022pjl.41.2020.10.14.15.01.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2020 15:01:07 -0700 (PDT)
Subject: Re: [PATCH] Changes to support booting NetBSD/alpha
To: Jason Thorpe <thorpej@me.com>, qemu-devel@nongnu.org
References: <20201007032417.26044-1-thorpej@me.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f9c924f8-b315-7870-0325-eef055a3b84c@linaro.org>
Date: Wed, 14 Oct 2020 15:01:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201007032417.26044-1-thorpej@me.com>
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/6/20 8:24 PM, Jason Thorpe wrote:
> Along with the previous patch set for qemu-palcode, these changes
> allow NetBSD/alpha to run in qemu-system-alpha.
> 
> - Allow a the minimum PCI device number to be passed to typhoon_init().
>   Use this to specify a minimum PCI device number of 1 in the Clipper
>   system emulation, since that's the lowest PCI device number with
>   valid interrupt mappings on that system.
> - Instead of passing just the CPU count in trap_arg2, also pass other
>   configuration information.  Define the first config bit (bit 6) to
>   reflect the "-nographic" option; PALcode will use this to initialize
>   the Console Terminal Block to specify serial console.
> - Attach a minimal i82378 SIO PCI node; some operating systems won't
>   scan for ISA devices unless a PCI-ISA bridge is detected.  Real hardware
>   would have had a Cypress or ALI bridge, but many Alpha models shipped
>   with a i82378, and most operating sytems are not picky about the specific
>   model.
> - Modify the mc146818rtc emulation to ensure the timer is started as soon
>   as the device is realized, and update the PF bit in REG_C even if it is
>   not going to result in raising an interrupt, as the real hardware does.
> 

This will have to be split up -- again, essentially by bullet point -- but it
looks reasonable enough.

You need to mind CODING_STYLE.  Run your patches through
./scripts/checkpatch.pl for a rough guide.


r~

