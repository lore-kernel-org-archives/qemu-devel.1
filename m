Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1371C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 07:53:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 247A12075F
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 07:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GKzdGHZW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 247A12075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNWvU-0008E6-2O
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 03:53:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kNWuJ-0007WO-So
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 03:52:11 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:34803)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kNWuH-0004ef-5z
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 03:52:11 -0400
Received: by mail-ej1-x642.google.com with SMTP id gr14so1441468ejb.1
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 00:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ViBfT1Vq+p8hOYceJIOAVdgml8bT3s85NbNrU6L1IWI=;
 b=GKzdGHZWSMG2h0mkhPiPQVPXOjBhVYHxhVArvlcRGjB3ELfC9CW+ga6cIgoSGilkp/
 ddREui5HqRQlG2LJfdttIgRYn64QCKhgnsnTZkyuDoH5M3Cd2QDFEYFOqkq7XkjNzPdT
 QZ+5ziLdoPfhDiOJCqQ3tfT+2NTs6QZZz89DRwBSuleLOAVf59v0kXL1du+tfPoEHhVh
 FpNZuCR09wWaN0tw+Cp44sooPOAeAbgyqEEF6KpAMp6kJBlyuVD6UajJx0oX6jX8xAWG
 aM7cM+7E9r8+o07r6giV/73d/obrBLn6NUHuETKiV5ky3QpjAMMfDPmIgJXN9huNv5dD
 mH8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ViBfT1Vq+p8hOYceJIOAVdgml8bT3s85NbNrU6L1IWI=;
 b=lKy/5GQtFDftqC00Mto6WDMLYEQaEcR803MZYMxISZFo7sk+1ZUbzMkc6lsJKDesBL
 L5xoPHs7HMBrTnE9Vy9hJZcon6EXz+Azdz6mjoDVrcwksK8bbDOuHbc0On2zzIru5955
 qz7/K2CSuuInOo2UreC/xEs5vNpAUOC27aAc/CVVoSQIOtZLtNxYdMcBRcfGbb02JTqy
 HOTvPXNNxLXZEBKimJpWw0wH7y/EXqH9jt9xBNaynjYb/yigaklL3g5YBuPlMhmlC9VS
 LsK+EResZD5cni377YAiOJ/zMDMa8dRv2tmTt06kxM3Zfuvmdk1yVzdNlDwUVlEkANaD
 gBYg==
X-Gm-Message-State: AOAM532ECQM2/wuf5gg9XAIFiJFY1OGAuqMWvuXome87yex4ZzGViqQx
 DcXj1gsUBAyoiV3tV5h6/Ayywx6riRhO0BxJYjM=
X-Google-Smtp-Source: ABdhPJx7MVAFabU5Sx2PknT6BsdiEytJ02S7zxZTd0OFLv5JtjJervUsxPvbXZRgyTpOQGLCEisHnCbzf6jFXlYpUTo=
X-Received: by 2002:a17:906:249b:: with SMTP id
 e27mr1503926ejb.105.1601452327279; 
 Wed, 30 Sep 2020 00:52:07 -0700 (PDT)
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
 <CAJ+F1C+p-JLj_epZfLiag7CdJGfZUkFNOmzPTsjCkW=QQ07_3g@mail.gmail.com>
 <87r1qjhg5w.fsf@dusky.pond.sub.org>
In-Reply-To: <87r1qjhg5w.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 30 Sep 2020 11:51:54 +0400
Message-ID: <CAJ+F1CJD2hNLxbGijxA_Dc=JpGjFm3cc-_3PVpPj8088SLXVJQ@mail.gmail.com>
Subject: Re: [PATCH] PoC: Rust binding for QAPI (qemu-ga only, for now)
To: Markus Armbruster <armbru@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000017a1c405b0832db9"
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
 qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000017a1c405b0832db9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Wed, Sep 30, 2020 at 11:34 AM Markus Armbruster <armbru@redhat.com>
