Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 721ADCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 13:47:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E21120679
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 13:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oVRR3DIw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E21120679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNzwG-0007KO-Eh
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 09:47:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34518)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <hsp.cat7@gmail.com>) id 1iNzeK-00021W-H2
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:29:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hsp.cat7@gmail.com>) id 1iNzeI-0008IH-Br
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:29:04 -0400
Received: from mail-yw1-xc30.google.com ([2607:f8b0:4864:20::c30]:41695)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <hsp.cat7@gmail.com>) id 1iNzeI-0008Hs-6E
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:29:02 -0400
Received: by mail-yw1-xc30.google.com with SMTP id o195so747316ywd.8
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 06:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=NWvmpWJ9Fm2s0u0rAL/RYHUQquvomNowfXAxzJjjmSY=;
 b=oVRR3DIwwSXP8vW29hYekBzeMmm13rE4LFbjNc4awZR53MXAAdl5oFLUm93A3xf9Tr
 AxadBjQjNUxeTsQzkIWhYyvbcZpfTYYO9vwyJG8rfW4WSJX/YX8Ylgxoq1X7+o8B/lC5
 g0xiTB/Lrw1Aqc02X8I95DQhMAki+fmMtsAce+bSt9F25W9eKisIBjkzz3scZ8mGJPG3
 KGBe3t2Vx8CKNxXpY0ns5h67jvY6urTfqjvD4pzTaXpllbbss9rF/UFQ+E+FzPkHpeQ8
 AbIAHvEas1qWJ0WF1nv19fFVyMoJkvThj5VbtQRxcVO3wFJsVqbZ4w8F8Ws+tCndln4r
 X3Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=NWvmpWJ9Fm2s0u0rAL/RYHUQquvomNowfXAxzJjjmSY=;
 b=KI+pGalFB8qHSB1WNPwIrPdksOALLQ5CDz9rlUslsRttJY5fnP68+CHiyAKhdwTQSo
 SGi/l2jwfa9YH/FW9OYLTWptiWTg8fUVsmPPjtAx3wLx5j7B3HrklIDIh7YVoAYjctUq
 j/ZHbXAs5EH/dyAeldAe08UPAhpnq2H9yXC/H6g+coeMMg2NBr/skD8arsJRluNdneQZ
 eS+v/TO4ZRQOElumoNpWvtTwKT57UE74vJrIFLM5+KEtL5pfkEMcS25jrVjK8Lby1X2x
 ELeVe6QdSoTWH2IAc5rkJ5u2jgCHu9IIz9Fa/u3oOQBRjyQ14ixgnj+hGbO2HqubrAqR
 zdhg==
X-Gm-Message-State: APjAAAUiH+MzbQZ9FBWxmTN/yGjoj1LGBeqWmSISEWD7O/qFS6GRxBc4
 FpuiWowxZge2UHCMhvRRqqc8hBuuzio7jd9YPdiZfHDu
X-Google-Smtp-Source: APXvYqwd/y1xm4gUL93gbSNB4bqQBt1HqhQaBY7U/LWKBeWp5uJfxirleTIa3EM7Wf89TwCTur10xEIFZbcPI/Ix8q4=
X-Received: by 2002:a81:9b10:: with SMTP id s16mr2259120ywg.342.1572010140119; 
 Fri, 25 Oct 2019 06:29:00 -0700 (PDT)
MIME-Version: 1.0
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Fri, 25 Oct 2019 15:28:49 +0200
Message-ID: <CABLmASG1413=5he48wC0e2hrdoKjs7kasY18WVkyCrRypqZRqw@mail.gmail.com>
Subject: USB-audio sound issues with qemu-system-ppc in Linux and Windows.
To: qemu-devel qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000fc36a20595bc2185"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c30
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

--000000000000fc36a20595bc2185
Content-Type: text/plain; charset="UTF-8"

 Hi,

I'm  experiencing several issues related to sound using usb-audio when
running qemu-system-ppc in Linux and Windows. Guests tried are Mac OS 9.2
and Mac OS X 10.0, 10.1, 10.2 and 10.3.
(10.4 and 10.5 never have the usb-audio device available for audio
playback, even though the device is recognised in the OS X system profiler.)
It is hit and miss whether the audio device is actually available upon boot
in 9.2 and the other versions of OS X.

Qemu version tried is current master (Oct 25th), Windows version is
cross-compiled from Fedora 30. I do not think there is any regression going
on here, these are just issues that have been present for a long time.

