Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FADC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 12:30:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 984A62067D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 12:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i+amtIx/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 984A62067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juxbJ-0001w0-Rn
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 08:30:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60864)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juxVf-0005aP-10
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 08:24:39 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:34848)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juxVc-0008Gg-W4
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 08:24:38 -0400
Received: by mail-oi1-x241.google.com with SMTP id k4so10793506oik.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 05:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=VOICyT3wl/EpNQqGgOp1bHXDUkMptuwBmOUfLQ1I5qo=;
 b=i+amtIx/gAkjr8bLVPaFPzq7r+Ek88quHLausbPiga+dP828zMdWO5Hk1P5ap25VAy
 usOIYLZ0LMnEHbmugH6OdqiP34PFtCknU7lKbw1vJRmK80v9DTZPwZpa1hIFxwiU8qz1
 IVK3lxbL5Rxg2HcP8XIKYLmPKeEea2YIGK8Lgv4SNbHlwuiubnHYqNbgHIK7SuZZUOb/
 nQIp0Oe0e7AyBn4GNNLaMz3N9uir6fK8/g5jRdewauD5+pHGV8FJ2JYvCu/IaTyQB8G2
 4rzUiofh0QoCtQiW2r+4d8rW0z0xhqxi/uzZYV0a4mTxMUBPHdkqapYQ8OskA85eQDVz
 pTZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=VOICyT3wl/EpNQqGgOp1bHXDUkMptuwBmOUfLQ1I5qo=;
 b=LNdEucAYQgykQYhqMivbSLS4FFSeUeCw8m5UrOEelZ+Vnx7xQSuFl31iQonNaRw237
 Kh+VcU7sajcE9KHbFt3FQCIhXKoIARmKgdtFXfWAtFcai/ryIEYbH/kOuBiiit/9IAvX
 O+7tRfLAVIGxaagxJORy6Put3npZw1En8FZfLaoH+rIVx2uzhblQmwaCKdlPBOwGdN3p
 NSaJ2gj+SGXDiW0ulpcVbaJyqVd3oCDhOD6qyM2FOrxIewU66x5jAQsSh6OJBMfr4xUo
 C7OJ4iKv+5fHmgAYZGGaRKtBo2Mh8Ppq7YEebo8opZYmWPo6AaAM3EDKbYURwch9TuRY
 Ba4g==
X-Gm-Message-State: AOAM531u8wGO41DZoVfl95Ue/piL4mzokDGYpypmyn8Vk7xrO6JsFl6l
 m9c/NAdHh29V8NoU9SNr6lCheGOJWc5iqJKbjwkP0w==
X-Google-Smtp-Source: ABdhPJwgkTunObiSA+SF9tdhzu5zzFtm65nvN1fB2E9YQwqhniG+3w1tCgKi+6I8sBYuLJCM5qOWtHQrCQ4AO3tag/c=
X-Received: by 2002:aca:54c9:: with SMTP id
 i192mr13781214oib.163.1594643075538; 
 Mon, 13 Jul 2020 05:24:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200705173402.15620-1-f4bug@amsat.org>
 <f21c68c9-a4e3-76cb-7484-1816d5742163@kaod.org>
In-Reply-To: <f21c68c9-a4e3-76cb-7484-1816d5742163@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Jul 2020 13:24:24 +0100
Message-ID: <CAFEAcA_5hKh2z2M8ESwhZ=6x_xuv6VVdxUxB=_iZ-x9hujLC=A@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/aspeed: Do not create and attach empty SD cards by
 default
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Eddie James <eajames@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 13 Jul 2020 at 13:20, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> On 7/5/20 7:34 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> > Since added in commit 2bea128c3d, each SDHCI is wired with a SD
> > card, using empty card when no block drive provided. This is not
> > the desired behavior. The SDHCI exposes a SD bus to plug cards
> > on, if no card available, it is fine to have an unplugged bus.
> >
> > Avoid creating unnecessary SD card device when no block drive
> > provided.
> >
> > Fixes: 2bea128c3d ("hw/sd/aspeed_sdhci: New device")
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Applied to target-arm.next for 5.1, thanks.

-- PMM

