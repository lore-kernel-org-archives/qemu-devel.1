Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E80EC432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 00:09:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34FAF20881
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 00:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDCTIQNm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34FAF20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibZGv-0003rR-9d
	for qemu-devel@archiver.kernel.org; Sun, 01 Dec 2019 19:09:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42714)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ibZGB-0003Kl-Jz
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 19:08:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ibZG9-0003S4-9O
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 19:08:15 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:40822)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ibZG9-0003Rr-2Q
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 19:08:13 -0500
Received: by mail-oi1-x242.google.com with SMTP id 6so5601506oix.7
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2019 16:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=7wI9WX6XpjFNwgHAP1xVeL+g1VfIlT4Ay4J7OJv8BWc=;
 b=GDCTIQNm9S868vPboKZVowP2wJMflNVgYG/k+qmRSxaQeyyHEfVhhGlEI382W9YSDz
 UObJ6IW6m1X9QppYZukDFLb2Bi58JJswNZb3czPLQYZQtKfrZvJyGy4VatG8HLImYcBm
 xZarQWfvi4ZL3fAJ6tuQD0kuEx3vllyNzBdACSxY/7jYPnq2T8HNDZIIR+MeUV53fLHG
 yhMEc5v2jKxDNa3+jbqbrjIsKxIm0OT2EAL5CapqPEPEvOppd5JtSV9JADT2T+dbVbUD
 fEvTn0+0TY7O2y6E9Be7VWYSZvD/hmbcc4ye63vzvwwbnhKhRCe0enerCcIFx1LY1NDK
 YpNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=7wI9WX6XpjFNwgHAP1xVeL+g1VfIlT4Ay4J7OJv8BWc=;
 b=Q6YrEl+c5wKVnYESn5p0oLJv9XXHaocQgnWQ9IRO9EFwys6NC93pMzjxgX1ixu/LJl
 Xz9BICtkheLxsyD0Tcn9/EVz1HcLmlsEtMNLnXEomXGWmttJOfGEY4WDA6uakwIP45AO
 ikotwucRqxf4jIEsUQlHZDO6IMeTRJjd1UYNJQUTrWV3cX1BGvxWd2Dk4xaqsDPp+vzF
 0zGH1JsJKTUCMY59wdA8pKLbQafUpWU0SP5nN4Q9IkydCxiCywp06DTOiKeVfnsyWIhG
 IOqVfNul1Fz49CnNMVvxWOjq+vQ7oJC5MybiyT+GZm6ZiJQ6LJc4L2P+zJ84VKxZeD0E
 abhA==
X-Gm-Message-State: APjAAAXFI7pPJcZrn1znJrXbSUpznB9lkBwsXAYShAsxaBzVVkdXh5UB
 ZjF4IVmf9Y2WGEzklLVIvw6jJo3lweD/CO/rHjcstQ==
X-Google-Smtp-Source: APXvYqzTnwxnQQ7rPntwbnXZ4IfGItoZ27s/JdyWqzvXDkUB4upkg9NMreg1zHbpeLAHSjzrxfwHCJP3fEv1xSH80YQ=
X-Received: by 2002:aca:670b:: with SMTP id z11mr20732738oix.79.1575245292415; 
 Sun, 01 Dec 2019 16:08:12 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6830:1391:0:0:0:0 with HTTP; Sun, 1 Dec 2019 16:08:12
 -0800 (PST)
In-Reply-To: <1574687098-26689-5-git-send-email-Filip.Bozuta@rt-rk.com>
References: <1574687098-26689-1-git-send-email-Filip.Bozuta@rt-rk.com>
 <1574687098-26689-5-git-send-email-Filip.Bozuta@rt-rk.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 2 Dec 2019 01:08:12 +0100
