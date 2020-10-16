Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1778C43457
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 17:25:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B53720789
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 17:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z3QDvapS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B53720789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTTU7-0007sv-06
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 13:25:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37490)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kTTNo-0001e8-Tx
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 13:19:13 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:42096)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kTTNh-0008ET-Qw
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 13:19:12 -0400
Received: by mail-pf1-x444.google.com with SMTP id x13so1856843pfa.9
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 10:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=xElUmhXNnSp7AFdkOLEgmMqLfxiXtNHwYnSUYtENJ9o=;
 b=Z3QDvapSVrpJqCQ/VO85iZgCaIqVOvPnl7LZy+Ro9EpeH3ckZWcGP9vfyLZRw5LPIT
 tLDoW7al8aSimy4No89wd2C+c/f0aqu6T+0A0+KCkYqo9sHYQvIQMBkfCTO3S+ynDbS+
 a6BQXJmMRddrVcHSycGQW33ADHeKCwCnnyV40vFbs6aq37fnqNBbSzO/tff3WJ38fWnW
 SWOMy/CISR3m5UD+9cX0GaaO+uwj9o0ole3kHn21S6QqpCIvaenaOEv+LH559FV0Y+rU
 Rwm3Aiq/yM2bq+hfV+zn/tieqk/T/Iao2ICA9u4i9MViD/JOr2k1x7cG0D+LbKYCJsAK
 kahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xElUmhXNnSp7AFdkOLEgmMqLfxiXtNHwYnSUYtENJ9o=;
 b=FpDEK7+vtE0baULzl73rm8Leb/hImPj17HkBOXI4KiJFYUDKHpamkEGbW5rutqRI9b
 Q5KG46Ca3kLx1BATOatF9m+VRhCDJrWxTwiIDWlslxAGc5KS0rFQkUIEkstJ2ZI1i3oo
 /R+087d/E35mlu9KiuvHlF9cKtgF/lIF5FA3LBRe5QRA9qC4s/ntMszaNTdSbjZc6tgd
 wKx907aCbvpSkwYggVGazxP58B//u/o7xPYppdAISw0kwRM0EtVT3//ZylZI/4+sB7Nf
 jK0MIuEdsh3HifLcJ5nDAJwODlLh1IixLtAnWpyRHFZpU6YS1lwx7UAMrnkieNaeLdWp
 8Afg==
X-Gm-Message-State: AOAM530rYYT/JACs9j5diYKn7p8OONfbUKY//bl665dLnb2ajHkXe3Hf
 whHUvkVST4vUaAxktaVISpSI6Q==
X-Google-Smtp-Source: ABdhPJzyblGiy9591jB3R9O1dJmtCy/hyIKmIf7e6i1k5AJA+j6Bqm8GfAvnr7aDWjjGmw6WD5gGdA==
X-Received: by 2002:a62:4e05:0:b029:156:6a80:2686 with SMTP id
 c5-20020a624e050000b02901566a802686mr4478680pfb.61.1602868743717; 
 Fri, 16 Oct 2020 10:19:03 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id ch21sm3559531pjb.24.2020.10.16.10.19.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2020 10:19:02 -0700 (PDT)
Subject: Re: [RFC PATCH 0/3] target/mips: Make the number of TLB entries a CPU
 property
To: "Victor Kamensky (kamensky)" <kamensky@cisco.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Richard Henderson <rth@twiddle.net>
References: <20201013132535.3599453-1-f4bug@amsat.org>
 <BYAPR11MB30479E5264D94EF903E9FD92CD040@BYAPR11MB3047.namprd11.prod.outlook.com>
 <515ec755fd8d7219040283f0c27346d762ee3c29.camel@linuxfoundation.org>
 <ea0ed6c7-1e3a-f7ee-a962-b471555e362d@amsat.org>
 <BYAPR11MB30471BC8B9D3B5F3E678F547CD050@BYAPR11MB3047.namprd11.prod.outlook.com>
 <CAMKF1sokbfu1ox+nnZe0nJLid5_GnzZUeQEfWDmqmS4LY-RqNg@mail.gmail.com>
 <BYAPR11MB30471A05FF44CF5F7C4C9A29CD020@BYAPR11MB3047.namprd11.prod.outlook.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <570801b3-ce5a-682a-334d-73404e418f3d@linaro.org>
Date: Fri, 16 Oct 2020 10:19:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BYAPR11MB30471A05FF44CF5F7C4C9A29CD020@BYAPR11MB3047.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.253,
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Khem Raj <raj.khem@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Richard Purdie <richard.purdie@linuxfoundation.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/15/20 11:56 AM, Victor Kamensky (kamensky) via wrote:
> Is possible to come back to 34Kf route, doing
> very small localized very well defined change
> of bumping TLBs number for model that we know
> works well for us?

Yes, thanks for testing.

I think we should also add a property to enable Config3.PM for any cpu, and see
how that gets on.  But simply adjusting the number of tlb entries is a good
start, and is the only thing that will work for older kernels.


r~

