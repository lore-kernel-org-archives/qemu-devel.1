Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C7EBC43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 14:16:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7A63206A5
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 14:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NwjSHSjL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7A63206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igrB7-0004iD-U4
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 09:16:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59614)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1igr2D-0001BR-ML
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 09:07:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1igr2B-0006Cp-Q2
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 09:07:41 -0500
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:33236)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1igr2B-0006AI-Jm
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 09:07:39 -0500
Received: by mail-ot1-x32e.google.com with SMTP id b18so771864otp.0
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 06:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=xfr4RsBDQPOFJsdG34apmzlNuzmpFAcZLgDsrhJEODA=;
 b=NwjSHSjLT8J4Tdol3XdMmczkerp0vWC+2Csy9Ojgf58C3Bf9y4skAvutsyuHk48QSx
 Q708Ew+QTImNkng/WwMQ1jDJuFxlIDnfRKDk4So+ykoQ3ttWENR1uq6oMlUmF/uAPy7N
 Be6JS+ExY+zj/4xImQUKwAHnTUzZcyqRiLGOrneoqlSd7Mo16m4cWtyAoUf8nAFmBGJB
 7NA9fJLSqjZmi7temWFfY53MSgVPskuvGV6RthcdekIS0iY/T2WLmsO1Ufnfs+W8sd4X
 sO2rHTsgwPKL5PrewiNLJzVn190WbPeM+cKKiiMmWm6UKih+Z3M2Jw3AT+/fxGRO8fud
 2Q/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=xfr4RsBDQPOFJsdG34apmzlNuzmpFAcZLgDsrhJEODA=;
 b=PvBInpl3QdUfZLDHBtacyqt8pfmSISWJNde3QLk6/m6rFMAYTNg8MOPM0m3imIz89e
 UNY5NAdOJqF7J6uuo+N1SMsb7KO/tNBwMS5Pu32I9VKk9FnnfEGdFSjS7dVCmB5dY2bf
 IWl0m9EfAESuRy7GOYdz1Hf1we0o0AZHmjY69YuATHLxL7TFq2n9DyTx/MG632+THix6
 fs/fpZoZeefTgknx9gT80OEtTxFc33NeLBvhNjXvmvcxWg08nWi9EhGJu3v0vfXyuvdg
 pi7jwZuRuMqiFWvYfYbOVUTw70n3FHfGtd7xF1T5jZIkVSliqwLiOHxW0rPurIXkT+SL
 C2MA==
X-Gm-Message-State: APjAAAV1gAomZQmN311p5tUhGVXRg1SKD45RfF8js4xF1LWizJ5RsMrW
 DyAbIhkAV+3dY4Uuo0YEFGivrIRoMlqUS+VkfzACOIEBaZY=
X-Google-Smtp-Source: APXvYqzUoPPFSZ7g4ez4P9XRclxJbtuuuIIKIdGYGGrSzsmr6MKlMecReGVfsii5yeGwKS4Kv51y+jSd/PHDz/UwDQ0=
X-Received: by 2002:a9d:4d8a:: with SMTP id u10mr32881983otk.232.1576505258277; 
 Mon, 16 Dec 2019 06:07:38 -0800 (PST)
MIME-Version: 1.0
References: <20191216110904.30815-1-peter.maydell@linaro.org>
In-Reply-To: <20191216110904.30815-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Dec 2019 14:07:27 +0000
Message-ID: <CAFEAcA98eUpMieL3z3PFake18LeSQmX=aL8cmgUqotii5-+8LQ@mail.gmail.com>
Subject: Re: [PULL 00/34] target-arm queue
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32e
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 16 Dec 2019 at 11:09, Peter Maydell <peter.maydell@linaro.org> wrote:
>
>
> First arm pullreq of 5.0!
>
> The following changes since commit 084a398bf8aa7634738e6c6c0103236ee1b3b72f:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2019-12-13 18:14:07 +0000)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20191216-1
>
> for you to fetch changes up to f80741d107673f162e3b097fc76a1590036cc9d1:
>
>   target/arm: ensure we use current exception state after SCR update (2019-12-16 10:52:58 +0000)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * Add support for Cortex-M7 CPU
>  * exynos4210_gic: Suppress gcc9 format-truncation warnings
>  * aspeed: Various minor bug fixes and improvements
>  * aspeed: Add support for the tacoma-bmc board
>  * Honour HCR_EL32.TID1 and .TID2 trapping requirements
>  * Handle trapping to EL2 of AArch32 VMRS instructions
>  * Handle AArch32 CP15 trapping via HSTR_EL2
>  * Add support for missing Jazelle system registers
>  * arm/arm-powerctl: set NSACR.{CP11, CP10} bits in arm_set_cpu_on
>  * Add support for DC CVAP & DC CVADP instructions
>  * Fix assertion when SCR.NS is changed in Secure-SVC &c
>  * enable SHPC native hot plug in arm ACPI
>
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

