Return-Path: <SRS0=SBSl=35=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C1BC2BA83
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Feb 2020 22:54:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 142E3207FF
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Feb 2020 22:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vXldfoCf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 142E3207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0vT9-0001V0-90
	for qemu-devel@archiver.kernel.org; Sun, 09 Feb 2020 17:54:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50781)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1j0vS5-0000Uq-KB
 for qemu-devel@nongnu.org; Sun, 09 Feb 2020 17:53:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1j0vS3-000769-Eb
 for qemu-devel@nongnu.org; Sun, 09 Feb 2020 17:53:21 -0500
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:42953)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1j0vS3-00075C-7b; Sun, 09 Feb 2020 17:53:19 -0500
Received: by mail-il1-x144.google.com with SMTP id x2so4151824ila.9;
 Sun, 09 Feb 2020 14:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=flXAlKZocQHTDs+0ehm1EKqxHkH5LSlN9/W2U0yck8A=;
 b=vXldfoCfphBa/z++DBgdnWJoInbrpfQpadwaOMr4FGGiEgUJTd8KC1kriUK6PeZEHO
 nV6sfc33WMMm4GUzZjjBhXnHgsAMQZlqcS79THpOASIYi+4adY3Xr0Qj0ZL4ciACIv1t
 h4PUcCAGr+CEprEVxsGku86uQJBShO8X2gpfD4RzgQrhPUrsSAFWqivdG4I+cf6oizij
 dFWEQSlmg3qLSYzkIHWVrG4wvSIPx25c0aa4RMR6tnQb/7nM6ZohhNOEsQfDK7b1+SV/
 6GZMk+ddR4YpeyfY5OOPh/2PvskaYlFg9lvHl5j/YnInbtuM59l7QSu20EtGP9uCGpjT
 KViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=flXAlKZocQHTDs+0ehm1EKqxHkH5LSlN9/W2U0yck8A=;
 b=P2ywFMxG8XK8zfICVOXXMdtkD3GLuexHOma7oFEAG5LJnbZlpQY/nOmnxeWpFXFtHB
 +Lv9BtNORbr+7ZkD2gtbAGivglG3qzZuMJIS3fUgB212Yy+0TWEqBqnrB5I3L4VG4bUP
 +MfKbNvACshaOt7lhh7VxOktN+DLk26XA4fWYstGeqk03liIpdOQfxWE7Bte1Ou5dZoE
 72gTfKAresIoEkpM7HASgfTnTAIYBHXnYgM+fSQreyPLyoyw9KYdt2Jyy+J4+8eECx1Y
 1MzQEk/f7CjBmolLpEQdrmNsRSXY/OJUUgwjelXPpbfPVvO5LS/nsETmyu26+YmTc1Zg
 KbiQ==
X-Gm-Message-State: APjAAAVISIR8xXrxw5wRv8CE+FlkTW05vyoRJWZxrYNDwDvYPZSUGOY1
 1RdwNucunikb+DUFWFVoT7fuzo1ymcNedu4vA5k=
X-Google-Smtp-Source: APXvYqyt9w7KlFXlqoSFqw65xnCDkuDRWerKetvY1rtsGT9JJ7f9lF3Y70Rjh1KwoOtiAgD8BUBqVxM6LZZjr3QJdpo=
X-Received: by 2002:a92:81d9:: with SMTP id q86mr9302278ilk.67.1581288798075; 
 Sun, 09 Feb 2020 14:53:18 -0800 (PST)
MIME-Version: 1.0
References: <20200208165645.15657-1-f4bug@amsat.org>
 <20200208165645.15657-2-f4bug@amsat.org>
