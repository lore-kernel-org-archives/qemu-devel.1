Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC065C47420
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 17:57:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3284020702
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 17:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edr+HhXV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3284020702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNJsV-0004dg-3w
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 13:57:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kNJqx-0002zI-WB
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 13:55:52 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:34403)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kNJqt-0000H1-RZ
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 13:55:51 -0400
Received: by mail-ej1-x644.google.com with SMTP id gr14so16333432ejb.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 10:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fBhr/dhTDmGHNlWgH7TZocnfF70jkyMnF5hFMIIFOcg=;
 b=edr+HhXVyiE/onKAdR97pR+9DW2e02A18g+kI/NTztAFAF/urKY8+I8Yd5GLSgxs+7
 HCLFFntDnMHcm9WaLUBNbRj3MamEzYj2pq18E25YO5vj2mrAli3EhWbszAnRLNQ/mKQL
 g5Epp3eZuP+GDw22CFzejonOO4yAIA4y5KJFcUn1HX35ltjuzRoJ/uwuEJK4K7pKX7Dm
 4T3a7q3FU3Jc6OZaPyuIGXR/uJUA5xm8HbzSYw1/71+g2lISs140NuazPtCiFh0SjIFz
 OgnX1YZIU3zi9Yn1mF9S72sklzB1r5Yh0YhHSjzlHlDvlS5O0/Npeq36MfQwi37PeRP6
 QNbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fBhr/dhTDmGHNlWgH7TZocnfF70jkyMnF5hFMIIFOcg=;
 b=XMUlGMxltrZ3riaLaDQzpPNk0Xl3eJL4W5xjGjT/L1XuGZ5JTRERi2yZGl/rN7AShf
 WvTPQoVRIa5pt/WdUjtlKEOZHB0TX5goRhu9KeIAUDEni5Laz7POJQ8aUY0fmw34Rj6p
 Z+Hg5UPsdFHm7Ds/dDv4iFELctdZdFI3Optqn9lFgX8baX4XOFLT5rvhXonbBerIVINu
 FE66Kg37hJZMWDcPeUihgnigIA/AG393uuqw2RZX0mXdh8k2saYFWlgDuTRpz/HF8rW1
 u9ZrAsClpCnhMPKb10qiNCnreGZfEItyHtio4eZcXTEILoWoAoczR0QJFDoTTEN9D9kq
 Q8Gw==
X-Gm-Message-State: AOAM533GkEJZCU8xfVc7+rjQhyvQu5qiCJxu7WIZ1WXOj3V+TuXlYV0N
 iC9qABN0EMf146NRhzbMy3F/pm3XiVfydrBsa9Y=
X-Google-Smtp-Source: ABdhPJzhzLEYPiAZxXG6Ts/R2wI1WRbniOk6fP190GwpDc7J2bkwfeL+sbQp2QYsegx/+mGzizvgYFjZ/jUkwTSKT28=
X-Received: by 2002:a17:906:c10c:: with SMTP id
 do12mr3712430ejc.527.1601402143885; 
 Tue, 29 Sep 2020 10:55:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200910174850.716104-1-marcandre.lureau@redhat.com>
 <eeead7ec-ebde-637d-de06-31c9b343b3b8@redhat.com>
 <399aad6c-5d86-8988-a44a-e91d650e7273@redhat.com>
 <CAJ+F1CKPyBfjPoaRc5j24swo8Bfy0D7m+txNk5cyAi47rOz2bw@mail.gmail.com>
 <093067ee-e849-be8c-6e02-167d28d3e3ed@redhat.com>
