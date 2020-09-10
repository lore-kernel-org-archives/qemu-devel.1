Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F97C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 20:17:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D43020829
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 20:17:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D43020829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kamp.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGT0X-0000rT-Lc
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 16:17:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60178)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pl@kamp.de>)
 id 1kGSzq-0000Fu-UF; Thu, 10 Sep 2020 16:16:42 -0400
Received: from kerio.kamp.de ([195.62.97.192]:41169)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pl@kamp.de>)
 id 1kGSzn-00040t-UJ; Thu, 10 Sep 2020 16:16:42 -0400
X-Footer: a2FtcC5kZQ==
Received: from [172.20.250.33] ([172.20.250.33])
 (authenticated user pl@kamp.de) by kerio.kamp.de with ESMTPSA
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
 Thu, 10 Sep 2020 22:16:26 +0200
From: Peter Lieven <pl@kamp.de>
Message-Id: <90DDF8F4-4AC0-42E8-85DA-4CC38C066F45@kamp.de>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_7AB19365-29EE-47F1-BD4E-4240272F41A4"
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH v7 03/25] block: Fixes nfs compiling error on msys2/mingw
Date: Thu, 10 Sep 2020 22:16:27 +0200
In-Reply-To: <20200910103059.987-4-luoyonggang@gmail.com>
To: Yonggang Luo <luoyonggang@gmail.com>
References: <20200910103059.987-1-luoyonggang@gmail.com>
 <20200910103059.987-4-luoyonggang@gmail.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
Received-SPF: pass client-ip=195.62.97.192; envelope-from=pl@kamp.de;
 helo=kerio.kamp.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 16:03:26
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Paolo Bonzini <pbonzini@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Apple-Mail=_7AB19365-29EE-47F1-BD4E-4240272F41A4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



