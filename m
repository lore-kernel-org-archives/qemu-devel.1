Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F18C35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 12:10:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C71A207FD
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 12:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evoCpHYf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C71A207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j578Q-00044E-Cw
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 07:10:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45222)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <hsp.cat7@gmail.com>) id 1j577n-0003YO-Id
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 07:09:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hsp.cat7@gmail.com>) id 1j577k-0008Iy-P5
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 07:09:43 -0500
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d]:43875)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <hsp.cat7@gmail.com>)
 id 1j577k-0008Hv-If; Fri, 21 Feb 2020 07:09:40 -0500
Received: by mail-ot1-x32d.google.com with SMTP id p8so1750798oth.10;
 Fri, 21 Feb 2020 04:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5cRqBAruWFNRxi4ri4uh4GtSLrNMUW19Fdx7FiXtb5Q=;
 b=evoCpHYfRQlEefEAMjUHpJejpiskAP7kJnAMtdt8M1NGABRNDv1vcU8GWJDRjDG3Ff
 RP7XsT3xMx7IrhhnYUimW2eRDvOvgleVpECmxnUEgFYK4oHH/iuwztokOJG0HZSTVCQf
 UlHswv0SDl4YjQUso+mUisXrNsVICKPEVQEm2sex9JqOpyq4FNNsmWG3NjtTTZEnxaDj
 gZBp9SNLMM7BVh5vkk0ghrNZlbv0LX8thovtpAlX00oKnFRs1S1WizNx9NtCYuUgyYdn
 bduC25h10I9FXAEIYvMQ60OYldgL2clLRNZAsJyd7xQ2IV3E5NWx30AdMKWdClQDled0
 HRkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5cRqBAruWFNRxi4ri4uh4GtSLrNMUW19Fdx7FiXtb5Q=;
 b=CEaopXtEo5m9PFzpioL4H/MRMPRxMuCdpjmjplpBy6Z9Q8PmLaS2VEt7NG63Z4PN+2
 EYLU1NbGWngJP6C6gCwVuYyHUaH/OpC89HaNLoMgBGFx6mzt+b/5FcfxBrWkZFNFEhrw
 5q2bJivxCi/Jtl7aHI1OtjRH8Z9y32ksv9YUf5tDd5i1VMYk/Po8aqTHULYZcOn8yRv9
 Uw40tBJ7uZ/DER+5C6LgTSKhqHOgWkGs9P/K26Yy7Tjl37Nex14g3dsLge1382yI/p0P
 f/CPzdoiXdK5/YMAHLN/vqadFmBliQXmFK7MDC8JWqrzD3mjtbBPeOhKRTndkLMPjPfQ
 4x4g==
X-Gm-Message-State: APjAAAVUFGptxeQP4Zj7lwCa4CzmZIM/Hr5uWlHDXNZHA3K2LKfqfqNL
 RLhzGDmzwbBiqldoHj58pfHF7uVjEIjJgtDxYHDV2JmiuKA=
X-Google-Smtp-Source: APXvYqxJE5gdmuqRWjwT8Ez7qetdBACy4HSn1ezM3PXk/JQsiAlxKrGyuHmHb0IQNSflQEjNPbVPuwV2xvz6VvydWuw=
X-Received: by 2002:a9d:1706:: with SMTP id i6mr29357419ota.151.1582286979592; 
 Fri, 21 Feb 2020 04:09:39 -0800 (PST)
MIME-Version: 1.0
References: <20200218012228.7336-1-programmingkidx@gmail.com>
 <CABLmASEMHLr=Q-7vVWcsHs0Yd9B4y7LOjgf_pwozb6soHuRZmw@mail.gmail.com>
 <C774280A-DB79-4C5B-816C-6E97816FDB78@gmail.com>
In-Reply-To: <C774280A-DB79-4C5B-816C-6E97816FDB78@gmail.com>
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Fri, 21 Feb 2020 13:09:28 +0100
Message-ID: <CABLmASGM+qu7QfNOgiFe7nK8+nNGJ=GqHi3tQUcHKq-jGwJu6g@mail.gmail.com>
Subject: Re: [PATCH v4] Implement the Screamer sound chip for the mac99
 machine type
To: Programmingkid <programmingkidx@gmail.com>
Content-Type: multipart/alternative; boundary="00000000000059f4aa059f14e51d"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32d
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

--00000000000059f4aa059f14e51d
Content-Type: text/plain; charset="UTF-8"

On Fri, Feb 21, 2020 at 12:30 PM Programmingkid <programmingkidx@gmail.com>
wrote:

