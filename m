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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D28BC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 17:17:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5983A2072C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 17:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZU4arN2/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5983A2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv2ah-0007iw-Gx
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 12:17:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52025)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iv2ZD-0006QU-2f
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 12:16:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iv2ZB-00053k-Op
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 12:16:23 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:46282)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iv2ZB-000537-Iv
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 12:16:21 -0500
Received: by mail-oi1-x242.google.com with SMTP id 13so153406oij.13
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 09:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=shGcF3Tz5e1GNL/ur5a+sjBw12s8F7NdfYQdjuwIQaQ=;
 b=ZU4arN2/m+yQLqMylJ9LFzDKoyMZLXBfXtDcOpQSQZN4zXQ6e2F8XW9KplXXs3un2U
 CHgWeHHakAldQv6VQJ9NKmVjk3/4UzST31kUrBzr/CM1wTK/Ka1WQM06LEac6/CRR5YR
 qQf6AWxYAI7pxPtICMnO46myQJJu07F9G5afqTk76ocfo78XeNabLticRsymLOwm/gL7
 ZAn0ARpCrdCfWvKCvw7mS9yeYHwl/5xcKKqGyAJFv8Bsjp5KU+WUDNeD+H/dFMWTiiKy
 AUM8eYZhr+vvyEEQXkqudP8AU7ojzNyDtgA24Cs8j6dbHm61ldNMo3uz/SpkXLEdiJqP
 qoeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=shGcF3Tz5e1GNL/ur5a+sjBw12s8F7NdfYQdjuwIQaQ=;
 b=SRFf2KEbnFzeb7ub9pRnnQx8jOxIhzMF3NSUcGr7+Jq9W8HyrbEmVOR9B4+xwRUYRR
 NfCFqUSUesvG2NnmjSugxPMwBSFe1qvjw799mFT57RqCiFH7iseiA6EMoyxCVDLhZt1p
 KwFOJwsMyesTbjmXKiP9Q1JmZkZbyhQlc+MHwKRdgij2/b/kP7YQbSHbYxeKYhon3wTh
 HSr+Kq5ymV8PgwOXJ5KT3uV8AR3xWQDcbiypHb78s0zPEt5y0wJlV0hW0Tbro+qpmZkM
 BJtdGnXw/Jrbg2r4j4QSSVWMCbMx+XPaPt2kQQ5mQyLfcXsKTN0GNe9pjNxtMbTnzc5e
 ptAA==
X-Gm-Message-State: APjAAAXdObiyGe4Z+RyVqSNsjp3cYFpyo+R2P7/74HeMnEP6uZ3S/dgm
 bE733cafGH6z3JnGbFiviT+lhbFtYljm8aAt5h0=
X-Google-Smtp-Source: APXvYqwlLxR0IyjxRnPd8f1E8uhDbN/21ToN6xeSg0QQVRQNKyLN0MwUPA4WyOuEcjp2YcnQ2JCXchchzwGtfydp/sQ=
X-Received: by 2002:a05:6808:64e:: with SMTP id
 z14mr149220oih.79.1579886180874; 
 Fri, 24 Jan 2020 09:16:20 -0800 (PST)
MIME-Version: 1.0
References: <1579779525-20065-1-git-send-email-imammedo@redhat.com>
 <1579779525-20065-55-git-send-email-imammedo@redhat.com>
In-Reply-To: <1579779525-20065-55-git-send-email-imammedo@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 24 Jan 2020 18:16:10 +0100
Message-ID: <CAL1e-=is6mH_GWh-es9YNcfrtCZ8DwO9DzYW2=___KxBOX7e6w@mail.gmail.com>
Subject: Re: [PATCH REPOST v3 54/80] mips/mips_malta: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000098bf9a059ce5ea2f"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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

--00000000000098bf9a059ce5ea2f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2020 at 1:19 PM Igor Mammedov <imammedo@redhat.com> wrote:

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
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/mips/mips_malta.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
>
Applied to MIPS queue.


> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index 5aaeaa8..77995a5 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -1223,7 +1223,6 @@ void mips_malta_init(MachineState *machine)
>      char *filename;
>      PFlashCFI01 *fl;
>      MemoryRegion *system_memory =3D get_system_memory();
> -    MemoryRegion *ram_high =3D g_new(MemoryRegion, 1);
>      MemoryRegion *ram_low_preio =3D g_new(MemoryRegion, 1);
>      MemoryRegion *ram_low_postio;
>      MemoryRegion *bios, *bios_copy =3D g_new(MemoryRegion, 1);
> @@ -1261,13 +1260,11 @@ void mips_malta_init(MachineState *machine)
>      }
>
>      /* register RAM at high address where it is undisturbed by IO */
> -    memory_region_allocate_system_memory(ram_high, NULL, "mips_malta.ram=
",
> -                                         ram_size);
> -    memory_region_add_subregion(system_memory, 0x80000000, ram_high);
> +    memory_region_add_subregion(system_memory, 0x80000000, machine->ram)=
;
>
>      /* alias for pre IO hole access */
>      memory_region_init_alias(ram_low_preio, NULL,
> "mips_malta_low_preio.ram",
> -                             ram_high, 0, MIN(ram_size, 256 * MiB));
> +                             machine->ram, 0, MIN(ram_size, 256 * MiB));
>      memory_region_add_subregion(system_memory, 0, ram_low_preio);
>
>      /* alias for post IO hole access, if there is enough RAM */
> @@ -1275,7 +1272,7 @@ void mips_malta_init(MachineState *machine)
>          ram_low_postio =3D g_new(MemoryRegion, 1);
>          memory_region_init_alias(ram_low_postio, NULL,
>                                   "mips_malta_low_postio.ram",
> -                                 ram_high, 512 * MiB,
> +                                 machine->ram, 512 * MiB,
>                                   ram_size - 512 * MiB);
>          memory_region_add_subregion(system_memory, 512 * MiB,
>                                      ram_low_postio);
> @@ -1447,6 +1444,7 @@ static void mips_malta_machine_init(MachineClass *m=
c)
>  #else
>      mc->default_cpu_type =3D MIPS_CPU_TYPE_NAME("24Kf");
>  #endif
> +    mc->default_ram_id =3D "mips_malta.ram";
>  }
>
>  DEFINE_MACHINE("malta", mips_malta_machine_init)
> --
> 2.7.4
>
>
>

--00000000000098bf9a059ce5ea2f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jan 23, 2020 at 1:19 PM Igor =
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
Tested-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.=
com" target=3D"_blank">philmd@redhat.com</a>&gt;<br>
---<br>
=C2=A0hw/mips/mips_malta.c | 10 ++++------<br>
=C2=A01 file changed, 4 insertions(+), 6 deletions(-)<br>
<br></blockquote><div><br></div><div>Applied to MIPS queue.</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c<br>
index 5aaeaa8..77995a5 100644<br>
--- a/hw/mips/mips_malta.c<br>
+++ b/hw/mips/mips_malta.c<br>
@@ -1223,7 +1223,6 @@ void mips_malta_init(MachineState *machine)<br>
=C2=A0 =C2=A0 =C2=A0char *filename;<br>
=C2=A0 =C2=A0 =C2=A0PFlashCFI01 *fl;<br>
=C2=A0 =C2=A0 =C2=A0MemoryRegion *system_memory =3D get_system_memory();<br=
>
-=C2=A0 =C2=A0 MemoryRegion *ram_high =3D g_new(MemoryRegion, 1);<br>
=C2=A0 =C2=A0 =C2=A0MemoryRegion *ram_low_preio =3D g_new(MemoryRegion, 1);=
<br>
=C2=A0 =C2=A0 =C2=A0MemoryRegion *ram_low_postio;<br>
=C2=A0 =C2=A0 =C2=A0MemoryRegion *bios, *bios_copy =3D g_new(MemoryRegion, =
1);<br>
@@ -1261,13 +1260,11 @@ void mips_malta_init(MachineState *machine)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* register RAM at high address where it is undisturbed=
 by IO */<br>
-=C2=A0 =C2=A0 memory_region_allocate_system_memory(ram_high, NULL, &quot;m=
ips_malta.ram&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ra=
m_size);<br>
-=C2=A0 =C2=A0 memory_region_add_subregion(system_memory, 0x80000000, ram_h=
igh);<br>
+=C2=A0 =C2=A0 memory_region_add_subregion(system_memory, 0x80000000, machi=
ne-&gt;ram);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* alias for pre IO hole access */<br>
=C2=A0 =C2=A0 =C2=A0memory_region_init_alias(ram_low_preio, NULL, &quot;mip=
s_malta_low_preio.ram&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ram_high, 0, MIN(ram_size, 256 * MiB));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0machine-&gt;ram, 0, MIN(ram_size, 256 * MiB)=
);<br>
=C2=A0 =C2=A0 =C2=A0memory_region_add_subregion(system_memory, 0, ram_low_p=
reio);<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* alias for post IO hole access, if there is enough RA=
M */<br>
@@ -1275,7 +1272,7 @@ void mips_malta_init(MachineState *machine)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ram_low_postio =3D g_new(MemoryRegion, 1)=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memory_region_init_alias(ram_low_postio, =
NULL,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;mips_malta_low_postio.r=
am&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ram_high, 512 * MiB,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0machine-&gt;ram, 512 * MiB,<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ram_size - 512 * MiB);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memory_region_add_subregion(system_memory=
, 512 * MiB,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ram_low_postio);=
<br>
@@ -1447,6 +1444,7 @@ static void mips_malta_machine_init(MachineClass *mc)=
<br>
=C2=A0#else<br>
=C2=A0 =C2=A0 =C2=A0mc-&gt;default_cpu_type =3D MIPS_CPU_TYPE_NAME(&quot;24=
Kf&quot;);<br>
=C2=A0#endif<br>
+=C2=A0 =C2=A0 mc-&gt;default_ram_id =3D &quot;mips_malta.ram&quot;;<br>
=C2=A0}<br>
<br>
=C2=A0DEFINE_MACHINE(&quot;malta&quot;, mips_malta_machine_init)<br>
-- <br>
2.7.4<br>
<br>
<br>
</blockquote></div></div>

--00000000000098bf9a059ce5ea2f--

