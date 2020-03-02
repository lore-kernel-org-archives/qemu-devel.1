Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E92C3F2D8
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 14:34:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8D44214DB
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 14:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZ/G03F6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8D44214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8m95-0006yn-LG
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 09:34:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42364)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clefrks@gmail.com>) id 1j8dA4-0002q3-TT
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 23:58:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clefrks@gmail.com>) id 1j8dA3-0006TQ-L5
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 23:58:36 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:45238)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <clefrks@gmail.com>) id 1j8dA3-0006TI-Dx
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 23:58:35 -0500
Received: by mail-ot1-x343.google.com with SMTP id 59so8393427otp.12
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2020 20:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SrlUpl2eDbn37n84RtNsong8vc8XZyj/quQ8WICVnm8=;
 b=gZ/G03F67dty/N0/f5XSHVMTHubHjAewLfEMlHw1wG8hUBpTvUL6PwpW5FuD8Fg83v
 B7Bq9+4Phn1eGxm6M4PDl0Z1BuTrzmcnZoDY1J+7qnlarpPhfMJ7rTxWnTWCqbJg7u1s
 3rCuZd+sDi7zahElo+cEuB0uQrRoflZh+zt4e3xZREq5AwfL7nVElLlhCUX/FBKnhG0e
 88LGxcf3f800KxbbZlwctNDSrrDMjzS6mE/zoWMdaavnJDZ7pwp2OorF5xnP83L1Q5uD
 9HkM0LjJaAEbDTUD3IHi8w2DhhwupoGNjZfUw07VjhDoaBqCJ2F5SF41IT2zeaUz1fNb
 3YaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SrlUpl2eDbn37n84RtNsong8vc8XZyj/quQ8WICVnm8=;
 b=uEP9qXQ2N2IAGHx5wP0mCL8/dT1uYmUlSZTIJ6TldxAy3QNNELnmiRqsC3/me95QlS
 b3/T/uT0BEKoWTECDy/A7uvTfSZP365mwNG3UoONDj3fYGhkq0fq7hzD2nSid6LGBKPY
 NXHr9MyYdzadVMisixLw0qTSiPJRgPhxr8FXke+f4SGGjx8TvSwsW1VZsRSNF1fKbklg
 DInR+Fzvkbb2rjMyo43/ZlnrM7/LkPq/EDzHVvu1ZWB1NyuYXQV7KTuxsjz0J9OKNnbl
 JNnf+he8xLEL0go5gnfFVJHCcOpA2KDU+uN/XwHGK0DiDcbVsTjVrE2pZaWwqlL7EZKt
 8Cng==
X-Gm-Message-State: APjAAAVqRNGMm45TzDkUlltsnYKKIwJuQdOop/tpbmw+l9z4KSOfloA4
 LcOQo19QIp3BRHpgYA6RCp8zAGCBaxKRC8mxQXjsstm/
X-Google-Smtp-Source: APXvYqyGScJe+uLLpv6733s53yzSfD7qBg6Ny6HsNoqF5cSnEFniaDSCDGgKSjZ5tDrs9QCxTDdTL4NJKrQulJGISRQ=
X-Received: by 2002:a9d:6e15:: with SMTP id e21mr11735874otr.289.1583125114477; 
 Sun, 01 Mar 2020 20:58:34 -0800 (PST)
MIME-Version: 1.0
References: <CALayR+Rd43eQj2iyww=nDRjyKJ8_iuhBFnfoGD+4t_cakmBfgg@mail.gmail.com>
In-Reply-To: <CALayR+Rd43eQj2iyww=nDRjyKJ8_iuhBFnfoGD+4t_cakmBfgg@mail.gmail.com>
From: clement andrew <clefrks@gmail.com>
Date: Mon, 2 Mar 2020 12:58:23 +0800
Message-ID: <CALayR+R=etp2Sb_W6or+hT-W9But9z4pRXLtF6nUbOrRh4acSQ@mail.gmail.com>
Subject: Re: USB passthrough using qemu commandline method in libvirt
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000156174059fd80a84"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
X-Mailman-Approved-At: Mon, 02 Mar 2020 09:32:59 -0500
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
Cc: stefanha@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000156174059fd80a84
Content-Type: text/plain; charset="UTF-8"

