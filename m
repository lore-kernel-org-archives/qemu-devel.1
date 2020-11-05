Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B1DC00A89
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 11:34:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB88B2083B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 11:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FRK3rPfO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB88B2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kadWw-0007Dr-MO
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 06:34:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34392)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kadVJ-0006Er-RX; Thu, 05 Nov 2020 06:32:33 -0500
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:41819)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kadVH-0001Cf-Hz; Thu, 05 Nov 2020 06:32:33 -0500
Received: by mail-lf1-x143.google.com with SMTP id 126so1780083lfi.8;
 Thu, 05 Nov 2020 03:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=FMB7cXJW+C6FuDYDCv8B0L3Qpa3D7BkJ2aEOqX+Xmy8=;
 b=FRK3rPfOIKN24nS3laP8nch8k65k5Vw7I2P/DsK3acoZhYJKf045BEjsfc/LI2wbJb
 8qOa5X3nfwqZAYCoknIzHAZCfSc20/y0hNSZv3O51n6W1Tytj4HBWL265CenOX06upSf
 7GRJ6d2VFz0yz+wC/5ULjfnnDi8nvWVmTA4Eb11gB72jdqBm5a34OhUKRuBHTy5BqG28
 gy/dOslm/mlZJ1vhgWAwY3VZ2pHR0Lt4/rSmd3svn8VBEHFoLiEBS5aQwH0WrSTUwEbu
 pLmrwrYNIT51SiDvceQeFU+PXGfBDFeQatzk+5zp5qN6MIaez9BxPOnvTXSTzTQ7dp86
 4CQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=FMB7cXJW+C6FuDYDCv8B0L3Qpa3D7BkJ2aEOqX+Xmy8=;
 b=Zss2GdTlBbmNVyjXyeEYswfM59mrhRqI3sJmST8VTj7W9DLxYWxmofe4stKZnWineM
 P0anqa/6ve0tQkiBL8y+MBvFvk3rL8S0D5FwB4J0sBrKPIRE0F135StO/J/6D0P1TY1U
 Dpp6r4VMIZr9pppqDP7mzh1ovPo7S4TQhA1h/JMF+DbDLRVKJ0ki/BPYc/+YpR1J2YXH
 qSuosfL0o0OMY6EcuXCTg+vVG9/ODArIFwoG00WxvI0A5yDO40217I2VgB3l9QW3FuPN
 NuOveRzBwUMV8nR8ZYRvUhJhwR5p334BpJhgM4OPYx7E3E3XLL0Lwi2xaAZUVPfDMMKG
 gyXQ==
X-Gm-Message-State: AOAM532dAl3G5XGaCiFjZ6/knScwAIVttfLdw3kzzks6G3jNbM8xs3S9
 xxSgy7LopGZXzz1XwXWscWS/Gyqqo2Ye1TrnQb4=
X-Google-Smtp-Source: ABdhPJybvwctCM9ELGIDXn3IoYddIB/Q6E4RkoVa+FZhpaDYLJEUwdCxVTW6cRZTe4xM5R63H7SBMAW5T4w/NxkiEw4=
X-Received: by 2002:ac2:54ab:: with SMTP id w11mr773495lfk.50.1604575948053;
 Thu, 05 Nov 2020 03:32:28 -0800 (PST)
MIME-Version: 1.0
References: <20201013001545.1958-1-luoyonggang@gmail.com>
 <20201013001545.1958-2-luoyonggang@gmail.com>
 <9582005a-1248-6a6b-060f-b0da597bc9c9@redhat.com>
In-Reply-To: <9582005a-1248-6a6b-060f-b0da597bc9c9@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Thu, 5 Nov 2020 19:32:17 +0800
Message-ID: <CAE2XoE_Mvtgnva3r6nMDq1P9D6iA9uUPP7sh20RLaC8zdYrTow@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] block: Fixes nfs compiling error on msys2/mingw
To: Max Reitz <mreitz@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000066213305b35a73a8"
Received-SPF: pass client-ip=2a00:1450:4864:20::143;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x143.google.com
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Kevin Wolf <kwolf@redhat.com>,
 Peter Lieven <pl@kamp.de>, qemu-level <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000066213305b35a73a8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2020 at 7:29 PM Max Reitz <mreitz@redhat.com> wrote:
