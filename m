Return-Path: <SRS0=4gpF=3O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6175C2D0DB
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2020 17:20:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C2C620716
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2020 17:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NBe351dZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C2C620716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ivP75-0006qm-F9
	for qemu-devel@archiver.kernel.org; Sat, 25 Jan 2020 12:20:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37097)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ivP5Q-0005jD-Dc
 for qemu-devel@nongnu.org; Sat, 25 Jan 2020 12:19:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ivP5M-0000eq-7x
 for qemu-devel@nongnu.org; Sat, 25 Jan 2020 12:19:07 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41277
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ivP5L-0000ad-RF
 for qemu-devel@nongnu.org; Sat, 25 Jan 2020 12:19:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579972740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c+nMWJndZqT86ePZcabpviv6UHzuja+05QEpEu++eUQ=;
 b=NBe351dZ5ZREbyziIwVzAjhdlKVCK66DPlaFoH0lQGDL19PEgQQLLL2jBo9c/2zWhNl0/f
 eEL/4bwwL1WvA1ruxKJsfj1ZOQH9zOI+6wsQE1WGw0IEtVOiNXFz7AIR9jqkrUB/A0iFOa
 rb0ia+LleNIKVJhTcYn/s3SwusGDhaY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-eWGF_6HDPxeuTnXLGZvwvw-1; Sat, 25 Jan 2020 12:18:57 -0500
Received: by mail-ed1-f69.google.com with SMTP id cy24so3954227edb.12
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2020 09:18:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=c+nMWJndZqT86ePZcabpviv6UHzuja+05QEpEu++eUQ=;
 b=TYYk+rSKxp8WXCf/RpR78hkFFSorswCltFTQv76AZzqpsJxeKveGEo4pihLfoQkObV
 FbOnempq4ypfdpDDwouSImKpFFu7UNM/NSO6bzDOmkMHQ9AXO56JP8Z9M+g/MCCQEYei
 RsyJb9M0J40Q9T/bdhw4U5wI+VUf+mEy81x5JErR7m77obdTiXrEcIVpqxAeptBEZeqO
 misO3iF2QFs0eGBPnkNnYUn5lZXYxc6ONLiPctyQyzjKVxCQLy/vc9Lm5dOyyQIL5I5L
 yV9MEXfi0y+TP8viELPaoHaSubfB2ASk+4Uau+T5nQzEXgt2pnTQAtfwrWtnEpzuhUB3
 uUGg==
X-Gm-Message-State: APjAAAU76TlLKFps/NrFodt/IsKOD0BmGuVDNIVbY8pBJSwUlUl+F2hT
 sBIXE9S1v8hz1lZ8S4vpHl+TZR07ppwc3TN3o2gicjTzsr856M55j3ULnCr6nRgrt+4Rp9QYWZl
 jQlxEwBoT+wZgaNuMPM6sFuT0tvBWMXc=
X-Received: by 2002:aa7:d99a:: with SMTP id u26mr7144574eds.183.1579972736048; 
 Sat, 25 Jan 2020 09:18:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqyU0ly+/hN965KcmJwdvTXU6iBMKkC4CcjGNCVJjws/LxcdpJB/2GKElSSPgPjFi9tTBLOGM8dIpEKMZAwbL8c=
X-Received: by 2002:aa7:d99a:: with SMTP id u26mr7144549eds.183.1579972735715; 
 Sat, 25 Jan 2020 09:18:55 -0800 (PST)
MIME-Version: 1.0
References: <CAJSP0QUk=4co-nqk8fv2n-T2_W40rE3r_5OMoxD7otAV993mCA@mail.gmail.com>
 <1EFEF446-AFEA-429F-B6BA-3206A7C41836@redhat.com>
 <20200108104306.GC5057@dhcp-200-226.str.redhat.com>
 <97F153BD-FB8A-46C7-90D0-9E894B9E0292@redhat.com>
 <20200108133842.GE5057@dhcp-200-226.str.redhat.com>
 <87d0bmchq0.fsf@dusky.pond.sub.org>
 <1B253197-5592-472A-AA26-E0614A13C91A@redhat.com>
 <87o8v52hz9.fsf@dusky.pond.sub.org>