> Am 10.09.2020 um 12:30 schrieb Yonggang Luo <luoyonggang@gmail.com>:
>=20
> These compiling errors are fixed:
> ../block/nfs.c:27:10: fatal error: poll.h: No such file or directory
>   27 | #include <poll.h>
>      |          ^~~~~~~~
> compilation terminated.
>=20
> ../block/nfs.c:63:5: error: unknown type name 'blkcnt_t'
>   63 |     blkcnt_t st_blocks;
>      |     ^~~~~~~~
> ../block/nfs.c: In function 'nfs_client_open':
> ../block/nfs.c:550:27: error: 'struct _stat64' has no member named =
'st_blocks'
>  550 |     client->st_blocks =3D st.st_blocks;
>      |                           ^
> ../block/nfs.c: In function 'nfs_get_allocated_file_size':
> ../block/nfs.c:751:41: error: 'struct _stat64' has no member named =
'st_blocks'
>  751 |     return (task.ret < 0 ? task.ret : st.st_blocks * 512);
>      |                                         ^
> ../block/nfs.c: In function 'nfs_reopen_prepare':
> ../block/nfs.c:805:31: error: 'struct _stat64' has no member named =
'st_blocks'
>  805 |         client->st_blocks =3D st.st_blocks;
>      |                               ^
> ../block/nfs.c: In function 'nfs_get_allocated_file_size':
> ../block/nfs.c:752:1: error: control reaches end of non-void function =
[-Werror=3Dreturn-type]
>  752 | }
>      | ^
>=20
> On msys2/mingw, there is no st_blocks in struct _stat64, so we use =
consistence st_size instead.
>=20
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
> block/nfs.c | 32 +++++++++++++++++++++++++-------
> 1 file changed, 25 insertions(+), 7 deletions(-)
>=20
> diff --git a/block/nfs.c b/block/nfs.c
> index 61a249a9fc..db6d8c2d2b 100644
> --- a/block/nfs.c
> +++ b/block/nfs.c
> @@ -24,7 +24,9 @@
>=20
> #include "qemu/osdep.h"
>=20
> +#if !defined(_WIN32)
> #include <poll.h>
> +#endif
> #include "qemu/config-file.h"
> #include "qemu/error-report.h"
> #include "qapi/error.h"
> @@ -51,6 +53,13 @@
> #define QEMU_NFS_MAX_PAGECACHE_SIZE (8388608 / NFS_BLKSIZE)
> #define QEMU_NFS_MAX_DEBUG_LEVEL 2
>=20
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
>=20
> +static blkcnt_t nfs_get_st_blocks(const struct nfs_stat *st)
> +{
> +#if defined(_WIN32)
> +    return (st->st_size + 511) / 512;
> +#else
> +    return st->st_blocks;
> +#endif
> +}
> +
> static int64_t nfs_client_open(NFSClient *client, BlockdevOptionsNfs =
*opts,
>                                int flags, int open_flags, Error =
**errp)
> {
>     int64_t ret =3D -EINVAL;
> -    struct stat st;
> +    struct nfs_stat st;
>     char *file =3D NULL, *strp =3D NULL;
>=20
>     qemu_mutex_init(&client->mutex);
> @@ -545,7 +563,7 @@ static int64_t nfs_client_open(NFSClient *client, =
BlockdevOptionsNfs *opts,
>     }
>=20
>     ret =3D DIV_ROUND_UP(st.st_size, BDRV_SECTOR_SIZE);
> -    client->st_blocks =3D st.st_blocks;
> +    client->st_blocks =3D nfs_get_st_blocks(&st);
>     client->has_zero_init =3D S_ISREG(st.st_mode);
>     *strp =3D '/';
>     goto out;
> @@ -729,7 +747,7 @@ static int64_t =
nfs_get_allocated_file_size(BlockDriverState *bs)
> {
>     NFSClient *client =3D bs->opaque;
>     NFSRPC task =3D {0};
> -    struct stat st;
> +    struct nfs_stat st;
>=20
>     if (bdrv_is_read_only(bs) &&
>         !(bs->open_flags & BDRV_O_NOCACHE)) {
> @@ -746,7 +764,7 @@ static int64_t =
nfs_get_allocated_file_size(BlockDriverState *bs)
>     nfs_set_events(client);
>     BDRV_POLL_WHILE(bs, !task.complete);
>=20
> -    return (task.ret < 0 ? task.ret : st.st_blocks * 512);
> +    return (task.ret < 0 ? task.ret : nfs_get_st_blocks(&st) * 512);
> }
>=20
> static int coroutine_fn
> @@ -778,7 +796,7 @@ static int nfs_reopen_prepare(BDRVReopenState =
*state,
>                               BlockReopenQueue *queue, Error **errp)
> {
>     NFSClient *client =3D state->bs->opaque;
> -    struct stat st;
> +    struct nfs_stat st;
>     int ret =3D 0;
>=20
>     if (state->flags & BDRV_O_RDWR && bdrv_is_read_only(state->bs)) {
> @@ -800,7 +818,7 @@ static int nfs_reopen_prepare(BDRVReopenState =
*state,
>                        nfs_get_error(client->context));
>             return ret;
>         }
> -        client->st_blocks =3D st.st_blocks;
> +        client->st_blocks =3D nfs_get_st_blocks(&st);
>     }
>=20
>     return 0;
> --=20
> 2.28.0.windows.1


You still implement nfs_get_allocated_file_size without actually =
returning the allocated file size on WIN32.=20
I would simply do this:

diff --git a/block/nfs.c b/block/nfs.c
index 61a249a..0983143 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -24,7 +24,9 @@
=20
 #include "qemu/osdep.h"
=20
+#if !defined(_WIN32)
 #include <poll.h>
+#endif
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
@@ -58,7 +60,9 @@ typedef struct NFSClient {
     bool has_zero_init;
     AioContext *aio_context;
     QemuMutex mutex;
+#if !defined(_WIN32)
     blkcnt_t st_blocks;
+#endif
     bool cache_used;
     NFSServer *server;
     char *path;
@@ -545,7 +549,9 @@ static int64_t nfs_client_open(NFSClient *client, =
BlockdevOptionsNfs *opts,
     }
=20
     ret =3D DIV_ROUND_UP(st.st_size, BDRV_SECTOR_SIZE);
+#if !defined(_WIN32)
     client->st_blocks =3D st.st_blocks;
+#endif
     client->has_zero_init =3D S_ISREG(st.st_mode);
     *strp =3D '/';
     goto out;
@@ -706,6 +712,8 @@ static int nfs_has_zero_init(BlockDriverState *bs)
     return client->has_zero_init;
 }
=20
+
+#if !defined(_WIN32)
 /* Called (via nfs_service) with QemuMutex held.  */
 static void
 nfs_get_allocated_file_size_cb(int ret, struct nfs_context *nfs, void =
*data,
@@ -748,6 +756,7 @@ static int64_t =
nfs_get_allocated_file_size(BlockDriverState *bs)
=20
     return (task.ret < 0 ? task.ret : st.st_blocks * 512);
 }
+#endif
=20
 static int coroutine_fn
 nfs_file_co_truncate(BlockDriverState *bs, int64_t offset, bool exact,
@@ -792,6 +801,7 @@ static int nfs_reopen_prepare(BDRVReopenState =
*state,
         return -EINVAL;
     }
=20
+#if !defined(_WIN32)
     /* Update cache for read-only reopens */
     if (!(state->flags & BDRV_O_RDWR)) {
         ret =3D nfs_fstat(client->context, client->fh, &st);
@@ -802,6 +812,7 @@ static int nfs_reopen_prepare(BDRVReopenState =
*state,
         }
         client->st_blocks =3D st.st_blocks;
     }
+#endif
=20
     return 0;
 }
@@ -869,7 +880,9 @@ static BlockDriver bdrv_nfs =3D {
     .create_opts                    =3D &nfs_create_opts,
=20
     .bdrv_has_zero_init             =3D nfs_has_zero_init,
+#if !defined(_WIN32)
     .bdrv_get_allocated_file_size   =3D nfs_get_allocated_file_size,
+#endif
     .bdrv_co_truncate               =3D nfs_file_co_truncate,
=20
     .bdrv_file_open                 =3D nfs_file_open,


Best,
Peter


--Apple-Mail=_7AB19365-29EE-47F1-BD4E-4240272F41A4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; =
charset=3Dus-ascii"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;" class=3D""><br =
class=3D""><div><br class=3D""><blockquote type=3D"cite" class=3D""><div =
class=3D"">Am 10.09.2020 um 12:30 schrieb Yonggang Luo &lt;<a =
href=3D"mailto:luoyonggang@gmail.com" =
class=3D"">luoyonggang@gmail.com</a>&gt;:</div><br =
class=3D"Apple-interchange-newline"><div class=3D""><div class=3D"">These =
compiling errors are fixed:<br class=3D"">../block/nfs.c:27:10: fatal =
error: poll.h: No such file or directory<br class=3D""> &nbsp;&nbsp;27 | =
#include &lt;poll.h&gt;<br class=3D""> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;^~~~~~~~<br =
class=3D"">compilation terminated.<br class=3D""><br =
class=3D"">../block/nfs.c:63:5: error: unknown type name 'blkcnt_t'<br =
class=3D""> &nbsp;&nbsp;63 | &nbsp;&nbsp;&nbsp;&nbsp;blkcnt_t =
st_blocks;<br class=3D""> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| =
&nbsp;&nbsp;&nbsp;&nbsp;^~~~~~~~<br class=3D"">../block/nfs.c: In =
function 'nfs_client_open':<br class=3D"">../block/nfs.c:550:27: error: =
'struct _stat64' has no member named 'st_blocks'<br class=3D""> =
&nbsp;550 | &nbsp;&nbsp;&nbsp;&nbsp;client-&gt;st_blocks =3D =
st.st_blocks;<br class=3D""> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;^<br class=3D"">../block/nfs.c: In function =
'nfs_get_allocated_file_size':<br class=3D"">../block/nfs.c:751:41: =
error: 'struct _stat64' has no member named 'st_blocks'<br class=3D""> =
&nbsp;751 | &nbsp;&nbsp;&nbsp;&nbsp;return (task.ret &lt; 0 ? task.ret : =
st.st_blocks * 512);<br class=3D""> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;^<br class=3D"">../block/nfs.c: In function =
'nfs_reopen_prepare':<br class=3D"">../block/nfs.c:805:31: error: =
'struct _stat64' has no member named 'st_blocks'<br class=3D""> =
&nbsp;805 | =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;client-&gt;st_blocks =3D =
st.st_blocks;<br class=3D""> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;^<br class=3D"">../block/nfs.c: In =
function 'nfs_get_allocated_file_size':<br =
class=3D"">../block/nfs.c:752:1: error: control reaches end of non-void =
function [-Werror=3Dreturn-type]<br class=3D""> &nbsp;752 | }<br =
class=3D""> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| ^<br class=3D""><br =
class=3D"">On msys2/mingw, there is no st_blocks in struct _stat64, so =
we use consistence st_size instead.<br class=3D""><br =
class=3D"">Signed-off-by: Yonggang Luo &lt;<a =
href=3D"mailto:luoyonggang@gmail.com" =
class=3D"">luoyonggang@gmail.com</a>&gt;<br class=3D"">---<br class=3D""> =
block/nfs.c | 32 +++++++++++++++++++++++++-------<br class=3D""> 1 file =
changed, 25 insertions(+), 7 deletions(-)<br class=3D""><br =
class=3D"">diff --git a/block/nfs.c b/block/nfs.c<br class=3D"">index =
61a249a9fc..db6d8c2d2b 100644<br class=3D"">--- a/block/nfs.c<br =
class=3D"">+++ b/block/nfs.c<br class=3D"">@@ -24,7 +24,9 @@<br =
class=3D""><br class=3D""> #include "qemu/osdep.h"<br class=3D""><br =
class=3D"">+#if !defined(_WIN32)<br class=3D""> #include =
&lt;poll.h&gt;<br class=3D"">+#endif<br class=3D""> #include =
"qemu/config-file.h"<br class=3D""> #include "qemu/error-report.h"<br =
class=3D""> #include "qapi/error.h"<br class=3D"">@@ -51,6 +53,13 @@<br =
class=3D""> #define QEMU_NFS_MAX_PAGECACHE_SIZE (8388608 / =
NFS_BLKSIZE)<br class=3D""> #define QEMU_NFS_MAX_DEBUG_LEVEL 2<br =
class=3D""><br class=3D"">+#if defined (_WIN32)<br class=3D"">+#define =
nfs_stat __stat64<br class=3D"">+typedef long long blkcnt_t;<br =
class=3D"">+#else<br class=3D"">+#define nfs_stat stat<br =
class=3D"">+#endif<br class=3D"">+<br class=3D""> typedef struct =
NFSClient {<br class=3D""> &nbsp;&nbsp;&nbsp;&nbsp;struct nfs_context =
*context;<br class=3D""> &nbsp;&nbsp;&nbsp;&nbsp;struct nfsfh *fh;<br =
class=3D"">@@ -70,7 +79,7 @@ typedef struct NFSRPC {<br class=3D""> =
&nbsp;&nbsp;&nbsp;&nbsp;int ret;<br class=3D""> =
&nbsp;&nbsp;&nbsp;&nbsp;int complete;<br class=3D""> =
&nbsp;&nbsp;&nbsp;&nbsp;QEMUIOVector *iov;<br class=3D"">- =
&nbsp;&nbsp;&nbsp;struct stat *st;<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;struct nfs_stat *st;<br class=3D""> =
&nbsp;&nbsp;&nbsp;&nbsp;Coroutine *co;<br class=3D""> =
&nbsp;&nbsp;&nbsp;&nbsp;NFSClient *client;<br class=3D""> } NFSRPC;<br =
class=3D"">@@ -415,11 +424,20 @@ static void =
nfs_file_close(BlockDriverState *bs)<br class=3D""> =
&nbsp;&nbsp;&nbsp;&nbsp;nfs_client_close(client);<br class=3D""> }<br =
class=3D""><br class=3D"">+static blkcnt_t nfs_get_st_blocks(const =
struct nfs_stat *st)<br class=3D"">+{<br class=3D"">+#if =
defined(_WIN32)<br class=3D"">+ &nbsp;&nbsp;&nbsp;return (st-&gt;st_size =
+ 511) / 512;<br class=3D"">+#else<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;return st-&gt;st_blocks;<br class=3D"">+#endif<br =
class=3D"">+}<br class=3D"">+<br class=3D""> static int64_t =
nfs_client_open(NFSClient *client, BlockdevOptionsNfs *opts,<br =
class=3D""> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;int flags, int open_flags, Error =
**errp)<br class=3D""> {<br class=3D""> &nbsp;&nbsp;&nbsp;&nbsp;int64_t =
ret =3D -EINVAL;<br class=3D"">- &nbsp;&nbsp;&nbsp;struct stat st;<br =
class=3D"">+ &nbsp;&nbsp;&nbsp;struct nfs_stat st;<br class=3D""> =
&nbsp;&nbsp;&nbsp;&nbsp;char *file =3D NULL, *strp =3D NULL;<br =
class=3D""><br class=3D""> =
&nbsp;&nbsp;&nbsp;&nbsp;qemu_mutex_init(&amp;client-&gt;mutex);<br =
class=3D"">@@ -545,7 +563,7 @@ static int64_t nfs_client_open(NFSClient =
*client, BlockdevOptionsNfs *opts,<br class=3D""> =
&nbsp;&nbsp;&nbsp;&nbsp;}<br class=3D""><br class=3D""> =
&nbsp;&nbsp;&nbsp;&nbsp;ret =3D DIV_ROUND_UP(st.st_size, =
BDRV_SECTOR_SIZE);<br class=3D"">- =
&nbsp;&nbsp;&nbsp;client-&gt;st_blocks =3D st.st_blocks;<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;client-&gt;st_blocks =3D =
nfs_get_st_blocks(&amp;st);<br class=3D""> =
&nbsp;&nbsp;&nbsp;&nbsp;client-&gt;has_zero_init =3D =
S_ISREG(st.st_mode);<br class=3D""> &nbsp;&nbsp;&nbsp;&nbsp;*strp =3D =
'/';<br class=3D""> &nbsp;&nbsp;&nbsp;&nbsp;goto out;<br class=3D"">@@ =
-729,7 +747,7 @@ static int64_t =
nfs_get_allocated_file_size(BlockDriverState *bs)<br class=3D""> {<br =
class=3D""> &nbsp;&nbsp;&nbsp;&nbsp;NFSClient *client =3D =
bs-&gt;opaque;<br class=3D""> &nbsp;&nbsp;&nbsp;&nbsp;NFSRPC task =3D =
{0};<br class=3D"">- &nbsp;&nbsp;&nbsp;struct stat st;<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;struct nfs_stat st;<br class=3D""><br class=3D""> =
&nbsp;&nbsp;&nbsp;&nbsp;if (bdrv_is_read_only(bs) &amp;&amp;<br =
class=3D""> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;!(bs-&gt;open_flags =
&amp; BDRV_O_NOCACHE)) {<br class=3D"">@@ -746,7 +764,7 @@ static =
int64_t nfs_get_allocated_file_size(BlockDriverState *bs)<br class=3D""> =
&nbsp;&nbsp;&nbsp;&nbsp;nfs_set_events(client);<br class=3D""> =
&nbsp;&nbsp;&nbsp;&nbsp;BDRV_POLL_WHILE(bs, !task.complete);<br =
class=3D""><br class=3D"">- &nbsp;&nbsp;&nbsp;return (task.ret &lt; 0 ? =
task.ret : st.st_blocks * 512);<br class=3D"">+ &nbsp;&nbsp;&nbsp;return =
(task.ret &lt; 0 ? task.ret : nfs_get_st_blocks(&amp;st) * 512);<br =
class=3D""> }<br class=3D""><br class=3D""> static int coroutine_fn<br =
class=3D"">@@ -778,7 +796,7 @@ static int =
nfs_reopen_prepare(BDRVReopenState *state,<br class=3D""> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;BlockReopenQueue *queue, Error =
**errp)<br class=3D""> {<br class=3D""> =
&nbsp;&nbsp;&nbsp;&nbsp;NFSClient *client =3D =
state-&gt;bs-&gt;opaque;<br class=3D"">- &nbsp;&nbsp;&nbsp;struct stat =
st;<br class=3D"">+ &nbsp;&nbsp;&nbsp;struct nfs_stat st;<br class=3D""> =
&nbsp;&nbsp;&nbsp;&nbsp;int ret =3D 0;<br class=3D""><br class=3D""> =
&nbsp;&nbsp;&nbsp;&nbsp;if (state-&gt;flags &amp; BDRV_O_RDWR &amp;&amp; =
bdrv_is_read_only(state-&gt;bs)) {<br class=3D"">@@ -800,7 +818,7 @@ =
static int nfs_reopen_prepare(BDRVReopenState *state,<br class=3D""> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;nfs_get_er=
ror(client-&gt;context));<br class=3D""> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;re=
turn ret;<br class=3D""> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br class=3D"">- =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;client-&gt;st_blocks =3D =
st.st_blocks;<br class=3D"">+ =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;client-&gt;st_blocks =3D =
nfs_get_st_blocks(&amp;st);<br class=3D""> &nbsp;&nbsp;&nbsp;&nbsp;}<br =
class=3D""><br class=3D""> &nbsp;&nbsp;&nbsp;&nbsp;return 0;<br =
class=3D"">-- <br class=3D"">2.28.0.windows.1<br =
class=3D""></div></div></blockquote><div><br class=3D""></div><div><br =
class=3D""></div>You still implement nfs_get_allocated_file_size without =
actually returning the allocated file size on WIN32.&nbsp;</div><div>I =
would simply do this:</div><div><br class=3D""></div><div><div =
style=3D"margin: 0px; font-stretch: normal; font-size: 11px; =
line-height: normal; font-family: Menlo; color: rgb(0, 0, 0);" =
class=3D""><span style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D""><b class=3D"">diff --git a/block/nfs.c =
b/block/nfs.c</b></span></div><div style=3D"margin: 0px; font-stretch: =
normal; font-size: 11px; line-height: normal; font-family: Menlo; color: =
rgb(0, 0, 0);" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D""><b class=3D"">index 61a249a..0983143 =
100644</b></span></div><div style=3D"margin: 0px; font-stretch: normal; =
font-size: 11px; line-height: normal; font-family: Menlo; color: rgb(0, =
0, 0);" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D""><b class=3D"">--- =
a/block/nfs.c</b></span></div><div style=3D"margin: 0px; font-stretch: =
normal; font-size: 11px; line-height: normal; font-family: Menlo; color: =
rgb(0, 0, 0);" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D""><b class=3D"">+++ =
b/block/nfs.c</b></span></div><div style=3D"margin: 0px; font-stretch: =
normal; font-size: 11px; line-height: normal; font-family: Menlo; color: =
rgb(56, 185, 199);" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">@@ -24,7 +24,9 @@</span></div><p =
style=3D"margin: 0px; font-stretch: normal; font-size: 11px; =
line-height: normal; font-family: Menlo; color: rgb(0, 0, 0); =
min-height: 13px;" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">&nbsp;</span><br =
class=3D"webkit-block-placeholder"></p><div style=3D"margin: 0px; =
font-stretch: normal; font-size: 11px; line-height: normal; font-family: =
Menlo; color: rgb(0, 0, 0);" class=3D""><span =
style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">&nbsp;#include "qemu/osdep.h"</span></div><p style=3D"margin: =
0px; font-stretch: normal; font-size: 11px; line-height: normal; =
font-family: Menlo; color: rgb(0, 0, 0); min-height: 13px;" =
class=3D""><span style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">&nbsp;</span><br class=3D"webkit-block-placeholder"></p><div =
style=3D"margin: 0px; font-stretch: normal; font-size: 11px; =
line-height: normal; font-family: Menlo; color: rgb(57, 192, 38);" =
class=3D""><span style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">+#if !defined(_WIN32)</span></div><div style=3D"margin: 0px; =
font-stretch: normal; font-size: 11px; line-height: normal; font-family: =
Menlo; color: rgb(0, 0, 0);" class=3D""><span =
style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">&nbsp;#include &lt;poll.h&gt;</span></div><div style=3D"margin:=
 0px; font-stretch: normal; font-size: 11px; line-height: normal; =
font-family: Menlo; color: rgb(57, 192, 38);" class=3D""><span =
style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">+#endif</span></div><div style=3D"margin: 0px; font-stretch: =
normal; font-size: 11px; line-height: normal; font-family: Menlo; color: =
rgb(0, 0, 0);" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">&nbsp;#include =
"qemu/config-file.h"</span></div><div style=3D"margin: 0px; =
font-stretch: normal; font-size: 11px; line-height: normal; font-family: =
Menlo; color: rgb(0, 0, 0);" class=3D""><span =
style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">&nbsp;#include "qemu/error-report.h"</span></div><div =
style=3D"margin: 0px; font-stretch: normal; font-size: 11px; =
line-height: normal; font-family: Menlo; color: rgb(0, 0, 0);" =
class=3D""><span style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">&nbsp;#include "qapi/error.h"</span></div><div style=3D"margin:=
 0px; font-stretch: normal; font-size: 11px; line-height: normal; =
font-family: Menlo; color: rgb(0, 0, 0);" class=3D""><span =
style=3D"font-variant-ligatures: no-common-ligatures; color: #38b9c7" =
class=3D"">@@ -58,7 +60,9 @@</span><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D""> typedef struct NFSClient =
{</span></div><div style=3D"margin: 0px; font-stretch: normal; =
font-size: 11px; line-height: normal; font-family: Menlo; color: rgb(0, =
0, 0);" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">&nbsp;&nbsp; &nbsp; bool =
has_zero_init;</span></div><div style=3D"margin: 0px; font-stretch: =
normal; font-size: 11px; line-height: normal; font-family: Menlo; color: =
rgb(0, 0, 0);" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">&nbsp;&nbsp; &nbsp; AioContext =
*aio_context;</span></div><div style=3D"margin: 0px; font-stretch: =
normal; font-size: 11px; line-height: normal; font-family: Menlo; color: =
rgb(0, 0, 0);" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">&nbsp;&nbsp; &nbsp; QemuMutex =
mutex;</span></div><div style=3D"margin: 0px; font-stretch: normal; =
font-size: 11px; line-height: normal; font-family: Menlo; color: rgb(57, =
192, 38);" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">+#if !defined(_WIN32)</span></div><div =
style=3D"margin: 0px; font-stretch: normal; font-size: 11px; =
line-height: normal; font-family: Menlo; color: rgb(0, 0, 0);" =
class=3D""><span style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">&nbsp;&nbsp; &nbsp; blkcnt_t st_blocks;</span></div><div =
style=3D"margin: 0px; font-stretch: normal; font-size: 11px; =
line-height: normal; font-family: Menlo; color: rgb(57, 192, 38);" =
class=3D""><span style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">+#endif</span></div><div style=3D"margin: 0px; font-stretch: =
normal; font-size: 11px; line-height: normal; font-family: Menlo; color: =
rgb(0, 0, 0);" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">&nbsp;&nbsp; &nbsp; bool =
cache_used;</span></div><div style=3D"margin: 0px; font-stretch: normal; =
font-size: 11px; line-height: normal; font-family: Menlo; color: rgb(0, =
0, 0);" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">&nbsp;&nbsp; &nbsp; NFSServer =
*server;</span></div><div style=3D"margin: 0px; font-stretch: normal; =
font-size: 11px; line-height: normal; font-family: Menlo; color: rgb(0, =
0, 0);" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">&nbsp;&nbsp; &nbsp; char =
*path;</span></div><div style=3D"margin: 0px; font-stretch: normal; =
font-size: 11px; line-height: normal; font-family: Menlo; color: rgb(0, =
0, 0);" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures; color: #38b9c7" class=3D"">@@ -545,7 +549,9 =
@@</span><span style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D""> static int64_t nfs_client_open(NFSClient *client, =
BlockdevOptionsNfs *opts,</span></div><div style=3D"margin: 0px; =
font-stretch: normal; font-size: 11px; line-height: normal; font-family: =
Menlo; color: rgb(0, 0, 0);" class=3D""><span =
style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">&nbsp;&nbsp; &nbsp; }</span></div><p style=3D"margin: 0px; =
font-stretch: normal; font-size: 11px; line-height: normal; font-family: =
Menlo; color: rgb(0, 0, 0); min-height: 13px;" class=3D""><span =
style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">&nbsp;</span><br class=3D"webkit-block-placeholder"></p><div =
style=3D"margin: 0px; font-stretch: normal; font-size: 11px; =
line-height: normal; font-family: Menlo; color: rgb(0, 0, 0);" =
class=3D""><span style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">&nbsp;&nbsp; &nbsp; ret =3D DIV_ROUND_UP(st.st_size, =
BDRV_SECTOR_SIZE);</span></div><div style=3D"margin: 0px; font-stretch: =
normal; font-size: 11px; line-height: normal; font-family: Menlo; color: =
rgb(57, 192, 38);" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">+#if !defined(_WIN32)</span></div><div =
style=3D"margin: 0px; font-stretch: normal; font-size: 11px; =
line-height: normal; font-family: Menlo; color: rgb(0, 0, 0);" =
class=3D""><span style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">&nbsp;&nbsp; &nbsp; client-&gt;st_blocks =3D =
st.st_blocks;</span></div><div style=3D"margin: 0px; font-stretch: =
normal; font-size: 11px; line-height: normal; font-family: Menlo; color: =
rgb(57, 192, 38);" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">+#endif</span></div><div style=3D"margin: =
0px; font-stretch: normal; font-size: 11px; line-height: normal; =
font-family: Menlo; color: rgb(0, 0, 0);" class=3D""><span =
style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">&nbsp;&nbsp; &nbsp; client-&gt;has_zero_init =3D =
S_ISREG(st.st_mode);</span></div><div style=3D"margin: 0px; =
font-stretch: normal; font-size: 11px; line-height: normal; font-family: =
Menlo; color: rgb(0, 0, 0);" class=3D""><span =
style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">&nbsp;&nbsp; &nbsp; *strp =3D '/';</span></div><div =
style=3D"margin: 0px; font-stretch: normal; font-size: 11px; =
line-height: normal; font-family: Menlo; color: rgb(0, 0, 0);" =
class=3D""><span style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">&nbsp;&nbsp; &nbsp; goto out;</span></div><div style=3D"margin:=
 0px; font-stretch: normal; font-size: 11px; line-height: normal; =
font-family: Menlo; color: rgb(0, 0, 0);" class=3D""><span =
style=3D"font-variant-ligatures: no-common-ligatures; color: #38b9c7" =
class=3D"">@@ -706,6 +712,8 @@</span><span =
style=3D"font-variant-ligatures: no-common-ligatures" class=3D""> static =
int nfs_has_zero_init(BlockDriverState *bs)</span></div><div =
style=3D"margin: 0px; font-stretch: normal; font-size: 11px; =
line-height: normal; font-family: Menlo; color: rgb(0, 0, 0);" =
class=3D""><span style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">&nbsp;&nbsp; &nbsp; return =
client-&gt;has_zero_init;</span></div><div style=3D"margin: 0px; =
font-stretch: normal; font-size: 11px; line-height: normal; font-family: =
Menlo; color: rgb(0, 0, 0);" class=3D""><span =
style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">&nbsp;}</span></div><p style=3D"margin: 0px; font-stretch: =
normal; font-size: 11px; line-height: normal; font-family: Menlo; color: =
rgb(0, 0, 0); min-height: 13px;" class=3D""><span =
style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">&nbsp;</span><br class=3D"webkit-block-placeholder"></p><div =
style=3D"margin: 0px; font-stretch: normal; font-size: 11px; =
line-height: normal; font-family: Menlo; color: rgb(57, 192, 38);" =
class=3D""><span style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">+</span></div><div style=3D"margin: 0px; font-stretch: =
normal; font-size: 11px; line-height: normal; font-family: Menlo; color: =
rgb(57, 192, 38);" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">+#if !defined(_WIN32)</span></div><div =
style=3D"margin: 0px; font-stretch: normal; font-size: 11px; =
line-height: normal; font-family: Menlo; color: rgb(0, 0, 0);" =
class=3D""><span style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">&nbsp;/* Called (via nfs_service) with QemuMutex held.&nbsp; =
*/</span></div><div style=3D"margin: 0px; font-stretch: normal; =
font-size: 11px; line-height: normal; font-family: Menlo; color: rgb(0, =
0, 0);" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">&nbsp;static void</span></div><div =
style=3D"margin: 0px; font-stretch: normal; font-size: 11px; =
line-height: normal; font-family: Menlo; color: rgb(0, 0, 0);" =
class=3D""><span style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">&nbsp;nfs_get_allocated_file_size_cb(int ret, struct =
nfs_context *nfs, void *data,</span></div><div style=3D"margin: 0px; =
font-stretch: normal; font-size: 11px; line-height: normal; font-family: =
Menlo; color: rgb(0, 0, 0);" class=3D""><span =
style=3D"font-variant-ligatures: no-common-ligatures; color: #38b9c7" =
class=3D"">@@ -748,6 +756,7 @@</span><span =
style=3D"font-variant-ligatures: no-common-ligatures" class=3D""> static =
int64_t nfs_get_allocated_file_size(BlockDriverState *bs)</span></div><p =
style=3D"margin: 0px; font-stretch: normal; font-size: 11px; =
line-height: normal; font-family: Menlo; color: rgb(0, 0, 0); =
min-height: 13px;" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">&nbsp;</span><br =
class=3D"webkit-block-placeholder"></p><div style=3D"margin: 0px; =
font-stretch: normal; font-size: 11px; line-height: normal; font-family: =
Menlo; color: rgb(0, 0, 0);" class=3D""><span =
style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">&nbsp;&nbsp; &nbsp; return (task.ret &lt; 0 ? task.ret : =
st.st_blocks * 512);</span></div><div style=3D"margin: 0px; =
font-stretch: normal; font-size: 11px; line-height: normal; font-family: =
Menlo; color: rgb(0, 0, 0);" class=3D""><span =
style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">&nbsp;}</span></div><div style=3D"margin: 0px; font-stretch: =
normal; font-size: 11px; line-height: normal; font-family: Menlo; color: =
rgb(57, 192, 38);" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">+#endif</span></div><p style=3D"margin: =
0px; font-stretch: normal; font-size: 11px; line-height: normal; =
font-family: Menlo; color: rgb(0, 0, 0); min-height: 13px;" =
class=3D""><span style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">&nbsp;</span><br class=3D"webkit-block-placeholder"></p><div =
style=3D"margin: 0px; font-stretch: normal; font-size: 11px; =
line-height: normal; font-family: Menlo; color: rgb(0, 0, 0);" =
class=3D""><span style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">&nbsp;static int coroutine_fn</span></div><div style=3D"margin:=
 0px; font-stretch: normal; font-size: 11px; line-height: normal; =
font-family: Menlo; color: rgb(0, 0, 0);" class=3D""><span =
style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">&nbsp;nfs_file_co_truncate(BlockDriverState *bs, int64_t =
offset, bool exact,</span></div><div style=3D"margin: 0px; font-stretch: =
normal; font-size: 11px; line-height: normal; font-family: Menlo; color: =
rgb(0, 0, 0);" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures; color: #38b9c7" class=3D"">@@ -792,6 +801,7 =
@@</span><span style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D""> static int nfs_reopen_prepare(BDRVReopenState =
*state,</span></div><div style=3D"margin: 0px; font-stretch: normal; =
font-size: 11px; line-height: normal; font-family: Menlo; color: rgb(0, =
0, 0);" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; return =
-EINVAL;</span></div><div style=3D"margin: 0px; font-stretch: normal; =
font-size: 11px; line-height: normal; font-family: Menlo; color: rgb(0, =
0, 0);" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">&nbsp;&nbsp; &nbsp; }</span></div><p =
style=3D"margin: 0px; font-stretch: normal; font-size: 11px; =
line-height: normal; font-family: Menlo; color: rgb(0, 0, 0); =
min-height: 13px;" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">&nbsp;</span><br =
class=3D"webkit-block-placeholder"></p><div style=3D"margin: 0px; =
font-stretch: normal; font-size: 11px; line-height: normal; font-family: =
Menlo; color: rgb(57, 192, 38);" class=3D""><span =
style=3D"font-variant-ligatures: no-common-ligatures" class=3D"">+#if =
!defined(_WIN32)</span></div><div style=3D"margin: 0px; font-stretch: =
normal; font-size: 11px; line-height: normal; font-family: Menlo; color: =
rgb(0, 0, 0);" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">&nbsp;&nbsp; &nbsp; /* Update cache for =
read-only reopens */</span></div><div style=3D"margin: 0px; =
font-stretch: normal; font-size: 11px; line-height: normal; font-family: =
Menlo; color: rgb(0, 0, 0);" class=3D""><span =
style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">&nbsp;&nbsp; &nbsp; if (!(state-&gt;flags &amp; BDRV_O_RDWR)) =
{</span></div><div style=3D"margin: 0px; font-stretch: normal; =
font-size: 11px; line-height: normal; font-family: Menlo; color: rgb(0, =
0, 0);" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; ret =3D =
nfs_fstat(client-&gt;context, client-&gt;fh, &amp;st);</span></div><div =
style=3D"margin: 0px; font-stretch: normal; font-size: 11px; =
line-height: normal; font-family: Menlo; color: rgb(0, 0, 0);" =
class=3D""><span style=3D"font-variant-ligatures: no-common-ligatures; =
color: #38b9c7" class=3D"">@@ -802,6 +812,7 @@</span><span =
style=3D"font-variant-ligatures: no-common-ligatures" class=3D""> static =
int nfs_reopen_prepare(BDRVReopenState *state,</span></div><div =
style=3D"margin: 0px; font-stretch: normal; font-size: 11px; =
line-height: normal; font-family: Menlo; color: rgb(0, 0, 0);" =
class=3D""><span style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; }</span></div><div =
style=3D"margin: 0px; font-stretch: normal; font-size: 11px; =
line-height: normal; font-family: Menlo; color: rgb(0, 0, 0);" =
class=3D""><span style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; client-&gt;st_blocks =3D =
st.st_blocks;</span></div><div style=3D"margin: 0px; font-stretch: =
normal; font-size: 11px; line-height: normal; font-family: Menlo; color: =
rgb(0, 0, 0);" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">&nbsp;&nbsp; &nbsp; }</span></div><div =
style=3D"margin: 0px; font-stretch: normal; font-size: 11px; =
line-height: normal; font-family: Menlo; color: rgb(57, 192, 38);" =
class=3D""><span style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">+#endif</span></div><p style=3D"margin: 0px; font-stretch: =
normal; font-size: 11px; line-height: normal; font-family: Menlo; color: =
rgb(0, 0, 0); min-height: 13px;" class=3D""><span =
style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">&nbsp;</span><br class=3D"webkit-block-placeholder"></p><div =
style=3D"margin: 0px; font-stretch: normal; font-size: 11px; =
line-height: normal; font-family: Menlo; color: rgb(0, 0, 0);" =
class=3D""><span style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">&nbsp;&nbsp; &nbsp; return 0;</span></div><div style=3D"margin:=
 0px; font-stretch: normal; font-size: 11px; line-height: normal; =
font-family: Menlo; color: rgb(0, 0, 0);" class=3D""><span =
style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">&nbsp;}</span></div><div style=3D"margin: 0px; font-stretch: =
normal; font-size: 11px; line-height: normal; font-family: Menlo; color: =
rgb(0, 0, 0);" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures; color: #38b9c7" class=3D"">@@ -869,7 +880,9 =
@@</span><span style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D""> static BlockDriver bdrv_nfs =3D {</span></div><div =
style=3D"margin: 0px; font-stretch: normal; font-size: 11px; =
line-height: normal; font-family: Menlo; color: rgb(0, 0, 0);" =
class=3D""><span style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">&nbsp;&nbsp; &nbsp; .create_opts&nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =3D =
&amp;nfs_create_opts,</span></div><p style=3D"margin: 0px; font-stretch: =
normal; font-size: 11px; line-height: normal; font-family: Menlo; color: =
rgb(0, 0, 0); min-height: 13px;" class=3D""><span =
style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">&nbsp;</span><br class=3D"webkit-block-placeholder"></p><div =
style=3D"margin: 0px; font-stretch: normal; font-size: 11px; =
line-height: normal; font-family: Menlo; color: rgb(0, 0, 0);" =
class=3D""><span style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">&nbsp;&nbsp; &nbsp; .bdrv_has_zero_init &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; =3D nfs_has_zero_init,</span></div><div =
style=3D"margin: 0px; font-stretch: normal; font-size: 11px; =
line-height: normal; font-family: Menlo; color: rgb(57, 192, 38);" =
class=3D""><span style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">+#if !defined(_WIN32)</span></div><div style=3D"margin: 0px; =
font-stretch: normal; font-size: 11px; line-height: normal; font-family: =
Menlo; color: rgb(0, 0, 0);" class=3D""><span =
style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">&nbsp;&nbsp; &nbsp; .bdrv_get_allocated_file_size &nbsp; =3D =
nfs_get_allocated_file_size,</span></div><div style=3D"margin: 0px; =
font-stretch: normal; font-size: 11px; line-height: normal; font-family: =
Menlo; color: rgb(57, 192, 38);" class=3D""><span =
style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">+#endif</span></div><div style=3D"margin: 0px; font-stretch: =
normal; font-size: 11px; line-height: normal; font-family: Menlo; color: =
rgb(0, 0, 0);" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">&nbsp;&nbsp; &nbsp; .bdrv_co_truncate =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =3D =
nfs_file_co_truncate,</span></div><p style=3D"margin: 0px; font-stretch: =
normal; font-size: 11px; line-height: normal; font-family: Menlo; color: =
rgb(0, 0, 0); min-height: 13px;" class=3D""><span =
style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">&nbsp;</span><br class=3D"webkit-block-placeholder"></p><div =
style=3D"margin: 0px; font-stretch: normal; font-size: 11px; =
line-height: normal; font-family: Menlo; color: rgb(0, 0, 0);" =
class=3D""><span style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">&nbsp;&nbsp; &nbsp; .bdrv_file_open &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =3D nfs_file_open,</span></div><div =
style=3D"margin: 0px; font-stretch: normal; font-size: 11px; =
line-height: normal; font-family: Menlo; color: rgb(0, 0, 0);" =
class=3D""><span style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D""><br class=3D""></span></div><div style=3D"margin: 0px; =
font-stretch: normal; font-size: 11px; line-height: normal; font-family: =
Menlo; color: rgb(0, 0, 0);" class=3D""><span =
style=3D"font-variant-ligatures: no-common-ligatures" class=3D""><br =
class=3D""></span></div><div style=3D"margin: 0px; font-stretch: normal; =
font-size: 11px; line-height: normal; font-family: Menlo; color: rgb(0, =
0, 0);" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">Best,</span></div><div style=3D"margin: =
0px; font-stretch: normal; font-size: 11px; line-height: normal; =
font-family: Menlo; color: rgb(0, 0, 0);" class=3D""><span =
style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">Peter</span></div></div><br class=3D""></body></html>=

--Apple-Mail=_7AB19365-29EE-47F1-BD4E-4240272F41A4--


