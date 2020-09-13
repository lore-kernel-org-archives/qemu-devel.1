Return-Path: <SRS0=H3r+=CW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41343C43461
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 16:06:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC7DC21D80
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 16:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgbqTtv4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC7DC21D80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHUW7-0007q7-0B
	for qemu-devel@archiver.kernel.org; Sun, 13 Sep 2020 12:06:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kHUS6-0000iR-Bm; Sun, 13 Sep 2020 12:02:06 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:37833)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kHUS3-0001El-Hl; Sun, 13 Sep 2020 12:02:06 -0400
Received: by mail-lj1-x244.google.com with SMTP id n25so16502701ljj.4;
 Sun, 13 Sep 2020 09:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=VBjD5YigITfEftkqmBaZgUPBAxCG0cniJBZFUE7nokw=;
 b=LgbqTtv4otg2tkonNQFfteKGEkiXf9gSB4o+DUG/8J/Bw/hV4FTDiKyHZoplJN/v6q
 Fkj3ZCvz/olo+wkJ1/90dpE+cUnTM1Last1ZHWbbfkN3g4pacWeZ9UnJhUExMyKDyr5s
 +urTF+4OZfRXtkC0+4KgQZXTZ03X4WQhDWm/Tuv8zAl1dZHz17lpRRi0ga0BzxsrAbqM
 CDv64PTeQUNpezd/L+agghaR/i1YXwI7U2/1hwP3M0mrqPGyYFoMUV31xzM5UWq5ximf
 WuZUyKOLYGJ8OVxcfkML2wAjgcDm0dtI26/49oq5JRoEsKasoIyCkBOIS4tHmC2Q+Pvj
 EAHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=VBjD5YigITfEftkqmBaZgUPBAxCG0cniJBZFUE7nokw=;
 b=Mi89/DYKcCe8+PIOYjrqhqzyDHVIpXM24YbC8QWfKrJ4OnVBwVXL0eHb9CG7G7nDgp
 iCoZDV/V9XRXs1UrLHU/lav0l0rwOQrYp3Eb/p6VI2xR6aohOZ5B6uCRuhTqe4A3UHow
 UJtYX2Nq6w6nehTL263VBVnXVSDGYRWD+9lnFgs3okJxME+z2tavwN6X5MZFmwH9zXdo
 J866u1fCYSLkiC8k5uZ37MgC8pg1iqik8jmKJMUZxLf2ByyQgOxsheGt9Zh1/pYLIuuE
 9IqqdoEC6Txy/N+sh4gmk9rf1Yqv2N22fviSSjBl1/vGDF3GuA6U8QQTKTBK50dZufrl
 jdnA==
X-Gm-Message-State: AOAM530A+LmV5n53njsFckJoBccMYuDwidH0bloC/oYW3nh31X1DKPSW
 dqJz+tuAuqluSIzopjnyEVpfDwVosww1LLmFj9A=
X-Google-Smtp-Source: ABdhPJwYL22gKF9yyaBMrIXL9r8W4uhGTs5giNgP1Y6ODCCTtE0ppSzumOK79+BwBLTFHFhQr6Lx7LI5oUK7RY2pOvE=
X-Received: by 2002:a2e:86d3:: with SMTP id n19mr4070220ljj.368.1600012916506; 
 Sun, 13 Sep 2020 09:01:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200912224431.1428-1-luoyonggang@gmail.com>
 <20200912224431.1428-12-luoyonggang@gmail.com>
 <c6ed5abf-2c71-bded-7efc-33baa0b415af@redhat.com>
In-Reply-To: <c6ed5abf-2c71-bded-7efc-33baa0b415af@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Mon, 14 Sep 2020 00:01:45 +0800
Message-ID: <CAE2XoE-mFPm=chadNahHgCsa3tSjxRXMH3te29ODV=emWdLjYA@mail.gmail.com>
Subject: Re: [PATCH v8 11/27] meson: Use -b to ignore CR vs. CR-LF issues on
 Windows
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000008643ff05af3409c0"
Received-SPF: pass client-ip=2a00:1450:4864:20::244;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x244.google.com
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
 qemu-level <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000008643ff05af3409c0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 13, 2020 at 11:35 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat=
