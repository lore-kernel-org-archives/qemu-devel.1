Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD98DC47420
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 09:16:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D792320739
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 09:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kib03p1Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D792320739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNYE0-00067B-Vo
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 05:16:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59654)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kNYCv-0005gD-9h
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 05:15:29 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:39443)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kNYCs-0001wO-90
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 05:15:28 -0400
Received: by mail-ej1-x641.google.com with SMTP id p9so1723085ejf.6
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 02:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=C6Foid6DgIxSgqFLyBKsCrQL6b70YMsMHoHd57JeA3s=;
 b=kib03p1Yg7p+sWVhXZScVJbOTgH6J7SrbAg5l2hNHTXNizWW8kp+sIDPrT6iNq03le
 m4hwhmdEp+HvDyuJ3SmOm1xlQPhSfwlq9Ed6uUJwU+oZM5e6bOupxqoeInwkUBhf60Za
 kKdHlQ/mNCrBSjqyZz0hKB1qVN/gQARfqVkuUA6GthoAsOfxahwypUOI33PjCBwkeiW0
 vYvGz8axFULUXZHv0TpAD2nZChyJYBDM/yv3UjYaUpmOeCL4jc+WUwRM76Y8ESK2sOLI
 X38eaCR55nXkvcaYC9QkdADqFWwP793qiSpndU2UZD31vn1ygH9pGd9m+Y5X3UhAR1hN
 14Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=C6Foid6DgIxSgqFLyBKsCrQL6b70YMsMHoHd57JeA3s=;
 b=Crqt2UbayrrqKE8ShEUfUkPQv6nj4FUDRS/vouK8u+VQBNzUGEhZT4SEfMMG6bqQ+q
 mMyaV6IKpH82N+ZcwTW/foGO8MpFAvQUkGrwxayO76cTxqGBOMbyRKjEhNssON4zlsgB
 jTkaHCKKcQnNZaCS83gHPhTrS8Vn2ZJn/I5x31IV9pNd62ZenKqYlgo4V5+tDJTuXb4U
 pfuappBXMX3c/4bvBTtK58hbRJV2j7VU/uOsEsP665DIWDxwWLRZ+BEu3xUUW511cF6z
 6IoDU611CrEFdR5+IsyYYX35tqJLpD9DZof8wq9eZba0KLYkXydbuQ9ZHCoteYOEE6Q8
 Jibg==
X-Gm-Message-State: AOAM5339Fr33Ozv+gQTnrzs0RVXvJnCfD4/T4dcAUv5us/9/z7lYCm2E
 YxHu11Jx9qQ1HlGn9XIzCr2Adlsq7I3PBDZBYBI=
X-Google-Smtp-Source: ABdhPJwArakGP2UZM8+nLz17qUED4doogTlC5D5nbFaJ5CTagPOC0zb4GF3wfW16124zCzHvtyEiMPkiBFZDL/U5fEo=
X-Received: by 2002:a17:906:a88a:: with SMTP id
 ha10mr1941559ejb.532.1601457324611; 
 Wed, 30 Sep 2020 02:15:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200910174850.716104-1-marcandre.lureau@redhat.com>
 <eeead7ec-ebde-637d-de06-31c9b343b3b8@redhat.com>
 <399aad6c-5d86-8988-a44a-e91d650e7273@redhat.com>
 <CAJ+F1CKPyBfjPoaRc5j24swo8Bfy0D7m+txNk5cyAi47rOz2bw@mail.gmail.com>
 <093067ee-e849-be8c-6e02-167d28d3e3ed@redhat.com>
 <CAJ+F1CL1kzvHRmMOTq38r0PNyCJhzyqWeiNb71e7sabaWOwdsQ@mail.gmail.com>
 <ddd2e282-3e0e-1c0e-2af3-7ca59c322ef9@redhat.com>