General issue: when audio is played, it almost always sounds crackling.

For reasons of size, I uploaded 3 logs obtained in Linux running Mac OS X
10.3 with -trace "usb*" to:
https://surfdrive.surf.nl/files/index.php/s/YfVVxEE3cHXkFPf/download
1. Log_no_audio_available.txt
2. Log_audio_available_2_sounds_played.txt
3. Log_audio_available_multi_sounds_played_untill_hangup.txt

General issue in Linux (fedora 30)(which seems related to bug
https://bugs.launchpad.net/qemu/+bug/1623998):
[hsp@fedora30 qemu-master]$ ./startqemu.sh
pulseaudio: set_sink_input_volume() failed
pulseaudio: Reason: Invalid argument
pulseaudio: set_sink_input_mute() failed
pulseaudio: Reason: Invalid argument

General issue in Windows 10: I always get to a point where this is logged:
dsound: Could not lock playback buffer
dsound: Reason: An invalid parameter was passed to the returning function
dsound: Failed to lock buffer

Linux specific.
Qemu invocation for Mac OS 9.2:
./qemu-system-ppc -L pc-bios -boot c -M mac99 -m 512 \
-drive file=~/Mac-disks/9.2.img,format=raw,media=disk \
-serial stdio -sdl -device usb-audio -trace "*aud*"

This immediately starts logging:
7380@1571817102.833929:audio_timer_start interval 10 ms
7380@1571817125.207880:audio_timer_delayed interval 16 ms
7380@1571817129.046816:audio_timer_delayed interval 16 ms

Any movement of a window on the Linux desktop results in additional
audio_timer_delayed logging.
The audio_timer_delayed never stops.
In Mac OS 9.2, the desktop icons disappear after some seconds of running,
so the system cannot be stopped normally.
Running the GTK GUI, only this is logged (no additional logging when moving
windows).
14130@1571988483.402017:audio_timer_start interval 10 ms
But the icons on the desktop also disappear.

When running Mac OS X 10.X and clicking some system sounds, I see:
12134@1571818709.446031:audio_timer_start interval 10 ms
12134@1571818710.195023:audio_timer_stop
12134@1571818714.951030:audio_timer_start interval 10 ms
12134@1571818715.432959:audio_timer_stop
12134@1571818717.171045:audio_timer_start interval 10 ms
12134@1571818717.714323:audio_timer_stop
12134@1571818718.072381:audio_timer_start interval 10 ms
12134@1571818719.114544:audio_timer_stop

After randomly clicking some system sounds more, the timer starts delaying
and no longer stops:
12134@1571818893.564793:audio_timer_stop
12134@1571818895.698040:audio_timer_start interval 10 ms
12134@1571818899.961673:audio_timer_delayed interval 15 ms
12134@1571818900.472716:audio_timer_delayed interval 15 ms
12134@1571818902.759007:audio_timer_delayed interval 15 ms
12134@1571818905.803400:audio_timer_delayed interval 15 ms
But the systems stays responsive, so can be shut down.

Windows specific.
Invocation:
qemu-system-ppc.exe -L pc-bios -boot c -M mac99 -m 512 ^
-drive file=C:\Mac-disks\9.2.img,format=raw,media=disk ^
-serial stdio -sdl -device usb-audio -trace "*aud*"

This immediately starts logging the audio_timer_start interval and never
stops.
Icons disappear from the desktop after some seconds.

When running Mac OS X 10.X, playing just two system sounds results in:
2380@1571822566.040790:audio_timer_start interval 10 ms
2380@1571822566.108279:audio_timer_delayed interval 22 ms
2380@1571822566.128820:audio_timer_delayed interval 20 ms
2380@1571822566.150509:audio_timer_delayed interval 22 ms
2380@1571822566.172112:audio_timer_delayed interval 21 ms
......
2380@1571822566.561345:audio_timer_delayed interval 21 ms
2380@1571822566.583846:audio_timer_delayed interval 22 ms
2380@1571822566.600482:audio_timer_delayed interval 15 ms
2380@1571822566.610111:audio_timer_stop
2380@1571822572.226433:audio_timer_start interval 10 ms
2380@1571822572.250866:audio_timer_delayed interval 24 ms
2380@1571822572.269819:audio_timer_delayed interval 18 ms
......
2380@1571822572.452403:audio_timer_delayed interval 20 ms
2380@1571822572.474190:audio_timer_delayed interval 21 ms
2380@1571822572.509474:audio_timer_delayed interval 35 ms
dsound: Could not lock playback buffer
dsound: Reason: An invalid parameter was passed to the returning function
dsound: Failed to lock buffer
2380@1571822572.560505:audio_timer_delayed interval 51 ms
2380@1571822572.581102:audio_timer_delayed interval 19 ms
2380@1571822572.600912:audio_timer_delayed interval 19 ms

There is no saying when audio_timer_delayed will start displaying
constantly.
Only when one set of:
2260@1571823472.652244:audio_timer_start interval 10 ms
2260@1571823473.198349:audio_timer_stop
Is following directly after each other, sound is played somewhat correctly.
After randomly clicking several system sounds, the audio_timer_delayed
message never stops.

Thanks for looking into this.
If there is any additional information needed, or disk images of Mac OS 9.2
or OS X 10.3 are required, please let me know.

Best,
Howard

ps: thanks to Zoltan for pointing out I sent the original message into an
earlier thread ;-)

