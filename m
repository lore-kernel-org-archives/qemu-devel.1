Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF02AC433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:32:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 782A320719
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:32:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 782A320719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCrPM-0004wS-9C
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 17:32:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kCrDT-00045u-W4
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 17:19:52 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33035)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kCrDR-0001Xh-VJ
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 17:19:51 -0400
Received: by mail-qk1-f193.google.com with SMTP id p4so7638872qkf.0
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 14:19:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IQ02CL8guGtLAyYApAPd+sO96HmXokSkOgW1+tk0TRM=;
 b=N/ZRCVfLdznmuQ20iUxALFpz0hrewf+Wxv30QcE55njOny7d9P1qBwj5vwePFEpJNx
 bGDpPs5kLDKlWSUEb5flvG0DTKDvP5CP0l49od4xlTz9zzS1kBkWfTk6Pn2MC67u+i0t
 +F/x7Dyabrl76FV5/6QoQ182yDyeYAZCqjVNCfSHO9hGdSoR7oQ11Wxf+NUxAuDIuogW
 AtMDL7Ht+u/nps0YxsDSV6TElOO98IJNeMEzApv3mWbOd75EVxcAhSGY6gpUF+mzY+Ei
 vupSAt4crvhjIfepIKziFyhMX0sFuMQxK2VPgqyxy5NudpZWxmYjfAHzROu4fC1/qcsQ
 H2yQ==
X-Gm-Message-State: AOAM530NTF6g7RhW5adDbE6+SgiLf1k5U6UMr0TjZPXRQzK4yaT9RSXU
 LqnpxRNHah/XsHGLBuaHhsEUrsiBNNcH3iFyc8Q=
X-Google-Smtp-Source: ABdhPJxsNbsOPyte1W8r86rDbfaj6XTiYAq/NtM+IIO1g5Hg8meBkxhN1q9dWOWKLZWXhtBbA3hX6lZbJAvloP10INA=
X-Received: by 2002:a05:620a:3c8:: with SMTP id
 r8mr3448958qkm.84.1598908789132; 
 Mon, 31 Aug 2020 14:19:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200827142915.108730-1-stefanha@redhat.com>
 <20200827142915.108730-4-stefanha@redhat.com>
In-Reply-To: <20200827142915.108730-4-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 31 Aug 2020 22:20:26 +0200
Message-ID: <CAAdtpL67FPFB8hW7WZ-ZjLM-_oHbXgNWaGELTby8RjyscYHKvQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] tracetool: add input filename and line number to Event
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000067932b05ae32f666"
Received-SPF: pass client-ip=209.85.222.193;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-qk1-f193.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 17:16:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000067932b05ae32f666
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 27 ao=C3=BBt 2020 16:32, Stefan Hajnoczi <stefanha@redhat.com> a =
=C3=A9crit :

> Store the input filename and line number in Event.
>
> A later patch will use this to improve error messages.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

