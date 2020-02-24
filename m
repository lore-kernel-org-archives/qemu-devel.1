Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B4C9C38BFA
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:51:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6276520CC7
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7F7Duto"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6276520CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Ldg-0007Sy-Gl
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 16:51:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55469)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1j6L3l-0004Lh-6N
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 16:14:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1j6L3j-0005Zp-Qk
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 16:14:37 -0500
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:46707)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1j6L3j-0005Zj-Ic; Mon, 24 Feb 2020 16:14:35 -0500
Received: by mail-lj1-x242.google.com with SMTP id x14so11667575ljd.13;
 Mon, 24 Feb 2020 13:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DpmcIpYkhMd8gIVEQLN/V4ghbiYvOSH+iuTZEKEuNnc=;
 b=F7F7Dutopk7w0aRMQ6iP5Pqksz6i3byJFhvgOUdr16q28oPfJyuSU3en4+hjxniWMI
 GkSS4zzkrv3wHOiQZULTJp6TSPOTgVbe07kku8BZPIR9vAl2/+c+SeIBDWiPyXN9gvoi
 DObcI6UAtNimHvWCGiyUXjsHdO4RQONvdjC/+F6i4UlgOYuoK0hncTMX8TLeO3F0GS3o
 1OWksr/Jk2ElK3pFrUTrXgmLTSetsN5h7sko/Kiw+nRZnYYJ74zrfoXaTyFWAi1OsK0Q
 eAmHQH4fj8OVyiG7RJkebbcMLGBft/9k3v9N3TzBsI92vJlOQkIvHK7rYUhJOMClWrGx
 rEQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DpmcIpYkhMd8gIVEQLN/V4ghbiYvOSH+iuTZEKEuNnc=;
 b=s9IdfWnjVKCx8jTfhJl1yc83wtVjF2IhXPYLfoBGIeK/23deXw1sKZcvpGenyEpbEr
 7IBkNEP1Zj6bvHMGfoWWE0BqG6UTZoA867fYQt8RK1dtzTaSpCTvOcaY92HIfLcKpEoB
 jz3mRD6quoYSiDbkCGVmGu2wo4PhbbiaA9omm67cFAW3eAIy3e6y2XX8LrarQqn39Pt5
 VJBcxF2bOsgSL4bDqxqp0+MdRUm2Ek1YY9/qEPo7LOERwY//6gzwO4u0TZp1AjAR4MUg
 x1YlAV4NaxrHx5RzjgHGqdSLG8oDLVrWCBRQm7DzG1QDJ9ZADhuo3iK0oNps2QcARRLQ
 /6IA==
X-Gm-Message-State: APjAAAUDNw83fN1K82NA4DP5tmICpfey5SsatzEtHjgWwGD7/GxhtMr4
 WncZScT/KnPV6atrX5sWVGXx1hcyudUhQJahg0I=
X-Google-Smtp-Source: APXvYqxo8vWrZ4h0ZITPEgSpVyhHcSLU2Pp1EYpZ66GiL7AwYRAxEB99CYU6VGO42G185akg61IsJG+clmZs10lwmAU=
X-Received: by 2002:a2e:a36a:: with SMTP id i10mr30572614ljn.107.1582578873907; 
 Mon, 24 Feb 2020 13:14:33 -0800 (PST)
