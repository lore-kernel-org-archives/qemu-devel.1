Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A1EBC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 17:23:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 069462070C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 17:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fK2rUb2M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 069462070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsUqD-0005DL-A7
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 13:23:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60732)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsUSR-0005r4-M2; Mon, 06 Jul 2020 12:59:07 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:43288)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsUSM-0005oU-8T; Mon, 06 Jul 2020 12:59:07 -0400
Received: by mail-io1-xd41.google.com with SMTP id k23so40040661iom.10;
 Mon, 06 Jul 2020 09:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=FXnnv73L5WipvrjnAQ/ZRDtg+5iLp60OiInY9J0Zsfs=;
 b=fK2rUb2MdciYU4Z+vy8DaVGveUMlo9HFcBrc2ZvwhMG/OTSUYi16woJ2geJIOeCHf+
 s/tu4UZiATsSlkJBZD2mo3pornyf9G2RKM8kkgfjb7neQY+BTo9GGZ9L3v3UwKSUzApe
 89qSSXu30fk4x/9gPjbYtny2dhJQctl8b9Lrmn4gsXAE9hmlLHVRcYlZiDw+zMWXKhiT
 WJsFHIKj5Bhm1NoNyZFlGdsqEUXmX9z2x7FAgTnWrhAmBppFMg16jLsf48EcsdQ3N9Ln
 BfooAlKZ7UjPxtmAAZt8fESX0cQByDrugScyx/bxh9+zbshTBMAtPKfqON37hfLVY3Rb
 eq2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=FXnnv73L5WipvrjnAQ/ZRDtg+5iLp60OiInY9J0Zsfs=;
 b=Ac9ShVJVVUD8rxlndKw6nz9LNuM1pkLp2aHpLlNBTPKbOgIvyPMiV3zGaw8QV7/OLS
 lfWeEAAXtxppY46AgAPYDTvyoF76XQliPmrQWdV3AqqtmpvNLP4tYTSTj9wzm/mIizoX
 wDZvcV3dNZ00OQbDlVxPqJdEwlzUq1ZrmHMLsBzDfdwfHtgyJIFd2KFCMJ3tiNhD+vm3
 6aR37ziv6qnitVTEgb/NvXGgQAMc8oREo4LNCbtFWGNMsLvtOdhpkrTpapsWgDDh46lT
 EjZKHpj0H2/bT1/SKOk0vLMwfZqFKJM+ahrSMxUS1EM+vzVzFxPr47jpPG626xuwLXYK
 8TXw==
X-Gm-Message-State: AOAM5334vMkdoSjBaPMqvnn/m2P8OaKj5hULhhqG85+vU4A3N6rLHaFJ
 MzQD0PgdEkCtdjKs+K1HidlHuH99mRhqHSGFiEU=
X-Google-Smtp-Source: ABdhPJxhPOyzA8S179T/GnN+DxKn3yFpd4iuIOBEQ6BWF7TH4kkJEHUUUSyuyppt2TvByxifRjL0bvuZRvWhnh0C+Tc=
X-Received: by 2002:a02:10c1:: with SMTP id 184mr52996773jay.135.1594054740444; 
 Mon, 06 Jul 2020 09:59:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200704144943.18292-1-f4bug@amsat.org>
 <20200704144943.18292-2-f4bug@amsat.org>
In-Reply-To: <20200704144943.18292-2-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jul 2020 09:49:12 -0700
Message-ID: <CAKmqyKNd3qyB33TCamM_zXPFahfvdpmCirouODOy_QFotz55EQ@mail.gmail.com>
Subject: Re: [PATCH 01/26] hw/arm/sbsa-ref: Remove unused 'hw/usb.h' header
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd41.google.com
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

On Sat, Jul 4, 2020 at 7:51 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
>
> This file doesn't access anything from "hw/usb.h", remove its
> inclusion.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/arm/sbsa-ref.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> index e40c868a82..021e7c1b8b 100644
> --- a/hw/arm/sbsa-ref.c
> +++ b/hw/arm/sbsa-ref.c
> @@ -38,7 +38,6 @@
>  #include "hw/loader.h"
>  #include "hw/pci-host/gpex.h"
>  #include "hw/qdev-properties.h"
> -#include "hw/usb.h"
>  #include "hw/char/pl011.h"
>  #include "net/net.h"
>
> --
> 2.21.3
>
>

