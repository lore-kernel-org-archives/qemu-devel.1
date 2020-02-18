Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C28FC3404D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 22:33:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC0D72176D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 22:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nghk/pB/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC0D72176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4BR8-0005ZY-2j
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 17:33:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39752)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1j4BQK-0004s2-SL
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 17:33:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1j4BQI-0002Ac-Rh
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 17:33:00 -0500
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:39328)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1j4BQD-0001x9-EN; Tue, 18 Feb 2020 17:32:54 -0500
Received: by mail-il1-x142.google.com with SMTP id f70so18800387ill.6;
 Tue, 18 Feb 2020 14:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PH57hqut1jKWd1MHIUY7LD2Vc7Fm11/Z0ViQLeEWljs=;
 b=nghk/pB/7ck/soqkn22e39mP8WwWXf700LZWd9wAZau8pS3GmNjq437pXlXCl2nWpV
 aKW5vxjRmE44wE+IZ8SH33vVzoAx2w4MigLQUgpdz74MkMuxmwIbZ+Y5zARD/I90dvp0
 5OLmAXFSXiNvdKDnpzGFbE7QZE7/vYQwuQDs/pRuwCFkGwN0oTj5jOii397aKLhmamjU
 ozFcuenO6x4Q9SIBv/lIWz3Ju8IMmUIcjl1ZxKyS/arYx6w2OeqxP8wDz1wUM1rREJKt
 UTQo5cO+mwXYITQGX3Qy+jngCvblQb6bp4EqUUTyxcdmLLFjrs2fLdALb31TpZj8kWlp
 jdSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PH57hqut1jKWd1MHIUY7LD2Vc7Fm11/Z0ViQLeEWljs=;
 b=lwK8kWb7KZemu6t/OyEeSC+x/wxLXgi1RITPlMCKdcwrGimc9jCwaCm021pjUg+heN
 lYnH6RZUvbkQaZPFX2JzKsYaE5+Cs+ntyRbuAUYBjzEgvmLhlSg4L2vYZ0vnZfEmxtUS
 en4IeD0yN9aNnUC1HpkcjTafZO2mGC7iXSZ9CTeWP68GmCCOxGshEU/KfLJR2Knib2tm
 I164ANCmV6zyWsg3DtGULsX713pm1YXTQ0JYJ/XYKVdcZENUM38HAxBi4VNFIfJf6MFe
 vTWgUSx3tH6fuu6Phe/JaxHn8K7gy2edTgTcD3R4cMAGcadmzq0nClVdK244FcoszYSn
 +/Vg==
X-Gm-Message-State: APjAAAUp5xG6J0FF5Tt+lKh64ni9FMXA0WD6hgyuinudCW1SUWJLaumm
 YRTilfOMgxbP+vT1giSOGje6kby6SWc3B2ZWKTI=
X-Google-Smtp-Source: APXvYqwy0+JaeW6v0hdyiYN0xaMylsz79jGNTVM0bwIZgC5BEPfVd9b2nsRiSocUE09AsdEj0Mq/QFQQMyUJCKQzo90=
X-Received: by 2002:a92:d5cf:: with SMTP id d15mr20707569ilq.306.1582065170725; 
 Tue, 18 Feb 2020 14:32:50 -0800 (PST)
MIME-Version: 1.0
References: <20200217204812.9857-1-linux@roeck-us.net>
 <1069ca0c-2902-1c76-d111-de6c6129b02b@redhat.com>
In-Reply-To: <1069ca0c-2902-1c76-d111-de6c6129b02b@redhat.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Tue, 18 Feb 2020 23:32:38 +0100
Message-ID: <CAPan3WrxkB+AAX27Qx3c6H+RQH3oYn6P-t4=bWDzjoUqf4nEEg@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] arm: allwinner: Wire up USB ports
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000008341b0059ee14063"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::142
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
 QEMU Developers <qemu-devel@nongnu.org>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000008341b0059ee14063
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Guenter, Philippe,

On Tue, Feb 18, 2020 at 7:39 AM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com>
wrote:

> Cc'ing Niek.
>
> On 2/17/20 9:48 PM, Guenter Roeck wrote:
> > Instantiate EHCI and OHCI controllers on Allwinner A10.
> >
> > The first patch in the series moves the declaration of EHCISysBusState
> > from hcd-ohci.c to hcd-ohci.h. This lets us add the structure to
> > AwA10State. Similar, TYPE_SYSBUS_OHCI is moved to be able to use it
> > outside its driver.
> >
> > The second patch introduces the ehci-sysbus property "companion-enable"=
.
> > This lets us use object_property_set_bool() to enable companion mode.
> >
> > The third patch instantiates EHCI and OHCI ports for Allwinner-A10
> > and marks the OHCI ports as companions of the respective EHCI ports.
> >
> > Tested by attaching various high speed and full speed devices, and by
> > booting from USB drive.
> >
> > v3: Rebased to master
> > v2: Add summary
> >      Rewrite to instantiate OHCI in companion mode; add patch 2/3
> >      Merge EHCI and OHCI instantiation into a single patch
> >
> > ----------------------------------------------------------------
> > Guenter Roeck (3):
> >        hw: usb: hcd-ohci: Move OHCISysBusState and TYPE_SYSBUS_OHCI to
> include file
> >        hcd-ehci: Introduce "companion-enable" sysbus property
> >        arm: allwinner: Wire up USB ports
> >
> >   hw/arm/allwinner-a10.c         | 43
> ++++++++++++++++++++++++++++++++++++++++++
> >   hw/usb/hcd-ehci-sysbus.c       |  2 ++
> >   hw/usb/hcd-ohci.c              | 15 ---------------
> >   hw/usb/hcd-ohci.h              | 16 ++++++++++++++++
> >   include/hw/arm/allwinner-a10.h |  6 ++++++
> >   5 files changed, 67 insertions(+), 15 deletions(-)
> >
>
>
Thanks for contributing this! I was able to test & verify it on my local
machine using latest Qemu master and linux 5.5.0.
I just had to add the -usb flag to the Qemu command and re-compile linux
with CONFIG_USB_STORAGE.

Output with buildroot on a USB mass storage disk as rootfs:

++ ./arm-softmmu/qemu-system-arm -M cubieboard -kernel
$HOME/cubie/linux.git/arch/arm/boot/zImage -nographic -append
'console=3DttyS0,115200 earlyprintk debug rootwait root=3D/dev/sda ro
init=3D/sbin/init' -dtb
$HOME/cubie/linux.git/arch/arm/boot/dts/sun4i-a10-cubieboard.dtb -m 512 -s
-usb -drive
if=3Dnone,id=3Dstick,file=3D$HOME/cubie/buildroot-2019.11/output/images/roo=
tfs.ext2
-device usb-storage,bus=3Dusb-bus.1,drive=3Dstick -nic user
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 5.5.0-rc3 (me@host) (gcc version 7.4.0
(Ubuntu/Linaro 7.4.0-1ubuntu1~18.04.1)) #6 SMP Tue Feb 18 23:21:36 CET 2020
[    0.000000] CPU: ARMv7 Processor [410fc080] revision 0 (ARMv7),
cr=3D10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT nonaliasing
instruction cache
[    0.000000] OF: fdt: Machine model: Cubietech Cubieboard
[    0.000000] Memory policy: Data cache writeback
...
[    4.559154] random: fast init done
[    5.481107] scsi 1:0:0:0: Direct-Access     QEMU     QEMU HARDDISK
 2.5+ PQ: 0 ANSI: 5
[    5.493282] sd 1:0:0:0: Power-on or device reset occurred
[    5.513539] sd 1:0:0:0: [sda] 122880 512-byte logical blocks: (62.9
MB/60.0 MiB)
[    5.521970] sd 1:0:0:0: [sda] Write Protect is off
[    5.522683] sd 1:0:0:0: [sda] Mode Sense: 63 00 00 08
[    5.524552] sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled,
doesn't support DPO or FUA
[    5.613064] sd 1:0:0:0: [sda] Attached SCSI disk
[    5.681764] EXT4-fs (sda): INFO: recovery required on readonly filesyste=
m
[    5.682530] EXT4-fs (sda): write access will be enabled during recovery
...
[    6.129348] EXT4-fs (sda): re-mounted. Opts: (null)
Starting syslogd: OK
Starting klogd: OK
Running sysctl: OK
Initializing random number generator: OK
Saving random seed: [    7.205617] random: dd: uninitialized urandom read
(512 bytes read)
OK
Starting network: OK

