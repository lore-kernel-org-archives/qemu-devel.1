Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9801DC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 13:40:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64FC32073E
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 13:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aJ78G3Bq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64FC32073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCkXf-0005bF-Lg
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 09:39:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37483)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jCkX4-0005BS-KS
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 09:39:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jCkX3-0005CA-5T
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 09:39:22 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:38286)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jCkX2-00059r-Uw
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 09:39:21 -0400
Received: by mail-oi1-x241.google.com with SMTP id k21so9363373oij.5
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 06:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2I0zqjn7tdVb7sDRhlzp12q3TauVt9PtldlTFQwvpEE=;
 b=aJ78G3BqXvLi2Ak1sU1zWZFV4vF45KpdPHSf419sP+Y7j/a7U3R1s5uNw/e+V68Q5S
 rjC17vZA4TKQZCCNqQxmVnxKjPBV8LdX98idyTwjhppXmmV/Fy0o03xXssErssApw9nf
 RpUyIJBzaTEgf87WZhZlMYf5jgV+lbLGDqrRh445SIQ2QmDDy89ErF2ngjVQr8L/Wq7Q
 5payQwt22v7rdyjG+M5z+7Y+UBqIWHSM08Feo0AlTQo3fV1d2vTYzGFI0BlEQvKc4AwQ
 m2THK8qmn2xfVN2TyzDFfSOXZmQQ9wpyI1+WKwVFEP9Nu4bupExudy/Kx6EJ0Y7t6nX1
 YXSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2I0zqjn7tdVb7sDRhlzp12q3TauVt9PtldlTFQwvpEE=;
 b=jLER6767Z426BwkN5/wdtmleRkWv6Sr0th5gdndSerHf3rnVXV/wfF9OX0Gxfcwdxq
 ih6ooBf9XOo74RksDDIH5MUzw5OEuhPOnIn2mr17gn+U6B54ryUTBOUbQRtJIKFNogXb
 ckxzGNRYvAIEHcluucJC/+JqLSfeVKQ0szz4bJWmej1WshtGanuB5XDWhPNvviA8R6Gf
 BPhlXmZMFUHGXhEgKYpsSgVsFtmOC73LSfQF8oHrRbwlVaiI2onathK3d/TOA39c36ii
 SvwvhbDyXyEL8e0qjB2zdksolZ8ZHRHZDbLH8WDtrmYPpZokWA5JD2E6bRF5lGh7DiPN
 E8RQ==
X-Gm-Message-State: ANhLgQ0MoQJcEy1cCNrgw6mE3BbG6lZXuEZYr7C8rJ1fD0kbczn3nmMR
 OxblSGl5xN2ZMyyzlJz9jVOG+cdWVUWJaqjTCHuPqg==
X-Google-Smtp-Source: ADFU+vtKniM6fFmHNPM2sSfOcC9+a/ib0L7/ucpLJQAhl9HTCkJEwQ/RXMkaNc/RL738xuDS2JR/SJ9jff/H7Z9+hmE=
X-Received: by 2002:aca:5b07:: with SMTP id p7mr6692105oib.146.1584106759995; 
 Fri, 13 Mar 2020 06:39:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200313123014.206828-1-dgilbert@redhat.com>
 <CAFEAcA8KPovUiycEr2hHb4LP0SL-hBCTNgkA9KFKMb6FQTceuQ@mail.gmail.com>
 <CAFEAcA9pBMC0W9cHKmq5nttPcA9qpYofSvkZEnmkGuS2g_vPTA@mail.gmail.com>
 <20200313133451.GD3581@work-vm>
In-Reply-To: <20200313133451.GD3581@work-vm>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Mar 2020 13:39:08 +0000
Message-ID: <CAFEAcA-E-pu_SBbZAWE5Sg1qRVm7jT-idbd4CCdk3h=yYNNOQg@mail.gmail.com>
Subject: Re: [PATCH] exec/rom_reset: Free rom data during inmigrate skip
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yan Vugenfirer <yvugenfi@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 13 Mar 2020 at 13:34, Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
>
> * Peter Maydell (peter.maydell@linaro.org) wrote:
> > On Fri, 13 Mar 2020 at 13:21, Peter Maydell <peter.maydell@linaro.org> wrote:
> > >
> > > On Fri, 13 Mar 2020 at 12:31, Dr. David Alan Gilbert (git)
> > > <dgilbert@redhat.com> wrote:
> > > >
> > > > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > > >
> > > > Commit 355477f8c73e9 skips rom reset when we're an incoming migration
> > > > so as not to overwrite shared ram in the ignore-shared migration
> > > > optimisation.
> > > > However, it's got an unexpected side effect that because it skips
> > > > freeing the ROM data, when rom_reset gets called later on, after
> > > > migration (e.g. during a reboot), the ROM does get reset to the original
> > > > file contents.  Because of seabios/x86's weird reboot process
> > > > this confuses a reboot into hanging after a migration.
> > > >
> > > > Fixes: 355477f8c73e9 ("migration: do not rom_reset() during incoming migration")
> > > > https://bugzilla.redhat.com/show_bug.cgi?id=1809380
> > > >
> > > > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > > > ---
> > > >  hw/core/loader.c | 23 ++++++++++++++---------
> > > >  1 file changed, 14 insertions(+), 9 deletions(-)
> > > >
> > >
> > > >      QTAILQ_FOREACH(rom, &roms, next) {
> > > >          if (rom->fw_file) {
> > > >              continue;
> > > >          }
> > > > +        /*
> > > > +         * We don't need to fill in the RAM with ROM data because we'll fill
> > > > +         * the data in during the next incoming migration in all cases.  Note
> > > > +         * that some of those RAMs can actually be modified by the guest on ARM
> > > > +         * so this is probably the only right thing to do here.
> > > > +         */
> > > > +        if (runstate_check(RUN_STATE_INMIGRATE) && rom->data) {
> > > > +            /*
> > > > +             * Free it so that a rom_reset after migration doesn't overwrite a
> > > > +             * potentially modified 'rom'.
> > > > +             */
> > > > +            rom_free_data(rom);
> > >
> > > Shouldn't this condition match the condition in rom_reset()
> > > for when we call rom_free_data()? You want the behaviour
> > > on a subsequent reset to match the behaviour you'd get
> > > if you did a reset on the source end without the migration.
> >
> > Wait, this *is* rom_reset(). Now I'm really confused.
>
> The exsiting rom_reset gets called multiple times:
>   a) During init
>       This actually copies the ROMs and then calls rom_free_data
>
>   b) During a subsequent reboot
>       This is mostly skipped because rom->data is now free because
>       of the prior call to rom_free_data during (a)
>
> During an inbound migrate, (a) happens before the migration, and
> (b) happens during a reboot after the migration.
>
> The problem is that 355477f8c73e9 caused (a) to be skipped
> then when (b) happens it actually overwrites the ROM because
> the rom_free_data had been skipped.  What I'm doing here is
> doing the rom_free_data(..) which causes it to then skip this
> iteration during (a) AND causes it to skip it during (b).

OK, but why is your condition for when to call rom_free_data()
in this special case not the same as the condition that we
use in the normal no-migration-involved case? I would expect
those to match up.

thanks
-- PMM

