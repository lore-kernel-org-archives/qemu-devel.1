Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7896BC76192
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 11:42:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42ED6206C2
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 11:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VdcdGATK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42ED6206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnLqP-00042G-Ik
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 07:42:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41801)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hnLqF-0003dk-QU
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 07:41:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hnLqE-00039g-NN
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 07:41:55 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d]:43458)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hnLqE-00031z-F4
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 07:41:54 -0400
Received: by mail-ot1-x32d.google.com with SMTP id h59so16802756otb.10
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 04:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Esv5MXQFuvTN61B+ot5W13bdZbX2F4yNdpqQuNZ+SBA=;
 b=VdcdGATKvwaQOJO+Cq7RXEoG5ntVg7YYkaPjDyKqwtwor9oOs7VT0u+OHBrsBc5l2H
 zKvyL2yNirBhuo5Ziqzppm6bs1nBifqohpWwNmv6eEOWQFvkn2PsOND1M74QUiz07ryR
 +ZRggS16BOSTFert2WlhuHAGPiG+5jEgLsMQ/92SFZMBnhx+aXA1y1/HaLuAneGNySVX
 rxB0XW7MkRB1CNEM/LRxJKjNUyjT7XKWTQZz3cmcd5F8483MAReH8tJBMzJTzVJokODY
 damd57HoVSjSd9jqtCDbm1UGpk9uqUzWvr8jAhfzujA3WK2kWmOFpo81T/m0NFObIkva
 +6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Esv5MXQFuvTN61B+ot5W13bdZbX2F4yNdpqQuNZ+SBA=;
 b=eDYMRA6UXRLT5SY2sKfSzAziLs0MJEDS0r4Y6l7zwR02OPtiMRebc9MU5au8hW+W8c
 Xd5ebaGmFI3X1vfyy8YL71Ia1Gj8MIo1gnG4ucRZJvJFHpj9btbkBZF+v8V0SGV1tclE
 3IBR8Q/YxwxuwR+1CGBhdS5Ol9Dp2OPx/h4OizBI4yfUBVsatBQYmM1JAsawJIl2TVos
 oZh9Dk+Gu9GCgtQ046VsugeV2WjZE282a2iF4ac/B2u9TKHLdGBdLAP8KKqbwXCEpIu8
 7lBzD7b/B7hZ+3i+Z6ctp4TZtQay7pVWBm2tIlqOoB4Aj/Pbcr9EE52FSRoF72J+eInf
 5X/Q==
X-Gm-Message-State: APjAAAWaCLIMIzd21C128eerte+2KheY0a8y7fe7CXlaW7e+DvIKuHVq
 N6rTF/qErjeQ2fxEjoCUq6c6+L9h46zooUy02Qs4Qw==
X-Google-Smtp-Source: APXvYqz74ypFI/jtr+JOmrhvclOxBITov87OVChWV6ikUAtsstLXkEWUvs9C0aSkQGMgPbKpT3CCBMLqTJFTEXc6ksM=
X-Received: by 2002:a05:6830:1653:: with SMTP id
 h19mr17165969otr.232.1563277297474; 
 Tue, 16 Jul 2019 04:41:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAL1e-=jiySpoypabXMkUsO=2pqgUrRxUhac=JM_V=2sn2LPhWA@mail.gmail.com>
In-Reply-To: <CAL1e-=jiySpoypabXMkUsO=2pqgUrRxUhac=JM_V=2sn2LPhWA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jul 2019 12:41:26 +0100
Message-ID: <CAFEAcA9D9-LmOxoSHyibqprKofAWAvthCYYRe==e=F_ZjjpZ5w@mail.gmail.com>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32d
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

On Tue, 16 Jul 2019 at 12:17, Aleksandar Markovic
<aleksandar.m.mail@gmail.com> wrote:
>
> Hello, Gerd, Daniel, and others involved.
>
> I have multiple reports from end users that say that transition from
> SDL 1.2 to SDL 2.0 was difficult, or even impossible for their hosts.
> In that light, they don't appreciate removing SDL 1.2 support from
> QEMU. The most notable example is Ubutnu 16.04, where it looks there
> is no way of installing SDL 2.0 that does not involve complete OS
> upgrade, which, for various reasons, many are not willing to do.

One of my build test machines is an Ubuntu 16.04 system
(specifically 16.04.6 LTS), and it has SDL2 installed
and the built test includes compiling the SDL2 UI. So I'm
not sure what's happening with your end users -- do you have
more detail on what their setup is and what isn't working for them ?

> It looks to me that depreciation of SDL 1.2 was a little premature. My
> humble opinion is that we should not look at release dates of
> libraries when we deprecate them, but release dates and end-of-support
> dates of major Linux distribution that include them.

That is indeed the way our deprecation policy is supposed to
work -- we care about the versions of libraries that distros
have shipped in their LTS, not what the upstream library
release schedule is.

thanks
-- PMM