MIME-Version: 1.0
References: <1581861317-30977-1-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1581861317-30977-1-git-send-email-bmeng.cn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 24 Feb 2020 13:06:55 -0800
Message-ID: <CAKmqyKNw6bwiWKbT=0_Yy4CZNrnSjUtyU_TL0G2HMq1WKstK4g@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: sifive_u: Add a "serial" property for board
 serial number
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Feb 16, 2020 at 5:56 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> At present the board serial number is hard-coded to 1, and passed
> to OTP model during initialization. Firmware (FSBL, U-Boot) uses
> the serial number to generate a unique MAC address for the on-chip
> ethernet controller. When multiple QEMU 'sifive_u' instances are
> created and connected to the same subnet, they all have the same
> MAC address hence it creates a unusable network.
>
> A new "serial" property is introduced to specify the board serial
> number. When not given, the default serial number 1 is used.
>
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
>
> ---
>
> Changes in v2:
> - Move setting OTP serial number property from riscv_sifive_u_soc_init()
>   to riscv_sifive_u_soc_realize(), to fix the 'check-qtest-riscv' error.
>   I am not really sure why doing so could fix the 'make check' error.
>   The v1 patch worked fine and nothing seems wrong.
>
>  hw/riscv/sifive_u.c         | 21 ++++++++++++++++++++-
>  include/hw/riscv/sifive_u.h |  1 +
>  2 files changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 0e12b3c..ca561d3 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -34,6 +34,7 @@
>  #include "qemu/log.h"
>  #include "qemu/error-report.h"
>  #include "qapi/error.h"
> +#include "qapi/visitor.h"
>  #include "hw/boards.h"
>  #include "hw/loader.h"
>  #include "hw/sysbus.h"
> @@ -434,7 +435,6 @@ static void riscv_sifive_u_soc_init(Object *obj)
>                            TYPE_SIFIVE_U_PRCI);
>      sysbus_init_child_obj(obj, "otp", &s->otp, sizeof(s->otp),
>                            TYPE_SIFIVE_U_OTP);
> -    qdev_prop_set_uint32(DEVICE(&s->otp), "serial", OTP_SERIAL);
>      sysbus_init_child_obj(obj, "gem", &s->gem, sizeof(s->gem),
>                            TYPE_CADENCE_GEM);
>  }
> @@ -453,6 +453,18 @@ static void sifive_u_set_start_in_flash(Object *obj, bool value, Error **errp)
>      s->start_in_flash = value;
>  }
>
> +static void sifive_u_get_serial(Object *obj, Visitor *v, const char *name,
> +                                void *opaque, Error **errp)
> +{
> +    visit_type_uint32(v, name, (uint32_t *)opaque, errp);
> +}
> +
> +static void sifive_u_set_serial(Object *obj, Visitor *v, const char *name,
> +                                void *opaque, Error **errp)
> +{
> +    visit_type_uint32(v, name, (uint32_t *)opaque, errp);

This is a little confusing. Maybe it's worth adding a comment that
opaque is s->serial?

Either that or change opaque to be SiFiveUState *s and then access
serial via the struct.

> +}
> +
>  static void riscv_sifive_u_machine_instance_init(Object *obj)
>  {
>      SiFiveUState *s = RISCV_U_MACHINE(obj);
> @@ -464,11 +476,17 @@ static void riscv_sifive_u_machine_instance_init(Object *obj)
>                                      "Set on to tell QEMU's ROM to jump to " \
>                                      "flash. Otherwise QEMU will jump to DRAM",
>                                      NULL);
> +
> +    s->serial = OTP_SERIAL;
> +    object_property_add(obj, "serial", "uint32", sifive_u_get_serial,
> +                        sifive_u_set_serial, NULL, &s->serial, NULL);
> +    object_property_set_description(obj, "serial", "Board serial number", NULL);
>  }
>
>  static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
>  {
>      MachineState *ms = MACHINE(qdev_get_machine());
> +    SiFiveUState *us = RISCV_U_MACHINE(ms);

I don't think the Soc should access the machine like this. What if we
use this Soc on a different machine?

There should be a SoC "serial" property that is set before realise as well.

Alistair

>      SiFiveUSoCState *s = RISCV_U_SOC(dev);
>      const struct MemmapEntry *memmap = sifive_u_memmap;
>      MemoryRegion *system_memory = get_system_memory();
> @@ -554,6 +572,7 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
>      object_property_set_bool(OBJECT(&s->prci), true, "realized", &err);
>      sysbus_mmio_map(SYS_BUS_DEVICE(&s->prci), 0, memmap[SIFIVE_U_PRCI].base);
>
> +    qdev_prop_set_uint32(DEVICE(&s->otp), "serial", us->serial);
>      object_property_set_bool(OBJECT(&s->otp), true, "realized", &err);
>      sysbus_mmio_map(SYS_BUS_DEVICE(&s->otp), 0, memmap[SIFIVE_U_OTP].base);
>
> diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
> index 82667b5..7cf742e 100644
> --- a/include/hw/riscv/sifive_u.h
> +++ b/include/hw/riscv/sifive_u.h
> @@ -59,6 +59,7 @@ typedef struct SiFiveUState {
>      int fdt_size;
>
>      bool start_in_flash;
> +    uint32_t serial;
>  } SiFiveUState;
>
>  enum {
> --
> 2.7.4
>
>

