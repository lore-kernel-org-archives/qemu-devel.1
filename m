Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF61CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:58:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEB622070B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EnAQrqAp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEB622070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNuUM-0000cJ-2q
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 03:58:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42873)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <hsp.cat7@gmail.com>) id 1iNuCn-000850-Jn
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 03:40:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hsp.cat7@gmail.com>) id 1iNuCk-0001iB-1T
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 03:40:17 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233]:46081)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <hsp.cat7@gmail.com>) id 1iNuCj-0001ha-Pw
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 03:40:13 -0400
Received: by mail-oi1-x233.google.com with SMTP id c2so886192oic.13
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 00:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=3ozBoP7CEMvrj+cVpbGJkU7+pULv9a+iNtdaHFD7mzY=;
 b=EnAQrqApbsNnr1hPryqX8VYbX0PfAk8d/BoRLbJo+bTAorqeGEvGRkwJ5Vb7w1WaF/
 MXiSN2bpfvu1MczBsF+qtzqr9FvbEmehPu66KA1WvEC+gHORydDnp07HtvCKDBGqBBNH
 wAKYwtpUM9VJSxZIMMoQTg/RqGmw2tOYMgYYuvYsnkcs5T8lMwLHZ4hO7zEw+9X24Kd/
 WTW0Il1F1IAgJuS7g/0f0PtMLO3sp2yONUF7NJhZi1a3nlVhMKPS5FMKwKpkUGuR/tIm
 TEeN7qxC08su3ZlFXlQcchX4ZjdEsM1EUIBmGVaCxUOMSEd5J17mJkaPFfCB2jFYEi3Z
 ZpKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=3ozBoP7CEMvrj+cVpbGJkU7+pULv9a+iNtdaHFD7mzY=;
 b=RsjZlpCfDrkWHqsGriY+Yg+RChuqoTq5hPcYGKsTNs2/TIPIMWnIgXpkVniJjGB/VT
 uNQbpZQpOsKD1phaPPWDjqmOL2SbjDVU2ltRl7Qf7wiNHRys5a2o7t5K2buIq+HddWBi
 Or2wmGEUc5IxMAC/vc9Ma5VpD1GxTfhtzSmS2W0NjN2Vr2RK+MvYITvJ1XYlJS8HOHhN
 F4AqwAzx3JggRvU9HqqUTMZ0MTrLkqMgHaRmD7q1VWpv33B86Vq0vrv1MTOhIwqfSiHD
 dq2gmd2fyI2tjWln9xiHy+79XmLa/uhwZYonDRqGipTY+OnE6thBsn1vOJOEpIw5XLPZ
 ux2A==
X-Gm-Message-State: APjAAAXpKnPldS9QJa13chw4XzaY9O/m1/E2tiXACz8OSRalRwCbE/+e
 pxgL7a3lj5ySdzcABCwdg/PRcBqJZoNDjZo4/KzYXgbK
X-Google-Smtp-Source: APXvYqyq31wuSsJXb6/CAz7UUa60YRW+0s3vzsTHR21W4MV6CPN3Gh9HJ0KLywX2JTEPqOBRRBBxXzWymgUbxF7je/Q=
X-Received: by 2002:aca:fc11:: with SMTP id a17mr1749664oii.59.1571989211279; 
 Fri, 25 Oct 2019 00:40:11 -0700 (PDT)
MIME-Version: 1.0
References: <20191025063713.23374-1-alex.bennee@linaro.org>
 <20191025063713.23374-47-alex.bennee@linaro.org>
In-Reply-To: <20191025063713.23374-47-alex.bennee@linaro.org>
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Fri, 25 Oct 2019 09:40:00 +0200
Message-ID: <CABLmASH=xHu+JZT34kX0cC3N6YsYqan3mzT7b7g1RgWz8nFrYw@mail.gmail.com>
Subject: USB-audio sound issues with qemu-system-ppc in Linux and Windows.
To: qemu-devel qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000008775810595b742c7"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::233
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

--0000000000008775810595b742c7
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

--0000000000008775810595b742c7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,<br><br>I&#39;m =C2=A0experiencing sev=
eral issues related to sound using usb-audio when running qemu-system-ppc i=
n Linux and Windows. Guests tried are Mac OS 9.2 and Mac OS X 10.0, 10.1, 1=
0.2 and 10.3. <br>(10.4 and 10.5 never have the usb-audio device available =
for audio playback, even though the device is recognised in the OS X system=
 profiler.)<br>It is hit and miss whether the audio device is actually avai=
lable upon boot in 9.2 and the other versions of OS X.<br><br>Qemu version =
tried is current master (Oct 25th), Windows version is cross-compiled from =
Fedora 30. I do not think there is any regression going on here, these are =
just issues that have been present for a long time.<br><br>General issue: w=
hen audio is played, it almost always sounds crackling.<br><br>For reasons =
of size, I uploaded 3 logs obtained in Linux running Mac OS X 10.3 with -tr=
ace &quot;usb*&quot; to: <a href=3D"https://surfdrive.surf.nl/files/index.p=
hp/s/YfVVxEE3cHXkFPf/download">https://surfdrive.surf.nl/files/index.php/s/=
YfVVxEE3cHXkFPf/download</a><br>1. Log_no_audio_available.txt<br>2. Log_aud=
io_available_2_sounds_played.txt<br>3. Log_audio_available_multi_sounds_pla=
yed_untill_hangup.txt<br><br>General issue in Linux (fedora 30)(which seems=
 related to bug <a href=3D"https://bugs.launchpad.net/qemu/+bug/1623998">ht=
tps://bugs.launchpad.net/qemu/+bug/1623998</a>):<br>[hsp@fedora30 qemu-mast=
er]$ ./startqemu.sh<br>pulseaudio: set_sink_input_volume() failed<br>pulsea=
udio: Reason: Invalid argument<br>pulseaudio: set_sink_input_mute() failed<=
br>pulseaudio: Reason: Invalid argument<br><br>General issue in Windows 10:=
 I always get to a point where this is logged:<br>dsound: Could not lock pl=
