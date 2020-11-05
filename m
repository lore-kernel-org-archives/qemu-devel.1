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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E917C00A89
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 11:47:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5ED22083B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 11:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pYWmTVem"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5ED22083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kadjm-0006Cz-Po
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 06:47:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36972)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kadj5-0005ZR-5K; Thu, 05 Nov 2020 06:46:47 -0500
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:33184)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kadj3-0006Lk-C8; Thu, 05 Nov 2020 06:46:46 -0500
Received: by mail-lj1-x241.google.com with SMTP id m8so1265396ljj.0;
 Thu, 05 Nov 2020 03:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=hs/RboAoZHJSsi7QV/j8Ot+OhvKMLiwqh+063gfBTHw=;
 b=pYWmTVempMy1ChcisSMcUT2JtIeI9b76fqTQBeh4bRSnNNwjbD2tWnPjm/cLv+CY9K
 kdh70fn5sTEIYv917zRbEyzOq1IW3rs1spD4+BQq1Waoj2FUOX88WdRP6eL462VSeWlf
 yzL4sqH15N+uWDF7zo45amTCwz4j3QoVIKi/FoF0q8i9quf/oauj33d3GAHc66GP55Ke
 XbVUhXCIq4ehsusPGctDiNl/7JqyRea0oHHlDtbcLL8j7Dn+b5OTZ4fRNy/a3+7GEuKD
 JH/dnhFs39u+8aCfyuJqCkeLMnVtIkI2GNb2Y2TQMmqh5qVslbJcUtPwNnUJVDfJalTN
 JK9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=hs/RboAoZHJSsi7QV/j8Ot+OhvKMLiwqh+063gfBTHw=;
 b=oYWL/I9HzOtat9vAr7jwt2nYI3ZtVkIouiMREKsVLs9Qils7R8lQSS3ss1a27Rd0L1
 9LijIQBModeHxBVoHX+rXMpzW1+zm0K45xUkHAikrI4v5FLgWHQdYQLwkqtRCEjx1Fst
 At8KhyNG7nCJyXnBm0lWxhrUSw0S2Qd0vOBMt2opkjQ85nsKq3Ctgh4Wv2dI1QJ2bSpF
 MylyEoZQT0gtKaVIqh82Jq1JJfj3eQ2H0gycudFM5lEcpD/VHsg9h55mUrwYl5Q/nDL8
 8jQ8K+dVuZM91NQNJtN6zQcJnhPzkwJBASVmananszTe6Yj4NpPy4DXfhkN0w4My/Abx
 XY2w==
X-Gm-Message-State: AOAM531jviHClwrii1cjxwxtoub9mSqbnKOsFdmCzFMFPQ7iNOF3cDgJ
 idgePDwO/mJbZ8Bba8F0SkF5ep7stDiRo222tuo=
X-Google-Smtp-Source: ABdhPJz1xeqYZs+1Ztm5Pz8sLXs0Zk+aaQptmP0swO6aTon32iMwVRxhZoPgxQRHBBVvNOku6BdXRqbHpBg1cNNkbrE=
X-Received: by 2002:a2e:9a17:: with SMTP id o23mr802128lji.242.1604576801802; 
 Thu, 05 Nov 2020 03:46:41 -0800 (PST)
MIME-Version: 1.0
References: <20201013001545.1958-1-luoyonggang@gmail.com>
 <20201013001545.1958-2-luoyonggang@gmail.com>
 <9582005a-1248-6a6b-060f-b0da597bc9c9@redhat.com>
 <CAE2XoE_Mvtgnva3r6nMDq1P9D6iA9uUPP7sh20RLaC8zdYrTow@mail.gmail.com>
 <d74223f4-fb3f-c83c-99e9-6d525501dee8@redhat.com>
