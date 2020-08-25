Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F334C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 15:02:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 496492075F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 15:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pg4oxCnd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 496492075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAaSV-0005U9-HL
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 11:01:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52942)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAaRE-0004IO-QF
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 11:00:40 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:37169)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAaRC-000236-I9
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 11:00:40 -0400
Received: by mail-ej1-x644.google.com with SMTP id dp2so11695101ejc.4
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 08:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=DZv6l2y4Im94jThe8MYkcyapTxnKKIFy0pG30tVki40=;
 b=Pg4oxCndn3BxzjiqGPz8t+N90exxH4CfLjFo3AAZ6IiqM0fZVrDdf/FFCe3naXwlN1
 ZGtGPsPyJBDFtznwXak0Dx2BFriNYIQJhE+YnAI0sWy8tbCdjxLB8tH8sW7sfLDsL8Ps
 mpY2Uz/6IHFq7eHCdsYxJ4hHxzRt9Fluhgg8IJqMdKJ8yRpQByHIM/SegtqM24602gox
 co5w9In3g5SGfZ12fBqEGHF8lyqWsuQJ6ySWraNbifqWs1SiKzIGfLBpEza4RcYe4Kqg
 Ks0QYyqMGqrSGwi1xpDFoucldDsBNsdDKEi4wlKLo2usm2u15aymELUNT/USriUhuTkI
 NOVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=DZv6l2y4Im94jThe8MYkcyapTxnKKIFy0pG30tVki40=;
 b=jYIuz1OKQq0iL2gw5MDXKAAgso1r0UqA30uzUgFjzADMKQEB5KEUjVv0WaoG9/f5lI
 MrCh4gA3JHl58gg84BXBUE5diQ7YLeHyHaxSKNNFLLtGLePOrCA9x7rnO9QEl0MIZMr1
 aYzC/dbpi6Z36STVE8BCvqVwthiPVvDw9Ba75udILGLdU3KbKK++R5vEsK4TCh2xkQOI
 Kb1+rtME2w++s0UTI0LQ5pNn3Vpoc7H9waYE02yma1PyoTN9W9oCdu2q0AwzN3yZIVBu
 My3eXujGxwUeT1GAzet5swbPpoAYO8HdLFhq05rLRfYrKDuOAdts9Hw1ffGWWChD17g+
 oGCA==
X-Gm-Message-State: AOAM533Zy0Ax9WmY9In//MMACUr1iYFElZbzf4XDfAUNsPSIDlcVIGoC
 mffTv/nRkt6GaU3P/mMbL16NoZhKYIcaoWwiiw5t4Q==
X-Google-Smtp-Source: ABdhPJwt8CTSQh7s4Hr9Qbm6HmWiwWcpBue2Nxy4fjAr8edOquCLxIlc5EBkjqppa/SBWjNIjX1T6J5gwpMU85gG/80=
X-Received: by 2002:a17:907:2066:: with SMTP id
 qp6mr1910135ejb.85.1598367636153; 
 Tue, 25 Aug 2020 08:00:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200818143825.691110-1-f4bug@amsat.org>
 <20200818143825.691110-2-f4bug@amsat.org>
In-Reply-To: <20200818143825.691110-2-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Aug 2020 16:00:24 +0100
Message-ID: <CAFEAcA-HKWvLWJ8MPigAni8jHwg5qu6kEq1=TgXVMvo5oeTeLg@mail.gmail.com>
Subject: Re: [PATCH 1/2] hw/core/qdev: Make qdev_pass_gpios() arguments
 self-describing
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 18 Aug 2020 at 15:38, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> Make the direction qdev_pass_gpios() pass the GPIOs more obvious
> by renaming its arguments as 'from_dev' and 'to_container'.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  include/hw/qdev-core.h | 10 +++++-----
>  hw/core/qdev.c         | 14 +++++++-------
>  2 files changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index ea3f73a282d..c72d4db2d26 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -643,8 +643,8 @@ static inline void qdev_init_gpio_in_named(DeviceStat=
e *dev,
>
>  /**
>   * qdev_pass_gpios: create GPIO lines on container which pass through to=
 device

In the line above we say that the pass through is from the container
to the device...

> - * @dev: Device which has GPIO lines
> - * @container: Container device which needs to expose them
> + * @from_dev: Device which has GPIO lines
> + * @to_container: Container device which needs to expose them

...but here we say that it is from the device to the container.

You could make an argument for either convention of from/to,
but we should be consistent. The most useful part of the name
is the part we already have, because 'dev' vs 'container'
is unambiguous, whereas 'to' vs 'from' depends on your
point of view and doesn't really help in working out which
way round the arguments should go.

thanks
-- PMM

