Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC236C7618F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 17:48:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E9112145D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 17:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UxIUgtz2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E9112145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnRZL-0006bD-Ib
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 13:48:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46913)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hnRZB-0006AA-8A
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 13:48:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hnRZ9-0004k9-Td
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 13:48:41 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:34579)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hnRZ9-0004jS-Mf
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 13:48:39 -0400
Received: by mail-oi1-x244.google.com with SMTP id l12so16283233oil.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 10:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Z9SkStwO1AoE+m8LMM41CL8SOoISvWLakq2MF8C+BEM=;
 b=UxIUgtz2wD3oSAhbZAN5a6mfvDeUO78HUGn8E4RXkrymS+vD77tokUhU4QSo1hwZVK
 wXh2hZfAgyFuXp+P4IAiNxgafy4NzJHCLAdgPDH5onH52EyJi5HYfKZSq5iDv+KHMQq+
 XTTMxr1qo2a+KCACr2xAi6T6wank0jQzAnMLVUVNjdRQCiqTgquBp8ShfjKmWEJT3+4S
 FNNhOE/WszmbXV8kJTZ2kcm9CaKVgPAH1nhZg+/cPAuxnApHUnTyqbix4qCxb3ZWthBL
 YXJyC8pbKkOriv/jX8KcPzRKiTRtfiVFsCJhTo7WHLK7wJ5FYX1kLIOlQBv+9be+Do4N
 DK8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Z9SkStwO1AoE+m8LMM41CL8SOoISvWLakq2MF8C+BEM=;
 b=CCNpUBipWLVZ+uHShOFflc3NeTKCNxWfBPbgYyFvgPENIRrAhchOCMWo76SWLF/wAR
 Wd5uUEEVfjV5nH+q/Xa3EITJxlIUKs1U+p/c86CWB4muOTnjGcy2pZvNDuB8mmFuNeYL
 bAFd2R+Mb6aE7wQsuxseYbi5eL0u9g8YIv2y9x6ltQx6kZHxsIVaAGC7XWaNKju0Zqey
 06en1E2dZloTWQzxkMOrwbOazi6Xdh0kcIUCU2x5kbJcJGI1IAUlp4qTTTDAnbmURc5v
 vZA65F8/vedpq4GXY1UcqPEKXrFVukP0rzPKH09iiRX94X3g2cqAYT6+1Ypb/P/jUMgY
 4oTw==
X-Gm-Message-State: APjAAAVz116tdV5HlhtxY4b/tTlz/v6JAqeEn86Y7qOILzcnX/yR4Y09
 zRKUywIVBbweaV8x6xgl8ltWT7Uotse8xbRBoYg=
X-Google-Smtp-Source: APXvYqyvlhRDqKB5hwjfOIkDqq8Qqzz9OlM4ajeyAmMzA32syqXUqb7S0NNkTJjipWYbQedsWZL0p7G+prYfbb4x4aU=
X-Received: by 2002:aca:4083:: with SMTP id
 n125mr16674750oia.106.1563299318604; 
 Tue, 16 Jul 2019 10:48:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAL1e-=jiySpoypabXMkUsO=2pqgUrRxUhac=JM_V=2sn2LPhWA@mail.gmail.com>
 <CAFEAcA9D9-LmOxoSHyibqprKofAWAvthCYYRe==e=F_ZjjpZ5w@mail.gmail.com>
In-Reply-To: <CAFEAcA9D9-LmOxoSHyibqprKofAWAvthCYYRe==e=F_ZjjpZ5w@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 16 Jul 2019 19:48:27 +0200
Message-ID: <CAL1e-=iSasCwJVm6aLOeGxnOd5-jzddOJ9X=VHDOKWiE03GCDQ@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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

On Tue, Jul 16, 2019 at 1:41 PM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Tue, 16 Jul 2019 at 12:17, Aleksandar Markovic
> <aleksandar.m.mail@gmail.com> wrote:
> >
> > Hello, Gerd, Daniel, and others involved.
> >
> > I have multiple reports from end users that say that transition from
> > SDL 1.2 to SDL 2.0 was difficult, or even impossible for their hosts.
> > In that light, they don't appreciate removing SDL 1.2 support from
> > QEMU. The most notable example is Ubutnu 16.04, where it looks there
> > is no way of installing SDL 2.0 that does not involve complete OS
> > upgrade, which, for various reasons, many are not willing to do.
>
> One of my build test machines is an Ubuntu 16.04 system
> (specifically 16.04.6 LTS), and it has SDL2 installed
> and the built test includes compiling the SDL2 UI. So I'm
> not sure what's happening with your end users -- do you have
> more detail on what their setup is and what isn't working for them ?
>

I gather that their systems are one of earlier versions of Ubuntu 16.04
that has SDL 1.2, and not SDL 2.

Let me explain the situation in more details. The build and test beds in
many organization are often maintained in a state that is not subject to
change over time. This means no updates/upgrades, except some
really rare exceptions. The rationale is that build and test beds should
be "constant" in time to achieve reproducible build runs and test
executions. In some organizations such setup is frequently achieved
by using virtual machines that automatically revert to their initial state
on each reboot.

But I digress. Let me quote our Linux deprecation policy for reference
for future readers here:

"For distributions with frequent, short-lifetime releases, the project will
aim to support all versions that are not end of life by their respective
vendors. For the purposes of identifying supported software versions,
the project will look at Fedora, Ubuntu, and openSUSE distros. Other
short-lifetime distros will be assumed to ship similar software versions.

For distributions with long-lifetime releases, the project will aim to
support the most recent major version at all times. Support for the
previous major version will be dropped 2 years after the new major
version is released. For the purposes of identifying supported software
versions, the project will look at RHEL, Debian, Ubuntu LTS, and
SLES distros. Other long-lifetime distros will be assumed to ship
similar software versions."

However, any distribution is a "living creature". Packages are constantly
added and modified, and Ubuntu 16.04 looks different at its inception
and now, even though it bears the same version number, 16.04.

The problem here (not directly visible from the policy) is that it looks
as if we implicitly assume that any end user is constantly updating and
upgrading their systems - and that may not be true. I think we can't say
to such user: "Why didn't you update your Ubuntu 16.04?" It is up to the
user how he/she wants to use their OS, we can't and shouldn't dictate
that - at least this is my understanding of our desired relations to the
end users.

> > It looks to me that depreciation of SDL 1.2 was a little premature. My
> > humble opinion is that we should not look at release dates of
> > libraries when we deprecate them, but release dates and end-of-support
> > dates of major Linux distribution that include them.
>
> That is indeed the way our deprecation policy is supposed to
> work -- we care about the versions of libraries that distros
> have shipped in their LTS, not what the upstream library
> release schedule is.
>

I think there seems to be a hidden unclarity in our deprecation policy,
related to the situation I described above.

I appreciate your response very much!

Yours,
Aleksandar

> thanks
> -- PMM

