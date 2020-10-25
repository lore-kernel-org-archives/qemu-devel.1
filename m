Return-Path: <SRS0=AG+E=EA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE551C388F7
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2020 16:25:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9A1C20874
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2020 16:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3tck0O6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9A1C20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWiqA-000503-Rs
	for qemu-devel@archiver.kernel.org; Sun, 25 Oct 2020 12:25:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56204)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1kWioR-0004H2-Gb; Sun, 25 Oct 2020 12:24:08 -0400
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:42783)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1kWioO-0001Yp-SG; Sun, 25 Oct 2020 12:24:07 -0400
Received: by mail-il1-x144.google.com with SMTP id c11so2906155iln.9;
 Sun, 25 Oct 2020 09:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WsAyD3ZiWS/7YfRroLPs2vCeM9O/uHDvc4R0hnn4d9Q=;
 b=b3tck0O6+SP2dep0g5bF3wdHV8laoxnVpzyQ3nep9dlVYhuM400Pt2BLI8RdTMsobZ
 bxi1n3OXfBSn6WPC7VngrlGicubUBeyLiqW4TznbCyEVkwqjZzvjp0ZaYGac1sNRCWuC
 oyetGjn4jCQijiW+NDIHthElro8+Gkw7Hb4I/vLpwKco9vQY3LzSLseM9VXnDKFVnuqy
 2ZyxJo+Yx3fJ+dtpD1IiYlwRz/dzF9ZgRfCUR5Enht1ZvgXtb7U6ixEk6EyXkG96+eCr
 /LE1FCmQvztbmw+FOy5e6T/7vRfEEiq4HqZNvT3vpX0lwzS8UEX0Dc1GVpUxDcYd/2VT
 H9wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WsAyD3ZiWS/7YfRroLPs2vCeM9O/uHDvc4R0hnn4d9Q=;
 b=JjVFHxs4OesX0KJCXlyccIgymCiwvKjwjeVgH3Eaq/hr/JM7yxInGQcgLSrt7g9zTJ
 0QJTpH/7JwO82kKxKsouItIQpVveclL1pcT9eQLb+2JZvlkANtk99jlJuweDHChPbtLW
 J/FIoVNv1keglsVcLSi3pT0cFQuyJmF7bahkNVW4g4j1fJdnDZjHLFGmF3AFumP0Z9R3
 2SqndQMxfpTcS+bIki5c+BEM/PK59jsNEbqHfkYj/pM3w+2CT+VdrPqYHao4TkGKKep3
 c1Uxi4QXGJ0PDHv+P0rmppexaDSJKYtVrm7YjTuEVxAiNg7cVPwTZ18hp2xB2y1Pljbu
 Psgw==
X-Gm-Message-State: AOAM530DKrmmR86wWVT/t10wppnJ2ADiwtolxRZWSh3/ac0Hvi2KvdYY
 nqWy+sx2Gpk7rRb9JRu7UVdA/MaZkNY5rFeZrn8=
X-Google-Smtp-Source: ABdhPJzEHDLuZruFbjyFI92/tNAt0JtcmHvC0lndHFaWsp2X4TiRYSaWqiEUGJr1fpY5eSVuscrtjve4XBuIzCYgTWk=
X-Received: by 2002:a92:85d5:: with SMTP id f204mr6975424ilh.45.1603643043458; 
 Sun, 25 Oct 2020 09:24:03 -0700 (PDT)
MIME-Version: 1.0
References: <20201024215200.494209-1-nieklinnenbank@gmail.com>
 <fd949ad0-f7fd-561e-33d8-57133a9afd31@amsat.org>
 <3bb92403-f955-d887-a301-1ff38259b49f@amsat.org>
In-Reply-To: <3bb92403-f955-d887-a301-1ff38259b49f@amsat.org>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Mon, 26 Oct 2020 00:48:13 +0100
Message-ID: <CAPan3WoC8W1-P0i=7zj98nq+EEiVfG3KZZRVhOjsJ=yZGeLF4Q@mail.gmail.com>
Subject: Re: [PATCH] tests/acceptance: expand Orange Pi PC SD images for
 NetBSD, Armbian above nearest power of two
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="000000000000f3b2ed05b2813d15"
Received-SPF: pass client-ip=2607:f8b0:4864:20::144;
 envelope-from=nieklinnenbank@gmail.com; helo=mail-il1-x144.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DATE_IN_FUTURE_06_12=1.947,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Bin Meng <bin.meng@windriver.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000f3b2ed05b2813d15
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Philippe,

On Sun, Oct 25, 2020 at 1:11 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g>
wrote:

> On 10/25/20 2:31 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> > Hi Niek,
> >
> > On 10/24/20 11:52 PM, Niek Linnenbank wrote:
> >> The acceptance tests for the Orange Pi PC need to expand the SD card
> >> images
> >> to a size which is a power of two. As Qemu uses the size of the SD
> >> image file
> >> as well for the size of the emulated SD card, this can sometimes give
> >> problems
> >> for guests that assume a certain minimum size of the SD card.
> >>
> >> This commit resolves the following acceptance test error for the
> >> NetBSD 9.0 test
> >> of the Orange Pi PC by increasing the size of the expanded SD card
> >> image to two times
> >> the nearest power of two:
> >>
> >>     (5/5)
> >>
> tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi=
_uboot_netbsd9:
>
> >> |console: U-Boot SPL 2020.01+dfsg-1 (Jan 08 2020 - 08:19:44 +0000)
> >>    console: DRAM: 1024 MiB
> >>    console: Failed to set core voltage! Can't set CPU frequency
> >>    /console: Trying to boot from MMC1
> >>    console: U-Boot 2020.01+dfsg-1 (Jan 08 2020 - 08:19:44 +0000)
> >> Allwinner Technology
> >>    ...
> >>    console: Starting kernel ...
> >>    console: [   1.0000000] NetBSD/evbarm (fdt) booting ...
> >>    ...
> >>    console: [   1.3300167] sdmmc0: SD card status: 4-bit, C0
> >>    console: [   1.3300167] ld0 at sdmmc0:
> >> <0xaa:0x5859:QEMU!:0x01:0xdeadbeef:0x062>
> >
> > The test has this comment:
> >
> >     # This test download a 304MB compressed image and expand it to 2GB
> >
> > Once uncompressed the image is ~1.2GB before rounding to 2GB.
> >
> >>    console: [   1.3430678] ld0: 1024 MB, 1040 cyl, 32 head, 63 sec,
> >> 512 bytes/sect x 2097152 sectors
> >
> > Why the card appears as 1GB??     ^^^^^^^
>

Very well spotted Philippe. Indeed that is strange and is probably also why
we are getting these issues.


> >
> > Can you try reverting commit 6d2d4069c47?
> > ("sd: Correct the maximum size of a Standard Capacity SD Memory Card")
>
>
I've tried your suggestion and indeed for the NetBSD 9.0 test, reverting
6d2d4069c47 resolves the error for NetBSD 9.0.
But the armbian tests fail with this output:

 (4/6)
tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi_b=
ionic_19_11:
/console: DRAM: 1024 MiB
console: Failed to set core voltage! Can't set CPU frequency
console: Trying to boot from MMC1
console: U-Boot 2019.04-armbian (Nov 18 2019 - 23:08:35 +0100) Allwinner
Technology
console: CPU:   Allwinner H3 (SUN8I 0000)
...
console: Autoboot in 1 seconds, press <Space> to stop
/console: switch to partitions #0, OK
console: mmc0 is current device
...
console: Loading Device Tree to 49757000, end 497c6fff ... OK
console: Starting kernel ...
console: Uncompressing Linux... done, booting the kernel.
/console: [  149.045498] debugfs: Directory '1c22c00.codec' with parent 'H3
Audio Codec' already present!
INTERRUPTED: Test interrupted by SIGTERM\nRunner error occurred: Timeout
reached\nOriginal status: ERROR\n

The 'setenv extraargs' isn't done when 'Autoboot in' appears, which is why
there is much less output from the kernel.
And it looks like that is because 'U-Boot SPL' isn't printed in the output
so the python test is still waiting for that.

However with the new patch submitted by Bin just now on the list, all tests
are passing again like before, including the new 20.08 armbian test:
  https://lists.gnu.org/archive/html/qemu-devel/2020-10/msg07318.html

