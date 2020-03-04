Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C036CC3F2D8
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 14:11:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8949A21739
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 14:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDPlT+la"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8949A21739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9Ujl-0004Nd-Kr
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 09:11:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51723)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1j9Uio-00038e-2v
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 09:10:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1j9Uim-0008Ce-N7
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 09:10:01 -0500
Received: from mail-yw1-xc43.google.com ([2607:f8b0:4864:20::c43]:40010)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1j9Uim-0008BA-J3; Wed, 04 Mar 2020 09:10:00 -0500
Received: by mail-yw1-xc43.google.com with SMTP id t192so2016194ywe.7;
 Wed, 04 Mar 2020 06:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xf5QouyH3BndECmQgUr5Xdc/HOWK5p0EBH0h1gW1ZZk=;
 b=lDPlT+laNVYbEi7wwtiyEQlfoKCQ5X3lyYHislnFTnO49X096sVq9UbZHm4OWd/y/W
 T2VzxBzymTZfxuRGS5HBHra1tK18YPWW6hZzS1dbb9di+GjtW9UUBmYhxMUWDvSB8yAS
 jMrYf4MUzin/6eKDXhBWmqEk90uY4qikndgTfnRH/ZeiBkHwN++uL2uFqiEqFQgd/ZFv
 7dz07Ym1vMGf2nj2CvyAvAFoDexL8rEFGsPEEVJBbGr13JegaRnVGAkFbqsqJCdHL+lf
 2ZzpJIWFKNdw5NAA0F4OA6KWPqU9/cKlWJq++4ivHVvrq2aYXhbXDLx2hdK4tn0w5B5k
 eOFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xf5QouyH3BndECmQgUr5Xdc/HOWK5p0EBH0h1gW1ZZk=;
 b=LXepUIpj4uERbunDqc2bcLNY9sZgpQW6nsikGhq6WD+9ycjdMiQGDsURaw+wZOmokC
 qVFt2kY9+S90sK0t0qMiTU7KlIro163f5CBsDsUK+Ua9xXnUmfwGKxJJ8DaE5hg2+nJy
 Yy0p8RjmC6uEX3WTmvSPHl0c1Pv3m/zf2164SVY/H1WGPAc6HCh7q1Lxn+8U0PfeOJbC
 469LdGWv0B8CEPdv5ldpm5GE5rfMXg9Bui3FDTY0EulAgspTIE+fo0emxYFpOy9EStte
 KNMZS/smiwrobzSP5sc9UM+ELsIr62qc6Rhm6aikKk1Rj4I+c5INwPJHHbILc+YjQTFc
 0BDw==
X-Gm-Message-State: ANhLgQ1C6uGU8pnn6BdGUqfiDeeqc4oisnajaj7U9nCUEY7sJUQEGn6B
 bOOFLjt6pKllBuQueDYA4bdsJ7jGPiirJ03LapE=
X-Google-Smtp-Source: ADFU+vvCYfhesrABeS8X3Ycy4dpOm+u1J6yhoGVLIJghJtMI91/s69nbfmNEFp01XzTGkWuHcMYyQY2Qu/iuezsRaJM=
X-Received: by 2002:a25:bd87:: with SMTP id f7mr2810668ybh.11.1583330999681;
 Wed, 04 Mar 2020 06:09:59 -0800 (PST)
MIME-Version: 1.0
References: <cover.1583285287.git.alistair.francis@wdc.com>
 <3f5f5106d357f6ff911e4b81973840d414920b78.1583285287.git.alistair.francis@wdc.com>
In-Reply-To: <3f5f5106d357f6ff911e4b81973840d414920b78.1583285287.git.alistair.francis@wdc.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 4 Mar 2020 22:09:49 +0800
Message-ID: <CAEUhbmW=T50FcppnLFAzdQNwQEwofX9U-Zyo2oJikSiS8ti4QQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] riscv/sifive_u: Fix up file ordering
To: Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c43
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
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <alistair23@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Mar 4, 2020 at 9:37 AM Alistair Francis
<alistair.francis@wdc.com> wrote:
>
> Split the file into clear machine and SoC sections.
>

Yep, I found functions in this file are a little bit confusing as well ..

> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  hw/riscv/sifive_u.c | 107 ++++++++++++++++++++++----------------------
>  1 file changed, 54 insertions(+), 53 deletions(-)
>
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 156a003642..9a0145b5b4 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -399,6 +399,60 @@ static void riscv_sifive_u_init(MachineState *machine)

So while we are here, could we rename this to something like:
sifive_u_machine_init()? ie: drop the riscv_ prefix.

>                            &address_space_memory);
>  }
>
> +static bool sifive_u_get_start_in_flash(Object *obj, Error **errp)

and sifive_u_machine_get_start_in_flash()? and other functions too?