--000000000000fc36a20595bc2185
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">
Hi,<br><br>I&#39;m =C2=A0experiencing several issues related to sound using=
=20
usb-audio when running qemu-system-ppc in Linux and Windows. Guests=20
tried are Mac OS 9.2 and Mac OS X 10.0, 10.1, 10.2 and 10.3. <br>(10.4=20
and 10.5 never have the usb-audio device available for audio playback,=20
even though the device is recognised in the OS X system profiler.)<br>It is=
 hit and miss whether the audio device is actually available upon boot in 9=
.2 and the other versions of OS X.<br><br>Qemu
 version tried is current master (Oct 25th), Windows version is=20
cross-compiled from Fedora 30. I do not think there is any regression=20
going on here, these are just issues that have been present for a long=20
time.<br><br>General issue: when audio is played, it almost always sounds c=
rackling.<br><br>For reasons of size, I uploaded 3 logs obtained in Linux r=
unning Mac OS X 10.3 with -trace &quot;usb*&quot; to: <a href=3D"https://su=
rfdrive.surf.nl/files/index.php/s/YfVVxEE3cHXkFPf/download" target=3D"_blan=
k">https://surfdrive.surf.nl/files/index.php/s/YfVVxEE3cHXkFPf/download</a>=
<br>1. Log_no_audio_available.txt<br>2. Log_audio_available_2_sounds_played=
.txt<br>3. Log_audio_available_multi_sounds_played_untill_hangup.txt<br><br=
>General issue in Linux (fedora 30)(which seems related to bug <a href=3D"h=
ttps://bugs.launchpad.net/qemu/+bug/1623998" target=3D"_blank">https://bugs=
.launchpad.net/qemu/+bug/1623998</a>):<br>[hsp@fedora30 qemu-master]$ ./sta=
rtqemu.sh<br>pulseaudio: set_sink_input_volume() failed<br>pulseaudio: Reas=
on: Invalid argument<br>pulseaudio: set_sink_input_mute() failed<br>pulseau=
dio: Reason: Invalid argument<br><br>General issue in Windows 10: I always =
get to a point where this is logged:<br>dsound: Could not lock playback buf=
fer<br>dsound: Reason: An invalid parameter was passed to the returning fun=
ction<br>dsound: Failed to lock buffer<br><br>Linux specific.<br>Qemu invoc=
ation for Mac OS 9.2:<br>./qemu-system-ppc -L pc-bios -boot c -M mac99 -m 5=
12 \<br>-drive file=3D~/Mac-disks/9.2.img,format=3Draw,media=3Ddisk \<br>-s=
erial stdio -sdl -device usb-audio -trace &quot;*aud*&quot;<br><br>This imm=
ediately starts logging:<br>7380@1571817102.833929:audio_timer_start interv=
al 10 ms<br>7380@1571817125.207880:audio_timer_delayed interval 16 ms<br>73=
80@1571817129.046816:audio_timer_delayed interval 16 ms<br><br>Any movement=
 of a window on the Linux desktop results in additional audio_timer_delayed=
 logging. <br>The audio_timer_delayed never stops.<br>In Mac OS 9.2, the de=
