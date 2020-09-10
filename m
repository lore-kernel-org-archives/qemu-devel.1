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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F4FC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 20:37:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A966214F1
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 20:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t/2FtO5V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A966214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGTK4-0005iw-1j
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 16:37:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kGTJL-0005Dv-43; Thu, 10 Sep 2020 16:36:51 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:34563)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kGTJI-0006bo-KI; Thu, 10 Sep 2020 16:36:50 -0400
Received: by mail-lf1-x142.google.com with SMTP id u8so4336198lff.1;
 Thu, 10 Sep 2020 13:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=FNNcZSK2TyrkG3Ga0a7+t5lhM3PMw5j+WULeukY+jds=;
 b=t/2FtO5Vjfnoglf/8y3LWUxh+j2kfiA5rzG+GjjE24Kh087AJnI1uSqrWWN3dTMTfg
 vSEb7kUSgTr3d/YKOVg9LsClftuuLrTyQGcGAX3LlsSzIHffqC4LPRP05bd6EOwqbpOd
 KVCyRgp2SVSFb64It97ofjETNK1x6YhJquNWYUCVPajIVqn0ozs1gZ7f1UZBI9xGVLif
 nRFMnxJD5VjBqoj71MJ0UQYxAaThJdnpnpTVOptd/4TYh+byniTpfGqvHqUn68SF4J60
 ft40tCr+v8O31DEz7Id47zNZCSqE+fkbOw2waMrxq+HoJYbBIykrZwjAweFmmhJNbju8
 LlsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=FNNcZSK2TyrkG3Ga0a7+t5lhM3PMw5j+WULeukY+jds=;
 b=FPY6ijPVH8N82HQAE4B0XApDMNJcBhgYxC+Wh4SozGm1IoVWe70KwLw2AK7JxEj/QU
 8IFZ+09yFtNKpgmSauoReDSs1NP0cQFaVToK4tSi0sp7dz3SBEoHvyUZGBdCjxqS5Wc5
 U6DoU0brXUO8GevY9lLJbiCQzWt4KuO8zD6QWtPa+P5DqlIbFjOkvC6Kw1L5voSAFNpz
 MsVQ1oedESfGx0LYQErsOtnvaxfe7rbJY0DobK1X55t3y0f1PGiAWCdqWFqHwpjTPLD/
 WOkG1ZdJc8aEl0dZq+LTkOFQx9PckLoiCnlFs6AIVGYbPhGOjKCrywtAtQY738o75sY0
 bUlg==
X-Gm-Message-State: AOAM532qINox27bioH+pfKMmBSZxwF5ZVlhrbLkw7/bYvN4wBjm5Y+e3
 MBM2m6e0/GiadxyBPOy39rFC6FQuAmgNfF7LjrM=
X-Google-Smtp-Source: ABdhPJyloT843ytPm4fqMPIGS8jqQpJry5Qq/cADCnOhRt7IM3afxE1P5mqKtj1Pr7Z+7JPGFLBUxQ/p6pnU/ZsyNDA=
X-Received: by 2002:a05:6512:4cb:: with SMTP id
 w11mr5060268lfq.33.1599770205558; 
 Thu, 10 Sep 2020 13:36:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200910103059.987-1-luoyonggang@gmail.com>
 <20200910103059.987-4-luoyonggang@gmail.com>
 <90DDF8F4-4AC0-42E8-85DA-4CC38C066F45@kamp.de>
In-Reply-To: <90DDF8F4-4AC0-42E8-85DA-4CC38C066F45@kamp.de>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Fri, 11 Sep 2020 04:36:33 +0800
Message-ID: <CAE2XoE9LHFovy+nh8z5xGrCzs+goKgJ+iTd67Zt-1k6UPx=Pxg@mail.gmail.com>
Subject: Re: [PATCH v7 03/25] block: Fixes nfs compiling error on msys2/mingw
To: Peter Lieven <pl@kamp.de>
Content-Type: multipart/alternative; boundary="000000000000d31d7005aefb8640"
Received-SPF: pass client-ip=2a00:1450:4864:20::142;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x142.google.com
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
 Paolo Bonzini <pbonzini@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000d31d7005aefb8640
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2020 at 4:16 AM Peter Lieven <pl@kamp.de> wrote:

