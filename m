Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FEF8C35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:05:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BC9F218AC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zCbUrq2O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BC9F218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Zu8-0000js-Cf
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 08:05:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35595)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j6ZsQ-0007PS-Bv
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 08:03:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j6ZsP-00012g-8j
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 08:03:54 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:34481)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j6ZsP-00011N-1U
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 08:03:53 -0500
Received: by mail-oi1-x244.google.com with SMTP id l136so12442261oig.1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 05:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Acw6Js8G5cqiyhObPuNAuN3cnonY0/zHBkQOyuuBJU0=;
 b=zCbUrq2OJlviLLGzmr9QI0s6YRHcpqy6/CN8Zvy6Drs2fOwySwbT++2ZUYGZBlwf7K
 gV7vwILhtAP9UvuTJtgE27+r1d4/8siO2sac8REPNlPgE+uxAPoihEGKnZJiZL8M7jXm
 wq69XlhnDwPvcjH+s334uA9jeakCZKtil4WpOSogtVMaCxjReVF5/WKIqw8igYbL5iBc
 T+t84K2jx8Tmw+nkqbFBwBCe7nXONv/cuF8HrPw/X5m8eI4W33NoULa+XWzwubE7C4j1
 /0ubKM7OJRrWA3CXKhezYzfNSa2PsBre4e2HDigKr3rNkR3rSDfqYTrvVf9hOrXtoxUB
 BsZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Acw6Js8G5cqiyhObPuNAuN3cnonY0/zHBkQOyuuBJU0=;
 b=VAA8YSxkUctbOrgGt6CtLigRvP/MKQ8kX/gmRndTh2mzE40FZZNf4mGTf09/JqeTU9
 pU1XS6CHyPRtZKEcwPrfJul/yJToMlgHcSEbSkPiBXUZD2T21EOxksPyPJqJyUQyrpK2
 Pe4WrGVzIGOZpTa4cMxA28jlzk+uvig480e3CbO+bRRQewSgB9q0m9vqMCxvdrbLiDIO
 XF3UC31GbC2Sdz/KD8CduPsDsQNq2ysnjpSL3PfrsOA8C56yeAXfiCHU+ukawJr6SLfh
 whNMEHLXI062cquT8VBEEcywmvl1BRtBonq1Fd/eyAgegZovmVrBlKxLz20P5rldaBX8
 N/Rg==
X-Gm-Message-State: APjAAAWgmxccl4vO5Jd734lhY+oGGg4M9PakfJKnhGec/UOw/x4wTvzG
 9n42Hd9+q0ZDrOf085yPvV8ccj5m4M6BNJWxe+2AKw==
X-Google-Smtp-Source: APXvYqwbNbtoIHn4XL7njvv1UMt0PKt6RyK+mMea7uNA0Coe0lVhduKHaUHohPRzIVFDaqLJrRIY0YocaVDfBVbe0pA=
X-Received: by 2002:a05:6808:289:: with SMTP id
 z9mr3339127oic.48.1582635831963; 
 Tue, 25 Feb 2020 05:03:51 -0800 (PST)
MIME-Version: 1.0
References: <1582537164-764-1-git-send-email-sai.pavan.boddu@xilinx.com>
In-Reply-To: <1582537164-764-1-git-send-email-sai.pavan.boddu@xilinx.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Feb 2020 13:03:40 +0000
Message-ID: <CAFEAcA9_SvWkqiq67noeHEfkOT7nMX=yHNuikUkBPkM=_bi0jA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Fix number of priority bits for arm boards
To: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
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
Cc: Alistair Francis <alistair@alistair23.me>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Anthony Liguori <anthony@codemonkey.ws>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 24 Feb 2020 at 09:44, Sai Pavan Boddu
<sai.pavan.boddu@xilinx.com> wrote:
>
> This patch series implements the mask for unimplemented priority bits in
> arm-gic. Which will return the expected number of priority bits on read.
>
> Changes for V2:
>     Followed gicv3 code for defining mask for unimplemented bits
>     Hardcoded num priority bits for A9 and ARM11MPCore boards
> Changes for V3:
>     Fixed the code as suggested in V1.
>     Implemented checks for max and min priority bits.
>
> Sai Pavan Boddu (3):
>   arm_gic: Mask the un-supported priority bits
>   cpu/a9mpcore: Set number of GIC priority bits to 5
>   cpu/arm11mpcore: Set number of GIC priority bits to 4

Applied to target-arm.next, thanks. (I tweaked a few of
the commit messages to give a little more detail.)

-- PMM