In-Reply-To: <d74223f4-fb3f-c83c-99e9-6d525501dee8@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Thu, 5 Nov 2020 19:46:31 +0800
Message-ID: <CAE2XoE8sJgjGEDygHO9EjYpUEH_YjiOgUhpD2==hJZrie4quLA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] block: Fixes nfs compiling error on msys2/mingw
To: Max Reitz <mreitz@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000494ebf05b35aa63c"
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Kevin Wolf <kwolf@redhat.com>,
 Peter Lieven <pl@kamp.de>, qemu-level <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000494ebf05b35aa63c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2020 at 7:44 PM Max Reitz <mreitz@redhat.com> wrote:
>
> On 05.11.20 12:32, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:
> >
> >
> > On Thu, Nov 5, 2020 at 7:29 PM Max Reitz <mreitz@redhat.com
> > <mailto:mreitz@redhat.com>> wrote:
> >  >
> >  > On 13.10.20 02:15, Yonggang Luo wrote:
> >  > > These compiling errors are fixed:
> >  > > ../block/nfs.c:27:10: fatal error: poll.h: No such file or
directory
> >  > >     27 | #include <poll.h>
> >  > >        |          ^~~~~~~~
> >  > > compilation terminated.
> >  > >
> >  > > ../block/nfs.c:63:5: error: unknown type name 'blkcnt_t'
> >  > >     63 |     blkcnt_t st_blocks;
> >  > >        |     ^~~~~~~~
> >  > > ../block/nfs.c: In function 'nfs_client_open':
> >  > > ../block/nfs.c:550:27: error: 'struct _stat64' has no member named
> > 'st_blocks'
> >  > >    550 |     client->st_blocks =3D st.st_blocks;
> >  > >        |                           ^
> >  > > ../block/nfs.c: In function 'nfs_get_allocated_file_size':
> >  > > ../block/nfs.c:751:41: error: 'struct _stat64' has no member named
> > 'st_blocks'
> >  > >    751 |     return (task.ret < 0 ? task.ret : st.st_blocks * 512)=
;
> >  > >        |                                         ^
> >  > > ../block/nfs.c: In function 'nfs_reopen_prepare':
> >  > > ../block/nfs.c:805:31: error: 'struct _stat64' has no member named
> > 'st_blocks'
> >  > >    805 |         client->st_blocks =3D st.st_blocks;
> >  > >        |                               ^
> >  > > ../block/nfs.c: In function 'nfs_get_allocated_file_size':
> >  > > ../block/nfs.c:752:1: error: control reaches end of non-void
> > function [-Werror=3Dreturn-type]
> >  > >    752 | }
> >  > >        | ^
> >  > >
> >  > > On msys2/mingw, there is no st_blocks in struct _stat64 yet, we
> > disable the usage of it
> >  > > on msys2/mingw, and create a typedef long long blkcnt_t; for
> > further implementation
> >  > >
> >  > > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com
> > <mailto:luoyonggang@gmail.com>>
> >  > > ---
> >  > >   block/nfs.c | 15 +++++++++++++++
> >  > >   1 file changed, 15 insertions(+)
> >  > >
> >  > > diff --git a/block/nfs.c b/block/nfs.c
> >  > > index f86e660374..cf8795fb49 100644
> >  > > --- a/block/nfs.c
> >  > > +++ b/block/nfs.c
> >  >
> >  > [...]
> >  >
> >  > > @@ -51,6 +53,10 @@
> >  > >   #define QEMU_NFS_MAX_PAGECACHE_SIZE (8388608 / NFS_BLKSIZE)
> >  > >   #define QEMU_NFS_MAX_DEBUG_LEVEL 2
> >  > >
> >  > > +#if defined(_WIN32)
> >  > > +typedef long long blkcnt_t;
> >  >
> >  > This makes me uneasy.  Is there a guarantee that this type will
never be
> >  > defined in a mingw environment (which would then result in a new
compile
> >  > error)?
> > That's be sure, mingw is compat with msvcrt.dll, so blkcnt_t  are alway=
s
> > not defined.
>
> And there is no possibility of that being added in the future?
If that's the case, what's the better option.
>
> Max
>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000494ebf05b35aa63c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Thu, Nov 5, 2020 at 7:44 PM Max Reitz &lt;<a hr=
ef=3D"mailto:mreitz@redhat.com">mreitz@redhat.com</a>&gt; wrote:<br>&gt;<br=
>&gt; On 05.11.20 12:32, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:<b=
r>&gt; &gt;<br>&gt; &gt;<br>&gt; &gt; On Thu, Nov 5, 2020 at 7:29 PM Max Re=
itz &lt;<a href=3D"mailto:mreitz@redhat.com">mreitz@redhat.com</a><br>&gt; =
&gt; &lt;mailto:<a href=3D"mailto:mreitz@redhat.com">mreitz@redhat.com</a>&=
gt;&gt; wrote:<br>&gt; &gt; =C2=A0&gt;<br>&gt; &gt; =C2=A0&gt; On 13.10.20 =
02:15, Yonggang Luo wrote:<br>&gt; &gt; =C2=A0&gt; &gt; These compiling err=
ors are fixed:<br>&gt; &gt; =C2=A0&gt; &gt; ../block/nfs.c:27:10: fatal err=
or: poll.h: No such file or directory<br>&gt; &gt; =C2=A0&gt; &gt; =C2=A0 =
=C2=A0 27 | #include &lt;poll.h&gt;<br>&gt; &gt; =C2=A0&gt; &gt; =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~~~<br>&gt; &gt; =
=C2=A0&gt; &gt; compilation terminated.<br>&gt; &gt; =C2=A0&gt; &gt;<br>&gt=
; &gt; =C2=A0&gt; &gt; ../block/nfs.c:63:5: error: unknown type name &#39;b=
lkcnt_t&#39;<br>&gt; &gt; =C2=A0&gt; &gt; =C2=A0 =C2=A0 63 | =C2=A0 =C2=A0 =
blkcnt_t st_blocks;<br>&gt; &gt; =C2=A0&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| =C2=A0 =C2=A0 ^~~~~~~~<br>&gt; &gt; =C2=A0&gt; &gt; ../block/nfs.c: In=
 function &#39;nfs_client_open&#39;:<br>&gt; &gt; =C2=A0&gt; &gt; ../block/=
