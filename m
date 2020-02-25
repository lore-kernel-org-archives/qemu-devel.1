Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC76CC35DF9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 11:13:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 746FD20726
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 11:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zuGh9yAI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 746FD20726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Y9j-0005Ds-Ms
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 06:13:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40322)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j6Y8n-0004ON-L1
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:12:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j6Y8j-0001wX-Ru
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:12:41 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:45105)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j6Y8j-0001ss-Lf
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:12:37 -0500
Received: by mail-ot1-x344.google.com with SMTP id 59so11689699otp.12
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=L/GN5mShHBdnMRsP6mdQ//WBZsXiUqXKixKlNorJjQE=;
 b=zuGh9yAIv9G+F8cH8ykqjiNbtXb5RYe6zff/EI2qlsqNxe9t5iNk7KE+aKI/dDGHsg
 G2JVu72xV9ZcvhCsCyxohw74kQyxUUKW3J4N4SCZ5ip48iJcsu4Lutxm76zlp68QebN5
 2XHwYnyXLi3w97OoYC8QgnGl1QxkAZUiw6rfYs1dGGK8fnwUqrjckCwMJrQ8batj7AZV
 v8wNQ8ZV9HMJn8MCFim4Xs4g5zqLhJippEAwYY2Znk8V+ycHgOkhJFqQu0CuHU170Vg1
 PVeYbfHd+Ck0T9n/2Rv51uSstkKo0rt2+fBcVn4kIPF8/G+2SzROcPkFygqm+gpu12FY
 iMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=L/GN5mShHBdnMRsP6mdQ//WBZsXiUqXKixKlNorJjQE=;
 b=C+kGBFlfuFBO5TYvXIiuH+P2ma14diLIivZRkvGqMqn4x+w1Q0d61KYnA20XN9wWqn
 7Kn7f9K45dOtUpkQ7FAQ7ECSNgjzhCiEEX00XK1MNJ2sJS8bGAoyjYHSmtbjXdjIu6ap
 qAlhDCl61OsBTJUL2gk09ZgR1/Zef+R2bW5thGiN5bDcScQ/ndl5zuK4IED7ZFW34EXh
 kjsuyL0+TxKvGehM6gxnS609ndJU1ostNWJef1W9cX4ZJfgzLiq1z19uYC2MqZRReKL/
 tQmjxGE6j7oked9dXYNHzAiNN1eYpmz1B1Y8b/bt0Ks++CCPED1Fp11+/0ls2jwtYYcx
 QjVQ==
X-Gm-Message-State: APjAAAWsIz4b6AmCzEmZc76GS6ZnlWG8sEsbWuXRScTnVcDccZnhYimp
 kX2QkNWKnJPbGTLmxG8uZsQUjCfH/vgn96OioAE3BA==
X-Google-Smtp-Source: APXvYqxTfDOt4FhRBcYRutD1FOqm+EHk0nWZrbqzNksxoTguCqQesMxiAeMNUd7aRRtdcv6xbpf2msooXoUi0bePKKo=
X-Received: by 2002:a05:6830:13da:: with SMTP id
 e26mr41230319otq.97.1582629156559; 
 Tue, 25 Feb 2020 03:12:36 -0800 (PST)
MIME-Version: 1.0
References: <20200223231044.8003-1-philmd@redhat.com>
 <20200223231044.8003-2-philmd@redhat.com>
In-Reply-To: <20200223231044.8003-2-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Feb 2020 11:12:25 +0000
Message-ID: <CAFEAcA_H7aWjtoky=o2uKpNjZnebuskn-fFUMXbq=Gja5vyaBA@mail.gmail.com>
Subject: Re: [PATCH 1/2] hw/arm/gumstix: Simplify since the machines are
 little-endian only
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 23 Feb 2020 at 23:10, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
> As the Connex and Verdex machines only boot in little-endian,
> we can simplify the code.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---

>  static void gumstix_machine_init(void)
>  {
> +    if (target_words_bigendian()) {
> +        return;
> +    }

I don't think we really need to do this, do we? We don't
in any of the other arm boards that just assume little-endian.
I think TARGET_WORDS_BIGENDIAN will only be true on Arm for
the BE linux-user targets, never for softmmu.

Also, there's a warning comment in the header file for
the declaration of target_words_bigendian() that says
you probably don't want to use it...

If you drop this, then otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

