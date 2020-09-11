Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68E9C43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 14:02:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3591F21D47
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 14:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgLujWO/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3591F21D47
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGjd2-00043Y-5j
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 10:02:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kGjbo-000399-1j
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 10:01:00 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:37628)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kGjbm-0007X4-3c
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 10:00:59 -0400
Received: by mail-ej1-x644.google.com with SMTP id nw23so13966643ejb.4
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 07:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4gmbIN9MUFb5Y4MPI3v2FyDiHafDV5zj1YzK/YIF25A=;
 b=lgLujWO/vzgIQrslH2D6TFevhu2ZsK3R6vINHzwbg/AG3DAYKVx516lVwT7MeUJHvz
 FDHVN0nRp/VBVBn8cqOQBLFO0nNj/Gy2Nc9FQtdfzL60W2B+S6y2g1ucCbKQSZ2s7R/w
 Q7BQlq3cE3RalB1bJcK9pOEw1CDnd3JVrymlO8ppXRpKGJqTaviNMmXOnbgB64dHjAtP
 ARwfXfdHsTR7nA3hUcEj21l9VDARhwCvf9htY7MoJV+NLCIiP/Od+LYh8IW2WHcIE5LY
 CQ2D+n/TTc/CLUJwFvFQdJqN6ND8NATBrnFXa9yq8cu3YMDLBUlrQ0zR2G6V1GPkb6yr
 Mrtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4gmbIN9MUFb5Y4MPI3v2FyDiHafDV5zj1YzK/YIF25A=;
 b=bfiArDRHOJWsmUdf1sICMY7zzgh6SUHnDSAy2gCq569Au0qiT2JN3yIo1M8wcuHG5c
 VoflBe/Re8o2iLImPIex9fUaZR2BVpFEsVo0BDQj/br/59OUc9KEp1zmIAl8/hT5MiLD
 e1S3IZfy7jkEO8XwW8w3eeCaQu357GMMqpZNgVTzNxb72ew+lKAX6OcfS+E7xXGK+rHP
 0zeWwTn1g2naLXm5ayyB8GYnB4jsD6FXBMU8IcTTAFtWnAmPmBuWzFeekQ/ozuXPzzGQ
 m+5wErmzyrH4Hfb+/x+IfZOWM9yGAwxuFXjat0ePun3Vqr5RqBkCs/DLg/X3uBhAicRw
 XzRg==
X-Gm-Message-State: AOAM531k+M6scJ2OWmOvh5KBeLfadRySJYYYFI96jksaRX0bX47dNY0/
 nKKEjs96OL9bBUFidohP/UXcX9iKaEx5OeYNMwo=
X-Google-Smtp-Source: ABdhPJxVgMv3A8wnpmKS/l0dk73v8+p0kK30Nnh3aS67uQTzjKn9HmUILJ5l0cwUPNMApBLM2FZvRHI2NisufkcKk7Q=
X-Received: by 2002:a17:906:faec:: with SMTP id
 lu44mr2113759ejb.527.1599832856577; 
 Fri, 11 Sep 2020 07:00:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200910174850.716104-1-marcandre.lureau@redhat.com>
 <eeead7ec-ebde-637d-de06-31c9b343b3b8@redhat.com>
 <399aad6c-5d86-8988-a44a-e91d650e7273@redhat.com>
In-Reply-To: <399aad6c-5d86-8988-a44a-e91d650e7273@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 11 Sep 2020 18:00:44 +0400
Message-ID: <CAJ+F1CKPyBfjPoaRc5j24swo8Bfy0D7m+txNk5cyAi47rOz2bw@mail.gmail.com>
Subject: Re: [PATCH] PoC: Rust binding for QAPI (qemu-ga only, for now)
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000001dcb5805af0a1d9b"
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

--0000000000001dcb5805af0a1d9b
Content-Type: text/plain; charset="UTF-8"

Hi

