Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F5CBC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 17:32:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F932206E6
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 17:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OwWaKMMM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F932206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsUyx-0002Mw-AS
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 13:32:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34826)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsUct-0002gN-Fs; Mon, 06 Jul 2020 13:09:55 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:38750)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsUcr-0007ch-Mu; Mon, 06 Jul 2020 13:09:55 -0400
Received: by mail-il1-x143.google.com with SMTP id s21so18390706ilk.5;
 Mon, 06 Jul 2020 10:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Qjmg6keciKQ+VOMeBpL/AW2YN1J1Kn6ACCJR6VlV+qI=;
 b=OwWaKMMMP1QFjMhkzf7cgTSnKgDIc5+avykkBDKL5ShxrEZIh2B9WQ4e2zfIOytV/S
 nT2xYaD/K/Vz5l0Ackv84a76Sz0UM/YC/GgxV/iqLEOpTvzEuxbqE411kHshEjoTjLro
 D8tn/C0W0XdheqSqYAmla8lSsnywSVsKq0WHgzdFTlrA5qHkvSACL4/4KkAEjFI5VhYv
 yu4z/Z1UQT1x3Xag1s1raH6NdSUSqtqIsUOrtWYSlMNZfedghH8nGN5g6ZLmqfd1X3fq
 1n5JPWWntS7W1kO4/RKlZkXlSU9pqI4NdubmRt+GADA2vNbCuw3/HfBUFwD2kp5Wgsvr
 AJtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Qjmg6keciKQ+VOMeBpL/AW2YN1J1Kn6ACCJR6VlV+qI=;
 b=e7JvzPmQvBpxb8BkBEiozOCZgxY0Vpt8JFdOdhWp4x00Mdj6i5dL4Oe4Oas2q1gFlk
 qdd6zdZV98lka2iZ21+SHVsECWX5gHe0DzMAF4Cy/z9I2tuHnuBYU+kEm1OWyTSc83O/
 tk5ef74ygfzlSUEQk+9C76uHc/RLpuANqec0GZJoWXmyS+rGMmMzsmwQYbCI+TphIOPe
 UgVNS9IHJsoepl/hEJJS1ujEDms+nk1zi6eJNftgl4wz5quMdHDAd8PNdT0GF2dhbqVo
 eZ6UQx3SyhMllj2cSNEjBYtKMTRoqLp9le+Ix8WAKoD6DvRc66xDkQp9/X30cnmw2YTz
 VTdg==
X-Gm-Message-State: AOAM530OmGoE4gaVBWKq6bieSvoaqclp/GqZqTJsgCdWAWyviXiKxaCb
 SX8T9LYCbAgFbK8eBh5JLxtJvx3bpX6qdRrCvPo=
X-Google-Smtp-Source: ABdhPJyOwkiRiK+9nBFi1yzATBmoIi7mSBskR4fEEeJCsCiuqZAj+mTPEz50OG8NSilCy8YDtIqWGKoKN3C/V91lepU=
X-Received: by 2002:a92:bb84:: with SMTP id x4mr32234878ilk.177.1594055392114; 
 Mon, 06 Jul 2020 10:09:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200704144943.18292-1-f4bug@amsat.org>
 <20200704144943.18292-11-f4bug@amsat.org>
In-Reply-To: <20200704144943.18292-11-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jul 2020 10:00:05 -0700
Message-ID: <CAKmqyKMUWZ9BsEeZkiK4-_MAhFpZO66MKQNhoZ3q1FT+XZie3g@mail.gmail.com>
Subject: Re: [PATCH 10/26] hw/usb/hcd-ehci: Move few definitions from header
 to source
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::143;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x143.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Huacai Chen <chenhc@lemote.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Paul Durrant <paul@xen.org>,
 Magnus Damm <magnus.damm@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 "open list:X86" <xen-devel@lists.xenproject.org>,
 Leif Lindholm <leif@nuviainc.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Richard Henderson <rth@twiddle.net>,
 Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Paul Zimmerman <pauldzim@gmail.com>,
 "open list:New World" <qemu-ppc@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Jul 4, 2020 at 7:53 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
>
> Move definitions only useful for hcd-ehci.c to this source file.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/usb/hcd-ehci.h | 11 -----------
>  hw/usb/hcd-ehci.c | 12 ++++++++++++
>  2 files changed, 12 insertions(+), 11 deletions(-)
>
> diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h
> index 57b38cfc05..4577f5e31d 100644
> --- a/hw/usb/hcd-ehci.h
> +++ b/hw/usb/hcd-ehci.h
> @@ -24,17 +24,6 @@
>  #include "hw/pci/pci.h"
>  #include "hw/sysbus.h"
>
> -#ifndef EHCI_DEBUG
> -#define EHCI_DEBUG   0
> -#endif
> -
> -#if EHCI_DEBUG
> -#define DPRINTF printf
> -#else
> -#define DPRINTF(...)
> -#endif
> -
> -#define MMIO_SIZE        0x1000
>  #define CAPA_SIZE        0x10
>
>  #define NB_PORTS         6        /* Max. Number of downstream ports */
> diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
> index 256fb91e0c..a0beee527c 100644
> --- a/hw/usb/hcd-ehci.c
> +++ b/hw/usb/hcd-ehci.c
> @@ -36,6 +36,18 @@
>  #include "qemu/error-report.h"
>  #include "sysemu/runstate.h"
>
> +#ifndef EHCI_DEBUG
> +#define EHCI_DEBUG   0
> +#endif
> +
> +#if EHCI_DEBUG
> +#define DPRINTF printf
> +#else
> +#define DPRINTF(...)
> +#endif
> +
> +#define MMIO_SIZE        0x1000
> +
>  #define FRAME_TIMER_FREQ 1000
>  #define FRAME_TIMER_NS   (NANOSECONDS_PER_SECOND / FRAME_TIMER_FREQ)
>  #define UFRAME_TIMER_NS  (FRAME_TIMER_NS / 8)
> --
> 2.21.3
>
>