>
> > On Feb 21, 2020, at 4:13 AM, Howard Spoelstra <hsp.cat7@gmail.com>
> wrote:
> >
> > Hi,
> >
> > It might be worth mentioning that any testing of your screamer
> implementation with MacOS/OSX guests on the mac99 machine needs a
> custom-built openbios.
> >
> > Where possible I'll compare your screamer with the current screamer
> implementation built from:
> > git clone -b screamer https://github.com/mcayland/qemu
> >
> > All tests on OSX Sierra host with system sounds and MP3 playback through
> latest QuickTime and iTunes available for the guest. Host is Intel i7-4770K
> at 3.50Ghz. 32Gb memory. Audio device is an USB headset.
> > Overall very subjective impression is that sound problems seem to arise
> quicker with strong changes in volume in the stream. Silence is produced
> perfectly...
> > I should note that I also tested earlier with a windows build and that I
> had to re-install Mac OS on three occasions to get sound going with your
> screamer. Whether that was caused by a faulty installation or your screamer
> is unclear to me.
> >
> > There we go:
> >
> > Mac OS 9.0.4: mac99,via=cuda
> > Apple audio extension often fails to load. (Not restricted to your
> screamer. This is a longstanding issue.) See at bottom for OSX crash report.
> > Your screamer: shows only CD in Sound CP Input panel. Play sound through
> output device is selected.
> > Current screamer: shows CD + External Mic. Play sound through output
> device is selected.
> >
> > Mac OS 9.1: mac99,via=cuda
> > Your screamer: No Input selection in the Sound CP.
> > Current screamer: Has External Mic (but no CD) in Sound CP. Play sound
> through output device is not selected.
> >
> > Mac OS 9.2: mac99,via=pmu
> > Your screamer: mp3 through iTunes and QuickTime OK. System sounds OK.
> > Current screamer: Has considerably more problems playing two streams
> simultaneously. (mp3 through both QuickTime and iTunes.)
> >
> > Mac OS X 10.0: mac99,via=cuda
> > Your screamer: setting the sound balance from middle position to the
> left seems to control volume.
> > Current screamer: Serious number of drop-outs when playing MP3 through
> QuickTime. Not when using iTunes. Has issues when moving the sound balance.
> >
> > Mac OS X 10.1: mac99,via=cuda
> > Off-topic: Interestingly, when booting with via=pmu, the same error
> occurs as reported above.
> > Your screamer: QuickTime: drop-outs. iTunes OK, even with playing system
> sounds through the stream. Balance has same problem as above.
> > Current screamer: Serious drop-outs through both QuickTime and iTunes
> when playing MP3. Balance sync gets completely lost after moving slider.
> More lag in response to clicking system sounds.
> >
> > Mac OSX 10.2: no test due to longstanding video issue with opening
> folders.
> >
> > Mac OSX 10.3: mac99,via=pmu
> > Your screamer: drop-outs with QuickTime and iTunes. But not the clicks
> heard as mentioned below. Opening the Sound preferences when playing MP3 is
> OK. System sounds playing through the stream produce crackling sound.
> systems sounds stop playing after several clicks on different ones. I hear
> parts of earlier clicked sound when new one clicked.
> > Current screamer: intermittent clicks (0.5 seconds) when playing MP3
> with QuickTime and iTunes. But QuickTime much better compared to 10.1.
> Currently playing mp3 gets completely distorted (doubled?) when opening
> Sound preferences.
> >
> > Mac OSX 10.4: mac99,via=pmu
> > Off-topic: From 10.4 onward, Internet radio works in iTunes. Channel
> update is very slow in 10.4...
> > Your screamer: drop-outs with QuickTime. Sounds comparable to current
> screamer. Opening Sound preferences is OK, but can make stream spiral out
> of control with an echo. Seems to happen quicker when playing sound with
> strong stereo effects. But always quickly recovers, unlike current
> screamer. iTunes also produces drop-outs. Also with internet stream, but is
> almost listenable.
> > Current screamer: drop-outs with QuickTime. Sounds like stream is not
> always in correct order. Sound crackles. iTunes almost OK. I can hear one
> or two clicks after stopping audio. Opening Sound preferences makes stream
> spiral out of control with an echo.
> >
> > Mac OSX 10.5: mac99,via=pmu
> > Your screamer: Drop-outs with QuickTime. A bit less-so with iTunes.
> Opening Sound preferences provides same experience as with 10.4. Internet
> stream almost listenable.
> > Current screamer: QuickTime produces drop-outs. Sound control panel
> spirals out of control. Small audio parts still played when stopping
> QuickTime. iTunes almost OK with MP3 playback, only small drop-outs. Same
> with Internet radio.
> >
> > For good measure I also tested 10.5 with your screamer and the recent
> hardfloat patches which improve fpu performance from 9% to 11% of a real G4
> 1Ghz ;-)
> > I did not experience a considerable improvement in sound quality.
> >
> > Best,
> > Howard
> >
> > OSX host Crash report when audio extension fails:
> >
> > Crashed Thread:        2
> >
> > Exception Type:        EXC_BAD_ACCESS (SIGSEGV)
> > Exception Codes:       KERN_INVALID_ADDRESS at 0x0000000000000008
> > Exception Note:        EXC_CORPSE_NOTIFY
> >
> > Termination Signal:    Segmentation fault: 11
> > Termination Reason:    Namespace SIGNAL, Code 0xb
> > Terminating Process:   exc handler [0]
> >
> > VM Regions Near 0x8:
> > -->
> >     __TEXT                 00000001087b0000-0000000108f7f000 [ 7996K]
> r-x/rwx SM=COW  /Users/USER/*
> >
> > Thread 2 Crashed:
> > 0   qemu-system-ppc-screamer          0x0000000108c5b9ed timer_del + 13
> > 1   qemu-system-ppc-screamer          0x000000010898bc1f
> audio_reset_timer + 319
> > 2   qemu-system-ppc-screamer          0x00000001089807b6 vm_state_notify
> + 262
> > 3   qemu-system-ppc-screamer          0x0000000108800b5f do_vm_stop + 47
> > 4   qemu-system-ppc-screamer          0x0000000108985277 qemu_main +
> 16775
> > 5   qemu-system-ppc-screamer          0x0000000108b46e86 call_qemu_main
> + 38
> > 6   qemu-system-ppc-screamer          0x0000000108c6071e
> qemu_thread_start + 126
> > 7   libsystem_pthread.dylib       0x00007fffb627093b _pthread_body + 180
> > 8   libsystem_pthread.dylib       0x00007fffb6270887 _pthread_start + 286
> > 9   libsystem_pthread.dylib       0x00007fffb627008d thread_start + 13
> >
>
> Thank you for such a detailed testing of my screamer patch. Your tests
> show it is an improvement over the older screamer implementation :)
>
> I'm hoping the maintainer will review my patch soon. I haven't heard a
> thing from him since late December. I thinking either he does not have the
> time to review my patch or he does not want to see his patch be replaced
> with mine.
>
> For the binaries of QEMU you provide on emaculation.net, would you say it
> is time to replace the old screamer builds with this patch?
>

Hi,

The current screamer-enabled builds for OSX and Windows are on
www.emaculation.com ;-)
As you see from testing, there are reasons why the patches from Mark's
screamer branch are not in master yet, and these have not all been
addressed. There still needs to be testing on Linux and certainly on
Windows builds, and from what I mentioned above that might not be plain
sailing.
I guess I'll wait with providing new builds when the patches for both
openbios and qemu are reviewed and in some repo from which I can build
easily.

Best,
Howard

--00000000000059f4aa059f14e51d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Feb 21, 2020 at 12:30 PM Prog=
rammingkid &lt;<a href=3D"mailto:programmingkidx@gmail.com">programmingkidx=
@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><br>
&gt; On Feb 21, 2020, at 4:13 AM, Howard Spoelstra &lt;<a href=3D"mailto:hs=
p.cat7@gmail.com" target=3D"_blank">hsp.cat7@gmail.com</a>&gt; wrote:<br>
&gt; <br>
&gt; Hi,<br>
&gt; <br>
&gt; It might be worth mentioning that any testing of your screamer impleme=
ntation with MacOS/OSX guests on the mac99 machine needs a custom-built ope=
nbios.<br>
&gt; <br>
&gt; Where possible I&#39;ll compare your screamer with the current screame=
r implementation built from:<br>
&gt; git clone -b screamer <a href=3D"https://github.com/mcayland/qemu" rel=
=3D"noreferrer" target=3D"_blank">https://github.com/mcayland/qemu</a> <br>
&gt; <br>
&gt; All tests on OSX Sierra host with system sounds and MP3 playback throu=
gh latest QuickTime and iTunes available for the guest. Host is Intel i7-47=
70K at 3.50Ghz. 32Gb memory. Audio device is an USB headset.<br>
&gt; Overall very subjective impression is that sound problems seem to aris=
e quicker with strong changes in volume in the stream. Silence is produced =
perfectly...<br>
&gt; I should note that I also tested earlier with a windows build and that=
 I had to re-install Mac OS on three occasions to get sound going with your=
 screamer. Whether that was caused by a faulty installation or your screame=
r is unclear to me.<br>
&gt; <br>
&gt; There we go:<br>
&gt; <br>
&gt; Mac OS 9.0.4: mac99,via=3Dcuda<br>
&gt; Apple audio extension often fails to load. (Not restricted to your scr=
eamer. This is a longstanding issue.) See at bottom for OSX crash report.<b=
r>
&gt; Your screamer: shows only CD in Sound CP Input panel. Play sound throu=
gh output device is selected.<br>
&gt; Current screamer: shows CD + External Mic. Play sound through output d=
evice is selected.<br>
&gt; <br>
&gt; Mac OS 9.1: mac99,via=3Dcuda<br>
&gt; Your screamer: No Input selection in the Sound CP. <br>
&gt; Current screamer: Has External Mic (but no CD) in Sound CP. Play sound=
 through output device is not selected.<br>
&gt; <br>
&gt; Mac OS 9.2: mac99,via=3Dpmu<br>
&gt; Your screamer: mp3 through iTunes and QuickTime OK. System sounds OK.<=
br>
&gt; Current screamer: Has considerably more problems playing two streams s=
imultaneously. (mp3 through both QuickTime and iTunes.)<br>
&gt; <br>
&gt; Mac OS X 10.0: mac99,via=3Dcuda<br>
&gt; Your screamer: setting the sound balance from middle position to the l=
eft seems to control volume.<br>
&gt; Current screamer: Serious number of drop-outs when playing MP3 through=
 QuickTime. Not when using iTunes. Has issues when moving the sound balance=
. <br>
&gt; <br>
&gt; Mac OS X 10.1: mac99,via=3Dcuda<br>
&gt; Off-topic: Interestingly, when booting with via=3Dpmu, the same error =
occurs as reported above.<br>
&gt; Your screamer: QuickTime: drop-outs. iTunes OK, even with playing syst=
em sounds through the stream. Balance has same problem as above.<br>
&gt; Current screamer: Serious drop-outs through both QuickTime and iTunes =
when playing MP3. Balance sync gets completely lost after moving slider. Mo=
re lag in response to clicking system sounds.<br>
&gt; <br>
&gt; Mac OSX 10.2: no test due to longstanding video issue with opening fol=
ders.<br>
&gt; <br>
&gt; Mac OSX 10.3: mac99,via=3Dpmu<br>
&gt; Your screamer: drop-outs with QuickTime and iTunes. But not the clicks=
 heard as mentioned below. Opening the Sound preferences when playing MP3 i=
s OK. System sounds playing through the stream produce crackling sound. sys=
tems sounds stop playing after several clicks on different ones. I hear par=
ts of earlier clicked sound when new one clicked.<br>
&gt; Current screamer: intermittent clicks (0.5 seconds) when playing MP3 w=
ith QuickTime and iTunes. But QuickTime much better compared to 10.1. Curre=
ntly playing mp3 gets completely distorted (doubled?) when opening Sound pr=
eferences.<br>
&gt; <br>
&gt; Mac OSX 10.4: mac99,via=3Dpmu<br>
&gt; Off-topic: From 10.4 onward, Internet radio works in iTunes. Channel u=
pdate is very slow in 10.4...<br>
&gt; Your screamer: drop-outs with QuickTime. Sounds comparable to current =
screamer. Opening Sound preferences is OK, but can make stream spiral out o=
f control with an echo. Seems to happen quicker when playing sound with str=
ong stereo effects. But always quickly recovers, unlike current screamer. i=
Tunes also produces drop-outs. Also with internet stream, but is almost lis=
tenable.<br>
&gt; Current screamer: drop-outs with QuickTime. Sounds like stream is not =
always in correct order. Sound crackles. iTunes almost OK. I can hear one o=
r two clicks after stopping audio. Opening Sound preferences makes stream s=
piral out of control with an echo.<br>
&gt; <br>
&gt; Mac OSX 10.5: mac99,via=3Dpmu<br>
&gt; Your screamer: Drop-outs with QuickTime. A bit less-so with iTunes. Op=
ening Sound preferences provides same experience as with 10.4. Internet str=
eam almost listenable.<br>
&gt; Current screamer: QuickTime produces drop-outs. Sound control panel sp=
irals out of control. Small audio parts still played when stopping QuickTim=
e. iTunes almost OK with MP3 playback, only small drop-outs. Same with Inte=
rnet radio. <br>
&gt; <br>
&gt; For good measure I also tested 10.5 with your screamer and the recent =
hardfloat patches which improve fpu performance from 9% to 11% of a real G4=
 1Ghz ;-)<br>
&gt; I did not experience a considerable improvement in sound quality.<br>
&gt; <br>
&gt; Best,<br>
&gt; Howard<br>
&gt; <br>
&gt; OSX host Crash report when audio extension fails:<br>
&gt; <br>
&gt; Crashed Thread:=C2=A0 =C2=A0 =C2=A0 =C2=A0 2<br>
&gt; <br>
&gt; Exception Type:=C2=A0 =C2=A0 =C2=A0 =C2=A0 EXC_BAD_ACCESS (SIGSEGV)<br=
>
&gt; Exception Codes:=C2=A0 =C2=A0 =C2=A0 =C2=A0KERN_INVALID_ADDRESS at 0x0=
000000000000008<br>
&gt; Exception Note:=C2=A0 =C2=A0 =C2=A0 =C2=A0 EXC_CORPSE_NOTIFY<br>
&gt; <br>
&gt; Termination Signal:=C2=A0 =C2=A0 Segmentation fault: 11<br>
&gt; Termination Reason:=C2=A0 =C2=A0 Namespace SIGNAL, Code 0xb<br>
&gt; Terminating Process:=C2=A0 =C2=A0exc handler [0]<br>
&gt; <br>
&gt; VM Regions Near 0x8:<br>
&gt; --&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0__TEXT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A000000001087b0000-0000000108f7f000 [ 7996K] r-x/rwx SM=3DCO=
W=C2=A0 /Users/USER/*<br>
&gt; <br>
&gt; Thread 2 Crashed:<br>
&gt; 0=C2=A0 =C2=A0qemu-system-ppc-screamer=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 0x0000000108c5b9ed timer_del + 13<br>
&gt; 1=C2=A0 =C2=A0qemu-system-ppc-screamer=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 0x000000010898bc1f audio_reset_timer + 319<br>
&gt; 2=C2=A0 =C2=A0qemu-system-ppc-screamer=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 0x00000001089807b6 vm_state_notify + 262<br>
&gt; 3=C2=A0 =C2=A0qemu-system-ppc-screamer=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 0x0000000108800b5f do_vm_stop + 47<br>
&gt; 4=C2=A0 =C2=A0qemu-system-ppc-screamer=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 0x0000000108985277 qemu_main + 16775<br>
&gt; 5=C2=A0 =C2=A0qemu-system-ppc-screamer=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 0x0000000108b46e86 call_qemu_main + 38<br>
&gt; 6=C2=A0 =C2=A0qemu-system-ppc-screamer=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 0x0000000108c6071e qemu_thread_start + 126<br>
&gt; 7=C2=A0 =C2=A0libsystem_pthread.dylib=C2=A0 =C2=A0 =C2=A0 =C2=A00x0000=
7fffb627093b _pthread_body + 180<br>
&gt; 8=C2=A0 =C2=A0libsystem_pthread.dylib=C2=A0 =C2=A0 =C2=A0 =C2=A00x0000=
7fffb6270887 _pthread_start + 286<br>
&gt; 9=C2=A0 =C2=A0libsystem_pthread.dylib=C2=A0 =C2=A0 =C2=A0 =C2=A00x0000=
7fffb627008d thread_start + 13<br>
&gt; <br>
<br>
Thank you for such a detailed testing of my screamer patch. Your tests show=
 it is an improvement over the older screamer implementation :)<br>
<br>
I&#39;m hoping the maintainer will review my patch soon. I haven&#39;t hear=
d a thing from him since late December. I thinking either he does not have =
the time to review my patch or he does not want to see his patch be replace=
d with mine. <br>
<br>
For the binaries of QEMU you provide on <a href=3D"http://emaculation.net" =
rel=3D"noreferrer" target=3D"_blank">emaculation.net</a>, would you say it =
is time to replace the old screamer builds with this patch? <br></blockquot=
e><div><br></div><div>Hi,</div><div><br></div><div>The current screamer-ena=
bled builds for OSX and Windows are on <a href=3D"http://www.emaculation.co=
m">www.emaculation.com</a> ;-)</div><div>As you see from testing, there are=
 reasons why the patches from Mark&#39;s screamer branch are not in master =
yet, and these have not all been addressed. There still needs to be testing=
 on Linux and certainly on Windows builds, and from what I mentioned above =
that might not be plain sailing. <br></div><div>I guess I&#39;ll wait with =
providing new builds when the patches for both openbios and qemu are review=
ed and in some repo from which I can build easily. </div><div><br></div><di=
v>Best,</div><div>Howard<br></div></div></div>

--00000000000059f4aa059f14e51d--

