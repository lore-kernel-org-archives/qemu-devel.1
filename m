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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94505C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 09:03:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90832206A1
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 09:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CK/kXkgz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90832206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGIUE-0005xW-9t
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 05:03:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kGITe-0005LP-M3; Thu, 10 Sep 2020 05:02:46 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a]:37112)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kGITc-0001E2-0s; Thu, 10 Sep 2020 05:02:46 -0400
Received: by mail-lj1-x22a.google.com with SMTP id n25so7169174ljj.4;
 Thu, 10 Sep 2020 02:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=FcsMQ46kCIe7+4wZHUZndbbbfznADKftu+fFYdX59AE=;
 b=CK/kXkgzu/xHGUFcBLoqal91GOe/fbWOw2s4Z+mOIPWA0L0AV6H1mF+7tWaVvnSStJ
 E7hAx3aYiPd20DkmJ+kOO+IgD1KJi/h6g9KFzGr7BecCCje1LpJ/h60d/7OV05vaywE9
 NUcduP2w2wjMGY3MBWGuZapv4wCZBAVd+zsCzztemN0ie9hpzOwV03X85EWqnu48nfkH
 DALCuRG/+balZTR9EOR3lAFPbGQYRVbkQgQJfclIU1Hl7kL+gmIIRXDAEWOa55wbVaLk
 eexXqq3Qjnhtk39CZUTNJqDGDiN7ZLcZkFoetY6ND7rA919xrL3RuBipgsFuYv6COreu
 f0RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=FcsMQ46kCIe7+4wZHUZndbbbfznADKftu+fFYdX59AE=;
 b=DndFaq0wDv9MBc7BOwBRqMNeILzKYrHV5HbxHGNthDoh81k8yHUmdawSVeejoM4t8t
 ka8Lm1HKtgiy9N4cOz0ESQPpgPIU4E/7rFGZkEYKxLxXVWx6Dtw35C1U73J2LjWJYmV5
 69vod9aURjqvzgHoJ07YuuvU6TXnTs9FT60Onx4hztJWoR5fqege6CWvpREo5T/5dYna
 16sSpzH0c4wVDZOsw1Kry+sKuef/ymxxU+lMkza7xzA+6UYrPsNsDV0t4cbm+FBJb0Vu
 gY4vzDXRPxlVnUuxXrWq0ZWvSt73pXS9Qi6Ka1OmEF2HpdOi0r7tVEpsjnVRKIzxRu9f
 +sCw==
X-Gm-Message-State: AOAM532P2FXJkzQGBEGlqSpMroJ7EgislLufn1UaXj4xVsOcwwurIFWa
 opE+0kXIG6WIFl0Qem02zFi1Hk90f8cDWC3IlY4=
X-Google-Smtp-Source: ABdhPJwRnMFDoxr9bkPdT2Tou8K2XYw7XVbur4goW2tNvI2/HUFf5GH6Cvll8ld5xmy0PoKdyl77D8QIRP5qJYkOryQ=
X-Received: by 2002:a2e:9dc7:: with SMTP id x7mr4213332ljj.447.1599728560247; 
 Thu, 10 Sep 2020 02:02:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200909094617.1582-1-luoyonggang@gmail.com>
 <20200909094617.1582-2-luoyonggang@gmail.com>
 <D8F68C97-16F7-48DA-A003-275A7C0D08F3@kamp.de>
 <CAE2XoE-bTGqfVe-5cCuZGBrsG9FVz6pomRU0-omCF9JiGNcSCA@mail.gmail.com>
 <F3949E8A-E95E-4C14-A5F4-039381CA30CD@kamp.de>
In-Reply-To: <F3949E8A-E95E-4C14-A5F4-039381CA30CD@kamp.de>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Thu, 10 Sep 2020 17:02:29 +0800
Message-ID: <CAE2XoE8B4nGpVMmKW9K1k-e7Yc=c=-w2_1S3S2c2u1Tq2X0WZg@mail.gmail.com>
Subject: Re: [PATCH v2 01/21] block: Fixes nfs compiling error on msys2/mingw
To: Peter Lieven <pl@kamp.de>
Content-Type: multipart/alternative; boundary="000000000000921bb205aef1d42f"
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x22a.google.com
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