wrote:

> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:
>
> > Hi
> >
> > On Tue, Sep 29, 2020 at 3:01 PM Paolo Bonzini <pbonzini@redhat.com>
> wrote:
> [...]
> >> Marc-Andr=C3=A9, we are totally in agreement about that!  The problem =
is that
> >> you have already decided what the solution looks like, and that's what
> >> I'm not sure about because your solution also implies completely
> >> revisiting the schema.
> >>
> >
> > Did I? Which schema change are you (or I) implying? Versioning the
> > interface? It's necessary at the client level, unless everything is
> > dynamic, after introspection, which makes automated static bindings
> > impractical.
>
> I disagree with "necessary".
>
> A client can use a specific version of QMP, and still talk to a server
> with a different version, because we designed that capability into QMP.
>

 "A client can use a specific version of QMP" =3D=3D versioning on the clie=
nt
side

>
> You absolutely can create bindings for a specific version of QMP for the
> client if you want.  Just make sure the client as a whole obeys the
> rules of the QMP game laid down in qmp-spec.txt and qapi-code-gen.txt.
>
> >> I say there are many candidates (the ones I know are Protobuf and
> >> Flexbuffers) for serialization and many candidates for transport (REST
> >> and gRPC to begin with) in addition to the two {QMP,JSON} and
> >> {DBus,DBus} tuples.  We should at least look at how they do code
> >> generation before deciding that JSON is bad and DBus is good.
> >>
> >
> > Contrary to what you believe I am not focusing so much on DBus here :) =
It
> > took about 200 loc to bind it, effortlessly (compared to sys<->rs
> > conversion). All it does is to expose the same API we have in the
> generated
> > C somehow (similar static types & functions - not all as a{sv} opaque
> > dictionaries).
>
> Two points.
>
> 1. Opaque dictionaries are far from the only way to do keyword arguments
> in a language that lacks them.
>

Oh one can always be creative. The point is trying to stay idiomatic in the
target language.


>
> 2. The API we generate for C is not exactly wonderful.
>
> Behold this beauty:
>
>     void qmp_block_commit(bool has_job_id, const char *job_id, const char
> *device, bool has_base_node, const char *base_node, bool has_base, const
> char *base, bool has_top_node, const char *top_node, bool has_top, const
> char *top, bool has_backing_file, const char *backing_file, bool has_spee=
d,
> int64_t speed, bool has_on_error, BlockdevOnError on_error, bool
> has_filter_node_name, const char *filter_node_name, bool has_auto_finaliz=
e,
> bool auto_finalize, bool has_auto_dismiss, bool auto_dismiss, Error **err=
p);
>
> It's gotten so bad we added a second way to do the C API:
>
>     void qmp_drive_backup(DriveBackup *arg, Error **errp);
>
> Turns out
>
>     DriveBackup arg =3D {
>         ... initialize the optionals you need ...
>     }
>     qmp_drive_backup(&arg, &err);
>
> is a lot easier on the eyes than passing 29 positional arguments.
>
>
So is writing the function arguments with indentation. Then I don't see
much difference between a long list of arguments in a struct and that
function. The main difference is that you make it easy to pass those
arguments down. But often, you want to pass a subset, you don't want to
pass the whole context as it may lead to bad design / bugs.

This could be viewed as a work-around for C's lack of positional
> parameters.
>
>
Or a badly designed QMP command.

Even more fun:
>
>     void qmp_blockdev_add(BlockdevOptions *arg, Error **errp);
>
> BlockdevOptions is a tagged union.
>
> This could be viewed as a work-around for C's lack of function
> overloading.
>
>
Or a badly designed QMP command ?

> It's easy for QEMU to generate a good static binding for C, because the
> > version always matches. For a client, you wouldn't be able to write a
> > similar idiomatic API in C, Rust, Python or Go, unfortunately.
>
> I disagree.  You won't be able to write good bindings using just
> positional parameters.  Not even if you add restrictions on how we can
> evolve QMP.  And no, I do not consider the C bindings we create for QEMU
> itself "good".  They're the best we could do, and good enough.
>
>
Sure they could be better, they are still quite idiomatic for C.

