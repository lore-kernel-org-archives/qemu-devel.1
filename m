Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB40C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 17:15:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB46F207FB
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 17:15:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMWWW4MD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB46F207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6zm0-0008Eg-UU
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 13:15:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rohit.shinde12194@gmail.com>)
 id 1k6zlE-0007mZ-Cn
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 13:14:28 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:40988)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rohit.shinde12194@gmail.com>)
 id 1k6zlC-000220-Dt
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 13:14:28 -0400
Received: by mail-pg1-x542.google.com with SMTP id s15so5999457pgc.8
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2020 10:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+zjJEW76GFXrK6U2q/vJE64GK4mCTpYjSjiBB706RAk=;
 b=YMWWW4MDLYzvEBN8lNbCIR+jk+J8Q5TGfRiRH3dNiT8iRhvrrfMzCd1Ykgl+/UkPN/
 MuMP0vZJ+QbC0e/ykIPRlGeBbmmYkxpXLaRFKoygrOUx3RFROyujBlVLLk23UoCUmMjT
 /dK8K2Vk0O3YZUcSGkDdHKkE41aplM+n7qqNj/SCi1gBEknqkJVcUClk6P8t8ebYdHvT
 RFJdDnyDY9RG2H+GdMSnIJWxzdWMNlFghiaxs/LLQWvhrHHUDFFChmhUsm99kWjjzpYV
 7sR88QYAjmQarmqAb0wByPTzTwxH94VrO8S+kH3oWwdfIYF1wqGtidt49beRrAxV6HHQ
 ovEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+zjJEW76GFXrK6U2q/vJE64GK4mCTpYjSjiBB706RAk=;
 b=JvkurbnCE0LCt+VFlmhIK86SdLTNHXpODreo9a/vxkWgScSmoZK9lDkIotEJh6it7Q
 IXYtbEwyktFH4u+bTJ6Nmb8u9dd4G8Yeg+lew/z7GgcqmWV2+wPjJMswJNKJlHT7qYov
 c27xesE/InX2/hp2xmHjX2WJB3DIpmjHXkPX9z40vs/JCItWRhNJxbuusMz+ZbXRc/6H
 2u/xuz2exI9xvKyuLAGCB2OuISSb+8JeyFtJAKPRDs+C4QGtJp+8GJEl9UBaO8XeQt4P
 7JxBjurIo9sG/Dk01/glS3qL8gmd+mYS+6hrIDw5vXy/qWrsTpmGuJfvGFKPhNy3VjTB
 nVtA==
X-Gm-Message-State: AOAM533TQIgb1KoVkdWJc0MyFt1cuWYLTGWFm+Ep6vuw6Osaooe33/Qv
 Atgzcwb/jYOBVvRG2UabyVear515NMbo5bIpkBg=
X-Google-Smtp-Source: ABdhPJwUePYmmm9uFt6LdDc9rZ7N394efinTzr6AKys80Cs/zCWNmMKAtXHc+z+7rwYQ09OrP3Gtq9jz466tHRW9QUw=
X-Received: by 2002:a62:17c1:: with SMTP id 184mr5671263pfx.136.1597511664554; 
 Sat, 15 Aug 2020 10:14:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200815130046.5344-1-rohit.shinde12194@gmail.com>
 <d915c2a8-deba-1d88-d7d8-d16b8dcaf6d4@amsat.org>
In-Reply-To: <d915c2a8-deba-1d88-d7d8-d16b8dcaf6d4@amsat.org>
From: Rohit Shinde <rohit.shinde12194@gmail.com>
Date: Sat, 15 Aug 2020 13:14:13 -0400
Message-ID: <CA+Ai=tBw1bKJjHMLS=wbh2_WEU04TWPJohRxTggUV2k3gnb6gw@mail.gmail.com>
Subject: Re: [PATCH] Fixes: Fallthrough warning on line 270 of
 qemu/qapi/opts-visitor.c
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="0000000000004a575d05acedabef"
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=rohit.shinde12194@gmail.com; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000004a575d05acedabef
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Philippe,

