Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC008C32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 13:13:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5D3520842
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 13:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhxA2WYr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5D3520842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEvUw-00010i-Om
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 09:13:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41114)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <doug16k@gmail.com>) id 1iEvUD-0000ZC-Mz
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 09:13:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <doug16k@gmail.com>) id 1iEvUC-0007vC-7i
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 09:13:09 -0400
Received: from mail-io1-xd2b.google.com ([2607:f8b0:4864:20::d2b]:38928)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <doug16k@gmail.com>) id 1iEvUC-0007uN-0Y
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 09:13:08 -0400
Received: by mail-io1-xd2b.google.com with SMTP id a1so38133128ioc.6
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 06:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=enRDTM5wM41Khon371+1GhlCBgGbJgd6B7P51I0+lV4=;
 b=dhxA2WYrQyND3xwUFDk9285yg4q/dgzCRx1uRdyAgwn2Ki2oEBoGRZdxXhE33BcdD2
 U7fMFNzaM40ep++xp9y2KKseOOUmsnjptLyH0M45okjN2iicCfy0ajinvd2b0rtSpoUY
 9OJoyEcgjgwFqvEtiSiHKLQYJixd+z09tissZYbsJtiKalJ8aKdweBO4uOprgG8h6vlh
 AFNUgim2lvwHKscbrQTdCXJsKPqEwH3DwfonoEn6IlZUZki1W3fwwgEFcvZRrx/ZfKoL
 rrnluIJta8wj4vKAhEKsKa0If9W70WhQVszheocf+XR9fHvCiV8j2Q85P90VKAGxqsBL
 shgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=enRDTM5wM41Khon371+1GhlCBgGbJgd6B7P51I0+lV4=;
 b=JfkYauOKNJIQKuq4nUtkShf8Gd10SaWEe493fkV2i5VEWKWetsd6999Dudglna9MrC
 Q5AQe7lPwKePR409VmjldzC/Dwgm5S+BAcuNa83yoQ9SzZg5tMy1Wlabi7C05ZJvz3Db
 iUwHqsi0w1/SA852amspgjYEOKiE9eOvbs9DDt+sgNa6s5w6G8/iNXFEcUpylGnH52v9
 hcpvXh7fgXQHzg9o7dsSAtqIyC4Mbmrv8Ln0wRRxVwywADcMZ+aFa1craymKj+SF6WgI
 GBvOvHRPz2yQfYZXpvWD6ILOOYIQxRGJf+8FTPvbiBxyvgYjxlDql3pYmAyM7ub/7IKe
 +Ndg==
X-Gm-Message-State: APjAAAUar4MC2xiublouXD163aknFzxIc9657snq4M/uyt7lZ7E6wQI3
 Zsf39YRCk3feyne4pqrA+Lhqo5xt+YalZkvrhTJWi5K4uTY=
X-Google-Smtp-Source: APXvYqw75BIPodWSFPrImp6L17KukK2nHzX4dEXolvWB08hrQkrpcnRVNBt1hv5d1kiqdq/kDpKgHr7rnWdBy+IcMjM=
X-Received: by 2002:a02:55c4:: with SMTP id e187mr19753719jab.32.1569849186599; 
 Mon, 30 Sep 2019 06:13:06 -0700 (PDT)
MIME-Version: 1.0
From: Doug Gale <doug16k@gmail.com>
Date: Mon, 30 Sep 2019 09:12:55 -0400
Message-ID: <CAEfK_46vgiqzy30gK41fZ7uz5fTe5ktKWLu345VJaw9PJaw3xw@mail.gmail.com>
Subject: Lockup with --accel tcg,thread=single
To: qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000001e45800593c4ff1b"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d2b
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000001e45800593c4ff1b
Content-Type: text/plain; charset="UTF-8"

I found a lockup in single threaded TCG, with OVMF bios, 16 CPUs.

qemu-system-x86_64 --accel tcg,thread=single -smp cpus=16 -bios
/usr/share/ovmf/OVMF.fd

