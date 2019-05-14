Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D48D4C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 10:12:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CEEC2085A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 10:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gczBr28G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CEEC2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44762 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQUQ6-0006HE-Q2
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 06:12:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hQUKz-0002tg-B1
	for qemu-devel@nongnu.org; Tue, 14 May 2019 06:07:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hQUKy-00089O-ES
	for qemu-devel@nongnu.org; Tue, 14 May 2019 06:07:09 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:37779)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hQUKy-000805-8D
	for qemu-devel@nongnu.org; Tue, 14 May 2019 06:07:08 -0400
Received: by mail-ot1-x344.google.com with SMTP id r10so13927553otd.4
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 03:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=7tU1y6cgDjkQulfnQj1uO3ZTQRYqn7MfRQezNbpW6lI=;
	b=gczBr28G3EVkNl4b5DarsJhVdC84KqN522VaCrnetnuMGTqQiDKnpKktIs5SJWUQgW
	gKGI5G33Y/j9c6V/QsFNZjoecs6RdYOG/k/rh6WbM810+BE2a2t+AeFpdiDfumjrwrZk
	oHzTIx1UiaywFc2fTgtJxiVQpyXqpbp26lmffxY5UmH7UZvLwTDJjqLpH+9mreqN73DZ
	0ZqWnddodozaF3MrbJ/LQfA2HaHh4yFTTIoR898vxIz8qPjW0kE1UbyyUJp31Pe8I7nn
	LVJPFFjivj4c6FLoQ4lPKzA2p/D4fQ/cUF1dLYs+VaZPRtod3lIvgNik+cG13h1YjJBW
	fOoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=7tU1y6cgDjkQulfnQj1uO3ZTQRYqn7MfRQezNbpW6lI=;
	b=Dy0eWnyT6ocgoDqlpriPb4rij55DN6dNyjwU1g9LHWHDnLwdk6YihktoeaBXeZqhCY
	d9VIWOIWX5jYzYdvLjM5IIWrw1/0OFUg8EjAlM/gHeGmdlo4BJYJV7EaN+BnQd7DhIxQ
	ZtfyyU1GpGCepkJ175MUEA/GMu//M7uN0vIjy8D9F0oTxc0UKm/RufDnCiKGZ+y12C2q
	LF2sKON9ElTc3bJHew3OlaPKyRYikgN/UarIsfLJ4oA9P89wOrtCGkiyTrVca/5vmTHR
	cXCIQf07+dn2WDf0yhxp7Qc6EiM1omq1lloSlljvQOoa9fWstYb+KDejnGj/adHQwFI2
	cRlg==
X-Gm-Message-State: APjAAAVu5Lgi4mu7aahskGbNejmON0FnA9S8zgI+ZzKKVe5xkiZA2Hy1
	is0UZPuWVbIWx5TUNHbwpHcrkhhND/g6GrFF/Ak8tw==
X-Google-Smtp-Source: APXvYqzIPzJd+0AXNk4lgoPMHQ0oKdp+CZkTb5T1tnGlL4qEy1G32ZXmacunVGmqRYa/dLzTzZZNVxiuCDexNE+Jmz0=
X-Received: by 2002:a9d:5e07:: with SMTP id d7mr18983749oti.21.1557828425254; 
	Tue, 14 May 2019 03:07:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190514100019.13263-1-thuth@redhat.com>
	<20190514100019.13263-3-thuth@redhat.com>
In-Reply-To: <20190514100019.13263-3-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 May 2019 11:06:54 +0100
Message-ID: <CAFEAcA9bGr1249Ofx=TXLK3JNs1KMWTnRR+-FexKr__0AJAipQ@mail.gmail.com>
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 2/4] hw/core: Add a config
 switch for the "or-irq" device
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
	qemu-arm <qemu-arm@nongnu.org>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 14 May 2019 at 11:00, Thomas Huth <thuth@redhat.com> wrote:
>
> The "or-irq" device is only used by certain machines. Let's add
> a proper config switch for it so that it only gets compiled when we
> really need it.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/arm/Kconfig        | 2 ++
>  hw/core/Kconfig       | 3 +++
>  hw/core/Makefile.objs | 2 +-
>  hw/pci-host/Kconfig   | 3 ++-
>  4 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index af8cffde9c..0bb3bbe9d3 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -277,6 +277,7 @@ config RASPI
>  config STM32F205_SOC
>      bool
>      select ARM_V7M
> +    select OR_IRQ
>      select STM32F2XX_TIMER
>      select STM32F2XX_USART
>      select STM32F2XX_SYSCFG
> @@ -424,6 +425,7 @@ config ARMSSE
>      select IOTKIT_SECCTL
>      select IOTKIT_SYSCTL
>      select IOTKIT_SYSINFO
> +    select OR_IRQ
>      select TZ_MPC
>      select TZ_MSC
>      select TZ_PPC

In cases like this where a device is used both by
an SoC and also directly by the board code that uses
that SoC, should we put the select OR_IRQ only in
the SoC's config, or also in the board model's config
(ie, in "config MPS2" as well as "config ARMSSE") ?

thanks
-- PMM

