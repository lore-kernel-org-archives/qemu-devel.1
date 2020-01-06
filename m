Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B5BC33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 16:02:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D8A720707
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 16:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RTKTJFym"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D8A720707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioUpm-0005FI-7E
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 11:02:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54765)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ioUom-0004Rm-Fi
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 11:01:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ioUol-0003tb-BU
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 11:01:24 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:39046)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ioUol-0003sy-5r
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 11:01:23 -0500
Received: by mail-oi1-x242.google.com with SMTP id a67so16184770oib.6
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 08:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=fjHBg905L5Ky0lWVe6NXpfNqzz1ujavN84hCA1yqE0I=;
 b=RTKTJFymWlrUjINowAhL9lrVMjl/2B7Vsua1kq8rpJfNRB1kOxhcJRymUn2AmZfLy7
 y/i5Fd/UuvHUxlbgEF/qJlEpz7xL6MSac05yFlIvMKc+b7TEgsnmzIE5YkdWF+FwRH5M
 vgJmodhmUikkUY30SwzkCGFBOBNA3l2RWo81IZX3xiL+UdksTzrpKFnTRIdzzxOdlgsm
 LSfyJUmSzY5MdT6d4IwMwnPyzHyeglq2zZ3alQxrypq58KE/t9z6BEqmbyOmk2Vr0i94
 v7eoIxAncAjKxCUVxWlVtlzh77zyJMUzq2G8Xsls5hcTCn+x8yNXCTXsANCelp17HPa5
 rcEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=fjHBg905L5Ky0lWVe6NXpfNqzz1ujavN84hCA1yqE0I=;
 b=tgyeZDtVR98xBoRaRz8k5cXDdbMhTjY955c++NFmTcaVzh+U/D8WXzY1EZSzVaGRdc
 FbTh9QQglqNTgHtvi1TK83cPJgytX8LHjDlBnPIiEn8eVK7tXoBnKEfcvnBeJBVkqeCQ
 L9a6WeN8TfYffvp/bbP9zObPFJ7MYH5OEtKyO+HouNM2ER/Bgr6iSJkQATU81VqHwfZ7
 CMu35cpsjILL0amUs3AXflFMzJ5UUC1+LnHGTSnHsKBHrI0FCfrShQ+h0z0yMUI8Rs31
 ZPDh4II6rjDXwPq9KL9PhfmMHPIRUx4p06Zt8Ah9rMb7vk8IFdlz3XY/5krKdSn1UD5e
 BhYQ==
X-Gm-Message-State: APjAAAXB7LxGh85wst2ptt780+qD0Wr85FazTuIHTKrlXQP7KFm+UmtP
 ZDGhemPx2vgIfQYDyAu/NiM4XHT1wVbkA0CWLhpHdg==
X-Google-Smtp-Source: APXvYqw4jEwt2vymLCT/NHGVhoIfF9p+zdoKygmC6/rArRsV5m3sqdjjooX2XpKYYJW5E4lrXwURb0y8d8t7LCy/C8E=
X-Received: by 2002:aca:570d:: with SMTP id l13mr5450072oib.146.1578326482292; 
 Mon, 06 Jan 2020 08:01:22 -0800 (PST)
MIME-Version: 1.0
References: <20191230110953.25496-1-f4bug@amsat.org>
 <20191230110953.25496-5-f4bug@amsat.org>
In-Reply-To: <20191230110953.25496-5-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Jan 2020 16:01:11 +0000
Message-ID: <CAFEAcA8oR4b4DZXcLV=QjyCBMc9ot-Wj10cUM=UU=Y9-kBfxEg@mail.gmail.com>
Subject: Re: [PATCH 4/6] hw/arm/allwinner-a10: Simplify by passing IRQs with
 qdev_pass_gpios()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 30 Dec 2019 at 11:10, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> By calling qdev_pass_gpios() we don't need to hold a copy of the
> IRQs from the INTC into the SoC state.
> Instead of filling an array of qemu_irq and passing it around, we
> can now directly call qdev_get_gpio_in() on the SoC.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  include/hw/arm/allwinner-a10.h |  1 -
>  hw/arm/allwinner-a10.c         | 24 +++++++++++-------------
>  2 files changed, 11 insertions(+), 14 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

