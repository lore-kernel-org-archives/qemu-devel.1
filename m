Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA06C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 19:56:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAF0020747
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 19:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJo7X3zZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAF0020747
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXV55-0001wt-Lu
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 15:56:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54258)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1kXV42-0001O9-V9; Tue, 27 Oct 2020 15:55:26 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:45378)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1kXV40-0008UE-An; Tue, 27 Oct 2020 15:55:26 -0400
Received: by mail-io1-xd44.google.com with SMTP id s7so1907842iol.12;
 Tue, 27 Oct 2020 12:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oWteFPu6wCQB8oebQwDec+/hTgn63s9L2xNFq013zQo=;
 b=aJo7X3zZAHiSjS0GA+QB0Zt5ppc3uVeaGD12HjrN95995taWkHAbDH730FDsr/Fbj7
 WlZOSGXUlESrgKvYqsWJT4YTBs8Ud0/oZYw/tBgClRS9g0ht2AWdpUQ2teUNoQg/k25a
 ZWqvxpjRRLMnztaBW+RqDtFHu7D3BpdfNjJ9NeJ9vi0L9CAd1Wz8jueCggdWH3hkgQZi
 1OJv2Dvd1anUQa41JAkfu3ya7Jw8hp8hfaZ422neE/HQvOEjGfu1WYlZFH58la0JcdQn
 BTSGuLJS7H5SglVtLx1PRtSjZ7vpcpSGXoIqSRKcnxRhDPE7LMKR1wmGzQaqJ3zKUYAK
 572A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oWteFPu6wCQB8oebQwDec+/hTgn63s9L2xNFq013zQo=;
 b=pE2fZhG84S7M3NxcrmF/ivarnZqWZ+PsLkZ0MRTm8SGJSU+3vxzX5U6GXLoOSgtO5F
 +TFgThew6aHF13MTMI4Bhx7pvFQbfLYeRlsiOHODKwZzhEaGuvKGpNgRH2pYs2oAGXBA
 3gWEtbRjM867rvESTCY4MIIWvTbCf3sXZheTiNZvs8tLMQdGUVXfZBI1NrYWa3Ra1TaR
 S0o8/azz1JWEdrFqc998P/71j78TfckGEMY0AuBzOyrNycctNd0wqOcQ2/e+pSFenIuX
 YRYcIyCenTQNu4TFiqKaipdJn/gWiANlPz+REjPJJ16bQJont+4WoeEX9Qz6tLT4ZbeG
 LZ/A==
X-Gm-Message-State: AOAM531Isq8rBaAQ3nD4GH8N/cSAfQMC47WKacqGIsgikQu1Cbgtjsef
 uowFE6UUdwQvaL+OrLFP2JspLXfScphwsSGAvPE=
X-Google-Smtp-Source: ABdhPJzUvUieYF4N5abrfEZXThRBeaAdN7lwd6VIlOWlhZeparRJ/gMfgF9smos0/MmIS2eaT8iiNKV4Bklzvb9sHUI=
X-Received: by 2002:a5d:91c7:: with SMTP id k7mr3391260ior.74.1603828521943;
 Tue, 27 Oct 2020 12:55:21 -0700 (PDT)
MIME-Version: 1.0
References: <20201024014954.21330-1-bmeng.cn@gmail.com>
 <1e4c44aa-7d2a-e773-fe8e-47b858137896@amsat.org>
In-Reply-To: <1e4c44aa-7d2a-e773-fe8e-47b858137896@amsat.org>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Wed, 28 Oct 2020 10:47:29 +0100
Message-ID: <CAPan3WqM1VGRB_K4AsBynrhzm-+DN9x2G7oOKHujSj-A1yH3Sg@mail.gmail.com>
Subject: Re: [PATCH] hw/sd: Zero out function selection fields before being
 populated
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="00000000000054c8b705b2ac6d8c"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d44;
 envelope-from=nieklinnenbank@gmail.com; helo=mail-io1-xd44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_FUTURE_12_24=3.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Bin Meng <bin.meng@windriver.com>, Bin Meng <bmeng.cn@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000054c8b705b2ac6d8c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Philippe, Bin,

Thanks for your support on this. I've just tried this patch and
unfortunately it doesn't seem to
resolve the issue, at least on my machine. This is the output that I get
when running the avocado test for NetBSD9.0:

 (5/5)
tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi_u=
boot_netbsd9:
|console: U-Boot SPL 2020.01+dfsg-1 (Jan 08 2020 - 08:19:44 +0000)
console: DRAM: 1024 MiB
console: Failed to set core voltage! Can't set CPU frequency
console: Trying to boot from MMC1
console: U-Boot 2020.01+dfsg-1 (Jan 08 2020 - 08:19:44 +0000) Allwinner
Technology
console: CPU:   Allwinner H3 (SUN8I 0000)
...
console: [   1.2957642] sdmmc0: SD card status: 4-bit, C0
console: [   1.3094731] ld0 at sdmmc0:
<0xaa:0x5859:QEMU!:0x01:0xdeadbeef:0x062>
console: [   1.3159383] ld0: 1024 MB, 1040 cyl, 32 head, 63 sec, 512
bytes/sect x 2097152 sectors
console: [   1.3763222] ld0: 4-bit width, High-Speed/SDR25, 50.000 MHz
console: [   2.0592109] WARNING: 4 errors while detecting hardware; check
system log.
console: [   2.0693403] boot device: ld0
console: [   2.0798960] root on ld0a dumps on ld0b
console: [   2.0994141] vfs_mountroot: can't open root device
console: [   2.0994141] cannot mount root, error =3D 6
<FREEZE>

When starting NetBSD 9.0 manually, it shows clearly that the SD card is
recognized with 1GiB size, also from U-Boot:
$ qemu-system-arm -M orangepi-pc -nographic -nic user -sd ./armv7.img
WARNING: Image format was not specified for './armv7.img' and probing
guessed raw.
         Automatically detecting the format is dangerous for raw images,
write operations on block 0 will be restricted.
         Specify the 'raw' format explicitly to remove the restrictions.

U-Boot SPL 2020.07-00610-g610e1487c8 (Jul 11 2020 - 22:31:58 +0200)
DRAM: 1024 MiB
Failed to set core voltage! Can't set CPU frequency
Trying to boot from MMC1

U-Boot 2020.07-00610-g610e1487c8 (Jul 11 2020 - 22:31:58 +0200) Allwinner
Technology

CPU:   Allwinner H3 (SUN8I 0000)
Model: Xunlong Orange Pi PC
DRAM:  1 GiB
MMC:   mmc@1c0f000: 0
...
Hit any key to stop autoboot:  0
=3D> mmc info
Device: mmc@1c0f000
Manufacturer ID: aa
OEM: 5859
Name: QEMU!
Bus Speed: 50000000
Mode: SD High Speed (50MHz)
Rd Block Len: 512
SD version 2.0
High Capacity: No
Capacity: 1 GiB
Bus Width: 4-bit
Erase Group Size: 512 Bytes
=3D>
=3D> boot
8846552 bytes read in 931 ms (9.1 MiB/s)
...
[   1.3447558] sdmmc0: SD card status: 4-bit, C0
[   1.3546801] ld0 at sdmmc0: <0xaa:0x5859:QEMU!:0x01:0xdeadbeef:0x062>
[   1.3647790] ld0: 1024 MB, 1040 cyl, 32 head, 63 sec, 512 bytes/sect x
2097152 sectors
[   1.4150230] ld0: 4-bit width, High-Speed/SDR25, 50.000 MHz
[   2.0800893] WARNING: 4 errors while detecting hardware; check system log=
.
[   2.0800893] boot device: ld0
[   2.0900792] root on ld0a dumps on ld0b
[   2.1004160] vfs_mountroot: can't open root device
[   2.1004160] cannot mount root, error =3D 6
[   2.1004160] root device (default ld0a):
<FREEZE>

Note that the image has been resized to 2GiB with qemu-img:
$ ls -alh armv7.img
-rw-rw-r-- 1 user user 2,0G okt 28 22:45 armv7.img

