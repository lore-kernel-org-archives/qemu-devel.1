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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDF3C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 17:37:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCC0F20776
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 17:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pzJJ/xyW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCC0F20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jddW9-0001I9-VK
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 13:37:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44058)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jddUl-0007sH-HA; Tue, 26 May 2020 13:36:07 -0400
Received: from mail-qv1-xf43.google.com ([2607:f8b0:4864:20::f43]:42098)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jddUk-0004v5-1L; Tue, 26 May 2020 13:36:07 -0400
Received: by mail-qv1-xf43.google.com with SMTP id g20so9819307qvb.9;
 Tue, 26 May 2020 10:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=wZBEHWBN/GWyvAOIWg38QMcm0Xw7UK4cDCEX+YPwHq0=;
 b=pzJJ/xyW0wd2saucqlepyUgN4z1JDgC2AM+XDdjqvZx2CQc/4YgdM+lFQQn9QiPmR1
 H54E7MizTyag7wNOMOTg731pDe+3I6yMrDbeacgA8d0UQ6wYcViHQjFqaGONi+J7gda0
 UrN2u0IP577j+VYICj2Y3LB+8kicuE1fBtxAwVwiUXMp1ZWare8v77DjBK+634DgDdCv
 q1UFkHGLoJ3aitUAZOQ/XZ4iwjPqElPNX9HM0ja+ti7eix8MR6eTepvh/S9Jni749G6r
 jlumnl/GLeDk7IO6Zff57Vv4R6GRwb7EoOsUf7/NQScWl5QuhDZ8FT9hZ7ZgtdbK9kwZ
 WP7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=wZBEHWBN/GWyvAOIWg38QMcm0Xw7UK4cDCEX+YPwHq0=;
 b=M5JgJEP2dYdPEVgbLY26MjCWUvt2RC5pqe40VeUu6WRnQosUX4qhA6+TFHfumZMFxG
 sICn/jC48dfv8haPUtgI/vP9l9azWDt/ntyHH43+T+KrRMn3NpSDuh4LcXm/Z0ZKhMfb
 a4fcpQyT5ktcfDlJt/3pBkIgWjedH83NZ+Dr16uIFfkRiBRFQUBynPZZzllyzg0wEI7I
 UFJOfFVTmlBONka153TrZL0jntteWEkZOgbBSzB9Z+kv5YsHnTl7kV3XVSH2duhO/VoG
 QlSnhVpX5M/LuNVeLMnjCE+02V32lHQnKSn36L02WKUA3yZm6DozPipsiWMqQod5wR5I
 Ewww==
X-Gm-Message-State: AOAM532WhrRGiEUImQsJMJocHaiIs8LCHr+UX6PmFwrdgaYBwVQbl+Fc
 NOmk/5zPNiMnnAM1ysmWEdQ7o8cAPJdIIN/q/Ig=
X-Google-Smtp-Source: ABdhPJyjBJCPHKl/A2sTimW2DEtVY1LvJ83cA22ASjLZyxpsonUwkGTGQUwj8ttfKFIiAOVowT0KuPer2PpQ6xktCbU=
X-Received: by 2002:a0c:a2a2:: with SMTP id g31mr4436671qva.15.1590514563646; 
 Tue, 26 May 2020 10:36:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200526062252.19852-1-f4bug@amsat.org>
 <20200526062252.19852-13-f4bug@amsat.org>
In-Reply-To: <20200526062252.19852-13-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 26 May 2020 10:27:01 -0700
Message-ID: <CAKmqyKNH7F2+9FCFza9FYFyj=xycYxjBmr2tSwdkXZSk5T8vrQ@mail.gmail.com>
Subject: Re: [PATCH 12/14] hw/display/exynos4210_fimd: Use
 qemu_log_mask(GUEST_ERROR)
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::f43;
 envelope-from=alistair23@gmail.com; helo=mail-qv1-xf43.google.com
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

