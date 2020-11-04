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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B17C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 14:54:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D1712074F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 14:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKLMDath"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D1712074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaKAp-0001RA-3N
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 09:54:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kaKA8-0000yn-K0
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 09:53:24 -0500
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:34669)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kaKA6-0004w2-JZ
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 09:53:24 -0500
Received: by mail-ed1-x541.google.com with SMTP id a15so13917437edy.1
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 06:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hXHqhjQ9aAvBh4VmDmm6TItzPPr6lvIssTcrJgpYMCA=;
 b=BKLMDathcgWO7OjA1Tldfrn9nNJfzj0lsB2gN5gFFKDlQqY+Z/STFGykLwzLtJqT/a
 9LzsM615ntXibvfKbiqiJdc2Cx4hAimFquFpreSZan/O06Z8oJtdH5L8VSovUTj3BMDh
 C6wyYsLp1Sswnf5Jo9VUQ1Yc9oxVto9rIZ0uNeo90M9D7Zttzo5id/72PYXrC0Uqwi/m
 NknhgCXSUWxeeqfsDJuDBqBZSNGFUByw/PH7wd7pNKenbiELn9cgAmEOI4nXve5JVNUK
 u6t8VcY0PDGl+s++N77kfHUHawYkyNGyA96TERoQwmqSNoHK1BVkOu2MC8VGoa7SIgGP
 Hutg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hXHqhjQ9aAvBh4VmDmm6TItzPPr6lvIssTcrJgpYMCA=;
 b=FxRd/xP35h0R7Wvqk9Soriad5USDMEF3gvEzULme1ESNzEKVEdULZVXoCY1MPV+O5g
 ARWz+v12xehDW5YB6b1t5mXJGbl1EHtJnPOv593xdEUgZRYiSQpGfrR1l5/ynx+3fhlx
 cS/tlIhMuenvsp3lSqRdD7GD9Gl2Fgae6ibZUsXim6rWKVgs1EwgbwoNYTc9/7+TokvK
 Pn92OFPb+bR887ASdRm+yz+aRcTYGLqCee1FXtUXRtdtGnS1EwP4QhxLuj+6ddZl6uPg
 ym3iP2nSA9W/Vfk3lYexplaRa2jm1KU3F64Vv8eUrCS1aoCUmhQtDuMrehmG8e3av6eo
 nZ7A==
X-Gm-Message-State: AOAM531mteA7kBgOYn1HtTDYaOD/NvOcFtZqfLpJtg482M7G0by3oJWs
 nz5aQKJvKA5xMM9HvR8FMBXC2naWk56BeFYS+rc=
X-Google-Smtp-Source: ABdhPJw/+vmu1gHHUb2WTLtJk24nnwlLE0ZCfty/g5OqrGy11uYp12oeXuVEIb8+EhsT1WoRxG5jPp8c8VcfPES5q9w=
X-Received: by 2002:a05:6402:1615:: with SMTP id
 f21mr28453642edv.257.1604501600684; 
 Wed, 04 Nov 2020 06:53:20 -0800 (PST)
MIME-Version: 1.0
References: <20201026213637.47087-1-jsnow@redhat.com>
 <1e06ab88-8d8d-d0b1-03f4-a868e2d95561@redhat.com>
In-Reply-To: <1e06ab88-8d8d-d0b1-03f4-a868e2d95561@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 4 Nov 2020 18:53:08 +0400
Message-ID: <CAJ+F1CJ7Rq_NUp0nO6hbFX2DFp-BckH=Jb_vayYsGEN44cqE-A@mail.gmail.com>
Subject: Re: [PATCH v2 00/16] qapi: static typing conversion, pt3
To: John Snow <jsnow@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000f34fed05b349234c"
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ed1-x541.google.com
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

--000000000000f34fed05b349234c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Wed, Nov 4, 2020 at 5:16 AM John Snow <jsnow@redhat.com> wrote:

> On 10/26/20 5:36 PM, John Snow wrote:
> > based-on: <20201026194251.11075-1-jsnow@redhat.com>
> >            [PATCH v2 00/11] qapi: static typing conversion, pt2
>
> Ping,
>
> This series can be reviewed independently of pt2, so I encourage you to
> try if you have the time.
>
> >
> > Hi, this series adds static type hints to the QAPI module.
> > This is part three, and it focuses on expr.py.
> >
> > Part 3: https://gitlab.com/jsnow/qemu/-/tree/python-qapi-cleanup-pt3
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
> >   - Rebased on the latest V2
> > 002/16:[0001] [FC] 'qapi/expr.py: Check for dict instead of OrderedDict=
'
> >   - Import order differences
> > 007/16:[0006] [FC] 'qapi/expr.py: Add casts in a few select cases'
> >   - Import order differences
> > 008/16:[0006] [FC] 'qapi/expr.py: add type hint annotations'
> >   - Import order differents
> > 012/16:[0066] [FC] 'qapi/expr.py: Add docstrings'
> >   - Various docstring changes for Sphinx
> > 014/16:[0004] [FC] 'qapi/expr.py: Use tuples instead of lists for stati=
c
> data'
> >   - Change to accommodate new 'coroutine' key
> > 015/16:[0006] [FC] 'qapi/expr.py: move related checks inside check_xxx
> functions'
> >   - Fix check order (ehabkost)
> >
> > John Snow (16):
> >    qapi/expr.py: Remove 'info' argument from nested check_if_str
> >    qapi/expr.py: Check for dict instead of OrderedDict
> >    qapi/expr.py: constrain incoming expression types
> >    qapi/expr.py: Add assertion for union type 'check_dict'
> >    qapi/expr.py: move string check upwards in check_type
> >    qapi/expr.py: Check type of 'data' member
> >    qapi/expr.py: Add casts in a few select cases
> >    qapi/expr.py: add type hint annotations
> >    qapi/expr.py: rewrite check_if
> >    qapi/expr.py: Remove single-letter variable
> >    qapi/expr.py: enable pylint checks
> >    qapi/expr.py: Add docstrings
> >    qapi/expr.py: Modify check_keys to accept any Iterable
> >    qapi/expr.py: Use tuples instead of lists for static data
> >    qapi/expr.py: move related checks inside check_xxx functions
> >    qapi/expr.py: Use an expression checker dispatch table
> >
> >   scripts/qapi/expr.py  | 447 +++++++++++++++++++++++++++++++----------=
-
> >   scripts/qapi/mypy.ini |   5 -
> >   scripts/qapi/pylintrc |   1 -
> >   3 files changed, 334 insertions(+), 119 deletions(-)
> >
>
>
>
Looks all good to me. And you have already reviewed-by on all patches.
Given that it's hardening the current code, I would suggest to merge it
during the freeze. Unless Markus can maintain a qapi-next branch where we
can base our work on?

thanks

--=20
Marc-Andr=C3=A9 Lureau

--000000000000f34fed05b349234c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Nov 4, 2020 at 5:16 AM John=
 Snow &lt;<a href=3D"mailto:jsnow@redhat.com">jsnow@redhat.com</a>&gt; wrot=
e:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 10/26/20 5=
:36 PM, John Snow wrote:<br>
&gt; based-on: &lt;<a href=3D"mailto:20201026194251.11075-1-jsnow@redhat.co=
m" target=3D"_blank">20201026194251.11075-1-jsnow@redhat.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [PATCH v2 00/11] qapi: static=
 typing conversion, pt2<br>