>
> On 13.10.20 02:15, Yonggang Luo wrote:
> > These compiling errors are fixed:
> > ../block/nfs.c:27:10: fatal error: poll.h: No such file or directory
> >     27 | #include <poll.h>
> >        |          ^~~~~~~~
> > compilation terminated.
> >
> > ../block/nfs.c:63:5: error: unknown type name 'blkcnt_t'
> >     63 |     blkcnt_t st_blocks;
> >        |     ^~~~~~~~
> > ../block/nfs.c: In function 'nfs_client_open':
> > ../block/nfs.c:550:27: error: 'struct _stat64' has no member named
'st_blocks'
> >    550 |     client->st_blocks =3D st.st_blocks;
> >        |                           ^
> > ../block/nfs.c: In function 'nfs_get_allocated_file_size':
> > ../block/nfs.c:751:41: error: 'struct _stat64' has no member named
'st_blocks'
> >    751 |     return (task.ret < 0 ? task.ret : st.st_blocks * 512);
> >        |                                         ^
> > ../block/nfs.c: In function 'nfs_reopen_prepare':
> > ../block/nfs.c:805:31: error: 'struct _stat64' has no member named
'st_blocks'
> >    805 |         client->st_blocks =3D st.st_blocks;
> >        |                               ^
> > ../block/nfs.c: In function 'nfs_get_allocated_file_size':
> > ../block/nfs.c:752:1: error: control reaches end of non-void function
[-Werror=3Dreturn-type]
> >    752 | }
> >        | ^
> >
> > On msys2/mingw, there is no st_blocks in struct _stat64 yet, we disable
the usage of it
> > on msys2/mingw, and create a typedef long long blkcnt_t; for further
implementation
> >
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > ---
> >   block/nfs.c | 15 +++++++++++++++
> >   1 file changed, 15 insertions(+)
> >
> > diff --git a/block/nfs.c b/block/nfs.c
> > index f86e660374..cf8795fb49 100644
> > --- a/block/nfs.c
> > +++ b/block/nfs.c
>
> [...]
>
> > @@ -51,6 +53,10 @@
> >   #define QEMU_NFS_MAX_PAGECACHE_SIZE (8388608 / NFS_BLKSIZE)
> >   #define QEMU_NFS_MAX_DEBUG_LEVEL 2
> >
> > +#if defined(_WIN32)
> > +typedef long long blkcnt_t;
>
> This makes me uneasy.  Is there a guarantee that this type will never be
> defined in a mingw environment (which would then result in a new compile
> error)?
That's be sure, mingw is compat with msvcrt.dll, so  blkcnt_t  are always
not defined.

>
> Can=E2=80=99t we just give NFSClient.st_blocks a different type, i.e. uin=
t64_t?
>
> Apart from that, looks good to me.
>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--00000000000066213305b35a73a8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Thu, Nov 5, 2020 at 7:29 PM Max Reitz &lt;<a hr=
ef=3D"mailto:mreitz@redhat.com">mreitz@redhat.com</a>&gt; wrote:<br>&gt;<br=
>&gt; On 13.10.20 02:15, Yonggang Luo wrote:<br>&gt; &gt; These compiling e=
rrors are fixed:<br>&gt; &gt; ../block/nfs.c:27:10: fatal error: poll.h: No=
 such file or directory<br>&gt; &gt; =C2=A0 =C2=A0 27 | #include &lt;poll.h=
&gt;<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0^~~~~~~~<br>&gt; &gt; compilation terminated.<br>&gt; &gt;<br>&gt; &g=
t; ../block/nfs.c:63:5: error: unknown type name &#39;blkcnt_t&#39;<br>&gt;=
 &gt; =C2=A0 =C2=A0 63 | =C2=A0 =C2=A0 blkcnt_t st_blocks;<br>&gt; &gt; =C2=
