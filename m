Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F12C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 09:54:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 546D32192A
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 09:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KOkYbrw8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 546D32192A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izdrT-0001Bu-Em
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 04:54:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44701)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1izdqV-0000c3-9I
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 04:53:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1izdqT-0000Hl-SS
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 04:53:14 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:42802)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1izdqT-0008Uq-Is
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 04:53:13 -0500
Received: by mail-ot1-x32b.google.com with SMTP id 66so4891409otd.9
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 01:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=vvG/3UNvQndCiBHy7fbvZVLT633wNDfGYgFo52BQbqY=;
 b=KOkYbrw8cec9Nvi3+0LP4MVcAZL9l3lo/59re+I6yTDMVKN7lTGHnA/l7E1y3aP/Ht
 Fu2Jl6nmbfjaETKYbsdvLSDVpJrM0u4q33cr2ztf6WGIV7/fF1VL3X4KjgVB2Sjb0cwC
 2tRXB1+vEDH20frW2DHw+ThvvSMHOI59V3nGe5/W5euCdYZalEAoOAxzo9cKwIL0Erev
 kkY5jCbPs00yjqy99bwNNvXJM2KVX8OQY5DOnQ8o3WMCciaiHkAEuCcMVIZLNWv01fag
 cKGTrp01z5ou8vu/H5sU+uJ9AlIqTXbMnUski2i748eqDsvPxGyy0UWJqgg0uNgMqm7j
 hG3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=vvG/3UNvQndCiBHy7fbvZVLT633wNDfGYgFo52BQbqY=;
 b=sIzusJd61dPoboNzRdL7DrIitgwlSKmrf9RIZB+RTkcY/KxykJpsy/I1tQuoERWPe/
 +z1CxLfytyHXIis30u5xrJvrIkvEbB9sg8UjQOE8Wa74KUOR5QKoyjuLfUnPBeLWUS+O
 BHHyPrYZwbT2EmsVjCwlT5E0/jsz3Z8DEqT8lC+2/hN0A5KKxptDoTSjrK2tgLHXbOEo
 bQToYX2VJeTLUo2djERWTAHzCMbJtb+LqD8E9UVjOfTwwmA+Fig76ea0C/AJ1J/8XdCm
 /lLUTAuQfsOo1lfePLAeDf4UwG+fQlKmPoCP9joXaca08DepO+hY2585vZgup695lIyY
 Hxyg==
X-Gm-Message-State: APjAAAXN77605SuLIFUa+Lh7raBxtvS2fxd5wjLCR2aNZ3/2BoZnoCo2
 rLp+SDEkfrlWcLMqkH88MLyTFthqlRVlr3MhDmEzEA==
X-Google-Smtp-Source: APXvYqwwPUm3M0GaWHECWJ/nYVTwp5+ctik9qX26RQhh/oIQedwYMOIpRPczhT379asuMo3a9IRVlvEV9gASGveVm0w=
X-Received: by 2002:a05:6830:13d3:: with SMTP id
 e19mr29922698otq.135.1580982792332; 
 Thu, 06 Feb 2020 01:53:12 -0800 (PST)
MIME-Version: 1.0
References: <20200204184028.13708-1-alex.bennee@linaro.org>
In-Reply-To: <20200204184028.13708-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Feb 2020 09:53:01 +0000
Message-ID: <CAFEAcA8C2ruo+Swp3LvMxJp9DoQXGGYAKoA8bM2Y0XaHR2vk+w@mail.gmail.com>
Subject: Re: [PULL 00/16] testing updates
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32b
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 4 Feb 2020 at 18:40, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> The following changes since commit 7bd9d0a9e26c7a3c67c0f174f0009ba19969b1=
58:
>
>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-202=
0-02-04' into staging (2020-02-04 16:12:31 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-testing-040220-1
>
> for you to fetch changes up to 68e5b85e41fe7684e58cd077772b7d1e8bc092c7:
>
>   .travis.yml: ensure python3-sphinx installed for docs (2020-02-04 17:13=
:29 +0000)
>
> ----------------------------------------------------------------
> Testing updates and build fixes:
>
>   - move more cross compilers to buster
>   - fix build breakage (hppa Kconfig)
>   - disable docs on shippable
>   - build docs under bionic with python3
>   - travis.yml re-factoring
>   - check capabilities of non-docker compilers
>   - smarter make -j parallelism


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

