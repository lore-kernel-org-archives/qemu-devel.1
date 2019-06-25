Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F7AC4646B
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 00:45:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CA14206DD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 00:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DuzwEm8i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CA14206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55744 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfZaB-0005Gu-NC
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 20:45:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35622)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hfZZ2-0004Yg-Kc
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 20:44:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hfZZ1-00045X-HA
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 20:44:00 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:46787)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hfZZ1-00043q-B1
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 20:43:59 -0400
Received: by mail-oi1-x241.google.com with SMTP id 65so11178194oid.13
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 17:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=QnsQSrKew7P1kE9N+kSMDpy3sm5zmFlGv+IoK/a8vvI=;
 b=DuzwEm8iq9bLbyWl/DYPCtlFpRYthPgHRd5CfYqSWyHMSb2vbRQqpcYPu7R552jUAN
 k+t5YNst6dJ2zM/eaFpSrTIWSjJkpeL/JI/BvXhbS/5tjGSRMUQRjmehFnuWUMprUqCn
 w02HxOe//L4lvh+7t2SkV2WNO8bA3n+h3ZHOpqERAI7d/LwaU8vew8T66m0BLaXBEzxD
 L3bOeiz0g5Od8RoGjCWHbIEg8ZqqEGfi+WDhR4lXR3yQtHmY9tRYwctwYQUctZjUeH6c
 AEzli6EvmP+8gYW5Axl5vvP4rEKotaRfbFrOhU0qQtZseY8LKVVkrTtcsqk5fJYYN4Hf
 ImnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=QnsQSrKew7P1kE9N+kSMDpy3sm5zmFlGv+IoK/a8vvI=;
 b=pfryecRemXxMvQ7qlZpYDueTZjH8IhNbSrX/g+PJznd++FTPFMh9aQ1+XZpNrGG7cl
 9+6EDN+Pk9ZneI5Uli8SbemnJeJrKuItaA7VRpZVzBUckdG98B17n++GB9fYZve+iPnD
 TAV8FOmgs6ciEyGaDMUslam9c5zV8/VXWx1BlTJzZLyuuEGS6tUCAKgFCDeCywVOE8G9
 JQwkIJxDQBFHrWuKedU36kkupgU5Lv0kVJQGsUff+4Y5ovzU2RxWxedBbG/Gr1XD+9sj
 MJgkcm1U78R0hJG3GD88ogs2mlUbfjYC8ZLfzBJl1A2T9PDMDHE2fqitON2MH87RcJ+4
 gisQ==
X-Gm-Message-State: APjAAAVem/cmrd7R01+xaioFgRddBZ+yENtn4a2xJItlYNEUg1by50fj
 hTuMMLK36sJR3yRcY3O+hvS6E92hM7rx0a2Muhc=
X-Google-Smtp-Source: APXvYqwcNuOZVq1kGevmnztuYYhDRvuh+kH129DA0rGNKLuwfZsNnuZX5u9jCOlvlPP9ipNehJh2xk5ofFX5EYBB3CI=
X-Received: by 2002:aca:310a:: with SMTP id x10mr12801135oix.62.1561423438123; 
 Mon, 24 Jun 2019 17:43:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:20e4:0:0:0:0:0 with HTTP; Mon, 24 Jun 2019 17:43:57
 -0700 (PDT)
Received: by 2002:a9d:20e4:0:0:0:0:0 with HTTP; Mon, 24 Jun 2019 17:43:57
 -0700 (PDT)
In-Reply-To: <20190624222844.26584-8-f4bug@amsat.org>
References: <20190624222844.26584-1-f4bug@amsat.org>
 <20190624222844.26584-8-f4bug@amsat.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 25 Jun 2019 02:43:57 +0200
Message-ID: <CAL1e-=gNKxSt9qAEGx4akJULMNE1KK2OF5X3wfSO=WUfnC5KSw@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH 07/10] hw/mips/gt64xxx_pci: Align the
 pci0-mem size
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jun 25, 2019 12:44 AM, "Philippe Mathieu-Daud=C3=A9" <f4bug@amsat.org> w=
rote:
>
> One byte is missing, use an aligned size.
>
>     (qemu) info mtree
>     memory-region: pci0-mem
>       0000000000000000-00000000fffffffe (prio 0, i/o): pci0-mem
>                                       ^
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

I agree with this change, but do we have similar situations in QEMU code
elsewhere?

>  hw/mips/gt64xxx_pci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/mips/gt64xxx_pci.c b/hw/mips/gt64xxx_pci.c
> index 815ef0711d..2fa313f498 100644
> --- a/hw/mips/gt64xxx_pci.c
> +++ b/hw/mips/gt64xxx_pci.c
> @@ -23,6 +23,7 @@
>   */
>
>  #include "qemu/osdep.h"
> +#include "qemu/units.h"
>  #include "qemu/log.h"
>  #include "hw/hw.h"
>  #include "hw/mips/mips.h"
> @@ -1201,7 +1202,7 @@ PCIBus *gt64120_register(qemu_irq *pic)
>      dev =3D qdev_create(NULL, TYPE_GT64120_PCI_HOST_BRIDGE);
>      d =3D GT64120_PCI_HOST_BRIDGE(dev);
>      phb =3D PCI_HOST_BRIDGE(dev);
> -    memory_region_init(&d->pci0_mem, OBJECT(dev), "pci0-mem",
UINT32_MAX);
> +    memory_region_init(&d->pci0_mem, OBJECT(dev), "pci0-mem", 4 * GiB);
>      address_space_init(&d->pci0_mem_as, &d->pci0_mem, "pci0-mem");
>      phb->bus =3D pci_register_root_bus(dev, "pci",
>                                       gt64120_pci_set_irq,
gt64120_pci_map_irq,
> --
> 2.19.1
>
>
