Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF7DDC35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 18:54:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB934214AF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 18:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ka5K5z05"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB934214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izPox-0008NB-Uh
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 13:54:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36073)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1izPoM-0007qR-9U
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 13:54:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1izPoL-00085P-0j
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 13:54:06 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:38453)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1izPoK-000831-PF; Wed, 05 Feb 2020 13:54:04 -0500
Received: by mail-oi1-x244.google.com with SMTP id l9so1828775oii.5;
 Wed, 05 Feb 2020 10:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UZ0bX6T6pi3Kt/fWzzu7atALwWihp9KxFsFA+tnR25Q=;
 b=ka5K5z05vBeVpJqUQmtLw8DdEx0GTGXptUn8YP2xnvhWtfHusUZy7+EOwdqpEF9RZ4
 hJKxn4qDEZOXT4FR67ukmVczBGqe8j4TH+zlgAVcQ7Xy2lwQ1msm22TKjWB00LBSg3Gb
 /f/Ni8RUNZrxVBY1YWjCupCdkc0TVasBgdy75BjrE7eQqMCV/KiFqRkBesxM/pFV3qYl
 wcOuK1ASWngr3H90awsv3xG4BiiIzeddZjReboYiHXvAIv/N7oilhV16CjCZLAs+TH7C
 PNycdT5TP/tYjuVCYQLcTmMgl/fYOlzEKLTFBd0Vobm4wbBmTUXVL0eBiNWrqR3LSxNv
 xPjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UZ0bX6T6pi3Kt/fWzzu7atALwWihp9KxFsFA+tnR25Q=;
 b=iZiVc/ReYZhjzBFCYMq2hGDI2VgI661C5eZosfcuKq2tt+aag3/eXwiQX8H3ehEY4h
 Cf9QQzKSQRAm1RTF34u9pBSxxuKuVHY5ZTiwzo52wsGP8hKl+L+2Glfg68A1pSR6j+4P
 J2lpJ7ja1M9rshEhRUIwXKOonDLx7N+HvjLRQFhkr0rI9G19wnaeUmdgEFZKth4p+rC/
 JJSxVa17cyd8hs2iA6J1eTvVEfAcaE/B3vZx1vGnWEVB0zE80b7XT6abR30Cn4bnp4mP
 YikG0AUV1+1JDi2tbqPRd9xDvrkRfqQX0xjiEhXjghjPdvCVn33G94fKNMsAaIhOR0jW
 VaJQ==
X-Gm-Message-State: APjAAAU5Dc5PnaW6OAcRMkQfLlBxFglvhevSreFXnnoDXalAkeU0cL9+
 XxrGNU76BzTZfQ6TjPci4qsV4BG1CemGf9lB+uo=
X-Google-Smtp-Source: APXvYqzpQo0okBMnGOg80xOJBb6dPWqcz00FnrG0FT//Wk/ixsATKOfS4YBONMfIHEfuM3kaLDV3Et7eJHd79nCyHUA=
X-Received: by 2002:a05:6808:64e:: with SMTP id
 z14mr3815280oih.79.1580928843800; 
 Wed, 05 Feb 2020 10:54:03 -0800 (PST)
MIME-Version: 1.0
References: <20191120091014.16883-1-thuth@redhat.com>
 <20191120091014.16883-4-thuth@redhat.com>
 <7a775153-f18d-e766-1d8f-33607f5fa05b@amsat.org>
 <2396dfd4-6c85-d17a-b358-bd058c757f14@redhat.com>
 <CAAdtpL7vPCQ8k91nvBWc_NLrmhu6OPVprUSL8uzi_v6HMiSrnw@mail.gmail.com>
 <CAL1e-=gd-ymYd3_cods8BAtwbQeJFodmnmsNo-gLx381rXHKxQ@mail.gmail.com>
 <20200205175115.GT2221087@redhat.com>
 <CAL1e-=jHpNmTdWSiHZ_StC0MXjLLsyq0cfSE=45=6SwoFnfiaA@mail.gmail.com>
In-Reply-To: <CAL1e-=jHpNmTdWSiHZ_StC0MXjLLsyq0cfSE=45=6SwoFnfiaA@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 5 Feb 2020 19:53:52 +0100
Message-ID: <CAL1e-=ivAZCj990c+47kVdcaOUgU5sDvoWZNWAMHmVJWd9L3Vg@mail.gmail.com>
Subject: Re: [PATCH for-5.0 3/4] Remove the core bluetooth code
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 libvir-list@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 5, 2020 at 7:03 PM Aleksandar Markovic
<aleksandar.m.mail@gmail.com> wrote:
>
> > The deprecation policy is primarily intended for notifying of changes
> > to QEMU's stable interfaces ( CLI, HMP, QMP) which affect behaviour
> > and usage of QEMU at runtime & are liable to break apps managing
> > QEMU.
> >
> > Changes to build time options have no strong reason to be subjected to
> > the deprecation process.
>
> This sounds reasonable to me.
>
> But: Should our deprecation policy be clearer on what is subject to
> our deprecation procedure, and what is not?
>
> Regards,
> Aleksandar
>

And, there is even a section devoted to the build system in
https://qemu.weilnetz.de/doc/qemu-doc.html#Deprecated-features :

    B.10 Build system

    B.10.1 Python 2 support (since 4.1.0)

    In the future, QEMU will require Python 3 to be available at build
time. Support for Python 2 in scripts shipped with QEMU is deprecated.

The wording above comes from the file in our source tree: qemu-deprecated.texi .

Shouldn't the cases like "--enable-blues" be documented here? I think
the deprecation of bluetooth devices support should have included a
short section on involved configure options here.

Why is Python 2 support different to "--enable-blues" support? There
should not be some unknown and arbitrary criterium what do and what
doesn't come in this subsection.

Or, if our build system is not subject to our deprecation policy, than
what is the entire subsection "B.10 Build system" doing here, in
section "Deprecated features"?


> > If we remove an option at build time the effect
> > is noticed immediately and the solution is straightforward (stop passing
> > the option). We have added / removed configure options at will with little
> > negative feedback historically. We'll have far biggest changes coming to
> > the build system in future too, with the introduction of meson.
> >
> > I don't think we want to constrain & complicate our work in modernizing
> > the build system by declaring that any changes to it must go through
> > deprecation.
> >
> > Regards,
> > Daniel
> > --
> > |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> > |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> > |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
> >

