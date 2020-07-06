Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23E8C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 17:28:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 815FF2070C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 17:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5emWhnv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 815FF2070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsUuk-000385-RC
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 13:28:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33858)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsUXt-0007qX-US; Mon, 06 Jul 2020 13:04:45 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:38263)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsUXs-0006wa-8f; Mon, 06 Jul 2020 13:04:45 -0400
Received: by mail-io1-xd42.google.com with SMTP id f6so24558830ioj.5;
 Mon, 06 Jul 2020 10:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=cTCiYJ1utsgT/OEA1JPToQ9e7sbkDVzau0vl+orbX5M=;
 b=Y5emWhnvg2wA6Hsc2mNKM91+PUECbIjNCVx4XijBRlwxhG9yPaVY4nCPuN66Pn/g4N
 jALw2uCbPtXPOhmyJkKBc45MnuJg6mxtGi3kWihcL0PytiWW/5DejqGp9pu1JW3N0B0L
 YJbqT9Ic/jycTAYWFiu+Rsh/qMuTBhTldv4DWUXGneSj8xYSSWACCuJie0v5fihIfGzM
 +FHYD1FVz9yVKlUzWPPpjP3O3le2SpOqqOzlb4GBTfB83H90A+bGP6q+3xoLfe4Nv+cq
 E6XH5NYuSvgxKJUs0XSM4FaA8Wd5kSisFNa8A9sD0zbO1Mx64e82B7/5rFnqrKTujNAu
 cLYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=cTCiYJ1utsgT/OEA1JPToQ9e7sbkDVzau0vl+orbX5M=;
 b=nhrWnsYnbiVKzXw4zdFkvyjPTtZ5TjlyAjP8r1PpPVVMQvVP+60DkmITruvWJA1H44
 9rrK5o7GVA0UXpjO0Kf//OlgyqwPm/mWE910pVy/ddgNBW3gs95ixMC+4Qv2vKGMCi0/
 sYJGSzfpIu6RArb9VlbXJFN7vOUV23xK6JMC/D5U0rIRdX1YbilaCBZJeOlJud2TPxNp
 4vSLVPZXAquiGLXWOxqx8/XFDkDk0bqfT2HKGnFDmO3Q5FzXOJreKPmBPD0YF2ropRbR
 c79LGoag5zVQtDf9Onf9RffUN0MHC4HrEm9F6UaX61PA3i7fbJR71/NypTNuj+VUKBRi
 J6fA==
X-Gm-Message-State: AOAM5315Jg7J6TnKzaAmXRniArtAV5bmDaqt6UQ47DniGAQZMFOaAFfV
 p3JxP35xn+7LYitGD38QqSf4j07pRU29kspmGqI=
X-Google-Smtp-Source: ABdhPJwtinW+rIbee8onSzHAr9mGYnsnNGs22+9NC+YbC3w6hod1nvPLY3hYBjgn60PpMlBLwo7zj8UoDSitGwru4As=
X-Received: by 2002:a5d:97d9:: with SMTP id k25mr26494073ios.42.1594055082487; 
 Mon, 06 Jul 2020 10:04:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200704144943.18292-1-f4bug@amsat.org>
 <20200704144943.18292-8-f4bug@amsat.org>
In-Reply-To: <20200704144943.18292-8-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jul 2020 09:54:53 -0700
Message-ID: <CAKmqyKMk272oxLgGJHQMmZk_7+Q7N=5uPxSUdEMq2-N8DbHrLg@mail.gmail.com>
Subject: Re: [PATCH 07/26] hw/usb/hcd-dwc2: Restrict some headers to source
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d42;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd42.google.com
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

On Sat, Jul 4, 2020 at 7:52 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
>
> The header "usb/hcd-dwc2.h" doesn't need to include "qemu/timer.h",
> "sysemu/dma.h", "hw/irq.h" (the types required are forward declared).
> Include them in the source file which is the only one requiring the
> function declarations.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/usb/hcd-dwc2.h | 3 ---
>  hw/usb/hcd-dwc2.c | 3 +++
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/hw/usb/hcd-dwc2.h b/hw/usb/hcd-dwc2.h
> index 4ba809a07b..2adf0f53c7 100644
> --- a/hw/usb/hcd-dwc2.h
> +++ b/hw/usb/hcd-dwc2.h
> @@ -19,11 +19,8 @@
>  #ifndef HW_USB_DWC2_H
>  #define HW_USB_DWC2_H
>
> -#include "qemu/timer.h"
> -#include "hw/irq.h"
>  #include "hw/sysbus.h"
>  #include "hw/usb.h"
> -#include "sysemu/dma.h"
>
>  #define DWC2_MMIO_SIZE      0x11000
>
> diff --git a/hw/usb/hcd-dwc2.c b/hw/usb/hcd-dwc2.c
> index 590e75b455..ccf05d0823 100644
> --- a/hw/usb/hcd-dwc2.c
> +++ b/hw/usb/hcd-dwc2.c
> @@ -36,8 +36,11 @@
>  #include "qapi/error.h"
>  #include "hw/usb/dwc2-regs.h"
>  #include "hw/usb/hcd-dwc2.h"
> +#include "hw/irq.h"
> +#include "sysemu/dma.h"
>  #include "migration/vmstate.h"
>  #include "trace.h"
> +#include "qemu/timer.h"
>  #include "qemu/log.h"
>  #include "hw/qdev-properties.h"
>
> --
> 2.21.3
>
>

