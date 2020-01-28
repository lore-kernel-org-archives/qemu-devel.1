Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B42FBC33CB3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 09:39:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D85620CC7
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 09:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLKu5F4z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D85620CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwNLB-0001Oa-Lz
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 04:39:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35741)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <hsp.cat7@gmail.com>) id 1iwNKZ-0000xV-8t
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 04:38:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hsp.cat7@gmail.com>) id 1iwNKX-00052p-QZ
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 04:38:47 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:40508)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <hsp.cat7@gmail.com>) id 1iwNKX-00051A-Kf
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 04:38:45 -0500
Received: by mail-oi1-x241.google.com with SMTP id a142so8103928oii.7
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 01:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yypFtVdgYVvJDeXSDzZ5zPPb8iQ639GBhk4/wgnp/U8=;
 b=hLKu5F4z1sLV3Ps7b3ugT71kwsfb7HdJcm2krBEW+m6eOU1d6+biu1zK8bImLr51yx
 B+Dnw+Mes8N6uFpFQh+qsMRK7n8lrc8tQWfiz0o1Oj/01+ajS8vu0BXQarBlY42gHn9Q
 Sv5zOQuocVjWzgvtfAArIC2NPIhgpiWaYQgOQYJeipXFoA5T/6BCl3Te27GlEl9+0fNX
 xgKGI21UdFfM3dhb1i2okVzTEsHGBc23UZLvYPVHe7yXjZEQHHAC9h06aMtVoPkJCTfU
 8jPVYmP040KEI/MIiI1KGampD+XOAn/5D0ehOlzLqNdZ1PZh4neOavQQIidwH3IJuPib
 pOOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yypFtVdgYVvJDeXSDzZ5zPPb8iQ639GBhk4/wgnp/U8=;
 b=RuSzpYU+rmyhFzeCG03gnIfEUSAFxJI9XUONglLAQ+nRwscmKY8CuW7BEJuEXyDcsR
 j0bCrxKkhe18bqQeoeSgpeF3mXCgDE52GCe1cYpI2b6wsvUkk7ErSDWTQ9It52kbsYpS
 34MkilpZJHIczazf+41a8C4Dss4jKS/hvuu3mwb6D+v4mM8Ss02nswFvgt14UuBNF1Di
 jRG44IsI7HVhoRm3dzOcdNwgfb/GkaMZ4qAbDNtdynXNvaH3DEdIMot0KUvkQWVDL/J5
 UuG4z3n8tAOuW7bw5RpaE0OEIkyMQyU4yiPqtdajAuxRU2idoxI1WnuH/0XbNRJ+EpBe
 tGNg==
X-Gm-Message-State: APjAAAWVa4NYIpOZpIyro4U7wSUENCFsAJUx90axUztwgSEOnwqZTEnf
 k98gLAXS7e51OajBoS2ufSt9s0aL2vPowU3CZzg=
X-Google-Smtp-Source: APXvYqyq1dknx9d6iHSpa7kv+OzYxaU9Kxu+FoC6ibU7pLvVgS+ovW2YZfHGtPdoDZ/Fyo+V5xXtNHbVWBSAwSHxaoA=
X-Received: by 2002:aca:2407:: with SMTP id n7mr2294181oic.14.1580204324390;
 Tue, 28 Jan 2020 01:38:44 -0800 (PST)
MIME-Version: 1.0
References: <43D423C6-78D4-4DCE-B97C-0658D3D2E3BD@gmail.com>
 <4021690b-2380-3925-209e-d4cc66928773@gmail.com>
 <5314e860-dffe-3bc0-209f-bd2b937cd0c6@t-online.de>
In-Reply-To: <5314e860-dffe-3bc0-209f-bd2b937cd0c6@t-online.de>
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Tue, 28 Jan 2020 10:38:33 +0100
Message-ID: <CABLmASGcUVyASudNizcgPshEqahwYt-4m9Z1DXEhVe2vdko9cQ@mail.gmail.com>
Subject: Re: [PATCH v2] Implement the Screamer sound chip for the mac99
 machine type