Message-ID: <CAL1e-=jo6xYCR6epJHQZmJOMsXNm2K8TaieGv2ZcqDU2g3DHBA@mail.gmail.com>
Subject: Re: [PATCH 4/5] mips: r4000: Renovate coding style
To: Filip Bozuta <Filip.Bozuta@rt-rk.com>
Content-Type: multipart/alternative; boundary="00000000000016ae230598ad60ee"
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
Cc: "pburton@wavecomp.com" <pburton@wavecomp.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "hpoussin@reactos.org" <hpoussin@reactos.org>,
 "amarkovic@wavecomp.com" <amarkovic@wavecomp.com>,
 "aleksandar.rikalo@rt-rk.com" <aleksandar.rikalo@rt-rk.com>,
 "aurelien@aurel32.net" <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000016ae230598ad60ee
Content-Type: text/plain; charset="UTF-8"

On Monday, November 25, 2019, Filip Bozuta <Filip.Bozuta@rt-rk.com> wrote:

> The script checkpatch.pl located in scripts folder was
> used to detect all errors and warrnings in file:
>     hw/mips/mips_r4k.c
>
> This mips r4000 machine file was edited and
> all the errors and warrings generated by the checkpatch.pl
> script were corrected and then the script was
> ran again to make sure there are no more errors and warnings.
>
> Signed-off-by: Filip Bozuta <Filip.Bozuta@rt-rk.com>
> ---
>  hw/mips/mips_r4k.c | 55 ++++++++++++++++++++++++++++++
> +++---------------------
>  1 file changed, 34 insertions(+), 21 deletions(-)
>
> diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
> index 7002423..d638358 100644
> --- a/hw/mips/mips_r4k.c
> +++ b/hw/mips/mips_r4k.c
> @@ -6,7 +6,7 @@
>   * ISA memory at the 0x10000000 (PHYS, 16Mb in size).
>   * All peripherial devices are attached to this "bus" with
>   * the standard PC ISA addresses.
> -*/
> + */
>
>  #include "qemu/osdep.h"
>  #include "qemu/units.h"
> @@ -54,17 +54,18 @@ static struct _loaderparams {
>      const char *initrd_filename;
>  } loaderparams;
>
> -static void mips_qemu_write (void *opaque, hwaddr addr,
> -                             uint64_t val, unsigned size)
> +static void mips_qemu_write(void *opaque, hwaddr addr,
> +                            uint64_t val, unsigned size)
>  {
> -    if ((addr & 0xffff) == 0 && val == 42)
> +    if ((addr & 0xffff) == 0 && val == 42) {
>          qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
> -    else if ((addr & 0xffff) == 4 && val == 42)
> +    } else if ((addr & 0xffff) == 4 && val == 42) {
>          qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
> +    }
>  }
>
> -static uint64_t mips_qemu_read (void *opaque, hwaddr addr,
> -                                unsigned size)
> +static uint64_t mips_qemu_read(void *opaque, hwaddr addr,
> +                               unsigned size)
>  {
>      return 0;
>  }
> @@ -100,8 +101,9 @@ static int64_t load_kernel(void)
>                             (uint64_t *)&kernel_high, big_endian,
>                             EM_MIPS, 1, 0);
>      if (kernel_size >= 0) {
> -        if ((entry & ~0x7fffffffULL) == 0x80000000)
> +        if ((entry & ~0x7fffffffULL) == 0x80000000) {
>              entry = (int32_t)entry;
> +        }
>      } else {
>          error_report("could not load kernel '%s': %s",
>                       loaderparams.kernel_filename,
> @@ -113,9 +115,10 @@ static int64_t load_kernel(void)
>      initrd_size = 0;
>      initrd_offset = 0;
>      if (loaderparams.initrd_filename) {
> -        initrd_size = get_image_size (loaderparams.initrd_filename);
> +        initrd_size = get_image_size(loaderparams.initrd_filename);
>          if (initrd_size > 0) {
> -            initrd_offset = (kernel_high + ~INITRD_PAGE_MASK) &
> INITRD_PAGE_MASK;
> +            initrd_offset = (kernel_high + ~INITRD_PAGE_MASK) &
> +            INITRD_PAGE_MASK;


"INITRD_PAGE_MASK" should be aligned vertically with  "(kernel_high".
Otherwise:

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>



>              if (initrd_offset + initrd_size > ram_size) {
>                  error_report("memory too small for initial ram disk '%s'",
>                               loaderparams.initrd_filename);
> @@ -139,11 +142,13 @@ static int64_t load_kernel(void)
>      params_buf[1] = tswap32(0x12345678);
>
>      if (initrd_size > 0) {
> -        snprintf((char *)params_buf + 8, 256, "rd_start=0x%" PRIx64 "
> rd_size=%" PRId64 " %s",
> +        snprintf((char *)params_buf + 8, 256,
> +                 "rd_start=0x%" PRIx64 " rd_size=%" PRId64 " %s",
>                   cpu_mips_phys_to_kseg0(NULL, initrd_offset),
>                   initrd_size, loaderparams.kernel_cmdline);
>      } else {
> -        snprintf((char *)params_buf + 8, 256, "%s",
> loaderparams.kernel_cmdline);
> +        snprintf((char *)params_buf + 8, 256,
> +        "%s", loaderparams.kernel_cmdline);
>      }
>
>      rom_add_blob_fixed("params", params_buf, params_size,
> @@ -207,15 +212,21 @@ void mips_r4k_init(MachineState *machine)
>
>      memory_region_add_subregion(address_space_mem, 0, ram);
>
> -    memory_region_init_io(iomem, NULL, &mips_qemu_ops, NULL, "mips-qemu",
> 0x10000);
> +    memory_region_init_io(iomem, NULL, &mips_qemu_ops,
> +                          NULL, "mips-qemu", 0x10000);
> +
>      memory_region_add_subregion(address_space_mem, 0x1fbf0000, iomem);
>
> -    /* Try to load a BIOS image. If this fails, we continue regardless,
> -       but initialize the hardware ourselves. When a kernel gets
> -       preloaded we also initialize the hardware, since the BIOS wasn't
> -       run. */
> -    if (bios_name == NULL)
> +    /*
> +     * Try to load a BIOS image. If this fails, we continue regardless,
> +     * but initialize the hardware ourselves. When a kernel gets
> +     * preloaded we also initialize the hardware, since the BIOS wasn't
> +     * run.
> +     */
> +
> +    if (bios_name == NULL) {
>          bios_name = BIOS_FILENAME;
> +    }
>      filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
>      if (filename) {
>          bios_size = get_image_size(filename);
> @@ -227,6 +238,7 @@ void mips_r4k_init(MachineState *machine)
>  #else
>      be = 0;
>  #endif
> +    dinfo = drive_get(IF_PFLASH, 0, 0);
>      if ((bios_size > 0) && (bios_size <= BIOS_SIZE)) {
>          bios = g_new(MemoryRegion, 1);
>          memory_region_init_ram(bios, NULL, "mips_r4k.bios", BIOS_SIZE,
> @@ -235,7 +247,7 @@ void mips_r4k_init(MachineState *machine)
>          memory_region_add_subregion(get_system_memory(), 0x1fc00000,
> bios);
>
>          load_image_targphys(filename, 0x1fc00000, BIOS_SIZE);
> -    } else if ((dinfo = drive_get(IF_PFLASH, 0, 0)) != NULL) {
> +    } else if (dinfo != NULL) {
>          uint32_t mips_rom = 0x00400000;
>          if (!pflash_cfi01_register(0x1fc00000, "mips_r4k.bios", mips_rom,
>                                     blk_by_legacy_dinfo(dinfo),
> @@ -280,11 +292,12 @@ void mips_r4k_init(MachineState *machine)
>
>      isa_vga_init(isa_bus);
>
> -    if (nd_table[0].used)
> +    if (nd_table[0].used) {
>          isa_ne2000_init(isa_bus, 0x300, 9, &nd_table[0]);
> +    }
>
>      ide_drive_get(hd, ARRAY_SIZE(hd));
> -    for(i = 0; i < MAX_IDE_BUS; i++)
> +    for (i = 0; i < MAX_IDE_BUS; i++)
>          isa_ide_init(isa_bus, ide_iobase[i], ide_iobase2[i], ide_irq[i],
>                       hd[MAX_IDE_DEVS * i],
>                       hd[MAX_IDE_DEVS * i + 1]);
> --
> 2.7.4
>
>
>

--00000000000016ae230598ad60ee
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Monday, November 25, 2019, Filip Bozuta &lt;<a href=3D"mailto:Fi=
lip.Bozuta@rt-rk.com">Filip.Bozuta@rt-rk.com</a>&gt; wrote:<br><blockquote =
class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid=
;padding-left:1ex">The script <a href=3D"http://checkpatch.pl" target=3D"_b=
lank">checkpatch.pl</a> located in scripts folder was<br>
used to detect all errors and warrnings in file:<br>
=C2=A0 =C2=A0 hw/mips/mips_r4k.c<br>
<br>
This mips r4000 machine file was edited and<br>
all the errors and warrings generated by the <a href=3D"http://checkpatch.p=
l" target=3D"_blank">checkpatch.pl</a><br>
script were corrected and then the script was<br>
ran again to make sure there are no more errors and warnings.<br>
<br>
Signed-off-by: Filip Bozuta &lt;<a href=3D"mailto:Filip.Bozuta@rt-rk.com">F=
ilip.Bozuta@rt-rk.com</a>&gt;<br>
---<br>
=C2=A0hw/mips/mips_r4k.c | 55 ++++++++++++++++++++++++++++++<wbr>+++-------=
--------------<br>
=C2=A01 file changed, 34 insertions(+), 21 deletions(-)<br>
<br>
diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c<br>
index 7002423..d638358 100644<br>
--- a/hw/mips/mips_r4k.c<br>
+++ b/hw/mips/mips_r4k.c<br>
@@ -6,7 +6,7 @@<br>
=C2=A0 * ISA memory at the 0x10000000 (PHYS, 16Mb in size).<br>
=C2=A0 * All peripherial devices are attached to this &quot;bus&quot; with<=
br>
=C2=A0 * the standard PC ISA addresses.<br>
-*/<br>
+ */<br>
<br>
=C2=A0#include &quot;qemu/osdep.h&quot;<br>
=C2=A0#include &quot;qemu/units.h&quot;<br>
@@ -54,17 +54,18 @@ static struct _loaderparams {<br>
=C2=A0 =C2=A0 =C2=A0const char *initrd_filename;<br>
=C2=A0} loaderparams;<br>
<br>
-static void mips_qemu_write (void *opaque, hwaddr addr,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t val, unsigned size)<br>
+static void mips_qemu_write(void *opaque, hwaddr addr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t val, unsigned size)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 if ((addr &amp; 0xffff) =3D=3D 0 &amp;&amp; val =3D=3D 42)<b=
r>
+=C2=A0 =C2=A0 if ((addr &amp; 0xffff) =3D=3D 0 &amp;&amp; val =3D=3D 42) {=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_system_reset_request(<wbr>SHUTDOWN_C=
AUSE_GUEST_RESET);<br>
-=C2=A0 =C2=A0 else if ((addr &amp; 0xffff) =3D=3D 4 &amp;&amp; val =3D=3D =
42)<br>
+=C2=A0 =C2=A0 } else if ((addr &amp; 0xffff) =3D=3D 4 &amp;&amp; val =3D=
=3D 42) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_system_shutdown_request(<wbr>SHUTDOW=
N_CAUSE_GUEST_SHUTDOWN)<wbr>;<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0}<br>
<br>
-static uint64_t mips_qemu_read (void *opaque, hwaddr addr,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned size)<br>
+static uint64_t mips_qemu_read(void *opaque, hwaddr addr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned size)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
@@ -100,8 +101,9 @@ static int64_t load_kernel(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 (uint64_t *)&amp;kernel_high, big_endian,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 EM_MIPS, 1, 0);<br>
=C2=A0 =C2=A0 =C2=A0if (kernel_size &gt;=3D 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((entry &amp; ~0x7fffffffULL) =3D=3D 0x8000=
0000)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((entry &amp; ~0x7fffffffULL) =3D=3D 0x8000=
0000) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0entry =3D (int32_t)entry;<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_report(&quot;could not load kernel =
&#39;%s&#39;: %s&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 loaderparams.kernel_filename,<br>
@@ -113,9 +115,10 @@ static int64_t load_kernel(void)<br>
=C2=A0 =C2=A0 =C2=A0initrd_size =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0initrd_offset =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0if (loaderparams.initrd_filename) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 initrd_size =3D get_image_size (loaderparams.i=
nitrd_filename)<wbr>;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 initrd_size =3D get_image_size(loaderparams.<w=
br>initrd_filename);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (initrd_size &gt; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 initrd_offset =3D (kernel_high +=
 ~INITRD_PAGE_MASK) &amp; INITRD_PAGE_MASK;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 initrd_offset =3D (kernel_high +=
 ~INITRD_PAGE_MASK) &amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 INITRD_PAGE_MASK;</blockquote><d=
iv><br></div><div>&quot;INITRD_PAGE_MASK&quot; should be aligned vertically=
 with =C2=A0&quot;(kernel_high&quot;. Otherwise:</div><div><br></div><div><=
span style=3D"color:rgb(34,34,34);font-size:14px;line-height:22.12000083923=
34px">Reviewed-by: Aleksandar Markovic &lt;</span><a href=3D"mailto:amarkov=
ic@wavecomp.com" target=3D"_blank" style=3D"font-size:14px;line-height:22.1=
200008392334px">amarkovic@wavecomp.com</a><span style=3D"color:rgb(34,34,34=
);font-size:14px;line-height:22.1200008392334px">&gt;</span></div><div><br>=
</div><div>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (initrd_offset + initrd_=
size &gt; ram_size) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_report(=
&quot;memory too small for initial ram disk &#39;%s&#39;&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 loaderparams.initrd_filename);<br>
@@ -139,11 +142,13 @@ static int64_t load_kernel(void)<br>
=C2=A0 =C2=A0 =C2=A0params_buf[1] =3D tswap32(0x12345678);<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (initrd_size &gt; 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 snprintf((char *)params_buf + 8, 256, &quot;rd=
_start=3D0x%&quot; PRIx64 &quot; rd_size=3D%&quot; PRId64 &quot; %s&quot;,<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 snprintf((char *)params_buf + 8, 256,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;rd_sta=
rt=3D0x%&quot; PRIx64 &quot; rd_size=3D%&quot; PRId64 &quot; %s&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_mips_phy=
s_to_kseg0(NULL, initrd_offset),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 initrd_size,=
 loaderparams.kernel_cmdline);<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 snprintf((char *)params_buf + 8, 256, &quot;%s=
&quot;, loaderparams.kernel_cmdline);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 snprintf((char *)params_buf + 8, 256,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;%s&quot;, loaderparams.kernel_cmdline);<=
br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0rom_add_blob_fixed(&quot;params&quot;, params_buf, para=
ms_size,<br>
@@ -207,15 +212,21 @@ void mips_r4k_init(MachineState *machine)<br>
<br>
=C2=A0 =C2=A0 =C2=A0memory_region_add_subregion(<wbr>address_space_mem, 0, =
ram);<br>
<br>
-=C2=A0 =C2=A0 memory_region_init_io(iomem, NULL, &amp;mips_qemu_ops, NULL,=
 &quot;mips-qemu&quot;, 0x10000);<br>
+=C2=A0 =C2=A0 memory_region_init_io(iomem, NULL, &amp;mips_qemu_ops,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 NULL, &quot;mips-qemu&quot;, 0x10000);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0memory_region_add_subregion(<wbr>address_space_mem, 0x1=
fbf0000, iomem);<br>
<br>
-=C2=A0 =C2=A0 /* Try to load a BIOS image. If this fails, we continue rega=
rdless,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0but initialize the hardware ourselves. When a k=
ernel gets<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0preloaded we also initialize the hardware, sinc=
e the BIOS wasn&#39;t<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0run. */<br>
-=C2=A0 =C2=A0 if (bios_name =3D=3D NULL)<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* Try to load a BIOS image. If this fails, we continue=
 regardless,<br>
+=C2=A0 =C2=A0 =C2=A0* but initialize the hardware ourselves. When a kernel=
 gets<br>
+=C2=A0 =C2=A0 =C2=A0* preloaded we also initialize the hardware, since the=
 BIOS wasn&#39;t<br>
+=C2=A0 =C2=A0 =C2=A0* run.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+<br>
+=C2=A0 =C2=A0 if (bios_name =3D=3D NULL) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bios_name =3D BIOS_FILENAME;<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0filename =3D qemu_find_file(QEMU_FILE_TYPE_<wbr>BIOS, b=
ios_name);<br>
=C2=A0 =C2=A0 =C2=A0if (filename) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bios_size =3D get_image_size(filename);<b=
r>
@@ -227,6 +238,7 @@ void mips_r4k_init(MachineState *machine)<br>
=C2=A0#else<br>
=C2=A0 =C2=A0 =C2=A0be =3D 0;<br>
=C2=A0#endif<br>
+=C2=A0 =C2=A0 dinfo =3D drive_get(IF_PFLASH, 0, 0);<br>
=C2=A0 =C2=A0 =C2=A0if ((bios_size &gt; 0) &amp;&amp; (bios_size &lt;=3D BI=
OS_SIZE)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bios =3D g_new(MemoryRegion, 1);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memory_region_init_ram(bios, NULL, &quot;=
mips_r4k.bios&quot;, BIOS_SIZE,<br>
@@ -235,7 +247,7 @@ void mips_r4k_init(MachineState *machine)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memory_region_add_subregion(<wbr>get_syst=
em_memory(), 0x1fc00000, bios);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0load_image_targphys(filename, 0x1fc00000,=
 BIOS_SIZE);<br>
-=C2=A0 =C2=A0 } else if ((dinfo =3D drive_get(IF_PFLASH, 0, 0)) !=3D NULL)=
 {<br>
+=C2=A0 =C2=A0 } else if (dinfo !=3D NULL) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t mips_rom =3D 0x00400000;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!pflash_cfi01_register(<wbr>0x1fc0000=
0, &quot;mips_r4k.bios&quot;, mips_rom,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 blk_by_legacy_dinfo(di=
nfo),<br>
@@ -280,11 +292,12 @@ void mips_r4k_init(MachineState *machine)<br>
<br>
=C2=A0 =C2=A0 =C2=A0isa_vga_init(isa_bus);<br>
<br>
-=C2=A0 =C2=A0 if (nd_table[0].used)<br>
+=C2=A0 =C2=A0 if (nd_table[0].used) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0isa_ne2000_init(isa_bus, 0x300, 9, &amp;n=
d_table[0]);<br>
+=C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0ide_drive_get(hd, ARRAY_SIZE(hd));<br>
-=C2=A0 =C2=A0 for(i =3D 0; i &lt; MAX_IDE_BUS; i++)<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; MAX_IDE_BUS; i++)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0isa_ide_init(isa_bus, ide_iobase[i], ide_=
iobase2[i], ide_irq[i],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 hd[MAX_IDE_DEVS * i],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 hd[MAX_IDE_DEVS * i + 1]);<br>
-- <br>
2.7.4<br>
<br>
<br>
</blockquote>

--00000000000016ae230598ad60ee--

