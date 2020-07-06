Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BF0C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 17:11:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACD9C206B6
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 17:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eegBASf0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACD9C206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsUea-0005Ip-VU
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 13:11:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33972)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsUYK-0000Xr-Pt; Mon, 06 Jul 2020 13:05:12 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:40516)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsUYJ-00070N-3W; Mon, 06 Jul 2020 13:05:12 -0400
Received: by mail-io1-xd41.google.com with SMTP id q8so40125815iow.7;
 Mon, 06 Jul 2020 10:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=zN9P5ColTvlUfdn83p6hlM/q3HmA739CHt0AXxAEsKY=;
 b=eegBASf0DJgvBsiQJhBbGe04hBG8gQlnhR0e1R/ASVwj2VHV9vGLfcRsCN4KCZZL7R
 B83BaGMH/iF7mwFtkqNwrhcYBoLeuRgJhTM45CYuhyfzNTru1stzx/37r5EW7OhPb+Sh
 LRtrqRylWajXgEByi9cOTijxoLbDMEMhICnRVbAOOwJLu9jPbF/Te8Qvau7kveunJewl
 Db0lsTutmvoozzVPB+KFbn17OIYLS5FptsgdKB52Bz3rn1GjOosdN0j2cy5W6T6sYt0p
 QdMaqFdSvbzvnq0BKJyMWcewvVfyBSesh4A14gyVGvYTOfgkCHZ+MscaMJTp0T9VOAKa
 WAHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=zN9P5ColTvlUfdn83p6hlM/q3HmA739CHt0AXxAEsKY=;
 b=gSZPeOHoGAi+1J9hCYQUV+BQGojLm8PxynrAPnK2pmyGHO8Jun+E5AQEtLcV1rFO5g
 gfPkOnCh3JbUo/syPFH9gq3oYwEJ1JhlKmK6Dri0M6w9wzJjAQAOE5/QNlZpfcYOQsrI
 jO9jou+s/4O4lBx8c60dEzKbhqmIl0KIFtgiYsR0jT/qSlen+UMzfJS5GzetfxPyPdzv
 a52tJyKD79zdfu/tzTVCKHzd8P14/I+T8+cg75SXZwj56dHunRCqlbe2EMjvQy3Ze8ly
 sOW34UpzP6g/hjlWY3BU/sCOQutyAIUfMM+LzUIKqOJAzg4FNyE4BaqSKEx1vn+q2dKa
 6uag==
X-Gm-Message-State: AOAM531pUTqRCWI3bMgebHOx3JPNlq0nEOb46qW/fp73KKhItMIlMqQQ
 fLlVgais/l2c9bPuzZqT8idvP2uTP/OP/Q03tlk=
X-Google-Smtp-Source: ABdhPJw8hZ3hkrezlrBZ0tGzIowHRnJHp8TQNjhIxHPipZ6z7o2IrpAbgPHKaESP7cYXHZCW69GaN6F/KxK5+BYwjZc=
X-Received: by 2002:a5d:9ed0:: with SMTP id a16mr26251024ioe.176.1594055109583; 
 Mon, 06 Jul 2020 10:05:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200704144943.18292-1-f4bug@amsat.org>
 <20200704144943.18292-6-f4bug@amsat.org>
In-Reply-To: <20200704144943.18292-6-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jul 2020 09:55:22 -0700
Message-ID: <CAKmqyKMW3Db-bk1+MOtz461-iAy9Se4uq=2stNmgiELzVAd3NA@mail.gmail.com>
Subject: Re: [PATCH 05/26] hw/usb/desc: Add missing header
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

On Sat, Jul 4, 2020 at 7:52 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
>
> This header uses the USBPacket and USBDevice types which are
> forward declared in "hw/usb.h".
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/usb/desc.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/usb/desc.h b/hw/usb/desc.h
> index 4d81c68e0e..92594fbe29 100644
> --- a/hw/usb/desc.h
> +++ b/hw/usb/desc.h
> @@ -2,6 +2,7 @@
>  #define QEMU_HW_USB_DESC_H
>
>  #include <wchar.h>
> +#include "hw/usb.h"
>
>  /* binary representation */
>  typedef struct USBDescriptor {
> --
> 2.21.3
>
>

