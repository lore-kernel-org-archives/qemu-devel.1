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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00AAC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 16:55:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEF0320776
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 16:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WH1Iy3+H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEF0320776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdcrp-000079-WD
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 12:55:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47884)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jdcki-0005A3-81; Tue, 26 May 2020 12:48:32 -0400
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:40724)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jdckh-00070P-1S; Tue, 26 May 2020 12:48:31 -0400
Received: by mail-il1-x142.google.com with SMTP id a18so3871230ilp.7;
 Tue, 26 May 2020 09:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=cI2kBYN4v92zgki8aIm+KltLVDl7Q7AyJhU1Q/w/19I=;
 b=WH1Iy3+HM6GY0QWzvBllseWDzwXzXwH0BylC7P+OrrzTzKwlb0U0RKhkZ4hqdFNVv4
 7CE1CI6eAPJ68XfxUtCdeaJ5H80YGfoAumQQmLUjwMZdVQltnK+xtwi8jHO/eLXLkEfr
 hPnpNpEvfBobhfrau36aU1Mp5baX4u5gY2M3pKgHgzoV8aCWzIoort4z7FecQdXxf4L8
 u5uW3N8+ZEatBbiJM0Y+6l23/u+WuXNYhKduqoREIDel1TXf6AXhST7YMCxZUoLOy2Lo
 TUBJfw4T0jlRTLPI79WLkSjKRjz+7+n9YPMRIXW9x00o4L/Xgbgpoo1h/etI+FOdcdLj
 cMtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=cI2kBYN4v92zgki8aIm+KltLVDl7Q7AyJhU1Q/w/19I=;
 b=aWOFDSsMrq6bcK+M0iDcE9m1gu9QY97tbkXd4eNdK0rqNYtDPlwG5hrYhWxPq4/Z3q
 Yyy6OhqvfVBYS11ZWy8FB5OR6wTnIGtVfE/1NRCeLmMiS+HkwI8Dp/Olz2X3vvZ3Og3/
 UgX1xs82bTpBBYe2mj7gZ8wCQiQGWGm4fVb2uRgNdzewHWfsyIqS91oVB26ysnEgH9lo
 LNXCwEfPgOx7aYsE7X4v3OLKRWAu1rhFe2SY7efHM1QXNBn5zYnSg4XtLO3RoqlB+rnZ
 cM+mvdn/4XL82z//WUORf0pV09Z1vkFFqJ6LsaDDoCJf8qSbx0+MqiOIfkcU2/kHj+70
 HjsA==
X-Gm-Message-State: AOAM530bm6ftlOMh4E90BV8h1W76JMxUoqcffOPaFUmFqg8k2lcoXPna
 a6BsBYYf4tYaFzp8rIT2K1dik9DXZJmGFVCkVG8=
X-Google-Smtp-Source: ABdhPJxQHi27S2/M/o+cjyhHVWaU8HxASjseal0bsvr5rADvxOkGgEt2gEOtsiC3oMS6B9YTdTnvdTvzXFxkWGYwhjY=
X-Received: by 2002:a92:48d1:: with SMTP id j78mr2059806ilg.131.1590511708940; 
 Tue, 26 May 2020 09:48:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200525034459.28535-1-f4bug@amsat.org>
 <20200525034459.28535-4-f4bug@amsat.org>
In-Reply-To: <20200525034459.28535-4-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 26 May 2020 09:39:30 -0700
Message-ID: <CAKmqyKM=i6jp6y023ExLztqTeg6dc+O5Rv05_tYcCYi48E1-pA@mail.gmail.com>
Subject: Re: [PATCH 3/4] hw/display/dpcd: Convert debug printf()s to trace
 events
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::142;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x142.google.com
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
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, May 24, 2020 at 8:46 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> Convert DPRINTF() to trace events and remove ifdef'ry.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/display/dpcd.c       | 16 +++-------------
>  hw/display/trace-events |  4 ++++
>  2 files changed, 7 insertions(+), 13 deletions(-)
>
> diff --git a/hw/display/dpcd.c b/hw/display/dpcd.c
> index 0c1b7b35fb..64463654a1 100644
> --- a/hw/display/dpcd.c
> +++ b/hw/display/dpcd.c
> @@ -32,16 +32,7 @@
>  #include "hw/misc/auxbus.h"
>  #include "migration/vmstate.h"
>  #include "hw/display/dpcd.h"
> -
> -#ifndef DEBUG_DPCD
> -#define DEBUG_DPCD 0
> -#endif
> -
> -#define DPRINTF(fmt, ...) do {                                          =
       \
> -    if (DEBUG_DPCD) {                                                   =
       \
> -        qemu_log("dpcd: " fmt, ## __VA_ARGS__);                         =
       \
> -    }                                                                   =
       \
> -} while (0)
> +#include "trace.h"
>
>  #define DPCD_READABLE_AREA                      0x600
>
> @@ -70,8 +61,8 @@ static uint64_t dpcd_read(void *opaque, hwaddr offset, =
unsigned size)
>                                         offset);
>          ret =3D 0;
>      }
> +    trace_dpcd_read(offset, ret);
>
> -    DPRINTF("read 0x%" PRIX8 " @0x%" HWADDR_PRIX "\n", ret, offset);
>      return ret;
>  }
>
> @@ -80,8 +71,7 @@ static void dpcd_write(void *opaque, hwaddr offset, uin=
t64_t value,
>  {
>      DPCDState *e =3D DPCD(opaque);
>
> -    DPRINTF("write 0x%" PRIX8 " @0x%" HWADDR_PRIX "\n", (uint8_t)value, =
offset);
> -
> +    trace_dpcd_write(offset, value);
>      if (offset < DPCD_READABLE_AREA) {
>          e->dpcd_info[offset] =3D value;
>      } else {
> diff --git a/hw/display/trace-events b/hw/display/trace-events
> index e6e22bef88..00543f1601 100644
> --- a/hw/display/trace-events
> +++ b/hw/display/trace-events
> @@ -151,3 +151,7 @@ artist_vram_write(unsigned int size, uint64_t addr, u=
int64_t val) "%u 0x%"PRIx64
>  artist_fill_window(unsigned int start_x, unsigned int start_y, unsigned =
int width, unsigned int height, uint32_t op, uint32_t ctlpln) "start=3D%ux%=
u length=3D%ux%u op=3D0x%08x ctlpln=3D0x%08x"
>  artist_block_move(unsigned int start_x, unsigned int start_y, unsigned i=
nt dest_x, unsigned int dest_y, unsigned int width, unsigned int height) "s=
ource %ux%u -> dest %ux%u size %ux%u"
>  artist_draw_line(unsigned int start_x, unsigned int start_y, unsigned in=
t end_x, unsigned int end_y) "%ux%u %ux%u"
> +
> +# dpcd.c
> +dpcd_read(uint32_t addr, uint8_t val) "read addr:0x%"PRIx32" val:0x%02x"
> +dpcd_write(uint32_t addr, uint8_t val) "write addr:0x%"PRIx32" val:0x%02=
x"
> --
> 2.21.3
>
>

