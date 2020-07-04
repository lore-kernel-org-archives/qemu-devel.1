Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B22C433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:25:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B817F20720
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tS5vEcMW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B817F20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrmrH-0001Ti-S5
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 14:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1jrmqK-0000hB-Ht
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 14:24:52 -0400
Received: from mail-il1-x12f.google.com ([2607:f8b0:4864:20::12f]:44918)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1jrmqI-0000mg-O1
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 14:24:52 -0400
Received: by mail-il1-x12f.google.com with SMTP id h16so6423870ilj.11
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 11:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WyLsCoxhCjkdiML6qPNNy9Lc8J7+386NcayL+LzwqNo=;
 b=tS5vEcMW83dmqDT03RYnQlwbaAEKpMGPuBUzNfgbIbqUgcrBfOPNggi0AUZpplOMsA
 VL+LvxDfZQXoZIOStPCH9DUZUZBB2Xk8Ue2Zl9aEH/ai1RxhiLBSLHWwWeYH7pNdp8+d
 qnj/nU0U3wh9sSKb45dz1b9nB1/0t9y8qGBkbu2BOp4Mi7GlV3SDF2mGsYNDa2pEWo79
 duU9owyqpavxvVMwN5m8ykkgdIVkNCJL+yukZYu9I80WMd45ofNeVbynYLXQcPbKfWJ2
 tru0mzhmiR5eXiKB40LdWVzRyAVILCVptbqFQFRHgtX9m6Nht6Fw9E///TdqhUCnC3xo
 Pucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WyLsCoxhCjkdiML6qPNNy9Lc8J7+386NcayL+LzwqNo=;
 b=Fa+g0v05/yFrlIB4uk/XvXU3i04XTawgNDzK96gTUjvZppZRmHq8f8hI7Y+Qo+ZgeJ
 SoWNv/iYQtrpsxyPYpxAG4EZm8qDas0RLPlMCAsbw8Ti4wPivtgO5DWWBXvaMlWe18Qv
 BhlTurw+/BQpikOwVJAbSK+oSslWcFfvEfT27MWPsmCkQN3/8VCXEvVvNyGeEm427uiG
 cCyuaqrh3LA2gXIY9pp4gdB7WVprjNkPGWhjHZkBwzdORDWzLL8rTNhD0zozzpbVk8vn
 65RfngWzgNDO6bIQxBCcYrFffqTQQeOXszcrruPFX3BMKFsH1Ou/s8Z10lTBqNARNVrn
 5LwA==
X-Gm-Message-State: AOAM533haR4akbAQiM7Nr9IJzKJ1iTyx4bqDLLW3tuWWcqSd1vhinMnw
 rWs3Pl3ELzo2qT7l6jiqa72LT7++UrTRMw5UZF8=
X-Google-Smtp-Source: ABdhPJzF78U1HTBCW83RiVoZ0Fz8i+Um/glDYXPY/n99/W2mSyCe9yMJQS4e8nG86L1yAcXrg+hScaEI0ep8bDdEhUE=
X-Received: by 2002:a92:c00d:: with SMTP id q13mr20696743ild.222.1593887089628; 
 Sat, 04 Jul 2020 11:24:49 -0700 (PDT)
MIME-Version: 1.0
References: <BY5PR02MB677298C4D2C2B63EF409AA5CCA6B0@BY5PR02MB6772.namprd02.prod.outlook.com>
In-Reply-To: <BY5PR02MB677298C4D2C2B63EF409AA5CCA6B0@BY5PR02MB6772.namprd02.prod.outlook.com>
From: Paul Zimmerman <pauldzim@gmail.com>
Date: Sat, 4 Jul 2020 11:24:38 -0700
Message-ID: <CADBGO7-hp4Pyfn+rq9d=ZxHmpMwitv-oLjYPJmCKSH6cLHVx=w@mail.gmail.com>
Subject: Re: Failure prints during format or mounting a usb storage device
To: Sai Pavan Boddu <saipava@xilinx.com>
Content-Type: multipart/alternative; boundary="000000000000ca1d0905a9a1c1d3"
Received-SPF: pass client-ip=2607:f8b0:4864:20::12f;
 envelope-from=pauldzim@gmail.com; helo=mail-il1-x12f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FREEMAIL_REPLY=1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Vikram Garhwal <fnuv@xilinx.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000ca1d0905a9a1c1d3
Content-Type: text/plain; charset="UTF-8"

On Sat, Jul 4, 2020 at 11:21 AM Sai Pavan Boddu <saipava@xilinx.com> wrote:

