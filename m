Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1E8C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 08:19:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E48EE20708
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 08:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JcuCPdyC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E48EE20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOGHn-0006yE-SA
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 04:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kOGH9-00068g-0S; Fri, 02 Oct 2020 04:18:47 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:40765)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kOGH6-0001Aq-SJ; Fri, 02 Oct 2020 04:18:46 -0400
Received: by mail-lf1-x142.google.com with SMTP id m5so823302lfp.7;
 Fri, 02 Oct 2020 01:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=zHXhax1dbjEU812GaMOKsxVjkC3XpdhlsfpMUpPCDYk=;
 b=JcuCPdyC4IsGPEI3YqMN4yJJxWZZJlXEEfHRB1gjjeTVjRl3w1HMHSJJ9jxxQEw+KB
 m0vdQ5J5Je+hR6li+ySZk4kbwm4c+EIyIVko8pvdSlHDqFsyBBgZX7Xcw/S+Iz8eQ+LJ
 SWLIcV5rkFAixdPl/+s0perwJ7Aa+aKKvLL0+nBDwV7IkNEraV0+HFxKshk1J2ntVCnG
 8oocY4HoyvvXi+XJQHBLyKBUmwJmfSOAZ2atMUwbmYXmsIIsJ/LxwvVuFoioN+z9re5X
 OWhL+LGdQWushlUf3ZBncQZqSt7mxEXMiDqQbu9p1LkmH9O2VIosQm/tRq4iafKswCoi
 hzIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=zHXhax1dbjEU812GaMOKsxVjkC3XpdhlsfpMUpPCDYk=;
 b=NXfNChC80a1z+bqoyVtvp00zbgPl6UiNHYf/RfquYueC7nqKgR0tf3PgAzjHH0jAI3
 rmYLhki8HvneLmxpvtO6XzHCJ5txdV9t28aJzl5b/qCbPyXsAB616ALFQtIE/jVkCw61
 6/PfNLGB/Za08gneycJGPSombm3bIFZwTDRSYZ61macsUpE+G6FDUWcI3fILeopIPxhl
 0nc3V8aeqSBpGanpjrd2bxx7Zs7ayuS2lLD6cI1VRFUCFGeDGg+PeIJojHyPHGoE1hDj
 OZfBj75c0qNQUfIPNStAjndMa89MCNKoJQnGHYUcE37Peg185UWYeDvZSc2g2odw6dEz
 UyFQ==
X-Gm-Message-State: AOAM53257EQLswkDRdzZXMmRPkngLCqhjXpN4wjlLIZRS43HsFRoAErI
 q+PG0XEjtfDu+l/P8OPPVV3VSLzY0JUgHBvc8Hc=
X-Google-Smtp-Source: ABdhPJzWh8RlVQtECK0BuBhp50guCH6vN0uSia6JAiX3rYiOktYq/pU4fjwDTjMp46FdkCknPHezpfb8PnO/L0P909I=
X-Received: by 2002:a19:383:: with SMTP id 125mr479227lfd.356.1601626722539;
 Fri, 02 Oct 2020 01:18:42 -0700 (PDT)
MIME-Version: 1.0
References: <20201001173503.1107-1-luoyonggang@gmail.com>
 <20201001173503.1107-2-luoyonggang@gmail.com>
 <87blhltdh7.fsf@dusky.pond.sub.org>
In-Reply-To: <87blhltdh7.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Fri, 2 Oct 2020 16:18:30 +0800
Message-ID: <CAE2XoE-PysXdbGLAddGf0b1Z-MrZfSjcpzijRzK8gKgq8bEuAg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] doc: Remove texi referenced in qemu-img-cmds.hx
 and target/i386/cpu.c
To: Markus Armbruster <armbru@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000dc1b7305b0abc7ba"
Received-SPF: pass client-ip=2a00:1450:4864:20::142;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x142.google.com
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
Reply-To: luoyonggang@gmail.com
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 QEMU Trivial <qemu-trivial@nongnu.org>, qemu-level <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000dc1b7305b0abc7ba
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

OK, then skip this

