Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 501F0C35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 11:31:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A816208C4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 11:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="shxERvAe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A816208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j56XF-0003lC-9x
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 06:31:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36466)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <programmingkidx@gmail.com>) id 1j56W7-0003FZ-BR
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 06:30:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <programmingkidx@gmail.com>) id 1j56W5-0003yM-QH
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 06:30:47 -0500
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34]:34387)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
 id 1j56W5-0003y6-Ld; Fri, 21 Feb 2020 06:30:45 -0500
Received: by mail-yb1-xb34.google.com with SMTP id u47so952186ybi.1;
 Fri, 21 Feb 2020 03:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=WIHfc89G//wIkMLiCMaMrcPyIrZ7GN17NiGcc0WAQ7Y=;
 b=shxERvAekcmrJfBZE0x5UKWJOj1LSJgyQ+zfsHyFL/jUOqdZq8jxUcECmLrAirPX+4
 Z5NSlATSgcOE8Edh6cTs14L3BMiJ34vnUtN/agcswiyTIIa3tDNupjBUJn3KWKlc5geN
 +++7ArL4FQqsx1L/40Ua8NZn59EauvF+lpTNTZrm7S9qdH0O296vpf97VBgUSYvOsx/G
 aH6Nwdd3adXSWa2pDZtHpHMcVSJskE/vxl3eT18/b9notsoZoTOno0kXO6ygt4Ec9CES
 9tFzzioGLjHnWEsLgzg2YFrIrD4V+mcROviBg65G2TJQX6p3zmFnmLNzXJdDr5jNjuqj
 O1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=WIHfc89G//wIkMLiCMaMrcPyIrZ7GN17NiGcc0WAQ7Y=;
 b=hcYVGyyV4dxUZ6mo0EAcyGgyZmHVASdtxhhPgVa8Ik5pGqgTvQGKm8mibGZNAqwXZT
 HPh179HvL1ne+7ncAqEVydhtnZkAZe08LDImyvGIH6VnG8I7BymQP1sDxJztFm6replY
 NOrxWaKl6kVBV/P4Uz7wXRXsG6qjr787yYJxv4cPjj3wYOQ/vzxil7f5AxkUn2U8T+8R
 rbY7YK0G7I0s71rFPZjbpJe4WvHkaZZlJthqd9v2avFO0s00GPnN4MzBs53YRLT7ZX4u
 wH7ApTARH/V9oIoxUq5xwC+4t2EwDnTJExvnf4iYU2f9rrmQ1UfweiTZlz0rT8bIwJEn
 i+MA==
X-Gm-Message-State: APjAAAXPUIUPg/EcIorvMacsvdCNDVzCQNiCTavsCmsfNhPLPbdmCJWr
 rCfY+RTKO0JliHJEdw2YZV0=
X-Google-Smtp-Source: APXvYqxpPzivBPZA1T+FpAbFDEZXHDkxSt9buLjr22fJeKIHD9oj4eJaq8lWfQk2eFbrQ2z+LWW/2g==
X-Received: by 2002:a25:be90:: with SMTP id i16mr34528276ybk.26.1582284644616; 
 Fri, 21 Feb 2020 03:30:44 -0800 (PST)
Received: from [192.168.0.5] (d149-67-30-58.try.wideopenwest.com.
 [67.149.58.30])
 by smtp.gmail.com with ESMTPSA id t5sm1160487ywc.3.2020.02.21.03.30.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Feb 2020 03:30:43 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v4] Implement the Screamer sound chip for the mac99
 machine type
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <CABLmASEMHLr=Q-7vVWcsHs0Yd9B4y7LOjgf_pwozb6soHuRZmw@mail.gmail.com>
Date: Fri, 21 Feb 2020 06:30:40 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <C774280A-DB79-4C5B-816C-6E97816FDB78@gmail.com>
References: <20200218012228.7336-1-programmingkidx@gmail.com>
 <CABLmASEMHLr=Q-7vVWcsHs0Yd9B4y7LOjgf_pwozb6soHuRZmw@mail.gmail.com>
To: Howard Spoelstra <hsp.cat7@gmail.com>
X-Mailer: Apple Mail (2.3273)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b34
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


