Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C9EC43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 14:20:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 049EB20652
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 14:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nBnh+OLR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 049EB20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47806 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLTc6-0002Ut-8P
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 10:20:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLTb8-00029s-6q
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 10:19:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLTb7-0008D3-B3
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 10:19:06 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:36072)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLTb7-0008Cl-6g
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 10:19:05 -0400
Received: by mail-oi1-x242.google.com with SMTP id l203so11381238oia.3
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 07:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=2XXSvQZMIShsrk3buOnTvMFReUAA0AgZ68Yrj0DtJKA=;
	b=nBnh+OLRDvHXBsU+0h6Qn9dz+WyJxCa363Fi3EQqRBb54Bg/Z+pzigkv5DvAA4sdVs
	RmTo9mXrjCZnXijAn48w1xbzuHEg/CM9vmENCsMht2iQT3G7Du8XcpLsWCGdXWbpMsWW
	RyNYxRe/I8/DDG+jbuh/4lIySniZvVKvhZi5rM59/J/ZeSS8pKv9qLyuiGxla2wwyYNH
	NmNBlW5josmLcZSqCXRx2vDyqR7B6zbHuyBIDVaoBohJRdUkACf6Q1eeOO49VU3AmwB8
	LgellP5roK09D6rcORmwlZjzLkP0oUHs9i4fLEQwfnrdmwsqYtPJWijXmaoqQ5K4NiZV
	8VSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=2XXSvQZMIShsrk3buOnTvMFReUAA0AgZ68Yrj0DtJKA=;
	b=SdgxZsU6C2vCjBPuvp7qdzh8f/8I7/Uzug4e/f4Smy44ziHMoYjfTsqgdOOwRSXfVX
	2dFL/xPdez1tjvDHclGNUZUa9l9B2FSqJI+i9zeLV//l4lilfFfTQMtrRH1HbWkBWaqk
	OQeACFUKx8Bu2uegmfxaeU3UwGPvzsgpmd3FJLq7uV98ZG86ICo4Wi2sxPQWeH3nVeSI
	dTGMWlFG/r8u1RFtVpun662kUc1KemW/6aqm2lqjX7SSOS8AOgd7iFOTMdg+avLjoToA
	JPVIH4Ji04KBLcpjzY30GMTrlFmEjnVLWs+ekynwIfyj0Vqj6LdBuALgIi60CPxyUL1D
	Bs5A==
X-Gm-Message-State: APjAAAUm2PZ8t6uZBVWAxsoKZTfFX6EQD7oxB9u5tNyPEd34zDvrkv8G
	AlxLheWgIq0HF1cuh67xclzxvA8f+Ej2c/V4dZpuIA==
X-Google-Smtp-Source: APXvYqz37STlLDoc22/C9Ee6pfOQqxuQglEO5xJ6PnjmjiNCsIfEnTTN7fMcfkKDESWb1k+S4QlICEAgQDutalYb0G4=
X-Received: by 2002:aca:b3c2:: with SMTP id c185mr3349730oif.98.1556633944204; 
	Tue, 30 Apr 2019 07:19:04 -0700 (PDT)
MIME-Version: 1.0
References: <1555560291-3415-1-git-send-email-hongbo.zhang@linaro.org>
In-Reply-To: <1555560291-3415-1-git-send-email-hongbo.zhang@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2019 15:18:53 +0100
Message-ID:
 <CAFEAcA_AZgLmYRkfKzgWpptkUdz-Qpa=Zwk7x0kONxQ64-WMSA@mail.gmail.com>
To: Hongbo Zhang <hongbo.zhang@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [PATCH v7 0/2] Add Arm SBSA Reference Machine
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
	Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Leif Lindholm <leif.lindholm@linaro.org>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430141853.SMrb0URPLEjIhG9Ji9uA359-U97vYYnayBh6wDnDqrs@z>

On Thu, 18 Apr 2019 at 05:05, Hongbo Zhang <hongbo.zhang@linaro.org> wrote:
>
> For the Aarch64, there is one machine 'virt', it is primarily meant to
> run on KVM and execute virtualization workloads, but we need an
> environment as faithful as possible to physical hardware,  to support
> firmware and OS development for pysical Aarch64 machines.
>
> This machine comes with:
>  - Re-designed memory map.
>  - CPU cortex-a57.
>  - EL2 and EL3 enabled.
>  - GIC version 3.
>  - System bus AHCI controller.
>  - System bus XHCI controller.
>  - CDROM and hard disc on AHCI bus.
>  - E1000E ethernet card on PCIE bus.
>  - VGA display adaptor on PCIE bus.
>  - Only minimal device tree nodes.
> And without:
>  - virtio deivces.
>  - fw_cfg device.
>  - ACPI tables.

I've had a look through these patches -- my comments are all
pretty minor. There are a few places where I don't really know
the right answer and have asked other people to weigh in on
whether changes (proposed or recent) for the virt board should
be applied here too.

thanks
-- PMM

