Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D57CEC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 07:30:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BFC7206B7
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 07:30:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BFC7206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kamp.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGH2V-0004hG-2t
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 03:30:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37270)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pl@kamp.de>)
 id 1kGH1c-0003ty-7f; Thu, 10 Sep 2020 03:29:44 -0400
Received: from kerio.kamp.de ([195.62.97.192]:60700)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pl@kamp.de>)
 id 1kGH1Z-00059s-PZ; Thu, 10 Sep 2020 03:29:43 -0400
X-Footer: a2FtcC5kZQ==
Received: from [82.141.7.17] ([79.200.90.160]) (authenticated user pl@kamp.de)
 by kerio.kamp.de with ESMTPSA
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
 Thu, 10 Sep 2020 09:29:25 +0200
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH v2 01/21] block: Fixes nfs compiling error on msys2/mingw
From: Peter Lieven <pl@kamp.de>
In-Reply-To: <CAE2XoE-bTGqfVe-5cCuZGBrsG9FVz6pomRU0-omCF9JiGNcSCA@mail.gmail.com>
Date: Thu, 10 Sep 2020 09:29:26 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <F3949E8A-E95E-4C14-A5F4-039381CA30CD@kamp.de>
References: <20200909094617.1582-1-luoyonggang@gmail.com>
 <20200909094617.1582-2-luoyonggang@gmail.com>
 <D8F68C97-16F7-48DA-A003-275A7C0D08F3@kamp.de>
 <CAE2XoE-bTGqfVe-5cCuZGBrsG9FVz6pomRU0-omCF9JiGNcSCA@mail.gmail.com>
To: Yonggang Luo <luoyonggang@gmail.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Received-SPF: pass client-ip=195.62.97.192; envelope-from=pl@kamp.de;
 helo=kerio.kamp.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 03:01:48
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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