sktop icons disappear after some seconds of running, so the system cannot b=
e stopped normally.<br>Running the GTK GUI, only this is logged (no additio=
nal logging when moving windows).<br>14130@1571988483.402017:audio_timer_st=
art interval 10 ms<br>But the icons on the desktop also disappear.<br><br>W=
hen running Mac OS X 10.X and clicking some system sounds, I see: <br>12134=
@1571818709.446031:audio_timer_start interval 10 ms<br>12134@1571818710.195=
023:audio_timer_stop <br>12134@1571818714.951030:audio_timer_start interval=
 10 ms<br>12134@1571818715.432959:audio_timer_stop <br>12134@1571818717.171=
045:audio_timer_start interval 10 ms<br>12134@1571818717.714323:audio_timer=
_stop <br>12134@1571818718.072381:audio_timer_start interval 10 ms<br>12134=
@1571818719.114544:audio_timer_stop <br><br>After randomly clicking some sy=
stem sounds more, the timer starts delaying and no longer stops:<br>12134@1=
571818893.564793:audio_timer_stop <br>12134@1571818895.698040:audio_timer_s=
tart interval 10 ms<br>12134@1571818899.961673:audio_timer_delayed interval=
 15 ms<br>12134@1571818900.472716:audio_timer_delayed interval 15 ms<br>121=
34@1571818902.759007:audio_timer_delayed interval 15 ms<br>12134@1571818905=
.803400:audio_timer_delayed interval 15 ms<br>But the systems stays respons=
ive, so can be shut down.<br><br>Windows specific.<br>Invocation:<br>qemu-s=
ystem-ppc.exe -L pc-bios -boot c -M mac99 -m 512 ^<br>-drive file=3DC:\Mac-=
disks\9.2.img,format=3Draw,media=3Ddisk ^<br>-serial stdio -sdl -device usb=
-audio -trace &quot;*aud*&quot;<br><br>This immediately starts logging the =
audio_timer_start interval and never stops.<br>Icons disappear from the des=
ktop after some seconds.<br><br>When running Mac OS X 10.X, playing just tw=
o system sounds results in:<br>2380@1571822566.040790:audio_timer_start int=
erval 10 ms<br>2380@1571822566.108279:audio_timer_delayed interval 22 ms<br=
>2380@1571822566.128820:audio_timer_delayed interval 20 ms<br>2380@15718225=
66.150509:audio_timer_delayed interval 22 ms<br>2380@1571822566.172112:audi=
o_timer_delayed interval 21 ms<br>......<br>2380@1571822566.561345:audio_ti=
mer_delayed interval 21 ms<br>2380@1571822566.583846:audio_timer_delayed in=
terval 22 ms<br>2380@1571822566.600482:audio_timer_delayed interval 15 ms<b=
r>2380@1571822566.610111:audio_timer_stop<br>2380@1571822572.226433:audio_t=
imer_start interval 10 ms<br>2380@1571822572.250866:audio_timer_delayed int=
erval 24 ms<br>2380@1571822572.269819:audio_timer_delayed interval 18 ms<br=
>......<br>2380@1571822572.452403:audio_timer_delayed interval 20 ms<br>238=
0@1571822572.474190:audio_timer_delayed interval 21 ms<br>2380@1571822572.5=
09474:audio_timer_delayed interval 35 ms<br>dsound: Could not lock playback=
 buffer<br>dsound: Reason: An invalid parameter was passed to the returning=
 function<br>dsound: Failed to lock buffer<br>2380@1571822572.560505:audio_=
timer_delayed interval 51 ms<br>2380@1571822572.581102:audio_timer_delayed =
interval 19 ms<br>2380@1571822572.600912:audio_timer_delayed interval 19 ms=
<br><br>There is no saying when audio_timer_delayed will start displaying c=
onstantly. <br>Only when one set of: <br>2260@1571823472.652244:audio_timer=
_start interval 10 ms<br>2260@1571823473.198349:audio_timer_stop<br>Is foll=
owing directly after each other, sound is played somewhat correctly.<br>Aft=
er randomly clicking several system sounds, the audio_timer_delayed message=
 never stops.<br><br>Thanks for looking into this. <br>If there is any addi=
tional information needed, or disk images of Mac OS 9.2 or OS X 10.3 are re=
quired, please let me know.<br><br>Best,<br><div>Howard <br></div><div><br>=
</div><div>ps: thanks to Zoltan for pointing out I sent the original messag=
e into an earlier thread ;-)<br></div></div>

--000000000000fc36a20595bc2185--

