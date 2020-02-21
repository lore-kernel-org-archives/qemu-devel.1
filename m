Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54390C35641
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 09:14:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 063B320679
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 09:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFBrjRlD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 063B320679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j54Nr-0000xw-6f
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 04:14:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39764)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <hsp.cat7@gmail.com>) id 1j54N7-0000MJ-Tf
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 04:13:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hsp.cat7@gmail.com>) id 1j54N5-0001Jm-VL
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 04:13:21 -0500
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:46624)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <hsp.cat7@gmail.com>)
 id 1j54N4-0001Ep-PJ; Fri, 21 Feb 2020 04:13:19 -0500
Received: by mail-ot1-x32e.google.com with SMTP id g64so1353613otb.13;
 Fri, 21 Feb 2020 01:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=g0xbhii6h4xvCFt8V9DRcJIfkVkwQvDbCXqUFTpkjrI=;
 b=eFBrjRlD/8So0Szs9atVMHtXHELggB6yodQjXKvcXMt3iJUAs5F8OnkExLI7fRGsb3
 m+SxQBhuudTBX1EpAe0Tkf/sy78ZIQOSP0TbmYdLJhvMB5qseb5N8hYbTYFCMTJ2ElzT
 1BAM9BMNrn0Bu8QtkKVKuO2ybdtvs+mSwRyqx0Ne/CxUu7A01g0vbLs3tyqw2jUcPRDL
 cNSPs0E4uOZF8yXDEhYZxC7Mq8imSKjbD0t7kxNCq057rhV9QMNvygyxCPmm+bkfQWzo
 kNnw8S5T48ZypVsbj+jgWYW0LbP41Ig1Vd7gmPn05egS0Oy6bJ9lS3cb7xV4KtgICG9Q
 K+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=g0xbhii6h4xvCFt8V9DRcJIfkVkwQvDbCXqUFTpkjrI=;
 b=pD0gFFkGAu6EEhfgcRO5qsa74oqzf/73Tl1zM4w/Re7fTplRl1KR3bRR0MKzyD2hUp
 xsTpp7JT0sXwFfZk42jBkvO18fdOlDPZYD/kQeO5aSWcChqlAd7oybBx9sf9jjxTBfiN
 KQ4tvmfYaZTJ+7+P/f32heuqKrdzXpmrc3XLFicJcD+hnrQPuOuRVJLKxOifYiLVCAQl
 v4aegEWp7FZWnYmuV7ALiyyMv4MWaTD80CZKv7lyURCWctrHzmxll9YbZU8dhFZ6ZCpr
 2fZktYGIH6o4HbL1o5qWSKLnDNuPAErsyOyzigxYqqVvywT9XKcemd0XlLGIRwNTgLXS
 mwAQ==
X-Gm-Message-State: APjAAAXjgz0TOPluKsEfh1+5vNK9JZJxevjB6KPLriziFgNwf4Ciyopc
 vNCpQFEzLkynkn5rnohc/d9nBpddu53S9qf0WFs=
X-Google-Smtp-Source: APXvYqz5HBy4A5zSIPckhqS5AyiVa8v57o2AEQg+iI0EwiSve8PfPOqkV6XXpO/2YLk1sd2KOd4v3j8ekK+gfcPGrqk=
X-Received: by 2002:a9d:66d1:: with SMTP id t17mr28347490otm.233.1582276397478; 
 Fri, 21 Feb 2020 01:13:17 -0800 (PST)
MIME-Version: 1.0
References: <20200218012228.7336-1-programmingkidx@gmail.com>
In-Reply-To: <20200218012228.7336-1-programmingkidx@gmail.com>
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Fri, 21 Feb 2020 10:13:06 +0100
Message-ID: <CABLmASEMHLr=Q-7vVWcsHs0Yd9B4y7LOjgf_pwozb6soHuRZmw@mail.gmail.com>
Subject: Re: [PATCH v4] Implement the Screamer sound chip for the mac99
 machine type
To: John Arbuckle <programmingkidx@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000009bb756059f126e5d"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32e
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
Cc: qemu-ppc <qemu-ppc@nongnu.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000009bb756059f126e5d
Content-Type: text/plain; charset="UTF-8"

Hi,

It might be worth mentioning that any testing of your screamer
implementation with MacOS/OSX guests on the mac99 machine needs a
custom-built openbios.

Where possible I'll compare your screamer with the current screamer
implementation built from:
git clone -b screamer https://github.com/mcayland/qemu

