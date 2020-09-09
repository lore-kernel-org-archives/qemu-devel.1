Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB83C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 15:59:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09DED206D4
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 15:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFl1xdup"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09DED206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG2VI-00085D-3q
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 11:59:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49126)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kG2UX-00079v-Lk; Wed, 09 Sep 2020 11:58:38 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:39593)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kG2UU-0002eA-Ik; Wed, 09 Sep 2020 11:58:37 -0400
Received: by mail-lf1-x142.google.com with SMTP id q8so1873423lfb.6;
 Wed, 09 Sep 2020 08:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=bDmj7UqRL3mVWtg09Ag9cQhUFGbfpb2Ld0WhRUjKye4=;
 b=UFl1xdupbw+ABcmy3PmXHtP5jfOJOALEcu8fgGYeOfYkJrCE0XZtde79KdHpbIkgC0
 bghNEcrXztHelVtY/LlEV+VSjk/g0dS4kjpUntqizoQVtGY378Yx9C6MQROg9FssrKhZ
 VGre+DqRZ4s9g0oSyBfhB2nyoFtYOzEYGJ/VtjmSpK1XYEDUOF2GbqKYFl7R/TiLk/Nh
 4TjJGmLy2SUFc5ZPf2b66GheagPsMJ4CfGQ1HOGYe4MjO8QRp7LQ2fnJam1HFAaiTp1c
 VKR4ZH7pyW+YwkF8qhdmisrmTxR4duAgctWlWwm2EGqSWst6LGX/jIknGQnmdlkALRjc
 9dGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=bDmj7UqRL3mVWtg09Ag9cQhUFGbfpb2Ld0WhRUjKye4=;
 b=AdBQiZedpF53sKjlNGdfhjKPezxWUK4T+l7HWhTy/88ptAPYNUSuMiEju3WIz6IJjA
 ZMyqHeCtmyFgoWSl9rahT67Prnfk47LF21vpt7qzTEcSgT+MzY2RZIx4yKAgXx+SQneb
 lzK7vm5uVdAqWjiijnZSBfatkwr6dsK0D1Bj75fAF3sJ7pnKpC4fzveh0hHoO2YVWxMW
 nA65Gj7Hghv+a8H+oJ0xtd17Ag9QOe5v6LJ+VEKaTcXgrVKmhUwrRVnTmFf9QS0rto+s
 IQIyDaEx8hB/HKwGlGC7MpLlVUnLWulMylsZJf/MgRVtk4PF4kVAAlVxwF7VkHwedyZZ
 Csdw==
X-Gm-Message-State: AOAM533F5QBOFRrfpXQyZLo8Nrn/BwKYDzpjKYuE2wb5YPvrz6J+0Cii
 6dtbPDqIbbDq+YTdHBaosB94aKvUH93FWcUEbSw=
X-Google-Smtp-Source: ABdhPJyN9j69UDT0alM44YtgNsHaJIRCLB3Ig2znbYPiYxjbvz2YH7kPpkRBzMlqoz3TV0hbXYyPrD75KvRZwmPA37g=
X-Received: by 2002:a19:41c8:: with SMTP id o191mr2244627lfa.176.1599667112498; 
 Wed, 09 Sep 2020 08:58:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200909094617.1582-1-luoyonggang@gmail.com>
 <20200909094617.1582-5-luoyonggang@gmail.com>
 <CAFEAcA8hGNTM+Mxp27tW+v=AvCFppiEiFoKKdB7PEXMKixH5fg@mail.gmail.com>
In-Reply-To: <CAFEAcA8hGNTM+Mxp27tW+v=AvCFppiEiFoKKdB7PEXMKixH5fg@mail.gmail.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Wed, 9 Sep 2020 23:58:21 +0800
Message-ID: <CAE2XoE-34P-g_MfMFzH609tJVuRQSjM7k=_N8pUgxNV_Dpi=aQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/21] curses: Fixes curses compiling errors.
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000ffddc805aee38512"
Received-SPF: pass client-ip=2a00:1450:4864:20::142;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x142.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Reply-To: luoyonggang@gmail.com
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Qemu-block <qemu-block@nongnu.org>,
 Stefan Weil <sw@weilnetz.de>, Xie Changlong <xiechanglong.d@gmail.com>,
 Peter Lieven <pl@kamp.de>, QEMU Developers <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000ffddc805aee38512
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2020 at 9:26 PM Peter Maydell <peter.maydell@linaro.org>
wrote:

