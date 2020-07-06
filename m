Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E76AC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 17:22:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0557206CD
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 17:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aqh+O/Xy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0557206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsUp0-0002y6-8P
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 13:22:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60302)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsUPw-0000yu-T2; Mon, 06 Jul 2020 12:56:33 -0400
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:44731)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsUPu-0005XS-Nw; Mon, 06 Jul 2020 12:56:32 -0400
Received: by mail-il1-x141.google.com with SMTP id h16so10172002ilj.11;
 Mon, 06 Jul 2020 09:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=L1yDIvA88vi1SgltVFMfPCZczTxmxTH0/nCyzEY2sLM=;
 b=Aqh+O/XyfP+h5qtevBYxfA2ozEfP3E38+RL+UpEl8kroHP77+5qRgTCik/GCicN+6S
 +rKRRRmasE1xQxg7houBPEQLk9fZyBXJz3Gd/aPzGeHbLPJuiwUR93vNoKORGH/3K0Zj
 XRraX/qVHeyon7mx5KjL5ftajYCyy9590ZCI69XiiWA4AGIBJ4VbVlu1dtlogNRIbVJt
 F/SzwCM4CTBlLS9Oep876d3Zo5skaH7N0kJ19Jgqacx7q5n4pHOby1h3rfdbcX+JUkMW
 O2JhjisLiDRQJM5Yl4Ax2ACke9kc9WWwEsAtkjrYOqkjVofEl6bD2uRyP5YVPuBA9oaO
 XQmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=L1yDIvA88vi1SgltVFMfPCZczTxmxTH0/nCyzEY2sLM=;
 b=MP2+ZBbNMf6i2ZIIbwaJ+Nw+j4Nwvll9qmTWdFgg2p0DNt4ktoBfb1dj+Yb0tH3pej
 yzyzi4KsfdhtsYXLfT7j1Ih1aIoaYZv6hU/POyGUdbm/r+66ASg+lQxYs5O2KFyPKX+/
 lkzb8Rw/Kbj38SNrezeXiluecIo4slo01O/V78rK6C44D9fK95r604mqADH/QigWlXvw
 2fmsBNxTdfEh/cfUAfTF1UXcqgL19zwCsqpobvATF1kdCw3DMefFDUWHRj9edY6PQ4DL
 AOmFmDpoIhCHic7A4rHvgABwTgeNu41ZoVDRdPDPUjObwxkhavPfi9m2obKAw0SxWvUP
 P5KQ==
X-Gm-Message-State: AOAM530ugJZ7xrFMO6mRkEzSRRopG3jFKdIjViEljS04tC9x+BLFSpcK
 VsN8Ml/hEeg3L2GqH1VagejXMxGuGfDsjn9hKo4=
X-Google-Smtp-Source: ABdhPJw/uGqEBJeyth+hrcyWGteDMhEzQn23gr50loOewZAqiVJNtM1FfMLGJkQCgbvJlCnRPxvOQh0duo89p2KIWqY=
X-Received: by 2002:a92:c213:: with SMTP id j19mr31576589ilo.40.1594054588655; 
 Mon, 06 Jul 2020 09:56:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200704153908.12118-1-philmd@redhat.com>
 <20200704153908.12118-22-philmd@redhat.com>
In-Reply-To: <20200704153908.12118-22-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jul 2020 09:46:42 -0700
Message-ID: <CAKmqyKNaTK+CSDvy-C0_go0EeggGYvWP4sjFmGkEF1cJSnBXUQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 21/23] hw/riscv: Emit warning when old code is used
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::141;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x141.google.com
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
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm <qemu-arm@nongnu.org>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>, Stafford Horne <shorne@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "open list:New World" <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Jul 4, 2020 at 8:48 AM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
>
> This code hasn't been QOM'ified yet. Warn the user.
>
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/riscv_htif.c  | 4 ++++
>  hw/riscv/sifive_uart.c | 4 ++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/hw/riscv/riscv_htif.c b/hw/riscv/riscv_htif.c
> index ca87a5cf9f..bd080dbefb 100644
> --- a/hw/riscv/riscv_htif.c
> +++ b/hw/riscv/riscv_htif.c
> @@ -30,6 +30,7 @@
>  #include "hw/riscv/riscv_htif.h"
>  #include "qemu/timer.h"
>  #include "qemu/error-report.h"
> +#include "hw/qdev-deprecated.h"
>
>  #define RISCV_DEBUG_HTIF 0
>  #define HTIF_DEBUG(fmt, ...)                                            =
       \
> @@ -238,6 +239,9 @@ HTIFState *htif_mm_init(MemoryRegion *address_space, =
MemoryRegion *main_mem,
>      uint64_t fromhost_offset =3D fromhost_addr - base;
>
>      HTIFState *s =3D g_malloc0(sizeof(HTIFState));
> +
> +    qdev_warn_deprecated_function_used();
> +
>      s->address_space =3D address_space;
>      s->main_mem =3D main_mem;
>      s->main_mem_ram_ptr =3D memory_region_get_ram_ptr(main_mem);
> diff --git a/hw/riscv/sifive_uart.c b/hw/riscv/sifive_uart.c
> index 9350482662..1a5890d5f7 100644
> --- a/hw/riscv/sifive_uart.c
> +++ b/hw/riscv/sifive_uart.c
> @@ -25,6 +25,7 @@
>  #include "hw/hw.h"
>  #include "hw/irq.h"
>  #include "hw/riscv/sifive_uart.h"
> +#include "hw/qdev-deprecated.h"
>
>  /*
>   * Not yet implemented:
> @@ -183,6 +184,9 @@ SiFiveUARTState *sifive_uart_create(MemoryRegion *add=
ress_space, hwaddr base,
>      Chardev *chr, qemu_irq irq)
>  {
>      SiFiveUARTState *s =3D g_malloc0(sizeof(SiFiveUARTState));
> +
> +    qdev_warn_deprecated_function_used();
> +
>      s->irq =3D irq;
>      qemu_chr_fe_init(&s->chr, chr, &error_abort);
>      qemu_chr_fe_set_handlers(&s->chr, uart_can_rx, uart_rx, uart_event,
> --
> 2.21.3
>
>