All tests on OSX Sierra host with system sounds and MP3 playback through
latest QuickTime and iTunes available for the guest. Host is Intel i7-4770K
at 3.50Ghz. 32Gb memory. Audio device is an USB headset.
Overall very subjective impression is that sound problems seem to arise
quicker with strong changes in volume in the stream. Silence is produced
perfectly...
I should note that I also tested earlier with a windows build and that I
had to re-install Mac OS on three occasions to get sound going with your
screamer. Whether that was caused by a faulty installation or your screamer
is unclear to me.

There we go:

Mac OS 9.0.4: mac99,via=cuda
Apple audio extension often fails to load. (Not restricted to your
screamer. This is a longstanding issue.) See at bottom for OSX crash report.
Your screamer: shows only CD in Sound CP Input panel. Play sound through
output device is selected.
Current screamer: shows CD + External Mic. Play sound through output device
is selected.

Mac OS 9.1: mac99,via=cuda
Your screamer: No Input selection in the Sound CP.
Current screamer: Has External Mic (but no CD) in Sound CP. Play sound
through output device is not selected.

Mac OS 9.2: mac99,via=pmu
Your screamer: mp3 through iTunes and QuickTime OK. System sounds OK.
Current screamer: Has considerably more problems playing two streams
simultaneously. (mp3 through both QuickTime and iTunes.)

Mac OS X 10.0: mac99,via=cuda
Your screamer: setting the sound balance from middle position to the left
seems to control volume.
Current screamer: Serious number of drop-outs when playing MP3 through
QuickTime. Not when using iTunes. Has issues when moving the sound balance.

Mac OS X 10.1: mac99,via=cuda
Off-topic: Interestingly, when booting with via=pmu, the same error occurs
as reported above.
Your screamer: QuickTime: drop-outs. iTunes OK, even with playing system
sounds through the stream. Balance has same problem as above.
Current screamer: Serious drop-outs through both QuickTime and iTunes when
playing MP3. Balance sync gets completely lost after moving slider. More
lag in response to clicking system sounds.

Mac OSX 10.2: no test due to longstanding video issue with opening folders.

Mac OSX 10.3: mac99,via=pmu
Your screamer: drop-outs with QuickTime and iTunes. But not the clicks
heard as mentioned below. Opening the Sound preferences when playing MP3 is
OK. System sounds playing through the stream produce crackling sound.
systems sounds stop playing after several clicks on different ones. I hear
parts of earlier clicked sound when new one clicked.
Current screamer: intermittent clicks (0.5 seconds) when playing MP3 with
QuickTime and iTunes. But QuickTime much better compared to 10.1. Currently
playing mp3 gets completely distorted (doubled?) when opening Sound
preferences.

Mac OSX 10.4: mac99,via=pmu
Off-topic: From 10.4 onward, Internet radio works in iTunes. Channel update
is very slow in 10.4...
Your screamer: drop-outs with QuickTime. Sounds comparable to current
screamer. Opening Sound preferences is OK, but can make stream spiral out
of control with an echo. Seems to happen quicker when playing sound with
strong stereo effects. But always quickly recovers, unlike current
screamer. iTunes also produces drop-outs. Also with internet stream, but is
almost listenable.
Current screamer: drop-outs with QuickTime. Sounds like stream is not
always in correct order. Sound crackles. iTunes almost OK. I can hear one
or two clicks after stopping audio. Opening Sound preferences makes stream
spiral out of control with an echo.

Mac OSX 10.5: mac99,via=pmu
Your screamer: Drop-outs with QuickTime. A bit less-so with iTunes. Opening
Sound preferences provides same experience as with 10.4. Internet stream
almost listenable.
Current screamer: QuickTime produces drop-outs. Sound control panel spirals
out of control. Small audio parts still played when stopping QuickTime.
iTunes almost OK with MP3 playback, only small drop-outs. Same with
Internet radio.

For good measure I also tested 10.5 with your screamer and the recent
hardfloat patches which improve fpu performance from 9% to 11% of a real G4
1Ghz ;-)
I did not experience a considerable improvement in sound quality.

Best,
Howard

OSX host Crash report when audio extension fails:

Crashed Thread:        2

Exception Type:        EXC_BAD_ACCESS (SIGSEGV)
Exception Codes:       KERN_INVALID_ADDRESS at 0x0000000000000008
Exception Note:        EXC_CORPSE_NOTIFY

Termination Signal:    Segmentation fault: 11
Termination Reason:    Namespace SIGNAL, Code 0xb
Terminating Process:   exc handler [0]

VM Regions Near 0x8:
-->
    __TEXT                 00000001087b0000-0000000108f7f000 [ 7996K]
