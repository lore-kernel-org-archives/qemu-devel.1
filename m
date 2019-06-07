Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D500AC2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 13:09:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0AE5208E3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 13:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nQMzlapA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0AE5208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50940 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZEcR-0002L1-QV
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 09:09:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59331)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hZEaf-0000ih-BD
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 09:07:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hZEad-0003dA-EJ
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 09:07:29 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:43928)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hZEab-0003V4-FG
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 09:07:27 -0400
Received: by mail-ot1-x343.google.com with SMTP id i8so1748472oth.10
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 06:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QLdA2mOirkQQ3DH1Q8+3NAyskJrz8qbP29IgOVwCT4M=;
 b=nQMzlapABWSy98+gz0VLJxXlapVn1mEGd0VzVmyjLpLVhTnhny1ltP0nYyteT1bzQc
 1Hm3pc12m6PHviF3vE8w4xeSG9CH5MkbfVq5XtPU8evbvQ4BaIQ0pbZmc6A6U3NkKXgW
 J/CJFPQXLnUAE5f9Gn3yV2i7zwUKOB1IamMw93/gPtUCoFphUUnEegT/8ssEs6X4vy4F
 WMsBXU+a4iSTqMIX1Ryy2mcNtN7rfUEVvsMeKSnb2UqoEXs/A0JKmUNO1+9zoXARYb50
 4br3rdy0mfqnxk3YL9+PUhiiUxbl8UxQPKBUdlFTFeXc+Dp1LCbT6+XHbLdii3Q627O1
 Yylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QLdA2mOirkQQ3DH1Q8+3NAyskJrz8qbP29IgOVwCT4M=;
 b=Mq/PGtlFAfUQ2AvBvpxT4/gTD4GPSaRK/CsuoPaXuXnXeuVTu0ISJFCXpiMXhNjIV3
 aCfCP8flA75le9WDXgCP/0EOg6NsKEqBvZnbxVMDjp63vDksmB/bdpnBQbENBy6ete/c
 KtNmYIvpY5kkyVYq0ztSCZ4Ym0ijwXaKJa12IuABDJfvf4LiBtTwy1kwc/jFPSP7yoEy
 um7Lgrec7ykoBKMLd8mg2i3UX9TkO16IYRaIwK0zyhJV1moh9Utt6M8/BGjiFvoyVAR2
 GOhRb6nagY4nbjWDIS8yYGyDsRiiFLiOXTpH9EXIhFyfURtPqguVFFxTSL8ONkcn2jpN
 HV9Q==
X-Gm-Message-State: APjAAAU4v82AAFXPihb5mUjGq4mW4HXMmsnwQVkFYDR5eat6Y02U/nP5
 dewLrWEvjVRgyPj9LfjkE4pMZ+TuA+1s5lybMqd46ezZcYc=
X-Google-Smtp-Source: APXvYqyxcMjkIaYoP5Rdcm4wc7CrR5j9cVbHTrW1SOPysF1+JEK5iXDYchBAVCZ2Uso+o6n6B4Pk+jiTQGB5Kl255BU=
X-Received: by 2002:a9d:193:: with SMTP id e19mr18818154ote.135.1559912840709; 
 Fri, 07 Jun 2019 06:07:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190516144733.32399-1-peter.maydell@linaro.org>
In-Reply-To: <20190516144733.32399-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Jun 2019 14:07:09 +0100
Message-ID: <CAFEAcA-t=9+zuEOf2uoJAMnpnyAJtpCqe2biWzS6a8nZU0uQOA@mail.gmail.com>
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH v2 0/4] hw/arm/boot: handle large Images
 more gracefully
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping for code review, please?

thanks
-- PMM

On Thu, 16 May 2019 at 15:47, Peter Maydell <peter.maydell@linaro.org> wrote:
>
>
> This patchset attempts to fix https://bugs.launchpad.net/qemu/+bug/1823998
> which reports that we don't handle kernels larger than 128MB
> correctly, because we allow the initrd to be placed over the
> tail end of the kernel. AArch64 kernel Image files (since v3.17)
> report the total size they require (including any BSS area that
> isn't in the Image itself), so we can use that to be sure we
> place the initrd sufficiently far into the RAM.
>
> Patches 1 and 2 are new since v1; patches 3 and 4 are the old
> patches 1 and 2 (and are basically unchanged since v1).
>
> Patches 1 and 2 in this series are new. Patch 1 fixes bugs
> in the existing code where we were assuming that we could
> treat info->ram_size as the address of the end of RAM, which
> isn't true if the RAM doesn't start at address 0. (This
> generally went unnoticed thanks to the magic of unsigned integer
> underflow turning end-start calculations into very large max_size
> values for load_ramdisk_as() and friends.)
> Patch 2 adds some explicit checks that we don't try to put things
> entirely off the end of RAM (which avoids those accidental
> underflows).
> Patch 3 in this series adjusts our "where do we put the initrd"
> heuristic so that it always places it at least after whatever
> our best guess at the kernel size is. (This might still not
> be right for images like self-decompressing 32-bit kernels, where
> there's no way to know how big the kernel will be after
> decompression.)
> Patch 4 makes load_aarch64_image() return the
> kernel size as indicated in the Image file header, so that for
> the specific case of AArch64 Image files we will definitely not
> put the initrd on top of them.
>
> thanks
> -- PMM
>
> Peter Maydell (4):
>   hw/arm/boot: Don't assume RAM starts at address zero
>   hw/arm/boot: Diagnose layouts that put initrd or DTB off the end of
>     RAM
>   hw/arm/boot: Avoid placing the initrd on top of the kernel
>   hw/arm/boot: Honour image size field in AArch64 Image format kernels
>
>  hw/arm/boot.c | 83 ++++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 62 insertions(+), 21 deletions(-)
>
> --
> 2.20.1
>

