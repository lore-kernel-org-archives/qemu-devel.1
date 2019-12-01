Return-Path: <SRS0=Jz4r=ZX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0663C432C3
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 13:47:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ACE1206E4
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 13:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UN0Tus85"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ACE1206E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibPZS-0006wD-Na
	for qemu-devel@archiver.kernel.org; Sun, 01 Dec 2019 08:47:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51085)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ibPYb-00068m-79
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 08:46:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ibPYZ-0008DA-ND
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 08:46:37 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:34988)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ibPYZ-0008Bx-0O
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 08:46:35 -0500
Received: by mail-ot1-x344.google.com with SMTP id o9so7644815ote.2
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2019 05:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=3Xxzii1usya3bU03c0B1SF8tabuPtVDKEvQ1pkd+MJM=;
 b=UN0Tus85aXMIIJS9YWaaiVI0Z6yARGMrzsEUGcLtM5QeKqNhbilt96na7uecbHNBx/
 23sfq2cWiLcE5RrR0Tq2MsTZ4MeghflnACvTIT3ndXhjrkZ1WKg8SK5m39rGGUvK23mZ
 lTUzueJ+HdYShBYzzcqaoxioRKK4Qc2ywDIJb4v2iB7qyZZmxIXG5XUyrxlLZOcM7YbL
 8mXF55kQF/ADTcnAge3N666VR+boY4RZyB79teyDLoBHeY0caAuhkKbkzqWCFuVPnPb0
 Qi8h1SQLy25Flv1h6ROAMiZNRCUaMPXOqc09v5Dk/OCWUS4Vm4aqKMcr4DoQWnYKsELd
 6RnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=3Xxzii1usya3bU03c0B1SF8tabuPtVDKEvQ1pkd+MJM=;
 b=DaTswmlEIROVi6r6uQio3Gz0KsA1yi6HT7byY4pF4XIbNAOgIBkE6zt3cqU+sY1YWB
 RsLJSPchOFlsReo4MRBukvWKP2+JxQ2jWfMmks2wHjGLWr7ePnqrG8MkCM+1zwq7tCq4
 TNRw2tJCdd+WePwbzT488cKqPhs/bP6a5AqnEA5lTPIgaEntKSz6rNxAXzoW5aMExIne
 +kOwMIkJ2x2REjKOll9TAJ+l1sckzg0c77xuvySDFGLmXsK59d6GsbBmuPNlFK8sh8sN
 QyuAV5Lua2elpHgLdiq1xV0ubgjOFLc/T3n4kYIE/QghqxNemgszZAytxLmp1ckRmy8B
 1cxA==
X-Gm-Message-State: APjAAAXipCQfBa+52FDkqgRlzSaawJW80P3A8YKwNx+UWQPPQzlW9aIl
 6xSBAsZlQB731Iir3RMzS+7QFSranwMt/E0QLYA=
X-Google-Smtp-Source: APXvYqyW4KvTu0rg0K0TrbnA6I6Z0C20c+C0zyrc/HiqCj95sljAxR3W+HINAXUa7yEJRY/5UMHMvSnNc74pbFdcKbM=
X-Received: by 2002:a05:6830:1042:: with SMTP id
 b2mr2969971otp.306.1575207993912; 
 Sun, 01 Dec 2019 05:46:33 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6830:1391:0:0:0:0 with HTTP; Sun, 1 Dec 2019 05:46:33
 -0800 (PST)
In-Reply-To: <9C97FEE6-D390-4CEB-9B00-50AE00AEA4D2@redhat.com>
References: <20191130194240.10517-18-armbru@redhat.com>
 <9C97FEE6-D390-4CEB-9B00-50AE00AEA4D2@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sun, 1 Dec 2019 14:46:33 +0100
Message-ID: <CAL1e-=jst9hGBXy0zm-975QDvW0F0xBNJAypqM4KooWEUvJfjQ@mail.gmail.com>
Subject: Re: [PATCH 17/21] s390x: Fix latent query-cpu-model-FOO error
 handling bugs
To: David Hildenbrand <dhildenb@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000ecb06d0598a4b08d"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 "vsementsov@virtuozzo.com" <vsementsov@virtuozzo.com>,
 Markus Armbruster <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000ecb06d0598a4b08d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Saturday, November 30, 2019, David Hildenbrand <dhildenb@redhat.com>
wrote:

>
>
> > Am 30.11.2019 um 20:42 schrieb Markus Armbruster <armbru@redhat.com>:
> >
> > =EF=BB=BFcpu_model_from_info() is a helper for qmp_query_cpu_model_expa=
nsion(),
> > qmp_query_cpu_model_comparison(), qmp_query_cpu_model_baseline().  It
> > crashes when the visitor or the QOM setter fails, and its @errp
> > argument is null.  Messed up in commit 137974cea3 's390x/cpumodel:
> > implement QMP interface "query-cpu-model-expansion"'.
> >
> > Its three callers have the same bug.  Messed up in commit 4e82ef0502
> > 's390x/cpumodel: implement QMP interface "query-cpu-model-comparison"'
> > and commit f1a47d08ef 's390x/cpumodel: implement QMP interface
> > "query-cpu-model-baseline"'.
> >
> > The bugs can't bite as no caller actually passes null.  Fix them
> > anyway.
>
> https://en.m.wikipedia.org/wiki/Software_bug
>
>   =E2=80=9E A software bug is an error, flaw or fault in a computer progr=
am or
> system that causes it to produce an incorrect or unexpected result, or to
> behave in unintended ways. =E2=80=9E
>
> Please make it clear in the descriptions that these are cleanups and not
> bugfixes. It might be very confusing for people looking out for real bugs=
.


