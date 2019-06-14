Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947D7C31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 19:06:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E03921473
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 19:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NztWyKqE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E03921473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54430 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbrWn-0003MT-7i
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 15:06:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41007)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbqNj-0007GG-V9
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:52:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbqNi-0007Gj-QY
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:52:55 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:45229)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbqNg-00072r-Su
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:52:53 -0400
Received: by mail-ot1-x344.google.com with SMTP id x21so3405726otq.12
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 10:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aXyj3HlAs6XieE1lzfqUgpGcYF+8UXTk6niz6BWcjJI=;
 b=NztWyKqEBb/Niuvpsf0BaEySXYaI/YXSSMoGNhhTkJH8kxyzobFZB+l7HgDGtAlyDH
 WfnP6veRuT/aiRUjPiEL77v0NyUnbddxqO9J6NjK+lajpn9ijUIl8A8ALcbyG37NvAGO
 yTJaSSqAkiooIZYO5YjtzK7EW/7pCjgiy9xat1KwfACbO4PpRK70ATuAsvTlwvQhoPWw
 NFjAPfSs2XV94CXgSPKMD716GSKrDlx7PlHOFYI5dHz/REaVny4nUtViSHamyfY5kpFK
 WPVdrX6pJyvbz4+T/4EQB7FjXS/ZfKcLycnE3SbGNsMc4KnjZ4fmW57VubSxF+UD7wV2
 eYig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aXyj3HlAs6XieE1lzfqUgpGcYF+8UXTk6niz6BWcjJI=;
 b=jBbVlP1+Yns+bF8oSyurtYy4U8Z0SFrRMm0NdbjPY8l7mGcCFPp+BFkFzJrV1nH9hK
 qt/hZmf8teVh+afn+edTZcQ9+dK6wvonUfE4XrXBhRM9nimrcHMwEoFoBe+39zuYRh0c
 VJepSkHCAQXEcUSQ9oGpmKrVtFXnKb+3zZxT/snvjswyAa47vUWrIp6Nw+Za4CjajY5P
 6NqPeaYw+js4vs0HZY3QuNIcU5jM2n9UCigHjAbc0Gp+UMTcC5ihB8DwfNvZsAAvjP/L
 4dI9Goki0fns/U7KggvbjSKTiWLq4ZNjnqNn57j/4rp7gc6JX0vMDYyOMNcWSVtQGWKa
 NCAQ==
X-Gm-Message-State: APjAAAXemBzmWNVJ6zL8kCT5UyzHVY4i1+wPix6WKViUo4UzbZkJyNqh
 SECYseVAjnnY5lV6Py7hBA9zpOILZ3IrlRvx5x72nLu3DxM=
X-Google-Smtp-Source: APXvYqzPwNgMIZYuzUhv66XqzRXQQSdgI4W4YKU0gKHO7fNUVuDnKSu7QF+rqrmniQkEJ514zVWYjY0meeTTxDg6xII=
X-Received: by 2002:a9d:d17:: with SMTP id 23mr47560156oti.221.1560534755345; 
 Fri, 14 Jun 2019 10:52:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190614104457.24703-1-peter.maydell@linaro.org>
 <20190614104457.24703-3-peter.maydell@linaro.org>
 <ab0b9cf8-98d2-1901-a8f7-259d6426f833@linaro.org>
In-Reply-To: <ab0b9cf8-98d2-1901-a8f7-259d6426f833@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Jun 2019 18:52:24 +0100
Message-ID: <CAFEAcA8CkvThgBXrSJw=O4BWBBDi0yXcF1T8fgytB53AshExXQ@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH 2/2] target/arm: Only implement doubles if
 the FPU supports them
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 14 Jun 2019 at 18:21, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 6/14/19 3:44 AM, Peter Maydell wrote:
> > @@ -173,6 +173,11 @@ static bool trans_VSEL(DisasContext *s, arg_VSEL *a)
> >          ((a->vm | a->vn | a->vd) & 0x10)) {
> >          return false;
> >      }
> > +
> > +    if (dp && !dc_isar_feature(aa32_fpdp, s)) {
> > +        return false;
> > +    }
>
> Would it be cleaner to define something like
>
> static bool vfp_dp_enabled(DisasContext *s, int regmask)
> {
>     if (!dc_isar_feature(aa32_fpdp, s)) {
>         /* All double-precision disabled.  */
>         return false;
>     }
>     if (!dc_isar_feature(aa32_fp_d32, s) && (regmask & 0x10)) {
>         /* D16-D31 do not exist.  */
>         return false;
>     }
>     return true;
> }
>
> Then use
>
>     if (dp && !vfp_dp_enabled(s, a->vm | a->vn | a->vd))
>
> ?

It would be less code, but I don't think the "are we using
a register than doesn't exist" and the "do we have dp support"
checks are really related, and splitting the "OR the register
numbers together" from the "test the top bit" makes that
part look rather less clear I think.

thanks
-- PMM

