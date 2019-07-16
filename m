Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39D2C7618F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 17:10:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF9FC206C2
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 17:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IC9/iUEj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF9FC206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnQxk-0001md-MT
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 13:10:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36363)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hnQxa-0001Om-OE
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 13:09:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hnQxZ-0004zj-P1
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 13:09:50 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e]:39312)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hnQxZ-0004z2-KC
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 13:09:49 -0400
Received: by mail-oi1-x22e.google.com with SMTP id m202so16168962oig.6
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 10:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mQ4z8KfJSdMWeWXpD+vh/TlMxlkTmkFZarDs/hC1xSY=;
 b=IC9/iUEj8BoWJT9FK+tRkumMuxVEENVAibjLpmyEVN7kAkpCXyhijDDIBrMiFTWSxI
 BxUxtWqSqXExb2uJ5U1bO+yipnjotn71y6Je9sIHmj10aOe96SrhC7yfzep/qrfvR6+2
 m4IMcaVVvglUapmEHb3nG3sA9o8W+orURRT0V2rdYSHjXt3TIumcAgpDAZBnXfJ2OumM
 +dEszvnO3Fen2PIvRb4BqLJ4yxB+Rl4dZG2teyobZZFT+jqtCj+dOQLw7q5hF76LYNe0
 qjPMKR9wVjXVRYoTipwGF/sVezusSjugtYd5JRj6dhTwI9T/6dhmqPTJkO8aBPIYWySL
 m1UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mQ4z8KfJSdMWeWXpD+vh/TlMxlkTmkFZarDs/hC1xSY=;
 b=gHNrNNySfApDZdvoK05XnokjpsIih95Io3fEAoYjmnp0shV29v5XVxP7Ni5tC0jcV6
 cIPOOtsaGsvt7TjHzT+3bo+pXa3Dz+GRycwfqtCSP2WQUzxbvP92jdqPSl2i0zQVQmP5
 c8RWjujgd3q6ipJn4U2Ywkyt3mnOiBKD4PH9DTZMg1m3PdOdQ5cpumCRRrNAU1Ii9HWU
 gtUvozFwds3z7Q/y6U5UFPo/hS+NMAe1WjrT4ACgAz0Oy3aeR8O3COyIntzLLph9NkUe
 6s5aDSn4YHaNSt3YFbzWclkqP21OKzW87TgpJ1muMIzPQwUr+jvat/lJRx43XmGJGGWa
 94XQ==
X-Gm-Message-State: APjAAAV50GykCDCxqMt/5zWXRcgaFBKNoWCw1oZFb3WtnUWwzxHF6UJQ
 +wMth32VdGQgEWLq7HciN1Skns3zLrq+dC3CqoY=
X-Google-Smtp-Source: APXvYqzlJaJRgqKTER5stpNY5IBI2NsGeZZqmuFgHV+PLmuT2+VHUTIfJT9wTTW6oyPXi1KDB0q3hyhneZdiXp/PJCE=
X-Received: by 2002:aca:4083:: with SMTP id
 n125mr16560375oia.106.1563296988805; 
 Tue, 16 Jul 2019 10:09:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAL1e-=jiySpoypabXMkUsO=2pqgUrRxUhac=JM_V=2sn2LPhWA@mail.gmail.com>
 <054d5b29-6482-1d71-3866-057dd00cb021@redhat.com>
In-Reply-To: <054d5b29-6482-1d71-3866-057dd00cb021@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 16 Jul 2019 19:09:37 +0200
Message-ID: <CAL1e-=ikCpJO1bn=AKYSLWb8QNYkf6062ojxn+UN3svXCEQvFA@mail.gmail.com>
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22e
Subject: Re: [Qemu-devel] [QUESTION] SDL 1.2 support
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
Cc: "berrange@redhat.com" <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 16, 2019 at 1:54 PM Thomas Huth <thuth@redhat.com> wrote:
>
> On 16/07/2019 13.17, Aleksandar Markovic wrote:
> > Hello, Gerd, Daniel, and others involved.
> >
> > I have multiple reports from end users that say that transition from
> > SDL 1.2 to SDL 2.0 was difficult, or even impossible for their hosts.
> > In that light, they don't appreciate removing SDL 1.2 support from
> > QEMU. The most notable example is Ubutnu 16.04, where it looks there
> > is no way of installing SDL 2.0 that does not involve complete OS
> > upgrade, which, for various reasons, many are not willing to do.
>
> What's the problem here? According to
> https://packages.ubuntu.com/xenial/libsdl2-2.0-0 the library should be
> available there.
>

Yes, we, as developers, are good at upgrading, we like flexibility in
our development systems, and naturally want to try latest and greatest
tools and libraries.

However, in QA / build / test environments, the things seem to look
different. Their main concern is stability and repeatibility of their
systems. They don't like updates and upgrades. If a new of library
is available for an OS, this does not mean it will be installed, or it
will be desired to be installed.

It appears that Ubuntu 16.04 came originally with SDL 1.2, and
SDL 2.0 was made available later on.

That is the problem: We make, in my opinion, an incorrect logical
leap here: we assume that if a package is available for an OS, it is
installed (or should be installed) on any instance of an OS.

Yours,
Aleksandar

