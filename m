Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC79C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:48:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6B2F20673
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 17:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uYus/O/J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6B2F20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33082 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLANx-0002nL-0l
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 13:48:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hLA74-0005jz-Oy
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:30:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hLA73-0006lQ-Qh
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:30:46 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:40418)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hLA71-0006k7-LP; Mon, 29 Apr 2019 13:30:43 -0400
Received: by mail-lj1-x244.google.com with SMTP id t10so9102007ljg.7;
	Mon, 29 Apr 2019 10:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=D0CsyVuEeijjtNrn3BRdbHVTNz74u9iotAEhTxxMyXM=;
	b=uYus/O/JfNBTN/acpE1d/z1mxuuuypqXzI7iegKxHMRGiUhFfMJ+iQehbIK2KRO5qk
	NJe8Lvr+0bj98gF4ww0qMwRG7FIJnw3pULMkPVFZypDLBPATY2HTiT2y9LzYwuvicn83
	CVPDHiv2E+Awgn5Qkii/kC3cgZxR+SU1xSs+60FRpiz8LgW3VjcSBv0zaW4Qj3Kx3uHe
	S0OSRcusH1imkaoCgFLOVFXd6OnJ4cuz05szWixL0uRzyEA+Q13dntbz/9QxXsk6vBjK
	6tRLKGaZcfjap6MnOWhrJwLSiogND1A9gp4zHXKMupIQyhj1moDhEnppbpVfEpXlsxOO
	SW2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=D0CsyVuEeijjtNrn3BRdbHVTNz74u9iotAEhTxxMyXM=;
	b=mRvZ0GDoIKnsWNlNgE06zY4IwjGE4YOG0wSV3H4L38+Yx/ut2blsMTxMX1HfntzTr0
	OSJhwIkm05AlH8RTcAidLC4tqf1/Z6JNlV+PuWBFHfgOBJ0TpA5GrFBchG4mdA37DkAe
	La+UW0YI3A2lHSA0XXQanXfrUUreZuewpYFBkgldOhluxwcHpm2zShpL9LHKV9yyCp5y
	g2oBtmLm9SOG4yEohM3WXD1aB46nypM4ILtsz6RrVRLsoj/rUH+o3F7NKsC+iF07Lpc9
	skdOKmNJjsnIOlwp44xYDGgIFYdcpE+fswZ9t9ScZRKI/cugQqHDT7+yNHgylQ++cV9w
	hLIg==
X-Gm-Message-State: APjAAAWSftElRvP0smBOWuwf4s6eAMkpY8eMoWviEDZjBKThBuU2BVEe
	O81as/BGTLikMAc2fXXKcWX/+z2NJSBDejNK5g5WIX91
X-Google-Smtp-Source: APXvYqyFNaAZT8rDRO+Sgxic7DRX0iIDQVrmY1xV35w8UuXxRyQl/r/I7M5ZKnx59LMGuHs5VaDQ5jyP/QjU/mtXeZ8=
X-Received: by 2002:a2e:824b:: with SMTP id j11mr6798990ljh.197.1556559042610; 
	Mon, 29 Apr 2019 10:30:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190427141459.19728-1-philmd@redhat.com>
	<20190427141459.19728-4-philmd@redhat.com>
In-Reply-To: <20190427141459.19728-4-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Apr 2019 10:30:12 -0700
Message-ID:
 <CAKmqyKN=WFU3fGDM_t1tnwH6E7dPSpHBUBoWSzZiLe7tf7p8FA@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::244
Subject: Re: [Qemu-devel] [PATCH 3/3] hw/dma: Do not build the xlnx_dpdma
 device for the MicroBlaze machines
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
Message-ID: <20190429173012.w_J_fZ44LburX_i_pTK09kTuI11uomJXH1XsbZCbTbk@z>

On Sat, Apr 27, 2019 at 7:15 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> The xlnx_dpdma device is only used by the ZynqMP AArch64 machine
> (not the MicroBlaze PMU). Remove it from the ZynqMP generic objects.
> (Note, this entry was duplicated for the AArch64).
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/dma/Makefile.objs | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/hw/dma/Makefile.objs b/hw/dma/Makefile.objs
> index 79affecc390..a5b1276f52a 100644
> --- a/hw/dma/Makefile.objs
> +++ b/hw/dma/Makefile.objs
> @@ -8,7 +8,6 @@ common-obj-$(CONFIG_XILINX_AXI) +=3D xilinx_axidma.o
>  common-obj-$(CONFIG_ZYNQ_DEVCFG) +=3D xlnx-zynq-devcfg.o
>  common-obj-$(CONFIG_ETRAXFS) +=3D etraxfs_dma.o
>  common-obj-$(CONFIG_STP2000) +=3D sparc32_dma.o
> -obj-$(CONFIG_XLNX_ZYNQMP) +=3D xlnx_dpdma.o
>  obj-$(CONFIG_XLNX_ZYNQMP_ARM) +=3D xlnx_dpdma.o
>  common-obj-$(CONFIG_XLNX_ZYNQMP_ARM) +=3D xlnx-zdma.o
>
> --
> 2.20.1
>
>

