Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C44C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:47:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 289E421734
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QDuvruqK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 289E421734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iugZo-0001kQ-Kh
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 12:47:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45804)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iueEe-00061e-Nn
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:17:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iueEd-0002re-Ao
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:17:32 -0500
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333]:34170)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iueEd-0002rQ-4X
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:17:31 -0500
Received: by mail-ot1-x333.google.com with SMTP id a15so3078327otf.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 07:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xdJfCQ/KznZsfKHOxJAl1dA2URhuqjIwEutBd0jY5U4=;
 b=QDuvruqKHYRddylgLbmBj3u8Bh7fS69eDvNfss14cqlPZIrvO1nylbWEC4Zo9GPR4I
 iLlAXV6yNaWpMkgEAQ+zHLt+uU6EB4SZ6UIdJVaOQQNGUpyi1qWd7tNgqAHs4e3eezyj
 lPAxMWTTiJ4RDwacSEtEKve9Gt/H3E8q7qqYPG6Z0eF8FoMYHvZqimUEmq756RmfGL/+
 xHa/L3Dv6F2wgSPBolhse3PHDcXMGd+x6ycS+uTcN4dwqSY3s1cm6LQDSeaMWdaeUVyD
 yha3cuSKOa6YalUese5ysYf8XBJo3lPoY+NJ7e+G5lKzeb1KOsUG0k4X/yhpvuWf6CA1
 7YMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xdJfCQ/KznZsfKHOxJAl1dA2URhuqjIwEutBd0jY5U4=;
 b=keFpxgkJmCcT9wCRL31HJk4yVsd69kNuTf+j3/+mx6fabmrKiM/WoBtqOGTkV4ARtc
 em9/uKpkODcXAUjqQqMOfhrGncpBAVFZLC+UeZlWX+E7wPKMdXcTMZl4LGVUPNhqZ7Nv
 5Eeda16g7LBEWodIdgpr3vfBUymTHl6tJQACRk9UM7FruxZGgGG9AoEANew1hxC8V4nf
 oj2bY0dBPdph9Mk8RxvR6dQvYj0tzNdvlPBYnSFN8E2P3XlpXu+STlTTi9cV9Iak6oTl
 yNiRZlirGguJpo37Yo0UeyPDskMYYQSQTiXTWG/TrcCs6naTUQCAZ9zjldW/qGIz8dJX
 EEHw==
X-Gm-Message-State: APjAAAWU/nFiQy3jjkhcaVLF8BGPisuk1XDdKU+r/vIMWSDkwn8gDavs
 5pusBIykwEEKhbtxSh5yofM5elc0w3EhKsNL3FCm/A==
X-Google-Smtp-Source: APXvYqylJbq6lh29if9wc3541YqMf352KnGZ0XImyJBeUm19KuFNUhl7KVMKF/c1aWTpTAkNMAoNREDGmH8r+MWwANg=
X-Received: by 2002:a05:6830:13d3:: with SMTP id
 e19mr11663163otq.135.1579792650266; 
 Thu, 23 Jan 2020 07:17:30 -0800 (PST)
MIME-Version: 1.0
References: <20200123082227.2037994-1-laurent@vivier.eu>
In-Reply-To: <20200123082227.2037994-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Jan 2020 15:17:19 +0000
Message-ID: <CAFEAcA86bVsY-4yg8FhsWqcOrE4=upwOuyxTLuk5CDO7r7E8mA@mail.gmail.com>
Subject: Re: [PULL 00/17] Linux user for 5.0 patches
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::333
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
Cc: Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 23 Jan 2020 at 08:25, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit 3e08b2b9cb64bff2b73fa9128c0e49bfcde0dd40:
>
>   Merge remote-tracking branch 'remotes/philmd-gitlab/tags/edk2-next-20200121' into staging (2020-01-21 15:29:25 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/linux-user-for-5.0-pull-request
>
> for you to fetch changes up to a7b09746679c1815115249ec69197e454efdfb15:
>
>   linux-user: Add support for read/clear RTC voltage low detector using ioctls (2020-01-22 15:21:37 +0100)
>
> ----------------------------------------------------------------
> Fix mmap guest space and brk
> Add FS/FD/RTC/KCOV ioctls
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

