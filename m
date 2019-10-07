Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504B3C47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 14:43:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B04921655
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 14:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gbxi3gYo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B04921655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHUEh-0003TZ-9K
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 10:43:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41663)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iHUBv-0000Ra-Vb
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 10:40:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iHUBu-0006z9-Ra
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 10:40:51 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d]:33742)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iHUBu-0006yt-Na
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 10:40:50 -0400
Received: by mail-ot1-x32d.google.com with SMTP id 60so11188450otu.0
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2019 07:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wmM9vna5q8ED7fQwnaF8wd/LqQ1opahY+TKOeojp8oI=;
 b=Gbxi3gYoOgFTaD/SqbyOuhrf52s9beJSu5sxlRWKed1bW4L5ReBnPTTcHi4x2MBh4L
 UoC+wIJIxoaHBP7nre7SShRrDMpMYh2t2Kz7oL+q+3h/YUJlRwIxNwyb8iavdYjOtVS6
 eyRbuUdV0TBcMABulL4I8c/LAY+VrGldxEv6BXQH+5wnpmKkB99cNevuaH4SewKli5MX
 amWYkuqxM73ek9EkBlmISxzg5p9FgDa8rw9R/+fJEhOVopSQxHDwejplsBzsPi4fZHNZ
 cq6YMDm7qLQtq2pPjep4xHjuiX2l7gKVTvfTH8T581bY3AtuHXduQxYC32YyUfNe1AF5
 v0Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wmM9vna5q8ED7fQwnaF8wd/LqQ1opahY+TKOeojp8oI=;
 b=Xq77e8Xm5JYYo+Kbp06efx0B/ZyBH2ZO88/E2NJO9j7iF74olcVUKGJ9hHcb566pAX
 F+HydAvEBqdDei5yshFNzQjGrJrJNq1xtuUW2FC7PPoJ7bpVw7GGUMw0C99R3dIqB20o
 sR5cJ68auUC6gnsfRafjO5yhhsX1BVlcjQsDUJLkdIBoEPQJ+vYEI/pb8OPVyCxAcvfZ
 EcGkzByU+H362iyNfVjRvvuQKCJEbjbBljG+IpAjjFI5xOy3nvuGwNKV3iCcYpTS0ZYo
 Fjd5zAe0pqQIIWNj3POFjPd5H7WhXGR51Ym3xpvRgzdwMkhwrev9HuwUvesAlTXyfN3z
 eJow==
X-Gm-Message-State: APjAAAUuRion4MTeGG/zFur1xsmuDnfpT2G4vUeZTIF+WuLjLEM4pCKU
 n3+djg+XMwFycUqYo9W3fOkeUKfmn3belaP2W4UngQ==
X-Google-Smtp-Source: APXvYqxJOh45ISAkYT6YyzVErqpq1v5kVEDPy+4LW7K4R1e2mWJdb9Y172XacIgru+tBBullH8CiB7pbHwlQTbVnV2k=
X-Received: by 2002:a05:6830:1357:: with SMTP id
 r23mr21451560otq.91.1570459244518; 
 Mon, 07 Oct 2019 07:40:44 -0700 (PDT)
MIME-Version: 1.0
References: <20191004093747.31350-1-david@gibson.dropbear.id.au>
In-Reply-To: <20191004093747.31350-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Oct 2019 15:40:33 +0100
Message-ID: <CAFEAcA8PVHBKj4TVRe5jW9BTbiUZYHVfV48dy9AxbOa3hyfqiA@mail.gmail.com>
Subject: Re: [PULL 00/53] ppc-for-4.2 queue 20191004
To: David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32d
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
Cc: Laurent Vivier <lvivier@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>,
 qemu-ppc <qemu-ppc@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 4 Oct 2019 at 10:37, David Gibson <david@gibson.dropbear.id.au> wrote:
>
> The following changes since commit 4f59102571fce49af180cfc6d4cdd2b5df7bdb14:
>
>   Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-oct-01-2019' into staging (2019-10-01 16:21:42 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-4.2-20191004
>
> for you to fetch changes up to 1aba8716c8335e88b8c358002a6e1ac89f7dd258:
>
>   ppc/pnv: Remove the XICSFabric Interface from the POWER9 machine (2019-10-04 19:08:23 +1000)
>
> ----------------------------------------------------------------
> ppc patch queue 2019-10-04
>
> Here's the next batch of ppc and spapr patches.  Includes:
>   * Fist part of a large cleanup to irq infrastructure
>   * Recreate the full FDT at CAS time, instead of making a difficult
>     to follow set of updates.  This will help us move towards
>     eliminating CAS reboots altogether
>   * No longer provide RTAS blob to SLOF - SLOF can include it just as
>     well itself, since guests will generally need to relocate it with
>     a call to instantiate-rtas
>   * A number of DFP fixes and cleanups from Mark Cave-Ayland
>   * Assorted bugfixes
>   * Several new small devices for powernv
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