ayback buffer<br>dsound: Reason: An invalid parameter was passed to the ret=
urning function<br>dsound: Failed to lock buffer<br><br>Linux specific.<br>=
Qemu invocation for Mac OS 9.2:<br>./qemu-system-ppc -L pc-bios -boot c -M =
mac99 -m 512 \<br>-drive file=3D~/Mac-disks/9.2.img,format=3Draw,media=3Ddi=
sk \<br>-serial stdio -sdl -device usb-audio -trace &quot;*aud*&quot;<br><b=
r>This immediately starts logging:<br>7380@1571817102.833929:audio_timer_st=
art interval 10 ms<br>7380@1571817125.207880:audio_timer_delayed interval 1=
6 ms<br>7380@1571817129.046816:audio_timer_delayed interval 16 ms<br><br>An=
y movement of a window on the Linux desktop results in additional audio_tim=
er_delayed logging. <br>The audio_timer_delayed never stops.<br>In Mac OS 9=
.2, the desktop icons disappear after some seconds of running, so the syste=
m cannot be stopped normally.<br>Running the GTK GUI, only this is logged (=
no additional logging when moving windows).<br>14130@1571988483.402017:audi=
o_timer_start interval 10 ms<br>But the icons on the desktop also disappear=
.<br><br>When running Mac OS X 10.X and clicking some system sounds, I see:=
 <br>12134@1571818709.446031:audio_timer_start interval 10 ms<br>12134@1571=
818710.195023:audio_timer_stop <br>12134@1571818714.951030:audio_timer_star=
t interval 10 ms<br>12134@1571818715.432959:audio_timer_stop <br>12134@1571=
818717.171045:audio_timer_start interval 10 ms<br>12134@1571818717.714323:a=
udio_timer_stop <br>12134@1571818718.072381:audio_timer_start interval 10 m=
s<br>12134@1571818719.114544:audio_timer_stop <br><br>After randomly clicki=
ng some system sounds more, the timer starts delaying and no longer stops:<=
br>12134@1571818893.564793:audio_timer_stop <br>12134@1571818895.698040:aud=
io_timer_start interval 10 ms<br>12134@1571818899.961673:audio_timer_delaye=
d interval 15 ms<br>12134@1571818900.472716:audio_timer_delayed interval 15=
 ms<br>12134@1571818902.759007:audio_timer_delayed interval 15 ms<br>12134@=
1571818905.803400:audio_timer_delayed interval 15 ms<br>But the systems sta=
ys responsive, so can be shut down.<br><br>Windows specific.<br>Invocation:=
<br>qemu-system-ppc.exe -L pc-bios -boot c -M mac99 -m 512 ^<br>-drive file=
=3DC:\Mac-disks\9.2.img,format=3Draw,media=3Ddisk ^<br>-serial stdio -sdl -=
device usb-audio -trace &quot;*aud*&quot;<br><br>This immediately starts lo=
gging the audio_timer_start interval and never stops.<br>Icons disappear fr=
om the desktop after some seconds.<br><br>When running Mac OS X 10.X, playi=
ng just two system sounds results in:<br>2380@1571822566.040790:audio_timer=
_start interval 10 ms<br>2380@1571822566.108279:audio_timer_delayed interva=
l 22 ms<br>2380@1571822566.128820:audio_timer_delayed interval 20 ms<br>238=
0@1571822566.150509:audio_timer_delayed interval 22 ms<br>2380@1571822566.1=
72112:audio_timer_delayed interval 21 ms<br>......<br>2380@1571822566.56134=
5:audio_timer_delayed interval 21 ms<br>2380@1571822566.583846:audio_timer_=
delayed interval 22 ms<br>2380@1571822566.600482:audio_timer_delayed interv=
al 15 ms<br>2380@1571822566.610111:audio_timer_stop<br>2380@1571822572.2264=
33:audio_timer_start interval 10 ms<br>2380@1571822572.250866:audio_timer_d=
elayed interval 24 ms<br>2380@1571822572.269819:audio_timer_delayed interva=
l 18 ms<br>......<br>2380@1571822572.452403:audio_timer_delayed interval 20=
 ms<br>2380@1571822572.474190:audio_timer_delayed interval 21 ms<br>2380@15=
71822572.509474:audio_timer_delayed interval 35 ms<br>dsound: Could not loc=
k playback buffer<br>dsound: Reason: An invalid parameter was passed to the=
 returning function<br>dsound: Failed to lock buffer<br>2380@1571822572.560=
505:audio_timer_delayed interval 51 ms<br>2380@1571822572.581102:audio_time=
r_delayed interval 19 ms<br>2380@1571822572.600912:audio_timer_delayed inte=
rval 19 ms<br><br>There is no saying when audio_timer_delayed will start di=
splaying constantly. <br>Only when one set of: <br>2260@1571823472.652244:a=
udio_timer_start interval 10 ms<br>2260@1571823473.198349:audio_timer_stop<=
br>Is following directly after each other, sound is played somewhat correct=
ly.<br>After randomly clicking several system sounds, the audio_timer_delay=
ed message never stops.<br><br>Thanks for looking into this. <br>If there i=
s any additional information needed, or disk images of Mac OS 9.2 or OS X 1=
0.3 are required, please let me know.<br><br>Best,<br>Howard</div></div>

--0000000000008775810595b742c7--

