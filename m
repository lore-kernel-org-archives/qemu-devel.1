Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C973DC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 01:03:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97C2A2073E
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 01:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7kFGLGR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97C2A2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqR9i-0004RG-RD
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 21:03:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41450)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jqR8c-0003YS-LY; Tue, 30 Jun 2020 21:02:10 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:36272)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jqR8b-00028G-0D; Tue, 30 Jun 2020 21:02:10 -0400
Received: by mail-io1-xd42.google.com with SMTP id y2so23174099ioy.3;
 Tue, 30 Jun 2020 18:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Q+ANy+tmYn8jGdx2J/ZJza45S2FkoMYyR2K9DYPm68s=;
 b=I7kFGLGRN5mXupkJOQSw0Dn8DW+LrztFQYk6ZqOeh/GFg++gwQkJXnP4ZbCzzoX0eT
 IYmWMeft8sJWHcMYHelb5SmBeMKR8DjlVIcyC/0uTI9e+Qx0VCsObNUIYxvs6xqwfctR
 CR8fxFORHu7bw/LkxyMddSUbJyzx77FbaOXHvxKfvPMpQU9VlD3YF2JK9Ta4oT3A5uU8
 98S723BpzEoDnWivFeDXaRFKLPp1FSvpnk50jmmJ9s3KHqwojz44+6wfEYwpX5OJrAa8
 cfGnAiDsOvhWDIceuEJ393cCBpNezD9uaswaycmymVC6Ov0xLjitUFdQA2em2tmBQ5+P
 3YcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Q+ANy+tmYn8jGdx2J/ZJza45S2FkoMYyR2K9DYPm68s=;
 b=KVIrA7EQzK/+jgqBSvZHN6kFWL04OhPecgyK8bWSZkj8xXCjWLOWndGQfbKwTGDzMv
 aesmSFFgHMtp9eUDS634y2t6lxcfwb4fFcHgaTjX2/PrDBk+RDp+oUjREHo6bWrJo3N8
 i3OKOW9I1uWrVe9hStC0aunHVz7OWaAvOAXOwfHwsOCocNVMOmrDLFZD0EyHLwb7jDVD
 PIq/4pjp6xiJNPyHpGQ/KSF0/xnjTbpcpjAazP24xkxoZTbAjzpeByrsAOT36EkyyB/W
 IvztBkNt0FiW0P3iddX/qyEsRkR8Xk/6d7hCesirZPnzGMyTiapQRtBKvk6SvEzI8ap0
 kZSg==
X-Gm-Message-State: AOAM530LFHJHr/gfwrAqExLGOH4vIXVmL2MSj8N5Jh2LJw4As+kC2We8
 uHgmhMIWtQNpWOB+aoELCVLWhGVcZIqYvrZz13Q=
X-Google-Smtp-Source: ABdhPJwoaXkRS5GeV6Q/0SNGNicWnHNMNnbSCdHzxPJvDhWDd8iBtf32OrOdHKWLdkYsdQZwFCLZNkkQhzdlt4FMSYM=
X-Received: by 2002:a5d:97d9:: with SMTP id k25mr8934457ios.42.1593565327691; 
 Tue, 30 Jun 2020 18:02:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200628142429.17111-1-peter.maydell@linaro.org>
 <20200628142429.17111-15-peter.maydell@linaro.org>
In-Reply-To: <20200628142429.17111-15-peter.maydell@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 30 Jun 2020 17:52:23 -0700
Message-ID: <CAKmqyKNgg20MHE_qo+49b67gR-3NncWHntH+kWXHqsqEKK81dw@mail.gmail.com>
Subject: Re: [PATCH 14/17] hw/arm/spitz: Use LOG_GUEST_ERROR for bad guest
 register accesses
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <alistair@alistair23.me>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Jun 28, 2020 at 7:33 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Instead of logging guest accesses to invalid register offsets in the
> Spitz flash device with zaurus_printf() (which just prints to stderr),
> use the usual qemu_log_mask(LOG_GUEST_ERROR,...).
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/arm/spitz.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/hw/arm/spitz.c b/hw/arm/spitz.c
> index 6eb46869157..49eae3fce4e 100644
> --- a/hw/arm/spitz.c
> +++ b/hw/arm/spitz.c
> @@ -23,6 +23,7 @@
>  #include "hw/ssi/ssi.h"
>  #include "hw/block/flash.h"
>  #include "qemu/timer.h"
> +#include "qemu/log.h"
>  #include "hw/arm/sharpsl.h"
>  #include "ui/console.h"
>  #include "hw/audio/wm8750.h"
> @@ -65,9 +66,6 @@ typedef struct {
>  #define zaurus_printf(format, ...)                              \
>      fprintf(stderr, "%s: " format, __func__, ##__VA_ARGS__)
>
> -#undef REG_FMT
> -#define REG_FMT                         "0x%02lx"
> -
>  /* Spitz Flash */
>  #define FLASH_BASE              0x0c000000
>  #define FLASH_ECCLPLB           0x00    /* Line parity 7 - 0 bit */
> @@ -137,7 +135,9 @@ static uint64_t sl_read(void *opaque, hwaddr addr, unsigned size)
>          return ecc_digest(&s->ecc, nand_getio(s->nand));
>
>      default:
> -        zaurus_printf("Bad register offset " REG_FMT "\n", (unsigned long)addr);
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "sl_read: bad register offset 0x%02" HWADDR_PRIx "\n",
> +                      addr);
>      }
>      return 0;
>  }
> @@ -168,7 +168,9 @@ static void sl_write(void *opaque, hwaddr addr,
>          break;
>
>      default:
> -        zaurus_printf("Bad register offset " REG_FMT "\n", (unsigned long)addr);
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "sl_write: bad register offset 0x%02" HWADDR_PRIx "\n",
> +                      addr);
>      }
>  }
>
> --
> 2.20.1
>
>

