Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0150CC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 01:40:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B886E20774
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 01:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="JcCXgKYn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B886E20774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiTFD-0005er-Qk
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 21:40:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40030)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1jiTC3-0003N9-LG; Mon, 08 Jun 2020 21:36:47 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:35270)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1jiTC0-000083-Rp; Mon, 08 Jun 2020 21:36:47 -0400
Received: by mail-ej1-x643.google.com with SMTP id y13so20510403eju.2;
 Mon, 08 Jun 2020 18:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gbaZwH2bHvRyjZRBOP0HUILH6bq/z3GX0RlSS2sdQcI=;
 b=JcCXgKYn+8U/OAMRidspyGkvTPosEVAgQCPlDaHyv8tsiLJcKDvZEf65RemlPkr2SM
 IobehETUn/14DN+hOTrl8cl16p+gKgstYpJq+fuuSB3hWKKzIt2ytnMHcuFEaWN/Yzx5
 izMHUWR4co0FnuzJWmHgCoq8NFmBTNaC6wTy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gbaZwH2bHvRyjZRBOP0HUILH6bq/z3GX0RlSS2sdQcI=;
 b=BBJVXHvHqKT584KqSLdUvh2xkMqIVxGPpXTiykU3w+SlitVwKX/5SzKai8OrrU1UZj
 0RjMNxDt3b6EU8K+QxxNyLNbTpQfTDe+9r0gi7kPJ63Ar/zVlJF5I4PoQ8sfJijr+IGK
 8DYMw2PCtU1sHigTcUa8MiFlvFOwifia0HEPaTjeSQBNioERPxGdRVdb6LfsNJqx1bzt
 YbVFrluqGZ2++brO7WH1hyF7NxkSCewTwfDtQY/u4BJGl7PO36KX/1UC1hIqXCmSt65S
 QFC/RXcJ/euZuw1oHWCL5du8damGdCrlYOEf3JAX5cQLYtof5wtmzyEHNVb2JrnxslcK
 xVRQ==
X-Gm-Message-State: AOAM532CG3rfTOtIAjgHnnq0bW0jXp/Z4M8PbZNQT+G3Cc7XnBERJgPA
 ITwN6nLsK1AANdPk+tGSP1apsEmjnIaJa70oJrXNlaSo
X-Google-Smtp-Source: ABdhPJzcyGtkKqa+iXxQ7kmGXRdYaflDo0fZIGgS5bFV6D8YFJhjqXeTt4oDrRp4rE25csT7lNEnk6i4U5MdAvaSxdo=
X-Received: by 2002:a17:906:1d55:: with SMTP id
 o21mr22657304ejh.491.1591666603149; 
 Mon, 08 Jun 2020 18:36:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200521192133.127559-1-hskinnemoen@google.com>
 <20200521192133.127559-5-hskinnemoen@google.com>
In-Reply-To: <20200521192133.127559-5-hskinnemoen@google.com>
From: Joel Stanley <joel@jms.id.au>
Date: Tue, 9 Jun 2020 01:36:30 +0000
Message-ID: <CACPK8XeJMf6VZv0eGGKSuM11sN5m7jBr=fLgS8+-mMrCgZ20cw@mail.gmail.com>
Subject: Re: [PATCH 4/6] hw/timer: Add NPCM7xx Timer device model
To: Havard Skinnemoen <hskinnemoen@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=joel.stan@gmail.com; helo=mail-ej1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, kfting@nuvoton.com,
 Avi Fishman <Avi.Fishman@nuvoton.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 21 May 2020 at 20:38, Havard Skinnemoen <hskinnemoen@google.com> wrote:
>
> The NPCM730 and NPCM750 SoCs have three timer modules each holding five
> timers and some shared registers (e.g. interrupt status).
>
> Each timer runs at 25 MHz divided by a prescaler, and counts down from a
> configurable initial value to zero. When zero is reached, the interrupt
> flag for the timer is set, and the timer is disabled (one-shot mode) or
> reloaded from its initial value (periodic mode).
>
> This implementation is sufficient to boot a Linux kernel configured for
> NPCM750. Note that the kernel does not seem to actually turn on the
> interrupts.
>
> Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
> Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