In-Reply-To: <093067ee-e849-be8c-6e02-167d28d3e3ed@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 29 Sep 2020 21:55:32 +0400
Message-ID: <CAJ+F1CL1kzvHRmMOTq38r0PNyCJhzyqWeiNb71e7sabaWOwdsQ@mail.gmail.com>
Subject: Re: [PATCH] PoC: Rust binding for QAPI (qemu-ga only, for now)
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Sebastian_Dr=C3=B6ge?= <slomo@circular-chaos.org>
Content-Type: multipart/alternative; boundary="000000000000edce6d05b0777d73"
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
Cc: "P. Berrange, Daniel" <berrange@redhat.com>,
 Sergio Lopez Pascual <slp@redhat.com>, "Hajnoczi, Stefan" <stefanha@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>, "Armbruster, Markus" <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000edce6d05b0777d73
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Fri, Sep 11, 2020 at 7:17 PM Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 11/09/20 16:00, Marc-Andr=C3=A9 Lureau wrote:
> >     - from_qemu_none should be a "to_*" or "constructor" conversion (I
> used
> >     new_from_foreign)
> >
> > new_ prefix is not very rusty.
>
> Right, I have changed it to with_foreign so now there is
> {as,with,to,into}_foreign, plus unsafe_{from,into}.
>
> These two could even be renamed to from_foreign and into_native at the
> cost of making the trait less general purpose.  This way we have the
> typical Rust names: as_* for Borrowed->Borrowed, with_*/to_* for
> Borrowed->Owned, from_*/into_* for Owned->Owned.
>
> > However, the memory allocator (or the stack) may not be compatible
> > with the one used in C.
>
> Hmm, that's a good point.  The simplest solution might be just to get
> rid of IntoForeign, it's just an optimization.
>
> > from_raw() is common, and takes ownership.
>
> from_raw()/into_raw() would be equivalent to
> into_foreign()/from_foreign().  However as you point out the allocators
> are different, so it's a good idea IMHO to separate
> into_raw()/from_raw() for the Rust allocator from
> into_foreign()/from_foreign() for the libc allocator.
>
> > I would need to modify this PoC for example
>
> Yes of course.  Can you just try splitting the PoC in multiple patches?
>  That should also make it easier to review, so far all I did was
> comparing against glib-rs.
>
> > But I must say I feel quite comfortable with the glib approach. It
> > would be nice to have some feedback from glib-rs maintainers about your
> > proposal.
>
> QAPI is not tied to glib-rs, so I don't think qemu-ga will need to use
> glib-rs.  I think either we use glib-rs, or if we are to roll our own we
> should not be tied to the naming.  We don't use GObject introspection,
> so none/full means nothing to most QEMU developers (and to Rust
> developers too).
>
> There are other things I don't like very much in glib-rs, for example
> the use of tuples and public fields and the somewhat messy usage of
> *const/*mut (I tried to be stricter on that).
>
>
I am trying to wrap my head around your proposal (based on
https://github.com/bonzini/rust-ptr), and trying to understand the
limitations/unrustiness of the glib-rs translate traits I used in this PoC.

First let's clarify the requirements. We need those conversions for now:
- const *P -> T
- mut *P -> T
And:
- &T -> const *P
- &T -> mut *P

Note that glib-rs has more advanced conversions, because of partial
ownership transfer with containers, and ref-counted types etc. Those could
soon become necessary for QEMU to bind other types than QAPI, in particular
QOM and our usage of glib in general. I kept that in mind by carefully
choosing glib-rs as a reference. I think it's important to take it into
account from the start (sadly, some limitations don't allow us to simply
use glib-rs traits, for reasons that aren't 100% clear to me, but are clear
to the compiler and others :)

Some other remarks:
- "mut *P -> T" is often just "const *P -> T" with P being freed after
conversion
- "&T -> const *P" can be "&T -> mut *P" with Rust side freeing P after
usage thanks to a stash, but can also be very different and not require it
(strings for example, the constP uses CString, while the mutP version is
just a g_strndup)
- it is nice (or necessary) to have to allow some form of composition for
container-like types (Option<T>, Vec<T>, struct T(U,V) inside etc) to avoid
duplication
- Rust naming conventions guide us towards using to_ and into_ (for
owned->owned) prefixes.


The glib-rs traits map the conversion functions respectively to (I removed
the Glib/Qemu prefix, because the subset used in both are very close):
- FromPtrNone::from_none
- FromPtrFull::from_full (usually just calls from_none() and free(P))
And:
- ToPtr::to_none (with the Stash)
- ToPtr::to_full

The symmetry is clear, and arguably easy to remember. fwiw, I don't know
why ToPtr wasn't split the same way FromPtr was (they used to be on the
same FromPtr trait).

The usage of to_ prefix is in accordance with the Rust conventions here.
The usage of from_ is perhaps not ideal?, but from_full is not incompatible
with the symmetrical into_ (as in From<T> for U implies Into<U> for T).

Experience shows that the combination of Stash & ToPtr design makes it
convenient for type composition too.


My understanding of what you propose is:
- ForeignConvert::with_foreign
- FromForeign::from_foreign (with implied into_native)
And:
- ForeignConvert::as_foreign (with the BorrowedPointer/stash-like)
- ToForeign::to_foreign + ForeignConvert::as_foreign_mut (which seems
wrongly designed in your proposal and unnecessary for now)

I excluded IntoForeign::into_foreign, since "T -> P" can't really be done
better than "&T -> *P" due to different memory allocators etc.

I don't have your head, so I find it hard to remember & work with. It uses
all possible prefixes: with_, from_, as_, as_mut, to_, and into_. That just
blows my mind, sorry :)

Then, I don't understand why ForeignConvert should hold both the "const *P
-> T" and "&T -> const *P" conversions. Except the common types, what's the
relation between the two?

Finally, I thought you introduced some differences with the stash design,
but in fact I can see that ForeignConvert::Storage works just the way as
ToPtr::Storage. So composition should be similar. Only your example code is
more repetitive as it doesn't indirectly refer to the trait Storage the
same way as glib-rs does (via <T as ToPtr>::Storage).

I am not making any conclusions yet, but I am not exactly happily going to
switch to your proposal yet :)

Comments?






--=20
Marc-Andr=C3=A9 Lureau

--000000000000edce6d05b0777d73
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Sep 11, 2020 at 7:17 PM Pao=
lo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On=
 11/09/20 16:00, Marc-Andr=C3=A9 Lureau wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0- from_qemu_none should be a &quot;to_*&quot; or &q=
uot;constructor&quot; conversion (I used<br>
&gt;=C2=A0 =C2=A0 =C2=A0new_from_foreign)<br>
&gt; <br>
&gt; new_ prefix is not very rusty.<br>
<br>
Right, I have changed it to with_foreign so now there is<br>
{as,with,to,into}_foreign, plus unsafe_{from,into}.<br>
<br>
These two could even be renamed to from_foreign and into_native at the<br>
cost of making the trait less general purpose.=C2=A0 This way we have the<b=
r>
typical Rust names: as_* for Borrowed-&gt;Borrowed, with_*/to_* for<br>
Borrowed-&gt;Owned, from_*/into_* for Owned-&gt;Owned.<br>
<br>
&gt; However, the memory allocator (or the stack) may not be compatible<br>
&gt; with the one used in C.<br>
<br>
Hmm, that&#39;s a good point.=C2=A0 The simplest solution might be just to =
get<br>
rid of IntoForeign, it&#39;s just an optimization.<br>
<br>
&gt; from_raw() is common, and takes ownership.<br>
<br>
from_raw()/into_raw() would be equivalent to<br>
into_foreign()/from_foreign().=C2=A0 However as you point out the allocator=
s<br>
are different, so it&#39;s a good idea IMHO to separate<br>
into_raw()/from_raw() for the Rust allocator from<br>
into_foreign()/from_foreign() for the libc allocator.<br>
<br>
&gt; I would need to modify this PoC for example<br>
<br>
Yes of course.=C2=A0 Can you just try splitting the PoC in multiple patches=
?<br>
=C2=A0That should also make it easier to review, so far all I did was<br>
comparing against glib-rs.<br>
<br>
&gt; But I must say I feel quite comfortable with the glib approach. It<br>
&gt; would be nice to have some feedback from glib-rs maintainers about you=
r<br>
&gt; proposal.<br>
<br>
QAPI is not tied to glib-rs, so I don&#39;t think qemu-ga will need to use<=
br>
glib-rs.=C2=A0 I think either we use glib-rs, or if we are to roll our own =
we<br>
should not be tied to the naming.=C2=A0 We don&#39;t use GObject introspect=
ion,<br>
so none/full means nothing to most QEMU developers (and to Rust<br>
developers too).<br>
<br>
There are other things I don&#39;t like very much in glib-rs, for example<b=
r>
the use of tuples and public fields and the somewhat messy usage of<br>
*const/*mut (I tried to be stricter on that).<br>
<br></blockquote><div><br></div><div>I am trying to wrap my head around you=
r proposal (based on <a href=3D"https://github.com/bonzini/rust-ptr">https:=
//github.com/bonzini/rust-ptr</a>), and trying to understand the limitation=
s/unrustiness of the glib-rs translate traits I used in this PoC.<br><br>Fi=
rst let&#39;s clarify the requirements. We need those conversions for now:<=
br>- const *P -&gt; T<br>- mut *P -&gt; T<br>And:<br>- &amp;T -&gt; const *=
P<br>- &amp;T -&gt; mut *P<br><br>Note that glib-rs has more advanced conve=
rsions, because of partial ownership transfer with containers, and ref-coun=
ted types etc. Those could soon become necessary for QEMU to bind other typ=
es than QAPI, in particular QOM and our usage of glib in general. I kept th=
at in mind by carefully choosing glib-rs as a reference. I think it&#39;s i=
mportant to take it into account from the start (sadly, some limitations do=
n&#39;t allow us to simply use glib-rs traits, for reasons that aren&#39;t =
100% clear to me, but are clear to the compiler and others :)<br><br>Some o=
ther remarks:<br>- &quot;mut *P -&gt; T&quot; is often just &quot;const *P =
-&gt; T&quot; with P being freed after conversion<br>- &quot;&amp;T -&gt; c=
onst *P&quot; can be &quot;&amp;T -&gt; mut *P&quot; with Rust side freeing=
 P after usage thanks to a stash, but can also be very different and not re=
quire it (strings for example, the constP uses CString, while the mutP vers=
ion is just a g_strndup)<br>- it is nice (or necessary) to have to allow so=
me form of composition for container-like types (Option&lt;T&gt;, Vec&lt;T&=
gt;, struct T(U,V) inside etc) to avoid duplication<br>- Rust naming conven=
tions guide us towards using to_ and into_ (for owned-&gt;owned) prefixes.<=
br><br><br>The glib-rs traits map the conversion functions respectively to =
(I removed the Glib/Qemu prefix, because the subset used in both are very c=
lose):<br>- FromPtrNone::from_none<br>- FromPtrFull::from_full (usually jus=
t calls from_none() and free(P))<br>And:<br>- ToPtr::to_none (with the Stas=
h)<br>- ToPtr::to_full<br><br>The symmetry is clear, and arguably easy to r=
emember. fwiw, I don&#39;t know why ToPtr wasn&#39;t split the same way Fro=
mPtr was (they used to be on the same FromPtr trait).<br><br>The usage of t=
o_ prefix is in accordance with the Rust conventions here. The usage of fro=
m_ is perhaps not ideal?, but from_full is not incompatible with the symmet=
rical into_ (as in From&lt;T&gt; for U implies Into&lt;U&gt; for T).<br><br=
>Experience shows that the combination of Stash &amp; ToPtr design makes it=
 convenient for type composition too.<br><br><br>My understanding of what y=
ou propose is:<br>- ForeignConvert::with_foreign<br>- FromForeign::from_for=
eign (with implied into_native)<br>And:<br>- ForeignConvert::as_foreign (wi=
th the BorrowedPointer/stash-like)<br>- ToForeign::to_foreign + ForeignConv=
ert::as_foreign_mut (which seems wrongly designed in your proposal and unne=
cessary for now)<br><br>I excluded IntoForeign::into_foreign, since &quot;T=
 -&gt; P&quot; can&#39;t really be done better than &quot;&amp;T -&gt; *P&q=
uot; due to different memory allocators etc.<br><br>I don&#39;t have your h=
ead, so I find it hard to remember &amp; work with. It uses all possible pr=
efixes: with_, from_, as_, as_mut, to_, and into_. That just blows my mind,=
 sorry :)<br><br>Then, I don&#39;t understand why ForeignConvert should hol=
d both the &quot;const *P -&gt; T&quot; and &quot;&amp;T -&gt; const *P&quo=
t; conversions. Except the common types, what&#39;s the relation between th=
e two?<br><br>Finally, I thought you introduced some differences with the s=
tash design, but in fact I can see that ForeignConvert::Storage works just =
the way as ToPtr::Storage. So composition should be similar. Only your exam=
ple code is more repetitive as it doesn&#39;t indirectly refer to the trait=
 Storage the same way as glib-rs does (via &lt;T as ToPtr&gt;::Storage).<br=
><br>I am not making any conclusions yet, but I am not exactly happily goin=
g to switch to your proposal yet :)<br><br>Comments?<br><br><br><br><br>=C2=
=A0</div></div><br>-- <br><div dir=3D"ltr" class=3D"gmail_signature">Marc-A=
ndr=C3=A9 Lureau<br></div></div>

--000000000000edce6d05b0777d73--

