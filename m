Return-Path: <SRS0=ZS6r=2E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NUMERIC_HTTP_ADDR,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DC2C43603
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 23:33:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93C99206D8
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 23:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAsPxaE1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93C99206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igGux-0006Hg-NF
	for qemu-devel@archiver.kernel.org; Sat, 14 Dec 2019 18:33:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33590)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1igGti-0005IT-0z
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 18:32:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1igGtg-0008Sf-9b
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 18:32:29 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:46890)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1igGtg-0008ML-1M; Sat, 14 Dec 2019 18:32:28 -0500
Received: by mail-oi1-x242.google.com with SMTP id a124so2622558oii.13;
 Sat, 14 Dec 2019 15:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=Y4NaC/znUTa69ELyXuJE/GuLuxb3fChZEcuPQJ1GAdA=;
 b=iAsPxaE1WJG02IC/aAvIaTu7HP7Q+jouzFFYpZl6ezCPN3Pz7jDR54icHcm89uaXWv
 1k09DyiBgMduiwxeBeVqRA8zk59GP3J1AMtNklyLdCS/EcOoKAJaPoH4K/c7oQd+JDXO
 +6TlMLnMfw1EeCDzIoiYFsRGCpsEiiA0BzHzhQNoQg4UBsPsCG6DXvDp2rDOnV5A8TBW
 iN8H/AtDFyj8RthCD1kYR9u80/OO4WxC9/sbJ9MPrYxorgTk8uaiJN3KXObuWKVCXkeK
 HPM6xbDhEmc0reXukFuMZyX1vet9RySE6uVK3qXzdvAQBt2zZcM2vZBTWyy2ZalhXU4J
 XNcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=Y4NaC/znUTa69ELyXuJE/GuLuxb3fChZEcuPQJ1GAdA=;
 b=sIdA6gOEjnE57NY9tBDSkiKhKOZJyW9gqNziqi/5YBWLqD/V/D5JXviiK0SDmmUIRX
 OAXjN7lerb8ccxEVa6Fbz1RXxkTFgAQS5RDaB1apjKBVLuBtvKmRvOBm/yU44ZfqRvKg
 0GFuBzbdv1Oe92ccJX2C1whC9dw89GkBk91WDlNWMXRGFHV3bxoAifHzYhLAksqF02l+
 EiNEuW0gF7h+Tb+n/poZDLp1c+hdUaO6AHzUDwAXuNK/2rpkYayOV/Axa2t9I2Vy5ZfY
 s+bQcw6M7moFy/nn8ruY1cux+BdurA9HhjjUhTU8z2QbB1F89IfUu/PgDgOaMwqDfY2B
 ZEAQ==
X-Gm-Message-State: APjAAAVNMUrgLQF88HglUSQ21gKRvSE5IgfrlhMYYE819R6FL71ejiEO
 MXuqHuPxvPV6Ingb5Qh2RnV6aomp4ka6cEHoyfE=
X-Google-Smtp-Source: APXvYqyFlHkTaEX5nCzkeYXkyUkE62eyivtzN6m0WTgzPJyue3bTH6jpqKEle250uK37n7OHk7NG1QPd0OvdN4vaz3g=
X-Received: by 2002:a05:6808:98b:: with SMTP id
 a11mr9000740oic.62.1576366345487; 
 Sat, 14 Dec 2019 15:32:25 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Sat, 14 Dec 2019 15:32:25 -0800 (PST)
In-Reply-To: <alpine.LNX.2.21.1.1912150915460.8@nippy.intranet>
References: <cover.1576286757.git.fthain@telegraphics.com.au>
 <CAL1e-=gwxSDa1NSevcCbjG1r5vg6A49Kg_FP2EL1jW+BMn7Ghw@mail.gmail.com>
 <alpine.LNX.2.21.1.1912150915460.8@nippy.intranet>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sun, 15 Dec 2019 00:32:25 +0100
Message-ID: <CAL1e-=hRs0EMz7ZTt+GXMfyHW8arq-h-m1Dzd3jz+vqP82+zjA@mail.gmail.com>
Subject: Re: [PATCH 00/10] Fixes for DP8393X SONIC device emulation
To: Finn Thain <fthain@telegraphics.com.au>
Content-Type: multipart/alternative; boundary="0000000000000f0bb90599b264b3"
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
Cc: Jason Wang <jasowang@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>,
 Herve Poussineau <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000000f0bb90599b264b3
Content-Type: text/plain; charset="UTF-8"

On Sunday, December 15, 2019, Finn Thain <fthain@telegraphics.com.au> wrote:

