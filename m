Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5EFC04AA7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 23:19:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3793208C3
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 23:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m02C9uQK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3793208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36238 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQKDu-0003U1-QQ
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 19:19:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hQKCh-0002cX-DH
	for qemu-devel@nongnu.org; Mon, 13 May 2019 19:18:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hQK1t-0001tg-83
	for qemu-devel@nongnu.org; Mon, 13 May 2019 19:07:23 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:45696)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hQK1s-0001o5-QM; Mon, 13 May 2019 19:06:45 -0400
Received: by mail-lf1-x143.google.com with SMTP id n22so10278305lfe.12;
	Mon, 13 May 2019 16:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=2vHz03zI+JINIBclxZbsNHslHVrte/25NIt2rGtgjnY=;
	b=m02C9uQKsPUfSqGCArA4wK/5F6UU3CfAIGYxLypeEoOu+3okHBZJ8XtmJL6TPAewhb
	2K5ifoC/Joq40zaTdtMigjvmExlPrM24WDenpNQA0pOVR2+Q2tqfgEftzywYDtJqx6VX
	Q/qjjD+zl8MDtTd5zfZOQeYa6pOKe4mT1AkrUkEhzSLCIPE92DONAgdPsJCAF3CZ5uNv
	McVz1jZ7+rpVE6hw+nv24lBC2Eu77qfaC+P5Z8qrjkFFNbVtK3tnSI3A3ulua4ZPJFpr
	/HeMMw377ahsGkfxo6UdZK8UYmTQvSsXu3ykoa8qyvjn4KYF4hLCHpXUVVT++TTftrs9
	aGUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=2vHz03zI+JINIBclxZbsNHslHVrte/25NIt2rGtgjnY=;
	b=EMfkbFrEX2+sG6Vd4HnyOMPDqsQdoGE7DIXPJKtWlLPJlSW+yyUg0bSvr5XF0budk3
	KxP4a34xCLCL966mra5p8VQ7bBrUqADveiS9mXPRuhazovo2NM0g6qsasI/z1vhC/7g4
	OJx2dRccrokd1mo2ynrKixdBWRXl9WNKpQu2lCWwF+8xQfp+IA6WTrT06mHcsl5SMDFY
	iZiEIeNO7ufIYTW/5U+9Mndv1YLvP9KdamhWIrnqadmHKjyrDAdFspMS6wCCL78Cj6hW
	vOrRctybanysj7JbCZ5inehEjvEcN/S0GwCSOeAwFpaaktFk9UgQvyWQQQIbG8wDObMU
	WPOQ==
X-Gm-Message-State: APjAAAUMeiuhTQqgm6Ilj3V7x+931OFdD9ESgAa3nb90fMEZBCosOFIU
	vyjqbyycx8I7U/tz5HSgKDQHCAlGg3U2kzgzY6A=
X-Google-Smtp-Source: APXvYqyQCaArhqiuRNRMd0DNX4WEJvaUdMVJ8S/K0zKHOqByX7/LSj7OkAaxCuryXybOQ0GNJtNdw20/EMPNdmShh+0=
X-Received: by 2002:a05:6512:309:: with SMTP id
	t9mr14617630lfp.103.1557788799792; 
	Mon, 13 May 2019 16:06:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190513194328.11045-1-jonathan@fintelia.io>
In-Reply-To: <20190513194328.11045-1-jonathan@fintelia.io>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 13 May 2019 16:04:26 -0700
Message-ID: <CAKmqyKNGXrvnJSuBN-BqtoyjE6FQ3niNMkWpwv1w2e1GN8ESHg@mail.gmail.com>
To: Jonathan Behrens <jonathan@fintelia.io>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::143
Subject: Re: [Qemu-devel] [PATCH] cadence_gem: Don't define GEM_INT_Q1_MASK
 twice
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
	Alistair Francis <alistair@alistair23.me>,
	"qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
	Jonathan Behrens <fintelia@gmail.com>,
	"open list:Xilinx Zynq" <qemu-arm@nongnu.org>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 13, 2019 at 12:57 PM Jonathan Behrens <jonathan@fintelia.io> wrote:
>
> Signed-off-by: Jonathan Behrens <jonathan@fintelia.io>

Good find. Thanks for the patch!

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Can this go via your tree Jason?

Alistair

> ---
>  hw/net/cadence_gem.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> index 7f63411430..37cb8a4e5c 100644
> --- a/hw/net/cadence_gem.c
> +++ b/hw/net/cadence_gem.c
> @@ -146,7 +146,6 @@
>  #define GEM_DESCONF7      (0x00000298/4)
>
>  #define GEM_INT_Q1_STATUS               (0x00000400 / 4)
> -#define GEM_INT_Q1_MASK                 (0x00000640 / 4)
>
>  #define GEM_TRANSMIT_Q1_PTR             (0x00000440 / 4)
>  #define GEM_TRANSMIT_Q7_PTR             (GEM_TRANSMIT_Q1_PTR + 6)
> --
> 2.20.1
>

