Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5B3C33CAF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:24:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB5F1207FF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HTYdixhk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB5F1207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iugDT-0005WD-DR
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 12:24:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50591)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1iueaD-0002Iz-0u
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:39:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1iueaB-0003Et-T4
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:39:48 -0500
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:53405)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1iuea8-0003CS-Au; Thu, 23 Jan 2020 10:39:44 -0500
Received: by mail-pj1-x1044.google.com with SMTP id n96so1368727pjc.3;
 Thu, 23 Jan 2020 07:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=EdjG42sUnvPpm61r3usIt55vc0aX2OqPH7wOIjO/dks=;
 b=HTYdixhkrtGRBDm0P/EO7GydYqhF9jbsjfIgno7kdHhCZkEoI6h0S6+yVs1ik0GzfH
 1886ZPfcrfPRhO9Nz0LnkGvcZkgUHUzNDAvcPgt1A+vh2g0vQL97GY+drk1OGf16jmHh
 GXV6Mhm6ngoVkSiWTuvpy/QcAF+ipOvO7weQ2K41T5SEeSZRNtD/NtaM9BUclnUxKwi1
 eULy6gP+9Xt31yh7uw3cayDpcLNEkzn1ENHRCFT2CZ9gk9RrFUh+JqJ4HbzLHAtoUAd/
 vpHkwRROeOZbxquAp/6un/UKZptJciKQ6AzrYfoifR+5X/LTMqjN5Sy/mmPastZQG0EP
 EvNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=EdjG42sUnvPpm61r3usIt55vc0aX2OqPH7wOIjO/dks=;
 b=KvubSyA1vzQqT4GyIDbCfnmMor2C1PzIywJO2P3HSsCYP810ra+HGzsdGfjs6glOm/
 F5QJ++5C5FDx+EpLI8b6ERIbpCPhYHKiC2gDkG3Zlzzs7Ro2OVZMoLmhNZpoJEAXf+XF
 66lSGJBBq83lKdLu2EHFJ+/6vE1zIBBUYgd7dLXXFYc7WEgznUGOCnXLvnxETYjHgr9C
 cY5/Ts/GX6slid54Fks+xyVrRF1tltAsfLSkUMYbyj4SZAtPKALZrhi11ORg7vt0MZwR
 B/J0jZJLvAvpq56eYhq6BMUkv9dnQSE+VckOveqxDymf6Ygbzd1/IKk4Z4fdv0mHkFVE
 A7fw==
X-Gm-Message-State: APjAAAWaXJqADzYrEtzU2xxJqtEccSohGiIqNTed9+59eXYNQ37ORWvl
 TeCIws48gxU9PESXKSAFYlA=
X-Google-Smtp-Source: APXvYqyHUYy3S7YgYXMPH/Swq6ALJDAk/0tvV26/36J/kSmx1g+YikJs/2Q53A6SIzY9HEbhHIt0SA==
X-Received: by 2002:a17:90a:cb87:: with SMTP id
 a7mr5073430pju.135.1579793983179; 
 Thu, 23 Jan 2020 07:39:43 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id fa21sm3386597pjb.17.2020.01.23.07.39.41
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 23 Jan 2020 07:39:42 -0800 (PST)
Date: Thu, 23 Jan 2020 07:39:41 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 0/8] Fix Exynos4210 DMA support
Message-ID: <20200123153941.GA29186@roeck-us.net>
References: <20200123052540.6132-1-linux@roeck-us.net>
 <CAFEAcA_CVt87SwQ7OdB=phedEez1K_mJyrMLkY9dCZuzNFfEsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_CVt87SwQ7OdB=phedEez1K_mJyrMLkY9dCZuzNFfEsg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1044
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 23, 2020 at 03:20:48PM +0000, Peter Maydell wrote:
> On Thu, 23 Jan 2020 at 05:25, Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > Commit 59520dc65e ("hw/arm/exynos4210: Add DMA support for the Exynos4210")
> > introduced DMA support for Exynos4210. Unfortunately, it never really
> > worked. DMA interrupt line and polarity was wrong, and the serial port
> > needs extra code to support DMA. This patch series fixes the problem.
> >
> > The series also converts pl330 and exynos4210_uart code to support tracing.
> > While not strictly necessary, this was very useful for debugging,
> > and it seemed too valuable to drop it from the final series. Similar,
> > improved support for receive FIFO handling is not strictly necessary
> > to fix DMA handling, but I initially thought that it was and added the
> > code. Like tracing support it seemed too valuable to drop it.
> >
> > The series was tested with qemu's smdkc210 and nuri emulations and with
> > exynos4210-smdkv310.dtb. Without the series, the emulation does not react
> > to serial line input, and serial line output stalls when using DMA. With
> > this series in place, serial line input is handled correctly, serial
> > output does not stall, and DMA interrupts are observed and handled.
> 
> Applied to target-arm.next, thanks.
> 
Thanks a lot for your help!

Guenter

