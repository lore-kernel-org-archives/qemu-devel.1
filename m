Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC91C4727F
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 18:36:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 563A720644
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 18:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="laeVhTtf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 563A720644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLsZw-0002xy-Bc
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 14:36:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51186)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLsYe-0002Pv-Od
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 14:35:00 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:38063)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLsYd-0007Nt-1i
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 14:35:00 -0400
Received: by mail-pj1-x1043.google.com with SMTP id u3so2153632pjr.3
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 11:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=SXUdg0kumKwnWgxJhn/Dmub0nJaV2qYf01u+jWMoF9c=;
 b=laeVhTtfgZEE/ECUwD2u+NALSEjnFswxnNi9ksiouPDO1pnX7rxaYZx6g1EWp19wUE
 RRUI1O3psFpAeLjal6gJjkARXN0fJ6zUd9wGvD+S2nNeGqhVzG0fbZRVK+5QRnKYAu9H
 jCc3Pw1LrIrm/FdRJg9jE1PX0VN6rvT8r4Vdq3emZfqYInq4ylP8GYe4pjXPYLziF7uU
 hyLspfwVmTwAzQ9Jn0lXLBzb5Ir9aVxbYrYlDf8q3HqazRZ31lE8CgGDsFmo5hbAxNBI
 Ia7oMFdeIAnR79f6jwR+liGV4PczaOFww3JoyBqdgxlHgJeD721r789tYkRNcBIGP70O
 Tu/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SXUdg0kumKwnWgxJhn/Dmub0nJaV2qYf01u+jWMoF9c=;
 b=JZeU18AG+kVcGCnfRbfYIFlgLkIDHRBxrYwqsVBqYEaFVzq7vhwBH8fNWwETrsELDq
 9lnHb41YtC5mkW3c06lYoAwCyJeK7XrypYpVeMI0R9lH2lWYeVS6FUY7JLfHue1fxQ51
 030Xez5UxM0wDgUpdO6ROvhiKtpoO0XtXbdHpRmLYfmYu0sxGKfccnqtPl8EH9j44B3T
 VXWCqKK2QMsKMHmaNC8H44SGqNSa+hG8nWsUTiq2kEYWGw9TPLQjgd+UgiTbPx8P+gYy
 X81A37PUpfH/L9oLmPHltAxBmKWEchmNgXaLExZ6yAVCetDerqYEPrD7I8hiY4QmIUWA
 uiiw==
X-Gm-Message-State: AOAM5333s+Bchzf74djpElYndw0VxPzJ8XS7WAt1x5dE06oZQBOXtCsS
 eHEMAlUfvjzWi2w1vZ/Chr/gUg==
X-Google-Smtp-Source: ABdhPJx69A1F+AuAL0OUbTFLYQHz47gshz6uAoqr1GkVcHPnidoNAOo9VFOm6xTuLffVffaBdLnmIw==
X-Received: by 2002:a17:90a:e68f:: with SMTP id
 s15mr766303pjy.79.1601058897590; 
 Fri, 25 Sep 2020 11:34:57 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 72sm3228921pfx.79.2020.09.25.11.34.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2020 11:34:56 -0700 (PDT)
Subject: Re: [PULL 7/8] gitlab: create a build-deprecated target
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20200916122648.17468-1-alex.bennee@linaro.org>
 <20200916122648.17468-8-alex.bennee@linaro.org>
 <CAFEAcA_UEoe2H5zc=L1T3p31FoxKSfG0mRznN-68FQmGTp3+pg@mail.gmail.com>
 <87imcdzwh7.fsf@linaro.org> <d04bee00-624f-c48c-89a1-d5e6cbbddb76@amsat.org>
 <CAFEAcA8PioiyU2t9bqJW5_HiQQKrhOScTQFBd+a7BY-fH802sQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20693fff-9b29-3bf2-2d36-444d2724982e@linaro.org>
Date: Fri, 25 Sep 2020 11:34:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8PioiyU2t9bqJW5_HiQQKrhOScTQFBd+a7BY-fH802sQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.238,
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/25/20 8:54 AM, Peter Maydell wrote:
> On Wed, 16 Sep 2020 at 14:52, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> Should we stop building the ppc64abi32 target instead?
>>
>> From c609274b853 ("docs/system/deprecated: mark
>> ppc64abi32-linux-user for deprecation"):
>>
>>  The ppc64abi32 architecture has a number of issues which regularly
>>  trip up our CI testing and is suspected to be quite broken. For that
>>  reason the maintainers strongly suspect no one actually uses it.
> 
> It still builds fine and it also runs the 'ls' binary in
> the linux-user-test collection (ie the 32-bit PPC binary).

But signal handling is completely wrong, so
tests/tcg/multiarch/linux-test.c will fail.


r~