In-Reply-To: <87o8v52hz9.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 25 Jan 2020 18:18:43 +0100
Message-ID: <CABgObfZUNcDza=yMG5i4SvYs0WHwRCW_yCNkHeKsYjYAhoLZuA@mail.gmail.com>
Subject: Re: Making QEMU easier for management tools and applications
To: Markus Armbruster <armbru@redhat.com>
X-MC-Unique: eWGF_6HDPxeuTnXLGZvwvw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000aae6f4059cfa114a"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 Christophe de Dinechin <dinechin@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000aae6f4059cfa114a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il mer 15 gen 2020, 10:21 Markus Armbruster <armbru@redhat.com> ha scritto:

> > We don=E2=80=99t want the QAPI to let arbitrary fields of a QOM object
> > be modified, do we?
>
> We already do: QMP command qom-set.  If it breaks your guest, you get to
> keep the pieces.
>

That's not true. We chose not to make that a "recommended" interface, and
instead we add new commands. However that's mostly to avoid tying our hands
and not making too much of QOM part of the API. But I would be very
surprised if a guest could be broken with qom-set.

This was definitely not the case when QOM was introduced in a half-baked
state, but let's not indulge in self-flagellation more than it's actually
necessary.



> > As for the =E2=80=9Cpublic=E2=80=9D aspects of a QOM object, that is st=
atic if it
> > comes from QAPI, so why couldn=E2=80=99t we define it there?
>
> QAPI specifies a certain kind of data types.
>
> QOM "specifies" data types as an imperative program for creating them.
> Maximally flexible, and fundamentally at odds with static analysis.
> I've hated this since day one.
>
> There's no hard reason why QOM could not specify static aspects
> declaratively.  It just doesn't, and changing it now would be a
> monumental task.
>
> The imperative program mostly creates identical data types every time.
> In other words, the data types are static.  Two problems.  One,
> converting such a program to an equivalent declaration takes manual
> labor.  Two, there are exceptions, and identifying them is more manual
> labor.
>
> >>> the same way, QAPI can't say anything about the structure of a QOM
> >>> object, and I think that's a problem.
> >>>
> >>>>> - which, as far as I
> >>>>> understand, is mainly because QOM properties aren't necessarily
> static,
> >>>>> so we can't provide a statically defined interface for them. Probab=
ly
> >>>>> solvable in QEMU, but not without a major effort.
> >>>>
> >>>> Or maybe extend the language so that it=E2=80=99s internal semantics
> >>>> knows about this aspect of QOM?
> >>>
> >>> My point is that for example you can't generate a C struct (which is
> >>> statically defined) from something that has a dynamic structure. The
> >>> best you could do is fall back to key=3Dvalue even in the C source, b=
oth
> >>> key and value being strings. But then you still have to parse these
> >>> strings manually, so it doesn't actually help much compared to a stat=
e
> >>> without C bindings.
> >
> > I really don=E2=80=99t understand that point. To me, all these operatio=
ns
> > seem relatively simple to generate.
>
> Yes, if the QAPI fairy gives us a declarative specification equivalent
> to the existing imperative one, then replacing the hand-written
> imperative code by code generated from the declarative specification
> would be relatively simple.
>
> > I think that what confuses me is when you write =E2=80=9Csomething that=
 has a
