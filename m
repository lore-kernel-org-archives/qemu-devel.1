Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB9DC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 18:43:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0E2421D7E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 18:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="khKZO9LB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0E2421D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuhRl-0006x0-9V
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 13:43:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33715)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iufHA-0000OC-L0
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:24:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iufH9-0006vB-DV
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:24:12 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:42319)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iufH9-0006uf-7N
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:24:11 -0500
Received: by mail-oi1-x242.google.com with SMTP id 18so3408667oin.9
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 08:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MTG316SXjD3XRVIEALV11CJVcTGvbR40Hq6l/pimWy0=;
 b=khKZO9LB6LdTDy/WqES8LmyJgLTBwchTqpoiqfc/AUUqyeIw57+fGi4schXSlYf636
 +P2+cUb6xPqcj+3dwifcEcegT2Igv7YVQlD6FsVPgSmbb36aHTBSBTwbRUHZ5H0kSiUu
 xGFWYvxD6ggp0PKgvZGiR8f7IJSRRvrRtAgkNFZxKEt7Vg5QgecL/VjfJeCtqpxQSTXK
 0HiyYpl9/fLhj3urdxFmdkTgVUT+BDLYGTTSUhjoyA36oKGRaGvIT2bDog6rko/Z5WGm
 lz5Qzf42+BmTEOxbl5Np1wDJia63nE0m8dykHRXV4g3WItUTMLkzDrwpuhPeUfuBOjNB
 MAMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MTG316SXjD3XRVIEALV11CJVcTGvbR40Hq6l/pimWy0=;
 b=Lngjp3sCB43x6dDjOCT6x9CT4/JrkZJ/8iQaK+mY8ezCdDdQuZbyqFRFclgFfYbL5E
 PSidtGSBIDnmtdL9VFgWVPJM0TQBHwTh5q8KDxL78SWWLJXrbx1iMB+jEGOP5OTTtEHN
 HO1KgOnnJ1MPhZa+Mb8HB4H1omVBaANjg5Y8hYDM0W0tru4dw0V0k6wOiJIUUr4+5qmt
 5rS0N7UeVGn9fZKMS1waEGCAGBMrzSBDHtigQuxepixJQXfBuqB5BqoCv/c9dsIT3hDU
 sdCmogBRk14W0PsHLxq9pcqNyLDbty1QZM7fX1qU/rmZ9Q0xE8S0vPDL48x4TvfEes2+
 30SA==
X-Gm-Message-State: APjAAAV8kYCoZXlJyTdk5T0T7LT+oeoAIBvQj40JvbGNK58h6q6qFRGX
 YHVq3ORdlKZtBoS+j5qcmc8yGCzt74icJ4DCMPvyQHWr5fo=
X-Google-Smtp-Source: APXvYqweX/gThbfr++qFFF04JSkqOWHgRH72nk720loynaeAY7CSqIXArIoJNCsgfPGDjqW+oDbvkay3EzLIEnyjYvA=
X-Received: by 2002:aca:570d:: with SMTP id l13mr10851072oib.146.1579796650373; 
 Thu, 23 Jan 2020 08:24:10 -0800 (PST)
MIME-Version: 1.0
References: <20200123052540.6132-1-linux@roeck-us.net>
 <20200123052540.6132-2-linux@roeck-us.net>
 <CAFEAcA-SPUPEcV4Uw9=8-5EJmLztVorV++ypFp=vYxasncBrZw@mail.gmail.com>
In-Reply-To: <CAFEAcA-SPUPEcV4Uw9=8-5EJmLztVorV++ypFp=vYxasncBrZw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Jan 2020 16:23:59 +0000
Message-ID: <CAFEAcA9p7Foko17jTB_GSGLnaQwpJTcf0-qTrJkVWje1jOpq-g@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] dma/pl330: Convert to support tracing
To: Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 23 Jan 2020 at 15:51, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Thu, 23 Jan 2020 at 05:25, Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > Replace debug logging code with tracing.
> >
> > Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>
> This turns out not to compile on OSX, which is a bit
> stricter about format strings:
>
> These two:
>
> > +pl330_dmald(uint32_t chan, uint32_t addr, uint32_t size, uint32_t num, uint32_t ch) "channel:%"PRId8" address:0x%08"PRIx32" size:0x%"PRIx32" num:%"PRId32"%c"
>
> > +pl330_dmast(uint32_t chn, uint32_t addr, uint32_t sz, uint32_t num, uint32_t c) "channel:%"PRId8" address:0x%08"PRIx32" size:0x%"PRIx32" num:%"PRId32" %c"
>
> both provoke
>  error: format specifies type 'char' but the argument has type
> 'uint32_t' (aka 'unsigned int') [-Werror,-Wformat]
>
> because of the last argument.
>
> Easy fix would seem to be to change 'uint32_t ch' to 'char ch'
> (the argument is always a literal constant 'Y' or 'N').

The 'chan'/'chn' argument is wrong too -- should be uint8_t
to match the format string and the type of PL330Chan::tag.
I'll just fix up the pullreq rather than forcing a respin.

-- PMM