> On Feb 21, 2020, at 4:13 AM, Howard Spoelstra <hsp.cat7@gmail.com> =
wrote:
>=20
> Hi,
>=20
> It might be worth mentioning that any testing of your screamer =
implementation with MacOS/OSX guests on the mac99 machine needs a =
custom-built openbios.
>=20
> Where possible I'll compare your screamer with the current screamer =
implementation built from:
> git clone -b screamer https://github.com/mcayland/qemu=20
>=20
> All tests on OSX Sierra host with system sounds and MP3 playback =
through latest QuickTime and iTunes available for the guest. Host is =
Intel i7-4770K at 3.50Ghz. 32Gb memory. Audio device is an USB headset.
> Overall very subjective impression is that sound problems seem to =
arise quicker with strong changes in volume in the stream. Silence is =
produced perfectly...
> I should note that I also tested earlier with a windows build and that =
I had to re-install Mac OS on three occasions to get sound going with =
your screamer. Whether that was caused by a faulty installation or your =
screamer is unclear to me.
>=20
> There we go:
>=20
> Mac OS 9.0.4: mac99,via=3Dcuda
> Apple audio extension often fails to load. (Not restricted to your =
screamer. This is a longstanding issue.) See at bottom for OSX crash =
report.
> Your screamer: shows only CD in Sound CP Input panel. Play sound =
through output device is selected.
> Current screamer: shows CD + External Mic. Play sound through output =
device is selected.
>=20
> Mac OS 9.1: mac99,via=3Dcuda
> Your screamer: No Input selection in the Sound CP.=20
> Current screamer: Has External Mic (but no CD) in Sound CP. Play sound =
through output device is not selected.
>=20
> Mac OS 9.2: mac99,via=3Dpmu
> Your screamer: mp3 through iTunes and QuickTime OK. System sounds OK.
> Current screamer: Has considerably more problems playing two streams =
simultaneously. (mp3 through both QuickTime and iTunes.)
>=20
> Mac OS X 10.0: mac99,via=3Dcuda
> Your screamer: setting the sound balance from middle position to the =
left seems to control volume.
> Current screamer: Serious number of drop-outs when playing MP3 through =
QuickTime. Not when using iTunes. Has issues when moving the sound =
balance.=20
>=20
> Mac OS X 10.1: mac99,via=3Dcuda
> Off-topic: Interestingly, when booting with via=3Dpmu, the same error =
occurs as reported above.
> Your screamer: QuickTime: drop-outs. iTunes OK, even with playing =
system sounds through the stream. Balance has same problem as above.
> Current screamer: Serious drop-outs through both QuickTime and iTunes =
when playing MP3. Balance sync gets completely lost after moving slider. =
More lag in response to clicking system sounds.
>=20
> Mac OSX 10.2: no test due to longstanding video issue with opening =
folders.
>=20
> Mac OSX 10.3: mac99,via=3Dpmu
> Your screamer: drop-outs with QuickTime and iTunes. But not the clicks =
heard as mentioned below. Opening the Sound preferences when playing MP3 =
is OK. System sounds playing through the stream produce crackling sound. =
systems sounds stop playing after several clicks on different ones. I =
hear parts of earlier clicked sound when new one clicked.
> Current screamer: intermittent clicks (0.5 seconds) when playing MP3 =
with QuickTime and iTunes. But QuickTime much better compared to 10.1. =
Currently playing mp3 gets completely distorted (doubled?) when opening =
Sound preferences.
>=20
> Mac OSX 10.4: mac99,via=3Dpmu
> Off-topic: =46rom 10.4 onward, Internet radio works in iTunes. Channel =
update is very slow in 10.4...
> Your screamer: drop-outs with QuickTime. Sounds comparable to current =
screamer. Opening Sound preferences is OK, but can make stream spiral =
out of control with an echo. Seems to happen quicker when playing sound =
with strong stereo effects. But always quickly recovers, unlike current =
screamer. iTunes also produces drop-outs. Also with internet stream, but =
is almost listenable.
> Current screamer: drop-outs with QuickTime. Sounds like stream is not =
always in correct order. Sound crackles. iTunes almost OK. I can hear =
one or two clicks after stopping audio. Opening Sound preferences makes =
stream spiral out of control with an echo.
>=20
> Mac OSX 10.5: mac99,via=3Dpmu
> Your screamer: Drop-outs with QuickTime. A bit less-so with iTunes. =
Opening Sound preferences provides same experience as with 10.4. =
Internet stream almost listenable.
> Current screamer: QuickTime produces drop-outs. Sound control panel =
spirals out of control. Small audio parts still played when stopping =
QuickTime. iTunes almost OK with MP3 playback, only small drop-outs. =
Same with Internet radio.=20
>=20
> For good measure I also tested 10.5 with your screamer and the recent =
hardfloat patches which improve fpu performance from 9% to 11% of a real =
G4 1Ghz ;-)
> I did not experience a considerable improvement in sound quality.
>=20
> Best,
> Howard
>=20
> OSX host Crash report when audio extension fails:
>=20
> Crashed Thread:        2
>=20
> Exception Type:        EXC_BAD_ACCESS (SIGSEGV)
> Exception Codes:       KERN_INVALID_ADDRESS at 0x0000000000000008
> Exception Note:        EXC_CORPSE_NOTIFY
>=20
> Termination Signal:    Segmentation fault: 11
> Termination Reason:    Namespace SIGNAL, Code 0xb
> Terminating Process:   exc handler [0]
>=20
> VM Regions Near 0x8:
> -->=20
>     __TEXT                 00000001087b0000-0000000108f7f000 [ 7996K] =
r-x/rwx SM=3DCOW  /Users/USER/*
>=20
> Thread 2 Crashed:
> 0   qemu-system-ppc-screamer      	0x0000000108c5b9ed timer_del + =
13
> 1   qemu-system-ppc-screamer      	0x000000010898bc1f =
audio_reset_timer + 319
> 2   qemu-system-ppc-screamer      	0x00000001089807b6 =
vm_state_notify + 262
> 3   qemu-system-ppc-screamer      	0x0000000108800b5f do_vm_stop + =
47
> 4   qemu-system-ppc-screamer      	0x0000000108985277 qemu_main + =
16775
> 5   qemu-system-ppc-screamer      	0x0000000108b46e86 =
call_qemu_main + 38
> 6   qemu-system-ppc-screamer      	0x0000000108c6071e =
qemu_thread_start + 126
> 7   libsystem_pthread.dylib       0x00007fffb627093b _pthread_body + =
180
> 8   libsystem_pthread.dylib       0x00007fffb6270887 _pthread_start + =
286
> 9   libsystem_pthread.dylib       0x00007fffb627008d thread_start + 13
>=20

Thank you for such a detailed testing of my screamer patch. Your tests =
show it is an improvement over the older screamer implementation :)

I'm hoping the maintainer will review my patch soon. I haven't heard a =
thing from him since late December. I thinking either he does not have =
the time to review my patch or he does not want to see his patch be =
replaced with mine.=20

For the binaries of QEMU you provide on emaculation.net, would you say =
it is time to replace the old screamer builds with this patch?=20


