Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF0BC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 17:20:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B8F7206CD
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 17:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ubHpKe3N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B8F7206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsUnR-0000E1-Pj
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 13:20:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60478)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsUR9-00038J-Gy; Mon, 06 Jul 2020 12:57:47 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:33209)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsUR7-0005hA-Kt; Mon, 06 Jul 2020 12:57:47 -0400
Received: by mail-io1-xd44.google.com with SMTP id i25so40215363iog.0;
 Mon, 06 Jul 2020 09:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=jbu76fBiXNYavUN7hJcbgVnTcX2cRFUs4aT7tEW/KCU=;
 b=ubHpKe3Nm/Sr5j6MorIaPojzmsRHj5+fmcltESNG2gAbWTvX1yCj86i/BloyiAH3SL
 xWhHSfxANC145Do+ytU9h3x6gUWXXpxoJbax6p8l+3hblfd3vf/ZAPYv7trfCqGSSgM7
 ULfQdyQJbfWa7bnl+6S/qg9ngCL58WTQ9YsqfvGxRjz48ApcTCue/jtHA4PiCxoPwZhs
 CTGRtaolavDk8YuMP5fi1gXkm8RHoEKlXhKjVg2jvZnxY6lwWUiXLwfdbEuPrlbjmpfN
 ZYZ+D4DfO4FNsz/Cko3Rugg6gv4hh5P11TwOjAfiM1LmFxrBE++T4JSXMs2EiDcjqq0I
 iI4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=jbu76fBiXNYavUN7hJcbgVnTcX2cRFUs4aT7tEW/KCU=;
 b=QaKAeFSsD93f34FOGlmeH65kaYNubpLpjaO55X2xgiROq6nTSrjmh2yCQ6NsphbW6F
 FvN9e4Lntqfb4mhZjVW+/l5uInc+NOgCeHrT4rbrA0e/JU94XBbXPU2xEqg3SgDlBZgA
 H8Qsh7oq27ZFwGorRYX3jBAvNPf+4p5+hKYFeWC87OoqXF9QSjIGnO81tyCYtkBn5jo4
 GgmpD7caHFFQT2N89XAsnNGbHJLH88EA8MT2G5pG8o1BZUCjrtwOlRwrxW+gtP7+Qi3G
 fAInqkkBcbgYsioPenN8s7026gUyNIUCLyXZ421q1myWsriwZEaS3XzlNrCiN4fg9AQD
 WIIg==
X-Gm-Message-State: AOAM5321+3tdRa0+J02ShkdNUUIkArsQr2f3v3iB4yJkF2oxlz22O/Hk
 4Bj/yQoIm2r0Ceg6H7qgNjFpGVHGGak38brcU/Q=
X-Google-Smtp-Source: ABdhPJz4Nagjt4yMPeIUiuanaZZK73HDv7ILWk0uVF4t2Q+HCp1PRj88webbTw+MS2P2VLqMmcsYgAWk06cLvYu6Q4g=
X-Received: by 2002:a02:1a06:: with SMTP id 6mr55748921jai.8.1594054664021;
 Mon, 06 Jul 2020 09:57:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200704144943.18292-1-f4bug@amsat.org>
 <20200704144943.18292-9-f4bug@amsat.org>
In-Reply-To: <20200704144943.18292-9-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jul 2020 09:47:55 -0700
Message-ID: <CAKmqyKNeuFosuMbvQ80EQ2uCEXpxfii=8WZE_njt8=3UyzUMqw@mail.gmail.com>
Subject: Re: [PATCH 08/26] hw/usb/hcd-dwc2: Restrict 'dwc2-regs.h' scope
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d44;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd44.google.com
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
> We only use these register definitions in files under the
> hw/usb/ directory. Keep that header local by moving it there.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  {include/hw =3D> hw}/usb/dwc2-regs.h | 0
>  hw/usb/hcd-dwc2.c                  | 2 +-
>  2 files changed, 1 insertion(+), 1 deletion(-)
>  rename {include/hw =3D> hw}/usb/dwc2-regs.h (100%)
>
> diff --git a/include/hw/usb/dwc2-regs.h b/hw/usb/dwc2-regs.h
> similarity index 100%
> rename from include/hw/usb/dwc2-regs.h
> rename to hw/usb/dwc2-regs.h
> diff --git a/hw/usb/hcd-dwc2.c b/hw/usb/hcd-dwc2.c
> index ccf05d0823..252b60ef65 100644
> --- a/hw/usb/hcd-dwc2.c
> +++ b/hw/usb/hcd-dwc2.c
> @@ -34,7 +34,6 @@
>  #include "qemu/osdep.h"
>  #include "qemu/units.h"
>  #include "qapi/error.h"
> -#include "hw/usb/dwc2-regs.h"
>  #include "hw/usb/hcd-dwc2.h"
>  #include "hw/irq.h"
>  #include "sysemu/dma.h"
> @@ -43,6 +42,7 @@
>  #include "qemu/timer.h"
>  #include "qemu/log.h"
>  #include "hw/qdev-properties.h"
> +#include "dwc2-regs.h"
>
>  #define USB_HZ_FS       12000000
>  #define USB_HZ_HS       96000000
> --
> 2.21.3
>
>

