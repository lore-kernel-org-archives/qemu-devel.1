Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 531EBC33CA2
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 10:37:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B0772072E
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 10:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ftxP4xVe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B0772072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iprfP-0007TK-64
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 05:37:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36593)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iprec-0006c1-2S
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 05:36:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iprea-0002OM-Pa
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 05:36:33 -0500
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232]:36461)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iprea-0002KB-KG
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 05:36:32 -0500
Received: by mail-oi1-x232.google.com with SMTP id c16so1476916oic.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 02:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qfkbt4tPy2nIKQjGkOOmxy45FFpfM1oVWBQlL+upna8=;
 b=ftxP4xVeNI+ImzW3P87bUeLlYE860dU97v4Z+1+Zc8ZJRTVSi8kRsWUNsV9YyXlAMg
 SkimLvoyVMXcy5Vif/g8keXHqMFC+GG8LGIZR/7eSvYQ1Vjmtg9ZQAJJRPw1VykiPvn3
 r5/jYpW4sKfhIx53II/DD2pS3aonMICz6lLkLmyxGQnn9ByzVTe+eGSKyRTp9qpdQo3B
 NiP7gdDw9QWKIBhzN5Fvn2aXfnM8a9KJgjtq7jUDMw82q3Yy8vWTqgBxZ1YRFA4LwiEj
 tspMD06uf7597i194+w4nb+O9NZM/nrzZRsuRTHu8tuSWWuySFNRAEQASF6lxWw0Diyf
 9XTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qfkbt4tPy2nIKQjGkOOmxy45FFpfM1oVWBQlL+upna8=;
 b=kcPc2I7qi8T8MCwFIzu1WkbYNoga/fAhfZ6uBEw7Bw9za4yFU96aBkzU7KgD4PLVFK
 CW35Bvw89wK4icIpcGekEkU9HxwqDBgoOydBXvGViUI3Y0BAyViZPHp/iYwNxQuce+Ku
 2blDZWVXmK96COdsWeD2eTIMjBqvP21zX6bFFy9q3eT7DetEEuGNzR6UWQdaMkY1BOvN
 rRbcES6Bsm4yFtJV64hOSLA9UvJhXWsy84q0AMWjciDCUizpd6RaquDPAdMDKzAuSiJl
 CqGaf9kaDm7uZPwzhU4O7JtKy1vhrHWp2NCWX9oiqkO+cuyP01PJLhOc4jRUoKKNDLKf
 jTkA==
X-Gm-Message-State: APjAAAWMIHrr6vI+QOCY909DAr7zz+IKuO5snOcwMTVPlciZlJ87KCQI
 U0plsT70NgK6O7tEIqVSsk6kL4Ocy7rci+JyHnXhCQ==
X-Google-Smtp-Source: APXvYqxkI3V15v6eQWmXtItZg/BoVcWLvBMO3vC67ZvSpf6UC2HU2vYhzibXUPf2Gsv8egNfHzX8LErcQO3tWscJO2Y=
X-Received: by 2002:aca:3d7:: with SMTP id 206mr1684145oid.98.1578652591457;
 Fri, 10 Jan 2020 02:36:31 -0800 (PST)
MIME-Version: 1.0
References: <20200108183553.GA5608@roeck-us.net>
In-Reply-To: <20200108183553.GA5608@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Jan 2020 10:36:20 +0000
Message-ID: <CAFEAcA9t4X5Xnk0aS4C-vhKX2c3GA9XQ3zZRGYVGLEQsG=EgeQ@mail.gmail.com>
Subject: Re: How to tell DMA controller in qemu to terminate transfer ?
To: Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::232
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

On Wed, 8 Jan 2020 at 18:36, Guenter Roeck <linux@roeck-us.net> wrote:
>
> Hi,
>
> I am trying to fix DMA support with Exynos4210. The original commit
> 59520dc65e ("hw/arm/exynos4210: Add DMA support for the Exynos4210") doesn't
> really work, primarily because it assigns wrong interrupt lines (no idea
> how I thought I tested that).
>
> Problem I have right now is that the pl330 peripheral DMA in Exynos4210
> depends on a signal from the peripheral device (here: serial ports)
> to end a DMA transfer. To make this work, I need a signal from
> exynos4210_uart.c to pl330.c to terminate the DMA after the receive
> buffer is empty.
>
> How can I implement this in qemu ?

That depends. How does the UART signal the DMA controller
in real hardware? If there's a signal line of some kind,
then you can model that with a qemu_irq line which the UART
exposes and raises/lowers at the right time, that's then
plumbed through by the SoC to the DMA controller.

thanks
-- PMM

