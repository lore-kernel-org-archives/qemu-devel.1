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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B9FC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 17:37:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B47D82084C
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 17:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbyFaROV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B47D82084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jddVh-0000Qx-Qe
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 13:37:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jddRO-00035P-Ug; Tue, 26 May 2020 13:32:38 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:40598)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jddRN-0001Ki-Bo; Tue, 26 May 2020 13:32:38 -0400
Received: by mail-qk1-x741.google.com with SMTP id c185so7337194qke.7;
 Tue, 26 May 2020 10:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=9TQk01LXu77Qb/2MeYsij309PkMXZLEcP4/iGwIEKpQ=;
 b=NbyFaROVHFJvx2ICUP1UEIeCigwWBnhxDOj0rcqPq3L+y5GofiFCWhH6bacKg1R0Ix
 k7SeIB+2eysZoA90xB7U4lFQmEkdFCVk5hBejcpFrEwUJ0QGDaSVSdapcx4C+CZcoD0M
 7JCM2tWdeHCeOLFfkOPN3k92bp1W4LR1c9V+Dz6Wnja9Uvnu42NVlZZ52F0UZZH+X1v1
 PTev0JL7Wa5NDIAF/3uXEb00L+ErhgLeFPzYI3Qa38GUL0Hw3MC3zlKisvYM49/m7FcH
 iyNoh3LCbY/9GeK21zpSykEK5GjGvGpq/f243KDDrapkhTuQlC2UHEhzqdo3tuXi4qFG
 02Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=9TQk01LXu77Qb/2MeYsij309PkMXZLEcP4/iGwIEKpQ=;
 b=fnz0Ofie7p1pzs5+NZUgMnRFH5K12WUPEV/ZaiHCDJ+EY9V/Vg9FJ07lGwD2Gbh6sn
 kF2BLG6iYwgwddpZVvB7fyX3IBs7CydiMXDHGc/13YAQ7i2bqUh39qTY5UxmJdpfAaTp
 y+a3Gifzvk5nng1LTYZLOd2L6n9NMlMPSFClqXfIZUsZ/xhDJhOnZ8Si2Cg1bs2Ab41U
 A+5U1+kuAKh3rA9JGJIiKWE+MuKXBgd966Cn6b/H5UwZiWVhrCiVlzuN3sO14IIcM3bC
 5R1AesSVNQEOC6KmDRA0rRYW0ujlRqq0r1uVMbGyXazEuq2Wc/FLnkGNa+cDP+H1B0LQ
 pNYw==
X-Gm-Message-State: AOAM532Z5+BzYPeHXT5IT6y5IwlOH9VLSHe0SzdN0MG3aLZKGfsx8PlQ
 yOM8nQi9iaBcVCDWAl5VT2BxtlWV22pJwX9LrGI=
X-Google-Smtp-Source: ABdhPJx1NYW6O2vTOmD2f+L1oefE7sUJOlRdzXwtXh4f1KlLnGDUPHbu69gI5a1CMlnFvc/bDBfE3NwYidfiPuQsHHE=
X-Received: by 2002:ae9:f804:: with SMTP id x4mr2619573qkh.164.1590514355126; 
 Tue, 26 May 2020 10:32:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200526062252.19852-1-f4bug@amsat.org>
 <20200526062252.19852-9-f4bug@amsat.org>
In-Reply-To: <20200526062252.19852-9-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 26 May 2020 10:23:36 -0700
Message-ID: <CAKmqyKPz5zvPuiP7dNoni2rHq_jvo9wJ=c+Q-_xNDN91yf6gGw@mail.gmail.com>
Subject: Re: [PATCH 08/14] hw/display/dpcd: Convert debug printf()s to trace
 events
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::741;
 envelope-from=alistair23@gmail.com; helo=mail-qk1-x741.google.com
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
> index bb089a5f5e..72d4c9812c 100644
> --- a/hw/display/trace-events
> +++ b/hw/display/trace-events
> @@ -157,3 +157,7 @@ artist_draw_line(unsigned int start_x, unsigned int s=
tart_y, unsigned int end_x,
>  # cg3.c
>  cg3_read(uint32_t addr, uint32_t val, unsigned size) "read addr:0x%06"PR=
Ix32" val:0x%08"PRIx32" size:%u"
>  cg3_write(uint32_t addr, uint32_t val, unsigned size) "write addr:0x%06"=
PRIx32" val:0x%08"PRIx32" size:%u"
> +
> +# dpcd.c
> +dpcd_read(uint32_t addr, uint8_t val) "read addr:0x%"PRIx32" val:0x%02x"
> +dpcd_write(uint32_t addr, uint8_t val) "write addr:0x%"PRIx32" val:0x%02=
x"
> --
> 2.21.3
>
>

