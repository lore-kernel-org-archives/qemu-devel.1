Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A99DC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 16:16:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2207124650
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 16:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dLzEd+AO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2207124650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX5AP-0000c4-MH
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 12:16:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54200)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kX4xj-0003KC-IA
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 12:03:12 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:36447)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kX4xh-0005u2-6U
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 12:03:11 -0400
Received: by mail-ej1-x642.google.com with SMTP id w27so14387116ejb.3
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 09:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nEAOEE2OqMC6Dka/XEM1yk542AFlUGnm5u3rydQEqKo=;
 b=dLzEd+AOb9SlLuOxppmJl1mZ/ji+DCh+1+Akk2oV5pwNs8I13vsIfTDvFd3x9fhADa
 vyimx9m+O7m3SgDEgptcbLhlZsdMSMiaN/2N2+9Z+aVqA3aO1hjOiV7MqpIgLwzwldph
 3l+hi0ImgWBQFKGCkfwGYKVbOUMiyJQTrwUgesRkOJM1Ukqz6dmfrjxk+VF7s7byqLR8
 kEDEKlX2JS4TEIOYO6rFq7T5eLPNHfmRIfAjHDPiRTnqLw/v8e8RT7YKFOQYK0DWeCfO
 Gro6Btf59jP1uKfr/eifxCuitSUiV/rjvKX4I17nEKZi/cv147SAVE/D4MYObNfD/AvR
 m5EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nEAOEE2OqMC6Dka/XEM1yk542AFlUGnm5u3rydQEqKo=;
 b=qQDXokpIr/R3EnWsIV/PdeiJfF9MK0Nk0GJ0CGUurP0FECvFJ5aydcMnGdbKgOEFzj
 MAqOkRtNsUJrXWjXX1dnDDVgM8fgDZHbsOXq3RMrz5HDVzjCiCyhNJytOYc1klx6YD/q
 QJmZCElm8jK/FvshvRFIjxJX1GOSeV48vBDyDnboo/p8TbFkWvKhedWeE1mr+N+rkwSB
 RRZyfmMrRPJWE6yBHidqsrR1dL70885QCP97swXnR+RQrNWkeHgpA5K+XDkJJxcfB40M
 Ly+junIR41CG1AgX/4ivLBZY2IUffECmMsY88ANwQCPofrTt9TqGt8gmn0nO1lJXvWv+
 Dh7g==
X-Gm-Message-State: AOAM533vY5g/jgQzpfp4OlvxPucQg+YdIDhZOtRgv5z0zbNDwjTOHmfA
 G7J0Rluvj9g8vIf788u+e8PZewoDjtdn6kAzPN30/A==
X-Google-Smtp-Source: ABdhPJz+auM2AQ0Xv8tMviHA6xLLjnEln9gclmk1MnqUX9XLnMvdcLzWA8SY7wGT3EkB0V0ag30laQRtfvSp+JEekLM=
X-Received: by 2002:a17:906:3a97:: with SMTP id
 y23mr16349315ejd.250.1603728187664; 
 Mon, 26 Oct 2020 09:03:07 -0700 (PDT)
MIME-Version: 1.0
References: <1603369056-4168-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1603369056-4168-2-git-send-email-sai.pavan.boddu@xilinx.com>
In-Reply-To: <1603369056-4168-2-git-send-email-sai.pavan.boddu@xilinx.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Oct 2020 16:02:56 +0000
Message-ID: <CAFEAcA_UuL=ymba+v1O75EOZqXBopLq_HOEtgZ8vZSyJ3AcF3Q@mail.gmail.com>
Subject: Re: [PATCH v12 1/3] misc: Add versal-usb2-ctrl-regs module
To: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x642.google.com
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
Cc: Francisco Eduardo Iglesias <figlesia@xilinx.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Vikram Garhwal <fnuv@xilinx.com>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Sai Pavan Boddu <saipava@xilinx.com>, Edgar Iglesias <edgari@xilinx.com>,
 Alistair Francis <alistair.francis@wdc.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ying Fang <fangying1@huawei.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Paul Zimmerman <pauldzim@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 22 Oct 2020 at 13:11, Sai Pavan Boddu
<sai.pavan.boddu@xilinx.com> wrote:
>
> This module emulates control registers of versal usb2 controller, this is added
> just to make guest happy. In general this module would control the phy-reset
> signal from usb controller, data coherency of the transactions, signals
> the host system errors received from controller.
>
> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
> Signed-off-by: Vikram Garhwal <fnu.vikram@xilinx.com>
> ---
>  hw/misc/meson.build                          |   1 +
>  hw/misc/xlnx-versal-usb2-ctrl-regs.c         | 229 +++++++++++++++++++++++++++
>  include/hw/misc/xlnx-versal-usb2-ctrl-regs.h |  45 ++++++

This seems a bit odd. If it's a USB device (or part of a USB
device) then it should be under hw/usb, shouldn't it?

> +static void ir_status_postw(RegisterInfo *reg, uint64_t val64)
> +{
> +    VersalUsb2CtrlRegs *s = XILINX_VERSAL_USB2_CTRL_REGS(reg->opaque);
> +    /*
> +     * TODO: This should also clear USBSTS.HSE field in USB XHCI register.
> +     * May be combine both the modules.
> +     */

What does the hardware for this look like? You've modelled
it as two completely separate devices (this one and the
TYPE_USB_DWC3) but would it be closer to the hardware
structure to have a top-level device which has-a DWC3 ?

thanks
-- PMM

