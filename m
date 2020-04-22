Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71AF9C5518A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 07:54:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 368E0206E9
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 07:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tL8ZriwB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 368E0206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45741 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRAD7-00059B-8u
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 03:54:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40160)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <hqm03ster@gmail.com>) id 1jRABy-0004he-Ga
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 03:53:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <hqm03ster@gmail.com>) id 1jRABx-0005Or-FQ
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 03:53:09 -0400
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731]:38958)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hqm03ster@gmail.com>)
 id 1jRABx-0005Jx-2a
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 03:53:09 -0400
Received: by mail-qk1-x731.google.com with SMTP id b62so1481467qkf.6
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 00:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fYeL9vUWeChobEKoh6rG429sf9VPqrXbw/mMaENVjmg=;
 b=tL8ZriwBDCdUqaABNUofVRwE8aHc3cNNOXd1pFoyC3MdEg5abt5q7lST1v6qh/XNBS
 uUKFqUIQp47kzmQHmPand/Pt8D05kK4m8NdTjdxCN1MZEsyTv/EWT7a1OS7w1YuK6I7u
 1BocZk5XcVM7BfVPDgOZt2uW1wKGwRfYtc0keZOZ7ZqH22+tvDgqZrExUwJwtYnTyEH1
 MFpoDCyqkkbf70Y3/Ot+CHTt5jIOtrg5UC3waWNJdp6PAFn+usHIyS5c5awG+/eYvy7j
 AYpQo/VGRib17Sk0h17UW6fe8wCs2ZZZHwQkbp7Wt/9tCCCQDLUXRdv/29innhnVsxZK
 f9VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fYeL9vUWeChobEKoh6rG429sf9VPqrXbw/mMaENVjmg=;
 b=i2x1FFIcHD4sPTP6cNNT8ABIxZYGycxkZlGJnweNeEOLFftZJDtlA43UZDdcZ6uDhA
 zxqiGhhJ3UzJJO+LS/OR+4x9y4vbj+Jk8rvBLAT2zVVyBziLpKly1a0tzov8TeReLCvq
 rLKXDgrHxSgDmG2zXXEvVLDdV9mvxS0oz4v/6RjJWLxEhgqkLHsEA5cT7iMMGHd0cUFc
 a8coHFJb06sR/k6Ur0khVO9T9ZjjdvffCE1EiggYlKc55WXEY1MrMtyvhFujFEzXtSv6
 PsBhkVneQVwpB2OheoNCZvZ34EOUcGa+SVx0/69jWEm3nE9789b3de/iaXI0k3IqhQBU
 sgWg==
X-Gm-Message-State: AGi0PuadG1kdbpaxFnWsINMsv2s5ygvo3lEMK2ULUeQTmh4jGVR4IP/o
 gbn7bJXyhos6URN4FEbpQosJ9lT0VLIXMHRbPUI=
X-Google-Smtp-Source: APiQypJdDamshdABJXoB5xF+xPVeUfJGOGvJUQ98JtH4ACzANIdBsyDAV+qBbx4zwFklVRCSbAVSiGyV9RwcEXEassc=
X-Received: by 2002:a05:620a:22b1:: with SMTP id
 p17mr25349293qkh.249.1587541986972; 
 Wed, 22 Apr 2020 00:53:06 -0700 (PDT)
MIME-Version: 1.0
References: <623b1855-285c-cce3-c806-c17e5fd217ea@redhat.com>
 <5211.1586899245384995995@groups.io>
 <a972450d-8834-ae87-e4e3-5263a41d1735@redhat.com>
 <20200420141303.dxjqgvmzglrjtsly@sirius.home.kraxel.org>
 <9aed493a-2187-cacd-5631-54fb9973509c@redhat.com>