Using Ubuntu 18.04 LTS, default gnome desktop. There is no guest OS, there
is no hard drive, just the OVMF firmware locks it up. (I narrowed it down
to this from a much larger repro)

Let that run for about 10 seconds or so, then attempt to Ctrl-C in the
terminal that launched qemu. You should see the hung program thing (wait or
force quit) appear on the qemu window, and the terminal just prints ^C
without interrupting qemu. DO NOT click force quit or wait. Use killall -9
qemu-system-x86_64 to kill it if you must, gdb kill is also okay. If you
force quit you will likely freeze the entire gnome desktop. This is what
kmsg reports:
https://gist.githubusercontent.com/doug65536/810e0471c11008c97edb4aa0d86ddd66/raw/40038a355542f0edb1f14a7c7fb7c2db60da0025/end%2520of%2520syslog%2520after%2520desktop%2520lockup,
this is what syslog reports:
https://gist.githubusercontent.com/doug65536/810e0471c11008c97edb4aa0d86ddd66/raw/40038a355542f0edb1f14a7c7fb7c2db60da0025/the%2520end%2520of%2520dmesg%2520after%2520desktop%2520lockup.
Probably bugs in gnome but just warning about locking up your machines when
reproducing.

Peter Maydell helped me bisect it in IRC.
 Works fine at commit 1e8a98b53867f61
 Fails at commit 9458a9a1df1a4c7

MTTCG works fine all the way up to master.

Configure command line:

../qemu/configure --target-list=x86_64-softmmu,i386-softmmu
--audio-drv-list=pa --enable-libusb --disable-libssh --enable-virglrenderer
--enable-opengl --enable-debug

The issue occurs without --enable-debug. I didn't strip the configure down
though, it may not need all of those configure options exactly.

OVMF from ubuntu package manager, package named ovmf, exact version
is 0~20180205.c0d9813c-2ubuntu0.1

Stack trace at lockup at
https://gist.githubusercontent.com/doug65536/810e0471c11008c97edb4aa0d86ddd66/raw/40038a355542f0edb1f14a7c7fb7c2db60da0025/backtrace%2520all

--0000000000001e45800593c4ff1b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:times ne=
w roman,serif">I found a lockup in single threaded TCG, with OVMF bios, 16 =
CPUs.</div><div class=3D"gmail_default" style=3D"font-family:times new roma=
n,serif"><br></div><div class=3D"gmail_default" style=3D""><font face=3D"mo=
nospace">qemu-system-x86_64 --accel tcg,thread=3Dsingle -smp cpus=3D16 -bio=
s /usr/share/ovmf/OVMF.fd<br></font></div><div class=3D"gmail_default" styl=
e=3D"font-family:times new roman,serif"><br></div><div class=3D"gmail_defau=
lt" style=3D"font-family:times new roman,serif">Using Ubuntu 18.04 LTS, def=
ault gnome desktop. There is no guest OS, there is no hard drive, just the =
OVMF firmware locks it up. (I narrowed it down to this from a much larger r=
epro)</div><div class=3D"gmail_default" style=3D"font-family:times new roma=
n,serif"><br></div><div class=3D"gmail_default" style=3D"font-family:times =
new roman,serif">Let that run for about 10 seconds or so, then attempt to C=
trl-C in the terminal that launched qemu. You should see the hung program t=
hing (wait or force quit) appear on the qemu window, and the terminal just =
prints ^C without interrupting qemu. DO NOT click force quit or wait. Use k=
illall -9 qemu-system-x86_64 to kill it if you must, gdb kill is also okay.=
 If you force quit you will likely freeze the entire gnome desktop. This is=
 what kmsg reports:=C2=A0<a href=3D"https://gist.githubusercontent.com/doug=
