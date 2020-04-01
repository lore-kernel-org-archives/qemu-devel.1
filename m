Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E26FC2D0F0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 16:37:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AAC4212CC
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 16:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fi73KHEW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AAC4212CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJgN5-0000Be-65
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 12:37:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35096)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <singhalsimran0@gmail.com>) id 1jJgLu-0007X6-DI
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 12:36:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <singhalsimran0@gmail.com>) id 1jJgLt-0007hz-7U
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 12:36:30 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e]:42224)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <singhalsimran0@gmail.com>)
 id 1jJgLq-0007bh-BC; Wed, 01 Apr 2020 12:36:26 -0400
Received: by mail-lj1-x22e.google.com with SMTP id q19so108900ljp.9;
 Wed, 01 Apr 2020 09:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mSCxKEIswY3twR25bYTVpqCEOpJgrL69cF/U0oJAV5Q=;
 b=Fi73KHEW03qGk8kB6r/mUc72Zbj6fzHTieDkZEzZAdGe1BHooDe4hOzo1kuAKOI4yw
 ZHs0nP4o/Gyi5DqWAsbPRohOfNEdZ8xEIOHLknFltdAnGLThUYG8MNCj0kRTPR3gxXrp
 Z498/BABFaTFKkbOuBrc5J/eCjNKWDK6TrgTICFkHX12k5zGUCDx3l6mQaduttqwIVhy
 p5n2M4n+3EgVyDbU9rjYJFJVOT2Q6Txxggd0Yb9IvSqCGOj35CyyEwyL5iw77AIy72n0
 9NdRTcYZEEGB+LvKiq9odZjrRwskH53ODVOs7oKRJmb+3WPby/cYo/wGpo44lWTebWeB
 rRSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mSCxKEIswY3twR25bYTVpqCEOpJgrL69cF/U0oJAV5Q=;
 b=jBW7Z8xYK3cd2AAHFN47zjHTEp0aSzAR95oXiuUnriPOO7NpvmhUGeqKOeJ0s3oHIX
 b1Ip88OvEfhc3Zlvfnddwm3LOFeJlbFSw66UteUbAICJ/QMgA5xFdA3WPQK9Wu9G4GUl
 GKSTieXgtUnmgmsrCVXa7ZnMRlbRP6bCoANrQ3WLwkhBpO4lG0yR+WxUrEcTpIqcBd1M
 k9f89nvSePhXuOQ/7YD1uH7eyoa7q/PXaGs8r/Q+FEJJXW12/mCQf3w+BNldc9TPUpYe
 qYQ9m1iFywxsR2EB3imipqhtmUOpI+CBbTe/RudqzTsXyaT5ZmwLzIlGrG7gs4Bzs58l
 OVuA==
X-Gm-Message-State: AGi0PuaHc5E5P+oojsq9uraRRQJdyHhwDe+KZzogKXhlEtASdwtIoYSY
 TSFYFHXdDHHiCYoIfwmL8Fil3PGxSSK71cxvz70=
X-Google-Smtp-Source: APiQypJGVFIs8zaPERwl8Kr0ATBpGen/DHkyPB9vPODNYJr6LxhuqKQhL77P96046bL0FsmHxbjFQOiJIp4gtcE4Y8Q=
X-Received: by 2002:a2e:8954:: with SMTP id b20mr12841678ljk.176.1585758983992; 
 Wed, 01 Apr 2020 09:36:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200401121101.GA26994@simran-Inspiron-5558>
 <d93af7ef-59d3-ceda-6847-1f5c92eaea2b@redhat.com>
 <CALrZqyNpvKeH6E2KCLQoCt1H1qphktWuX8i-cwoMOH6_g0Qu4g@mail.gmail.com>
 <33d40ebc-00d1-28d2-f278-2419ab636b45@redhat.com>