When you do bindings for another language, do bindings for that
> language, not C bindings in that language.
>
>
Yes

Regardless of bindings, the client as a whole should obey the rules of
> the QMP game laid down in qmp-spec.txt and qapi-code-gen.txt.  If these
> rules have become counter-productive, then it's time to replace QMP
> wholesale.
>
> Do not attempt to force a square peg into a round hole.  If we must have
> square pegs, design a square hole, and retire the round hole.
>
>
Hmm? I am trying to make the hole a bit more regular...

> Iow, I am not trying to sell DBus, I would like to make it easier to bind
> > QMP in general. (although I do believe that DBus is a better protocol
> than
> > QMP for local IPC, yes. And gRPC is probably better for remoting)
> >
> >> I would rather make those problems solved at the server level, that
> >> > doesn't require any change to QMP today, just a more careful
> >> > consideration when making changes (and probably some tools to help
> >> > enforce some stability).
> >>
> >> Problem is, "more careful consideration when making changes" is not a
> >> small thing.  And other RPCs have evolved in a completely different
> >> space (REST APIs for web services) that have chosen the same tradeoffs
> >> as QMP, so why should we not learn from them?
> >>
> >>
> > I don't buy that generalization. A very recent protocol in this space,
> that
> > aims to be a good low-level RPC on Linux (for containers, cloud etc) is
> > varlink. (In many ways, we could compare it to QMP, but it lacks some
> > important features, like events)
> >
> > varlink does non-optional members and versioning the same way I propose
> > here, for what I could tell. Although they use JSON, and have similar
> > transport "benefits", this basic rule allow them to have very decent
> > automated binding in various languages, without resorting to unorthodox
> > solutions, ex:
> > https://github.com/varlink/rust/blob/master/examples/example/src/main.r=
s
>
> Paolo pointed out successful protocols that make tradeoffs similar to
> QMP to support the idea that these tradeoffs can make sense and are
> workable.
>
> Pointing out other, dissimilar protocols is not a convincing
> counter-argument :)
>

It's relevant. Did you study varlink a bit? It's so close to QMP, you will
find it hard to point out real dissimilarities.


--=20
Marc-Andr=C3=A9 Lureau

--00000000000017a1c405b0832db9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Sep 30, 2020 at 11:34 AM Ma=
rkus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">M=
arc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@gmail.com" tar=
get=3D"_blank">marcandre.lureau@gmail.com</a>&gt; writes:<br>
<br>
&gt; Hi<br>
&gt;<br>
&gt; On Tue, Sep 29, 2020 at 3:01 PM Paolo Bonzini &lt;<a href=3D"mailto:pb=
onzini@redhat.com" target=3D"_blank">pbonzini@redhat.com</a>&gt; wrote:<br>
[...]<br>
&gt;&gt; Marc-Andr=C3=A9, we are totally in agreement about that!=C2=A0 The=
 problem is that<br>