Thanks for the detailed comments! I have a couple of questions.


   1. I'll modify the patch to just include a fallthrough comment instead
   of an attribute. How do I include the v4 version number in the patch? Do=
 I
   erase the last commit on my branch or fork from the master and start the
   work again and label it as v4?
   2. I am trying to find some issues of interest, starting through which I
   can go to bigger contributions. Do you have any suggestions on how I mig=
ht
   do that? For now, I am trying to tackle the bite sized issues to find my
   way around the code base. I would like to move to substantial contributi=
ons.
   3. I have a background in CS theory, but its been 2 years since I
   graduated from my Master's so I am a bit rusty on some stuff. How much C=
S
   theory (like compilers and OS) do I need to know if I want to contribute=
?


Thanks,
Rohit.

On Sat, Aug 15, 2020 at 11:24 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg>
wrote:

> Hi Rohit,
>
> Congratulation for your first patch! It is in very
> good shape already :)
>
> It is easier for the reviewers if you start the patch subject with
> the name of the subsystem concerned, or the file modified:
>
> "qapi/opts-visitor: Add missing fallthrough annotations"
>
> On 8/15/20 3:00 PM, Rohit Shinde wrote:
> > Added the fallthrough comment so that the compiler doesn't emit an erro=
r
> on compiling with the -Wimplicit-fallthrough flag.
>
> If possible align the description to 72 chars.
>
> >
> > Signed off by: Rohit Shinde
>
> The tag is written "Signed-off-by" with '-', then your "name <email>":
>
> Signed-off-by: Rohit Shinde <rohit.shinde12194@gmail.com>
>
> If you configure your git client, using 'git-commit -s' will
> automatically add the S-o-b tag:
>
> $ git config user.name "Rohit Shinde"
> $ git config user.email "rohit.shinde12194@gmail.com"
> $ git commit -s
>
> > ---
> >  qapi/opts-visitor.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/qapi/opts-visitor.c b/qapi/opts-visitor.c
> > index 7781c23a42..43cf60d3a0 100644
> > --- a/qapi/opts-visitor.c
> > +++ b/qapi/opts-visitor.c
> > @@ -266,6 +266,7 @@ opts_next_list(Visitor *v, GenericList *tail, size_=
t
> size)
> >          }
> >          ov->list_mode =3D LM_IN_PROGRESS;
> >          /* range has been completed, fall through in order to pop
> option */
> > +        __attribute__((fallthrough));
>
> C uses attributes when declaring a type/variable/function.
> Here this is inside a function body, not a declaration.
> A simple "/* fallthrough */" comment will make the compiler happy.
> You can see a similar patch for example:
>
> https://git.qemu.org/?p=3Dqemu.git;a=3Dblobdiff;f=3Ddisas/sh4.c;h=3Ddcdbd=
f26d8;hp=3D55ef865a3;hb=3Dccb237090f;hpb=3D7aa12aa215
>
> When you find an issue that might have already been fixed elsewhere
> in the repository, 'git-log -p' is your friend. Since the commits are
> patches already accepted/merged, they might be a good source to learn
> (how the issue was fixed, how the bug was described, ...).


> Regards,
>
> Phil.
>
> >
> >      case LM_IN_PROGRESS: {
> >          const QemuOpt *opt;
> >
>
>

--0000000000004a575d05acedabef
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hey Philippe,<div><br></div><div>Thanks f=
or the detailed comments! I have a couple of questions.</div><div><br></div=
><div><ol><li>I&#39;ll modify the patch to just include a fallthrough comme=
nt instead of an attribute. How do I include the v4 version number in the p=
atch? Do I erase the last commit on my branch or fork from the master and s=
tart the work again and label it as v4?</li><li>I am trying to find some is=
sues of interest, starting through which I can go to bigger contributions. =
Do you have any suggestions on how I might do that? For now, I am trying to=
 tackle the bite sized issues to find my way around the code base. I would =
like to move to substantial contributions.</li><li>I have a background in C=
S theory, but its been 2 years since I graduated from my Master&#39;s so I =
am a bit rusty on some stuff. How much CS theory (like compilers and OS) do=
 I need to know if I want to contribute?</li></ol><div><br></div><div>Thank=
s,</div><div>Rohit.</div></div></div><br><div class=3D"gmail_quote"><div di=
r=3D"ltr" class=3D"gmail_attr">On Sat, Aug 15, 2020 at 11:24 AM Philippe Ma=
thieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.org">f4bug@amsat.org</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi R=
ohit,<br>
<br>
Congratulation for your first patch! It is in very<br>
good shape already :)<br>
<br>
It is easier for the reviewers if you start the patch subject with<br>
the name of the subsystem concerned, or the file modified:<br>
<br>
&quot;qapi/opts-visitor: Add missing fallthrough annotations&quot;<br>
<br>
On 8/15/20 3:00 PM, Rohit Shinde wrote:<br>
&gt; Added the fallthrough comment so that the compiler doesn&#39;t emit an=
 error on compiling with the -Wimplicit-fallthrough flag.<br>