Updated Mail:
Forgot to put in system information

Hi

I'm trying to do usb passthrough using qemu commandline method in libvirt
as below by making changes , but VM failed to create the usb passthrough.
<qemu:commandline>
  <qemu:arg value='-device'/>
  <qemu:arg value='usb-host,vendorid=0x0930,productid=0x6545,bus=usb1.0'/>
</qemu:commandline>

While using just normal qemu command, it was passing just fine.
sudo qemu-system-x86_64 -enable-kvm -m 2G -cpu host -smp 2 -vga qxl -drive
file=/var/lib/libvirt/images/os1.qcow2,index=0,media=disk,format=qcow2
-device usb-host,vendorid=0x0930,productid=0x6545

Base OS: Ubuntu 18.04.03

Hypervisor: KVM

VM OS: Ubuntu 18.04

Kernel:
https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.2.11/linux-image-unsigned-5.2.11-050211-generic_5.2.11-050211.201908290731_amd64.deb

Libvirt version: 4.0.0 (default from ubuntu 18.04)

Qemu version: 2.11.1 (default from ubuntu 18.04)

Libusb version: 1.0.0 (default from ubuntu 18.04)


Is there a guide where i can find out information on this ?

On Mon, Mar 2, 2020 at 12:55 PM clement andrew <clefrks@gmail.com> wrote:

> Hi
>
> I'm trying to do usb passthrough using qemu commandline method in libvirt
> as below by making changes , but VM failed to create the usb passthrough.
> <qemu:commandline>
>   <qemu:arg value='-device'/>
>   <qemu:arg value='usb-host,vendorid=0x0930,productid=0x6545,bus=usb1.0'/>
> </qemu:commandline>
>
> While using just normal qemu command, it was passing just fine.
> sudo qemu-system-x86_64 -enable-kvm -m 2G -cpu host -smp 2 -vga qxl -drive
> file=/var/lib/libvirt/images/os1.qcow2,index=0,media=disk,format=qcow2
> -device usb-host,vendorid=0x0930,productid=0x6545
>
> Is there a guide where i can find out information on this ?
>
> Thanks!
>

--000000000000156174059fd80a84
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Updated Mail:<br>Forgot to put in system information<div><=
br></div><div>Hi</div><div><br></div><div><div>I&#39;m trying to do usb pas=
sthrough using qemu commandline method in libvirt as below by making change=
s , but VM failed to create the usb passthrough.</div><div>&lt;qemu:command=
line&gt;</div><div>=C2=A0 &lt;qemu:arg value=3D&#39;-device&#39;/&gt;</div>=
<div>=C2=A0 &lt;qemu:arg value=3D&#39;usb-host,vendorid=3D0x0930,productid=
=3D0x6545,bus=3Dusb1.0&#39;/&gt;</div><div>&lt;/qemu:commandline&gt;</div><=
div><br></div><div>While using just normal qemu command, it was passing jus=
t fine.=C2=A0</div><div><span lang=3D"EN-MY" style=3D"font-size:11pt;font-f=
amily:Calibri,sans-serif">sudo qemu-system-x86_64 -enable-kvm -m 2G -cpu ho=
st -smp 2 -vga qxl -drive file=3D/var/lib/libvirt/images/os1.qcow2,index=3D=
0,media=3Ddisk,format=3Dqcow2=C2=A0 -device usb-host,vendorid=3D0x0930,prod=
uctid=3D0x6545</span><br></div><div><span lang=3D"EN-MY" style=3D"font-size=
:11pt;font-family:Calibri,sans-serif"><br></span></div><div><span lang=3D"E=
N-MY" style=3D"font-size:11pt;font-family:Calibri,sans-serif"><p class=3D"M=
soNormal" style=3D"margin:0in 0in 0.0001pt 1in;font-size:11pt"><span lang=
=3D"EN-MY">Base OS: Ubuntu
18.04.03</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in 0in 0.0001pt 1in;font-size:11pt"=
><span lang=3D"EN-MY">Hypervisor: KVM</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in 0in 0.0001pt 1in;font-size:11pt"=
><span lang=3D"EN-MY">VM OS: Ubuntu
18.04</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in 0in 0.0001pt 1in;font-size:11pt"=
><span lang=3D"EN-MY">Kernel: <a href=3D"https://kernel.ubuntu.com/~kernel-=
ppa/mainline/v5.2.11/linux-image-unsigned-5.2.11-050211-generic_5.2.11-0502=
11.201908290731_amd64.deb" style=3D"font-family:&quot;Times New Roman&quot;=
,serif;color:rgb(5,99,193)"><span style=3D"color:black">https://kernel.ubun=
tu.com/~kernel-ppa/mainline/v5.2.11/linux-image-unsigned-5.2.11-050211-gene=
ric_5.2.11-050211.201908290731_amd64.deb</span></a></span></p>