On Fri, Oct 2, 2020 at 1:15 PM Markus Armbruster <armbru@redhat.com> wrote:
>
> Yonggang Luo <luoyonggang@gmail.com> writes:
>
> > There is no texi document anymore
> >
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > ---
> >  qemu-img-cmds.hx  | 2 +-
> >  target/i386/cpu.c | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
> > index b89c019b76..cab8234235 100644
> > --- a/qemu-img-cmds.hx
> > +++ b/qemu-img-cmds.hx
> > @@ -1,5 +1,5 @@
> >  HXCOMM Keep the list of subcommands sorted by name.
> > -HXCOMM Use DEFHEADING() to define headings in both help text and texi
> > +HXCOMM Use DEFHEADING() to define headings in both help text and rST
> >  HXCOMM Text between SRST and ERST are copied to rST version and
> >  HXCOMM discarded from C version
> >  HXCOMM DEF(command, callback, arg_string) is used to construct
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index f37eb7b675..f8231f56b6 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -4127,7 +4127,7 @@ static PropValue tcg_default_props[] =3D {
> >   * We resolve CPU model aliases using -v1 when using "-machine
> >   * none", but this is just for compatibility while libvirt isn't
> >   * adapted to resolve CPU model versions before creating VMs.
> > - * See "Runnability guarantee of CPU models" at * qemu-deprecated.texi=
.
> > + * See "Runnability guarantee of CPU models" at * deprecated.rst.
> >   */
> >  X86CPUVersion default_cpu_version =3D 1;
>
> Duplicates my "[PATCH 0/2] Update leftover comments that mention
> Texinfo", which Laurent has queued.
>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000dc1b7305b0abc7ba
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">OK, then skip this<br><br>On Fri, Oct 2, 2020 at 1:15 PM M=
arkus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com=
</a>&gt; wrote:<br>&gt;<br>&gt; Yonggang Luo &lt;<a href=3D"mailto:luoyongg=
ang@gmail.com">luoyonggang@gmail.com</a>&gt; writes:<br>&gt;<br>&gt; &gt; T=
here is no texi document anymore<br>&gt; &gt;<br>&gt; &gt; Signed-off-by: Y=
onggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.com">luoyonggang@gmail.=
com</a>&gt;<br>&gt; &gt; ---<br>&gt; &gt; =C2=A0qemu-img-cmds.hx =C2=A0| 2 =
+-<br>&gt; &gt; =C2=A0target/i386/cpu.c | 2 +-<br>&gt; &gt; =C2=A02 files c=
hanged, 2 insertions(+), 2 deletions(-)<br>&gt; &gt;<br>&gt; &gt; diff --gi=
t a/qemu-img-cmds.hx b/qemu-img-cmds.hx<br>&gt; &gt; index b89c019b76..cab8=
234235 100644<br>&gt; &gt; --- a/qemu-img-cmds.hx<br>&gt; &gt; +++ b/qemu-i=
mg-cmds.hx<br>&gt; &gt; @@ -1,5 +1,5 @@<br>&gt; &gt; =C2=A0HXCOMM Keep the =
list of subcommands sorted by name.<br>&gt; &gt; -HXCOMM Use DEFHEADING() t=
o define headings in both help text and texi<br>&gt; &gt; +HXCOMM Use DEFHE=
ADING() to define headings in both help text and rST<br>&gt; &gt; =C2=A0HXC=
OMM Text between SRST and ERST are copied to rST version and<br>&gt; &gt; =
=C2=A0HXCOMM discarded from C version<br>&gt; &gt; =C2=A0HXCOMM DEF(command=
, callback, arg_string) is used to construct<br>&gt; &gt; diff --git a/targ=
et/i386/cpu.c b/target/i386/cpu.c<br>&gt; &gt; index f37eb7b675..f8231f56b6=
 100644<br>&gt; &gt; --- a/target/i386/cpu.c<br>&gt; &gt; +++ b/target/i386=
/cpu.c<br>&gt; &gt; @@ -4127,7 +4127,7 @@ static PropValue tcg_default_prop=
s[] =3D {<br>&gt; &gt; =C2=A0 * We resolve CPU model aliases using -v1 when=
 using &quot;-machine<br>&gt; &gt; =C2=A0 * none&quot;, but this is just fo=
r compatibility while libvirt isn&#39;t<br>&gt; &gt; =C2=A0 * adapted to re=
solve CPU model versions before creating VMs.<br>&gt; &gt; - * See &quot;Ru=
nnability guarantee of CPU models&quot; at * qemu-deprecated.texi.<br>&gt; =
&gt; + * See &quot;Runnability guarantee of CPU models&quot; at * deprecate=
d.rst.<br>&gt; &gt; =C2=A0 */<br>&gt; &gt; =C2=A0X86CPUVersion default_cpu_=
version =3D 1;<br>&gt;<br>&gt; Duplicates my &quot;[PATCH 0/2] Update lefto=
ver comments that mention<br>&gt; Texinfo&quot;, which Laurent has queued.<=
br>&gt;<br><br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=
=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 s=
incerely,<br>Yonggang Luo</div>

--000000000000dc1b7305b0abc7ba--

