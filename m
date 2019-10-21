Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DE3CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 21:10:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED7C02086D
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 21:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avK+l72v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED7C02086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMewU-0004vO-7L
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 17:10:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43075)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iMep8-00079U-1B
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 17:02:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iMep7-0008NY-0I
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 17:02:41 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:41261)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iMep6-0008N0-P6; Mon, 21 Oct 2019 17:02:40 -0400
Received: by mail-lf1-x143.google.com with SMTP id x4so4951397lfn.8;
 Mon, 21 Oct 2019 14:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=/4GYEEZxPx2EoffTa5gB5GuX2Y2RuIDNsIu83WJIHSs=;
 b=avK+l72vFf0cK4Rb/qZDKD64x6px5QGuyrqSm6Jj1tKlPMyZh9tA8t3aLS0yUx/2dK
 YRQF6eCjEUERU7qfI8ZoOeQb1zaN+lpQaYgB4qD4pDgoXR5MjPFtF4sOWanA8Llg8gt5
 h9Wrc6PEfjjxg+nbtoihbJCfQGa9E3THG9Bc8q4PN4Qvd3KebBlQGav9co4o6l2H4beO
 5I6ln8a2H7zzqJUHe/tZIe8woJ4c7W7WKwiFX8VKQ/6rw2k6BRka+idggGKg6sHk7FCF
 Fc+glqMOEYL/7/RyrvzbRTiy161re3LHePmT9SCU0JexSYmNpOtclHonbta7etrF3XQj
 vVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=/4GYEEZxPx2EoffTa5gB5GuX2Y2RuIDNsIu83WJIHSs=;
 b=nA4U0m4d8JFgkXw386bJapS5pNM8s80JNo9T0V5ctdqp8IqUeAamoBRDNRfGahF3fw
 bB1ewZ0fEj8756JpRBuT7a3TM85sxmTiMJXNbwxFeTOo33T/rvFF8uhPEqMEksV6+Veo
 Ik+4cX5oUm4zJYGAQ3V0Dw5mpxyfyZ/mxAU/nMBeJRS1+5mXWfxhvUZOqvcetSHjaV9l
 tFTJf6QrZFJeG+6iho7vUz0M2iQfU93TWa8UEb35cjRyHDY22Q+n6usBl3aj+T0HnsZL
 7H5olq/i+Io2GlpkqunSRo14mKmX44MxTy/YCtnw1/LGbYn/6VelDa3WVxCxwYNM2khV
 nFFA==
X-Gm-Message-State: APjAAAVbDl7hqwcBG/5yC0Lv8HigGPxA/pHW/lQfaTtMwHKyaWg2cQEI
 pzswq2o4ipq8voapGbLuk1AYGAo3B7NZP1Hr3UE=
X-Google-Smtp-Source: APXvYqx/KxjfDV9TM5XDHhrRh3MUN9QXw37nbG/w3gkIEuMflwJlEYvlVWuFPvXgjSkzq3JTvZ+eX9Hh0rSCfxjNRn8=
X-Received: by 2002:a19:855:: with SMTP id 82mr16116361lfi.44.1571691759285;
 Mon, 21 Oct 2019 14:02:39 -0700 (PDT)
MIME-Version: 1.0
References: <20191020225650.3671-1-philmd@redhat.com>
 <20191020225650.3671-17-philmd@redhat.com>
In-Reply-To: <20191020225650.3671-17-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 21 Oct 2019 13:57:23 -0700
Message-ID: <CAKmqyKN9pc+wLV0wUZYgCm9-35dZKdJAM-Yu6zMc0bwY5v8FVw@mail.gmail.com>
Subject: Re: [PATCH 16/21] hw/lm32: Let the machine be the owner of the system
 memory
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::143
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
Cc: Paul Burton <pburton@wavecomp.com>, Jan Kiszka <jan.kiszka@web.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Rob Herring <robh@kernel.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, Helge Deller <deller@gmx.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Antony Pavlov <antonynpavlov@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Joel Stanley <joel@jms.id.au>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Leif Lindholm <leif.lindholm@linaro.org>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Peter Chubb <peter.chubb@nicta.com.au>, Fabien Chouteau <chouteau@adacore.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, Andrew Jeffery <andrew@aj.id.au>,
 Michael Walle <michael@walle.cc>, "open list:New World" <qemu-ppc@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Oct 20, 2019 at 4:10 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/lm32/lm32_boards.c | 4 ++--
>  hw/lm32/milkymist.c   | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/hw/lm32/lm32_boards.c b/hw/lm32/lm32_boards.c
> index 5ae308bfcf..50b607e0cc 100644
> --- a/hw/lm32/lm32_boards.c
> +++ b/hw/lm32/lm32_boards.c
> @@ -107,7 +107,7 @@ static void lm32_evr_init(MachineState *machine)
>
>      reset_info->flash_base =3D flash_base;
>
> -    memory_region_allocate_system_memory(phys_ram, NULL, "lm32_evr.sdram=
",
> +    memory_region_allocate_system_memory(phys_ram, machine, "lm32_evr.sd=
ram",
>                                           ram_size);
>      memory_region_add_subregion(address_space_mem, ram_base, phys_ram);
>
> @@ -200,7 +200,7 @@ static void lm32_uclinux_init(MachineState *machine)
>
>      reset_info->flash_base =3D flash_base;
>
> -    memory_region_allocate_system_memory(phys_ram, NULL,
> +    memory_region_allocate_system_memory(phys_ram, machine,
>                                           "lm32_uclinux.sdram", ram_size)=
;
>      memory_region_add_subregion(address_space_mem, ram_base, phys_ram);
>
> diff --git a/hw/lm32/milkymist.c b/hw/lm32/milkymist.c
> index 460d322de5..ee2eb1877e 100644
> --- a/hw/lm32/milkymist.c
> +++ b/hw/lm32/milkymist.c
> @@ -116,7 +116,7 @@ milkymist_init(MachineState *machine)
>
>      cpu_lm32_set_phys_msb_ignore(env, 1);
>
> -    memory_region_allocate_system_memory(phys_sdram, NULL, "milkymist.sd=
ram",
> +    memory_region_allocate_system_memory(phys_sdram, machine, "milkymist=
.sdram",
>                                           sdram_size);
>      memory_region_add_subregion(address_space_mem, sdram_base, phys_sdra=
m);
>
> --
> 2.21.0
>
>

