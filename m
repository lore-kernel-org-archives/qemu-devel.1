Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D689C2BB55
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 04:35:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA77820767
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 04:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VS7ovtwS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA77820767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOwF4-0004ev-Tq
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 00:35:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51226)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <hqm03ster@gmail.com>) id 1jOwET-000494-RK
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 00:34:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hqm03ster@gmail.com>) id 1jOwER-000334-N5
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 00:34:33 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:35046)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <hqm03ster@gmail.com>) id 1jOwER-00032p-HU
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 00:34:31 -0400
Received: by mail-qt1-x843.google.com with SMTP id s30so15447615qth.2
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 21:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QTjLpcwdoLQZOb+qTdh/A5lGACctspOpVK63giqxhtM=;
 b=VS7ovtwSAPwm/erVEArjbjitvtUlwRiroXIQI8GrQETeLOT2fWBNw6HcssNU6sFdnV
 igmo8dMUz+z6NWTCoZ3cuTPdQx05M1X0r2DNxeqB2jHSRU1vbTbEjsV/TQtCbmrxRveG
 TaUcBKVhzzdIVHd7IVPS67iLQ+LTyNBVB6nn/3KrjwL+TBR3NEhAPFCq4pNq7skbqrcZ
 reXXZ4aCDyBrv7jwNDuowV7WpbvQEtBnHE66p6qtAYNqd5gc96SSSLIWm7EUeEgv6xhu
 z2Ep9lOX90zdlgtvLguVJ5EnkaVicGRtaEKlKSOurOJcwHs3OjgeChCvZqNDp/fVAeYL
 pWIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QTjLpcwdoLQZOb+qTdh/A5lGACctspOpVK63giqxhtM=;
 b=gbjuXXef5BKbsFgqI/QR5f5grrpEe/iW8AAZkeG0goGHaWOyBQWNzzr/T3OKxG8+Ht
 J5owpNYbVHaW6OtgS+yURTrRk4eE4L+4ja3bV/PdYcd1ib2+xmOZaMANyvXimXEoDSnR
 srl/RaHKTNppmy67Zv56k3mlkMcduOncTIjrKpNKl9AkE/SN68UeOZPK6UPFKioM7cPE
 aXkI8j3e68GHJ+zoKU8p22gPvxGYo7TTN6E3bxTemRu1rEwrxRy6hBE8ZCSI32fqVpDL
 ESDlRdxnzqVfCHorZUPQnySVWGG/8zwCPlbHcLn1Bnnq8RQpdW76wd9GG4tyqPD0mKPw
 lQKA==
X-Gm-Message-State: AGi0PuZvxkkcBHvFHgM+GchNutQGhJypp61amNdXRqn4LCa9AcA9wnjO
 RWCBav56kaR1xgLfD2gaXRWoOFEMTsOiKlaIUBo=
X-Google-Smtp-Source: APiQypJP7wngR55WKIV1un5OXko8VxihuR2EQjFH3y1VRNexDW4IYAxxka9MfEqQgUbECBcVkZR38brTYELcGuSbE44=
X-Received: by 2002:ac8:7246:: with SMTP id l6mr24499713qtp.298.1587011670671; 
 Wed, 15 Apr 2020 21:34:30 -0700 (PDT)
MIME-Version: 1.0
References: <623b1855-285c-cce3-c806-c17e5fd217ea@redhat.com>
 <5211.1586899245384995995@groups.io>
 <a972450d-8834-ae87-e4e3-5263a41d1735@redhat.com>
In-Reply-To: <a972450d-8834-ae87-e4e3-5263a41d1735@redhat.com>
From: Hou Qiming <hqm03ster@gmail.com>
Date: Thu, 16 Apr 2020 12:38:19 +0800
Message-ID: <CABSdmr=u9QeNA6jy29e2pkiqnGH=xw1n+Hkkrd=AH1RRvj92Ng@mail.gmail.com>
Subject: Re: [edk2-discuss] Load Option passing. Either bugs or my confusion.
To: Laszlo Ersek <lersek@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000e2864d05a360f2c6"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::843
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

--000000000000e2864d05a360f2c6
Content-Type: text/plain; charset="UTF-8"

Very good point, I did neglect ramfb resolution changes... But there is one
important thing: it *can* cause a QEMU crash, a potentially exploitable
one, not always a guest crash. That's what motivated my heavy-handed
approach since allowing resolution change would have necessitated a good
deal of security checks. It has crashed my host *kernel* quite a few times.