> Hi,
>
>
>
> We are seeing some errors when a usb-storage device is formatted or
> mounted on the guest. Below is commit I have bisected it.
>
>
>
> **************
>
> Errors:
>
>
>
> / # mount /dev/sda /mnt
>
> [New Thread 0x7fffd4680700 (LWP 23270)]
>
> [   33.258454] usb 2-1: reset SuperSpeed Gen 1 USB device number 2 using
> xhci_hcd
>
> [   33.399528] usb 2-1: reset SuperSpeed Gen 1 USB device number 2 using
> xhci_hcd
>
> [   33.544621] usb 2-1: reset SuperSpeed Gen 1 USB device number 2 using
> xhci_hcd
>
> [   33.560460] sd 2:0:0:0: [sda] tag#0 FAILED Result: hostbyte=DID_ERROR
> driverbyte=DRIVER_OK
>
> [   33.562405] sd 2:0:0:0: [sda] tag#0 CDB: Read(10) 28 00 00 00 10 00 00
> 00 01 00
>
> [   33.563389] blk_update_request: I/O error, dev sda, sector 4096 op
> 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
>
> / # [Thread 0x7fffd4680700 (LWP 23270) exited]
>
>
>
> ================
>
> Bisect commit :
>
>
>
> commit 7ad3d51ebb8a522ffcad391c4bef281245739dde
>
> Author: Paul Zimmerman <pauldzim@gmail.com>
>
> Date:   Wed May 20 16:53:47 2020 -0700
>
>
>
>     usb: add short-packet handling to usb-storage driver
>
>
>
>     The dwc-hsotg (dwc2) USB host depends on a short packet to
>
>     indicate the end of an IN transfer. The usb-storage driver
>
>     currently doesn't provide this, so fix it.
>
>
>
>     I have tested this change rather extensively using a PC
>
>     emulation with xhci, ehci, and uhci controllers, and have
>
>     not observed any regressions.
>
>
>
>     Signed-off-by: Paul Zimmerman <pauldzim@gmail.com>
>
>     Message-id: 20200520235349.21215-6-pauldzim@gmail.com
>
>     Signed-off-by: Peter Maydell peter.maydell@linaro.org
>
>
>
> =====================
>
> Steps to reproduce:
>
>    1. x86_64-softmmu/qemu-system-x86_64 -kernel bzImage -nographic
>    -append "console=ttyS0" -m 512M -initrd initramfs.cpio.gz -device
>    qemu-xhci,id=xhci1 -drive file=./usb.img,if=none,id=stick
>    2. Hotplug usb-storage:
>
>                                 device_add
> usb-storage,bus=xhci1.0,port=1,id=usbdev1,drive=stick
>
>    1. Format &  mount the detected device
>
> mkfs.vfat -F 32 /dev/sda
> mount /dev/sda /mnt
>
> You can find the similar errors mentioned above at this stage.
>
> Test Environment:
>
>        Host:  Ubuntu 16.04 LTS
>
>        Guest:  kernel version: 5.4.0 & BusyBox v1.31.1
>
>
>
> Thanks & Regards,
>
> Sai Pavan
>
>
>
I can try to reproduce this on Monday, if no one beats me to it.

Thanks,
Paul

--000000000000ca1d0905a9a1c1d3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><br></div><div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Sat, Jul 4, 2020 at 11:21 AM Sai Pavan Boddu &lt;<a href=
=3D"mailto:saipava@xilinx.com">saipava@xilinx.com</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex">





<div lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"m_8403759097060693532WordSection1">
<p class=3D"MsoNormal">Hi,<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">We are seeing some errors when a usb-storage device =
is formatted or mounted on the guest. Below is commit I have bisected it.<u=
></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">**************<u></u><u></u></p>
<p class=3D"MsoNormal">Errors:<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">/ # mount /dev/sda /mnt<u></u><u></u></p>
<p class=3D"MsoNormal">[New Thread 0x7fffd4680700 (LWP 23270)]<u></u><u></u=
></p>
<p class=3D"MsoNormal">[=C2=A0=C2=A0 33.258454] usb 2-1: reset SuperSpeed G=
en 1 USB device number 2 using xhci_hcd<u></u><u></u></p>
<p class=3D"MsoNormal">[=C2=A0=C2=A0 33.399528] usb 2-1: reset SuperSpeed G=
en 1 USB device number 2 using xhci_hcd<u></u><u></u></p>
<p class=3D"MsoNormal">[=C2=A0=C2=A0 33.544621] usb 2-1: reset SuperSpeed G=
en 1 USB device number 2 using xhci_hcd<u></u><u></u></p>
<p class=3D"MsoNormal">[=C2=A0=C2=A0 33.560460] sd 2:0:0:0: [sda] tag#0 FAI=
LED Result: hostbyte=3DDID_ERROR driverbyte=3DDRIVER_OK<u></u><u></u></p>
<p class=3D"MsoNormal">[=C2=A0=C2=A0 33.562405] sd 2:0:0:0: [sda] tag#0 CDB=
: Read(10) 28 00 00 00 10 00 00 00 01 00<u></u><u></u></p>
<p class=3D"MsoNormal">[=C2=A0=C2=A0 33.563389] blk_update_request: I/O err=
or, dev sda, sector 4096 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class =
0<u></u><u></u></p>
<p class=3D"MsoNormal">/ # [Thread 0x7fffd4680700 (LWP 23270) exited]<u></u=
><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<u><=
/u><u></u></p>
<p class=3D"MsoNormal">Bisect commit :<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">commit 7ad3d51ebb8a522ffcad391c4bef281245739dde<u></=
u><u></u></p>
<p class=3D"MsoNormal">Author: Paul Zimmerman &lt;<a href=3D"mailto:pauldzi=
m@gmail.com" target=3D"_blank">pauldzim@gmail.com</a>&gt;<u></u><u></u></p>
<p class=3D"MsoNormal">Date:=C2=A0=C2=A0 Wed May 20 16:53:47 2020 -0700<u><=
/u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0 usb: add short-packet handling to=
 usb-storage driver<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0 The dwc-hsotg (dwc2) USB host dep=
