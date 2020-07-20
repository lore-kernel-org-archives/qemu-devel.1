Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856B7C433E4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 09:57:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DA2B21775
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 09:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PlxPjlKx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DA2B21775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxSXw-0001DY-J4
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 05:57:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxSX5-0000Zs-9b
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 05:56:27 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:41608)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxSX2-0006wN-HS
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 05:56:26 -0400
Received: by mail-oi1-x243.google.com with SMTP id y22so13928281oie.8
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 02:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Igl+SeUa2coVvr0kUZnPl7TcdbXnN/EO0v1zIvH6CxY=;
 b=PlxPjlKxHoo48Sd5OgeICMu2gCoSftiSn63AZhrA9VyObhTi/03dz+ugKYVqU0481J
 WshALREvOMIqD3bUELRIOs43tiWqr5z2nh5Iw05Y1E3DPt9GeMBedzADOaF4pOQxrRXl
 EKl7zVWmF76y+VYukJdAqEMJ7He9n6x1Cht32qlzgXr7ENkTm3Q1FFtJ262SL/jz/5Tb
 2YzBMGXs7EVBMgwS0uCUvTf5wFgPYaj2C5HLkOi9oHUeNd9vWjWkAhLD3jVoY1Gv7OfU
 dFCvW+PqtsyxWX435U6bKbsem8CKTlOWzBdGd4puQmpV97B/efMbE0mb7EWMBMxD54OD
 ZvEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Igl+SeUa2coVvr0kUZnPl7TcdbXnN/EO0v1zIvH6CxY=;
 b=Ojm9oMMr4oI9T1Ra6LjXcXAhvlgxtutdUy1eXy6SIyIQZnpQEOvv6qiPOWlswT/WAK
 j+OKEp5Dl+9EPhz5MwHGSLIa3QwiOnwqRkWHoRnPEoUkE2MlIoF3TNUWQFoTt2fruQkS
 DqI2Ig+PSbekYZHQiPZDzA1SM7ftC+4Kfz+m5WlN3zuZxSx5CQmkq0fMh+qXmRueLVpB
 wNryoWYZFX+S5f4AAsy+FTKZHIUhbTrsrr2+AJgqz1M3CuOtQ09Bz1uAwLI3nWeBDcaE
 D695LMlO8QfecGRsqhBimFs7YHi+TgvpbDrydeHLneXxMxxAFvw07v856zNHuPN4RddO
 cMsg==
X-Gm-Message-State: AOAM533NK2qf+kP2AqN8CTAJQdIaJSst7pFvQIDaZMpHF9W+Eob1loMo
 176ISP0O/iE9K4e+U8Hz8KhgI5jsCFJfsyCLO/8QMQ==
X-Google-Smtp-Source: ABdhPJzR3o6HsUQC8cAkr1NtmQjEn+O1UENBYOkihbmCbfkCTliHAZw8kd5Edd1PF94bIJ27PwFvEZLjdFGTtGDRicc=
X-Received: by 2002:aca:54c9:: with SMTP id
 i192mr17085614oib.163.1595238983048; 
 Mon, 20 Jul 2020 02:56:23 -0700 (PDT)
MIME-Version: 1.0
References: <159480834629.15819.10175861928294983612.stgit@pasha-ThinkPad-X280>
 <159480835744.15819.10383908697966018668.stgit@pasha-ThinkPad-X280>
In-Reply-To: <159480835744.15819.10383908697966018668.stgit@pasha-ThinkPad-X280>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Jul 2020 10:56:11 +0100
Message-ID: <CAFEAcA9f18nwJQhX5EGtHWeHjw4DbRBmU1xmZm8gCgOkSgP+Mw@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/arm: remove exit(1) in case of missing ROM
To: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x243.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Antony Pavlov <antonynpavlov@gmail.com>, Huacai Chen <chenhc@lemote.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 15 Jul 2020 at 11:19, Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru> wrote:
>
> This patch updates ARM-based machines to allow starting them without ROM.
> In this case CPU starts to execute instructions from the empty memory,
> but QEMU allows introspecting the machine configuration.
>
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>

I guess this makes sense -- this is how most of our machines
already behave, so consistency and being able to introspect
the machine config are both worth having. Also these errors
mostly pre-date the 'generic loader' device, which is another
way to load guest code that the error-exit prevents. (You could
even load guest code via the gdbstub if you wanted...)

arm machines affected by this patch:
 * canon-a1100
 * connex
 * verdex
 * sx1
 * sx1-v1
 * cheetah

none of which are commonly-used anyway.

