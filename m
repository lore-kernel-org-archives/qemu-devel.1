Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D37ECC4363D
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 00:06:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38DDE2067C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 00:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkhOPp4c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38DDE2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNm6w-0005uJ-S0
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 20:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kNm5j-0005H2-33; Wed, 30 Sep 2020 20:04:59 -0400
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:37373)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kNm5h-0006TP-GC; Wed, 30 Sep 2020 20:04:58 -0400
Received: by mail-il1-x142.google.com with SMTP id j13so4334736ilc.4;
 Wed, 30 Sep 2020 17:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=YPWmL5pqxcGhaQHK4Z5UI4PW8UeS6FPhFCYrMEvjtso=;
 b=nkhOPp4c6Qa0eFRa+2Y3Ni6dG7752zjaBeBHsql53dac/htwSg8IeN0V4+0xEhsbDl
 Is/KsLUxvMj47pYwKUmY1t/O6tFtNWuR/LEgUupftBoUbRotewJog4IxD/3DxIpgMd54
 oXbcc5W+SzOP4SC0XXR8A2Smi+Pumpyn0LABdZeWXmGfbIzFg80sd5Qld0qeccqAx0w4
 epxAiSKbLmdTcHtYIhUk1ZnMJsMv2nQxVLbkNrU+hBJWArLeif4tSeln0g68u94teIKi
 PM0Zd2WkMfJ0EWZOH6zUMKy0s+VsIAi5I1Lt0I7FdODumwsSXe4Ws2ZIuLFEOs6nXo59
 imEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=YPWmL5pqxcGhaQHK4Z5UI4PW8UeS6FPhFCYrMEvjtso=;
 b=ZZHyHmWEaKICrgZ+L8JnDEsUbtdb0aXXF2IXMuZv8MfT54vkdn1i/zNijYDE6Ischz
 C5F1TejJpgub3PWc88s3ytzYUBX9imCnsReMMCPPg0EEW5t+SfZTN4vylBHm6O6GHG9U
 2Wvztm41NEzlO3dkbkyqa9p/ljSmSo0eagn0brWJeDrMrmSujXVBeHB4TDc6nssZcZx4
 JBEI7pV54MqJEh3AhzGdnMUrDJUAA5UyvnwFsSdKWnd+JdzJG3XS/YGlqfMyWkagmVSI
 iyPn4As4pnElH22+9t0gNFSAdg+FR/gAFcbZwFnj8ugrkMu4eCRd3OA7lfkTk2McEWmp
 dTRA==
X-Gm-Message-State: AOAM532dSpgzq1wwufh330TGD2fQQoRvW//INIqVeHDrdTkPxpczLCUx
 d0UYcthDxPCfbPk7okpg/j3DBK/SlcDb0rhsLJ0=
X-Google-Smtp-Source: ABdhPJzOTFD0B5Wzc/6Lu6NnSITMKbPzTOdGOqTNqwSSvwQA9+WwFHTWBXvJOSCb3cds3z9jFFcmqqP/Js2ZVW2SDpA=
X-Received: by 2002:a92:9817:: with SMTP id l23mr338924ili.131.1601510696190; 
 Wed, 30 Sep 2020 17:04:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200927091946.65491-1-f4bug@amsat.org>
In-Reply-To: <20200927091946.65491-1-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 30 Sep 2020 16:53:33 -0700
Message-ID: <CAKmqyKO0jkh+=R4H5yFms2fDk7N4vfUgU8RQLTAZHqoCPMS9kw@mail.gmail.com>
Subject: Re: [PATCH] ssi: Display chip select polarity in monitor 'info qtree'
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::142;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x142.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 qemu-arm <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Sep 27, 2020 at 2:20 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> It is sometime useful to verify a device chip select polarity
> on a SPI bus. Since we have this information available, display
> it in the 'info qtree' monitor output:
>
>   $ qemu-system-arm -M lm3s6965evb -monitor stdio -S
>   (qemu) info qtree
>   [...]
>   dev: pl022, id ""
>     gpio-out "sysbus-irq" 1
>     mmio 0000000040008000/0000000000001000
>     bus: ssi
>       type SSI
>       dev: ssd0323, id ""
>         gpio-in "" 1
>         gpio-in "ssi-gpio-cs" 1
>         chip select polarity: high           <---
>       dev: ssi-sd, id ""
>         gpio-in "ssi-gpio-cs" 1
>         chip select polarity: low            <---
>         bus: sd-bus
>           type sd-bus
>           dev: sd-card, id ""
>             spec_version =3D 2 (0x2)
>             drive =3D "sd0"
>             spi =3D true
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/ssi/ssi.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/hw/ssi/ssi.c b/hw/ssi/ssi.c
> index 4278d0e4440..4c9f8d66d23 100644
> --- a/hw/ssi/ssi.c
> +++ b/hw/ssi/ssi.c
> @@ -17,6 +17,7 @@
>  #include "migration/vmstate.h"
>  #include "qemu/module.h"
>  #include "qapi/error.h"
> +#include "monitor/monitor.h"
>  #include "qom/object.h"
>
>  struct SSIBus {
> @@ -26,10 +27,31 @@ struct SSIBus {
>  #define TYPE_SSI_BUS "SSI"
>  OBJECT_DECLARE_SIMPLE_TYPE(SSIBus, SSI_BUS)
>
> +static void ssi_print_dev(Monitor *mon, DeviceState *dev, int indent)
> +{
> +    static const char *const polarity_s[] =3D {
> +        [SSI_CS_NONE] =3D "unknown",
> +        [SSI_CS_LOW]  =3D "low",
> +        [SSI_CS_HIGH] =3D "high"
> +    };
> +    SSISlaveClass *ssc =3D SSI_SLAVE_GET_CLASS(dev);
> +
> +    monitor_printf(mon, "%*schip select polarity: %s\n",
> +                   indent, "", polarity_s[ssc->cs_polarity]);
> +}
> +
> +static void ssi_bus_class_init(ObjectClass *klass, void *data)
> +{
> +    BusClass *k =3D BUS_CLASS(klass);
> +
> +    k->print_dev =3D ssi_print_dev;
> +}
> +
>  static const TypeInfo ssi_bus_info =3D {
>      .name =3D TYPE_SSI_BUS,
>      .parent =3D TYPE_BUS,
>      .instance_size =3D sizeof(SSIBus),
> +    .class_init =3D ssi_bus_class_init,
>  };
>
>  static void ssi_cs_default(void *opaque, int n, int level)
> --
> 2.26.2
>
>