To: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
Content-Type: multipart/alternative; boundary="0000000000006d8a5f059d2ffd36"
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
Cc: Programmingkid <programmingkidx@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu Developers <qemu-devel@nongnu.org>,
 =?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?= <dirty.ice.hu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000006d8a5f059d2ffd36
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2020 at 9:30 AM Volker R=C3=BCmelin <vr_qemu@t-online.de> w=
rote:

> > Hi,
> >
> > Unfortunately it's not that simple to simply revert the patch since the
> old backend api no longer exists.  Also I don't have a Mac so it's almost
> impossible for me to test the results.  I looked at the specified commit
> and I think I found a problem, could you please apply the attached patch =
on
> the current git master and check whether it solves the problem?  If yes
> I'll turn it into a proper patch.
> >
> > Regards,
> > Zoltan
> >
>
> Hi Zolt=C3=A1n,
>
> I also don't have a Mac so I tested your patch with a slightly modified
> sdlaudio version. I found two bugs in your patch. With the bugs fixed I
> have working SDL2 audio playback with float type samples. Now I wonder if
> the fixed patch also fixes coreaudio playback. Depending on how busy you
> are I can just write a review for your patch and let you handle the rest,
> or may I send a modified version of your patch to the mailing list for
> testing?
>
> With best regards
> Volker
>

Hi Volker,

I can test for coreaudio. Can you let us know exactly what you fixed in the
patch?
While cross compiling for windows, I saw these errors (besides some casting
issues):
line 56: buffer2  (should be *buffer2?)
line 455: ret  (should be ret2?)

audio/dsoundaudio.c:56:20: error: variable or field 'buffer2' declared void
   56 |     void *buffer1, buffer2;
      |                    ^~~~~~~
audio/dsoundaudio.c: In function 'dsound_get_buffer_out':
audio/dsoundaudio.c:428:18: error: returning 'int' from a function with
return type 'void *' makes pointer from integer without a cast
[-Werror=3Dint-conversion]
  428 |         return ds->buffer2;
      |                ~~^~~~~~~~~
audio/dsoundaudio.c:451:17: error: assignment to 'int' from 'void *' makes
integer from pointer without a cast [-Werror=3Dint-conversion]
  451 |     ds->buffer2 =3D ret2;
      |                 ^
audio/dsoundaudio.c:455:12: error: 'ret' undeclared (first use in this
function); did you mean 'ret2'?
  455 |     return ret;
      |            ^~~
      |            ret2
audio/dsoundaudio.c:455:12: note: each undeclared identifier is reported
only once for each function it appears in
audio/dsoundaudio.c: In function 'dsound_put_buffer_out':
audio/dsoundaudio.c:471:49: error: passing argument 3 of
'dsound_unlock_out' makes pointer from integer without a cast
[-Werror=3Dint-conversion]
  471 |     err =3D dsound_unlock_out(dsb, ds->buffer1, ds->buffer2,
ds->size1, ds->size2);
      |                                               ~~^~~~~~~~~
      |                                                 |
      |                                                 int
In file included from audio/dsoundaudio.c:267:
audio/dsound_template.h:49:12: note: expected 'LPVOID' {aka 'void *'} but
argument is of type 'int'
   49 |     LPVOID p2,
      |     ~~~~~~~^~
audio/dsoundaudio.c: In function 'dsound_get_buffer_out':
audio/dsoundaudio.c:456:1: error: control reaches end of non-void function
[-Werror=3Dreturn-type]
  456 | }
      | ^
cc1: all warnings being treated as errors

Best,
Howard

--0000000000006d8a5f059d2ffd36
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jan 28, 2020 at 9:30 AM Volke=
r R=C3=BCmelin &lt;<a href=3D"mailto:vr_qemu@t-online.de" target=3D"_blank"=
>vr_qemu@t-online.de</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">&gt; Hi,<br>
&gt;<br>
&gt; Unfortunately it&#39;s not that simple to simply revert the patch sinc=
e the old backend api no longer exists.=C2=A0 Also I don&#39;t have a Mac s=
o it&#39;s almost impossible for me to test the results.=C2=A0 I looked at =
the specified commit and I think I found a problem, could you please apply =
the attached patch on the current git master and check whether it solves th=
e problem?=C2=A0 If yes I&#39;ll turn it into a proper patch.<br>
&gt;<br>
&gt; Regards,<br>
&gt; Zoltan<br>
&gt;<br>
<br>
Hi Zolt=C3=A1n,<br>
<br>
I also don&#39;t have a Mac so I tested your patch with a slightly modified=
 sdlaudio version. I found two bugs in your patch. With the bugs fixed I ha=
