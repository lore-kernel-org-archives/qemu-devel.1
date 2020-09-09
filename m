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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4912DC43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 18:30:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A67AE206E6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 18:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p4Xc6Q+U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A67AE206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG4r9-0008IJ-MQ
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 14:30:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52806)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kG4q9-0007T7-Ol; Wed, 09 Sep 2020 14:29:05 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:41982)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kG4q7-0005Vz-TO; Wed, 09 Sep 2020 14:29:05 -0400
Received: by mail-lj1-x243.google.com with SMTP id y4so4822576ljk.8;
 Wed, 09 Sep 2020 11:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=FgurmH85iQmYjpsf8QRarFhazPy85qlJblIX7SX8MdI=;
 b=p4Xc6Q+UPslkaqvGyF0NhVYIGYIfTrBPakFABq1aUKohWWp1WOcX9nL34Pyle+335I
 YxaJAL4heRkBJJ0AIthhdDYjkU8PY2R+RWfPcejO/tJV+Gf8kCZWrxGB6e6/k6PqaQBp
 dk/sm99ljnQX2RpZYgXHQm6uHx+HFsqGczIpzIo3lgVgoN9azNWq/rj86SLS6hArbyfZ
 OJld6S7+ZCun5V0gU1FBeahcnYdvNOh0dSfzfBeQiHW5zD4IGGFax6U4PoK0QFCUTr8q
 f/TlUCw6yoiGNaX0MQbGOVkDhAkFZtu0FRxkEKqxZx+1yflDte5iA/qjEHSmIqEtVTR2
 HMWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=FgurmH85iQmYjpsf8QRarFhazPy85qlJblIX7SX8MdI=;
 b=Ku+9MU+YLOJI4HScrrHkA6yy1R833tgoIrpeKpP5fRfc4qIU272qww/K7ul1FeiUXQ
 nPToMGT9sVgKC0p2Kds7NzEENMg84st/rWRMjoLXHshK45WMotFilhXqw2OeY1Zu64m7
 5tYmHY0iwOUN3AkImQAtYoGp48PYccQ0cx7zDR1CaNAGFYQeqspCiAHZMylBm6yegnhs
 yZ6BvvqwaYLopDrEveeqDJUVlNc0eSB5+i2vogTS4DdYLWGVtNQsf5YSVkM2mHzTrQdy
 2XHfDICDJ/ui3nGZRi8smHN2a8cPcj+r9zZeovDrhhDCvnLuV0AqRvHcCAvd4gDsH2vp
 g0lg==
X-Gm-Message-State: AOAM533YAWsSXTtlT00WvNn7SX4IYXnj64tj8f68EnsMPLFluqBsjWKI
 TdQU6BYz/1cIYHSAOmqX/n/+QI6iw4Cixzp1Sng=
X-Google-Smtp-Source: ABdhPJwTeoVx0aT42rH2dd2jW/23OeLaK09a416QuP58UFUXQxk/JfCelQm66rCRXh66Z+nu0dVUwFxajsp3cOc+xzk=
X-Received: by 2002:a05:651c:151:: with SMTP id
 c17mr2700055ljd.467.1599676141850; 
 Wed, 09 Sep 2020 11:29:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200909094617.1582-1-luoyonggang@gmail.com>
 <20200909094617.1582-15-luoyonggang@gmail.com>
 <CAPyFy2BrjPh_E3YaxEx73eJjSd3TXeghiokeKL-Y+suupmiP8Q@mail.gmail.com>
 <20200909181633.GW1011023@redhat.com>
In-Reply-To: <20200909181633.GW1011023@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Thu, 10 Sep 2020 02:28:49 +0800
Message-ID: <CAE2XoE-R0jSuMuXWVqm9DPSNM2o8JxbTEH3xwgOJ7rsAqAcdvg@mail.gmail.com>
Subject: Re: [PATCH v2 14/21] cirrus: Building freebsd in a single short
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000030d63b05aee5a016"
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x243.google.com
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
 Qemu-block <qemu-block@nongnu.org>, Stefan Weil <sw@weilnetz.de>,
 Xie Changlong <xiechanglong.d@gmail.com>, Peter Lieven <pl@kamp.de>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel <qemu-devel@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000030d63b05aee5a016
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2020 at 2:16 AM Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m>
wrote:

> On Wed, Sep 09, 2020 at 01:32:04PM -0400, Ed Maste wrote:
> > On Wed, 9 Sep 2020 at 05:47, Yonggang Luo <luoyonggang@gmail.com> wrote=
:
> > >
> > > freebsd 1 hour limit not hit anymore
> > >
> > > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> >
> > Reviewed-by: Ed Maste <emaste@FreeBSD.org>
> >
> > > When its running properly, the consumed time are little, but when
> tests running too long,
> > > look at the cpu  usage, the cpu usage are nearly zero. does't
> consuming time.
> >
> > So it looks like we have a test getting stuck. After this change is in
> > we could split the test execution out into its own script so to make
> > it more obvious if/when this happens - for example,
> >
> >   script:
> >     - mkdir build
> >     - cd build
> >     - ../configure --enable-werror || { cat config.log; exit 1; }
> >     - gmake -j8
> >   test_script:
> >    - gmake V=3D1 check
> >
> > I can follow up with a proper patch for that (and making the change
> > for macos as well) later.
>
> What would help most is if there's a way to convince meson to print
> the execution time of each test case, instead of merely its name.
> That way we could immediately spot the slow test when it hits
>
> Yeap, that's would be great, but now the tests are running by not by meso=
n

>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-
> https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-
> https://www.instagram.com/dberrange :|
>
>

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--00000000000030d63b05aee5a016
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Sep 10, 2020 at 2:16 AM Danie=
l P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berrange@redh=
at.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">On Wed, Sep 09, 2020 at 01:32:04PM -0400, Ed Maste wrote:<br>
&gt; On Wed, 9 Sep 2020 at 05:47, Yonggang Luo &lt;<a href=3D"mailto:luoyon=
ggang@gmail.com" target=3D"_blank">luoyonggang@gmail.com</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; freebsd 1 hour limit not hit anymore<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gma=
il.com" target=3D"_blank">luoyonggang@gmail.com</a>&gt;<br>
&gt; <br>
&gt; Reviewed-by: Ed Maste &lt;emaste@FreeBSD.org&gt;<br>
&gt; <br>
&gt; &gt; When its running properly, the consumed time are little, but when=
 tests running too long,<br>
&gt; &gt; look at the cpu=C2=A0 usage, the cpu usage are nearly zero. does&=
#39;t consuming time.<br>
&gt; <br>
&gt; So it looks like we have a test getting stuck. After this change is in=
<br>
&gt; we could split the test execution out into its own script so to make<b=
r>
&gt; it more obvious if/when this happens - for example,<br>
&gt; <br>
&gt;=C2=A0 =C2=A0script:<br>
&gt;=C2=A0 =C2=A0 =C2=A0- mkdir build<br>
&gt;=C2=A0 =C2=A0 =C2=A0- cd build<br>
&gt;=C2=A0 =C2=A0 =C2=A0- ../configure --enable-werror || { cat config.log;=
 exit 1; }<br>
&gt;=C2=A0 =C2=A0 =C2=A0- gmake -j8<br>
&gt;=C2=A0 =C2=A0test_script:<br>
&gt;=C2=A0 =C2=A0 - gmake V=3D1 check<br>
&gt; <br>
&gt; I can follow up with a proper patch for that (and making the change<br=
>
&gt; for macos as well) later.<br>
<br>
What would help most is if there&#39;s a way to convince meson to print<br>
the execution time of each test case, instead of merely its name.<br>
That way we could immediately spot the slow test when it hits<br>
<br></blockquote><div>Yeap, that&#39;s would be great, but now the tests ar=
e running by not by meson=C2=A0</div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">
<br>
Regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D"http=
s://www.flickr.com/photos/dberrange" rel=3D"noreferrer" target=3D"_blank">h=
ttps://www.flickr.com/photos/dberrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer" target=3D"_blank">htt=
ps://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-o-=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://fstop138.berrange.com" rel=3D"n=
oreferrer" target=3D"_blank">https://fstop138.berrange.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer" target=3D"_bla=
nk">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D=
"https://www.instagram.com/dberrange" rel=3D"noreferrer" target=3D"_blank">=
https://www.instagram.com/dberrange</a> :|<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div>

--00000000000030d63b05aee5a016--

