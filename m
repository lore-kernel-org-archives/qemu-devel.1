Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC2BC4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:53:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F27C12076A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRWgV+Fy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F27C12076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNAS2-0001CG-1E
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 03:53:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35512)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kNAL7-0003p1-Hw
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:46:21 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:43313)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kNAL0-0005TS-5y
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:46:21 -0400
Received: by mail-ej1-x642.google.com with SMTP id o8so13600887ejb.10
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 00:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=o7bAShrKNpeMDd+m+nDXxzh3bFReZJMlx+wmgquxbTQ=;
 b=YRWgV+FyNPptq5guYs57cAxwEqUw36s/Booy7yt2uV+s1okgcmW+aKC30zXzARXmM8
 RUKe3tQeZhx1CEfs7nKYs5jDmjBQExikWwKjP/27uALzdMKNvIEkb4Mhl8pPT0S8cnqC
 MHQuKq5MJa0pxI3dtBixAHPf2mSZCmEPkclfc2Gy0Igz/nGIyQ8UbPWnmFnRijsRe7x6
 fkgk2LRzEKWvuDrQaBXQrBfIJlX2Fuxc7SB29ZMdfrzWRZml83pYVw/hHnmE2foyIl3F
 LeNs/VOLeQR7UsYjHMSuSzwWThU86rmgekkG3Q2dfDfOpj6wtrBzck1oRGfhGyGT1gA7
 TWaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=o7bAShrKNpeMDd+m+nDXxzh3bFReZJMlx+wmgquxbTQ=;
 b=PT3VFYH8M0nxc/CdeU8B/wI+PZBxjALGqEv3rDKuGvugurpK+2yPMS8i/70/mgq+xY
 k1xu8f1ATBA3ZwXhew/Uvt9D2RmdTj1S/lQK/zbYrBQ1la1tc06cLtUFt+oL6ntXpCmc
 ew9QTyjz+bqrwRgAjDcLw3tphPgXRQlkCQ4coltefZoOxS8CxshRRd7RqEwq4QevKNdf
 QsP6X4hqFbNxT/9+Yk3+ILSUBWXigCO/r7kqfY7SG/ts7f47C4K4TqGIGe49iY3WRf72
 gRU7rt+SdWI1EezbGlp98C/OA8XtnXrAAh+P1nDnILzpNROX9bnuOxrTBWXbd3/oFFyi
 kbaQ==
X-Gm-Message-State: AOAM5339NPDmRmgneJUkJ33xmvvQ5lrKReiHOjjLdbi6ivjj1WW6Mgs1
 DKp71kJ5T2nDBYdvUrA1nvjSQT868X87vgw2mFM=
X-Google-Smtp-Source: ABdhPJxLhSGt7/dC6OiO6c2lMRtga8EEepAwPT/Ic4d27NfQRNX1IhU1vrHJ6QFrYqRoTSKwUQ6If+BqBMNdId/vSLc=
X-Received: by 2002:a17:906:4a51:: with SMTP id
 a17mr2508754ejv.381.1601365571480; 
 Tue, 29 Sep 2020 00:46:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200910174850.716104-1-marcandre.lureau@redhat.com>
 <87mu1j8p7p.fsf@dusky.pond.sub.org>
 <CAMxuvayvRfjUMYDiB5fm5QBD76kfD8-G1wTEucQTBbZUtnwXrA@mail.gmail.com>
 <874knpluez.fsf@dusky.pond.sub.org>
 <CAJ+F1CLCT3RpZF8JDYayqkKxFu76vy+q6GUjofZV3JF_YDvxng@mail.gmail.com>
 <9d6215d4-d0cd-67e4-3048-77127194f7e8@redhat.com>
In-Reply-To: <9d6215d4-d0cd-67e4-3048-77127194f7e8@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 29 Sep 2020 11:45:58 +0400
Message-ID: <CAJ+F1CLowpdHaJ58Vt7GYukAYvYAfuEJvnuw_ZM5kO_4=gh9XA@mail.gmail.com>
Subject: Re: [PATCH] PoC: Rust binding for QAPI (qemu-ga only, for now)
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000000b2eb205b06efa03"
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
Cc: "P. Berrange, Daniel" <berrange@redhat.com>,
 Sergio Lopez Pascual <slp@redhat.com>, "Hajnoczi, Stefan" <stefanha@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000000b2eb205b06efa03
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Tue, Sep 22, 2020 at 9:08 PM Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 22/09/20 18:35, Marc-Andr=C3=A9 Lureau wrote:
> > The D-Bus specification doesn't detail versioning much. What is
> > recommended is to have the version number as part of the interface name
> > (kinda like soname):
> > http://0pointer.de/blog/projects/versioning-dbus.html (this is
> > documented in several places iirc)
> >
> > So a QEMU D-Bus interface could have a name like org.qemu.Qemu51,
> > org.qemu.Qemu52.. for example, if we can't provide better API
> stability...
>
> That would be a problem for backports.
>
>
Yes..  Backports could expose a subset of the new version interface? Or the
interface can be divided for each Qmp command. (unorthodox)