> +{
> +    SiFiveUState *s = RISCV_U_MACHINE(obj);
> +
> +    return s->start_in_flash;
> +}
> +
> +static void sifive_u_set_start_in_flash(Object *obj, bool value, Error **errp)
> +{
> +    SiFiveUState *s = RISCV_U_MACHINE(obj);
> +
> +    s->start_in_flash = value;
> +}
> +
> +static void riscv_sifive_u_machine_instance_init(Object *obj)
> +{
> +    SiFiveUState *s = RISCV_U_MACHINE(obj);
> +
> +    s->start_in_flash = false;
> +    object_property_add_bool(obj, "start-in-flash", sifive_u_get_start_in_flash,
> +                             sifive_u_set_start_in_flash, NULL);
> +    object_property_set_description(obj, "start-in-flash",
> +                                    "Set on to tell QEMU's ROM to jump to " \
> +                                    "flash. Otherwise QEMU will jump to DRAM",
> +                                    NULL);
> +}
> +
> +
> +static void riscv_sifive_u_machine_class_init(ObjectClass *oc, void *data)
> +{
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +
> +    mc->desc = "RISC-V Board compatible with SiFive U SDK";
> +    mc->init = riscv_sifive_u_init;
> +    mc->max_cpus = SIFIVE_U_MANAGEMENT_CPU_COUNT + SIFIVE_U_COMPUTE_CPU_COUNT;
> +    mc->min_cpus = SIFIVE_U_MANAGEMENT_CPU_COUNT + 1;
> +    mc->default_cpus = mc->min_cpus;
> +}
> +
> +static const TypeInfo riscv_sifive_u_machine_typeinfo = {
> +    .name       = MACHINE_TYPE_NAME("sifive_u"),
> +    .parent     = TYPE_MACHINE,
> +    .class_init = riscv_sifive_u_machine_class_init,
> +    .instance_init = riscv_sifive_u_machine_instance_init,
> +    .instance_size = sizeof(SiFiveUState),
> +};
> +
> +static void riscv_sifive_u_machine_init_register_types(void)
> +{
> +    type_register_static(&riscv_sifive_u_machine_typeinfo);
> +}
> +
> +type_init(riscv_sifive_u_machine_init_register_types)
> +
>  static void riscv_sifive_u_soc_init(Object *obj)

Similarly this can be renamed to: sifive_u_soc_init(), and other soc functions.

>  {
>      MachineState *ms = MACHINE(qdev_get_machine());
> @@ -439,33 +493,6 @@ static void riscv_sifive_u_soc_init(Object *obj)
>                            TYPE_CADENCE_GEM);
>  }
>
> -static bool sifive_u_get_start_in_flash(Object *obj, Error **errp)
> -{
> -    SiFiveUState *s = RISCV_U_MACHINE(obj);
> -
> -    return s->start_in_flash;
> -}
> -
> -static void sifive_u_set_start_in_flash(Object *obj, bool value, Error **errp)
> -{
> -    SiFiveUState *s = RISCV_U_MACHINE(obj);
> -
> -    s->start_in_flash = value;
> -}
> -
> -static void riscv_sifive_u_machine_instance_init(Object *obj)
> -{
> -    SiFiveUState *s = RISCV_U_MACHINE(obj);
> -
> -    s->start_in_flash = false;
> -    object_property_add_bool(obj, "start-in-flash", sifive_u_get_start_in_flash,
> -                             sifive_u_set_start_in_flash, NULL);
> -    object_property_set_description(obj, "start-in-flash",
> -                                    "Set on to tell QEMU's ROM to jump to " \
> -                                    "flash. Otherwise QEMU will jump to DRAM",
> -                                    NULL);
> -}
> -
>  static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
>  {
>      MachineState *ms = MACHINE(qdev_get_machine());
> @@ -603,29 +630,3 @@ static void riscv_sifive_u_soc_register_types(void)
>  }
>
>  type_init(riscv_sifive_u_soc_register_types)
> -
> -static void riscv_sifive_u_machine_class_init(ObjectClass *oc, void *data)
> -{
> -    MachineClass *mc = MACHINE_CLASS(oc);
> -
> -    mc->desc = "RISC-V Board compatible with SiFive U SDK";
> -    mc->init = riscv_sifive_u_init;
> -    mc->max_cpus = SIFIVE_U_MANAGEMENT_CPU_COUNT + SIFIVE_U_COMPUTE_CPU_COUNT;
> -    mc->min_cpus = SIFIVE_U_MANAGEMENT_CPU_COUNT + 1;
> -    mc->default_cpus = mc->min_cpus;
> -}
> -
> -static const TypeInfo riscv_sifive_u_machine_typeinfo = {
> -    .name       = MACHINE_TYPE_NAME("sifive_u"),
> -    .parent     = TYPE_MACHINE,
> -    .class_init = riscv_sifive_u_machine_class_init,
> -    .instance_init = riscv_sifive_u_machine_instance_init,
> -    .instance_size = sizeof(SiFiveUState),
> -};
> -
> -static void riscv_sifive_u_machine_init_register_types(void)
> -{
> -    type_register_static(&riscv_sifive_u_machine_typeinfo);
> -}
> -
> -type_init(riscv_sifive_u_machine_init_register_types)
> --

Regards,
Bin