&gt;&gt; you have already decided what the solution looks like, and that&#3=
9;s what<br>
&gt;&gt; I&#39;m not sure about because your solution also implies complete=
ly<br>
&gt;&gt; revisiting the schema.<br>
&gt;&gt;<br>
&gt;<br>
&gt; Did I? Which schema change are you (or I) implying? Versioning the<br>
&gt; interface? It&#39;s necessary at the client level, unless everything i=
s<br>
&gt; dynamic, after introspection, which makes automated static bindings<br=
>
&gt; impractical.<br>
<br>
I disagree with &quot;necessary&quot;.<br>
<br>
A client can use a specific version of QMP, and still talk to a server<br>
with a different version, because we designed that capability into QMP.<br>=
</blockquote><div><br></div><div>=C2=A0&quot;A client can use a specific ve=
rsion of QMP&quot; =3D=3D versioning on the client side<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">
<br>
You absolutely can create bindings for a specific version of QMP for the<br=
>
client if you want.=C2=A0 Just make sure the client as a whole obeys the<br=
>
rules of the QMP game laid down in qmp-spec.txt and qapi-code-gen.txt.<br>
<br>
&gt;&gt; I say there are many candidates (the ones I know are Protobuf and<=
br>
&gt;&gt; Flexbuffers) for serialization and many candidates for transport (=
REST<br>
&gt;&gt; and gRPC to begin with) in addition to the two {QMP,JSON} and<br>
&gt;&gt; {DBus,DBus} tuples.=C2=A0 We should at least look at how they do c=
ode<br>
&gt;&gt; generation before deciding that JSON is bad and DBus is good.<br>
&gt;&gt;<br>
&gt;<br>
&gt; Contrary to what you believe I am not focusing so much on DBus here :)=
 It<br>
