Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6BDCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 16:04:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C8602064A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 16:04:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C8602064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNfb7-0000NJ-Mj
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 12:04:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40231)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pmathieu@redhat.com>) id 1iNeCg-0007Sy-NF
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:35:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pmathieu@redhat.com>) id 1iNeCf-00039b-Hp
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:35:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:2167)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1iNeCf-00038C-8x
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:35:05 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8CB1381F25
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 14:35:03 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id z5so1363384wma.5
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 07:35:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Twd/G+y8iSXLmGHx2fj4YB/D7ZUndAyxQxNB6ivdobA=;
 b=AiOCDkunZdBEr+jt2e0x+xiwRtvOMroat3iSNwWpO1rFgiAWIyXjYnvOwy7pD5Mdh7
 XVA+zhys3P8ob4V26sUvfc99ro803iCClzw2sDLQTd5lFQybJu56K5H2F4w2LvLvV6lS
 YTKpQIXhUIRkDuyQB3lsJPIdsiq0lQloYjBF84RUNPYiYTaeUStlLZhyMVwk1jMIl5fA
 hf4rVhtHqSsa3LuxV1io/d9z1MG63v1FCcmIgfT4HaPTGA7PeMJGzTQHs58I0NLSCT0N
 P0MpBJDvDQs6y60SOb/OWLricHx4y8XQAXcL3pDM0u+wnlJU7E73oTKXily8uoGT0b+A
 0KMA==
X-Gm-Message-State: APjAAAWYuHHwnhcFjnoSZTDzjA37+uuU4AZAS2QwEXgR0bc4nWLwHxTA
 KslEYrwhuAuLg8DzM+XQMqntfL3PSRD4GWN7pnbXbipM4HGZ2fXTUhrZPEFGIjESppBljFx/kSb
 DvN7qDFiTMp+7gVkawPZ3gzCcrlMzeKc=
X-Received: by 2002:a1c:4e15:: with SMTP id g21mr4879358wmh.148.1571927702292; 
 Thu, 24 Oct 2019 07:35:02 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx+LmiOrcuJKshqxvHuApoMeFbgKgMYy7aN9cEbSS2UrtU0+wdGVEPEa+ifj5WLZ09BEcpBLFMPzl4/mARtzx4=
X-Received: by 2002:a1c:4e15:: with SMTP id g21mr4879342wmh.148.1571927702103; 
 Thu, 24 Oct 2019 07:35:02 -0700 (PDT)
MIME-Version: 1.0
References: <20191024102240.2778-1-alex.bennee@linaro.org>
 <20191024102240.2778-16-alex.bennee@linaro.org>
 <c4ea7902-b3ad-47ab-ad56-42f604473922@redhat.com>
In-Reply-To: <c4ea7902-b3ad-47ab-ad56-42f604473922@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Thu, 24 Oct 2019 16:34:51 +0200
Message-ID: <CAP+75-X4VY=Hk77po2pGF-qjM4dxUQdMC5QaYi=pqMnaoLRxkw@mail.gmail.com>
Subject: Re: [PATCH v2 15/17] travis.yml: --enable-debug-tcg to check-tcg
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 "Emilio G. Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 24, 2019 at 4:33 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
> On 10/24/19 12:22 PM, Alex Benn=C3=A9e wrote:
> > This adds a whole bunch of asserts which will catch bugs you might
> > introduce into the TCG code.
>
> Very good idea.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
> >
> > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > ---
> >   .travis.yml | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/.travis.yml b/.travis.yml
> > index c43597f1331..ba3a8d4cfc9 100644
> > --- a/.travis.yml
> > +++ b/.travis.yml
> > @@ -334,14 +334,14 @@ matrix:
> >
> >       # Run check-tcg against linux-user
> >       - env:
> > -        - CONFIG=3D"--disable-system"
> > +        - CONFIG=3D"--disable-system --enable-debug-tcg"
> >           - TEST_CMD=3D"make -j3 check-tcg V=3D1"
> >           - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-default"

Hmm maybe we should change the ccache name now...

CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-debug-tcg"?

> >
> >
> >       # Run check-tcg against softmmu targets
> >       - env:
> > -        - CONFIG=3D"--target-list=3Dxtensa-softmmu,arm-softmmu,aarch64=
-softmmu,alpha-softmmu"
> > +        - CONFIG=3D"--enable-debug-tcg --target-list=3Dxtensa-softmmu,=
arm-softmmu,aarch64-softmmu,alpha-softmmu"
> >           - TEST_CMD=3D"make -j3 check-tcg V=3D1"
> >           - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-default"

Here too.

