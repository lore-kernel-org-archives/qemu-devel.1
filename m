Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4910C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 00:56:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9801020791
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 00:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sHdXdo27"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9801020791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kB6DY-00062V-Te
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 20:56:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rohit.shinde12194@gmail.com>)
 id 1kB6D1-0005Vl-VU; Wed, 26 Aug 2020 20:56:07 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:42772)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rohit.shinde12194@gmail.com>)
 id 1kB6D0-0002a3-3V; Wed, 26 Aug 2020 20:56:07 -0400
Received: by mail-pg1-x541.google.com with SMTP id g1so2102997pgm.9;
 Wed, 26 Aug 2020 17:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5HcANXCkjFKsVhJ6CG//mHdkllQgS0m6ShWR7+kuyeg=;
 b=sHdXdo27+KMNrWLiC6fzNnT3kc6Jxjv4qMogNeaaa/5ww8SiDo+osjd2njnlRBbo50
 x7/9iWWNCV1mSZFUZ7nvq91LGhwa9QHqrEvuN1NNeHcMS+G6wGeHCz1pVxjcQth4v2Ab
 WwbwEJArFqXkanI/wylU6AsIBmrbqCv5uKiZGeFM4ZaUWVi60Q+1SE3NMEkb54vQLKuq
 WMT3kOx91ecEKarY25Oez1M6/DQDmlXv0EdsGphwU4zmNSBKSGqoG2frIFbSRJOQ6QNH
 bhAqqolYfDby9Q0p3IHl/DXs7wPiJzrgWqodR5SZRj3V+rrXxOorwrHbHe70hbgUJ0Pq
 84UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5HcANXCkjFKsVhJ6CG//mHdkllQgS0m6ShWR7+kuyeg=;
 b=aPF5zDa76YP5IApZEE6Ebbe7BPLlbHbO8PlqkGeoRE5Nx8ijNOjrnOizyB+8gHf79M
 ypP7KW8C9eSr4fstqczLGBlzMKA0O1ndZDX+f7jCpDPCLmdZgWOLqQ+Mv7HSiDxr/W+S
 ILNLXR4jInFZ8KqGAxqxzgG3erstVyGu3l4j8anVNAw3wmllc2xEIijEYKFi8LaNIK0E
 gUs1ggDqHyK8yF0fM4vc2eL48ZP7SRI3JxLZ6I0I8DlxuIJDTr4sbVg3myHu1/7BkW3E
 7+2IF87qCo4NzWJAB+BBlWox6Bqb99DwLoh+aJ4v6BOIZIXbtsjoe8itw8bPLAJa4y6S
 24Xg==
X-Gm-Message-State: AOAM530r8TeQ49Mt+Jum0gqMqyS9U1rDIgvMezXM3vUQHIna6UnyfwTF
 kcDUbV+cjlJPGfcvlGJSd8VZBxlIB7UvofLyfQY=
X-Google-Smtp-Source: ABdhPJzUxFcAkE3hlx8DcHXjp0+JJXi3L4thbJdjakby1MIqNfHKaBR1Id3StuHklBC301U7ODAidqgOrwHqbAfvheo=
X-Received: by 2002:a17:902:fe0f:: with SMTP id
 g15mr11820803plj.204.1598489763988; 
 Wed, 26 Aug 2020 17:56:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200818105021.4998-1-rohit.shinde12194@gmail.com>
 <87o8mzjm7r.fsf@dusky.pond.sub.org>
In-Reply-To: <87o8mzjm7r.fsf@dusky.pond.sub.org>
From: Rohit Shinde <rohit.shinde12194@gmail.com>
Date: Wed, 26 Aug 2020 20:55:53 -0400
Message-ID: <CA+Ai=tD2QK9+GaXQoQWzKTPY-uZhLSCBeLUfz95eCiHv0v2i+A@mail.gmail.com>
Subject: Re: [PATCH v5] qapi/opts-visitor: Added missing fallthrough
 annotations
To: Markus Armbruster <armbru@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000008f476405add16608"
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=rohit.shinde12194@gmail.com; helo=mail-pg1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000008f476405add16608
Content-Type: text/plain; charset="UTF-8"

I am just compiling with cflag set to -Wimplicit-fallthrough. I am using
gcc.

On Tue, Aug 25, 2020 at 2:03 AM Markus Armbruster <armbru@redhat.com> wrote:

> Rohit Shinde <rohit.shinde12194@gmail.com> writes:
>
> > Added fallthrough comment on line 270 to prevent the compiler from
> > throwing an error while compiling with the -Wimplicit-fallthrough flag
>
> None of the compilers I know warns there.  Which one are you using?
>
> Commit message style tip: use the imperative mood
> https://chris.beams.io/posts/git-commit/#imperative
>
> > Signed-off-by: Rohit Shinde <rohit.shinde12194@gmail.com>
> > ---
> >  qapi/opts-visitor.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/qapi/opts-visitor.c b/qapi/opts-visitor.c
> > index 7781c23a42..3422ff265e 100644
> > --- a/qapi/opts-visitor.c
> > +++ b/qapi/opts-visitor.c
> > @@ -266,6 +266,7 @@ opts_next_list(Visitor *v, GenericList *tail, size_t
> size)
> >          }
> >          ov->list_mode = LM_IN_PROGRESS;
> >          /* range has been completed, fall through in order to pop
> option */
> > +        /* fallthrough */
> >
> >      case LM_IN_PROGRESS: {
> >          const QemuOpt *opt;
>
>

--0000000000008f476405add16608
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I am just compiling with cflag set to -Wimplicit-fallthrou=
gh. I am using gcc.</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" cl=
ass=3D"gmail_attr">On Tue, Aug 25, 2020 at 2:03 AM Markus Armbruster &lt;<a=
 href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">Rohit Shinde &lt;<a hre=
f=3D"mailto:rohit.shinde12194@gmail.com" target=3D"_blank">rohit.shinde1219=
4@gmail.com</a>&gt; writes:<br>
<br>
&gt; Added fallthrough comment on line 270 to prevent the compiler from<br>
&gt; throwing an error while compiling with the -Wimplicit-fallthrough flag=
<br>
<br>
None of the compilers I know warns there.=C2=A0 Which one are you using?<br=
>
<br>
Commit message style tip: use the imperative mood<br>
<a href=3D"https://chris.beams.io/posts/git-commit/#imperative" rel=3D"nore=
ferrer" target=3D"_blank">https://chris.beams.io/posts/git-commit/#imperati=
ve</a><br>
<br>
&gt; Signed-off-by: Rohit Shinde &lt;<a href=3D"mailto:rohit.shinde12194@gm=
ail.com" target=3D"_blank">rohit.shinde12194@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 qapi/opts-visitor.c | 1 +<br>
&gt;=C2=A0 1 file changed, 1 insertion(+)<br>
&gt;<br>
&gt; diff --git a/qapi/opts-visitor.c b/qapi/opts-visitor.c<br>
&gt; index 7781c23a42..3422ff265e 100644<br>
&gt; --- a/qapi/opts-visitor.c<br>
&gt; +++ b/qapi/opts-visitor.c<br>
&gt; @@ -266,6 +266,7 @@ opts_next_list(Visitor *v, GenericList *tail, size=
_t size)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ov-&gt;list_mode =3D LM_IN_PROGRESS;=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* range has been completed, fall th=
rough in order to pop option */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* fallthrough */<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 case LM_IN_PROGRESS: {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const QemuOpt *opt;<br>
<br>
</blockquote></div>

--0000000000008f476405add16608--

