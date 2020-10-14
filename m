Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 971A2C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 21:51:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E053E21D81
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 21:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xDqdz9TY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E053E21D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSogB-0001Pf-FN
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 17:51:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kSoeO-0000TA-Qe
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 17:49:36 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:39065)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kSoeM-0003PC-CL
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 17:49:36 -0400
Received: by mail-pj1-x1042.google.com with SMTP id gv6so541490pjb.4
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 14:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=RazYZMFTaLHcCa5zzN/JC7OnxCch7q/fcqP4Ca6Lt1o=;
 b=xDqdz9TYn7IkqV58iHOlcZByD20N9xuj2TKYBvGB4Qkk6pRKyS/XAd+qdav57mZWs6
 Ou++rRcKMlCxOfvudK0ktXqLta6bw4Azgux5qfysWSSLm0zHaZmbvZNqy4NqaEs4CBXd
 bKgZEy/6nARf7FO3rTm+6ZIOUYr7LOwj0CKsEPQ1+ZOfAgRs446Ld/vvjY+MGvVNYY/0
 Ch9Kd80sTx+OrCwX7wY0H2xnwUeKLgr3bpmEqo4MktymqMm7pCJUzpJmiooAy0yadmp2
 7Uc9UAs9rgjttzVuNoH265TpsLNblM0WxOux7bevgOzTQrkvZEnj6TUYXVPMPMGb78Rb
 JTZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RazYZMFTaLHcCa5zzN/JC7OnxCch7q/fcqP4Ca6Lt1o=;
 b=b1LY5ibu9FJFfquq59lMcs9fRzRCnaSym0pvYvZ4oevpa/7WM6fDT8EVKz1F00fhrN
 4nSOiHK3PmY7DioiSdNUrkqF/hhPL/JBh8zreifi0a/JPjOsEYZbq2SkAmvmWnZ/0Zfe
 kAQZw75AEg9E+J1i8mBjiBZ7RseVjSU4r/uZHTPYTzqZa6/tnQYh8yjvoDKxyo6bivzw
 7R4wxLIlOUPdsFB+nOFxsoZmr/I6axLUsXInYJW2IaL1fkd8VCe+sMy0Vgm4AobSa9RZ
 gQ+IxOxtxO/pM/7ulGK9lbD1xxJYLkZpHgk1/IZSDcYpnNsaKsputbsgPeTTth7693h5
 UHOQ==
X-Gm-Message-State: AOAM531IZKlXNtt1IfQ7dMM12sSaBvEbmNPvJYUyPJP5wpjWUhoPlZ/c
 Y57qXagacwcb4wTmIwtIVwlInbC7dGHd8Q==
X-Google-Smtp-Source: ABdhPJwcArP4kim5F9a5vty2DLpFac72Ofgjw2HHW2jrYevrpk95hAXPGLYVlaNocl8Lmza6XgZzbg==
X-Received: by 2002:a17:90a:f698:: with SMTP id
 cl24mr1121040pjb.59.1602712171375; 
 Wed, 14 Oct 2020 14:49:31 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id nm11sm516238pjb.24.2020.10.14.14.49.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2020 14:49:30 -0700 (PDT)
Subject: Re: [PATCH 07/10] tcg: implement bulletproof JIT
To: Joelle van Dyne <j@getutm.app>
References: <20201012232939.48481-1-j@getutm.app>
 <20201012232939.48481-8-j@getutm.app>
 <19c387d2-fc9-d1d0-849c-f8e8e270a97c@eik.bme.hu>
 <CADmqK1sTLy8O58rVR116VJnAK2qYMLQvX2wYxpcix_1YkFvLug@mail.gmail.com>
 <2ab5b15f-2372-9531-4ade-50dc12592d6c@linaro.org>
 <CA+E+eSCUdR5tUT5x90iQ-h3cTiS4u=6MnfrGsP0Pj=F75FsnKA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <05c6cd7d-aa9f-ddea-cc04-2db5aa3110a0@linaro.org>
Date: Wed, 14 Oct 2020 14:49:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CA+E+eSCUdR5tUT5x90iQ-h3cTiS4u=6MnfrGsP0Pj=F75FsnKA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/14/20 1:58 PM, Joelle van Dyne wrote:
> Much of the code that uses the macro is like the following (from
> aarch64/tcg-include.inc.c)
> 
>         *TCG_CODE_PTR_RW(s, code_ptr) =
>             deposit32(*TCG_CODE_PTR_RW(s, code_ptr), 0, 26, offset);
> 
> Before the change, it was just *code_ptr. I'm saying the alternative
> was to have to write "tcg_insn_unit *rw_code_ptr = (tcg_insn_unit
> *)TCG_CODE_PTR_RW(s, code_ptr)" everywhere or else inline cast it.
> Whereas making it return tcg_insn_unit * means only three instances of
> casting to uint8_t *. Using void * means casting at every instance.

I should have done more than skim, I suppose.

Well, without going back to look, how many of these are there, really?
Virtually all of the writes should be via tcg_out32().

If there's < 5 of the above per tcg/foo/ -- particularly if they're all
restricted to relocations as in the above -- then I'm ok with local variable
assignment to "rw_ptr".  Especially since the replacement isn't exactly small,
and you're having to split to two separate lines anyway.

I'll have a real look when you've split this into parts, because otherwise it's
just too big.


r~

