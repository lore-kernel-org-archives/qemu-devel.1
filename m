Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0292AC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 08:36:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AAD5207DE
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 08:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pahrvbRt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AAD5207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFvas-0005mo-EV
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 04:36:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39590)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFvZu-0004Se-8U; Wed, 09 Sep 2020 04:35:42 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:41562)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFvZr-0006XD-NF; Wed, 09 Sep 2020 04:35:41 -0400
Received: by mail-lj1-x241.google.com with SMTP id y4so2402089ljk.8;
 Wed, 09 Sep 2020 01:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=Y+HDabDD03r+hBJu+CowRJjOVR40J0Bx4f5f24XKDZk=;
 b=pahrvbRt+4Vx/3hDuNBWUTmSnoy3aLkSqv5eo6621b3tWZyNdh2b/8ufTLuwFajTm1
 iFXzaAzn/1DKHID9/C0nteo7A6B//qocBhxZfVieNELzC7nKQYIpzaNNguq428+f1UPN
 flxaCRf+evSFtlCmP/Kk6pJeLH0HuWSTnlTMCNRfAQwFqaZSN96erGnG4K4+6W8htFZG
 ze/dGXTzrJJN1hSNIfVB6ra/bxPaXailVrm87At/zzZsF5hAdINnlUB8TEpKQTcD+DNo
 v9P+FGhAotnVnqPq/cVU/dvx5ONqavHCRET1vfkSuOzE4lTbZsBBhmgoWR9RjuXSqMCS
 Xqxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=Y+HDabDD03r+hBJu+CowRJjOVR40J0Bx4f5f24XKDZk=;
 b=SxZ6iuKLys6UBxD3gLakOgGF8R6uZSBqNuPFZ/Eou/idpX++uoID1/N/d3FzelRepG
 qza1VOjEH1ubIRTBDV11P2pFrkrH9cSs8/8KduD9G50R4qoENQCnPdbcROJ6bEfwEYfY
 bTB7OWMSC+yZj6hCRGm0HGWODVNlLIen40U8zMog359LXXsBDCXgEgFU+r+E6T6lyaQ6
 SjNxzpJQYykdn+M01aslG+ffb9RlDc73Q3AatEETkbBU/r8BQlB6Wsv4TMJqFZMDAvsB
 JG2w9qfTUlYCISyv5GLua3exTYXyEEPCFV/ejFiSYhd5gIeU2aox1LBsVMF0m6XxtyYm
 ZEQQ==
X-Gm-Message-State: AOAM531zszcnpDDWVqbyQJKzu9ALeEpTcP18tBgEkRL/wDGzhiWH20fU
 lLsvH017+HJkBT/ygnyWt3+TinNdkMKjjroNlFA=
X-Google-Smtp-Source: ABdhPJwqvMJICGRPTrYz/wBc6MR2VMLm+y4SHV+9uzgrMpsu78S9zYtK1VQTG5Mnx3KBcelA6vtY7qHpZB0qpVDxUrA=
X-Received: by 2002:a2e:86d3:: with SMTP id n19mr1422062ljj.368.1599640537415; 
 Wed, 09 Sep 2020 01:35:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200908151052.713-1-luoyonggang@gmail.com>
 <20200908151052.713-2-luoyonggang@gmail.com>
 <20200909083001.GD12090@stefanha-x1.localdomain>
In-Reply-To: <20200909083001.GD12090@stefanha-x1.localdomain>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Wed, 9 Sep 2020 16:35:26 +0800
Message-ID: <CAE2XoE_AOYve+0uxRp4ki8nHERbvvTLVvJnzC-Oh7HFHDkr0xA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] logging: Fixes memory leak in test-logging.c
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000000043de05aedd56c9"
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Daniel Brodsky <dnbrdsky@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 qemu-level <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000000043de05aedd56c9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2020 at 4:30 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:

> On Tue, Sep 08, 2020 at 11:10:51PM +0800, Yonggang Luo wrote:
> > g_dir_make_tmp Returns the actual name used. This string should be
> > freed with g_free() when not needed any longer and is is in the GLib
> > file name encoding. In case of errors, NULL is returned and error will
> > be set. Use g_autofree to free it properly
> >
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > ---
> >  tests/test-logging.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tests/test-logging.c b/tests/test-logging.c
> > index 8a1161de1d..957f6c08cd 100644
> > --- a/tests/test-logging.c
> > +++ b/tests/test-logging.c
> > @@ -196,7 +196,7 @@ static void rmdir_full(gchar const *root)
> >
> >  int main(int argc, char **argv)
> >  {
> > -    gchar *tmp_path =3D g_dir_make_tmp("qemu-test-logging.XXXXXX", NUL=
L);
> > +    g_autofree gchar *tmp_path =3D
> g_dir_make_tmp("qemu-test-logging.XXXXXX", NULL);
> >      int rc;
> >
> >      g_test_init(&argc, &argv, NULL);
>
> I don't see the memory leak. There is a g_free(tmp_path) at the bottom
> of main().
>
> Did I miss something?
>
Oh, gocha, this issue fixed by someone else. So when I rebasing, something
are lost.
 I am intent replace the free with  g_autofree , should I update it? this
is not a fix anymore, just
a improve

>
> Stefan
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000000043de05aedd56c9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Sep 9, 2020 at 4:30 PM Stefan=
 Hajnoczi &lt;<a href=3D"mailto:stefanha@redhat.com">stefanha@redhat.com</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On =
Tue, Sep 08, 2020 at 11:10:51PM +0800, Yonggang Luo wrote:<br>
&gt; g_dir_make_tmp Returns the actual name used. This string should be<br>
&gt; freed with g_free() when not needed any longer and is is in the GLib<b=
r>
&gt; file name encoding. In case of errors, NULL is returned and error will=
<br>
&gt; be set. Use g_autofree to free it properly<br>
&gt; <br>
&gt; Signed-off-by: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.co=
m" target=3D"_blank">luoyonggang@gmail.com</a>&gt;<br>
&gt; Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@=
redhat.com" target=3D"_blank">philmd@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 tests/test-logging.c | 2 +-<br>
&gt;=C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/tests/test-logging.c b/tests/test-logging.c<br>
&gt; index 8a1161de1d..957f6c08cd 100644<br>
&gt; --- a/tests/test-logging.c<br>
&gt; +++ b/tests/test-logging.c<br>
&gt; @@ -196,7 +196,7 @@ static void rmdir_full(gchar const *root)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 int main(int argc, char **argv)<br>
&gt;=C2=A0 {<br>
&gt; -=C2=A0 =C2=A0 gchar *tmp_path =3D g_dir_make_tmp(&quot;qemu-test-logg=
ing.XXXXXX&quot;, NULL);<br>
&gt; +=C2=A0 =C2=A0 g_autofree gchar *tmp_path =3D g_dir_make_tmp(&quot;qem=
u-test-logging.XXXXXX&quot;, NULL);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int rc;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_test_init(&amp;argc, &amp;argv, NULL);<br>
<br>
I don&#39;t see the memory leak. There is a g_free(tmp_path) at the bottom<=
br>
of main().<br>
<br>
Did I miss something?<br></blockquote><div>Oh, gocha, this issue fixed by s=
omeone else. So when I rebasing, something are lost.</div><div>=C2=A0I am i=
ntent replace the free with=C2=A0

g_autofree , should I update it? this is not a fix anymore, just=C2=A0<br><=
/div><div>a improve</div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Stefan<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div>

--0000000000000043de05aedd56c9--