=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A0 ^~~~~~~~<br>&gt; &gt; ../block/nfs.=
c: In function &#39;nfs_client_open&#39;:<br>&gt; &gt; ../block/nfs.c:550:2=
7: error: &#39;struct _stat64&#39; has no member named &#39;st_blocks&#39;<=
br>&gt; &gt; =C2=A0 =C2=A0550 | =C2=A0 =C2=A0 client-&gt;st_blocks =3D st.s=
t_blocks;<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^<br>=
&gt; &gt; ../block/nfs.c: In function &#39;nfs_get_allocated_file_size&#39;=
:<br>&gt; &gt; ../block/nfs.c:751:41: error: &#39;struct _stat64&#39; has n=
o member named &#39;st_blocks&#39;<br>&gt; &gt; =C2=A0 =C2=A0751 | =C2=A0 =
=C2=A0 return (task.ret &lt; 0 ? task.ret : st.st_blocks * 512);<br>&gt; &g=
t; =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 ^<br>&gt; &gt; ../block/nfs.c: In function &#39;nf=
s_reopen_prepare&#39;:<br>&gt; &gt; ../block/nfs.c:805:31: error: &#39;stru=
ct _stat64&#39; has no member named &#39;st_blocks&#39;<br>&gt; &gt; =C2=A0=
 =C2=A0805 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 client-&gt;st_blocks =3D st.st_blo=
cks;<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ^<br>&gt; &gt; ../block/nfs.c: In function &#39;nfs_get_allocated_file_=
size&#39;:<br>&gt; &gt; ../block/nfs.c:752:1: error: control reaches end of=
 non-void function [-Werror=3Dreturn-type]<br>&gt; &gt; =C2=A0 =C2=A0752 | =
}<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0| ^<br>&gt; &gt;<br>&gt; &gt; On =
msys2/mingw, there is no st_blocks in struct _stat64 yet, we disable the us=
age of it<br>&gt; &gt; on msys2/mingw, and create a typedef long long blkcn=
t_t; for further implementation<br>&gt; &gt;<br>&gt; &gt; Signed-off-by: Yo=
nggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.com">luoyonggang@gmail.c=
om</a>&gt;<br>&gt; &gt; ---<br>&gt; &gt; =C2=A0 block/nfs.c | 15 ++++++++++=
+++++<br>&gt; &gt; =C2=A0 1 file changed, 15 insertions(+)<br>&gt; &gt;<br>=
&gt; &gt; diff --git a/block/nfs.c b/block/nfs.c<br>&gt; &gt; index f86e660=
374..cf8795fb49 100644<br>&gt; &gt; --- a/block/nfs.c<br>&gt; &gt; +++ b/bl=
ock/nfs.c<br>&gt;<br>&gt; [...]<br>&gt;<br>&gt; &gt; @@ -51,6 +53,10 @@<br>=
&gt; &gt; =C2=A0 #define QEMU_NFS_MAX_PAGECACHE_SIZE (8388608 / NFS_BLKSIZE=
)<br>&gt; &gt; =C2=A0 #define QEMU_NFS_MAX_DEBUG_LEVEL 2<br>&gt; &gt; =C2=
=A0 <br>&gt; &gt; +#if defined(_WIN32)<br>&gt; &gt; +typedef long long blkc=
nt_t;<br>&gt;<br>&gt; This makes me uneasy.=C2=A0 Is there a guarantee that=
 this type will never be<br>&gt; defined in a mingw environment (which woul=
d then result in a new compile<br>&gt; error)?<div> That&#39;s be sure, min=
gw is compat with msvcrt.dll, so=C2=A0

blkcnt_t=C2=A0 are always not defined.</div><div><br>&gt;<br>&gt; Can=E2=80=
=99t we just give NFSClient.st_blocks a different type, i.e. uint64_t?<div>=
&gt;<br>&gt; Apart from that, looks good to me.<br>&gt;<br><br><br>--<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=
=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo<=
/div></div></div>

--00000000000066213305b35a73a8--