In-Reply-To: <20200208165645.15657-2-f4bug@amsat.org>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Sun, 9 Feb 2020 23:53:07 +0100
Message-ID: <CAPan3WoKbOGsgHMw9PR=LKyViDvwENjx9AM50dWG5+munsO9iQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/13] hw/arm/raspi: Use BCM2708 machine type with pre
 Device Tree kernels
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="00000000000018beab059e2c7db4"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::144
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
 Stephen Warren <swarren@nvidia.com>,
 =?UTF-8?Q?Zolt=C3=A1n_Baldaszti?= <bztemail@gmail.com>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 Alistair Francis <alistair@alistair23.me>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Igor Mammedov <imammedo@redhat.com>, Michael Chan <michael.chan@broadcom.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>, Kshitij Soni <kshitij.soni@broadcom.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000018beab059e2c7db4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 8, 2020 at 5:57 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
>
wrote:

> When booting without device tree, the Linux kernels uses the $R1
> register to determine the machine type. The list of values is
> registered at [1].
>
> There are two entries for the Raspberry Pi:
>
> - https://www.arm.linux.org.uk/developer/machines/list.php?mid=3D3138
>   name: MACH_TYPE_BCM2708
>   value: 0xc42 (3138)
>   status: Active, not mainlined
>   date: 15 Oct 2010
>
> - https://www.arm.linux.org.uk/developer/machines/list.php?mid=3D4828
>   name: MACH_TYPE_BCM2835
>   value: 4828
>   status: Active, mainlined
>   date: 6 Dec 2013
>
> QEMU always used the non-mainlined type MACH_TYPE_BCM2708.
> The value 0xc43 is registered to 'MX51_GGC' (processor i.MX51), and
> 0xc44 to 'Western Digital Sharespace NAS' (processor Marvell 88F5182).
>
> The Raspberry Pi foundation bootloader only sets the BCM2708 machine
> type, see [2] or [3]:
>
>  133 9:
>  134     mov r0, #0
>  135     ldr r1, =3D3138       @ BCM2708 machine id
>  136     ldr r2, atags       @ ATAGS
>  137     bx  r4
>
> U-Boot only uses MACH_TYPE_BCM2708 (see [4]):
>
>  25 /*
>  26  * 2835 is a SKU in a series for which the 2708 is the first or
> primary SoC,
>  27  * so 2708 has historically been used rather than a dedicated 2835 ID=
.
>  28  *
>  29  * We don't define a machine type for bcm2709/bcm2836 since the RPi
> Foundation
>  30  * chose to use someone else's previously registered machine ID (3139=
,
> MX51_GGC)
>  31  * rather than obtaining a valid ID:-/
>  32  *
>  33  * For the bcm2837, hopefully a machine type is not needed, since
> everything
>  34  * is DT.
>  35  */
>
> While the definition MACH_BCM2709 with value 0xc43 was introduced in
> a commit described "Add 2709 platform for Raspberry Pi 2" out of the
> mainline Linux kernel, it does not seem used, and the platform is
> introduced with Device Tree support anyway (see [5] and [6]).
>
> Remove the unused values (0xc43 introduced in commit 1df7d1f9303aef
> "raspi: add raspberry pi 2 machine" and 0xc44 in commit bade58166f4
> "raspi: Raspberry Pi 3 support"), keeping only MACH_TYPE_BCM2708.
>
> [1] https://www.arm.linux.org.uk/developer/machines/
> [2]
> https://github.com/raspberrypi/tools/blob/920c7ed2e/armstubs/armstub7.S#L=
135
> [3]
> https://github.com/raspberrypi/tools/blob/49719d554/armstubs/armstub7.S#L=
64
> [4]
> https://gitlab.denx.de/u-boot/u-boot/blob/v2015.04/include/configs/rpi-co=
mmon.h#L18
> [5]
> https://github.com/raspberrypi/linux/commit/d9fac63adac#diff-6722037d7957=
0df5b392a49e0e006573R526
> [6]
> http://lists.infradead.org/pipermail/linux-rpi-kernel/2015-February/00126=
8.html
>
> Cc: Zolt=C3=A1n Baldaszti <bztemail@gmail.com>
> Cc: Pekka Enberg <penberg@iki.fi>
> Cc: Stephen Warren <swarren@nvidia.com>
> Cc: Kshitij Soni <kshitij.soni@broadcom.com>
> Cc: Michael Chan <michael.chan@broadcom.com>
> Cc: Andrew Baumann <Andrew.Baumann@microsoft.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>

