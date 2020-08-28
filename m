Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A72F6C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:16:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7501C20848
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:16:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GL003rRm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7501C20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBfAw-0005ZD-PX
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 10:16:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49456)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBfAI-0004ui-Lt
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:15:38 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:37037)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBfAH-0004ck-06
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:15:38 -0400
Received: by mail-ej1-x644.google.com with SMTP id e23so1721101ejb.4
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 07:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=D3IhhZufnQweJE5HDgy5L6wT+uLFW4UHHPjummAV10g=;
 b=GL003rRmmJ0StJPvkndI49Ig7enDw4gzjwRYDNLAEkgckbPSGHX8hHKbeOcw6nkzZX
 W+EjFZnYNSB/XCy6bWdcLNjZ9dIYuobaNH/Drdby7OH093PRyuG47fNPnGrwmHbH6uWo
 LSd0l2UWt0xZ8Aorn51yNUFmBR7zK8F0n7j+ZZi4xgTGHKwU00srpsqYoSR780VA/7PP
 zqINLrobbNBWYtAOdBNLraySm7vurrEaFHmCDyaHBKe1B0jRceWPL1Xm3RUJ/UkLbyTg
 hvV2rjUUiHIPFDP3ooa4cBKFQTIkvKHvkB9MxVgLIt47iM/FoTmZMNI1l+9CJOvceZzj
 tMqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=D3IhhZufnQweJE5HDgy5L6wT+uLFW4UHHPjummAV10g=;
 b=SB3+vspruc9GbieDgc2A9Y1Xrca9e8L+g4FjoZ9CarZylc4eVgBeHAoNqne18twQfk
 yh66iD4RyjzTV5/HvizQ/no/CkpyKHxrC5MafDDlnOOxN8xKD4ie5vmyj3r7jGCZSU0u
 Jgtcl1HDedTySJaxR1vEt3X70rLhR+8HNmPrrlWH6Zx2RzUYBCD6mv0yq5f1aw+e8k9/
 6yAo3sIONE34YgIi1EMLN0K7Ad4KdcocDexPtnf0VQaFBblOd6f8tXfPJILygr3ftkDc
 Ybi8f7Y8NxMcrnnUyd9uNZ4ioFvqG47j7m03HlJVLUGg1wMr9Tx4CFGnMkpjGrM0JDqr
 QLnQ==
X-Gm-Message-State: AOAM531zkUgrfrNC1oR9tsfFu/FNf3jrSAc3Gj0NMBmxvqmhIcukO6cx
 jYTPeWJmSHAfIrqmEctwF3ReXkqJJE40GCQ23TVcIA==
X-Google-Smtp-Source: ABdhPJyrddF9T82UsvA4EARuU3wPTQJFYZovRerVBRppwyr5olq8b0gw2GNZuOHk1Am8Jg6hks9FdgjQxTXwSdCuRhQ=
X-Received: by 2002:a17:906:f28b:: with SMTP id
 gu11mr1979263ejb.407.1598624135723; 
 Fri, 28 Aug 2020 07:15:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200828141011.1434-1-luoyonggang@gmail.com>
In-Reply-To: <20200828141011.1434-1-luoyonggang@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 28 Aug 2020 15:15:24 +0100
Message-ID: <CAFEAcA9wDuM_nVvWz7=DdRjqUqON5svC=E774+h2tzohpRbw3g@mail.gmail.com>
Subject: Re: [PATCH] meson: Convert undefsym.sh to undefsym.py
To: luoyonggang@gmail.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x644.google.com
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
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 28 Aug 2020 at 15:11, <luoyonggang@gmail.com> wrote:
>
> From: Yonggang Luo <luoyonggang@gmail.com>
>
> undefsym.sh are not msys2 compatible, convert it to python script
>
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>

> diff --git a/scripts/undefsym.py b/scripts/undefsym.py
> new file mode 100644
> index 0000000000..c690f88c7a
> --- /dev/null
> +++ b/scripts/undefsym.py
> @@ -0,0 +1,57 @@
> +#!/usr/bin/env python3
> +# -*- coding: utf-8 -*-
> +

All new files need to start with a header comment giving the
copyright and license information, please.

thanks
-- PMM

