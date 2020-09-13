Return-Path: <SRS0=H3r+=CW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_QP_LONG_LINE,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB71C43461
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 18:59:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DA1D2158C
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 18:59:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DA1D2158C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kamp.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHXDm-0002qN-8f
	for qemu-devel@archiver.kernel.org; Sun, 13 Sep 2020 14:59:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pl@kamp.de>)
 id 1kHXCy-0001d2-DJ; Sun, 13 Sep 2020 14:58:40 -0400
Received: from kerio.kamp.de ([195.62.97.192]:55121)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pl@kamp.de>)
 id 1kHXCu-0004fJ-Gi; Sun, 13 Sep 2020 14:58:40 -0400
X-Footer: a2FtcC5kZQ==
Received: from [82.141.7.52] ([79.200.90.160]) (authenticated user pl@kamp.de)
 by kerio.kamp.de with ESMTPSA
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
 Sun, 13 Sep 2020 20:58:14 +0200
Content-Type: multipart/alternative;
 boundary=Apple-Mail-5F6402E0-D95F-4037-A161-1D11B953A1AD
Content-Transfer-Encoding: 7bit
From: Peter Lieven <pl@kamp.de>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v7 03/25] block: Fixes nfs compiling error on msys2/mingw
Date: Sun, 13 Sep 2020 20:58:16 +0200
Message-Id: <70725C86-4117-4C7A-99B1-D7B013835306@kamp.de>
References: <CAE2XoE9LHFovy+nh8z5xGrCzs+goKgJ+iTd67Zt-1k6UPx=Pxg@mail.gmail.com>
In-Reply-To: <CAE2XoE9LHFovy+nh8z5xGrCzs+goKgJ+iTd67Zt-1k6UPx=Pxg@mail.gmail.com>
To: luoyonggang@gmail.com
X-Mailer: iPhone Mail (17G80)
Received-SPF: pass client-ip=195.62.97.192; envelope-from=pl@kamp.de;
 helo=kerio.kamp.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/13 14:58:26
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 MIME_QP_LONG_LINE=0.001, SPF_HELO_NONE=0.001,
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
 Paolo Bonzini <pbonzini@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Apple-Mail-5F6402E0-D95F-4037-A161-1D11B953A1AD
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable



> Am 10.09.2020 um 22:36 schrieb =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) <=
luoyonggang@gmail.com>:
>=20
> =EF=BB=BF
>=20
>=20
>> On Fri, Sep 11, 2020 at 4:16 AM Peter Lieven <pl@kamp.de> wrote:
>>=20
>>=20
>>> Am 10.09.2020 um 12:30 schrieb Yonggang Luo <luoyonggang@gmail.com>:
>>>=20
>>> These compiling errors are fixed:
>>> ../block/nfs.c:27:10: fatal error: poll.h: No such file or directory
>>>   27 | #include <poll.h>
>>>      |          ^~~~~~~~
>>> compilation terminated.
>>>=20
>>> ../block/nfs.c:63:5: error: unknown type name 'blkcnt_t'
>>>   63 |     blkcnt_t st_blocks;
>>>      |     ^~~~~~~~
>>> ../block/nfs.c: In function 'nfs_client_open':
>>> ../block/nfs.c:550:27: error: 'struct _stat64' has no member named 'st_b=
locks'
>>>  550 |     client->st_blocks =3D st.st_blocks;
>>>      |                           ^
>>> ../block/nfs.c: In function 'nfs_get_allocated_file_size':
>>> ../block/nfs.c:751:41: error: 'struct _stat64' has no member named 'st_b=
locks'
>>>  751 |     return (task.ret < 0 ? task.ret : st.st_blocks * 512);
>>>      |                                         ^
>>> ../block/nfs.c: In function 'nfs_reopen_prepare':
>>> ../block/nfs.c:805:31: error: 'struct _stat64' has no member named 'st_b=
locks'
>>>  805 |         client->st_blocks =3D st.st_blocks;
>>>      |                               ^
>>> ../block/nfs.c: In function 'nfs_get_allocated_file_size':
>>> ../block/nfs.c:752:1: error: control reaches end of non-void function [-=
Werror=3Dreturn-type]
>>>  752 | }
>>>      | ^
>>>=20
>>> On msys2/mingw, there is no st_blocks in struct _stat64, so we use consi=
stence st_size instead.
>>>=20
>>> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
>>> ---
>>> block/nfs.c | 32 +++++++++++++++++++++++++-------
>>> 1 file changed, 25 insertions(+), 7 deletions(-)
>>>=20
>>> diff --git a/block/nfs.c b/block/nfs.c
>>> index 61a249a9fc..db6d8c2d2b 100644
>>> --- a/block/nfs.c
>>> +++ b/block/nfs.c
>>> @@ -24,7 +24,9 @@
>>>=20
>>> #include "qemu/osdep.h"
>>>=20
>>> +#if !defined(_WIN32)
>>> #include <poll.h>
>>> +#endif
>>> #include "qemu/config-file.h"
>>> #include "qemu/error-report.h"
>>> #include "qapi/error.h"
>>> @@ -51,6 +53,13 @@
>>> #define QEMU_NFS_MAX_PAGECACHE_SIZE (8388608 / NFS_BLKSIZE)
>>> #define QEMU_NFS_MAX_DEBUG_LEVEL 2
>>>=20
>>> +#if defined (_WIN32)
>>> +#define nfs_stat __stat64
>>> +typedef long long blkcnt_t;
>>> +#else
>>> +#define nfs_stat stat
>>> +#endif
>>> +
>>> typedef struct NFSClient {
>>>     struct nfs_context *context;
>>>     struct nfsfh *fh;
>>> @@ -70,7 +79,7 @@ typedef struct NFSRPC {
>>>     int ret;
>>>     int complete;
>>>     QEMUIOVector *iov;
>>> -    struct stat *st;
>>> +    struct nfs_stat *st;
>>>     Coroutine *co;
>>>     NFSClient *client;
>>> } NFSRPC;
>>> @@ -415,11 +424,20 @@ static void nfs_file_close(BlockDriverState *bs)
>>>     nfs_client_close(client);
>>> }
>>>=20
>>> +static blkcnt_t nfs_get_st_blocks(const struct nfs_stat *st)
>>> +{
>>> +#if defined(_WIN32)
>>> +    return (st->st_size + 511) / 512;
>>> +#else
>>> +    return st->st_blocks;
>>> +#endif
>>> +}
>>> +
>>> static int64_t nfs_client_open(NFSClient *client, BlockdevOptionsNfs *op=
ts,
>>>                                int flags, int open_flags, Error **errp)
>>> {
>>>     int64_t ret =3D -EINVAL;
>>> -    struct stat st;
>>> +    struct nfs_stat st;
>>>     char *file =3D NULL, *strp =3D NULL;
>>>=20
>>>     qemu_mutex_init(&client->mutex);
>>> @@ -545,7 +563,7 @@ static int64_t nfs_client_open(NFSClient *client, Bl=
ockdevOptionsNfs *opts,
>>>     }
>>>=20
>>>     ret =3D DIV_ROUND_UP(st.st_size, BDRV_SECTOR_SIZE);
>>> -    client->st_blocks =3D st.st_blocks;
>>> +    client->st_blocks =3D nfs_get_st_blocks(&st);
>>>     client->has_zero_init =3D S_ISREG(st.st_mode);
>>>     *strp =3D '/';
>>>     goto out;
>>> @@ -729,7 +747,7 @@ static int64_t nfs_get_allocated_file_size(BlockDriv=
erState *bs)
>>> {
>>>     NFSClient *client =3D bs->opaque;
>>>     NFSRPC task =3D {0};
>>> -    struct stat st;
>>> +    struct nfs_stat st;
>>>=20
>>>     if (bdrv_is_read_only(bs) &&
>>>         !(bs->open_flags & BDRV_O_NOCACHE)) {
>>> @@ -746,7 +764,7 @@ static int64_t nfs_get_allocated_file_size(BlockDriv=
erState *bs)
>>>     nfs_set_events(client);
>>>     BDRV_POLL_WHILE(bs, !task.complete);
>>>=20
>>> -    return (task.ret < 0 ? task.ret : st.st_blocks * 512);
>>> +    return (task.ret < 0 ? task.ret : nfs_get_st_blocks(&st) * 512);
>>> }
>>>=20
>>> static int coroutine_fn
>>> @@ -778,7 +796,7 @@ static int nfs_reopen_prepare(BDRVReopenState *state=
,
>>>                               BlockReopenQueue *queue, Error **errp)
>>> {
>>>     NFSClient *client =3D state->bs->opaque;
>>> -    struct stat st;
>>> +    struct nfs_stat st;
>>>     int ret =3D 0;
>>>=20
>>>     if (state->flags & BDRV_O_RDWR && bdrv_is_read_only(state->bs)) {
>>> @@ -800,7 +818,7 @@ static int nfs_reopen_prepare(BDRVReopenState *state=
,
>>>                        nfs_get_error(client->context));
>>>             return ret;
>>>         }
>>> -        client->st_blocks =3D st.st_blocks;
>>> +        client->st_blocks =3D nfs_get_st_blocks(&st);
>>>     }
>>>=20
>>>     return 0;
>>> --=20
>>> 2.28.0.windows.1
>>=20
>>=20
>> You still implement nfs_get_allocated_file_size without actually returnin=
g the allocated file size on WIN32.=20
>> I would simply do this:
>>=20
>> diff --git a/block/nfs.c b/block/nfs.c
>> index 61a249a..0983143 100644
>> --- a/block/nfs.c
>> +++ b/block/nfs.c
>> @@ -24,7 +24,9 @@
>> =20
>>  #include "qemu/osdep.h"
>> =20
>> +#if !defined(_WIN32)
>>  #include <poll.h>
>> +#endif
>>  #include "qemu/config-file.h"
>>  #include "qemu/error-report.h"
>>  #include "qapi/error.h"
>> @@ -58,7 +60,9 @@ typedef struct NFSClient {
>>      bool has_zero_init;
>>      AioContext *aio_context;
>>      QemuMutex mutex;
>> +#if !defined(_WIN32)
>>      blkcnt_t st_blocks;
>> +#endif
>>      bool cache_used;
>>      NFSServer *server;
>>      char *path;
>> @@ -545,7 +549,9 @@ static int64_t nfs_client_open(NFSClient *client, Blo=
ckdevOptionsNfs *opts,
>>      }
>> =20
>>      ret =3D DIV_ROUND_UP(st.st_size, BDRV_SECTOR_SIZE);
>> +#if !defined(_WIN32)
>>      client->st_blocks =3D st.st_blocks;
>> +#endif
>>      client->has_zero_init =3D S_ISREG(st.st_mode);
>>      *strp =3D '/';
>>      goto out;
>> @@ -706,6 +712,8 @@ static int nfs_has_zero_init(BlockDriverState *bs)
>>      return client->has_zero_init;
>>  }
>> =20
>> +
>> +#if !defined(_WIN32)
>>  /* Called (via nfs_service) with QemuMutex held.  */
>>  static void
>>  nfs_get_allocated_file_size_cb(int ret, struct nfs_context *nfs, void *d=
ata,
>> @@ -748,6 +756,7 @@ static int64_t nfs_get_allocated_file_size(BlockDrive=
rState *bs)
>> =20
>>      return (task.ret < 0 ? task.ret : st.st_blocks * 512);
>>  }
>> +#endif
>> =20
>>  static int coroutine_fn
>>  nfs_file_co_truncate(BlockDriverState *bs, int64_t offset, bool exact,
>> @@ -792,6 +801,7 @@ static int nfs_reopen_prepare(BDRVReopenState *state,=

>>          return -EINVAL;
>>      }
>> =20
>> +#if !defined(_WIN32)
>>      /* Update cache for read-only reopens */
>>      if (!(state->flags & BDRV_O_RDWR)) {
>>          ret =3D nfs_fstat(client->context, client->fh, &st);
>> @@ -802,6 +812,7 @@ static int nfs_reopen_prepare(BDRVReopenState *state,=

>>          }
>>          client->st_blocks =3D st.st_blocks;
>>      }
>> +#endif
>> =20
>>      return 0;
>>  }
>> @@ -869,7 +880,9 @@ static BlockDriver bdrv_nfs =3D {
>>      .create_opts                    =3D &nfs_create_opts,
>> =20
>>      .bdrv_has_zero_init             =3D nfs_has_zero_init,
>> +#if !defined(_WIN32)
>>      .bdrv_get_allocated_file_size   =3D nfs_get_allocated_file_size,
>> +#endif
>>      .bdrv_co_truncate               =3D nfs_file_co_truncate,
>> =20
>>      .bdrv_file_open                 =3D nfs_file_open,
>>=20
>>=20
>> Best,
>> Peter
> Any git repo have this patch? I can cherry-pick it directly=20

not yet. but feel free to use this diff for your own patch. otherwise i can s=
etup a branch with this patch on github where you can pick it.

Peter


--Apple-Mail-5F6402E0-D95F-4037-A161-1D11B953A1AD
Content-Type: text/html;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; charset=3D=
utf-8"></head><body dir=3D"auto"><br><div dir=3D"ltr"><br><blockquote type=3D=
"cite">Am 10.09.2020 um 22:36 schrieb =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang L=
uo) &lt;luoyonggang@gmail.com&gt;:<br><br></blockquote></div><blockquote typ=
e=3D"cite"><div dir=3D"ltr">=EF=BB=BF<div dir=3D"ltr"><div dir=3D"ltr"><br><=
/div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On=
 Fri, Sep 11, 2020 at 4:16 AM Peter Lieven &lt;<a href=3D"mailto:pl@kamp.de"=
>pl@kamp.de</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex"><div style=3D"overflow-wrap: break-word;"><br><div><br><blockquote ty=
pe=3D"cite"><div>Am 10.09.2020 um 12:30 schrieb Yonggang Luo &lt;<a href=3D"=
mailto:luoyonggang@gmail.com" target=3D"_blank">luoyonggang@gmail.com</a>&gt=
;:</div><br><div><div>These compiling errors are fixed:<br>../block/nfs.c:27=
:10: fatal error: poll.h: No such file or directory<br> &nbsp;&nbsp;27 | #in=
clude &lt;poll.h&gt;<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;^~~~~~~~<br>compilation terminated.<br><b=
r>../block/nfs.c:63:5: error: unknown type name 'blkcnt_t'<br> &nbsp;&nbsp;6=
3 | &nbsp;&nbsp;&nbsp;&nbsp;blkcnt_t st_blocks;<br> &nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;^~~~~~~~<br>../block/nfs.c: In function 'nfs=
_client_open':<br>../block/nfs.c:550:27: error: 'struct _stat64' has no memb=
er named 'st_blocks'<br> &nbsp;550 | &nbsp;&nbsp;&nbsp;&nbsp;client-&gt;st_b=
locks =3D st.st_blocks;<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;^<br>../bloc=
k/nfs.c: In function 'nfs_get_allocated_file_size':<br>../block/nfs.c:751:41=
: error: 'struct _stat64' has no member named 'st_blocks'<br> &nbsp;751 | &n=
bsp;&nbsp;&nbsp;&nbsp;return (task.ret &lt; 0 ? task.ret : st.st_blocks * 51=
2);<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;^<br>../block/nfs.c: In f=
unction 'nfs_reopen_prepare':<br>../block/nfs.c:805:31: error: 'struct _stat=
64' has no member named 'st_blocks'<br> &nbsp;805 | &nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;client-&gt;st_blocks =3D st.st_blocks;<br> &nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;^<br>../block/nfs.c: In f=
unction 'nfs_get_allocated_file_size':<br>../block/nfs.c:752:1: error: contr=
ol reaches end of non-void function [-Werror=3Dreturn-type]<br> &nbsp;752 | }=
<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| ^<br><br>On msys2/mingw, there is no st=
_blocks in struct _stat64, so we use consistence st_size instead.<br><br>Sig=
ned-off-by: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.com" target=
=3D"_blank">luoyonggang@gmail.com</a>&gt;<br>---<br> block/nfs.c | 32 ++++++=
+++++++++++++++++++-------<br> 1 file changed, 25 insertions(+), 7 deletions=
(-)<br><br>diff --git a/block/nfs.c b/block/nfs.c<br>index 61a249a9fc..db6d8=
c2d2b 100644<br>--- a/block/nfs.c<br>+++ b/block/nfs.c<br>@@ -24,7 +24,9 @@<=
br><br> #include "qemu/osdep.h"<br><br>+#if !defined(_WIN32)<br> #include &l=
t;poll.h&gt;<br>+#endif<br> #include "qemu/config-file.h"<br> #include "qemu=
/error-report.h"<br> #include "qapi/error.h"<br>@@ -51,6 +53,13 @@<br> #defi=
ne QEMU_NFS_MAX_PAGECACHE_SIZE (8388608 / NFS_BLKSIZE)<br> #define QEMU_NFS_=
MAX_DEBUG_LEVEL 2<br><br>+#if defined (_WIN32)<br>+#define nfs_stat __stat64=
<br>+typedef long long blkcnt_t;<br>+#else<br>+#define nfs_stat stat<br>+#en=
dif<br>+<br> typedef struct NFSClient {<br> &nbsp;&nbsp;&nbsp;&nbsp;struct n=
fs_context *context;<br> &nbsp;&nbsp;&nbsp;&nbsp;struct nfsfh *fh;<br>@@ -70=
,7 +79,7 @@ typedef struct NFSRPC {<br> &nbsp;&nbsp;&nbsp;&nbsp;int ret;<br>=
 &nbsp;&nbsp;&nbsp;&nbsp;int complete;<br> &nbsp;&nbsp;&nbsp;&nbsp;QEMUIOVec=
tor *iov;<br>- &nbsp;&nbsp;&nbsp;struct stat *st;<br>+ &nbsp;&nbsp;&nbsp;str=
uct nfs_stat *st;<br> &nbsp;&nbsp;&nbsp;&nbsp;Coroutine *co;<br> &nbsp;&nbsp=
;&nbsp;&nbsp;NFSClient *client;<br> } NFSRPC;<br>@@ -415,11 +424,20 @@ stati=
c void nfs_file_close(BlockDriverState *bs)<br> &nbsp;&nbsp;&nbsp;&nbsp;nfs_=
client_close(client);<br> }<br><br>+static blkcnt_t nfs_get_st_blocks(const s=
truct nfs_stat *st)<br>+{<br>+#if defined(_WIN32)<br>+ &nbsp;&nbsp;&nbsp;ret=
urn (st-&gt;st_size + 511) / 512;<br>+#else<br>+ &nbsp;&nbsp;&nbsp;return st=
-&gt;st_blocks;<br>+#endif<br>+}<br>+<br> static int64_t nfs_client_open(NFS=
Client *client, BlockdevOptionsNfs *opts,<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;int flags, int open_flags, Error **errp)<br> {<br> &nbsp;&nbsp;&nbsp;&nb=
sp;int64_t ret =3D -EINVAL;<br>- &nbsp;&nbsp;&nbsp;struct stat st;<br>+ &nbs=
p;&nbsp;&nbsp;struct nfs_stat st;<br> &nbsp;&nbsp;&nbsp;&nbsp;char *file =3D=
 NULL, *strp =3D NULL;<br><br> &nbsp;&nbsp;&nbsp;&nbsp;qemu_mutex_init(&amp;=
client-&gt;mutex);<br>@@ -545,7 +563,7 @@ static int64_t nfs_client_open(NFS=
Client *client, BlockdevOptionsNfs *opts,<br> &nbsp;&nbsp;&nbsp;&nbsp;}<br><=
br> &nbsp;&nbsp;&nbsp;&nbsp;ret =3D DIV_ROUND_UP(st.st_size, BDRV_SECTOR_SIZ=
E);<br>- &nbsp;&nbsp;&nbsp;client-&gt;st_blocks =3D st.st_blocks;<br>+ &nbsp=
;&nbsp;&nbsp;client-&gt;st_blocks =3D nfs_get_st_blocks(&amp;st);<br> &nbsp;=
&nbsp;&nbsp;&nbsp;client-&gt;has_zero_init =3D S_ISREG(st.st_mode);<br> &nbs=
p;&nbsp;&nbsp;&nbsp;*strp =3D '/';<br> &nbsp;&nbsp;&nbsp;&nbsp;goto out;<br>=
@@ -729,7 +747,7 @@ static int64_t nfs_get_allocated_file_size(BlockDriverSt=
ate *bs)<br> {<br> &nbsp;&nbsp;&nbsp;&nbsp;NFSClient *client =3D bs-&gt;opaq=
ue;<br> &nbsp;&nbsp;&nbsp;&nbsp;NFSRPC task =3D {0};<br>- &nbsp;&nbsp;&nbsp;=
struct stat st;<br>+ &nbsp;&nbsp;&nbsp;struct nfs_stat st;<br><br> &nbsp;&nb=
sp;&nbsp;&nbsp;if (bdrv_is_read_only(bs) &amp;&amp;<br> &nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;!(bs-&gt;open_flags &amp; BDRV_O_NOCACHE)) {<br>=
@@ -746,7 +764,7 @@ static int64_t nfs_get_allocated_file_size(BlockDriverSt=
ate *bs)<br> &nbsp;&nbsp;&nbsp;&nbsp;nfs_set_events(client);<br> &nbsp;&nbsp=
;&nbsp;&nbsp;BDRV_POLL_WHILE(bs, !task.complete);<br><br>- &nbsp;&nbsp;&nbsp=
;return (task.ret &lt; 0 ? task.ret : st.st_blocks * 512);<br>+ &nbsp;&nbsp;=
&nbsp;return (task.ret &lt; 0 ? task.ret : nfs_get_st_blocks(&amp;st) * 512)=
;<br> }<br><br> static int coroutine_fn<br>@@ -778,7 +796,7 @@ static int nf=
s_reopen_prepare(BDRVReopenState *state,<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Blo=
ckReopenQueue *queue, Error **errp)<br> {<br> &nbsp;&nbsp;&nbsp;&nbsp;NFSCli=
ent *client =3D state-&gt;bs-&gt;opaque;<br>- &nbsp;&nbsp;&nbsp;struct stat s=
t;<br>+ &nbsp;&nbsp;&nbsp;struct nfs_stat st;<br> &nbsp;&nbsp;&nbsp;&nbsp;in=
t ret =3D 0;<br><br> &nbsp;&nbsp;&nbsp;&nbsp;if (state-&gt;flags &amp; BDRV_=
O_RDWR &amp;&amp; bdrv_is_read_only(state-&gt;bs)) {<br>@@ -800,7 +818,7 @@ s=
tatic int nfs_reopen_prepare(BDRVReopenState *state,<br> &nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;nfs_get_error(client-&gt;context)=
);<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;return ret;<br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br>- &n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;client-&gt;st_blocks =3D st.st_block=
s;<br>+ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;client-&gt;st_blocks =3D n=
fs_get_st_blocks(&amp;st);<br> &nbsp;&nbsp;&nbsp;&nbsp;}<br><br> &nbsp;&nbsp=
;&nbsp;&nbsp;return 0;<br>-- <br>2.28.0.windows.1<br></div></div></blockquot=
e><div><br></div><div><br></div>You still implement nfs_get_allocated_file_s=
ize without actually returning the allocated file size on WIN32.&nbsp;</div>=
<div>I would simply do this:</div><div><br></div><div><div style=3D"margin:0=
px;font-stretch:normal;font-size:11px;line-height:normal;font-family:Menlo;c=
olor:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-ligatures">=
<b>diff --git a/block/nfs.c b/block/nfs.c</b></span></div><div style=3D"marg=
in:0px;font-stretch:normal;font-size:11px;line-height:normal;font-family:Men=
lo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-ligatur=
es"><b>index 61a249a..0983143 100644</b></span></div><div style=3D"margin:0p=
x;font-stretch:normal;font-size:11px;line-height:normal;font-family:Menlo;co=
lor:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-ligatures"><=
b>--- a/block/nfs.c</b></span></div><div style=3D"margin:0px;font-stretch:no=
rmal;font-size:11px;line-height:normal;font-family:Menlo;color:rgb(0,0,0)"><=
span style=3D"font-variant-ligatures:no-common-ligatures"><b>+++ b/block/nfs=
.c</b></span></div><div style=3D"margin:0px;font-stretch:normal;font-size:11=
px;line-height:normal;font-family:Menlo;color:rgb(56,185,199)"><span style=3D=
"font-variant-ligatures:no-common-ligatures">@@ -24,7 +24,9 @@</span></div><=
p style=3D"margin:0px;font-stretch:normal;font-size:11px;line-height:normal;=
font-family:Menlo;color:rgb(0,0,0);min-height:13px"><span style=3D"font-vari=
ant-ligatures:no-common-ligatures">&nbsp;</span><br></p><div style=3D"margin=
:0px;font-stretch:normal;font-size:11px;line-height:normal;font-family:Menlo=
;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-ligatures=
">&nbsp;#include "qemu/osdep.h"</span></div><p style=3D"margin:0px;font-stre=
tch:normal;font-size:11px;line-height:normal;font-family:Menlo;color:rgb(0,0=
,0);min-height:13px"><span style=3D"font-variant-ligatures:no-common-ligatur=
es">&nbsp;</span><br></p><div style=3D"margin:0px;font-stretch:normal;font-s=
ize:11px;line-height:normal;font-family:Menlo;color:rgb(57,192,38)"><span st=
yle=3D"font-variant-ligatures:no-common-ligatures">+#if !defined(_WIN32)</sp=
an></div><div style=3D"margin:0px;font-stretch:normal;font-size:11px;line-he=
ight:normal;font-family:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-=
ligatures:no-common-ligatures">&nbsp;#include &lt;poll.h&gt;</span></div><di=
v style=3D"margin:0px;font-stretch:normal;font-size:11px;line-height:normal;=
font-family:Menlo;color:rgb(57,192,38)"><span style=3D"font-variant-ligature=
s:no-common-ligatures">+#endif</span></div><div style=3D"margin:0px;font-str=
etch:normal;font-size:11px;line-height:normal;font-family:Menlo;color:rgb(0,=
0,0)"><span style=3D"font-variant-ligatures:no-common-ligatures">&nbsp;#incl=
ude "qemu/config-file.h"</span></div><div style=3D"margin:0px;font-stretch:n=
ormal;font-size:11px;line-height:normal;font-family:Menlo;color:rgb(0,0,0)">=
<span style=3D"font-variant-ligatures:no-common-ligatures">&nbsp;#include "q=
emu/error-report.h"</span></div><div style=3D"margin:0px;font-stretch:normal=
;font-size:11px;line-height:normal;font-family:Menlo;color:rgb(0,0,0)"><span=
 style=3D"font-variant-ligatures:no-common-ligatures">&nbsp;#include "qapi/e=
rror.h"</span></div><div style=3D"margin:0px;font-stretch:normal;font-size:1=
1px;line-height:normal;font-family:Menlo;color:rgb(0,0,0)"><span style=3D"fo=
nt-variant-ligatures:no-common-ligatures;color:rgb(56,185,199)">@@ -58,7 +60=
,9 @@</span><span style=3D"font-variant-ligatures:no-common-ligatures"> type=
def struct NFSClient {</span></div><div style=3D"margin:0px;font-stretch:nor=
mal;font-size:11px;line-height:normal;font-family:Menlo;color:rgb(0,0,0)"><s=
pan style=3D"font-variant-ligatures:no-common-ligatures">&nbsp;&nbsp; &nbsp;=
 bool has_zero_init;</span></div><div style=3D"margin:0px;font-stretch:norma=
l;font-size:11px;line-height:normal;font-family:Menlo;color:rgb(0,0,0)"><spa=
n style=3D"font-variant-ligatures:no-common-ligatures">&nbsp;&nbsp; &nbsp; A=
ioContext *aio_context;</span></div><div style=3D"margin:0px;font-stretch:no=
rmal;font-size:11px;line-height:normal;font-family:Menlo;color:rgb(0,0,0)"><=
span style=3D"font-variant-ligatures:no-common-ligatures">&nbsp;&nbsp; &nbsp=
; QemuMutex mutex;</span></div><div style=3D"margin:0px;font-stretch:normal;=
font-size:11px;line-height:normal;font-family:Menlo;color:rgb(57,192,38)"><s=
pan style=3D"font-variant-ligatures:no-common-ligatures">+#if !defined(_WIN3=
2)</span></div><div style=3D"margin:0px;font-stretch:normal;font-size:11px;l=
ine-height:normal;font-family:Menlo;color:rgb(0,0,0)"><span style=3D"font-va=
riant-ligatures:no-common-ligatures">&nbsp;&nbsp; &nbsp; blkcnt_t st_blocks;=
</span></div><div style=3D"margin:0px;font-stretch:normal;font-size:11px;lin=
e-height:normal;font-family:Menlo;color:rgb(57,192,38)"><span style=3D"font-=
variant-ligatures:no-common-ligatures">+#endif</span></div><div style=3D"mar=
gin:0px;font-stretch:normal;font-size:11px;line-height:normal;font-family:Me=
nlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-ligatu=
res">&nbsp;&nbsp; &nbsp; bool cache_used;</span></div><div style=3D"margin:0=
px;font-stretch:normal;font-size:11px;line-height:normal;font-family:Menlo;c=
olor:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-ligatures">=
&nbsp;&nbsp; &nbsp; NFSServer *server;</span></div><div style=3D"margin:0px;=
font-stretch:normal;font-size:11px;line-height:normal;font-family:Menlo;colo=
r:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-ligatures">&nb=
sp;&nbsp; &nbsp; char *path;</span></div><div style=3D"margin:0px;font-stret=
ch:normal;font-size:11px;line-height:normal;font-family:Menlo;color:rgb(0,0,=
0)"><span style=3D"font-variant-ligatures:no-common-ligatures;color:rgb(56,1=
85,199)">@@ -545,7 +549,9 @@</span><span style=3D"font-variant-ligatures:no-=
common-ligatures"> static int64_t nfs_client_open(NFSClient *client, Blockde=
vOptionsNfs *opts,</span></div><div style=3D"margin:0px;font-stretch:normal;=
font-size:11px;line-height:normal;font-family:Menlo;color:rgb(0,0,0)"><span s=
tyle=3D"font-variant-ligatures:no-common-ligatures">&nbsp;&nbsp; &nbsp; }</s=
pan></div><p style=3D"margin:0px;font-stretch:normal;font-size:11px;line-hei=
ght:normal;font-family:Menlo;color:rgb(0,0,0);min-height:13px"><span style=3D=
"font-variant-ligatures:no-common-ligatures">&nbsp;</span><br></p><div style=
=3D"margin:0px;font-stretch:normal;font-size:11px;line-height:normal;font-fa=
mily:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common=
-ligatures">&nbsp;&nbsp; &nbsp; ret =3D DIV_ROUND_UP(st.st_size, BDRV_SECTOR=
_SIZE);</span></div><div style=3D"margin:0px;font-stretch:normal;font-size:1=
1px;line-height:normal;font-family:Menlo;color:rgb(57,192,38)"><span style=3D=
"font-variant-ligatures:no-common-ligatures">+#if !defined(_WIN32)</span></d=
iv><div style=3D"margin:0px;font-stretch:normal;font-size:11px;line-height:n=
ormal;font-family:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatu=
res:no-common-ligatures">&nbsp;&nbsp; &nbsp; client-&gt;st_blocks =3D st.st_=
blocks;</span></div><div style=3D"margin:0px;font-stretch:normal;font-size:1=
1px;line-height:normal;font-family:Menlo;color:rgb(57,192,38)"><span style=3D=
"font-variant-ligatures:no-common-ligatures">+#endif</span></div><div style=3D=
"margin:0px;font-stretch:normal;font-size:11px;line-height:normal;font-famil=
y:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">&nbsp;&nbsp; &nbsp; client-&gt;has_zero_init =3D S_ISREG(st.st_mode=
);</span></div><div style=3D"margin:0px;font-stretch:normal;font-size:11px;l=
ine-height:normal;font-family:Menlo;color:rgb(0,0,0)"><span style=3D"font-va=
riant-ligatures:no-common-ligatures">&nbsp;&nbsp; &nbsp; *strp =3D '/';</spa=
n></div><div style=3D"margin:0px;font-stretch:normal;font-size:11px;line-hei=
ght:normal;font-family:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-l=
igatures:no-common-ligatures">&nbsp;&nbsp; &nbsp; goto out;</span></div><div=
 style=3D"margin:0px;font-stretch:normal;font-size:11px;line-height:normal;f=
ont-family:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-=
common-ligatures;color:rgb(56,185,199)">@@ -706,6 +712,8 @@</span><span styl=
e=3D"font-variant-ligatures:no-common-ligatures"> static int nfs_has_zero_in=
it(BlockDriverState *bs)</span></div><div style=3D"margin:0px;font-stretch:n=
ormal;font-size:11px;line-height:normal;font-family:Menlo;color:rgb(0,0,0)">=
<span style=3D"font-variant-ligatures:no-common-ligatures">&nbsp;&nbsp; &nbs=
p; return client-&gt;has_zero_init;</span></div><div style=3D"margin:0px;fon=
t-stretch:normal;font-size:11px;line-height:normal;font-family:Menlo;color:r=
gb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-ligatures">&nbsp;=
}</span></div><p style=3D"margin:0px;font-stretch:normal;font-size:11px;line=
-height:normal;font-family:Menlo;color:rgb(0,0,0);min-height:13px"><span sty=
le=3D"font-variant-ligatures:no-common-ligatures">&nbsp;</span><br></p><div s=
tyle=3D"margin:0px;font-stretch:normal;font-size:11px;line-height:normal;fon=
t-family:Menlo;color:rgb(57,192,38)"><span style=3D"font-variant-ligatures:n=
o-common-ligatures">+</span></div><div style=3D"margin:0px;font-stretch:norm=
al;font-size:11px;line-height:normal;font-family:Menlo;color:rgb(57,192,38)"=
><span style=3D"font-variant-ligatures:no-common-ligatures">+#if !defined(_W=
IN32)</span></div><div style=3D"margin:0px;font-stretch:normal;font-size:11p=
x;line-height:normal;font-family:Menlo;color:rgb(0,0,0)"><span style=3D"font=
-variant-ligatures:no-common-ligatures">&nbsp;/* Called (via nfs_service) wi=
th QemuMutex held.&nbsp; */</span></div><div style=3D"margin:0px;font-stretc=
h:normal;font-size:11px;line-height:normal;font-family:Menlo;color:rgb(0,0,0=
)"><span style=3D"font-variant-ligatures:no-common-ligatures">&nbsp;static v=
oid</span></div><div style=3D"margin:0px;font-stretch:normal;font-size:11px;=
line-height:normal;font-family:Menlo;color:rgb(0,0,0)"><span style=3D"font-v=
ariant-ligatures:no-common-ligatures">&nbsp;nfs_get_allocated_file_size_cb(i=
nt ret, struct nfs_context *nfs, void *data,</span></div><div style=3D"margi=
n:0px;font-stretch:normal;font-size:11px;line-height:normal;font-family:Menl=
o;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-ligature=
s;color:rgb(56,185,199)">@@ -748,6 +756,7 @@</span><span style=3D"font-varia=
nt-ligatures:no-common-ligatures"> static int64_t nfs_get_allocated_file_siz=
e(BlockDriverState *bs)</span></div><p style=3D"margin:0px;font-stretch:norm=
al;font-size:11px;line-height:normal;font-family:Menlo;color:rgb(0,0,0);min-=
height:13px"><span style=3D"font-variant-ligatures:no-common-ligatures">&nbs=
p;</span><br></p><div style=3D"margin:0px;font-stretch:normal;font-size:11px=
;line-height:normal;font-family:Menlo;color:rgb(0,0,0)"><span style=3D"font-=
variant-ligatures:no-common-ligatures">&nbsp;&nbsp; &nbsp; return (task.ret &=
lt; 0 ? task.ret : st.st_blocks * 512);</span></div><div style=3D"margin:0px=
;font-stretch:normal;font-size:11px;line-height:normal;font-family:Menlo;col=
or:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-ligatures">&n=
bsp;}</span></div><div style=3D"margin:0px;font-stretch:normal;font-size:11p=
x;line-height:normal;font-family:Menlo;color:rgb(57,192,38)"><span style=3D"=
font-variant-ligatures:no-common-ligatures">+#endif</span></div><p style=3D"=
margin:0px;font-stretch:normal;font-size:11px;line-height:normal;font-family=
:Menlo;color:rgb(0,0,0);min-height:13px"><span style=3D"font-variant-ligatur=
es:no-common-ligatures">&nbsp;</span><br></p><div style=3D"margin:0px;font-s=
tretch:normal;font-size:11px;line-height:normal;font-family:Menlo;color:rgb(=
0,0,0)"><span style=3D"font-variant-ligatures:no-common-ligatures">&nbsp;sta=
tic int coroutine_fn</span></div><div style=3D"margin:0px;font-stretch:norma=
l;font-size:11px;line-height:normal;font-family:Menlo;color:rgb(0,0,0)"><spa=
n style=3D"font-variant-ligatures:no-common-ligatures">&nbsp;nfs_file_co_tru=
ncate(BlockDriverState *bs, int64_t offset, bool exact,</span></div><div sty=
le=3D"margin:0px;font-stretch:normal;font-size:11px;line-height:normal;font-=
family:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-comm=
on-ligatures;color:rgb(56,185,199)">@@ -792,6 +801,7 @@</span><span style=3D=
"font-variant-ligatures:no-common-ligatures"> static int nfs_reopen_prepare(=
BDRVReopenState *state,</span></div><div style=3D"margin:0px;font-stretch:no=
rmal;font-size:11px;line-height:normal;font-family:Menlo;color:rgb(0,0,0)"><=
span style=3D"font-variant-ligatures:no-common-ligatures">&nbsp;&nbsp; &nbsp=
; &nbsp; &nbsp; return -EINVAL;</span></div><div style=3D"margin:0px;font-st=
retch:normal;font-size:11px;line-height:normal;font-family:Menlo;color:rgb(0=
,0,0)"><span style=3D"font-variant-ligatures:no-common-ligatures">&nbsp;&nbs=
p; &nbsp; }</span></div><p style=3D"margin:0px;font-stretch:normal;font-size=
:11px;line-height:normal;font-family:Menlo;color:rgb(0,0,0);min-height:13px"=
><span style=3D"font-variant-ligatures:no-common-ligatures">&nbsp;</span><br=
></p><div style=3D"margin:0px;font-stretch:normal;font-size:11px;line-height=
:normal;font-family:Menlo;color:rgb(57,192,38)"><span style=3D"font-variant-=
ligatures:no-common-ligatures">+#if !defined(_WIN32)</span></div><div style=3D=
"margin:0px;font-stretch:normal;font-size:11px;line-height:normal;font-famil=
y:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-li=
gatures">&nbsp;&nbsp; &nbsp; /* Update cache for read-only reopens */</span>=
</div><div style=3D"margin:0px;font-stretch:normal;font-size:11px;line-heigh=
t:normal;font-family:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-lig=
atures:no-common-ligatures">&nbsp;&nbsp; &nbsp; if (!(state-&gt;flags &amp; B=
DRV_O_RDWR)) {</span></div><div style=3D"margin:0px;font-stretch:normal;font=
-size:11px;line-height:normal;font-family:Menlo;color:rgb(0,0,0)"><span styl=
e=3D"font-variant-ligatures:no-common-ligatures">&nbsp;&nbsp; &nbsp; &nbsp; &=
nbsp; ret =3D nfs_fstat(client-&gt;context, client-&gt;fh, &amp;st);</span><=
/div><div style=3D"margin:0px;font-stretch:normal;font-size:11px;line-height=
:normal;font-family:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-liga=
tures:no-common-ligatures;color:rgb(56,185,199)">@@ -802,6 +812,7 @@</span><=
span style=3D"font-variant-ligatures:no-common-ligatures"> static int nfs_re=
open_prepare(BDRVReopenState *state,</span></div><div style=3D"margin:0px;fo=
nt-stretch:normal;font-size:11px;line-height:normal;font-family:Menlo;color:=
rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-ligatures">&nbsp=
;&nbsp; &nbsp; &nbsp; &nbsp; }</span></div><div style=3D"margin:0px;font-str=
etch:normal;font-size:11px;line-height:normal;font-family:Menlo;color:rgb(0,=
0,0)"><span style=3D"font-variant-ligatures:no-common-ligatures">&nbsp;&nbsp=
; &nbsp; &nbsp; &nbsp; client-&gt;st_blocks =3D st.st_blocks;</span></div><d=
iv style=3D"margin:0px;font-stretch:normal;font-size:11px;line-height:normal=
;font-family:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:n=
o-common-ligatures">&nbsp;&nbsp; &nbsp; }</span></div><div style=3D"margin:0=
px;font-stretch:normal;font-size:11px;line-height:normal;font-family:Menlo;c=
olor:rgb(57,192,38)"><span style=3D"font-variant-ligatures:no-common-ligatur=
es">+#endif</span></div><p style=3D"margin:0px;font-stretch:normal;font-size=
:11px;line-height:normal;font-family:Menlo;color:rgb(0,0,0);min-height:13px"=
><span style=3D"font-variant-ligatures:no-common-ligatures">&nbsp;</span><br=
></p><div style=3D"margin:0px;font-stretch:normal;font-size:11px;line-height=
:normal;font-family:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-liga=
tures:no-common-ligatures">&nbsp;&nbsp; &nbsp; return 0;</span></div><div st=
yle=3D"margin:0px;font-stretch:normal;font-size:11px;line-height:normal;font=
-family:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-com=
mon-ligatures">&nbsp;}</span></div><div style=3D"margin:0px;font-stretch:nor=
mal;font-size:11px;line-height:normal;font-family:Menlo;color:rgb(0,0,0)"><s=
pan style=3D"font-variant-ligatures:no-common-ligatures;color:rgb(56,185,199=
)">@@ -869,7 +880,9 @@</span><span style=3D"font-variant-ligatures:no-common=
-ligatures"> static BlockDriver bdrv_nfs =3D {</span></div><div style=3D"mar=
gin:0px;font-stretch:normal;font-size:11px;line-height:normal;font-family:Me=
nlo;color:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-ligatu=
res">&nbsp;&nbsp; &nbsp; .create_opts&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; =3D &amp;nfs_create_opts,</span></div><p styl=
e=3D"margin:0px;font-stretch:normal;font-size:11px;line-height:normal;font-f=
amily:Menlo;color:rgb(0,0,0);min-height:13px"><span style=3D"font-variant-li=
gatures:no-common-ligatures">&nbsp;</span><br></p><div style=3D"margin:0px;f=
ont-stretch:normal;font-size:11px;line-height:normal;font-family:Menlo;color=
:rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-ligatures">&nbs=
p;&nbsp; &nbsp; .bdrv_has_zero_init &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; =3D nfs_has_zero_init,</span></div><div style=3D"margin:0px;font-stretch:n=
ormal;font-size:11px;line-height:normal;font-family:Menlo;color:rgb(57,192,3=
8)"><span style=3D"font-variant-ligatures:no-common-ligatures">+#if !defined=
(_WIN32)</span></div><div style=3D"margin:0px;font-stretch:normal;font-size:=
11px;line-height:normal;font-family:Menlo;color:rgb(0,0,0)"><span style=3D"f=
ont-variant-ligatures:no-common-ligatures">&nbsp;&nbsp; &nbsp; .bdrv_get_all=
ocated_file_size &nbsp; =3D nfs_get_allocated_file_size,</span></div><div st=
yle=3D"margin:0px;font-stretch:normal;font-size:11px;line-height:normal;font=
-family:Menlo;color:rgb(57,192,38)"><span style=3D"font-variant-ligatures:no=
-common-ligatures">+#endif</span></div><div style=3D"margin:0px;font-stretch=
:normal;font-size:11px;line-height:normal;font-family:Menlo;color:rgb(0,0,0)=
"><span style=3D"font-variant-ligatures:no-common-ligatures">&nbsp;&nbsp; &n=
bsp; .bdrv_co_truncate &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =3D n=
fs_file_co_truncate,</span></div><p style=3D"margin:0px;font-stretch:normal;=
font-size:11px;line-height:normal;font-family:Menlo;color:rgb(0,0,0);min-hei=
ght:13px"><span style=3D"font-variant-ligatures:no-common-ligatures">&nbsp;<=
/span><br></p><div style=3D"margin:0px;font-stretch:normal;font-size:11px;li=
ne-height:normal;font-family:Menlo;color:rgb(0,0,0)"><span style=3D"font-var=
iant-ligatures:no-common-ligatures">&nbsp;&nbsp; &nbsp; .bdrv_file_open &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =3D nfs_file_open,</span=
></div><div style=3D"margin:0px;font-stretch:normal;font-size:11px;line-heig=
ht:normal;font-family:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-li=
gatures:no-common-ligatures"><br></span></div><div style=3D"margin:0px;font-=
stretch:normal;font-size:11px;line-height:normal;font-family:Menlo;color:rgb=
(0,0,0)"><span style=3D"font-variant-ligatures:no-common-ligatures"><br></sp=
an></div><div style=3D"margin:0px;font-stretch:normal;font-size:11px;line-he=
ight:normal;font-family:Menlo;color:rgb(0,0,0)"><span style=3D"font-variant-=
ligatures:no-common-ligatures">Best,</span></div><div style=3D"margin:0px;fo=
nt-stretch:normal;font-size:11px;line-height:normal;font-family:Menlo;color:=
rgb(0,0,0)"><span style=3D"font-variant-ligatures:no-common-ligatures">Peter=
</span></div></div></div></blockquote><div>Any git repo have this patch? I c=
an cherry-pick it directly&nbsp;</div></div></div></div></blockquote><div><b=
r></div><div>not yet. but feel free to use this diff for your own patch. oth=
erwise i can setup a branch with this patch on github where you can pick it.=
</div><div><br></div><div>Peter</div><br></body></html>=

--Apple-Mail-5F6402E0-D95F-4037-A161-1D11B953A1AD--


