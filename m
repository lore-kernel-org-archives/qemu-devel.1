Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6641C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 05:42:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DE402075F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 05:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JfZbHNyi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DE402075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbHUs-0002Lo-Ol
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 01:42:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53244)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbHUC-0001tw-3U
 for qemu-devel@nongnu.org; Wed, 20 May 2020 01:41:48 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:34950)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbHUB-0006MY-5y
 for qemu-devel@nongnu.org; Wed, 20 May 2020 01:41:47 -0400
Received: by mail-pl1-x641.google.com with SMTP id q16so878327plr.2
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 22:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Tm2V5ZxWUrK0v5UBQ6qvSsoCs9g2MKmlmUNCVMclD98=;
 b=JfZbHNyihCUQW0/rKbafsNGkYtO9GBQt52neAZlhfL3Nu1eYe+YFCxrQoQaAZYRyfd
 KnbCHogdy2prntID/XcmYAt86i8WZsTApNzTuj6ALMF3fa2OCM7MnfCGahHEAFh6fHOW
 7ndj0u7sHpPvT3K3a3mvDy+b5YnJeecdYBU3zwIzrXvgCx6Cpqw/TIJIcU00KoR3gPfM
 7z7keufCEYYcH/fYl4pr0C/T7+qyEmrNdAPdx8iI/DsLRGauYKqPHiUiOx7fqOfb+Vlg
 JFjwt5b/9qgw8ePOi8a3IZOZQR6Qaa5naGuEPmONNTBtNamEmCQzuMPibRdCFPVEzFU/
 SWJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Tm2V5ZxWUrK0v5UBQ6qvSsoCs9g2MKmlmUNCVMclD98=;
 b=FlKnnwwRKCF3YFwqvH4w1j41bVyVHOSMI4PGJRjW0JriMf9mKG1jxs0Tqh7Yt6/PUB
 1/ivifrn5lqLD6jISVnTOUwhzdjBOfKyQnftay/0y+Q809cUr68hYUZofqej7C2Q51e/
 aVZ1YTMJeYEJqzcrTGlg7ABD8SVp+0mC9/e4BNfxsCwY1uUYCUrltBCC711d+0LJgqda
 wmRSXL5AdMrivQx5EvM2EDdgYoUYqqxnBu4u8wKmIkR5agDJ7vinjXJcH2x+HTyrv5pe
 3W1elEytFgqse2Il3WuM2ghCEe029XzK/8XOaW5QdBV9wXP5K9Vl7hffj/NyWkh0F6nO
 wRig==
X-Gm-Message-State: AOAM532rcyg4b3R9UNiCIGddvgYn9/3sxWD4CLlJnsjTBvzUr9Q/JTi7
 dOj64OM68PiXpuycbQL+HlIkuw==
X-Google-Smtp-Source: ABdhPJySIkayk6Ry1dzjMun6tBFnFe8IbmRe6XOhI146BJNItgeCkEHVSMSxO4tNUC5ZISJWcbRqWA==
X-Received: by 2002:a17:902:8496:: with SMTP id
 c22mr3019469plo.182.1589953305636; 
 Tue, 19 May 2020 22:41:45 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id u4sm4774103pjf.3.2020.05.19.22.41.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2020 22:41:45 -0700 (PDT)
Subject: Re: [RFC PATCH 2/8] riscv: Generate payload scripts
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, peter.maydell@linaro.org
References: <20200430072139.4602-1-zhiwei_liu@c-sky.com>
 <20200430072139.4602-3-zhiwei_liu@c-sky.com>
 <70ed74b9-83bb-c3ae-667a-bd74826acdd4@linaro.org>
 <047f591b-3c70-7ae8-8c2b-2a8ce2e41309@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <865aaf91-59da-09a3-438a-3230ff69d093@linaro.org>
Date: Tue, 19 May 2020 22:41:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <047f591b-3c70-7ae8-8c2b-2a8ce2e41309@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
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
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, wxy194768@alibaba-inc.com,
 wenmeng_zhang@c-sky.com, palmer@dabbelt.com, alistair23@gmail.com,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/19/20 7:37 PM, LIU Zhiwei wrote:
> On 2020/5/12 1:40, Richard Henderson wrote:
>> On 4/30/20 12:21 AM, LIU Zhiwei wrote:
>>> +    # sequence of li rd, 0x1234567887654321
>>> +    #
>>> +    #  0:   002471b7                lui     rd,0x247
>>> +    #  4:   8ad1819b                addiw   rd,rd,-1875
>>> +    #  8:   00c19193                slli    rd,rd,0xc
>>> +    #  c:   f1118193                addi    rd,rd,-239 # 0x246f11
>>> +    # 10:   00d19193                slli    rd,rd,0xd
>>> +    # 14:   d9518193                addi    rd,rd,-619
>>> +    # 18:   00e19193                slli    rd,rd,0xe
>>> +    # 1c:   32118193                addi    rd,rd,801
>> You don't really need to use addiw.  Removing that special case would really
>> simplify this.
> I think I don't get it. Do you mean that the immediate will not be 64 bit?

Well, mostly the immediate will be small, actually.  But the interface must
support 64-bit immediates.

I'm saying that for this computation,

	lui
	addi
	slli
	addi
	...

is the same.  You don't *have* to use addiw.


r~

