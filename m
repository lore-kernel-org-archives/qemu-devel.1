Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7CA7C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 13:57:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84E702070B
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 13:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FeCemsbK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84E702070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41106 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMYhE-0005xy-Eg
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 09:57:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMYgJ-0005Z2-GC
	for qemu-devel@nongnu.org; Fri, 03 May 2019 09:56:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMYgI-0005Nz-Hu
	for qemu-devel@nongnu.org; Fri, 03 May 2019 09:56:55 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c]:46214)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hMYgG-0005K2-9g
	for qemu-devel@nongnu.org; Fri, 03 May 2019 09:56:53 -0400
Received: by mail-oi1-x22c.google.com with SMTP id d62so4385173oib.13
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 06:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=HfUHnFHMTxJuK0GygaVLXkSmW2e1UXulQ2kEeejzkOU=;
	b=FeCemsbKxVP1DN4SL/tqSdzh9vXWblX5vEKTjxrbKI2eRsotWOFdwiAZp79T9UUH4S
	+SCWFCP/QndA0PTU8PM8pO8ph8uO7x13hIoj+8pShNsTQcL7oi3kNMrEeO1zltkw+iXl
	upvKahGfcKVEq2tP8VsdYWvFam+HEfyDohzJM0W24OEQqftjBU3yrs7bHQfX0IRmCih9
	RRLoAM1NpndhAFbFEwHj7E+JyJBpZGHkizGKu3omYGAaK9d37cfTebn3Ncc/oeSU5Rys
	SLGGmFRGpqdFI6lVCOMvQLDZiRdDX2vy56HoOzJ0fNXkUcPhIExeGp8OkkGNa9gLsAte
	xtKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=HfUHnFHMTxJuK0GygaVLXkSmW2e1UXulQ2kEeejzkOU=;
	b=KK+CjZjAd5Vqwxh9iGROPEINmsaaxlPC1/ku2Ukh8qgVtPyX+zoRCpI9A6goRX+DJD
	1PfLhBPehlJcCxXko43ZQNG7upG+QXooN3mH9TpbytUpIMdw6pY0FtwUGFfjdLTahwqW
	t1tPNkxHbK61FgMOG6DV5yQipjnZ8rYg2b5J5KcHN44Q3xopvqSPm/9MGSnYj/5VBG8Q
	EkNyTEO5qc9qBiD/YsRDI09eLFiEhS4MRw+4d73ENrrllZKlnwFkDoqw/RMXnJq+LoGG
	5Ik7GOmUQoBCQxJPfbFO5bZVp1woJidiDU7VnFT/sT+1lOfKUIrggATxUI+X6GLTH+xC
	MsrQ==
X-Gm-Message-State: APjAAAU/5OFOi/3U7uouWR62RWU15iRsXTxa1nD7EmSjG+wSXcbpEfj7
	wD/FzM1n/8udEKxCp9pxVvvkDEer+xjncuI+bUZeGw==
X-Google-Smtp-Source: APXvYqwXuYy6zrqWkKMEAZcgwQ9oBHBSWwAnNxvEVFQKQ1BAycAFea7BDhholy8LZWM1eAoBpNKULp3zThXnKXxE9rc=
X-Received: by 2002:aca:4b04:: with SMTP id y4mr6047044oia.170.1556891806160; 
	Fri, 03 May 2019 06:56:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190503065954.17069-1-kraxel@redhat.com>
In-Reply-To: <20190503065954.17069-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 May 2019 14:56:35 +0100
Message-ID:
 <CAFEAcA8yBguOgjfCHa8RT=gFev2TTUAuG-Z3hNtDgFYrdZ16eA@mail.gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::22c
Subject: Re: [Qemu-devel] [PULL 0/7] Usb 20190503 v2 patches
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503135635.xhnpUSZTxsHQxZBb8wAWzlidtNiCg0G56Ft62J7nkr0@z>

On Fri, 3 May 2019 at 08:02, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit f75d15231e56cb0f2bafe19faf1229c459a60731:
>
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2019-04-30 17:06:57 +0100)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/usb-20190503-v2-pull-request
>
> for you to fetch changes up to ccb799313a5926a6aa49018bbc67fe6165fad7f3:
>
>   hw/usb: avoid format truncation warning when formatting port name (2019-05-03 08:56:58 +0200)
>
> ----------------------------------------------------------------
> usb: bugfixes for mtp and xhci, split ohci-pci.


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