> On Wed, 9 Sep 2020 at 10:46, Yonggang Luo <luoyonggang@gmail.com> wrote:
> >
> > This is the compiling error:
> > ../ui/curses.c: In function 'curses_refresh':
> > ../ui/curses.c:256:5: error: 'next_maybe_keycode' may be used
> uninitialized in this function [-Werror=3Dmaybe-uninitialized]
> >   256 |     curses2foo(_curses2keycode, _curseskey2keycode, chr,
> maybe_keycode)
> >       |     ^~~~~~~~~~
> > ../ui/curses.c:302:32: note: 'next_maybe_keycode' was declared here
> >   302 |             enum maybe_keycode next_maybe_keycode;
> >       |                                ^~~~~~~~~~~~~~~~~~
> > ../ui/curses.c:256:5: error: 'maybe_keycode' may be used uninitialized
> in this function [-Werror=3Dmaybe-uninitialized]
> >   256 |     curses2foo(_curses2keycode, _curseskey2keycode, chr,
> maybe_keycode)
> >       |     ^~~~~~~~~~
> > ../ui/curses.c:265:24: note: 'maybe_keycode' was declared here
> >   265 |     enum maybe_keycode maybe_keycode;
> >       |                        ^~~~~~~~~~~~~
> > cc1.exe: all warnings being treated as errors
> >
> > gcc version 10.2.0 (Rev1, Built by MSYS2 project)
> >
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> > Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
>
> I never gave this a reviewed-by tag -- can you be more careful
> with your tag handling, please?
>
Sorry, I see you replied the patch, and misunderstand as a review by

>
> thanks
> -- PMM
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000ffddc805aee38512
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Sep 9, 2020 at 9:26 PM Peter =
Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@linar=
o.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">On Wed, 9 Sep 2020 at 10:46, Yonggang Luo &lt;<a href=3D"mailto:luoyon=
ggang@gmail.com" target=3D"_blank">luoyonggang@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; This is the compiling error:<br>
&gt; ../ui/curses.c: In function &#39;curses_refresh&#39;:<br>
&gt; ../ui/curses.c:256:5: error: &#39;next_maybe_keycode&#39; may be used =
uninitialized in this function [-Werror=3Dmaybe-uninitialized]<br>
&gt;=C2=A0 =C2=A0256 |=C2=A0 =C2=A0 =C2=A0curses2foo(_curses2keycode, _curs=
eskey2keycode, chr, maybe_keycode)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0^~~~~~~~~~<br>
&gt; ../ui/curses.c:302:32: note: &#39;next_maybe_keycode&#39; was declared=
 here<br>
&gt;=C2=A0 =C2=A0302 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0enum =
maybe_keycode next_maybe_keycode;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~=
~~~~~~~~~~~~~<br>
&gt; ../ui/curses.c:256:5: error: &#39;maybe_keycode&#39; may be used unini=
tialized in this function [-Werror=3Dmaybe-uninitialized]<br>
&gt;=C2=A0 =C2=A0256 |=C2=A0 =C2=A0 =C2=A0curses2foo(_curses2keycode, _curs=
eskey2keycode, chr, maybe_keycode)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0^~~~~~~~~~<br>
&gt; ../ui/curses.c:265:24: note: &#39;maybe_keycode&#39; was declared here=
<br>
&gt;=C2=A0 =C2=A0265 |=C2=A0 =C2=A0 =C2=A0enum maybe_keycode maybe_keycode;=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~~<br>
&gt; cc1.exe: all warnings being treated as errors<br>
&gt;<br>
&gt; gcc version 10.2.0 (Rev1, Built by MSYS2 project)<br>
&gt;<br>
&gt; Signed-off-by: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.co=
m" target=3D"_blank">luoyonggang@gmail.com</a>&gt;<br>
&gt; Reviewed-by: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.=
org" target=3D"_blank">peter.maydell@linaro.org</a>&gt;<br>
&gt; Reviewed-by: Gerd Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.com" ta=
rget=3D"_blank">kraxel@redhat.com</a>&gt;<br>
<br>
I never gave this a reviewed-by tag -- can you be more careful<br>
with your tag handling, please?<br></blockquote><div>Sorry, I see you repli=
ed the patch, and misunderstand as a review by=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
<br>
thanks<br>
-- PMM<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div>

--000000000000ffddc805aee38512--

