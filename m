Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8B6C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 23:09:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F3B4223EA
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 23:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CGPzOM2H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F3B4223EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka5Qf-0008O6-8n
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 18:09:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49050)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ka5Pv-0007w1-Rx
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 18:08:43 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429]:43752)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ka5Pr-0002E1-MB
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 18:08:43 -0500
Received: by mail-pf1-x429.google.com with SMTP id z3so237499pfb.10
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 15:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=vTF5LR4J9ibQVZ3XjZSKBn6FJiD2hbzdbedy9KBRYRo=;
 b=CGPzOM2Huc57nYVbHj+//3Ro8PGWtQcCuW8wRUrzlimcMxyJt2DGN08UaCNjn/7fQX
 0mjaEAYKUO+NnoyTspNykJo2nK9Enrdo8Zd2xR4fjY44EaLrhMVV1ZmfPV/g3XYtdDdR
 L6orhPlTtnfhB8AzJLDb16DiJPRyvcsymrZyBQhyk66bbcOEtZMZ5wGmqKqrGgZT0oYm
 WYDLzW02sSiDM0eoKN7y7I5sG46Wj60vpgawHk1BETOi1rWqpbqwIOhHL0LeYBf/6tf1
 DHdH7Nvz943Czu/lVOzdneBIIiYpdINZxRDV5i6UJ0rvss6rwY04MevK7uH+OOZ1UwxP
 etyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vTF5LR4J9ibQVZ3XjZSKBn6FJiD2hbzdbedy9KBRYRo=;
 b=bMsN9OhXlOCxTwTsJdqX0JRxZTLzQfb80Wy1iiJEB9jd+D6Fjtwqmt3AIj4iM0MqWs
 znJGsQ8t6hfOjSUKiTDS4v2z+DrwKV17mUC7bB6GsyoBaWTAnWNFv+jOmEnOBFXw1dVl
 jMZ+yVnfYU3wCSOapRKlDATZUvThFO/+S3gSJ4lfW1QzgiY/FgEJ8kRm45bAIt7mf769
 cRXhAy9dauQhDS1UuDSFr3yMKw8kC9LlovPHH5q+vAmuZp3N1AGBCkqOx10up76iqbjO
 VhuMcD8p4IFVap15LFNXti3gcSnY1c10Eu8uxl0V3KoW2d4HWQyq6j/YpdNn9u6VAAjh
 fN8A==
X-Gm-Message-State: AOAM532x/Q340wtdRqANIro9yUg7e79Tg22WopOax8CUDxQEMtKmJyjg
 EdeboTujCaO2f8q7EDq9qf89OM1afx3EyQ==
X-Google-Smtp-Source: ABdhPJy5QGUY85DF6YX0+CkkrFxvopZKkgnMultkiEGJ3KlQLMg5b7oV/KgaXT8GntNgkEAe4bqVYg==
X-Received: by 2002:a17:90a:fb4e:: with SMTP id
 iq14mr1590749pjb.68.1604444917109; 
 Tue, 03 Nov 2020 15:08:37 -0800 (PST)
Received: from [172.16.1.221] (76-14-210-194.or.wavecable.com. [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id gw10sm196493pjb.24.2020.11.03.15.08.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2020 15:08:36 -0800 (PST)
Subject: Re: [PATCH v2 18/19] tcg/aarch64: Implement flush_idcache_range
 manually
To: Joelle van Dyne <j@getutm.app>
References: <20201030004921.721096-1-richard.henderson@linaro.org>
 <20201030004921.721096-19-richard.henderson@linaro.org>
 <CA+E+eSB64cm8GPsuEYNQJLkF2gPiF2oueYPOOTtxpYy7hWzTRg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b5136404-3423-cdfb-0979-aa544c704163@linaro.org>
Date: Tue, 3 Nov 2020 15:08:34 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CA+E+eSB64cm8GPsuEYNQJLkF2gPiF2oueYPOOTtxpYy7hWzTRg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/31/20 6:25 PM, Joelle van Dyne wrote:
> Unfortunately this crashes on iOS/Apple Silicon macOS.
> 
> (lldb) bt
> * thread #19, stop reason = EXC_BAD_INSTRUCTION (code=1, subcode=0xd53b002a)
>   * frame #0: 0x00000001169501e0
> libqemu-x86_64-softmmu.utm.dylib`tcg_prologue_init + 760
> ...
> (lldb) x/i 0x00000001169501e0
> ->  0x1169501e0: 0xd53b002a   mrs    x10, CTR_EL0

That is *really* annoying.  Why in the world would Apple not set SCTLR_ELx.UCT?
 There's nothing that the OS can do better than the application for ARMv8.0-A.

Oh well.  I'll paste your code in.


r~

