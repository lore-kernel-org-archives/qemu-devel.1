Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4741BC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 01:47:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05CCD20775
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 01:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="Sg930trP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05CCD20775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiTMM-0002D8-3J
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 21:47:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40044)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1jiTC9-0003VA-PB; Mon, 08 Jun 2020 21:36:53 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:33500)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1jiTC9-00008j-2V; Mon, 08 Jun 2020 21:36:53 -0400
Received: by mail-ed1-x542.google.com with SMTP id o26so15021726edq.0;
 Mon, 08 Jun 2020 18:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wg4d2BRHpAgJWcLacAVjl8/fG6hwFrWBvdQXQQyeVrA=;
 b=Sg930trPsX11p9Ng3gQuG+40hDD6gmoxXUwED6FRHjd50+jtMjYT1vGDdtvCrtQZiW
 3kVF3eWouqu6zK/6syI7ZyHCXzHys7Qyba86ujiJXa5dsha/OnYWXuN+Q9wEE0QF8cdS
 dUBQcJ+/V7EQvJjZCYKQyJDUTltuPG9bRTCDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wg4d2BRHpAgJWcLacAVjl8/fG6hwFrWBvdQXQQyeVrA=;
 b=c7HmHNRY+Kku/K/TV2rsWFzgPvVo1WDPEKI0WMXZVBBAZ3MHAXdRXyB+Izhj6bs6CC
 Rum1hwwwFbMCYHmFt08BCV5qG9h8d1OXI/DMDPGFMg/vxPyNOeDNoK+JkMM9H0vo/vUA
 t4scu4Jy0iDwEkHq7hhaq8YDucR2y4scqMqSyeSOgtGx4exhTOeWlBVNmqYolTmLY6Cg
 yZK9F8gaGd8UbJlUi+sRkMGlwqtaGB9acMgdk5Doke6/e2zEK+jWw9rwqVteURhHvd0k
 XHcyavVJ1CJCa3o2ZVmIW+00QzveqfUTdDqJVPXG4clpYIwF/oCQkmSyXfSUvK8H9G3L
 XGtg==
X-Gm-Message-State: AOAM533QEs6V96o6nrRAztoluxB60qz7pTWPmAsxfmuG3vY1nV00ep+6
 kXar2BOcN8PsrwQ3bHOeFZyRo1ev2iiz+mC6vFU=
X-Google-Smtp-Source: ABdhPJy5YxfhxgyHcjVvP6T2W6JB8s1676qLzs3+q+uRk4BGJDGesclkBZ3+frfKqL1qEAvJTRUpvw8FP04qeRaarf8=
X-Received: by 2002:aa7:dc50:: with SMTP id g16mr16260874edu.318.1591666611260; 
 Mon, 08 Jun 2020 18:36:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200521192133.127559-1-hskinnemoen@google.com>
 <20200521192133.127559-6-hskinnemoen@google.com>
In-Reply-To: <20200521192133.127559-6-hskinnemoen@google.com>
From: Joel Stanley <joel@jms.id.au>
Date: Tue, 9 Jun 2020 01:36:39 +0000
Message-ID: <CACPK8XcDdTSN34XhWATabBG-stYfRp8SbWUn9VHPbq4c3v3fXA@mail.gmail.com>
Subject: Re: [PATCH 5/6] hw/arm: Add NPCM730 and NPCM750 SoC models
To: Havard Skinnemoen <hskinnemoen@google.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=joel.stan@gmail.com; helo=mail-ed1-x542.google.com
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

On Thu, 21 May 2020 at 20:39, Havard Skinnemoen <hskinnemoen@google.com> wrote:
>
> The Nuvoton NPCM7xx SoC family are used to implement Baseboard
> Management Controllers in servers. While the family includes four SoCs,
> this patch implements limited support for two of them: NPCM730 (targeted
> for Data Center applications) and NPCM750 (targeted for Enterprise
> applications).
>
> This patch includes little more than the bare minimum needed to boot a
> Linux kernel built with NPCM7xx support in direct-kernel mode:
>
>   - Two Cortex-A9 CPU cores with built-in periperhals.
>   - Global Configuration Registers.
>   - Clock Management.
>   - 3 Timer Modules with 5 timers each.
>   - 4 serial ports.
>
> The chips themselves have a lot more features, some of which will be
> added to the model at a later stage.
>
> Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
> Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>

This looks okay from my perspective. You will want to get Cedric or
Peter to take a closer look though.

We have started adding about the systems that are supported by qemu,
including how to boot the machine, what is supported and the
limitations of the modelling. See docs/system/arm/aspeed.rst for an
example.

Reviewed-by: Joel Stanley <joel@jms.id.au>

Cheers,

Joel