ve working SDL2 audio playback with float type samples. Now I wonder if the=
 fixed patch also fixes coreaudio playback. Depending on how busy you are I=
 can just write a review for your patch and let you handle the rest, or may=
 I send a modified version of your patch to the mailing list for testing?<b=
r>
<br>
With best regards<br>
Volker<br></blockquote><div><br></div><div>Hi Volker,</div><div><br></div><=
div>I can test for coreaudio. Can you let us know exactly what you fixed in=
 the patch?</div><div>While cross compiling for windows, I saw these errors=
 (besides some casting issues):</div><div>line 56: buffer2=C2=A0 (should be=
 *buffer2?)</div><div>line 455: ret=C2=A0 (should be ret2?)</div><div><br><=
/div><div>audio/dsoundaudio.c:56:20: error: variable or field &#39;buffer2&=
#39; declared void<br>=C2=A0 =C2=A056 | =C2=A0 =C2=A0 void *buffer1, buffer=
2;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~~<br>audio/dsoundaudio.c: In function &#39;ds=
ound_get_buffer_out&#39;:<br>audio/dsoundaudio.c:428:18: error: returning &=
#39;int&#39; from a function with return type &#39;void *&#39; makes pointe=
r from integer without a cast [-Werror=3Dint-conversion]<br>=C2=A0 428 | =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ds-&gt;buffer2;<br>=C2=A0 =C2=A0 =C2=A0 =
| =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0~~^~~~~~~~~<br>aud=
io/dsoundaudio.c:451:17: error: assignment to &#39;int&#39; from &#39;void =
*&#39; makes integer from pointer without a cast [-Werror=3Dint-conversion]=
<br>=C2=A0 451 | =C2=A0 =C2=A0 ds-&gt;buffer2 =3D ret2;<br>=C2=A0 =C2=A0 =
=C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^<br>audio=
/dsoundaudio.c:455:12: error: &#39;ret&#39; undeclared (first use in this f=
unction); did you mean &#39;ret2&#39;?<br>=C2=A0 455 | =C2=A0 =C2=A0 return=
 ret;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~=
~<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret2<b=
r>audio/dsoundaudio.c:455:12: note: each undeclared identifier is reported =
only once for each function it appears in<br>audio/dsoundaudio.c: In functi=
on &#39;dsound_put_buffer_out&#39;:<br>audio/dsoundaudio.c:471:49: error: p=
assing argument 3 of &#39;dsound_unlock_out&#39; makes pointer from integer=
 without a cast [-Werror=3Dint-conversion]<br>=C2=A0 471 | =C2=A0 =C2=A0 er=
r =3D dsound_unlock_out(dsb, ds-&gt;buffer1, ds-&gt;buffer2, ds-&gt;size1, =
ds-&gt;size2);<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~~^~~~~~~~~<br>=C2=A0 =
=C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 int<br>In file included from audio/dsoundaudio.c:267:<br>audio/d=
sound_template.h:49:12: note: expected &#39;LPVOID&#39; {aka &#39;void *&#3=
9;} but argument is of type &#39;int&#39;<br>=C2=A0 =C2=A049 | =C2=A0 =C2=
=A0 LPVOID p2,<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 ~~~~~~~^~<br>audio/d=
soundaudio.c: In function &#39;dsound_get_buffer_out&#39;:<br>audio/dsounda=
udio.c:456:1: error: control reaches end of non-void function [-Werror=3Dre=
turn-type]<br>=C2=A0 456 | }<br>=C2=A0 =C2=A0 =C2=A0 | ^<br>cc1: all warnin=
gs being treated as errors<br></div><div><br></div><div>Best,</div><div>How=
ard<br></div><div><br></div><div>=C2=A0</div></div></div>

--0000000000006d8a5f059d2ffd36--