> Am 10.09.2020 um 09:14 schrieb =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang =
Luo) <luoyonggang@gmail.com>:
>=20
>=20
>=20
> On Thu, Sep 10, 2020 at 3:01 PM Peter Lieven <pl@kamp.de> wrote:
>=20
>=20
> > Am 09.09.2020 um 11:45 schrieb Yonggang Luo <luoyonggang@gmail.com>:
> >=20
> > These compiling errors are fixed:
> > ../block/nfs.c:27:10: fatal error: poll.h: No such file or directory
> >   27 | #include <poll.h>
> >      |          ^~~~~~~~
> > compilation terminated.
> >=20
> > ../block/nfs.c:63:5: error: unknown type name 'blkcnt_t'
> >   63 |     blkcnt_t st_blocks;
> >      |     ^~~~~~~~
> > ../block/nfs.c: In function 'nfs_client_open':
> > ../block/nfs.c:550:27: error: 'struct _stat64' has no member named =
'st_blocks'
> >  550 |     client->st_blocks =3D st.st_blocks;
> >      |                           ^
> > ../block/nfs.c: In function 'nfs_get_allocated_file_size':
> > ../block/nfs.c:751:41: error: 'struct _stat64' has no member named =
'st_blocks'
> >  751 |     return (task.ret < 0 ? task.ret : st.st_blocks * 512);
> >      |                                         ^
> > ../block/nfs.c: In function 'nfs_reopen_prepare':
> > ../block/nfs.c:805:31: error: 'struct _stat64' has no member named =
'st_blocks'
> >  805 |         client->st_blocks =3D st.st_blocks;
> >      |                               ^
> > ../block/nfs.c: In function 'nfs_get_allocated_file_size':
> > ../block/nfs.c:752:1: error: control reaches end of non-void =
function [-Werror=3Dreturn-type]
> >  752 | }
> >      | ^
> >=20
> > On msys2/mingw, there is no st_blocks in struct _stat64, so we use =
consistence st_size instead.
> >=20
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > ---
> > block/nfs.c | 26 +++++++++++++++++---------
> > 1 file changed, 17 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/block/nfs.c b/block/nfs.c
> > index 61a249a9fc..34b2cd5708 100644
> > --- a/block/nfs.c
> > +++ b/block/nfs.c
> > @@ -24,7 +24,9 @@
> >=20
> > #include "qemu/osdep.h"
> >=20
> > +#if !defined(_WIN32)
> > #include <poll.h>
> > +#endif
> > #include "qemu/config-file.h"
> > #include "qemu/error-report.h"
> > #include "qapi/error.h"
> > @@ -51,6 +53,12 @@
> > #define QEMU_NFS_MAX_PAGECACHE_SIZE (8388608 / NFS_BLKSIZE)
> > #define QEMU_NFS_MAX_DEBUG_LEVEL 2
> >=20
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
> > @@ -419,7 +427,7 @@ static int64_t nfs_client_open(NFSClient =
*client, BlockdevOptionsNfs *opts,
> >                                int flags, int open_flags, Error =
**errp)
> > {
> >     int64_t ret =3D -EINVAL;
> > -    struct stat st;
> > +    struct nfs_stat st;
> >     char *file =3D NULL, *strp =3D NULL;
> >=20
> >     qemu_mutex_init(&client->mutex);
> > @@ -545,7 +553,7 @@ static int64_t nfs_client_open(NFSClient =
*client, BlockdevOptionsNfs *opts,
> >     }
> >=20
> >     ret =3D DIV_ROUND_UP(st.st_size, BDRV_SECTOR_SIZE);
> > -    client->st_blocks =3D st.st_blocks;
> > +    client->st_size =3D st.st_size;
> >     client->has_zero_init =3D S_ISREG(st.st_mode);
> >     *strp =3D '/';
> >     goto out;
> > @@ -729,11 +737,11 @@ static int64_t =
nfs_get_allocated_file_size(BlockDriverState *bs)
> > {
> >     NFSClient *client =3D bs->opaque;
> >     NFSRPC task =3D {0};
> > -    struct stat st;
> > +    struct nfs_stat st;
> >=20
> >     if (bdrv_is_read_only(bs) &&
> >         !(bs->open_flags & BDRV_O_NOCACHE)) {
> > -        return client->st_blocks * 512;
> > +        return client->st_size;
> I am using   client->st_size instead client->st_blocks * 512, anything =
wrong with this?
> >     }
> >=20
> >     task.bs =3D bs;
> > @@ -746,7 +754,7 @@ static int64_t =
nfs_get_allocated_file_size(BlockDriverState *bs)
> >     nfs_set_events(client);
> >     BDRV_POLL_WHILE(bs, !task.complete);
> >=20
> > -    return (task.ret < 0 ? task.ret : st.st_blocks * 512);
> > +    return (task.ret < 0 ? task.ret : st.st_size);
> > }
> >=20
> > static int coroutine_fn
> > @@ -778,7 +786,7 @@ static int nfs_reopen_prepare(BDRVReopenState =
*state,
> >                               BlockReopenQueue *queue, Error **errp)
> > {
> >     NFSClient *client =3D state->bs->opaque;
> > -    struct stat st;
> > +    struct nfs_stat st;
> >     int ret =3D 0;
> >=20
> >     if (state->flags & BDRV_O_RDWR && bdrv_is_read_only(state->bs)) =
{
> > @@ -800,7 +808,7 @@ static int nfs_reopen_prepare(BDRVReopenState =
*state,
> >                        nfs_get_error(client->context));
> >             return ret;
> >         }
> > -        client->st_blocks =3D st.st_blocks;
> > +        client->st_size =3D st.st_size;
> >     }
> >=20
> >     return 0;
> > --=20
> > 2.28.0.windows.1
> >=20
>=20
>=20
> NACK. st_blocks and st_size is not the same. st_blocks is the number =
of allocated blocks on disk. st_size is the virtual size of a file as it =
may contain holes.
> I think the appropriate fix is to not implement =
nfs_get_allocated_file_size on WIN32. Its not mandatory.
>=20
> Please look at the   st_size, it's equivalant to  st_blocks * 512;

It is definitely not. Where do you have this info from?

Please have a look at libnfs/lib/nfs_v3.c in function nfs3_stat_1_cb.


        st.st_size    =3D res->GETATTR3res_u.resok.obj_attributes.size;
#ifndef WIN32
        st.st_blksize =3D NFS_BLKSIZE;
	st.st_blocks  =3D (res->GETATTR3res_u.resok.obj_attributes.used =
+ 512 - 1) / 512;
#endif//WIN32


Your patch will eliminate this difference for non WIN32 systems. Please =
change your patch to not implement nfs_get_allocated_file_size and qemu =
will handle this case properly.
Put everything that involves st_blocks and nfs_get_allocated_file_size =
in #ifndef _WIN32 conditions.


Peter=


