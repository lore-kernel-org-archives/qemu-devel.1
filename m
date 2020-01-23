Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A05C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:03:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A18552071E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hcZ0CQug"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A18552071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuftT-0005ME-VH
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 12:03:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46393)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iueI1-0002Xx-Tg
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:21:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iueI0-0004vg-P4
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:21:01 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:38738)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iueI0-0004vB-6G
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:21:00 -0500
Received: by mail-oi1-x244.google.com with SMTP id l9so3219815oii.5
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 07:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4YdT+X4UZ9T1P6M+i6pylJQ2Rj9JmdJAcxMgiXyp4xU=;
 b=hcZ0CQug0H7HdJiAOe36eeO7mVDQSQQ5aUHT0KSFFZ9s22v1G6e/hVWtBsuDqmxMGJ
 0FPDZTG5IbsOCqZKwvMisZnKgcDUU3olMx126ZxEyk6mixI/7kMF/Emhu6Tz7uUd48Yq
 TF8pi2sVSivP59sK2wepgBKfry7rvT1iiCUFQ83m99+lPT/+dp8O35NAuWCvpy9zPGik
 JvOjHvpfS3pUTPV7k4C89xs6TouhZdB4dDc6Y76fzgXwtgFUF2UGDEEqRBVSaptZNS5l
 JEy2qC5KnIi1NEjqyTAbkdMDI6+1kLUR08J0KxpoHLSMfVnsKu5OaFVjYYIFKruJyZOZ
 7LMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4YdT+X4UZ9T1P6M+i6pylJQ2Rj9JmdJAcxMgiXyp4xU=;
 b=G6+VQhma2xCnC1Z8gZ059c3vS0ooxYvREAuZQQi4xeGXxCv5brENe1G5Jj0k4Ny6FR
 yC9IX8eqg2cP2C95l9Ce7UUcSSrpYz4rWOvWKt0DVCvZZhNBl/ES5B21o9p/eW3Kuae5
 6n1RZm4YdRD5E2Z3aUka1T8ri5UP5ykfmX5fBMI1EnKo5sofAb5ir61Eq3gK21iWaAEJ
 29qmeiPqK6tEBJVrpTscVzlcStTBryyhTLYlxfYJwTReZ2KqPm6bfLXV3BRu5CrLZ0PH
 FjlKqy+GRV1gmhgM7n93vEEu6SQGoqpR8nQkC97jrltYriRv98lLnBWNmna435shVBzK
 vTMw==
X-Gm-Message-State: APjAAAUwSir/erA0QoSRU/OBqm1bpp04emma4bJIgbKpJNkCfBQcrR1o
 M7WfVET/a01vcdE+qF7FvAJo0OVuh8AokN3N/sp899Do4d0=
X-Google-Smtp-Source: APXvYqwRrqwHz2yEfhBLmXeTq25NQ0DekrePRy0Sg6zj+EnrIPClAt84oyrYOBgi5cZTU/B9c19mEkQdwNArUQcsmPY=
X-Received: by 2002:aca:3182:: with SMTP id
 x124mr10935204oix.170.1579792859484; 
 Thu, 23 Jan 2020 07:20:59 -0800 (PST)
MIME-Version: 1.0
References: <20200123052540.6132-1-linux@roeck-us.net>
In-Reply-To: <20200123052540.6132-1-linux@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Jan 2020 15:20:48 +0000
Message-ID: <CAFEAcA_CVt87SwQ7OdB=phedEez1K_mJyrMLkY9dCZuzNFfEsg@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] Fix Exynos4210 DMA support
To: Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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

On Thu, 23 Jan 2020 at 05:25, Guenter Roeck <linux@roeck-us.net> wrote:
>
> Commit 59520dc65e ("hw/arm/exynos4210: Add DMA support for the Exynos4210")
> introduced DMA support for Exynos4210. Unfortunately, it never really
> worked. DMA interrupt line and polarity was wrong, and the serial port
> needs extra code to support DMA. This patch series fixes the problem.
>
> The series also converts pl330 and exynos4210_uart code to support tracing.
> While not strictly necessary, this was very useful for debugging,
> and it seemed too valuable to drop it from the final series. Similar,
> improved support for receive FIFO handling is not strictly necessary
> to fix DMA handling, but I initially thought that it was and added the
> code. Like tracing support it seemed too valuable to drop it.
>
> The series was tested with qemu's smdkc210 and nuri emulations and with
> exynos4210-smdkv310.dtb. Without the series, the emulation does not react
> to serial line input, and serial line output stalls when using DMA. With
> this series in place, serial line input is handled correctly, serial
> output does not stall, and DMA interrupts are observed and handled.

Applied to target-arm.next, thanks.

-- PMM

