Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A5F9C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 13:19:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9DB3206DA
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 13:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LkShth7c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9DB3206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZDlS-0007ky-Um
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 09:19:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58760)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZDkm-0007GC-Pl
 for qemu-devel@nongnu.org; Thu, 14 May 2020 09:18:24 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:43845)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZDkk-00088j-EW
 for qemu-devel@nongnu.org; Thu, 14 May 2020 09:18:24 -0400
Received: by mail-ot1-x341.google.com with SMTP id a68so2263772otb.10
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 06:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=tCV320QsAetnYGvAZIlT9eDCV3xQn2c+fJkN4XfB/Q4=;
 b=LkShth7cH0w5G+flXQPMduxO342qyrmrnyTTRW721axrsJdDuPB9pb8fPBhbOLwUOv
 C8x5ih/85j6vwgrnIJAvAvvhhyyk4l/z+Tnj50YoyUeBi/qVgGx2518vJ5peaKSgj0eJ
 Hsu484L3skv7jJthUiGu9thcQ7WeqwZ6ifu6/kRf9wwYzs+Y1bfd4yqOWWkE52v0Eqih
 LR4CVRZ2Q9tYdVUXsT7SN7cg3qTXirDlcTRC1flfOy6jUsEGZvbesH9bT+omIMvBZ0PA
 kmYq3BLKfzAHOLt4eOSb+TFX44SiHk2JmCsHByT4tYdPDh7LmtaKmX5frVUNMmeBpsef
 ftOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=tCV320QsAetnYGvAZIlT9eDCV3xQn2c+fJkN4XfB/Q4=;
 b=sFQ24pfDNnnmIQehmBcInask2zFLF0hwX5GpAn51EcAvMFgRI4UFs2Ajclhs4R42pD
 669hIqJe7zTQNvlYXJlAXIX8lf1m8TfWcRcUp/XSWUWoY6P5I6cGalAPQNBTT64W1x5F
 AYvjfUMDDg+2YsBAkvKZnP/PLzbbQb8RE0BeOw4NtiayuUUCYA0OPkbtbHierVRLu6E1
 nJfKOvPhl1gJmIFLcbVvmabvoetvek/jLzDn1oJ4KmAGsQrXlr034fys1DWhbn+ZXxmR
 1Th+2Bd6iKNEi+ml6pdcZyn2DAS/DrWO58Yki2uKI6HcGq8TAN/8h6jGxEL3Gk0C4eph
 8B/A==
X-Gm-Message-State: AOAM530fbzuNMrZIR1Zr7EuuQB99mMb9fGB6k3/MAd9YFOp5/MlmD/iv
 EUiaDtKxfRORPN5gnh7A8UfZurgssog0xDKvu8kvWQ==
X-Google-Smtp-Source: ABdhPJz8D+AmSiSYl0BX4YtNaX74UmyfD3g4T9sJRW7E3zjyX+tmr6QxXNfkFs9ydrvxqWGqyXXXDR51hYLH28pr1QQ=
X-Received: by 2002:a05:6830:1e4e:: with SMTP id
 e14mr3387637otj.91.1589462300136; 
 Thu, 14 May 2020 06:18:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200512074813.29992-1-f4bug@amsat.org>
 <20200512074813.29992-4-f4bug@amsat.org>
In-Reply-To: <20200512074813.29992-4-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 May 2020 14:18:08 +0100
Message-ID: <CAFEAcA8-GnozMpmNJUxLVt893uKesj1Wj9u6pGZgLH4YXH4oNw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] hw/openrisc/pic_cpu: Use qdev gpio rather than
 qemu_allocate_irqs()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Stafford Horne <shorne@gmail.com>, John Snow <jsnow@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 12 May 2020 at 08:48, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> Coverity points out (CID 1421934) that we are leaking the
> memory returned by qemu_allocate_irqs(). We can avoid this
> leak by switching to using qdev_init_gpio_in(); the base
> class finalize will free the irqs that this allocates under
> the hood.

>  hw/openrisc/pic_cpu.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/hw/openrisc/pic_cpu.c b/hw/openrisc/pic_cpu.c
> index 36f9350830..4b0c92f842 100644
> --- a/hw/openrisc/pic_cpu.c
> +++ b/hw/openrisc/pic_cpu.c
> @@ -52,10 +52,9 @@ static void openrisc_pic_cpu_handler(void *opaque, int=
 irq, int level)
>  void cpu_openrisc_pic_init(OpenRISCCPU *cpu)
>  {
>      int i;
> -    qemu_irq *qi;
> -    qi =3D qemu_allocate_irqs(openrisc_pic_cpu_handler, cpu, NR_IRQS);
> +    qdev_init_gpio_in(DEVICE(cpu), openrisc_pic_cpu_handler, NR_IRQS);
>
>      for (i =3D 0; i < NR_IRQS; i++) {
> -        cpu->env.irq[i] =3D qi[i];
> +        cpu->env.irq[i] =3D qdev_get_gpio_in(DEVICE(cpu), i);
>      }
>  }

This isn't wrong as such, but it's a bit weird, because it's code
outside of a device adding GPIO lines to that device, and the
handler function openrisc_pic_cpu_handler() is basically doing
nothing but reaching into the internals of the CPU device and
changing it.

Ideally:
 * all this code should be in target/openrisc/cpu.c, the same
   way the arm CPU creates its own inbound IRQs with qdev_init_gpio_in()
 * cpu->env.irq[] should go away, and hw/openrisc/openrisc_sim.c
   should be calling qdev_get_gpio_in() to get each IRQ line
   it needs, rather than directly grabbing cpu->env.irq and then
   indexing into it

But this change is an OK first step and we can build the other
cleanup on top of it, so
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

