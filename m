Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD063C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 15:08:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7813E2075F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 15:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l00q5erM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7813E2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAaYK-0005Zq-PR
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 11:08:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAaVM-0000IY-7l
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 11:04:56 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:45631)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAaVJ-0003FJ-4h
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 11:04:55 -0400
Received: by mail-ej1-x643.google.com with SMTP id si26so17004439ejb.12
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 08:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=KIXcaowuMym4eb+LaRrC6GPH85C78x9/rnLVMXOoZqs=;
 b=l00q5erMLE4Dmm5GH+fjk8so955LW4+QaljUWEdLO+iAVWal62GbCU3BhICehAw+/0
 Nl9qgDwp0LY63KzfvgZPbEfvRh9HzxjQDeJ11ZPvIkkwWOWaJ/9ffQMBcHvDb8VhiXgd
 yxqeaAVf/43UXfvlF0KWxdXdANTT5ikRrTevC6SdTNK6oNnwZR8E27zZ5l9xRsrc4vfk
 XMt3+29FVTqx/apfyZCDbtkXOfL07C3jPbxBFMolYJkF4YucgV15H/XBjl6CzKcLrJNC
 hsvy8tq3J9kZsW4RlCACFinWm2OwhemEO0VdgwPsgMUYDSfM/NArWGofh5o2oPsYwcox
 Mj9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=KIXcaowuMym4eb+LaRrC6GPH85C78x9/rnLVMXOoZqs=;
 b=d8lqDwTdW5oI+fbI63yfkpmNDDZ045b0rF5xs0eJsqr7rMnBGqkySNfui687b2vMSD
 6HYc/P/gpqGn9e08IE2p6YIn/ES/Fj927hPWx9ANMQVETaoLxubDjOyLUrdPrz6JhiCl
 9xBIrz3FbZKvvpKZ7/8+YOvGpQd9hiNictgujYAZId/x4enHq3VYd0PsnTHiWqQL9tZS
 PsyzcWIUJGhIat9qnikg7fft+LJuKRo39rS8CzIenk6F5qLNTBhmDpKuBYVmDjnsbwxI
 +HIjvPY0CTk3kowz4vydsk/JpYHgw8jexXzEzApf6h0oGW5W/PhlTk/bvyHd6droLN5g
 67Jw==
X-Gm-Message-State: AOAM533622aZjUlYxmK3JVQ0vofJOtmiMbaYwCM/nLNVuC33n3nQKHGE
 FjgpqSE8ebxeu+BQq/UbdRXJu7cL534t43f69V6d8w==
X-Google-Smtp-Source: ABdhPJxzzSSGguY/ldEpdEfyP/TpDWQjl1FRTvTgnfP+gYFUfATIZzZFnjqBQ9LQap01GlmWIrqR523CIshnOgyRKfs=
X-Received: by 2002:a17:906:2cc2:: with SMTP id
 r2mr10859286ejr.482.1598367891446; 
 Tue, 25 Aug 2020 08:04:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200818143825.691110-1-f4bug@amsat.org>
 <20200818143825.691110-3-f4bug@amsat.org>
In-Reply-To: <20200818143825.691110-3-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Aug 2020 16:04:39 +0100
Message-ID: <CAFEAcA8fbA0XKEHzMtTOmkzHCN7ji__wB+22uKTAp0-UAgEjEg@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/core/sysbus: Make sysbus_pass_irq() arguments
 self-describing
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 18 Aug 2020 at 15:38, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> Make the direction sysbus_pass_irq() pass the GPIOs more obvious
> by renaming its arguments as 'from_dev' and 'to_dev'.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  include/hw/sysbus.h | 7 ++++++-
>  hw/core/sysbus.c    | 5 ++---
>  2 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/include/hw/sysbus.h b/include/hw/sysbus.h
> index da9f85c58ce..65de6f6b062 100644
> --- a/include/hw/sysbus.h
> +++ b/include/hw/sysbus.h
> @@ -73,7 +73,12 @@ typedef void FindSysbusDeviceFunc(SysBusDevice *sbdev,=
 void *opaque);
>  void sysbus_init_mmio(SysBusDevice *dev, MemoryRegion *memory);
>  MemoryRegion *sysbus_mmio_get_region(SysBusDevice *dev, int n);
>  void sysbus_init_irq(SysBusDevice *dev, qemu_irq *p);
> -void sysbus_pass_irq(SysBusDevice *dev, SysBusDevice *target);
> +/**
> + * sysbus_pass_irq: Pass through IRQ/GPIO lines from one to another devi=
ce
> + * @to_dev: Device which needs to expose IRQ/GPIO lines
> + * @from_dev: Device which has the IRQ/GPIO lines
> + */
> +void sysbus_pass_irq(SysBusDevice *to_dev, SysBusDevice *from_dev);

I think this is less good than what we had before, because (as
per comments on patch 1) "to" vs "from" is ambiguous.
The 'before' here is not as good as the qdev_pass_gpios()
choice of "dev" vs "container", though, so I guess we should
make this function match that one.

> -/* Pass IRQs from a target device.  */
> -void sysbus_pass_irq(SysBusDevice *dev, SysBusDevice *target)
> +void sysbus_pass_irq(SysBusDevice *to_dev, SysBusDevice *from_dev)
>  {
> -    qdev_pass_gpios(DEVICE(target), DEVICE(dev), SYSBUS_DEVICE_GPIO_IRQ)=
;
> +    qdev_pass_gpios(DEVICE(from_dev), DEVICE(to_dev), SYSBUS_DEVICE_GPIO=
_IRQ);
>  }

Having these two functions pass the container and target in
opposite orders seems unnecessarily confusing. We should
make them use the same order, at least...

thanks
-- PMM

