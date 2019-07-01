Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C085C0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 14:32:23 +0000 (UTC)
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2766C208CA
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 14:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KaN4YC/O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2766C208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhxLy-0001ML-BU
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 10:32:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54760)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hhxHy-00067o-GE
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 10:28:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hhxHx-0006aJ-Do
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 10:28:14 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:32926)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hhxHx-0006Zc-7U
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 10:28:13 -0400
Received: by mail-oi1-x242.google.com with SMTP id u15so9980763oiv.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 07:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7SXR3zO9cp1ANHx7ow9CJZAvcgm5OoRPKzo7VdBR5Rk=;
 b=KaN4YC/OT8uUTrRz854sdDDoZSJH3CHZ4MrlgNuzqNhb9jSdVYjRMOAv9ShrrwW8Ol
 omxJkjAu+AszK4hp4OfCLvy9p9rkjIcZtrGs6tMCIFc7i++DDh3OxDWhd5t0lOuG2F8S
 pEh59HYv17p2qCKN8VUJgqJafZk8umhPBwP/19E+jV1c+jtRJC7Z5xMQs8zKootoKsje
 bO/XbxCvFRjWBS5cAwIiIhFDC/MA1IViFJGIW+8g5tyYvMZBb9qAjb1cG5yZccqjl0bn
 T44NDHi27QAW653y6CNXSrcMJDgJEGazm9zBhS7+4ltetN4sicrv5P8v63z0HvSk+KLk
 WF/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7SXR3zO9cp1ANHx7ow9CJZAvcgm5OoRPKzo7VdBR5Rk=;
 b=B6eHUYA7rp1ersmzkgilguWzmlQri3EwWoV4PEFKFP6ee6CFM6nFXZJ5uwzc5muaCP
 P/JwKUPGuw8dhabHogpLncEufY5la5uV78RUnq9VDO+uLl5wiXNVUO6+JVhEXoC0Vh4t
 blIH7qMqN2uv4C0BTmCpcvXcpxsYHEB/BDcTLOEFeAkDaJvp9q3/l1mQLL+tk7YV7rn2
 PMhv9BZguOESzpshTSbCKtZS4Q745oRI0nvFO6iDt9V42vAs4d04VkW899K2WKCHaxD2
 AMPlgE+v3vCAeGlB8thdhqNgZndtAjsXkv/VYNWR5e4tA+fFJwsvY773pLiK5UYHqPq4
 haMw==
X-Gm-Message-State: APjAAAUaSBDJiOq+l/tHMcVx00laR9uxLeLwQzsxhZflpgZSI7SWTBK/
 OGkBrY+87chbD9OCuKN7lDWTOHuB/oT8TWT5oHjiZQ==
X-Google-Smtp-Source: APXvYqwITMHlOSiO83rYYAMxf6VxQeipdnmbMSvvFxwPI4G8xLQb27tDgwxxKr5yJRNqb+OlYY+SjVJOKPCGPJJz78w=
X-Received: by 2002:aca:ac48:: with SMTP id v69mr6787581oie.48.1561991292023; 
 Mon, 01 Jul 2019 07:28:12 -0700 (PDT)
MIME-Version: 1.0
References: <1561890034-15921-1-git-send-email-hongbo.zhang@linaro.org>
 <1561890034-15921-2-git-send-email-hongbo.zhang@linaro.org>
In-Reply-To: <1561890034-15921-2-git-send-email-hongbo.zhang@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Jul 2019 15:28:01 +0100
Message-ID: <CAFEAcA-F7kcQe1cPn4v22CJu=SyEq5Bi9hAXtb-Z1+-f2b6tYA@mail.gmail.com>
To: Hongbo Zhang <hongbo.zhang@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [PATCH v9 1/2] hw/arm: Add arm SBSA reference
 machine, skeleton part
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Leif Lindholm <leif.lindholm@linaro.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 30 Jun 2019 at 11:21, Hongbo Zhang <hongbo.zhang@linaro.org> wrote:
>
> For the Aarch64, there is one machine 'virt', it is primarily meant to
> run on KVM and execute virtualization workloads, but we need an
> environment as faithful as possible to physical hardware, for supporting
> firmware and OS development for pysical Aarch64 machines.

"physical"

>
> This patch introduces new machine type 'sbsa-ref' with main features:
>  - Based on 'virt' machine type.
>  - A new memory map.
>  - CPU type cortex-a57.
>  - EL2 and EL3 are enabled.
>  - GIC version 3.
>  - System bus AHCI controller.
>  - System bus EHCI controller.
>  - CDROM and hard disc on AHCI bus.
>  - E1000E ethernet card on PCIE bus.
>  - VGA display adaptor on PCIE bus.
>  - No virtio deivces.

"devices"

>  - No fw_cfg device.
>  - No ACPI table supplied.
>  - Only minimal device tree nodes.
>
> Arm Trusted Firmware and UEFI porting to this are done accordingly, and
> it should supply ACPI tables to load OS, the minimal device tree nodes
> supplied from this platform are only to pass the dynamic info reflecting
> command line input to firmware, not for loading OS.
>
> To make the review easier, this task is split into two patches, the
> fundamental sceleton part and the peripheral devices part, this patch is

"skeleton"

> the first part.
>
> Signed-off-by: Hongbo Zhang <hongbo.zhang@linaro.org>
> ---

> +static const int sbsa_ref_irqmap[] = {
> +    [SBSA_UART] = 1,
> +    [SBSA_RTC] = 2,
> +    [SBSA_PCIE] = 3, /* ... to 6 */
> +    [SBSA_GPIO] = 7,
> +    [SBSA_SECURE_UART] = 8,
> +    [SBSA_SECURE_UART_MM] = 9,
> +    [SBSA_AHCI] = 10,
> +    [SBSA_EHCI] = 11,
> +};

This array isn't used in this patch, so it needs to be moved
into patch 2, to avoid a compile failure with clang because
of the unused-variable.

thanks
-- PMM

