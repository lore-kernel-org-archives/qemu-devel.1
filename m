Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FCFC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 16:52:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BED0620776
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 16:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uygr6lw7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BED0620776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdcoC-0001hv-RX
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 12:52:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jdcmu-0008Mx-Fs; Tue, 26 May 2020 12:50:48 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:41494)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jdcmt-0008P8-8X; Tue, 26 May 2020 12:50:48 -0400
Received: by mail-io1-xd42.google.com with SMTP id o5so22742175iow.8;
 Tue, 26 May 2020 09:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=4xhxIuW5e7MTY17vJexhuzlogi09eAgFg3lNXL700Oc=;
 b=uygr6lw7iZ5vnE1WD+PojkgydN/vd4U/GOGrtaI/dHHgBelfq8fXQLEZBUGrcMUsNx
 s2rQZCjSKAqSfcK26TuA2103yaVQA3WDL0sguGB5GmNSdahiErUrIshSroZpJjAta886
 Wss6/sg8albn11yBHg+T+F6OPJO3A/Ks743qAmYjkoKN8ovFpnCnqZcczJLQ8Bk7jyaA
 gjlkDQg/DjFGTOlQj6LfX6zQ8nXnTkGhDLdAftnT57/lMh27od5U7QDjJ0S9ao1+O02a
 lB6WeJLRnWOGG1xIvPLT6PgkU3fTrzwHHzNiXPOvz3cC0Yfs8c/koWijyChHWvWFFps2
 Ek7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=4xhxIuW5e7MTY17vJexhuzlogi09eAgFg3lNXL700Oc=;
 b=P1LIyHs0mAzCei121O86kF/tnPI9SkJLpxCrz6ryvr5kaLeBswOHtD0WsWVCg+7O3T
 mYq47dOYj6iEV+6imzwLXygiEaPJrk29YS2nnzIKVuOYhIWgmscjnjAZW267+M7lS74s
 ubnPbreOmURq7h1wcVHaZOGLKoigCtTODtvMyHGGfCHNa8MJY5e9f/YSK8WB0t0MPo2Z
 4HtWTcZhyoJW37QkNjGQRvm8xKFWuoq3XPoQ2lYbimZdBof4vjtT1CfP2m8er6sQ2/78
 W+bsqPpb7bnBepIF6j//FAekNqGSZXst39vn4K9TeJkyu/sFH//XuxjwrpwzYHdDHidb
 5zhw==
X-Gm-Message-State: AOAM5306fIBOM7ql0S9QRIAzs0p455DlVoGiuKupvYpbb5w450XmUrAm
 Ec4Ne8A8LKgFq6ZKvQLBiT6+HE1PmreQTSlhGtc=
X-Google-Smtp-Source: ABdhPJyncKVcuCtrgK6WZ/NuVPhU4G8aCrFJYvhnLbiixk+Wq6nzRO7BdNF5PR7woGqtLp76fSqzuNp+iDnaojUPX0U=
X-Received: by 2002:a5d:9d03:: with SMTP id j3mr4516138ioj.176.1590511845417; 
 Tue, 26 May 2020 09:50:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200526062252.19852-1-f4bug@amsat.org>
 <20200526062252.19852-3-f4bug@amsat.org>
In-Reply-To: <20200526062252.19852-3-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 26 May 2020 09:41:46 -0700
Message-ID: <CAKmqyKMhGXK+NPH16neMJc+8q7tGACHzTpMqT1CgpXT6x9fR0A@mail.gmail.com>
Subject: Re: [PATCH 02/14] hw/display/cg3: Convert debug printf()s to trace
 events
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, May 25, 2020 at 11:23 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
>
> Convert DPRINTF() to trace events and remove ifdef'ry.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/display/cg3.c        | 14 ++++----------
>  hw/display/trace-events |  4 ++++
>  2 files changed, 8 insertions(+), 10 deletions(-)
>
> diff --git a/hw/display/cg3.c b/hw/display/cg3.c
> index f7f1c199ce..7cbe6e56ff 100644
> --- a/hw/display/cg3.c
> +++ b/hw/display/cg3.c
> @@ -35,6 +35,7 @@
>  #include "hw/qdev-properties.h"
>  #include "qemu/log.h"
>  #include "qemu/module.h"
> +#include "trace.h"
>
>  /* Change to 1 to enable debugging */
>  #define DEBUG_CG3 0
> @@ -63,12 +64,6 @@
>  #define CG3_VRAM_SIZE 0x100000
>  #define CG3_VRAM_OFFSET 0x800000
>
> -#define DPRINTF(fmt, ...) do { \
> -    if (DEBUG_CG3) { \
> -        printf("CG3: " fmt , ## __VA_ARGS__); \
> -    } \
> -} while (0)
> -
>  #define TYPE_CG3 "cgthree"
>  #define CG3(obj) OBJECT_CHECK(CG3State, (obj), TYPE_CG3)
>
> @@ -195,7 +190,8 @@ static uint64_t cg3_reg_read(void *opaque, hwaddr add=
r, unsigned size)
>          val =3D 0;
>          break;
>      }
> -    DPRINTF("read %02x from reg %" HWADDR_PRIx "\n", val, addr);
> +    trace_cg3_read(addr, val, size);
> +
>      return val;
>  }
>
> @@ -206,9 +202,7 @@ static void cg3_reg_write(void *opaque, hwaddr addr, =
uint64_t val,
>      uint8_t regval;
>      int i;
>
> -    DPRINTF("write %" PRIx64 " to reg %" HWADDR_PRIx " size %d\n",
> -            val, addr, size);
> -
> +    trace_cg3_write(addr, val, size);
>      switch (addr) {
>      case CG3_REG_BT458_ADDR:
>          s->dac_index =3D val;
> diff --git a/hw/display/trace-events b/hw/display/trace-events
> index e6e22bef88..47b2b168ae 100644
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
> +# cg3.c
> +cg3_read(uint32_t addr, uint32_t val, unsigned size) "read addr:0x%06"PR=
Ix32" val:0x%08"PRIx32" size:%u"
> +cg3_write(uint32_t addr, uint32_t val, unsigned size) "write addr:0x%06"=
PRIx32" val:0x%08"PRIx32" size:%u"
> --
> 2.21.3
>
>

