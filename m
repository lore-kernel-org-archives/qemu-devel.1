Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E4FC43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 12:16:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B86A62075E
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 12:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TrIEij6p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B86A62075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56859 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL5Cz-0005ZF-T7
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 08:16:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL5C4-00057a-Nb
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 08:15:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL5Bt-0004jJ-5A
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 08:15:29 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:43233)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL5Bq-0004hO-HD
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 08:15:24 -0400
Received: by mail-ot1-x344.google.com with SMTP id u15so8343513otq.10
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 05:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=zxAE7AJJ3IqVcvBrGvcg9/NZVkz9VxnKmKVZLGSvHso=;
	b=TrIEij6pXceAdibdoZPa+RHKPWLBzZwDOaLUww3sCndxuvmpnAI/AKo5m9jxp5JSSy
	WcFSDK3815ZNCGUNGSEnGr4R7TLja6XZjcviwhcJTSznPDd02ZLJIh787iGJl2MbNbNE
	ENJfDD+Lzvn8pSlnJu5Xb48QWwK5yMAWcmdJoh/K9i2kPVGXqad5yE4BQtBVDSrv83PM
	3OnjSz5DoxTzvhS1Y33H5rHA15Zeopbzg7S7HpPLkbQlikRh5aNWUfcs0KRtFTwb8RTm
	7ZRNRw9lPzj0i/wbJSqmwM3huMKqveMA/87KhIOfW/JfZ4JhnuYk7O7aLi8JYxhB5Rs8
	LrpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=zxAE7AJJ3IqVcvBrGvcg9/NZVkz9VxnKmKVZLGSvHso=;
	b=C+kS1og2IHFs1/HIVNihd0+CTvpjbk/o6INm8nLxEqb9ZSyc5Io0r/KK3IvAaMdnEL
	1jZc+pEtHxXi+NJGGOLlRbR8JhlMdN5eCEov4Ow8Wlz8mTBJkeBR2UfoX+4wT+aPLFXE
	2aXdRhPJXX/wBV/DCwOlVtj5ETQ7IqpsjHy5tqpGGYl/RGhnxobo8i/Ha++t97dcUIKF
	sfihV2YxMO4v1bPqSSxGe5PoApio7DNRbpjc2h7y/FmW7qypOpzaYTaACXeY4uK09UAx
	WLGcSTta4Gx0Mb4jlydaVt47FYqm5yMiO3v1BR9MrFQKIn/Kb160dDHrLBrlWzP6rL5h
	TYXw==
X-Gm-Message-State: APjAAAWje+796ycgidR7EEaukxC5yFXRaXUAsACJOUrU6wT7aQaEfM6q
	4cfz+h5dhNrLgfvyVGSmK6RVjXBhtT/m1EYl/ELP6w==
X-Google-Smtp-Source: APXvYqwp+S2Wi4jvglInsIN3Pu9N28J4jfjOBFg0VlkNcumliansnKJp7L4DuFtkXgqqrxnntxMdMRwy7hgyVwMKZQ8=
X-Received: by 2002:a9d:57c4:: with SMTP id q4mr3764395oti.151.1556540120500; 
	Mon, 29 Apr 2019 05:15:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190427133028.12874-1-philmd@redhat.com>
In-Reply-To: <20190427133028.12874-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 13:15:09 +0100
Message-ID:
 <CAFEAcA9ezbte4fq_Wyic3tv9+bnkQJGq9REuvxie+QCQpNL3bw@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH] hw/dma: Compile the bcm2835_dma device as
 common object
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
	Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429121509.F7rXQ3Khd5zXNwD6uLe1G3ExuS2Q5KCrX_IwfDkkyJI@z>

On Sat, 27 Apr 2019 at 14:30, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> This device is used by both ARM (BCM2836, for raspi2) and AArch64
> (BCM2837, for raspi3) targets, and is not CPU-specific.
> Move it to common object, so we build it once for all targets.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/dma/Makefile.objs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/dma/Makefile.objs b/hw/dma/Makefile.objs
> index 79affecc390..8b39f9c6004 100644
> --- a/hw/dma/Makefile.objs
> +++ b/hw/dma/Makefile.objs
> @@ -14,4 +14,4 @@ common-obj-$(CONFIG_XLNX_ZYNQMP_ARM) +=3D xlnx-zdma.o
>
>  obj-$(CONFIG_OMAP) +=3D omap_dma.o soc_dma.o
>  obj-$(CONFIG_PXA2XX) +=3D pxa2xx_dma.o
> -obj-$(CONFIG_RASPI) +=3D bcm2835_dma.o
> +common-obj-$(CONFIG_RASPI) +=3D bcm2835_dma.o




Applied to target-arm.next, thanks.

-- PMM