<p class=3D"MsoNormal" style=3D"margin:0in 0in 0.0001pt 1in;font-size:11pt"=
><span lang=3D"EN-MY">Libvirt version:
4.0.0 (default from ubuntu 18.04)</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in 0in 0.0001pt 1in;font-size:11pt"=
><span lang=3D"EN-MY">Qemu version:
2.11.1 (default from ubuntu 18.04)</span></p>

<p class=3D"MsoNormal" style=3D"margin:0in 0in 0.0001pt 1in;font-size:11pt"=
><span lang=3D"EN-MY">Libusb version:
1.0.0 (default from ubuntu 18.04)</span></p></span></div><div><span lang=3D=
"EN-MY" style=3D"font-size:11pt;font-family:Calibri,sans-serif"><br></span>=
</div><div><span lang=3D"EN-MY" style=3D"font-size:11pt;font-family:Calibri=
,sans-serif"><br></span></div><div><span lang=3D"EN-MY" style=3D"font-size:=
11pt;font-family:Calibri,sans-serif">Is there a guide where i can find out =
information on this ?=C2=A0</span></div></div></div><br><div class=3D"gmail=
_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Mar 2, 2020 at 12:55 =
PM clement andrew &lt;<a href=3D"mailto:clefrks@gmail.com">clefrks@gmail.co=
m</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
><div dir=3D"ltr">Hi=C2=A0<div><br></div><div>I&#39;m trying to do usb pass=
through using qemu commandline method in libvirt as below by making changes=
 , but VM failed to create the usb passthrough.</div><div>&lt;qemu:commandl=
ine&gt;</div><div>=C2=A0 &lt;qemu:arg value=3D&#39;-device&#39;/&gt;</div><=
div>=C2=A0 &lt;qemu:arg value=3D&#39;usb-host,vendorid=3D0x0930,productid=
=3D0x6545,bus=3Dusb1.0&#39;/&gt;</div><div>&lt;/qemu:commandline&gt;</div><=
div><br></div><div>While using just normal qemu command, it was passing jus=
t fine.=C2=A0</div><div><span lang=3D"EN-MY" style=3D"font-size:11pt;font-f=
amily:Calibri,sans-serif">sudo qemu-system-x86_64 -enable-kvm -m 2G -cpu ho=
st
-smp 2 -vga qxl -drive
file=3D/var/lib/libvirt/images/os1.qcow2,index=3D0,media=3Ddisk,format=3Dqc=
ow2=C2=A0 -device
usb-host,vendorid=3D0x0930,productid=3D0x6545</span><br></div><div><span la=
ng=3D"EN-MY" style=3D"font-size:11pt;font-family:Calibri,sans-serif"><br></=
span></div><div><span lang=3D"EN-MY" style=3D"font-size:11pt;font-family:Ca=
libri,sans-serif">Is there a guide where i can find out information on this=
 ?=C2=A0<br><br>Thanks!</span></div></div>
</blockquote></div>

--000000000000156174059fd80a84--

