Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04CC1C83000
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 20:05:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F1B02076B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 20:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dV67b3At"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F1B02076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTsxE-0005nu-Az
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 16:05:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50576)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jTswE-0005Jk-7z
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 16:04:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jTswD-0007ql-GY
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 16:04:09 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f]:35931)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jTswC-0007qW-Td
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 16:04:09 -0400
Received: by mail-oi1-x22f.google.com with SMTP id s202so3005506oih.3
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 13:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Pc6uCheg5bSUEvPzOOBqyBuV/BB4vFhQg6Zv0nEjVmg=;
 b=dV67b3At6N479/JxbeEs57SY7oeTlEOpZVjZQMUAwTOo+tg5U19yiQhgh1wKkxSQSz
 VmVEmAllSWC/0AfRPJ4LKo/y3q38FU779Z1tIs6akc/j2O12NovclDrihLCzUmSgGMiH
 ZxK9mhhzGPy9kFKj1qaYBirYBN4XlK/wgPyDstmA9QrU0bb6jAg30OvowQPp+rFKxhBq
 mSRVm0XOEeAvEI5BKlAv+t4qTDcH5/I07LApPGPYBL4CevuYWUweNLaShY9G5x7qBwql
 K7zA640priY1O7ys9fzf2K1bS4m+PhTlj1Wz8LEDrrubvPrXKJu6UoBlivPOF0CY7GYx
 yZ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Pc6uCheg5bSUEvPzOOBqyBuV/BB4vFhQg6Zv0nEjVmg=;
 b=CIy6oUM6Zlg813RxfTdlTEt/X5xCiC55ZgdjGvzK7UNaw6a7S3nLMxbOUBsBIuFgFp
 oIrP64RwshI9BUk4YldupFIeD+muBCIvSB2LAUe9Oi1F2RYOOB2vHsxr/VNo65YHuP81
 dkWbVFWQnOk1XoJfA02LP4NO9d8vcflRauPUJ8CiG9GNfHgEvJFDSqKUVRuwaNrPbKGv
 VE5pscqJWhOmqj4HV8P2sq1VMV5Hnz+C5JRqWz7tpY9kFJYqAtqBh8SzY58+jse5QF4w
 gSKYNWFD8rq/qrnY3HsOLFc5VAKXLxtPnPadGwT/ZIsInypBBz26iNn+nx4pbxa/dI71
 TeMg==
X-Gm-Message-State: AGi0PuZNuAuDM/OOWbRcjUp6NmY4IX9hG4hWLXjMldB/ufOAagW0m5s4
 wh8Kb/murJYwEbQwihXVAbbri3elzJFtoy47B31Ifw==
X-Google-Smtp-Source: APiQypLjlg31JL2vWmJcHt2cV9/x5v0DYBI8ckZ36ssXbKqtO9zjftBu40w6jRvHeadXMePaCCfN8nXZe//J2flKpeA=
X-Received: by 2002:aca:3441:: with SMTP id b62mr2854732oia.146.1588190647622; 
 Wed, 29 Apr 2020 13:04:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200429182856.2588202-1-alistair.francis@wdc.com>
In-Reply-To: <20200429182856.2588202-1-alistair.francis@wdc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 29 Apr 2020 21:03:56 +0100
Message-ID: <CAFEAcA-ZqDFo=D3YZgqLpvhzW+Jq8h-JNynDS05E2bSa6FOLEg@mail.gmail.com>
Subject: Re: [PULL 00/14] RISC-V Patch Queue for 5.1
To: Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x22f.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::22f
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
Cc: Palmer Dabbelt <palmerdabbelt@google.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 29 Apr 2020 at 19:37, Alistair Francis <alistair.francis@wdc.com> wrote:
>
> The following changes since commit a7922a3c81f34f45b1ebc9670a7769edc4c42a43:
>
>   Open 5.1 development tree (2020-04-29 15:07:10 +0100)
>
> are available in the Git repository at:
>
>   git@github.com:alistair23/qemu.git tags/pull-riscv-to-apply-20200429-1
>
> for you to fetch changes up to 23766b6a35d5b1664ab782c02624bf2435c4ed5d:
>
>   hw/riscv/spike: Allow more than one CPUs (2020-04-29 11:23:44 -0700)
>
> ----------------------------------------------------------------
> RISC-V pull request for 5.1
>
> This is the first pull request for the 5.1 development period. It
> contains all of the patches that were sent during the 5.0 timeframe.
>
> This is an assortment of fixes for RISC-V, including fixes for the
> Hypervisor extension, the Spike machine and an update to OpenSBI.
>
> --------------------------------------------------------------

Hi; this doesn't apply to current master. The conflict looks like
it's probably pretty easy to fix up, but could you fix it and resend,
please?

thanks
-- PMM

