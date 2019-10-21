Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932D5CA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 06:26:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A4142067B
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 06:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9G3y4hp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A4142067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMR91-0002IZ-9h
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 02:26:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42265)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iMR7w-0001WG-Au
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 02:25:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iMR7u-00044v-GU
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 02:25:12 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:39595)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iMR7u-00044Y-Ay; Mon, 21 Oct 2019 02:25:10 -0400
Received: by mail-ot1-x342.google.com with SMTP id s22so10003554otr.6;
 Sun, 20 Oct 2019 23:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=rmlrOvahKodlraOulz4ED3OPmzyOXNBOtDy7atqv9jQ=;
 b=E9G3y4hpVHgkbF1w4KSScZ9/CUFIW8MPstlfQ75AACBJu4V2W4my9PoVm7MCM6nz5J
 QDTkTCLS+kLootzntMTqV/Y95cZpreBoc6N3oUHm0E04Nt9AXC77LyGAZtndG7KNA+Tt
 YunioIdDNHZRVUFwydc1iFcyPq4n79p2WKWph1BY/e8RXlASI63ZpgjHZDicJ7SEppwx
 naVyr7iZ2AwlZ109BBX4rI0qGhRNAlELWhqSfUjFXy2Xq46p42E2yf/5uBoJJei38OBD
 eMkPfjbk3aPH7HkqSdMQqVkK82mz+C/iKuyc5qN//wQXIgXHf24dr+mdNKFBqQ/dDKkZ
 yVuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=rmlrOvahKodlraOulz4ED3OPmzyOXNBOtDy7atqv9jQ=;
 b=A3E9Q4ztmDRmyXCyz8nSUCxapIyLOFSgqQAlNamzn7/Q0ZFjReuKDFqMbehvC8VI6x
 vH784qknTE/QgpN0qkNigv544mOZ6yLpCZGINal30EYnVG+Ud623QSPpYDdsUIqZIGF2
 YXfjuqfqeVJxGDEFP+4XrjZC4oZMbBYeOXcTRiuAA88jDK8PgDwAt8Eix7lL1oNKrL9J
 h2r1QvTgrhZDXHajvHe/9AEwnqk/WhM7rztOKjjRFMACpU+MijgMjf5XOSpbjRhagSph
 nmILwsn8I4wrmEf3Tz/PL4wWE2iv6uQ81EliI6kbmb2N/hPNbclY8ZK40RA402kbmp7p
 /Evg==
X-Gm-Message-State: APjAAAWdnbnC+0FqQWImI63LxBq4j7XYmXrmlFHsEcPJQcydoh9gOmLd
 2WaLOYh9GP7mcVhNQ19ojb2SPpXR47Q/zsbJEnA=
X-Google-Smtp-Source: APXvYqw3Vw8koErkNVb0UJNjPhg6oQ7cIIp+7PGaHe5BL3RMVWJTLDpp/xAac4uDKyAIg51D41zLcI6D1xdBndV8trk=
X-Received: by 2002:a05:6830:452:: with SMTP id
 d18mr17793981otc.295.1571639108992; 
 Sun, 20 Oct 2019 23:25:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Sun, 20 Oct 2019 23:25:08
 -0700 (PDT)
In-Reply-To: <20191020225650.3671-19-philmd@redhat.com>
References: <20191020225650.3671-1-philmd@redhat.com>
 <20191020225650.3671-19-philmd@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 21 Oct 2019 08:25:08 +0200
Message-ID: <CAL1e-=ivk8phw5SOd=a6SO8RJ4E=9kN8hN0tocQYcb7AEKeyEA@mail.gmail.com>
Subject: Re: [PATCH 18/21] hw/mips: Let the machine be the owner of the system
 memory
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000ce8753059565bef2"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
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
 Beniamino Galvani <b.galvani@gmail.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 Peter Chubb <peter.chubb@nicta.com.au>, Fabien Chouteau <chouteau@adacore.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, Andrew Jeffery <andrew@aj.id.au>,
 Michael Walle <michael@walle.cc>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000ce8753059565bef2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Monday, October 21, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
