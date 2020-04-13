Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49731C2BA2B
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 22:29:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 116342063A
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 22:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UB4VCZiZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 116342063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jO7aG-0000fQ-5Q
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 18:29:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47488)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jO7ZV-00083x-9v
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 18:28:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jO7ZT-0007ZA-LC
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 18:28:52 -0400
Received: from mail-vk1-xa41.google.com ([2607:f8b0:4864:20::a41]:37363)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jO7ZT-0007Yn-HC; Mon, 13 Apr 2020 18:28:51 -0400
Received: by mail-vk1-xa41.google.com with SMTP id f195so2694828vka.4;
 Mon, 13 Apr 2020 15:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=sPwFUCD5WD03IbhSKbITuz7UtC98LCV4nW8YJYz10tE=;
 b=UB4VCZiZ7rTnlcmBPWRpjT9/QNLTW/YrBtVm6zuXEJMEiDeVdF4BIE0xAPW+MCxY74
 O996QqWcC+XyUjz5SMjMImRJ28H92XviQm7M43K1oNpZY1SHX4AHXoTQ14dHwlpftx2t
 QbfYhXZtQY21ipV7nGHf+zcwNkTnhQdxjVMnOYnzt4dUMEkgFIz4x7GCNP4gPQeujVQh
 he6IkO/+Y++Etu0cY1LnnYqnqPj3wwtc0Ua02OBGJQByUo2yylaTe2VlCvnjha+jC3ZJ
 Oli3EDOvP91i6u/yiWssGjJ2zWICsKaeCNvl0Ao+KRmz6edzb4kh3ID1bKY+NO00JfLN
 0lDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=sPwFUCD5WD03IbhSKbITuz7UtC98LCV4nW8YJYz10tE=;
 b=F8ZEOLTgr7dAGDJwLXtQvGwuNmVMF4L2tKR+5kGk29Z79990zOjASp2UvGPajA8rdF
 TT094TK24ee0qkmt5VhyOP5wJnE8UmgF16+WvHvAbgK22ioC7Sj1q/T+jVUoXqs2T1NA
 zc9wNiPnYU51cuIgw18fzjtIjwiKJTlORkdyL+uVbJP5y1PZbORv0yGag3HvfXNtnVzw
 sGM0481eyocluEY1i22ZMeBe9d0rJ0+UwTZ7fFUaJy7NsEcNyMC1DZcDqDx0EONTj9FM
 pAm8ioMoNFlSYBRulX/aedgsHduuxdkkkorSbl0O9lKRADtnGnrte237NjHrmLnBtzBo
 5RCg==
X-Gm-Message-State: AGi0PuZ4+PU7MoQWyw115AtconOzudw1Xnx65t6tlR+KT1uMdPSAqbGh
 OEgRjcf9aFA1N6dazrfgcifKk7UwXfLzuMst4ZY=
X-Google-Smtp-Source: APiQypJx4ySOK5XtCPZ54C86WKgbHpF37uobe1AzkP8FHb6vge3N/asDxDIvlhPmqAkPIfJI7zawsTFtDFkbOn4UoCo=
X-Received: by 2002:a1f:2e8c:: with SMTP id u134mr13040124vku.16.1586816930627; 
 Mon, 13 Apr 2020 15:28:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200412223619.11284-1-f4bug@amsat.org>
 <20200412223619.11284-20-f4bug@amsat.org>
In-Reply-To: <20200412223619.11284-20-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 13 Apr 2020 15:20:34 -0700
Message-ID: <CAKmqyKMGO+a3MO33RLkw5ye_OYfJ8zE_HXF+ET3tzHXQgK9cgA@mail.gmail.com>
Subject: Re: [PATCH-for-5.1 v3 19/24] hw/riscv/sifive_e: Move some code from
 realize() to init()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::a41
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jeff Cody <codyprime@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Max Reitz <mreitz@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 "open list:New World" <qemu-ppc@nongnu.org>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>, Andrew Jeffery <andrew@aj.id.au>,
 Wen Congyang <wencongyang2@huawei.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Apr 12, 2020 at 3:45 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> Coccinelle reported:
>
>   $ spatch ... --timeout 60 --sp-file \
>     scripts/coccinelle/simplify-init-realize-error_propagate.cocci
>   HANDLING: ./hw/riscv/sifive_e.c
>   >>> possible moves from riscv_sifive_e_soc_init() to riscv_sifive_e_soc=
_realize() in ./hw/riscv/sifive_e.c:135
>
> Move the calls using &error_fatal which don't depend on input
> updated before realize() to init().
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> v3: Typo 'depend of' -> 'depend on' (eblake)
> ---
>  hw/riscv/sifive_e.c | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)
>
> diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
> index 646553a7c3..0be8b52147 100644
> --- a/hw/riscv/sifive_e.c
> +++ b/hw/riscv/sifive_e.c
> @@ -118,7 +118,9 @@ static void riscv_sifive_e_init(MachineState *machine=
)
>  static void riscv_sifive_e_soc_init(Object *obj)
>  {
>      MachineState *ms =3D MACHINE(qdev_get_machine());
> +    const struct MemmapEntry *memmap =3D sifive_e_memmap;
>      SiFiveESoCState *s =3D RISCV_E_SOC(obj);
> +    MemoryRegion *sys_mem =3D get_system_memory();
>
>      object_initialize_child(obj, "cpus", &s->cpus,
>                              sizeof(s->cpus), TYPE_RISCV_HART_ARRAY,
> @@ -130,6 +132,18 @@ static void riscv_sifive_e_soc_init(Object *obj)
>      sysbus_init_child_obj(obj, "riscv.sifive.e.gpio0",
>                            &s->gpio, sizeof(s->gpio),
>                            TYPE_SIFIVE_GPIO);
> +
> +    /* Mask ROM */
> +    memory_region_init_rom(&s->mask_rom, obj, "riscv.sifive.e.mrom",
> +                           memmap[SIFIVE_E_MROM].size, &error_fatal);
> +    memory_region_add_subregion(sys_mem,
> +        memmap[SIFIVE_E_MROM].base, &s->mask_rom);
> +
> +    /* Flash memory */
> +    memory_region_init_rom(&s->xip_mem, obj, "riscv.sifive.e.xip",
> +                           memmap[SIFIVE_E_XIP].size, &error_fatal);
> +    memory_region_add_subregion(sys_mem, memmap[SIFIVE_E_XIP].base,
> +        &s->xip_mem);
>  }
>
>  static void riscv_sifive_e_soc_realize(DeviceState *dev, Error **errp)
> @@ -144,12 +158,6 @@ static void riscv_sifive_e_soc_realize(DeviceState *=
dev, Error **errp)
>      object_property_set_bool(OBJECT(&s->cpus), true, "realized",
>                              &error_abort);
>
> -    /* Mask ROM */
> -    memory_region_init_rom(&s->mask_rom, OBJECT(dev), "riscv.sifive.e.mr=
om",
> -                           memmap[SIFIVE_E_MROM].size, &error_fatal);
> -    memory_region_add_subregion(sys_mem,
> -        memmap[SIFIVE_E_MROM].base, &s->mask_rom);
> -
>      /* MMIO */
>      s->plic =3D sifive_plic_create(memmap[SIFIVE_E_PLIC].base,
>          (char *)SIFIVE_E_PLIC_HART_CONFIG,
> @@ -206,12 +214,6 @@ static void riscv_sifive_e_soc_realize(DeviceState *=
dev, Error **errp)
>          memmap[SIFIVE_E_QSPI2].base, memmap[SIFIVE_E_QSPI2].size);
>      create_unimplemented_device("riscv.sifive.e.pwm2",
>          memmap[SIFIVE_E_PWM2].base, memmap[SIFIVE_E_PWM2].size);
> -
> -    /* Flash memory */
> -    memory_region_init_rom(&s->xip_mem, OBJECT(dev), "riscv.sifive.e.xip=
",
> -                           memmap[SIFIVE_E_XIP].size, &error_fatal);
> -    memory_region_add_subregion(sys_mem, memmap[SIFIVE_E_XIP].base,
> -        &s->xip_mem);
>  }
>
>  static void riscv_sifive_e_machine_init(MachineClass *mc)
> --
> 2.21.1
>
>

