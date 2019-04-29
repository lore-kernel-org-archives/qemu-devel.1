Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C64C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:46:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B481620652
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFoKaeSq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B481620652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33070 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLAMa-0001iV-Qy
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 13:46:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hLA5j-0004TG-Tx
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:29:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hLA5j-0006Ae-2N
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:29:23 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:46677)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hLA5g-000699-VZ; Mon, 29 Apr 2019 13:29:21 -0400
Received: by mail-lj1-x242.google.com with SMTP id h21so10092400ljk.13;
	Mon, 29 Apr 2019 10:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=gLS9I0ngHrnn3Ujgur6YQTjnpkUCsdPWux+YrreoIwE=;
	b=gFoKaeSqqjjUIfHjdi1V2wL1DTbZocQbM+iMoydPFobJyCX4QOGfKyEzHalbfAhjJ/
	dKcVa+3jzEnBXATmT2hH3xNVuPDPShGAzqbI3ZD3Ynv6iyyu3pCi7mZJR7+sFdfRcVaC
	qkgcVSyTVnGvh1MnlFfZp+Mywd4WzcaElsqor1NEzMLwWuk+6JGILYNYodytP3ZxhZEN
	3j2VCZTXyZ1EhhsKD68CzRFFAHFWOhcAPklJBQ5TXjM9uE+wSKjQZP/Z3uGNunEH6zWH
	Y21b9FjGypkJTfS060SrlxvymIcOtq/icBZYRC0sMbDFAuymvKwg+NpTWE2sUWEX3cPj
	rffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=gLS9I0ngHrnn3Ujgur6YQTjnpkUCsdPWux+YrreoIwE=;
	b=mRPzG9wrgiHq8cqEOuNzkmIp35/SFpGueDsfTZSyiKYrt9iOEzEgGPhmwNRnVtNtdM
	nDEg7QIqV0GuBlBribqUCEKVIP/tsYRpcWw4FLrH0Jds3CPejZMnKH2h6Bj524oZ9ZeX
	RJvMVgbrkn3thbOqlvj0by7lW74QYfwthFg1uWStBQnoYUWKvaJwamkwrYY2Jy2uUxwL
	z3XFG8MlSGPT0TS2tET4FHOLmWbO9+lRvxQkngF56VQBeMzpbmq2aGlVcci5HIKtYiSN
	WIfrGEsx2fCrKOhNbTpXsDvmufBLXK5fB4x5uKSHn0KW/kRe0JUnQUbRdUgsEVVt1j0n
	q0GA==
X-Gm-Message-State: APjAAAWqyMwoVrtdhCu53rIVXj5vk4bdTmBN+8oqQp9e2RBtfq8JiAEm
	Nkq4+HTdShDhl4tqIXOBlLhGf4+appEJbNUv7nc=
X-Google-Smtp-Source: APXvYqzjKJq/IiKV40YCEvMQ8p/Y5F0hP8AtMspqS3Rb/YofohBvrhK1M/MMq9KiQD4shENx0kZm2FaD3OuK7mjpXPs=
X-Received: by 2002:a2e:5b97:: with SMTP id m23mr4739150lje.99.1556558958689; 
	Mon, 29 Apr 2019 10:29:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190427141459.19728-1-philmd@redhat.com>
	<20190427141459.19728-2-philmd@redhat.com>
In-Reply-To: <20190427141459.19728-2-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Apr 2019 10:28:49 -0700
Message-ID:
 <CAKmqyKOESUfmvHY73k6NsnZ0Gr9LXuHwOUDSn2vXQGXRfmWkOA@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::242
Subject: Re: [Qemu-devel] [PATCH 1/3] hw/Kconfig: Move the generic
 XLNX_ZYNQMP to the root hw/Kconfig
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
	Alistair Francis <alistair@alistair23.me>,
	"qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
	qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429172849.lt8DXLj6oUVCO7pUsLFT0zb6iKFPtuztUZPlpr9Fcf0@z>

On Sat, Apr 27, 2019 at 7:15 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> The XLNX_ZYNQMP config is used in multiple subdirectories
> (timer, intc). Move it to the root hw/Kconfig.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/Kconfig       | 3 +++
>  hw/timer/Kconfig | 3 ---
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/hw/Kconfig b/hw/Kconfig
> index 88b9f150070..c3c78f43eb5 100644
> --- a/hw/Kconfig
> +++ b/hw/Kconfig
> @@ -72,3 +72,6 @@ config XILINX
>  config XILINX_AXI
>      bool
>      select PTIMER # for hw/dma/xilinx_axidma.c
> +
> +config XLNX_ZYNQMP
> +    bool
> diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
> index 51921eb63f1..eefc95f35ec 100644
> --- a/hw/timer/Kconfig
> +++ b/hw/timer/Kconfig
> @@ -34,9 +34,6 @@ config TWL92230
>      bool
>      depends on I2C
>
> -config XLNX_ZYNQMP
> -    bool
> -
>  config ALTERA_TIMER
>      bool
>      select PTIMER
> --
> 2.20.1
>
>

