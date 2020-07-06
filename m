Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71339C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 17:14:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36930206B6
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 17:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AbJ0ON1q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36930206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsUgz-0003CL-EY
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 13:14:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsUZX-0003BM-Ed; Mon, 06 Jul 2020 13:06:27 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:35227)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsUZR-0007H8-Uj; Mon, 06 Jul 2020 13:06:27 -0400
Received: by mail-il1-x143.google.com with SMTP id t18so13609047ilh.2;
 Mon, 06 Jul 2020 10:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=B6iU2F4D68kBs4rXCTy4j6Bd4sjgaDyabwwjvi+hW5Q=;
 b=AbJ0ON1qWA3F4Bki8vxBgNFCAj9bKw6GWMHnwjy0BHevGWNnPoRZOMJ0S+D6de1dhl
 0hNekgR0AHtFq5mG7yzL9shawGAV2AmKUgYcpgmrhjZljtKHOBACxfNrtufx07HwKaMW
 qPASD8vFzMlW++21+2uuY8a4B3cYDOiH2vcQJdGo42bfb58doT5aEhXx2+lGYg2TladZ
 Ss8z+SOazk9trK61OW/m2u2TWhD4ewrvaWAJWYnZPzMWA25uCSGGgRXWR8mns1NG9zn/
 Ja/0keDaRQdPfssAe8FscZ3h1S+YYXW9ePYnlkmdrTyY7zU1cCrI9V7RI3HBRPxlyq11
 C4uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=B6iU2F4D68kBs4rXCTy4j6Bd4sjgaDyabwwjvi+hW5Q=;
 b=awroqvqC+8c+SUV3KI3qgH/baWahgLHt5OEb5HzMxX8ZAbdweZzsCbtfGgxsxNusRW
 l0ibkXe4s+mc4WifPdXBKRX4dXw8lzEOD5HKSkGePV6NYqI/jt1sHJlbi5DTKLiILIHS
 jc+r8KRmkDAMEbL3WZlLhrRdZRT+eNTppoliuxDdG1sUMCK37MT4O1iiXctBo/9kDLTG
 8+vgiyUahRb2dpleG50CoR8CuwI6w8enSWok98gfLmAAuuWS3Xya8w+ajMAfYcpIV0ql
 BAZtqWrAOhzMhipv7Tt3ocZEyL1+UXDBCqTM/MLcUIPGtZZdYOuuLO5sVGv39N7BgyGp
 W2NQ==
X-Gm-Message-State: AOAM5310al3ivSS7vve7Xyra669jMLqAYccMEgbg3Bek58Zsq4NRZTAH
 mtkn/vvwmvBBjgEbe7FPM7QcuoxWmMs3lJstCmU=
X-Google-Smtp-Source: ABdhPJxcajQAjV3tK1pO3vVESVT/fL33Jteajm7cQ9OrNrxAE/wXmAHw5YAkhAIBWLMGaVi/cTHnOj0BeNWBXTtUiyQ=
X-Received: by 2002:a92:5f12:: with SMTP id t18mr31713705ilb.267.1594055180052; 
 Mon, 06 Jul 2020 10:06:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200704144943.18292-1-f4bug@amsat.org>
 <20200704144943.18292-10-f4bug@amsat.org>
In-Reply-To: <20200704144943.18292-10-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jul 2020 09:56:33 -0700
Message-ID: <CAKmqyKMivQ6HxaB9DmJ1EgWcpC0sD1VBOC=V_09if_kkcvEwcA@mail.gmail.com>
Subject: Re: [PATCH 09/26] hw/usb/hcd-ehci: Remove unnecessary include
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

On Sat, Jul 4, 2020 at 7:55 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
>
> As "qemu/main-loop.h" is not used, remove it.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/usb/hcd-ehci.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
> index 1495e8f7fa..256fb91e0c 100644
> --- a/hw/usb/hcd-ehci.c
> +++ b/hw/usb/hcd-ehci.c
> @@ -34,7 +34,6 @@
>  #include "migration/vmstate.h"
>  #include "trace.h"
>  #include "qemu/error-report.h"
> -#include "qemu/main-loop.h"
>  #include "sysemu/runstate.h"
>
>  #define FRAME_TIMER_FREQ 1000
> --
> 2.21.3
>
>

