Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72EE8C4BA2D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 22:59:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1BD824670
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 22:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2MGh55S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1BD824670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j75eh-0004bn-0H
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 17:59:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40364)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1j75cG-0001jr-B6
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 17:57:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1j75cF-0007pQ-6Z
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 17:57:20 -0500
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:38268)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1j75cE-0007hO-V0; Wed, 26 Feb 2020 17:57:19 -0500
Received: by mail-lf1-x144.google.com with SMTP id r14so573393lfm.5;
 Wed, 26 Feb 2020 14:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=w7Cz7S4ZUXHvWEvf7YTm3LirUiL1aqC6vptuu99D+tg=;
 b=b2MGh55S1jX/TrJ21xjCnVdFk7kU17eXQPTkylm9iiwEjno+T1OgJCyruBSHqGfC+O
 RNWRyxV10+yp1x+iSeqkWuiR8WycNNlQPSgc74Y5KijS9lDlzuuFmtTB1hLBrRJhH+UE
 r9f5l2dWKe1m9oU4ZCahGdTsR6/IcGE+Gv5A2L9oy4wKPqDtJj4IF70P7I+j96Hugjmz
 ow4Es3MImqGrp4oKxXqJD6nMwdntF/qBVKFHCPKKMn1u1yNDcPYODlcYfpouK3IPVKPW
 pJ3p36PppHiO24HDhY7MdHd/w+a7uxcnZWRsS/vmuflkk3NjnSayyLXFaw8/DRJBvk6n
 bAcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=w7Cz7S4ZUXHvWEvf7YTm3LirUiL1aqC6vptuu99D+tg=;
 b=YPC98sNyC2mBjvLH9bWkVp5ztgHz06Nss0a6Iodl4DW4EdExMfhy8vI5Tg2GHBJD/I
 WZojlc74Md16jJbnOt4+cWzxYno79o80J7WoCpuyIFl0Hx9mS2XWQVm2njXEPMmycr2u
 /5KCmCe1kaWn5QRGJ9wysvJx8PJiqAeCZTWpdA8/ik+LkYOt7/G2fMVHuvAJZFF3jmfd
 wkS7JYCiaPU+7M+eoPbCZ9+YcQN1Sh/gU+Px8KfH86GO8lBuwCWeM8P4LNrE4pGq0XDh
 kYN4fArnPmBAnm9rGVeDdKAPCTR4l4WuU9fBhzasrrgErrx89heRB5izQvejLyFmPl6/
 EOMg==
X-Gm-Message-State: ANhLgQ1CVuRF7QlhSiAj+CpqdCKLPBy5Zvopq7R4OwL2Y8gbFcwQ1vK3
 4L+p9h9pUMctQeFL7IhUQDRkjqWt5sciez69ZUU=
X-Google-Smtp-Source: ADFU+vuTHUV51WqLUXjAwSTNW+ZPYE1Bn6uktbwLfAVIMS4I8H4pCVnwV6XK5TfaHr88fy2PjkZzzkFn1PFMwyqApAc=
X-Received: by 2002:ac2:5198:: with SMTP id u24mr448618lfi.137.1582757837534; 
 Wed, 26 Feb 2020 14:57:17 -0800 (PST)
MIME-Version: 1.0
References: <20200225131422.53368-1-damien.hedde@greensocs.com>
 <20200225131422.53368-10-damien.hedde@greensocs.com>
In-Reply-To: <20200225131422.53368-10-damien.hedde@greensocs.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 26 Feb 2020 14:49:40 -0800
Message-ID: <CAKmqyKP5VAiHe5PL4crr0KfSwup7vmmys70=6BT5hcMYF37Azw@mail.gmail.com>
Subject: Re: [PATCH v8 9/9] qdev-monitor: print the device's clock with info
 qtree
To: Damien Hedde <damien.hedde@greensocs.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::144
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Mark Burton <mark.burton@greensocs.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Edgar Iglesias <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Feb 25, 2020 at 5:52 AM Damien Hedde <damien.hedde@greensocs.com> w=
rote:
>
> This prints the clocks attached to a DeviceState when using
> "info qtree" monitor command. For every clock, it displays the
> direction, the name and if the clock is forwarded. For input clock,
> it displays also the frequency.
>
> This is based on the original work of Frederic Konrad.
>
> Here follows a sample of `info qtree` output on xilinx_zynq machine
> after linux boot with only one uart clocked:
> > bus: main-system-bus
> >  type System
> >  [...]
> >  dev: cadence_uart, id ""
> >    gpio-out "sysbus-irq" 1
> >    clock-in "refclk" freq_hz=3D0.000000e+00
> >    chardev =3D ""
> >    mmio 00000000e0001000/0000000000001000
> >  dev: cadence_uart, id ""
> >    gpio-out "sysbus-irq" 1
> >    clock-in "refclk" freq_hz=3D1.375661e+07
> >    chardev =3D "serial0"
> >    mmio 00000000e0000000/0000000000001000
> >  [...]
> >  dev: xilinx,zynq_slcr, id ""
> >    clock-out "uart1_ref_clk" freq_hz=3D0.000000e+00
> >    clock-out "uart0_ref_clk" freq_hz=3D1.375661e+07
> >    clock-in "ps_clk" freq_hz=3D3.333333e+07
> >    mmio 00000000f8000000/0000000000001000
>
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>
> v7:
>  + print output clocks frequencies too
>  + add sample of qtree message above
>  + display frequencies in floating-point
> ---
>  qdev-monitor.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/qdev-monitor.c b/qdev-monitor.c
> index 8ce71a206b..1d84b4e416 100644
> --- a/qdev-monitor.c
> +++ b/qdev-monitor.c
> @@ -38,6 +38,7 @@
>  #include "migration/misc.h"
>  #include "migration/migration.h"
>  #include "qemu/cutils.h"
> +#include "hw/clock.h"
>
>  /*
>   * Aliases were a bad idea from the start.  Let's keep them
> @@ -736,6 +737,7 @@ static void qdev_print(Monitor *mon, DeviceState *dev=
, int indent)
>      ObjectClass *class;
>      BusState *child;
>      NamedGPIOList *ngl;
> +    NamedClockList *ncl;
>
>      qdev_printf("dev: %s, id \"%s\"\n", object_get_typename(OBJECT(dev))=
,
>                  dev->id ? dev->id : "");
> @@ -750,6 +752,13 @@ static void qdev_print(Monitor *mon, DeviceState *de=
v, int indent)
>                          ngl->num_out);
>          }
>      }
> +    QLIST_FOREACH(ncl, &dev->clocks, node) {
> +        qdev_printf("clock-%s%s \"%s\" freq_hz=3D%e\n",
> +                    ncl->output ? "out" : "in",
> +                    ncl->alias ? " (alias)" : "",
> +                    ncl->name,
> +                    CLOCK_PERIOD_TO_HZ(1.0 * clock_get(ncl->clock)));
> +    }
>      class =3D object_get_class(OBJECT(dev));
>      do {
>          qdev_print_props(mon, dev, DEVICE_CLASS(class)->props_, indent);
> --
> 2.25.1
>
>

