Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9744FC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:21:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54637206C0
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGlLYjqh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54637206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDvIl-0003au-Gd
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 15:21:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48277)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jDuwj-0006kC-7V
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:58:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jDuwh-0000oe-W3
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:58:41 -0400
Received: from mail-vk1-xa43.google.com ([2607:f8b0:4864:20::a43]:44920)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jDuwh-0000cn-QE; Mon, 16 Mar 2020 14:58:39 -0400
Received: by mail-vk1-xa43.google.com with SMTP id s194so5208348vkb.11;
 Mon, 16 Mar 2020 11:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=YCj2j2QLvThI/7yEyvEGkibNCO6HQSKc0dHTHfIKDcY=;
 b=bGlLYjqhuOBElLMaKSsrdR8mC6CRaROa6KBnTAsCpws2wpve3LntDOB0Q+oE4R0Idb
 Xn8nHKI2IbSTmNeMjeJaO01UwKNzHkrYG0rUasis1zkIRxIFq+MHhDkGW0kaP8z7tL4+
 iaknz1bsSRKSh7+Vlf2okzdk88wPqJ7WUyTLsJ7+fzuwPU36xVjshHKmoEkAD0kYysw/
 pJMJ1vjHXVogndtc2iF1sCN/OJloYUef8O8PWKDcAWByEIM4Fzu86oBH3FSV/qFgheEF
 XVjA5AJP9vcnuTaX0eDATnVVr8Uf3IGtnWTGqPKKdTF9/ObXE60DbfFDe+xrXTP9c+v2
 F+UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=YCj2j2QLvThI/7yEyvEGkibNCO6HQSKc0dHTHfIKDcY=;
 b=foMvV5V+DqfAOuNrzqIVzqdBg+YmZvP5/AuCc9upG5WkJUu6RpjB4gLd3aOx7gALF1
 n4CNtgpN0Je6NRF1wyCW4CYzdLw5v13erqdYPZiieveprQvEpLVttw2i9KDqrGUaYjOS
 Bob47OiTLJYKn9y7uBPTBmzB1r/cx+V+CYLDdg7H6+KTNthyaFJWGTP+L2I/A3VEfdiz
 tkbngeIO8yW9JIsblCL0916KD2gQNq1b/wXRO6SFj21V5AELyCV2RkuLsT3bJ+5OUSWL
 hzQgcYL8vji6s2B5cDZy+CPc7TkbQQLQ00UFHIxIw1y6GH8w7GG7quH+b8CJUuAwZEHD
 QObQ==
X-Gm-Message-State: ANhLgQ395Su2RAOCovfdEqmkWI4cltdvH38Q55UcSYSamBq0ZztnxQx4
 MjAe0gZyXdkY31Eyyt9LZleAm80fliqCCws0dC8=
X-Google-Smtp-Source: ADFU+vt1UQZbBobBOZUFnYrin4HNu6UUV4fvJ3h+wNQic8DypOo+3LRiFcH2okRqlturOlaEhHGMiHec9oeAD65CExg=
X-Received: by 2002:a1f:9d16:: with SMTP id g22mr1216404vke.22.1584385118812; 
 Mon, 16 Mar 2020 11:58:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200316185006.576-1-philmd@redhat.com>
 <20200316185006.576-21-philmd@redhat.com>
In-Reply-To: <20200316185006.576-21-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 16 Mar 2020 11:50:46 -0700
Message-ID: <CAKmqyKNOkFcO3hzELJ49LR9XBfGnRaBu1Uw+1iuyoj8kU4Sp4Q@mail.gmail.com>
Subject: Re: [PATCH v3 20/25] hw/riscv: Let devices own the MemoryRegion they
 create
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::a43
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
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 16, 2020 at 11:54 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Avoid orphan memory regions being added in the /unattached QOM
> container.
>
> This commit was produced with the Coccinelle script
> scripts/coccinelle/memory-region-housekeeping.cocci.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/sifive_e.c | 6 +++---
>  hw/riscv/sifive_u.c | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
> index a1974ef7be..646553a7c3 100644
> --- a/hw/riscv/sifive_e.c
> +++ b/hw/riscv/sifive_e.c
> @@ -145,8 +145,8 @@ static void riscv_sifive_e_soc_realize(DeviceState *d=
ev, Error **errp)
>                              &error_abort);
>
>      /* Mask ROM */
> -    memory_region_init_rom(&s->mask_rom, NULL, "riscv.sifive.e.mrom",
> -        memmap[SIFIVE_E_MROM].size, &error_fatal);
> +    memory_region_init_rom(&s->mask_rom, OBJECT(dev), "riscv.sifive.e.mr=
om",
> +                           memmap[SIFIVE_E_MROM].size, &error_fatal);
>      memory_region_add_subregion(sys_mem,
>          memmap[SIFIVE_E_MROM].base, &s->mask_rom);
>
> @@ -208,7 +208,7 @@ static void riscv_sifive_e_soc_realize(DeviceState *d=
ev, Error **errp)
>          memmap[SIFIVE_E_PWM2].base, memmap[SIFIVE_E_PWM2].size);
>
>      /* Flash memory */
> -    memory_region_init_rom(&s->xip_mem, NULL, "riscv.sifive.e.xip",
> +    memory_region_init_rom(&s->xip_mem, OBJECT(dev), "riscv.sifive.e.xip=
",
>                             memmap[SIFIVE_E_XIP].size, &error_fatal);
>      memory_region_add_subregion(sys_mem, memmap[SIFIVE_E_XIP].base,
>          &s->xip_mem);
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 156a003642..662d42a5a7 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -497,7 +497,7 @@ static void riscv_sifive_u_soc_realize(DeviceState *d=
ev, Error **errp)
>                               &error_abort);
>
>      /* boot rom */
> -    memory_region_init_rom(mask_rom, NULL, "riscv.sifive.u.mrom",
> +    memory_region_init_rom(mask_rom, OBJECT(dev), "riscv.sifive.u.mrom",
>                             memmap[SIFIVE_U_MROM].size, &error_fatal);
>      memory_region_add_subregion(system_memory, memmap[SIFIVE_U_MROM].bas=
e,
>                                  mask_rom);
> --
> 2.21.1
>
>

