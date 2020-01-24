Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39241C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 17:17:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 043012072C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 17:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jxfordxr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 043012072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv2aS-0007FL-75
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 12:17:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51922)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iv2Ys-00065y-Nv
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 12:16:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iv2Yr-0004VU-Be
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 12:16:02 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:38442)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iv2Yr-0004V5-5o
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 12:16:01 -0500
Received: by mail-oi1-x243.google.com with SMTP id l9so198732oii.5
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 09:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bGNm5awvS2Gl3044vzS4CRUEh7yT57HbIXYDy6ugFAE=;
 b=JxfordxrCqtN9SFZ5k50ndpIQ0PPeQWsbhzsjg6Y/6V5LpHBILxB+zP9HSadu6mezJ
 KUAOL8EElcFNNpThBDQ8xojj13nh0RJV3j7C1gYEO00ClPfvJYlJUkn4R3XOSrg/7SY0
 2Z6gc2DtaDB6yuX0SvKzFEMyKrn03JooH8Xp+weTN0zydqo+9oPpu19bM41OElGBFHmX
 5bwpn/ADljW3AwCbGLAIefujjL/KHow2wSgaE5FkMByQWuqhcq3KGwJXECGsFV3aI4R/
 jmNbEhC2994M0gevoJPSkvMY0N+CasSqd7LzWIsoUnnutSHnLPgDMgwaeoFbm2X9tpQK
 xNlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bGNm5awvS2Gl3044vzS4CRUEh7yT57HbIXYDy6ugFAE=;
 b=KYRc9WB+/SJ2jE8RXMfNO12LW/UaE0qUBmHzEU340wjk7iJpll1IvS39putMM+wVtF
 bsM7Xk2tqL1PRscpSC9B01Dq2C9MFOxsZa/KKPu1wwtCKxe8Pv4OXoj0m8zWaQ4fFwAi
 JFfe1LsNIjpxmyu7Yr6hLAe8POOYtdzqOjD5VdteJ9klMosfag87r55FrfpUyMGI5+4g
 LPOekOYhP6YbJBM/3+8JbGKw3uT4eeXqBjN2KxdztaNkmf5XZTv+ayNROKJs7n7DoeWd
 QDNDjK4gtB2vPuSXnCnTLUIv96w6cGm7dYyvMFciDBKVfdoHNFGPBpzlVOBIDw50OAhj
 mbZg==
X-Gm-Message-State: APjAAAW0cUJAYh8tbTEuiTBNkCCxyryL+CSyg96UmWbYkoWBgSEC1951
 oJURf3mxtbZ0mrbE+DyizsOOqeJ997uv+vCy4Ww=
X-Google-Smtp-Source: APXvYqxpTdY71vL9U/ZcjIpKGqBiNxcmegQFI7U1WHcDVsq8XxmLAs8vzR0vkvLOlb6xQL97EwB4a4o1jNCeIOaP80I=
X-Received: by 2002:aca:bbc6:: with SMTP id l189mr158908oif.53.1579886160591; 
 Fri, 24 Jan 2020 09:16:00 -0800 (PST)
MIME-Version: 1.0
References: <1579779525-20065-1-git-send-email-imammedo@redhat.com>
 <1579779525-20065-57-git-send-email-imammedo@redhat.com>
In-Reply-To: <1579779525-20065-57-git-send-email-imammedo@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 24 Jan 2020 18:15:49 +0100
Message-ID: <CAL1e-=idAHM3LooaThSiYTv5_wux+NJJ16H1O5+Ethndiv50vw@mail.gmail.com>
Subject: Re: [PATCH REPOST v3 56/80] mips/mips_r4k: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000006340e0059ce5e902"
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

--0000000000006340e0059ce5e902
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2020 at 1:24 PM Igor Mammedov <imammedo@redhat.com> wrote:

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
>  hw/mips/mips_r4k.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
>
Applied to MIPS queue.


> diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
> index fd926a3..69b6549 100644
> --- a/hw/mips/mips_r4k.c
> +++ b/hw/mips/mips_r4k.c
> @@ -171,13 +171,11 @@ static const int sector_len =3D 32 * KiB;
>  static
>  void mips_r4k_init(MachineState *machine)
>  {
> -    ram_addr_t ram_size =3D machine->ram_size;
>      const char *kernel_filename =3D machine->kernel_filename;
>      const char *kernel_cmdline =3D machine->kernel_cmdline;
>      const char *initrd_filename =3D machine->initrd_filename;
>      char *filename;
>      MemoryRegion *address_space_mem =3D get_system_memory();
> -    MemoryRegion *ram =3D g_new(MemoryRegion, 1);
>      MemoryRegion *bios;
>      MemoryRegion *iomem =3D g_new(MemoryRegion, 1);
>      MemoryRegion *isa_io =3D g_new(MemoryRegion, 1);
> @@ -203,14 +201,12 @@ void mips_r4k_init(MachineState *machine)
>      qemu_register_reset(main_cpu_reset, reset_info);
>
>      /* allocate RAM */
> -    if (ram_size > 256 * MiB) {
> +    if (machine->ram_size > 256 * MiB) {
>          error_report("Too much memory for this machine: %" PRId64 "MB,"
>                       " maximum 256MB", ram_size / MiB);
>          exit(1);
>      }
> -    memory_region_allocate_system_memory(ram, NULL, "mips_r4k.ram",
> ram_size);
> -
> -    memory_region_add_subregion(address_space_mem, 0, ram);
> +    memory_region_add_subregion(address_space_mem, 0, machine->ram);
>
>      memory_region_init_io(iomem, NULL, &mips_qemu_ops,
>                            NULL, "mips-qemu", 0x10000);
> @@ -261,7 +257,7 @@ void mips_r4k_init(MachineState *machine)
>      g_free(filename);
>
>      if (kernel_filename) {
> -        loaderparams.ram_size =3D ram_size;
> +        loaderparams.ram_size =3D machine->ram_size;
>          loaderparams.kernel_filename =3D kernel_filename;
>          loaderparams.kernel_cmdline =3D kernel_cmdline;
>          loaderparams.initrd_filename =3D initrd_filename;
> @@ -316,7 +312,7 @@ static void mips_machine_init(MachineClass *mc)
>  #else
>      mc->default_cpu_type =3D MIPS_CPU_TYPE_NAME("24Kf");
>  #endif
> -
> +    mc->default_ram_id =3D "mips_r4k.ram";
>  }
>
>  DEFINE_MACHINE("mips", mips_machine_init)
> --
> 2.7.4
>
>
>

--0000000000006340e0059ce5e902
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jan 23, 2020 at 1:24 PM Igor =
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
=C2=A0hw/mips/mips_r4k.c | 12 ++++--------<br>
=C2=A01 file changed, 4 insertions(+), 8 deletions(-)<br>
<br></blockquote><div><br></div><div>Applied to MIPS queue.</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c<br>
index fd926a3..69b6549 100644<br>
--- a/hw/mips/mips_r4k.c<br>
+++ b/hw/mips/mips_r4k.c<br>
@@ -171,13 +171,11 @@ static const int sector_len =3D 32 * KiB;<br>
=C2=A0static<br>
=C2=A0void mips_r4k_init(MachineState *machine)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 ram_addr_t ram_size =3D machine-&gt;ram_size;<br>
=C2=A0 =C2=A0 =C2=A0const char *kernel_filename =3D machine-&gt;kernel_file=
name;<br>
=C2=A0 =C2=A0 =C2=A0const char *kernel_cmdline =3D machine-&gt;kernel_cmdli=
ne;<br>
=C2=A0 =C2=A0 =C2=A0const char *initrd_filename =3D machine-&gt;initrd_file=
name;<br>
=C2=A0 =C2=A0 =C2=A0char *filename;<br>
=C2=A0 =C2=A0 =C2=A0MemoryRegion *address_space_mem =3D get_system_memory()=
;<br>
-=C2=A0 =C2=A0 MemoryRegion *ram =3D g_new(MemoryRegion, 1);<br>
=C2=A0 =C2=A0 =C2=A0MemoryRegion *bios;<br>
=C2=A0 =C2=A0 =C2=A0MemoryRegion *iomem =3D g_new(MemoryRegion, 1);<br>
=C2=A0 =C2=A0 =C2=A0MemoryRegion *isa_io =3D g_new(MemoryRegion, 1);<br>
@@ -203,14 +201,12 @@ void mips_r4k_init(MachineState *machine)<br>
=C2=A0 =C2=A0 =C2=A0qemu_register_reset(main_cpu_reset, reset_info);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* allocate RAM */<br>
-=C2=A0 =C2=A0 if (ram_size &gt; 256 * MiB) {<br>
+=C2=A0 =C2=A0 if (machine-&gt;ram_size &gt; 256 * MiB) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_report(&quot;Too much memory for th=
is machine: %&quot; PRId64 &quot;MB,&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &quot; maximum 256MB&quot;, ram_size / MiB);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(1);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 memory_region_allocate_system_memory(ram, NULL, &quot;mips_r=
4k.ram&quot;, ram_size);<br>
-<br>
-=C2=A0 =C2=A0 memory_region_add_subregion(address_space_mem, 0, ram);<br>
+=C2=A0 =C2=A0 memory_region_add_subregion(address_space_mem, 0, machine-&g=
t;ram);<br>
<br>
=C2=A0 =C2=A0 =C2=A0memory_region_init_io(iomem, NULL, &amp;mips_qemu_ops,<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0NULL, &quot;mips-qemu&quot;, 0x10000);<br>
@@ -261,7 +257,7 @@ void mips_r4k_init(MachineState *machine)<br>
=C2=A0 =C2=A0 =C2=A0g_free(filename);<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (kernel_filename) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 loaderparams.ram_size =3D ram_size;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 loaderparams.ram_size =3D machine-&gt;ram_size=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0loaderparams.kernel_filename =3D kernel_f=
ilename;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0loaderparams.kernel_cmdline =3D kernel_cm=
dline;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0loaderparams.initrd_filename =3D initrd_f=
ilename;<br>
@@ -316,7 +312,7 @@ static void mips_machine_init(MachineClass *mc)<br>
=C2=A0#else<br>
=C2=A0 =C2=A0 =C2=A0mc-&gt;default_cpu_type =3D MIPS_CPU_TYPE_NAME(&quot;24=
Kf&quot;);<br>
=C2=A0#endif<br>
-<br>
+=C2=A0 =C2=A0 mc-&gt;default_ram_id =3D &quot;mips_r4k.ram&quot;;<br>
=C2=A0}<br>
<br>
=C2=A0DEFINE_MACHINE(&quot;mips&quot;, mips_machine_init)<br>
-- <br>
2.7.4<br>
<br>
<br>
</blockquote></div></div>

--0000000000006340e0059ce5e902--

