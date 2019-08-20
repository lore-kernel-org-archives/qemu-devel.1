Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77ABBC3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 15:33:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42D7B2054F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 15:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fiuNZ+MU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42D7B2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i068F-00063X-Fx
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 11:33:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35777)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i066m-0005SO-85
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 11:31:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i066l-0002SI-A3
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 11:31:40 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:35064)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i066l-0002Rc-5d
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 11:31:39 -0400
Received: by mail-ot1-x344.google.com with SMTP id g17so5412970otl.2
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 08:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zpB9XLMo1Q8vxKxjfFa8+dNSfxsG4UwS/v+5EZ7yVGE=;
 b=fiuNZ+MUpFYo+Un6MR2cnrRt40+xZysKRDRPqjnra2SopPGAIPOxNxhd90g03VEiuR
 zPLCEtJTdMp8VObOJBjItr1W6SON6nZ24BC3oP/B9rcClfP1W7jgnI3mDJCilKrf4wgB
 tcLwJyqz2mgv2MCfUC7eLPiX32Ubc6dG9HohmPG2X28dfGnXP1tRYXkxTLuWKdGNbg/a
 3sEZKNk7hpAgMEGamTuCCsDzJAuvVAAF8xGT99adCzp5B5Xw2M0TgBtoBPgCFcSI/H9/
 O0PmngspOAd+RyOtFHqpHMqxnlVYXOVoVxVeZR0tPOrOxqTa6Y7tTdwh3appCZMsb0/v
 Qk/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zpB9XLMo1Q8vxKxjfFa8+dNSfxsG4UwS/v+5EZ7yVGE=;
 b=bseYqkdBXQDbL7u6XCL7ToFcmhDI9quBfc7n/6Mm+TAY4LlrZWkeP6YHPi79ZnyH2R
 3FRMjomeVSLaimNVZTaz0QBfI8hbNAB/tcTZscjBvIUjXTbWX/5YdLq3qgG3quA+UYkV
 a1XqbdtOYoIv7BlUmv+2PVxmLAUJo3dH8RY04lB4SKUxAJR2hHDj5owuDyMNB7nS5aRC
 4g46ig9PLXdOOPMjTQ1HrFriUOsq0rvOrp81IRHtSHarA0eo7G8dvk8P+UDE8cTMWLO4
 ZqH27pq2ieNimJEvtZLLgYms9KohGUC5ndXkFtRSjeSnNGrJ22mN80Air2rnU2h8fubk
 LUJw==
X-Gm-Message-State: APjAAAXXeDwnDFH1/QPrWe7xpRN9mBMwgskaS+lG3h6AYKa+FotKsekW
 28OilfqB1WHI8nIuAkz2V/cYM2jiWKRJRXVcNCr/7A==
X-Google-Smtp-Source: APXvYqy5h7Y6KP2UHXIsqChtlrxY4OxuU/O1HVfFIGAh8uHoRnhub9igSYF5/qJKQQs5PvLPkIfpYU9q6Qn67x4Cpj0=
X-Received: by 2002:a05:6830:2103:: with SMTP id
 i3mr23438141otc.135.1566315094670; 
 Tue, 20 Aug 2019 08:31:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190803210803.5701-1-richard.henderson@linaro.org>
 <20190803210803.5701-7-richard.henderson@linaro.org>
In-Reply-To: <20190803210803.5701-7-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Aug 2019 16:31:23 +0100
Message-ID: <CAFEAcA-cFi8BLBhh3vPdT4d=ps_pmP5gNz1W00mskVhhzN175w@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH v7 6/6] tests/tcg/aarch64: Add bti smoke
 test
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Dave P Martin <Dave.Martin@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 3 Aug 2019 at 22:08, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This will build with older toolchains, without the upstream support
> for -mbranch-protection.  Such a toolchain will produce a warning
> in such cases,
>
> ld: warning: /tmp/ccyZt0kq.o: unsupported GNU_PROPERTY_TYPE (5) \
> type: 0xc0000000
>
> but the still places the note at the correct location in the binary
> for processing by the runtime loader.

Is there some way to suppress these warnings ? 'make check-tcg'
output includes

  BUILD   TCG tests for aarch64-linux-user
  BUILD   aarch64 guest-tests with aarch64-linux-gnu-gcc
/usr/lib/gcc-cross/aarch64-linux-gnu/7/../../../../aarch64-linux-gnu/bin/ld:
warning: /tmp/cccZ8Fk7.o: unsupported GNU_PROPERTY_TYPE (5) type:
0xc0000000
/usr/lib/gcc-cross/aarch64-linux-gnu/7/../../../../aarch64-linux-gnu/bin/ld:
warning: .note.gnu.build-id section discarded, --build-id ignored.
  RUN     TCG tests for aarch64-linux-user

and these are going to come up in the merge-testing search
for warnings in the build logs...

thanks
-- PMM

