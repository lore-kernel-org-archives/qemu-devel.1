Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56399C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 16:00:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20BA120707
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 16:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eP3JebAv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20BA120707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioUoJ-0003tw-7H
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 11:00:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54459)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ioUnV-0003DC-Dz
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 11:00:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ioUnU-00035B-8C
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 11:00:05 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:39407)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ioUnU-00034h-1M
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 11:00:04 -0500
Received: by mail-ot1-x342.google.com with SMTP id 77so72220240oty.6
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 08:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=bgOK7NoTR1RuGbGG5u/CCCNXHoAk6w4r9z7PP/8VPDk=;
 b=eP3JebAvrcjGSTK1xyr1kGI1OhPsdcro7GuTZjWK8bYn3+gYLSQ+qIKhYWvJ6DBdSL
 thLjTUzYRsfCxNuO7I81GVyEoLnPjU3Hb9sNauj4y+6gA3ObJ/n7hxR7EiHUph3BJ3RX
 2ZC0yjpgHbZ+HnU5GvHPcZc4TxyR80gMFm1mwetpquvTjAsgsehXsYmqbYr5NQql4mSM
 M8H6MKC0plXxwDSdpJHKtYzVG99kX4btyFMxnIVKQRkmsuPpJrrNwT5t/3OGCAhbERaF
 hFDe6q0sOKz1MrW7imT0g1udjojaBPCgamRjhe3bflTuXXvMCW4ARfcxfdbR+A3rtFfK
 r1KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=bgOK7NoTR1RuGbGG5u/CCCNXHoAk6w4r9z7PP/8VPDk=;
 b=Ov3nh84ES0o2m4XH9OppzW2Oz/rpCkcmV8z1RPRFtzkHPdWdEMtKGYJd+9iO5k3eHr
 +9tb/JYgLSxENW+bpPjoLRtBcvd4WaTCaDLegZ682AzMluXHcQLJSal/gQeVXLtQCZ0O
 lm+XWpooOCwbq5T3O20u+o1RHUyLgLkoXZKLTEAm50qCFqlnG2R7gt+ouc0DVahihRp9
 0MtqLTA9wvSlLNFTumG8IjfesIy+fpyr4nfGopitijCWFYcKZBn6KLIspnh1C1mnMex3
 IIUe38GXIyiOBUBHxPuolaXVZu7FXGgvO3FYVloN/BTTaVIZGpial5xYoFdZzZL2x2lA
 4LFQ==
X-Gm-Message-State: APjAAAWYYCLT2BHDut+hTa0sukeB9d6mcAz9C5C453rqJQ3f8WVh/uap
 UXa2VNvkXgPTRxFkwfjb8SCOkJ/fdLJhWTOuY/6BVw==
X-Google-Smtp-Source: APXvYqx+kNH6fWSdrUdVJuP2I2ccX8ViiqjTvR5kXCDLWMOLKe/Fb1CgkDxRR26htzjJ7x6pBq0V2gvoLzyUew44khc=
X-Received: by 2002:a05:6830:13d3:: with SMTP id
 e19mr108130484otq.135.1578326403093; 
 Mon, 06 Jan 2020 08:00:03 -0800 (PST)
MIME-Version: 1.0
References: <20191230110953.25496-1-f4bug@amsat.org>
 <20191230110953.25496-4-f4bug@amsat.org>
In-Reply-To: <20191230110953.25496-4-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Jan 2020 15:59:51 +0000
Message-ID: <CAFEAcA-UBNVvskK+mSjHGOhfXbkGgi1TPJZLFGzcdOoW=6i22g@mail.gmail.com>
Subject: Re: [PATCH 3/6] hw/arm/allwinner-a10: Move SoC definitions out of
 header
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 30 Dec 2019 at 11:09, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> These definitions are specific to the A10 SoC and don't need
> to be exported to the different Allwinner peripherals.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  include/hw/arm/allwinner-a10.h | 6 ------
>  hw/arm/allwinner-a10.c         | 6 ++++++
>  2 files changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

