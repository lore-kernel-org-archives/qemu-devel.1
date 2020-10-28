Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 941E2C388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 17:00:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E875B247CC
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 17:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bGZMD0Dc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E875B247CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXoof-0005yl-AR
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 13:00:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39884)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kXocW-0007kg-FH
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 12:48:20 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:43573)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kXocU-00026V-Ab
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 12:48:20 -0400
Received: by mail-pl1-x641.google.com with SMTP id o9so2751372plx.10
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 09:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=GRkJ6ewUhlRgRtdm7clVBC/5/nY3C+Wa4vVmYnkeyHA=;
 b=bGZMD0DcaQe5jnPacKfpj+3N7ub4ZY0e7qdTt8TC9o+VgGJE6OuyBX/dYTTxuUAogu
 rnRNC4/hUa7fYMbOukmKSYsn5k9USJ1N+TGSYEszbu8uQIAFlxLRK6yYLC9UTDTZ+nAQ
 +fLHOCYTAqCUCz/NeMZ5ULBUnCAPKIG6K9Oosd7kT0Aw+uVqiFKKM2qYLQbCU/XeEfh9
 HWqFSznnGFbJy/78nGkPyWZ4cWHcUZc2mm1tHhrHuMhH4zgZwx5sQALA9acTlTf7Z67s
 g7p+KJJgSfLjS21Vwzz4RVUmL0EQ84FobZhV6AtPQEuWb+pdDaKtoF6PCEXq4b+cyCWS
 Nm8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GRkJ6ewUhlRgRtdm7clVBC/5/nY3C+Wa4vVmYnkeyHA=;
 b=MHB2wWWMrQmCcIYYMSEwA+Rtso5m9PL+5UB3uBXa118Y8LBSHoA1oTdImhn6b74kUc
 eJFAix0QJEFIRVx/CDL/fHjP7gm0VXKzv8WJI/JCZdhslQUy0r1/G2adZQKqxxmBuJV4
 ow+p5G8K8flLQpnE4V6gF9vgBIBeCayCfKg0VM6Nhr43md0esaOObWAAb1ApgbWritNI
 Uw+S2I9j2q7jElzJ1+zKgggb5uebaflwf9GxDfVbHY80OWkbcpqCQ6bRccAKKmPNgUTA
 HkJ9dSJDdmzMDjklkWSXaWnQLKgklGzdb+oskdLmL9q1MkcPj221mHEs5D5V2n5Q3bz4
 sT0Q==
X-Gm-Message-State: AOAM531DEUZZhatwMF5qnEEJW7+y9gjEE1VgwO2FtkRsswErsh0pHPZf
 aCUJOhE4HnMPJ2O+D1gejVzN8A==
X-Google-Smtp-Source: ABdhPJzQYRtrHrssIYRGVXE7HuReeaZL0MArak82qutCXzj40sM0mVrwe1gUIaFmJ3wD/HD2JW1xsg==
X-Received: by 2002:a17:902:c412:b029:d6:2939:1b75 with SMTP id
 k18-20020a170902c412b02900d629391b75mr8496330plk.80.1603903696944; 
 Wed, 28 Oct 2020 09:48:16 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id u13sm114626pfl.162.2020.10.28.09.48.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2020 09:48:16 -0700 (PDT)
Subject: Re: [PATCH V15 1/6] target/mips: Fix PageMask with variable page size
To: Huacai Chen <zltjiangshi@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
References: <1603858685-30701-1-git-send-email-chenhc@lemote.com>
 <1603858685-30701-2-git-send-email-chenhc@lemote.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <11b935d9-e701-099d-1082-adb0613116d5@linaro.org>
Date: Wed, 28 Oct 2020 09:48:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1603858685-30701-2-git-send-email-chenhc@lemote.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.921,
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
 Huacai Chen <chenhuacai@gmail.com>, qemu-devel@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhc@lemote.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/27/20 9:17 PM, Huacai Chen wrote:
> +invalid:
> +    /*
> +     * When invalid, ensure the value is bigger than or equal to
> +     * the minimal but smaller than or equal to the maxium.
> +     */
> +    maskbits = MIN(16, MAX(maskbits, TARGET_PAGE_BITS - 12));
> +    env->CP0_PageMask = ((1 << (16 + 1)) - 1) << CP0PM_MASK;

maskbits is unused.  Did you mean to use it?


r~

