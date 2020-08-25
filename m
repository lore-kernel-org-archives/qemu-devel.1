Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B684C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 16:12:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BB6220782
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 16:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M2Ir1xlN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BB6220782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAbYq-0003Zc-AX
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 12:12:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAbYB-00035x-O6
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 12:11:55 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:35732)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAbY7-000618-Ib
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 12:11:53 -0400
Received: by mail-ej1-x642.google.com with SMTP id a26so17334369ejc.2
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 09:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZuN1VoXSmh7z3aL0TqbTklriGqEg4qhEQmsUK59ZCWc=;
 b=M2Ir1xlN0FefnaQ5hMjI+LkS9kE0JXlQwMwcNhnGNP7fIpqkmAaZhSFy9zU3I47icc
 BDIwn6y5WZoTNy6PI/LqaZeJ2YbhVzDBNDewXyMLSiF0sapgjOGQt6mD3rg+r06j7BiK
 w/C3twy2xjVY4GE3lzz43V0AvWG0Nc3ThoBIBX9jlXzJS7S44D8GoD/wqVzi1c+hL6rE
 oLex5ZnKSctlCWMm8QbmYzTicziDfiFcUviqcFFIT6vj5s0XRWiucn1+05qaVHwAkcem
 vAHFqqs9A6bxsO53a72FnMu8gm/CatsOqCCD7SICzvVz4gmg8x8VDA5G3RedkqN45yG4
 e4cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZuN1VoXSmh7z3aL0TqbTklriGqEg4qhEQmsUK59ZCWc=;
 b=P3pPhdI20+YQ1DZuMukSqI12i7DZ2ezOTscg1jkXaoDIN0Rh29+jSvZNcR7WTQiLsS
 V/SeqrmSvsba1MAUKP83e5mjm8vPppSjlXJyrqGe/oAQeaFsfbdweRBj6IRTUDPpqS6D
 tC5/hVYxpMLwqJocJqTa5WGMbFAbmNUcDZdKtAG3JHmqgJ68NIpajSz50l9T4bg6hDyU
 hNtuPQlcOvcBbXtmeV5DGMNtP8tHNMocxDqjum45Kcs8n3EoqAjFRpsrJbr/a4V+g4yc
 8jjeq2d0u/O/lwxVaa+h/RmgKAkAwjStkFOkp2pUPegZJXSXCWnL87gBrvHu4fFQvWn2
 DVjg==
X-Gm-Message-State: AOAM532pi4r0IHyg/LH5p/4Bmqf+CRhgVS6n6hZ2ITSOlf6GfP2Nr/u/
 vo1ZWTW/VSlUQLU1TTLjXytbmu7blMVk9ppG36Irog==
X-Google-Smtp-Source: ABdhPJzfjHtt3uwuzLyPrCvZmT2a+JMiw1S7D6QCJzGDRn0HEu2rAA0g1hnziqQ2He3wMGQkzLxPkPhNQyeQHiHEej4=
X-Received: by 2002:a17:906:2b0b:: with SMTP id
 a11mr1683383ejg.250.1598371906859; 
 Tue, 25 Aug 2020 09:11:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200825150409.346957-1-marcandre.lureau@redhat.com>
 <20200825150409.346957-6-marcandre.lureau@redhat.com>
In-Reply-To: <20200825150409.346957-6-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Aug 2020 17:11:35 +0100
Message-ID: <CAFEAcA9BLnPwNdQbj2sx19u4r8v+Ze2twCH-4_+7dJw-bGdGkw@mail.gmail.com>
Subject: Re: [PATCH 5/5] meson: add NSIS building
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Weil <sw@weilnetz.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 25 Aug 2020 at 16:09, <marcandre.lureau@redhat.com> wrote:
> diff --git a/scripts/nsis.sh b/scripts/nsis.sh
> new file mode 100755
> index 0000000000..d7d8b39b04
> --- /dev/null
> +++ b/scripts/nsis.sh
> @@ -0,0 +1,58 @@
> +#!/bin/bash -e
> +

Copyright and license header comment for all new files, please.

thanks
-- PMM

