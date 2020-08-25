Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B6AC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 08:12:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D50922065F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 08:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FT+DZzCV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D50922065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAU3s-0005kx-3p
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 04:12:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56204)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kAU3K-0005KX-K2
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 04:11:34 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:42199)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kAU3I-0006nf-Iq
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 04:11:34 -0400
Received: by mail-ej1-x643.google.com with SMTP id j25so6171848ejk.9
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 01:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7EXxON0lhZPI+ezOt2qEWfz1fmOZkyagZW+TQ9lYJuQ=;
 b=FT+DZzCVJhQuYhdBbkCVXFFykVOZbohWD8F6LR/3jJAYJZOaVgX6uLCCRh9xtzkir4
 cHAlMvYX5I4u+WTdKa9kw+65q4Bqaf/XhwY7Nwpw1o4Kf2qnKP9VKAeD6DlcOExUFNFg
 E2yeiHaREECU1LWIp142rM68zKE6CztmkowFMYlMsXPUIn17wwx2Xp9zaxRw8BlygY6S
 9MXY3C7W4ZBbPsnG9gFAOCoRu/VWsHNGMcX01p4IMlM4n39NCfzoDvB/9qae1luaO5yI
 3m+QoWZuGjo/8xJpGsd4FmE56aUUncGuZbbX7gIBqeKao31NbgApKJ4YtYMLQhqmn75j
 3EqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7EXxON0lhZPI+ezOt2qEWfz1fmOZkyagZW+TQ9lYJuQ=;
 b=J6MXbUTS/9DN+wbcMmiKAfx8SKVl3syXpO9ETHrYlWcKBmB1B5pNmzU9oy+VAKt2Q1
 6oF3DvgIKKsCzhJW17E0dPKdQMN3C/HITyO2NaLXOaI7T3wqfv0RpY6CIgKWXQxe7gKw
 t+/k8gzGocG+9zLlnu8RQszuCdA5+9q6Jdv5ye1jX+ZFsNJZy+dG9aciEv0Q+7raMcuq
 +CMn8iu0phpXJMBRsBboZQOWARzJr8D+Fjw7bKf/TFxKFPYPLQ2YjLg80W4zKwhuWtAG
 gj+029e/GWpsKB/6EbKpUISOVlrcm0+uTrot4TyfAUbtAUKoIAF3wCxkOE2BC8f3/SfM
 C7Hg==
X-Gm-Message-State: AOAM532S1TsSi01j6lj5/rz8B0LxK1pdGO8bbZ7tfyEQvlZcOS34t6yP
 OFuFDIVF6ugPOPZ1BDUfC4WC3fz3k1Fn/NRCkWk=
X-Google-Smtp-Source: ABdhPJwSdFbMDGlCvBxzxXNUOsTxYxjZN75nnLYrM4PECHWmty7f0POsUsGl7dGuxpTO6v+bvvBRyczmXavPKzPuANU=
X-Received: by 2002:a17:906:1f96:: with SMTP id
 t22mr9187056ejr.381.1598343091001; 
 Tue, 25 Aug 2020 01:11:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200825064342.2037-1-kraxel@redhat.com>
 <CAJ+F1CJ0J5E2sJ=jvG7m=5pttOYohGvwqUjMFM1Vz5qBmhnk5Q@mail.gmail.com>
 <20200825080657.saqysz6rugvhomrl@sirius.home.kraxel.org>
In-Reply-To: <20200825080657.saqysz6rugvhomrl@sirius.home.kraxel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 25 Aug 2020 12:11:19 +0400
Message-ID: <CAJ+F1CLJY0Rc7_abUsqGrzoVTDp=Oe3GEE4X6F9AeQOo9Y0n4Q@mail.gmail.com>
Subject: Re: [PATCH] meson: set colorout to auto
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000002b1e6a05adaf400d"
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ej1-x643.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000002b1e6a05adaf400d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Tue, Aug 25, 2020 at 12:07 PM Gerd Hoffmann <kraxel@redhat.com> wrote:

> On Tue, Aug 25, 2020 at 10:59:42AM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Tue, Aug 25, 2020 at 10:44 AM Gerd Hoffmann <kraxel@redhat.com>
> wrote:
> >
> > > Dunno why the default is set to "always".  IMHO it should be "auto",
> > > i.e. only colorize in case stdout goes to a terminal.  Cluttering
> > > logfiles and confusing compiler message parsers with terminal control
> > > sequences is not nice ...
> > >
> > > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > >
> >
> > "Enable colored output with GCC. Ninja redirects stdout/stderr so by
> > default GCC thinks it is not talking to a terminal"
> >
> >
> https://github.com/mesonbuild/meson/commit/4f63fe498314c385de2d3b6a3a953d=
15985914d2
>
> Hmm, maybe ninja handles this then, by stripping the terminal sequences
> in case stdout isn't a terminal.
>
> With ninja being the default backend the default kind-of makes sense
> (for meson upstream) ...
>
> > Since we use make, I don't know if it's any better.
>
> ... but given qemu uses make not ninja we might prefer something else ;)
>
> As far I know make doesn't redirect output.  Or maybe it redirects using
> a pty (instead of a pipe) in case stdout is a terminal.  At least auto
> mode for colored gcc warnings works fine with make.  It is colored when
> started in a terminal, it isn't when started in emacs (and piped through
> the emacs message parser).
>
>
Then it looks like you have a legit patch. We can revert it when we switch
back to ninja some day.

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> Perhaps meson should set compiler/tools colors =3D always/never based on
> what
> > it is connected to at configure time instead?
>
> Why?  Even when running configure in a terminal I might use emacs for
> builds later on.
>
> take care,
>   Gerd
>
>

--=20
Marc-Andr=C3=A9 Lureau

--0000000000002b1e6a05adaf400d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi<br></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Tue, Aug 25, 2020 at 12:07 PM Gerd Hoffman=
n &lt;<a href=3D"mailto:kraxel@redhat.com">kraxel@redhat.com</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Tue, Aug 25,=
 2020 at 10:59:42AM +0400, Marc-Andr=C3=A9 Lureau wrote:<br>
&gt; Hi<br>
&gt; <br>
&gt; On Tue, Aug 25, 2020 at 10:44 AM Gerd Hoffmann &lt;<a href=3D"mailto:k=
raxel@redhat.com" target=3D"_blank">kraxel@redhat.com</a>&gt; wrote:<br>
&gt; <br>
&gt; &gt; Dunno why the default is set to &quot;always&quot;.=C2=A0 IMHO it=
 should be &quot;auto&quot;,<br>
&gt; &gt; i.e. only colorize in case stdout goes to a terminal.=C2=A0 Clutt=
ering<br>
&gt; &gt; logfiles and confusing compiler message parsers with terminal con=
trol<br>
&gt; &gt; sequences is not nice ...<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Gerd Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.=
com" target=3D"_blank">kraxel@redhat.com</a>&gt;<br>
&gt; &gt;<br>
&gt; <br>
&gt; &quot;Enable colored output with GCC. Ninja redirects stdout/stderr so=
 by<br>
&gt; default GCC thinks it is not talking to a terminal&quot;<br>
&gt; <br>
&gt; <a href=3D"https://github.com/mesonbuild/meson/commit/4f63fe498314c385=
de2d3b6a3a953d15985914d2" rel=3D"noreferrer" target=3D"_blank">https://gith=
ub.com/mesonbuild/meson/commit/4f63fe498314c385de2d3b6a3a953d15985914d2</a>=
<br>
<br>
Hmm, maybe ninja handles this then, by stripping the terminal sequences<br>
in case stdout isn&#39;t a terminal.<br>
<br>
With ninja being the default backend the default kind-of makes sense<br>
(for meson upstream) ...<br>
<br>
&gt; Since we use make, I don&#39;t know if it&#39;s any better.<br>
<br>
... but given qemu uses make not ninja we might prefer something else ;)<br=
>
<br>
As far I know make doesn&#39;t redirect output.=C2=A0 Or maybe it redirects=
 using<br>
a pty (instead of a pipe) in case stdout is a terminal.=C2=A0 At least auto=
<br>
mode for colored gcc warnings works fine with make.=C2=A0 It is colored whe=
n<br>
started in a terminal, it isn&#39;t when started in emacs (and piped throug=
h<br>
the emacs message parser).<br>
<br></blockquote><div><br></div><div>Then it looks like you have a legit pa=
tch. We can revert it when we switch back to ninja some day.<br></div><div>=
<br> </div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:m=
arcandre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt; <br></div><=
div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; Perhaps meson should set compiler/tools colors =3D always/never based =
on what<br>
&gt; it is connected to at configure time instead?<br>
<br>
Why?=C2=A0 Even when running configure in a terminal I might use emacs for<=
br>
builds later on.<br>
<br>
take care,<br>
=C2=A0 Gerd<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--0000000000002b1e6a05adaf400d--

