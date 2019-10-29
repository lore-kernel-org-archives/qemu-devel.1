Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D620CA9EAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 15:34:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C787820874
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 15:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="we4O/WvY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C787820874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPTVn-0008OA-0P
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 11:34:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42603)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iPTUJ-0006Zt-81
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 11:32:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iPTUH-0007wB-Hw
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 11:32:50 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:45142)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iPTUH-0007vl-C1
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 11:32:49 -0400
Received: by mail-oi1-x244.google.com with SMTP id k2so4156425oij.12
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 08:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=x3LfQCMitIN1jIYn4kuogdPiskErMYpQM92MYSR99XU=;
 b=we4O/WvY1eYmK4zX5r58SliJ9tBGWzJF19aCmtr3W1tvPy6mh8wxtPRXk/HsQts0x2
 JWeQNIhUYtGXrm/2FPx/J782H32CiOyJOte1x2R46tfY0tEN2nC7MQi8wUlDfVKuZWuX
 JHYdCJ85hza3A0vwhjhRij7A5aSXGzg05lbhiWRbb5zKRlynQwaE0yB/NqRdLnWAFy3D
 d7aQBPDcy20i6c+sR6CVwldu+tmNZ6y9nzW9aC+4nPgSurBEjIE/0rEK6QlahCL/o5Jm
 uljl59see0XEVGIFjTbzdD6wimLJUcwfJ9/m6//NCfxjmKEhfUGqlpPp5cRCtDIL6wLV
 +ODg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=x3LfQCMitIN1jIYn4kuogdPiskErMYpQM92MYSR99XU=;
 b=Vzc+p/kScge6SJjd3urumv/NzJHRXoZHyxA2KWsCclt42r3Gq4v/AArIHH/Nq9aQ7W
 a7L50nkInK29Hg0euyq8WivBXstnRYT8svORFXZ6YJ5hlnOmuKc+18D6Gkdak/DFVrrI
 pWRHTPJs8CQUwDjH7MwZA80SkGOh4HaeVtuRIN9FTZnqCJ7so1lHnZ6jHiXzScnkqfiF
 lsdzUNODsbikESL8xw9UiE1I1cYV0xGNlWCMiXM/gQss9WSABkBsyveLY/lz0ktYfazX
 E572FgFN30YttckAu3VgdJv6N8dTstxo+H4JNwGe7+aAn1Ys+kr1XlS2TWIgRbMOfv+9
 UMiw==
X-Gm-Message-State: APjAAAU74ih5DftaY6WWCAaof3MQ2ZIuXTFLQDOaQPGnLxPNvs1LLN8l
 ArFGUS9lue1wuKvIGrKM5kW2/YZ/3Z+kFXP9oGdc0Q==
X-Google-Smtp-Source: APXvYqwbD9fX5Q1bxShnmvMhALVw8tZoQwQDHxrVmLbxhWRpoC1FIMcpf2j/mN6cCQmUGHspSKp3VEiee9dYkFFhB6g=
X-Received: by 2002:a05:6808:b18:: with SMTP id
 s24mr2214593oij.48.1572363168249; 
 Tue, 29 Oct 2019 08:32:48 -0700 (PDT)
MIME-Version: 1.0
References: <20191028145937.10914-1-richard.henderson@linaro.org>
In-Reply-To: <20191028145937.10914-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Oct 2019 15:32:50 +0000
Message-ID: <CAFEAcA8gKZz9nDkUa0LPK_q=CJxx_DiJTdSyWaKk027ZgLPSVQ@mail.gmail.com>
Subject: Re: [PULL v2 00/12] tcg patch queue
To: Richard Henderson <richard.henderson@linaro.org>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 28 Oct 2019 at 14:59, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> V2 fixes a build problem that affected win32.
>
>
> r~
>
>
> The following changes since commit 187f35512106501fe9a11057f4d8705431e0026d:
>
>   Merge remote-tracking branch 'remotes/stsquad/tags/pull-testing-next-251019-3' into staging (2019-10-26 10:13:48 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-tcg-20191028
>
> for you to fetch changes up to fe9b676fb3160496b4b2bf0c57d33be724bf04c3:
>
>   translate-all: Remove tb_alloc (2019-10-28 10:35:23 +0100)
>
> ----------------------------------------------------------------
> Improvements for TARGET_PAGE_BITS_VARY
> Fix for TCI ld16u_i64.
> Fix for segv on icount execute from i/o memory.
> Two misc cleanups.
>
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