> > dynamic structure=E2=80=9D. I understand that as referring to the struc=
ture
> > defined in the schema. But the schema itself is static. So you can
> > generate static code from it, and it=E2=80=99s already done today.
>
> QAPI data types are static.
>
> QOM types are not.  They're effectively almost static in practice.
>
> > Another hypothesis on my side is that we don=E2=80=99t want, ever, to
> > have the API provide for example the option to create its own
> > arbitrary QOM classes, or to tag arbitrary properties to an object,
> > where by =E2=80=9Carbitrary=E2=80=9D I mean not explicitly mentioned so=
mewhere in
> > something like the schema.
> >
> > So I suspect you are talking about something else.
>
> Kevin's talking about the imperative code creating different QOM
> properties depending on how and in what context it is run.
>
> QOM is perfectly capable of supporting a QMP command to add arbitrary
> QOM properties to an object at run time, or even add arbitrary QOM
> types, but as you wrote we don't want that.
>
> >> QOM and QAPI sabotage each other.  Ironic, considering they were dream=
ed
> >> up by the same guy :)
> >>
> >> QAPI is compile-time static by design.
> >>
> >> QOM is run-time dynamic by design.  Some support for static definition=
s
> >> has been grafted on since.
> >>
> >> We use QAPI type system escapes for QOM.  Defeats QAPI introspection a=
nd
> >> doc generation.  We provide separate QOM introspection instead, which =
is
> >> clumsier and less expressive.  QOM documentation doesn't exist.
> >
> > But back to the original discussion about management tools,
> > do we let upper layers tag their own arbitrary stuff in QOM objects?
>
> We don't want management applications to add QOM properties for their
> own purposes.
>
> >>> Maybe what could be done is covering at least the static properties a=
nd
> >>> then having key=3Dvalue for the dynamic part (which should be the
> >>> exception).
> >>
> >> To make this worthwhile, we'd have to replace dynamic QOM properties b=
y
> >> static ones when possible.  Monumental task.
> >
> > I=E2=80=99m sure you are right, but it=E2=80=99s hard for me to evaluat=
e, given how
> > many ways there are to access an object. Naively, grepping for
> > set_prop and for new_with_prop does not give me that many hits.
>
> Look for object_property_add*().  Some 450 hits.
>
> See also object_class_property_add(), grafted on in
>
> commit 16bf7f522a2ff68993f80631ed86254c71eaf5d4
> Author: Daniel P. Berrange <berrange@redhat.com>
> Date:   Tue Oct 13 13:37:46 2015 +0100
>
>     qom: Allow properties to be registered against classes
>
>     When there are many instances of a given class, registering
>     properties against the instance is wasteful of resources. The
>     majority of objects have a statically defined list of possible
>     properties, so most of the properties are easily registerable
>     against the class. Only those properties which are conditionally
>     registered at runtime need be recorded against the klass.
>
>     Registering properties against classes also makes it possible
>     to provide static introspection of QOM - currently introspection
>     is only possible after creating an instance of a class, which
>     severely limits its usefulness.
>
>     This impl only supports simple scalar properties. It does not
>     attempt to allow child object / link object properties against
>     the class. There are ways to support those too, but it would
>     make this patch more complicated, so it is left as an exercise
>     for the future.
>
>     There is no equivalent to object_property_del() provided, since
>     classes must be immutable once they are defined.
>
>     Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
>     Signed-off-by: Andreas F=C3=A4rber <afaerber@suse.de>
>
> >>>>>> - Relations, e.g. how we represent =E2=80=9Ccontains=E2=80=9D, =E2=
=80=9Cderives from=E2=80=9D,
> =E2=80=9Cneeds=E2=80=9D,
> >>>>>> =E2=80=9Cone of=E2=80=9D, =E2=80=9Cone or several=E2=80=9D, =E2=80=
=9Cattaches to=E2=80=9D=E2=80=A6
> >>>>>> - States, e.g. how do we represent the machine configuration,
> >>>>>> or the desired new disk setting
> >>>>>> - Verbs, e.g. how we represent =E2=80=9Cadd=E2=80=9D, =E2=80=9Ccon=
nect=E2=80=9D, =E2=80=9Cremove=E2=80=9D, =E2=80=9Cfind=E2=80=9D,
> >>>>>> =E2=80=9Cstart=E2=80=9D, =E2=80=9Cnotify=E2=80=9D, etc. and how we=
 describe the kind of input they
> need.
> >>>>>> - Possibly more subtle things like support for transactions,
> commit/rollback,
> >>>>>> i.e. =E2=80=9CI want to add connect a virtual nic to some host vf,=
 but if
