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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFD8C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 11:36:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EE6D22207
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 11:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZodrbDS/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EE6D22207
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNDvV-0000QJ-DP
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 07:36:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35860)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kNDuD-0007jY-Am
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 07:34:49 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:33042)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kNDuA-0007De-RZ
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 07:34:49 -0400
Received: by mail-ej1-x643.google.com with SMTP id j11so14552157ejk.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 04:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DEUy71vj+FhIBOXVwtpgyizlZ5mTKxHugER6o5FDIL4=;
 b=ZodrbDS/2RR9xp2nEiMKd+KJy8RR10whfTtwC+dPhz9gSCHr1OvEDYqCkD8s3n3oZN
 TGDvJ6XVz5enwboxPELFFF4v4rllCznC2Vd+sA1ZPm/3aPZ5F9KojJQJuqHFxr2FzYQ2
 1NzubVe92/XQ2MlUWz2OVr8XViucMt6pCtIuIWehpZ92QQ8ZgCkG/TwWyWKSTZtQXv6Y
 IifvGAuWxe4cg8Yl8xKTjA6EL8dxs5AHaxcQB2Or2MiDVvC++7Ftsc3yOxPcVQ+MbVY4
 +jTcm/YRGs302dmCoOUbtqqaE+8NLDER9bveCIZHXEiZFDeRgTXDzBHVegq0xv/i1sfO
 6r3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DEUy71vj+FhIBOXVwtpgyizlZ5mTKxHugER6o5FDIL4=;
 b=Ygp6JM1TuDl6c8yRWoRN19Hj9Z1JeYoB7I+BT633lbfc5vPeXru7Z95Q+2Bqk7g+/A
 Z/qxumaUhuYjGPoHb2gSw2t5eRbwsa7uGaAH5OLUyqWfspuIsdPUzaGW2XBybfK0QA6S
 0eUr1Ne9yvNW2Yh2KxbTyubxtCp2m0nnnTZkhcqdtPpRtIqqTf6CvbI+xeacgX89piui
 RGMy5mzJnEmx+cjGAKyobgQmnIPONlSia1z23gA7URO+deMxrDFInL+LSIcP8HFxCFDT
 qWspvzThW/WZGoaFED5h92pWsqzBGBjd7sPFaWKmgRCfmkT7RAFJ2RjjD0PopAU+yQss
 gZ7w==
X-Gm-Message-State: AOAM533g1bhXvJuEc46whpAjvvZTh8XI0WWtCICj1uLeLL7DcF+ZajLA
 NgN7KFZq3JMMhHhjxFXMunhjK71sO+0KQ714GII=
X-Google-Smtp-Source: ABdhPJwMfpOJAdk/+Px2bCWhT7FsVbWHTh2R9bwGnAsHkFEP6q4eWrkLBdm7ZMzkILnDSI4TUpaB5/kJe2X19BZXBEE=
X-Received: by 2002:a17:906:4a51:: with SMTP id
 a17mr3282464ejv.381.1601379284948; 
 Tue, 29 Sep 2020 04:34:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200910174850.716104-1-marcandre.lureau@redhat.com>
 <87mu1j8p7p.fsf@dusky.pond.sub.org>
 <CAMxuvayvRfjUMYDiB5fm5QBD76kfD8-G1wTEucQTBbZUtnwXrA@mail.gmail.com>
 <874knpluez.fsf@dusky.pond.sub.org>
 <CAJ+F1CLCT3RpZF8JDYayqkKxFu76vy+q6GUjofZV3JF_YDvxng@mail.gmail.com>
 <9d6215d4-d0cd-67e4-3048-77127194f7e8@redhat.com>
 <CAJ+F1CLowpdHaJ58Vt7GYukAYvYAfuEJvnuw_ZM5kO_4=gh9XA@mail.gmail.com>
 <8c1783d1-70f4-d751-3d5d-83459cb1db45@redhat.com>
 <CAJ+F1CJgEe3++UHDfT3iOGyu+r1tM4A_9jRXoKC0P-k-Mhq29w@mail.gmail.com>
 <fb20f8e4-6bc9-3518-a983-86fad1915e49@redhat.com>
