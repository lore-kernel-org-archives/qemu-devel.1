Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81149C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 00:16:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14D56206B1
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 00:16:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14D56206B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ehu.eus
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCXzl-00048U-4K
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 20:16:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46956)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <unai.martinezcorral@ehu.eus>) id 1jCXz3-0003cS-TA
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 20:15:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <unai.martinezcorral@ehu.eus>) id 1jCXz1-0007WP-R8
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 20:15:25 -0400
Received: from smtp.lg.ehu.es ([158.227.0.66]:21112 helo=smtp.ehu.eus)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <unai.martinezcorral@ehu.eus>)
 id 1jCXz1-0007SP-Fs
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 20:15:23 -0400
Received: from imsva2.lgp.ehu.es (imsva2.lgp.ehu.es [10.0.3.246])
 by postfix.smtp2.imsva2 (Postfix) with ESMTPS id F36F0B515
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 01:15:20 +0100 (CET)
Received: from imsva2.lgp.ehu.es (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BD79C5A045
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 01:15:20 +0100 (CET)
Received: from imsva2.lgp.ehu.es (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AD4775A053
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 01:15:20 +0100 (CET)
Received: from smtp.ehu.eus (unknown [10.0.100.76])
 by imsva2.lgp.ehu.es (Postfix) with ESMTPS
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 01:15:20 +0100 (CET)
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com
 [209.85.166.177]) by smtp2 (Postfix) with ESMTPSA id 7026AB515
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 01:15:20 +0100 (CET)
Received: by mail-il1-f177.google.com with SMTP id a6so7266611ilc.4
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 17:15:20 -0700 (PDT)
X-Gm-Message-State: ANhLgQ1gWGLtAVfD/P7uMg9ulbOYuG6/uy3KcLPelckItE7NeZaytGuM
 ztHrxTBQuWQAPRnS8YYHgW9Qo9ErAScXB0SHyg==
X-Google-Smtp-Source: ADFU+vtijoZULpUai8hq9IGgMsXHHCqbCAMMa5d2fjU7lQoBSZ8H302P6lmG+MmPgUsxrExR2S3M3ph3+akIs/lo4Ig=
X-Received: by 2002:a92:8f91:: with SMTP id r17mr9833486ilk.97.1584058518969; 
 Thu, 12 Mar 2020 17:15:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200309191200.GA60@669c1c222ef4>
 <20200309191924.GB65@669c1c222ef4>
 <b7389e46-c96b-a95b-5831-accfdbd1da4a@vivier.eu>
 <62decc58-62e9-9352-ce64-9f8c3a796162@redhat.com>
In-Reply-To: <62decc58-62e9-9352-ce64-9f8c3a796162@redhat.com>
From: Unai Martinez Corral <unai.martinezcorral@ehu.eus>
Date: Fri, 13 Mar 2020 01:15:08 +0100
X-Gmail-Original-Message-ID: <CAGZZdDEE1j3iaTZzf3yfhd+m4MWcVe+6OtQn=mM3HBrFJ10rCg@mail.gmail.com>
Message-ID: <CAGZZdDEE1j3iaTZzf3yfhd+m4MWcVe+6OtQn=mM3HBrFJ10rCg@mail.gmail.com>
Subject: Re: [PATCH v10 02/10] qemu-binfmt-conf.sh: enforce safe tests
To: Eric Blake <eblake@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000053a38e05a0b15d8b"
X-Greylist: ACL 191 matched, not delayed by milter-greylist-4.6.2 (smtp2
 [10.0.100.76]); Fri, 13 Mar 2020 01:15:20 +0100 (CET)
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSVA-9.1.0.1631-8.5.0.1020-25288.001
X-TM-AS-Result: No--23.723-7.0-31-10
X-imss-scan-details: No--23.723-7.0-31-10
X-TMASE-Version: IMSVA-9.1.0.1631-8.5.1020-25288.001
X-TMASE-Result: 10--23.723000-10.000000
X-TMASE-MatchedRID: saYaiT+pevtEKrd892jSeeoYKtLIG3hQvLmbsSCEPo6SiO9qGYcDAE2Q
 cCvZx8tXExww/fT/esYaLqFbxdotGfZfafJjZZIJg8vHe9ji82J+WFAPZFdmcnAfHYdsC0hxOJi
 EFz4iU63+TmbsPRhNL5pWgCLYjjT9opGQY5bbP3KQsRqSXMRkV//vRwcN6CxcaXR5jZ6Opx3jTf
 aMm5n8U45S/4bo68Nb9FQh3flUIh48Via9JYHCQO8AWiH3iBbh8aYGy3XVwEO9z0wUwlRS34il0
 AdCmaIpFdBncI/k7KyIsRvDeU77XOU9R6b8nlzkKxYuhKouUmECM+p530IQblaQDN5ivd16pnrD
 EHT4irrBBKZzlcWAHVLFinzH90WnBnIRIVcCWN8DWeOSESGSoI0G9GYox3Fwu/vm8uSG0azUfk2
 TVZL1X5rtwF8UU4WlYV18sEyS6XxMQXZwH0qMvjnIwR5/0L43zrlB6ufbD0KLAP3aG37rj6oJbK
 8K6jmFlAfNcyApOBwrSLwjuHSdDyXdp9l6EkRZutz7tidPO1bfJn8YmbDwRkFw/oCfxuNmVuDlr
 I9QyGZuUAMzxboz+e9VsdrlGzy3EriYLlTYT3ObKItl61J/yZUdXE/WGn0FSlnU38LCY8tWRVlr
 jsKO8Jihc+8xCO+cz1YRopIey+/hJjARFxy17dlW8+25c2nzA240j6SqxrO1+LoFjPNI8lxW465
 Gjvc0
X-TMASE-SNAP-Result: 1.821001.0001-0-1-12:0,22:0,33:0,34:0-0
X-Greylist: Sender IP whitelisted, Sender succeeded SMTP AUTH, not delayed by
 milter-greylist-4.6.2 (postfix.smtp2.imsva2 [10.0.100.76]);
 Fri, 13 Mar 2020 01:15:20 +0100 (CET)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 158.227.0.66
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
Reply-To: unai.martinezcorral@ehu.eus
Cc: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>, riku.voipio@iki.fi,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000053a38e05a0b15d8b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Laurent, as Eric explained, this commit (as well as the homogeneisation of
spacing) are fixes to pre-existing issues in the script, in order to better
match other bash sources in the codebase. It would be possible to pick 1/10
and 2/10 as a separate patchset.

El mar., 10 mar. 2020 a las 12:47, Eric Blake (<eblake@redhat.com>)
escribi=C3=B3:

> On 3/10/20 3:28 AM, Laurent Vivier wrote:
> > Le 09/03/2020 =C3=A0 20:19, Unai Martinez-Corral a =C3=A9crit :
> >> All the tests are prefixed with 'x', in order to avoid risky compariso=
ns
> >> (i.e. a user deliberately trying to provoke a syntax error).
> >
> > With the quotes I don't see how we can provoke a syntax error.
> > Could you provide an example?
>
> Historically, in some shells:
>
> foo=3D\(
> bar=3D\)
> if [ "$foo" =3D "$bar" ]; then echo hello world; fi
>
> could output 'hello world' (by parsing a parenthesized one-argument
> test, and the string '=3D' is non-empty), but:
>
> if [ "x$foo" =3D "x$bar" ]; then echo goodbye; fi
>
> did not (since no operator begins with 'x', you have guaranteed the
> syntax that [ will parse).  Similarly, if foo=3D! or foo=3D-a, you could =
get
> syntax errors (if [ tried to treat the expansion of $foo as an operator
> and got thrown off by the remaining arguments not matching an expected
> pattern).
>
> These days, POSIX says that with three arguments when the 2nd is a
> binary operator, there is no ambiguity (the binary operator takes
> precedence over the ( and ) around the non-empty string test), and
> modern bash obeys the POSIX rule without needing the x prefix.  But it
> is still better to prefix with x for copy-paste portability to older
> shells that do not match current POSIX rules.
>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
>
>

--00000000000053a38e05a0b15d8b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Laurent, as Eric explained, this commit (as well as the ho=
mogeneisation of spacing) are fixes to pre-existing issues in the script, i=
n order to better match other bash sources in the codebase. It would be pos=
sible to pick 1/10 and 2/10 as a separate patchset.<br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">El mar., 10 mar. 202=
0 a las 12:47, Eric Blake (&lt;<a href=3D"mailto:eblake@redhat.com">eblake@=
redhat.com</a>&gt;) escribi=C3=B3:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">On 3/10/20 3:28 AM, Laurent Vivier wrote:<br>
&gt; Le 09/03/2020 =C3=A0 20:19, Unai Martinez-Corral a =C3=A9crit=C2=A0:<b=
r>
&gt;&gt; All the tests are prefixed with &#39;x&#39;, in order to avoid ris=
ky comparisons<br>
&gt;&gt; (i.e. a user deliberately trying to provoke a syntax error).<br>
&gt; <br>
&gt; With the quotes I don&#39;t see how we can provoke a syntax error.<br>
&gt; Could you provide an example?<br>
<br>
Historically, in some shells:<br>
<br>
foo=3D\(<br>
bar=3D\)<br>
if [ &quot;$foo&quot; =3D &quot;$bar&quot; ]; then echo hello world; fi<br>
<br>
could output &#39;hello world&#39; (by parsing a parenthesized one-argument=
 <br>
test, and the string &#39;=3D&#39; is non-empty), but:<br>
<br>
if [ &quot;x$foo&quot; =3D &quot;x$bar&quot; ]; then echo goodbye; fi<br>
<br>
did not (since no operator begins with &#39;x&#39;, you have guaranteed the=
 <br>
syntax that [ will parse).=C2=A0 Similarly, if foo=3D! or foo=3D-a, you cou=
ld get <br>
syntax errors (if [ tried to treat the expansion of $foo as an operator <br=
>
and got thrown off by the remaining arguments not matching an expected <br>
pattern).<br>
<br>
These days, POSIX says that with three arguments when the 2nd is a <br>
binary operator, there is no ambiguity (the binary operator takes <br>
precedence over the ( and ) around the non-empty string test), and <br>
modern bash obeys the POSIX rule without needing the x prefix.=C2=A0 But it=
 <br>
is still better to prefix with x for copy-paste portability to older <br>
shells that do not match current POSIX rules.<br>
<br>
-- <br>
Eric Blake, Principal Software Engineer<br>
Red Hat, Inc.=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+1-919-301-3226<br>
Virtualization:=C2=A0 <a href=3D"http://qemu.org" rel=3D"noreferrer" target=
=3D"_blank">qemu.org</a> | <a href=3D"http://libvirt.org" rel=3D"noreferrer=
" target=3D"_blank">libvirt.org</a><br>
<br>
</blockquote></div>

--00000000000053a38e05a0b15d8b--


