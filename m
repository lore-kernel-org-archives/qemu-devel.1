Return-Path: <SRS0=be0Y=DK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F62C4363D
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 09:50:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BC1D206C9
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 09:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sWdNuZoN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BC1D206C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOeB2-0000uC-EN
	for qemu-devel@archiver.kernel.org; Sat, 03 Oct 2020 05:50:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kOe9w-0000Mu-1W
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 05:48:56 -0400
Received: from mail-oo1-xc43.google.com ([2607:f8b0:4864:20::c43]:39358)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kOe9u-0001iz-26
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 05:48:55 -0400
Received: by mail-oo1-xc43.google.com with SMTP id c4so995127oou.6
 for <qemu-devel@nongnu.org>; Sat, 03 Oct 2020 02:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=reROD41lJiup6iZYSsuhFcjvbHAZP6Y8+IJM5pW4HeI=;
 b=sWdNuZoNp/SGC8O1o+gdEy3C5k23urEB1dAKsYNbDtYqBpmPE91qz4352lpPe14wGo
 Mjghe/3N7DZNefvUhoz4cGX092xo/HznXvL4fFclS1lB1/w1cIcyhQiCDbTcaBV4LN3R
 8JifkpLVgsGxtSvvCXK0J2h/7PWBL6nFzXnbBsbMT+So/no43D5TxYvFEGem6dDZr1Ut
 g+odFZH9QmiZiY/bgy1dXj/qXnIxY4BN1vZMnfU6ofwZDImCTr0XXN/JSrkO0NzFWwiC
 o2E5+E4aE57ASi0R094qVKCjKmichdgnY7+JPa8fU7Aj4l5JsrOzO12nkidNE5vOUXOM
 V3XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=reROD41lJiup6iZYSsuhFcjvbHAZP6Y8+IJM5pW4HeI=;
 b=bEb+CPf2qy1gC+yYmhSOOtKD/DEE+3A0aoB7rGwEbteCNqAuVWzwNnoERIajEVnD77
 4YTuj86JAswTvAP6l26HUGHkCLZPWQfQOniAoajGtMcoxBrpgqXRAywLHfJzZBdRBcjG
 hEhRGzaZx+KQgPKiDeNtI9UGBR6xorRLqLLJVEPdmtpuLqaP/VYvaWBUoHWNmIliwWCb
 gXOTj28c9W6Wj/+BNAqXHmKfjRr5s6k4dZMA2Ne3GedcwEZYN247kd3HnsfC8B+OmRUf
 kCQ4HWc4ho00xa0FkGj5neFzWySsW2k4Kbx7HyrdTfU5BNFZLmFvGKq136Lrh6AwBcAw
 +qFg==
X-Gm-Message-State: AOAM530Delt0P/jth1O3d2ceDowBQcNKOkunqAJgnkhvz0Z9icF8l2U3
 cGyfX5hAQTbr6eGs7R+dDwVFSg==
X-Google-Smtp-Source: ABdhPJx4UssWIUrC+FErQ3GDoZmOAg3dnXteUU8ca3qiO7110tjet5RiqpvMFtfazMzjUfQyFVWR6w==
X-Received: by 2002:a4a:c541:: with SMTP id j1mr5129157ooq.13.1601718532719;
 Sat, 03 Oct 2020 02:48:52 -0700 (PDT)
Received: from [10.10.73.179] (fixed-187-189-51-144.totalplay.net.
 [187.189.51.144])
 by smtp.gmail.com with ESMTPSA id m6sm1077388otm.76.2020.10.03.02.48.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Oct 2020 02:48:52 -0700 (PDT)
Subject: Re: [PATCH v4 09/12] target/arm: Make m_helper.c optional via
 CONFIG_ARM_V7M
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200929224355.1224017-1-philmd@redhat.com>
 <20200929224355.1224017-10-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d9af8896-efec-c850-655e-1d1eb2629762@linaro.org>
Date: Sat, 3 Oct 2020 04:48:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200929224355.1224017-10-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c43;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.256,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/29/20 5:43 PM, Philippe Mathieu-Daudé wrote:
> +arm_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('m_helper.c'), if_false: files('m_helper-stub.c'))
> +
>  arm_ss.add(zlib)
>  
>  arm_ss.add(when: 'CONFIG_TCG', if_true: files('arm-semi.c'))
> +arm_ss.add(when: 'CONFIG_TCG', if_false: files('m_helper-stub.c'))

I'm a bit surprised about adding the file twice.
Since ARM_V7M depends on TCG, isn't the second line redundant?


r~