In-Reply-To: <fb20f8e4-6bc9-3518-a983-86fad1915e49@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 29 Sep 2020 15:34:32 +0400
Message-ID: <CAJ+F1C+p-JLj_epZfLiag7CdJGfZUkFNOmzPTsjCkW=QQ07_3g@mail.gmail.com>
Subject: Re: [PATCH] PoC: Rust binding for QAPI (qemu-ga only, for now)
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000006e1bba05b0722b36"
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
Cc: "P. Berrange, Daniel" <berrange@redhat.com>,
 Sergio Lopez Pascual <slp@redhat.com>, "Hajnoczi, Stefan" <stefanha@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000006e1bba05b0722b36
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Tue, Sep 29, 2020 at 3:01 PM Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 29/09/20 12:34, Marc-Andr=C3=A9 Lureau wrote:
> >     That would not be backwards compatible as you would have to set all
> >     optional fields.  Every time the command grows a new optional
> argument,
> >     all clients would have to specify it; if a command becomes optional=
,
> >     you'd have to add Some() around it.  So I would say that...
> >
> >
> > Not necessarily, with ..default::Default()
>
> That's true, I always forget about .. (though you'd still have to add
> Some() for now-optional fields).
>
> >     > Less idiomatic, but it also works around the optional arguments a=
nd
> >     > ordering issue.
> >
> >     ...  the builder pattern is not a workaround: it's the best and mos=
t
> >     common Rust idiom to achieve what QAPI expresses as optional fields=
.
> >     Likewise for keyword-only arguments in Python.
> >
> > Except QAPI makes all fields potentially optional (and unordered),
> > that's not idiomatic.
>
> Yes, for some APIs you can always add hand-written, more idiomatic
> versions.  Or you could mark them as fixed-arguments in the schema and
> let the code generator do that (but then you need to add a compatibility
> check).  But that would be an explicit choice, not something required by
> the transport.
>

That's my point, if we agree on keeping arguments & members non-optional
and ordered, we are doing 50% of the job for nicer automated bindings.

Second half would probably be involving some version information in the
schema.


> > D-Bus is machine-level oriented, it's easy to bind to various languages=
,
> > it can be pretty efficient too. It's not designed to be a good network
> > RPC. QMP tries to be a bit of both, but is perhaps not good enough in
> > either.
>
> No, only tries to be a good network RPC; not a particularly efficient
> one, but future-proof.  And it mostly succeeds at that---with one
> notable exception: JSON parsers that mess up with numbers bigger than 2^5=
3.
>
> >     If you want to "reinvent" QMP, instead of focusing on D-Bus you
> should
> >     take a look at alternative IDLs and protocols (D-Bus is one but
> there's
> >     also Protobuf and Flexbuffers), see how QAPI declarations would map
> to
> >     those protocols, see how you would deal with extensibility, and ran=
k
> >     them according to various criteria.  For example:
> >
> >     * JSON "just works" but needs a custom code generator and imposes
> some
> >     extra complexity on the clients for the simplest commands
> >
> >     * D-Bus has a good ecosystem and would keep simple commands simpler
> but
> >     has issues with upgrade paths and is uglier for complex commands
> >
> >     * Protobufs probably would also just work and would have better cod=
e
> >     generators, but would require some kind of lint to ensure
> >     backwards-compatibility
> >
> > Again, the issues we are discussing are not specific to binding QMP ove=
r
> > D-Bus. Binding QMP to various languages has similar problems.
>
> Marc-Andr=C3=A9, we are totally in agreement about that!  The problem is =
that
> you have already decided what the solution looks like, and that's what
> I'm not sure about because your solution also implies completely
> revisiting the schema.
>

Did I? Which schema change are you (or I) implying? Versioning the
interface? It's necessary at the client level, unless everything is
dynamic, after introspection, which makes automated static bindings
impractical.


> I say there are many candidates (the ones I know are Protobuf and
> Flexbuffers) for serialization and many candidates for transport (REST
> and gRPC to begin with) in addition to the two {QMP,JSON} and
> {DBus,DBus} tuples.  We should at least look at how they do code
> generation before deciding that JSON is bad and DBus is good.
>

Contrary to what you believe I am not focusing so much on DBus here :) It
took about 200 loc to bind it, effortlessly (compared to sys<->rs
conversion). All it does is to expose the same API we have in the generated
C somehow (similar static types & functions - not all as a{sv} opaque
dictionaries).

It's easy for QEMU to generate a good static binding for C, because the
version always matches. For a client, you wouldn't be able to write a
similar idiomatic API in C, Rust, Python or Go, unfortunately.

