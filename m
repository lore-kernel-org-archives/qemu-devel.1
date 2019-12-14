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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F880C43603
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 23:36:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5385420706
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 23:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o+t6k81d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5385420706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igGxg-0007mq-EE
	for qemu-devel@archiver.kernel.org; Sat, 14 Dec 2019 18:36:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52479)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1igGwu-0007MY-Gm
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 18:35:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1igGwt-00089q-1E
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 18:35:48 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:40670)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1igGws-00086d-PV; Sat, 14 Dec 2019 18:35:46 -0500
Received: by mail-oi1-x241.google.com with SMTP id 6so2652038oix.7;
 Sat, 14 Dec 2019 15:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=alKby2HQ8O/eZnC/VPF2517t9OEB3x15CojX2zko3u0=;
 b=o+t6k81dEdtzZYbixoKZaKYJqKcbv29f+njeLBS1VKdnt6VOoNqYCw9vl+dOJfz0Wb
 QDxox9uUB3Ez2uGjyD9v+ffD9j+DDNkrbwZXMHgwxHFktqfqMLrVS4m+uH/kwtXnbQir
 BN8oZR/KnBDOCoTxtZuPkCOqBDn6oXBJxDClyAMbPBxKT0YL8b5uvZwSMBaPj/QtY5bm
 nul5vFKQzZUJBZutv2gx5ymM6MrA5N2a/9zgZipEWgwDK5BHZRpvnPw0AZp+dPEChwHZ
 Qso1UGjDUt3OFxdkIySzG38OOfr93aHxdSL+/x/uTFM3iRzW67UKeEAcNpOlEt9vETG5
 wN1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=alKby2HQ8O/eZnC/VPF2517t9OEB3x15CojX2zko3u0=;
 b=UP481JbGoeVQwrplReWDVX1z5NLA3ezCsKCMXGmkfDWWFuwHuVTXb/WF998fxm3tHo
 Yc/CIk8J0RNR8ew2pnYt/XPM6LuaKsbBfupNxtcLaNLWuONx20QMpy+iobZ80guwxFQB
 LL1jgI9Avk3kOhBlk9iFXnMvSM9vsKLru6iR2WkaoQMwkB4Wm9TekSaSHvLw5rdJeAqL
 onysNcQsdfpEi15LiyEQOHNOuYFkbNLPegAMfKTFaYFOem0ckmiABN/Ob4wWxhXPhQi+
 kRBDdtj7pnonhXFrTsuYhmCdoZV2eQtQWpiW+eWi2wecn8saSVEpmJ4EK8OaxMlj6nkv
 vY2A==
X-Gm-Message-State: APjAAAXBc86O/8kGzcaUY0nqpWgKAoLA31XwkPfmj5xDVWBsRUgQLEw8
 N1TAA+1UrFwhu2UiAjcP5nJoSZocje+vn7E2sTlH+w==
X-Google-Smtp-Source: APXvYqyCV4Di/OufRFAZCpmf6bEv5C9D/UoqGpUGZIGqHOy/UEF20mOgRIaDioqlRSHxbtO7zJ+fdN86hCSRc1ZTQ8k=
X-Received: by 2002:aca:bbc6:: with SMTP id l189mr8938517oif.53.1576366545667; 
 Sat, 14 Dec 2019 15:35:45 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Sat, 14 Dec 2019 15:35:45 -0800 (PST)
In-Reply-To: <CAL1e-=hRs0EMz7ZTt+GXMfyHW8arq-h-m1Dzd3jz+vqP82+zjA@mail.gmail.com>
References: <cover.1576286757.git.fthain@telegraphics.com.au>
 <CAL1e-=gwxSDa1NSevcCbjG1r5vg6A49Kg_FP2EL1jW+BMn7Ghw@mail.gmail.com>
 <alpine.LNX.2.21.1.1912150915460.8@nippy.intranet>
 <CAL1e-=hRs0EMz7ZTt+GXMfyHW8arq-h-m1Dzd3jz+vqP82+zjA@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sun, 15 Dec 2019 00:35:45 +0100
Message-ID: <CAL1e-=iTBxqCsNCbGpONdewE4uTDG=OAV36fF_Cq9=i6KQhMaA@mail.gmail.com>
Subject: Re: [PATCH 00/10] Fixes for DP8393X SONIC device emulation
To: Finn Thain <fthain@telegraphics.com.au>
Content-Type: multipart/alternative; boundary="000000000000fd8e2e0599b26fab"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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

--000000000000fd8e2e0599b26fab
Content-Type: text/plain; charset="UTF-8"

On Sunday, December 15, 2019, Aleksandar Markovic <
aleksandar.m.mail@gmail.com> wrote:

