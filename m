Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF969C4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 10:35:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A9D62075F
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 10:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPFJJHyr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A9D62075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNCyx-0001JH-CY
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 06:35:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50376)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kNCy2-0000ir-M1
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 06:34:42 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:39632)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kNCy0-00071p-BG
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 06:34:42 -0400
Received: by mail-ed1-x543.google.com with SMTP id e22so5779601edq.6
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 03:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SemIGdCwYLKCKaF9vpPmwJI19fSYT8opFhUWXtWKWUY=;
 b=ZPFJJHyrISS8qSilg4PGQqfvb0mICsBuTwxSQRa9tVM70xDusohff5fc7HnRiNFw4I
 jg6MwsKAPtWnV1Cc05hIQwKiF4Gv9Y4yRLsBNgoBFgpl6jQ/M+MNra+UoURhrsqexscb
 rd9TK67vxQmnUyFzAQsl+IpolKhTDtyP70XcbmyVWQfYilhU8qCIGz5DkBgFd/xJQq3o
 PZ05gV+eTMJ3qY4FRrzVBkomYTag9GX6bRm81zN4ya+xpyZlI5+OtfTGuoW8sibfFdl6
 GMTpYlo3hQb7xAb2gMr2HERtrAO5pLDUw5NIFAXknAnUpkarj9BvMOfWQnbyrXK802Me
 fcWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SemIGdCwYLKCKaF9vpPmwJI19fSYT8opFhUWXtWKWUY=;
 b=QQKJqvK5UIsS6k0Vfmb6Kxk0YmTToT28vQPs8hHBeQGgiwOEO5CWShuPU/u4fJQN+S
 wxQxQjdUGH5Osbdj/Y8PEDcTI/QbJo/h/6hCibr4lewCUDPR3X5nXUaFQx2EVI+QAT1h
 h1ZbAOfLW8RALX58uSMIjfQpvAijrVgKQFJSsGZIzDLiuSy91qDeb4pqzAoF3wlphCXP
 3uGtoAeIhJ2upEnk1eYVZtqjnUCVjXYS6/ulHcB6J3uPeY/O4gAUe0oIGUI2DC+ismSC
 BAuPZ3e7iQTDfU8zcg6AG1gQPMHhgVrMS7fE4R+0Aba/mer9RCPHR4jD22UQlgG9U313
 PVMw==
X-Gm-Message-State: AOAM531gJGg/eL3MY28f8FksDoX6jGlftEI4kk0FmPCsZFjWHO5woqlX
 jnoWpbeBNw9RT9pI3T2P/mSS4G2xVdDzxnBEdHW1noc7Usf/Cw==
X-Google-Smtp-Source: ABdhPJzLMAYgFepgOdKWF/bZ02eJMxe0OYQZtvzx0v+nt38+pIcRIy6JNmkTm/lE5uimigyaAuaUVpd8KyTNf3TrioY=
X-Received: by 2002:aa7:ca17:: with SMTP id y23mr2538756eds.245.1601375678554; 
 Tue, 29 Sep 2020 03:34:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200910174850.716104-1-marcandre.lureau@redhat.com>
 <87mu1j8p7p.fsf@dusky.pond.sub.org>
 <CAMxuvayvRfjUMYDiB5fm5QBD76kfD8-G1wTEucQTBbZUtnwXrA@mail.gmail.com>
 <874knpluez.fsf@dusky.pond.sub.org>
 <CAJ+F1CLCT3RpZF8JDYayqkKxFu76vy+q6GUjofZV3JF_YDvxng@mail.gmail.com>
 <9d6215d4-d0cd-67e4-3048-77127194f7e8@redhat.com>
 <CAJ+F1CLowpdHaJ58Vt7GYukAYvYAfuEJvnuw_ZM5kO_4=gh9XA@mail.gmail.com>
 <8c1783d1-70f4-d751-3d5d-83459cb1db45@redhat.com>
In-Reply-To: <8c1783d1-70f4-d751-3d5d-83459cb1db45@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 29 Sep 2020 14:34:26 +0400
Message-ID: <CAJ+F1CJgEe3++UHDfT3iOGyu+r1tM4A_9jRXoKC0P-k-Mhq29w@mail.gmail.com>
Subject: Re: [PATCH] PoC: Rust binding for QAPI (qemu-ga only, for now)
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000078e4a905b07154d8"
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ed1-x543.google.com
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