> anything
> >>>>>> along the way fails, I=E2=80=99d like all the cleanup to happen
> automatically)
> >>>>>
> >>>>> This sounds like a different approach from our current QAPI command
> set
> >>>>
> >>>> Well, except for purposefully trying to use a different wording to
> avoid
> >>>> the risk of getting your mind stuck in one of the particular existin=
g
> >>>> meta-languages in QEMU, the approach is not very different.
> >>>
> >>> I didn't necessarily mean relations/state/verbs, which obviously exis=
t,
> >>> but the examples that seemed to express things in a deliberately
> >>> different way from what we have today.
> >>>
> >>>> - Transactions do not exist today that I know of, although we see
> >>>> signs of them in discussions about the fact that this options destro=
ys
> >>>> that back end but that option does not.
> >>>
> >>> We have a 'transaction' QMP command, but they are not an integral par=
t
> >>> of the language. Considering the trouble to implement transactional
> >>> commands, I suppose we don't even want it to be a fundamental part of
> >>> the language.
> >>>
> >>>>> Does it actually provide more functionality, though?
> >>>>
> >>>> It=E2=80=99s not intended to provide more, but to require less to do=
 the same
> thing.
> >>>
> >>> Though we always need to keep in mind that if requiring less for futu=
re
> >>> additions requires a huge effort now, the investment may pay off only
> in
> >>> a very distant future (if the abstraction we build even survives unti=
l
> >>> then).
> >>
> >> Worse is better.
> >>
> >> http://dreamsongs.com/RiseOfWorseIsBetter.html
> >
> > You know that I positively hate this ;-)
>
> It's been a tough lesson for me, too.
>
> > Well, I guess we can expand the schema. #ILoveJSON.
>
> Basing the QAPI language on JSON was a poor choice.  Not sure that's
> fixable at a reasonable cost.
>
>

--000000000000aae6f4059cfa114a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mer 15 gen 2020, 10:21 Markus Armbruster &lt;<a hre=
f=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; ha scritto:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex">&gt; We don=E2=80=99t want the QAPI to le=
t arbitrary fields of a QOM object<br>
&gt; be modified, do we?<br>
<br>
We already do: QMP command qom-set.=C2=A0 If it breaks your guest, you get =
to<br>
keep the pieces.<br></blockquote></div></div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto">That&#39;s not true. We chose not to make that a &quot;reco=
mmended&quot; interface, and instead we add new commands. However that&#39;=
s mostly to avoid tying our hands and not making too much of QOM part of th=
e API. But I would be very surprised if a guest could be broken with qom-se=
t.</div><div dir=3D"auto"><br></div><div dir=3D"auto">This was definitely n=
ot the case when QOM was introduced in a half-baked state, but let&#39;s no=
t indulge in self-flagellation more than it&#39;s actually necessary.</div>=
<div dir=3D"auto"><br></div><div dir=3D"auto"><br></div><div dir=3D"auto"><=
div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt; As for the =E2=80=9Cpublic=E2=80=9D aspects of a QOM object, that is s=
tatic if it<br>
&gt; comes from QAPI, so why couldn=E2=80=99t we define it there?<br>
<br>
QAPI specifies a certain kind of data types.<br>
<br>
QOM &quot;specifies&quot; data types as an imperative program for creating =
them.<br>
Maximally flexible, and fundamentally at odds with static analysis.<br>
I&#39;ve hated this since day one.<br>
<br>
There&#39;s no hard reason why QOM could not specify static aspects<br>
declaratively.=C2=A0 It just doesn&#39;t, and changing it now would be a<br=
>
monumental task.<br>
<br>
The imperative program mostly creates identical data types every time.<br>
In other words, the data types are static.=C2=A0 Two problems.=C2=A0 One,<b=
r>
converting such a program to an equivalent declaration takes manual<br>
labor.=C2=A0 Two, there are exceptions, and identifying them is more manual=
<br>
labor.<br>
<br>
&gt;&gt;&gt; the same way, QAPI can&#39;t say anything about the structure =
of a QOM<br>
&gt;&gt;&gt; object, and I think that&#39;s a problem.<br>
&gt;&gt;&gt; <br>
&gt;&gt;&gt;&gt;&gt; - which, as far as I<br>
&gt;&gt;&gt;&gt;&gt; understand, is mainly because QOM properties aren&#39;=
t necessarily static,<br>
&gt;&gt;&gt;&gt;&gt; so we can&#39;t provide a statically defined interface=
 for them. Probably<br>
