Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E15C433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:44:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5664120708
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYU1VesL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5664120708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTnRy-0002ym-HJ
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 10:44:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42834)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <a.tarasenko@gmail.com>)
 id 1kTnPA-00011o-Vl; Sat, 17 Oct 2020 10:41:57 -0400
Received: from mail-qv1-xf42.google.com ([2607:f8b0:4864:20::f42]:46381)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <a.tarasenko@gmail.com>)
 id 1kTnP9-00083U-6I; Sat, 17 Oct 2020 10:41:56 -0400
Received: by mail-qv1-xf42.google.com with SMTP id s1so2362324qvm.13;
 Sat, 17 Oct 2020 07:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JiNVF472HuYt6MgbPT0XLWmR4gT4sBztlT6GdODxlJs=;
 b=KYU1VesLSf5KqDgWyc3gjwqCxfekj2rkAFZXwQ16OaLfccGpLxl1smzqGLl5RAPiUk
 nIG28CA7DifzsnskvzPd4Mq6QKGgBMshPAfOBOWYlJnI0T90aLLSsJpA8hvtyCjxmD7A
 0QWpAcJdPETJEui5+LDsul7/kWiLo/5UofZJzBSCdXMhGQzx2ApQZpWq2tX0vxroE9SN
 8f3nPrdVss1UpXBrbQeVue7NKIZ0bJtBC4Op8gVWP8SwtOPnG6W/sv0KI4aE7rsoVQ8P
 7m/NDPt0mGUje9iW/W6yg2hXJB1Tlja1/NmpnfemTvY80C+XUs8hk9aRZNQwfOphrmE3
 co7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JiNVF472HuYt6MgbPT0XLWmR4gT4sBztlT6GdODxlJs=;
 b=kpKc8THsdpynwB9vJknsVc4fzS9f+rQ3Ry4Xp7RwbRziDm4/J0x0tf5OGqj6dP1u/j
 OtOW3eZYOjHG7WO/6WarOdVnd4W1lkPjxUj9X4s3qfx29SJsuPpLzh7FobUintbM3Aaw
 GKNwXnmV8b3A5/ncM16nFtpVFFU/onTKoidn2pU02IWeydnL9xHD2mCULBnKV2C43AqM
 obdppRR61sWjslno2+ncWlmWI+U/ziwAAqOePgpSUurOAip4OnXQF1e5jpZ2N8cJ9UNL
 NUIaZYvqXcNOZP3rYVMUIobY8ikLX2D8h801qE1NmrQZ1tlqfGZOdvAyAN1L6HJPU3ZP
 t6qA==
X-Gm-Message-State: AOAM532Q+Za1lCBt53aobr2DoaICIIGbp3r5EHYjlM9yLllAS5JGgct2
 7qvYvpY9iZJDPLdBOvR9H/9McZ9qCZEM7+YnChjk9+1Hxj0=
X-Google-Smtp-Source: ABdhPJw3pVImP3x0yleJDOLgtik8wQm6t8LQ66ltXyDoBJ5tK3v02x+fFV50zBsMVmyQMk5RQF7bU9BpY9igHZ5nUls=
X-Received: by 2002:a05:6214:18cf:: with SMTP id
 cy15mr9273079qvb.53.1602945712944; 
 Sat, 17 Oct 2020 07:41:52 -0700 (PDT)
MIME-Version: 1.0
References: <20201016182739.22875-1-mark.cave-ayland@ilande.co.uk>
 <20201016182739.22875-5-mark.cave-ayland@ilande.co.uk>
 <653bf315-d1e4-4dc9-dac8-1e859a2ad4d1@eik.bme.hu>
In-Reply-To: <653bf315-d1e4-4dc9-dac8-1e859a2ad4d1@eik.bme.hu>
From: Artyom Tarasenko <a.tarasenko@gmail.com>
Date: Sat, 17 Oct 2020 16:41:41 +0200
Message-ID: <CAAM0arMhKLDAfrqbh9c-rZEGgvYaNUyxFBnjpS2RdT=PcSLB3w@mail.gmail.com>
Subject: Re: [PATCH 4/5] ppc405_boards: use qdev properties instead of legacy
 m48t59_init() function
To: BALATON Zoltan <balaton@eik.bme.hu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::f42;
 envelope-from=a.tarasenko@gmail.com; helo=mail-qv1-xf42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: qemu-trivial@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-devel@nongnu.org, f4bug@amsat.org,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>, qemu-ppc@nongnu.org,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 16, 2020 at 10:38 PM BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> On Fri, 16 Oct 2020, Mark Cave-Ayland wrote:
> > Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> > ---
> > hw/ppc/ppc405_boards.c | 10 +++++++++-
> > 1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
> > index 6198ec1035..4687715b15 100644
> > --- a/hw/ppc/ppc405_boards.c
> > +++ b/hw/ppc/ppc405_boards.c
> > @@ -28,6 +28,8 @@
> > #include "qemu-common.h"
> > #include "cpu.h"
> > #include "hw/ppc/ppc.h"
> > +#include "hw/qdev-properties.h"
> > +#include "hw/sysbus.h"
> > #include "ppc405.h"
> > #include "hw/rtc/m48t59.h"
> > #include "hw/block/flash.h"
> > @@ -145,6 +147,8 @@ static void ref405ep_init(MachineState *machine)
> >     char *filename;
> >     ppc4xx_bd_info_t bd;
> >     CPUPPCState *env;
> > +    DeviceState *dev;
> > +    SysBusDevice *s;
> >     qemu_irq *pic;
> >     MemoryRegion *bios;
> >     MemoryRegion *sram = g_new(MemoryRegion, 1);
> > @@ -227,7 +231,11 @@ static void ref405ep_init(MachineState *machine)
> >     /* Register FPGA */
> >     ref405ep_fpga_init(sysmem, 0xF0300000);
> >     /* Register NVRAM */
> > -    m48t59_init(NULL, 0xF0000000, 0, 8192, 1968, 8);
> > +    dev = qdev_new("sysbus-m48t08");
> > +    qdev_prop_set_int32(dev, "base-year", 1968);
>
> Is there anything that uses other than 1968 as base year?

I think 40p uses 1900 as the base year.

> If not this
> could be the default in the device so you don't need these set prop calls
> here and in sun machines.
>
> The only other place this device is used seems to be ppc/prep machine that
> uses the isa version but does not set a base year. Is that a bug? The
> original prep machine removed in b2ce76a0730 used 2000 but that's unlikely
> as well as these machines predate that. Anyway, the sysbus and isa
> versions are different so their default base-year could be set
> independently and then boards won't need to set this propery and may be
> could use qdev_create_simple instead or whatever that was renamed to.
>
> Regards,
> BALATON Zoltan
>
> > +    s = SYS_BUS_DEVICE(dev);
> > +    sysbus_realize_and_unref(s, &error_fatal);
> > +    sysbus_mmio_map(s, 0, 0xF0000000);
> >     /* Load kernel */
> >     linux_boot = (kernel_filename != NULL);
> >     if (linux_boot) {
> >

