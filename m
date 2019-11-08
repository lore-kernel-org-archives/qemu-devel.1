Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F8A6C5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 14:39:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBA87214DB
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 14:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ks4QVggY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBA87214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT5Q7-0004u7-RS
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 09:39:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40143)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iT5Me-0000hD-IG
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 09:35:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iT5Md-00065G-0b
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 09:35:52 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:36296)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iT5Mc-00062s-Q7
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 09:35:50 -0500
Received: by mail-ot1-x32b.google.com with SMTP id f10so5371841oto.3
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2019 06:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/fNEUSZciTP6XdNhN77A4a2fCdai6H55iZR5gzYyf2Y=;
 b=ks4QVggY9N6zwt7yGylv6j9iPOK6Brqx1Zzephne/9Pl81zVPvOYrRcI0mv4Pu2K9G
 sa6YTLlZHEBlXb17CFvQs99QnF94AZ2wZwFme6yTaeNWRzqn0BhumhEHWmCuUNmBSWuq
 rB/ccA5TvCHkklUVJUVTdRs8xD8yCy7Ku7/nuD/MFiIh0QaQKju4QTigjpkEWrKLXJKf
 rMctwoyGBkGeznWht279aBaxebrf4zSdkYy1jL/DlAxA6fEEvckGAgNLukHK1AgZHx+p
 7vChEM/6NYw3mTMp8H6cvy0Nf5PB4zTWDqHwi5YJpE60mEVR0/q/rF7ODJ24AXlksJ5G
 eojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/fNEUSZciTP6XdNhN77A4a2fCdai6H55iZR5gzYyf2Y=;
 b=Ivdt5GbSGbNZl5tCU0ywYDF9pjCK+66G8Tf/WnwmEwOl+S2GcZVZMV3GQSgyL3BWc7
 LhsxFV52h9vDpLARKj5BJ/7ouQ4+FV+jGUKrA7iFJbmupLybiKTcnjg7bRDoXqVKwxL5
 dLxXbT+esdP9PugIGequC1sZ9C47Uxz3cB5w8cmTpfyjheOAr7rb1Bc812rxBvXsStH8
 DQs0MRH/G9hZyvws1pRaMninEPKZu8nYIgxCB2xVxGgJAT1eKlEe79Ts/c2e+U7RPSDH
 O8ux0IZ0IqtGaFFrXnkV8FYa7r/LjGPABmmVZ3TUQ+ImhVFnScZsihYQ+KQsPsa+gx7u
 CGxA==
X-Gm-Message-State: APjAAAWqXXPCDdGuqdsyc+OgbjjrJtX1yj0LdsjyntIlBzfjEMA4N7ob
 ce+SIACA7r2bH4tQA0A+JIPVpYg6DyszsQQzsqsAFg==
X-Google-Smtp-Source: APXvYqwaIE+GVT+6TH/bRCHM7OMm4KRICz3HW9n2b3EY6IlClkFI1/h1qFfS1sqdYVqsnhOFGjnHZCDDOQHIEGUe/1M=
X-Received: by 2002:a05:6830:1386:: with SMTP id
 d6mr8827085otq.135.1573223749564; 
 Fri, 08 Nov 2019 06:35:49 -0800 (PST)
MIME-Version: 1.0
References: <20191108102212.11101-1-kraxel@redhat.com>
In-Reply-To: <20191108102212.11101-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Nov 2019 14:35:38 +0000
Message-ID: <CAFEAcA9shYgm3zEfV_PKPMgyNuu4EhdpOiKuPRENqQAKyogd=w@mail.gmail.com>
Subject: Re: [PULL 0/1] Seabios 20191108 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
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

On Fri, 8 Nov 2019 at 10:24, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 59015778f3ec7c01202d46c5dbeeac8ab4225c52:
>
>   Update version for v4.2.0-rc0 release (2019-11-07 18:17:31 +0000)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/seabios-20191108-pull-request
>
> for you to fetch changes up to f085bf95a6208b42f1ae01f60c76d936d9fed490:
>
>   seabios: update to pre-1.13 snapshot (2019-11-08 11:18:26 +0100)
>
> ----------------------------------------------------------------
> seabios: update to pre-1.13 snapshot (gcc 4.8.5 version).
>
> ---------------------------------------------------------------

Still fails on x86_64 Linux and s390x (though everything else
is passing now):

ERROR:/home/petmay01/linaro/qemu-for-merges/tests/boot-sector.c:161:boot_sector_test:
assertion failed (signature == SIGNATURE): (0x00000000 == 0x0000dead)
ERROR - Bail out!
ERROR:/home/petmay01/linaro/qemu-for-merges/tests/boot-sector.c:161:boot_sector_test:
assertion failed (signature == SIGNATURE): (0x00000000 == 0x0000dead)
Aborted (core dumped)
/home/petmay01/linaro/qemu-for-merges/tests/Makefile.include:916:
recipe for target 'check-qtest-x86_64' failed

thanks
-- PMM