It seems to me that the bindings issue is only a problem if we insist on
> having positional arguments like we do for C, but if we can avoid
> functions with a zillion arguments we could.  For example in Rust, it's
> idiomatic to use the builder pattern
>
>     let thread =3D thread::Builder::new()
>         .name("foo".into())
>         .stack_size(65536)
>         .spawn(run_thread)?;
>     thread.join()?;
>
> and I think the same would work in Go or even C++.  It would look like
>
>    qapi::qga::commands::GuestShutdown::new()
>        .mode("halt")
>        .invoke_on(qapi_channel)?;
>
>
Or simply use the same approach as qapi-rs (
https://github.com/arcnmx/qapi-rs) which is  simply generating data
structures based on the schema, and not binding commands to Rust functions
for ex.

qga.execute(&qga::guest_shutdown { mode: Some(GuestShutdownMode::Halt) })

Less idiomatic, but it also works around the optional arguments and
ordering issue.

In both cases, the client interface should be versionized (since some
fields may be added or becoming optional, return value may appear etc), and
only at runtime can you actually verify what is actually supported.

In Python, you can use keyword arguments and there are even keyword-only
> arguments ("def f(*, key1, key2)"), like
>
>     qapi.qga.GuestFileOpen(path=3D"/etc/passwd").invoke_on(qapi_channel);
>
>
Yes, the python binding will have a similar issue. And if we want to add
typing to the mix, representing everything as a dict is not going to help
much. Fortunately, there are other options I believe. But I would rather
aim for the obvious, having non-optional & ordered arguments, and
interface/methods versioning.

When you do something like this QMP-style APIs are not a problem.
> FlatBuffers is another serialization format that supports this kind of
> extensibility (https://google.github.io/flatbuffers/ explicitly compares
> it to JSON, even).
>

Well, I wouldn't say it's not a problem. It makes working with QMP as a
client quite an unpleasant experience overall imho...

--=20
Marc-Andr=C3=A9 Lureau

--0000000000000b2eb205b06efa03
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 22, 2020 at 9:08 PM Pao=
lo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On=
 22/09/20 18:35, Marc-Andr=C3=A9 Lureau wrote:<br>
&gt; The D-Bus specification doesn&#39;t detail versioning much. What is<br=
>
&gt; recommended is to have the version number as part of the interface nam=
e<br>
&gt; (kinda like soname):<br>
&gt; <a href=3D"http://0pointer.de/blog/projects/versioning-dbus.html" rel=
=3D"noreferrer" target=3D"_blank">http://0pointer.de/blog/projects/versioni=
ng-dbus.html</a> (this is<br>
&gt; documented in several places iirc)<br>
&gt; <br>
&gt; So a QEMU D-Bus interface could have a name like org.qemu.Qemu51,<br>
&gt; org.qemu.Qemu52.. for example, if we can&#39;t provide better API stab=
ility...<br>
<br>
That would be a problem for backports.<br>
<br></blockquote><div><br></div><div>Yes..=C2=A0 Backports could expose a s=
ubset of the new version interface? Or the interface can be divided for eac=
h Qmp command. (unorthodox)<br></div><div> <br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">
It seems to me that the bindings issue is only a problem if we insist on<br=
>
having positional arguments like we do for C, but if we can avoid<br>
functions with a zillion arguments we could.=C2=A0 For example in Rust, it&=
#39;s<br>
idiomatic to use the builder pattern<br>
<br>
=C2=A0 =C2=A0 let thread =3D thread::Builder::new()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .name(&quot;foo&quot;.into())<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .stack_size(65536)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .spawn(run_thread)?;<br>
=C2=A0 =C2=A0 thread.join()?;<br>
<br>
and I think the same would work in Go or even C++.=C2=A0 It would look like=
<br>
<br>
=C2=A0 =C2=A0qapi::qga::commands::GuestShutdown::new()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0.mode(&quot;halt&quot;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0.invoke_on(qapi_channel)?;<br>
<br></blockquote><div><br></div><div>Or simply use the same approach as qap=
i-rs (<a href=3D"https://github.com/arcnmx/qapi-rs">https://github.com/arcn=
mx/qapi-rs</a>) which is=C2=A0 simply generating data structures based on t=
he schema, and not binding commands to Rust functions for ex.</div><div><br=
></div><div>qga.execute(&amp;qga::guest_shutdown { mode: Some(GuestShutdown=
Mode::Halt) })</div><div><br></div><div>Less idiomatic, but it also works a=
round the optional arguments and ordering issue.<br></div><div><br></div><d=
iv>In both cases, the client interface should be versionized (since some fi=
elds may be added or becoming optional, return value may appear etc), and o=
nly at runtime can you actually verify what is actually supported.</div><di=
v><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">In Python, yo=
u can use keyword arguments and there are even keyword-only<br>
arguments (&quot;def f(*, key1, key2)&quot;), like<br>
<br>
=C2=A0 =C2=A0 qapi.qga.GuestFileOpen(path=3D&quot;/etc/passwd&quot;).invoke=
_on(qapi_channel);<br>
<br></blockquote><div><br></div><div>Yes, the python binding will have a si=
milar issue. And if we want to add typing to the mix, representing everythi=
ng as a dict is not going to help much. Fortunately, there are other option=
s I believe. But I would rather aim for the obvious, having non-optional &a=
mp; ordered arguments, and interface/methods versioning.<br></div><div><br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">
When you do something like this QMP-style APIs are not a problem.<br>
FlatBuffers is another serialization format that supports this kind of<br>
extensibility (<a href=3D"https://google.github.io/flatbuffers/" rel=3D"nor=
eferrer" target=3D"_blank">https://google.github.io/flatbuffers/</a> explic=
itly compares<br>
it to JSON, even).<br></blockquote><div><br></div><div>Well, I wouldn&#39;t=
 say it&#39;s not a problem. It makes working with QMP as a client quite an=
 unpleasant experience overall imho...<br></div></div><br>-- <br><div dir=
=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--0000000000000b2eb205b06efa03--