ends on a short packet to<u></u><u></u></p>
<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0 indicate the end of an IN transfe=
r. The usb-storage driver<u></u><u></u></p>
<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0 currently doesn&#39;t provide thi=
s, so fix it.<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0 I have tested this change rather =
extensively using a PC<u></u><u></u></p>
<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0 emulation with xhci, ehci, and uh=
ci controllers, and have<u></u><u></u></p>
<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0 not observed any regressions.<u><=
/u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0 Signed-off-by: Paul Zimmerman &lt=
;<a href=3D"mailto:pauldzim@gmail.com" target=3D"_blank">pauldzim@gmail.com=
</a>&gt;<u></u><u></u></p>
<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0 Message-id: <a href=3D"mailto:202=
00520235349.21215-6-pauldzim@gmail.com" target=3D"_blank">20200520235349.21=
215-6-pauldzim@gmail.com</a><u></u><u></u></p>
<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0 Signed-off-by: Peter Maydell <a h=
ref=3D"mailto:peter.maydell@linaro.org" target=3D"_blank">
peter.maydell@linaro.org</a><u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D<u></u><u></u></p>
<p class=3D"MsoNormal">Steps to reproduce:<u></u><u></u></p>
<ol style=3D"margin-top:0in" start=3D"1" type=3D"1">
<li class=3D"m_8403759097060693532MsoListParagraph" style=3D"margin-left:.2=
5in">x86_64-softmmu/qemu-system-x86_64 -kernel bzImage -nographic -append &=
quot;console=3DttyS0&quot; -m 512M -initrd initramfs.cpio.gz -device qemu-x=
hci,id=3Dxhci1 -drive file=3D./usb.img,if=3Dnone,id=3Dstick<u></u><u></u></=
li><li class=3D"m_8403759097060693532MsoListParagraph" style=3D"margin-left=
:.25in">Hotplug usb-storage:<u></u><u></u></li></ol>
<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 device_add usb-st=
orage,bus=3Dxhci1.0,port=3D1,id=3Dusbdev1,drive=3Dstick<u></u><u></u></p>
<ol style=3D"margin-top:0in" start=3D"3" type=3D"1">
<li class=3D"m_8403759097060693532MsoListParagraph" style=3D"margin-left:.2=
5in">Format &amp; =C2=A0mount the detected device<u></u><u></u></li></ol>
<p class=3D"MsoNormal" style=3D"margin-left:1.0in">mkfs.vfat -F 32 /dev/sda=
 <br>
mount /dev/sda /mnt<u></u><u></u></p>
<p class=3D"MsoNormal" style=3D"margin-left:.5in;text-indent:.5in">You can =
find the similar errors mentioned above at this stage.<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u><u></u></p>
<p class=3D"MsoNormal">Test Environment:<u></u><u></u></p>
<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Host: =C2=A0Ubu=
ntu 16.04 LTS<u></u><u></u></p>
<p class=3D"MsoNormal">=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Guest: =C2=A0ke=
rnel version: 5.4.0 &amp; BusyBox v1.31.1<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">Thanks &amp; Regards,<u></u><u></u></p>
<p class=3D"MsoNormal">Sai Pavan<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
</div>

</blockquote></div></div><div dir=3D"auto">I can try to reproduce this on M=
onday, if no one beats me to it.</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Thanks,</div><div dir=3D"auto">Paul</div>

--000000000000ca1d0905a9a1c1d3--

