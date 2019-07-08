Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D720C48BE7
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 08:15:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07F7F20844
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 08:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jyNXv18N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07F7F20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkOne-0008Nq-5v
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 04:15:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56222)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hkOmm-0007z6-5x
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 04:14:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hkOmk-0008JW-Qe
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 04:14:08 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:45747)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hkOmk-0008JC-Kx
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 04:14:06 -0400
Received: by mail-oi1-x243.google.com with SMTP id m206so11890937oib.12
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2019 01:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=ly34sK1qwjS1tEsQv+RflgpzvfNydYSUxt0Ibbgf14U=;
 b=jyNXv18NeUwJIWP59Qf6DnpBMp4VVA6a6wCENFG4Ewdxogzm1wmFyWQMzNV50+zfx9
 rRAkhMc54rAyOIs54Uxn+vZxT9CSiizZahJZI+hROjFCVpc/K60pLdQ+4DCTZ7botIvE
 zCcnTAAuhJMiVTl73WScuFKnyDl9YML2H3OU9jgTAeoZbp6vedOcjan4lmzqvWTKrDqQ
 2Z3aXir7HHeuTEPIO+DfG8mYlCNPB6IOw7tWBeNl63k7yvvWWialqwb5c5QlHnir97ld
 9GVqZD0dIXfpn0caSbIjGundI46v3y9gcExNbVi0RmJal4+iYlraUlop0217zjjRygJ2
 M0fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=ly34sK1qwjS1tEsQv+RflgpzvfNydYSUxt0Ibbgf14U=;
 b=PJx4wog6fWUIJRcC40R7nyRq8JBOD2hAuqLhaiKXWNlGakSUxzp9ajJgGm6P5PKqM0
 SXYh9I4P1Ha2ukfnIaWUGlZYACZnNgokggp9PaFi5D5OGgQq9J2+aKXbV6t1c+7APs5V
 IC9iV9Mlx+w7cp1Lux5Fz7Ob4wbJBdLTUn7/8IkPsH9j2c49pZ9uCcxi0/4bVqzOVWfd
 yTAKDfm8lI1oxVfN8/C71CQnP3ZFmygg3akcl8BuKUPZpDjplu+7kpDBZFK2Yuufc0+f
 F1bMikJQdzSxnrczRF3NS7X+waJQPlYT2vRy7rmYjVTB30WVYqKSkl4MzTC3fY2kmGCM
 vdKw==
X-Gm-Message-State: APjAAAWSeRninNtDPABneW55mO/Sud4KTpvSHck7auH4cXqjBwINWR2R
 vKQFDa7a7szDX8qIhcUSOcrFnUDpFqjibPG64F0=
X-Google-Smtp-Source: APXvYqybYPKxvlz9fEsnb26TFSOjsetskoE5swI9/iWKMLjxq5duPd9XLTQM9L8HvKn/SzH0qPMqFNoLoGhh0XWkS80=
X-Received: by 2002:aca:310a:: with SMTP id x10mr1970693oix.62.1562573644968; 
 Mon, 08 Jul 2019 01:14:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:4798:0:0:0:0:0 with HTTP;
 Mon, 8 Jul 2019 01:14:04 -0700 (PDT)
Received: by 2002:a9d:4798:0:0:0:0:0 with HTTP;
 Mon, 8 Jul 2019 01:14:04 -0700 (PDT)
In-Reply-To: <4da49ffe-902f-2cf2-8a21-2bbd511b17a4@weilnetz.de>
References: <1534182832-554-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1534182832-554-5-git-send-email-aleksandar.markovic@rt-rk.com>
 <4da49ffe-902f-2cf2-8a21-2bbd511b17a4@weilnetz.de>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 8 Jul 2019 10:14:04 +0200
Message-ID: <CAL1e-=jE8X1ODnA0aSXe5OCqJzYA0J47h5b6=H_UivPP11zSQA@mail.gmail.com>
To: Stefan Weil <sw@weilnetz.de>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] Handling of fall through code (was: [PATCH v8
 04/87] target/mips: Mark switch fallthroughs with interpretable comments
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
Cc: pburton@wavecomp.com, peter.maydell@linaro.org, smarkovic@wavecomp.com,
 riku.voipio@iki.fi, richard.henderson@linaro.org, qemu-devel@nongnu.org,
 laurent@vivier.eu, Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 philippe.mathieu.daude@gmail.com, amarkovic@wavecomp.com,
 pjovanovic@wavecomp.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jul 7, 2019 10:26 PM, "Stefan Weil" <sw@weilnetz.de> wrote:
>
> Am 13.08.18 um 19:52 schrieb Aleksandar Markovic:
>
>> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>>
>> Mark switch fallthroughs with comments, in cases fallthroughs
>> are intentional.
>
>
>
> This is a general problem all over the QEMU code. I usually compile with
nearly all warnings enabled and get now lots of errors with the latest code
and after updating to gcc-8.3.0 (Debian buster). It should be reproducible
by enabling -Werror=implicit-fallthrough.
>

Hi, Stefan.

Thanks for bringing this to the attention of the community.

I am sure there is a number of nasty bugs of this nature in our code - yet
to be found.

> The current situation is like this:
>
> - Some code has fallthrough comments which are accepted by the compiler.
>
> - Other code has fallthrough comments which are not accepted (resulting
in a compiler error).
>
> - Some code is correct, but has no indication that the fallthrough is
intentional.
>
> - There is also fallthrough code which is obviously not correct (even in
target/mips/translate.c).

Can you please be more specific about those cases from
target/mips/translate.c?

Yours,
Aleksandar

>
>
> I suggest to enable -Werror=implicit-fallthrough by default and add a new
macro to mark all fallthrough locations which are correct, but not accepted
by the compiler.
>
> This can be done with a definition for GCC compatible compilers in
include/qemu/compiler.h:
>
> #define QEMU_FALLTHROUGH __attribute__ ((fallthrough))
>
> Then fallthrough code would look like this:
>
>     case 1:
>         do_something();
>         QEMU_FALLTHROUGH;
>
>     case 2:
>
>
> VIXL_FALLTHROUGH also needs a similar definition to work with gcc-8.3.0.
>
> Please comment. Would you prefer another macro name or a macro with
parentheses like this:
>
> #define QEMU_FALLTHROUGH() __attribute__ ((fallthrough))
>
>
> As soon as there is consensus on the macro name and form, I can send a
patch which adds it (but would not mind if someone else adds it).
>
> Then I suggest that the maintainers build with the fallthrough warning
enabled and fix all warnings, either by using the new macro or by adding
the missing break.
>
> Finally we can enforce the warning by default.
>
>
> Another macro which is currently missing is a scanf variant of
GCC_FMT_ATTR.
>
> I suggest to add and use a GCC_SCANF_ATTR macro:
>
> #define GCC_SCANF_ATTR(n, m) __attribute__((format(gnu_scanf, n, m)))
>
> A more regular solution would require renaming GCC_FMT_ATTR to
GCC_FMT_PRINTF and use GCC_FMT_SCANF for the new macro.
>
>
> Regards
> Stefan Weil
>
>
>
