Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716A9C00A89
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 11:28:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55F352078E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 11:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMN3i8pb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55F352078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kadRI-0003mW-Rf
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 06:28:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33338)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kadQH-0003Jk-IR
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 06:27:21 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d]:33478)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kadQF-0007oW-CB
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 06:27:21 -0500
Received: by mail-ed1-x52d.google.com with SMTP id v4so1156576edi.0
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 03:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Osvfe3g71aX1dmIhx41Ah5E1FVc3sHbtLyhpyEmM/aA=;
 b=bMN3i8pbH9NYtAEahIMr3A4ZjF4QOKdVkji09IIlqfGxhM+HahiNIC/K1JKVe23V7F
 CDMix75W1exFsb+fdKyIFlm8U9cJbsrGx4BD4adfXwMROkRh/WjTSkaR57EUnXRpvC1c
 C8qARgdLDqTBfZY2opNwlOi2lsg0sgdur3mVZkyHygdL0C8s1Em3/PZyz6dPme7AV0jk
 onvY9fWmOKOVWM676AWpucnlcmKfG3Kuxo4vu/EAr3szExIpuI5+WpIUFH5LdC4g2vTl
 hnoDsPAv6qx5wXOkMoqF666XStvKkO28mjmkU74ZSkYXCEnR8MtoGPZhBynrN+DErOw0
 vGUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Osvfe3g71aX1dmIhx41Ah5E1FVc3sHbtLyhpyEmM/aA=;
 b=Py7a1RoK1UGv7t+Y3oK8bjw7/1Riyo5PP4DYF6GqWCl0WeaZXrORbqSNqaymIig9if
 N1I5JwpdVEarbSNUozR/MAoUTfa4ykui0hRHnKNLLY9QpdJLXVrHXjnRzLgprrKeogUD
 b+v2Y/3p2RPhJcGKQR4Pjb0iIzeGi4F5W7p0qBJq1ULRzzR4CcFn0/1LflA2pSSk5/t+
 yQpIDOzHK3Y3Plj6JTygxTvv68pEuw40OXXEK1vSjg3hkNwETFYQQTH6j8lZiyt8jwR9
 yBN2xgjlWgYnqt7HI9sSMim6NIaQfrCgSFft/01oA4nBsKDxgHkOoeCNf837j7KgEYNJ
 GTlg==
X-Gm-Message-State: AOAM532zll3x9HZDdsWYjlP0JfE87B2MacHqcT0A6EtjcGOf/XNrbd86
 KCGitdc0QfFiafssQEI+COkWy8zXR9hJM9zwCeM=
X-Google-Smtp-Source: ABdhPJwVjFGKrXej4Rt/dl/fp307kmAozhaeNV0QRlFUZ+FyvKp7T1AMlaF+FR0ZIfN4ApQ5nEN/CevoThz7MpSyLP0=
X-Received: by 2002:a05:6402:195:: with SMTP id
 r21mr1980420edv.164.1604575636792; 
 Thu, 05 Nov 2020 03:27:16 -0800 (PST)
MIME-Version: 1.0
References: <20201015165255.1573897-1-marcandre.lureau@redhat.com>
 <20201015165255.1573897-2-marcandre.lureau@redhat.com>
 <b669f195-9440-16d7-5b41-c082f4cac9bb@redhat.com>
In-Reply-To: <b669f195-9440-16d7-5b41-c082f4cac9bb@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 5 Nov 2020 15:27:03 +0400
Message-ID: <CAJ+F1CL5h0OYJamCywe17XwyDW9wSytNmV79RbK61S+H0rjLbQ@mail.gmail.com>
Subject: Re: [PATCH 1/9] qapi: replace List[str] by IfCond
To: John Snow <jsnow@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000d8aa2d05b35a60a7"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ed1-x52d.google.com
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, QEMU <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000d8aa2d05b35a60a7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Wed, Oct 28, 2020 at 1:22 AM John Snow <jsnow@redhat.com> wrote:

