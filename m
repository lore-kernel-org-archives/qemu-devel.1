Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09CD7C32771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 12:00:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C002720656
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 12:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMH7jy8L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C002720656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipWTq-0008HI-QT
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 07:00:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55871)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ipWSx-0007oO-R3
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 06:59:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ipWSw-0000Uw-2Y
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 06:59:07 -0500
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:33333)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ipWSv-0000NL-Nt
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 06:59:05 -0500
Received: by mail-ot1-x32e.google.com with SMTP id b18so7012845otp.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 03:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=PcasZ8zVFZGSNPEthaBnjE9TvA0HsvnAnHMipWWkUTM=;
 b=BMH7jy8LmAl44PeFx0t9mtktm3lKPnaDuibWOz98Y/U6SIZKiMg/TMdzDnB/abqPeG
 fFHhTrcR0kvRjQ0WhZNwCZ83GQ2FPk17E1cKEZBa3I0rrExy9uw6oq7GmCXUj1bJR6vw
 iGcsb6wgIL48+ah/r7QbSh37HROWrhX+tGtkEn2LDj9eEan1YIqD9A70mGRh11c+ulab
 BT1Jt0EO5HLwj6yVHM7fExjXr2jTTmXypIHh5DO/CNDEPZKt8QgiJZpVpK42umEEMvd3
 TDcBqr2uL9HC51eopkFJLeTuECm6zvPztBqYYpS17HD6qgvKCUQQYGRm9Bei8SV6bDf6
 mJAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=PcasZ8zVFZGSNPEthaBnjE9TvA0HsvnAnHMipWWkUTM=;
 b=OaXq6vzI5P55/FrZ0VAdTxFQO95MgkqZyjat8UazHTgkvdNv7vDxQ8c8cVnBPkleg0
 e5CbotmR7NgwVgnczFjxep7jyY216FO5ZDEzR5Py9WnPrkcTsY7/OLDEiuGDyKs93SyX
 trkDtyhzGDEeysYerhVBdgOgxrCBWecybyQd6QkmljRspTZPSQZe1kpJguvaRX7BDLoE
 9Ip25plARqEzyvOkvLRO/T728M8uymiqgAQ6dCPrSPh68GhlmFwR5jGqpg/++GqyBmbc
 e1Tut+5117r/PoXSeerTFVgANqPW6qV7kzvP1Q8othf/mGLrfsTvSoQL6BRP+9UpXlBp
 AFew==
X-Gm-Message-State: APjAAAUldodLahSnIxX0w32W8v+higzNDH8t1xbw67WIplg2br0jr66L
 se9JNVksBfTQA6ZplxI8KwioB/QzzmYX7GMvpYQ=
X-Google-Smtp-Source: APXvYqyF5sq83hvx3/sHU1HXP8cZ0EqEHIqXCdCT7dhyiegj17shETRCt3jcbn0jfmf1yxSKD+Y03hUIq7UJyr+6l44=
X-Received: by 2002:a9d:7305:: with SMTP id e5mr7894015otk.64.1578571144499;
 Thu, 09 Jan 2020 03:59:04 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Thu, 9 Jan 2020 03:59:04 -0800 (PST)
In-Reply-To: <373c37b0-812d-2bcd-4983-7999d19dde66@redhat.com>
References: <20200109021710.1219-1-richard.henderson@linaro.org>
 <20200109021710.1219-3-richard.henderson@linaro.org>
 <58c44c67-4b1b-dfef-c4a0-f47b33f4283b@redhat.com>
 <373c37b0-812d-2bcd-4983-7999d19dde66@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 9 Jan 2020 12:59:04 +0100
Message-ID: <CAL1e-=jPcBBRxJ8PmDzus7w_p_JObuYbx0_sE-m4x969MePJRA@mail.gmail.com>
Subject: [PATCH 2/4] vl: Free accel_list in configure_accelerators
To: Laurent Vivier <lvivier@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000005215ed059bb3bce7"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32e
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000005215ed059bb3bce7
Content-Type: text/plain; charset="UTF-8"

On Thursday, January 9, 2020, Laurent Vivier <lvivier@redhat.com> wrote:

> On 09/01/2020 09:18, Thomas Huth wrote:
> > On 09/01/2020 03.17, Richard Henderson wrote:
> >> We allocate the list with g_strsplit, so free it too.
> >> This freeing was lost during one of the rearrangements.
> >>
> >> Fixes: 6f6e1698a68c
> >> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> >> ---
> >>  vl.c | 4 +++-
> >>  1 file changed, 3 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/vl.c b/vl.c
> >> index be79b03c1a..c9329fe699 100644
> >> --- a/vl.c
> >> +++ b/vl.c
> >> @@ -2748,7 +2748,6 @@ static int do_configure_accelerator(void *opaque,
> QemuOpts *opts, Error **errp)
> >>  static void configure_accelerators(const char *progname)
> >>  {
> >>      const char *accel;
> >> -    char **accel_list, **tmp;
> >>      bool init_failed = false;
> >>
> >>      qemu_opts_foreach(qemu_find_opts("icount"),
> >> @@ -2756,6 +2755,8 @@ static void configure_accelerators(const char
> *progname)
> >>
> >>      accel = qemu_opt_get(qemu_get_machine_opts(), "accel");
> >>      if (QTAILQ_EMPTY(&qemu_accel_opts.head)) {
> >> +        char **accel_list, **tmp;
> >> +
> >>          if (accel == NULL) {
> >>              /* Select the default accelerator */
> >>              if (!accel_find("tcg") && !accel_find("kvm")) {
> >> @@ -2787,6 +2788,7 @@ static void configure_accelerators(const char
> *progname)
> >>                  error_report("invalid accelerator %s", *tmp);
> >>              }
> >>          }
> >> +        g_strfreev(accel_list);
> >>      } else {
> >>          if (accel != NULL) {
> >>              error_report("The -accel and \"-machine accel=\" options
> are incompatible");
> >>
> >
> > FYI, a fix for this is already part of Laurent's "Trivial branch
> > patches" PULL request from yesterday.
>
> https://patchew.org/QEMU/20200108160233.991134-1-laurent@
> vivier.eu/20200108160233.991134-6-laurent@vivier.eu/
>
>
If this (from Laurent's PR) patch is merged, Richard could transform his
patch into "vl: Fix the scope of variables accel_list and tmp in
configure_accelerator()" in v2.

Whatever happens:

Reviewed by: Aleksandar Markovic <amarkovic@wavecomp.com>


> Thanks,
> Laurent
>
>
>

--0000000000005215ed059bb3bce7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Thursday, January 9, 2020, Laurent Vivier &lt;<a href=3D"mailto:=
lvivier@redhat.com" target=3D"_blank">lvivier@redhat.com</a>&gt; wrote:<br>=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">On 09/01/2020 09:18, Thomas Huth wrote:<br>
&gt; On 09/01/2020 03.17, Richard Henderson wrote:<br>
&gt;&gt; We allocate the list with g_strsplit, so free it too.<br>
&gt;&gt; This freeing was lost during one of the rearrangements.<br>
&gt;&gt;<br>
&gt;&gt; Fixes: 6f6e1698a68c<br>
&gt;&gt; Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.hen=
derson@linaro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<b=
r>
&gt;&gt; ---<br>
&gt;&gt;=C2=A0 vl.c | 4 +++-<br>
&gt;&gt;=C2=A0 1 file changed, 3 insertions(+), 1 deletion(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/vl.c b/vl.c<br>
&gt;&gt; index be79b03c1a..c9329fe699 100644<br>
&gt;&gt; --- a/vl.c<br>
&gt;&gt; +++ b/vl.c<br>
&gt;&gt; @@ -2748,7 +2748,6 @@ static int do_configure_accelerator(void *op=
aque, QemuOpts *opts, Error **errp)<br>
&gt;&gt;=C2=A0 static void configure_accelerators(const char *progname)<br>
&gt;&gt;=C2=A0 {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 const char *accel;<br>
&gt;&gt; -=C2=A0 =C2=A0 char **accel_list, **tmp;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 bool init_failed =3D false;<br>
&gt;&gt;=C2=A0 <br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 qemu_opts_foreach(qemu_find_op<wbr>ts(&quot;ic=
ount&quot;),<br>
&gt;&gt; @@ -2756,6 +2755,8 @@ static void configure_accelerators(const cha=
r *progname)<br>
&gt;&gt;=C2=A0 <br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 accel =3D qemu_opt_get(qemu_get_machine_<wbr>o=
pts(), &quot;accel&quot;);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 if (QTAILQ_EMPTY(&amp;qemu_accel_opts<wbr>.hea=
d)) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 char **accel_list, **tmp;<br>
&gt;&gt; +<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (accel =3D=3D NULL) {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Select the defa=
ult accelerator */<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!accel_find(&q=
uot;tcg&quot;) &amp;&amp; !accel_find(&quot;kvm&quot;)) {<br>
&gt;&gt; @@ -2787,6 +2788,7 @@ static void configure_accelerators(const cha=
r *progname)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 erro=
r_report(&quot;invalid accelerator %s&quot;, *tmp);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_strfreev(accel_list);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (accel !=3D NULL) {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot=
;The -accel and \&quot;-machine accel=3D\&quot; options are incompatible&qu=
ot;);<br>
&gt;&gt;<br>
&gt; <br>
&gt; FYI, a fix for this is already part of Laurent&#39;s &quot;Trivial bra=
nch<br>
&gt; patches&quot; PULL request from yesterday.<br>
<br>
<a href=3D"https://patchew.org/QEMU/20200108160233.991134-1-laurent@vivier.=
eu/20200108160233.991134-6-laurent@vivier.eu/" target=3D"_blank">https://pa=
tchew.org/QEMU/20200<wbr>108160233.991134-1-laurent@<wbr>vivier.eu/20200108=
160233.<wbr>991134-6-laurent@vivier.eu/</a><br>
<br></blockquote><div><br></div><div>If this (from Laurent&#39;s PR) patch =
is merged, Richard could transform his patch into &quot;vl: Fix the scope o=
f variables accel_list and tmp in configure_accelerator()&quot; in v2.</div=
><div><br></div><div>Whatever happens:</div><div><br></div><div>Reviewed by=
: Aleksandar Markovic &lt;<a href=3D"mailto:amarkovic@wavecomp.com">amarkov=
ic@wavecomp.com</a>&gt;</div><div>=C2=A0</div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
">
Thanks,<br>
Laurent<br>
<br>
<br>
</blockquote>

--0000000000005215ed059bb3bce7--

