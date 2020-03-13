Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E28C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:33:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B800920749
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 18:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xare2t6L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B800920749
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCp7r-0006Yv-Vz
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 14:33:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49299)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jCp76-0005Lw-1B
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:32:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jCp74-000334-6O
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 14:32:51 -0400
Received: from mail-ua1-x942.google.com ([2607:f8b0:4864:20::942]:40134)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jCp73-00031M-23; Fri, 13 Mar 2020 14:32:50 -0400
Received: by mail-ua1-x942.google.com with SMTP id t20so3914995uao.7;
 Fri, 13 Mar 2020 11:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YeVTQOf6rtHWhmWd6q33ZsNwxEbBRUt5T26QVD7T45E=;
 b=Xare2t6LOXCCiRVHvD1QaxW41w5cV67Ti/5iUeWqAsue5NTL2d2P7pxUET9o668UFX
 JUqdVj7tSHn0PghH569qtfAHodeSSaRtFVdXc6fmokfPpTjo83dYKwPl0LXNUVSsuMem
 ILsviY4rR5xfo73jW3mraymShAulWxaUyvt1jM/eQLvgJK7RHXtBJtCbsPTZ5926z+u+
 C4Ydl8KdmRoKIsTAakZ6sObY+InLgmMM4vf4mxnAe+GPo4nrRDNRO7K3pIY+c4vO77Wu
 l6zlLwyzqvwA0SHE/3zFOADWDfxHeH+TEiJmeRQL1CGQjOXIa/7jQ97ezl4T1J2L8hX5
 NU2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YeVTQOf6rtHWhmWd6q33ZsNwxEbBRUt5T26QVD7T45E=;
 b=kX5aSh1EgI9ybVx6k2XJYBg7WyMvXE8JKPrTcGOUjB99skBlxxBpcPjlSnWgpvKfdz
 6u9cbrlyBR0wZwjiKBISi69fx7h3SlZxJQy4w/U7+fjTKnUd0/2JpeZpThnO9hCLoF3s
 stg+Rf0NTGRSEC1iDZT+5NPoajETDApmwTyivGOVG8dxZj/BKwxHkzS7uoXmam4/zAkr
 JqLLet0+Y2yFwJnSxAtZUP2Z0tCpuct81ImHIZTrGfVxmk04MF5DGEKeieDifZkrYtrY
 euwiwweBxiDYWdthnSyD1qm5j0mg9cAcQm5RUSCOBnnFHhGB9nCUaCTu99kUZ7Akqsyi
 tEfQ==
X-Gm-Message-State: ANhLgQ0+ePf1UZwwjdyooTEn1pujJeevUhM426ibhUMN3utHjb5K1kd7
 0gXSrQzwCTQFSODPhRm6QtZ3d4NEO3aYfYZZqec=
X-Google-Smtp-Source: ADFU+vu5f13DtUswJwOEUXBneNM5E60MeXMzyOBDV/MxkvTjesbqkGztkY0f55yEXyyxCzTCcKVkqpJ8C1mE5me4rgg=
X-Received: by 2002:a9f:3311:: with SMTP id o17mr9495641uab.30.1584124366851; 
 Fri, 13 Mar 2020 11:32:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200313005508.1906-1-coreyw7@fb.com>
 <20200313005508.1906-2-coreyw7@fb.com>
In-Reply-To: <20200313005508.1906-2-coreyw7@fb.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 13 Mar 2020 11:32:20 -0700
Message-ID: <CAKmqyKMK+nharq3_FbUFKACjg7yODjT7cg6VTqAWLjQ5U4fhOg@mail.gmail.com>
Subject: Re: [PATCH 1/2] riscv: sifive_e: Support changing CPU type
To: Corey Wharton <coreyw7@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::942
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Mar 12, 2020 at 5:58 PM Corey Wharton <coreyw7@fb.com> wrote:
>
> Allows the CPU to be changed from the default via the -cpu command
> line option.
>
> Signed-off-by: Corey Wharton <coreyw7@fb.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/sifive_e.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
> index a254cad489..b0a611adb9 100644
> --- a/hw/riscv/sifive_e.c
> +++ b/hw/riscv/sifive_e.c
> @@ -123,7 +123,7 @@ static void riscv_sifive_e_soc_init(Object *obj)
>      object_initialize_child(obj, "cpus", &s->cpus,
>                              sizeof(s->cpus), TYPE_RISCV_HART_ARRAY,
>                              &error_abort, NULL);
> -    object_property_set_str(OBJECT(&s->cpus), SIFIVE_E_CPU, "cpu-type",
> +    object_property_set_str(OBJECT(&s->cpus), ms->cpu_type, "cpu-type",
>                              &error_abort);
>      object_property_set_int(OBJECT(&s->cpus), ms->smp.cpus, "num-harts",
>                              &error_abort);
> @@ -220,6 +220,7 @@ static void riscv_sifive_e_machine_init(MachineClass *mc)
>      mc->desc = "RISC-V Board compatible with SiFive E SDK";
>      mc->init = riscv_sifive_e_init;
>      mc->max_cpus = 1;
> +    mc->default_cpu_type = SIFIVE_E_CPU;
>  }
>
>  DEFINE_MACHINE("sifive_e", riscv_sifive_e_machine_init)
> --
> 2.21.1
>
>

