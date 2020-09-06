Return-Path: <SRS0=M8gQ=CP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4724EC433E2
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2020 12:14:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95F35208B3
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2020 12:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jSfNoq3i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95F35208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEtYr-0006O1-LK
	for qemu-devel@archiver.kernel.org; Sun, 06 Sep 2020 08:14:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kEtY6-0005fM-WF; Sun, 06 Sep 2020 08:13:35 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:35149)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kEtY5-0003mN-3t; Sun, 06 Sep 2020 08:13:34 -0400
Received: by mail-lf1-x141.google.com with SMTP id w11so6132606lfn.2;
 Sun, 06 Sep 2020 05:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=QmE07HEnFEaUCmfLTkTXOqhOMiLKNDOq45u3ckcXxhE=;
 b=jSfNoq3i7EePQd3yTutqjCDUW9rKoc8GbW6UnVVGjdF/C0LHZJFK13hPeC2rUBI5pH
 RPvNGRk84wPsz5K1XGyCVejaJOXLLaC1xivCI7t1BAAYoewbRrSslSQyIRZZ/bCU3p7z
 auwQpQ0bnNpli936v0sYljzvHncL79WlAPQ+HKTlF4VG+Wofl3UMh0Z7JOqgOkjiAgeQ
 e/eBXl6+6LDb9t2NrF85CXxlhltkWaJjVRvutekgB1kg5Jo4IUcyTApE6/8ulsiV39yu
 MB3dLZgAuX1+Kc1QFsVdhIVqFmYjrwcSUIgf0K1jtqMpjtHf8HTNIAjed8LEUTQytR5b
 Hf9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=QmE07HEnFEaUCmfLTkTXOqhOMiLKNDOq45u3ckcXxhE=;
 b=DeXk/CAtk3CnrMvL230xymr1pAi6ZyijVQ0Dq3HYLnKxA7yaKEDiuZSywfucDjNNLX
 Qh7FF0skgEkMoGpdpARaYIo+TutAMiqIjAyG8nECjexmmJSiNXFUgQZX/eT1UBIYbrnR
 L7pvz/uh6aXdvIiBl5P8tt2GyhtRkGG4D9m7FWwDc1lOZBpltyHvaQx3dZ7l1XVjc8xy
 Y3TCqDiM8EXJzWDlA9KAy9jlV1073VSQh1lwla8hCTgPlOZxHyPIgMlGjKjJj7t74u3u
 7xS4dV/oeLq+7kl0iq3O+6gR19kCp4v7MoSKoazNOCLz8Ex2nI6BnFjNkPjDLXApZxSS
 1g2A==
X-Gm-Message-State: AOAM533UFgZLpxPHED8hB5aquSocO59LYllhsoo06H/nj+zoJk52tZIT
 n33HUhJmf+iXbpRfmyuFm6Rb3uZ3Dq82OnDxVKA=
X-Google-Smtp-Source: ABdhPJzYofDZmJCu8zrVt7ZrKcnu7nEc+YHp1Muw0qP5lJ8TM4MM5FgR9Kv5ZVxnv5gyYnJkN0yasZCLH1mG6tJNhcQ=
X-Received: by 2002:a19:41c8:: with SMTP id o191mr8228099lfa.176.1599394410391; 
 Sun, 06 Sep 2020 05:13:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200905211038.904-1-luoyonggang@gmail.com>
 <20200905211038.904-2-luoyonggang@gmail.com>
 <5a0e9248-d2eb-a88e-4043-7104498cd804@weilnetz.de>
In-Reply-To: <5a0e9248-d2eb-a88e-4043-7104498cd804@weilnetz.de>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Sun, 6 Sep 2020 20:13:19 +0800
Message-ID: <CAE2XoE-MuBNOGU5T_H_vgWYA5sU+HBjrk3tBa-=zJzpekWQcqw@mail.gmail.com>
Subject: Re: [PATCH 1/2] tests: Trying fixes test-replication.c on msys2/mingw.
To: Stefan Weil <sw@weilnetz.de>
Content-Type: multipart/alternative; boundary="000000000000aff34005aea4078d"
Received-SPF: pass client-ip=2a00:1450:4864:20::141;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x141.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Block <qemu-block@nongnu.org>,
 Wen Congyang <wencongyang2@huawei.com>,
 Xie Changlong <xiechanglong.d@gmail.com>, qemu-level <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000aff34005aea4078d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 6, 2020 at 5:49 AM Stefan Weil <sw@weilnetz.de> wrote:

> Am 05.09.20 um 23:10 schrieb Yonggang Luo:
>
> > On Windows there is no path like /tmp/s_local_disk.XXXXXX
> >
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > ---
> >  tests/test-replication.c | 13 +++++++++----
> >  1 file changed, 9 insertions(+), 4 deletions(-)
> >
> > diff --git a/tests/test-replication.c b/tests/test-replication.c
> > index 9ab3666a90..3cf544a133 100644
> > --- a/tests/test-replication.c
> > +++ b/tests/test-replication.c
> > @@ -23,14 +23,14 @@
> >
> >  /* primary */
> >  #define P_ID "primary-id"
> > -static char p_local_disk[] =3D "/tmp/p_local_disk.XXXXXX";
> > +static char p_local_disk[PATH_MAX];
> >
> >  /* secondary */
> >  #define S_ID "secondary-id"
> >  #define S_LOCAL_DISK_ID "secondary-local-disk-id"
> > -static char s_local_disk[] =3D "/tmp/s_local_disk.XXXXXX";
> > -static char s_active_disk[] =3D "/tmp/s_active_disk.XXXXXX";
> > -static char s_hidden_disk[] =3D "/tmp/s_hidden_disk.XXXXXX";
> > +static char s_local_disk[PATH_MAX];
> > +static char s_active_disk[PATH_MAX];
> > +static char s_hidden_disk[PATH_MAX];
> >
> >  /* FIXME: steal from blockdev.c */
> >  QemuOptsList qemu_drive_opts =3D {
> > @@ -571,6 +571,11 @@ static void setup_sigabrt_handler(void)
> >  int main(int argc, char **argv)
> >  {
> >      int ret;
> > +    const char *tmpdir =3D g_get_tmp_dir();
> > +    sprintf(p_local_disk, "%s/p_local_disk.XXXXXX", tmpdir);
> > +    sprintf(s_local_disk, "%s/s_local_disk.XXXXXX", tmpdir);
> > +    sprintf(s_active_disk, "%s/s_active_disk.XXXXXX", tmpdir);
> > +    sprintf(s_hidden_disk, "%s/s_hidden_disk.XXXXXX", tmpdir);
> >      qemu_init_main_loop(&error_fatal);
> >      bdrv_init();
> >
>
>
> Maybe it is possible to use get_tmp_filename() (which could be
> simplified by using g_get_tmp_dir).
>
What  does get_tmp_filename mean? I didn't understand

>
> And please use snprintf instead of sprintf. I am afraid that a path can
> be longer than PATH_MAX, even if the tmpdir path is normally rather short=
.
>
 OK, I'll use  snprintf

>
> You could also allocate the different filenames dynamically instead of
> limiting them to PATH_MAX characters.
>
as a test, it's too complicated,

>
> Regards
>
> Stefan Weil
>
>
>

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000aff34005aea4078d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sun, Sep 6, 2020 at 5:49 AM Stefan=
 Weil &lt;<a href=3D"mailto:sw@weilnetz.de">sw@weilnetz.de</a>&gt; wrote:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">Am 05.09.20 um 23=
:10 schrieb Yonggang Luo:<br>
<br>
&gt; On Windows there is no path like /tmp/s_local_disk.XXXXXX<br>
&gt;<br>
&gt; Signed-off-by: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.co=
m" target=3D"_blank">luoyonggang@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 tests/test-replication.c | 13 +++++++++----<br>
&gt;=C2=A0 1 file changed, 9 insertions(+), 4 deletions(-)<br>
&gt;<br>
&gt; diff --git a/tests/test-replication.c b/tests/test-replication.c<br>
&gt; index 9ab3666a90..3cf544a133 100644<br>
&gt; --- a/tests/test-replication.c<br>
&gt; +++ b/tests/test-replication.c<br>
&gt; @@ -23,14 +23,14 @@<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 /* primary */<br>
&gt;=C2=A0 #define P_ID &quot;primary-id&quot;<br>
&gt; -static char p_local_disk[] =3D &quot;/tmp/p_local_disk.XXXXXX&quot;;<=
br>
&gt; +static char p_local_disk[PATH_MAX];<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 /* secondary */<br>
&gt;=C2=A0 #define S_ID &quot;secondary-id&quot;<br>
&gt;=C2=A0 #define S_LOCAL_DISK_ID &quot;secondary-local-disk-id&quot;<br>
&gt; -static char s_local_disk[] =3D &quot;/tmp/s_local_disk.XXXXXX&quot;;<=
br>
&gt; -static char s_active_disk[] =3D &quot;/tmp/s_active_disk.XXXXXX&quot;=
;<br>
&gt; -static char s_hidden_disk[] =3D &quot;/tmp/s_hidden_disk.XXXXXX&quot;=
;<br>
&gt; +static char s_local_disk[PATH_MAX];<br>
&gt; +static char s_active_disk[PATH_MAX];<br>
&gt; +static char s_hidden_disk[PATH_MAX];<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 /* FIXME: steal from blockdev.c */<br>
&gt;=C2=A0 QemuOptsList qemu_drive_opts =3D {<br>
&gt; @@ -571,6 +571,11 @@ static void setup_sigabrt_handler(void)<br>
&gt;=C2=A0 int main(int argc, char **argv)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int ret;<br>
&gt; +=C2=A0 =C2=A0 const char *tmpdir =3D g_get_tmp_dir();<br>
&gt; +=C2=A0 =C2=A0 sprintf(p_local_disk, &quot;%s/p_local_disk.XXXXXX&quot=
;, tmpdir);<br>
&gt; +=C2=A0 =C2=A0 sprintf(s_local_disk, &quot;%s/s_local_disk.XXXXXX&quot=
;, tmpdir);<br>
&gt; +=C2=A0 =C2=A0 sprintf(s_active_disk, &quot;%s/s_active_disk.XXXXXX&qu=
ot;, tmpdir);<br>
&gt; +=C2=A0 =C2=A0 sprintf(s_hidden_disk, &quot;%s/s_hidden_disk.XXXXXX&qu=
ot;, tmpdir);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 qemu_init_main_loop(&amp;error_fatal);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 bdrv_init();<br>
&gt;=C2=A0 <br>
<br>
<br>
Maybe it is possible to use get_tmp_filename() (which could be<br>
simplified by using g_get_tmp_dir).<br></blockquote><div>What=C2=A0 does ge=
t_tmp_filename mean? I didn&#39;t understand</div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">
<br>
And please use snprintf instead of sprintf. I am afraid that a path can<br>
be longer than PATH_MAX, even if the tmpdir path is normally rather short.<=
br></blockquote><div>=C2=A0OK, I&#39;ll use=C2=A0

snprintf=20

</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
You could also allocate the different filenames dynamically instead of<br>
limiting them to PATH_MAX characters.<br></blockquote><div>as a test, it&#3=
9;s too complicated,=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">
<br>
Regards<br>
<br>
Stefan Weil<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div>

--000000000000aff34005aea4078d--

