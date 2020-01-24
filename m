Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AFEC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 17:16:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 106682072C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 17:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vJslOp6k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 106682072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv2ZB-00067c-3h
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 12:16:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51718)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iv2YG-0005ah-92
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 12:15:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iv2YD-0003KY-VQ
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 12:15:23 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:41699)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iv2YD-0003It-Mv
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 12:15:21 -0500
Received: by mail-oi1-x243.google.com with SMTP id i1so178719oie.8
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 09:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yDKZvplGLLHJPDooKzLozxCmGjllqV4rfb+wD1y7tsw=;
 b=vJslOp6k4FWL0wnAsgntXpdhSyy80QhtnnAG5ct8wkFvEoReABA7HzXxWfXcdx2f9V
 CJXa88yBjl2WPUYexVs+TmAyyYM0K4Cf1pnAGLA73rM8C+V6/uM+fANeVMM7kufnyDeK
 rv0f+A7C8GM1SS/WkRXL2fh8gs1m1SYLPwKd763if1HXYZ3wefOBX2BTgUPkrrs48w4O
 yRpIBlbHVCP4OLutyNvvaHSSzNqH3iE1y2VwHBOp3kQlG93ujkq0Y64PWc6uYLnsjv1U
 QcevSSuJK5/QgbMCVftYt6LhdRwdPsyBkTyVKEnq7LI1yHVvdfsYoOA7PdXZpqRBedEa
 3PDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yDKZvplGLLHJPDooKzLozxCmGjllqV4rfb+wD1y7tsw=;
 b=WFopRu8dB7v2TsubwNzZaEFZJVxQCn45NuCbFJdDKRtMVTlDGRYjRmikRhLF2Be+1E
 WCdN7tWTNUjhqvv0d9kS2ndwmQB2l6pePb4Lh58Xxk/3kSxDz9PWKXnlaYIg9h++9k2o
 5mbNlTXnM97mya28r6gdSY+Na1geMxgpIeiXKtTQUv9zTHCc98cXCJlPUtea9Kdjnzgd
 1vMlSmvykQ8VnT0jABCWVQEXa+ewEVwLxwWZlpnIpIM1sK4hs4sGGW/bwmCYa8xjwnV/
 3aW5I3sdmQFScVD5REafJMfgVhGGTwH1c04ixecSbdQk7i2vqgNRpcY64oxbyUB58fkc
 n+Dg==
X-Gm-Message-State: APjAAAWDhCF+KiluhKMcMwOE420smm25hPgB452CEg0qC/sP3LhQ4j/B
 LmB2OEGsYhAoIel5xGrcQdpR2zRKTT4sIXYpJyU=
X-Google-Smtp-Source: APXvYqzqZ/nB/OovoDbrcv7uzsmoRU3htoxE4J5Hbz3chu0shnzK8GT/1/vWMeiKdkOu+qV2hPHMqfXGAdm64aozj08=
X-Received: by 2002:a05:6808:6c5:: with SMTP id m5mr10488oih.106.1579886120580; 
 Fri, 24 Jan 2020 09:15:20 -0800 (PST)
MIME-Version: 1.0
References: <1579779525-20065-1-git-send-email-imammedo@redhat.com>
 <1579779525-20065-54-git-send-email-imammedo@redhat.com>
In-Reply-To: <1579779525-20065-54-git-send-email-imammedo@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 24 Jan 2020 18:15:09 +0100
Message-ID: <CAL1e-=h7Q0h0Rn8jghXfX1F94qXnMBBSSuiAs5m8B-T4YuedfQ@mail.gmail.com>
Subject: Re: [PATCH REPOST v3 53/80] mips/mips_jazz: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000000b9fc059ce5e7d4"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000000b9fc059ce5e7d4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2020 at 1:15 PM Igor Mammedov <imammedo@redhat.com> wrote:

> memory_region_allocate_system_memory() API is going away, so
> replace it with memdev allocated MemoryRegion. The later is
> initialized by generic code, so board only needs to opt in
> to memdev scheme by providing
>   MachineClass::default_ram_id
> and using MachineState::ram instead of manually initializing
> RAM memory region.
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/mips/mips_jazz.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
>
Applied to MIPS queue.


> diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
> index 66fd4d8..85d49cf 100644
> --- a/hw/mips/mips_jazz.c
> +++ b/hw/mips/mips_jazz.c
> @@ -159,7 +159,6 @@ static void mips_jazz_init(MachineState *machine,
>      ISABus *isa_bus;
>      ISADevice *pit;
>      DriveInfo *fds[MAX_FD];
> -    MemoryRegion *ram =3D g_new(MemoryRegion, 1);
>      MemoryRegion *bios =3D g_new(MemoryRegion, 1);
>      MemoryRegion *bios2 =3D g_new(MemoryRegion, 1);
>      SysBusESPState *sysbus_esp;
> @@ -191,9 +190,7 @@ static void mips_jazz_init(MachineState *machine,
>      cc->do_transaction_failed =3D mips_jazz_do_transaction_failed;
>
>      /* allocate RAM */
> -    memory_region_allocate_system_memory(ram, NULL, "mips_jazz.ram",
> -                                         machine->ram_size);
> -    memory_region_add_subregion(address_space, 0, ram);
> +    memory_region_add_subregion(address_space, 0, machine->ram);
>
>      memory_region_init_ram(bios, NULL, "mips_jazz.bios", MAGNUM_BIOS_SIZ=
E,
>                             &error_fatal);
> @@ -393,6 +390,7 @@ static void mips_magnum_class_init(ObjectClass *oc,
> void *data)
>      mc->init =3D mips_magnum_init;
>      mc->block_default_type =3D IF_SCSI;
>      mc->default_cpu_type =3D MIPS_CPU_TYPE_NAME("R4000");
> +    mc->default_ram_id =3D "mips_jazz.ram";
>  }
>
>  static const TypeInfo mips_magnum_type =3D {
> @@ -409,6 +407,7 @@ static void mips_pica61_class_init(ObjectClass *oc,
> void *data)
>      mc->init =3D mips_pica61_init;
>      mc->block_default_type =3D IF_SCSI;
>      mc->default_cpu_type =3D MIPS_CPU_TYPE_NAME("R4000");
> +    mc->default_ram_id =3D "mips_jazz.ram";
>  }
>
>  static const TypeInfo mips_pica61_type =3D {
> --
> 2.7.4
>
>
>

--00000000000000b9fc059ce5e7d4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jan 23, 2020 at 1:15 PM Igor =
Mammedov &lt;<a href=3D"mailto:imammedo@redhat.com">imammedo@redhat.com</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">memo=
ry_region_allocate_system_memory() API is going away, so<br>
replace it with memdev allocated MemoryRegion. The later is<br>
initialized by generic code, so board only needs to opt in<br>
to memdev scheme by providing<br>
=C2=A0 MachineClass::default_ram_id<br>
and using MachineState::ram instead of manually initializing<br>
RAM memory region.<br>
<br>
Signed-off-by: Igor Mammedov &lt;<a href=3D"mailto:imammedo@redhat.com" tar=
get=3D"_blank">imammedo@redhat.com</a>&gt;<br>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redha=
t.com" target=3D"_blank">philmd@redhat.com</a>&gt;<br>
---<br>
=C2=A0hw/mips/mips_jazz.c | 7 +++----<br>
=C2=A01 file changed, 3 insertions(+), 4 deletions(-)<br>
<br></blockquote><div><br></div><div>Applied to MIPS queue.<br></div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c<br>
index 66fd4d8..85d49cf 100644<br>
--- a/hw/mips/mips_jazz.c<br>
+++ b/hw/mips/mips_jazz.c<br>
@@ -159,7 +159,6 @@ static void mips_jazz_init(MachineState *machine,<br>
=C2=A0 =C2=A0 =C2=A0ISABus *isa_bus;<br>
=C2=A0 =C2=A0 =C2=A0ISADevice *pit;<br>
=C2=A0 =C2=A0 =C2=A0DriveInfo *fds[MAX_FD];<br>
-=C2=A0 =C2=A0 MemoryRegion *ram =3D g_new(MemoryRegion, 1);<br>
=C2=A0 =C2=A0 =C2=A0MemoryRegion *bios =3D g_new(MemoryRegion, 1);<br>
=C2=A0 =C2=A0 =C2=A0MemoryRegion *bios2 =3D g_new(MemoryRegion, 1);<br>
=C2=A0 =C2=A0 =C2=A0SysBusESPState *sysbus_esp;<br>
@@ -191,9 +190,7 @@ static void mips_jazz_init(MachineState *machine,<br>
=C2=A0 =C2=A0 =C2=A0cc-&gt;do_transaction_failed =3D mips_jazz_do_transacti=
on_failed;<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* allocate RAM */<br>
-=C2=A0 =C2=A0 memory_region_allocate_system_memory(ram, NULL, &quot;mips_j=
azz.ram&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ma=
chine-&gt;ram_size);<br>
-=C2=A0 =C2=A0 memory_region_add_subregion(address_space, 0, ram);<br>
+=C2=A0 =C2=A0 memory_region_add_subregion(address_space, 0, machine-&gt;ra=
m);<br>
<br>
=C2=A0 =C2=A0 =C2=A0memory_region_init_ram(bios, NULL, &quot;mips_jazz.bios=
&quot;, MAGNUM_BIOS_SIZE,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 &amp;error_fatal);<br>
@@ -393,6 +390,7 @@ static void mips_magnum_class_init(ObjectClass *oc, voi=
d *data)<br>
=C2=A0 =C2=A0 =C2=A0mc-&gt;init =3D mips_magnum_init;<br>
=C2=A0 =C2=A0 =C2=A0mc-&gt;block_default_type =3D IF_SCSI;<br>
=C2=A0 =C2=A0 =C2=A0mc-&gt;default_cpu_type =3D MIPS_CPU_TYPE_NAME(&quot;R4=
000&quot;);<br>
+=C2=A0 =C2=A0 mc-&gt;default_ram_id =3D &quot;mips_jazz.ram&quot;;<br>
=C2=A0}<br>
<br>
=C2=A0static const TypeInfo mips_magnum_type =3D {<br>
@@ -409,6 +407,7 @@ static void mips_pica61_class_init(ObjectClass *oc, voi=
d *data)<br>
=C2=A0 =C2=A0 =C2=A0mc-&gt;init =3D mips_pica61_init;<br>
=C2=A0 =C2=A0 =C2=A0mc-&gt;block_default_type =3D IF_SCSI;<br>
=C2=A0 =C2=A0 =C2=A0mc-&gt;default_cpu_type =3D MIPS_CPU_TYPE_NAME(&quot;R4=
000&quot;);<br>
+=C2=A0 =C2=A0 mc-&gt;default_ram_id =3D &quot;mips_jazz.ram&quot;;<br>
=C2=A0}<br>
<br>
=C2=A0static const TypeInfo mips_pica61_type =3D {<br>
-- <br>
2.7.4<br>
<br>
<br>
</blockquote></div></div>

--00000000000000b9fc059ce5e7d4--

