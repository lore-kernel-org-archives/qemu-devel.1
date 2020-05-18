Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22690C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:53:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6FF720758
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qIdnZBDY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6FF720758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaj1C-0004tB-2M
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 12:53:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33386)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jaiyR-0000lX-7f; Mon, 18 May 2020 12:50:43 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:46411)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jaiyP-0000p9-Up; Mon, 18 May 2020 12:50:42 -0400
Received: by mail-io1-xd44.google.com with SMTP id j8so11282638iog.13;
 Mon, 18 May 2020 09:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=o8vEbrpZlcHQLGBuKlpKAF+lAa1iujf52jGiLw5n6l0=;
 b=qIdnZBDYuX6GveeKiUKZdJAUvExOJJ9Y8FFVTOA1Uef996vuVt5gQCu6jFaBukmrdE
 7zlm/8/bCEAaGWFiyImVEs76OqwPfnUMXS8qQSI/136okrbBo5gT1SBBdMAOzte/en8x
 a58sNfR0tyJrMAhwPslxx5Bm6A3ZxrZIfckVgmc/CkaUiZTx1VifFDp+KMzRZ45QDGLe
 lKYpnAjJIRKXI+vggnikvE9IwIX2R3waE1CzV7lp2hma+mKw/RfjOsdo9wWZxI6si3SO
 wtUIgeuCNLOgbdZl+oPvFb8p5BzhZeeuioC1MXMJQkZXKVdEPMBNhJPwMgfRdMaCve/h
 mvYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=o8vEbrpZlcHQLGBuKlpKAF+lAa1iujf52jGiLw5n6l0=;
 b=PAFZfC6EgSpiDg8FV8DvMp8+ErNH7nh/3qcZZN30KfiuH8fhY8rqSVex/V82c7Kt4b
 x+P1vmBMn73Gk+UqpgfgrHhmXzapuuy9si3VGH642aTgGhvJRs9c5xANsEMz8YE0lb1u
 frzgy0hSlRgl94s0UQ3mOypYv/C0jNjyd7b5a5IvP46SwFvNgDLcCpcH+Pbo0kqtxQj5
 8NFdcEvDTzybWAgWoDdpyu4E6BBRqJeqmliO3MQ5Y6HGoznMyR9UnE8iPa3rBU7KFXK7
 SuJnEnU6Rx3DpTKCBw0Xu/NYZZN2VOwqqBQKN+tN4DVLL94J97M/0JDn9cA651bZKI2t
 tBRA==
X-Gm-Message-State: AOAM530SsH3MTS4nYkENxU+TzHE9wB4Ry0NmsGcSQ5WqBYehWzj3ECRZ
 rRUe/E8hh9A6EB8YRS+8tWaewlUtgAqpTNCyUEg=
X-Google-Smtp-Source: ABdhPJwlvnjxqHJxT3Np3bKxL4Eljct3vqufMgRWI9WB67gzzAWw0OUXc71x9GEBfuL5NsqFLKoTk68Gb3qzsnJg9Vo=
X-Received: by 2002:a5d:9604:: with SMTP id w4mr15654795iol.105.1589820640032; 
 Mon, 18 May 2020 09:50:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200518140309.5220-1-f4bug@amsat.org>
 <20200518140309.5220-2-f4bug@amsat.org>
In-Reply-To: <20200518140309.5220-2-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 18 May 2020 09:41:47 -0700
Message-ID: <CAKmqyKO7S1Pe7nMN2Tg3V0ptmPEhhvvhGEs9ecrxbB4BusKeJA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] hw/arm/integratorcp: Replace hw_error() by
 qemu_log_mask()
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
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 18, 2020 at 7:03 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> hw_error() calls exit(). This a bit overkill when we can log
> the accesses as unimplemented or guest error.
>
> When fuzzing the devices, we don't want the whole process to
> exit. Replace some hw_error() calls by qemu_log_mask().
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/arm/integratorcp.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
> index 6d69010d06..5fb54e5aa7 100644
> --- a/hw/arm/integratorcp.c
> +++ b/hw/arm/integratorcp.c
> @@ -20,6 +20,7 @@
>  #include "exec/address-spaces.h"
>  #include "sysemu/runstate.h"
>  #include "sysemu/sysemu.h"
> +#include "qemu/log.h"
>  #include "qemu/error-report.h"
>  #include "hw/char/pl011.h"
>  #include "hw/hw.h"
> @@ -144,8 +145,9 @@ static uint64_t integratorcm_read(void *opaque, hwadd=
r offset,
>          /* ??? Voltage control unimplemented.  */
>          return 0;
>      default:
> -        hw_error("integratorcm_read: Unimplemented offset 0x%x\n",
> -                 (int)offset);
> +        qemu_log_mask(LOG_UNIMP,
> +                      "%s: Unimplemented offset 0x%" HWADDR_PRIX "\n",
> +                      __func__, offset);
>          return 0;
>      }
>  }
> @@ -252,8 +254,9 @@ static void integratorcm_write(void *opaque, hwaddr o=
ffset,
>          /* ??? Voltage control unimplemented.  */
>          break;
>      default:
> -        hw_error("integratorcm_write: Unimplemented offset 0x%x\n",
> -                 (int)offset);
> +        qemu_log_mask(LOG_UNIMP,
> +                      "%s: Unimplemented offset 0x%" HWADDR_PRIX "\n",
> +                      __func__, offset);
>          break;
>      }
>  }
> @@ -394,7 +397,8 @@ static uint64_t icp_pic_read(void *opaque, hwaddr off=
set,
>      case 5: /* INT_SOFTCLR */
>      case 11: /* FRQ_ENABLECLR */
>      default:
> -        printf ("icp_pic_read: Bad register offset 0x%x\n", (int)offset)=
;
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIX =
"\n",
> +                      __func__, offset);
>          return 0;
>      }
>  }
> @@ -430,7 +434,8 @@ static void icp_pic_write(void *opaque, hwaddr offset=
,
>      case 8: /* FRQ_STATUS */
>      case 9: /* FRQ_RAWSTAT */
>      default:
> -        printf ("icp_pic_write: Bad register offset 0x%x\n", (int)offset=
);
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIX =
"\n",
> +                      __func__, offset);
>          return;
>      }
>      icp_pic_update(s);
> @@ -504,7 +509,8 @@ static uint64_t icp_control_read(void *opaque, hwaddr=
 offset,
>      case 3: /* CP_DECODE */
>          return 0x11;
>      default:
> -        hw_error("icp_control_read: Bad offset %x\n", (int)offset);
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIX =
"\n",
> +                      __func__, offset);
>          return 0;
>      }
>  }
> @@ -524,7 +530,8 @@ static void icp_control_write(void *opaque, hwaddr of=
fset,
>          /* Nothing interesting implemented yet.  */
>          break;
>      default:
> -        hw_error("icp_control_write: Bad offset %x\n", (int)offset);
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIX =
"\n",
> +                      __func__, offset);
>      }
>  }
>
> --
> 2.21.3
>
>