&gt;&gt;&gt;&gt;&gt; solvable in QEMU, but not without a major effort.<br>
&gt;&gt;&gt;&gt; <br>
&gt;&gt;&gt;&gt; Or maybe extend the language so that it=E2=80=99s internal=
 semantics<br>
&gt;&gt;&gt;&gt; knows about this aspect of QOM?<br>
&gt;&gt;&gt; <br>
&gt;&gt;&gt; My point is that for example you can&#39;t generate a C struct=
 (which is<br>
&gt;&gt;&gt; statically defined) from something that has a dynamic structur=
e. The<br>
&gt;&gt;&gt; best you could do is fall back to key=3Dvalue even in the C so=
urce, both<br>
&gt;&gt;&gt; key and value being strings. But then you still have to parse =
these<br>
&gt;&gt;&gt; strings manually, so it doesn&#39;t actually help much compare=
d to a state<br>
&gt;&gt;&gt; without C bindings.<br>
&gt;<br>
&gt; I really don=E2=80=99t understand that point. To me, all these operati=
ons<br>
&gt; seem relatively simple to generate.<br>
<br>
Yes, if the QAPI fairy gives us a declarative specification equivalent<br>
to the existing imperative one, then replacing the hand-written<br>
imperative code by code generated from the declarative specification<br>
would be relatively simple.<br>
<br>
&gt; I think that what confuses me is when you write =E2=80=9Csomething tha=
t has a<br>
&gt; dynamic structure=E2=80=9D. I understand that as referring to the stru=
cture<br>
&gt; defined in the schema. But the schema itself is static. So you can<br>
&gt; generate static code from it, and it=E2=80=99s already done today.<br>
<br>
QAPI data types are static.<br>
<br>
QOM types are not.=C2=A0 They&#39;re effectively almost static in practice.=
<br>
<br>
&gt; Another hypothesis on my side is that we don=E2=80=99t want, ever, to<=
br>
&gt; have the API provide for example the option to create its own<br>
&gt; arbitrary QOM classes, or to tag arbitrary properties to an object,<br=
>
&gt; where by =E2=80=9Carbitrary=E2=80=9D I mean not explicitly mentioned s=
omewhere in<br>
&gt; something like the schema.<br>
&gt;<br>
&gt; So I suspect you are talking about something else.<br>
<br>
Kevin&#39;s talking about the imperative code creating different QOM<br>
properties depending on how and in what context it is run.<br>
<br>
QOM is perfectly capable of supporting a QMP command to add arbitrary<br>
QOM properties to an object at run time, or even add arbitrary QOM<br>
types, but as you wrote we don&#39;t want that.<br>
<br>
&gt;&gt; QOM and QAPI sabotage each other.=C2=A0 Ironic, considering they w=
ere dreamed<br>
&gt;&gt; up by the same guy :)<br>
&gt;&gt; <br>
&gt;&gt; QAPI is compile-time static by design.<br>
&gt;&gt; <br>
&gt;&gt; QOM is run-time dynamic by design.=C2=A0 Some support for static d=
efinitions<br>
&gt;&gt; has been grafted on since.<br>
&gt;&gt; <br>
&gt;&gt; We use QAPI type system escapes for QOM.=C2=A0 Defeats QAPI intros=
pection and<br>
&gt;&gt; doc generation.=C2=A0 We provide separate QOM introspection instea=
d, which is<br>
&gt;&gt; clumsier and less expressive.=C2=A0 QOM documentation doesn&#39;t =
exist.<br>
&gt;<br>
&gt; But back to the original discussion about management tools,<br>
&gt; do we let upper layers tag their own arbitrary stuff in QOM objects?<b=
r>
<br>
We don&#39;t want management applications to add QOM properties for their<b=
r>
own purposes.<br>
<br>
&gt;&gt;&gt; Maybe what could be done is covering at least the static prope=
rties and<br>
&gt;&gt;&gt; then having key=3Dvalue for the dynamic part (which should be =
the<br>
&gt;&gt;&gt; exception).<br>
&gt;&gt; <br>
&gt;&gt; To make this worthwhile, we&#39;d have to replace dynamic QOM prop=
erties by<br>
&gt;&gt; static ones when possible.=C2=A0 Monumental task.<br>
&gt;<br>
&gt; I=E2=80=99m sure you are right, but it=E2=80=99s hard for me to evalua=
te, given how<br>
&gt; many ways there are to access an object. Naively, grepping for<br>
&gt; set_prop and for new_with_prop does not give me that many hits.<br>
<br>
Look for object_property_add*().=C2=A0 Some 450 hits.<br>
<br>
See also object_class_property_add(), grafted on in<br>
<br>
commit 16bf7f522a2ff68993f80631ed86254c71eaf5d4<br>
Author: Daniel P. Berrange &lt;<a href=3D"mailto:berrange@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">berrange@redhat.com</a>&gt;<br>
Date:=C2=A0 =C2=A0Tue Oct 13 13:37:46 2015 +0100<br>
<br>
=C2=A0 =C2=A0 qom: Allow properties to be registered against classes<br>
<br>
=C2=A0 =C2=A0 When there are many instances of a given class, registering<b=
r>
=C2=A0 =C2=A0 properties against the instance is wasteful of resources. The=
<br>
=C2=A0 =C2=A0 majority of objects have a statically defined list of possibl=
e<br>
=C2=A0 =C2=A0 properties, so most of the properties are easily registerable=
<br>
=C2=A0 =C2=A0 against the class. Only those properties which are conditiona=
lly<br>
=C2=A0 =C2=A0 registered at runtime need be recorded against the klass.<br>
<br>
=C2=A0 =C2=A0 Registering properties against classes also makes it possible=
<br>
=C2=A0 =C2=A0 to provide static introspection of QOM - currently introspect=
ion<br>
=C2=A0 =C2=A0 is only possible after creating an instance of a class, which=
<br>
=C2=A0 =C2=A0 severely limits its usefulness.<br>
<br>
=C2=A0 =C2=A0 This impl only supports simple scalar properties. It does not=
<br>
=C2=A0 =C2=A0 attempt to allow child object / link object properties agains=
t<br>
=C2=A0 =C2=A0 the class. There are ways to support those too, but it would<=
br>
=C2=A0 =C2=A0 make this patch more complicated, so it is left as an exercis=
e<br>
=C2=A0 =C2=A0 for the future.<br>
<br>
=C2=A0 =C2=A0 There is no equivalent to object_property_del() provided, sin=
ce<br>
=C2=A0 =C2=A0 classes must be immutable once they are defined.<br>
<br>
=C2=A0 =C2=A0 Signed-off-by: Daniel P. Berrange &lt;<a href=3D"mailto:berra=
nge@redhat.com" target=3D"_blank" rel=3D"noreferrer">berrange@redhat.com</a=
>&gt;<br>
=C2=A0 =C2=A0 Signed-off-by: Andreas F=C3=A4rber &lt;<a href=3D"mailto:afae=
rber@suse.de" target=3D"_blank" rel=3D"noreferrer">afaerber@suse.de</a>&gt;=
<br>
<br>
&gt;&gt;&gt;&gt;&gt;&gt; - Relations, e.g. how we represent =E2=80=9Ccontai=
ns=E2=80=9D, =E2=80=9Cderives from=E2=80=9D, =E2=80=9Cneeds=E2=80=9D,<br>
&gt;&gt;&gt;&gt;&gt;&gt; =E2=80=9Cone of=E2=80=9D, =E2=80=9Cone or several=
=E2=80=9D, =E2=80=9Cattaches to=E2=80=9D=E2=80=A6<br>
&gt;&gt;&gt;&gt;&gt;&gt; - States, e.g. how do we represent the machine con=
figuration,<br>
&gt;&gt;&gt;&gt;&gt;&gt; or the desired new disk setting<br>
&gt;&gt;&gt;&gt;&gt;&gt; - Verbs, e.g. how we represent =E2=80=9Cadd=E2=80=
=9D, =E2=80=9Cconnect=E2=80=9D, =E2=80=9Cremove=E2=80=9D, =E2=80=9Cfind=E2=
=80=9D,<br>
&gt;&gt;&gt;&gt;&gt;&gt; =E2=80=9Cstart=E2=80=9D, =E2=80=9Cnotify=E2=80=9D,=
 etc. and how we describe the kind of input they need.<br>
