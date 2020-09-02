Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD75C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 22:08:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C614C20767
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 22:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GR8GriRB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C614C20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDava-0000n4-Ta
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 18:08:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56498)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDav3-0000M4-ED; Wed, 02 Sep 2020 18:07:53 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:37229)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDav1-0004BC-Gn; Wed, 02 Sep 2020 18:07:53 -0400
Received: by mail-lj1-x244.google.com with SMTP id w14so1051106ljj.4;
 Wed, 02 Sep 2020 15:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=1uY1eMqGj6p/ib8rcdiGL3bg8mhpmrAj6tvF2fAi4M0=;
 b=GR8GriRBBQ2JEUWLWQlsqxncFr9xuhHdzCHjon5ITg2p+sFruSvv4zxYglkDTxS1jd
 7dJgA0jT3KU4jAq5l2m1zPOV5+7UM66VHqCH6w6YlVIQxbrE0uNKt9ariReCEbwwnY3D
 A4lEahzpcCMTO0aAXGVzmW0I6sCia2D3lslJQSgHy9dO8Q2ttwhU0LL2FX9X3PK9AZWz
 DwTu0XPONWl1+px/jvVKPK3bp2lgAKg/mUCVgUJBfUtPpea9wnemenMl/z8ayxPYnpSv
 a1UXlWHtjrNmJZ4uvMDqXFZGeWdpuy28bBFEWw/S87mFwme5cd+3ihkoylEDSQb3encu
 GMYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=1uY1eMqGj6p/ib8rcdiGL3bg8mhpmrAj6tvF2fAi4M0=;
 b=oWHpCxjEUnKS0DJXRgJxx+UJfgQ3EoolBNUeS7BD4CJA914pKwRFRXhKMcM4OlfdCj
 p6ySLc3MxWTytTvKTE9MhWz70B2Kq8NhUaEEKf9E7EISaWAxjkEApkzsNIcBN1Q+//T5
 0XOmEmRNfF45KUJd7wYpcLuJmVjYHAQuwNNsT71GLlQy+RM2003ZkzGkEU+X8toSxDFk
 08WBsY6b8L0KlxO6qnnnVrH+X5JIWcNpgH6S0aOyleWc/bkrAabpmii94Z640RRCbvFQ
 Kgpc+xh+c/vN9scxw+zpVdeaJIArB6TOpR0z7pxssWRb654OPxganM35qQoBLevtmlNW
 l8xg==
X-Gm-Message-State: AOAM531XiwXomdyIVHaM6k3KIH8uiWmBkeSzLUkMuqh+EGp5VDhGITAu
 WvNtl2ADhYehYtZQmNVSkmjYTMyM0rDhL0jIHE4=
X-Google-Smtp-Source: ABdhPJzF/axP2gNfd0JQVNJ4VbREmnvsj9ElScagqGchiwvcDsz0XpzsaEXaa0m/wRwTmazJIJf0SvXobdPy0Lc7U5k=
X-Received: by 2002:a05:651c:1119:: with SMTP id
 d25mr6523ljo.300.1599084469274; 
 Wed, 02 Sep 2020 15:07:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200825103850.119911-1-berrange@redhat.com>
 <20200825103850.119911-4-berrange@redhat.com>
In-Reply-To: <20200825103850.119911-4-berrange@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Thu, 3 Sep 2020 06:07:36 +0800
Message-ID: <CAE2XoE_8E0gYBnPn9GtB94zQ4Rr+ihOi1gvw4mvnNj5CRxv6DA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] nbd: disable signals and forking on Windows builds
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000c1ce1005ae5bdd43"
Received-SPF: pass client-ip=2a00:1450:4864:20::244;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x244.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-level <qemu-devel@nongnu.org>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000c1ce1005ae5bdd43
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2020 at 6:40 PM Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m>
wrote:

> Disabling these parts are sufficient to get the qemu-nbd program
> compiling in a Windows build.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  meson.build | 7 ++-----
>  qemu-nbd.c  | 5 +++++
>  2 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/meson.build b/meson.build
> index df5bf728b5..1071871605 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1074,12 +1074,9 @@ if have_tools
>               dependencies: [authz, block, crypto, io, qom, qemuutil],
> install: true)
>    qemu_io =3D executable('qemu-io', files('qemu-io.c'),
>               dependencies: [block, qemuutil], install: true)
> -  qemu_block_tools +=3D [qemu_img, qemu_io]
> -  if targetos =3D=3D 'linux' or targetos =3D=3D 'sunos' or
> targetos.endswith('bsd')
> -    qemu_nbd =3D executable('qemu-nbd', files('qemu-nbd.c'),
> +  qemu_nbd =3D executable('qemu-nbd', files('qemu-nbd.c'),
>                 dependencies: [block, qemuutil], install: true)
> -    qemu_block_tools +=3D [qemu_nbd]
> -  endif
> +  qemu_block_tools +=3D [qemu_img, qemu_io, qemu_nbd]
>
>    subdir('storage-daemon')
>    subdir('contrib/rdmacm-mux')
> diff --git a/qemu-nbd.c b/qemu-nbd.c
> index dc6ef089af..33476a1000 100644
> --- a/qemu-nbd.c
> +++ b/qemu-nbd.c
> @@ -899,6 +899,7 @@ int main(int argc, char **argv)
>  #endif
>
>      if ((device && !verbose) || fork_process) {
> +#ifndef WIN32
>          int stderr_fd[2];
>          pid_t pid;
>          int ret;
> @@ -962,6 +963,10 @@ int main(int argc, char **argv)
>               */
>              exit(errors);
>          }
> +#else /* WIN32 */
> +        error_report("Unable to fork into background on Windows hosts");
> +        exit(EXIT_FAILURE);
> +#endif /* WIN32 */
>      }
>
May us replace fork with alternative such as spawn?

>
>      if (device !=3D NULL && sockpath =3D=3D NULL) {
> --
> 2.26.2
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

--000000000000c1ce1005ae5bdd43
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 25, 2020 at 6:40 PM Danie=
l P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berrange@redh=
at.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">Disabling these parts are sufficient to get the qemu-nbd program<br>
compiling in a Windows build.<br>
<br>
Signed-off-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redha=
t.com" target=3D"_blank">berrange@redhat.com</a>&gt;<br>
---<br>
=C2=A0meson.build | 7 ++-----<br>
=C2=A0qemu-nbd.c=C2=A0 | 5 +++++<br>
=C2=A02 files changed, 7 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/meson.build b/meson.build<br>
index df5bf728b5..1071871605 100644<br>
--- a/meson.build<br>
+++ b/meson.build<br>
@@ -1074,12 +1074,9 @@ if have_tools<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dependencies: [authz, bloc=
k, crypto, io, qom, qemuutil], install: true)<br>
=C2=A0 =C2=A0qemu_io =3D executable(&#39;qemu-io&#39;, files(&#39;qemu-io.c=
&#39;),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dependencies: [block, qemu=
util], install: true)<br>
-=C2=A0 qemu_block_tools +=3D [qemu_img, qemu_io]<br>
-=C2=A0 if targetos =3D=3D &#39;linux&#39; or targetos =3D=3D &#39;sunos&#3=
9; or targetos.endswith(&#39;bsd&#39;)<br>
-=C2=A0 =C2=A0 qemu_nbd =3D executable(&#39;qemu-nbd&#39;, files(&#39;qemu-=
nbd.c&#39;),<br>
+=C2=A0 qemu_nbd =3D executable(&#39;qemu-nbd&#39;, files(&#39;qemu-nbd.c&#=
39;),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dependencies: [bloc=
k, qemuutil], install: true)<br>
-=C2=A0 =C2=A0 qemu_block_tools +=3D [qemu_nbd]<br>
-=C2=A0 endif<br>
+=C2=A0 qemu_block_tools +=3D [qemu_img, qemu_io, qemu_nbd]<br>
<br>
=C2=A0 =C2=A0subdir(&#39;storage-daemon&#39;)<br>
=C2=A0 =C2=A0subdir(&#39;contrib/rdmacm-mux&#39;)<br>
diff --git a/qemu-nbd.c b/qemu-nbd.c<br>
index dc6ef089af..33476a1000 100644<br>
--- a/qemu-nbd.c<br>
+++ b/qemu-nbd.c<br>
@@ -899,6 +899,7 @@ int main(int argc, char **argv)<br>
=C2=A0#endif<br>
<br>
=C2=A0 =C2=A0 =C2=A0if ((device &amp;&amp; !verbose) || fork_process) {<br>
+#ifndef WIN32<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int stderr_fd[2];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pid_t pid;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
@@ -962,6 +963,10 @@ int main(int argc, char **argv)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(errors);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+#else /* WIN32 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Unable to fork into backgro=
und on Windows hosts&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(EXIT_FAILURE);<br>
+#endif /* WIN32 */<br>
=C2=A0 =C2=A0 =C2=A0}<br></blockquote><div>May us replace fork with alterna=
tive such as spawn?=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">
<br>
=C2=A0 =C2=A0 =C2=A0if (device !=3D NULL &amp;&amp; sockpath =3D=3D NULL) {=
<br>
-- <br>
2.26.2<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div>

--000000000000c1ce1005ae5bdd43--