Iow, I am not trying to sell DBus, I would like to make it easier to bind
QMP in general. (although I do believe that DBus is a better protocol than
QMP for local IPC, yes. And gRPC is probably better for remoting)

> I would rather make those problems solved at the server level, that
> > doesn't require any change to QMP today, just a more careful
> > consideration when making changes (and probably some tools to help
> > enforce some stability).
>
> Problem is, "more careful consideration when making changes" is not a
> small thing.  And other RPCs have evolved in a completely different
> space (REST APIs for web services) that have chosen the same tradeoffs
> as QMP, so why should we not learn from them?
>
>
I don't buy that generalization. A very recent protocol in this space, that
aims to be a good low-level RPC on Linux (for containers, cloud etc) is
varlink. (In many ways, we could compare it to QMP, but it lacks some
important features, like events)

varlink does non-optional members and versioning the same way I propose
here, for what I could tell. Although they use JSON, and have similar
transport "benefits", this basic rule allow them to have very decent
automated binding in various languages, without resorting to unorthodox
solutions, ex:
https://github.com/varlink/rust/blob/master/examples/example/src/main.rs

--=20
Marc-Andr=C3=A9 Lureau

--0000000000006e1bba05b0722b36
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 29, 2020 at 3:01 PM Pao=
lo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On=
 29/09/20 12:34, Marc-Andr=C3=A9 Lureau wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0That would not be backwards compatible as you would=
 have to set all<br>
&gt;=C2=A0 =C2=A0 =C2=A0optional fields.=C2=A0 Every time the command grows=
 a new optional argument,<br>
&gt;=C2=A0 =C2=A0 =C2=A0all clients would have to specify it; if a command =
becomes optional,<br>
&gt;=C2=A0 =C2=A0 =C2=A0you&#39;d have to add Some() around it.=C2=A0 So I =
would say that...<br>
&gt; <br>
&gt; <br>
&gt; Not necessarily, with ..default::Default()<br>
<br>
That&#39;s true, I always forget about .. (though you&#39;d still have to a=
dd<br>
Some() for now-optional fields).<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Less idiomatic, but it also works around the o=
ptional arguments and<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; ordering issue.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0...=C2=A0 the builder pattern is not a workaround: =
it&#39;s the best and most<br>
&gt;=C2=A0 =C2=A0 =C2=A0common Rust idiom to achieve what QAPI expresses as=
 optional fields.<br>
&gt;=C2=A0 =C2=A0 =C2=A0Likewise for keyword-only arguments in Python.<br>
&gt; <br>
&gt; Except QAPI makes all fields potentially optional (and unordered),<br>
&gt; that&#39;s not idiomatic.<br>
<br>
Yes, for some APIs you can always add hand-written, more idiomatic<br>
versions.=C2=A0 Or you could mark them as fixed-arguments in the schema and=
<br>
let the code generator do that (but then you need to add a compatibility<br=
>
check).=C2=A0 But that would be an explicit choice, not something required =
by<br>
the transport.<br></blockquote><div><br></div><div>That&#39;s my point, if =
we agree on keeping arguments &amp; members non-optional and ordered, we ar=
e doing 50% of the job for nicer automated bindings.</div></div><div class=
=3D"gmail_quote"><br></div><div class=3D"gmail_quote">Second half would pro=
bably be involving some version information in the schema.<br></div><div cl=
ass=3D"gmail_quote"><br></div><div class=3D"gmail_quote"><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
<br>
&gt; D-Bus is machine-level oriented, it&#39;s easy to bind to various lang=
uages,<br>
&gt; it can be pretty efficient too. It&#39;s not designed to be a good net=
work<br>
&gt; RPC. QMP tries to be a bit of both, but is perhaps not good enough in<=
br>
&gt; either.<br>
<br>
No, only tries to be a good network RPC; not a particularly efficient<br>
one, but future-proof.=C2=A0 And it mostly succeeds at that---with one<br>
notable exception: JSON parsers that mess up with numbers bigger than 2^53.=
<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0If you want to &quot;reinvent&quot; QMP, instead of=
 focusing on D-Bus you should<br>