>
>
> Am 10.09.2020 um 12:30 schrieb Yonggang Luo <luoyonggang@gmail.com>:
>
> These compiling errors are fixed:
> ../block/nfs.c:27:10: fatal error: poll.h: No such file or directory
>   27 | #include <poll.h>
>      |          ^~~~~~~~
> compilation terminated.
>
> ../block/nfs.c:63:5: error: unknown type name 'blkcnt_t'
>   63 |     blkcnt_t st_blocks;
>      |     ^~~~~~~~
> ../block/nfs.c: In function 'nfs_client_open':
> ../block/nfs.c:550:27: error: 'struct _stat64' has no member named
> 'st_blocks'
>  550 |     client->st_blocks =3D st.st_blocks;
>      |                           ^
> ../block/nfs.c: In function 'nfs_get_allocated_file_size':
> ../block/nfs.c:751:41: error: 'struct _stat64' has no member named
> 'st_blocks'
>  751 |     return (task.ret < 0 ? task.ret : st.st_blocks * 512);
>      |                                         ^
> ../block/nfs.c: In function 'nfs_reopen_prepare':
> ../block/nfs.c:805:31: error: 'struct _stat64' has no member named
> 'st_blocks'
>  805 |         client->st_blocks =3D st.st_blocks;
>      |                               ^
> ../block/nfs.c: In function 'nfs_get_allocated_file_size':
> ../block/nfs.c:752:1: error: control reaches end of non-void function
> [-Werror=3Dreturn-type]
>  752 | }
>      | ^
>
> On msys2/mingw, there is no st_blocks in struct _stat64, so we use
> consistence st_size instead.
>
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
> block/nfs.c | 32 +++++++++++++++++++++++++-------
> 1 file changed, 25 insertions(+), 7 deletions(-)
>
> diff --git a/block/nfs.c b/block/nfs.c
> index 61a249a9fc..db6d8c2d2b 100644
> --- a/block/nfs.c
> +++ b/block/nfs.c
> @@ -24,7 +24,9 @@
>
> #include "qemu/osdep.h"
>
> +#if !defined(_WIN32)
> #include <poll.h>
> +#endif
> #include "qemu/config-file.h"
> #include "qemu/error-report.h"
> #include "qapi/error.h"
> @@ -51,6 +53,13 @@
> #define QEMU_NFS_MAX_PAGECACHE_SIZE (8388608 / NFS_BLKSIZE)
> #define QEMU_NFS_MAX_DEBUG_LEVEL 2
>
> +#if defined (_WIN32)
> +#define nfs_stat __stat64
> +typedef long long blkcnt_t;
> +#else
> +#define nfs_stat stat
> +#endif
> +
> typedef struct NFSClient {
>     struct nfs_context *context;
>     struct nfsfh *fh;
> @@ -70,7 +79,7 @@ typedef struct NFSRPC {
>     int ret;
>     int complete;
>     QEMUIOVector *iov;
> -    struct stat *st;
> +    struct nfs_stat *st;
>     Coroutine *co;
>     NFSClient *client;
> } NFSRPC;
> @@ -415,11 +424,20 @@ static void nfs_file_close(BlockDriverState *bs)
>     nfs_client_close(client);
> }
>
> +static blkcnt_t nfs_get_st_blocks(const struct nfs_stat *st)
> +{
> +#if defined(_WIN32)
> +    return (st->st_size + 511) / 512;
> +#else
> +    return st->st_blocks;
> +#endif
> +}
> +
> static int64_t nfs_client_open(NFSClient *client, BlockdevOptionsNfs *opt=
s,
>                                int flags, int open_flags, Error **errp)
> {
>     int64_t ret =3D -EINVAL;
> -    struct stat st;
> +    struct nfs_stat st;
>     char *file =3D NULL, *strp =3D NULL;
>
>     qemu_mutex_init(&client->mutex);
> @@ -545,7 +563,7 @@ static int64_t nfs_client_open(NFSClient *client,
> BlockdevOptionsNfs *opts,
>     }
>
>     ret =3D DIV_ROUND_UP(st.st_size, BDRV_SECTOR_SIZE);
> -    client->st_blocks =3D st.st_blocks;
> +    client->st_blocks =3D nfs_get_st_blocks(&st);
>     client->has_zero_init =3D S_ISREG(st.st_mode);
>     *strp =3D '/';
>     goto out;
> @@ -729,7 +747,7 @@ static int64_t
> nfs_get_allocated_file_size(BlockDriverState *bs)
> {
>     NFSClient *client =3D bs->opaque;
>     NFSRPC task =3D {0};
> -    struct stat st;
> +    struct nfs_stat st;
>
>     if (bdrv_is_read_only(bs) &&
>         !(bs->open_flags & BDRV_O_NOCACHE)) {
> @@ -746,7 +764,7 @@ static int64_t
> nfs_get_allocated_file_size(BlockDriverState *bs)
>     nfs_set_events(client);
>     BDRV_POLL_WHILE(bs, !task.complete);
>
> -    return (task.ret < 0 ? task.ret : st.st_blocks * 512);
> +    return (task.ret < 0 ? task.ret : nfs_get_st_blocks(&st) * 512);
> }
>
> static int coroutine_fn
> @@ -778,7 +796,7 @@ static int nfs_reopen_prepare(BDRVReopenState *state,
>                               BlockReopenQueue *queue, Error **errp)
> {
>     NFSClient *client =3D state->bs->opaque;
> -    struct stat st;
> +    struct nfs_stat st;
>     int ret =3D 0;
>
>     if (state->flags & BDRV_O_RDWR && bdrv_is_read_only(state->bs)) {
> @@ -800,7 +818,7 @@ static int nfs_reopen_prepare(BDRVReopenState *state,
>                        nfs_get_error(client->context));
>             return ret;
>         }
> -        client->st_blocks =3D st.st_blocks;
> +        client->st_blocks =3D nfs_get_st_blocks(&st);
>     }
>
>     return 0;
> --
> 2.28.0.windows.1
>
>
>
> You still implement nfs_get_allocated_file_size without actually returnin=
g
> the allocated file size on WIN32.
> I would simply do this:
>
> *diff --git a/block/nfs.c b/block/nfs.c*
> *index 61a249a..0983143 100644*
> *--- a/block/nfs.c*
> *+++ b/block/nfs.c*
> @@ -24,7 +24,9 @@
>
>
>  #include "qemu/osdep.h"
>
>
> +#if !defined(_WIN32)
>  #include <poll.h>
> +#endif
>  #include "qemu/config-file.h"
>  #include "qemu/error-report.h"
>  #include "qapi/error.h"
> @@ -58,7 +60,9 @@ typedef struct NFSClient {
>      bool has_zero_init;
>      AioContext *aio_context;
>      QemuMutex mutex;
> +#if !defined(_WIN32)
>      blkcnt_t st_blocks;
> +#endif
>      bool cache_used;
>      NFSServer *server;
>      char *path;
> @@ -545,7 +549,9 @@ static int64_t nfs_client_open(NFSClient *client,
> BlockdevOptionsNfs *opts,
>      }
>
>
>      ret =3D DIV_ROUND_UP(st.st_size, BDRV_SECTOR_SIZE);
> +#if !defined(_WIN32)
>      client->st_blocks =3D st.st_blocks;
> +#endif
>      client->has_zero_init =3D S_ISREG(st.st_mode);
>      *strp =3D '/';
>      goto out;
> @@ -706,6 +712,8 @@ static int nfs_has_zero_init(BlockDriverState *bs)
>      return client->has_zero_init;
>  }
>
>
> +
> +#if !defined(_WIN32)
>  /* Called (via nfs_service) with QemuMutex held.  */
>  static void
>  nfs_get_allocated_file_size_cb(int ret, struct nfs_context *nfs, void
> *data,
> @@ -748,6 +756,7 @@ static int64_t
> nfs_get_allocated_file_size(BlockDriverState *bs)
>
>
>      return (task.ret < 0 ? task.ret : st.st_blocks * 512);
>  }
> +#endif
>
>
>  static int coroutine_fn
>  nfs_file_co_truncate(BlockDriverState *bs, int64_t offset, bool exact,
> @@ -792,6 +801,7 @@ static int nfs_reopen_prepare(BDRVReopenState *state,
>          return -EINVAL;
>      }
>
>
> +#if !defined(_WIN32)
>      /* Update cache for read-only reopens */
>      if (!(state->flags & BDRV_O_RDWR)) {
>          ret =3D nfs_fstat(client->context, client->fh, &st);
> @@ -802,6 +812,7 @@ static int nfs_reopen_prepare(BDRVReopenState *state,
>          }
>          client->st_blocks =3D st.st_blocks;
>      }
> +#endif
>
>
>      return 0;
>  }
> @@ -869,7 +880,9 @@ static BlockDriver bdrv_nfs =3D {
>      .create_opts                    =3D &nfs_create_opts,
>
>
>      .bdrv_has_zero_init             =3D nfs_has_zero_init,
> +#if !defined(_WIN32)
>      .bdrv_get_allocated_file_size   =3D nfs_get_allocated_file_size,
> +#endif
>      .bdrv_co_truncate               =3D nfs_file_co_truncate,
>
>
>      .bdrv_file_open                 =3D nfs_file_open,
>
>
> Best,
> Peter
>
Any git repo have this patch? I can cherry-pick it directly


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000d31d7005aefb8640
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Sep 11, 2020 at 4:16 AM Peter=
 Lieven &lt;<a href=3D"mailto:pl@kamp.de">pl@kamp.de</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex"><div style=3D"overflow-=
wrap: break-word;"><br><div><br><blockquote type=3D"cite"><div>Am 10.09.202=
0 um 12:30 schrieb Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.com=
" target=3D"_blank">luoyonggang@gmail.com</a>&gt;:</div><br><div><div>These=
 compiling errors are fixed:<br>../block/nfs.c:27:10: fatal error: poll.h: =
No such file or directory<br> =C2=A0=C2=A027 | #include &lt;poll.h&gt;<br> =
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0^~~~~~~~<br>compilation terminated.<br><br>../block/nfs.c:63:5:=
 error: unknown type name &#39;blkcnt_t&#39;<br> =C2=A0=C2=A063 | =C2=A0=C2=
=A0=C2=A0=C2=A0blkcnt_t st_blocks;<br> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| =C2=
=A0=C2=A0=C2=A0=C2=A0^~~~~~~~<br>../block/nfs.c: In function &#39;nfs_clien=
t_open&#39;:<br>../block/nfs.c:550:27: error: &#39;struct _stat64&#39; has =
no member named &#39;st_blocks&#39;<br> =C2=A0550 | =C2=A0=C2=A0=C2=A0=C2=
=A0client-&gt;st_blocks =3D st.st_blocks;<br> =C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0| =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0^<br>../block/nfs.c: In function &#39;nfs_get_allocated_file_si=
ze&#39;:<br>../block/nfs.c:751:41: error: &#39;struct _stat64&#39; has no m=
ember named &#39;st_blocks&#39;<br> =C2=A0751 | =C2=A0=C2=A0=C2=A0=C2=A0ret=
urn (task.ret &lt; 0 ? task.ret : st.st_blocks * 512);<br> =C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0| =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^<br>../block/nfs.c: In function &#39;nfs_=
reopen_prepare&#39;:<br>../block/nfs.c:805:31: error: &#39;struct _stat64&#=
39; has no member named &#39;st_blocks&#39;<br> =C2=A0805 | =C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0client-&gt;st_blocks =3D st.st_blocks;<br>=
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0^<br>../bloc=
k/nfs.c: In function &#39;nfs_get_allocated_file_size&#39;:<br>../block/nfs=
.c:752:1: error: control reaches end of non-void function [-Werror=3Dreturn=
-type]<br> =C2=A0752 | }<br> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| ^<br><br>On ms=
ys2/mingw, there is no st_blocks in struct _stat64, so we use consistence s=
t_size instead.<br><br>Signed-off-by: Yonggang Luo &lt;<a href=3D"mailto:lu=
oyonggang@gmail.com" target=3D"_blank">luoyonggang@gmail.com</a>&gt;<br>---=
<br> block/nfs.c | 32 +++++++++++++++++++++++++-------<br> 1 file changed, =
25 insertions(+), 7 deletions(-)<br><br>diff --git a/block/nfs.c b/block/nf=
s.c<br>index 61a249a9fc..db6d8c2d2b 100644<br>--- a/block/nfs.c<br>+++ b/bl=
ock/nfs.c<br>@@ -24,7 +24,9 @@<br><br> #include &quot;qemu/osdep.h&quot;<br=
><br>+#if !defined(_WIN32)<br> #include &lt;poll.h&gt;<br>+#endif<br> #incl=
ude &quot;qemu/config-file.h&quot;<br> #include &quot;qemu/error-report.h&q=
uot;<br> #include &quot;qapi/error.h&quot;<br>@@ -51,6 +53,13 @@<br> #defin=
e QEMU_NFS_MAX_PAGECACHE_SIZE (8388608 / NFS_BLKSIZE)<br> #define QEMU_NFS_=
MAX_DEBUG_LEVEL 2<br><br>+#if defined (_WIN32)<br>+#define nfs_stat __stat6=
4<br>+typedef long long blkcnt_t;<br>+#else<br>+#define nfs_stat stat<br>+#=
endif<br>+<br> typedef struct NFSClient {<br> =C2=A0=C2=A0=C2=A0=C2=A0struc=
t nfs_context *context;<br> =C2=A0=C2=A0=C2=A0=C2=A0struct nfsfh *fh;<br>@@=
 -70,7 +79,7 @@ typedef struct NFSRPC {<br> =C2=A0=C2=A0=C2=A0=C2=A0int ret=
;<br> =C2=A0=C2=A0=C2=A0=C2=A0int complete;<br> =C2=A0=C2=A0=C2=A0=C2=A0QEM=
UIOVector *iov;<br>- =C2=A0=C2=A0=C2=A0struct stat *st;<br>+ =C2=A0=C2=A0=
=C2=A0struct nfs_stat *st;<br> =C2=A0=C2=A0=C2=A0=C2=A0Coroutine *co;<br> =
=C2=A0=C2=A0=C2=A0=C2=A0NFSClient *client;<br> } NFSRPC;<br>@@ -415,11 +424=
,20 @@ static void nfs_file_close(BlockDriverState *bs)<br> =C2=A0=C2=A0=C2=
=A0=C2=A0nfs_client_close(client);<br> }<br><br>+static blkcnt_t nfs_get_st=
_blocks(const struct nfs_stat *st)<br>+{<br>+#if defined(_WIN32)<br>+ =C2=
=A0=C2=A0=C2=A0return (st-&gt;st_size + 511) / 512;<br>+#else<br>+ =C2=A0=
=C2=A0=C2=A0return st-&gt;st_blocks;<br>+#endif<br>+}<br>+<br> static int64=
_t nfs_client_open(NFSClient *client, BlockdevOptionsNfs *opts,<br> =C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int flags, int open_flags, Error **errp)<br> =
{<br> =C2=A0=C2=A0=C2=A0=C2=A0int64_t ret =3D -EINVAL;<br>- =C2=A0=C2=A0=C2=
=A0struct stat st;<br>+ =C2=A0=C2=A0=C2=A0struct nfs_stat st;<br> =C2=A0=C2=
=A0=C2=A0=C2=A0char *file =3D NULL, *strp =3D NULL;<br><br> =C2=A0=C2=A0=C2=
=A0=C2=A0qemu_mutex_init(&amp;client-&gt;mutex);<br>@@ -545,7 +563,7 @@ sta=
tic int64_t nfs_client_open(NFSClient *client, BlockdevOptionsNfs *opts,<br=
> =C2=A0=C2=A0=C2=A0=C2=A0}<br><br> =C2=A0=C2=A0=C2=A0=C2=A0ret =3D DIV_ROU=
ND_UP(st.st_size, BDRV_SECTOR_SIZE);<br>- =C2=A0=C2=A0=C2=A0client-&gt;st_b=
locks =3D st.st_blocks;<br>+ =C2=A0=C2=A0=C2=A0client-&gt;st_blocks =3D nfs=
_get_st_blocks(&amp;st);<br> =C2=A0=C2=A0=C2=A0=C2=A0client-&gt;has_zero_in=
it =3D S_ISREG(st.st_mode);<br> =C2=A0=C2=A0=C2=A0=C2=A0*strp =3D &#39;/&#3=
9;;<br> =C2=A0=C2=A0=C2=A0=C2=A0goto out;<br>@@ -729,7 +747,7 @@ static int=
64_t nfs_get_allocated_file_size(BlockDriverState *bs)<br> {<br> =C2=A0=C2=
=A0=C2=A0=C2=A0NFSClient *client =3D bs-&gt;opaque;<br> =C2=A0=C2=A0=C2=A0=
=C2=A0NFSRPC task =3D {0};<br>- =C2=A0=C2=A0=C2=A0struct stat st;<br>+ =C2=
=A0=C2=A0=C2=A0struct nfs_stat st;<br><br> =C2=A0=C2=A0=C2=A0=C2=A0if (bdrv=
_is_read_only(bs) &amp;&amp;<br> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0!(bs-&gt;open_flags &amp; BDRV_O_NOCACHE)) {<br>@@ -746,7 +764,7 @@ s=
tatic int64_t nfs_get_allocated_file_size(BlockDriverState *bs)<br> =C2=A0=
=C2=A0=C2=A0=C2=A0nfs_set_events(client);<br> =C2=A0=C2=A0=C2=A0=C2=A0BDRV_=
POLL_WHILE(bs, !task.complete);<br><br>- =C2=A0=C2=A0=C2=A0return (task.ret=
 &lt; 0 ? task.ret : st.st_blocks * 512);<br>+ =C2=A0=C2=A0=C2=A0return (ta=
sk.ret &lt; 0 ? task.ret : nfs_get_st_blocks(&amp;st) * 512);<br> }<br><br>=
 static int coroutine_fn<br>@@ -778,7 +796,7 @@ static int nfs_reopen_prepa=
re(BDRVReopenState *state,<br> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0BlockReopenQ=
ueue *queue, Error **errp)<br> {<br> =C2=A0=C2=A0=C2=A0=C2=A0NFSClient *cli=
ent =3D state-&gt;bs-&gt;opaque;<br>- =C2=A0=C2=A0=C2=A0struct stat st;<br>=
+ =C2=A0=C2=A0=C2=A0struct nfs_stat st;<br> =C2=A0=C2=A0=C2=A0=C2=A0int ret=
 =3D 0;<br><br> =C2=A0=C2=A0=C2=A0=C2=A0if (state-&gt;flags &amp; BDRV_O_RD=
WR &amp;&amp; bdrv_is_read_only(state-&gt;bs)) {<br>@@ -800,7 +818,7 @@ sta=
tic int nfs_reopen_prepare(BDRVReopenState *state,<br> =C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0nfs_get_error(client-&gt;conte=
xt));<br> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0return ret;<br> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}<=
br>- =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0client-&gt;st_blocks =3D st.=
st_blocks;<br>+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0client-&gt;st_blo=
cks =3D nfs_get_st_blocks(&amp;st);<br> =C2=A0=C2=A0=C2=A0=C2=A0}<br><br> =
=C2=A0=C2=A0=C2=A0=C2=A0return 0;<br>-- <br>2.28.0.windows.1<br></div></div=
></blockquote><div><br></div><div><br></div>You still implement nfs_get_all=
ocated_file_size without actually returning the allocated file size on WIN3=
2.=C2=A0</div><div>I would simply do this:</div><div><br></div><div><div st=
yle=3D"margin:0px;font-stretch:normal;font-size:11px;line-height:normal;fon=
t-family:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-c=
ommon-ligatures"><b>diff --git a/block/nfs.c b/block/nfs.c</b></span></div>=
<div style=3D"margin:0px;font-stretch:normal;font-size:11px;line-height:nor=
mal;font-family:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatur=
es:no-common-ligatures"><b>index 61a249a..0983143 100644</b></span></div><d=
iv style=3D"margin:0px;font-stretch:normal;font-size:11px;line-height:norma=
l;font-family:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures=
:no-common-ligatures"><b>--- a/block/nfs.c</b></span></div><div style=3D"ma=
rgin:0px;font-stretch:normal;font-size:11px;line-height:normal;font-family:=
Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-lig=
atures"><b>+++ b/block/nfs.c</b></span></div><div style=3D"margin:0px;font-=
stretch:normal;font-size:11px;line-height:normal;font-family:Menlo;color:rg=
b(56,185,199)"><span style=3D"font-variant-ligatures:no-common-ligatures">@=
@ -24,7 +24,9 @@</span></div><p style=3D"margin:0px;font-stretch:normal;fon=
t-size:11px;line-height:normal;font-family:Menlo;color:rgb(0,0,0);min-heigh=
t:13px"><span style=3D"font-variant-ligatures:no-common-ligatures">=C2=A0</=
span><br></p><div style=3D"margin:0px;font-stretch:normal;font-size:11px;li=
ne-height:normal;font-family:Menlo;color:rgb(0,0,0)"><span style=3D"font-va=
riant-ligatures:no-common-ligatures">=C2=A0#include &quot;qemu/osdep.h&quot=
;</span></div><p style=3D"margin:0px;font-stretch:normal;font-size:11px;lin=
e-height:normal;font-family:Menlo;color:rgb(0,0,0);min-height:13px"><span s=
tyle=3D"font-variant-ligatures:no-common-ligatures">=C2=A0</span><br></p><d=
iv style=3D"margin:0px;font-stretch:normal;font-size:11px;line-height:norma=
l;font-family:Menlo;color:rgb(57,192,38)"><span style=3D"font-variant-ligat=
ures:no-common-ligatures">+#if !defined(_WIN32)</span></div><div style=3D"m=
argin:0px;font-stretch:normal;font-size:11px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">=C2=A0#include &lt;poll.h&gt;</span></div><div style=3D"margin:0px=
;font-stretch:normal;font-size:11px;line-height:normal;font-family:Menlo;co=
lor:rgb(57,192,38)"><span style=3D"font-variant-ligatures:no-common-ligatur=
es">+#endif</span></div><div style=3D"margin:0px;font-stretch:normal;font-s=
ize:11px;line-height:normal;font-family:Menlo;color:rgb(0,0,0)"><span style=
=3D"font-variant-ligatures:no-common-ligatures">=C2=A0#include &quot;qemu/c=
onfig-file.h&quot;</span></div><div style=3D"margin:0px;font-stretch:normal=
;font-size:11px;line-height:normal;font-family:Menlo;color:rgb(0,0,0)"><spa=
n style=3D"font-variant-ligatures:no-common-ligatures">=C2=A0#include &quot=
;qemu/error-report.h&quot;</span></div><div style=3D"margin:0px;font-stretc=
h:normal;font-size:11px;line-height:normal;font-family:Menlo;color:rgb(0,0,=
0)"><span style=3D"font-variant-ligatures:no-common-ligatures">=C2=A0#inclu=
de &quot;qapi/error.h&quot;</span></div><div style=3D"margin:0px;font-stret=
ch:normal;font-size:11px;line-height:normal;font-family:Menlo;color:rgb(0,0=
,0)"><span style=3D"font-variant-ligatures:no-common-ligatures;color:rgb(56=
,185,199)">@@ -58,7 +60,9 @@</span><span style=3D"font-variant-ligatures:no=
-common-ligatures"> typedef struct NFSClient {</span></div><div style=3D"ma=
rgin:0px;font-stretch:normal;font-size:11px;line-height:normal;font-family:=
Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-lig=
atures">=C2=A0=C2=A0 =C2=A0 bool has_zero_init;</span></div><div style=3D"m=
argin:0px;font-stretch:normal;font-size:11px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">=C2=A0=C2=A0 =C2=A0 AioContext *aio_context;</span></div><div styl=
e=3D"margin:0px;font-stretch:normal;font-size:11px;line-height:normal;font-=
family:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-com=
mon-ligatures">=C2=A0=C2=A0 =C2=A0 QemuMutex mutex;</span></div><div style=
=3D"margin:0px;font-stretch:normal;font-size:11px;line-height:normal;font-f=
amily:Menlo;color:rgb(57,192,38)"><span style=3D"font-variant-ligatures:no-=
common-ligatures">+#if !defined(_WIN32)</span></div><div style=3D"margin:0p=
x;font-stretch:normal;font-size:11px;line-height:normal;font-family:Menlo;c=
olor:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-ligatures"=
>=C2=A0=C2=A0 =C2=A0 blkcnt_t st_blocks;</span></div><div style=3D"margin:0=
px;font-stretch:normal;font-size:11px;line-height:normal;font-family:Menlo;=
color:rgb(57,192,38)"><span style=3D"font-variant-ligatures:no-common-ligat=
ures">+#endif</span></div><div style=3D"margin:0px;font-stretch:normal;font=
-size:11px;line-height:normal;font-family:Menlo;color:rgb(0,0,0)"><span sty=
le=3D"font-variant-ligatures:no-common-ligatures">=C2=A0=C2=A0 =C2=A0 bool =
cache_used;</span></div><div style=3D"margin:0px;font-stretch:normal;font-s=
ize:11px;line-height:normal;font-family:Menlo;color:rgb(0,0,0)"><span style=
=3D"font-variant-ligatures:no-common-ligatures">=C2=A0=C2=A0 =C2=A0 NFSServ=
er *server;</span></div><div style=3D"margin:0px;font-stretch:normal;font-s=
ize:11px;line-height:normal;font-family:Menlo;color:rgb(0,0,0)"><span style=
=3D"font-variant-ligatures:no-common-ligatures">=C2=A0=C2=A0 =C2=A0 char *p=
ath;</span></div><div style=3D"margin:0px;font-stretch:normal;font-size:11p=
x;line-height:normal;font-family:Menlo;color:rgb(0,0,0)"><span style=3D"fon=
t-variant-ligatures:no-common-ligatures;color:rgb(56,185,199)">@@ -545,7 +5=
49,9 @@</span><span style=3D"font-variant-ligatures:no-common-ligatures"> s=
tatic int64_t nfs_client_open(NFSClient *client, BlockdevOptionsNfs *opts,<=
/span></div><div style=3D"margin:0px;font-stretch:normal;font-size:11px;lin=
e-height:normal;font-family:Menlo;color:rgb(0,0,0)"><span style=3D"font-var=
iant-ligatures:no-common-ligatures">=C2=A0=C2=A0 =C2=A0 }</span></div><p st=
yle=3D"margin:0px;font-stretch:normal;font-size:11px;line-height:normal;fon=
t-family:Menlo;color:rgb(0,0,0);min-height:13px"><span style=3D"font-varian=
t-ligatures:no-common-ligatures">=C2=A0</span><br></p><div style=3D"margin:=
0px;font-stretch:normal;font-size:11px;line-height:normal;font-family:Menlo=
;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-ligature=
s">=C2=A0=C2=A0 =C2=A0 ret =3D DIV_ROUND_UP(st.st_size, BDRV_SECTOR_SIZE);<=
/span></div><div style=3D"margin:0px;font-stretch:normal;font-size:11px;lin=
e-height:normal;font-family:Menlo;color:rgb(57,192,38)"><span style=3D"font=
-variant-ligatures:no-common-ligatures">+#if !defined(_WIN32)</span></div><=
div style=3D"margin:0px;font-stretch:normal;font-size:11px;line-height:norm=
al;font-family:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligature=
s:no-common-ligatures">=C2=A0=C2=A0 =C2=A0 client-&gt;st_blocks =3D st.st_b=
locks;</span></div><div style=3D"margin:0px;font-stretch:normal;font-size:1=
1px;line-height:normal;font-family:Menlo;color:rgb(57,192,38)"><span style=
=3D"font-variant-ligatures:no-common-ligatures">+#endif</span></div><div st=
yle=3D"margin:0px;font-stretch:normal;font-size:11px;line-height:normal;fon=
t-family:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-c=
ommon-ligatures">=C2=A0=C2=A0 =C2=A0 client-&gt;has_zero_init =3D S_ISREG(s=
t.st_mode);</span></div><div style=3D"margin:0px;font-stretch:normal;font-s=
ize:11px;line-height:normal;font-family:Menlo;color:rgb(0,0,0)"><span style=
=3D"font-variant-ligatures:no-common-ligatures">=C2=A0=C2=A0 =C2=A0 *strp =
=3D &#39;/&#39;;</span></div><div style=3D"margin:0px;font-stretch:normal;f=
ont-size:11px;line-height:normal;font-family:Menlo;color:rgb(0,0,0)"><span =
style=3D"font-variant-ligatures:no-common-ligatures">=C2=A0=C2=A0 =C2=A0 go=
to out;</span></div><div style=3D"margin:0px;font-stretch:normal;font-size:=
11px;line-height:normal;font-family:Menlo;color:rgb(0,0,0)"><span style=3D"=
font-variant-ligatures:no-common-ligatures;color:rgb(56,185,199)">@@ -706,6=
 +712,8 @@</span><span style=3D"font-variant-ligatures:no-common-ligatures"=
> static int nfs_has_zero_init(BlockDriverState *bs)</span></div><div style=
=3D"margin:0px;font-stretch:normal;font-size:11px;line-height:normal;font-f=
amily:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-comm=
on-ligatures">=C2=A0=C2=A0 =C2=A0 return client-&gt;has_zero_init;</span></=
div><div style=3D"margin:0px;font-stretch:normal;font-size:11px;line-height=
:normal;font-family:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-lig=
atures:no-common-ligatures">=C2=A0}</span></div><p style=3D"margin:0px;font=
-stretch:normal;font-size:11px;line-height:normal;font-family:Menlo;color:r=
gb(0,0,0);min-height:13px"><span style=3D"font-variant-ligatures:no-common-=
ligatures">=C2=A0</span><br></p><div style=3D"margin:0px;font-stretch:norma=
l;font-size:11px;line-height:normal;font-family:Menlo;color:rgb(57,192,38)"=
><span style=3D"font-variant-ligatures:no-common-ligatures">+</span></div><=
div style=3D"margin:0px;font-stretch:normal;font-size:11px;line-height:norm=
al;font-family:Menlo;color:rgb(57,192,38)"><span style=3D"font-variant-liga=
tures:no-common-ligatures">+#if !defined(_WIN32)</span></div><div style=3D"=
margin:0px;font-stretch:normal;font-size:11px;line-height:normal;font-famil=
y:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-l=
igatures">=C2=A0/* Called (via nfs_service) with QemuMutex held.=C2=A0 */</=
span></div><div style=3D"margin:0px;font-stretch:normal;font-size:11px;line=
-height:normal;font-family:Menlo;color:rgb(0,0,0)"><span style=3D"font-vari=
ant-ligatures:no-common-ligatures">=C2=A0static void</span></div><div style=
=3D"margin:0px;font-stretch:normal;font-size:11px;line-height:normal;font-f=
amily:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-comm=
on-ligatures">=C2=A0nfs_get_allocated_file_size_cb(int ret, struct nfs_cont=
ext *nfs, void *data,</span></div><div style=3D"margin:0px;font-stretch:nor=
mal;font-size:11px;line-height:normal;font-family:Menlo;color:rgb(0,0,0)"><=
span style=3D"font-variant-ligatures:no-common-ligatures;color:rgb(56,185,1=
99)">@@ -748,6 +756,7 @@</span><span style=3D"font-variant-ligatures:no-com=
mon-ligatures"> static int64_t nfs_get_allocated_file_size(BlockDriverState=
 *bs)</span></div><p style=3D"margin:0px;font-stretch:normal;font-size:11px=
;line-height:normal;font-family:Menlo;color:rgb(0,0,0);min-height:13px"><sp=
an style=3D"font-variant-ligatures:no-common-ligatures">=C2=A0</span><br></=
p><div style=3D"margin:0px;font-stretch:normal;font-size:11px;line-height:n=
ormal;font-family:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligat=
ures:no-common-ligatures">=C2=A0=C2=A0 =C2=A0 return (task.ret &lt; 0 ? tas=
k.ret : st.st_blocks * 512);</span></div><div style=3D"margin:0px;font-stre=
tch:normal;font-size:11px;line-height:normal;font-family:Menlo;color:rgb(0,=
0,0)"><span style=3D"font-variant-ligatures:no-common-ligatures">=C2=A0}</s=
pan></div><div style=3D"margin:0px;font-stretch:normal;font-size:11px;line-=
height:normal;font-family:Menlo;color:rgb(57,192,38)"><span style=3D"font-v=
ariant-ligatures:no-common-ligatures">+#endif</span></div><p style=3D"margi=
n:0px;font-stretch:normal;font-size:11px;line-height:normal;font-family:Men=
lo;color:rgb(0,0,0);min-height:13px"><span style=3D"font-variant-ligatures:=
no-common-ligatures">=C2=A0</span><br></p><div style=3D"margin:0px;font-str=
etch:normal;font-size:11px;line-height:normal;font-family:Menlo;color:rgb(0=
,0,0)"><span style=3D"font-variant-ligatures:no-common-ligatures">=C2=A0sta=
tic int coroutine_fn</span></div><div style=3D"margin:0px;font-stretch:norm=
al;font-size:11px;line-height:normal;font-family:Menlo;color:rgb(0,0,0)"><s=
pan style=3D"font-variant-ligatures:no-common-ligatures">=C2=A0nfs_file_co_=
truncate(BlockDriverState *bs, int64_t offset, bool exact,</span></div><div=
 style=3D"margin:0px;font-stretch:normal;font-size:11px;line-height:normal;=
font-family:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:n=
o-common-ligatures;color:rgb(56,185,199)">@@ -792,6 +801,7 @@</span><span s=
tyle=3D"font-variant-ligatures:no-common-ligatures"> static int nfs_reopen_=
prepare(BDRVReopenState *state,</span></div><div style=3D"margin:0px;font-s=
tretch:normal;font-size:11px;line-height:normal;font-family:Menlo;color:rgb=
(0,0,0)"><span style=3D"font-variant-ligatures:no-common-ligatures">=C2=A0=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;</span></div><div style=3D"margi=
n:0px;font-stretch:normal;font-size:11px;line-height:normal;font-family:Men=
lo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-ligatu=
res">=C2=A0=C2=A0 =C2=A0 }</span></div><p style=3D"margin:0px;font-stretch:=
normal;font-size:11px;line-height:normal;font-family:Menlo;color:rgb(0,0,0)=
;min-height:13px"><span style=3D"font-variant-ligatures:no-common-ligatures=
">=C2=A0</span><br></p><div style=3D"margin:0px;font-stretch:normal;font-si=
ze:11px;line-height:normal;font-family:Menlo;color:rgb(57,192,38)"><span st=
yle=3D"font-variant-ligatures:no-common-ligatures">+#if !defined(_WIN32)</s=
pan></div><div style=3D"margin:0px;font-stretch:normal;font-size:11px;line-=
height:normal;font-family:Menlo;color:rgb(0,0,0)"><span style=3D"font-varia=
nt-ligatures:no-common-ligatures">=C2=A0=C2=A0 =C2=A0 /* Update cache for r=
ead-only reopens */</span></div><div style=3D"margin:0px;font-stretch:norma=
l;font-size:11px;line-height:normal;font-family:Menlo;color:rgb(0,0,0)"><sp=
an style=3D"font-variant-ligatures:no-common-ligatures">=C2=A0=C2=A0 =C2=A0=
 if (!(state-&gt;flags &amp; BDRV_O_RDWR)) {</span></div><div style=3D"marg=
in:0px;font-stretch:normal;font-size:11px;line-height:normal;font-family:Me=
nlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-ligat=
ures">=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D nfs_fstat(client-&gt;contex=
t, client-&gt;fh, &amp;st);</span></div><div style=3D"margin:0px;font-stret=
ch:normal;font-size:11px;line-height:normal;font-family:Menlo;color:rgb(0,0=
,0)"><span style=3D"font-variant-ligatures:no-common-ligatures;color:rgb(56=
,185,199)">@@ -802,6 +812,7 @@</span><span style=3D"font-variant-ligatures:=
no-common-ligatures"> static int nfs_reopen_prepare(BDRVReopenState *state,=
</span></div><div style=3D"margin:0px;font-stretch:normal;font-size:11px;li=
ne-height:normal;font-family:Menlo;color:rgb(0,0,0)"><span style=3D"font-va=
riant-ligatures:no-common-ligatures">=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 }</s=
pan></div><div style=3D"margin:0px;font-stretch:normal;font-size:11px;line-=
height:normal;font-family:Menlo;color:rgb(0,0,0)"><span style=3D"font-varia=
nt-ligatures:no-common-ligatures">=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 client-=
&gt;st_blocks =3D st.st_blocks;</span></div><div style=3D"margin:0px;font-s=
tretch:normal;font-size:11px;line-height:normal;font-family:Menlo;color:rgb=
(0,0,0)"><span style=3D"font-variant-ligatures:no-common-ligatures">=C2=A0=
=C2=A0 =C2=A0 }</span></div><div style=3D"margin:0px;font-stretch:normal;fo=
nt-size:11px;line-height:normal;font-family:Menlo;color:rgb(57,192,38)"><sp=
an style=3D"font-variant-ligatures:no-common-ligatures">+#endif</span></div=
><p style=3D"margin:0px;font-stretch:normal;font-size:11px;line-height:norm=
al;font-family:Menlo;color:rgb(0,0,0);min-height:13px"><span style=3D"font-=
variant-ligatures:no-common-ligatures">=C2=A0</span><br></p><div style=3D"m=
argin:0px;font-stretch:normal;font-size:11px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">=C2=A0=C2=A0 =C2=A0 return 0;</span></div><div style=3D"margin:0px=
;font-stretch:normal;font-size:11px;line-height:normal;font-family:Menlo;co=
lor:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-ligatures">=
=C2=A0}</span></div><div style=3D"margin:0px;font-stretch:normal;font-size:=
11px;line-height:normal;font-family:Menlo;color:rgb(0,0,0)"><span style=3D"=
font-variant-ligatures:no-common-ligatures;color:rgb(56,185,199)">@@ -869,7=
 +880,9 @@</span><span style=3D"font-variant-ligatures:no-common-ligatures"=
> static BlockDriver bdrv_nfs =3D {</span></div><div style=3D"margin:0px;fo=
nt-stretch:normal;font-size:11px;line-height:normal;font-family:Menlo;color=
:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-ligatures">=C2=
=A0=C2=A0 =C2=A0 .create_opts=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =3D &amp;nfs_create_opts,</span></div><p style=3D"=
margin:0px;font-stretch:normal;font-size:11px;line-height:normal;font-famil=
y:Menlo;color:rgb(0,0,0);min-height:13px"><span style=3D"font-variant-ligat=
ures:no-common-ligatures">=C2=A0</span><br></p><div style=3D"margin:0px;fon=
t-stretch:normal;font-size:11px;line-height:normal;font-family:Menlo;color:=
rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-ligatures">=C2=
=A0=C2=A0 =C2=A0 .bdrv_has_zero_init =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =3D nfs_has_zero_init,</span></div><div style=3D"margin:0px;font-stretc=
h:normal;font-size:11px;line-height:normal;font-family:Menlo;color:rgb(57,1=
92,38)"><span style=3D"font-variant-ligatures:no-common-ligatures">+#if !de=
fined(_WIN32)</span></div><div style=3D"margin:0px;font-stretch:normal;font=
-size:11px;line-height:normal;font-family:Menlo;color:rgb(0,0,0)"><span sty=
le=3D"font-variant-ligatures:no-common-ligatures">=C2=A0=C2=A0 =C2=A0 .bdrv=
_get_allocated_file_size =C2=A0 =3D nfs_get_allocated_file_size,</span></di=
v><div style=3D"margin:0px;font-stretch:normal;font-size:11px;line-height:n=
ormal;font-family:Menlo;color:rgb(57,192,38)"><span style=3D"font-variant-l=
igatures:no-common-ligatures">+#endif</span></div><div style=3D"margin:0px;=
font-stretch:normal;font-size:11px;line-height:normal;font-family:Menlo;col=
or:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-ligatures">=
=C2=A0=C2=A0 =C2=A0 .bdrv_co_truncate =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =3D nfs_file_co_truncate,</span></div><p style=3D"margin:0px;=
font-stretch:normal;font-size:11px;line-height:normal;font-family:Menlo;col=
or:rgb(0,0,0);min-height:13px"><span style=3D"font-variant-ligatures:no-com=
mon-ligatures">=C2=A0</span><br></p><div style=3D"margin:0px;font-stretch:n=
ormal;font-size:11px;line-height:normal;font-family:Menlo;color:rgb(0,0,0)"=
><span style=3D"font-variant-ligatures:no-common-ligatures">=C2=A0=C2=A0 =
=C2=A0 .bdrv_file_open =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =3D nfs_file_open,</span></div><div style=3D"margin:0px;font-stretch:no=
rmal;font-size:11px;line-height:normal;font-family:Menlo;color:rgb(0,0,0)">=
<span style=3D"font-variant-ligatures:no-common-ligatures"><br></span></div=
><div style=3D"margin:0px;font-stretch:normal;font-size:11px;line-height:no=
rmal;font-family:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatu=
res:no-common-ligatures"><br></span></div><div style=3D"margin:0px;font-str=
etch:normal;font-size:11px;line-height:normal;font-family:Menlo;color:rgb(0=
,0,0)"><span style=3D"font-variant-ligatures:no-common-ligatures">Best,</sp=
an></div><div style=3D"margin:0px;font-stretch:normal;font-size:11px;line-h=
eight:normal;font-family:Menlo;color:rgb(0,0,0)"><span style=3D"font-varian=
t-ligatures:no-common-ligatures">Peter</span></div></div></div></blockquote=
><div>Any git repo have this patch? I can cherry-pick it directly=C2=A0</di=
v></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=87=B4<br>=E7=
=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<=
br>Yonggang Luo<br></div></div>

--000000000000d31d7005aefb8640--

