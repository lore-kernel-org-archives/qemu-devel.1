Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE06C4BA0E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 11:45:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DB4D24687
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 11:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVt3YuRB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DB4D24687
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6v7l-00048C-KD
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 06:45:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56608)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j6v1L-0003AG-G9
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:38:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j6v1I-0001DN-PO
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:38:31 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:44368)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1j6v1I-0001B2-FC; Wed, 26 Feb 2020 06:38:28 -0500
Received: by mail-ot1-x342.google.com with SMTP id h9so2612734otj.11;
 Wed, 26 Feb 2020 03:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=ccsFE83qNAPbqZpbD6TR1q94Avth12/WtUGJcx1UV4U=;
 b=nVt3YuRB0mdL7ae7kuUct1iBfuvWAeq70L0IFy1al3TiBW9qLXpgKM5McxpGfjV3I5
 Uc/wK719kxtt0zzgWKACVpvO5GPVs6W4vTF24weGpoqMFGXDG/SgJre/afgAhRAXXGJg
 Op/kUYsotTEtlcMIGygau76e10Shz3ot2YlH1oikDpuR6tNEhjOP9T2kPazV7SOshbHE
 k+plPLEAWD9YDZeZYntIDHEQZMs01icvcJn5x//sYtjsZUiQdZccRFGr5KAec/Melhty
 YSxvCKokzun4M7MoJI9O/mkPQZOcYC04rIkeSIzreCOwwvlKJCQlzmblId8GAMMj4lfE
 oPHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=ccsFE83qNAPbqZpbD6TR1q94Avth12/WtUGJcx1UV4U=;
 b=I+Q0O8Q50yeI+Topwb+Ytiviav0ace2sVBPyorr1Z481XmWITWCd/4wTujfKqqb1nB
 +5ciP2p03bG1gFOHquvMubW/ch/xPR99zNpUF0yDXur5teIKtWlYDXw8HGDcBGEFw0oe
 k72ubwZXd14O0Id448mEFO9mP6/NRjxBskf1gvzRI2kylgpt9Jb+X/CQwduP5tZmXtDr
 56sUMKBR6I/2kubHrrMjNUR4jXqXgMj3ywrLlaUiKSyL0LlLD1PYntiWl9pBimd20sIj
 MyBFZ4q6huUmFiE9DBeS9KdRj16P2BI8O//1DTde7mKDCPSYfRn4kyXW+ks7ezEjEWAd
 YbGg==
X-Gm-Message-State: APjAAAW/ci+Ad7NgKUzh3pV3fJVNYwUFhDz4LZAizfNymc9OKC2YQZD/
 cgGAVIMl7y+omOBqLoi+eDe6kETQXsQqW/76nsM=
X-Google-Smtp-Source: APXvYqy8JRw8WtzzT/u5doN0Q6NXNYIyq3SXohc/WRUbpHhQCHv5s8+0MC792PwNzHhu3iko/ijrm8FH/ytkQ9suWsw=
X-Received: by 2002:a05:6830:1042:: with SMTP id
 b2mr2577487otp.306.1582717107523; 
 Wed, 26 Feb 2020 03:38:27 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Wed, 26 Feb 2020 03:38:27 -0800 (PST)
In-Reply-To: <20200224205533.23798-8-philmd@redhat.com>
References: <20200224205533.23798-1-philmd@redhat.com>
 <20200224205533.23798-8-philmd@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 26 Feb 2020 12:38:27 +0100
Message-ID: <CAL1e-=hJaaS4s=FnRhD4Bs7HOVom6WDvOMWya3359xzMPufYgA@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 07/32] hw/mips: Use memory_region_init_rom()
 with read-only regions
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000f955f9059f790a2a"
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Magnus Damm <magnus.damm@gmail.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Fabien Chouteau <chouteau@adacore.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 Peter Chubb <peter.chubb@nicta.com.au>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Laurent Vivier <laurent@vivier.eu>, Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Michael Walle <michael@walle.cc>, Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000f955f9059f790a2a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Monday, February 24, 2020, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m>
wrote:

> This commit was produced with the Coccinelle script
> scripts/coccinelle/memory-region-housekeeping.cocci.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---


Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

Will be applied to the next MIPS queue, planned to be sent in next few days=
.


>  hw/mips/mips_fulong2e.c | 3 +--
>  hw/mips/mips_jazz.c     | 6 ++----
>  hw/mips/mips_mipssim.c  | 3 +--
>  hw/mips/mips_r4k.c      | 3 +--
>  4 files changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
> index 2e043cbb98..547a7d3a45 100644
> --- a/hw/mips/mips_fulong2e.c
> +++ b/hw/mips/mips_fulong2e.c
> @@ -319,9 +319,8 @@ static void mips_fulong2e_init(MachineState *machine)
>
>      /* allocate RAM */
>      memory_region_allocate_system_memory(ram, NULL, "fulong2e.ram",
> ram_size);
> -    memory_region_init_ram(bios, NULL, "fulong2e.bios", BIOS_SIZE,
> +    memory_region_init_rom(bios, NULL, "fulong2e.bios", BIOS_SIZE,
>                             &error_fatal);
> -    memory_region_set_readonly(bios, true);
>
>      memory_region_add_subregion(address_space_mem, 0, ram);
>      memory_region_add_subregion(address_space_mem, 0x1fc00000LL, bios);
> diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
> index 66fd4d867d..cf47335ea5 100644
> --- a/hw/mips/mips_jazz.c
> +++ b/hw/mips/mips_jazz.c
> @@ -195,9 +195,8 @@ static void mips_jazz_init(MachineState *machine,
>                                           machine->ram_size);
>      memory_region_add_subregion(address_space, 0, ram);
>
> -    memory_region_init_ram(bios, NULL, "mips_jazz.bios", MAGNUM_BIOS_SIZ=
E,
> +    memory_region_init_rom(bios, NULL, "mips_jazz.bios", MAGNUM_BIOS_SIZ=
E,
>                             &error_fatal);
> -    memory_region_set_readonly(bios, true);
>      memory_region_init_alias(bios2, NULL, "mips_jazz.bios", bios,
>                               0, MAGNUM_BIOS_SIZE);
>      memory_region_add_subregion(address_space, 0x1fc00000LL, bios);
> @@ -263,9 +262,8 @@ static void mips_jazz_init(MachineState *machine,
>          {
>              /* Simple ROM, so user doesn't have to provide one */
>              MemoryRegion *rom_mr =3D g_new(MemoryRegion, 1);
> -            memory_region_init_ram(rom_mr, NULL, "g364fb.rom", 0x80000,
> +            memory_region_init_rom(rom_mr, NULL, "g364fb.rom", 0x80000,
>                                     &error_fatal);
> -            memory_region_set_readonly(rom_mr, true);
>              uint8_t *rom =3D memory_region_get_ram_ptr(rom_mr);
>              memory_region_add_subregion(address_space, 0x60000000,
> rom_mr);
>              rom[0] =3D 0x10; /* Mips G364 */
> diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c
> index b934ca9d51..3fdbb21680 100644
> --- a/hw/mips/mips_mipssim.c
> +++ b/hw/mips/mips_mipssim.c
> @@ -169,9 +169,8 @@ mips_mipssim_init(MachineState *machine)
>      /* Allocate RAM. */
>      memory_region_allocate_system_memory(ram, NULL, "mips_mipssim.ram",
>                                           ram_size);
> -    memory_region_init_ram(bios, NULL, "mips_mipssim.bios", BIOS_SIZE,
> +    memory_region_init_rom(bios, NULL, "mips_mipssim.bios", BIOS_SIZE,
>                             &error_fatal);
> -    memory_region_set_readonly(bios, true);
>
>      memory_region_add_subregion(address_space_mem, 0, ram);
>
> diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
> index b2aec434c3..54b286ceee 100644
> --- a/hw/mips/mips_r4k.c
> +++ b/hw/mips/mips_r4k.c
> @@ -241,9 +241,8 @@ void mips_r4k_init(MachineState *machine)
>      dinfo =3D drive_get(IF_PFLASH, 0, 0);
>      if ((bios_size > 0) && (bios_size <=3D BIOS_SIZE)) {
>          bios =3D g_new(MemoryRegion, 1);
> -        memory_region_init_ram(bios, NULL, "mips_r4k.bios", BIOS_SIZE,
> +        memory_region_init_rom(bios, NULL, "mips_r4k.bios", BIOS_SIZE,
>                                 &error_fatal);
> -        memory_region_set_readonly(bios, true);
>          memory_region_add_subregion(get_system_memory(), 0x1fc00000,
> bios);
>
>          load_image_targphys(filename, 0x1fc00000, BIOS_SIZE);
> --
> 2.21.1
>
>
>

--000000000000f955f9059f790a2a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Monday, February 24, 2020, Philippe Mathieu-Daud=C3=A9 &lt;<a hr=
ef=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; wrote:<br><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex">This commit was produced with the Coccinelle script=
<br>
scripts/coccinelle/memory-<wbr>region-housekeeping.cocci.<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@red=
hat.com">philmd@redhat.com</a>&gt;<br>
---</blockquote><div><br></div><div>Reviewed-by: Aleksandar Markovic &lt;<a=
 href=3D"mailto:amarkovic@wavecomp.com">amarkovic@wavecomp.com</a>&gt;<br><=
/div><div><br></div><div>Will be applied to the next MIPS queue, planned to=
 be sent in next few days.</div><div>=C2=A0</div><blockquote class=3D"gmail=
_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:=
1ex">
=C2=A0hw/mips/mips_fulong2e.c | 3 +--<br>
=C2=A0hw/mips/mips_jazz.c=C2=A0 =C2=A0 =C2=A0| 6 ++----<br>
=C2=A0hw/mips/mips_mipssim.c=C2=A0 | 3 +--<br>
=C2=A0hw/mips/mips_r4k.c=C2=A0 =C2=A0 =C2=A0 | 3 +--<br>
=C2=A04 files changed, 5 insertions(+), 10 deletions(-)<br>
<br>
diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c<br>
index 2e043cbb98..547a7d3a45 100644<br>
--- a/hw/mips/mips_fulong2e.c<br>
+++ b/hw/mips/mips_fulong2e.c<br>
@@ -319,9 +319,8 @@ static void mips_fulong2e_init(<wbr>MachineState *machi=
ne)<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* allocate RAM */<br>
=C2=A0 =C2=A0 =C2=A0memory_region_allocate_system_<wbr>memory(ram, NULL, &q=
uot;fulong2e.ram&quot;, ram_size);<br>
-=C2=A0 =C2=A0 memory_region_init_ram(bios, NULL, &quot;fulong2e.bios&quot;=
, BIOS_SIZE,<br>
+=C2=A0 =C2=A0 memory_region_init_rom(bios, NULL, &quot;fulong2e.bios&quot;=
, BIOS_SIZE,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 &amp;error_fatal);<br>
-=C2=A0 =C2=A0 memory_region_set_readonly(<wbr>bios, true);<br>
<br>
=C2=A0 =C2=A0 =C2=A0memory_region_add_subregion(<wbr>address_space_mem, 0, =
ram);<br>
=C2=A0 =C2=A0 =C2=A0memory_region_add_subregion(<wbr>address_space_mem, 0x1=
fc00000LL, bios);<br>
diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c<br>
index 66fd4d867d..cf47335ea5 100644<br>
--- a/hw/mips/mips_jazz.c<br>
+++ b/hw/mips/mips_jazz.c<br>
@@ -195,9 +195,8 @@ static void mips_jazz_init(MachineState *machine,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 m=
achine-&gt;ram_size);<br>
=C2=A0 =C2=A0 =C2=A0memory_region_add_subregion(<wbr>address_space, 0, ram)=
;<br>
<br>
-=C2=A0 =C2=A0 memory_region_init_ram(bios, NULL, &quot;mips_jazz.bios&quot=
;, MAGNUM_BIOS_SIZE,<br>
+=C2=A0 =C2=A0 memory_region_init_rom(bios, NULL, &quot;mips_jazz.bios&quot=
;, MAGNUM_BIOS_SIZE,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 &amp;error_fatal);<br>
-=C2=A0 =C2=A0 memory_region_set_readonly(<wbr>bios, true);<br>
=C2=A0 =C2=A0 =C2=A0memory_region_init_alias(<wbr>bios2, NULL, &quot;mips_j=
azz.bios&quot;, bios,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0, MAGNUM_BIOS_SIZE);<br>
=C2=A0 =C2=A0 =C2=A0memory_region_add_subregion(<wbr>address_space, 0x1fc00=
000LL, bios);<br>
@@ -263,9 +262,8 @@ static void mips_jazz_init(MachineState *machine,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Simple ROM, so user does=
n&#39;t have to provide one */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MemoryRegion *rom_mr =3D g_=
new(MemoryRegion, 1);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_region_init_ram(rom_mr, N=
ULL, &quot;g364fb.rom&quot;, 0x80000,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_region_init_rom(rom_mr, N=
ULL, &quot;g364fb.rom&quot;, 0x80000,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;error_fatal);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_region_set_readonly(<wbr>=
rom_mr, true);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t *rom =3D memory_reg=
ion_get_ram_ptr(rom_<wbr>mr);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memory_region_add_subregion=
(<wbr>address_space, 0x60000000, rom_mr);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rom[0] =3D 0x10; /* Mips G3=
64 */<br>
diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c<br>
index b934ca9d51..3fdbb21680 100644<br>
--- a/hw/mips/mips_mipssim.c<br>
+++ b/hw/mips/mips_mipssim.c<br>
@@ -169,9 +169,8 @@ mips_mipssim_init(MachineState *machine)<br>
=C2=A0 =C2=A0 =C2=A0/* Allocate RAM. */<br>
=C2=A0 =C2=A0 =C2=A0memory_region_allocate_system_<wbr>memory(ram, NULL, &q=
uot;mips_mipssim.ram&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r=
am_size);<br>
-=C2=A0 =C2=A0 memory_region_init_ram(bios, NULL, &quot;mips_mipssim.bios&q=
uot;, BIOS_SIZE,<br>
+=C2=A0 =C2=A0 memory_region_init_rom(bios, NULL, &quot;mips_mipssim.bios&q=
uot;, BIOS_SIZE,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 &amp;error_fatal);<br>
-=C2=A0 =C2=A0 memory_region_set_readonly(<wbr>bios, true);<br>
<br>
=C2=A0 =C2=A0 =C2=A0memory_region_add_subregion(<wbr>address_space_mem, 0, =
ram);<br>
<br>
diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c<br>
index b2aec434c3..54b286ceee 100644<br>
--- a/hw/mips/mips_r4k.c<br>
+++ b/hw/mips/mips_r4k.c<br>
@@ -241,9 +241,8 @@ void mips_r4k_init(MachineState *machine)<br>
=C2=A0 =C2=A0 =C2=A0dinfo =3D drive_get(IF_PFLASH, 0, 0);<br>
=C2=A0 =C2=A0 =C2=A0if ((bios_size &gt; 0) &amp;&amp; (bios_size &lt;=3D BI=
OS_SIZE)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bios =3D g_new(MemoryRegion, 1);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_region_init_ram(bios, NULL, &quot;mips_=
r4k.bios&quot;, BIOS_SIZE,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_region_init_rom(bios, NULL, &quot;mips_=
r4k.bios&quot;, BIOS_SIZE,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;error_fatal);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_region_set_readonly(<wbr>bios, true);<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memory_region_add_subregion(<wbr>get_syst=
em_memory(), 0x1fc00000, bios);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0load_image_targphys(filename, 0x1fc00000,=
 BIOS_SIZE);<br>
-- <br>
2.21.1<br>
<br>
<br>
</blockquote>

--000000000000f955f9059f790a2a--

