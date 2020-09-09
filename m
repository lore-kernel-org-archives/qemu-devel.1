Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB41C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 13:02:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AC0721D7F
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 13:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvSgIY2Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AC0721D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFzkS-0004ly-FK
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 09:02:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFzhb-0001HA-6V; Wed, 09 Sep 2020 08:59:55 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:42727)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFzhZ-0001Qu-82; Wed, 09 Sep 2020 08:59:54 -0400
Received: by mail-lj1-x241.google.com with SMTP id k25so3371312ljg.9;
 Wed, 09 Sep 2020 05:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=VS0z2CEKU99TJPkqU2U+MHtQNhqfs59CfN0SIua7icI=;
 b=DvSgIY2YL+kwXs9tdHumd5V+qPHJCXTcrYJZDV9/v1TL2C6gDmL8DyWMBY/KWxNJQU
 QDeadHJQ2xfUCUe1cz6EhZ+oGwKfsRU2G+VQQoapvLCQ80UUq0KIPAC9LNmiP8KVdzN4
 MOHKYfMQdFjY5nJUYROFj0XF4zeH7HdXOYxoePwNsiX3hhAVy75pWdrOdUHrOO+WbI8u
 UQ3dGylA+sc+GFb1appYasV9uZunqYQPvF50LbFrEoTYBs8OTYMF8iKzck6TPfGl900i
 o9quU/IinKgCV2045muRN+/b8d/m4QlY3s1LOyMT/J/JyVquOGT8Op/qq3HxUgvLrwLf
 yrLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=VS0z2CEKU99TJPkqU2U+MHtQNhqfs59CfN0SIua7icI=;
 b=egLJw+qZfnPV5i6hFtIduwpkzfoxN36bd7jcgPGN+EeSI7LoV4HbL60WP02MTvbq3S
 zTVeKskI7LchTHzDgXkgHEYwIhdmLgeF9/nE9BSOfKktUyVLT06NE0qG4dhRym5CBpmG
 O3VnbmpE9E4d0RLxv4H+EYXjCczxw6HV4bc85a01mk2LTuPTKgr3egFqxCIdMBI36ba7
 ztf4Nc31KvPl2vGdJoLtoAGWbkU4S37P0KRuar0BGoSfhIUJNjfOVU2tyEiIaphFvKOg
 iFMZrgYZBaupoYqBbmgsemNn1epfoShR7gwpUeL7zTB44TnTKu39+B5uDd7PWjaMdpq3
 ZVrg==
X-Gm-Message-State: AOAM530/KCdIX3zRWmUTruME/cBqgYBZ/NxpqkMxO/FF0KhTlhQsWz/+
 F9GrZPOUjDGF6xBN9F3cBpfOd/UL/pF4n2V8PRA=
X-Google-Smtp-Source: ABdhPJylBbb857hd7Bog2q1Dbnm3NvjdIBf2a64j/f3jqpL6l18Zel/Ox0NwixxEXfZaSCdqDtpqMTamib4vbYnFqfM=
X-Received: by 2002:a2e:9dc7:: with SMTP id x7mr1987294ljj.447.1599656391012; 
 Wed, 09 Sep 2020 05:59:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200909094617.1582-1-luoyonggang@gmail.com>
 <20200909094617.1582-8-luoyonggang@gmail.com>
 <20200909125550.GY1011023@redhat.com>
In-Reply-To: <20200909125550.GY1011023@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Wed, 9 Sep 2020 20:59:40 +0800
Message-ID: <CAE2XoE9Ss89S=0w_0ukK-X5zL3YOYy4aXdRZsx3YUfkzynC0oQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/21] tests: Trying fixes test-replication.c on
 msys2/mingw.
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000f2f6ab05aee1062a"
Received-SPF: pass client-ip=2a00:1450:4864:20::241;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x241.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Qemu-block <qemu-block@nongnu.org>, Stefan Weil <sw@weilnetz.de>,
 Xie Changlong <xiechanglong.d@gmail.com>, Peter Lieven <pl@kamp.de>,
 qemu-level <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Max Reitz <mreitz@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000f2f6ab05aee1062a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2020 at 8:56 PM Daniel P. Berrang=C3=A9 <berrange@redhat.com=
>
wrote:

> On Wed, Sep 09, 2020 at 05:46:03PM +0800, Yonggang Luo wrote:
> > On Windows there is no path like /tmp/s_local_disk.XXXXXX
> > Use g_get_tmp_dir instead of /tmp.
> >
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > ---
> >  tests/test-replication.c | 18 ++++++++++++++----
> >  1 file changed, 14 insertions(+), 4 deletions(-)
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
>
> > @@ -571,6 +571,11 @@ static void setup_sigabrt_handler(void)
> >  int main(int argc, char **argv)
> >  {
> >      int ret;
> > +    const char *tmpdir =3D g_get_tmp_dir();
> > +    p_local_disk =3D g_strdup_printf("%s/p_local_disk.XXXXXX", tmpdir)=
;
> > +    s_local_disk =3D g_strdup_printf("%s/s_local_disk.XXXXXX", tmpdir)=
;
> > +    s_active_disk =3D g_strdup_printf("%s/s_active_disk.XXXXXX", tmpdi=
r);
> > +    s_hidden_disk =3D g_strdup_printf("%s/s_hidden_disk.XXXXXX", tmpdi=
r);
>
> I presume msys is taking care of translating "/" into "\" so that
> we don't need to use  g_build_filename to use the native directory
> separator straightaway ?
>
Not only msys2, but also win32 api can recoginize "/", so we doesn't need
to care about it

>
>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-
> https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-
> https://www.instagram.com/dberrange :|
>
>

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000f2f6ab05aee1062a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Sep 9, 2020 at 8:56 PM Daniel=
 P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berrange@redha=
t.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">On Wed, Sep 09, 2020 at 05:46:03PM +0800, Yonggang Luo wrote:<br>
&gt; On Windows there is no path like /tmp/s_local_disk.XXXXXX<br>
&gt; Use g_get_tmp_dir instead of /tmp.<br>
&gt; <br>
&gt; Signed-off-by: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.co=
m" target=3D"_blank">luoyonggang@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 tests/test-replication.c | 18 ++++++++++++++----<br>
&gt;=C2=A0 1 file changed, 14 insertions(+), 4 deletions(-)<br>
<br>
Reviewed-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.=
com" target=3D"_blank">berrange@redhat.com</a>&gt;<br>
<br>
<br>
&gt; @@ -571,6 +571,11 @@ static void setup_sigabrt_handler(void)<br>
&gt;=C2=A0 int main(int argc, char **argv)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int ret;<br>
&gt; +=C2=A0 =C2=A0 const char *tmpdir =3D g_get_tmp_dir();<br>
&gt; +=C2=A0 =C2=A0 p_local_disk =3D g_strdup_printf(&quot;%s/p_local_disk.=
XXXXXX&quot;, tmpdir);<br>
&gt; +=C2=A0 =C2=A0 s_local_disk =3D g_strdup_printf(&quot;%s/s_local_disk.=
XXXXXX&quot;, tmpdir);<br>
&gt; +=C2=A0 =C2=A0 s_active_disk =3D g_strdup_printf(&quot;%s/s_active_dis=
k.XXXXXX&quot;, tmpdir);<br>
&gt; +=C2=A0 =C2=A0 s_hidden_disk =3D g_strdup_printf(&quot;%s/s_hidden_dis=
k.XXXXXX&quot;, tmpdir);<br>
<br>
I presume msys is taking care of translating &quot;/&quot; into &quot;\&quo=
t; so that<br>
we don&#39;t need to use=C2=A0 g_build_filename to use the native directory=
<br>
separator straightaway ?<br></blockquote><div>Not only msys2, but also win3=
2 api can recoginize &quot;/&quot;, so we doesn&#39;t need to care about it=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
<br>
Regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D"http=
s://www.flickr.com/photos/dberrange" rel=3D"noreferrer" target=3D"_blank">h=
ttps://www.flickr.com/photos/dberrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer" target=3D"_blank">htt=
ps://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-o-=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://fstop138.berrange.com" rel=3D"n=
oreferrer" target=3D"_blank">https://fstop138.berrange.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer" target=3D"_bla=
nk">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D=
"https://www.instagram.com/dberrange" rel=3D"noreferrer" target=3D"_blank">=
https://www.instagram.com/dberrange</a> :|<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div>

--000000000000f2f6ab05aee1062a--