r-x/rwx SM=COW  /Users/USER/*

Thread 2 Crashed:
0   qemu-system-ppc-screamer       0x0000000108c5b9ed timer_del + 13
1   qemu-system-ppc-screamer       0x000000010898bc1f audio_reset_timer +
319
2   qemu-system-ppc-screamer       0x00000001089807b6 vm_state_notify + 262
3   qemu-system-ppc-screamer       0x0000000108800b5f do_vm_stop + 47
4   qemu-system-ppc-screamer       0x0000000108985277 qemu_main + 16775
5   qemu-system-ppc-screamer       0x0000000108b46e86 call_qemu_main + 38
6   qemu-system-ppc-screamer       0x0000000108c6071e qemu_thread_start +
126
7   libsystem_pthread.dylib       0x00007fffb627093b _pthread_body + 180
8   libsystem_pthread.dylib       0x00007fffb6270887 _pthread_start + 286
9   libsystem_pthread.dylib       0x00007fffb627008d thread_start + 13

--0000000000009bb756059f126e5d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,<br><br>It might be worth mentioning that any test=
ing of your screamer implementation with MacOS/OSX guests on the mac99 mach=
ine needs a custom-built openbios.<br><br>Where possible I&#39;ll compare y=
our screamer with the current screamer implementation built from:<br>git cl=
one -b screamer <a href=3D"https://github.com/mcayland/qemu">https://github=
.com/mcayland/qemu</a> <br><br>All tests on OSX Sierra host with system sou=
nds and MP3 playback through latest QuickTime and iTunes available for the =
guest. Host is Intel i7-4770K at 3.50Ghz. 32Gb memory. Audio device is an U=
SB headset.<br>Overall very subjective impression is that sound problems se=
em to arise quicker with strong changes in volume in the stream. Silence is=
 produced perfectly...<br>I should note that I also tested earlier with a w=
indows build and that I had to re-install Mac OS on three occasions to get =
sound going with your screamer. Whether that was caused by a faulty install=
ation or your screamer is unclear to me.<br></div><div><br></div><div>There=
 we go:<br></div><div><br>Mac OS 9.0.4: mac99,via=3Dcuda<br>Apple audio ext=
ension often fails to load. (Not restricted to your screamer. This is a lon=
gstanding issue.) See at bottom for OSX crash report.<br>Your screamer: sho=
ws only CD in Sound CP Input panel. Play sound through output device is sel=
ected.<br>Current screamer: shows CD + External Mic. Play sound through out=
put device is selected.<br><br>Mac OS 9.1: mac99,via=3Dcuda<br>Your screame=
r: No Input selection in the Sound CP. <br>Current screamer: Has External M=
ic (but no CD) in Sound CP. Play sound through output device is not selecte=
d.<br><br>Mac OS 9.2: mac99,via=3Dpmu<br>Your screamer: mp3 through iTunes =
and QuickTime OK. System sounds OK.<br>Current screamer: Has considerably m=
ore problems playing two streams simultaneously. (mp3 through both QuickTim=
e and iTunes.)<br><br>Mac OS X 10.0: mac99,via=3Dcuda<br>Your screamer: set=
ting the sound balance from middle position to the left seems to control vo=
lume.<br>Current screamer: Serious number of drop-outs when playing MP3 thr=
ough QuickTime. Not when using iTunes. Has issues when moving the sound bal=
ance. <br><br>Mac OS X 10.1: mac99,via=3Dcuda<br>Off-topic: Interestingly, =
when booting with via=3Dpmu, the same error occurs as reported above.<br>Yo=
ur screamer: QuickTime: drop-outs. iTunes OK, even with playing system soun=
ds through the stream. Balance has same problem as above.<br>Current scream=
er: Serious drop-outs through both QuickTime and iTunes when playing MP3. B=
alance sync gets completely lost after moving slider. More lag in response =
to clicking system sounds.<br><br>Mac OSX 10.2: no test due to longstanding=
 video issue with opening folders.<br><br>Mac OSX 10.3: mac99,via=3Dpmu<br>=
Your screamer: drop-outs with QuickTime and iTunes. But not the clicks hear=
d as mentioned below. Opening the Sound preferences when playing MP3 is OK.=
 System sounds playing through the stream produce crackling sound. systems =
sounds stop playing after several clicks on different ones. I hear parts of=
 earlier clicked sound when new one clicked.<br>Current screamer: intermitt=
ent clicks (0.5 seconds) when playing MP3 with QuickTime and iTunes. But Qu=
ickTime much better compared to 10.1. Currently playing mp3 gets completely=
 distorted (doubled?) when opening Sound preferences.<br><br>Mac OSX 10.4: =
mac99,via=3Dpmu<br>Off-topic: From 10.4 onward, Internet radio works in iTu=
nes. Channel update is very slow in 10.4...<br>Your screamer: drop-outs wit=
h QuickTime. Sounds comparable to current screamer. Opening Sound preferenc=
es is OK, but can make stream spiral out of control with an echo. Seems to =
happen quicker when playing sound with strong stereo effects. But always qu=
ickly recovers, unlike current screamer. iTunes also produces drop-outs. Al=
so with internet stream, but is almost listenable.<br>Current screamer: dro=
p-outs with QuickTime. Sounds like stream is not always in correct order. S=
ound crackles. iTunes almost OK. I can hear one or two clicks after stoppin=
g audio. Opening Sound preferences makes stream spiral out of control with =
an echo.<br><br>Mac OSX 10.5: mac99,via=3Dpmu<br>Your screamer: Drop-outs w=
ith QuickTime. A bit less-so with iTunes. Opening Sound preferences provide=
s same experience as with 10.4. Internet stream almost listenable.<br>Curre=
nt screamer: QuickTime produces drop-outs. Sound control panel spirals out =
of control. Small audio parts still played when stopping QuickTime. iTunes =
almost OK with MP3 playback, only small drop-outs. Same with Internet radio=
. <br><br>For good measure I also tested 10.5 with your screamer and the re=
cent hardfloat patches which improve fpu performance from 9% to 11% of a re=
al G4 1Ghz ;-)<br>I did not experience a considerable improvement in sound =
quality.<br></div><div><br></div><div>Best,</div><div>Howard<br></div><div>=
<br></div><div>OSX host Crash report when audio extension fails:<br><br>Cra=
shed Thread: =C2=A0 =C2=A0 =C2=A0 =C2=A02<br><br>Exception Type: =C2=A0 =C2=
=A0 =C2=A0 =C2=A0EXC_BAD_ACCESS (SIGSEGV)<br>Exception Codes: =C2=A0 =C2=A0=
 =C2=A0 KERN_INVALID_ADDRESS at 0x0000000000000008<br>Exception Note: =C2=
=A0 =C2=A0 =C2=A0 =C2=A0EXC_CORPSE_NOTIFY<br><br>Termination Signal: =C2=A0=
 =C2=A0Segmentation fault: 11<br>Termination Reason: =C2=A0 =C2=A0Namespace=
 SIGNAL, Code 0xb<br>Terminating Process: =C2=A0 exc handler [0]<br><br>VM =
Regions Near 0x8:<br>--&gt; <br>=C2=A0 =C2=A0 __TEXT =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 00000001087b0000-0000000108f7f000 [ 7996=
K] r-x/rwx SM=3DCOW =C2=A0/Users/USER/*<br><br>Thread 2 Crashed:<br>0 =C2=
=A0 qemu-system-ppc-screamer =C2=A0 =C2=A0 =C2=A0	0x0000000108c5b9ed timer_=
del + 13<br>1 =C2=A0 qemu-system-ppc-screamer =C2=A0 =C2=A0 =C2=A0	0x000000=
010898bc1f audio_reset_timer + 319<br>2 =C2=A0 qemu-system-ppc-screamer =C2=
=A0 =C2=A0 =C2=A0	0x00000001089807b6 vm_state_notify + 262<br>3 =C2=A0 qemu=
-system-ppc-screamer =C2=A0 =C2=A0 =C2=A0	0x0000000108800b5f do_vm_stop + 4=
7<br>4 =C2=A0 qemu-system-ppc-screamer =C2=A0 =C2=A0 =C2=A0	0x0000000108985=
277 qemu_main + 16775<br>5 =C2=A0 qemu-system-ppc-screamer =C2=A0 =C2=A0 =
=C2=A0	0x0000000108b46e86 call_qemu_main + 38<br>6 =C2=A0 qemu-system-ppc-s=
creamer =C2=A0 =C2=A0 =C2=A0	0x0000000108c6071e qemu_thread_start + 126<br>=
7 =C2=A0 libsystem_pthread.dylib =C2=A0 =C2=A0 =C2=A0 	0x00007fffb627093b _=
pthread_body + 180<br>8 =C2=A0 libsystem_pthread.dylib =C2=A0 =C2=A0 =C2=A0=
 	0x00007fffb6270887 _pthread_start + 286<br>9 =C2=A0 libsystem_pthread.dyl=
ib =C2=A0 =C2=A0 =C2=A0 	0x00007fffb627008d thread_start + 13</div><div><br=
></div></div>

--0000000000009bb756059f126e5d--