&gt; took about 200 loc to bind it, effortlessly (compared to sys&lt;-&gt;r=
s<br>
&gt; conversion). All it does is to expose the same API we have in the gene=
rated<br>
&gt; C somehow (similar static types &amp; functions - not all as a{sv} opa=
que<br>
&gt; dictionaries).<br>
<br>
Two points.<br>
<br>
1. Opaque dictionaries are far from the only way to do keyword arguments<br=
>
in a language that lacks them.<br></blockquote><div><br></div><div>Oh one c=
an always be creative. The point is trying to stay idiomatic in the target =
language.<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
2. The API we generate for C is not exactly wonderful.<br>
<br>
Behold this beauty:<br>
<br>
=C2=A0 =C2=A0 void qmp_block_commit(bool has_job_id, const char *job_id, co=
nst char *device, bool has_base_node, const char *base_node, bool has_base,=
 const char *base, bool has_top_node, const char *top_node, bool has_top, c=
onst char *top, bool has_backing_file, const char *backing_file, bool has_s=
peed, int64_t speed, bool has_on_error, BlockdevOnError on_error, bool has_=
filter_node_name, const char *filter_node_name, bool has_auto_finalize, boo=
l auto_finalize, bool has_auto_dismiss, bool auto_dismiss, Error **errp);<b=
r>
<br>
It&#39;s gotten so bad we added a second way to do the C API:<br>
<br>
=C2=A0 =C2=A0 void qmp_drive_backup(DriveBackup *arg, Error **errp);<br>
<br>
Turns out<br>
<br>
=C2=A0 =C2=A0 DriveBackup arg =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ... initialize the optionals you need ...<br>
=C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 qmp_drive_backup(&amp;arg, &amp;err);<br>
<br>
is a lot easier on the eyes than passing 29 positional arguments.<br>
<br></blockquote><div><br></div><div>So is writing the function arguments w=
ith indentation. Then I don&#39;t see much difference between a long list o=
f arguments in a struct and that function. The main difference is that you =
make it easy to pass those arguments down. But often, you want to pass a su=
bset, you don&#39;t want to pass the whole context as it may lead to bad de=
sign / bugs.</div><div><br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">
This could be viewed as a work-around for C&#39;s lack of positional<br>
parameters.<br>
<br></blockquote><div><br></div><div>Or a badly designed QMP command.<br></=
div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Even more fun:<br>
<br>
=C2=A0 =C2=A0 void qmp_blockdev_add(BlockdevOptions *arg, Error **errp);<br=
>
<br>
BlockdevOptions is a tagged union.<br>
<br>
This could be viewed as a work-around for C&#39;s lack of function<br>
overloading.<br>
<br></blockquote><div><br></div><div>Or a badly designed QMP command ?</div=
><div> <br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; It&#39;s easy for QEMU to generate a good static binding for C, becaus=
e the<br>
&gt; version always matches. For a client, you wouldn&#39;t be able to writ=
e a<br>
&gt; similar idiomatic API in C, Rust, Python or Go, unfortunately.<br>
<br>
I disagree.=C2=A0 You won&#39;t be able to write good bindings using just<b=
r>
positional parameters.=C2=A0 Not even if you add restrictions on how we can=
<br>
evolve QMP.=C2=A0 And no, I do not consider the C bindings we create for QE=
MU<br>
itself &quot;good&quot;.=C2=A0 They&#39;re the best we could do, and good e=
nough.<br>
<br></blockquote><div><br></div><div>Sure they could be better, they are st=
ill quite idiomatic for C.</div><div> <br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">
When you do bindings for another language, do bindings for that<br>
language, not C bindings in that language.<br>
<br></blockquote><div><br></div><div>Yes</div><div> <br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">
Regardless of bindings, the client as a whole should obey the rules of<br>
the QMP game laid down in qmp-spec.txt and qapi-code-gen.txt.=C2=A0 If thes=
e<br>
rules have become counter-productive, then it&#39;s time to replace QMP<br>
wholesale.<br>
<br>
Do not attempt to force a square peg into a round hole.=C2=A0 If we must ha=
ve<br>
square pegs, design a square hole, and retire the round hole.<br>
<br></blockquote><div><br></div><div>Hmm? I am trying to make the hole a bi=
t more regular...<br></div><div> <br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">
&gt; Iow, I am not trying to sell DBus, I would like to make it easier to b=
ind<br>
&gt; QMP in general. (although I do believe that DBus is a better protocol =
than<br>
&gt; QMP for local IPC, yes. And gRPC is probably better for remoting)<br>
&gt;<br>
&gt;&gt; I would rather make those problems solved at the server level, tha=
t<br>
&gt;&gt; &gt; doesn&#39;t require any change to QMP today, just a more care=
ful<br>
&gt;&gt; &gt; consideration when making changes (and probably some tools to=
 help<br>
&gt;&gt; &gt; enforce some stability).<br>
&gt;&gt;<br>
&gt;&gt; Problem is, &quot;more careful consideration when making changes&q=
uot; is not a<br>
&gt;&gt; small thing.=C2=A0 And other RPCs have evolved in a completely dif=
ferent<br>
&gt;&gt; space (REST APIs for web services) that have chosen the same trade=
offs<br>
&gt;&gt; as QMP, so why should we not learn from them?<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt; I don&#39;t buy that generalization. A very recent protocol in this sp=
ace, that<br>
&gt; aims to be a good low-level RPC on Linux (for containers, cloud etc) i=
s<br>
&gt; varlink. (In many ways, we could compare it to QMP, but it lacks some<=
br>
&gt; important features, like events)<br>
&gt;<br>
&gt; varlink does non-optional members and versioning the same way I propos=
e<br>
&gt; here, for what I could tell. Although they use JSON, and have similar<=
br>
&gt; transport &quot;benefits&quot;, this basic rule allow them to have ver=
y decent<br>
&gt; automated binding in various languages, without resorting to unorthodo=
x<br>
&gt; solutions, ex:<br>
&gt; <a href=3D"https://github.com/varlink/rust/blob/master/examples/exampl=
e/src/main.rs" rel=3D"noreferrer" target=3D"_blank">https://github.com/varl=
ink/rust/blob/master/examples/example/src/main.rs</a><br>
<br>
Paolo pointed out successful protocols that make tradeoffs similar to<br>
QMP to support the idea that these tradeoffs can make sense and are<br>
workable.<br>
<br>
Pointing out other, dissimilar protocols is not a convincing<br>
counter-argument :)<br></blockquote><div><br></div><div>It&#39;s relevant. =
Did you study varlink a bit? It&#39;s so close to QMP, you will find it har=
d to point out real dissimilarities.<br></div></div><br clear=3D"all"><br>-=
- <br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=A9 Lureau<br>=
</div></div>

--00000000000017a1c405b0832db9--