>
Disclaimer: I am not entirely familiar with the code in question, so take
my opinion with reasonablereservation.

It looks that we here deal with latent bugs. As you probably know from
experience, a latent bugs, when they are activated with some ostensibly
unrelated code change, can be much more difficult to diagnose and fix than
regular bugs.

In that light, this change is not a clean up. It is a fix of a latent bugs,
and Markus' aproach to treat it as a bug fix looks right to me. I would
just add a word "latent" or similar, which would even more distance the
patch from "cleanup" meaning.

David, if I understand well, this patch fixes the commit done by you. I
definitely understand this is not a pleasant position, but we all
(definitelly including myself too) should learn to handle such situations
as gracefully as we can.

Yours,
Aleksandar



>
>
>
> Also, please change the terminology =E2=80=9Emessed up=E2=80=9C to =E2=80=
=9Eintroduced in=E2=80=9C or
> similar.
>
> (applies to all s390x patches)
>
> Thanks.

--000000000000ecb06d0598a4b08d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Saturday, November 30, 2019, David Hildenbrand &lt;<a href=3D"ma=
ilto:dhildenb@redhat.com">dhildenb@redhat.com</a>&gt; wrote:<br><blockquote=
 class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc soli=
d;padding-left:1ex"><br>
<br>
&gt; Am 30.11.2019 um 20:42 schrieb Markus Armbruster &lt;<a href=3D"mailto=
:armbru@redhat.com">armbru@redhat.com</a>&gt;:<br>
&gt; <br>
&gt; =EF=BB=BFcpu_model_from_info() is a helper for qmp_query_cpu_model_exp=
ansion(<wbr>),<br>
&gt; qmp_query_cpu_model_<wbr>comparison(), qmp_query_cpu_model_baseline()<=
wbr>.=C2=A0 It<br>
&gt; crashes when the visitor or the QOM setter fails, and its @errp<br>
&gt; argument is null.=C2=A0 Messed up in commit 137974cea3 &#39;s390x/cpum=
odel:<br>
&gt; implement QMP interface &quot;query-cpu-model-expansion&quot;&#39;.<br=
>
&gt; <br>
&gt; Its three callers have the same bug.=C2=A0 Messed up in commit 4e82ef0=
502<br>
&gt; &#39;s390x/cpumodel: implement QMP interface &quot;query-cpu-model-com=
parison&quot;&#39;<br>
&gt; and commit f1a47d08ef &#39;s390x/cpumodel: implement QMP interface<br>
&gt; &quot;query-cpu-model-baseline&quot;&#39;.<br>
&gt; <br>
&gt; The bugs can&#39;t bite as no caller actually passes null.=C2=A0 Fix t=
hem<br>
&gt; anyway.<br>
<br>
<a href=3D"https://en.m.wikipedia.org/wiki/Software_bug" target=3D"_blank">=
https://en.m.wikipedia.org/<wbr>wiki/Software_bug</a><br>
<br>
=C2=A0 =E2=80=9E A software bug is an error, flaw or fault in a computer pr=
ogram or system that causes it to produce an incorrect or unexpected result=
, or to behave in unintended ways. =E2=80=9E<br>
<br>
Please make it clear in the descriptions that these are cleanups and not bu=
gfixes. It might be very confusing for people looking out for real bugs.</b=
lockquote><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex"><br></blockquote><div><br></div><d=
iv>Disclaimer: I am not entirely familiar with the code in question, so tak=
e my opinion with reasonablereservation.</div><div><br></div><div>It looks =
that we here deal with latent bugs. As you probably know from experience, a=
 latent bugs, when they are activated with some ostensibly unrelated code c=
hange, can be much more difficult to diagnose and fix than regular bugs.</d=
iv><div><br></div><div>In that light, this change is not a clean up. It is =
a fix of a latent bugs, and Markus&#39; aproach to treat it as a bug fix lo=
oks right to me. I would just add a word &quot;latent&quot; or similar, whi=
ch would even more distance the patch from &quot;cleanup&quot; meaning.</di=
v><div><br></div><div>David, if I understand well, this patch fixes the com=
mit done by you. I definitely understand this is not a pleasant position, b=
ut we all (definitelly including myself too) should learn to handle such si=
tuations as gracefully as we can.</div><div><br></div><div>Yours,</div><div=
>Aleksandar</div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail=
_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:=
1ex"><br></blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><br></blockquote><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex"><br></blockquote><blockquote class=3D"gmail_quote=
" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">A=
lso, please change the terminology =E2=80=9Emessed up=E2=80=9C to =E2=80=9E=
introduced in=E2=80=9C or similar.<br>
<br>
(applies to all s390x patches)<br>
<br>
Thanks.</blockquote>

--000000000000ecb06d0598a4b08d--