> ---
>  0 files changed
>
> diff --git a/hw/arm/digic_boards.c b/hw/arm/digic_boards.c
> index b6452d918c..dbad63ffa2 100644
> --- a/hw/arm/digic_boards.c
> +++ b/hw/arm/digic_boards.c
> @@ -102,8 +102,12 @@ static void digic_load_rom(DigicState *s, hwaddr addr,
>          char *fn = qemu_find_file(QEMU_FILE_TYPE_BIOS, filename);
>
>          if (!fn) {
> -            error_report("Couldn't find rom image '%s'.", filename);
> -            exit(1);
> +            if (bios_name) {
> +                error_report("Couldn't find rom image '%s'.", filename);
> +                exit(1);
> +            } else {
> +                return;
> +            }
>          }
>
>          rom_size = load_image_targphys(fn, addr, max_size);
> diff --git a/hw/arm/gumstix.c b/hw/arm/gumstix.c
> index 3a4bc332c4..a74bb5e27c 100644
> --- a/hw/arm/gumstix.c
> +++ b/hw/arm/gumstix.c
> @@ -60,9 +60,8 @@ static void connex_init(MachineState *machine)
>
>      dinfo = drive_get(IF_PFLASH, 0, 0);
>      if (!dinfo && !qtest_enabled()) {
> -        error_report("A flash image must be given with the "
> -                     "'pflash' parameter");
> -        exit(1);
> +        warn_report("A flash image must be given with the "
> +                    "'pflash' parameter");

I think we should just drop the error message. If we will
start without the flash image, then "A flash image
must be given" is no longer true.

>      }
>
>      if (!pflash_cfi01_register(0x00000000, "connext.rom", connex_rom,
> @@ -90,9 +89,8 @@ static void verdex_init(MachineState *machine)
>
>      dinfo = drive_get(IF_PFLASH, 0, 0);
>      if (!dinfo && !qtest_enabled()) {
> -        error_report("A flash image must be given with the "
> -                     "'pflash' parameter");
> -        exit(1);
> +        warn_report("A flash image must be given with the "
> +                    "'pflash' parameter");

Ditto here.

>      }
>
>      if (!pflash_cfi01_register(0x00000000, "verdex.rom", verdex_rom,
> diff --git a/hw/arm/omap_sx1.c b/hw/arm/omap_sx1.c
> index 57829b3744..c0ed3d93e9 100644
> --- a/hw/arm/omap_sx1.c
> +++ b/hw/arm/omap_sx1.c
> @@ -191,13 +191,12 @@ static void sx1_init(MachineState *machine, const int version)
>      }
>
>      if (!machine->kernel_filename && !fl_idx && !qtest_enabled()) {
> -        error_report("Kernel or Flash image must be specified");
> -        exit(1);
> +        warn_report("Kernel or Flash image must be specified");

And here.

> +    } else {
> +        /* Load the kernel.  */
> +        arm_load_kernel(mpu->cpu, machine, &sx1_binfo);
>      }

Calling arm_load_kernel() must not be conditional -- it is the
function which makes sure the guest CPU is reset.

(A handful of boards will call arm_load_kernel() only if
!qtest_enabled(), but most call it unconditionally. We should
look at why those handful of boards seem to need the conditional
and either remove it if useless or see if it should be applied
in other places or if arm_load_kernel() itself could be improved
to make the check unnecessary for all boards.)

>
> -    /* Load the kernel.  */
> -    arm_load_kernel(mpu->cpu, machine, &sx1_binfo);
> -
>      /* TODO: fix next line */
>      //~ qemu_console_resize(ds, 640, 480);
>  }
> diff --git a/hw/arm/palm.c b/hw/arm/palm.c
> index 97ca105d29..d4f4a8d07a 100644
> --- a/hw/arm/palm.c
> +++ b/hw/arm/palm.c
> @@ -257,12 +257,11 @@ static void palmte_init(MachineState *machine)
>      }
>
>      if (!rom_loaded && !machine->kernel_filename && !qtest_enabled()) {
> -        fprintf(stderr, "Kernel or ROM image must be specified\n");
> -        exit(1);
> +        warn_report("Kernel or ROM image must be specified");
> +    } else {
> +        /* Load the kernel.  */
> +        arm_load_kernel(mpu->cpu, machine, &palmte_binfo);

Again, drop the warning, and the call to arm_load_kernel()
must not be conditional.

>      }
> -
> -    /* Load the kernel.  */
> -    arm_load_kernel(mpu->cpu, machine, &palmte_binfo);
>  }
>
>  static void palmte_machine_init(MachineClass *mc)

thanks
-- PMM

