Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 792CEC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 14:51:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44234206E9
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 14:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TlHACp3x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44234206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvilH-000261-GQ
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 10:51:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jvijR-0000P3-M8; Wed, 15 Jul 2020 10:50:01 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:40204)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jvijP-0000yL-HA; Wed, 15 Jul 2020 10:50:01 -0400
Received: by mail-io1-xd44.google.com with SMTP id l17so2492288iok.7;
 Wed, 15 Jul 2020 07:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GwF5kLecPGbFx7XOkpIQGvxC60yxwFLvNgeE86muLgE=;
 b=TlHACp3x5i9hsSwEYd5uZlRy2gy8E+87mlYM+q+5Guzr5HR72CAwU7y60b5WKBmbzH
 1GeqG8K6sdZloe8KoS5ENliBn2iTZhUN9TLe1bdtMPd0DFieiZ8Jj4uJk5eV+ssnIPa7
 Ef4QYgbGsV94DOHiEC5psLnS7j1GkA12OjgZDIr8YIPVkKdgPrlU1Hyldrhtropnw9rV
 dJKhOUmC2tM8Oln+tAGBPzSLkWBFMNBngUGlybZJ3SV2778oU47QJfuwvbSvC5Wwo50e
 m6avdTxv+134xNHSz1uCufpd+PQMQzCmXPZBDLhP/GBbvlvpkHuSjxE1rISIpjcmdKbv
 qTNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GwF5kLecPGbFx7XOkpIQGvxC60yxwFLvNgeE86muLgE=;
 b=WswVbJc8gs7V5o1duh8zfJFCBJ1mScbxd2zPO0FvKlktq1SIVTo15sUb16UxpMpUCI
 UEyCtL1flgIW/GdxjF02V7yYHZ/rr1LM/p6mGgf1ibsQY7PNliMgMgYXm6tUf9DBXN5o
 ojvheSmq/qVBPwuTcr39UA3r2STDseAnjjBbrn2hlLMq87lL/qgLEFjRtZAmuIzE6NgD
 uKEVNFggXZr9XocyZ8PeCWmOgxLF3MiP/gcgAKesFo+yzoaPCPIdsBC0fVdymhOYTn6C
 zp9jBDBOSWUvazbz/R/DScqXbYUhz17SuMzaNekPxci67V+KvUmmKgFDVM2Cxbesblxd
 ivKg==
X-Gm-Message-State: AOAM532sKt5U0m2KKB8TPIh+b019oxPmZmsmtmO5//UpgtKYP0xE5zm9
 86SdBbMmLgV0m6m8Sp/CyWbfbzmxICIn2I7Fc3E=
X-Google-Smtp-Source: ABdhPJwsZgn6x4T8xrU48LoKVza2qyTzj7srAnlPS3fzCtYbwsb/lU66jbQKICIDMh03drLI5AdRYfM0qb+1hBaOT3g=
X-Received: by 2002:a5d:9306:: with SMTP id l6mr10611822ion.105.1594824597354; 
 Wed, 15 Jul 2020 07:49:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200715140440.3540942-1-armbru@redhat.com>
 <20200715140440.3540942-3-armbru@redhat.com>
In-Reply-To: <20200715140440.3540942-3-armbru@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 15 Jul 2020 07:39:56 -0700
Message-ID: <CAKmqyKPuNqq+CrxQ7uqJNKNW54MLbjV-nXHh-yj=LsTObBjBBw@mail.gmail.com>
Subject: Re: [PATCH for-5.1 2/2] hw: Mark nd_table[] misuse in realize methods
 FIXME
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Alistair Francis <alistair@alistair23.me>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Edgar Iglesias <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 15, 2020 at 7:06 AM Markus Armbruster <armbru@redhat.com> wrote:
>
> nd_table[] contains NIC configuration for boards to pick up.  Device
> code has no business looking there.  Several devices do it anyway.
> Two of them already have a suitable FIXME comment: "allwinner-a10" and
> "msf2-soc".  Copy it to the others: "allwinner-h3", "xlnx-versal",
> "xlnx,zynqmp", "sparc32-ledma", "riscv.sifive.u.soc".
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/arm/allwinner-h3.c | 1 +
>  hw/arm/xlnx-versal.c  | 1 +
>  hw/arm/xlnx-zynqmp.c  | 1 +
>  hw/dma/sparc32_dma.c  | 1 +
>  hw/riscv/sifive_u.c   | 1 +
>  5 files changed, 5 insertions(+)
>
> diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
> index 8e09468e86..ff92ded82c 100644
> --- a/hw/arm/allwinner-h3.c
> +++ b/hw/arm/allwinner-h3.c
> @@ -358,6 +358,7 @@ static void allwinner_h3_realize(DeviceState *dev, Error **errp)
>                                "sd-bus");
>
>      /* EMAC */
> +    /* FIXME use qdev NIC properties instead of nd_table[] */
>      if (nd_table[0].used) {
>          qemu_check_nic_model(&nd_table[0], TYPE_AW_SUN8I_EMAC);
>          qdev_set_nic_properties(DEVICE(&s->emac), &nd_table[0]);
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index ead038b971..e3aa4bd1e5 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -160,6 +160,7 @@ static void versal_create_gems(Versal *s, qemu_irq *pic)
>          object_initialize_child(OBJECT(s), name, &s->lpd.iou.gem[i],
>                                  TYPE_CADENCE_GEM);
>          dev = DEVICE(&s->lpd.iou.gem[i]);
> +        /* FIXME use qdev NIC properties instead of nd_table[] */
>          if (nd->used) {
>              qemu_check_nic_model(nd, "cadence_gem");
>              qdev_set_nic_properties(dev, nd);
> diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
> index 772cfa3771..5855e5d5bf 100644
> --- a/hw/arm/xlnx-zynqmp.c
> +++ b/hw/arm/xlnx-zynqmp.c
> @@ -455,6 +455,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
>      for (i = 0; i < XLNX_ZYNQMP_NUM_GEMS; i++) {
>          NICInfo *nd = &nd_table[i];
>
> +        /* FIXME use qdev NIC properties instead of nd_table[] */
>          if (nd->used) {
>              qemu_check_nic_model(nd, TYPE_CADENCE_GEM);
>              qdev_set_nic_properties(DEVICE(&s->gem[i]), nd);
> diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
> index 9459178866..bcd1626fbd 100644
> --- a/hw/dma/sparc32_dma.c
> +++ b/hw/dma/sparc32_dma.c
> @@ -341,6 +341,7 @@ static void sparc32_ledma_device_realize(DeviceState *dev, Error **errp)
>      DeviceState *d;
>      NICInfo *nd = &nd_table[0];
>
> +    /* FIXME use qdev NIC properties instead of nd_table[] */
>      qemu_check_nic_model(nd, TYPE_LANCE);
>
>      d = qdev_new(TYPE_LANCE);
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 19a976c9a6..e5682c38a9 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -714,6 +714,7 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
>      }
>      sysbus_mmio_map(SYS_BUS_DEVICE(&s->otp), 0, memmap[SIFIVE_U_OTP].base);
>
> +    /* FIXME use qdev NIC properties instead of nd_table[] */
>      if (nd->used) {
>          qemu_check_nic_model(nd, TYPE_CADENCE_GEM);
>          qdev_set_nic_properties(DEVICE(&s->gem), nd);
> --
> 2.26.2
>
>