>
wrote:

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/mips/boston.c        | 2 +-
>  hw/mips/mips_fulong2e.c | 3 ++-
>  hw/mips/mips_jazz.c     | 2 +-
>  hw/mips/mips_malta.c    | 2 +-
>  hw/mips/mips_mipssim.c  | 2 +-
>  hw/mips/mips_r4k.c      | 3 ++-
>  6 files changed, 8 insertions(+), 6 deletions(-)
>
>
Philippe, can this patch be applied independently (on other patches of this
series)?

Thanks,
A.




> diff --git a/hw/mips/boston.c b/hw/mips/boston.c
> index ca7d813a52..8445fee0f1 100644
> --- a/hw/mips/boston.c
> +++ b/hw/mips/boston.c
> @@ -474,7 +474,7 @@ static void boston_mach_init(MachineState *machine)
>      memory_region_add_subregion_overlap(sys_mem, 0x18000000, flash, 0);
>
>      ddr =3D g_new(MemoryRegion, 1);
> -    memory_region_allocate_system_memory(ddr, NULL, "boston.ddr",
> +    memory_region_allocate_system_memory(ddr, machine, "boston.ddr",
>                                           machine->ram_size);
>      memory_region_add_subregion_overlap(sys_mem, 0x80000000, ddr, 0);
>
> diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
> index cf537dd7e6..d5a5cef619 100644
> --- a/hw/mips/mips_fulong2e.c
> +++ b/hw/mips/mips_fulong2e.c
> @@ -318,7 +318,8 @@ static void mips_fulong2e_init(MachineState *machine)
>      ram_size =3D 256 * MiB;
>
>      /* allocate RAM */
> -    memory_region_allocate_system_memory(ram, NULL, "fulong2e.ram",
> ram_size);
> +    memory_region_allocate_system_memory(ram, machine,
> +                                         "fulong2e.ram", ram_size);
>      memory_region_init_ram(bios, NULL, "fulong2e.bios", BIOS_SIZE,
>                             &error_fatal);
>      memory_region_set_readonly(bios, true);
> diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
> index 8d010a0b6e..88b125855f 100644
> --- a/hw/mips/mips_jazz.c
> +++ b/hw/mips/mips_jazz.c
> @@ -188,7 +188,7 @@ static void mips_jazz_init(MachineState *machine,
>      cc->do_transaction_failed =3D mips_jazz_do_transaction_failed;
>
>      /* allocate RAM */
> -    memory_region_allocate_system_memory(ram, NULL, "mips_jazz.ram",
> +    memory_region_allocate_system_memory(ram, machine, "mips_jazz.ram",
>                                           machine->ram_size);
>      memory_region_add_subregion(address_space, 0, ram);
>
> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index 4d9c64b36a..af56a29ccb 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -1267,7 +1267,7 @@ void mips_malta_init(MachineState *machine)
>      }
>
>      /* register RAM at high address where it is undisturbed by IO */
> -    memory_region_allocate_system_memory(ram_high, NULL,
> "mips_malta.ram",
> +    memory_region_allocate_system_memory(ram_high, machine,
> "mips_malta.ram",
>                                           ram_size);
>      memory_region_add_subregion(system_memory, 0x80000000, ram_high);
>
> diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c
> index 282bbecb24..c1933231e2 100644
> --- a/hw/mips/mips_mipssim.c
> +++ b/hw/mips/mips_mipssim.c
> @@ -166,7 +166,7 @@ mips_mipssim_init(MachineState *machine)
>      qemu_register_reset(main_cpu_reset, reset_info);
>
>      /* Allocate RAM. */
> -    memory_region_allocate_system_memory(ram, NULL, "mips_mipssim.ram",
> +    memory_region_allocate_system_memory(ram, machine,
> "mips_mipssim.ram",
>                                           ram_size);
>      memory_region_init_ram(bios, NULL, "mips_mipssim.bios", BIOS_SIZE,
>                             &error_fatal);
> diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
> index bc0be26544..59f8cacfb6 100644
> --- a/hw/mips/mips_r4k.c
> +++ b/hw/mips/mips_r4k.c
> @@ -203,7 +203,8 @@ void mips_r4k_init(MachineState *machine)
>                       " maximum 256MB", ram_size / MiB);
>          exit(1);
>      }
> -    memory_region_allocate_system_memory(ram, NULL, "mips_r4k.ram",
> ram_size);
> +    memory_region_allocate_system_memory(ram, machine, "mips_r4k.ram",
> +                                         ram_size);
>
>      memory_region_add_subregion(address_space_mem, 0, ram);
>
> --
> 2.21.0
>
>
>

--000000000000ce8753059565bef2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Monday, October 21, 2019, Philippe Mathieu-Daud=C3=A9 &lt;<a hre=
f=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; wrote:<br><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc s=
olid;padding-left:1ex">Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a hr=
ef=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt;<br>
---<br>
=C2=A0hw/mips/boston.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 +-<br>
=C2=A0hw/mips/mips_fulong2e.c | 3 ++-<br>
=C2=A0hw/mips/mips_jazz.c=C2=A0 =C2=A0 =C2=A0| 2 +-<br>
=C2=A0hw/mips/mips_malta.c=C2=A0 =C2=A0 | 2 +-<br>
=C2=A0hw/mips/mips_mipssim.c=C2=A0 | 2 +-<br>
=C2=A0hw/mips/mips_r4k.c=C2=A0 =C2=A0 =C2=A0 | 3 ++-<br>
=C2=A06 files changed, 8 insertions(+), 6 deletions(-)<br>
<br></blockquote><div><br></div><div>Philippe, can this patch be applied in=
dependently (on other patches of this series)?</div><div><br></div><div>Tha=
nks,</div><div>A.</div><div><br></div><div><br></div><div>=C2=A0</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex">
diff --git a/hw/mips/boston.c b/hw/mips/boston.c<br>
index ca7d813a52..8445fee0f1 100644<br>
--- a/hw/mips/boston.c<br>
+++ b/hw/mips/boston.c<br>
@@ -474,7 +474,7 @@ static void boston_mach_init(MachineState *machine)<br>
=C2=A0 =C2=A0 =C2=A0memory_region_add_subregion_<wbr>overlap(sys_mem, 0x180=
00000, flash, 0);<br>
<br>
=C2=A0 =C2=A0 =C2=A0ddr =3D g_new(MemoryRegion, 1);<br>
-=C2=A0 =C2=A0 memory_region_allocate_system_<wbr>memory(ddr, NULL, &quot;b=
oston.ddr&quot;,<br>
+=C2=A0 =C2=A0 memory_region_allocate_system_<wbr>memory(ddr, machine, &quo=
t;boston.ddr&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 m=
achine-&gt;ram_size);<br>
=C2=A0 =C2=A0 =C2=A0memory_region_add_subregion_<wbr>overlap(sys_mem, 0x800=
00000, ddr, 0);<br>
<br>
diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c<br>
index cf537dd7e6..d5a5cef619 100644<br>
--- a/hw/mips/mips_fulong2e.c<br>
+++ b/hw/mips/mips_fulong2e.c<br>
@@ -318,7 +318,8 @@ static void mips_fulong2e_init(<wbr>MachineState *machi=
ne)<br>
=C2=A0 =C2=A0 =C2=A0ram_size =3D 256 * MiB;<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* allocate RAM */<br>
-=C2=A0 =C2=A0 memory_region_allocate_system_<wbr>memory(ram, NULL, &quot;f=
ulong2e.ram&quot;, ram_size);<br>
+=C2=A0 =C2=A0 memory_region_allocate_system_<wbr>memory(ram, machine,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&q=
uot;fulong2e.ram&quot;, ram_size);<br>
=C2=A0 =C2=A0 =C2=A0memory_region_init_ram(bios, NULL, &quot;fulong2e.bios&=
quot;, BIOS_SIZE,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 &amp;error_fatal);<br>
=C2=A0 =C2=A0 =C2=A0memory_region_set_readonly(<wbr>bios, true);<br>
diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c<br>
index 8d010a0b6e..88b125855f 100644<br>
--- a/hw/mips/mips_jazz.c<br>
+++ b/hw/mips/mips_jazz.c<br>
@@ -188,7 +188,7 @@ static void mips_jazz_init(MachineState *machine,<br>
=C2=A0 =C2=A0 =C2=A0cc-&gt;do_transaction_failed =3D mips_jazz_do_transacti=
on_<wbr>failed;<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* allocate RAM */<br>
-=C2=A0 =C2=A0 memory_region_allocate_system_<wbr>memory(ram, NULL, &quot;m=
ips_jazz.ram&quot;,<br>
+=C2=A0 =C2=A0 memory_region_allocate_system_<wbr>memory(ram, machine, &quo=
t;mips_jazz.ram&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 m=
achine-&gt;ram_size);<br>
=C2=A0 =C2=A0 =C2=A0memory_region_add_subregion(<wbr>address_space, 0, ram)=
;<br>
<br>
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c<br>
index 4d9c64b36a..af56a29ccb 100644<br>
--- a/hw/mips/mips_malta.c<br>
+++ b/hw/mips/mips_malta.c<br>
@@ -1267,7 +1267,7 @@ void mips_malta_init(MachineState *machine)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* register RAM at high address where it is undisturbed=
 by IO */<br>
-=C2=A0 =C2=A0 memory_region_allocate_system_<wbr>memory(ram_high, NULL, &q=
uot;mips_malta.ram&quot;,<br>
+=C2=A0 =C2=A0 memory_region_allocate_system_<wbr>memory(ram_high, machine,=
 &quot;mips_malta.ram&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r=
am_size);<br>
=C2=A0 =C2=A0 =C2=A0memory_region_add_subregion(<wbr>system_memory, 0x80000=
000, ram_high);<br>
<br>
diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c<br>
index 282bbecb24..c1933231e2 100644<br>
--- a/hw/mips/mips_mipssim.c<br>
+++ b/hw/mips/mips_mipssim.c<br>
@@ -166,7 +166,7 @@ mips_mipssim_init(MachineState *machine)<br>
=C2=A0 =C2=A0 =C2=A0qemu_register_reset(main_cpu_<wbr>reset, reset_info);<b=
r>
<br>
=C2=A0 =C2=A0 =C2=A0/* Allocate RAM. */<br>
-=C2=A0 =C2=A0 memory_region_allocate_system_<wbr>memory(ram, NULL, &quot;m=
ips_mipssim.ram&quot;,<br>
+=C2=A0 =C2=A0 memory_region_allocate_system_<wbr>memory(ram, machine, &quo=
t;mips_mipssim.ram&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r=
am_size);<br>
=C2=A0 =C2=A0 =C2=A0memory_region_init_ram(bios, NULL, &quot;mips_mipssim.b=
ios&quot;, BIOS_SIZE,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 &amp;error_fatal);<br>
diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c<br>
index bc0be26544..59f8cacfb6 100644<br>
--- a/hw/mips/mips_r4k.c<br>
+++ b/hw/mips/mips_r4k.c<br>
@@ -203,7 +203,8 @@ void mips_r4k_init(MachineState *machine)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &quot; maximum 256MB&quot;, ram_size / MiB);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(1);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 memory_region_allocate_system_<wbr>memory(ram, NULL, &quot;m=
ips_r4k.ram&quot;, ram_size);<br>
+=C2=A0 =C2=A0 memory_region_allocate_system_<wbr>memory(ram, machine, &quo=
t;mips_r4k.ram&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ra=
m_size);<br>
<br>
=C2=A0 =C2=A0 =C2=A0memory_region_add_subregion(<wbr>address_space_mem, 0, =
ram);<br>
=C2=A0<br>
-- <br>
2.21.0<br>
<br>
<br>
</blockquote>

--000000000000ce8753059565bef2--

