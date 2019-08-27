Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8EEC3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 14:27:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B93D2184D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 14:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M5usQZD3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B93D2184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2cR1-00007V-Rh
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 10:26:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40591)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i2cQM-000885-RS
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 10:26:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i2cQL-000801-Ev
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 10:26:18 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:45402)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i2cQL-0007zf-6P
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 10:26:17 -0400
Received: by mail-oi1-x243.google.com with SMTP id v12so15077463oic.12
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2019 07:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=uONHJPamT9tocW7B2+QJlFqugFF5JHNme8pGAKigzDQ=;
 b=M5usQZD3Dsd8okioVZ/3p1CIoZrXhkPCgeEnl5a9raO/PzXWjaxR9uxaHvBjdM6+u/
 As0VRH8o87oS7mS0tUyXP2eayDvGCamdya7EirUMqkFVtVrVgCqHP7kTCthNTiaD0ODA
 zNEF3IrnV99de4T1fl1ntM4SLnPAtUf2JWf5jt9tA9rEU+WSaNfoZaqKjmA0P8o2c/uW
 /QVyLDky+NvC3DEbNmlfRlp8DQ0yj0zdP6ITarIIfGxLu/MJahwmmv9eM4WJS2w4DEM8
 CLBzfYBm0xWCt+ztd59TtZVRkoTaZB534j70lPJ4JhXuMhCKPStPCCKEYSqvvz2aPh3T
 kEsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=uONHJPamT9tocW7B2+QJlFqugFF5JHNme8pGAKigzDQ=;
 b=h4bb95oX+ee5lbtdPP0OMEVDTKKcw+xaVikN2wVMmRBJtk3TGceoYFzmBBFRRusITd
 zuGULm4vsR3OeZTLUUzVyjHPXtmsJt6FzazuV+IBFjYHYij8lwlHRX3wA3Dm5uy/NEqY
 NN4NsuxjOIIyJJpu39i/3yDA6B7N9tiNuiOBn+3V1jcNPNsCGjYpbTaCRiTDQkdg/AIB
 tW/abJVHUWzUdQoOb3ED+TO+JS6BpX7e0DYEH/OmyJyZkH1/Bu4iErIlbnHDcmmC8OOe
 VYIJURS4hYPHqPmHtFkhw5+h1IX8u8V3H0GpLuK/gopiAMbLliS3RfL7O9VcfIrkN1hL
 enKw==
X-Gm-Message-State: APjAAAXWfmbw3czLcfEwJhh7fh+uBosOOiLHLKsiGBblpNWrrOvJmlz7
 KXh9KxlGCeAbbg5rKz0f5TcopuNN0sDzcrIsIZIsQPNgltU=
X-Google-Smtp-Source: APXvYqzeg/6nbH+i+MQ5xWyC/E2lZbNvPIAEiI6DD2nFONEdiTOQMtS4kBCM2wGYJu/uRMwdR3fjpDcwJXrpwER3eg4=
X-Received: by 2002:aca:4814:: with SMTP id v20mr16454944oia.98.1566915976182; 
 Tue, 27 Aug 2019 07:26:16 -0700 (PDT)
MIME-Version: 1.0
References: <1566495734-23297-1-git-send-email-pbonzini@redhat.com>
 <9492af41-2125-9543-203a-312f0cd9087c@redhat.com>
 <CAFEAcA__BNnW4oSyv4iTAd7rsMUfcjyNJgk0nOwbkRQtmLj9jQ@mail.gmail.com>
 <dd473e9b-716d-cd9f-47bd-433d2b17687d@redhat.com>
 <CAFEAcA81qUSMqpMTCrs9-vgj7Wmji2dCDkYrQ91wxmhTiP83Xw@mail.gmail.com>
 <dd60f779-8349-1d0d-eb86-645e2e1b0808@redhat.com>
 <CAFEAcA9i1p6XR8Bc83uHD88EWrtmU-aN_PsuZYNAAFgpgWoZgQ@mail.gmail.com>
 <CAJ+F1CL6dXxH2MgZU=DaCeqHFu2LtDiYsve+gwsJym5APDH9kw@mail.gmail.com>
In-Reply-To: <CAJ+F1CL6dXxH2MgZU=DaCeqHFu2LtDiYsve+gwsJym5APDH9kw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Aug 2019 15:26:05 +0100
Message-ID: <CAFEAcA-zVs4KkGicVZ-E4T-V-hyDRJZCfr5FfXWfR8LHtBtJOQ@mail.gmail.com>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [PATCH] modules-test: fix const cast
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 27 Aug 2019 at 14:39, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
>
> Hi
>
> On Tue, Aug 27, 2019 at 4:02 PM Peter Maydell <peter.maydell@linaro.org> =
wrote:
> >
> > On Fri, 23 Aug 2019 at 13:10, Paolo Bonzini <pbonzini@redhat.com> wrote=
:
> > >
> > > On 23/08/19 14:07, Peter Maydell wrote:
> > > >> Are you going to apply this and "[PATCH] modules-test: ui-spice-ap=
p is
> > > >> not built as module" to qemu.git directly?
> > > > Is the other one also needed as a build fix ?
> > >
> > > Yes, otherwise the test fails (it didn't fail in the meson tree).
> >
> > Both this fix and the ui-spice-app one are now in master, but
> > the 'enable-modules' Travis build still seems to be consistently
> > failing -- could somebody take a look, please?
> >
>
> I am looking at, it seems to be related to default machine
>
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> QTEST_QEMU_BINARY=3Daarch64-softmmu/qemu-system-aarch64
> QTEST_QEMU_IMG=3Dqemu-img tests/modules-test -m=3Dquick -k --tap <
> /dev/null | ./scripts/tap-driver.pl --test-name=3D"modules-test"
>
> qemu-system-aarch64: -machine accel=3Dqtest: No machine specified, and
> there is no default
>
> Use -machine help to list supported machines

Yeah, you need a machine type. If you need to run code on the
QEMU instance you need to know what machine type you're expecting;
if you aren't and you're just doing qtest stuff then -machine none
may be appropriate.

thanks
-- PMM