On Fri, Sep 11, 2020 at 5:08 PM Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 11/09/20 12:24, Paolo Bonzini wrote:
> >>
> >> - from_qemu_none(ptr: *const sys::P) -> T
> >>   Return a Rust type T for a const ffi pointer P.
> >>
> >> - from_qemu_full(ptr: *mut sys::P) -> T
> >>   Return a Rust type T for a ffi pointer P, taking ownership.
> >>
> >> - T::to_qemu_none() -> Stash<P>
> >>   Returns a borrowed ffi pointer P (using a Stash to destroy "glue"
> >>   storage data, if any).
> >>
> >> - T::to_qemu_full() -> P
> >>   Returns a ffi pointer P. (P resources are leaked/passed to C/ffi)
> >
> > I know these come from glib-rs, but still the names are awful. :)
>
> After studying a bit I managed to give a rational explanation of the
> above gut feeling.  Conversions in Rust usually follow this naming
> convention:
>
>         Name              Type                  Price
>         --------          --------------------  -----------
>         as_*, borrow      Borrowed -> Borrowed  Cheap
>         to_*, constructor Borrowed -> Owned     Expensive
>         from, into_*      Owned -> Owned        Any
>
> and we have
>
>         from_qemu_none    Borrowed -> Owned
>         to_qemu_none      Borrowed -> Borrowed
>         from_qemu_full    Owned -> Owned
>         to_qemu_full      Owned -> Owned
>
> So
>
> - from_qemu_none should be a "to_*" or "constructor" conversion (I used
> new_from_foreign)
>

new_ prefix is not very rusty.

from_raw() is common, and takes ownership.
from_ptr() (as in CStr) could be a candidate (although it wouldn't have the
same lifetime requirements)


> - to_qemu_none, even though in some cases it can be expensive, should be
> an "as_*" conversion (as_foreign).
>

as_ptr(), but since it's more complicated than just a pointer due to
temporary storage, it's not the best fit either...


> - from_qemu_full and to_qemu_full should be "from" or "into_*"
>

ok


>
> to_qemu_full() could also be split into a more expensive but flexible
> "to" variant and the cheaper "into" variant.  Just for the sake of
> example, I updated my demo by replacing the IntoRaw trait with these two:
>
>     trait ToForeign<T> {
>         fn to_foreign(&self) -> *mut T;
>     }
>
>     trait IntoForeign<T> {
>         fn into_foreign(self) -> *mut T;
>     }
>
> where the example implementations show the different cost quite clearly:
>
>     impl ToForeign<c_char> for String {
>         fn to_foreign(&self) -> *mut c_char {
>             unsafe { libc::strndup(self.as_ptr() as *const c_char,
>                                    self.len() as size_t) }
>         }
>     }
>
>     impl IntoForeign<c_char> for String {
>         fn into_foreign(self) -> *mut c_char {
>             let ptr = self.as_ptr();
>             forget(self);
>             ptr as *mut _
>         }
>     }
>
>
You corrected the \0-ending in the git tree. However, the memory allocator
(or the stack) may not be compatible with the one used in C.

 As for the general comparison with glib-rs traits, it's hard for me to say
upfront the pros and cons, I would need to modify this PoC for example. But
I must say I feel quite comfortable with the glib approach. It would be
nice to have some feedback from glib-rs maintainers about your proposal.

(my gut feeling is that we would be better sticking with something close to
glib, as it is likely we will end up using glib-rs at some point, and
having similar patterns should help each other)

--0000000000001dcb5805af0a1d9b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Sep 11, 2020 at 5:08 PM Pao=
lo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On=
 11/09/20 12:24, Paolo Bonzini wrote:<br>
&gt;&gt;<br>
&gt;&gt; - from_qemu_none(ptr: *const sys::P) -&gt; T<br>
&gt;&gt;=C2=A0 =C2=A0Return a Rust type T for a const ffi pointer P.<br>
&gt;&gt;<br>
&gt;&gt; - from_qemu_full(ptr: *mut sys::P) -&gt; T<br>
&gt;&gt;=C2=A0 =C2=A0Return a Rust type T for a ffi pointer P, taking owner=
ship.<br>
&gt;&gt;<br>
&gt;&gt; - T::to_qemu_none() -&gt; Stash&lt;P&gt;<br>
&gt;&gt;=C2=A0 =C2=A0Returns a borrowed ffi pointer P (using a Stash to des=
troy &quot;glue&quot;<br>
&gt;&gt;=C2=A0 =C2=A0storage data, if any).<br>
&gt;&gt;<br>
&gt;&gt; - T::to_qemu_full() -&gt; P<br>
&gt;&gt;=C2=A0 =C2=A0Returns a ffi pointer P. (P resources are leaked/passe=
d to C/ffi)<br>
&gt;<br>
&gt; I know these come from glib-rs, but still the names are awful. :)<br>
<br>
After studying a bit I managed to give a rational explanation of the<br>
above gut feeling.=C2=A0 Conversions in Rust usually follow this naming<br>
convention:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Type=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 P=
rice<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 --------=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ----=
----------------=C2=A0 -----------<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 as_*, borrow=C2=A0 =C2=A0 =C2=A0 Borrowed -&gt;=
 Borrowed=C2=A0 Cheap<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 to_*, constructor Borrowed -&gt; Owned=C2=A0 =
