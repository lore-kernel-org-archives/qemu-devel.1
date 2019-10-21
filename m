Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D2CCA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 21:05:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E48982086D
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 21:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aIOG1F3j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E48982086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMes6-0000bZ-Ql
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 17:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43166)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iMepe-0007bm-4r
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 17:03:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iMepc-0000ET-Tb
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 17:03:13 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:42821)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iMepc-0000DU-MM; Mon, 21 Oct 2019 17:03:12 -0400
Received: by mail-lf1-x144.google.com with SMTP id z12so11248471lfj.9;
 Mon, 21 Oct 2019 14:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ugJia3nKS2YoLHkGk7Se+jzfpJkArUWn8r2/dXCG3aw=;
 b=aIOG1F3jo+dKk8/FHmolN3iPlrW2vNnECCf4rkpL5J70OFlGdvKRV4qYKxyWMQ95S9
 N46uP5rT52Lkqmr10gzx6Mna0t5SSEJ7mlCEAIwUlf82Xw1ZnvQb2ZJPCTeuXm9BSyto
 n6GaZsITLDzavUU2QykqragOgzPZfM8LLuOnX5UMqE4fM9WO/O5RR000L6AsHFbjzUEw
 VLA4EgEy/s1D39zGqbPZ3PELmUVxOrdqeTAOfFAwV+K7Wgf43FdXUAXP9Nn90HSPoHpP
 9fnbJvlbA7Hob8gZQRb3Onz0BrKHVbVlLl8sr8/FjfefqTSug532YnxFqV297iDT2Y2i
 r9Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ugJia3nKS2YoLHkGk7Se+jzfpJkArUWn8r2/dXCG3aw=;
 b=AKk8MRLMJqimzuJInyL2X8K3R9YueGAVP1Noi0yS/NbKBEt3Ul8PBqtM0nol42LCcX
 wrquPqhFB9Ia1m9MV+s0s1YRRyvIP+g7CEf/0fekZxtv52HfEusczG4Z7SvUBNP9egOd
 M/3NcK1C+5EU6eX/v7qvXu1Sma7sEj8WrVLDSRAIXx4vzpQdvJ2uA8TZYmj7f/r3KrDN
 Wq4kITF5jRhUiBt9ShL0MN5ovAzT0iRmlNL3wPFUQqBnqJmJCcx3BxnYEsn6w1qZS7/E
 2r6ay5fDDSEV9Enrj5MtSv8vyj/qF6flWRs6qS/0dw+Z6mPxr1iBJhCSNl4yoOQ4i4ZG
 MMiQ==
X-Gm-Message-State: APjAAAWowC2JcB+PQ1JTqAD8UDQjX47foFXxGAg7Zo8bY2HwrcNm3JXg
 by2SyOpKVJsZ8OOpf5cxhdDnotet+NzyLt0OCXM=
X-Google-Smtp-Source: APXvYqxLRpcBS0t/n4tmMQauV19gHY8VGg5o3pUzKGJIdrmoivbi1CifBz+B9NHm9VqLXWHiuxXkPEEfAB4yj64ctPE=
X-Received: by 2002:a19:dc4c:: with SMTP id f12mr15256659lfj.86.1571691790186; 
 Mon, 21 Oct 2019 14:03:10 -0700 (PDT)
MIME-Version: 1.0
References: <20191020225650.3671-1-philmd@redhat.com>
 <20191020225650.3671-18-philmd@redhat.com>
In-Reply-To: <20191020225650.3671-18-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 21 Oct 2019 13:57:53 -0700
Message-ID: <CAKmqyKM-urjxM1TH+DXFrbJscuJPz6wDhNsqHgJisiVcmfXpRQ@mail.gmail.com>
Subject: Re: [PATCH 17/21] hw/m68k: Let the machine be the owner of the system
 memory
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::144
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

On Sun, Oct 20, 2019 at 4:20 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/m68k/an5206.c    | 2 +-
>  hw/m68k/mcf5208.c   | 2 +-
>  hw/m68k/next-cube.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/hw/m68k/an5206.c b/hw/m68k/an5206.c
> index 54ccbe1a82..fb045c2436 100644
> --- a/hw/m68k/an5206.c
> +++ b/hw/m68k/an5206.c
> @@ -46,7 +46,7 @@ static void an5206_init(MachineState *machine)
>      env->rambar0 =3D AN5206_RAMBAR_ADDR | 1;
>
>      /* DRAM at address zero */
> -    memory_region_allocate_system_memory(ram, NULL, "an5206.ram", ram_si=
ze);
> +    memory_region_allocate_system_memory(ram, machine, "an5206.ram", ram=
_size);
>      memory_region_add_subregion(address_space_mem, 0, ram);
>
>      /* Internal SRAM.  */
> diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
> index 34d34eba17..8e8c8ef349 100644
> --- a/hw/m68k/mcf5208.c
> +++ b/hw/m68k/mcf5208.c
> @@ -248,7 +248,7 @@ static void mcf5208evb_init(MachineState *machine)
>      memory_region_add_subregion(address_space_mem, 0x00000000, rom);
>
>      /* DRAM at 0x40000000 */
> -    memory_region_allocate_system_memory(ram, NULL, "mcf5208.ram", ram_s=
ize);
> +    memory_region_allocate_system_memory(ram, machine, "mcf5208.ram", ra=
m_size);
>      memory_region_add_subregion(address_space_mem, 0x40000000, ram);
>
>      /* Internal SRAM.  */
> diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
> index e5343348d0..6aed9376f3 100644
> --- a/hw/m68k/next-cube.c
> +++ b/hw/m68k/next-cube.c
> @@ -893,7 +893,7 @@ static void next_cube_init(MachineState *machine)
>      memcpy(ns->rtc.ram, rtc_ram2, 32);
>
>      /* 64MB RAM starting at 0x04000000  */
> -    memory_region_allocate_system_memory(ram, NULL, "next.ram", ram_size=
);
> +    memory_region_allocate_system_memory(ram, machine, "next.ram", ram_s=
ize);
>      memory_region_add_subregion(sysmem, 0x04000000, ram);
>
>      /* Framebuffer */
> --
> 2.21.0
>
>

