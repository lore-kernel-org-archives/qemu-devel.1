Return-Path: <SRS0=8j4I=3W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A863C35249
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 18:17:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAD7920658
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 18:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxrRwvcl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAD7920658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyJoa-0006pv-Qb
	for qemu-devel@archiver.kernel.org; Sun, 02 Feb 2020 13:17:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47242)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <hsp.cat7@gmail.com>) id 1iyJnx-0006Qz-UP
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 13:17:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hsp.cat7@gmail.com>) id 1iyJnw-0005VE-Lb
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 13:17:09 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:36684)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <hsp.cat7@gmail.com>) id 1iyJnw-0005UP-Em
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 13:17:08 -0500
Received: by mail-ot1-x344.google.com with SMTP id j20so3039959otq.3
 for <qemu-devel@nongnu.org>; Sun, 02 Feb 2020 10:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Zx9TYA7gRlxRnb+a1ZJJPV6+asReS6BX/OS/2zUzVvg=;
 b=bxrRwvclCY6vjgYtWLcKyZUTQUQZRoYjF4W0+enlei8ob7GYpgSBGZMbrSxtR7KiLY
 vLJsSIcqfHnkk73Ddxe+PmwI24wFhmgN89eBbcISHg6YoY+UN/Ra1mQyBm7rdYrnmyIK
 6DFHwClbwUbDblnML6OzIcaNfTPakI64BnK0yTHQZcl5OPkOZb0x+T9RUlQk70mxRxRn
 55jI4OiY4Z0vDs6mKvmZzL/+wa3SHM3FaalW73eqp5iW0tqEXpeyNjMBRfiVFwCq4MWe
 wfaswfl2Vx32rSsLxm2IOu+1q9nogeuzOANS9oaxlsNiDMHWuS+44zERbO68A5vZCWVr
 lLNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Zx9TYA7gRlxRnb+a1ZJJPV6+asReS6BX/OS/2zUzVvg=;
 b=eOjEJdPilNwdSWSzfrsq1qUcboAaED3TT1Xvnl04YpIVuHkqoBQrS3wDVvNn5jU0Lx
 eAOKMzNKxs/Ok3TbX+xo0gZjIv5jKDur5T00wp6np3mqsZzeNyMjHUQrmOj1y7tRcq7p
 DGEFOd6uYXO6345fRn9c4/Ef+WuJZylKxU/IizBx8IGd32fHmTEVGvPcZinJwfra3gFZ
 ZXC17xkL4pOvJ3N3jfAu8HEdTL1402dqFvQHi9qHBUGQfUpBkNdHLJbd4+6UNCcZpj4a
 gCOL0VpxFqf3cfEokXBW5MVOnuhZ9OM6wY+Qpo1S8weMzmb/fJtgchX58Z0PZYjViOdW
 6luQ==
X-Gm-Message-State: APjAAAVEnBp0QA8kQRNaYuSKqQuuQdMt4ck86fZikPROZTjJdPTIgv3u
 19BQOgsf/Vl1kcjJlsRv+3dXt+bEFrAQx8XBSCQ=
X-Google-Smtp-Source: APXvYqx9Q6dUA02g/FWq1q3t/PDoC9PmlPMytotN7fq3ekpRKrw0xbcS+xkC7fZWqt7/kF3kUkJdvXjoB5vv4P9ePLM=
X-Received: by 2002:a9d:22:: with SMTP id 31mr14384203ota.173.1580667427510;
 Sun, 02 Feb 2020 10:17:07 -0800 (PST)
MIME-Version: 1.0
References: <30c8b9e6-484c-5785-b178-bef01628db49@t-online.de>
In-Reply-To: <30c8b9e6-484c-5785-b178-bef01628db49@t-online.de>
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Sun, 2 Feb 2020 19:16:56 +0100
Message-ID: <CABLmASH07iyCdGaWzX5CpYSm0BA-Ww5F3-uOeUduiTLDuKRPjw@mail.gmail.com>
Subject: Re: [PATCH 0/1] coreaudio: fix coreaudio playback
To: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
Content-Type: multipart/alternative; boundary="000000000000865d9b059d9bd06c"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: qemu Developers <qemu-devel@nongnu.org>,
 Programmingkid <programmingkidx@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?= <dirty.ice.hu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000865d9b059d9bd06c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 2, 2020 at 3:03 PM Volker R=C3=BCmelin <vr_qemu@t-online.de> wr=
