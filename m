Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B373C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 10:46:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25455204EC
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 10:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QiECRMHp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25455204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2YzD-0001Z0-3N
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 06:46:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34109)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i2Yxp-0000pC-Vl
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 06:44:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i2Yxo-000128-QN
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 06:44:37 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:38281)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i2Yxo-00011r-Hp
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 06:44:36 -0400
Received: by mail-oi1-x241.google.com with SMTP id q8so14269901oij.5
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2019 03:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SL1+Vu/Pp9flDd+Z7wud1TjEBXU7Ib14lQRu6iN4wkU=;
 b=QiECRMHpaozHmzMyKVKQQLDLvbZy94Dv2uBnAKEASQx5LsZbYwwoIrUgBor+hCH4Qm
 JXEQcVDR29wjL+G8sFcBRlvc/WLMThwepsUZsK/asqZYXfE76yLj1nbXDRhH2ieTqVPD
 4tTjeWK6tt9+1yB16QDEDNdHYPI6UoIpAPe4yF4S3FTJJglQqKE3cpd1RkR87Edti+Dt
 2t5KNkuHSQYx8jowKOYh7x0GPGexc6xeRDHnIeUnfdDDZ1jQSU1qXgdwXb+znILCWNiC
 kmVP/laBMGp4aJ0v8QL2qTQPyTLteORutv3NsAuehwzBLU6TefSt0ls37XryrGFBE60T
 xCCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SL1+Vu/Pp9flDd+Z7wud1TjEBXU7Ib14lQRu6iN4wkU=;
 b=nw0WptgU1+kzS4swqnzERy5kmHgsp0scS/sr7Kr1OFZvRAE99JNwSx85x8UMsB5+3s
 KOcx9PwaJBEeC4//Rtj61hUUq+EkjYddr0thILjMy10fJ6OeIWP9Mckz2xNqGHXBtOh2
 x+3xnXc9H2FJi0P1QIG/i3Z9YXedJvpqlbn7cgMhXhZtdCX42nxiytuqwLNSulc0U4co
 /J5cfBqn3HGAGaLETlgX2LovP9N9lvJNpywVC1O2yf7+/A3yrq38vSJ3dVcjUSkjlgOj
 6pRo75p8MEDtsluB6Lgg0PHbzcmr/bI0qnNlywVWA/OGDUrZo3DWaNIHLJ9ihngcCAmB
 tUYg==
X-Gm-Message-State: APjAAAWw9I9SAmB/mtUGorDwsuRYwtODqv7kPMW4WidU+RCDd9Tqy5BH
 0j4RsMpr8n9VnPr5cUE5WVCDFS1Fecl5Om/16MKOFg==
X-Google-Smtp-Source: APXvYqx8Njf4QAYtqngkGmW/fgpoSG2tuIBXPIRbPcnzDT5VMHBWgNV83qjHWcwmZeG7ygH/H51EoRAodnPpzVyO15U=
X-Received: by 2002:aca:50cb:: with SMTP id e194mr14495155oib.48.1566902675469; 
 Tue, 27 Aug 2019 03:44:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190819213755.26175-1-richard.henderson@linaro.org>
 <20190819213755.26175-22-richard.henderson@linaro.org>
In-Reply-To: <20190819213755.26175-22-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Aug 2019 11:44:24 +0100
Message-ID: <CAFEAcA8saD6zkOA7-6nF5jQBMgKPLv0L3WXV2m0Y4WtHwVqWgw@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PATCH v2 21/68] target/arm: Convert
 Synchronization primitives
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

On Mon, 19 Aug 2019 at 22:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/translate.c | 560 ++++++++++++++++++++++-------------------
>  target/arm/a32.decode  |  48 ++++
>  target/arm/t32.decode  |  46 ++++
>  3 files changed, 396 insertions(+), 258 deletions(-)

> +static bool trans_STREXD_a32(DisasContext *s, arg_STREX *a)
> +{
> +    if (!ENABLE_ARCH_6K || (a->rt & 1)) {
> +        return false;
> +    }
> +    a->rt2 = a->rt + 1;
> +    return op_strex(s, a, MO_64, false);
> +}

I've just noticed that there's a bug in these checks -- the
M-profile CPUs don't have the V6K feature, but they should
still have STREXB/STREXH/STREXD, and with this test they'll
incorrectly UNDEF them.

thanks
-- PMM

