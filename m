Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A10C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 19:49:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7EF3207EA
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 19:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D0nnus9j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7EF3207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTsCy-00045H-Vx
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 15:49:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56330)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kTsCO-0003fN-T6
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 15:49:04 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530]:37731)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kTsCN-0007tB-38
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 15:49:04 -0400
Received: by mail-ed1-x530.google.com with SMTP id o18so6181073edq.4
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2020 12:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bJ2+RKKO2hShYrtnT80GJolwY6KQv/PA9+FS2Ht8/6M=;
 b=D0nnus9j5n/Zfcpr+pSke6QXUjbvLS/JNbvWVd/IL81u6rWQnHaSc158aeseEf3k0l
 LjXI8z8IzZEb7jRXTivHIRijyGKMhL0//IBscb6fjLTlEySEjXkf9zx/KXsd5ONrInQu
 OeCaBWl6yWaKZEL9A5s5+l1Il5P5eiprU0cVTjXMz2LTbR19+T18NJ8D9DZsDUExV/rZ
 OAum1GbE/dQO4amIoJ8Inyx0Z5Z3/bR4zRKyRtGbNa6dilRqQVdONDZayPVke9GKZ6T0
 TmxFbBjdKa5blPoArCw1zpPV4yTI15Oht7yoKOoGTs+6TbRUWNw7+bJWHkNfrjgIaUNT
 qkIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bJ2+RKKO2hShYrtnT80GJolwY6KQv/PA9+FS2Ht8/6M=;
 b=SOa1hGFCulf1157iK4xv6xdcVTwdb4aV5j79xjVuNP1HhBnh5l6szlFetMrWTm+Q5B
 m6bKmZCK7OzppHoZZTjQ5D52gTivJpKcYNpNzYMRTZYKG/Rl8xjeFTlZs/pd6ZnsGS/G
 arezmbINuVAuIkq9cb8YLtkmK8OSlNxLu9s7l6j7912Nz6g8nAYSHuIXngckUPXCVkX9
 Oh4mfn6d9XOL0qvIjWDnU/F+Oe+o7GWXWhJxr4Qv9pPI0/ZUrlNkaVO/N7IdnKTUroI6
 58buKJwJcFAENwVVlQjH51lf79GpA1VFN7Bp7JjZOAuDpyS5MxfzT68Lqk5GA+V+Oj+g
 G32Q==
X-Gm-Message-State: AOAM530hO7CqANjHxyI29YWA7meqHypzrsxdm6QAYPI+uNlbfgf3Si3p
 aC7fyfIgOx2lvATgYCgv2GBKPAOT/xBM6aNNucLdeQ==
X-Google-Smtp-Source: ABdhPJyO+SHzbX5q3pEs8Pm+mDZs4YmW0ydPNB4aYIVocvia8LWnCKyIU0GncpqRv12muGIKDDTnyNJPZA3PeyxdLqw=
X-Received: by 2002:a50:9ea6:: with SMTP id a35mr10990854edf.52.1602964138401; 
 Sat, 17 Oct 2020 12:48:58 -0700 (PDT)
MIME-Version: 1.0
References: <20201016155331.1613089-1-pbonzini@redhat.com>
 <CAFEAcA_ZW2mq3ygzCjuphW2kkdOy4fcTzDObcyQTw0BJJgspZw@mail.gmail.com>
 <ecd2b5bf-0c3c-fa58-ce4d-3d4d55274424@redhat.com>
 <CAFEAcA_HDoheozjRjcAKy3eEJ94cBgU29FDftMe2yn=SdMKHMA@mail.gmail.com>
 <03d83be5-db1a-3856-5243-66b0f7bdc724@redhat.com>
 <04d2d02d-e5c0-ac69-1de5-f3d7bac32883@redhat.com>
In-Reply-To: <04d2d02d-e5c0-ac69-1de5-f3d7bac32883@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 17 Oct 2020 20:48:45 +0100
Message-ID: <CAFEAcA-HiKQ5Kj7-kJhJjzCjd80-OPhiUFUzJVJcCNo7z2w4tw@mail.gmail.com>
Subject: Re: [PULL v2 00/22] Build system + misc changes for 2020-10-16
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Yonggang Luo <luoyonggang@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 17 Oct 2020 at 17:37, Paolo Bonzini <pbonzini@redhat.com> wrote:
> Ok, so the warning remains when everything is fixed, though the text is
> slightly different (and better):
>
>   Library iconv found: NO
>   Run-time dependency ncursesw found: NO (tried pkgconfig)
>   Library ncursesw found: YES
>   Library cursesw found: NO
>   ../src/meson.build:540: WARNING: curses library not usable, disabling
>
> In this case, meson.build warns because curses doesn't always have a .pc
> file; therefore when meson.build doesn't find the headers it can't but
> proceed without curses suport.

> The "library found"/"curses support disabled" situation is a bit
> confusing, which is why I've been adding some kind of message for those
> few cases in which we cannot just use pkg-config.  (The multipath test
> is already warning, but those libraries are a bit niche so you probably
> don't even have the libraries installed).
>
> Peter, I would like your input on these two things:
>
> 1) are you going to pull v3 and I can fix up everything later?  Or would
> you prefer me to send v4 once the new curses test is reviewed?

If the only issue with v3 is that stray warning message I'm
OK with applying it and improving the test later.

> 2) would you prefer the "library was found but headers weren't" to warn,
> issue an informative message, or be completely silent?

I think the build system should just say whether it found a
working curses setup or not, and do our usual "this is fatal
if --enable-whatever, otherwise just disable feature". If we
happen to have convenient information to put in whatever
the new build system's equivalent of config.log is [ie the
saved-for-debug-purposes log], we might as well put it in,
but we don't need to put that in the stdout. (We shouldn't
say "ncurses found: YES" unless we actually found a working
version, ideally.)

thanks
-- PMM