(I'll reply to that message shortly)

Regards,
Niek



> Now I remember, I hit the similar problem 2 years ago :S
>
> See the description of the C_SIZE field in CSD register:
>
>    "To indicate 2 GByte card, BLOCK_LEN shall be 1024 bytes."
>
> This model uses a fixed BLOCK_LEN =3D 512 bytes.
>
> >
> >>    console: [   1.4102580] ld0: 4-bit width, High-Speed/SDR25, 50.000
> MHz
> >>    console: [   2.0674392] WARNING: 4 errors while detecting hardware;
> >> check system log.
> >>    console: [   2.0674392] boot device: ld0
> >>    console: [   2.0775401] root on ld0a dumps on ld0b
> >>    console: [   2.0977679] vfs_mountroot: can't open root device
> >>    console: [   2.0977679] cannot mount root, error =3D 6
> >>    INTERRUPTED: Test interrupted by SIGTERM\nRunner error occurred:
> >> Timeout reached.
> >>
> >> Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> >> Based-on: ("[RFC PATCH 0/4] tests/acceptance: Test U-Boot/Linux from
> >> Armbian 20.08 on Orange Pi PC")
> >> ---
> >>   tests/acceptance/boot_linux_console.py | 10 +++++-----
> >>   1 file changed, 5 insertions(+), 5 deletions(-)
> >
>


--=20
Niek Linnenbank

--000000000000f3b2ed05b2813d15
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hello Philippe,<br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, Oct 25, 2020=
 at 1:11 PM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.o=
rg">f4bug@amsat.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">On 10/25/20 2:31 AM, Philippe Mathieu-Daud=C3=A9 wrote:<=
br>
&gt; Hi Niek,<br>
&gt; <br>
&gt; On 10/24/20 11:52 PM, Niek Linnenbank wrote:<br>
&gt;&gt; The acceptance tests for the Orange Pi PC need to expand the SD ca=
rd <br>
&gt;&gt; images<br>
&gt;&gt; to a size which is a power of two. As Qemu uses the size of the SD=
 <br>
&gt;&gt; image file<br>
&gt;&gt; as well for the size of the emulated SD card, this can sometimes g=
ive <br>
&gt;&gt; problems<br>
&gt;&gt; for guests that assume a certain minimum size of the SD card.<br>
&gt;&gt;<br>
&gt;&gt; This commit resolves the following acceptance test error for the <=
br>
&gt;&gt; NetBSD 9.0 test<br>
&gt;&gt; of the Orange Pi PC by increasing the size of the expanded SD card=
 <br>
&gt;&gt; image to two times<br>
&gt;&gt; the nearest power of two:<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 (5/5) <br>
&gt;&gt; tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_o=
rangepi_uboot_netbsd9: <br>
&gt;&gt; |console: U-Boot SPL 2020.01+dfsg-1 (Jan 08 2020 - 08:19:44 +0000)=
<br>
&gt;&gt; =C2=A0=C2=A0 console: DRAM: 1024 MiB<br>
&gt;&gt; =C2=A0=C2=A0 console: Failed to set core voltage! Can&#39;t set CP=
U frequency<br>
&gt;&gt; =C2=A0=C2=A0 /console: Trying to boot from MMC1<br>
&gt;&gt; =C2=A0=C2=A0 console: U-Boot 2020.01+dfsg-1 (Jan 08 2020 - 08:19:4=
4 +0000) <br>
&gt;&gt; Allwinner Technology<br>
&gt;&gt; =C2=A0=C2=A0 ...<br>
&gt;&gt; =C2=A0=C2=A0 console: Starting kernel ...<br>
&gt;&gt; =C2=A0=C2=A0 console: [=C2=A0=C2=A0 1.0000000] NetBSD/evbarm (fdt)=
 booting ...<br>
&gt;&gt; =C2=A0=C2=A0 ...<br>
&gt;&gt; =C2=A0=C2=A0 console: [=C2=A0=C2=A0 1.3300167] sdmmc0: SD card sta=
tus: 4-bit, C0<br>
&gt;&gt; =C2=A0=C2=A0 console: [=C2=A0=C2=A0 1.3300167] ld0 at sdmmc0: <br>
&gt;&gt; &lt;0xaa:0x5859:QEMU!:0x01:0xdeadbeef:0x062&gt;<br>
&gt; <br>
&gt; The test has this comment:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0=C2=A0 # This test download a 304MB compressed image and e=
xpand it to 2GB<br>
&gt; <br>
&gt; Once uncompressed the image is ~1.2GB before rounding to 2GB.<br>
&gt; <br>
&gt;&gt; =C2=A0=C2=A0 console: [=C2=A0=C2=A0 1.3430678] ld0: 1024 MB, 1040 =
cyl, 32 head, 63 sec, <br>
&gt;&gt; 512 bytes/sect x 2097152 sectors<br>
&gt; <br>
&gt; Why the card appears as 1GB??=C2=A0=C2=A0=C2=A0=C2=A0 ^^^^^^^<br></blo=
ckquote><div><br></div><div>Very well spotted Philippe. Indeed that is stra=
nge and is probably also why we are getting these issues.<br></div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; <br>
&gt; Can you try reverting commit 6d2d4069c47?<br>
&gt; (&quot;sd: Correct the maximum size of a Standard Capacity SD Memory C=
ard&quot;)<br>
<br></blockquote><div><br></div><div>I&#39;ve tried your suggestion and ind=
eed for the NetBSD 9.0 test, reverting 6d2d4069c47 resolves the error for N=
etBSD 9.0.</div><div>But the armbian tests fail with this output:</div><div=
><br></div><div>=C2=A0(4/6) tests/acceptance/boot_linux_console.py:BootLinu=
xConsole.test_arm_orangepi_bionic_19_11: /console: DRAM: 1024 MiB<br>consol=
e: Failed to set core voltage! Can&#39;t set CPU frequency<br>console: Tryi=
ng to boot from MMC1<br>console: U-Boot 2019.04-armbian (Nov 18 2019 - 23:0=
8:35 +0100) Allwinner Technology<br>console: CPU: =C2=A0 Allwinner H3 (SUN8=
I 0000)</div><div>...</div><div>console: Autoboot in 1 seconds, press &lt;S=
pace&gt; to stop<br>/console: switch to partitions #0, OK<br>console: mmc0 =
is current device<br>...</div><div>console: Loading Device Tree to 49757000=
, end 497c6fff ... OK<br>console: Starting kernel ...<br>console: Uncompres=
sing Linux... done, booting the kernel.<br>/console: [ =C2=A0149.045498] de=
bugfs: Directory &#39;1c22c00.codec&#39; with parent &#39;H3 Audio Codec&#3=
9; already present!<br>INTERRUPTED: Test interrupted by SIGTERM\nRunner err=
or occurred: Timeout reached\nOriginal status: ERROR\n</div><div><br></div>=
<div>The &#39;setenv extraargs&#39; isn&#39;t done when &#39;Autoboot in&#3=
9; appears, which is why there is much less output from the kernel.<br></di=
v><div>And it looks like that is because &#39;U-Boot SPL&#39; isn&#39;t pri=
nted in the output so the python test is still waiting for that.</div><div>=
<br></div><div>However with the new patch submitted by Bin just now on the =
list, all tests are passing again like before, including the new 20.08 armb=
ian test:</div><div>=C2=A0 <a href=3D"https://lists.gnu.org/archive/html/qe=
mu-devel/2020-10/msg07318.html">https://lists.gnu.org/archive/html/qemu-dev=
el/2020-10/msg07318.html</a></div><div><br></div><div>(I&#39;ll reply to th=
at message shortly)</div><div><br></div><div>Regards,</div><div>Niek<br></d=
iv><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
Now I remember, I hit the similar problem 2 years ago :S<br>
<br>
See the description of the C_SIZE field in CSD register:<br>
<br>
=C2=A0 =C2=A0&quot;To indicate 2 GByte card, BLOCK_LEN shall be 1024 bytes.=
&quot;<br>
<br>
This model uses a fixed BLOCK_LEN =3D 512 bytes.<br>
<br>
&gt; <br>
&gt;&gt; =C2=A0=C2=A0 console: [=C2=A0=C2=A0 1.4102580] ld0: 4-bit width, H=
igh-Speed/SDR25, 50.000 MHz<br>
&gt;&gt; =C2=A0=C2=A0 console: [=C2=A0=C2=A0 2.0674392] WARNING: 4 errors w=
hile detecting hardware; <br>
&gt;&gt; check system log.<br>
&gt;&gt; =C2=A0=C2=A0 console: [=C2=A0=C2=A0 2.0674392] boot device: ld0<br=
>
&gt;&gt; =C2=A0=C2=A0 console: [=C2=A0=C2=A0 2.0775401] root on ld0a dumps =
on ld0b<br>
&gt;&gt; =C2=A0=C2=A0 console: [=C2=A0=C2=A0 2.0977679] vfs_mountroot: can&=
#39;t open root device<br>
&gt;&gt; =C2=A0=C2=A0 console: [=C2=A0=C2=A0 2.0977679] cannot mount root, =
error =3D 6<br>
&gt;&gt; =C2=A0=C2=A0 INTERRUPTED: Test interrupted by SIGTERM\nRunner erro=
r occurred: <br>
&gt;&gt; Timeout reached.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenban=
k@gmail.com" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt;<br>
&gt;&gt; Based-on: (&quot;[RFC PATCH 0/4] tests/acceptance: Test U-Boot/Lin=
ux from <br>
&gt;&gt; Armbian 20.08 on Orange Pi PC&quot;)<br>
&gt;&gt; ---<br>
&gt;&gt; =C2=A0 tests/acceptance/boot_linux_console.py | 10 +++++-----<br>
&gt;&gt; =C2=A0 1 file changed, 5 insertions(+), 5 deletions(-)<br>
&gt; <br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--000000000000f3b2ed05b2813d15--