On Mon, May 25, 2020 at 11:34 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
>
> Replace DPRINT_ERROR() by qemu_log_mask(GUEST_ERROR).
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/display/exynos4210_fimd.c | 46 +++++++++++++++++++++++-------------
>  1 file changed, 29 insertions(+), 17 deletions(-)
>
> diff --git a/hw/display/exynos4210_fimd.c b/hw/display/exynos4210_fimd.c
> index 1c0266ce9f..4b7286b7c9 100644
> --- a/hw/display/exynos4210_fimd.c
> +++ b/hw/display/exynos4210_fimd.c
> @@ -31,6 +31,7 @@
>  #include "ui/pixel_ops.h"
>  #include "qemu/bswap.h"
>  #include "qemu/module.h"
> +#include "qemu/log.h"
>
>  /* Debug messages configuration */
>  #define EXYNOS4210_FIMD_DEBUG              0
> @@ -39,20 +40,15 @@
>  #if EXYNOS4210_FIMD_DEBUG =3D=3D 0
>      #define DPRINT_L1(fmt, args...)       do { } while (0)
>      #define DPRINT_L2(fmt, args...)       do { } while (0)
> -    #define DPRINT_ERROR(fmt, args...)    do { } while (0)
>  #elif EXYNOS4210_FIMD_DEBUG =3D=3D 1
>      #define DPRINT_L1(fmt, args...) \
>          do {fprintf(stderr, "QEMU FIMD: "fmt, ## args); } while (0)
>      #define DPRINT_L2(fmt, args...)       do { } while (0)
> -    #define DPRINT_ERROR(fmt, args...)  \
> -        do {fprintf(stderr, "QEMU FIMD ERROR: "fmt, ## args); } while (0=
)
>  #else
>      #define DPRINT_L1(fmt, args...) \
>          do {fprintf(stderr, "QEMU FIMD: "fmt, ## args); } while (0)
>      #define DPRINT_L2(fmt, args...) \
>          do {fprintf(stderr, "QEMU FIMD: "fmt, ## args); } while (0)
> -    #define DPRINT_ERROR(fmt, args...)  \
> -        do {fprintf(stderr, "QEMU FIMD ERROR: "fmt, ## args); } while (0=
)
>  #endif
>
>  #if EXYNOS4210_FIMD_MODE_TRACE =3D=3D 0
> @@ -1108,7 +1104,7 @@ static inline int fimd_get_buffer_id(Exynos4210fimd=
Window *w)
>      case FIMD_WINCON_BUF2_STAT:
>          return 2;
>      default:
> -        DPRINT_ERROR("Non-existent buffer index\n");
> +        qemu_log_mask(LOG_GUEST_ERROR, "FIMD: Non-existent buffer index\=
n");
>          return 0;
>      }
>  }
> @@ -1160,20 +1156,24 @@ static void fimd_update_memory_section(Exynos4210=
fimdState *s, unsigned win)
>
>      if (int128_get64(w->mem_section.size) !=3D w->fb_len ||
>              !memory_region_is_ram(w->mem_section.mr)) {
> -        DPRINT_ERROR("Failed to find window %u framebuffer region\n", wi=
n);
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "FIMD: Failed to find window %u framebuffer region=
\n",
> +                      win);
>          goto error_return;
>      }
>
>      w->host_fb_addr =3D cpu_physical_memory_map(fb_start_addr, &fb_mappe=
d_len,
>                                                false);
>      if (!w->host_fb_addr) {
> -        DPRINT_ERROR("Failed to map window %u framebuffer\n", win);
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "FIMD: Failed to map window %u framebuffer\n", win=
);
>          goto error_return;
>      }
>
>      if (fb_mapped_len !=3D w->fb_len) {
> -        DPRINT_ERROR("Window %u mapped framebuffer length is less then "
> -                "expected\n", win);
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "FIMD: Window %u mapped framebuffer length is less=
 than "
> +                      "expected\n", win);
>          cpu_physical_memory_unmap(w->host_fb_addr, fb_mapped_len, 0, 0);
>          goto error_return;
>      }
> @@ -1490,7 +1490,9 @@ static void exynos4210_fimd_write(void *opaque, hwa=
ddr offset,
>              break;
>          case 3:
>              if (w !=3D 1 && w !=3D 2) {
> -                DPRINT_ERROR("Bad write offset 0x%08x\n", offset);
> +                qemu_log_mask(LOG_GUEST_ERROR,
> +                              "FIMD: Bad write offset 0x%08"HWADDR_PRIx"=
\n",
> +                              offset);
>                  return;
>              }
>              s->window[w].osdsize =3D val;
> @@ -1624,7 +1626,9 @@ static void exynos4210_fimd_write(void *opaque, hwa=
ddr offset,
>          break;
>      case FIMD_VIDW0ADD0_B2 ... FIMD_VIDW4ADD0_B2:
>          if (offset & 0x0004) {
> -            DPRINT_ERROR("bad write offset 0x%08x\n", offset);
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "FIMD: bad write offset 0x%08"HWADDR_PRIx"\n",
> +                          offset);
>              break;
>          }
>          w =3D (offset - FIMD_VIDW0ADD0_B2) >> 3;
> @@ -1638,14 +1642,18 @@ static void exynos4210_fimd_write(void *opaque, h=
waddr offset,
>          break;
>      case FIMD_SHD_ADD0_START ... FIMD_SHD_ADD0_END:
>          if (offset & 0x0004) {
> -            DPRINT_ERROR("bad write offset 0x%08x\n", offset);
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "FIMD: bad write offset 0x%08"HWADDR_PRIx"\n",
> +                          offset);
>              break;
>          }
>          s->window[(offset - FIMD_SHD_ADD0_START) >> 3].shadow_buf_start =
=3D val;
>          break;
>      case FIMD_SHD_ADD1_START ... FIMD_SHD_ADD1_END:
>          if (offset & 0x0004) {
> -            DPRINT_ERROR("bad write offset 0x%08x\n", offset);
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "FIMD: bad write offset 0x%08"HWADDR_PRIx"\n",
> +                          offset);
>              break;
>          }
>          s->window[(offset - FIMD_SHD_ADD1_START) >> 3].shadow_buf_end =
=3D val;
> @@ -1665,7 +1673,8 @@ static void exynos4210_fimd_write(void *opaque, hwa=
ddr offset,
>          s->window[w].palette[i] =3D val;
>          break;
>      default:
> -        DPRINT_ERROR("bad write offset 0x%08x\n", offset);
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "FIMD: bad write offset 0x%08"HWADDR_PRIx"\n", off=
set);
>          break;
>      }
>  }
> @@ -1715,7 +1724,9 @@ static uint64_t exynos4210_fimd_read(void *opaque, =
hwaddr offset,
>              break;
>          case 3:
>              if (w !=3D 1 && w !=3D 2) {
> -                DPRINT_ERROR("bad read offset 0x%08x\n", offset);
> +                qemu_log_mask(LOG_GUEST_ERROR,
> +                              "FIMD: bad read offset 0x%08"HWADDR_PRIx"\=
n",
> +                              offset);
>                  return 0xBAADBAAD;
>              }
>              ret =3D s->window[w].osdsize;
> @@ -1809,7 +1820,8 @@ static uint64_t exynos4210_fimd_read(void *opaque, =
hwaddr offset,
>          return s->window[w].palette[i];
>      }
>
> -    DPRINT_ERROR("bad read offset 0x%08x\n", offset);
> +    qemu_log_mask(LOG_GUEST_ERROR,
> +                  "FIMD: bad read offset 0x%08"HWADDR_PRIx"\n", offset);
>      return 0xBAADBAAD;
>  }
>
> --
> 2.21.3
>
>

