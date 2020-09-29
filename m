Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E614C47423
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 15:35:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE92520773
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 15:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="usQpz9bZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE92520773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNHfI-0004JM-K7
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 11:35:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kNHd0-00035c-Uw
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 11:33:18 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:44592)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kNHcz-0002HI-5S
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 11:33:18 -0400
Received: by mail-ej1-x642.google.com with SMTP id r7so15591957ejs.11
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 08:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GC9PIK7OHFVCwZpH55NOy1s/ZLyaICin9jkzF8dEP3w=;
 b=usQpz9bZKXrlWTs0cqclDljku+zbZ9u7kKaX2M07g3z/XEy6pJCjA4VlbruAMkyDIs
 p2VWAXzXvws+rlZfk1KpTryDByaZkL8tnTFPcFHPYcLjyz51dbKic/S+sVnpT2U428RA
 ko6RdhbR6cNYZ13TkZI9zt+TSBgTF8HYT+nBjIrpRNBIH8OjnoMwtA1fOi9lY/W2CByW
 J3xy+S/c/r43j1SxNYRR/laisJxSbbmS49CDHfWZ5pn4l1Q0qocjfEVPlw7d1sWb6oiR
 Tm419NE9b0+sa4zSc7DzXdoS9zmsX3rPrNqH/fqaiRYNyToA6ML9HNgkFKzhvaj0yWV0
 4SDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GC9PIK7OHFVCwZpH55NOy1s/ZLyaICin9jkzF8dEP3w=;
 b=WN6SmU7Y7wp/1VR6zwf6bdgXNYvEgNvqf63H898BKOlG/3miTqwdda2bk71uc3LJKR
 0jNCMa+eSPcvqkQMMeKTPVPPpJsENcIVna1RdQP6hsn1gmTOgphFKaHNnLpHyx0KX3nQ
 da6Kx7KSVK5//gLFSHpRnBw5S/VOBJONriGuVZOVpSYFQE8cXFHtyCILzK182bXyxB8y
 woKPTcI7sYJKuE6WsoAfxTGqObflI53U+tqLP0eNTtsYKUAz2ewL3JDXCVxWRVy9hyZo
 xsjiZKrIcK2PH4Bh5GSIQO8dOQS8aj4VnZNe3XTaVPpWSex/N11ttCkwHP/jv3JeyDu1
 HlIA==
X-Gm-Message-State: AOAM533wy9+Wqi3PkwG3Xx6Rt51lwa8Qac0yRtBuYImLzjZiN6RYkUyK
 pfk3NAQgmsguTJrSwMFAajSSFyQfkv1mmgKtkU4=
X-Google-Smtp-Source: ABdhPJyYz4VVzZRejNhOVpYWFD6XyuZF20YPxe3oA5dovOQHeJ8Obsl6f89mAmXwnPQD1poGCaqKzwldA/+XRuyftKA=
X-Received: by 2002:a17:906:249b:: with SMTP id
 e27mr4384201ejb.105.1601393595519; 
 Tue, 29 Sep 2020 08:33:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200929143654.518157-1-marcandre.lureau@redhat.com>
 <CAE2XoE9x4ovaUaNJhh=-deYqYJKQC68wQaACQbnC28EZoeEqUg@mail.gmail.com>
In-Reply-To: <CAE2XoE9x4ovaUaNJhh=-deYqYJKQC68wQaACQbnC28EZoeEqUg@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 29 Sep 2020 19:33:04 +0400
Message-ID: <CAJ+F1C+oGqrKYKPTnNrO-3XM7_raaHY4ofdbd1xxtY8CPYd-mQ@mail.gmail.com>
Subject: Re: [PATCH v2] build-sys: fix git version from -version
To: Yonggang Luo <luoyonggang@gmail.com>
Content-Type: multipart/alternative; boundary="00000000000068188a05b075808c"
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ej1-x642.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 qemu-level <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000068188a05b075808c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2020 at 6:43 PM =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) <=
luoyonggang@gmail.com>
wrote:

>
>
> On Tue, Sep 29, 2020 at 10:38 PM <marcandre.lureau@redhat.com> wrote:
> >
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Typo introduced with the script.
> >
> > Fixes: 2c273f32d3 ("meson: generate qemu-version.h")
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  scripts/qemu-version.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/scripts/qemu-version.sh b/scripts/qemu-version.sh
> > index 03128c56a2..3f6e7e6d41 100755
> > --- a/scripts/qemu-version.sh
> > +++ b/scripts/qemu-version.sh
> > @@ -9,7 +9,7 @@ version=3D"$3"
> >  if [ -z "$pkgversion" ]; then
> >      cd "$dir"
> >      if [ -e .git ]; then
> > -        pkgversion=3D$(git describe --match 'v*' --dirty | echo "")
> > +        pkgversion=3D$(git describe --match 'v*' --dirty) || :
> >      fi
> >  fi
> >
> > --
> > 2.26.2
> >
> >
> Maybe this script can convert to python? as we are converting to
> meson+python,
> for less care about different bash/zsh/xsh differences?
>

You are welcome to do it :)
thanks


> --
>          =E6=AD=A4=E8=87=B4
> =E7=A4=BC
> =E7=BD=97=E5=8B=87=E5=88=9A
> Yours
>     sincerely,
> Yonggang Luo
>


--=20
Marc-Andr=C3=A9 Lureau

--00000000000068188a05b075808c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 29, 2020 at 6:43 PM =E7=
=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) &lt;<a href=3D"mailto:luoyonggang@gm=
ail.com">luoyonggang@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex"><div dir=3D"ltr"><br><br>On Tue, Sep 29, 2020=
 at 10:38 PM &lt;<a href=3D"mailto:marcandre.lureau@redhat.com" target=3D"_=
blank">marcandre.lureau@redhat.com</a>&gt; wrote:<br>&gt;<br>&gt; From: Mar=
c-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com" targ=
et=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>&gt;<br>&gt; Typo intr=
oduced with the script.<br>&gt;<br>&gt; Fixes: 2c273f32d3 (&quot;meson: gen=
erate qemu-version.h&quot;)<br>&gt; Signed-off-by: Marc-Andr=C3=A9 Lureau &=
lt;<a href=3D"mailto:marcandre.lureau@redhat.com" target=3D"_blank">marcand=
re.lureau@redhat.com</a>&gt;<br>&gt; ---<br>&gt; =C2=A0scripts/qemu-version=
.sh | 2 +-<br>&gt; =C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>&=
gt;<br>&gt; diff --git a/scripts/qemu-version.sh b/scripts/qemu-version.sh<=
br>&gt; index 03128c56a2..3f6e7e6d41 100755<br>&gt; --- a/scripts/qemu-vers=
ion.sh<br>&gt; +++ b/scripts/qemu-version.sh<br>&gt; @@ -9,7 +9,7 @@ versio=
n=3D&quot;$3&quot;<br>&gt; =C2=A0if [ -z &quot;$pkgversion&quot; ]; then<br=
>&gt; =C2=A0 =C2=A0 =C2=A0cd &quot;$dir&quot;<br>&gt; =C2=A0 =C2=A0 =C2=A0i=
f [ -e .git ]; then<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0pkgversion=3D$(git=
 describe --match &#39;v*&#39; --dirty | echo &quot;&quot;)<br>&gt; + =C2=
=A0 =C2=A0 =C2=A0 =C2=A0pkgversion=3D$(git describe --match &#39;v*&#39; --=
dirty) || :<br>&gt; =C2=A0 =C2=A0 =C2=A0fi<br>&gt; =C2=A0fi<br>&gt;<br>&gt;=
 --<br>&gt; 2.26.2<br>&gt;<br>&gt;<br>Maybe this script can convert to pyth=
on? as we are converting to meson+python,<div>for less care about different=
 bash/zsh/xsh differences?<br></div></div></blockquote><div><br></div><div>=
You are welcome to do it :)</div><div>thanks<br></div><div> <br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div><br>--<b=
r>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=
=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang L=
uo</div></div>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--00000000000068188a05b075808c--

