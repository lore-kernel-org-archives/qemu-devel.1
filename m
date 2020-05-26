Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DF1C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 16:55:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D0E820776
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 16:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jheA7ja9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D0E820776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdcrm-0008Q9-Hc
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 12:55:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51442)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jdco8-00024J-M6; Tue, 26 May 2020 12:52:04 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:46973)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jdco6-0000m8-Ov; Tue, 26 May 2020 12:52:03 -0400
Received: by mail-io1-xd41.google.com with SMTP id j8so22723257iog.13;
 Tue, 26 May 2020 09:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=wogobYdgA7pdWEUiow9y+BbE4SrJpOahPEjnfmC9ss0=;
 b=jheA7ja9yxFsNrUeovavT8+NzngQH/J+PJ4kuh0t/fwMH3SYb7nkLNyudNtVldLNNG
 eoXiq06CtQJ3uxyzvV7NyH0N4JoqlcLnh6vWkJrTiNrLgNheyz7gP8R0shM89QDbtw8p
 JZUjizEJni0l4y29EpjSrqEqzOExoJi634eEtOXK+9pty7OITgNGpiG5Njr+V5wn3Ry5
 LUxNVYgx6wx+92PYH/nfCF7INVc2/A2sARyBanCkXDNPf/YA4jgAjgZwE5TLFKt6dvr/
 2dGc0B+aWkRbqkeM0yEc0gIlX8XwbYOB1Vb1c/7zNZNbnr7PEu7PeYRjx5CfWXvGsEvI
 K1Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=wogobYdgA7pdWEUiow9y+BbE4SrJpOahPEjnfmC9ss0=;
 b=CQdEyb2BmSYeFi0aoF4/Zpd0L2m/DQJwV0ZDHw3j9x7XWiC9AppndmTJGB8OrVjsjh
 e+105rY3Shc2Uuy+Om6vijqDX0+W/RHmgpb/MJMUy8on51uuodI0F5zj5WlBUXlWAkSf
 7iqNNeTlTvzEpezg+ojij8y0cN5oUnnLmpzb2SY8RsByEaw060Or+p070vArXcwxZKuU
 pbj+0pYf2mvCFseimZXbfFhB3jbtnF+yw+qbcoZriRre0YlLj8qxRFKUyKO0gBfF6XGU
 3/VZXSCZ3Toloisz+IQASvG9TXnnTTYvNicLxiLZoWJEoolw0eUIS6WBe94Hfbcgt8Y0
 qD4A==
X-Gm-Message-State: AOAM5339RCJddAREkCFztbzLr1AMND+aOpG9zlyXKjERQHwAJv+YhFeH
 IVBJq89Yvcvw1BFY7ka9nsY9jR2JVHpKkGiBB6w=
X-Google-Smtp-Source: ABdhPJwG6bLuMi57LOOhtuFM7Cd+Y8FlPRKN7hczqoZy/Qg+bhnVHVNLF7Y1r4RMiuDna+oMVFZgZrmdvQFR8GxrUj4=
X-Received: by 2002:a02:7009:: with SMTP id f9mr1962296jac.8.1590511920816;
 Tue, 26 May 2020 09:52:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200526062252.19852-1-f4bug@amsat.org>
 <20200526062252.19852-5-f4bug@amsat.org>
In-Reply-To: <20200526062252.19852-5-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 26 May 2020 09:42:56 -0700
Message-ID: <CAKmqyKOc=Zs0VA-_BKDsrG__RXtgcM7JR8cwsNsd8RNr9VKVgA@mail.gmail.com>
Subject: Re: [PATCH 04/14] hw/display/cirrus_vga: Use qemu_log_mask(UNIMP)
 instead of debug printf
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 QEMU Trivial <qemu-trivial@nongnu.org>,
 Alistair Francis <alistair@alistair23.me>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 25, 2020 at 11:25 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
>
> Replace some debug printf() calls by qemu_log_mask(LOG_UNIMP),
> and add a new one in cirrus_linear_bitblt_read().
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/display/cirrus_vga.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
> index 33ccdde000..f9f837b850 100644
> --- a/hw/display/cirrus_vga.c
> +++ b/hw/display/cirrus_vga.c
> @@ -35,6 +35,7 @@
>  #include "qemu/osdep.h"
>  #include "qemu/module.h"
>  #include "qemu/units.h"
> +#include "qemu/log.h"
>  #include "sysemu/reset.h"
>  #include "qapi/error.h"
>  #include "trace.h"
> @@ -905,9 +906,8 @@ static int cirrus_bitblt_cputovideo(CirrusVGAState * =
s)
>  static int cirrus_bitblt_videotocpu(CirrusVGAState * s)
>  {
>      /* XXX */
> -#ifdef DEBUG_BITBLT
> -    printf("cirrus: bitblt (video to cpu) is not implemented yet\n");
> -#endif
> +    qemu_log_mask(LOG_UNIMP,
> +                  "cirrus: bitblt (video to cpu) is not implemented\n");
>      return 0;
>  }
>
> @@ -989,9 +989,8 @@ static void cirrus_bitblt_start(CirrusVGAState * s)
>          cirrus_blt_mode & (CIRRUS_BLTMODE_MEMSYSSRC |
>                             CIRRUS_BLTMODE_MEMSYSDEST))
>         =3D=3D (CIRRUS_BLTMODE_MEMSYSSRC | CIRRUS_BLTMODE_MEMSYSDEST)) {
> -#ifdef DEBUG_BITBLT
> -       printf("cirrus: bitblt - memory-to-memory copy is requested\n");
> -#endif
> +        qemu_log_mask(LOG_UNIMP,
> +                      "cirrus: bitblt - memory-to-memory copy requested\=
n");
>         goto bitblt_ignore;
>      }
>
> @@ -2412,6 +2411,9 @@ static uint64_t cirrus_linear_bitblt_read(void *opa=
que,
>
>      /* XXX handle bitblt */
>      (void)s;
> +    qemu_log_mask(LOG_UNIMP,
> +                  "cirrus: linear bitblt is not implemented\n");
> +
>      return 0xff;
>  }
>
> --
> 2.21.3
>
>