In-Reply-To: <ddd2e282-3e0e-1c0e-2af3-7ca59c322ef9@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 30 Sep 2020 13:15:12 +0400
Message-ID: <CAJ+F1CL7r31u1bQLRGmbZt-BPLM3XefFdY9O3Mk=VMmgJ76aiw@mail.gmail.com>
Subject: Re: [PATCH] PoC: Rust binding for QAPI (qemu-ga only, for now)
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000f4df5005b0845609"
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ej1-x641.google.com
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
 =?UTF-8?Q?Sebastian_Dr=C3=B6ge?= <slomo@circular-chaos.org>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000f4df5005b0845609
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Tue, Sep 29, 2020 at 10:23 PM Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 29/09/20 19:55, Marc-Andr=C3=A9 Lureau wrote:
> > My understanding of what you propose is:
> > - ForeignConvert::with_foreign
> > - FromForeign::from_foreign (with implied into_native)
> > And:
> > - ForeignConvert::as_foreign (with the BorrowedPointer/stash-like)
> > - ToForeign::to_foreign + ForeignConvert::as_foreign_mut (which seems
> > wrongly designed in your proposal and unnecessary for now)
>
> Might well be, but how is it wrong?  (I'd like to improve).
>

Why BorrowedMutPointer provides both *const P and *mut P ? The *const P
conversion seems overlapping with BorrowedPointer.

Anyway, the &mut T -> *mut P conversion seems fairly rare to me and
error-prone. You usually give up ownership if you let the foreign function
tweak the P.

In any case, we don't need such conversion for QAPI, for now.


> > I don't have your head, so I find it hard to remember & work with. It>
> uses all possible prefixes: with_, from_, as_, as_mut, to_, and into_.
> > That just blows my mind, sorry :)
>
> Ahah I don't have your head either!  The idea anyway is to reuse
> prefixes that are common in Rust code:
>
> * with_: a constructor that uses something to build a type (think
> Vec::with_capacity) and therefore takes ownership
>


ForeignConvert::with_foreign (const *P -> T) doesn't take ownership.

The Rust reference for this kind of conversion is CStr::from_ptr.


> * as_: a cheap conversion to something, it's cheap because it reuses the
> lifetime (and therefore takes no ownership).  Think Option::as_ref.
>

as_ shouldn't create any object, and is thus unsuitable for a general
rs<->sys conversion function (any).

* from_/to_: a copying and possibly expensive conversion (that you have
> to write the code for).  Because it's copying, it doesn't consume the
> argument (for from_) or self (for to_).
>
>
and that's what glib-rs uses (and CStr).



> * into_: a conversion that consumes the receiver
>
>
That's not used by glib afaik, but we should be able to introduce it for
"mut *P -> T", it's not incompatible with FromPtrFull::from_full.

In general, I like the fact that the conversion traits are associated to T,
and not to P (which can remain a bare pointer, without much associated
methods).

It may well be over the top.
>
> > Then, I don't understand why ForeignConvert should hold both the "const
> > *P -> T" and "&T -> const *P" conversions. Except the common types,
> > what's the relation between the two?
>
> Maybe I'm wrong, but why would you need just one?
>

No I mean they could be on different traits. One could be implemented
without the other. Or else I don't understand why the other conversion
functions would not be in that trait too.


> > Finally, I thought you introduced some differences with the stash
> > design, but in fact I can see that ForeignConvert::Storage works just
> > the way as ToPtr::Storage. So composition should be similar. Only your
> > example code is more repetitive as it doesn't indirectly refer to the
> > trait Storage the same way as glib-rs does (via <T as ToPtr>::Storage).
>
> Yes, that's the main difference.  I removed Storage because I didn't
> want to force any trait on BorrowedPointer's second type argument.  It
> seemed like a generic concept to me.
>

To the cost of some duplication. I like the coupling between the traits
better. If you need a similar tuple/struct elsewhere, it's easy to make
your own.

The Storage type can quickly become quite complicated with QAPI, I would
rather avoid having to repeat it, it would create hideous compiler errors
too.


> The other difference is that Stash is a tuple while BorrowedPointer is a
> struct and has methods to access it.  Stash seems very ugly to use.
>

Yes I agree. Not sure why they made it a bare tuple, laziness perhaps :).


--=20
Marc-Andr=C3=A9 Lureau

