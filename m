Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B295C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 17:16:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C411206DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 17:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqkaVDc+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C411206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsUir-0007SV-C4
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 13:16:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34394)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsUam-00062S-Bv; Mon, 06 Jul 2020 13:07:44 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:40546)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsUak-0007Ot-MY; Mon, 06 Jul 2020 13:07:44 -0400
Received: by mail-io1-xd41.google.com with SMTP id q8so40134950iow.7;
 Mon, 06 Jul 2020 10:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=dBgIVLKA0exdXkprZM6w2CG1AHicJslD0tUu5CxlPMg=;
 b=iqkaVDc+Prmll7W77QI2rjsviIcN5ukUeuzuaQ0p2o0zCEfPG0UufK2FbcqQBNBIWA
 guTgtEdhEKGxejAPHA9tMZmUDN3oLd7C2F0fKRP3owIBf/3tZ11gV8WrZd1M/ig0wQ6V
 kMYCtvlGTOSJe6qG/h8lVqrP3vA+s8CU5gCDC1Wp0auG8Myfi+4wBJ7sve4nUfxtUQa8
 WHp/NFGJDmm4uIEFnPQD7R6ve34GdwcRK7lZxMbn/Dt8nvSuLcJnM1PTi7aYL2e3L8UN
 MvCrzRJl874oVwv+GY8to2rSNjmgWVf0WumbR206I4OuAAVCHdu/C1OKKjCgdQQZOSva
 47bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=dBgIVLKA0exdXkprZM6w2CG1AHicJslD0tUu5CxlPMg=;
 b=Qz3JH6WARzybc9jOdqDYTI+1Fwt3aw8xp/rfVwPzq25lvFbdS13CWaFDxCT9sQuBQW
 lskknUENnrTN+OL4tRXp+R6YUFCCKF04M+4ySP1jQqn3pkIIJFJGqtfd4fMuA6FEnVO4
 pE7//9fcZ1yMQA0m7/3nXXpXTpPWoQspnBAW/2Hh2dgbnRJtXU8sGEo1ll8XxWB+5NfG
 yZf4hlB89wUwgf4QeeKqTfqPWHs/icvfxhSVKpF7ePKyNjATAWB/zgfYr7VBVNYiv8j2
 /kNOH1fgWW8DFwJKWSY3HQ52ui731UjFEGDdB3AEzJp9CW4pG+ZZFJ015a0BzGvny2z6
 6gmA==
X-Gm-Message-State: AOAM530wDQWzlGgaKv15bsd0bi5sMzQIVWJ3XEtE20my9ZZ1bh7SKimm
 6jVZPCnxkoyFh+OXhSAPMqBY4q4P45r6TsjXTtE=
X-Google-Smtp-Source: ABdhPJyw0KmkpT0wW3UGWOxj20T8QI719PAjvFEtTo4fBjXY/b+McPswSyw7q1t1bQm3ES8jp++ekpGyo8FkQ/2mlOY=
X-Received: by 2002:a02:1a06:: with SMTP id 6mr55797272jai.8.1594055261111;
 Mon, 06 Jul 2020 10:07:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200704144943.18292-1-f4bug@amsat.org>
 <20200704144943.18292-12-f4bug@amsat.org>
In-Reply-To: <20200704144943.18292-12-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jul 2020 09:57:54 -0700
Message-ID: <CAKmqyKMYzHasyz0-Fx5tbpzr2_369n7wxkmtSVubCOxPH1BrDQ@mail.gmail.com>
Subject: Re: [PATCH 11/26] hw/usb/hcd-xhci: Add missing header
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

On Sat, Jul 4, 2020 at 7:54 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
>
> This header uses the USBPort type which is forward declared
> by "hw/usb.h".
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/usb/hcd-xhci.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/hw/usb/hcd-xhci.h b/hw/usb/hcd-xhci.h
> index 946af51fc2..8edbdc2c3e 100644
> --- a/hw/usb/hcd-xhci.h
> +++ b/hw/usb/hcd-xhci.h
> @@ -22,6 +22,8 @@
>  #ifndef HW_USB_HCD_XHCI_H
>  #define HW_USB_HCD_XHCI_H
>
> +#include "hw/usb.h"
> +
>  #define TYPE_XHCI "base-xhci"
>  #define TYPE_NEC_XHCI "nec-usb-xhci"
>  #define TYPE_QEMU_XHCI "qemu-xhci"
> --
> 2.21.3
>
>

