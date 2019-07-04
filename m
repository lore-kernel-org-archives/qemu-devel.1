Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A705C06513
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 10:09:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E0A12189E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 10:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lBXu88yS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E0A12189E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiygJ-0007Ak-DH
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 06:09:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42337)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hiyfq-0006ji-Hz
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 06:09:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hiyfp-0001xQ-FC
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 06:09:06 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:45498)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hiyfp-0001wu-5u
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 06:09:05 -0400
Received: by mail-oi1-x243.google.com with SMTP id m206so4506228oib.12
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2019 03:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2rYDimOw4p51/b8kXoRbETMXd0phChYu1mfYM0XSgdk=;
 b=lBXu88ySEZzhz8iJQohIB5qBX5WbL1Cb1pZTxS1d/EZPfmkH0e/Zrs+wfWqC9p+6tp
 oY/W1TEQ+CUt9x2pxhNLEPv0coL0YjyC4Dm/Q8WRjwKQrHk7UQAoLlBMznS6baXzKV+y
 bALWlkjwXO0zMwAus3va+GBQX1tLOH+9q7TlxOdNtvQgQxQQcFU4rjVqpVCDi4jKbjXJ
 18kV5+0F+lmp2/kB/KA4d9I7YXwXnOYkoQt6obZAyeb2Vey3tsk6J+NBh5UeWCHX4xq5
 G2EsbBYeaNIi9saz0S0TE94UViZ1lKTklyn/636NRql66tF7hSnrk/5n0yoft402dE4B
 vMkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2rYDimOw4p51/b8kXoRbETMXd0phChYu1mfYM0XSgdk=;
 b=CvzbVrlVnSMkahDNFcPG5MW3GxXUXj1iuJdnKAvWudVL9GiHXXcxn3O0VedZK+3nIs
 XcsB3xBAu8e0SA/eZXiLrembYqNRKOf52MLOpA4IMUCt+twIjD+J4wlIrr3HAy9s7CEQ
 oS79vIqlIB1NfwTxjwARGxuMpqc5Uy7se7kr442xXgq7KfujXRXKutEhEI3pUgZYRf25
 830N+84B01XXbuP/OxYj0N74dsoBqaJat3bvSE+uTjnvNBUU96Uyx7Z9Dbf+pY8OP0wP
 TY5RLa3WeoMMHyP6nP0HDbZ9ZX/1xoHl8S7QEJhaATWSmx+no2nvMi+XgZU6Nh0fjbq+
 IO6g==
X-Gm-Message-State: APjAAAWjWn8jsz6a7GfFtWN0Xoai9G3Q6Imo9HmPfDvXficnB8oUTGHA
 K/ZvFWIGCuQDzuQfS5Bx7m6ujJRNlQ/0TmOxuYxnRQ/+8PE=
X-Google-Smtp-Source: APXvYqzaXRhOWYbX0zOhaEqZHnVgJdNaRcTGfunTpxI4jCUKaI8jXj1PQ4p6/+fAJJ4Dmk6HzHeRLxLrSowS5I1IuN0=
X-Received: by 2002:aca:5cd7:: with SMTP id q206mr1299738oib.146.1562234943980; 
 Thu, 04 Jul 2019 03:09:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190702221606.21600-1-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20190702221606.21600-1-mark.cave-ayland@ilande.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Jul 2019 11:08:53 +0100
Message-ID: <CAFEAcA9b0KTMEcTL0gBE+e3DxF7TJHYaM2nT7NXvTF0SViXoyQ@mail.gmail.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [PULL 0/6] qemu-sparc queue 20190702
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2 Jul 2019 at 23:18, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
>
> The following changes since commit 506179e42112be77bfd071f050b15762d3b2cd43:
>
>   Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-4.1-20190702' into staging (2019-07-02 18:56:44 +0100)
>
> are available in the git repository at:
>
>   git://github.com/mcayland/qemu.git tags/qemu-sparc-20190702
>
> for you to fetch changes up to 09340f497e96a62d076b2f223e7b16a7358cfecb:
>
>   sunhme: ensure that RX descriptor ring overflow is indicated to client driver (2019-07-02 22:49:08 +0100)
>
> ----------------------------------------------------------------
> qemu-sparc queue
>
> ----------------------------------------------------------------
> Mark Cave-Ayland (6):
>       sun4m: set default display type to TCX
>       sunhme: add trace event for logging PCI IRQ
>       sunhme: fix incorrect constant in sunhme_can_receive()
>       sunhme: flush any queued packets when HME_MAC_RXCFG_ENABLE bit is raised
>       sunhme: fix return values from sunhme_receive() during receive packet processing
>       sunhme: ensure that RX descriptor ring overflow is indicated to client driver


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

