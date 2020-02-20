Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72672C11D05
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 15:06:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F8D02071E
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 15:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p0hK/2mF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F8D02071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4nP0-0007ek-1R
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 10:06:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46089)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j4nO5-0006Xn-Uc
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 10:05:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j4nO4-0002tA-Re
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 10:05:13 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:35365)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j4nO4-0002se-Lb
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 10:05:12 -0500
Received: by mail-oi1-x242.google.com with SMTP id b18so27860686oie.2
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 07:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ha7WNp34FymPkhMtZXsI3NKdYl16Zvgi/+5I5PPeEq8=;
 b=p0hK/2mFOUGwjvy8WVTEvKpNn8dP1JiIbfxdhoSU71vtH0+3M/S89rLv2rMKquO4JD
 B9sz8UX5o7ZroSjG60TKGXphm6uLNbQ1ennHZht73WDFt8Hd0jPfV4NoG3G5XyAeYMQ8
 pMeOzG2k8a1kkFUXUPVPOfimLCpiFqjdgr+snhjJ1g2ScWd1N05Y5TH79FJiJqi7/sOp
 AkU7CalO5jHMIC8Utr85QGlRJZsbKrbq3KjSCECK2mMEmSYJpx0slHZieRFOn9A+XF86
 dMlhVKkDbQUKW0G0VSMOoAaRYIAmLixmUp7OCASeK9n8a5se2ykeSvGAYwr31W0bqqhB
 R9CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ha7WNp34FymPkhMtZXsI3NKdYl16Zvgi/+5I5PPeEq8=;
 b=EhpC29F5/ow2eBLKrUuujYVchnsICBiEPEVgFjoh55oTKtFDXvWwAvLLJtgFxSdi7H
 vq52Jn4AXbOTEEUeCCxm6aMb0db28NYz6LfWxlk9K67vwPumNpkqZQLrFOF2Lz8ScCuu
 3QpMhsiagI++p3zXV27oLt+xURy6Gxlfzcw3NR4D0bPR0wU3pHzBFPgPiTjJj6CnEYDE
 9/gSf1Hhkw4JpjuyUJJi427cGE2R8w5B7vKxyF8swRqZtZKyZ3dgNazh/CsPDSQC2aHf
 Td4xJytszo0wf+LMbW/YKoh5SUkwtdiM/yr665LlagOrDESj20YrM/DAF4EyQj4UDK1Q
 XteA==
X-Gm-Message-State: APjAAAXwd90JCQPyLWMmm8+wcYGmff0NHwSnZVirel+L7nEj+W1KE0Rn
 zA1S7S8Ac8hYV20wb/I+AiwLkIlDjETw4UpdZBI4aA==
X-Google-Smtp-Source: APXvYqxmnuXV06Qc8l0P49WFFtJyiVEJ7ui7Wb/sIQI3KmyL0CB+4A6t8JDoNgWFqGHKKACzLCymLEIWU7fQ/W2J8lk=
X-Received: by 2002:a54:4f16:: with SMTP id e22mr2432193oiy.170.1582211111909; 
 Thu, 20 Feb 2020 07:05:11 -0800 (PST)
MIME-Version: 1.0
References: <20200215122354.13706-1-linux@roeck-us.net>
In-Reply-To: <20200215122354.13706-1-linux@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Feb 2020 15:05:00 +0000
Message-ID: <CAFEAcA-u=j3MYu-Ck0UbMzXXEoB41dx6UbGw15QBEnqBBX988g@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] hw/arm/xilinx_zynq: Fix USB port instantiation
To: Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 15 Feb 2020 at 12:23, Guenter Roeck <linux@roeck-us.net> wrote:
>
> USB ports on Xilinx Zync must be instantiated as TYPE_CHIPIDEA to work.
> Linux expects and checks various chipidea registers, which do not exist
> with the basic ehci emulation. This patch series fixes the problem.
>
> The first patch in the series fixes the actual problem.
>
> The second patch removes the now obsolete explicit Xilinx
> support from the EHCI code.
>
> v2: Introduced summary
>
> ----------------------------------------------------------------
> Guenter Roeck (2):
>       hw/arm/xilinx_zynq: Fix USB port instantiation
>       hw/usb/hcd-ehci-sysbus: Remove obsolete xlnx,ps7-usb class

Xilinx folks -- could you provide a reviewed-by or acked-by
for this series, please?

thanks
-- PMM

