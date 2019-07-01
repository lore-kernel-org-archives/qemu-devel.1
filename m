Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74A5C5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 21:38:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97FE620B7C
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 21:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GkVf5v/s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97FE620B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi40g-000285-Qt
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 17:38:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46759)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hi3H6-0003xK-0g
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:51:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hi3H1-0002y1-7g
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:51:40 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42337)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hi3H0-0002xD-OI
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:51:39 -0400
Received: by mail-ot1-f67.google.com with SMTP id l15so14888165otn.9
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 13:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=WlFEqtUXt54b0aOCl4ubcuGedgwjm1qKVcTQcTcPvjQ=;
 b=GkVf5v/sKAm49oELw8DDyHVoTY3sFXzsLpPldRK7kgmbg8cI+4Pyq7iyslKIrX1IpW
 JHBNGyFGzt51uXFUXN6vZJJRlOJ92yS3KevNQz8PM/5FAynOCQuiGKI6U8qiMYdIK178
 TnGBDCQ6qZkk98teJE8C/lx9fhsW7dwdt+AG5Cyv7pV6jPAkHjzE7PRdcnXSjGTu+ixw
 +TqvNbqp52BHlAR1wijsuIcBBHOdR8sy8T0omBpak76aXXDUBlAST0qmB1X/aOQloE7i
 TNAOtfEk5qK0NGMmLayguTRZ77o8Gln6ZdxS+NM9JeCa89hxr5t6ksNboRNmCgbLRbgR
 8xMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=WlFEqtUXt54b0aOCl4ubcuGedgwjm1qKVcTQcTcPvjQ=;
 b=t3iLKW8OqJ9I4gA3/Omlh00rNk9gVPm0EVuJahBtLaX0C42ojSehpXPJJVke9YKaja
 YH9hnaMkp32dG4r5FICvpOVwc8owIogdJMreHSxi1cH0bnzLJE5zYRVZokODbFwIMoaq
 OLdlkHoNz2NOkCSTWCPx/yTP2OuG+ETJp69FdVeWMzYtZ/UPYX+odRYCEmTIdVwQIVbc
 WN9S6ai2ZUKFqaFdu8Q6QSZGcUcZ4RbRlJrSGppuC7g6LnC6kACjKR3vdxT7quHNxKZm
 O/lOC6cT5FIVKy5gAcHfjPkVuVI2XKwy5IpVQVvqH8oaqToGpD7binTNsbPEopv6Uita
 pcOw==
X-Gm-Message-State: APjAAAV/VDBGk5CPRrNp28D98yOvUZro0NLIX2iZCq2NG5C7Utmm75cp
 2wmRYVUSiS9MYumR3UxnObQzlOazNWCe9O7Pgp4Mnw==
X-Google-Smtp-Source: APXvYqwGwN1Buy7nRoCIKIknJeJSC4VpEKAmCJxqkKVR79/MMLZVyGMQ6KTmylXul487TENWWNYFnqOsKfjCSuXw5OA=
X-Received: by 2002:a9d:6e8a:: with SMTP id a10mr21951626otr.295.1562000928342; 
 Mon, 01 Jul 2019 10:08:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:4798:0:0:0:0:0 with HTTP;
 Mon, 1 Jul 2019 10:08:47 -0700 (PDT)
Received: by 2002:a9d:4798:0:0:0:0:0 with HTTP;
 Mon, 1 Jul 2019 10:08:47 -0700 (PDT)
In-Reply-To: <CAL1e-=iogUENT-RESCwCs+tjLD7DBqJ3GamLyythSdcqQ9M==g@mail.gmail.com>
References: <20190701140143.32706-1-philmd@redhat.com>
 <CAL1e-=iogUENT-RESCwCs+tjLD7DBqJ3GamLyythSdcqQ9M==g@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 1 Jul 2019 19:08:47 +0200
Message-ID: <CAL1e-=jy+3aXffBchAai=obXOXwCMVddd8tw4hymccXpg3-x2A@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.67
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH] tests/machine-none: Test recent MIPS cpus
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, qemu-devel@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jul 1, 2019 4:53 PM, "Aleksandar Markovic" <aleksandar.m.mail@gmail.com>
wrote:
>
>
> On Jul 1, 2019 4:45 PM, "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com>
wrote:
> >
> > The MIPS I7200 got added in commit d45942d908e, and the I6500
> > in commit ca1ffd14ed8.
> > Extend the coverage on the little-endian machines.
> > The 4Kc and 20Kc are still covered by the big-endian machines.
> >
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > ---
>
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
>

If nobody objects, I am going to select this patch for mips queue scheduled
tomorrow.

Thanks!

Aleksandar

> >  tests/machine-none-test.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/tests/machine-none-test.c b/tests/machine-none-test.c
> > index 4c6d470798..5953d31755 100644
> > --- a/tests/machine-none-test.c
> > +++ b/tests/machine-none-test.c
> > @@ -36,9 +36,9 @@ static struct arch2cpu cpus_map[] =3D {
> >      /* FIXME: { "microblaze", "any" }, doesn't work with -M none -cpu
any */
> >      /* FIXME: { "microblazeel", "any" }, doesn't work with -M none
-cpu any */
> >      { "mips", "4Kc" },
> > -    { "mipsel", "4Kc" },
> > +    { "mipsel", "I7200" },
> >      { "mips64", "20Kc" },
> > -    { "mips64el", "20Kc" },
> > +    { "mips64el", "I6500" },
> >      { "moxie", "MoxieLite" },
> >      { "nios2", "FIXME" },
> >      { "or1k", "or1200" },
> > --
> > 2.20.1
> >
> >
