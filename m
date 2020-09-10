Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149E8C2BB84
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 07:15:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1210B2078E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 07:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZg6knKH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1210B2078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGGnj-0003G5-Tu
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 03:15:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34222)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kGGn8-0002kl-Rs; Thu, 10 Sep 2020 03:14:46 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:46545)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kGGn6-00038g-IC; Thu, 10 Sep 2020 03:14:46 -0400
Received: by mail-lj1-x242.google.com with SMTP id a22so6764849ljp.13;
 Thu, 10 Sep 2020 00:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=SGzrft+AF/QpzHbbGyGg2pcA6uoKL52OMsLo3vXEJes=;
 b=jZg6knKHxtVG44Fu5A4dPf8MACHmIhFcZqC3nQv7rJ0bDj2XPFEMl4Mw8yiG734/u+
 eYscFdnY8FY2lhj4EY7wSF7t6rUKYU0Gxqs6kJIwzEHLiOaoieN+/tJlhI+Wg/jD2y5Z
 sDX4PAsbvdwlNx2dvQ3XcTJx5jkA8SOb7jBD6jIBL1A8Itw3FWtrOYyzv6N4xVgQuXJs
 /7vNg4Eon3Y6TUFp0g1Avk/4bsjWB+8wWkimJnPekpUEJEPz7dGULGSBW7hytu3oNwMW
 lCugLlxflEyfhVyF6LXyctSCbdbT1yFPp8a9daVksmVpr6PqBU3ugJn+7KsM/R3Bhrl3
 eR5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=SGzrft+AF/QpzHbbGyGg2pcA6uoKL52OMsLo3vXEJes=;
 b=i/WRALiwwMvNHGbrKkVEaKi0Uaio//NE5b5+OpBqmSdWeFLCiFaeqi5ys7Okhfg3xc
 hEiX07MUSuRJMcQe4KLJAZN4TcnAZFbXRx4RC8/hVrxLSbDzuNo/LWS4JsOeG+yKwlou
 ZJhtjKwV42yZm5w2kZXpBMbbAuQpumyXrT50TYqAc20b80RZSuZU2m9WuTmTbexY8ble
 uIGghQpB4NWv/oNNM1r9FwlOmTh350Y8TfT8/j0Do6+D/Ee5ecRgbowaB224AmrAUECF
 7z9uxH2f3386fcROxI3IuUyh8jV72pYnrwCcfTMc9cKPkN1ShBUJdNoZkfo003YVqg5m
 1f0g==
X-Gm-Message-State: AOAM532tNqBo1Z1oU+dmkfEnZDKnWmf9grWxT2rJ83gt0b8F0rmgLNJi
 goCwcpbD0M+VcsvKUlykfjwd904XBKRMl6/GPks=
X-Google-Smtp-Source: ABdhPJxFSiXGjvCiPP6G94QYZOvfjs+TPsDaDURViNRONv87oOOFVtpMbWgK9u/Sh/zR51n0uAg47R7ZIOq9f/V2+0I=
X-Received: by 2002:a2e:854c:: with SMTP id u12mr3673039ljj.120.1599722082634; 
 Thu, 10 Sep 2020 00:14:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200909094617.1582-1-luoyonggang@gmail.com>
 <20200909094617.1582-2-luoyonggang@gmail.com>
 <D8F68C97-16F7-48DA-A003-275A7C0D08F3@kamp.de>
In-Reply-To: <D8F68C97-16F7-48DA-A003-275A7C0D08F3@kamp.de>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Thu, 10 Sep 2020 15:14:31 +0800
Message-ID: <CAE2XoE-bTGqfVe-5cCuZGBrsG9FVz6pomRU0-omCF9JiGNcSCA@mail.gmail.com>
Subject: Re: [PATCH v2 01/21] block: Fixes nfs compiling error on msys2/mingw
To: Peter Lieven <pl@kamp.de>
Content-Type: multipart/alternative; boundary="000000000000798f5e05aef052d8"
Received-SPF: pass client-ip=2a00:1450:4864:20::242;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x242.google.com
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
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu block <qemu-block@nongnu.org>,
 Stefan Weil <sw@weilnetz.de>, Xie Changlong <xiechanglong.d@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000798f5e05aef052d8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2020 at 3:01 PM Peter Lieven <pl@kamp.de> wrote:

>
>
> > Am 09.09.2020 um 11:45 schrieb Yonggang Luo <luoyonggang@gmail.com>:
> >
> > These compiling errors are fixed:
> > ../block/nfs.c:27:10: fatal error: poll.h: No such file or directory
> >   27 | #include <poll.h>
> >      |          ^~~~~~~~
> > compilation terminated.
> >
> > ../block/nfs.c:63:5: error: unknown type name 'blkcnt_t'
> >   63 |     blkcnt_t st_blocks;
> >      |     ^~~~~~~~
> > ../block/nfs.c: In function 'nfs_client_open':
> > ../block/nfs.c:550:27: error: 'struct _stat64' has no member named
> 'st_blocks'
> >  550 |     client->st_blocks =3D st.st_blocks;
> >      |                           ^
> > ../block/nfs.c: In function 'nfs_get_allocated_file_size':
> > ../block/nfs.c:751:41: error: 'struct _stat64' has no member named
> 'st_blocks'
> >  751 |     return (task.ret < 0 ? task.ret : st.st_blocks * 512);
> >      |                                         ^
> > ../block/nfs.c: In function 'nfs_reopen_prepare':
> > ../block/nfs.c:805:31: error: 'struct _stat64' has no member named
> 'st_blocks'
> >  805 |         client->st_blocks =3D st.st_blocks;
> >      |                               ^
> > ../block/nfs.c: In function 'nfs_get_allocated_file_size':
> > ../block/nfs.c:752:1: error: control reaches end of non-void function
> [-Werror=3Dreturn-type]
> >  752 | }
> >      | ^
> >
> > On msys2/mingw, there is no st_blocks in struct _stat64, so we use
> consistence st_size instead.
> >
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > ---
> > block/nfs.c | 26 +++++++++++++++++---------
> > 1 file changed, 17 insertions(+), 9 deletions(-)
> >
> > diff --git a/block/nfs.c b/block/nfs.c
> > index 61a249a9fc..34b2cd5708 100644
> > --- a/block/nfs.c
> > +++ b/block/nfs.c
> > @@ -24,7 +24,9 @@
> >
> > #include "qemu/osdep.h"
> >
> > +#if !defined(_WIN32)
> > #include <poll.h>
> > +#endif
> > #include "qemu/config-file.h"
> > #include "qemu/error-report.h"
> > #include "qapi/error.h"
> > @@ -51,6 +53,12 @@
> > #define QEMU_NFS_MAX_PAGECACHE_SIZE (8388608 / NFS_BLKSIZE)
> > #define QEMU_NFS_MAX_DEBUG_LEVEL 2
> >
> > +#if defined (_WIN32)
> > +#define nfs_stat __stat64
> > +#else
> > +#define nfs_stat stat
> > +#endif
> > +
> > typedef struct NFSClient {
> >     struct nfs_context *context;
> >     struct nfsfh *fh;
> > @@ -58,7 +66,7 @@ typedef struct NFSClient {
> >     bool has_zero_init;
> >     AioContext *aio_context;
> >     QemuMutex mutex;
> > -    blkcnt_t st_blocks;
> > +    int64_t st_size;
> >     bool cache_used;
> >     NFSServer *server;
> >     char *path;
> > @@ -70,7 +78,7 @@ typedef struct NFSRPC {
> >     int ret;
> >     int complete;
> >     QEMUIOVector *iov;
> > -    struct stat *st;
> > +    struct nfs_stat *st;
> >     Coroutine *co;
> >     NFSClient *client;
> > } NFSRPC;
> > @@ -419,7 +427,7 @@ static int64_t nfs_client_open(NFSClient *client,
> BlockdevOptionsNfs *opts,
> >                                int flags, int open_flags, Error **errp)
> > {
> >     int64_t ret =3D -EINVAL;
> > -    struct stat st;
> > +    struct nfs_stat st;
> >     char *file =3D NULL, *strp =3D NULL;
> >
> >     qemu_mutex_init(&client->mutex);
> > @@ -545,7 +553,7 @@ static int64_t nfs_client_open(NFSClient *client,
> BlockdevOptionsNfs *opts,
> >     }
> >
> >     ret =3D DIV_ROUND_UP(st.st_size, BDRV_SECTOR_SIZE);
> > -    client->st_blocks =3D st.st_blocks;
> > +    client->st_size =3D st.st_size;
> >     client->has_zero_init =3D S_ISREG(st.st_mode);
> >     *strp =3D '/';
> >     goto out;
> > @@ -729,11 +737,11 @@ static int64_t
> nfs_get_allocated_file_size(BlockDriverState *bs)
> > {
> >     NFSClient *client =3D bs->opaque;
> >     NFSRPC task =3D {0};
> > -    struct stat st;
> > +    struct nfs_stat st;
> >
> >     if (bdrv_is_read_only(bs) &&
> >         !(bs->open_flags & BDRV_O_NOCACHE)) {
> > -        return client->st_blocks * 512;
> > +        return client->st_size;
>
I am using   client->st_size instead client->st_blocks * 512, anything
wrong with this?

> >     }
> >
> >     task.bs =3D bs;
> > @@ -746,7 +754,7 @@ static int64_t
> nfs_get_allocated_file_size(BlockDriverState *bs)
> >     nfs_set_events(client);
> >     BDRV_POLL_WHILE(bs, !task.complete);
> >
> > -    return (task.ret < 0 ? task.ret : st.st_blocks * 512);
> > +    return (task.ret < 0 ? task.ret : st.st_size);
> > }
> >
> > static int coroutine_fn
> > @@ -778,7 +786,7 @@ static int nfs_reopen_prepare(BDRVReopenState *stat=
e,
> >                               BlockReopenQueue *queue, Error **errp)
> > {
> >     NFSClient *client =3D state->bs->opaque;
> > -    struct stat st;
> > +    struct nfs_stat st;
> >     int ret =3D 0;
> >
> >     if (state->flags & BDRV_O_RDWR && bdrv_is_read_only(state->bs)) {
> > @@ -800,7 +808,7 @@ static int nfs_reopen_prepare(BDRVReopenState *stat=
e,
> >                        nfs_get_error(client->context));
> >             return ret;
> >         }
> > -        client->st_blocks =3D st.st_blocks;
> > +        client->st_size =3D st.st_size;
> >     }
> >
> >     return 0;
> > --
> > 2.28.0.windows.1
> >
>
>
> NACK. st_blocks and st_size is not the same. st_blocks is the number of
> allocated blocks on disk. st_size is the virtual size of a file as it may
> contain holes.
> I think the appropriate fix is to not implement
> nfs_get_allocated_file_size on WIN32. Its not mandatory.
>
> Please look at the   st_size, it's equivalant to  st_blocks * 512;

Peter
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

--000000000000798f5e05aef052d8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Sep 10, 2020 at 3:01 PM Peter=
 Lieven &lt;<a href=3D"mailto:pl@kamp.de">pl@kamp.de</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
<br>
&gt; Am 09.09.2020 um 11:45 schrieb Yonggang Luo &lt;<a href=3D"mailto:luoy=
onggang@gmail.com" target=3D"_blank">luoyonggang@gmail.com</a>&gt;:<br>
&gt; <br>
&gt; These compiling errors are fixed:<br>
&gt; ../block/nfs.c:27:10: fatal error: poll.h: No such file or directory<b=
r>
&gt;=C2=A0 =C2=A027 | #include &lt;poll.h&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~<br>
&gt; compilation terminated.<br>
&gt; <br>
&gt; ../block/nfs.c:63:5: error: unknown type name &#39;blkcnt_t&#39;<br>
&gt;=C2=A0 =C2=A063 |=C2=A0 =C2=A0 =C2=A0blkcnt_t st_blocks;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0^~~~~~~~<br>
&gt; ../block/nfs.c: In function &#39;nfs_client_open&#39;:<br>
&gt; ../block/nfs.c:550:27: error: &#39;struct _stat64&#39; has no member n=
amed &#39;st_blocks&#39;<br>
&gt;=C2=A0 550 |=C2=A0 =C2=A0 =C2=A0client-&gt;st_blocks =3D st.st_blocks;<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^<br>
&gt; ../block/nfs.c: In function &#39;nfs_get_allocated_file_size&#39;:<br>
&gt; ../block/nfs.c:751:41: error: &#39;struct _stat64&#39; has no member n=
amed &#39;st_blocks&#39;<br>
&gt;=C2=A0 751 |=C2=A0 =C2=A0 =C2=A0return (task.ret &lt; 0 ? task.ret : st=
.st_blocks * 512);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0^<br>
&gt; ../block/nfs.c: In function &#39;nfs_reopen_prepare&#39;:<br>
&gt; ../block/nfs.c:805:31: error: &#39;struct _stat64&#39; has no member n=
amed &#39;st_blocks&#39;<br>
&gt;=C2=A0 805 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0client-&gt;st_blocks =3D =
st.st_blocks;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^<br>
&gt; ../block/nfs.c: In function &#39;nfs_get_allocated_file_size&#39;:<br>
&gt; ../block/nfs.c:752:1: error: control reaches end of non-void function =
[-Werror=3Dreturn-type]<br>
&gt;=C2=A0 752 | }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 | ^<br>
&gt; <br>
&gt; On msys2/mingw, there is no st_blocks in struct _stat64, so we use con=
sistence st_size instead.<br>
&gt; <br>
&gt; Signed-off-by: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.co=
m" target=3D"_blank">luoyonggang@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt; block/nfs.c | 26 +++++++++++++++++---------<br>
&gt; 1 file changed, 17 insertions(+), 9 deletions(-)<br>
&gt; <br>
&gt; diff --git a/block/nfs.c b/block/nfs.c<br>
&gt; index 61a249a9fc..34b2cd5708 100644<br>
&gt; --- a/block/nfs.c<br>
&gt; +++ b/block/nfs.c<br>
&gt; @@ -24,7 +24,9 @@<br>
&gt; <br>
&gt; #include &quot;qemu/osdep.h&quot;<br>
&gt; <br>
&gt; +#if !defined(_WIN32)<br>
&gt; #include &lt;poll.h&gt;<br>
&gt; +#endif<br>
&gt; #include &quot;qemu/config-file.h&quot;<br>
&gt; #include &quot;qemu/error-report.h&quot;<br>
&gt; #include &quot;qapi/error.h&quot;<br>
&gt; @@ -51,6 +53,12 @@<br>
&gt; #define QEMU_NFS_MAX_PAGECACHE_SIZE (8388608 / NFS_BLKSIZE)<br>
&gt; #define QEMU_NFS_MAX_DEBUG_LEVEL 2<br>
&gt; <br>
&gt; +#if defined (_WIN32)<br>
&gt; +#define nfs_stat __stat64<br>
&gt; +#else<br>
&gt; +#define nfs_stat stat<br>
&gt; +#endif<br>
&gt; +<br>
&gt; typedef struct NFSClient {<br>
&gt;=C2=A0 =C2=A0 =C2=A0struct nfs_context *context;<br>
&gt;=C2=A0 =C2=A0 =C2=A0struct nfsfh *fh;<br>
&gt; @@ -58,7 +66,7 @@ typedef struct NFSClient {<br>
&gt;=C2=A0 =C2=A0 =C2=A0bool has_zero_init;<br>
&gt;=C2=A0 =C2=A0 =C2=A0AioContext *aio_context;<br>
&gt;=C2=A0 =C2=A0 =C2=A0QemuMutex mutex;<br>
&gt; -=C2=A0 =C2=A0 blkcnt_t st_blocks;<br>
&gt; +=C2=A0 =C2=A0 int64_t st_size;<br>
&gt;=C2=A0 =C2=A0 =C2=A0bool cache_used;<br>
&gt;=C2=A0 =C2=A0 =C2=A0NFSServer *server;<br>
&gt;=C2=A0 =C2=A0 =C2=A0char *path;<br>
&gt; @@ -70,7 +78,7 @@ typedef struct NFSRPC {<br>
&gt;=C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt;=C2=A0 =C2=A0 =C2=A0int complete;<br>
&gt;=C2=A0 =C2=A0 =C2=A0QEMUIOVector *iov;<br>
&gt; -=C2=A0 =C2=A0 struct stat *st;<br>
&gt; +=C2=A0 =C2=A0 struct nfs_stat *st;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Coroutine *co;<br>
&gt;=C2=A0 =C2=A0 =C2=A0NFSClient *client;<br>
&gt; } NFSRPC;<br>
&gt; @@ -419,7 +427,7 @@ static int64_t nfs_client_open(NFSClient *client, =
BlockdevOptionsNfs *opts,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int flags, int open_flags, Error =
**errp)<br>
&gt; {<br>
&gt;=C2=A0 =C2=A0 =C2=A0int64_t ret =3D -EINVAL;<br>
&gt; -=C2=A0 =C2=A0 struct stat st;<br>
&gt; +=C2=A0 =C2=A0 struct nfs_stat st;<br>
&gt;=C2=A0 =C2=A0 =C2=A0char *file =3D NULL, *strp =3D NULL;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0qemu_mutex_init(&amp;client-&gt;mutex);<br>
&gt; @@ -545,7 +553,7 @@ static int64_t nfs_client_open(NFSClient *client, =
BlockdevOptionsNfs *opts,<br>
&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0ret =3D DIV_ROUND_UP(st.st_size, BDRV_SECTOR_SIZE);=
<br>
&gt; -=C2=A0 =C2=A0 client-&gt;st_blocks =3D st.st_blocks;<br>
&gt; +=C2=A0 =C2=A0 client-&gt;st_size =3D st.st_size;<br>
&gt;=C2=A0 =C2=A0 =C2=A0client-&gt;has_zero_init =3D S_ISREG(st.st_mode);<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0*strp =3D &#39;/&#39;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0goto out;<br>
&gt; @@ -729,11 +737,11 @@ static int64_t nfs_get_allocated_file_size(Block=
DriverState *bs)<br>
&gt; {<br>
&gt;=C2=A0 =C2=A0 =C2=A0NFSClient *client =3D bs-&gt;opaque;<br>
&gt;=C2=A0 =C2=A0 =C2=A0NFSRPC task =3D {0};<br>
&gt; -=C2=A0 =C2=A0 struct stat st;<br>
&gt; +=C2=A0 =C2=A0 struct nfs_stat st;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0if (bdrv_is_read_only(bs) &amp;&amp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!(bs-&gt;open_flags &amp; BDRV_O_NOCA=
CHE)) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return client-&gt;st_blocks * 512;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return client-&gt;st_size;<br></blockquot=
e><div>I am using=C2=A0=C2=A0

client-&gt;st_size instead client-&gt;st_blocks * 512, anything wrong with =
this?</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"http://task.bs" rel=3D"noreferrer" targe=
t=3D"_blank">task.bs</a> =3D bs;<br>
&gt; @@ -746,7 +754,7 @@ static int64_t nfs_get_allocated_file_size(BlockDr=
iverState *bs)<br>
&gt;=C2=A0 =C2=A0 =C2=A0nfs_set_events(client);<br>
&gt;=C2=A0 =C2=A0 =C2=A0BDRV_POLL_WHILE(bs, !task.complete);<br>
&gt; <br>
&gt; -=C2=A0 =C2=A0 return (task.ret &lt; 0 ? task.ret : st.st_blocks * 512=
);<br>
&gt; +=C2=A0 =C2=A0 return (task.ret &lt; 0 ? task.ret : st.st_size);<br>
&gt; }<br>
&gt; <br>
&gt; static int coroutine_fn<br>
&gt; @@ -778,7 +786,7 @@ static int nfs_reopen_prepare(BDRVReopenState *sta=
te,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0BlockReopenQueue *queue, Error **e=
rrp)<br>
&gt; {<br>
&gt;=C2=A0 =C2=A0 =C2=A0NFSClient *client =3D state-&gt;bs-&gt;opaque;<br>
&gt; -=C2=A0 =C2=A0 struct stat st;<br>
&gt; +=C2=A0 =C2=A0 struct nfs_stat st;<br>
&gt;=C2=A0 =C2=A0 =C2=A0int ret =3D 0;<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0if (state-&gt;flags &amp; BDRV_O_RDWR &amp;&amp; bd=
rv_is_read_only(state-&gt;bs)) {<br>
&gt; @@ -800,7 +808,7 @@ static int nfs_reopen_prepare(BDRVReopenState *sta=
te,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 nfs_get_error(client-&gt;context));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 client-&gt;st_blocks =3D st.st_blocks;<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 client-&gt;st_size =3D st.st_size;<br>
&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; -- <br>
&gt; 2.28.0.windows.1<br>
&gt; <br>
<br>
<br>
NACK. st_blocks and st_size is not the same. st_blocks is the number of all=
ocated blocks on disk. st_size is the virtual size of a file as it may cont=
ain holes.<br>
I think the appropriate fix is to not implement nfs_get_allocated_file_size=
 on WIN32. Its not mandatory.<br>
<br></blockquote><div>Please look at the=C2=A0=C2=A0

st_size, it&#39;s equivalant to=C2=A0

st_blocks * 512;</div><div><br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">
Peter<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div>

--000000000000798f5e05aef052d8--