In-Reply-To: <9aed493a-2187-cacd-5631-54fb9973509c@redhat.com>
From: Hou Qiming <hqm03ster@gmail.com>
Date: Wed, 22 Apr 2020 15:42:34 +0800
Message-ID: <CABSdmrm2qp=nMdu7N7kxxS9PVA25_pfnK_F3EimLuq8twPKjgg@mail.gmail.com>
Subject: Re: [edk2-discuss] Load Option passing. Either bugs or my confusion.
To: Laszlo Ersek <lersek@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000003319d205a3dc6c48"
Received-SPF: pass client-ip=2607:f8b0:4864:20::731;
 envelope-from=hqm03ster@gmail.com; helo=mail-qk1-x731.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::731
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
Cc: edk2-devel-groups-io <devel@edk2.groups.io>,
 qemu devel list <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 discuss@edk2.groups.io, valerij zaporogeci <vlrzprgts@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000003319d205a3dc6c48
Content-Type: text/plain; charset="UTF-8"

A little off topic thing: isn't the default resolution supposed to be
1024x768? This is the Microsoft regulation which all my physical devices
seem to follow:

https://docs.microsoft.com/en-us/windows-hardware/test/hlk/testref/6afc8979-df62-4d86-8f6a-99f05bbdc7f3

And when the user provides an EDID one should parse it and set the default
resolution to match it. But that's a less important feature.


On Tue, Apr 21, 2020 at 9:03 PM Laszlo Ersek <lersek@redhat.com> wrote:

> On 04/20/20 16:13, Gerd Hoffmann wrote:
> >   Hi,
> >
> >> So I would say that the symptom you see is a QEMU v4.1.0 regression.
> >> The QemuRamfbGraphicsOutputSetMode() function in the OVMF ramfb
> >> driver certainly needs the QemuFwCfgWriteBytes() call to work, for
> >> changing the resolution.
> >
> > Oh?  QemuRamfbGraphicsOutputSetMode() can be called multiple times?
> > How does that happen?
>
> QemuRamfbGraphicsOutputSetMode() is the "SetMode" member function of the
> EFI_GRAPHICS_OUTPUT_PROTOCOL instance that QemuRamfbDxe produces.
>
> This is a standard protocol; UEFI drivers and applications are free to
> locate it and to use it.
>
> (1) When you launch OVMF, you get the splash screen in a particular
> resolution. This resolution:
> - is configured by OvmfPkg/PlatformDxe,
> - is inherited by an OS boot loader,
> - is reconfigurable with OvmfPkg/PlatformDxe, for the next boot, via the
>   Setup TUI,
> - defaults to 800x600 (taking effect when no particular choice is
>   configured).
>
> (2) UiApp -- the Setup TUI itself -- uses its own resolution. Under
> OVMF, this resolution is fixed 640x480. When UiApp is entered,
> ultimately a call is made to QemuRamfbGraphicsOutputSetMode() -- i.e., a
> GOP.SetMode() member function -- for setting this 640x480 resolution.
>
> Using the following command:
>
>   qemu-system-x86_64 \
>     -nodefaults \
>     -boot menu=on,splash-time=5000 \
>     -enable-kvm \
>     -device ramfb \
>     -drive
> if=pflash,readonly,format=raw,file=$PREFIX/share/qemu/edk2-x86_64-code.fd \
>     -drive
> if=pflash,snapshot,format=raw,file=$PREFIX/share/qemu/edk2-i386-vars.fd \
>     -debugcon file:ovmf.log \
>     -global isa-debugcon.iobase=0x402
>
> when you first see the progress bar, the graphical resolution (1) is
> 800x600. Accordingly, QEMU prints to stderr:
>
> > ramfb_fw_cfg_write: 800x600 @ 0x6702000
>
> Once you hit ESC to interrupt the progress bar and to enter the Setup
> TUI, UiApp switches to resolution (2), 640x480. QEMU prints:
>
> > ramfb_fw_cfg_write: 640x480 @ 0x6702000
> > ramfb_fw_cfg_write: resolution locked, change rejected
>
> And you get garbage in the Setup window.
>
> Thanks,
> Laszlo
>
>

--0000000000003319d205a3dc6c48
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>A little off topic thing: isn&#39;t the default resol=
ution supposed to be 1024x768? This is the Microsoft regulation which all m=
y physical devices seem to follow:<br></div><div><br></div><div><a href=3D"=
https://docs.microsoft.com/en-us/windows-hardware/test/hlk/testref/6afc8979=
-df62-4d86-8f6a-99f05bbdc7f3">https://docs.microsoft.com/en-us/windows-hard=
ware/test/hlk/testref/6afc8979-df62-4d86-8f6a-99f05bbdc7f3</a></div><div><b=
r></div><div>And when the user provides an EDID one should parse it and set=
 the default resolution to match it. But that&#39;s a less important featur=