The previous patch proposed by Bin did resolve the error ("hw/sd: Fix 2GiB
card CSD register values" ):
 https://lists.gnu.org/archive/html/qemu-devel/2020-10/msg07318.html

Although I see that this patch is now in master
(89c6700fe7eed9195f10055751edbc6d5e7ab940),
can you please confirm that the issue is still present when testing this on
your machine as well?

With kind regards,
Niek


On Mon, Oct 26, 2020 at 9:10 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g>
wrote:

> On 10/24/20 3:49 AM, Bin Meng wrote:
> > From: Bin Meng <bin.meng@windriver.com>
> >
> > The function selection fields (399:376) should be zeroed out to
> > prevent leftover from being or'ed into the switch function status
> > data structure.
> >
> > This fixes the boot failure as seen in the acceptance testing on
> > the orangepi target.
> >
> > Fixes: b638627c723a ("hw/sd: Fix incorrect populated function switch
> status data structure")
> > Reported-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> > Signed-off-by: Bin Meng <bin.meng@windriver.com>
> > ---
> >
> >   hw/sd/sd.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> > index c3febed243..bd10ec8fc4 100644
> > --- a/hw/sd/sd.c
> > +++ b/hw/sd/sd.c
> > @@ -824,6 +824,7 @@ static void sd_function_switch(SDState *sd, uint32_=
t
> arg)
> >       sd->data[12] =3D 0x80;    /* Supported group 1 functions */
> >       sd->data[13] =3D 0x03;
> >
> > +    memset(&sd->data[14], 0, 3);
> >       for (i =3D 0; i < 6; i ++) {
> >           new_func =3D (arg >> (i * 4)) & 0x0f;
> >           if (mode && new_func !=3D 0x0f)
> >
>
> Thanks, series applied to sd-next tree.
>
>

--=20
Niek Linnenbank

--00000000000054c8b705b2ac6d8c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello Philippe, Bin,</div><div><br></div><div>Thanks =
for your support on this. I&#39;ve just tried this patch and unfortunately =
it doesn&#39;t seem to</div><div>resolve the issue, at least on my machine.=
 This is the output that I get when running the avocado test for NetBSD9.0:=
<br></div><div><br></div><div>=C2=A0(5/5) tests/acceptance/boot_linux_conso=
le.py:BootLinuxConsole.test_arm_orangepi_uboot_netbsd9: |console: U-Boot SP=
L 2020.01+dfsg-1 (Jan 08 2020 - 08:19:44 +0000)<br>console: DRAM: 1024 MiB<=
br>console: Failed to set core voltage! Can&#39;t set CPU frequency<br>cons=
ole: Trying to boot from MMC1<br>console: U-Boot 2020.01+dfsg-1 (Jan 08 202=
0 - 08:19:44 +0000) Allwinner Technology<br>console: CPU: =C2=A0 Allwinner =
H3 (SUN8I 0000)</div><div>...</div><div>console: [ =C2=A0 1.2957642] sdmmc0=
: SD card status: 4-bit, C0<br>console: [ =C2=A0 1.3094731] ld0 at sdmmc0: =
&lt;0xaa:0x5859:QEMU!:0x01:0xdeadbeef:0x062&gt;<br>console: [ =C2=A0 1.3159=
383] ld0: 1024 MB, 1040 cyl, 32 head, 63 sec, 512 bytes/sect x 2097152 sect=
ors<br>console: [ =C2=A0 1.3763222] ld0: 4-bit width, High-Speed/SDR25, 50.=
000 MHz<br>console: [ =C2=A0 2.0592109] WARNING: 4 errors while detecting h=
ardware; check system log.<br>console: [ =C2=A0 2.0693403] boot device: ld0=
<br>console: [ =C2=A0 2.0798960] root on ld0a dumps on ld0b<br>console: [ =
=C2=A0 2.0994141] vfs_mountroot: can&#39;t open root device<br>console: [ =
=C2=A0 2.0994141] cannot mount root, error =3D 6</div><div>&lt;FREEZE&gt;</=
div><div><br></div><div>When starting NetBSD 9.0 manually, it shows clearly=
 that the SD card is recognized with 1GiB size, also from U-Boot:</div><div=
>$ qemu-system-arm -M orangepi-pc -nographic -nic user -sd ./armv7.img<br>W=
ARNING: Image format was not specified for &#39;./armv7.img&#39; and probin=
g guessed raw.<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Automatically detecting=
 the format is dangerous for raw images, write operations on block 0 will b=
e restricted.<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Specify the &#39;raw&#39=
; format explicitly to remove the restrictions.<br><br>U-Boot SPL 2020.07-0=
0610-g610e1487c8 (Jul 11 2020 - 22:31:58 +0200)<br>DRAM: 1024 MiB<br>Failed=
 to set core voltage! Can&#39;t set CPU frequency<br>Trying to boot from MM=
C1<br><br>U-Boot 2020.07-00610-g610e1487c8 (Jul 11 2020 - 22:31:58 +0200) A=
llwinner Technology<br><br>CPU: =C2=A0 Allwinner H3 (SUN8I 0000)<br>Model: =
Xunlong Orange Pi PC<br>DRAM: =C2=A01 GiB<br>MMC: =C2=A0 mmc@1c0f000: 0<br>=
</div><div>...</div><div>Hit any key to stop autoboot: =C2=A00 <br>=3D&gt; =
mmc info<br>Device: mmc@1c0f000<br>Manufacturer ID: aa<br>OEM: 5859<br>Name=
: QEMU! <br>Bus Speed: 50000000<br>Mode: SD High Speed (50MHz)<br>Rd Block =
Len: 512<br>SD version 2.0<br>High Capacity: No<br>Capacity: 1 GiB<br>Bus W=
idth: 4-bit<br>Erase Group Size: 512 Bytes<br>=3D&gt; <br>=3D&gt; boot<br>8=
846552 bytes read in 931 ms (9.1 MiB/s)</div><div>...</div><div>[ =C2=A0 1.=
3447558] sdmmc0: SD card status: 4-bit, C0<br>[ =C2=A0 1.3546801] ld0 at sd=
mmc0: &lt;0xaa:0x5859:QEMU!:0x01:0xdeadbeef:0x062&gt;<br>[ =C2=A0 1.3647790=
] ld0: 1024 MB, 1040 cyl, 32 head, 63 sec, 512 bytes/sect x 2097152 sectors=
<br>[ =C2=A0 1.4150230] ld0: 4-bit width, High-Speed/SDR25, 50.000 MHz<br>[=
 =C2=A0 2.0800893] WARNING: 4 errors while detecting hardware; check system=
 log.<br>[ =C2=A0 2.0800893] boot device: ld0<br>[ =C2=A0 2.0900792] root o=
n ld0a dumps on ld0b<br>[ =C2=A0 2.1004160] vfs_mountroot: can&#39;t open r=
oot device<br>[ =C2=A0 2.1004160] cannot mount root, error =3D 6<br>[ =C2=
=A0 2.1004160] root device (default ld0a):</div><div>&lt;FREEZE&gt;</div><d=
iv><br></div><div>Note that the image has been resized to 2GiB with qemu-im=
g:<br></div><div>$ ls -alh armv7.img<br>-rw-rw-r-- 1 user user 2,0G okt 28 =
22:45 armv7.img<br></div><div><br></div><div>The previous patch proposed by=
 Bin did resolve the error (&quot;hw/sd: Fix 2GiB card CSD register values&=
quot; ):<br></div><div>=C2=A0<a href=3D"https://lists.gnu.org/archive/html/=
qemu-devel/2020-10/msg07318.html">https://lists.gnu.org/archive/html/qemu-d=
evel/2020-10/msg07318.html</a></div><div><br></div><div><div>Although I see=
 that this patch is now in master (89c6700fe7eed9195f10055751edbc6d5e7ab940=
),<br></div></div><div>can you please confirm that the issue is still prese=
nt when testing this on your machine as well?</div><div><br></div><div>With=
 kind regards,</div><div>Niek<br></div><div><br></div></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Oct 26, 2020=
 at 9:10 AM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.o=
rg">f4bug@amsat.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">On 10/24/20 3:49 AM, Bin Meng wrote:<br>
&gt; From: Bin Meng &lt;<a href=3D"mailto:bin.meng@windriver.com" target=3D=
"_blank">bin.meng@windriver.com</a>&gt;<br>
&gt; <br>
&gt; The function selection fields (399:376) should be zeroed out to<br>
&gt; prevent leftover from being or&#39;ed into the switch function status<=
br>
&gt; data structure.<br>
&gt; <br>
&gt; This fixes the boot failure as seen in the acceptance testing on<br>
&gt; the orangepi target.<br>
&gt; <br>
&gt; Fixes: b638627c723a (&quot;hw/sd: Fix incorrect populated function swi=
tch status data structure&quot;)<br>
&gt; Reported-by: Michael Roth &lt;<a href=3D"mailto:mdroth@linux.vnet.ibm.=
com" target=3D"_blank">mdroth@linux.vnet.ibm.com</a>&gt;<br>
&gt; Signed-off-by: Bin Meng &lt;<a href=3D"mailto:bin.meng@windriver.com" =
target=3D"_blank">bin.meng@windriver.com</a>&gt;<br>
&gt; ---<br>
&gt; <br>
&gt;=C2=A0 =C2=A0hw/sd/sd.c | 1 +<br>
&gt;=C2=A0 =C2=A01 file changed, 1 insertion(+)<br>
&gt; <br>
&gt; diff --git a/hw/sd/sd.c b/hw/sd/sd.c<br>
&gt; index c3febed243..bd10ec8fc4 100644<br>
&gt; --- a/hw/sd/sd.c<br>
&gt; +++ b/hw/sd/sd.c<br>
&gt; @@ -824,6 +824,7 @@ static void sd_function_switch(SDState *sd, uint32=
_t arg)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0sd-&gt;data[12] =3D 0x80;=C2=A0 =C2=A0 /* Su=
pported group 1 functions */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0sd-&gt;data[13] =3D 0x03;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0 memset(&amp;sd-&gt;data[14], 0, 3);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; 6; i ++) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0new_func =3D (arg &gt;&gt; (i =
* 4)) &amp; 0x0f;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (mode &amp;&amp; new_func !=
=3D 0x0f)<br>
&gt; <br>
<br>
Thanks, series applied to sd-next tree.<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div>

--00000000000054c8b705b2ac6d8c--

