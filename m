Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57128C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 16:53:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B57920767
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 16:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hl30c5Na"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B57920767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDW0Z-0003AU-52
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 12:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42330)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDVzx-0002W0-Jh
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 12:52:37 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:38564)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDVzv-0007Ij-Jl
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 12:52:37 -0400
Received: by mail-pl1-x641.google.com with SMTP id t11so31049plr.5
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 09:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=1ZNGVwocjGG86+ARDHEM4T3GOQbrr8lQiGUBxbtB6Ds=;
 b=Hl30c5NaCIjur0JBfH5z8AWqWJ428T++ABRG0CmRxKiIkrISBSubHNLimuAmiv/oPt
 Id9BUjrzgeSavBcVjO7aNARjZ8QQA8CDmLKBkLb4SSokKSemN2KQTqbsQ5RGHNFwoUfd
 4tky8uQmrM0q4ll8Fk6pMXvBLCIS0qkjwxitr3vht6ZErzoWyS3sv/8yjBSJaGYa+3jK
 hRk7tYWgMlZJ+sv83vK2hXGp1eQp5t5hAkP2Hn574a+dO7KG05qJ6Ji5uT6dNvaqHpsh
 dR09VJY9itN6moArN1QB5b/pOfMeFyWjTouggYJ56ND79aojXGQpIQrnsXySQRQuhFSR
 JX9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1ZNGVwocjGG86+ARDHEM4T3GOQbrr8lQiGUBxbtB6Ds=;
 b=hh10zH4ftvfsbg0XcWnZWxHGJNDh6vikGC4uKi+jS7e9IHI5De8jRLe8wc0LrUyHKl
 fGLZ+qchxUHhKM9Vfw/CrZDGEK/0MEQQu/OUtuzE5KmYUFIzLrjhVf9K7vUsBTTpmiC4
 6IejqThYkqy3dHXPovVjQl9Si8URwvzeFxfYbAwD+RZGU1LzFkKsZ2811hoX14Ge7MoP
 X4Cru+abvjcEzypgjNdvZqJZHFVzKpYog+sd/du5ngtdvo+u38uqtcJBKUMRgqV1VluU
 08Wm/xoUEGKuGVRksJLfEvvbK47OF0J8o0CSj697DugcdqLRA6R1y/WzF0/b9xtO511S
 Vndw==
X-Gm-Message-State: AOAM531zy6/qOp+jhM43M8WfHjNwCcoZ4fQJuTMEbyfFS+j4GlA121ef
 BBlb/hdGQxcvKkuHqW1WegrMaA==
X-Google-Smtp-Source: ABdhPJw0vbO8CAaLXWcD5l7Ag92YdaTDLZldmrjlJnNDpQEaVCZppF9YCvtQ7I7sX1K//+bnuSRbqg==
X-Received: by 2002:a17:90a:e16:: with SMTP id
 v22mr3066111pje.124.1599065554066; 
 Wed, 02 Sep 2020 09:52:34 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id z127sm16156pfc.113.2020.09.02.09.52.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2020 09:52:33 -0700 (PDT)
Subject: Re: [PATCH 2/7] hw/hppa: Make number of TLB and BTLB entries
 configurable
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
References: <20200901183452.24967-1-deller@gmx.de>
 <20200901183452.24967-3-deller@gmx.de>
 <e4627473-3272-59e7-a8b6-0f223e69b198@linaro.org>
 <162b573e-75d1-048b-4413-124e463c0942@gmx.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9c5f04c8-7312-4af2-c3c1-de8edc877bbb@linaro.org>
Date: Wed, 2 Sep 2020 09:52:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <162b573e-75d1-048b-4413-124e463c0942@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.324,
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
Cc: Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/2/20 4:16 AM, Helge Deller wrote:
>>> +    val = cpu_to_le64(HPPA_TLB_ENTRIES);
>>
>> I guess you don't have a cpu structure here against which you could apply
>> ARRAY_SIZE?
> 
> You mean to calculate the number of TLB entries based on the static size
> of an array, e.g. ARRAY_SIZE(struct CPUHPPAState.tlb[256]) ?
> I've replaced it intentionally by a constant, because in a follow-up
> patch to improve the TLB-lookup speed, the array gets replaced by a GTree.

Ok.

>> The indented defines are weird.
> 
> How/Why?

Because usually the # is at column 1.


r~