<br>
If possible align the description to 72 chars.<br>
<br>
&gt; <br>
&gt; Signed off by: Rohit Shinde<br>
<br>
The tag is written &quot;Signed-off-by&quot; with &#39;-&#39;, then your &q=
uot;name &lt;email&gt;&quot;:<br>
<br>
Signed-off-by: Rohit Shinde &lt;<a href=3D"mailto:rohit.shinde12194@gmail.c=
om" target=3D"_blank">rohit.shinde12194@gmail.com</a>&gt;<br>
<br>
If you configure your git client, using &#39;git-commit -s&#39; will<br>
automatically add the S-o-b tag:<br>
<br>
$ git config <a href=3D"http://user.name" rel=3D"noreferrer" target=3D"_bla=
nk">user.name</a> &quot;Rohit Shinde&quot;<br>
$ git config user.email &quot;<a href=3D"mailto:rohit.shinde12194@gmail.com=
" target=3D"_blank">rohit.shinde12194@gmail.com</a>&quot;<br>
$ git commit -s<br>
<br>
&gt; ---<br>
&gt;=C2=A0 qapi/opts-visitor.c | 1 +<br>
&gt;=C2=A0 1 file changed, 1 insertion(+)<br>
&gt; <br>
&gt; diff --git a/qapi/opts-visitor.c b/qapi/opts-visitor.c<br>
&gt; index 7781c23a42..43cf60d3a0 100644<br>
&gt; --- a/qapi/opts-visitor.c<br>
&gt; +++ b/qapi/opts-visitor.c<br>
&gt; @@ -266,6 +266,7 @@ opts_next_list(Visitor *v, GenericList *tail, size=
_t size)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ov-&gt;list_mode =3D LM_IN_PROGRESS;=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* range has been completed, fall th=
rough in order to pop option */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 __attribute__((fallthrough));<br>
<br>
C uses attributes when declaring a type/variable/function.<br>
Here this is inside a function body, not a declaration.<br>
A simple &quot;/* fallthrough */&quot; comment will make the compiler happy=
.<br>
You can see a similar patch for example:<br>
<a href=3D"https://git.qemu.org/?p=3Dqemu.git;a=3Dblobdiff;f=3Ddisas/sh4.c;=
h=3Ddcdbdf26d8;hp=3D55ef865a3;hb=3Dccb237090f;hpb=3D7aa12aa215" rel=3D"nore=
ferrer" target=3D"_blank">https://git.qemu.org/?p=3Dqemu.git;a=3Dblobdiff;f=
=3Ddisas/sh4.c;h=3Ddcdbdf26d8;hp=3D55ef865a3;hb=3Dccb237090f;hpb=3D7aa12aa2=
15</a><br>
<br>
When you find an issue that might have already been fixed elsewhere<br>
in the repository, &#39;git-log -p&#39; is your friend. Since the commits a=
re<br>
patches already accepted/merged, they might be a good source to learn<br>
(how the issue was fixed, how the bug was described, ...).=C2=A0</blockquot=
e><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Regards,<br>
<br>
Phil.<br>
<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 case LM_IN_PROGRESS: {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const QemuOpt *opt;<br>
&gt; <br>
<br>
</blockquote></div></div>

--0000000000004a575d05acedabef--

