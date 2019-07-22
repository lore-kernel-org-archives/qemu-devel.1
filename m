Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F794C76190
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 14:16:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ECF221911
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 14:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RgFS/zbd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ECF221911
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpZ7F-00070K-Dh
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 10:16:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34738)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hpZ73-0006bt-NH
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 10:16:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hpZ72-0007Uc-Nu
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 10:16:25 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:45774)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hpZ72-0007UI-IB
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 10:16:24 -0400
Received: by mail-oi1-x241.google.com with SMTP id m206so29667855oib.12
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2019 07:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Y5jP81ToIFpqCZKsZwrZ0gM2++g5b+5yLi7jHA3zf58=;
 b=RgFS/zbdCRQ6oX+g9bS1z/qM9PH0KCpwl8+oY+YP8pEhjEdzZpHjRW8z2g1WIwNxG/
 ggMzpNmWxGOw4AE0ceDMM7lbvdFN5lxyc/9xBmljQvr28Pz51qI95pOUOCb4b//x7qDL
 9ZSnw5adJkzUtV8tkpqprj2enDxoc5hqukRhrQbW3dg4MwQy4tA1olUL4rFCu5ebD9Jg
 qxvd2U0LZMUlM4K6SIQI/qjhdso1Lx7F55KAdgGAkDvVBLeUnMe3czRQ4FDJjbBJ7PBQ
 BBjBQiPNOEp5pVu8VZZCIL3Rxl0kTYqHxftgRmze+CX5qQm9rQYeHW3KhkBdwMemxEpU
 w8BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Y5jP81ToIFpqCZKsZwrZ0gM2++g5b+5yLi7jHA3zf58=;
 b=bB8CO5F/NL7hmcrljD++QchEkhkYAxA3kljT/9g/ON2MA1Q6I3X7j2zuHHZbwDdVrg
 GYOdDF2S0nTDcOIIITvOvBLSdiPpAl+lKZ4StFJ1qgYk4n4G4sr9M5j52ffUIytUaMEg
 z/1J8js0wTqlzhA/Y1gHX/fthj5iPhPZoG/aLrzc8r4pg2SUDmoVXZmijo2StDkiJxVq
 Oq/fJVvLsX7ggJCw3wtjjgO5IIudvEqrkT8tTOhDYcCV51j0qsdy5UOQHg9aN5GnvD5w
 TNRGDzo4896AM6e07x0YkgsdFzhipEHslN/D7ok7AfOKFRh+LwCVvY8cQivi5eVDPhyd
 3bNQ==
X-Gm-Message-State: APjAAAUH/LITiabhNUZSEXOymFuHbPh/PADhs8xiRSrybWBZaMKWvATH
 lBmRAKnfe1+YVVgNk1wy2w5uTXFCjdH8u/1pcZxRWw==
X-Google-Smtp-Source: APXvYqxzlRxCPmrTpX4FN6OMgtfRctP+L8xZxkr/4ISetrwwk7DL5IRTYStBjzczS//4SLJ7IA/5cXho8G1vGpZuAHI=
X-Received: by 2002:aca:ac48:: with SMTP id v69mr33363424oie.48.1563804983862; 
 Mon, 22 Jul 2019 07:16:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190720151846.7450-1-pbonzini@redhat.com>
In-Reply-To: <20190720151846.7450-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jul 2019 15:16:13 +0100
Message-ID: <CAFEAcA_vOhmAcQDW8Eg7jhdMdeoGYwU3EponOJ-PAZ=_W10fLg@mail.gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PULL 00/12] Misc patches for QEMU 4.0-rc2
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

On Sat, 20 Jul 2019 at 16:19, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit e2b47666fe1544959c89bd3ed159e9e37cc9fc73:
>
>   Merge remote-tracking branch 'remotes/berrange/tags/misc-next-pull-request' into staging (2019-07-19 14:29:13 +0100)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to d4b976c0a81dc625ccd05e2b3075f353170669d4:
>
>   target/i386: sev: fix failed message typos (2019-07-19 23:45:28 +0200)
>
> ----------------------------------------------------------------
> Mostly bugfixes, plus a patch to mark accelerator MemoryRegions in "info
> mtree" that has been lingering for too long.
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