=C2=A0 =C2=A0Expensive<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 from, into_*=C2=A0 =C2=A0 =C2=A0 Owned -&gt; Ow=
ned=C2=A0 =C2=A0 =C2=A0 =C2=A0 Any<br>
<br>
and we have<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 from_qemu_none=C2=A0 =C2=A0 Borrowed -&gt; Owne=
d<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 to_qemu_none=C2=A0 =C2=A0 =C2=A0 Borrowed -&gt;=
 Borrowed<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 from_qemu_full=C2=A0 =C2=A0 Owned -&gt; Owned<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 to_qemu_full=C2=A0 =C2=A0 =C2=A0 Owned -&gt; Ow=
ned<br>
<br>
So<br>
<br>
- from_qemu_none should be a &quot;to_*&quot; or &quot;constructor&quot; co=
nversion (I used<br>
new_from_foreign)<br></blockquote><div><br></div><div>new_ prefix is not ve=
ry rusty.</div><div><br></div><div>from_raw() is common, and takes ownershi=
p.<br></div><div>from_ptr() (as in CStr) could be a candidate (although it =
wouldn&#39;t have the same lifetime requirements)<br></div><div><br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">
<br>
- to_qemu_none, even though in some cases it can be expensive, should be<br=
>
an &quot;as_*&quot; conversion (as_foreign).<br></blockquote><div><br></div=
><div>as_ptr(), but since it&#39;s more complicated than just a pointer due=
 to temporary storage, it&#39;s not the best fit either...</div><div> <br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
- from_qemu_full and to_qemu_full should be &quot;from&quot; or &quot;into_=
*&quot;<br></blockquote><div><br></div><div>ok<br></div><div>=C2=A0</div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">
<br>
to_qemu_full() could also be split into a more expensive but flexible<br>
&quot;to&quot; variant and the cheaper &quot;into&quot; variant.=C2=A0 Just=
 for the sake of<br>
example, I updated my demo by replacing the IntoRaw trait with these two:<b=
r>
<br>
=C2=A0 =C2=A0 trait ToForeign&lt;T&gt; {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 fn to_foreign(&amp;self) -&gt; *mut T;<br>
=C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 trait IntoForeign&lt;T&gt; {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 fn into_foreign(self) -&gt; *mut T;<br>
=C2=A0 =C2=A0 }<br>
<br>
where the example implementations show the different cost quite clearly:<br=
>
<br>
=C2=A0 =C2=A0 impl ToForeign&lt;c_char&gt; for String {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 fn to_foreign(&amp;self) -&gt; *mut c_char {<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsafe { libc::strndup(self.as_pt=
r() as *const c_char,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.len() as size_t) }=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 impl IntoForeign&lt;c_char&gt; for String {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 fn into_foreign(self) -&gt; *mut c_char {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 let ptr =3D self.as_ptr();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 forget(self);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ptr as *mut _<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 }<br>
<br></blockquote><div><br></div><div>You corrected the \0-ending in the git=
 tree. However, the memory allocator (or the stack) may not be compatible w=
ith the one used in C.<br></div><div><br></div><div>=C2=A0As for the genera=
l comparison with glib-rs traits, it&#39;s hard for me to say upfront the p=
ros and cons, I would need to modify this PoC for example. But I must say I=
 feel quite comfortable with the glib approach. It would be nice to have so=
me feedback from glib-rs maintainers about your proposal.<br></div><div><br=
></div><div>(my gut feeling is that we would be better sticking with someth=
ing close to glib, as it is likely we will end up using glib-rs at some poi=
nt, and having similar patterns should help each other)<br></div></div></di=
v>

--0000000000001dcb5805af0a1d9b--

