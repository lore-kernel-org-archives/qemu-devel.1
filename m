Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45269C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 16:08:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 045A12070D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 16:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TJlQqWMu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 045A12070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46013 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP84k-0007y2-5P
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 12:08:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hP7xU-00036q-Ez
	for qemu-devel@nongnu.org; Fri, 10 May 2019 12:01:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hP7xT-0004MF-Hz
	for qemu-devel@nongnu.org; Fri, 10 May 2019 12:01:16 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:45145)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hP7xT-0004LI-BC
	for qemu-devel@nongnu.org; Fri, 10 May 2019 12:01:15 -0400
Received: by mail-ot1-x343.google.com with SMTP id a10so3707862otl.12
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 09:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=Dy8EhEUL2zVhXDJiWFjxCwIcgr3gV584fPxJ19AkQfE=;
	b=TJlQqWMuDb8BYcqOW6x39cfka8o0a8zS7/dVoGofIqyfy6bZm21Okfw5YbQ05kVxb/
	J6De+Tj/9hnaX8WUbxLBpZ7fvz4Hr8AxS2xwPp5iYxmNPpDOCNno29nqQwiyFgd88NkZ
	7AZJaW+3N5o51mLvvV4foxsDeashWN7qCnAu1ONBwwTCl2UUaHhf1Krht9QmCoS3Qo16
	/A5yrMoX3x0Sa4Lg3wJEXZl2rmghTWdIiBxOR+hjRB/AObuD1YY7+eem7WE4Rpxl+Xaw
	PZkpBjkqUWisw3Sf3Rnb9bQMqS+LpTZLnw9RjeBUYG5G93uqUnUlq8mzQikfnlEK0Hct
	V8AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=Dy8EhEUL2zVhXDJiWFjxCwIcgr3gV584fPxJ19AkQfE=;
	b=a+Oy0s3Cs5e/eCaWUChUH65TEae3LAdNmPLZgBzVMCSfuh5uLYzwYX5OvQiWYfDYXy
	bL+gRmTfgfl40O2QICRFTEDw/wnd6X3N+WRG9v1I4RnSGKnz7BzZQ8YUmeudZAMRJTvg
	fEFk+robgsv8d+KidKVzNYHDoZw/LhFaLXJngnagmeCALACX7W1niDT1Jdcd/nE6FnkX
	LieHGnuNehbJTX/HX0XSRJYubxA3Rl2yvZDwdEMlzjm5YpuS3oMEX6QMWkdkZTjmA6YE
	+/CUWD3hoF4hms8NH8j12y5mZBTqpArcxb3qjadIX7cnif0r91pAiHTpQhtiE8JieDFO
	tPvw==
X-Gm-Message-State: APjAAAVqL2byJCvwgbDaPLmMjcl2YqhyWNzWKHbcfkzzlHfVjhoWW1aS
	i5cym57dp61XlELKoSWJLejUwXRpccJCA94kKtNx0w==
X-Google-Smtp-Source: APXvYqzJ4CW6XdrGPlpFFxuwLYzQ4ndUzf7Ol1TM6CrJZ5oDa5f3PiG+g1oTRooXJuY0BNAifStBdYX0k/HCo4uHHi0=
X-Received: by 2002:a9d:4793:: with SMTP id b19mr2871763otf.238.1557504074140; 
	Fri, 10 May 2019 09:01:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190510012458.22706-1-richard.henderson@linaro.org>
	<20190510012458.22706-23-richard.henderson@linaro.org>
In-Reply-To: <20190510012458.22706-23-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 May 2019 17:01:03 +0100
Message-ID: <CAFEAcA9uwaev+Q=BgLBz+fgO6C7VGmw4Nxcozg2vm6TOm+LJww@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH v5 22/24] target/arm: Implement ARMv8.5-RNG
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 10 May 2019 at 02:25, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Cc: qemu-arm@nongnu.org
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v3: Log errors with -d unimp, for lack of a better flag.
> ---
>  target/arm/cpu.h    |  5 +++++
>  target/arm/cpu64.c  |  1 +
>  target/arm/helper.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 50 insertions(+)

> +/* We do not support re-seeding, so the two registers operate the same.  */
> +static const ARMCPRegInfo rndr_reginfo[] = {
> +    { .name = "RNDR", .state = ARM_CP_STATE_AA64,
> +      .type = ARM_CP_NO_RAW | ARM_CP_SUPPRESS_TB_END,
> +      .opc0 = 3, .opc1 = 3, .crn = 2, .crm = 4, .opc2 = 0,
> +      .access = PL0_R, .readfn = rndr_readfn },
> +    { .name = "RNDRRS", .state = ARM_CP_STATE_AA64,
> +      .type = ARM_CP_NO_RAW | ARM_CP_SUPPRESS_TB_END,
> +      .opc0 = 3, .opc1 = 3, .crn = 2, .crm = 4, .opc2 = 1,
> +      .access = PL0_R, .readfn = rndr_readfn },

Don't these need to be marked ARM_CP_IO for the benefit
of -icount ?

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

