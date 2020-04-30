Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E286CC8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 12:10:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A599220757
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 12:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XOWsX2j7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A599220757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU81k-0003tN-Pv
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 08:10:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34032)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jU7kF-0004Yb-Bk
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:52:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jU7kE-0000Xq-69
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:52:47 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336]:37486)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jU7kD-0000XM-Nr
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:52:45 -0400
Received: by mail-ot1-x336.google.com with SMTP id z17so4639440oto.4
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 04:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Izs21Dp5htQo5BsetrxdKdZNkodJ6x5Fwd/PALoe3gM=;
 b=XOWsX2j7wxxmuQmkQxrDgpGmfQj6kh38hlLsjBBf4fI0P7YAVRq/fsWxbJDfiFrncs
 l5stKnrYzWnDAxfLJkfBBC1uJ00EtrIWIqpivonBWFwXxtBHzT61O6i9FaxIED0PAG/j
 AJjGxbaknYjo/TWaWyKMH5AJw9U/5VxO74ucEHO3eemTfQI9HUn3R2P4TUrF2LiBkhsu
 b/ri799XcePxH6hh0h1DslkH1Kk8Cj7vCinOhauIf6s1ms6NPkVWaUoiEVtNyri/Y2ck
 RHsR3Um5+ZjPYZWrParD0m0l1gvYqlWvPSRW9NlqaylSGXFLOFCvkDmE8f66wk+L77e0
 JIPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Izs21Dp5htQo5BsetrxdKdZNkodJ6x5Fwd/PALoe3gM=;
 b=W8xEIi4urUJM1RNgU27N5srKr657+DtyFZRHa9Y7isX0e+mnrtmBQj2of0lN9eP+Xo
 7VJy2P+MWvP0PGp/P/vm5THDEgMv8lS+K4yeNnGfOd/6jVFR6nD2cE30MPcpVlLnT4uZ
 t2wnxkl8jItKRyTbXyR0ANoLYMlCbXgGlw7aDISY/emet9UEtX5bESqTXO49z5VI0IGa
 yu6Y/3Db74BRSVogko1KBHlKhari6/H+aRFBhTi/AkjyWblfTiznCBF4huvuU9RzhaGO
 wuHbo3NBZ2phjWPaWl9nuEd2tXxCk6eIfhVSwzqMLunkIUiHJ/PnSDT3ub8N7DOzx4yq
 sVPg==
X-Gm-Message-State: AGi0PuZ3l+3fdP47ksUiO91Lrmc5Xs5YyE7B6wzOLD/PJ5edSVHombE/
 oSde9q31lsLorFskFnfUN5OpqDff9152osFbElc0OQ==
X-Google-Smtp-Source: APiQypKGHjUIVl9cqGW7cp6iw8qHumIRHIR5IoLraX7rhyYg4L0rCSoOyEojsmoPmiTx85+tgEEu+ohZc2x5mwpxDDw=
X-Received: by 2002:a9d:2c08:: with SMTP id f8mr2195218otb.135.1588247564326; 
 Thu, 30 Apr 2020 04:52:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200429202006.775322-1-alistair.francis@wdc.com>
In-Reply-To: <20200429202006.775322-1-alistair.francis@wdc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Apr 2020 12:52:33 +0100
Message-ID: <CAFEAcA8d5y1d0hsNfPakVxoTqdPJ7NSUr6d5PQcwRDUtX9pq4A@mail.gmail.com>
Subject: Re: [PULL v2 00/14] RISC-V Patch Queue for 5.1
To: Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x336.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::336
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

On Wed, 29 Apr 2020 at 21:28, Alistair Francis <alistair.francis@wdc.com> wrote:
>
> The following changes since commit 648db19685b7030aa558a4ddbd3a8e53d8c9a062:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-misc-2020-04-29' into staging (2020-04-29 15:07:33 +0100)
>
> are available in the Git repository at:
>
>   git@github.com:alistair23/qemu.git tags/pull-riscv-to-apply-20200429-2
>
> for you to fetch changes up to 31e6d70485b1a719ca27e9a2d21f2a61ac497cdf:
>
>   hw/riscv/spike: Allow more than one CPUs (2020-04-29 13:16:38 -0700)
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

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

