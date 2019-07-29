Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1B5C7618B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 12:44:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95A28206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 12:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vLNgS7CL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95A28206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs51N-0006oU-U5
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 08:44:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35910)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hs50n-0006L5-QU
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 08:44:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hs50m-0001gs-Nl
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 08:44:21 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:40698)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hs50m-0001eo-Is
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 08:44:20 -0400
Received: by mail-ot1-x342.google.com with SMTP id l15so5129834oth.7
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2019 05:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=axBUDQ/juYdTqJW1DQMakICAGQZ6LrtKnM5P6S7oZps=;
 b=vLNgS7CLdVg6n80qTAeeMCM6TR96YysizTjetC1BTVkSusLAG5g2VqrV9Mm8GWwpv7
 YQazvJm8sjhPtFwjMG+qnWE6kNbbROOZjHePojR/6l+hyBJETgdFVEXdX6wDt57RJVZU
 Z2rhf6IUcCoXlOlRen8QjHeXEv7FEZIfJbq2HKVenBjfZQYxtf59OFwMtXO/DYmG2OZS
 U6r2zf0RqEoAk5+NdF1POQh2beGtK7WapYC2VeYsvxd3aqPHVykcAShRbADrgPn5K4vd
 GRsahwBoqn7jKr1KGmy2RLKce9uftpbwvhZQGPDsg6+RJ6PEDYASlA4nP527fx3cUijX
 S3zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=axBUDQ/juYdTqJW1DQMakICAGQZ6LrtKnM5P6S7oZps=;
 b=EpNMm7zQvKoaeXQ13Z/LTpeqntpUhkZOdGKRPWMb4VnYf+sjHj2L6yINrMRTDoW/Sx
 gV0QsDLz2Vl1Bw1W+wqMWv+JWFikidbX+RNonGQvn9x8dgm2HD2QFGWzn3+3ZOPBeIKE
 SlLR50lN75NHYjtTm1pEhMr7FabAuKXbMxMjGjs9L3WbT8SWOxnhOI3gwpG13y8uony6
 dYZqJ8tTifLIi4ZC05kMJkFVnnHIUgxfbXKytOJy81+mLer2Bl+yUBo2q8SK1ObEiEpc
 b0XXCGWYJxkdkEOdvNnrtrg2ThAAVWbOsZlIwDLupKkEfO5cxfamxmLjb42ZRbuRBWSK
 3Vgw==
X-Gm-Message-State: APjAAAVp90peZQaA9927hmmJzq2EorwFfWNGNl8gA4u1ETkbPmm46S+g
 mwlhv+oWSefp88fEB4ikw9S/7gTbJ7pl+W+SNixUHw==
X-Google-Smtp-Source: APXvYqx3x0h2tzqFojssy0RlaJbtAIXWP3juCbAgkaeHGnWUwdpT94f/VmK6yeQXmMPE0NrRndVzo1iV1Hodrm3fSZw=
X-Received: by 2002:a9d:4d81:: with SMTP id u1mr32509663otk.221.1564404257124; 
 Mon, 29 Jul 2019 05:44:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190726113950.7499-1-alex.bennee@linaro.org>
In-Reply-To: <20190726113950.7499-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jul 2019 13:44:06 +0100
Message-ID: <CAFEAcA-N5BCMkHA7Mujyts3Q2WiyAMqZq=+L=tsr=cak2QTzYA@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v5] target/arm: generate a custom MIDR for
 -cpu max
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

On Fri, 26 Jul 2019 at 12:39, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> While most features are now detected by probing the ID_* registers
> kernels can (and do) use MIDR_EL1 for working out of they have to
> apply errata. This can trip up warnings in the kernel as it tries to
> work out if it should apply workarounds to features that don't
> actually exist in the reported CPU type.
>
> Avoid this problem by synthesising our own MIDR value.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>
> ---
> v2
>   - don't leak QEMU version into ID reg
> v3
>   - move comment into one block
>   - explicit setting of more fields
> v4
>   - minor reword of comment
> v5
>   - VARIANT->PARTNUM and extra words

Applied to target-arm.next for 4.2, thanks.

-- PMM

