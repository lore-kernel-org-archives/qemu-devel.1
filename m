Return-Path: <SRS0=twQi=CO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BCEC43461
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 03:12:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEF80206CA
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 03:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="igMfbuTv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEF80206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEOdD-0005RN-Sn
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 23:12:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56244)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kEOcd-00051C-Bw
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 23:12:11 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:45200)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kEOcb-0000uq-FB
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 23:12:11 -0400
Received: by mail-lj1-x243.google.com with SMTP id c2so10099509ljj.12
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 20:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=Tu1+6FWsVpRYf/gyVNE1BkrQWYGgKMHZfycvMU2BCds=;
 b=igMfbuTvNFKsdDYLTw2s6vH4M8GLy8Onl4WUBwbX3Rwg/TaSW/wKbiuejBuxIsl2Ps
 e3a+y72/Rgqse527F7MuwYuGrY01fbJZf8aWK8UJB+y5E8zwkkyHb+liWf6RF4kqr0Ft
 UPKKmvwfhSC3MSEC6zT6AFNxhWGUO4TY0mzOb9VG2NwZbOb5FiXXGInxQ83uPpLcaVBS
 V+EeoErCqdBvsGcsS70CTmHQbZmfEkz1mPygHadCT709eehmv34GXcDVHujljNn8b86U
 VNfOLJB86Q7mS7a369NCXzHEcaw5RObR9ktEKWyaQsAvBj8aNKseF89Rwf6r/pJi9j5e
 /Pcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=Tu1+6FWsVpRYf/gyVNE1BkrQWYGgKMHZfycvMU2BCds=;
 b=gW/ay+QgraGiQ7hzPYmmTZZGI1TPE2EzSGSyFhqJArcFLPbujpK+BPRAZmwjaw6b3S
 /AyJr0N/e/DTWVLFE1ITpSofucjYpwEuRvlfIGoum8I5QUs8mWPamAIkshwMUjIbY5xP
 3fT89zBSYmyOVDgohuP+elAQSjNqqptQd3dP27DUEvCFz9bsJUF1hGqXGcB8r4eERb5r
 DCdY2ArztCyY3gYR97wutVY7uoKYLaWTorWELLdW3BbZHuSCIAql9GOO+PjYD3YqDLek
 NYhZnPes+ng6cH6kqUPAVe3AdeI6zZhOHf+kro/99RDLawcdHuKpH6qNIrHh5fUHQ8MA
 KSYA==
X-Gm-Message-State: AOAM530MNeg/FNL92HBEEnYB1ubaUu01F8SjyhEBznBBuqFNKR54CzBh
 JACHPRYe/3ypWPjUhrj+H9hxpCpnK8+mDeT2+Dk=
X-Google-Smtp-Source: ABdhPJzxmfCSBJ465q1/QENl4iqIy+pHueH+pTsR42gAMN3NxPEps3fUaVInEFsGxsUqfODFrF1a0GStGIjK8K5X+40=
X-Received: by 2002:a2e:86d3:: with SMTP id n19mr5619465ljj.368.1599275526812; 
 Fri, 04 Sep 2020 20:12:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200903220655.1333-1-luoyonggang@gmail.com>
 <c11df65c-4503-d96d-3452-fe3ae1caca3a@redhat.com>
In-Reply-To: <c11df65c-4503-d96d-3452-fe3ae1caca3a@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Sat, 5 Sep 2020 11:11:54 +0800
Message-ID: <CAE2XoE_Gj2mp8qoqH97PMOHEEeA_HOKe3b7oN0YH=+RzEn0kMg@mail.gmail.com>
Subject: Re: [PATCH v2] tests: Trying fixes test-replication.c on msys2.
To: Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000ac78a605ae88597f"
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x243.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Xie Changlong <xiechanglong.d@gmail.com>, qemu-level <qemu-devel@nongnu.org>,
 Wen Congyang <wencongyang2@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000ac78a605ae88597f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2020 at 9:07 PM Thomas Huth <thuth@redhat.com> wrote:

