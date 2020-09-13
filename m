Return-Path: <SRS0=H3r+=CW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D06C43461
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 16:03:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24D8D221EB
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 16:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INepk4EX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24D8D221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHUTg-0002ZP-2E
	for qemu-devel@archiver.kernel.org; Sun, 13 Sep 2020 12:03:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53770)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kHUQm-0008JB-D0; Sun, 13 Sep 2020 12:00:44 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:46644)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kHUQi-00019S-VO; Sun, 13 Sep 2020 12:00:44 -0400
Received: by mail-lj1-x241.google.com with SMTP id a22so16451760ljp.13;
 Sun, 13 Sep 2020 09:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=7Gbha9a9tcrYkTAvUULCkhrAqPA/d9a3tNTb37VAqKY=;
 b=INepk4EX9+OqftIdOVCmdV0AESlkatXnlZhIf78Rdt7B6PkjDbb6bAzMnvCRoEDDpU
 x1qDyYB0l/bbPz7VZC2NXPIhG7tVeLg/rUPVjf4kXTpqiyrvWZ6ceTTaz3atDRKAfqB8
 xsl8pX+g1Nl0+y1Pfznb/CLjtrPo3c8wrCyvdzTjh8nVPkcXba/5jLORAOTFq3OXvjNk
 8eRuB0uVcSvlJMTtyFFiirs0VLd4j4xohSkdiIZ75aVCM9uTyOfzTP0IUCMCGLRZHoKY
 T+1XdLE4LMzGLiI9QdCuotbtpluHc3fkHW4KsdalaXyS6UH36yEykPKlhPEAo2Y9mCyC
 IROg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=7Gbha9a9tcrYkTAvUULCkhrAqPA/d9a3tNTb37VAqKY=;
 b=tCuV5Bu7kUpxbCRt13cpFhU/tcnpJshbEMOP6wFMRWNTE3xwbev6v0gX01cJWCL57q
 RM30usKNGs1TMIcF5CZ5QlbxSUndriG97Xjxlf+/K9I/oZEWVABSIRMSq5BOsfT9CFYO
 Box0/eOXn8XVSMIwYgkqZJusEwUP8uk9N7qzG044z2JzVPz7Vg71mBnYt0mh4F1UZr30
 yQjI1mhH2XVwRNhWe9CGZSwkT8Q767g3Z9iVc4kW8XFiBo++5ZvEjyrLx/bYt/1LRLPS
 1EXzqXlowZ2Nu7j70L1djaZSeoueJvyvleObxbM+98sMsUaMWw1ISa05+ONE4qamrg3e
 CWmg==
X-Gm-Message-State: AOAM533BWVJBEh3KRlUwPlqtkALTybEHpBmU5FYeJLCpSjkqAWUuSlsR
 YKR8Pcy9g/alXXjAsZfkOWZVMyLM5ED4hTIaU9g=
X-Google-Smtp-Source: ABdhPJwyGCULAl7qxZbJy4HlRAUjey4IfyhpUEiqAQ3Yl/enuY+YaWiIATq8fCw66AT6NjBhr6wxRXhE2nPFjjY7spc=
X-Received: by 2002:a2e:89d6:: with SMTP id c22mr3975279ljk.242.1600012837737; 
 Sun, 13 Sep 2020 09:00:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200912224431.1428-1-luoyonggang@gmail.com>
 <20200912224431.1428-3-luoyonggang@gmail.com>
 <5a805c5b-53d5-322e-1031-ddd68154b9e0@redhat.com>
In-Reply-To: <5a805c5b-53d5-322e-1031-ddd68154b9e0@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Mon, 14 Sep 2020 00:00:26 +0800
Message-ID: <CAE2XoE_HtV_YDEdjh2824G+Csz+yR-2WZg7JYb_DNkX=xPUA6A@mail.gmail.com>
Subject: Re: [PATCH v8 02/27] block: Fixes nfs compiling error on msys2/mingw
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000d4578d05af340480"
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
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000d4578d05af340480
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 13, 2020 at 11:47 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat=
.com>
wrote:

> On 9/13/20 12:44 AM, Yonggang Luo wrote:
> > These compiling errors are fixed:
> > ../block/nfs.c:27:10: fatal error: poll.h: No such file or directory
> >    27 | #include <poll.h>
> >       |          ^~~~~~~~
> > compilation terminated.
> >
> > ../block/nfs.c:63:5: error: unknown type name 'blkcnt_t'
> >    63 |     blkcnt_t st_blocks;
> >       |     ^~~~~~~~
> > ../block/nfs.c: In function 'nfs_client_open':
> > ../block/nfs.c:550:27: error: 'struct _stat64' has no member named
> 'st_blocks'
> >   550 |     client->st_blocks =3D st.st_blocks;
> >       |                           ^
> > ../block/nfs.c: In function 'nfs_get_allocated_file_size':
> > ../block/nfs.c:751:41: error: 'struct _stat64' has no member named
> 'st_blocks'
> >   751 |     return (task.ret < 0 ? task.ret : st.st_blocks * 512);
> >       |                                         ^
> > ../block/nfs.c: In function 'nfs_reopen_prepare':
> > ../block/nfs.c:805:31: error: 'struct _stat64' has no member named
> 'st_blocks'
> >   805 |         client->st_blocks =3D st.st_blocks;
> >       |                               ^
> > ../block/nfs.c: In function 'nfs_get_allocated_file_size':
> > ../block/nfs.c:752:1: error: control reaches end of non-void function
> [-Werror=3Dreturn-type]
> >   752 | }
> >       | ^
> >
> > On msys2/mingw, there is no st_blocks in struct _stat64, so we use
> consistence st_size instead.
> >
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > ---
> >  block/nfs.c | 26 ++++++++++++++++++++++----
> >  1 file changed, 22 insertions(+), 4 deletions(-)
> >
> > diff --git a/block/nfs.c b/block/nfs.c
> > index 61a249a9fc..98b48f363b 100644
> > --- a/block/nfs.c
> > +++ b/block/nfs.c
> > @@ -24,7 +24,9 @@
> >
> >  #include "qemu/osdep.h"
> >
> > +#if !defined(_WIN32)
> >  #include <poll.h>
> > +#endif
> >  #include "qemu/config-file.h"
> >  #include "qemu/error-report.h"
> >  #include "qapi/error.h"
> > @@ -51,6 +53,12 @@
> >  #define QEMU_NFS_MAX_PAGECACHE_SIZE (8388608 / NFS_BLKSIZE)
> >  #define QEMU_NFS_MAX_DEBUG_LEVEL 2
> >
> > +#if defined (_WIN32)
> > +#define nfs_stat __stat64
> > +#else
> > +#define nfs_stat stat
> > +#endif
> > +
> >  typedef struct NFSClient {
> >      struct nfs_context *context;
> >      struct nfsfh *fh;
> > @@ -58,7 +66,9 @@ typedef struct NFSClient {
> >      bool has_zero_init;
> >      AioContext *aio_context;
> >      QemuMutex mutex;
> > +#if !defined (_WIN32)
> >      blkcnt_t st_blocks;
>
> What about adding a "typedef off_t blkcnt_t;" or
> similar typedef instead? Then no need to #ifdef
> the st_blocks uses.
>
No, I did that before and someone else have objection

>
> > +#endif
> >      bool cache_used;
> >      NFSServer *server;
> >      char *path;
> > @@ -70,7 +80,7 @@ typedef struct NFSRPC {
> >      int ret;
> >      int complete;
> >      QEMUIOVector *iov;
> > -    struct stat *st;
> > +    struct nfs_stat *st;
> >      Coroutine *co;
> >      NFSClient *client;
> >  } NFSRPC;
> > @@ -419,7 +429,7 @@ static int64_t nfs_client_open(NFSClient *client,
> BlockdevOptionsNfs *opts,
> >                                 int flags, int open_flags, Error **errp=
)
> >  {
> >      int64_t ret =3D -EINVAL;
> > -    struct stat st;
> > +    struct nfs_stat st;
> >      char *file =3D NULL, *strp =3D NULL;
> >
> >      qemu_mutex_init(&client->mutex);
> > @@ -545,7 +555,9 @@ static int64_t nfs_client_open(NFSClient *client,
> BlockdevOptionsNfs *opts,
> >      }
> >
> >      ret =3D DIV_ROUND_UP(st.st_size, BDRV_SECTOR_SIZE);
> > +#if !defined (_WIN32)
> >      client->st_blocks =3D st.st_blocks;
> > +#endif
> >      client->has_zero_init =3D S_ISREG(st.st_mode);
> >      *strp =3D '/';
> >      goto out;
> > @@ -706,6 +718,7 @@ static int nfs_has_zero_init(BlockDriverState *bs)
> >      return client->has_zero_init;
> >  }
> >
> > +#if !defined (_WIN32)
> >  /* Called (via nfs_service) with QemuMutex held.  */
> >  static void
> >  nfs_get_allocated_file_size_cb(int ret, struct nfs_context *nfs, void
> *data,
> > @@ -729,7 +742,7 @@ static int64_t
> nfs_get_allocated_file_size(BlockDriverState *bs)
> >  {
> >      NFSClient *client =3D bs->opaque;
> >      NFSRPC task =3D {0};
> > -    struct stat st;
> > +    struct nfs_stat st;
> >
> >      if (bdrv_is_read_only(bs) &&
> >          !(bs->open_flags & BDRV_O_NOCACHE)) {
> > @@ -748,6 +761,7 @@ static int64_t
> nfs_get_allocated_file_size(BlockDriverState *bs)
> >
> >      return (task.ret < 0 ? task.ret : st.st_blocks * 512);
> >  }
> > +#endif
> >
> >  static int coroutine_fn
> >  nfs_file_co_truncate(BlockDriverState *bs, int64_t offset, bool exact,
> > @@ -778,7 +792,7 @@ static int nfs_reopen_prepare(BDRVReopenState *stat=
e,
> >                                BlockReopenQueue *queue, Error **errp)
> >  {
> >      NFSClient *client =3D state->bs->opaque;
> > -    struct stat st;
> > +    struct nfs_stat st;
> >      int ret =3D 0;
> >
> >      if (state->flags & BDRV_O_RDWR && bdrv_is_read_only(state->bs)) {
> > @@ -800,7 +814,9 @@ static int nfs_reopen_prepare(BDRVReopenState *stat=
e,
> >                         nfs_get_error(client->context));
> >              return ret;
> >          }
> > +#if !defined (_WIN32)
> >          client->st_blocks =3D st.st_blocks;
> > +#endif
> >      }
> >
> >      return 0;
> > @@ -869,7 +885,9 @@ static BlockDriver bdrv_nfs =3D {
> >      .create_opts                    =3D &nfs_create_opts,
> >
> >      .bdrv_has_zero_init             =3D nfs_has_zero_init,
> > +#if !defined (_WIN32)
> >      .bdrv_get_allocated_file_size   =3D nfs_get_allocated_file_size,
> > +#endif
> >      .bdrv_co_truncate               =3D nfs_file_co_truncate,
> >
> >      .bdrv_file_open                 =3D nfs_file_open,
> >
>
>

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000d4578d05af340480
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sun, Sep 13, 2020 at 11:47 PM Phil=
ippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com">philmd@red=
hat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">On 9/13/20 12:44 AM, Yonggang Luo wrote:<br>
&gt; These compiling errors are fixed:<br>
&gt; ../block/nfs.c:27:10: fatal error: poll.h: No such file or directory<b=
r>
&gt;=C2=A0 =C2=A0 27 | #include &lt;poll.h&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~=
<br>
&gt; compilation terminated.<br>
&gt; <br>
&gt; ../block/nfs.c:63:5: error: unknown type name &#39;blkcnt_t&#39;<br>
&gt;=C2=A0 =C2=A0 63 |=C2=A0 =C2=A0 =C2=A0blkcnt_t st_blocks;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0^~~~~~~~<br>
&gt; ../block/nfs.c: In function &#39;nfs_client_open&#39;:<br>
&gt; ../block/nfs.c:550:27: error: &#39;struct _stat64&#39; has no member n=
amed &#39;st_blocks&#39;<br>
&gt;=C2=A0 =C2=A0550 |=C2=A0 =C2=A0 =C2=A0client-&gt;st_blocks =3D st.st_bl=
ocks;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^<br>
&gt; ../block/nfs.c: In function &#39;nfs_get_allocated_file_size&#39;:<br>
&gt; ../block/nfs.c:751:41: error: &#39;struct _stat64&#39; has no member n=
amed &#39;st_blocks&#39;<br>
&gt;=C2=A0 =C2=A0751 |=C2=A0 =C2=A0 =C2=A0return (task.ret &lt; 0 ? task.re=
t : st.st_blocks * 512);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^<br>
&gt; ../block/nfs.c: In function &#39;nfs_reopen_prepare&#39;:<br>
&gt; ../block/nfs.c:805:31: error: &#39;struct _stat64&#39; has no member n=
amed &#39;st_blocks&#39;<br>
&gt;=C2=A0 =C2=A0805 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0client-&gt;st_block=
s =3D st.st_blocks;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^<br>
&gt; ../block/nfs.c: In function &#39;nfs_get_allocated_file_size&#39;:<br>
&gt; ../block/nfs.c:752:1: error: control reaches end of non-void function =
[-Werror=3Dreturn-type]<br>
&gt;=C2=A0 =C2=A0752 | }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0| ^<br>
&gt; <br>
&gt; On msys2/mingw, there is no st_blocks in struct _stat64, so we use con=
sistence st_size instead.<br>
&gt; <br>
&gt; Signed-off-by: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.co=
m" target=3D"_blank">luoyonggang@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 block/nfs.c | 26 ++++++++++++++++++++++----<br>
&gt;=C2=A0 1 file changed, 22 insertions(+), 4 deletions(-)<br>
&gt; <br>
&gt; diff --git a/block/nfs.c b/block/nfs.c<br>
&gt; index 61a249a9fc..98b48f363b 100644<br>
&gt; --- a/block/nfs.c<br>
&gt; +++ b/block/nfs.c<br>
&gt; @@ -24,7 +24,9 @@<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;<br>
&gt;=C2=A0 <br>
&gt; +#if !defined(_WIN32)<br>
&gt;=C2=A0 #include &lt;poll.h&gt;<br>
&gt; +#endif<br>
&gt;=C2=A0 #include &quot;qemu/config-file.h&quot;<br>
&gt;=C2=A0 #include &quot;qemu/error-report.h&quot;<br>
&gt;=C2=A0 #include &quot;qapi/error.h&quot;<br>
&gt; @@ -51,6 +53,12 @@<br>
&gt;=C2=A0 #define QEMU_NFS_MAX_PAGECACHE_SIZE (8388608 / NFS_BLKSIZE)<br>
&gt;=C2=A0 #define QEMU_NFS_MAX_DEBUG_LEVEL 2<br>
&gt;=C2=A0 <br>
&gt; +#if defined (_WIN32)<br>
&gt; +#define nfs_stat __stat64<br>
&gt; +#else<br>
&gt; +#define nfs_stat stat<br>
&gt; +#endif<br>
&gt; +<br>
&gt;=C2=A0 typedef struct NFSClient {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 struct nfs_context *context;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 struct nfsfh *fh;<br>
&gt; @@ -58,7 +66,9 @@ typedef struct NFSClient {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 bool has_zero_init;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 AioContext *aio_context;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 QemuMutex mutex;<br>
&gt; +#if !defined (_WIN32)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 blkcnt_t st_blocks;<br>
<br>
What about adding a &quot;typedef off_t blkcnt_t;&quot; or<br>
similar typedef instead? Then no need to #ifdef<br>
the st_blocks uses.<br></blockquote><div>No, I did that before and someone =
else have objection=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">
<br>
&gt; +#endif<br>
&gt;=C2=A0 =C2=A0 =C2=A0 bool cache_used;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 NFSServer *server;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 char *path;<br>
&gt; @@ -70,7 +80,7 @@ typedef struct NFSRPC {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int ret;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int complete;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 QEMUIOVector *iov;<br>
&gt; -=C2=A0 =C2=A0 struct stat *st;<br>
&gt; +=C2=A0 =C2=A0 struct nfs_stat *st;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 Coroutine *co;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 NFSClient *client;<br>
&gt;=C2=A0 } NFSRPC;<br>
&gt; @@ -419,7 +429,7 @@ static int64_t nfs_client_open(NFSClient *client, =
BlockdevOptionsNfs *opts,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int flags, int open_flags, =
Error **errp)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int64_t ret =3D -EINVAL;<br>
&gt; -=C2=A0 =C2=A0 struct stat st;<br>
&gt; +=C2=A0 =C2=A0 struct nfs_stat st;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 char *file =3D NULL, *strp =3D NULL;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 qemu_mutex_init(&amp;client-&gt;mutex);<br>
&gt; @@ -545,7 +555,9 @@ static int64_t nfs_client_open(NFSClient *client, =
BlockdevOptionsNfs *opts,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 ret =3D DIV_ROUND_UP(st.st_size, BDRV_SECTOR_SIZE)=
;<br>
&gt; +#if !defined (_WIN32)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 client-&gt;st_blocks =3D st.st_blocks;<br>
&gt; +#endif<br>
&gt;=C2=A0 =C2=A0 =C2=A0 client-&gt;has_zero_init =3D S_ISREG(st.st_mode);<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 *strp =3D &#39;/&#39;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 goto out;<br>
&gt; @@ -706,6 +718,7 @@ static int nfs_has_zero_init(BlockDriverState *bs)=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return client-&gt;has_zero_init;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +#if !defined (_WIN32)<br>
&gt;=C2=A0 /* Called (via nfs_service) with QemuMutex held.=C2=A0 */<br>
&gt;=C2=A0 static void<br>
&gt;=C2=A0 nfs_get_allocated_file_size_cb(int ret, struct nfs_context *nfs,=
 void *data,<br>
&gt; @@ -729,7 +742,7 @@ static int64_t nfs_get_allocated_file_size(BlockDr=
iverState *bs)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 NFSClient *client =3D bs-&gt;opaque;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 NFSRPC task =3D {0};<br>
&gt; -=C2=A0 =C2=A0 struct stat st;<br>
&gt; +=C2=A0 =C2=A0 struct nfs_stat st;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (bdrv_is_read_only(bs) &amp;&amp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !(bs-&gt;open_flags &amp; BDRV_O_NOC=
ACHE)) {<br>
&gt; @@ -748,6 +761,7 @@ static int64_t nfs_get_allocated_file_size(BlockDr=
iverState *bs)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 return (task.ret &lt; 0 ? task.ret : st.st_blocks =
* 512);<br>
&gt;=C2=A0 }<br>
&gt; +#endif<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 static int coroutine_fn<br>
&gt;=C2=A0 nfs_file_co_truncate(BlockDriverState *bs, int64_t offset, bool =
exact,<br>
&gt; @@ -778,7 +792,7 @@ static int nfs_reopen_prepare(BDRVReopenState *sta=
te,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BlockReopenQueue *queue, Error **=
errp)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 NFSClient *client =3D state-&gt;bs-&gt;opaque;<br>
&gt; -=C2=A0 =C2=A0 struct stat st;<br>
&gt; +=C2=A0 =C2=A0 struct nfs_stat st;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int ret =3D 0;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (state-&gt;flags &amp; BDRV_O_RDWR &amp;&amp; b=
drv_is_read_only(state-&gt;bs)) {<br>
&gt; @@ -800,7 +814,9 @@ static int nfs_reopen_prepare(BDRVReopenState *sta=
te,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0nfs_get_error(client-&gt;context));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +#if !defined (_WIN32)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 client-&gt;st_blocks =3D st.st_block=
s;<br>
&gt; +#endif<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; @@ -869,7 +885,9 @@ static BlockDriver bdrv_nfs =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 .create_opts=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D &amp;nfs_create_opts,<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 .bdrv_has_zero_init=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0=3D nfs_has_zero_init,<br>
&gt; +#if !defined (_WIN32)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 .bdrv_get_allocated_file_size=C2=A0 =C2=A0=3D nfs_=
get_allocated_file_size,<br>
&gt; +#endif<br>
&gt;=C2=A0 =C2=A0 =C2=A0 .bdrv_co_truncate=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=3D nfs_file_co_truncate,<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 .bdrv_file_open=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D nfs_file_open,<br>
&gt; <br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div>

--000000000000d4578d05af340480--

