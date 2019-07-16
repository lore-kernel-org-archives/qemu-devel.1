Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 017FFC76196
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 18:30:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD0852173C
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 18:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z8goQaDB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD0852173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnSDm-0006VK-TC
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 14:30:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59968)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hnSDb-000678-26
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 14:30:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hnSDZ-0007E2-QO
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 14:30:27 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:34172)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hnSDZ-0007D2-EL
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 14:30:25 -0400
Received: by mail-oi1-x244.google.com with SMTP id l12so16392246oil.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 11:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aquQzRbDZhel1v/OcBUNTs4hz8KN3JGbLntIZHDsHCQ=;
 b=Z8goQaDB2HUp1nYhzwfIr44iD+iFrycUW7R5JoyaZnIH04s/7bG9jZCENfTIyGu346
 cqtE2C/T2yKImMLaMdrV3jk9I66ZdcAKiEgafjGYaYPETsgfW6Vv1WRV7gscJTad6K/g
 cFgZP195oyDCgAXtzwVqm8NKTAglTl1pqFTbXdaxK+TMPFLmoaeZzRHbvxZVQNzdg++m
 pj+nRsdFt1x2dHtPcADutc/to8cXYPkzu+p13xH0xEe8OLk0aLt3JwRHQUl0H6iOZ/e0
 C7/rAikxNOzx/DgVfI6KB9tyIyGHjXqAO7boQVfX+C1wWjktKkc5Zd8xjvEBj06i/uPz
 eHgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aquQzRbDZhel1v/OcBUNTs4hz8KN3JGbLntIZHDsHCQ=;
 b=JIlyNbL5HLXCzORnbmVomk7GcunNu4oDMODqJKz2nAl5yz8HouHZHuXxQtevBMED54
 SSs4ivcOLnkamJ+/Bw+y4wjujsxUoM0Vz1DEN+fK4VFheGHeOrIkfW1inZJ0QPQXTsmd
 ANBvwCOEnj6MwQ3VOcbopfjKERFG4HtwPvMvzq9A81UG3rUYobnWbZhZq/X779mRBv4s
 7dOIQEGVfsnDQfP+6oKUsPonZBD/wxHD3RS+1ynk6g2pUQeQo+upIXkQrIPhs9TFZ5Hj
 bA0qx890L9ghLo0SvtCSfJe3/Ri1xfEJL2kw6LYsgXFSB6EOmPpfkd+zMhXZuJPIBrMO
 KwmA==
X-Gm-Message-State: APjAAAWv4OqTstc9Np9anvo6HjeIGP2hlFRx2bK139TZD7qHYMVkQxls
 07mhEzPn5dPk1O1FUrJl/Vu/0Q6+oSEYyrPrd5sj0w==
X-Google-Smtp-Source: APXvYqyEMdyQ5fydu1q0tBcetKJAPnaNVeZM6JF1nKhiS43Ln4LYLRq6Bxgwcb5EXnALxAddPo7mtXIRxBWdmYNnwhU=
X-Received: by 2002:aca:ac48:: with SMTP id v69mr16737511oie.48.1563301823843; 
 Tue, 16 Jul 2019 11:30:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAL1e-=jiySpoypabXMkUsO=2pqgUrRxUhac=JM_V=2sn2LPhWA@mail.gmail.com>
 <CAFEAcA9D9-LmOxoSHyibqprKofAWAvthCYYRe==e=F_ZjjpZ5w@mail.gmail.com>
 <CAL1e-=iSasCwJVm6aLOeGxnOd5-jzddOJ9X=VHDOKWiE03GCDQ@mail.gmail.com>
In-Reply-To: <CAL1e-=iSasCwJVm6aLOeGxnOd5-jzddOJ9X=VHDOKWiE03GCDQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jul 2019 19:30:12 +0100
Message-ID: <CAFEAcA_Lu-oroWzzXmjVp37NT20O2ZK4WrZLTiZq4_h69i2R_w@mail.gmail.com>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
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

On Tue, 16 Jul 2019 at 18:48, Aleksandar Markovic
<aleksandar.m.mail@gmail.com> wrote:
> "For distributions with frequent, short-lifetime releases, the project will
> aim to support all versions that are not end of life by their respective
> vendors. For the purposes of identifying supported software versions,
> the project will look at Fedora, Ubuntu, and openSUSE distros. Other
> short-lifetime distros will be assumed to ship similar software versions.
>
> For distributions with long-lifetime releases, the project will aim to
> support the most recent major version at all times. Support for the
> previous major version will be dropped 2 years after the new major
> version is released. For the purposes of identifying supported software
> versions, the project will look at RHEL, Debian, Ubuntu LTS, and
> SLES distros. Other long-lifetime distros will be assumed to ship
> similar software versions."
>
> However, any distribution is a "living creature". Packages are constantly
> added and modified, and Ubuntu 16.04 looks different at its inception
> and now, even though it bears the same version number, 16.04.

Ubuntu do actually put a sub-version number in here; if you
do 'lsb_release -a' on a properly upgraded 16.04 LTS system
it will tell you it's 16.04.6.

> The problem here (not directly visible from the policy) is that it looks
> as if we implicitly assume that any end user is constantly updating and
> upgrading their systems - and that may not be true.

We do effectively assume that to some extent (ie I don't
think we need to support the very first 16.04 release), and
I think that's not unreasonable, because if you're not updating
then you have a huge pile of security vulnerabilities you haven't
patched against. The vastly common use case is to stay up to date
within an LTS type release.

> I think we can't say
> to such user: "Why didn't you update your Ubuntu 16.04?" It is up to the
> user how he/she wants to use their OS, we can't and shouldn't dictate
> that - at least this is my understanding of our desired relations to the
> end users.

We don't dictate to users how they should use or update their
OS. But we do have to define a policy which balances the
amount of effort we as upstream would have to do (limiting
the set of systems we support is less work for us), against
the benefit to users of having support for a wider range of
systems. The deprecation-policy is where we've set that balance.
It is inevitable that there will be some set of users that are
left unsupported by the point we've chosen. We hope that that
set of users is fairly small, because we include LTS distros
in our supported set and give a 2 year grace period for users
to move forward; and many users who for stability reasons want
to stick with an older distro will also be staying with the
older QEMU and not moving forward to the most recent one.
But, yes, there will be some who are stuck on the older LTS and
still want the newer QEMU. That's unfortunate for them, but
we can't support everybody on the planet on every version of
Linux ever shipped since the 1990s. Those users get to
make a choice between remaining with their stable environment
(the QEMU we shipped to them originally still works and won't
evaporate) or moving forward to both a newer QEMU and perhaps
a newer version of their host OS.

thanks
-- PMM