> On 04/09/2020 00.06, Yonggang Luo wrote:
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > ---
> >  tests/test-replication.c | 17 +++++++++++++----
> >  1 file changed, 13 insertions(+), 4 deletions(-)
> >
> > diff --git a/tests/test-replication.c b/tests/test-replication.c
> > index 9ab3666a90..d0e06f8d77 100644
> > --- a/tests/test-replication.c
> > +++ b/tests/test-replication.c
> > @@ -23,14 +23,18 @@
> >
> >  /* primary */
> >  #define P_ID "primary-id"
> > -static char p_local_disk[] =3D "/tmp/p_local_disk.XXXXXX";
> > +#define P_LOCAL_DISK "%s/p_local_disk.XXXXXX"
> > +static char p_local_disk[PATH_MAX];
> >
> >  /* secondary */
> >  #define S_ID "secondary-id"
> >  #define S_LOCAL_DISK_ID "secondary-local-disk-id"
> > -static char s_local_disk[] =3D "/tmp/s_local_disk.XXXXXX";
> > -static char s_active_disk[] =3D "/tmp/s_active_disk.XXXXXX";
> > -static char s_hidden_disk[] =3D "/tmp/s_hidden_disk.XXXXXX";
> > +#define S_LOCAL_DISK "%s/s_local_disk.XXXXXX"
> > +static char s_local_disk[PATH_MAX];
> > +#define S_ACTIVE_DISK "%s/s_active_disk.XXXXXX"
> > +static char s_active_disk[PATH_MAX];
> > +#define S_HIDDEN_DISK "%s/s_hidden_disk.XXXXXX"
> > +static char s_hidden_disk[PATH_MAX];
> >
> >  /* FIXME: steal from blockdev.c */
> >  QemuOptsList qemu_drive_opts =3D {
> > @@ -571,7 +575,12 @@ static void setup_sigabrt_handler(void)
> >  int main(int argc, char **argv)
> >  {
> >      int ret;
> > +    const char *tmpdir =3D g_get_tmp_dir();
> >      qemu_init_main_loop(&error_fatal);
> > +    sprintf(p_local_disk, P_LOCAL_DISK, tmpdir);
> > +    sprintf(s_local_disk, S_LOCAL_DISK, tmpdir);
> > +    sprintf(s_active_disk, S_ACTIVE_DISK, tmpdir);
> > +    sprintf(s_hidden_disk, S_HIDDEN_DISK, tmpdir);
>
> Sounds like the right way to go, but I think I'd do it without the
> #defines and simply use the strings directly here, what do you think?
>
I place them at the same place by define is for easily readable, if I
directly place at sprintf,
then the code are harder to read

>
>  Thomas
>
>
> PS: Please use scripts/get_maintainer.pl (or the MAINTAINERS file
> directly) on your patches to find out the right maintainers that you
> should put on CC: for every patch.
>
>

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000ac78a605ae88597f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Sep 4, 2020 at 9:07 PM Thomas=
 Huth &lt;<a href=3D"mailto:thuth@redhat.com">thuth@redhat.com</a>&gt; wrot=
e:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 04/09/2020=
 00.06, Yonggang Luo wrote:<br>
&gt; Signed-off-by: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.co=
m" target=3D"_blank">luoyonggang@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 tests/test-replication.c | 17 +++++++++++++----<br>
&gt;=C2=A0 1 file changed, 13 insertions(+), 4 deletions(-)<br>
&gt; <br>
&gt; diff --git a/tests/test-replication.c b/tests/test-replication.c<br>
&gt; index 9ab3666a90..d0e06f8d77 100644<br>
&gt; --- a/tests/test-replication.c<br>
&gt; +++ b/tests/test-replication.c<br>
&gt; @@ -23,14 +23,18 @@<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 /* primary */<br>
&gt;=C2=A0 #define P_ID &quot;primary-id&quot;<br>
&gt; -static char p_local_disk[] =3D &quot;/tmp/p_local_disk.XXXXXX&quot;;<=
br>
&gt; +#define P_LOCAL_DISK &quot;%s/p_local_disk.XXXXXX&quot;<br>
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
&gt; +#define S_LOCAL_DISK &quot;%s/s_local_disk.XXXXXX&quot;<br>
&gt; +static char s_local_disk[PATH_MAX];<br>
&gt; +#define S_ACTIVE_DISK &quot;%s/s_active_disk.XXXXXX&quot;<br>
&gt; +static char s_active_disk[PATH_MAX];<br>
&gt; +#define S_HIDDEN_DISK &quot;%s/s_hidden_disk.XXXXXX&quot;<br>
&gt; +static char s_hidden_disk[PATH_MAX];<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 /* FIXME: steal from blockdev.c */<br>
&gt;=C2=A0 QemuOptsList qemu_drive_opts =3D {<br>
&gt; @@ -571,7 +575,12 @@ static void setup_sigabrt_handler(void)<br>
&gt;=C2=A0 int main(int argc, char **argv)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int ret;<br>
&gt; +=C2=A0 =C2=A0 const char *tmpdir =3D g_get_tmp_dir();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 qemu_init_main_loop(&amp;error_fatal);<br>
&gt; +=C2=A0 =C2=A0 sprintf(p_local_disk, P_LOCAL_DISK, tmpdir);<br>
&gt; +=C2=A0 =C2=A0 sprintf(s_local_disk, S_LOCAL_DISK, tmpdir);<br>
&gt; +=C2=A0 =C2=A0 sprintf(s_active_disk, S_ACTIVE_DISK, tmpdir);<br>
&gt; +=C2=A0 =C2=A0 sprintf(s_hidden_disk, S_HIDDEN_DISK, tmpdir);<br>
<br>
Sounds like the right way to go, but I think I&#39;d do it without the<br>
#defines and simply use the strings directly here, what do you think?<br></=
blockquote><div>I place them at the same place by define is for easily read=
able, if I directly place at sprintf,</div><div>then the code are harder to=
 read=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
=C2=A0Thomas<br>
<br>
<br>
PS: Please use scripts/<a href=3D"http://get_maintainer.pl" rel=3D"noreferr=
er" target=3D"_blank">get_maintainer.pl</a> (or the MAINTAINERS file<br>
directly) on your patches to find out the right maintainers that you<br>
should put on CC: for every patch.<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div>

--000000000000ac78a605ae88597f--