nfs.c:550:27: error: &#39;struct _stat64&#39; has no member named<br>&gt; &=
gt; &#39;st_blocks&#39;<br>&gt; &gt; =C2=A0&gt; &gt; =C2=A0 =C2=A0550 | =C2=
=A0 =C2=A0 client-&gt;st_blocks =3D st.st_blocks;<br>&gt; &gt; =C2=A0&gt; &=
gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^<br>&gt; &gt; =C2=A0&gt; =
&gt; ../block/nfs.c: In function &#39;nfs_get_allocated_file_size&#39;:<br>=
&gt; &gt; =C2=A0&gt; &gt; ../block/nfs.c:751:41: error: &#39;struct _stat64=
&#39; has no member named<br>&gt; &gt; &#39;st_blocks&#39;<br>&gt; &gt; =C2=
=A0&gt; &gt; =C2=A0 =C2=A0751 | =C2=A0 =C2=A0 return (task.ret &lt; 0 ? tas=
k.ret : st.st_blocks * 512);<br>&gt; &gt; =C2=A0&gt; &gt; =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ^<br>&gt; &gt; =C2=A0&gt; &gt; ../block/nfs.c: In function &#39;nfs_reo=
pen_prepare&#39;:<br>&gt; &gt; =C2=A0&gt; &gt; ../block/nfs.c:805:31: error=
: &#39;struct _stat64&#39; has no member named<br>&gt; &gt; &#39;st_blocks&=
#39;<br>&gt; &gt; =C2=A0&gt; &gt; =C2=A0 =C2=A0805 | =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 client-&gt;st_blocks =3D st.st_blocks;<br>&gt; &gt; =C2=A0&gt; &gt; =
=C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^<br>&gt; &gt; =
=C2=A0&gt; &gt; ../block/nfs.c: In function &#39;nfs_get_allocated_file_siz=
e&#39;:<br>&gt; &gt; =C2=A0&gt; &gt; ../block/nfs.c:752:1: error: control r=
eaches end of non-void<br>&gt; &gt; function [-Werror=3Dreturn-type]<br>&gt=
; &gt; =C2=A0&gt; &gt; =C2=A0 =C2=A0752 | }<br>&gt; &gt; =C2=A0&gt; &gt; =
=C2=A0 =C2=A0 =C2=A0 =C2=A0| ^<br>&gt; &gt; =C2=A0&gt; &gt;<br>&gt; &gt; =
=C2=A0&gt; &gt; On msys2/mingw, there is no st_blocks in struct _stat64 yet=
, we<br>&gt; &gt; disable the usage of it<br>&gt; &gt; =C2=A0&gt; &gt; on m=
sys2/mingw, and create a typedef long long blkcnt_t; for<br>&gt; &gt; furth=
er implementation<br>&gt; &gt; =C2=A0&gt; &gt;<br>&gt; &gt; =C2=A0&gt; &gt;=
 Signed-off-by: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.com">l=
