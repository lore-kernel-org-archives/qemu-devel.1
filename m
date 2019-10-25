Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F36DCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 15:07:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 360C820684
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 15:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nEFpS8KG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 360C820684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO1Ap-00021j-7W
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 11:06:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50356)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iO0wO-00045l-7P
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:51:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iO0wL-0007ek-Vm
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:51:47 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:35660)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iO0wL-0007eG-Pf
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:51:45 -0400
Received: by mail-oi1-x243.google.com with SMTP id x3so1818590oig.2
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 07:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xlxSLc7xTdyHnHjeegrcAjQgP0ehJSSY73g1OQihZXo=;
 b=nEFpS8KG/Fbe6jjsTWpMC1H4I2+Jg3BgEGfjYQSrgPvgXKDGkNnAeofiD2qcu6Mdpn
 1abHieOaOeSe4AlbPEoubsiVFnYsJ+yZTi2u6XNEUDxUr9GoS8YKG7B2xoh4YvTOMHsc
 /88GP9UVZT7FcsvSLi9H9VNGcT5aNuGShvVAPjTqejV3neSSRSVxWWn+NLNTUR5yJnS7
 bzXsNThzLtLSrMylBm5RbGUhgloRuHdc6shfuhwj2RHAuf+HEGu16o78XDJKLCBZ6vCu
 06EoVYaJ2HsMdOs8XA9hEIXjNfOtME/XiKnjDW2hUG65dhbzmE3WGKrV9mxliQJP9Zr3
 FlpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xlxSLc7xTdyHnHjeegrcAjQgP0ehJSSY73g1OQihZXo=;
 b=A7wXWp+hy90HHgSHi8NPiwGjtfgo+Y3NqMaIZMzkYGQWQ2OPoOiFSc6MaEeuhKZ+CA
 nBk3CPOmGkjmvK/6F37/GU931sk5x04ifz8pB80Y4GX+8PVceC9jechdMDEssKDYukb7
 6fR8vk+gprBzIEE3pw/ok0YpbptDnRN1No9zR4uHijGfImkEtprwN6zNKJkd38hRYOWO
 Hd+XZo+shf6K7hjmViCKK4LCD0GMVnsphTe3Nrt+ULj2pJo2AXuyAQBkh4d0Sfyl6rA9
 Y6Vyx9AfXKkVm/Y8xLEFa/vSIHBCxAiO58pck7O9XohSflVWznwIcL1jpnCuFETvKMuR
 0Teg==
X-Gm-Message-State: APjAAAW3LzmZcTXLmpCxpNYTBSu+r5Opocm7kndlBGY0ZR5N0pho90iv
 h1N8P+tlzbY7P7UECYFjECPD7nmNDVzN8XFIhq56ug==
X-Google-Smtp-Source: APXvYqyJv8/ljG94uM9qWnRUVB04QtU4pPEnC8Ym0T2R6XwZ8s+6kpTDvwNeAvICiVx9BHIvOUnYygJHEEdJCL4/ojk=
X-Received: by 2002:aca:2312:: with SMTP id e18mr2371247oie.98.1572015104607; 
 Fri, 25 Oct 2019 07:51:44 -0700 (PDT)
MIME-Version: 1.0
References: <20191023154505.30521-1-richard.henderson@linaro.org>
 <20191023154505.30521-5-richard.henderson@linaro.org>
In-Reply-To: <20191023154505.30521-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 Oct 2019 15:51:33 +0100
Message-ID: <CAFEAcA8unCxb-4E561fnOFd=LCXv1y7YSd9xUb2GAutjcYXeGg@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] exec: Use const alias for TARGET_PAGE_BITS_VARY
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 23 Oct 2019 at 18:06, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Using a variable that is declared "const" for this tells the
> compiler that it may read the value once and assume that it
> does not change across function calls.
>
> For target_page_size, this means we have only one assert per
> function, and one read of the variable.
>
> This reduces the size of qemu-system-aarch64 by 8k.
>
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>


> + * We want to declare the "target_page" variable as const, which tells
> + * the compiler that it can cache any value that it reads across calls.
> + * This avoids multiple assertions and multiple reads within any one user.
> + *
> + * This works because we initialize the target_page data very early, in a
> + * location far removed from the functions that require the final results.

I have to say that this feels like a worryingly large amount
of magic. Is this actually guaranteed to work by the compiler?

thanks
-- PMM