<br>
Ping,<br>
<br>
This series can be reviewed independently of pt2, so I encourage you to <br=
>
try if you have the time.<br>
<br>
&gt; <br>
&gt; Hi, this series adds static type hints to the QAPI module.<br>
&gt; This is part three, and it focuses on expr.py.<br>
&gt; <br>
&gt; Part 3: <a href=3D"https://gitlab.com/jsnow/qemu/-/tree/python-qapi-cl=
eanup-pt3" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/jsnow/qe=
mu/-/tree/python-qapi-cleanup-pt3</a><br>
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
&gt;=C2=A0 =C2=A0- Rebased on the latest V2<br>
&gt; 002/16:[0001] [FC] &#39;qapi/expr.py: Check for dict instead of Ordere=
dDict&#39;<br>
&gt;=C2=A0 =C2=A0- Import order differences<br>
&gt; 007/16:[0006] [FC] &#39;qapi/expr.py: Add casts in a few select cases&=
#39;<br>
&gt;=C2=A0 =C2=A0- Import order differences<br>
&gt; 008/16:[0006] [FC] &#39;qapi/expr.py: add type hint annotations&#39;<b=
r>
&gt;=C2=A0 =C2=A0- Import order differents<br>
&gt; 012/16:[0066] [FC] &#39;qapi/expr.py: Add docstrings&#39;<br>
&gt;=C2=A0 =C2=A0- Various docstring changes for Sphinx<br>
&gt; 014/16:[0004] [FC] &#39;qapi/expr.py: Use tuples instead of lists for =
static data&#39;<br>
&gt;=C2=A0 =C2=A0- Change to accommodate new &#39;coroutine&#39; key<br>
&gt; 015/16:[0006] [FC] &#39;qapi/expr.py: move related checks inside check=
_xxx functions&#39;<br>
&gt;=C2=A0 =C2=A0- Fix check order (ehabkost)<br>
&gt; <br>
&gt; John Snow (16):<br>
&gt;=C2=A0 =C2=A0 qapi/expr.py: Remove &#39;info&#39; argument from nested =
check_if_str<br>
&gt;=C2=A0 =C2=A0 qapi/expr.py: Check for dict instead of OrderedDict<br>
&gt;=C2=A0 =C2=A0 qapi/expr.py: constrain incoming expression types<br>
&gt;=C2=A0 =C2=A0 qapi/expr.py: Add assertion for union type &#39;check_dic=
t&#39;<br>
&gt;=C2=A0 =C2=A0 qapi/expr.py: move string check upwards in check_type<br>
&gt;=C2=A0 =C2=A0 qapi/expr.py: Check type of &#39;data&#39; member<br>
&gt;=C2=A0 =C2=A0 qapi/expr.py: Add casts in a few select cases<br>
&gt;=C2=A0 =C2=A0 qapi/expr.py: add type hint annotations<br>
&gt;=C2=A0 =C2=A0 qapi/expr.py: rewrite check_if<br>
&gt;=C2=A0 =C2=A0 qapi/expr.py: Remove single-letter variable<br>
&gt;=C2=A0 =C2=A0 qapi/expr.py: enable pylint checks<br>
&gt;=C2=A0 =C2=A0 qapi/expr.py: Add docstrings<br>
&gt;=C2=A0 =C2=A0 qapi/expr.py: Modify check_keys to accept any Iterable<br=
>
&gt;=C2=A0 =C2=A0 qapi/expr.py: Use tuples instead of lists for static data=
<br>
&gt;=C2=A0 =C2=A0 qapi/expr.py: move related checks inside check_xxx functi=
ons<br>
&gt;=C2=A0 =C2=A0 qapi/expr.py: Use an expression checker dispatch table<br=
>
&gt; <br>
&gt;=C2=A0 =C2=A0scripts/qapi/expr.py=C2=A0 | 447 +++++++++++++++++++++++++=
++++++-----------<br>
&gt;=C2=A0 =C2=A0scripts/qapi/mypy.ini |=C2=A0 =C2=A05 -<br>
&gt;=C2=A0 =C2=A0scripts/qapi/pylintrc |=C2=A0 =C2=A01 -<br>
&gt;=C2=A0 =C2=A03 files changed, 334 insertions(+), 119 deletions(-)<br>
&gt; <br>
<br>
<br>
</blockquote></div><div><br></div><div>Looks all good to me. And you have a=
lready reviewed-by on all patches. Given that it&#39;s hardening the curren=
t code, I would suggest to merge it during the freeze. Unless Markus can ma=
intain a qapi-next branch where we can base our work on?<br></div><div><br>=
</div><div>thanks</div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmai=
l_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--000000000000f34fed05b349234c--

