Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9643EC4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 18:53:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E019B20872
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 18:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nd1mxSMh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E019B20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO3hV-0006Qb-T9
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 14:53:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kO3gX-0005vu-C7
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 14:52:09 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:39323)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kO3gV-0006tN-K6
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 14:52:09 -0400
Received: by mail-ej1-x644.google.com with SMTP id p9so9566400ejf.6
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 11:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=S5bY6Lc0MFUhqs4IvUQ63NHEUx/YLqSTz1H/EVhoXNU=;
 b=Nd1mxSMhhHZM2xl4DW4Z4e+/J6dxCg80Ku6trZ8JEn6gvrQA0cY4O8d/Fc872wpGVk
 3orMopcNvrS+5f757UWkAv7lwnRuy1tj/qt2prUD/E84FCH6gdbvdx4PGM/oH76rQT/g
 Dx7KxjR+cpkW74fjf2r2kFtegohkGToXwXn/oEmBI2feGXvgu+wXP8VxHVLR+jI2fCrS
 T3fGxdbfiKFddxG6xc9i1m28xjY8Why/PPIX2tFJITrcVlUICU8wGKTOcOT5XCxQvN0L
 cMQMEPwpCKONeuicEBSBOw/xVad2ik+yOvHa8LmfejkAZ0oIfVilJEpK6SlFKOTcl8Rk
 VhMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=S5bY6Lc0MFUhqs4IvUQ63NHEUx/YLqSTz1H/EVhoXNU=;
 b=ixHOi7XBxmPxI6gsJxfmdUOO1F7QTzL2ubOgON4I8+ookm5KccCCwhzbLVu4DAvxbT
 3alODAIOjhPidedX6lpcD/k+b+FrWEAyqbYgz4B1eq785qAOkrsw2PMDJ5ismZ7lfe99
 +qjBOWQAXG7dKZYi7SMFc5ypJ4DWTQi7VW8GD1spypQxhfwidxCeUNpuaCfb91F/RnEr
 EZsHUq97mPr1RT1WntWgGm3E+46ZWYX6DFAE1DpicGayl0qfLHhhhQhjddK38FQ+EaCZ
 46zzpZ5GRI/jXLMlaSrOSDMqPfKF23k3Axvw0TJxQGYdFA3cwKfciDEb1ltfQJ02JMjZ
 /XBA==
X-Gm-Message-State: AOAM530MGzbP638AGyR9KgQ7AnOsCXx/zsj5mFV5sOjpU8GibOeKvmG+
 UBq9syuT4n1zb+/9f84dxQNI2JKl7MZi4eCowjfeVw==
X-Google-Smtp-Source: ABdhPJwpF130dbaJIZxwAe+mzHFfxfCUiw4vsw/DD4PDXlUQzLNVgNH594WgfD2s3odu19KdvzdzHYNS+61UsWU7yOs=
X-Received: by 2002:a17:906:60d6:: with SMTP id
 f22mr2793746ejk.250.1601578326048; 
 Thu, 01 Oct 2020 11:52:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200930195850.278104-1-pbonzini@redhat.com>
 <20200930195850.278104-2-pbonzini@redhat.com>
 <CAFEAcA98nJiysUkGEUaq4OMJ815pQRTKz4TWxZFHqzzNX2r2uw@mail.gmail.com>
 <5eba8be2-0076-025a-2e21-281427b69d23@redhat.com>
In-Reply-To: <5eba8be2-0076-025a-2e21-281427b69d23@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Oct 2020 19:51:55 +0100
Message-ID: <CAFEAcA9iGZBKAyDnZmb=ieuSZvb2FkkzFqE_Ax-5TNHjY8oy5w@mail.gmail.com>
Subject: Re: [PULL 29/86] meson: move libudev test
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 1 Oct 2020 at 17:55, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 01/10/20 18:19, Peter Maydell wrote:
> > I'm not very confident about reading meson.build logic, but it
> > looks like this trusts meson/pkg-config to tell it about
> > whether it can do a static link against this library,
> > which doesn't work on my system, at least. (Ubuntu 18.04.4).
>
> Yes, and the same was of course true of pkg-config without meson.  You
> probably got the same warning that you reported on v7.
>
> In fact, my guess is that the "test $static !=3D yes" was added in reply
> to a similar complaint; the commit that introduced it has a note that
> the test was added by the maintainer:
>
>     commit 3efac6ebb88e4d099f07fef65178ebaa595ae770
>     Author: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
>     Date:   Tue Oct 23 13:23:10 2018 +0200
>
>     configure: add test for libudev
>
>     Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com=
>
>     Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>     *make libudev optional to avoid breaking existing build/test
>     environments
>     *disable libudev for --static builds
>     Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
>
> But I don't think --static should affect the build this way, especially
> since libudev was the only library that had this test in the configure
> script (checked in 5.1).  Debian doesn't package "libgtk-3.a" either and
> yet GTK+ it is not special cased in the configure script, so I'm not
> sure what it is that makes libudev special.
>
> Do you actually build just with "--static"?  Or do you have a list of
> "--disable" options so you can add one more?

Yes, I have a lot of --disable-foo options. Ideally I wouldn't
need any, because our configure/build system would identify "there
isn't actually a static version of this dependency present"
rather than blindly trusting pkg-config when it lies to us.
(Is it possible to get Meson to just always do a "test that
a trivial program with these cflags and libs will build" as
part of whatever magic it does as part of dependency() ?
Or to have a qemu_dependency() wrapper that does ?)

The useful thing about libgtk is that it's pretty obvious
that the --disable option to use to stop QEMU linking to
it is --disable-gtk. It's much less obvious what would be
the --disable option to use to stop us linking against
libgio, or libudev, because those dependencies aren't closely
and obviously tied to QEMU features. So for that kind of
library dependency it's much more useful to have configure
do enough checks that it doesn't try to link against something
that doesn't exist.

thanks
-- PMM