Reviewed-by: Niek Linnenbank <nieklinnenbank@gmail.com>


> ---
> v3: Improved MACH_TYPE_BCM2708 comment (Zolt=C3=A1n)
> ---
>  hw/arm/raspi.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> index 3996f6c63a..f2ccabc662 100644
> --- a/hw/arm/raspi.c
> +++ b/hw/arm/raspi.c
> @@ -29,8 +29,8 @@
>  #define FIRMWARE_ADDR_3 0x80000 /* Pi 3 loads kernel.img here by default
> */
>  #define SPINTABLE_ADDR  0xd8 /* Pi 3 bootloader spintable */
>
> -/* Table of Linux board IDs for different Pi versions */
> -static const int raspi_boardid[] =3D {[1] =3D 0xc42, [2] =3D 0xc43, [3] =
=3D
> 0xc44};
> +/* Registered machine type (matches RPi Foundation bootloader and U-Boot=
)
> */
> +#define MACH_TYPE_BCM2708   3138
>
>  typedef struct RasPiState {
>      BCM283XState soc;
> @@ -116,7 +116,7 @@ static void setup_boot(MachineState *machine, int
> version, size_t ram_size)
>      static struct arm_boot_info binfo;
>      int r;
>
> -    binfo.board_id =3D raspi_boardid[version];
> +    binfo.board_id =3D MACH_TYPE_BCM2708;
>      binfo.ram_size =3D ram_size;
>      binfo.nb_cpus =3D machine->smp.cpus;
>
> --
> 2.21.1
>
>

--=20
Niek Linnenbank

--00000000000018beab059e2c7db4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sat, Feb 8, 2020 at 5:57 PM Philip=
pe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.org">f4bug@amsat.or=
g</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>When booting without device tree, the Linux kernels uses the $R1<br>
register to determine the machine type. The list of values is<br>
registered at [1].<br>
<br>
There are two entries for the Raspberry Pi:<br>
<br>
- <a href=3D"https://www.arm.linux.org.uk/developer/machines/list.php?mid=
=3D3138" rel=3D"noreferrer" target=3D"_blank">https://www.arm.linux.org.uk/=
developer/machines/list.php?mid=3D3138</a><br>
=C2=A0 name: MACH_TYPE_BCM2708<br>
=C2=A0 value: 0xc42 (3138)<br>
=C2=A0 status: Active, not mainlined<br>
=C2=A0 date: 15 Oct 2010<br>
<br>
- <a href=3D"https://www.arm.linux.org.uk/developer/machines/list.php?mid=
=3D4828" rel=3D"noreferrer" target=3D"_blank">https://www.arm.linux.org.uk/=
developer/machines/list.php?mid=3D4828</a><br>
=C2=A0 name: MACH_TYPE_BCM2835<br>
=C2=A0 value: 4828<br>
=C2=A0 status: Active, mainlined<br>
=C2=A0 date: 6 Dec 2013<br>
<br>
QEMU always used the non-mainlined type MACH_TYPE_BCM2708.<br>
The value 0xc43 is registered to &#39;MX51_GGC&#39; (processor i.MX51), and=
<br>
0xc44 to &#39;Western Digital Sharespace NAS&#39; (processor Marvell 88F518=
2).<br>
<br>
The Raspberry Pi foundation bootloader only sets the BCM2708 machine<br>
type, see [2] or [3]:<br>
<br>
=C2=A0133 9:<br>
=C2=A0134=C2=A0 =C2=A0 =C2=A0mov r0, #0<br>
=C2=A0135=C2=A0 =C2=A0 =C2=A0ldr r1, =3D3138=C2=A0 =C2=A0 =C2=A0 =C2=A0@ BC=
M2708 machine id<br>
=C2=A0136=C2=A0 =C2=A0 =C2=A0ldr r2, atags=C2=A0 =C2=A0 =C2=A0 =C2=A0@ ATAG=
S<br>
=C2=A0137=C2=A0 =C2=A0 =C2=A0bx=C2=A0 r4<br>
<br>
U-Boot only uses MACH_TYPE_BCM2708 (see [4]):<br>
<br>
=C2=A025 /*<br>
=C2=A026=C2=A0 * 2835 is a SKU in a series for which the 2708 is the first =
or primary SoC,<br>
=C2=A027=C2=A0 * so 2708 has historically been used rather than a dedicated=
 2835 ID.<br>
=C2=A028=C2=A0 *<br>
=C2=A029=C2=A0 * We don&#39;t define a machine type for bcm2709/bcm2836 sin=
ce the RPi Foundation<br>
=C2=A030=C2=A0 * chose to use someone else&#39;s previously registered mach=
ine ID (3139, MX51_GGC)<br>
=C2=A031=C2=A0 * rather than obtaining a valid ID:-/<br>
=C2=A032=C2=A0 *<br>
=C2=A033=C2=A0 * For the bcm2837, hopefully a machine type is not needed, s=
ince everything<br>
=C2=A034=C2=A0 * is DT.<br>
=C2=A035=C2=A0 */<br>
<br>
While the definition MACH_BCM2709 with value 0xc43 was introduced in<br>
a commit described &quot;Add 2709 platform for Raspberry Pi 2&quot; out of =
the<br>
mainline Linux kernel, it does not seem used, and the platform is<br>
introduced with Device Tree support anyway (see [5] and [6]).<br>
<br>
Remove the unused values (0xc43 introduced in commit 1df7d1f9303aef<br>
&quot;raspi: add raspberry pi 2 machine&quot; and 0xc44 in commit bade58166=
f4<br>
&quot;raspi: Raspberry Pi 3 support&quot;), keeping only MACH_TYPE_BCM2708.=
<br>
<br>
[1] <a href=3D"https://www.arm.linux.org.uk/developer/machines/" rel=3D"nor=
eferrer" target=3D"_blank">https://www.arm.linux.org.uk/developer/machines/=
</a><br>
[2] <a href=3D"https://github.com/raspberrypi/tools/blob/920c7ed2e/armstubs=
/armstub7.S#L135" rel=3D"noreferrer" target=3D"_blank">https://github.com/r=
aspberrypi/tools/blob/920c7ed2e/armstubs/armstub7.S#L135</a><br>
[3] <a href=3D"https://github.com/raspberrypi/tools/blob/49719d554/armstubs=
/armstub7.S#L64" rel=3D"noreferrer" target=3D"_blank">https://github.com/ra=
spberrypi/tools/blob/49719d554/armstubs/armstub7.S#L64</a><br>
[4] <a href=3D"https://gitlab.denx.de/u-boot/u-boot/blob/v2015.04/include/c=
onfigs/rpi-common.h#L18" rel=3D"noreferrer" target=3D"_blank">https://gitla=
b.denx.de/u-boot/u-boot/blob/v2015.04/include/configs/rpi-common.h#L18</a><=
br>
[5] <a href=3D"https://github.com/raspberrypi/linux/commit/d9fac63adac#diff=
-6722037d79570df5b392a49e0e006573R526" rel=3D"noreferrer" target=3D"_blank"=
>https://github.com/raspberrypi/linux/commit/d9fac63adac#diff-6722037d79570=
df5b392a49e0e006573R526</a><br>
[6] <a href=3D"http://lists.infradead.org/pipermail/linux-rpi-kernel/2015-F=
ebruary/001268.html" rel=3D"noreferrer" target=3D"_blank">http://lists.infr=
adead.org/pipermail/linux-rpi-kernel/2015-February/001268.html</a><br>
<br>
Cc: Zolt=C3=A1n Baldaszti &lt;<a href=3D"mailto:bztemail@gmail.com" target=
=3D"_blank">bztemail@gmail.com</a>&gt;<br>
Cc: Pekka Enberg &lt;<a href=3D"mailto:penberg@iki.fi" target=3D"_blank">pe=
nberg@iki.fi</a>&gt;<br>
Cc: Stephen Warren &lt;<a href=3D"mailto:swarren@nvidia.com" target=3D"_bla=
nk">swarren@nvidia.com</a>&gt;<br>
Cc: Kshitij Soni &lt;<a href=3D"mailto:kshitij.soni@broadcom.com" target=3D=
"_blank">kshitij.soni@broadcom.com</a>&gt;<br>
Cc: Michael Chan &lt;<a href=3D"mailto:michael.chan@broadcom.com" target=3D=
"_blank">michael.chan@broadcom.com</a>&gt;<br>
Cc: Andrew Baumann &lt;<a href=3D"mailto:Andrew.Baumann@microsoft.com" targ=
et=3D"_blank">Andrew.Baumann@microsoft.com</a>&gt;<br>
Reviewed-by: Alistair Francis &lt;<a href=3D"mailto:alistair.francis@wdc.co=
m" target=3D"_blank">alistair.francis@wdc.com</a>&gt;<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsa=
t.org" target=3D"_blank">f4bug@amsat.org</a>&gt;<br></blockquote><div><br><=
/div><div>Reviewed-by: Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank=
@gmail.com">nieklinnenbank@gmail.com</a>&gt;<br></div><div>=C2=A0</div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
v3: Improved MACH_TYPE_BCM2708 comment (Zolt=C3=A1n)<br>
---<br>
=C2=A0hw/arm/raspi.c | 6 +++---<br>
=C2=A01 file changed, 3 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c<br>
index 3996f6c63a..f2ccabc662 100644<br>
--- a/hw/arm/raspi.c<br>
+++ b/hw/arm/raspi.c<br>
@@ -29,8 +29,8 @@<br>
=C2=A0#define FIRMWARE_ADDR_3 0x80000 /* Pi 3 loads kernel.img here by defa=
ult */<br>
=C2=A0#define SPINTABLE_ADDR=C2=A0 0xd8 /* Pi 3 bootloader spintable */<br>
<br>
-/* Table of Linux board IDs for different Pi versions */<br>
-static const int raspi_boardid[] =3D {[1] =3D 0xc42, [2] =3D 0xc43, [3] =
=3D 0xc44};<br>
+/* Registered machine type (matches RPi Foundation bootloader and U-Boot) =
*/<br>
+#define MACH_TYPE_BCM2708=C2=A0 =C2=A03138<br>
<br>
=C2=A0typedef struct RasPiState {<br>
=C2=A0 =C2=A0 =C2=A0BCM283XState soc;<br>
@@ -116,7 +116,7 @@ static void setup_boot(MachineState *machine, int versi=
on, size_t ram_size)<br>
=C2=A0 =C2=A0 =C2=A0static struct arm_boot_info binfo;<br>
=C2=A0 =C2=A0 =C2=A0int r;<br>
<br>
-=C2=A0 =C2=A0 binfo.board_id =3D raspi_boardid[version];<br>
+=C2=A0 =C2=A0 binfo.board_id =3D MACH_TYPE_BCM2708;<br>
=C2=A0 =C2=A0 =C2=A0binfo.ram_size =3D ram_size;<br>
=C2=A0 =C2=A0 =C2=A0binfo.nb_cpus =3D machine-&gt;smp.cpus;<br>
<br>
-- <br>
2.21.1<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--00000000000018beab059e2c7db4--