> On Sat, 14 Dec 2019, Aleksandar Markovic wrote:
>
> > On Saturday, December 14, 2019, Finn Thain <fthain@telegraphics.com.au>
> > wrote:
> >
> > > Hi All,
> > >
> > > There is a bug in the DP8393X emulation that can stop packet reception.
> > >
> > >
> > Can you provide the details of your test scenario?
> >
> > Thanks,
> > Aleksandar
> >
>
> I test the qemu build like this,
>
> qemu-system-m68k -M q800 -m 512M -serial none -serial mon:stdio -g
> 800x600x4
> -net nic,model=dp83932,addr=00:00:00:01:02:03
> -net bridge,helper=/opt/qemu/libexec/qemu-bridge-helper,br=br0
> -append "fbcon=font:ProFont6x11 console=tty0 console=ttyS0 ignore_loglevel"
> -kernel vmlinux-4.14.157-mac-backport+
> -initrd /mnt/loop/install/cdrom/initrd.gz
>
> You can obtain this kernel binary from the linux-mac68k project on
> sourceforge. (I usually use a mainline Linux build but it makes no
> difference.)
>
> I normally use a disk image with Debian/m68k SID rootfs but in this
> example I've used the initrd that you can find on the Debian/m68k
> installer ISO.
>
> Once the guest starts, switch to a different virtual console and bring up
> the SONIC:
>
> <ctrl>-<a> <ctrl>-<a> <2>
> # ip addr add dev eth0 192.168.65.2/24
> # ip link set dev eth0 up
>
> On the host, send a ping flood (with preload) to the guest:
>
> # ifconfig br0 192.168.65.1/24
> # ping 192.168.65.2 -f -l 20
>
> The packet reception ("deaf sonic") issue is reproduced immediately.
>
> This has been observed in both qemu-m68k and mainline qemu. See also,
> https://github.com/vivier/qemu-m68k/commit/0a45280c9fa40da8d5f30b1bb3d051
> 3db91c3909
>
>
Finn,

I appreciate your detailed response!

Aleksandar

--0000000000000f0bb90599b264b3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Sunday, December 15, 2019, Finn Thain &lt;<a href=3D"mailto:ftha=
in@telegraphics.com.au">fthain@telegraphics.com.au</a>&gt; wrote:<br><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex">On Sat, 14 Dec 2019, Aleksandar Markovic wrote:<br=
>
<br>
&gt; On Saturday, December 14, 2019, Finn Thain &lt;<a href=3D"mailto:fthai=
n@telegraphics.com.au">fthain@telegraphics.com.au</a>&gt;<br>
&gt; wrote:<br>
&gt; <br>
&gt; &gt; Hi All,<br>
&gt; &gt;<br>
&gt; &gt; There is a bug in the DP8393X emulation that can stop packet rece=
ption.<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; Can you provide the details of your test scenario?<br>
&gt; <br>
&gt; Thanks,<br>
&gt; Aleksandar<br>
&gt; <br>
<br>
I test the qemu build like this,<br>
<br>
qemu-system-m68k -M q800 -m 512M -serial none -serial mon:stdio -g 800x600x=
4<br>
-net nic,model=3Ddp83932,addr=3D00:00:<wbr>00:01:02:03<br>
-net bridge,helper=3D/opt/qemu/<wbr>libexec/qemu-bridge-helper,br=3D<wbr>br=
0<br>
-append &quot;fbcon=3Dfont:ProFont6x11 console=3Dtty0 console=3DttyS0 ignor=
e_loglevel&quot;<br>
-kernel vmlinux-4.14.157-mac-backport+<br>
-initrd /mnt/loop/install/cdrom/<wbr>initrd.gz<br>
<br>
You can obtain this kernel binary from the linux-mac68k project on <br>
sourceforge. (I usually use a mainline Linux build but it makes no <br>
difference.)<br>
<br>
I normally use a disk image with Debian/m68k SID rootfs but in this <br>
example I&#39;ve used the initrd that you can find on the Debian/m68k <br>
installer ISO.<br>
<br>
Once the guest starts, switch to a different virtual console and bring up <=
br>
the SONIC:<br>
<br>
&lt;ctrl&gt;-&lt;a&gt; &lt;ctrl&gt;-&lt;a&gt; &lt;2&gt;<br>
# ip addr add dev eth0 <a href=3D"http://192.168.65.2/24" target=3D"_blank"=
>192.168.65.2/24</a><br>
# ip link set dev eth0 up<br>
<br>
On the host, send a ping flood (with preload) to the guest:<br>
<br>
# ifconfig br0 <a href=3D"http://192.168.65.1/24" target=3D"_blank">192.168=
.65.1/24</a><br>
# ping 192.168.65.2 -f -l 20<br>
<br>
The packet reception (&quot;deaf sonic&quot;) issue is reproduced immediate=
ly.<br>
<br>
This has been observed in both qemu-m68k and mainline qemu. See also,<br>
<a href=3D"https://github.com/vivier/qemu-m68k/commit/0a45280c9fa40da8d5f30=
b1bb3d0513db91c3909" target=3D"_blank">https://github.com/vivier/<wbr>qemu-=
m68k/commit/<wbr>0a45280c9fa40da8d5f30b1bb3d051<wbr>3db91c3909</a><br>
<br>
</blockquote><div><br></div><div>Finn,</div><div><br></div><div>I appreciat=
e your detailed response!</div><div><br></div><div>Aleksandar</div><div>=C2=
=A0</div>

--0000000000000f0bb90599b264b3--