Welcome to Cubieboard2!
Cubieboard2 login:


Thanks!

Tested-by: Niek Linnenbank <nieklinnenbank@gmail.com>

Regards,
Niek


--=20
Niek Linnenbank

--0000000000008341b0059ee14063
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Guenter, Philippe,<br></div><br><div class=3D"gmai=
l_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 18, 2020 at 7:39=
 AM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com">ph=
ilmd@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">Cc&#39;ing Niek.<br>
<br></blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
On 2/17/20 9:48 PM, Guenter Roeck wrote:<br>
&gt; Instantiate EHCI and OHCI controllers on Allwinner A10.<br>
&gt; <br>
&gt; The first patch in the series moves the declaration of EHCISysBusState=
<br>
&gt; from hcd-ohci.c to hcd-ohci.h. This lets us add the structure to<br>
&gt; AwA10State. Similar, TYPE_SYSBUS_OHCI is moved to be able to use it<br=
>
&gt; outside its driver.<br>
&gt; <br>
&gt; The second patch introduces the ehci-sysbus property &quot;companion-e=
nable&quot;.<br>
&gt; This lets us use object_property_set_bool() to enable companion mode.<=
br>
&gt; <br>
&gt; The third patch instantiates EHCI and OHCI ports for Allwinner-A10<br>
&gt; and marks the OHCI ports as companions of the respective EHCI ports.<b=
r>
&gt; <br>
&gt; Tested by attaching various high speed and full speed devices, and by<=
br>
&gt; booting from USB drive.<br>
&gt; <br>
&gt; v3: Rebased to master<br>
&gt; v2: Add summary<br>
&gt;=C2=A0 =C2=A0 =C2=A0 Rewrite to instantiate OHCI in companion mode; add=
 patch 2/3<br>
&gt;=C2=A0 =C2=A0 =C2=A0 Merge EHCI and OHCI instantiation into a single pa=
tch<br>
&gt; <br>
&gt; ----------------------------------------------------------------<br>
&gt; Guenter Roeck (3):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 hw: usb: hcd-ohci: Move OHCISysBusState and=
 TYPE_SYSBUS_OHCI to include file<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 hcd-ehci: Introduce &quot;companion-enable&=
quot; sysbus property<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 arm: allwinner: Wire up USB ports<br>
&gt; <br>
&gt;=C2=A0 =C2=A0hw/arm/allwinner-a10.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =
43 ++++++++++++++++++++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0hw/usb/hcd-ehci-sysbus.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0=
 2 ++<br>
