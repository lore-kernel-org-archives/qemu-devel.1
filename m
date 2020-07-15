Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F11DC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 12:55:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46F3620657
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 12:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lG7Ucxar"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46F3620657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvgwI-0003SR-CR
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 08:55:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jvgvU-0002Ds-D9
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 08:54:20 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45134)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jvgvS-00010w-3w
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 08:54:20 -0400
Received: by mail-wr1-x444.google.com with SMTP id s10so2500842wrw.12
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 05:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ExZQwgE74aOpvlF71MWeblykUo7AVLqak5OcoZOwksk=;
 b=lG7Ucxarct+VRvfyOjD3PMVnYwZva5qSKrerSTvibzr9XFeMXZEIuPjdLwj0+I0c6/
 HdBGO5xIf2nwMHGJflDTVi0wGPniDtfRq/eYl6G/7XGidyHI+sTQWGUoycgega+iI4by
 yOTbVAiNRpnXvjzLPosdvKslYY3t2KA+NR+zkDBxgrS2jl+oyAWP6mWXLaKm42bxG5D5
 3lP2OFForB/i2mmT0f1MRpyoQxoXcckh8y7QTmsamprQLQxyjdnXS/PpZJuYLT9sCA7e
 QaGZHQ6a/GEHCA1J4KkIcspiAM6U7GEjQC1+gI/YVDnA+aF0V3CmPdgs0HJLpx6p/lO1
 ll3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ExZQwgE74aOpvlF71MWeblykUo7AVLqak5OcoZOwksk=;
 b=MH8gQBF+YpH3fwEf3D5xZlrX8hu7P4IgS+EPbdYh9tn/OCOxGPDPAQ7jHalYzc4DbK
 O1Hy2N8xl0Z2tB8Z9Vb7dIkaE61oRiVfBv08Vvwe5VZNnKsVKMac9b8UVnC37yKi+Yx3
 KcE+vmSxFWwMs/3xgit6JNAHEhCaB7FbkWqvqM7YSZ9JU0UkiRo2sSYLIGMBZBdl8RXg
 LmI1sws1wZMBK2JcNHU2jM0hVT8bqLMyU3t1lPN84a8Ilfo6K21vJG2SRj2emLpGXmB+
 sDW2wxqzsCthxcDqGCZPAFpBXUSuvs66V4XNGndBwvaO44gUEFLjJMmdSuJKC4pLIyj9
 8U1g==
X-Gm-Message-State: AOAM530XEIAKF0cQQ4C1cYk+VjEzIkSJyrGA/Ypz5c1iF4KKKcgV+MVI
 UM2zhknLvum85yYFPg4QqTWuwaCrnQM=
X-Google-Smtp-Source: ABdhPJwYpPHF52YkTCY9Ds8J4nS0pfNm5C7EdrQy5ZUnzcRvZ7ywj3GE9a2rroyKBH89CCJM1SyeBw==
X-Received: by 2002:adf:ed87:: with SMTP id c7mr10843573wro.422.1594817656282; 
 Wed, 15 Jul 2020 05:54:16 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id f17sm3582402wme.14.2020.07.15.05.54.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jul 2020 05:54:15 -0700 (PDT)
Subject: Re: [PULL 0/9] final misc fixes for 5.1-rc0
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200714095247.19573-1-alex.bennee@linaro.org>
 <CAFEAcA-4U-LAjcBPWQNrtfk=Kr2zsejHGYCzLWSoYq97_o9j8g@mail.gmail.com>
 <89543ebb-4c8d-64f6-f15a-e1736e683e22@amsat.org>
 <CAFEAcA9j7GDkKyChCsDo7=Qa8CGj7wRA_csSfV_nijs-bYV-gw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4f63a920-48d4-6135-a666-af80180299bd@amsat.org>
Date: Wed, 15 Jul 2020 14:54:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9j7GDkKyChCsDo7=Qa8CGj7wRA_csSfV_nijs-bYV-gw@mail.gmail.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/15/20 2:51 PM, Peter Maydell wrote:
> On Wed, 15 Jul 2020 at 13:29, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> What host/distrib are you using?
>>
>> I can not reproduce on aarch64 (Ubuntu 20.04 LTS) using:
>> gcc (Ubuntu 9.3.0-10ubuntu2) 9.3.0
> 
> Ubuntu 20.04 LTS (this is the aarch64.ci.qemu.org packet.net box
> you have access to).

Yes this is where I tested.

> Also Ubuntu 18.04.4 LTS aarch32 chroot on
> an aarch64 system.
> 
>> Any config in particular?
> 
> Nope, stock "configure" with no arguments. Incremental build, not
> from-clean.

OK, I tested from-clean (in case that helps Alex).

Thanks,

Phil.