&gt;&gt;&gt;&gt;&gt;&gt; - Possibly more subtle things like support for tra=
nsactions, commit/rollback,<br>
&gt;&gt;&gt;&gt;&gt;&gt; i.e. =E2=80=9CI want to add connect a virtual nic =
to some host vf, but if anything<br>
&gt;&gt;&gt;&gt;&gt;&gt; along the way fails, I=E2=80=99d like all the clea=
nup to happen automatically)<br>
&gt;&gt;&gt;&gt;&gt; <br>
&gt;&gt;&gt;&gt;&gt; This sounds like a different approach from our current=
 QAPI command set<br>
&gt;&gt;&gt;&gt; <br>
&gt;&gt;&gt;&gt; Well, except for purposefully trying to use a different wo=
rding to avoid<br>
&gt;&gt;&gt;&gt; the risk of getting your mind stuck in one of the particul=
ar existing<br>
&gt;&gt;&gt;&gt; meta-languages in QEMU, the approach is not very different=
.<br>
&gt;&gt;&gt; <br>
&gt;&gt;&gt; I didn&#39;t necessarily mean relations/state/verbs, which obv=
iously exist,<br>
&gt;&gt;&gt; but the examples that seemed to express things in a deliberate=
ly<br>
&gt;&gt;&gt; different way from what we have today.<br>
&gt;&gt;&gt; <br>
&gt;&gt;&gt;&gt; - Transactions do not exist today that I know of, although=
 we see<br>