&gt;=C2=A0 =C2=A0hw/usb/hcd-ohci.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 | 15 ---------------<br>
&gt;=C2=A0 =C2=A0hw/usb/hcd-ohci.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 | 16 ++++++++++++++++<br>
&gt;=C2=A0 =C2=A0include/hw/arm/allwinner-a10.h |=C2=A0 6 ++++++<br>
&gt;=C2=A0 =C2=A05 files changed, 67 insertions(+), 15 deletions(-)<br>
&gt; <br>
<br>
</blockquote></div><div><br></div><div>Thanks for contributing this! I was =
able to test &amp; verify it on my local machine using latest Qemu master a=
nd linux 5.5.0.</div><div>I just had to add the -usb flag to the Qemu comma=
nd and re-compile linux with CONFIG_USB_STORAGE.</div><div><br></div><div>O=
utput with buildroot on a USB mass storage disk as rootfs:<br></div><div><b=
r></div><div>++ ./arm-softmmu/qemu-system-arm -M cubieboard -kernel $HOME/c=
ubie/linux.git/arch/arm/boot/zImage -nographic -append &#39;console=3DttyS0=
,115200 earlyprintk debug rootwait root=3D/dev/sda ro init=3D/sbin/init&#39=
; -dtb $HOME/cubie/linux.git/arch/arm/boot/dts/sun4i-a10-cubieboard.dtb -m =
512 -s -usb -drive if=3Dnone,id=3Dstick,file=3D$HOME/cubie/buildroot-2019.1=
1/output/images/rootfs.ext2 -device usb-storage,bus=3Dusb-bus.1,drive=3Dsti=
ck -nic user<br>[ =C2=A0 =C2=A00.000000] Booting Linux on physical CPU 0x0<=
br>[ =C2=A0 =C2=A00.000000] Linux version 5.5.0-rc3 (me@host) (gcc version =
7.4.0 (Ubuntu/Linaro 7.4.0-1ubuntu1~18.04.1)) #6 SMP Tue Feb 18 23:21:36 CE=
T 2020<br>[ =C2=A0 =C2=A00.000000] CPU: ARMv7 Processor [410fc080] revision=
 0 (ARMv7), cr=3D10c5387d<br>[ =C2=A0 =C2=A00.000000] CPU: PIPT / VIPT nona=
liasing data cache, VIPT nonaliasing instruction cache<br>[ =C2=A0 =C2=A00.=
000000] OF: fdt: Machine model: Cubietech Cubieboard<br>[ =C2=A0 =C2=A00.00=
0000] Memory policy: Data cache writeback<br></div><div>...<br></div><div>[=
 =C2=A0 =C2=A04.559154] random: fast init done<br>[ =C2=A0 =C2=A05.481107] =
scsi 1:0:0:0: Direct-Access =C2=A0 =C2=A0 QEMU =C2=A0 =C2=A0 QEMU HARDDISK =
=C2=A0 =C2=A02.5+ PQ: 0 ANSI: 5<br>[ =C2=A0 =C2=A05.493282] sd 1:0:0:0: Pow=
er-on or device reset occurred<br>[ =C2=A0 =C2=A05.513539] sd 1:0:0:0: [sda=
] 122880 512-byte logical blocks: (62.9 MB/60.0 MiB)<br>[ =C2=A0 =C2=A05.52=
1970] sd 1:0:0:0: [sda] Write Protect is off<br>[ =C2=A0 =C2=A05.522683] sd=
 1:0:0:0: [sda] Mode Sense: 63 00 00 08<br>[ =C2=A0 =C2=A05.524552] sd 1:0:=
0:0: [sda] Write cache: enabled, read cache: enabled, doesn&#39;t support D=
PO or FUA<br>[ =C2=A0 =C2=A05.613064] sd 1:0:0:0: [sda] Attached SCSI disk<=
br>[ =C2=A0 =C2=A05.681764] EXT4-fs (sda): INFO: recovery required on reado=
nly filesystem<br>[ =C2=A0 =C2=A05.682530] EXT4-fs (sda): write access will=
 be enabled during recovery<br></div><div>...</div><div>[ =C2=A0 =C2=A06.12=
9348] EXT4-fs (sda): re-mounted. Opts: (null)<br>Starting syslogd: OK<br>St=
arting klogd: OK<br>Running sysctl: OK<br>Initializing random number genera=
tor: OK<br>Saving random seed: [ =C2=A0 =C2=A07.205617] random: dd: uniniti=
alized urandom read (512 bytes read)<br>OK<br>Starting network: OK<br><br>W=
elcome to Cubieboard2!<br>Cubieboard2 login:</div><div><br></div><div><br><=
/div><div>Thanks!</div><div><br></div><div>Tested-by: Niek Linnenbank &lt;<=
a href=3D"mailto:nieklinnenbank@gmail.com">nieklinnenbank@gmail.com</a>&gt;=
</div><div><br></div><div>Regards,</div><div>Niek<br></div><div><br></div><=
div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D=
"ltr"><div>Niek Linnenbank<br><br></div></div></div></div>

--0000000000008341b0059ee14063--