>
>
> On Sunday, December 15, 2019, Finn Thain <fthain@telegraphics.com.au>
> wrote:
>
>> On Sat, 14 Dec 2019, Aleksandar Markovic wrote:
>>
>> > On Saturday, December 14, 2019, Finn Thain <fthain@telegraphics.com.au>
>> > wrote:
>> >
>> > > Hi All,
>> > >
>> > > There is a bug in the DP8393X emulation that can stop packet
>> reception.
>> > >
>> > >
>> > Can you provide the details of your test scenario?
>> >
>> > Thanks,
>> > Aleksandar
>> >
>>
>> I test the qemu build like this,
>>
>> qemu-system-m68k -M q800 -m 512M -serial none -serial mon:stdio -g
>> 800x600x4
>> -net nic,model=dp83932,addr=00:00:00:01:02:03
>> -net bridge,helper=/opt/qemu/libexec/qemu-bridge-helper,br=br0
>> -append "fbcon=font:ProFont6x11 console=tty0 console=ttyS0
>> ignore_loglevel"
>> -kernel vmlinux-4.14.157-mac-backport+
>> -initrd /mnt/loop/install/cdrom/initrd.gz
>>
>> You can obtain this kernel binary from the linux-mac68k project on
>> sourceforge. (I usually use a mainline Linux build but it makes no
>> difference.)
>>
>> I normally use a disk image with Debian/m68k SID rootfs but in this
>> example I've used the initrd that you can find on the Debian/m68k
>> installer ISO.
>>
>> Once the guest starts, switch to a different virtual console and bring up
>> the SONIC:
>>
>> <ctrl>-<a> <ctrl>-<a> <2>
>> # ip addr add dev eth0 192.168.65.2/24
>> # ip link set dev eth0 up
>>
>> On the host, send a ping flood (with preload) to the guest:
>>
>> # ifconfig br0 192.168.65.1/24
>> # ping 192.168.65.2 -f -l 20
>>
>> The packet reception ("deaf sonic") issue is reproduced immediately.
>>
>> This has been observed in both qemu-m68k and mainline qemu. See also,
>> https://github.com/vivier/qemu-m68k/commit/0a45280c9fa40da8d
>> 5f30b1bb3d0513db91c3909
>>
>>
> Finn,
>
> I appreciate your detailed response!
>
> Aleksandar
>
>


Herve,

Is there any way for us to come up with an equivalent or at least
approximate scenario for Jazz machines?

Regards,
Aleksandar

--000000000000fd8e2e0599b26fab
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Sunday, December 15, 2019, Aleksandar Markovic &lt;<a href=3D"ma=
ilto:aleksandar.m.mail@gmail.com">aleksandar.m.mail@gmail.com</a>&gt; wrote=
:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex"><br><br>On Sunday, December 15, 2019, F=
inn Thain &lt;<a href=3D"mailto:fthain@telegraphics.com.au" target=3D"_blan=
k">fthain@telegraphics.com.au</a>&gt; wrote:<br><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex">On Sat, 14 Dec 2019, Aleksandar Markovic wrote:<br>
<br>
&gt; On Saturday, December 14, 2019, Finn Thain &lt;<a href=3D"mailto:fthai=
n@telegraphics.com.au" target=3D"_blank">fthain@telegraphics.com.au</a>&gt;=
<br>
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
-net nic,model=3Ddp83932,addr=3D00:00:0<wbr>0:01:02:03<br>
-net bridge,helper=3D/opt/qemu/libexe<wbr>c/qemu-bridge-helper,br=3Dbr0<br>
-append &quot;fbcon=3Dfont:ProFont6x11 console=3Dtty0 console=3DttyS0 ignor=
e_loglevel&quot;<br>
-kernel vmlinux-4.14.157-mac-backport+<br>
-initrd /mnt/loop/install/cdrom/initrd<wbr>.gz<br>
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
b1bb3d0513db91c3909" target=3D"_blank">https://github.com/vivier/qemu<wbr>-=
m68k/commit/0a45280c9fa40da8d<wbr>5f30b1bb3d0513db91c3909</a><br>
<br>
</blockquote><div><br></div><div>Finn,</div><div><br></div><div>I appreciat=
e your detailed response!</div><div><br></div><div>Aleksandar</div><div>=C2=
=A0</div></blockquote><div><br></div><div><br></div><div>Herve,</div><div><=
br></div><div>Is there any way for us to come up with an equivalent or at l=
east approximate scenario for Jazz machines?</div><div><br></div><div>Regar=
ds,</div><div>Aleksandar=C2=A0</div>

--000000000000fd8e2e0599b26fab--

