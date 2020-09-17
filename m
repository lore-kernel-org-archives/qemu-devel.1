Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85648C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 07:27:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED68E2072E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 07:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9+Y6WZA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED68E2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIoJt-0007wa-2K
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 03:27:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kIoIb-00072B-Mx
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 03:25:47 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:44936)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kIoIZ-0001x4-Td
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 03:25:45 -0400
Received: by mail-ej1-x644.google.com with SMTP id r7so1770019ejs.11
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 00:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RXHY67Bzpgcy/6ww9gNs35EIqABdAzpYQa8iqAsMeIo=;
 b=g9+Y6WZApmhQff1D8RRQ2fwFSiA6K7bjduKrNwG3MlbrlUdvJAZqiLfKyqxbyT+mZ8
 AyYoRm2wHyZ/oA2mwZkk2iARZW0sQzFVYaU8ZoUdVqPklSCPjglUBSJAlNRNn0ZXgjOw
 xqKsCLZ9/0XxiX+haxywpuqKP1GOqYd7c8kwfrzcQJDTizKHQBGAXD6qUSSx3NAuSth7
 c4tVTexESR/x+nvfAp07GM5ZSM3ySoFRaFVGy0VBUMjp5IXBWiOENfciZhwpOMqfiBew
 cETWnEVmni4JgHtgaiRPaC72Lw7TL+5410u590M9Zg7gMRvdQwN2HJw9pPKY0S5MxZE9
 Sufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RXHY67Bzpgcy/6ww9gNs35EIqABdAzpYQa8iqAsMeIo=;
 b=ABr4YuJ7J9D9csPA5WmC7TlEYuhLdF35IDhwZkjZtWBxHG/8LMHS6M662OZFVFVeUW
 AcDg+pwOra/OJdYTaukx5OaX1/l0nI439mfPg+SsN9eKag7fHVbqlh60INaPE8ZmNLj6
 CZKAz+onfpnriWYp9jUKnI32QyYCgI0asMIF9MbIHAz9RuwjVQB6Rci0vDiJTmKKAZUd
 8Y2lT+7laS3KONqY+LTwwez7cjsdFgaymAWod6jTYW2+N1vgJUa/GyRstOFNdzPBxnPr
 /+GVJAAPQEZltnJ0hfloqrCHkpCfADkIR5oIJOr7u3EHN2Xj7/KZUFPmCjxJTP9EXBmI
 F5AQ==
X-Gm-Message-State: AOAM532BZ2y9oeilhlG7CthVv4/+VDYGWhMOvLtXB91Qp31V7odd8nM4
 Driz/UCKufJ3tNyg9ZpgLd32Fz+t2P2g4b+zudo=
X-Google-Smtp-Source: ABdhPJy0uXSGN9+FPyejLWK6fpGeZ5EC21h+XMmAnF3+zXLZ3qUNMsXFfYwGnuJIpuIvD0/Dg9D9ArA6EdPNHgXfuRk=
X-Received: by 2002:a17:906:faec:: with SMTP id
 lu44mr28930061ejb.527.1600327542555; 
 Thu, 17 Sep 2020 00:25:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200916193101.511600-1-ehabkost@redhat.com>
 <CAJ+F1CLo=mz6LhRTx0PTF-NiabiaCNwm-U=7VEhQXUmryQoqvw@mail.gmail.com>
 <40730966-469a-de4d-29bd-03c7c409b3cf@redhat.com>
In-Reply-To: <40730966-469a-de4d-29bd-03c7c409b3cf@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 17 Sep 2020 11:25:30 +0400
Message-ID: <CAJ+F1CL+mBt3c+GW3DPcfJROrpxWFFM_4vXGQqRb+E9ceS7cag@mail.gmail.com>
Subject: Re: [PATCH 0/3] qom: Replace INTERFACE_CHECK with OBJECT_CHECK
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000b2cad205af7d4a25"
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ej1-x644.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000b2cad205af7d4a25
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, Sep 17, 2020 at 11:19 AM Philippe Mathieu-Daud=C3=A9 <philmd@redhat=
.com>
wrote:

> On 9/16/20 11:31 PM, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Wed, Sep 16, 2020 at 11:35 PM Eduardo Habkost <ehabkost@redhat.com
> > <mailto:ehabkost@redhat.com>> wrote:
> >
> >     This series replaces INTERFACE_CHECK with OBJECT_CHECK because
> >     both macros are exactly the same.
> >
> >     The last patch is a new run of the OBJECT_CHECK ->
> >     DECLARE*_CHECKER* converter script that will convert the former
> >     INTERFACE_CHECK-based macros.
> >
> >
> > Well, at least having a different macro allows to tweak qom
> > implementation or replace it with something different more easily.
> >
> > I have some wip branch somewhere where I actually made Interface a
> > different beast than Object (it was saving some fields, and avoiding
> > some potentially wrong casts iirc - I didn't bother to upstream that
> > yet). Also I have a different branch where I played with GObject to
> > replace qom. In both cases, your proposal would have, or would make, th=
e
> > work more complicated.
>
> Considering "wip branch not bothered to upstream" as "fork",
> your comment from [*] applies here...
>
>   You can't blame upstream from doing cleanups and modernization, or
>   stagnating. Forks are forks, with all the pain they carry. If they
>   want to avoid the maintenance cost, they have to do the extra effort
>   to get it upstream. This is also a "sneaky way" to remind them that
>   effort is better spent in this direction.
>
> [*] https://www.mail-archive.com/qemu-devel@nongnu.org/msg720284.html
>
>
Fair enough. Note I didn't nack it, but in general the proposal seems to
blurry some worthy semantic difference between object & interface. Maybe
#define alias INTERFACE_CHECK with OBJECT_CHECK instead ?

--=20
Marc-Andr=C3=A9 Lureau

--000000000000b2cad205af7d4a25
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Sep 17, 2020 at 11:19 AM Ph=
ilippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com">philmd@r=
edhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">On 9/16/20 11:31 PM, Marc-Andr=C3=A9 Lureau wrote:<br>
&gt; Hi<br>
&gt; <br>
&gt; On Wed, Sep 16, 2020 at 11:35 PM Eduardo Habkost &lt;<a href=3D"mailto=
:ehabkost@redhat.com" target=3D"_blank">ehabkost@redhat.com</a><br>
&gt; &lt;mailto:<a href=3D"mailto:ehabkost@redhat.com" target=3D"_blank">eh=
abkost@redhat.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0This series replaces INTERFACE_CHECK with OBJECT_CH=
ECK because<br>
&gt;=C2=A0 =C2=A0 =C2=A0both macros are exactly the same.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0The last patch is a new run of the OBJECT_CHECK -&g=
t;<br>
&gt;=C2=A0 =C2=A0 =C2=A0DECLARE*_CHECKER* converter script that will conver=
t the former<br>
&gt;=C2=A0 =C2=A0 =C2=A0INTERFACE_CHECK-based macros.<br>
&gt; <br>
&gt; <br>
&gt; Well, at least having a different macro allows to tweak qom<br>
&gt; implementation or replace it with something different more easily.<br>
&gt; <br>
&gt; I have some wip branch somewhere where I actually made Interface a<br>
&gt; different beast than Object (it was saving some fields, and avoiding<b=
r>
&gt; some potentially wrong casts iirc - I didn&#39;t bother to upstream th=
at<br>
&gt; yet). Also I have a different branch where I played with GObject to<br=
>
&gt; replace qom. In both cases, your proposal would have, or would make, t=
he<br>
&gt; work more complicated.<br>
<br>
Considering &quot;wip branch not bothered to upstream&quot; as &quot;fork&q=
uot;,<br>
your comment from [*] applies here...<br>
<br>
=C2=A0 You can&#39;t blame upstream from doing cleanups and modernization, =
or<br>
=C2=A0 stagnating. Forks are forks, with all the pain they carry. If they<b=
r>
=C2=A0 want to avoid the maintenance cost, they have to do the extra effort=
<br>
=C2=A0 to get it upstream. This is also a &quot;sneaky way&quot; to remind =
them that<br>
=C2=A0 effort is better spent in this direction.<br>
<br>
[*] <a href=3D"https://www.mail-archive.com/qemu-devel@nongnu.org/msg720284=
.html" rel=3D"noreferrer" target=3D"_blank">https://www.mail-archive.com/qe=
mu-devel@nongnu.org/msg720284.html</a><br>
<br>
</blockquote></div><div><br></div><div>Fair enough. Note I didn&#39;t nack =
it, but in general the proposal seems to blurry some worthy semantic differ=
ence between object &amp; interface. Maybe #define alias INTERFACE_CHECK wi=
th OBJECT_CHECK instead ?<br></div><br>-- <br><div dir=3D"ltr" class=3D"gma=
il_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--000000000000b2cad205af7d4a25--

