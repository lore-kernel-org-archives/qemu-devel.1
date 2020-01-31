Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2870C33CB2
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 09:13:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77E8B206F0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 09:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alrYKYhj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77E8B206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixSMQ-0006I6-N4
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 04:13:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59507)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <hsp.cat7@gmail.com>) id 1ixSLg-0005mw-3F
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 04:12:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hsp.cat7@gmail.com>) id 1ixSLd-0001lT-SC
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 04:12:24 -0500
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332]:44502)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <hsp.cat7@gmail.com>) id 1ixSLd-0001kS-Mu
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 04:12:21 -0500
Received: by mail-ot1-x332.google.com with SMTP id h9so5882493otj.11
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2020 01:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Gtmp+9El5j1vpeQ89AG2WyEPaniEMWe+8K1TWeVTLWc=;
 b=alrYKYhjTCAolmO7Cs0EvhylRXC/ocxB5JlYekdCQfHjFPRBcx10rMqvZVRGcGHPr6
 jOKQPA0kujEtZx/YWue73DtwC8YskR5V7HGo7YnOlDxSjF7tgRYdDh9ob7xx7M5brg5a
 qA3UwwZw5Td+WwbL48OClZL4anMaET2/y9GnQk+tVzAe7OccROzgKaQlUWu67niI1KUl
 2f41ANAE0zR361lbRZqSAeLEdamg1jbzhTbyftCzMj1wHVYesqZXg8AhC8KX2L8mIIY3
 +zYpjQpcVqlWza+S6lguVqCrhAQ+53jLRLg4ingE6dcg4Scikp3qV8PY/x/88Lr1DDsT
 rLPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Gtmp+9El5j1vpeQ89AG2WyEPaniEMWe+8K1TWeVTLWc=;
 b=OAziw2kaJ1IHxT4Yi5U5a05DB1qGrZJREZ+vMVd/7BkkL/I/cSAnWixYMcwX+Lre+g
 nIxhOAr2WMZpZeszzviSOAxfLuHIrs0JzUlx42o069UR1atQoGAs6MNapXdqXTHH6ZMK
 yUZjUJsYbQGtIwTIqjlLT8K+PiIwvtzdm6olsI5xrXVKKysEx3coFaGRUbL2VbZ+K2+c
 NUD+rIhJmfusKSSnS+IQUpel2WMCB4kOklo8jUs267nWgyVIYDgu7wJCHw3JTNCOi6GY
 jlqDKLgbmPRS9r0JZvKWrqvU/TPq6eK8Muax3+NNveL8GErUtvlG2JoEr/JD5/pXR7z0
 cYAw==
X-Gm-Message-State: APjAAAVB57RbrKZGuwxV34TDWvFasxnXY/597miDKnnorA2WRzvbpShf
 bJYvSh6e5cZ9xA7RNGWSHda/6FoZwr3LIr9hsRE=
X-Google-Smtp-Source: APXvYqxEBC+sTEeuCSjcq5DCjMVsDJbqknE2Q3N8U/1fbl8elVlv155FktMU3D5Rgyj0ioy696QrFgSR1E/qlpM4rTA=
X-Received: by 2002:a9d:831:: with SMTP id 46mr7087673oty.295.1580461940559;
 Fri, 31 Jan 2020 01:12:20 -0800 (PST)
MIME-Version: 1.0
References: <43D423C6-78D4-4DCE-B97C-0658D3D2E3BD@gmail.com>
 <4021690b-2380-3925-209e-d4cc66928773@gmail.com>
 <5314e860-dffe-3bc0-209f-bd2b937cd0c6@t-online.de>
 <CABLmASGcUVyASudNizcgPshEqahwYt-4m9Z1DXEhVe2vdko9cQ@mail.gmail.com>
 <54f5ddf3-5ea9-bd6d-8c71-edf4db527463@t-online.de>
 <f03b7ae9-344c-5a7f-414c-6250a9c5ec2f@t-online.de>
 <CABLmASGkSnG4+vfykBnEznX=kCAcSaiW20nf-wT9Cne4Cj9+LQ@mail.gmail.com>
 <3e4f565a-07d7-c1cc-b49c-0a8c504ae07c@t-online.de>
 <20200131080357.wyiof5grg2jtgot2@sirius.home.kraxel.org>
 <87db6b90-0f37-30a9-9934-57af7eaf02cb@ilande.co.uk>
In-Reply-To: <87db6b90-0f37-30a9-9934-57af7eaf02cb@ilande.co.uk>
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Fri, 31 Jan 2020 10:12:09 +0100
Message-ID: <CABLmASFB5t1ATS2fjngpu4H9YGqLa1e_m5iRj=4UGuufSgzUEg@mail.gmail.com>
Subject: Re: [RFC] coreaudio: fix coreaudio_test.diff
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Content-Type: multipart/alternative; boundary="0000000000008c52d2059d6bf8ea"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::332
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
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?= <dirty.ice.hu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000008c52d2059d6bf8ea
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 31, 2020 at 9:35 AM Mark Cave-Ayland <
mark.cave-ayland@ilande.co.uk> wrote:

> On 31/01/2020 08:03, Gerd Hoffmann wrote:
>
> >> Thank you for testing the two patches. I will wait a few days to see i=
f
> Zolt=C3=A1n wants to write a cleaned up patch. Otherwise I'll try to writ=
e a
> patch that's acceptable for submission.
> >
> > I'm busy collecting pending audio fixes for the next pull req,
> > planned to send out early next week.  Would be cool if I can
> > include a coreaudio fix ;)
> >
> > The RFC patch looks sane to me but it clearly needs a better
> > commit message.
> >
> > Current patch queue state:
> >   https://git.kraxel.org/cgit/qemu/log/?h=3Dqueue/audio
> >
> > If I missed something please resend.
>
> That would be great! One thing to note is that Volker's RFC patch applies
> on top of
> Zoltan's original diff from
> https://lists.nongnu.org/archive/html/qemu-devel/2020-01/msg02142.html
> rather than
> being standalone.
>
> If you take a look at my branch at
> https://github.com/mcayland/qemu/commits/for-cat7
> then it's just a case of squashing the top 2 commits and coming up with a
> suitable
> commit message.
>
>
> ATB,
>
> Mark.
>

Yes, lovely!

I just applied the dsound patch from KJ Liew on top of the for-cat7 branch.

https://lists.nongnu.org/archive/html/qemu-devel/2020-01/msg03805.html

While it will not apply directly (not finding the file to patch in the
source tree), it nevertheless gets rid of the dsound errors too.

Best,
Howard

--0000000000008c52d2059d6bf8ea
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jan 31, 2020 at 9:35 AM Mark =
Cave-Ayland &lt;<a href=3D"mailto:mark.cave-ayland@ilande.co.uk" target=3D"=
_blank">mark.cave-ayland@ilande.co.uk</a>&gt; wrote:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">On 31/01/2020 08:03, Gerd Hoffmann wro=
te:<br>
<br>
&gt;&gt; Thank you for testing the two patches. I will wait a few days to s=
ee if Zolt=C3=A1n wants to write a cleaned up patch. Otherwise I&#39;ll try=
 to write a patch that&#39;s acceptable for submission.<br>
&gt; <br>
&gt; I&#39;m busy collecting pending audio fixes for the next pull req,<br>
&gt; planned to send out early next week.=C2=A0 Would be cool if I can<br>
&gt; include a coreaudio fix ;)<br>
&gt; <br>
&gt; The RFC patch looks sane to me but it clearly needs a better<br>
&gt; commit message.<br>
&gt; <br>
&gt; Current patch queue state:<br>
&gt;=C2=A0 =C2=A0<a href=3D"https://git.kraxel.org/cgit/qemu/log/?h=3Dqueue=
/audio" rel=3D"noreferrer" target=3D"_blank">https://git.kraxel.org/cgit/qe=
mu/log/?h=3Dqueue/audio</a><br>
&gt; <br>
&gt; If I missed something please resend.<br>
<br>
That would be great! One thing to note is that Volker&#39;s RFC patch appli=
es on top of<br>
Zoltan&#39;s original diff from<br>
<a href=3D"https://lists.nongnu.org/archive/html/qemu-devel/2020-01/msg0214=
2.html" rel=3D"noreferrer" target=3D"_blank">https://lists.nongnu.org/archi=
ve/html/qemu-devel/2020-01/msg02142.html</a> rather than<br>
being standalone.<br>
<br>
If you take a look at my branch at <a href=3D"https://github.com/mcayland/q=
emu/commits/for-cat7" rel=3D"noreferrer" target=3D"_blank">https://github.c=
om/mcayland/qemu/commits/for-cat7</a><br>
then it&#39;s just a case of squashing the top 2 commits and coming up with=
 a suitable<br>
commit message.<br>
<br>
<br>
ATB,<br>
<br>
Mark.<br></blockquote><div><br></div><div>Yes, lovely! <br></div><div><br><=
/div><div>I just applied the dsound patch from KJ Liew on top of the for-ca=
t7 branch. </div><div><br></div><div><a href=3D"https://lists.nongnu.org/ar=
chive/html/qemu-devel/2020-01/msg03805.html" target=3D"_blank">https://list=
s.nongnu.org/archive/html/qemu-devel/2020-01/msg03805.html</a> <br></div><d=
iv><br></div><div>
<div>While it will not apply directly (not finding the file to patch in the=
 source tree), it nevertheless gets rid of the dsound errors too. <br></div=
>

</div><div><br></div><div>Best,</div><div>Howard<br></div><div>=C2=A0</div>=
</div></div>

--0000000000008c52d2059d6bf8ea--