65536/810e0471c11008c97edb4aa0d86ddd66/raw/40038a355542f0edb1f14a7c7fb7c2db=
60da0025/end%2520of%2520syslog%2520after%2520desktop%2520lockup" style=3D"f=
ont-family:Arial,Helvetica,sans-serif">https://gist.githubusercontent.com/d=
oug65536/810e0471c11008c97edb4aa0d86ddd66/raw/40038a355542f0edb1f14a7c7fb7c=
2db60da0025/end%2520of%2520syslog%2520after%2520desktop%2520lockup</a>, thi=
s is what syslog reports:=C2=A0<a href=3D"https://gist.githubusercontent.co=
m/doug65536/810e0471c11008c97edb4aa0d86ddd66/raw/40038a355542f0edb1f14a7c7f=
b7c2db60da0025/the%2520end%2520of%2520dmesg%2520after%2520desktop%2520locku=
p" style=3D"font-family:Arial,Helvetica,sans-serif">https://gist.githubuser=
content.com/doug65536/810e0471c11008c97edb4aa0d86ddd66/raw/40038a355542f0ed=
b1f14a7c7fb7c2db60da0025/the%2520end%2520of%2520dmesg%2520after%2520desktop=
%2520lockup</a>. Probably bugs in gnome but just warning about locking up y=
our machines when reproducing.</div><div class=3D"gmail_default" style=3D"f=
ont-family:times new roman,serif"><br></div><div class=3D"gmail_default" st=
yle=3D"font-family:times new roman,serif">Peter Maydell helped me bisect it=
 in IRC.=C2=A0</div><div class=3D"gmail_default" style=3D"font-family:times=
 new roman,serif">=C2=A0Works fine at commit=C2=A01e8a98b53867f61</div><div=
 class=3D"gmail_default" style=3D"font-family:times new roman,serif">=C2=A0=
Fails at commit=C2=A09458a9a1df1a4c7</div><div class=3D"gmail_default" styl=
e=3D"font-family:times new roman,serif"><br></div><div class=3D"gmail_defau=
lt" style=3D"font-family:times new roman,serif">MTTCG works fine all the wa=
y up to master.</div><div class=3D"gmail_default" style=3D"font-family:time=
s new roman,serif"><br></div><div class=3D"gmail_default" style=3D"font-fam=
ily:times new roman,serif">Configure command line:</div><div class=3D"gmail=
_default" style=3D"font-family:times new roman,serif"><br></div><div class=
=3D"gmail_default" style=3D""><font face=3D"monospace">../qemu/configure --=
target-list=3Dx86_64-softmmu,i386-softmmu --audio-drv-list=3Dpa --enable-li=
busb --disable-libssh --enable-virglrenderer --enable-opengl --enable-debug=
</font><br></div><div class=3D"gmail_default" style=3D"font-family:times ne=
w roman,serif"><br></div><div class=3D"gmail_default" style=3D"font-family:=
times new roman,serif">The issue occurs without --enable-debug. I didn&#39;=
t strip the configure down though, it may not need all of those configure o=
ptions exactly.</div><div class=3D"gmail_default" style=3D"font-family:time=
s new roman,serif"><br></div><div class=3D"gmail_default" style=3D"font-fam=
ily:times new roman,serif">OVMF from ubuntu package manager, package named =
ovmf, exact version is=C2=A00~20180205.c0d9813c-2ubuntu0.1</div><div class=
=3D"gmail_default" style=3D"font-family:times new roman,serif"><br></div><d=
iv class=3D"gmail_default" style=3D"font-family:times new roman,serif">Stac=
k trace at lockup at=C2=A0<a href=3D"https://gist.githubusercontent.com/dou=
g65536/810e0471c11008c97edb4aa0d86ddd66/raw/40038a355542f0edb1f14a7c7fb7c2d=
b60da0025/backtrace%2520all" style=3D"font-family:Arial,Helvetica,sans-seri=
f">https://gist.githubusercontent.com/doug65536/810e0471c11008c97edb4aa0d86=
ddd66/raw/40038a355542f0edb1f14a7c7fb7c2db60da0025/backtrace%2520all</a></d=
iv><div class=3D"gmail_default" style=3D"font-family:times new roman,serif"=
><br></div><div class=3D"gmail_default" style=3D"font-family:times new roma=
n,serif"><br></div></div>

--0000000000001e45800593c4ff1b--