> On 10/15/20 12:52 PM, marcandre.lureau@redhat.com wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Wrap the 'if' condition in a higher-level object. Not only this is
> > allows more type safety but also further refactoring without too much
> > chrun. The following patches will extend the syntax of 'if' and will
> > have some extra handling and types.
> >
>
> Probably a good idea. Thanks for basing it on Pt6; I'll try to push
> ahead as fast as I can -- though there are some more aggressive cleanups
> in error, expr, and parser that we haven't discussed on list yet much
> and are quite prone to change.
>
> Let me know if you have any comments or feedbacks regarding what you
> found there!
>

Overall, I was pretty happy with the result. Although it seemed a bit
awkward to have types everywhere in Python (it doesn't feel as consistent
as with other languages, I think I need to get used to it)


> Pts 2 (introspect.py) and 3 (expr.py) are recently re-sent to list, if
> you have specific critique in those areas.
>

Done, not much comments


> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   docs/sphinx/qapidoc.py     |  2 +-
> >   scripts/qapi/commands.py   |  4 +-
> >   scripts/qapi/common.py     | 26 ++++++++---
> >   scripts/qapi/events.py     |  4 +-
> >   scripts/qapi/gen.py        |  9 ++--
> >   scripts/qapi/introspect.py | 21 ++++-----
> >   scripts/qapi/schema.py     | 91 ++++++++++++++++++++-----------------=
-
> >   scripts/qapi/types.py      | 11 ++---
> >   scripts/qapi/visit.py      |  9 ++--
> >   9 files changed, 102 insertions(+), 75 deletions(-)
> >
> > diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> > index 11e97839de..db9520f37f 100644
> > --- a/docs/sphinx/qapidoc.py
> > +++ b/docs/sphinx/qapidoc.py
> > @@ -116,7 +116,7 @@ class QAPISchemaGenRSTVisitor(QAPISchemaVisitor):
> >           the conditions are in literal-text and the commas are not.
> >           If with_if is False, we don't return the "(If: " and ")".
> >           """
> > -        condlist =3D intersperse([nodes.literal('', c) for c in ifcond=
],
> > +        condlist =3D intersperse([nodes.literal('', c) for c in
> ifcond.ifcond],
> >                                  nodes.Text(', '))
> >           if not with_if:
> >               return condlist
> > diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
> > index 50978090b4..03deac5fdd 100644
> > --- a/scripts/qapi/commands.py
> > +++ b/scripts/qapi/commands.py
> > @@ -20,7 +20,7 @@ from typing import (
> >       Set,
> >   )
> >
> > -from .common import c_name, mcgen
> > +from .common import IfCond, c_name, mcgen
> >   from .gen import (
> >       QAPIGenC,
> >       QAPIGenCCode,
> > @@ -301,7 +301,7 @@ void %(c_prefix)sqmp_init_marshal(QmpCommandList
> *cmds);
> >       def visit_command(self,
> >                         name: str,
> >                         info: QAPISourceInfo,
> > -                      ifcond: List[str],
> > +                      ifcond: IfCond,
> >                         features: List[QAPISchemaFeature],
> >                         arg_type: Optional[QAPISchemaObjectType],
> >                         ret_type: Optional[QAPISchemaType],
> > diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> > index 11b86beeab..59e6a400da 100644
> > --- a/scripts/qapi/common.py
> > +++ b/scripts/qapi/common.py
> > @@ -12,7 +12,7 @@
> >   # See the COPYING file in the top-level directory.
> >
> >   import re
> > -from typing import Optional, Sequence
> > +from typing import Optional, Sequence, Union
> >
> >
> >   #: Magic string that gets removed along with all space to its right.
> > @@ -194,18 +194,34 @@ def guardend(name: str) -> str:
> >                    name=3Dc_fname(name).upper())
> >
> >
> > -def gen_if(ifcond: Sequence[str]) -> str:
> > +class IfCond:
> > +    def __init__(self, ifcond: Optional[Sequence[str]] =3D None):
> > +        self.ifcond =3D ifcond or []
> > +
> > +    def __bool__(self) -> bool:
> > +        return bool(self.ifcond)
> > +
> > +    def __repr__(self) -> str:
> > +        return repr(self.ifcond)
> > +
> > +    def __eq__(self, other: object) -> bool:
> > +        if not isinstance(other, IfCond):
> > +            return NotImplemented
> > +        return self.ifcond =3D=3D other.ifcond
> > +
>
> Haven't looked ahead yet, forgive me if this is a bad idea:
>
> worth adding an __iter__ method here so that callers don't have to call
> "for x in ifcond.ifcond" ?
>
> Maybe you refactor such that this is becomes pointless.
>

Yes, the new expression tree and generation code is quite different now.
Not really worth it as an intermediary refactoring step.


> Also; should we create an Ifcond object in schema.py instead in common,
> as it's a generic representation of the #if conditionals, less tied to
> the C generation?
>
>
Good point, I'll update.

thanks

--=20
Marc-Andr=C3=A9 Lureau

--000000000000d8aa2d05b35a60a7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi<br></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Wed, Oct 28, 2020 at 1:22 AM John Snow &lt=
;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank">jsnow@redhat.com</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 1=
0/15/20 12:52 PM, <a href=3D"mailto:marcandre.lureau@redhat.com" target=3D"=
_blank">marcandre.lureau@redhat.com</a> wrote:<br>
&gt; From: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@re=
dhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
&gt; <br>
&gt; Wrap the &#39;if&#39; condition in a higher-level object. Not only thi=
s is<br>
&gt; allows more type safety but also further refactoring without too much<=
br>
&gt; chrun. The following patches will extend the syntax of &#39;if&#39; an=
d will<br>
&gt; have some extra handling and types.<br>
&gt; <br>
<br>
Probably a good idea. Thanks for basing it on Pt6; I&#39;ll try to push <br=
>
ahead as fast as I can -- though there are some more aggressive cleanups <b=
r>
in error, expr, and parser that we haven&#39;t discussed on list yet much <=
br>
and are quite prone to change.<br>
<br>
Let me know if you have any comments or feedbacks regarding what you <br>
found there!<br></blockquote><div><br></div><div>Overall, I was pretty happ=
y with the result. Although it seemed a bit awkward to have types everywher=
e in Python (it doesn&#39;t feel as consistent as with other languages, I t=
hink I need to get used to it)<br></div><div><br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">
<br>
Pts 2 (introspect.py) and 3 (expr.py) are recently re-sent to list, if <br>
you have specific critique in those areas.<br></blockquote><div><br></div><=
div>Done, not much comments<br></div><div> <br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">
<br>
&gt; Signed-off-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.=
lureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br=
>
&gt; ---<br>
&gt;=C2=A0 =C2=A0docs/sphinx/qapidoc.py=C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<br>
&gt;=C2=A0 =C2=A0scripts/qapi/commands.py=C2=A0 =C2=A0|=C2=A0 4 +-<br>
&gt;=C2=A0 =C2=A0scripts/qapi/common.py=C2=A0 =C2=A0 =C2=A0| 26 ++++++++---=
<br>
&gt;=C2=A0 =C2=A0scripts/qapi/events.py=C2=A0 =C2=A0 =C2=A0|=C2=A0 4 +-<br>
&gt;=C2=A0 =C2=A0scripts/qapi/gen.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 9 +=
+--<br>
&gt;=C2=A0 =C2=A0scripts/qapi/introspect.py | 21 ++++-----<br>
&gt;=C2=A0 =C2=A0scripts/qapi/schema.py=C2=A0 =C2=A0 =C2=A0| 91 +++++++++++=
+++++++++------------------<br>
&gt;=C2=A0 =C2=A0scripts/qapi/types.py=C2=A0 =C2=A0 =C2=A0 | 11 ++---<br>
&gt;=C2=A0 =C2=A0scripts/qapi/visit.py=C2=A0 =C2=A0 =C2=A0 |=C2=A0 9 ++--<b=
r>
&gt;=C2=A0 =C2=A09 files changed, 102 insertions(+), 75 deletions(-)<br>
&gt; <br>
&gt; diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py<br>
&gt; index 11e97839de..db9520f37f 100644<br>
&gt; --- a/docs/sphinx/qapidoc.py<br>
&gt; +++ b/docs/sphinx/qapidoc.py<br>
&gt; @@ -116,7 +116,7 @@ class QAPISchemaGenRSTVisitor(QAPISchemaVisitor):<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0the conditions are in literal-=
text and the commas are not.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0If with_if is False, we don&#3=
9;t return the &quot;(If: &quot; and &quot;)&quot;.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 condlist =3D intersperse([nodes.literal(&=
#39;&#39;, c) for c in ifcond],<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 condlist =3D intersperse([nodes.literal(&=
#39;&#39;, c) for c in ifcond.ifcond],<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nodes.Text(&#39;, &#39;))<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not with_if:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return condlist<=
br>
&gt; diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py<br>
&gt; index 50978090b4..03deac5fdd 100644<br>
&gt; --- a/scripts/qapi/commands.py<br>
&gt; +++ b/scripts/qapi/commands.py<br>
&gt; @@ -20,7 +20,7 @@ from typing import (<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Set,<br>
&gt;=C2=A0 =C2=A0)<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -from .common import c_name, mcgen<br>
&gt; +from .common import IfCond, c_name, mcgen<br>
&gt;=C2=A0 =C2=A0from .gen import (<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0QAPIGenC,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0QAPIGenCCode,<br>
&gt; @@ -301,7 +301,7 @@ void %(c_prefix)sqmp_init_marshal(QmpCommandList *=
cmds);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0def visit_command(self,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0name: str,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0info: QAPISourceInfo,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ifcond: List[str],<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ifcond: IfCond,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0features: List[QAPISchemaFeature],<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0arg_type: Optional[QAPISchemaObjectType],<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0ret_type: Optional[QAPISchemaType],<br>
&gt; diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py<br>
&gt; index 11b86beeab..59e6a400da 100644<br>
&gt; --- a/scripts/qapi/common.py<br>
&gt; +++ b/scripts/qapi/common.py<br>
&gt; @@ -12,7 +12,7 @@<br>
&gt;=C2=A0 =C2=A0# See the COPYING file in the top-level directory.<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0import re<br>
&gt; -from typing import Optional, Sequence<br>
&gt; +from typing import Optional, Sequence, Union<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0#: Magic string that gets removed along with all space to =
its right.<br>
&gt; @@ -194,18 +194,34 @@ def guardend(name: str) -&gt; str:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n=
ame=3Dc_fname(name).upper())<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -def gen_if(ifcond: Sequence[str]) -&gt; str:<br>
&gt; +class IfCond:<br>
&gt; +=C2=A0 =C2=A0 def __init__(self, ifcond: Optional[Sequence[str]] =3D =
None):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.ifcond =3D ifcond or []<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def __bool__(self) -&gt; bool:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return bool(self.ifcond)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def __repr__(self) -&gt; str:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return repr(self.ifcond)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def __eq__(self, other: object) -&gt; bool:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if not isinstance(other, IfCond):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NotImplemented<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return self.ifcond =3D=3D other.ifcond<br=
>
&gt; +<br>
<br>
Haven&#39;t looked ahead yet, forgive me if this is a bad idea:<br>
<br>
worth adding an __iter__ method here so that callers don&#39;t have to call=
 <br>
&quot;for x in ifcond.ifcond&quot; ?<br>
<br>
Maybe you refactor such that this is becomes pointless.<br></blockquote><di=
v><br></div><div>Yes, the new expression tree and generation code is quite =
different now. Not really worth it as an intermediary refactoring step.<br>=
</div><div> <br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Also; should we create an Ifcond object in schema.py instead in common, <br=
>
as it&#39;s a generic representation of the #if conditionals, less tied to =
<br>
the C generation?<br>
<br></blockquote><div><br></div>Good point, I&#39;ll update.</div><div clas=
s=3D"gmail_quote"><br></div><div class=3D"gmail_quote">thanks<br clear=3D"a=
ll"></div><br>-- <br><div dir=3D"ltr">Marc-Andr=C3=A9 Lureau<br></div></div=
>

--000000000000d8aa2d05b35a60a7--

