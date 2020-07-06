Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2D0C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 17:29:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B65C52070C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 17:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MioVaGq1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B65C52070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsUvb-00044X-22
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 13:29:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33384)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsUVb-0002EQ-O7; Mon, 06 Jul 2020 13:02:23 -0400
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:44779)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsUVZ-0006a2-UJ; Mon, 06 Jul 2020 13:02:23 -0400
Received: by mail-il1-x141.google.com with SMTP id h16so10189564ilj.11;
 Mon, 06 Jul 2020 10:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=SURriqbHZVXTTwsvXZaGt8gxbHhNclYTbkHoMvIQmpM=;
 b=MioVaGq1jCalxgWYpPdotTkyVsAMeK/bshk85fNYAhYubO4nVFHSOeCUz0kSho8p9p
 6Y83qIJELSpr9VN9VFzq+lTIUscnBNyLwqUC24IyYDjx/4cG7EfaP2YEZc6BAomYyDpg
 4WJqsPVXOVt3XY2x1ZsaQLbg24wvg5Vy/7YqNFE+T3a7KXvhOx34JOs9fSXv1n/wrIC6
 8CzhLDbRxujPAE056QBW2Z/dWImCVitmNebYDtS6btqpo7FzR6vkHFi2ue676ojVEt9W
 vkRi2J6vudadAMoruzF52cpovO1cMqBkDNoVdP47mEGcUSBlNOyPMoeOEOsRimXSU/ZU
 vZxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=SURriqbHZVXTTwsvXZaGt8gxbHhNclYTbkHoMvIQmpM=;
 b=rU5wTaR/pZA9HUFdWbrwkwEN+hURz1bQPM5qUChxwkMWGvuJyvUNWugiOu1oFWO55Y
 /G5uW1VoRTDpuzdkzcsbzLR4eW1hWHUuhOcxb5Ws1wkwPRGP/tEEqyqrtPthogP9Yd6a
 t95DT8NQFgChR7Ev+/BTcRGqQD3NmzuOH00PH/Dm1sHNyFiG59uEcNW2br5LA1ogUxmv
 gtji8PCpaekWSBsQUTqg8J6rpobs+zGjTyL9gi/KtwP/UCBlVC5aRgqZu7JNJ1jNchrQ
 BRkqy6ktQ1BxJv21myCFWVJU6CzmlwIE00ei/luVq7/dFXFrWJRsqWyt9XrVib/TVej3
 x06g==
X-Gm-Message-State: AOAM533SVmsIgQ4JllIU0rX7ViKHnrgJLj7WToaN6ez7g+oT7pCIbcXi
 HVF8Md/sRNjN/cVLnOKHohlVmw+YTVPsCKSUmRA=
X-Google-Smtp-Source: ABdhPJw3irY14ekgg5HFZwY3uijUbo8j99jRr5i12obU9BK983EmEFW1tqXdt4MQ3PGmM1qTVFVUGr89GwGbxSSoFdg=
X-Received: by 2002:a92:d186:: with SMTP id z6mr33254547ilz.227.1594054940213; 
 Mon, 06 Jul 2020 10:02:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200704144943.18292-1-f4bug@amsat.org>
 <20200704144943.18292-5-f4bug@amsat.org>
In-Reply-To: <20200704144943.18292-5-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jul 2020 09:52:26 -0700
Message-ID: <CAKmqyKMm2xhgxSqX5mHAkELfBnWhzqw-ruf3oATFvB8sohnw2w@mail.gmail.com>
Subject: Re: [PATCH 04/26] hw/usb: Reduce 'exec/memory.h' inclusion
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::141;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x141.google.com
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
> "exec/memory.h" is only required by "hw/usb/hcd-musb.h".
> Include it there directly.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  include/hw/usb.h          | 1 -
>  include/hw/usb/hcd-musb.h | 2 ++
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/hw/usb.h b/include/hw/usb.h
> index 4f04a1a879..15b2ef300a 100644
> --- a/include/hw/usb.h
> +++ b/include/hw/usb.h
> @@ -25,7 +25,6 @@
>   * THE SOFTWARE.
>   */
>
> -#include "exec/memory.h"
>  #include "hw/qdev-core.h"
>  #include "qemu/iov.h"
>  #include "qemu/queue.h"
> diff --git a/include/hw/usb/hcd-musb.h b/include/hw/usb/hcd-musb.h
> index c874b9f292..ec3ee5c4b0 100644
> --- a/include/hw/usb/hcd-musb.h
> +++ b/include/hw/usb/hcd-musb.h
> @@ -13,6 +13,8 @@
>  #ifndef HW_USB_MUSB_H
>  #define HW_USB_MUSB_H
>
> +#include "exec/memory.h"
> +
>  enum musb_irq_source_e {
>      musb_irq_suspend =3D 0,
>      musb_irq_resume,
> --
> 2.21.3
>
>

