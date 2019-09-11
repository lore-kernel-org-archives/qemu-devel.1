Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD50C49ED6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 12:01:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47D602085B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 12:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nv2WubTd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47D602085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i81Je-0007Hw-Cn
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 08:01:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43348)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i81In-0006jz-JS
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 08:00:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i81Im-0005kj-6X
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 08:00:49 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:35612)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i81Il-0005k9-Uf
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 08:00:48 -0400
Received: by mail-ot1-x342.google.com with SMTP id t6so9037316otp.2
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 05:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=znBKtWGumXHEWuNX1v6kCONpTPR5H+awa565uDytD3k=;
 b=Nv2WubTddl9YRW9NLAUPUC2GbImLnWvDXc0iekHavCUTqJrHkMYaod0ske14HXszEb
 mMfWELXYDGDLQ5AQy2MK0z5jGCiytpVd+BCHoS/KPFu1CjTuixHeO/WACDOqk6gYy8k0
 Sf90Ks1UV5fnQn41m6LxRe9YTpxWqoveYmbP2g8OTtaD/xynXV1ccOXKZ0xYA+ee7l77
 XUuS2TOkt1zlb6Im5idhuzpihY095QwBa1KHpKCJ4iDhEU13cD3kUQtjpDOMSChouGQq
 d7XbwMsa4mYPnoXyoeJr7X4epuBTiV6sHAm+izsB1JRGXtMooYA5yzjGx0O6q/Hu3WDk
 hQqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=znBKtWGumXHEWuNX1v6kCONpTPR5H+awa565uDytD3k=;
 b=Z0FnJK3xj7tQuAxmCY1xPQnjGJC2hpqImZcbODOcALII5zx+Lz08Et/omIVr+Rs+K+
 CGDWnDZz8uDeGAV2aRrg/nrm+F7rdbgLsAtxP8s4HDoLHLWNXGiVJYbmDds/Ce6tNep+
 1g7ESkZUDaj2LehIAlWwewWXUnc7QvH8u8ZhJrp6eLcbfsoqBWoaNfZYVi70Z2EcDwn7
 Llew2mPAwAoDjznYPeaWfLiErR/3RJV5lBiNnRg8UFcLAy1c6Lr393H4WV2OnNxBmfKb
 +Ez0JZ+lvA4iPYh7+0C9SJjDH8zAkeHDzLbSYTjPG6a1uWAY/WjDYnUu6GyRgl994Qj8
 /6bg==
X-Gm-Message-State: APjAAAWcDeHQ8bF+7/t2EmFZf+Vq5BotV4rlrj7XEyXwZ2uIC2mHuM12
 X+pWm5xX84tc31ZdgIpTY9PTAPLehUBGyG17GEHXEA==
X-Google-Smtp-Source: APXvYqzgxRrHdAxjvK0Osfz1dDEnU7xUib/UM3bgXyv9YKZhJSfIVh90f5MgOv5D/NMiO6VSBAEFWnrnAyqq/p8UWTc=
X-Received: by 2002:a9d:6a8a:: with SMTP id l10mr26316069otq.97.1568203246756; 
 Wed, 11 Sep 2019 05:00:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190906202636.28642-1-alex.bennee@linaro.org>
In-Reply-To: <20190906202636.28642-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 11 Sep 2019 13:00:35 +0100
Message-ID: <CAFEAcA-DQ0Zq40Xnw5wkA6ojOUCf67xfX83nMEoKW_UrysJhjQ@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v4 0/4] semihosting at translate time fixes
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 6 Sep 2019 at 21:26, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> Hi Peter,
>
> Hopefully this is the final version of the semihosting at translate
> time patches. I've applied Richard's IS_USER changes and gated the SVN
> for !M profile.
>
> Alex Benn=C3=A9e (3):
>   target/arm: handle M-profile semihosting at translate time
>   target/arm: handle A-profile semihosting at translate time
>   target/arm: remove run time semihosting checks

Hi. I've just been looking at these, and I noticed that
they seem to accidentally extend the "no semihosting
in user mode" check that is currently for softmmu only
to also cover linux-user mode (where it would amount
to "never provide semihosting"). This is because we used
to do the check in the helper.c code which is only used
by softmmu, and not in the linux-user/arm/cpu_loop.c
equivalent that linux-user uses. But now we do the check
in translate.c, which is common to both.

There's also some missed cleanup in that the linux-user
code can also have the "maybe EXCP_BKPT/EXCP_SWI is a semihosting
call" checks deleted.

> Emilio G. Cota (1):
>   atomic_template: fix indentation in GEN_ATOMIC_HELPER

I've taken the atomic_template fix into target-arm.next,
since it's unrelated.

thanks
-- PMM