---
>  scripts/tracetool/__init__.py | 27 ++++++++++++++++++++++-----
>  1 file changed, 22 insertions(+), 5 deletions(-)
>
> diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.p=
y
> index e4ee4d5e61..1a6e2fa64a 100644
> --- a/scripts/tracetool/__init__.py
> +++ b/scripts/tracetool/__init__.py
> @@ -218,6 +218,10 @@ class Event(object):
>          Properties of the event.
>      args : Arguments
>          The event arguments.
> +    lineno : int
> +        The line number in the input file.
> +    filename : str
> +        The path to the input file.
>
>      """
>
> @@ -230,7 +234,7 @@ class Event(object):
>
>      _VALID_PROPS =3D set(["disable", "tcg", "tcg-trans", "tcg-exec",
> "vcpu"])
>
> -    def __init__(self, name, props, fmt, args, orig=3DNone,
> +    def __init__(self, name, props, fmt, args, lineno, filename,
> orig=3DNone,
>                   event_trans=3DNone, event_exec=3DNone):
>          """
>          Parameters
> @@ -243,6 +247,10 @@ class Event(object):
>              Event printing format string(s).
>          args : Arguments
>              Event arguments.
> +        lineno : int
> +            The line number in the input file.
> +        filename : str
> +            The path to the input file.
>          orig : Event or None
>              Original Event before transformation/generation.
>          event_trans : Event or None
> @@ -255,6 +263,8 @@ class Event(object):
>          self.properties =3D props
>          self.fmt =3D fmt
>          self.args =3D args
> +        self.lineno =3D int(lineno)
> +        self.filename =3D str(filename)
>          self.event_trans =3D event_trans
>          self.event_exec =3D event_exec
>
> @@ -276,16 +286,21 @@ class Event(object):
>      def copy(self):
>          """Create a new copy."""
>          return Event(self.name, list(self.properties), self.fmt,
> -                     self.args.copy(), self, self.event_trans,
> self.event_exec)
> +                     self.args.copy(), self.lineno, self.filename,
> +                     self, self.event_trans, self.event_exec)
>
>      @staticmethod
> -    def build(line_str):
> +    def build(line_str, lineno, filename):
>          """Build an Event instance from a string.
>
>          Parameters
>          ----------
>          line_str : str
>              Line describing the event.
> +        lineno : int
> +            Line number in input file.
> +        filename : str
> +            Path to input file.
>          """
>          m =3D Event._CRE.match(line_str)
>          assert m is not None
> @@ -315,7 +330,7 @@ class Event(object):
>          if "tcg" in props and isinstance(fmt, str):
>              raise ValueError("Events with 'tcg' property must have two
> format strings")
>
> -        event =3D Event(name, props, fmt, args)
> +        event =3D Event(name, props, fmt, args, lineno, filename)
>
>          # add implicit arguments when using the 'vcpu' property
>          import tracetool.vcpu
> @@ -360,6 +375,8 @@ class Event(object):
>                       list(self.properties),
>                       self.fmt,
>                       self.args.transform(*trans),
> +                     self.lineno,
> +                     self.filename,
>                       self)
>
>
> @@ -386,7 +403,7 @@ def read_events(fobj, fname):
>              continue
>
>          try:
> -            event =3D Event.build(line)
> +            event =3D Event.build(line, lineno, fname)
>          except ValueError as e:
>              arg0 =3D 'Error at %s:%d: %s' % (fname, lineno, e.args[0])
>              e.args =3D (arg0,) + e.args[1:]
> --
> 2.26.2
>
>

--00000000000067932b05ae32f666
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Le jeu. 27 ao=C3=BBt 2020 16:32, Stefan Hajnoczi &lt;<=
a href=3D"mailto:stefanha@redhat.com">stefanha@redhat.com</a>&gt; a =C3=A9c=
rit=C2=A0:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex">Store the input filename=
 and line number in Event.<br>