The point is, while the QemuRamfbDxe driver may behave properly, nothing
prevents the guest from writing garbage or *malicious* values to the ramfb
config space. Then the values are sent to the display component without any
sanity check. For some GUI frontends, this means allocating an OpenGL
texture with guest-supplied dimensions and uploading guest memory content
to it, which means that guest memory content goes straight into a *kernel
driver*, *completely unchecked*. Some integer overflow and a lenient GPU
driver later, and the guest escapes straight to kernel.

The proper way to enable ramfb resolution change again is adding sanity
checks for ramfb resolution / pointer / etc. on the QEMU side. We have to
make sure it doesn't exceed what the host GPU driver supports. Maybe clamp
both width and height to between 1 and 2048? We also need to validate that
OpenGL texture dimension update succeeds. Note that OpenGL is not obliged
to validate anything and everything has to be checked on the QEMU side.

Qiming


On Wed, Apr 15, 2020 at 11:05 PM Laszlo Ersek <lersek@redhat.com> wrote:

> (CC Gerd, Qiming, Marcel, qemu-devel for ramfb:)
>
> On 04/14/20 23:20, valerij zaporogeci wrote:
>
> [snip]
>
> > There is a Boot Manager UI display problem, I don't know if this is
> > qemu problem, but with the ARM (both 32 and 64 bits, the qemu version
> > is 4.2.0, the OVMF is fresh), and using "ramfb" device, the Boot
> > Manager has troubles with drawing - it's interfase looks entirely
> > broken, like this (I'll try to attach the screenshot). UEFI shell
> > doesn't have this problem. switching to "serial" (which is -serial vc)
> > doesn't produce it too. Only when ramfb is chosen, the Boot Manager UI
> > gets smeared. But it takes input and presumable works properly, except
> > displaying things. qemu writes these messages in the command prompt:
> > ramfb_fw_cfg_write: 640x480 @ 0x4bd00000
> > ramfb_fw_cfg_write: resolution locked, change rejected
> > ramfb_fw_cfg_write: 800x600 @ 0x4bd00000
> > ramfb_fw_cfg_write: resolution locked, change rejected
>
> Gerd contributed the OVMF QemuRamfbDxe driver in edk2 commit
> 1d25ff51af5c ("OvmfPkg: add QemuRamfbDxe", 2018-06-14). Note the date:
> June 2018.
>
> The then-latest (released) QEMU version was v2.12.0, and v2.12.1 /
> v3.0.0 were in the making.
>
> At that time, the resolution change definitely worked -- note my
> "Tested-by" on the edk2 commit message.
>
>
> Running "git blame" on the QEMU source, I now find commit a9e0cb67b7f4
> ("hw/display/ramfb: lock guest resolution after it's set", 2019-05-24).
>
> Again, note the date: May 2019 (and this commit was released with QEMU
> v4.1.0).
>
> So I would say that the symptom you see is a QEMU v4.1.0 regression. The
> QemuRamfbGraphicsOutputSetMode() function in the OVMF ramfb driver
> certainly needs the QemuFwCfgWriteBytes() call to work, for changing the
> resolution.
>
>
> Now, I'm not familiar with the reasons behind QEMU commit a9e0cb67b7f4.
> It says it intends to "prevent[] a crash when the guest writes garbage
> to the configuration space (e.g. when rebooting)".
>
> But I don't understand why locking the resolution was necessary for
> preventing "a crash":
>
> (1) Registering a device reset handler in QEMU seems sufficient, so that
> QEMU forget about the currently shared RAMFB area at platform reset.
>
> (2) The crash in question is apparently not a *QEMU* crash -- which
> might otherwise justify a heavy-handed approach. Instead, it is a
> *guest* crash. See the references below:
>
> (2a)
> http://mid.mail-archive.com/CABSdmrmU7FK90Bupq_ySowcc9Uk=8nQxNLHgzvDsNYdp_QLogA@mail.gmail.com
>      https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg02299.html
>
> (2b) https://github.com/intel/gvt-linux/issues/23#issuecomment-483651476
>
> Therefore, I don't think that locking the resolution was justified!
>
> Importantly:
>
> - The QemuRamfbDxe driver allocates the framebuffer in *reserved*
> memory, therefore any well-behaving OS will *never* touch the
> framebuffer.
>
> - The QemuRamfbDxe driver allocates the framebuffer memory only once,
> namely for such a resolution that needs the largest amount of
> framebuffer memory. Therefore, framebuffer re-allocations in the guest
> driver -- and thereby guest RAM *re-mapping* in QEMU -- are *not*
> necessary, upon resolution change.
>
> The ramfb device reset handler in QEMU is justified (for unmapping /
> forgetting the previously shared RAMFB area).
>
> The resolution locking is *NOT* justified, and it breaks the OVMF
> driver. I suggest backing out the resolution locking from QEMU.
>
> Reference (2a) above indicates 'It could be a misguided attempt to
> "resize ramfb" by the guest Intel driver'. If that is the case, then
> please fix the Intel guest driver, without regressing the QEMU device
> model.
>
> I'm sad that the QEMU device model change was not regression-tested
> against the *upstream* OVMF driver (which, by then, had been upstream
> for almost a year).
>
> Laszlo
>
>

--000000000000e2864d05a360f2c6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Very good point, I did neglect ramfb resolution chang=
es... But there is one important thing: it *can* cause a QEMU crash, a pote=
ntially exploitable one, not always a guest crash. That&#39;s what motivate=
d my heavy-handed approach since allowing resolution change would have nece=
ssitated a good deal of security checks. It has crashed my host *kernel* qu=
ite a few times.<br></div><div><br></div><div>The point is, while=20
the QemuRamfbDxe driver may behave properly, nothing prevents the guest fro=
m writing garbage or *malicious* values to the ramfb config space. Then the=
 values are sent to the display component without any sanity check. For som=
e GUI frontends, this means allocating an OpenGL texture with guest-supplie=
d dimensions and uploading guest memory content to it, which means that gue=
st memory content goes straight into a *kernel driver*, *completely uncheck=
ed*. Some integer overflow and a lenient GPU driver later, and the guest es=
capes straight to kernel.</div><div><br></div><div>The proper way to enable=
 ramfb resolution change again is adding sanity checks for ramfb resolution=
 / pointer / etc. on the QEMU side. We have to make sure it doesn&#39;t exc=
eed what the host GPU driver supports.
 Maybe clamp both width and height to between 1 and 2048?

 We also need to validate that OpenGL texture dimension update succeeds. No=
te that OpenGL is not obliged to validate anything and everything has to be=
 checked on the QEMU side.<br></div><div><br></div><div>Qiming<br></div><di=
v><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"=
gmail_attr">On Wed, Apr 15, 2020 at 11:05 PM Laszlo Ersek &lt;<a href=3D"ma=
ilto:lersek@redhat.com">lersek@redhat.com</a>&gt; wrote:<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">(CC Gerd, Qiming, Marcel, qemu-dev=
el for ramfb:)<br>
<br>
On 04/14/20 23:20, valerij zaporogeci wrote:<br>
<br>
[snip]<br>
<br>
&gt; There is a Boot Manager UI display problem, I don&#39;t know if this i=
s<br>
&gt; qemu problem, but with the ARM (both 32 and 64 bits, the qemu version<=
br>
&gt; is 4.2.0, the OVMF is fresh), and using &quot;ramfb&quot; device, the =
Boot<br>
&gt; Manager has troubles with drawing - it&#39;s interfase looks entirely<=
br>
&gt; broken, like this (I&#39;ll try to attach the screenshot). UEFI shell<=
br>
&gt; doesn&#39;t have this problem. switching to &quot;serial&quot; (which =
is -serial vc)<br>
&gt; doesn&#39;t produce it too. Only when ramfb is chosen, the Boot Manage=
r UI<br>
&gt; gets smeared. But it takes input and presumable works properly, except=
<br>
&gt; displaying things. qemu writes these messages in the command prompt:<b=
r>
&gt; ramfb_fw_cfg_write: 640x480 @ 0x4bd00000<br>
&gt; ramfb_fw_cfg_write: resolution locked, change rejected<br>
&gt; ramfb_fw_cfg_write: 800x600 @ 0x4bd00000<br>
&gt; ramfb_fw_cfg_write: resolution locked, change rejected<br>
<br>
Gerd contributed the OVMF QemuRamfbDxe driver in edk2 commit<br>
1d25ff51af5c (&quot;OvmfPkg: add QemuRamfbDxe&quot;, 2018-06-14). Note the =
date:<br>
June 2018.<br>
<br>
The then-latest (released) QEMU version was v2.12.0, and v2.12.1 /<br>
v3.0.0 were in the making.<br>
<br>
At that time, the resolution change definitely worked -- note my<br>
&quot;Tested-by&quot; on the edk2 commit message.<br>
<br>
<br>
Running &quot;git blame&quot; on the QEMU source, I now find commit a9e0cb6=
7b7f4<br>
(&quot;hw/display/ramfb: lock guest resolution after it&#39;s set&quot;, 20=
19-05-24).<br>
<br>
Again, note the date: May 2019 (and this commit was released with QEMU<br>
v4.1.0).<br>
<br>
So I would say that the symptom you see is a QEMU v4.1.0 regression. The<br=
>
QemuRamfbGraphicsOutputSetMode() function in the OVMF ramfb driver<br>
certainly needs the QemuFwCfgWriteBytes() call to work, for changing the<br=
>
resolution.<br>
<br>
<br>
Now, I&#39;m not familiar with the reasons behind QEMU commit a9e0cb67b7f4.=
<br>
It says it intends to &quot;prevent[] a crash when the guest writes garbage=
<br>
to the configuration space (e.g. when rebooting)&quot;.<br>
<br>
But I don&#39;t understand why locking the resolution was necessary for<br>
preventing &quot;a crash&quot;:<br>
<br>
(1) Registering a device reset handler in QEMU seems sufficient, so that<br=
>
QEMU forget about the currently shared RAMFB area at platform reset.<br>
<br>
(2) The crash in question is apparently not a *QEMU* crash -- which<br>
might otherwise justify a heavy-handed approach. Instead, it is a<br>
*guest* crash. See the references below:<br>
<br>
(2a) <a href=3D"http://mid.mail-archive.com/CABSdmrmU7FK90Bupq_ySowcc9Uk=3D=
8nQxNLHgzvDsNYdp_QLogA@mail.gmail.com" rel=3D"noreferrer" target=3D"_blank"=
>http://mid.mail-archive.com/CABSdmrmU7FK90Bupq_ySowcc9Uk=3D8nQxNLHgzvDsNYd=
p_QLogA@mail.gmail.com</a><br>
=C2=A0 =C2=A0 =C2=A0<a href=3D"https://lists.gnu.org/archive/html/qemu-deve=
l/2019-05/msg02299.html" rel=3D"noreferrer" target=3D"_blank">https://lists=
.gnu.org/archive/html/qemu-devel/2019-05/msg02299.html</a><br>
<br>
(2b) <a href=3D"https://github.com/intel/gvt-linux/issues/23#issuecomment-4=
83651476" rel=3D"noreferrer" target=3D"_blank">https://github.com/intel/gvt=
-linux/issues/23#issuecomment-483651476</a><br>
<br>
Therefore, I don&#39;t think that locking the resolution was justified!<br>
<br>
Importantly:<br>
<br>
- The QemuRamfbDxe driver allocates the framebuffer in *reserved*<br>
memory, therefore any well-behaving OS will *never* touch the<br>
framebuffer.<br>
<br>
- The QemuRamfbDxe driver allocates the framebuffer memory only once,<br>
namely for such a resolution that needs the largest amount of<br>
framebuffer memory. Therefore, framebuffer re-allocations in the guest<br>
driver -- and thereby guest RAM *re-mapping* in QEMU -- are *not*<br>
necessary, upon resolution change.<br>
<br>
The ramfb device reset handler in QEMU is justified (for unmapping /<br>
forgetting the previously shared RAMFB area).<br>
<br>
The resolution locking is *NOT* justified, and it breaks the OVMF<br>
driver. I suggest backing out the resolution locking from QEMU.<br>
<br>
Reference (2a) above indicates &#39;It could be a misguided attempt to<br>
&quot;resize ramfb&quot; by the guest Intel driver&#39;. If that is the cas=
e, then<br>
please fix the Intel guest driver, without regressing the QEMU device<br>
model.<br>
<br>
I&#39;m sad that the QEMU device model change was not regression-tested<br>
against the *upstream* OVMF driver (which, by then, had been upstream<br>
for almost a year).<br>
<br>
Laszlo<br>
<br>
</blockquote></div>

--000000000000e2864d05a360f2c6--