uoyonggang@gmail.com</a><br>&gt; &gt; &lt;mailto:<a href=3D"mailto:luoyongg=
ang@gmail.com">luoyonggang@gmail.com</a>&gt;&gt;<br>&gt; &gt; =C2=A0&gt; &g=
t; ---<br>&gt; &gt; =C2=A0&gt; &gt; =C2=A0 block/nfs.c | 15 +++++++++++++++=
<br>&gt; &gt; =C2=A0&gt; &gt; =C2=A0 1 file changed, 15 insertions(+)<br>&g=
t; &gt; =C2=A0&gt; &gt;<br>&gt; &gt; =C2=A0&gt; &gt; diff --git a/block/nfs=
.c b/block/nfs.c<br>&gt; &gt; =C2=A0&gt; &gt; index f86e660374..cf8795fb49 =
100644<br>&gt; &gt; =C2=A0&gt; &gt; --- a/block/nfs.c<br>&gt; &gt; =C2=A0&g=
t; &gt; +++ b/block/nfs.c<br>&gt; &gt; =C2=A0&gt;<br>&gt; &gt; =C2=A0&gt; [=
...]<br>&gt; &gt; =C2=A0&gt;<br>&gt; &gt; =C2=A0&gt; &gt; @@ -51,6 +53,10 @=
@<br>&gt; &gt; =C2=A0&gt; &gt; =C2=A0 #define QEMU_NFS_MAX_PAGECACHE_SIZE (=
8388608 / NFS_BLKSIZE)<br>&gt; &gt; =C2=A0&gt; &gt; =C2=A0 #define QEMU_NFS=
_MAX_DEBUG_LEVEL 2<br>&gt; &gt; =C2=A0&gt; &gt;<br>&gt; &gt; =C2=A0&gt; &gt=
; +#if defined(_WIN32)<br>&gt; &gt; =C2=A0&gt; &gt; +typedef long long blkc=
nt_t;<br>&gt; &gt; =C2=A0&gt;<br>&gt; &gt; =C2=A0&gt; This makes me uneasy.=
=C2=A0 Is there a guarantee that this type will never be<br>&gt; &gt; =C2=
=A0&gt; defined in a mingw environment (which would then result in a new co=
mpile<br>&gt; &gt; =C2=A0&gt; error)?<br>&gt; &gt; That&#39;s be sure, ming=
w is compat with msvcrt.dll, so blkcnt_t =C2=A0are always<br>&gt; &gt; not =
defined.<br>&gt;<br>&gt; And there is no possibility of that being added in=
 the future?<div>If that&#39;s the case, what&#39;s the better option.<br>&=
gt;<br>&gt; Max<br>&gt;<br><br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=
=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo</div></div>

--000000000000494ebf05b35aa63c--

