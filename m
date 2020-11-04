Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B78BAC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 09:52:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4F4420781
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 09:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTb7qIAQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4F4420781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaFSk-0007kc-Fx
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 04:52:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kaFRv-0007JG-V5
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 04:51:28 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630]:34666)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kaFRt-00066b-Pi
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 04:51:27 -0500
Received: by mail-ej1-x630.google.com with SMTP id o9so26786652ejg.1
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 01:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5Ku0xBtE2+kNIsIRTXD61r5iJ2QVVnRTPGSkcQ/Cwbo=;
 b=YTb7qIAQhfTWX9ed8Rz1Ii1dcMQ+O+ldZhsHpR5H0VeulyvhZiZdvXW+cx/0WTJDEU
 h920KK3WC4MWeNMJMYT5J6Lj2K4u4DkYI4sXJUAu5SZzl8+PCcDVVzuNsKoovFFv80A4
 hDRnorpGeUK36gBtVaWDlrpq/hyUZ+8tMBfNnjWPIndGLXRWcBQjZ5tY5bZC3dq/ValM
 7obsrMHoMajFq+6Ip0dh8AB8klroqZ+Lt5KeJaSA20PktrKl7wbpfw6jnTiBsJDk9xLP
 mfnroKM1q1g2u1O++R14aZxzLHZn7KEizyNNKoa+ofGjWVuGZ4l66+129WPxM3z660sj
 /DBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5Ku0xBtE2+kNIsIRTXD61r5iJ2QVVnRTPGSkcQ/Cwbo=;
 b=UzXhUYGUXqe0ZDTi7t7c2AAz0rwV4hUlS1bMf1xjExkF+Yp0BRZxk+Cv41w2W9uSsa
 WGC1zZuZykAr9phg2l33OQMdvqygKXdE4lIVMWxR+n6fOqxY5pSv2wyqq+byWQswt1bU
 E9QNQQQD802Q/tT3BLlPx+nbQudppNKZOkX6gbFzl4CAiG99vGI2fhZFnUOYX+0IBK64
 Payt4OzDLejvlwPaTAtwoEI20j/P/LgSQiVI18Rv7JdYg+CPr90WW9Nc0KpuZQlApKj1
 gOw/FPIJosh1vF2Iki6HJIH6FTYNy2yp4V+7dkDxY6VG7dK42X3O+0JicC6dF1xe/oU6
 5tTQ==
X-Gm-Message-State: AOAM530K6kmrASJwJHrkVuxQQaGzdcqueu4pfaCXm08w4eiMtJlQaWAE
 oIV9DYgKZwRB/aUMtL+IAMFU/SIUJa/a4pwA47A=
X-Google-Smtp-Source: ABdhPJwEHbcO0N7RNOPLWI5XHfD6wtKZYsgdTYyQwxVCoiuXkdHAmG79XZBkQxGUbhm+RP96u64IMiuwtwx4LyfBSxY=
X-Received: by 2002:a17:906:5618:: with SMTP id
 f24mr1980965ejq.381.1604483484299; 
 Wed, 04 Nov 2020 01:51:24 -0800 (PST)
MIME-Version: 1.0
References: <20201026194251.11075-1-jsnow@redhat.com>
 <ec85be81-7f73-a5ea-7bfc-d8f4b575585f@redhat.com>
In-Reply-To: <ec85be81-7f73-a5ea-7bfc-d8f4b575585f@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 4 Nov 2020 13:51:12 +0400
Message-ID: <CAJ+F1CKOF4OxtWE-ngAh25T8o4PA2VOPTRbbdbFgi4eUV7VzSA@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] qapi: static typing conversion, pt2
To: John Snow <jsnow@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000021363705b344ece5"
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ej1-x630.google.com
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
Cc: Cleber Rosa <crosa@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000021363705b344ece5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Mon, Nov 2, 2020 at 7:41 PM John Snow <jsnow@redhat.com> wrote:

> On 10/26/20 3:42 PM, John Snow wrote:
> > Hi, this series adds static type hints to the QAPI module.
> > This is part two, and covers introspect.py.
> >
> > Part 2: https://gitlab.com/jsnow/qemu/-/tree/python-qapi-cleanup-pt2
> > Everything: https://gitlab.com/jsnow/qemu/-/tree/python-qapi-cleanup-pt=
6
> >
> > - Requires Python 3.6+
> > - Requires mypy 0.770 or newer (for type analysis only)
> > - Requires pylint 2.6.0 or newer (for lint checking only)
> >
> > Type hints are added in patches that add *only* type hints and change n=
o
> > other behavior. Any necessary changes to behavior to accommodate typing
> > are split out into their own tiny patches.
> >
> > Every commit should pass with:
> >   - flake8 qapi/
> >   - pylint --rcfile=3Dqapi/pylintrc qapi/
> >   - mypy --config-file=3Dqapi/mypy.ini qapi/
> >
> > V2:
> >   - Dropped all R-B from previous series; enough has changed.
> >   - pt2 is now introspect.py, expr.py is pushed to pt3.
> >   - Reworked again to have less confusing (?) type names
> >   - Added an assertion to prevent future accidental breakage
> >
>
> Ping!
>
> Patches 1-3: Can be skipped; just enables sphinx to check the docstring
> syntax. Don't worry about these too much, they're just here for you to
> test with.
>

They are interesting, but the rebase version fails. And the error produced
is not exactly friendly:
Exception occurred:
  File "/usr/lib/python3.9/site-packages/sphinx/domains/c.py", line 3751,
in resolve_any_xref
    return [('c:' + self.role_for_objtype(objtype), retnode)]
TypeError: can only concatenate str (not "NoneType") to str

Could you rebase and split off in a separate series?

Patch 4 adds some small changes, to support:
> Patch 5 adds the type hints.
> Patches 6-11 try to improve the readability of the types and the code.
>
> This was a challenging file to clean up, so I am sure there's lots of
> easy, low-hanging fruit in the review/feedback for me to improve.
>

Nothing obvious to me.

Python typing is fairly new to me, and I don't know the best practices. I
would just take what you did and improve later, if needed.

A wish item before we proceed with more python code cleanups is
documentation and/or automated tests.

Could you add a new make check-python and perhaps document what the new
code-style expectations?