In-Reply-To: <33d40ebc-00d1-28d2-f278-2419ab636b45@redhat.com>
From: Simran Singhal <singhalsimran0@gmail.com>
Date: Wed, 1 Apr 2020 22:06:11 +0530
Message-ID: <CALrZqyOiSCv4=rdT_S8W-N12yOBk2tX=Wsxxxb_9S_4uCGeO=w@mail.gmail.com>
Subject: Re: [PATCH] Compress lines for immediate return
To: Eric Blake <eblake@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000f0b72905a23d4883"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::22e
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Julia Suvorova <jusual@mail.ru>, Peter Lieven <pl@kamp.de>,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000f0b72905a23d4883
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2020 at 9:15 PM Eric Blake <eblake@redhat.com> wrote:

> On 4/1/20 9:49 AM, Simran Singhal wrote:
> > Hello Philippe
> >
> > On Wed, Apr 1, 2020 at 7:26 PM Philippe Mathieu-Daud=C3=A9 <philmd@redh=
at.com
> >
> > wrote:
> >
> >> Hi Simran,
> >>
> >> On 4/1/20 2:11 PM, Simran Singhal wrote:
> >>> Compress two lines into a single line if immediate return statement i=
s
> >> found.
> >>
> >> How did you find these changes? Manual audit, some tool?
> >>
> >
> > I wrote coccinelle script to do these changes.
> >
>
> Then is it worth checking in your script to scripts/coccinelle/ to let
> it be something we can repeatedly rerun in the future to catch more
> instances?  Even if you don't go that far, mentioning the exact rune you
> used makes it easier to reproduce the patch, or even backport its
> effects to a different branch.
>

Ok, I'll resend the patch with changing the commit message to include the
script used to make the change.

Thanks
Simran


>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
>
>

--000000000000f0b72905a23d4883
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Apr 1, 2020 at 9:15 PM Eric B=
lake &lt;<a href=3D"mailto:eblake@redhat.com">eblake@redhat.com</a>&gt; wro=
te:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 4/1/20 9:=
49 AM, Simran Singhal wrote:<br>
&gt; Hello Philippe<br>
&gt; <br>
&gt; On Wed, Apr 1, 2020 at 7:26 PM Philippe Mathieu-Daud=C3=A9 &lt;<a href=
=3D"mailto:philmd@redhat.com" target=3D"_blank">philmd@redhat.com</a>&gt;<b=
r>
&gt; wrote:<br>
&gt; <br>
&gt;&gt; Hi Simran,<br>
&gt;&gt;<br>
&gt;&gt; On 4/1/20 2:11 PM, Simran Singhal wrote:<br>
&gt;&gt;&gt; Compress two lines into a single line if immediate return stat=
ement is<br>
&gt;&gt; found.<br>
&gt;&gt;<br>
&gt;&gt; How did you find these changes? Manual audit, some tool?<br>
&gt;&gt;<br>
&gt; <br>
&gt; I wrote coccinelle script to do these changes.<br>
&gt; <br>
<br>
Then is it worth checking in your script to scripts/coccinelle/ to let <br>
it be something we can repeatedly rerun in the future to catch more <br>
instances?=C2=A0 Even if you don&#39;t go that far, mentioning the exact ru=
ne you <br>
used makes it easier to reproduce the patch, or even backport its <br>
effects to a different branch.<br></blockquote><div><br></div><div>Ok, I&#3=
9;ll resend the patch with changing the commit message to include the scrip=
t used to make the change.</div><div><br></div><div>Thanks</div><div>Simran=
<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">
<br>
-- <br>
Eric Blake, Principal Software Engineer<br>
Red Hat, Inc.=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+1-919-301-3226<br>
Virtualization:=C2=A0 <a href=3D"http://qemu.org" rel=3D"noreferrer" target=
=3D"_blank">qemu.org</a> | <a href=3D"http://libvirt.org" rel=3D"noreferrer=
" target=3D"_blank">libvirt.org</a><br>
<br>
</blockquote></div></div>

--000000000000f0b72905a23d4883--