--000000000000f4df5005b0845609
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 29, 2020 at 10:23 PM Pa=
olo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">O=
n 29/09/20 19:55, Marc-Andr=C3=A9 Lureau wrote:<br>
&gt; My understanding of what you propose is:<br>
&gt; - ForeignConvert::with_foreign<br>
&gt; - FromForeign::from_foreign (with implied into_native)<br>
&gt; And:<br>
&gt; - ForeignConvert::as_foreign (with the BorrowedPointer/stash-like)<br>
&gt; - ToForeign::to_foreign + ForeignConvert::as_foreign_mut (which seems<=
br>
&gt; wrongly designed in your proposal and unnecessary for now)<br>
<br>
Might well be, but how is it wrong?=C2=A0 (I&#39;d like to improve).<br></b=
lockquote><div><br></div>Why BorrowedMutPointer provides both *const P and =
*mut P ? The *const P conversion seems overlapping with BorrowedPointer.</d=
iv><div class=3D"gmail_quote"><br></div><div class=3D"gmail_quote">Anyway, =
the &amp;mut T -&gt; *mut P conversion seems fairly rare to me and error-pr=
one. You usually give up ownership if you let the foreign function tweak th=
e P.<br></div><div class=3D"gmail_quote"><div><br></div><div>In any case, w=
e don&#39;t need such conversion for QAPI, for now.</div><div><br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; I don&#39;t have your head, so I find it hard to remember &amp; work w=
ith. It&gt; uses all possible prefixes: with_, from_, as_, as_mut, to_, and=
 into_.<br>
&gt; That just blows my mind, sorry :)<br>
<br>
Ahah I don&#39;t have your head either!=C2=A0 The idea anyway is to reuse<b=
r>
prefixes that are common in Rust code:<br>
<br>
* with_: a constructor that uses something to build a type (think<br>
Vec::with_capacity) and therefore takes ownership<br></blockquote><div><br>=
</div><div><br></div><div>ForeignConvert::with_foreign (const *P -&gt; T) d=
oesn&#39;t take ownership.</div><div><br></div><div>The Rust reference for =
this kind of conversion is CStr::from_ptr.</div><div><br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">
<br>
* as_: a cheap conversion to something, it&#39;s cheap because it reuses th=
e<br>
lifetime (and therefore takes no ownership).=C2=A0 Think Option::as_ref.<br=
></blockquote><div><br></div><div>as_ shouldn&#39;t create any object, and =
is thus unsuitable for a general rs&lt;-&gt;sys conversion function (any). =
<br></div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
* from_/to_: a copying and possibly expensive conversion (that you have<br>
to write the code for).=C2=A0 Because it&#39;s copying, it doesn&#39;t cons=
ume the<br>
argument (for from_) or self (for to_).<br>
<br></blockquote><div><br></div><div>and that&#39;s what glib-rs uses (and =
CStr).</div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">
* into_: a conversion that consumes the receiver<br>
<br></blockquote><div><br></div><div>That&#39;s not used by glib afaik, but=
 we should be able to introduce it for &quot;mut *P -&gt; T&quot;, it&#39;s=
 not incompatible with FromPtrFull::from_full.</div><div><br></div><div>In =
general, I like the fact that the conversion traits are associated to T, an=
d not to P (which can remain a bare pointer, without much associated method=
s).<br></div><div><br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">
It may well be over the top.<br>
<br>
&gt; Then, I don&#39;t understand why ForeignConvert should hold both the &=
quot;const<br>
&gt; *P -&gt; T&quot; and &quot;&amp;T -&gt; const *P&quot; conversions. Ex=
cept the common types,<br>
&gt; what&#39;s the relation between the two?<br>
<br>
Maybe I&#39;m wrong, but why would you need just one?<br></blockquote><div>=
<br></div><div>No I mean they could be on different traits. One could be im=
plemented without the other. Or else I don&#39;t understand why the other c=
onversion functions would not be in that trait too.<br></div><div> <br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; Finally, I thought you introduced some differences with the stash<br>
&gt; design, but in fact I can see that ForeignConvert::Storage works just<=
br>
&gt; the way as ToPtr::Storage. So composition should be similar. Only your=
<br>
&gt; example code is more repetitive as it doesn&#39;t indirectly refer to =
the<br>
&gt; trait Storage the same way as glib-rs does (via &lt;T as ToPtr&gt;::St=
orage).<br>
<br>
Yes, that&#39;s the main difference.=C2=A0 I removed Storage because I didn=
&#39;t<br>
want to force any trait on BorrowedPointer&#39;s second type argument.=C2=
=A0 It<br>
seemed like a generic concept to me.<br></blockquote><div><br></div><div>To=
 the cost of some duplication. I like the coupling between the traits bette=
r. If you need a similar tuple/struct elsewhere, it&#39;s easy to make your=
 own.</div><div><br></div><div>The Storage type can quickly become quite co=
mplicated with QAPI, I would rather avoid having to repeat it, it would cre=
ate hideous compiler errors too.<br></div><div> <br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
<br>
The other difference is that Stash is a tuple while BorrowedPointer is a<br=
>
struct and has methods to access it.=C2=A0 Stash seems very ugly to use.<br=
></blockquote><div><br></div><div>Yes I agree. Not sure why they made it a =
bare tuple, laziness perhaps :).</div><br></div><br>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--000000000000f4df5005b0845609--