&gt;&gt;&gt;&gt; signs of them in discussions about the fact that this opti=
ons destroys<br>
&gt;&gt;&gt;&gt; that back end but that option does not.<br>
&gt;&gt;&gt; <br>
&gt;&gt;&gt; We have a &#39;transaction&#39; QMP command, but they are not =
an integral part<br>
&gt;&gt;&gt; of the language. Considering the trouble to implement transact=
ional<br>
&gt;&gt;&gt; commands, I suppose we don&#39;t even want it to be a fundamen=
tal part of<br>
&gt;&gt;&gt; the language.<br>
&gt;&gt;&gt; <br>
&gt;&gt;&gt;&gt;&gt; Does it actually provide more functionality, though?<b=
r>
&gt;&gt;&gt;&gt; <br>
&gt;&gt;&gt;&gt; It=E2=80=99s not intended to provide more, but to require =
less to do the same thing.<br>
&gt;&gt;&gt; <br>
&gt;&gt;&gt; Though we always need to keep in mind that if requiring less f=
or future<br>
&gt;&gt;&gt; additions requires a huge effort now, the investment may pay o=
ff only in<br>
&gt;&gt;&gt; a very distant future (if the abstraction we build even surviv=
es until<br>
&gt;&gt;&gt; then).<br>
&gt;&gt; <br>
&gt;&gt; Worse is better.<br>
&gt;&gt; <br>
&gt;&gt; <a href=3D"http://dreamsongs.com/RiseOfWorseIsBetter.html" rel=3D"=
noreferrer noreferrer" target=3D"_blank">http://dreamsongs.com/RiseOfWorseI=
sBetter.html</a><br>
&gt;<br>
&gt; You know that I positively hate this ;-)<br>
<br>
It&#39;s been a tough lesson for me, too.<br>
<br>
&gt; Well, I guess we can expand the schema. #ILoveJSON.<br>
<br>
Basing the QAPI language on JSON was a poor choice.=C2=A0 Not sure that&#39=
;s<br>
fixable at a reasonable cost.<br>
<br>
</blockquote></div></div></div>

--000000000000aae6f4059cfa114a--


