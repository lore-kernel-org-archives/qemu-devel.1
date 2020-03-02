Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF414C3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 23:31:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 776C524677
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 23:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hokUvzcy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 776C524677
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8uXV-0008Fm-NV
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 18:31:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35751)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <hsp.cat7@gmail.com>) id 1j8uWm-0007jE-Du
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 18:31:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hsp.cat7@gmail.com>) id 1j8uWl-0003Jg-1e
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 18:31:12 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:33258)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <hsp.cat7@gmail.com>) id 1j8uWk-0003Fk-QI
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 18:31:10 -0500
Received: by mail-ot1-x342.google.com with SMTP id a20so1191384otl.0
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 15:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4/hwPPxySr/Sg7prvUBxw8vzCIOTTkUQdkQZndiaTKc=;
 b=hokUvzcyxSjNEk58qzfneOdTPD6nKTjh4yxV/YCJsq8cEaar5AJJJzr9nXf+PriHFi
 yEFhddG2Vifs2GHFuS/2Aav14Kkn9uWn1M3odqle+JvRKyCRkaCzo7h/HfWo1QDPn/uz
 1IU+u+J764znsw04Ie5/un/s+DIcuj3PBdj6Ecbme4SYRGYv3FO7j6HTP4HiJpMJJkzb
 zIX6HtXYf0Y9EsGuaEfUMFGPbl/zOiUtvVl83qHMXl702kuhPJdDUKfHDyAQevW78Ja8
 ybA6r46+ZquC3BIUhzbBS0UEnC2kvG6K6A9cz16uSCKlpfOXf692uD18MXYGQF+rute6
 LCZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4/hwPPxySr/Sg7prvUBxw8vzCIOTTkUQdkQZndiaTKc=;
 b=rB0HSdu12LgrE1hGp9iNNH8tBV+UKrn0h/zYBloQHwYtIwAlisxNsqgjwPaHu9fzr0
 rgbZYfGcjQuq/tjEqh79ThUJ534E6PkkhNlB5tvxfe2Hygk3qaOeWxiKiyvxDTaCOQFI
 4SMcCu71ZOO2eApMJvKBQ0dZqGfugO+P0Bq1bfxah4CSlISsqfLgzfFlH+wtBue6WV84
 oV3X8OuKTat4Au7lVOc9K2y7DbcNUAjkXorP4VaNgvi6Lq7Im7+L4d20NOKCX4d8tN35
 SsOpw+rSDaF3wpxHVLb5mYosykA5md6k+y1sidUdVIjtewMCgVT6vfZOrmpHztGf1ecj
 0CJw==
X-Gm-Message-State: ANhLgQ1rQ49blDOqTXdTH/0nZQxCSPhKA5OdU/g4nU0MR/OpdBvw4qCE
 VbLg/oALDhqBhFYl7eA07o4lczl6/So10IwevJA=
X-Google-Smtp-Source: ADFU+vvoyvTvy6OPvoKe8xW4MjOB4APSaY/UDUqsbHSJuGSPLtsjfE1k5Q6Xhc3J1ircCJuBLhGFVrbxd0NY1wosMl4=
X-Received: by 2002:a05:6830:1e76:: with SMTP id
 m22mr1301624otr.295.1583191869704; 
 Mon, 02 Mar 2020 15:31:09 -0800 (PST)
MIME-Version: 1.0
References: <417bfe2f-e3c1-d83d-b437-47859daf524d@t-online.de>
In-Reply-To: <417bfe2f-e3c1-d83d-b437-47859daf524d@t-online.de>
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Tue, 3 Mar 2020 00:30:58 +0100
Message-ID: <CABLmASHxx+x6rDo-Vk_wwKrHoq2+10oyH49AeKnmJXdQJSJnGw@mail.gmail.com>
Subject: Re: [PATCH 0/5] mostly changes related to audio float samples
To: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
Content-Type: multipart/alternative; boundary="000000000000014fca059fe7952f"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 John Arbuckle <programmingkidx@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?= <dirty.ice.hu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000014fca059fe7952f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 2, 2020 at 8:08 PM Volker R=C3=BCmelin <vr_qemu@t-online.de> wr=
ote:

> Patch "audio: change naming scheme of FLOAT_CONV macros" and
> patch "audio: consistency changes" should have been a review
> for ed2a4a7941 "audio: proper support for float samples in
> mixeng", but I was too slow.
>
> Patch "audio: change mixing engine float range to [-1.f, 1.f]"
> definitely needs to be tested by macOS users. I verified
> PulseAudio, SDL2 and ALSA (actually libasound) work, but I
> don't want to introduce a regression for CoreAudio. I spent
> some time on https://developer.apple.com but I couldn't find
> the answer if CoreAudio uses the [-1.f, 1.f] range too. The
> results from my favorite search engine suggest the answer is
> yes.
>
> @Howard:
> I need your help once again. Can you please test if you can
> hear (or see) clipping with my patches? Don't forget to set all
> volume controls in the guest and on the host to 100% or 0dB to
> get a reliable result. Compared to qemu without these patches I
> expect the playback volume is a bit louder, but there's still
> no clipping.
>
> Volker R=C3=BCmelin (5):
>   qapi/audio: add documentation for AudioFormat
>   audio: change naming scheme of FLOAT_CONV macros
>   audio: consistency changes
>   audio: change mixing engine float range to [-1.f, 1.f]
>   audio: fix saturation nonlinearity in clip_* functions
>
>  audio/mixeng.c          | 26 +++++++++++++-------------
>  audio/mixeng_template.h | 22 ++++++++++------------
>  qapi/audio.json         | 14 ++++++++++++++
>  3 files changed, 37 insertions(+), 25 deletions(-)
>
> --
> 2.16.4
>
> Hi,

I applied these to Mark's screamer branch to create a new OSX build.
Testing was done by playing system sounds, and an MP3/Internet radio with
QuickTime/iTunes. With or without 6dB, the max volume is way out of my
comfort zone. I hear no real difference in quality compared to a build from
the current screamer branch. If any, it might sound a bit better. That
means there still is some minimal crackling (clipping?) in the high volume
parts of the audio I played with OSX guests, not Mac OS 9.x guests.

So as there is no regression,
tested by: howard spoelstra <hsp.cat7@gmail.com>

--000000000000014fca059fe7952f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Mar 2, 2020 at 8:08 PM Volker=
 R=C3=BCmelin &lt;<a href=3D"mailto:vr_qemu@t-online.de">vr_qemu@t-online.d=
e</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>Patch &quot;audio: change naming scheme of FLOAT_CONV macros&quot; and<br>
patch &quot;audio: consistency changes&quot; should have been a review<br>
for ed2a4a7941 &quot;audio: proper support for float samples in<br>
mixeng&quot;, but I was too slow.<br>
<br>
Patch &quot;audio: change mixing engine float range to [-1.f, 1.f]&quot;<br=
>
definitely needs to be tested by macOS users. I verified<br>
PulseAudio, SDL2 and ALSA (actually libasound) work, but I<br>
don&#39;t want to introduce a regression for CoreAudio. I spent<br>
some time on <a href=3D"https://developer.apple.com" rel=3D"noreferrer" tar=
get=3D"_blank">https://developer.apple.com</a> but I couldn&#39;t find<br>
the answer if CoreAudio uses the [-1.f, 1.f] range too. The<br>
results from my favorite search engine suggest the answer is<br>
yes.<br>
<br>
@Howard:<br>
I need your help once again. Can you please test if you can<br>
hear (or see) clipping with my patches? Don&#39;t forget to set all<br>
volume controls in the guest and on the host to 100% or 0dB to<br>
get a reliable result. Compared to qemu without these patches I<br>
expect the playback volume is a bit louder, but there&#39;s still<br>
no clipping.<br>
<br>
Volker R=C3=BCmelin (5):<br>
=C2=A0 qapi/audio: add documentation for AudioFormat<br>
=C2=A0 audio: change naming scheme of FLOAT_CONV macros<br>
=C2=A0 audio: consistency changes<br>
=C2=A0 audio: change mixing engine float range to [-1.f, 1.f]<br>
=C2=A0 audio: fix saturation nonlinearity in clip_* functions<br>
<br>
=C2=A0audio/mixeng.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 26 +++++++++++++--=
-----------<br>
=C2=A0audio/mixeng_template.h | 22 ++++++++++------------<br>
=C2=A0qapi/audio.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 14 ++++++++++++++<=
br>
=C2=A03 files changed, 37 insertions(+), 25 deletions(-)<br>
<br>
-- <br>
2.16.4<br>
<br></blockquote><div>Hi,</div><div><br></div><div>I applied these to Mark&=
#39;s screamer branch to create a new OSX build. Testing was done by playin=
g system sounds, and an MP3/Internet radio with QuickTime/iTunes. With or w=
ithout 6dB, the max volume is way out of my comfort zone. I hear no real di=
fference in quality compared to a build from the current screamer branch. I=
f any, it might sound a bit better. That means there still is some minimal =
crackling (clipping?) in the high volume parts of the audio I played with O=
SX guests, not Mac OS 9.x guests.=C2=A0=C2=A0</div><div><br></div><div>So a=
s there is no regression,<br></div><div>tested by: howard spoelstra &lt;<a =
href=3D"mailto:hsp.cat7@gmail.com">hsp.cat7@gmail.com</a>&gt;<br></div></di=
v></div>

--000000000000014fca059fe7952f--

