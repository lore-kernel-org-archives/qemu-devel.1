Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D470C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 04:38:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30C872073F
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 04:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="g2U9nS2V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30C872073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBAgj-0000Wc-VR
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 00:38:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35134)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joel.stan@gmail.com>) id 1iBAeK-0008KK-4c
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 00:36:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joel.stan@gmail.com>) id 1iBAeJ-00045T-6K
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 00:36:04 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:45438)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joel.stan@gmail.com>)
 id 1iBAeC-00043y-3i; Fri, 20 Sep 2019 00:35:57 -0400
Received: by mail-qt1-x843.google.com with SMTP id c21so7141506qtj.12;
 Thu, 19 Sep 2019 21:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=P0HGbdxrmbTwLhsFf8fVFclc5uy3emLEDmnjj7AIK8M=;
 b=g2U9nS2VednVRdiFMpV7J7Ba9Qm6fFmjdBb9Pp8+kg/7QygSNe+nebT3LpG21D7W0w
 RIz2h4Wkg/14fOFEOFcytNSGAMIt1Xg98RpKKtxA01dKKTpN8adLxBt0Qdfm355Qc1i2
 7cgR7IvyEfU+IX5O2Atw/qUyQn0mQCHWV5pno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=P0HGbdxrmbTwLhsFf8fVFclc5uy3emLEDmnjj7AIK8M=;
 b=fFLoa1l69VW3c8TxbQ4rkyuApSI12Bhn1+ztTDE2qRx2p6joHJsEgrU4tKjX0UlCGW
 ONkhUJQj0Ez4/k9zMG9QIWy9K6k/jYmomW6YBlNfgyTUyfnHXI9tr+NUMGS/4+0x5f02
 cIr3mODB9mdzDg4HMaoBqXgldQTuTrDJgO3KJp7idLUN0iYh3hqvijw5E+7+s9COMDKu
 lxnSJr46w+/8jLJSiXjV+BGcblWbdAgJjROSkb+xH8iDrgFAnNOUAOGaL1XMIRHLyJfY
 MJSpm/HlEtRV/DxATf1GfttsVnB7zJsUe0ZY5YhhWbZHu5/JBabOA1r9dfJ13SARyFzi
 nVSg==
X-Gm-Message-State: APjAAAXhcZaclQ/7yGPnRpB+ZKGJAvZrz3sLJt/Tih2LzMWWtVOmxBUP
 +HgyynoiSkVHovh1qWKHLAMRrLkxrq6y3I5jiqM=
X-Google-Smtp-Source: APXvYqydi2r1niOdEcq7f/TqVh0U8iIb2UUeNyD7BU7sVZRo8JQctZPttneS+kVliQhurL2bGLWgIirKwEjjhPpr0Xc=
X-Received: by 2002:ac8:2d8b:: with SMTP id p11mr1218945qta.220.1568954154594; 
 Thu, 19 Sep 2019 21:35:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190919055002.6729-1-clg@kaod.org>
 <20190919055002.6729-18-clg@kaod.org>
In-Reply-To: <20190919055002.6729-18-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Fri, 20 Sep 2019 04:35:43 +0000
Message-ID: <CACPK8XffSK65RAc-kgbZrvxbr9cEF3uYEu6_tpN=9oDwrNgs-w@mail.gmail.com>
Subject: Re: [PATCH 17/21] aspeed/soc: Add AST2600 support
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::843
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 19 Sep 2019 at 05:52, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> Initial definitions for a simple machine using an AST2600 SoC (Cortex
> CPU).
>
> The Cortex CPU and its interrupt controller are too complex to handle
> in the common Aspeed SoC framework. We introduce a new Aspeed SoC
> class with instance_init and realize handlers to handle the differences
> with the AST2400 and the AST2500 SoCs. This will add extra work to
> keep in sync both models with future extensions but it makes the code
> clearer.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>

One small addition below. If you don't resend I can do a follow up patch fo=
r it:

> +
> +static const int aspeed_soc_ast2600_irqmap[] =3D {

> +    [ASPEED_ETH1]      =3D 2,
> +    [ASPEED_ETH2]      =3D 3,

We need to add ETH3 and ETH4 here. They look like this:

    [ASPEED_ETH3]      =3D 32,
    [ASPEED_ETH4]      =3D 33,