--000000000000921bb205aef1d42f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2020 at 3:29 PM Peter Lieven <pl@kamp.de> wrote:

>
>
> > Am 10.09.2020 um 09:14 schrieb =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo=
) <luoyonggang@gmail.com
> >:
> >
> >
> >
> > On Thu, Sep 10, 2020 at 3:01 PM Peter Lieven <pl@kamp.de> wrote:
> >
> >
> > > Am 09.09.2020 um 11:45 schrieb Yonggang Luo <luoyonggang@gmail.com>:
> > >
> > > These compiling errors are fixed:
> > > ../block/nfs.c:27:10: fatal error: poll.h: No such file or directory
> > >   27 | #include <poll.h>
> > >      |          ^~~~~~~~
> > > compilation terminated.
> > >
> > > ../block/nfs.c:63:5: error: unknown type name 'blkcnt_t'
> > >   63 |     blkcnt_t st_blocks;
> > >      |     ^~~~~~~~
> > > ../block/nfs.c: In function 'nfs_client_open':
> > > ../block/nfs.c:550:27: error: 'struct _stat64' has no member named
> 'st_blocks'
> > >  550 |     client->st_blocks =3D st.st_blocks;
> > >      |                           ^
> > > ../block/nfs.c: In function 'nfs_get_allocated_file_size':
> > > ../block/nfs.c:751:41: error: 'struct _stat64' has no member named
> 'st_blocks'
> > >  751 |     return (task.ret < 0 ? task.ret : st.st_blocks * 512);
> > >      |                                         ^
> > > ../block/nfs.c: In function 'nfs_reopen_prepare':
> > > ../block/nfs.c:805:31: error: 'struct _stat64' has no member named
> 'st_blocks'
> > >  805 |         client->st_blocks =3D st.st_blocks;
> > >      |                               ^
> > > ../block/nfs.c: In function 'nfs_get_allocated_file_size':
> > > ../block/nfs.c:752:1: error: control reaches end of non-void function
> [-Werror=3Dreturn-type]
> > >  752 | }
> > >      | ^
> > >
> > > On msys2/mingw, there is no st_blocks in struct _stat64, so we use
> consistence st_size instead.
> > >
> > > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > > ---
> > > block/nfs.c | 26 +++++++++++++++++---------
> > > 1 file changed, 17 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/block/nfs.c b/block/nfs.c
> > > index 61a249a9fc..34b2cd5708 100644
> > > --- a/block/nfs.c
> > > +++ b/block/nfs.c
> > > @@ -24,7 +24,9 @@
> > >
> > > #include "qemu/osdep.h"
> > >
> > > +#if !defined(_WIN32)
> > > #include <poll.h>
> > > +#endif
> > > #include "qemu/config-file.h"
> > > #include "qemu/error-report.h"
> > > #include "qapi/error.h"
> > > @@ -51,6 +53,12 @@
> > > #define QEMU_NFS_MAX_PAGECACHE_SIZE (8388608 / NFS_BLKSIZE)
> > > #define QEMU_NFS_MAX_DEBUG_LEVEL 2
> > >
> > > +#if defined (_WIN32)
> > > +#define nfs_stat __stat64
> > > +#else
> > > +#define nfs_stat stat
> > > +#endif
> > > +
> > > typedef struct NFSClient {
> > >     struct nfs_context *context;
> > >     struct nfsfh *fh;
> > > @@ -58,7 +66,7 @@ typedef struct NFSClient {
> > >     bool has_zero_init;
> > >     AioContext *aio_context;
> > >     QemuMutex mutex;
> > > -    blkcnt_t st_blocks;
> > > +    int64_t st_size;
> > >     bool cache_used;
> > >     NFSServer *server;
> > >     char *path;
> > > @@ -70,7 +78,7 @@ typedef struct NFSRPC {
> > >     int ret;
> > >     int complete;
> > >     QEMUIOVector *iov;
> > > -    struct stat *st;
> > > +    struct nfs_stat *st;
> > >     Coroutine *co;
> > >     NFSClient *client;
> > > } NFSRPC;
> > > @@ -419,7 +427,7 @@ static int64_t nfs_client_open(NFSClient *client,
> BlockdevOptionsNfs *opts,
> > >                                int flags, int open_flags, Error **err=
p)
> > > {
> > >     int64_t ret =3D -EINVAL;
> > > -    struct stat st;
> > > +    struct nfs_stat st;
> > >     char *file =3D NULL, *strp =3D NULL;
> > >
> > >     qemu_mutex_init(&client->mutex);
> > > @@ -545,7 +553,7 @@ static int64_t nfs_client_open(NFSClient *client,
> BlockdevOptionsNfs *opts,
> > >     }
> > >
> > >     ret =3D DIV_ROUND_UP(st.st_size, BDRV_SECTOR_SIZE);
> > > -    client->st_blocks =3D st.st_blocks;
> > > +    client->st_size =3D st.st_size;
> > >     client->has_zero_init =3D S_ISREG(st.st_mode);
> > >     *strp =3D '/';
> > >     goto out;
> > > @@ -729,11 +737,11 @@ static int64_t
> nfs_get_allocated_file_size(BlockDriverState *bs)
> > > {
> > >     NFSClient *client =3D bs->opaque;
> > >     NFSRPC task =3D {0};
> > > -    struct stat st;
> > > +    struct nfs_stat st;
> > >
> > >     if (bdrv_is_read_only(bs) &&
> > >         !(bs->open_flags & BDRV_O_NOCACHE)) {
> > > -        return client->st_blocks * 512;
> > > +        return client->st_size;
> > I am using   client->st_size instead client->st_blocks * 512, anything
> wrong with this?
> > >     }
> > >
> > >     task.bs =3D bs;
> > > @@ -746,7 +754,7 @@ static int64_t
> nfs_get_allocated_file_size(BlockDriverState *bs)
> > >     nfs_set_events(client);
> > >     BDRV_POLL_WHILE(bs, !task.complete);
> > >
> > > -    return (task.ret < 0 ? task.ret : st.st_blocks * 512);
> > > +    return (task.ret < 0 ? task.ret : st.st_size);
> > > }
> > >
> > > static int coroutine_fn
> > > @@ -778,7 +786,7 @@ static int nfs_reopen_prepare(BDRVReopenState
> *state,
> > >                               BlockReopenQueue *queue, Error **errp)
> > > {
> > >     NFSClient *client =3D state->bs->opaque;
> > > -    struct stat st;
> > > +    struct nfs_stat st;
> > >     int ret =3D 0;
> > >
> > >     if (state->flags & BDRV_O_RDWR && bdrv_is_read_only(state->bs)) {
> > > @@ -800,7 +808,7 @@ static int nfs_reopen_prepare(BDRVReopenState
> *state,
> > >                        nfs_get_error(client->context));
> > >             return ret;
> > >         }
> > > -        client->st_blocks =3D st.st_blocks;
> > > +        client->st_size =3D st.st_size;
> > >     }
> > >
> > >     return 0;
> > > --
> > > 2.28.0.windows.1
> > >
> >
> >
> > NACK. st_blocks and st_size is not the same. st_blocks is the number of
> allocated blocks on disk. st_size is the virtual size of a file as it may
> contain holes.
> > I think the appropriate fix is to not implement
> nfs_get_allocated_file_size on WIN32. Its not mandatory.
> >
> > Please look at the   st_size, it's equivalant to  st_blocks * 512;
>
> It is definitely not. Where do you have this info from?
>
> Please have a look at libnfs/lib/nfs_v3.c in function nfs3_stat_1_cb.
>
>
>         st.st_size    =3D res->GETATTR3res_u.resok.obj_attributes.size;
> #ifndef WIN32
>         st.st_blksize =3D NFS_BLKSIZE;
>         st.st_blocks  =3D (res->GETATTR3res_u.resok.obj_attributes.used +
> 512 - 1) / 512;
> #endif//WIN32
>
>
> Your patch will eliminate this difference for non WIN32 systems. Please
> change your patch to not implement nfs_get_allocated_file_size and qemu
> will handle this case properly.
> Put everything that involves st_blocks and nfs_get_allocated_file_size in
> #ifndef _WIN32 conditions.
>
You are right, I'll fix it latter

>
>
> Peter
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000921bb205aef1d42f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Sep 10, 2020 at 3:29 PM Peter=
 Lieven &lt;<a href=3D"mailto:pl@kamp.de">pl@kamp.de</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
<br>
&gt; Am 10.09.2020 um 09:14 schrieb =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Lu=
o) &lt;<a href=3D"mailto:luoyonggang@gmail.com" target=3D"_blank">luoyongga=
ng@gmail.com</a>&gt;:<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; On Thu, Sep 10, 2020 at 3:01 PM Peter Lieven &lt;<a href=3D"mailto:pl@=
kamp.de" target=3D"_blank">pl@kamp.de</a>&gt; wrote:<br>
&gt; <br>
&gt; <br>
&gt; &gt; Am 09.09.2020 um 11:45 schrieb Yonggang Luo &lt;<a href=3D"mailto=
:luoyonggang@gmail.com" target=3D"_blank">luoyonggang@gmail.com</a>&gt;:<br=
>
&gt; &gt; <br>
&gt; &gt; These compiling errors are fixed:<br>
&gt; &gt; ../block/nfs.c:27:10: fatal error: poll.h: No such file or direct=
ory<br>
&gt; &gt;=C2=A0 =C2=A027 | #include &lt;poll.h&gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~<=
br>
&gt; &gt; compilation terminated.<br>
&gt; &gt; <br>
&gt; &gt; ../block/nfs.c:63:5: error: unknown type name &#39;blkcnt_t&#39;<=
br>
&gt; &gt;=C2=A0 =C2=A063 |=C2=A0 =C2=A0 =C2=A0blkcnt_t st_blocks;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0^~~~~~~~<br>
&gt; &gt; ../block/nfs.c: In function &#39;nfs_client_open&#39;:<br>
&gt; &gt; ../block/nfs.c:550:27: error: &#39;struct _stat64&#39; has no mem=
ber named &#39;st_blocks&#39;<br>
&gt; &gt;=C2=A0 550 |=C2=A0 =C2=A0 =C2=A0client-&gt;st_blocks =3D st.st_blo=
cks;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^<br>
&gt; &gt; ../block/nfs.c: In function &#39;nfs_get_allocated_file_size&#39;=
:<br>
&gt; &gt; ../block/nfs.c:751:41: error: &#39;struct _stat64&#39; has no mem=
ber named &#39;st_blocks&#39;<br>
&gt; &gt;=C2=A0 751 |=C2=A0 =C2=A0 =C2=A0return (task.ret &lt; 0 ? task.ret=
 : st.st_blocks * 512);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^<br>
&gt; &gt; ../block/nfs.c: In function &#39;nfs_reopen_prepare&#39;:<br>
&gt; &gt; ../block/nfs.c:805:31: error: &#39;struct _stat64&#39; has no mem=
ber named &#39;st_blocks&#39;<br>
&gt; &gt;=C2=A0 805 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0client-&gt;st_blocks=
 =3D st.st_blocks;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^<br>
&gt; &gt; ../block/nfs.c: In function &#39;nfs_get_allocated_file_size&#39;=
:<br>
&gt; &gt; ../block/nfs.c:752:1: error: control reaches end of non-void func=
tion [-Werror=3Dreturn-type]<br>
&gt; &gt;=C2=A0 752 | }<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 | ^<br>
&gt; &gt; <br>
&gt; &gt; On msys2/mingw, there is no st_blocks in struct _stat64, so we us=
e consistence st_size instead.<br>
&gt; &gt; <br>
&gt; &gt; Signed-off-by: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gma=
il.com" target=3D"_blank">luoyonggang@gmail.com</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt; block/nfs.c | 26 +++++++++++++++++---------<br>
&gt; &gt; 1 file changed, 17 insertions(+), 9 deletions(-)<br>
&gt; &gt; <br>
&gt; &gt; diff --git a/block/nfs.c b/block/nfs.c<br>
&gt; &gt; index 61a249a9fc..34b2cd5708 100644<br>
&gt; &gt; --- a/block/nfs.c<br>
&gt; &gt; +++ b/block/nfs.c<br>
&gt; &gt; @@ -24,7 +24,9 @@<br>
&gt; &gt; <br>
&gt; &gt; #include &quot;qemu/osdep.h&quot;<br>
&gt; &gt; <br>
&gt; &gt; +#if !defined(_WIN32)<br>
&gt; &gt; #include &lt;poll.h&gt;<br>
&gt; &gt; +#endif<br>
&gt; &gt; #include &quot;qemu/config-file.h&quot;<br>
&gt; &gt; #include &quot;qemu/error-report.h&quot;<br>
&gt; &gt; #include &quot;qapi/error.h&quot;<br>
&gt; &gt; @@ -51,6 +53,12 @@<br>
&gt; &gt; #define QEMU_NFS_MAX_PAGECACHE_SIZE (8388608 / NFS_BLKSIZE)<br>
&gt; &gt; #define QEMU_NFS_MAX_DEBUG_LEVEL 2<br>
&gt; &gt; <br>
&gt; &gt; +#if defined (_WIN32)<br>
&gt; &gt; +#define nfs_stat __stat64<br>
&gt; &gt; +#else<br>
&gt; &gt; +#define nfs_stat stat<br>
&gt; &gt; +#endif<br>
&gt; &gt; +<br>
&gt; &gt; typedef struct NFSClient {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0struct nfs_context *context;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0struct nfsfh *fh;<br>
&gt; &gt; @@ -58,7 +66,7 @@ typedef struct NFSClient {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0bool has_zero_init;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0AioContext *aio_context;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0QemuMutex mutex;<br>
&gt; &gt; -=C2=A0 =C2=A0 blkcnt_t st_blocks;<br>
&gt; &gt; +=C2=A0 =C2=A0 int64_t st_size;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0bool cache_used;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0NFSServer *server;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0char *path;<br>
&gt; &gt; @@ -70,7 +78,7 @@ typedef struct NFSRPC {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0int complete;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0QEMUIOVector *iov;<br>
&gt; &gt; -=C2=A0 =C2=A0 struct stat *st;<br>
&gt; &gt; +=C2=A0 =C2=A0 struct nfs_stat *st;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0Coroutine *co;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0NFSClient *client;<br>
&gt; &gt; } NFSRPC;<br>
&gt; &gt; @@ -419,7 +427,7 @@ static int64_t nfs_client_open(NFSClient *cli=
ent, BlockdevOptionsNfs *opts,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int flags, int open_flags, Er=
ror **errp)<br>
&gt; &gt; {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0int64_t ret =3D -EINVAL;<br>
&gt; &gt; -=C2=A0 =C2=A0 struct stat st;<br>
&gt; &gt; +=C2=A0 =C2=A0 struct nfs_stat st;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0char *file =3D NULL, *strp =3D NULL;<br>
&gt; &gt; <br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0qemu_mutex_init(&amp;client-&gt;mutex);<br>
&gt; &gt; @@ -545,7 +553,7 @@ static int64_t nfs_client_open(NFSClient *cli=
ent, BlockdevOptionsNfs *opts,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; <br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0ret =3D DIV_ROUND_UP(st.st_size, BDRV_SECTOR_S=
IZE);<br>
&gt; &gt; -=C2=A0 =C2=A0 client-&gt;st_blocks =3D st.st_blocks;<br>
&gt; &gt; +=C2=A0 =C2=A0 client-&gt;st_size =3D st.st_size;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0client-&gt;has_zero_init =3D S_ISREG(st.st_mod=
e);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0*strp =3D &#39;/&#39;;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0goto out;<br>
&gt; &gt; @@ -729,11 +737,11 @@ static int64_t nfs_get_allocated_file_size(=
BlockDriverState *bs)<br>
&gt; &gt; {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0NFSClient *client =3D bs-&gt;opaque;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0NFSRPC task =3D {0};<br>
&gt; &gt; -=C2=A0 =C2=A0 struct stat st;<br>
&gt; &gt; +=C2=A0 =C2=A0 struct nfs_stat st;<br>
&gt; &gt; <br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0if (bdrv_is_read_only(bs) &amp;&amp;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!(bs-&gt;open_flags &amp; BDRV_O=
_NOCACHE)) {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return client-&gt;st_blocks * 512;<b=
r>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return client-&gt;st_size;<br>
&gt; I am using=C2=A0 =C2=A0client-&gt;st_size instead client-&gt;st_blocks=
 * 512, anything wrong with this?<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; <br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0<a href=3D"http://task.bs" rel=3D"noreferrer" =
target=3D"_blank">task.bs</a> =3D bs;<br>
&gt; &gt; @@ -746,7 +754,7 @@ static int64_t nfs_get_allocated_file_size(Bl=
ockDriverState *bs)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0nfs_set_events(client);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0BDRV_POLL_WHILE(bs, !task.complete);<br>
&gt; &gt; <br>
&gt; &gt; -=C2=A0 =C2=A0 return (task.ret &lt; 0 ? task.ret : st.st_blocks =
* 512);<br>
&gt; &gt; +=C2=A0 =C2=A0 return (task.ret &lt; 0 ? task.ret : st.st_size);<=
br>
&gt; &gt; }<br>
&gt; &gt; <br>
&gt; &gt; static int coroutine_fn<br>
&gt; &gt; @@ -778,7 +786,7 @@ static int nfs_reopen_prepare(BDRVReopenState=
 *state,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0BlockReopenQueue *queue, Error=
 **errp)<br>
&gt; &gt; {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0NFSClient *client =3D state-&gt;bs-&gt;opaque;=
<br>
&gt; &gt; -=C2=A0 =C2=A0 struct stat st;<br>
&gt; &gt; +=C2=A0 =C2=A0 struct nfs_stat st;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0int ret =3D 0;<br>
&gt; &gt; <br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0if (state-&gt;flags &amp; BDRV_O_RDWR &amp;&am=
p; bdrv_is_read_only(state-&gt;bs)) {<br>
&gt; &gt; @@ -800,7 +808,7 @@ static int nfs_reopen_prepare(BDRVReopenState=
 *state,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 nfs_get_error(client-&gt;context));<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 client-&gt;st_blocks =3D st.st_block=
s;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 client-&gt;st_size =3D st.st_size;<b=
r>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; <br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; &gt; -- <br>
&gt; &gt; 2.28.0.windows.1<br>
&gt; &gt; <br>
&gt; <br>
&gt; <br>
&gt; NACK. st_blocks and st_size is not the same. st_blocks is the number o=
f allocated blocks on disk. st_size is the virtual size of a file as it may=
 contain holes.<br>
&gt; I think the appropriate fix is to not implement nfs_get_allocated_file=
_size on WIN32. Its not mandatory.<br>
&gt; <br>
&gt; Please look at the=C2=A0 =C2=A0st_size, it&#39;s equivalant to=C2=A0 s=
t_blocks * 512;<br>
<br>
It is definitely not. Where do you have this info from?<br>
<br>
Please have a look at libnfs/lib/nfs_v3.c in function nfs3_stat_1_cb.<br>
<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 st.st_size=C2=A0 =C2=A0 =3D res-&gt;GETATTR3res=
_u.resok.obj_attributes.size;<br>
#ifndef WIN32<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 st.st_blksize =3D NFS_BLKSIZE;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 st.st_blocks=C2=A0 =3D (res-&gt;GETATTR3res_u.r=
esok.obj_attributes.used + 512 - 1) / 512;<br>
#endif//WIN32<br>
<br>
<br>
Your patch will eliminate this difference for non WIN32 systems. Please cha=
nge your patch to not implement nfs_get_allocated_file_size and qemu will h=
andle this case properly.<br>
Put everything that involves st_blocks and nfs_get_allocated_file_size in #=
ifndef _WIN32 conditions.<br></blockquote><div>You are right, I&#39;ll fix =
it latter=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
<br>
Peter<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div>

--000000000000921bb205aef1d42f--

