Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94306C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 17:11:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 608422187F
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 17:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qGYtt21G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 608422187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiime-0005zS-Mb
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 13:11:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44640)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <chmeeedalf@gmail.com>) id 1hiikq-0004eY-Uv
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 13:09:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chmeeedalf@gmail.com>) id 1hiikp-0001Ks-Pi
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 13:09:12 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:40671)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <chmeeedalf@gmail.com>)
 id 1hiikp-0001Js-IQ; Wed, 03 Jul 2019 13:09:11 -0400
Received: by mail-io1-xd42.google.com with SMTP id n5so6529251ioc.7;
 Wed, 03 Jul 2019 10:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+YD/hVFUwZeAELuj5wFjmTZuBwsLkpzFTf85UB81hbw=;
 b=qGYtt21Gx3Y20kssO7FQEnPAxHrNIJIydoXOY55rpp9mWHNfBRQOK3vYI4HMoH2HNz
 q9B0xwxfXfI4epWoS09+cld+zf4DzW3weU5GXqGSF91yYDkhKZYQTs9aCsoCl2ns+OJg
 +jHQlf0uvno/uwwputqxqS+eW7703tK/OtPtNzO7ADU01HeJuY9FxpqCFkRpf6cpGu66
 TPYe3j6YEA/FvQlmFfhehDv0O5OEcV+hfA5f3wT32ebF4lA03rAVSZNeprh2MA1qEAet
 weEngP2YI38En6WApOQTSGRjT1yqiamHgO8th9nZwq1IrfxsfEuetIgBVyg9m8o+ScjC
 E8JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+YD/hVFUwZeAELuj5wFjmTZuBwsLkpzFTf85UB81hbw=;
 b=m86mVa+uFfW6j+LmmjlEbwG+nfaSguYANMeBnESErnguZ1VSweMz29AGLEXVS47Njg
 zNhR01qN8dKXmoz/9NZ9VTddaya9vEt6uS/myW60Z7rQLPBXOwHbOl7Oao84A14bExf1
 hnj45/fdT4yq2jCOiXPkOPAcqW9YAN3H1bLXtRl6yf42GvyPPAad9lr8MPt37SSLPhza
 Yku++1sPnBwlKKU0cizKctvv+cfpm6l6Zqe9G8UJg6iQhwBkHE211Nhg5ALZIRBiQSh+
 CYYOLABoSevRLBurkkoWLgBYH9ElY64R2YMrTLGlPMpD2/atcESvUDgtSCNtBg/S7B81
 6cgA==
X-Gm-Message-State: APjAAAULJcftMtzLo+2+LHImh+axyskPuPYTWUV9EqU/55vRERDb8nZP
 doolDt5hFFR23queMLq2gsQ=
X-Google-Smtp-Source: APXvYqz8uuQfAQHZa2aq+JKnf0vX5Ej+zhKwQZUz3x/h0VssuCrBVAL3pa6Dz50DN97hvdori0/IDw==
X-Received: by 2002:a5d:8c84:: with SMTP id g4mr5747523ion.211.1562173750297; 
 Wed, 03 Jul 2019 10:09:10 -0700 (PDT)
Received: from titan.knownspace (173-25-245-129.client.mchsi.com.
 [173.25.245.129])
 by smtp.gmail.com with ESMTPSA id m25sm2503259ion.35.2019.07.03.10.09.09
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 03 Jul 2019 10:09:10 -0700 (PDT)
Date: Wed, 3 Jul 2019 12:09:06 -0500
From: Justin Hibbits <chmeeedalf@gmail.com>
To: Laurent Vivier <laurent@vivier.eu>
Message-ID: <20190703120906.00a6976e@titan.knownspace>
In-Reply-To: <EBA933C4-69B4-43BF-9049-FF1E6A327429@vivier.eu>
References: <20190702123713.14396-1-laurent@vivier.eu>
 <CAFEAcA_Zu0X1zLfKtBkQdi25KCkjf_PNu8zKWE5Dx7uzzLEzBA@mail.gmail.com>
 <5d7fa8ef-c56c-1f90-d5d6-b230d1e3f363@vivier.eu>
 <EBA933C4-69B4-43BF-9049-FF1E6A327429@vivier.eu>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; powerpc64-portbld-freebsd13.0)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d42
Subject: Re: [Qemu-devel] [PULL 0/3] Trivial branch patches
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 3 Jul 2019 18:12:51 +0200
Laurent Vivier <laurent@vivier.eu> wrote:

> > Le 3 juil. 2019 =C3=A0 17:22, Laurent Vivier <laurent@vivier.eu> a
> > =C3=A9crit :
> >=20
> > Le 03/07/2019 =C3=A0 16:45, Peter Maydell a =C3=A9crit : =20
> >> On Tue, 2 Jul 2019 at 13:39, Laurent Vivier <laurent@vivier.eu>
> >> wrote: =20
> >>>=20
> >>> The following changes since commit
> >>> 7d0e02405fc02a181319b1ab8681d2f72246b7c6:
> >>>=20
> >>>  Merge remote-tracking branch
> >>> 'remotes/vivier2/tags/trivial-patches-pull-request' into staging
> >>> (2019-07-01 17:40:32 +0100)
> >>>=20
> >>> are available in the Git repository at:
> >>>=20
> >>>  git://github.com/vivier/qemu.git tags/trivial-branch-pull-request
> >>>=20
> >>> for you to fetch changes up to
> >>> 7c955080d40ccc7952a0479bc160f2b048c0af53:
> >>>=20
> >>>  docs/devel/testing: Fix typo in dockerfile path (2019-07-02
> >>> 10:12:32 +0200)
> >>>=20
> >>> ----------------------------------------------------------------
> >>> Fix typo, fix sys_cache_info() on FreeBSD/powerpc,
> >>> change virtio-rng default to urandom
> >>>=20
> >>> ---------------------------------------------------------------- =20
> >>=20
> >> Hi; this makes 'make check' fail on OSX:
> >>=20
> >> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> >> tests/test-char -m=3Dquick -k --tap < /dev/null |
> >> ./scripts/tap-driver.pl --test-name=3D"test-char"
> >> Assertion failed: ((isize & (isize - 1)) =3D=3D 0), function
> >> init_cache_info, file
> >> /Users/pm215/src/qemu-for-merges/util/cacheinfo.c, line 179.
> >>=20
> >> I guess this is the sys_cache_info change. =20
> >=20
> > OK, I will try to reproduce the problem.
> >=20
> > I think before this patch (regarding the kind of change we have
> > introduced) isize and dsize were always set to 0 and then changed
> > to 16 in fallback_cache_info()... or perhaps MacOS X sysctlbyname()
> > needs a long. =20
>=20
> It seems MacOS X (x86_64) needs a long:
>=20
> #include <stdio.h>
> #include <sys/types.h>
> #include <sys/sysctl.h>
>=20
> int main(void)
> {
>         long size;
>         int ret;
>         size_t len =3D sizeof(size);
>         ret =3D sysctlbyname("hw.cachelinesize", &size, &len, NULL, 0);
>         printf("ret %d size 0x%lx\n", ret, size);
>         return 0;
> }
> $ cc -o cachesize cachesize.c
> $ ./cachesize=20
> ret 0 size 0x40
>=20
> #include <stdio.h>
> #include <sys/types.h>
> #include <sys/sysctl.h>
>=20
> int main(void)
> {
>         int size;
>         int ret;
>         size_t len =3D sizeof(size);
>         ret =3D sysctlbyname("hw.cachelinesize", &size, &len, NULL, 0);
>         printf("ret %d size 0x%x\n", ret, size);
>         return 0;
> }
> $ cc -o cachesize cachesize.c
> $ ./cachesize=20
> ret 0 size 0x1737b1d2
> $ sysctl hw.cachelinesize
> hw.cachelinesize: 64
>=20
> But man page is not up-to-date:
>=20
> $ uname -r
> 17.7.0
> $ man sysctl
> SYSCTL(8)                 BSD System Manager's Manual
> SYSCTL(8) =E2=80=A6
>      The string and integer information is summarized below.  For a
> detailed description of these variable see sysctl(3).
>=20
>      The changeable column indicates whether a process with
> appropriate privi- lege can change the value.  String and integer
> values can be set using sysctl.
>=20
>      Name                                        Type
> Changeable =E2=80=A6
>      hw.cachelinesize                            integer       no
> =E2=80=A6
>=20
> In fact, it is in sysctl(3):
>=20
> SYSCTL(3)                BSD Library Functions Manual
> SYSCTL(3) =E2=80=A6
>    CTL_HW
>      The string and integer information available for the CTL_HW
> level is detailed below.  The changeable column shows whether a
> process with appropriate privilege may change the value.
>=20
>            Name                         Type          Changeable
> ...
>            hw.cachelinesize             int64_t       no
>=20
> I will try to check on MacOS/X ppc and ppc64.
>=20
> Thanks,
> Laurent
>=20

It's not listed in the man page for ppc(64), but examining the XNU
source for the version that matches 10.5.8 (last ppc-supporting kernel)
it's a CTLTYPE_INT.  So, it may be different depending on arch and/or
OS X version.  Does QEmu even support 10.5.x or Mac OS/ppc* anymore?  I
had read somewhere that it was unsupported now (2.4.x is the latest one
in Tigerbrew).

- Justin