.com>
wrote:

> On 9/13/20 12:44 AM, Yonggang Luo wrote:
> > On windows, a difference in line endings causes testsuite failures
> > complaining that every single line in files such as
> > 'tests/qapi-schemadoc-good.texi' is wrong.  Fix it by adding -b to diff=
.
>
> Isn't '--strip-trailing-cr' more adapted?
>
> er, I did that before.....

> >
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > Reviewed-by: Eric Blake <eblake@redhat.com>
> > Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > ---
> >  tests/qapi-schema/meson.build | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tests/qapi-schema/meson.build
> b/tests/qapi-schema/meson.build
> > index c87d141417..f1449298b0 100644
> > --- a/tests/qapi-schema/meson.build
> > +++ b/tests/qapi-schema/meson.build
> > @@ -220,6 +220,6 @@ qapi_doc =3D custom_target('QAPI doc',
> >
> >  # "full_path()" needed here to work around
> >  # https://github.com/mesonbuild/meson/issues/7585
> > -test('QAPI doc', diff, args: ['-u', files('doc-good.texi'),
> qapi_doc[0].full_path()],
> > +test('QAPI doc', diff, args: ['-b', '-u', files('doc-good.texi'),
> qapi_doc[0].full_path()],
> >       depends: qapi_doc,
> >       suite: ['qapi-schema', 'qapi-doc'])
> >
>
>

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000008643ff05af3409c0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sun, Sep 13, 2020 at 11:35 PM Phil=
ippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com">philmd@red=
hat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">On 9/13/20 12:44 AM, Yonggang Luo wrote:<br>
&gt; On windows, a difference in line endings causes testsuite failures<br>
&gt; complaining that every single line in files such as<br>
&gt; &#39;tests/qapi-schemadoc-good.texi&#39; is wrong.=C2=A0 Fix it by add=
ing -b to diff.<br>
<br>
Isn&#39;t &#39;--strip-trailing-cr&#39; more adapted?<br>
<br></blockquote><div>er, I did that before.....=C2=A0</div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">
&gt; <br>
&gt; Signed-off-by: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.co=
m" target=3D"_blank">luoyonggang@gmail.com</a>&gt;<br>
&gt; Reviewed-by: Eric Blake &lt;<a href=3D"mailto:eblake@redhat.com" targe=
t=3D"_blank">eblake@redhat.com</a>&gt;<br>
&gt; Reviewed-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@re=
dhat.com" target=3D"_blank">berrange@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 tests/qapi-schema/meson.build | 2 +-<br>
&gt;=C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/tests/qapi-schema/meson.build b/tests/qapi-schema/meson.b=
uild<br>
&gt; index c87d141417..f1449298b0 100644<br>
&gt; --- a/tests/qapi-schema/meson.build<br>
&gt; +++ b/tests/qapi-schema/meson.build<br>
&gt; @@ -220,6 +220,6 @@ qapi_doc =3D custom_target(&#39;QAPI doc&#39;,<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 # &quot;full_path()&quot; needed here to work around<br>
&gt;=C2=A0 # <a href=3D"https://github.com/mesonbuild/meson/issues/7585" re=
l=3D"noreferrer" target=3D"_blank">https://github.com/mesonbuild/meson/issu=
es/7585</a><br>
&gt; -test(&#39;QAPI doc&#39;, diff, args: [&#39;-u&#39;, files(&#39;doc-go=
od.texi&#39;), qapi_doc[0].full_path()],<br>
&gt; +test(&#39;QAPI doc&#39;, diff, args: [&#39;-b&#39;, &#39;-u&#39;, fil=
es(&#39;doc-good.texi&#39;), qapi_doc[0].full_path()],<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0depends: qapi_doc,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0suite: [&#39;qapi-schema&#39;, &#39;qapi-doc=
&#39;])<br>
&gt; <br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div>

--0000000000008643ff05af3409c0--