e.<br></div><div><br></div></div><br><div class=3D"gmail_quote"><div dir=3D=
"ltr" class=3D"gmail_attr">On Tue, Apr 21, 2020 at 9:03 PM Laszlo Ersek &lt=
;<a href=3D"mailto:lersek@redhat.com">lersek@redhat.com</a>&gt; wrote:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">On 04/20/20 16:13, G=
erd Hoffmann wrote:<br>
&gt;=C2=A0 =C2=A0Hi,<br>
&gt;<br>
&gt;&gt; So I would say that the symptom you see is a QEMU v4.1.0 regressio=
n.<br>
&gt;&gt; The QemuRamfbGraphicsOutputSetMode() function in the OVMF ramfb<br=
>
&gt;&gt; driver certainly needs the QemuFwCfgWriteBytes() call to work, for=
<br>
&gt;&gt; changing the resolution.<br>
&gt;<br>
&gt; Oh?=C2=A0 QemuRamfbGraphicsOutputSetMode() can be called multiple time=
s?<br>
&gt; How does that happen?<br>
<br>
QemuRamfbGraphicsOutputSetMode() is the &quot;SetMode&quot; member function=
 of the<br>
EFI_GRAPHICS_OUTPUT_PROTOCOL instance that QemuRamfbDxe produces.<br>
<br>
This is a standard protocol; UEFI drivers and applications are free to<br>
locate it and to use it.<br>
<br>
(1) When you launch OVMF, you get the splash screen in a particular<br>
resolution. This resolution:<br>
- is configured by OvmfPkg/PlatformDxe,<br>
- is inherited by an OS boot loader,<br>
- is reconfigurable with OvmfPkg/PlatformDxe, for the next boot, via the<br=
>
=C2=A0 Setup TUI,<br>
- defaults to 800x600 (taking effect when no particular choice is<br>
=C2=A0 configured).<br>
<br>
(2) UiApp -- the Setup TUI itself -- uses its own resolution. Under<br>
OVMF, this resolution is fixed 640x480. When UiApp is entered,<br>
ultimately a call is made to QemuRamfbGraphicsOutputSetMode() -- i.e., a<br=
>
GOP.SetMode() member function -- for setting this 640x480 resolution.<br>
<br>
Using the following command:<br>
<br>
=C2=A0 qemu-system-x86_64 \<br>
=C2=A0 =C2=A0 -nodefaults \<br>
=C2=A0 =C2=A0 -boot menu=3Don,splash-time=3D5000 \<br>
=C2=A0 =C2=A0 -enable-kvm \<br>
=C2=A0 =C2=A0 -device ramfb \<br>
=C2=A0 =C2=A0 -drive if=3Dpflash,readonly,format=3Draw,file=3D$PREFIX/share=
/qemu/edk2-x86_64-code.fd \<br>
=C2=A0 =C2=A0 -drive if=3Dpflash,snapshot,format=3Draw,file=3D$PREFIX/share=
/qemu/edk2-i386-vars.fd \<br>
=C2=A0 =C2=A0 -debugcon file:ovmf.log \<br>
=C2=A0 =C2=A0 -global isa-debugcon.iobase=3D0x402<br>
<br>
when you first see the progress bar, the graphical resolution (1) is<br>
800x600. Accordingly, QEMU prints to stderr:<br>
<br>
&gt; ramfb_fw_cfg_write: 800x600 @ 0x6702000<br>
<br>
Once you hit ESC to interrupt the progress bar and to enter the Setup<br>
TUI, UiApp switches to resolution (2), 640x480. QEMU prints:<br>
<br>
&gt; ramfb_fw_cfg_write: 640x480 @ 0x6702000<br>
&gt; ramfb_fw_cfg_write: resolution locked, change rejected<br>
<br>
And you get garbage in the Setup window.<br>
<br>
Thanks,<br>
Laszlo<br>
<br>
</blockquote></div>

--0000000000003319d205a3dc6c48--

