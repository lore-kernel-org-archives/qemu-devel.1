Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE33CC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 16:51:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3089C20789
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 16:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EuBlH1Dm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3089C20789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcAOc-0003Y1-6T
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 11:51:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55714)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kcANS-0002HV-AV
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 11:50:46 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:43106)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kcANQ-0000vv-Aw
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 11:50:45 -0500
Received: by mail-pg1-x543.google.com with SMTP id r10so7608008pgb.10
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 08:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=CbdVUbeS87dK0zuV4z7dwRbBptT1fvdw2b17hfW8UkI=;
 b=EuBlH1Dmkf81SennINRUKmaW8334vD5o4uUMck8ljzRJUHzmpZK0f0rScr13kD/3Ig
 qU6+Z8/waFNgY8Qr8OkUQt0KtIZ8WQpb2wm3Iv7iQ6wJUScujWQS4eqVD5ZRmH/PjwVI
 Fi4w8t4gjnfP6m54AlQxhMQ1ZzVKierlaViyDNq7MlV4veeFu2OCCf5YkZdjLP5seyG3
 f1Wmjdn9PgzJjf00w7eO5N/VhNs9RLKm9UI4Ae53Dp1hoFOu8VX9Q1vTsIa6AwFQDfkz
 R/wfJRiDn+xHMR+bJDSPbZar5YFUrvdDxvQiUdfDjq+l1zTskYRMpTQAJzJDrP02Qq0A
 IgFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CbdVUbeS87dK0zuV4z7dwRbBptT1fvdw2b17hfW8UkI=;
 b=gXREekAXM8ovT/PO0josOVbeXfzkdzvdQNuZEB+rlf7Apxouonp2kgYhYDVsNIxVQb
 C10Jaxfs0RhX2X33R5hE80wXNF+MH//C0kIWVFgoG58sLV9AIWkEFQCArDtgbjrjVYfQ
 pw5y+0mu8ipgFAe5YXCsHr7oJgYD5YzE9lKeEghm8F7D8SIDr2sUtzNBWmOghZ+0LUCi
 +ky5OUiqXsgwegzOm5ipgfRn8KIBTN6Qyi53sCP5zq3rVZM1v81A64LOOKvyxct/iOFc
 VCrQno4XzdN12fRaA9IRurLEXHVZTFlstbE6WK+a+visvyXjwxtyDj+M8HSRSmhMc7Cr
 nz0A==
X-Gm-Message-State: AOAM532Yshjsf9olsvl7e7VkyjN9kDpEuPUuIm5UFGT5chy1Ytm79ssJ
 NW4IHhXAeAol0ZzSIkAx290U3A==
X-Google-Smtp-Source: ABdhPJwPFVkWMTA1CI/NNU9vAjDcEpabe09cBkwtQ3ney31RcpAoLSbtwEoUWQJgalybYvM0jyGy3w==
X-Received: by 2002:a17:90a:d201:: with SMTP id o1mr89334pju.46.1604940642013; 
 Mon, 09 Nov 2020 08:50:42 -0800 (PST)
Received: from [172.16.1.221] (76-14-210-194.or.wavecable.com. [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id a123sm11692718pfd.218.2020.11.09.08.50.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2020 08:50:41 -0800 (PST)
Subject: Re: [PATCH for-5.2] target/arm: Fix neon VTBL/VTBX for len > 1
To: Peter Maydell <peter.maydell@linaro.org>
References: <20201105171126.88014-1-richard.henderson@linaro.org>
 <CAFEAcA9BSNwtqNwh1H3+SjEAvxihpfcXc=frPLcqNtaKUJi0Yg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f7338191-7185-deef-b928-fe85e158632f@linaro.org>
Date: Mon, 9 Nov 2020 08:50:39 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9BSNwtqNwh1H3+SjEAvxihpfcXc=frPLcqNtaKUJi0Yg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Ard Biesheuvel <ardb@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/9/20 3:59 AM, Peter Maydell wrote:
>> +            tmp = env->vfp.zregs[reg >> 1].d[reg & 1];
> 
> This can be written
>   tmp = *aa32_vfp_dreg(env, reg);
> rather than open-coding the conversion from a dreg number into
> the appropriate access into the zregs representation.

Ah, I forgot about that helper.  Thanks.


r~