--00000000000078e4a905b07154d8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Tue, Sep 29, 2020 at 2:15 PM Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 29/09/20 09:45, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Tue, Sep 22, 2020 at 9:08 PM Paolo Bonzini <pbonzini@redhat.com
> > <mailto:pbonzini@redhat.com>> wrote:
> >     > So a QEMU D-Bus interface could have a name like org.qemu.Qemu51,
> >     > org.qemu.Qemu52.. for example, if we can't provide better API
> >     stability...
> >
> >     That would be a problem for backports.
> >
> > Yes..  Backports could expose a subset of the new version interface? Or
> > the interface can be divided for each Qmp command. (unorthodox)
>
> That seems like a workaround for an IDL that is not the right solution
> for the problem.
>
> >        qapi::qga::commands::GuestShutdown::new()
> >            .mode("halt")
> >            .invoke_on(qapi_channel)?;
> >
> >
> > Or simply use the same approach as qapi-rs
> > (https://github.com/arcnmx/qapi-rs) which is  simply generating data
> > structures based on the schema, and not binding commands to Rust
> > functions for ex.
> >
> > qga.execute(&qga::guest_shutdown { mode: Some(GuestShutdownMode::Halt) =
})
>
>
> That would not be backwards compatible as you would have to set all
> optional fields.  Every time the command grows a new optional argument,
> all clients would have to specify it; if a command becomes optional,
> you'd have to add Some() around it.  So I would say that...
>
>
Not necessarily, with ..default::Default()

> Less idiomatic, but it also works around the optional arguments and
> > ordering issue.
>
> ...  the builder pattern is not a workaround: it's the best and most
> common Rust idiom to achieve what QAPI expresses as optional fields.
> Likewise for keyword-only arguments in Python.
>

Except QAPI makes all fields potentially optional (and unordered), that's
not idiomatic.


> > Yes, the python binding will have a similar issue. And if we want to ad=
d
> > typing to the mix, representing everything as a dict is not going to
> > help much. Fortunately, there are other options I believe. But I would
> > rather aim for the obvious, having non-optional & ordered arguments, an=
d
> > interface/methods versioning.
>
> You shouldn't just state what you want; you really should take a look at
> how the ability to add optional arguments has been used in the past, and
> see if an alternative RPC without optional and unordered arguments would
> have been as effective.  D-Bus is probably a perfectly good API for
> qemu-ga.  The experience with qemu-ga however does not necessarily
> extend to QEMU.
>
> The main issue with D-Bus is that it conflates the transport and the IDL
> so that you have to resort to passing arguments as key-value pairs.  QMP
>

D-Bus is machine-level oriented, it's easy to bind to various languages, it
can be pretty efficient too. It's not designed to be a good network RPC.
QMP tries to be a bit of both, but is perhaps not good enough in either.

does the same, but the IDL is much more flexible and not QEMU-specific,
> so we don't pay as high a price.  Remember that while the specific
> transport of QMP ("JSON dictionaries over a socket with 'execute' and
> 'arguments' keys") is QEMU-specific, the concept of using JSON payloads
> for RPC is very common.  For example, REST APIs almost invariably use
> JSON and the resulting API even "feel" somewhat similar to QMP.
>
> In fact, The first Google result for "openapi backwards compatible
> extensions"
> (
> https://github.com/zalando/restful-api-guidelines/blob/master/chapters/co=
mpatibility.adoc#107
> )
> might as well be written for QMP:
>
> * [server] Add only optional, never mandatory fields.
>
> * [client] Be tolerant with unknown fields in the payload
>
> * [server] Unknown input fields in payload or URL should not be ignored
>
> * [client] API clients consuming data must not assume that objects are
> closed for extension
>
> * [server] When changing your RESTful APIs, do so in a compatible way
> and avoid generating additional API versions
>
> * [server] MUST not use URI versioning
>
> and so on.
>
> If you want to "reinvent" QMP, instead of focusing on D-Bus you should
> take a look at alternative IDLs and protocols (D-Bus is one but there's
> also Protobuf and Flexbuffers), see how QAPI declarations would map to
> those protocols, see how you would deal with extensibility, and rank
> them according to various criteria.  For example:
>
> * JSON "just works" but needs a custom code generator and imposes some
> extra complexity on the clients for the simplest commands
>
> * D-Bus has a good ecosystem and would keep simple commands simpler but
> has issues with upgrade paths and is uglier for complex commands
>
> * Protobufs probably would also just work and would have better code
> generators, but would require some kind of lint to ensure
> backwards-compatibility
>
>

Again, the issues we are discussing are not specific to binding QMP over
D-Bus. Binding QMP to various languages has similar problems. Perhaps those
problems are minor, perhaps we can find decent solutions, like the one you
suggest to use Rust builder pattern for commands. I think they are not
great, as I tried to explain with the versioning and runtime issues that
you have to take into account anyway at the client level. I would rather
make those problems solved at the server level, that doesn't require any
change to QMP today, just a more careful consideration when making changes
(and probably some tools to help enforce some stability).



--=20
Marc-Andr=C3=A9 Lureau

--00000000000078e4a905b07154d8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 29, 2020 at 2:15 PM Pao=
lo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On=
 29/09/20 09:45, Marc-Andr=C3=A9 Lureau wrote:<br>
&gt; Hi<br>
&gt; <br>
&gt; On Tue, Sep 22, 2020 at 9:08 PM Paolo Bonzini &lt;<a href=3D"mailto:pb=
onzini@redhat.com" target=3D"_blank">pbonzini@redhat.com</a><br>
&gt; &lt;mailto:<a href=3D"mailto:pbonzini@redhat.com" target=3D"_blank">pb=
onzini@redhat.com</a>&gt;&gt; wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; So a QEMU D-Bus interface could have a name li=
ke org.qemu.Qemu51,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; org.qemu.Qemu52.. for example, if we can&#39;t=
 provide better API<br>
&gt;=C2=A0 =C2=A0 =C2=A0stability...<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0That would be a problem for backports.<br>
&gt; <br>
&gt; Yes..=C2=A0 Backports could expose a subset of the new version interfa=
ce? Or<br>
&gt; the interface can be divided for each Qmp command. (unorthodox)<br>
<br>
That seems like a workaround for an IDL that is not the right solution<br>
for the problem.<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0qapi::qga::commands::GuestShutdown::ne=
w()<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0.mode(&quot;halt&quot;)<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0.invoke_on(qapi_channel)=
?;<br>
&gt; <br>
&gt; <br>
&gt; Or simply use the same approach as qapi-rs<br>
&gt; (<a href=3D"https://github.com/arcnmx/qapi-rs" rel=3D"noreferrer" targ=
et=3D"_blank">https://github.com/arcnmx/qapi-rs</a>) which is=C2=A0 simply =
generating data<br>
&gt; structures based on the schema, and not binding commands to Rust<br>
&gt; functions for ex.<br>
&gt; <br>
&gt; qga.execute(&amp;qga::guest_shutdown { mode: Some(GuestShutdownMode::H=
alt) })<br>
<br>
<br>
That would not be backwards compatible as you would have to set all<br>
optional fields.=C2=A0 Every time the command grows a new optional argument=
,<br>
all clients would have to specify it; if a command becomes optional,<br>
you&#39;d have to add Some() around it.=C2=A0 So I would say that...<br>
<br></blockquote><div><br></div><div>Not necessarily, with ..default::Defau=
lt()</div><div> <br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>
&gt; Less idiomatic, but it also works around the optional arguments and<br=
>
&gt; ordering issue.<br>
<br>
...=C2=A0 the builder pattern is not a workaround: it&#39;s the best and mo=
st<br>
common Rust idiom to achieve what QAPI expresses as optional fields.<br>
Likewise for keyword-only arguments in Python.<br></blockquote><div><br></d=
iv><div>Except QAPI makes all fields potentially optional (and unordered), =
that&#39;s not idiomatic.<br></div><div>=C2=A0</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">
&gt; Yes, the python binding will have a similar issue. And if we want to a=
dd<br>
&gt; typing to the mix, representing everything as a dict is not going to<b=
r>
&gt; help much. Fortunately, there are other options I believe. But I would=
<br>
&gt; rather aim for the obvious, having non-optional &amp; ordered argument=
s, and<br>
&gt; interface/methods versioning.<br>
<br>
You shouldn&#39;t just state what you want; you really should take a look a=
t<br>
how the ability to add optional arguments has been used in the past, and<br=
>
see if an alternative RPC without optional and unordered arguments would<br=
>
have been as effective.=C2=A0 D-Bus is probably a perfectly good API for<br=
>
qemu-ga.=C2=A0 The experience with qemu-ga however does not necessarily<br>
extend to QEMU.<br>
<br>
The main issue with D-Bus is that it conflates the transport and the IDL<br=
>
so that you have to resort to passing arguments as key-value pairs.=C2=A0 Q=
MP<br></blockquote><div><br></div><div>D-Bus is machine-level oriented, it&=
#39;s easy to bind to various languages, it can be pretty efficient too. It=
&#39;s not designed to be a good network RPC. QMP tries to be a bit of both=
, but is perhaps not good enough in either.<br></div><div><br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">
does the same, but the IDL is much more flexible and not QEMU-specific,<br>
so we don&#39;t pay as high a price.=C2=A0 Remember that while the specific=
<br>
transport of QMP (&quot;JSON dictionaries over a socket with &#39;execute&#=
39; and<br>
&#39;arguments&#39; keys&quot;) is QEMU-specific, the concept of using JSON=
 payloads<br>
for RPC is very common.=C2=A0 For example, REST APIs almost invariably use<=
br>
JSON and the resulting API even &quot;feel&quot; somewhat similar to QMP.<b=
r>
<br></blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
In fact, The first Google result for &quot;openapi backwards compatible<br>
extensions&quot;<br>
(<a href=3D"https://github.com/zalando/restful-api-guidelines/blob/master/c=
hapters/compatibility.adoc#107" rel=3D"noreferrer" target=3D"_blank">https:=
//github.com/zalando/restful-api-guidelines/blob/master/chapters/compatibil=
ity.adoc#107</a>)<br>
might as well be written for QMP:<br>
<br>
* [server] Add only optional, never mandatory fields.<br>
<br>
* [client] Be tolerant with unknown fields in the payload<br>
<br>
* [server] Unknown input fields in payload or URL should not be ignored<br>
<br>
* [client] API clients consuming data must not assume that objects are<br>
closed for extension<br>
<br>
* [server] When changing your RESTful APIs, do so in a compatible way<br>
and avoid generating additional API versions<br>
<br>
* [server] MUST not use URI versioning<br>
<br>
and so on.<br>
<br>
If you want to &quot;reinvent&quot; QMP, instead of focusing on D-Bus you s=
hould<br>
take a look at alternative IDLs and protocols (D-Bus is one but there&#39;s=
<br>
also Protobuf and Flexbuffers), see how QAPI declarations would map to<br>
those protocols, see how you would deal with extensibility, and rank<br>
them according to various criteria.=C2=A0 For example:<br>
<br>
* JSON &quot;just works&quot; but needs a custom code generator and imposes=
 some<br>
extra complexity on the clients for the simplest commands<br>
<br>
* D-Bus has a good ecosystem and would keep simple commands simpler but<br>
has issues with upgrade paths and is uglier for complex commands<br>
<br>
* Protobufs probably would also just work and would have better code<br>
generators, but would require some kind of lint to ensure<br>
backwards-compatibility<br>
<br>
</blockquote><div><br></div><div><div><br></div><div>Again, the issues we a=
re discussing are not specific to binding QMP over D-Bus. Binding QMP to va=
rious languages has similar problems. Perhaps those problems are minor, per=
haps we can find decent solutions, like the one you suggest to use Rust bui=
lder pattern for commands. I think they are not great, as I tried to explai=
n with the versioning and runtime issues that you have to take into account=
 anyway at the client level. I would rather make those problems solved at t=
he server level, that doesn&#39;t require any change to QMP today, just a m=
ore careful consideration when making changes (and probably some tools to h=
elp enforce some stability).<br></div></div><div><br></div></div><br clear=
=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--00000000000078e4a905b07154d8--

