Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A95C3A59F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 19:54:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F38932184D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 19:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yedh92U2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F38932184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2L4L-0002wI-6K
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 15:54:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46040)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i2L2J-00017z-Na
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 15:52:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i2L2I-00063C-Ny
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 15:52:19 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:37517)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i2L2I-00062x-Hj
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 15:52:18 -0400
Received: by mail-oi1-x243.google.com with SMTP id b25so13111672oib.4
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2019 12:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wsQSsDSjnsZdMZjo0xkidElZrPufq2mB/NuD5hpzyXs=;
 b=yedh92U2qt1mqgFz9E39m85vTwfHGFBp+qOYfs2OohBGe72iKcAWC//hdrk72Oepcx
 3EcV9WqR8/mhn41b1iAhrgj3mk4+Gag+0woPOuJcQ7+tQQ2a50JwkPcA81pLbFWGXaMt
 NFamtPhFKvJn3nXfJCFohcQrGPnOIziv85CKOSPktmIj+724DHcDH8hS5T1ydJXIaTwA
 yghYiy2MKO95xwzNvQgT0LdmAm68tf4k+hEETEdX/hpIgkTEpQkSSMSMXxeGPPQy1/o7
 TbTp5/G0zARlln8WK9mKYA+ij7+LXwp6MQeR2BGZfhtUniOws4aOVgq6Y1ghH2fHMSWw
 cCMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wsQSsDSjnsZdMZjo0xkidElZrPufq2mB/NuD5hpzyXs=;
 b=S5XruKF7YWdX/wxXllMsot27HrCYXeC2ya4OjBrABvm5IBTUpoB2DxHAUlRUjbdTZJ
 w596+dUiccdt9gu185Z3BAqCDXdKBMFwWWcBc+614zaPfUpUR52pkPxSMXMoNPfbq95s
 HXvnD0sAU6xmgQ58hR7Rxn7VdoJ1pS290bLfBYEcM9Rr4WEBqkgRLCDXyB+CqAPU05hZ
 stZTe8oijNdIVacKQpLoI6hn76xOnVeqHfXQX6sSMuhAZoccId0B/fbUYU+vDjsFE/2T
 vAEnMtSd15lKU/SKR/iZ541HAaXLbCEHrIGrkr6gaNWljo25Zmcr3cRzIrvyh9KMzHp0
 +W+w==
X-Gm-Message-State: APjAAAV6nQEEt1gijWKBPF9x2JaLOlXimAUusAM/ZJXJLfyXOTvrb+j0
 8uKibugPNY6J+sTqUyfP5cKUZXj0w8DHxFTb0C+Sjw==
X-Google-Smtp-Source: APXvYqwPuFHxRhQFkHlLNNUlVAod6baOc7X/wledYYYbsn7O0IC0ZfzYxZnudjyr+nkAZ8BL75lkVW3UXHG+2skCyGk=
X-Received: by 2002:a54:4718:: with SMTP id k24mr13169665oik.146.1566849137740; 
 Mon, 26 Aug 2019 12:52:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190819213755.26175-1-richard.henderson@linaro.org>
 <20190819213755.26175-62-richard.henderson@linaro.org>
In-Reply-To: <20190819213755.26175-62-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Aug 2019 20:52:06 +0100
Message-ID: <CAFEAcA8N_X28ADZgoaWhj1wHjD5Rg48pfU+bYicZw4NmDW8DdA@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [PATCH v2 61/68] target/arm: Convert T16,
 Conditional branches, Supervisor call
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 19 Aug 2019 at 22:39, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate.c | 26 +++-----------------------
>  target/arm/t16.decode  | 12 ++++++++++++
>  2 files changed, 15 insertions(+), 23 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

