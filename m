Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 430AAC468BE
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 11:36:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B23F20B7C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 11:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pueavyNx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B23F20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48698 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZDAt-0005jm-Th
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 07:36:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33144)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hZBq8-00084N-7B
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 06:11:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hZBq1-0000MI-9h
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 06:11:11 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:44393)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hZBpz-00009S-00
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 06:11:08 -0400
Received: by mail-oi1-x241.google.com with SMTP id e189so1027133oib.11
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 03:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=lwVsP3q3Na9chJgbRd91xhzekVCplSdN5e5V061lESs=;
 b=pueavyNxCQl3ytqWJooZczOtjzWX4cIRp7FhCcfSYnTHudZ8CRaShY9fbkmvFOLC/q
 WMVdAEtb9cl8wV7mHmCfJDmvaQGbQLvYNSXuTEtE5T0UGbyThTe6TxJQYpKGwhZGzkRz
 0y8gthfMG7ouRti87iglTn+204s4PPFRRJfbi0M6pdeZVnydDuiOhd/QtjhMn1GD8xWj
 NjYdofF4FFnDNbO+tffwtsqTXHpI087G1K4FZLuMxHVXvV4FN+RJCZEZB5SbMIbiW+Gw
 TIVUglwKEE/5AkNYJefaxSBNXU319e0GJOyy4Z1GT5QXm1/xtgB89RXTMVdf70gijJeL
 CneA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=lwVsP3q3Na9chJgbRd91xhzekVCplSdN5e5V061lESs=;
 b=hiFIk6Xrtm7eYR2fgP1e7dQl4R/KUwSXkwDKU//UUuKyquRV+Et+N9nQpMI2Mq5p8d
 ZGhOxcrjzlyS0mGnOFEkgPhDNHWnxFzovDlPi6OAV4kV1I6jNDvPD3PLNq6hMpzv9OiP
 vRxg8eQJK4hU0uKahGPp2fUKtjIP2gyH6/nxCqXVmvy2TQpifugpupDW5NAVyP/OcX2N
 Pq0kUDmururpaDBnSpgZFeaYz3fjuMpicSxpVH2U4ERVM6Ll5zWyRmK6D+eZvXHFpAif
 uyb84f6kZ6wKg0A41q8cIgQQDLot9FcENMwthyLrkx+o1v4FUjFEjCzp2UJIygezHh2v
 1lRQ==
X-Gm-Message-State: APjAAAUP4TmX9pm/ohgnmjEmIMNnOm7pplb+9fh/OvD7tQ2cAuJ0q9b0
 RajTEti47tqF8FGMP7wyTpJsrjnzwxcGHz9J8xVdIQ==
X-Google-Smtp-Source: APXvYqxeYqDAq2SNiQ/2Y2seS/3o5cE/qkSx8gY/c06C4Ep7xGemFg8BjxEWW03R3u/xkYEYEyIM//fQUmMIFQZYY7U=
X-Received: by 2002:aca:c786:: with SMTP id x128mr3153673oif.146.1559902262487; 
 Fri, 07 Jun 2019 03:11:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190525151241.5017-1-clg@kaod.org>
In-Reply-To: <20190525151241.5017-1-clg@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Jun 2019 11:10:51 +0100
Message-ID: <CAFEAcA_JQLEWdmFuDivD5YwyqQGcFzr_tDr0H4p7fvwZFGj4Jw@mail.gmail.com>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PATCH 00/19] aspeed: machine extensions and fixes
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 25 May 2019 at 16:12, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> Hello,
>
> This series improves the current models of the Aspeed machines in QEMU
> and adds new ones. It also prepares ground for the future Aspeed SoC.
> You will find patches for :
>
>  - per SoC mappings of the memory space and the interrupt number space
>  - a RTC model from Joel
>  - support for multiple CPUs and NICs
>  - fixes for the timer model from Joel, Andrew and Christian
>  - DMA support for the SMC controller, which was reworked to use a RAM
>    container region as suggested by Peter in September 2018
>
> It is based on Eduardo's series" Machine Core queue, 2019-05-24"
>
>   http://patchwork.ozlabs.org/patch/1105091/
>
> I have included Philippe's patch (comes first) in this patchset for
> reference only.

...I'm hoping some of the other folks interested in Aspeed
are going to review this series.

thanks
-- PMM

