Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A99C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 16:15:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58EA120645
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 16:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFKX1k/M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58EA120645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgtXJ-0001gC-5O
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 12:15:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33478)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hgtH9-0008A1-VF
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 11:59:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hgtH8-0004Ed-QH
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 11:58:59 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:46202)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hgtH8-0004Do-IM; Fri, 28 Jun 2019 11:58:58 -0400
Received: by mail-lj1-x243.google.com with SMTP id v24so6473115ljg.13;
 Fri, 28 Jun 2019 08:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=nTecwUNICFBnPJuivHvyec7tJWuxumCuvk8mOqdjk5U=;
 b=CFKX1k/M97Xj0qvxURCC51SzZY9MvohoYs3sQYbtYHhh9xiEXkpGO27VJ0KEH7de6r
 VPhrFEV7//63aeMD2Q4ChA1asPg4b/wt2DruiP51xxAUPP1PuR7HJCfIX3LyiIbe0+mI
 gEV7UwZ0pAQCiJ7VIEifUvcFw7DoGnbBRnsYLSWs0lqyjVC9OAok/AkYMlZr+p8nJwIz
 Qhm5Jg52jAl58CvsZFGICJKJqGFXKTWiSYwfYp5xY+IlUZx0/XxrpplbuSYSQYDeolys
 Rfiv+bCE6jKPvmwBNVlCUs98P99QZCRar6x3YJENDfSh0ykXY7qk9Fg7uW8zQc+jxrPn
 Z7ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=nTecwUNICFBnPJuivHvyec7tJWuxumCuvk8mOqdjk5U=;
 b=dGscM6FH+eExMfDtotOZQDaqHgXQkGX9inSSFsCpy86/XCvKOvI4xWIh3S9SUhoqdp
 Q2WJvvlPF1eB2K9deh29KkOvfjoVZru33jKpAOEQrk/oAezdFuFMJC6m3Bci7Q74lJDZ
 QUFqMnj/kxSN1C8YxTMvPRwBWeVU5a/ylRMNEaVztMPdiSB+Li4QwynV7w6ZS2o4AnoV
 M0kj5CeoSh8MS6gSm0cynHGiglxBqwi0wEhJL4ui53IydVlpWrVEAz1h14JBF3qRaThn
 rz2VNJSecFA9TPGP3NUymmYoELD/7I+kd5Zj9Na+MkOD7/WvGWztvE7Xv0EZKqN0y1Ez
 sjLw==
X-Gm-Message-State: APjAAAUe2NBVutbinrRuC91IlV19iWXFlijBWxEKL97ffG/QaCe9G/WJ
 4IZj+76HewQeQ0L0QgWeirQD0TffHyubTupOqxs=
X-Google-Smtp-Source: APXvYqz7Lco6wbhRaovTv3wWiVBo4Vv3zjgnJjO/aYJr67hI90YxOon3yll691JDmQ1GfkPqtOts/H1q2UdzW1dyBVA=
X-Received: by 2002:a2e:5d5a:: with SMTP id r87mr6648846ljb.196.1561737537434; 
 Fri, 28 Jun 2019 08:58:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190627202719.17739-1-philmd@redhat.com>
 <20190627202719.17739-5-philmd@redhat.com>
In-Reply-To: <20190627202719.17739-5-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 28 Jun 2019 08:55:57 -0700
Message-ID: <CAKmqyKMwbr+FL+B+EH0W7Jpr03hex2i-H7TReyU8oVRA3kRpuQ@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::243
Subject: Re: [Qemu-devel] [PATCH v5 04/28] hw/block/pflash_cfi02: Fix debug
 format string
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
 Stephen Checkoway <stephen.checkoway@oberlin.edu>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Qemu-block <qemu-block@nongnu.org>, John Snow <jsnow@redhat.com>,
 Magnus Damm <magnus.damm@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Antony Pavlov <antonynpavlov@gmail.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 qemu-arm <qemu-arm@nongnu.org>, Jan Kiszka <jan.kiszka@web.de>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Michael Walle <michael@walle.cc>,
 "open list:New World" <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 27, 2019 at 1:36 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Always compile the debug code to prevent format string to bitrot.
> Delete dead code.
>
> Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
> Message-Id: <20190426162624.55977-3-stephen.checkoway@oberlin.edu>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> [PMD: Extracted from bigger patch, use PRIx32]
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/block/pflash_cfi02.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
>
> diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
> index 6cdfc85264..43796e551a 100644
> --- a/hw/block/pflash_cfi02.c
> +++ b/hw/block/pflash_cfi02.c
> @@ -47,15 +47,13 @@
>  #include "hw/sysbus.h"
>  #include "trace.h"
>
> -//#define PFLASH_DEBUG
> -#ifdef PFLASH_DEBUG
> +#define PFLASH_DEBUG false
>  #define DPRINTF(fmt, ...)                                  \
>  do {                                                       \
> -    fprintf(stderr, "PFLASH: " fmt , ## __VA_ARGS__);       \
> +    if (PFLASH_DEBUG) {                                    \
> +        fprintf(stderr, "PFLASH: " fmt, ## __VA_ARGS__);   \
> +    }                                                      \
>  } while (0)
> -#else
> -#define DPRINTF(fmt, ...) do { } while (0)
> -#endif
>
>  #define PFLASH_LAZY_ROMD_THRESHOLD 42
>
> @@ -218,14 +216,14 @@ static uint32_t pflash_read(PFlashCFI02 *pfl, hwadd=
r offset,
>          default:
>              goto flash_read;
>          }
> -        DPRINTF("%s: ID " TARGET_FMT_plx " %x\n", __func__, boff, ret);
> +        DPRINTF("%s: ID " TARGET_FMT_plx " %" PRIx32 "\n", __func__, bof=
f, ret);
>          break;
>      case 0xA0:
>      case 0x10:
>      case 0x30:
>          /* Status register read */
>          ret =3D pfl->status;
> -        DPRINTF("%s: status %x\n", __func__, ret);
> +        DPRINTF("%s: status %" PRIx32 "\n", __func__, ret);
>          /* Toggle bit 6 */
>          pfl->status ^=3D 0x40;
>          break;
> @@ -268,10 +266,6 @@ static void pflash_write(PFlashCFI02 *pfl, hwaddr of=
fset,
>      trace_pflash_io_write(offset, width, width << 1, value, pfl->wcycle)=
;
>      cmd =3D value;
>      if (pfl->cmd !=3D 0xA0 && cmd =3D=3D 0xF0) {
> -#if 0
> -        DPRINTF("%s: flash reset asked (%02x %02x)\n",
> -                __func__, pfl->cmd, cmd);
> -#endif
>          goto reset_flash;
>      }
>      offset &=3D pfl->chip_len - 1;
> --
> 2.20.1
>
>