> > John Snow (11):
> >    [DO-NOT-MERGE] docs: replace single backtick (`) with double-backtic=
k
> >      (``)
> >    [DO-NOT-MERGE] docs/sphinx: change default role to "any"
> >    [DO-NOT-MERGE] docs: enable sphinx-autodoc for scripts/qapi
> >    qapi/introspect.py: add assertions and casts
> >    qapi/introspect.py: add preliminary type hint annotations
> >    qapi/introspect.py: add _gen_features helper
> >    qapi/introspect.py: Unify return type of _make_tree()
> >    qapi/introspect.py: replace 'extra' dict with 'comment' argument
> >    qapi/introspect.py: create a typed 'Annotated' data strutcure
> >    qapi/introspect.py: improve readability of _tree_to_qlit
> >    qapi/introspect.py: Add docstring to _tree_to_qlit
> >
> >   docs/conf.py                           |   6 +-
> >   docs/devel/build-system.rst            | 120 +++++------
> >   docs/devel/index.rst                   |   1 +
> >   docs/devel/migration.rst               |  59 +++---
> >   docs/devel/python/index.rst            |   7 +
> >   docs/devel/python/qapi.commands.rst    |   7 +
> >   docs/devel/python/qapi.common.rst      |   7 +
> >   docs/devel/python/qapi.error.rst       |   7 +
> >   docs/devel/python/qapi.events.rst      |   7 +
> >   docs/devel/python/qapi.expr.rst        |   7 +
> >   docs/devel/python/qapi.gen.rst         |   7 +
> >   docs/devel/python/qapi.introspect.rst  |   7 +
> >   docs/devel/python/qapi.main.rst        |   7 +
> >   docs/devel/python/qapi.parser.rst      |   8 +
> >   docs/devel/python/qapi.rst             |  26 +++
> >   docs/devel/python/qapi.schema.rst      |   7 +
> >   docs/devel/python/qapi.source.rst      |   7 +
> >   docs/devel/python/qapi.types.rst       |   7 +
> >   docs/devel/python/qapi.visit.rst       |   7 +
> >   docs/devel/tcg-plugins.rst             |  14 +-
> >   docs/devel/testing.rst                 |   2 +-
> >   docs/interop/live-block-operations.rst |   4 +-
> >   docs/system/arm/cpu-features.rst       | 110 +++++-----
> >   docs/system/arm/nuvoton.rst            |   2 +-
> >   docs/system/s390x/protvirt.rst         |  10 +-
> >   qapi/block-core.json                   |   4 +-
> >   scripts/qapi/introspect.py             | 277 +++++++++++++++++-------=
-
> >   scripts/qapi/mypy.ini                  |   5 -
> >   scripts/qapi/schema.py                 |   2 +-
> >   29 files changed, 487 insertions(+), 254 deletions(-)
> >   create mode 100644 docs/devel/python/index.rst
> >   create mode 100644 docs/devel/python/qapi.commands.rst
> >   create mode 100644 docs/devel/python/qapi.common.rst
> >   create mode 100644 docs/devel/python/qapi.error.rst
> >   create mode 100644 docs/devel/python/qapi.events.rst
> >   create mode 100644 docs/devel/python/qapi.expr.rst
> >   create mode 100644 docs/devel/python/qapi.gen.rst
> >   create mode 100644 docs/devel/python/qapi.introspect.rst
> >   create mode 100644 docs/devel/python/qapi.main.rst
> >   create mode 100644 docs/devel/python/qapi.parser.rst
> >   create mode 100644 docs/devel/python/qapi.rst
> >   create mode 100644 docs/devel/python/qapi.schema.rst
> >   create mode 100644 docs/devel/python/qapi.source.rst
> >   create mode 100644 docs/devel/python/qapi.types.rst
> >   create mode 100644 docs/devel/python/qapi.visit.rst
> >
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--00000000000021363705b344ece5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Nov 2, 2020 at 7:41 PM John=
 Snow &lt;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank">jsnow@redha=
t.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">On 10/26/20 3:42 PM, John Snow wrote:<br>
&gt; Hi, this series adds static type hints to the QAPI module.<br>
&gt; This is part two, and covers introspect.py.<br>
&gt; <br>
&gt; Part 2: <a href=3D"https://gitlab.com/jsnow/qemu/-/tree/python-qapi-cl=
eanup-pt2" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/jsnow/qe=
mu/-/tree/python-qapi-cleanup-pt2</a><br>
&gt; Everything: <a href=3D"https://gitlab.com/jsnow/qemu/-/tree/python-qap=
i-cleanup-pt6" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/jsno=
w/qemu/-/tree/python-qapi-cleanup-pt6</a><br>
&gt; <br>
&gt; - Requires Python 3.6+<br>
&gt; - Requires mypy 0.770 or newer (for type analysis only)<br>
&gt; - Requires pylint 2.6.0 or newer (for lint checking only)<br>
&gt; <br>
&gt; Type hints are added in patches that add *only* type hints and change =
no<br>
&gt; other behavior. Any necessary changes to behavior to accommodate typin=
g<br>
&gt; are split out into their own tiny patches.<br>
&gt; <br>
&gt; Every commit should pass with:<br>
&gt;=C2=A0 =C2=A0- flake8 qapi/<br>
&gt;=C2=A0 =C2=A0- pylint --rcfile=3Dqapi/pylintrc qapi/<br>
&gt;=C2=A0 =C2=A0- mypy --config-file=3Dqapi/mypy.ini qapi/<br>
&gt; <br>
&gt; V2:<br>
&gt;=C2=A0 =C2=A0- Dropped all R-B from previous series; enough has changed=
.<br>
&gt;=C2=A0 =C2=A0- pt2 is now introspect.py, expr.py is pushed to pt3.<br>
&gt;=C2=A0 =C2=A0- Reworked again to have less confusing (?) type names<br>
&gt;=C2=A0 =C2=A0- Added an assertion to prevent future accidental breakage=
<br>
&gt; <br>
<br>
Ping!<br>
<br>
Patches 1-3: Can be skipped; just enables sphinx to check the docstring <br=
>
syntax. Don&#39;t worry about these too much, they&#39;re just here for you=
 to <br>
test with.<br></blockquote><div><br></div><div>They are interesting, but th=
e rebase version fails. And the error produced is not exactly friendly:</di=
v><div>Exception occurred:<br>=C2=A0 File &quot;/usr/lib/python3.9/site-pac=
kages/sphinx/domains/c.py&quot;, line 3751, in resolve_any_xref<br>=C2=A0 =
=C2=A0 return [(&#39;c:&#39; + self.role_for_objtype(objtype), retnode)]<br=
>TypeError: can only concatenate str (not &quot;NoneType&quot;) to str<br> =
</div><div><br></div><div>Could you rebase and split off in a separate seri=
es? <br></div><div><br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">
Patch 4 adds some small changes, to support:<br>
Patch 5 adds the type hints.<br>
Patches 6-11 try to improve the readability of the types and the code.<br>
<br>
This was a challenging file to clean up, so I am sure there&#39;s lots of <=
br>
easy, low-hanging fruit in the review/feedback for me to improve.<br></bloc=
kquote><div><br></div><div>Nothing obvious to me.</div><div><br></div><div>=
Python typing is fairly new to me, and I don&#39;t know the best practices.=
 I would just take what you did and improve later, if needed.<br></div><div=
><br></div><div>A wish item before we proceed with more python code cleanup=
s is documentation and/or automated tests.</div><div><br></div><div>Could y=
ou add a new make check-python and perhaps document what the new code-style=
 expectations?<br></div><div><br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">
<br>
&gt; John Snow (11):<br>
&gt;=C2=A0 =C2=A0 [DO-NOT-MERGE] docs: replace single backtick (`) with dou=
ble-backtick<br>
&gt;=C2=A0 =C2=A0 =C2=A0 (``)<br>
&gt;=C2=A0 =C2=A0 [DO-NOT-MERGE] docs/sphinx: change default role to &quot;=
any&quot;<br>
&gt;=C2=A0 =C2=A0 [DO-NOT-MERGE] docs: enable sphinx-autodoc for scripts/qa=
pi<br>
&gt;=C2=A0 =C2=A0 qapi/introspect.py: add assertions and casts<br>
&gt;=C2=A0 =C2=A0 qapi/introspect.py: add preliminary type hint annotations=
<br>
&gt;=C2=A0 =C2=A0 qapi/introspect.py: add _gen_features helper<br>
&gt;=C2=A0 =C2=A0 qapi/introspect.py: Unify return type of _make_tree()<br>
&gt;=C2=A0 =C2=A0 qapi/introspect.py: replace &#39;extra&#39; dict with &#3=
9;comment&#39; argument<br>
&gt;=C2=A0 =C2=A0 qapi/introspect.py: create a typed &#39;Annotated&#39; da=
ta strutcure<br>
&gt;=C2=A0 =C2=A0 qapi/introspect.py: improve readability of _tree_to_qlit<=
br>
&gt;=C2=A0 =C2=A0 qapi/introspect.py: Add docstring to _tree_to_qlit<br>
&gt; <br>
&gt;=C2=A0 =C2=A0docs/conf.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A06 +-<br>
&gt;=C2=A0 =C2=A0docs/devel/build-system.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | 120 +++++------<br>
&gt;=C2=A0 =C2=A0docs/devel/index.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0docs/devel/migration.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0|=C2=A0 59 +++---<br>
&gt;=C2=A0 =C2=A0docs/devel/python/index.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 =C2=A07 +<br>
&gt;=C2=A0 =C2=A0docs/devel/python/qapi.commands.rst=C2=A0 =C2=A0 |=C2=A0 =
=C2=A07 +<br>
&gt;=C2=A0 =C2=A0docs/devel/python/qapi.common.rst=C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 =C2=A07 +<br>
&gt;=C2=A0 =C2=A0docs/devel/python/qapi.error.rst=C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A07 +<br>
&gt;=C2=A0 =C2=A0docs/devel/python/qapi.events.rst=C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 =C2=A07 +<br>
&gt;=C2=A0 =C2=A0docs/devel/python/qapi.expr.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 |=C2=A0 =C2=A07 +<br>
&gt;=C2=A0 =C2=A0docs/devel/python/qapi.gen.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 =C2=A07 +<br>
&gt;=C2=A0 =C2=A0docs/devel/python/qapi.introspect.rst=C2=A0 |=C2=A0 =C2=A0=
7 +<br>
&gt;=C2=A0 =C2=A0docs/devel/python/qapi.main.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 |=C2=A0 =C2=A07 +<br>
&gt;=C2=A0 =C2=A0docs/devel/python/qapi.parser.rst=C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 =C2=A08 +<br>
&gt;=C2=A0 =C2=A0docs/devel/python/qapi.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 26 +++<br>
&gt;=C2=A0 =C2=A0docs/devel/python/qapi.schema.rst=C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 =C2=A07 +<br>
&gt;=C2=A0 =C2=A0docs/devel/python/qapi.source.rst=C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 =C2=A07 +<br>
&gt;=C2=A0 =C2=A0docs/devel/python/qapi.types.rst=C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A07 +<br>
&gt;=C2=A0 =C2=A0docs/devel/python/qapi.visit.rst=C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A07 +<br>
&gt;=C2=A0 =C2=A0docs/devel/tcg-plugins.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 14 +-<br>
&gt;=C2=A0 =C2=A0docs/devel/testing.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 =C2=A0docs/interop/live-block-operations.rst |=C2=A0 =C2=A04 +-<=
br>
&gt;=C2=A0 =C2=A0docs/system/arm/cpu-features.rst=C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 110 +++++-----<br>
&gt;=C2=A0 =C2=A0docs/system/arm/nuvoton.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 =C2=A0docs/system/s390x/protvirt.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 10 +-<br>
&gt;=C2=A0 =C2=A0qapi/block-core.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A04 +-<br>
&gt;=C2=A0 =C2=A0scripts/qapi/introspect.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| 277 +++++++++++++++++--------<br>
&gt;=C2=A0 =C2=A0scripts/qapi/mypy.ini=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A05 -<br>
&gt;=C2=A0 =C2=A0scripts/qapi/schema.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 =C2=A029 files changed, 487 insertions(+), 254 deletions(-)<br>
&gt;=C2=A0 =C2=A0create mode 100644 docs/devel/python/index.rst<br>
&gt;=C2=A0 =C2=A0create mode 100644 docs/devel/python/qapi.commands.rst<br>
&gt;=C2=A0 =C2=A0create mode 100644 docs/devel/python/qapi.common.rst<br>
&gt;=C2=A0 =C2=A0create mode 100644 docs/devel/python/qapi.error.rst<br>
&gt;=C2=A0 =C2=A0create mode 100644 docs/devel/python/qapi.events.rst<br>
&gt;=C2=A0 =C2=A0create mode 100644 docs/devel/python/qapi.expr.rst<br>
&gt;=C2=A0 =C2=A0create mode 100644 docs/devel/python/qapi.gen.rst<br>
&gt;=C2=A0 =C2=A0create mode 100644 docs/devel/python/qapi.introspect.rst<b=
r>
&gt;=C2=A0 =C2=A0create mode 100644 docs/devel/python/qapi.main.rst<br>
&gt;=C2=A0 =C2=A0create mode 100644 docs/devel/python/qapi.parser.rst<br>
&gt;=C2=A0 =C2=A0create mode 100644 docs/devel/python/qapi.rst<br>
&gt;=C2=A0 =C2=A0create mode 100644 docs/devel/python/qapi.schema.rst<br>
&gt;=C2=A0 =C2=A0create mode 100644 docs/devel/python/qapi.source.rst<br>
&gt;=C2=A0 =C2=A0create mode 100644 docs/devel/python/qapi.types.rst<br>
&gt;=C2=A0 =C2=A0create mode 100644 docs/devel/python/qapi.visit.rst<br>
&gt; <br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr">Marc-Andr=
=C3=A9 Lureau<br></div></div>

--00000000000021363705b344ece5--