ote:

> Hi,
>
> here is a new patch for the CoreAudio playback problem. This patch
> is Zolt=C3=A1n's patch from
> https://lists.nongnu.org/archive/html/qemu-devel/2020-01/msg02142.html
> and a improved version of my patch squashed together.
>
> I actually tested the changes in audio/audio_template.h,
> audio/mixeng.c and audio/mixeng.h with all useful permutations of
> FLOAT_MIXENG and RECIPROCAL defined/undefined.
>
> @Howard and John
> Can you please test this patch? Compared to the patches you tested
> this patch is quite different.
>
> @John
> 'git am exported_mail.eml' knows how to handle
> Content-Transfer-Encoding: in a mail file. It's not necessary to
> apply this patch by hand.
>
> Volker R=C3=BCmelin (1):
>   coreaudio: fix coreaudio playback
>
>  audio/audio_template.h |  7 +++++++
>  audio/coreaudio.c      | 32 +++++++++-----------------------
>  audio/mixeng.c         | 48
> ++++++++++++++++++++++++++++++++++++++++++++++++
>  audio/mixeng.h         |  5 +++++
>  4 files changed, 69 insertions(+), 23 deletions(-)
>
> --
> 2.16.4
>
> Hi,

This patch restores coreaudio for me.
I applied the patch on top of https://github.com/mcayland/qemu/tree/screame=
r
to test audio support in qemu-system-ppc running Mac OS 9.2 and OSX 10.5.
Host is OSX Sierra.

Thanks,
Howard

--000000000000865d9b059d9bd06c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sun, Feb 2, 2020 at 3:03 PM Volker=
 R=C3=BCmelin &lt;<a href=3D"mailto:vr_qemu@t-online.de">vr_qemu@t-online.d=
e</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>Hi,<br>
<br>
here is a new patch for the CoreAudio playback problem. This patch<br>
is Zolt=C3=A1n&#39;s patch from<br>
<a href=3D"https://lists.nongnu.org/archive/html/qemu-devel/2020-01/msg0214=
2.html" rel=3D"noreferrer" target=3D"_blank">https://lists.nongnu.org/archi=
ve/html/qemu-devel/2020-01/msg02142.html</a><br>
and a improved version of my patch squashed together.<br>
<br>
I actually tested the changes in audio/audio_template.h,<br>
audio/mixeng.c and audio/mixeng.h with all useful permutations of<br>
FLOAT_MIXENG and RECIPROCAL defined/undefined.<br>
<br>
@Howard and John<br>
Can you please test this patch? Compared to the patches you tested<br>
this patch is quite different.<br>
<br>
@John<br>
&#39;git am exported_mail.eml&#39; knows how to handle<br>
Content-Transfer-Encoding: in a mail file. It&#39;s not necessary to<br>
apply this patch by hand.<br>
<br>
Volker R=C3=BCmelin (1):<br>
=C2=A0 coreaudio: fix coreaudio playback<br>
<br>
=C2=A0audio/audio_template.h |=C2=A0 7 +++++++<br>
=C2=A0audio/coreaudio.c=C2=A0 =C2=A0 =C2=A0 | 32 +++++++++-----------------=
------<br>
=C2=A0audio/mixeng.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 48 ++++++++++++++++=
++++++++++++++++++++++++++++++++<br>
=C2=A0audio/mixeng.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 5 +++++<br>
=C2=A04 files changed, 69 insertions(+), 23 deletions(-)<br>
<br>
-- <br>
2.16.4<br>
<br></blockquote><div>Hi,</div><div><br></div><div>This patch restores core=
audio for me.</div><div>I applied the patch on top of <a href=3D"https://gi=
thub.com/mcayland/qemu/tree/screamer">https://github.com/mcayland/qemu/tree=
/screamer</a> to test audio support in qemu-system-ppc running Mac OS 9.2 a=
nd OSX 10.5. Host is OSX Sierra. <br></div><div><br></div><div>Thanks,</div=
><div>Howard<br></div><div>=C2=A0</div></div></div>

--000000000000865d9b059d9bd06c--