<br>
A later patch will use this to improve error messages.<br>
<br>
Signed-off-by: Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@redhat.com" t=
arget=3D"_blank" rel=3D"noreferrer">stefanha@redhat.com</a>&gt;<br></blockq=
uote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto"><span style=
=3D"font-family:sans-serif;font-size:13.696px">Reviewed-by: Philippe Mathie=
u-Daud=C3=A9 &lt;</span><a href=3D"mailto:f4bug@amsat.org" style=3D"text-de=
coration:none;color:rgb(66,133,244);font-family:sans-serif;font-size:13.696=
px">f4bug@amsat.org</a><span style=3D"font-family:sans-serif;font-size:13.6=
96px">&gt;</span><br></div><div dir=3D"auto"><br></div><div dir=3D"auto"><d=
iv class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:=
0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
---<br>
=C2=A0scripts/tracetool/__init__.py | 27 ++++++++++++++++++++++-----<br>
=C2=A01 file changed, 22 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.py<=
br>
index e4ee4d5e61..1a6e2fa64a 100644<br>
--- a/scripts/tracetool/__init__.py<br>
+++ b/scripts/tracetool/__init__.py<br>
@@ -218,6 +218,10 @@ class Event(object):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Properties of the event.<br>
=C2=A0 =C2=A0 =C2=A0args : Arguments<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0The event arguments.<br>
+=C2=A0 =C2=A0 lineno : int<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 The line number in the input file.<br>
+=C2=A0 =C2=A0 filename : str<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 The path to the input file.<br>
<br>
=C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
<br>
@@ -230,7 +234,7 @@ class Event(object):<br>
<br>
=C2=A0 =C2=A0 =C2=A0_VALID_PROPS =3D set([&quot;disable&quot;, &quot;tcg&qu=
ot;, &quot;tcg-trans&quot;, &quot;tcg-exec&quot;, &quot;vcpu&quot;])<br>
<br>
-=C2=A0 =C2=A0 def __init__(self, name, props, fmt, args, orig=3DNone,<br>
+=C2=A0 =C2=A0 def __init__(self, name, props, fmt, args, lineno, filename,=
 orig=3DNone,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 event_trans=
=3DNone, event_exec=3DNone):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Parameters<br>
@@ -243,6 +247,10 @@ class Event(object):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Event printing format strin=
g(s).<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0args : Arguments<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Event arguments.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 lineno : int<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 The line number in the input fil=
e.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 filename : str<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 The path to the input file.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0orig : Event or None<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Original Event before trans=
formation/generation.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0event_trans : Event or None<br>
@@ -255,6 +263,8 @@ class Event(object):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.properties =3D props<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.fmt =3D fmt<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.args =3D args<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.lineno =3D int(lineno)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.filename =3D str(filename)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.event_trans =3D event_trans<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.event_exec =3D event_exec<br>
<br>
@@ -276,16 +286,21 @@ class Event(object):<br>
=C2=A0 =C2=A0 =C2=A0def copy(self):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Create a new copy.&quot=
;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return Event(<a href=3D"http://self.name"=
 rel=3D"noreferrer noreferrer" target=3D"_blank">self.name</a>, list(self.p=
roperties), self.fmt,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0self.args.copy(), self, self.event_trans, self.event_exec)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0self.args.copy(), self.lineno, self.filename,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0self, self.event_trans, self.event_exec)<br>
<br>
=C2=A0 =C2=A0 =C2=A0@staticmethod<br>
-=C2=A0 =C2=A0 def build(line_str):<br>
+=C2=A0 =C2=A0 def build(line_str, lineno, filename):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;Build an Event instance=
 from a string.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Parameters<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0----------<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0line_str : str<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Line describing the event.<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 lineno : int<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Line number in input file.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 filename : str<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Path to input file.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0m =3D Event._CRE.match(line_str)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0assert m is not None<br>
@@ -315,7 +330,7 @@ class Event(object):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if &quot;tcg&quot; in props and isinstanc=
e(fmt, str):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise ValueError(&quot;Even=
ts with &#39;tcg&#39; property must have two format strings&quot;)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 event =3D Event(name, props, fmt, args)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 event =3D Event(name, props, fmt, args, lineno=
, filename)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# add implicit arguments when using the &=
#39;vcpu&#39; property<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0import tracetool.vcpu<br>
@@ -360,6 +375,8 @@ class Event(object):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 list(self.properties),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 self.fmt,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 self.args.transform(*trans),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0self.lineno,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0self.filename,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 self)<br>
<br>
<br>
@@ -386,7 +403,7 @@ def read_events(fobj, fname):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0continue<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0try:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 event =3D Event.build(line)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 event =3D Event.build(line, line=
no, fname)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0except ValueError as e:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0arg0 =3D &#39;Error at %s:%=
d: %s&#39; % (fname, lineno, e.args[0])<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0e.args =3D (arg0,) + e.args=
[1:]<br>
-- <br>
2.26.2<br>
<br>
</blockquote></div></div></div>

--00000000000067932b05ae32f666--

