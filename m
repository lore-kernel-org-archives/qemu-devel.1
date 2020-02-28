Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD9DC3F2CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 14:03:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDEEA246A8
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 14:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qGA8S8p7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDEEA246A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7gEj-0006Hn-SJ
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 09:03:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33064)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7gDo-0005pE-Sf
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 09:02:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7gDl-0002Uv-8B
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 09:02:31 -0500
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235]:39780)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7gDl-0002Sn-1y
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 09:02:29 -0500
Received: by mail-oi1-x235.google.com with SMTP id r16so2910073oie.6
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 06:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6qOEi3AtUyJ6rW3AeCGD4dVYtKAuRDJtJwJyUMflLsI=;
 b=qGA8S8p7x+7dUUPbtt9F8EtQYp6BXCNPxyz5rAnJQCZ5s5sqvyJorX2ViIeQM9/5kj
 Q+3g54dyhgkBhhy8DDllQpmraw3yzJHwVeZjMBHCtJEPRku43adq/0zouOvAXfnpVc+F
 Czlwaob04C9XcKkCiq3MnJhyCDN33T6vjSJFRbI5CLbRZ9okZgnjb1uEz2Tu9epi9w2o
 OzchtWzbB+sEe7OqjZJmJPFNkc3u5CBILeA5J4/xuWXia6ySmyBmXxN/2hVlG53QOYiV
 Rj7FfhEFIEwkNhNlQ8HOm4Rtb8inWbYUYOMnG5wAwBTmzOrwIcsZZtlunMFECwrCKjzu
 IIqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6qOEi3AtUyJ6rW3AeCGD4dVYtKAuRDJtJwJyUMflLsI=;
 b=rx4l1UFYb1z8aXmpMj+/xmq3p0gCjxDmnZHV02sOq1frFYW+WmJEgO0ckyNczZgTXK
 kUkP9OLxn/HPAp2Cyb7JYLQMGhcDnzlyjtDa/VhhvC4etO7dnZoORCGp8Qmsf0zFKOq+
 ZF928UF7Y6ljSSwKH2Cw6U8QLyNA2nt7hQr4qQgt3M0Kdkq1PUTNEus4W8N+7yzm553Y
 RAcdUlGDFb8+0re2bK5NkuE/4RFI3cHluFzh9jb2p9UbYztlwmEeDX6Khi9Ko8ANt4CT
 rbcSJjZFFatKoqDxrH34qzlvMTgg+IPqYFTZXs+BCsxwVxxfeoKjEc3IzPHkpE+0lw6o
 TgxQ==
X-Gm-Message-State: APjAAAX4QNvXFj2gmEUeaz77iONA0PC3MZ0i0H1hA1Sn53s5bWSPqP96
 9+13017WM7BFQuFVGrF0oQASzvKfKmv/W11W5Y2aAg==
X-Google-Smtp-Source: APXvYqyJ+gKYyI4QXoC4XqVTjzXBEu9hNtqrVI4shlsgZxvHh4Noghhcj0foGO92Ftw+aPo50gdRw2tFupj/v29UF+4=
X-Received: by 2002:a05:6808:289:: with SMTP id
 z9mr3142508oic.48.1582898547003; 
 Fri, 28 Feb 2020 06:02:27 -0800 (PST)
MIME-Version: 1.0
References: <1582810056-22646-1-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1582810056-22646-1-git-send-email-aleksandar.markovic@rt-rk.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 28 Feb 2020 14:02:15 +0000
Message-ID: <CAFEAcA-+kywWfidtju87gVrGkryJWQKF2yxiUwKVjV4=NNgu8g@mail.gmail.com>
Subject: Re: [PULL 0/5] MIPS queue for February 27th, 2020
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::235
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 27 Feb 2020 at 13:27, Aleksandar Markovic
<aleksandar.markovic@rt-rk.com> wrote:
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> The following changes since commit db736e0437aa6fd7c1b7e4599c17f9619ab6b837:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2020-02-25 13:31:16 +0000)
>
> are available in the git repository at:
>
>   https://github.com/AMarkovic/qemu tags/mips-queue-feb-27-2020
>
> for you to fetch changes up to 0484d9d4fbe9beacd3dd36fdf7fc3e14940bf078:
>
>   tests/acceptance: Count multiple Tux logos displayed on framebuffer (2020-02-27 14:19:07 +0100)
>
> ----------------------------------------------------------------
>
> MIPS queue for February 27th, 2020
>
>   - Adjusting maintainership of MIPS KVM CPUs
>   - Machine memory and interrupt-related minor improvements
>   - Acceptance test for SMP support on Malta with I6400 CPU
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

