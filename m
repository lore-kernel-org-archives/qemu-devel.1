Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289CECA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 20:55:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5C382084B
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 20:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="odAYjHeq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5C382084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMeib-0001QN-2f
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 16:55:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41850)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iMehJ-0000J1-Uv
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 16:54:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iMehI-0002r7-SA
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 16:54:37 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:44397)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iMehI-0002py-Js; Mon, 21 Oct 2019 16:54:36 -0400
Received: by mail-lj1-x241.google.com with SMTP id m13so14795727ljj.11;
 Mon, 21 Oct 2019 13:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=y6PVkJluZrdtoJOj1jT41eZt37CmWiN7V3jyZ1GlLCw=;
 b=odAYjHeqwVexzxm/u+uSQ5ftyJsVAQzQ/hST9cvQxy1vwt8VgzQj3liADO0WbAGnLy
 XmjodAo1vn/NZttgA/l5WxZs0gkh637DamTNBjcHFYOSa9KUmjI+RAnGRQ7k9OBm+eRf
 fXdNoorlWFngZU/wUzHvZJ98GUD7ZuuJ9J+4f3SY6+QVN2eiXfJzmiPHRjQvyI6fXJw8
 uMZkbiF06xj63KJvZZJAHjVsfIO01atpjzuyDAJE/I9B+qFrkiDnFnG1gM/6O6WPJc8k
 pK/SbeGf7qFhqtabZzpxTMCnBOncSJ0SXaF+n4Xg3E/F05xL8Z+pLyvA7YkEhTHnpETo
 Xk1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=y6PVkJluZrdtoJOj1jT41eZt37CmWiN7V3jyZ1GlLCw=;
 b=XnqP6GGdgdtX8kKimMeA+mr0qw/IhVT/XFmbQJ0L5VsItOmNis1mI/Z/S9GQHrSVmm
 lC5ACQyYg4/q9dRxH41aLOm/wrweVRL5J2PLXIRlrqjolcMHJFrd2Qhv4Jvux4eZdyRo
 9JZ8Yf28nI7gCkQaYwnIoI/GBT2KKDUZxDLdPYfaGNP3bo8DXIcUuU3W6Fb241N4h9GK
 x/70RPbN50qarxy6TpM+L2FLJATnDAtECSlw3zxE8lpyKGcX26/n5AekLB26GErn3kk4
 9SLGovdIh/BRxToDBxRSuZKOu02XHYchqjON+JAgalsFLqWLpOLqbcFV+iPJj4BjmkK/
 jBrA==
X-Gm-Message-State: APjAAAWhGFvO9lp6YLKHFs/6Ot2kzJ6PulAwLB6qHRearzxvxxPPhRb9
 3kQ4k5Ykrplyxj7O0wpWD+KGwrbvej2yusbAQck=
X-Google-Smtp-Source: APXvYqxKQ/5BA2PYmKZRF7wUrbqV/yWo67MblngiIFeI8vJgkCLk758Hp0kX25u/iPi8UOvdSE5o1H36Rj2PFK4oM6U=
X-Received: by 2002:a2e:9890:: with SMTP id b16mr16586980ljj.4.1571691275252; 
 Mon, 21 Oct 2019 13:54:35 -0700 (PDT)
MIME-Version: 1.0
References: <20191020225650.3671-1-philmd@redhat.com>
 <20191020225650.3671-4-philmd@redhat.com>
In-Reply-To: <20191020225650.3671-4-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 21 Oct 2019 13:49:16 -0700
Message-ID: <CAKmqyKNAcJjcF+8A4tN3gGYsjD3DUPbOzXOcm49wvXWgVq6bFA@mail.gmail.com>
Subject: Re: [PATCH 03/21] hw/arm/collie: Create the RAM in the board
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::241
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

On Sun, Oct 20, 2019 at 3:59 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> The SDRAM is incorrectly created in the SA1110 SoC.
> Move its creation in the board code, this will later allow the
> board to have the QOM ownership of the RAM.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/arm/collie.c    | 8 ++++++--
>  hw/arm/strongarm.c | 7 +------
>  hw/arm/strongarm.h | 4 +---
>  3 files changed, 8 insertions(+), 11 deletions(-)
>
> diff --git a/hw/arm/collie.c b/hw/arm/collie.c
> index b1288ccea8..970a4405cc 100644
> --- a/hw/arm/collie.c
> +++ b/hw/arm/collie.c
> @@ -27,9 +27,13 @@ static void collie_init(MachineState *machine)
>  {
>      StrongARMState *s;
>      DriveInfo *dinfo;
> -    MemoryRegion *sysmem =3D get_system_memory();
> +    MemoryRegion *sdram =3D g_new(MemoryRegion, 1);
>
> -    s =3D sa1110_init(sysmem, collie_binfo.ram_size, machine->cpu_type);
> +    s =3D sa1110_init(machine->cpu_type);
> +
> +    memory_region_allocate_system_memory(sdram, NULL, "strongarm.sdram",
> +                                         collie_binfo.ram_size);
> +    memory_region_add_subregion(get_system_memory(), SA_SDCS0, sdram);
>
>      dinfo =3D drive_get(IF_PFLASH, 0, 0);
>      pflash_cfi01_register(SA_CS0, "collie.fl1", 0x02000000,
> diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
> index dc65d88a65..6bee034914 100644
> --- a/hw/arm/strongarm.c
> +++ b/hw/arm/strongarm.c
> @@ -1586,8 +1586,7 @@ static const TypeInfo strongarm_ssp_info =3D {
>  };
>
>  /* Main CPU functions */
> -StrongARMState *sa1110_init(MemoryRegion *sysmem,
> -                            unsigned int sdram_size, const char *cpu_typ=
e)
> +StrongARMState *sa1110_init(const char *cpu_type)
>  {
>      StrongARMState *s;
>      int i;
> @@ -1601,10 +1600,6 @@ StrongARMState *sa1110_init(MemoryRegion *sysmem,
>
>      s->cpu =3D ARM_CPU(cpu_create(cpu_type));
>
> -    memory_region_allocate_system_memory(&s->sdram, NULL, "strongarm.sdr=
am",
> -                                         sdram_size);
> -    memory_region_add_subregion(sysmem, SA_SDCS0, &s->sdram);
> -
>      s->pic =3D sysbus_create_varargs("strongarm_pic", 0x90050000,
>                      qdev_get_gpio_in(DEVICE(s->cpu), ARM_CPU_IRQ),
>                      qdev_get_gpio_in(DEVICE(s->cpu), ARM_CPU_FIQ),
> diff --git a/hw/arm/strongarm.h b/hw/arm/strongarm.h
> index e98840b461..192821f6aa 100644
> --- a/hw/arm/strongarm.h
> +++ b/hw/arm/strongarm.h
> @@ -55,7 +55,6 @@ enum {
>
>  typedef struct {
>      ARMCPU *cpu;
> -    MemoryRegion sdram;
>      DeviceState *pic;
>      DeviceState *gpio;
>      DeviceState *ppc;
> @@ -63,7 +62,6 @@ typedef struct {
>      SSIBus *ssp_bus;
>  } StrongARMState;
>
> -StrongARMState *sa1110_init(MemoryRegion *sysmem,
> -                            unsigned int sdram_size, const char *rev);
> +StrongARMState *sa1110_init(const char *cpu_type);
>
>  #endif
> --
> 2.21.0
>
>

