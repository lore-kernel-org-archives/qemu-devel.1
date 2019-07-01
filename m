Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A9CC0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 15:07:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C4A320659
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 15:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UfUdIVfr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C4A320659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhxuM-0006aZ-Rg
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 11:07:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58620)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hhxXY-0005mt-5J
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 10:44:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hhxXW-0001di-WE
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 10:44:20 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:44519)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hhxXW-0001cM-Hu
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 10:44:18 -0400
Received: by mail-oi1-x243.google.com with SMTP id e189so10108663oib.11
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 07:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=v8mWmOTDXUBtlhUdnimPF0goXk8Uy165smt3zk5fOYA=;
 b=UfUdIVfrWj+XlxguyyRxkjPeK2B/tJ/NL4J6mdENeFvfST1kZsS2iKmFaYtPcx2hWs
 1PwKEBWQYrT74A4NUMSQtRx2y6asC2tqHy0ePXAbf6TLUXeyCww32xH/amU6LtR+OoJw
 dCqxGPG8qEmChsRvHDqA1/e2dYj6c6wEVFnC+wyyfPmttsppY+pTRmaabb9WuyG36n7+
 6V+Ja5gweoEbbQeNxH9NsHCYLoCTY1M/CGPheQ4QK34kiYgpOAIt/AAcc3srLDW6dg0R
 crTV9J2wjvhVIRl8v5wvrM+U/Ez+wqVuiS3MVsddTXOhK08diEA/KbhFpwYkqsqJHxeE
 zKAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=v8mWmOTDXUBtlhUdnimPF0goXk8Uy165smt3zk5fOYA=;
 b=kmWvW2vwoqb521yH0kL1X/CiUXMhclVvodqlmfSHdPMAK2qsJbloBHZWW2lz/3I9P1
 wJMlgjIMO1pu7JZrHhJqX3kymvjHJMSlc2m6qCbr/RhdwMoQqKxo9YU2lXMZOF9Va+Wl
 bGqd8EEsywkfVax1AB0d5LNYoWKWcpbpZzf54y7wjhFJoNwUzKrfT2WMQym93R1e8mDN
 rZJ6a+nf100XaBYSr5NHZBQUca4SD8K8C8OdrC8i12AUy65SrcB6gCE+1mdtUkvX7vyt
 T5R8XgIrI7wHvxUAr+MTR1P6fmy0QRtJYSkn7x7XrMZJgjL0RXA/382SJIvTW8abVDsO
 m0xA==
X-Gm-Message-State: APjAAAX5PKnkhXNmOIFsBskXamKU93uqut3/xROuU+VahuoGrOSpEuqO
 DkaeznM9zjpspVt/UedPm1Ef939dCUoH83tQSdc4Sg==
X-Google-Smtp-Source: APXvYqzLzUsClGTb4POACSnjAt0ZKTiA5DXJvRNw+S2oJqsbVPBKRN+zgGhU72plREBgQYzKAFdtdYViLMokA4F55yw=
X-Received: by 2002:aca:6185:: with SMTP id v127mr7240404oib.163.1561992257364; 
 Mon, 01 Jul 2019 07:44:17 -0700 (PDT)
MIME-Version: 1.0
References: <1561890034-15921-1-git-send-email-hongbo.zhang@linaro.org>
 <1561890034-15921-2-git-send-email-hongbo.zhang@linaro.org>
In-Reply-To: <1561890034-15921-2-git-send-email-hongbo.zhang@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Jul 2019 15:44:06 +0100
Message-ID: <CAFEAcA8Dxyz9tkhmmV0ACjCDw+r9q73-AY6vhK0cRE9AVLhrLA@mail.gmail.com>
To: Hongbo Zhang <hongbo.zhang@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
> the first part.
>
> Signed-off-by: Hongbo Zhang <hongbo.zhang@linaro.org>

> +static const TypeInfo sbsa_ref_info = {
> +    .name          = TYPE_SBSA_MACHINE,
> +    .parent        = TYPE_MACHINE,
> +    .class_init    = sbsa_ref_class_init,

You need here to also have

    .instance_size = sizeof(SBSAMachineState),

> +};

Otherwise we won't allocate enough memory for the size of
the struct, and will run off the end of the allocation.
You can see this if you do a build with just patch 1 and
try 'make check' on it with a clang-sanitizer build
(ie passing configure  '--cc=clang-7' '--cxx=clang++-7'
'--extra-cflags=-fsanitize=undefined -fno-sanitize=shift-base -Werror')
as it will catch reads off the end of the memory.

thanks
-- PMM

