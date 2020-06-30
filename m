Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF85C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 19:20:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1352A206C0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 19:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkTVbUw2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1352A206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqLnr-0007wE-59
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 15:20:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42898)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jqLjE-00014i-1N
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 15:15:36 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f]:43087)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jqLjC-0005tL-6g
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 15:15:35 -0400
Received: by mail-lj1-x22f.google.com with SMTP id f5so8029999ljj.10
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 12:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=frrsInF8bWDxkckWByVwp5XV8jqUNQmqXa6WiUylT0w=;
 b=EkTVbUw2XoBGisT5gscaOY/3d3stWkUiE6kAxXJ8ZJOCtcHtv/vZZIvNV1jzvPphyP
 I5iQJVXfSI8k4oi/oKM0A8uOjQalQ/ExtfnT4VHIcxE2Xq70C4zgzqHNT8V9hi/HL8PQ
 /eG2KtW4i6EQz8+vovgVDvyokEqss1LBQb2QFYKngTMjcltgt9Z0aras3YYNfqQh5zFb
 +CLVI5/wqJFSyDzOiG0VDs5A6nUwy8mG33YHNzkutKP+zRGMiF6TlEM9EOOiiUpEoRSz
 uQD2nh2F1WvyDNohgqINPY9B0sEVthA2ZwZcGwhmCbpzMddFrhqabVOfrrAu90cYSvT0
 3FcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=frrsInF8bWDxkckWByVwp5XV8jqUNQmqXa6WiUylT0w=;
 b=OOpQoaClDCG7DXdIFJYEIMUI3YEgyx5IzFihr0iiqyFjXAezc4eXmxax5tcRZokZQK
 n0PA/ywgOfPyDXxdU6Eg9RZ1RYBX4iLxvfVLQjkFFDjgoNMAagj1UhZF1IAb2tJoGJ2y
 dhuLttqsgSgZstO3QzlF/c6NvQrMYiRf5lgar+aTsoR3BnB7Gm8bDCkhaYsshir4QBvJ
 9vT43dMMeimzyS6TKdgq5CDdnehgJFo+4JN+TXmLBVwzJeQXmdyJFmnyo9jPdU66eFzv
 hz63OuPglcQSlSiNUESTypOuimgzBrFNyuQjRryjIYCZL/CM+BgSEJe1j3p3UczHo1A7
 z8rQ==
X-Gm-Message-State: AOAM533OZeLqyQXKhjBRgbgK3E9A6hYefuST8RviZSE0QHFScb1sIi18
 YIsdYcHs3d9/rmOKUlLty32gwUgWRsCpQf45a3w=
X-Google-Smtp-Source: ABdhPJzBN14fAJfA1m8DliyvLg+FcSe3+PmvA+MSNvWsMTQl78pgEc5Ut9UFak15wfC8ZHXVNDTyZGGnYKLUTn5lNKU=
X-Received: by 2002:a05:651c:1044:: with SMTP id
 x4mr10674758ljm.409.1593544529722; 
 Tue, 30 Jun 2020 12:15:29 -0700 (PDT)
MIME-Version: 1.0
References: <CALTWKrVAW33jJs1Q+51wN07DDUbAqwo=o+WDCpoT=NFB6dNZ6A@mail.gmail.com>
 <5ff8e75e-787e-a34d-2b3c-da63e2e46e1f@redhat.com>
 <CALTWKrUOjwi9xG7vXCQ9sXStFaPh782ytwwPbztAp_PNuHFHYA@mail.gmail.com>
 <CAHiYmc7tYYWb6AMQeFtCOQFXWbzB4+jGx1Zia+uvDd8ej+rieg@mail.gmail.com>
 <54168dd1-2907-37ef-20d4-9feddf7c7561@redhat.com>
In-Reply-To: <54168dd1-2907-37ef-20d4-9feddf7c7561@redhat.com>
From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Date: Tue, 30 Jun 2020 21:14:50 +0200
Message-ID: <CALTWKrXDqu-eo5OtyN1EpHirktJgUBWQeoid6HADksKR5Ft=tg@mail.gmail.com>
Subject: Re: [REPORT] [GSoC - TCG Continuous Benchmarking] [#2] Dissecting
 QEMU Into Three Main Parts
To: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, 
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=ahmedkhaledkaraman@gmail.com; helo=mail-lj1-x22f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 30, 2020 at 2:46 PM Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>=
 wrote:
>
> > However, we know that the results for hosts of different architectures
> > will be different - we expect that.
> >
> > 32-bit Intel host will also most likely produce significantly
> > different results than 64-bit Intel hosts. By the way, 64-bit targets
> > in QEMU linux-user mode are not supported on 32-bit hosts (although
> > nothing stops the user to start corresponding instances of QEMU on a
> > 32-bit host, but the results are unpredictable.
> >
> > Let's focus now on Intel 64-bit hosts only. Richard, can you perhaps
> > enlighten us on whether QEMU (from the point of view of TCG target)
> > behaves differently on different Intel 64-bit hosts, and to what
> > degree?
> >
> > I currently work remotely, but once I am be physically at my office I
> > will have a variety of hosts at the company, and would be happy to do
> > the comparison between them, wrt what you presented in Report 2.
> >
> > In conclusion, I think a basic description of your test bed is missing
> > in your reports. And, for final reports (which we call "nightly
> > reports") a detailed system description, as Mr Lukas outlined, is,
> > also in my opinion, necessary.
> >
> > Thanks, Mr. Lukas, for bringing this to our attention!
> >
>
> You're welcome. I'm more on the python side, but as far as I know differe=
nt cpu models (provided their features are enabled) and especially architec=
tures result in way different code-paths. Imagine an old processor without =
vector instructions compare to newer ones that can process multiple instruc=
tions at once.
>
> As for the reports, I don't think that at this point it would be necessar=
y to focus on anything besides a single cpu model (x86_64 Intel) as there a=
re already many variables. Later someone can follow-up with a cross-arch co=
mparison, if necessary.
>
> Regards,
> Luk=C3=A1=C5=A1
>
> > Yours,
> > Aleksandar
> >
> >
> >
> >
> >> Best regards,
> >> Ahmed Karaman
> >
>
>
Thanks Mr. Luk=C3=A1=C5=A1 and Aleksandar,
OK, now I see how important it is to have this information somewhere
on the reports page.

In response to Mr. Yongang, I said I will create an mini-report as a
guide for setting up the testbed.
I will add a section to this report with the detailed hardware
information of the used system.
Thanks for bringing this into attention.

Best regards,
Ahmed Karaman

