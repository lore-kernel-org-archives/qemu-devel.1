Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A588C468BD
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 17:54:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E548E208C0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 17:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dt/3clZ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E548E208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49924 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZJ4V-000203-7g
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 13:54:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56355)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hZH3M-0006PS-PB
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:45:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hZH3F-0003lE-Fr
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:45:12 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:42286)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hZH3C-0002km-PS
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:45:08 -0400
Received: by mail-ot1-x341.google.com with SMTP id l15so2252868otn.9
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 08:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+dqWPXmpKRFmoyF1BYy25lbKYWxiwuoMRvLxXce39rc=;
 b=Dt/3clZ9jITEUL8YvGMxs39I7G8cWmEz6dDyM/UwTycyu0C383wrYQvAm3kyxtid5S
 0dmKMCDqs7GcV3Xn1EgXhRp5ovV9qzCR0lTzE/C4I89dt1f8+gT1Rno3O1eOWtdfIegf
 T9XX4dG/9Bk9rgiLcxoOWm3YP6oF5QFCgiBTfF4YJIeYzPTH6aowScEqCcipCAlmh38W
 mJIf5VDBbwNpvtR0OVwiwBuacPTZ7H28quX7gkfLLe1sGvbEDROfhkVm2t3CISy6MrOQ
 69468tRixucc4NGps5LHqkEr5va7nKxotY9qAQ3sYd8DSTwHNoHDUz0HA13cXKzZuUj8
 5hYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+dqWPXmpKRFmoyF1BYy25lbKYWxiwuoMRvLxXce39rc=;
 b=Cy7m9MNcp6cX2juYUH89KBaBhQtCdDBHDTvNJoww913CMH0w1BCTyV7wQosLbHAaSk
 x3qOg0hL96vwksT6q9Tr2Uu3a2105FoNSNs2z22okhzzb7DK0yUZX5FMeX75qxZ8ATJj
 n1cuoaKae91OvHrI7Iz1k/uMWnEKfUB556BUVhyexIEMHmtUDjiiDvA2XYobofDCc1vi
 b0H4sMRmPSj3QzU/9ZiVY4XVztgc0weGB1nMfkDxbsYxMyvExur2WQV0LzLNttIlSx9P
 P2u47gNhbv/xqyAcGA7WaYSu1JwrAEM8ePB5gPupMe7hd8InisVr4erWyERNP/a4ubOn
 3qeQ==
X-Gm-Message-State: APjAAAUB0vrlka8VWbR2NQYw45S/a1P1aG5+6rsCuCfMbGPJJI5NL/7i
 YyUGLmoqIfLigBQHe7QGmITNWSRl8PHf8H4KWoPWaA==
X-Google-Smtp-Source: APXvYqyHngtF2zxBXIcLyrHD3XO//gYIzenwhOa+Q8fEAXV6AcY2O+at8CVFzee4s8Rwtthbi+xx55tvX6RtyQcDEQM=
X-Received: by 2002:a9d:711e:: with SMTP id n30mr1978361otj.97.1559922270221; 
 Fri, 07 Jun 2019 08:44:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190603232209.20704-1-richard.henderson@linaro.org>
 <CAFEAcA-KZM8tzD6XLhbtxB=OrnvgmtjcknvxrYoVmooBb7grMw@mail.gmail.com>
 <0a55f185-fb9f-335f-2342-9c214706a4d1@linaro.org>
In-Reply-To: <0a55f185-fb9f-335f-2342-9c214706a4d1@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Jun 2019 16:44:18 +0100
Message-ID: <CAFEAcA_kL1WCtSCHp_h1F4Ch6qU6tYXuvqUQhqxGoeHiqApyNQ@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH v2] target/arm: Vectorize USHL and SSHL
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

On Fri, 7 Jun 2019 at 16:40, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 6/7/19 9:54 AM, Peter Maydell wrote:
> > On Tue, 4 Jun 2019 at 00:22, Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> >>
> >> These instructions shift left or right depending on the sign
> >> of the input, and 7 bits are significant to the shift.  This
> >> requires several masks and selects in addition to the actual
> >> shifts to form the complete answer.
> >>
> >> That said, the operation is still a small improvement even for
> >> two 64-bit elements -- 13 vector operations instead of 2 * 7
> >> integer operations.
> >>
> >> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> >> ---
> >
> > Applied to target-arm.next, thanks.
> >
> > NB: in v1 this series had a second patch. I'm assuming you
> > dropped it deliberately -- if not, let me know.
>
> Oops, no.  Can you please grab it with your r-b from v1?

Sure.

-- PMM

