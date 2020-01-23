Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38DD1C35240
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 23:32:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3E272071E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 23:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b2dtTTY1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3E272071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iulxF-00077C-2r
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 18:32:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54189)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iulwU-0006fl-1T
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 18:31:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iulwS-0006iJ-Qf
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 18:31:17 -0500
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c]:38176)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iulwS-0006gu-Jz
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 18:31:16 -0500
Received: by mail-pg1-x52c.google.com with SMTP id a33so30416pgm.5
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 15:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ry7ZNooGyUNFUHQBDdcWWlkQ6T8Y2f8z3ZM0zCYpZ8k=;
 b=b2dtTTY1HmgIexeQalbvG4HrMV20fWgZT3vzQKFD8QRErU6dzWyYQ5SjQ57KS8BPn2
 U8tD9k/ol+V1F5TOQ9swwldptDG+tiw2zIshveXMZjgqCYBSpq2LgOFdRdW7+/HusSzp
 nGFQCx88q7PMIY9CAVrsVIlS/2qYBldFmhlMC8+hBwAQAGsIkBK10/R+TUYzAoeBP/cU
 eoitHUCg2Pz6ul/SuKUhKve12X+yl2itAITHeMFZeyk9Tf2Y7VzrGMoSrIDfCcDb1WWO
 JyR+zBpIXY+tWzbgqZWWYqbENTzwQ+Hkf80448XCbVb/asDnZ5bbyg6k2K1/sCyhhty9
 sBjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ry7ZNooGyUNFUHQBDdcWWlkQ6T8Y2f8z3ZM0zCYpZ8k=;
 b=Ixm9eDw4sI+BSeUIHeJGQf13tHK05wPmQEnAy6rSPPvHvJQbg58tapiYkhezyNFBux
 /59Uysn7AQBBvsekqxitkiyUkGt3RbR3nB436Sp/4nV0InnLmrZOiBjLrwTtAps3uqeh
 reubp5ghmU2KmNNfE7AuvCrLhaIgj4iyShHYPBDsO88H1SGkq0gbSF5IxKuUURXNASOL
 KhNGb1MyCDDbkZa5b7VDasyVtfYQSexZQ7OVYrnSbmh7e83Ld8Jbd7BPyqHaqh2nzG9s
 +UK4T3LDS9Zy1iSm8Jxi2V4PtJJBjN66s5ts/yx84c0Fs2KtjJW4NYjteJEigHPE+jFB
 zteQ==
X-Gm-Message-State: APjAAAUoSsWnYFDQH2ekSk13er0QkcTKJDWSCCtB4XWOOL6a+Mfx3EkB
 Qtn8kOEiNDC9crftPNpkqQCF5gzUtOA=
X-Google-Smtp-Source: APXvYqxu5IzdN/Y7OeB4L8JIJ+y385RtI523CN4gAKHlU10cLf/skNk6KaFXS5WQc/bBku86DqG8tg==
X-Received: by 2002:a63:e309:: with SMTP id f9mr854648pgh.391.1579822275106;
 Thu, 23 Jan 2020 15:31:15 -0800 (PST)
Received: from [10.5.50.117] (rrcs-173-198-77-92.west.biz.rr.com.
 [173.198.77.92])
 by smtp.gmail.com with ESMTPSA id f8sm4101327pjg.28.2020.01.23.15.31.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jan 2020 15:31:14 -0800 (PST)
Subject: Re: [PULL v2 00/59] Misc (x86 and QOM) patches for 2020-01-23
To: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
 <CAFEAcA8R5yDfAYYraeBStD_Oh7G60QSgUaw_JVdqC=C8y4n0Jw@mail.gmail.com>
 <CABgObfZF7D+MgxXMDbrqZQpOb6WaOiKFaLSUv9U+3Ufb0GGKMw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f03723ca-9514-149a-180e-172a88f6e4f0@linaro.org>
Date: Thu, 23 Jan 2020 13:31:10 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CABgObfZF7D+MgxXMDbrqZQpOb6WaOiKFaLSUv9U+3Ufb0GGKMw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::52c
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

On 1/23/20 9:20 AM, Paolo Bonzini wrote:
> Il gio 23 gen 2020, 19:43 Peter Maydell <peter.maydell@linaro.org
> <mailto:peter.maydell@linaro.org>> ha scritto:
>     When I try to build-test this merge, the clang sanitizer
>     build seems to fail whenever it tries to link anything:
>     (configure args '--cc=clang' '--cxx=clang++' '--enable-gtk'
>     '--extra-cflags=-fsanitize=undefined  -fno-sanitize=shift-base -Werror')
> 
> 
> That's intended, you need to add -fsanitize=undefined to --extra-ldflags as
> well now. I can change that back, but then I am not sure what one would use
> --extra-ldflags for.

This seems broken to me.  Most cflags have to be present on the link line as
well, unless you know very much what you're doing.  I would not expect
--extra-cflags to have to be repeated.


r~

