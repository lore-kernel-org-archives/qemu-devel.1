Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47EF9C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 23:12:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0EA7221F0
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 23:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R2X8RRrz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0EA7221F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGsDg-0006Hx-Mo
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 19:12:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56934)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kGsCK-000569-CJ
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 19:11:16 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:35035)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kGsCI-0003Pc-QX
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 19:11:16 -0400
Received: by mail-pj1-x1042.google.com with SMTP id jw11so2389220pjb.0
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 16:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=dpK9AoKJ2suv9yl/2HoHjmNCcdsx0/cMNHnvymyu6v8=;
 b=R2X8RRrzLkyUR19BYKntm/0IZCdZLY1OMpRff82fJvt95/JDXjzjW+DHB2nC2RoE5C
 IU6oZelEmtsNryHGxyAe5ms24l7tdz3wkPBle7axbyt9lEVIokn2wmXUHthSQwDwTlOG
 SiFtyokilygrP8uqL1G510CkatO+k1oOyOfYlpBUNCoOaQSkE7T79mNzyyxhdjZaSysy
 SqHqvpqGC0xQg/0LxaMtp2NXLIZQdxm7FgpnlyFk9iRgOFbSNfBsl1NbuDGq+tRXvIPp
 pa3T2TqYaCdGt4B17vMHDSbMPHKPcCrp5Vl17G8Cm4lu4m7etMUApKTTRUmGpltLCwQA
 IPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dpK9AoKJ2suv9yl/2HoHjmNCcdsx0/cMNHnvymyu6v8=;
 b=f6HwO5BDYk81n2yX+G82GHUVZai5fH/48LgvsG96q22lxlgK8J86NGH0W3LwDQTkmB
 rI5fsbRz4784tvPsFC32Z9Yf1pGov0RxoFGLzeW3gBuxcsEoNMX7cBfPEuyvZRqsiukF
 u61MYdSLkbdvBhsuQ13kjIBQMfUTjX1RaApRTvlnkoZo84BoDFVqr4eUDG/6GKpPc73S
 eUK231xONiY11aqtExRilKgBt3m6akQ03RtOywwfBK/vdCX/n5aUPKkZb7n+kKR1/lVw
 vRC5X8P3G7uJectsnt2vJ5HcPQOYjNiEaWORTpbWPL7J7lVXF7n9qg4jamZ5aAoqxKOC
 sZhw==
X-Gm-Message-State: AOAM532KsuzaxFYdHKru38Bx1wC2Kt8tEGXYwR0aL0H3qYtxtrwmYKni
 2QtKTT6GHp2MoQ7z+8LjDJnuAzIX1YW0IA==
X-Google-Smtp-Source: ABdhPJzJhxyo5Pwv4MAddpsvsNnHWi8+BnTb+n5ykCJ6x8GYG7kOG4DKjSMASoOdac+T48xwEr6gUw==
X-Received: by 2002:a17:90a:ad48:: with SMTP id
 w8mr4201855pjv.179.1599865873617; 
 Fri, 11 Sep 2020 16:11:13 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id p190sm3394180pfp.9.2020.09.11.16.11.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2020 16:11:12 -0700 (PDT)
Subject: Re: [PATCH 6/7] hw/char/serial-isa: Alias QDEV properties from
 generic serial object
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200907015535.827885-1-f4bug@amsat.org>
 <20200907015535.827885-7-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <dbd702de-6f44-7bfb-3877-2b99d2e4194c@linaro.org>
Date: Fri, 11 Sep 2020 16:11:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200907015535.827885-7-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.469,
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/6/20 6:55 PM, Philippe Mathieu-Daudé wrote:
> Instead of overwritting the properties of the generic 'state'
> object, alias them.
> Note we can now propagate the "baudbase" property.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/char/serial-isa.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


