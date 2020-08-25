Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7742BC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 07:01:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B49320639
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 07:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JyyVLSuu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B49320639
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kASx6-0006h4-A5
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 03:01:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kASw1-00069b-7B
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 02:59:57 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533]:42326)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kASvz-0006Zg-E6
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 02:59:56 -0400
Received: by mail-ed1-x533.google.com with SMTP id l63so7207361edl.9
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 23:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ek881MxKDLzapdNUB6+8AxPsGHINCpaS40pPP5PcJvU=;
 b=JyyVLSuuiYz1nSulGsOgQnBXmK9TywghhAS70gDIEjNkCFZ04XzNek0eqok5961MxR
 UlFo14kEeEQCEWwXmW/o1R18Fmc95TBUUEHNibCYKaVlGjbmkI+Fjmd4xRxhCDVGCGVE
 V5JyPi6qgje4yw0hMMbIxbTTKNNTdkmTgUx3LpR8quYjoNAar6VOt+Meu7RsyU1l26Gg
 ueIor8atB4+aBRXayGk4te8uAQQ2DzE7mkRrlMlWGy19UAR8oqmZ0TWkrQQ37pJ0tLCR
 xmYcubgWbGLAYy6QGYQJ2l5BtMCIwCanE14pycvPX/Ond/4O6wdBfdgfmnHdlx/7WPB1
 bN3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ek881MxKDLzapdNUB6+8AxPsGHINCpaS40pPP5PcJvU=;
 b=nxrdICdRscEFFMZ2ImVqH1N/o66j9V9pw7rojyXXwifk207nj87hMnqO839aVKyk7F
 /MJj99+OM6NVAWN87prj+MkfZsyCuloZNoo7ylP1kNZxKZj7Fi8V6WHKRyfl5WqGm2L8
 rN3bFoP5nysEyJmONsLJ0XKAPgez+4I18xznlRVt22jpaz+2yNdvFNLK1T2pGswgA8fq
 rJoQHhaMrJzOdRt0q31Vyoh4AL/RQBCRbMQwDqpJD7HSONYqgAoHThm9k+uH+DDRWKs4
 1ibdmqYkxhUfgtvUbB2UXyMLovT+Rx6WKaLSjFxoOe/1JQfnpVBYh4Es+h1TRvurD40X
 wMPQ==
X-Gm-Message-State: AOAM532n+4MRKtXa50qjGbgcIsNBBsgTL0+Hdk4B62RbjtCgVivUX6/x
 G3E8SXP5FB3MQGNjPE3suXKrI9o7Xsi/jaRFZFo=
X-Google-Smtp-Source: ABdhPJxrHzjg9aPCdHaZ/Y4ZxCW8S+FSS9+acmOQdE3+85dRlUH6dOMFuUpGMu8gCZEGXxXa5Blqrp54TLDYDUhbmow=
X-Received: by 2002:aa7:d585:: with SMTP id r5mr8676356edq.30.1598338793934;
 Mon, 24 Aug 2020 23:59:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200825064342.2037-1-kraxel@redhat.com>
In-Reply-To: <20200825064342.2037-1-kraxel@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 25 Aug 2020 10:59:42 +0400
Message-ID: <CAJ+F1CJ0J5E2sJ=jvG7m=5pttOYohGvwqUjMFM1Vz5qBmhnk5Q@mail.gmail.com>
Subject: Re: [PATCH] meson: set colorout to auto
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000000b147905adae4039"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ed1-x533.google.com
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
Cc: QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000000b147905adae4039
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Tue, Aug 25, 2020 at 10:44 AM Gerd Hoffmann <kraxel@redhat.com> wrote:

> Dunno why the default is set to "always".  IMHO it should be "auto",
> i.e. only colorize in case stdout goes to a terminal.  Cluttering
> logfiles and confusing compiler message parsers with terminal control
> sequences is not nice ...
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>

"Enable colored output with GCC. Ninja redirects stdout/stderr so by
default GCC thinks it is not talking to a terminal"

https://github.com/mesonbuild/meson/commit/4f63fe498314c385de2d3b6a3a953d15=
985914d2

Since we use make, I don't know if it's any better.

Perhaps meson should set compiler/tools colors =3D always/never based on wh=
at
it is connected to at configure time instead?

--=20
Marc-Andr=C3=A9 Lureau

--0000000000000b147905adae4039
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 25, 2020 at 10:44 AM Ge=
rd Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.com">kraxel@redhat.com</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Dunno=
 why the default is set to &quot;always&quot;.=C2=A0 IMHO it should be &quo=
t;auto&quot;,<br>
i.e. only colorize in case stdout goes to a terminal.=C2=A0 Cluttering<br>
logfiles and confusing compiler message parsers with terminal control<br>
sequences is not nice ...<br>
<br>
Signed-off-by: Gerd Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.com" targe=
t=3D"_blank">kraxel@redhat.com</a>&gt;<br></blockquote><div><br></div><div>=
&quot;Enable colored output with GCC. Ninja redirects stdout/stderr so by d=
efault GCC thinks it is not talking to a terminal&quot;</div><div><br></div=
><div><a href=3D"https://github.com/mesonbuild/meson/commit/4f63fe498314c38=
5de2d3b6a3a953d15985914d2">https://github.com/mesonbuild/meson/commit/4f63f=
e498314c385de2d3b6a3a953d15985914d2</a></div><div><br> </div><div>Since we =
use make, I don&#39;t know if it&#39;s any better.</div><div><br></div><div=
>Perhaps meson should set compiler/tools colors =3D always/never based on w=
hat it is connected to at configure time instead?<br></div></div><br>-- <br=
><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=A9 Lureau<br></div=
></div>

--0000000000000b147905adae4039--