&gt;=C2=A0 =C2=A0 =C2=A0take a look at alternative IDLs and protocols (D-Bu=
s is one but there&#39;s<br>
&gt;=C2=A0 =C2=A0 =C2=A0also Protobuf and Flexbuffers), see how QAPI declar=
ations would map to<br>
&gt;=C2=A0 =C2=A0 =C2=A0those protocols, see how you would deal with extens=
ibility, and rank<br>
&gt;=C2=A0 =C2=A0 =C2=A0them according to various criteria.=C2=A0 For examp=
le:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0* JSON &quot;just works&quot; but needs a custom co=
de generator and imposes some<br>
&gt;=C2=A0 =C2=A0 =C2=A0extra complexity on the clients for the simplest co=
mmands<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0* D-Bus has a good ecosystem and would keep simple =
commands simpler but<br>
&gt;=C2=A0 =C2=A0 =C2=A0has issues with upgrade paths and is uglier for com=
plex commands<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0* Protobufs probably would also just work and would=
 have better code<br>
&gt;=C2=A0 =C2=A0 =C2=A0generators, but would require some kind of lint to =
ensure<br>
&gt;=C2=A0 =C2=A0 =C2=A0backwards-compatibility<br>
&gt; <br>
&gt; Again, the issues we are discussing are not specific to binding QMP ov=
er<br>
&gt; D-Bus. Binding QMP to various languages has similar problems.<br>
<br>
Marc-Andr=C3=A9, we are totally in agreement about that!=C2=A0 The problem =
is that<br>
you have already decided what the solution looks like, and that&#39;s what<=
br>
I&#39;m not sure about because your solution also implies completely<br>
revisiting the schema.<br></blockquote><div><br></div><div>Did I? Which sch=
ema change are you (or I) implying? Versioning the interface? It&#39;s nece=
ssary at the client level, unless everything is dynamic, after introspectio=
n, which makes automated static bindings impractical.<br></div><div> <br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
I say there are many candidates (the ones I know are Protobuf and<br>
Flexbuffers) for serialization and many candidates for transport (REST<br>
and gRPC to begin with) in addition to the two {QMP,JSON} and<br>
{DBus,DBus} tuples.=C2=A0 We should at least look at how they do code<br>
generation before deciding that JSON is bad and DBus is good.<br></blockquo=
te><div>=C2=A0</div><div>Contrary to what you believe I am not focusing so =
much on DBus here :) It took about 200 loc to bind it, effortlessly (compar=
ed to sys&lt;-&gt;rs conversion). All it does is to expose the same API we =
have in the generated C somehow (similar static types &amp; functions - not=
 all as a{sv} opaque dictionaries). <br></div><div><br></div><div>It&#39;s =
easy for QEMU to generate a good static binding for C, because the version =
always matches. For a client, you wouldn&#39;t be able to write a similar i=
diomatic API in C, Rust, Python or Go, unfortunately. <br></div><div><br></=
div><div>Iow, I am not trying to sell DBus, I would like to make it easier =
to bind QMP in general. (although I do believe that DBus is a better protoc=
ol than QMP for local IPC, yes. And gRPC is probably better for remoting)<b=
r></div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; I would rather make those problems solved at the server level, that<br=
>
&gt; doesn&#39;t require any change to QMP today, just a more careful<br>
&gt; consideration when making changes (and probably some tools to help<br>
&gt; enforce some stability).<br>
<br>
Problem is, &quot;more careful consideration when making changes&quot; is n=
ot a<br>
small thing.=C2=A0 And other RPCs have evolved in a completely different<br=
>
space (REST APIs for web services) that have chosen the same tradeoffs<br>
as QMP, so why should we not learn from them?<br>
<br></blockquote><div><br></div>I don&#39;t buy that generalization. A very=
 recent protocol in this space, that aims to be a good low-level RPC on Lin=
ux (for containers, cloud etc) is varlink. (In many ways, we could compare =
it to QMP, but it lacks some important features, like events)</div><div cla=
ss=3D"gmail_quote"><br></div><div class=3D"gmail_quote">varlink does non-op=
tional members and versioning the same way I propose here, for what I could=
 tell. Although they use JSON, and have similar transport &quot;benefits&qu=
ot;, this basic rule allow them to have very decent automated binding in va=
rious languages, without resorting to unorthodox solutions, ex: <a href=3D"=
https://github.com/varlink/rust/blob/master/examples/example/src/main.rs">h=
ttps://github.com/varlink/rust/blob/master/examples/example/src/main.rs</a>=
</div><br>-- <br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=A9=
 Lureau<br></div></div>

--0000000000006e1bba05b0722b36--

