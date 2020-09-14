Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 373B6C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 10:27:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD0BB2076C
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 10:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vL4w+kkJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD0BB2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHlhr-0006ZE-Tf
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 06:27:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35066)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kHlgr-0005fx-P9; Mon, 14 Sep 2020 06:26:30 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:32981)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kHlgo-0000le-24; Mon, 14 Sep 2020 06:26:29 -0400
Received: by mail-lf1-x142.google.com with SMTP id x77so12849080lfa.0;
 Mon, 14 Sep 2020 03:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=M7UVepTqkDAx0i1nxoBfazL2epSaoE02+iavfYAFf6E=;
 b=vL4w+kkJzj9Q9jJTsfcD/LIX8EBobTnXicSNQLhTqQXOmsAYL2hcTsGUIHnvjS+go3
 ZgRW9xhCwmY4VYXJvJOyLvVXoKNeZNhOYWAlrGSZ+ZuG1uWhLbVvvnWAZkuLgJ8GB8lB
 Tak+oyKvazYmckhE6EkZSNWP86TZ1rnQygQ5yM0qoTMWr3zzZN03BpMjTde162oclEN6
 oxeBdhTvCkZ+oJ85F4bpvY5IucnFsTtAMfwSYiO3TbPVQSVb8i/rNjYh+DXl7V4ww+Ph
 eVyGqNW5H3raSE/RRRweszcC6VJSFNza998dPJm4VfureR373jGI0eqidCnVOadlZamp
 Tc8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=M7UVepTqkDAx0i1nxoBfazL2epSaoE02+iavfYAFf6E=;
 b=pntb4Nfat14WfAmSNDPpGVpILsruLQ3dHdl5Bz3k/6lZzTRp3DJvik0fi1HWQGEVJN
 HnpwkC1tS2Ao+eTXNVvqLuWmQQbNuBdomDt98EZBTstVliNxvnqKi2cDSLuLZvg/m88i
 fWre3NfhqJzi81iDFjd2CoPdDkAmz4S4AarBMWIfNn70t7LXPeNjtquLAOHUbtc8FUj6
 3sL9SXY1TzMTZQBnjig9U31grheO9SYe+ISEgR+VLTzZ+cUs27Oc9rMnCe6eJjPmPdC3
 oniHUExsBWGlTrXgXXFL6KvfhT2SIHiUS1mDRooHUkCpM2moc0h1XV+B91JAaSMLRQMp
 Xogw==
X-Gm-Message-State: AOAM5308WxOvYslUwmBeLj4j+Q3egpKsD39ddPz+2HdTaOGKv+Jm8sPy
 TObslRhsu7qbXx3xSSm0eZcxe7B1v77YDMjuTy0=
X-Google-Smtp-Source: ABdhPJym8beTwhVnNJMtbbbbapKVwAIlfyc+CUSDZZq9KBYBcnA3IYAdLNZv+2MQ9omgf8zz11Loq78q9Fr5KpNCxp8=
X-Received: by 2002:a19:189:: with SMTP id 131mr3833968lfb.331.1600079182087; 
 Mon, 14 Sep 2020 03:26:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200912224431.1428-1-luoyonggang@gmail.com>
 <20200912224431.1428-3-luoyonggang@gmail.com>
 <5a805c5b-53d5-322e-1031-ddd68154b9e0@redhat.com>
 <CAE2XoE_HtV_YDEdjh2824G+Csz+yR-2WZg7JYb_DNkX=xPUA6A@mail.gmail.com>
 <b2218d06-f52f-6c52-a57c-8fa5c5b20deb@redhat.com>
In-Reply-To: <b2218d06-f52f-6c52-a57c-8fa5c5b20deb@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Mon, 14 Sep 2020 18:26:12 +0800
Message-ID: <CAE2XoE85cKdnch6FQKMqo9X5frOjJrBLbHWBvh1XN1QswvMqwA@mail.gmail.com>
Subject: Re: [PATCH v8 02/27] block: Fixes nfs compiling error on msys2/mingw
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000042cd4b05af4377dd"
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

--00000000000042cd4b05af4377dd
Content-Type: text/plain; charset="UTF-8"

How about using the following patch with
+#if !defined (_WIN32)
     .bdrv_get_allocated_file_size   = nfs_get_allocated_file_size,
+#endif
Also,
  +static blkcnt_t nfs_get_st_blocks(const struct nfs_stat *st)
+{
+#if defined(_WIN32)
+    return (st->st_size + 511) / 512;
+#else
+    return st->st_blocks;
+#endif
+}
Change to be
    +static blkcnt_t nfs_get_st_blocks(const struct nfs_stat *st)
+{
+#if defined(_WIN32)
+    return-1; /* TODO: unimplemented on win32 yet */
+#else
+    return st->st_blocks;
+#endif
+}

 block/nfs.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/block/nfs.c b/block/nfs.c
index cc2413d5ab..beebd566d1 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -24,7 +24,9 @@

 #include "qemu/osdep.h"

+#if !defined(_WIN32)
 #include <poll.h>
+#endif
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
@@ -51,6 +53,13 @@
 #define QEMU_NFS_MAX_PAGECACHE_SIZE (8388608 / NFS_BLKSIZE)
 #define QEMU_NFS_MAX_DEBUG_LEVEL 2

+#if defined (_WIN32)
+#define nfs_stat __stat64
+typedef long long blkcnt_t;
+#else
+#define nfs_stat stat
+#endif
+
 typedef struct NFSClient {
     struct nfs_context *context;
     struct nfsfh *fh;
@@ -70,7 +79,7 @@ typedef struct NFSRPC {
     int ret;
     int complete;
     QEMUIOVector *iov;
-    struct stat *st;
+    struct nfs_stat *st;
     Coroutine *co;
     NFSClient *client;
 } NFSRPC;
@@ -418,11 +427,20 @@ static void nfs_file_close(BlockDriverState *bs)
     nfs_client_close(client);
 }

+static blkcnt_t nfs_get_st_blocks(const struct nfs_stat *st)
+{
+#if defined(_WIN32)
+    return (st->st_size + 511) / 512;
+#else
+    return st->st_blocks;
+#endif
+}
+
 static int64_t nfs_client_open(NFSClient *client, BlockdevOptionsNfs *opts,
                                int flags, int open_flags, Error **errp)
 {
     int64_t ret = -EINVAL;
-    struct stat st;
+    struct nfs_stat st;
     char *file = NULL, *strp = NULL;

     qemu_mutex_init(&client->mutex);
@@ -548,7 +566,7 @@ static int64_t nfs_client_open(NFSClient *client,
BlockdevOptionsNfs *opts,
     }

     ret = DIV_ROUND_UP(st.st_size, BDRV_SECTOR_SIZE);
-    client->st_blocks = st.st_blocks;
+    client->st_blocks = nfs_get_st_blocks(&st);
     client->has_zero_init = S_ISREG(st.st_mode);
     *strp = '/';
     goto out;
@@ -733,7 +751,7 @@ static int64_t
nfs_get_allocated_file_size(BlockDriverState *bs)
 {
     NFSClient *client = bs->opaque;
     NFSRPC task = {0};
-    struct stat st;
+    struct nfs_stat st;

     if (bdrv_is_read_only(bs) &&
         !(bs->open_flags & BDRV_O_NOCACHE)) {
@@ -750,7 +768,7 @@ static int64_t
nfs_get_allocated_file_size(BlockDriverState *bs)
     nfs_set_events(client);
     BDRV_POLL_WHILE(bs, !task.complete);

-    return (task.ret < 0 ? task.ret : st.st_blocks * 512);
+    return (task.ret < 0 ? task.ret : nfs_get_st_blocks(&st) * 512);
 }

 static int coroutine_fn
@@ -781,7 +799,7 @@ static int nfs_reopen_prepare(BDRVReopenState *state,
                               BlockReopenQueue *queue, Error **errp)
 {
     NFSClient *client = state->bs->opaque;
-    struct stat st;
+    struct nfs_stat st;
     int ret = 0;

     if (state->flags & BDRV_O_RDWR && bdrv_is_read_only(state->bs)) {
@@ -803,7 +821,7 @@ static int nfs_reopen_prepare(BDRVReopenState *state,
                        nfs_get_error(client->context));
             return ret;
         }
-        client->st_blocks = st.st_blocks;
+        client->st_blocks = nfs_get_st_blocks(&st);
     }

     return 0;

--00000000000042cd4b05af4377dd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>How about using the following patch with=C2=A0</div><=
div>+#if !defined (_WIN32)<br>=C2=A0 =C2=A0 =C2=A0.bdrv_get_allocated_file_=
size=C2=A0 =C2=A0=3D nfs_get_allocated_file_size,<br>+#endif=C2=A0=C2=A0<br=
></div><div>Also,</div><div>=C2=A0 +static blkcnt_t nfs_get_st_blocks(const=
 struct nfs_stat *st)<br>+{<br>+#if defined(_WIN32)<br>+ =C2=A0 =C2=A0retur=
n (st-&gt;st_size + 511) / 512;<br>+#else<br>+ =C2=A0 =C2=A0return st-&gt;s=
t_blocks;<br>+#endif<br>+}=C2=A0</div><div>Change to be=C2=A0<br></div><div=
>=C2=A0 =C2=A0 +static blkcnt_t nfs_get_st_blocks(const struct nfs_stat *st=
)<br>+{<br>+#if defined(_WIN32)<br>+ =C2=A0 =C2=A0return-1; /* TODO: unimpl=
emented on win32 yet */<br>+#else<br>+ =C2=A0 =C2=A0return st-&gt;st_blocks=
;<br>+#endif<br>+}=C2=A0 =C2=A0<br></div><div><br></div><div>=C2=A0block/nf=
s.c | 32 +++++++++++++++++++++++++-------<br>=C2=A01 file changed, 25 inser=
tions(+), 7 deletions(-)<br><br>diff --git a/block/nfs.c b/block/nfs.c<br>i=
ndex cc2413d5ab..beebd566d1 100644<br>--- a/block/nfs.c<br>+++ b/block/nfs.=
c<br>@@ -24,7 +24,9 @@<br>=C2=A0<br>=C2=A0#include &quot;qemu/osdep.h&quot;=
<br>=C2=A0<br>+#if !defined(_WIN32)<br>=C2=A0#include &lt;poll.h&gt;<br>+#e=
ndif<br>=C2=A0#include &quot;qemu/config-file.h&quot;<br>=C2=A0#include &qu=
ot;qemu/error-report.h&quot;<br>=C2=A0#include &quot;qapi/error.h&quot;<br>=
@@ -51,6 +53,13 @@<br>=C2=A0#define QEMU_NFS_MAX_PAGECACHE_SIZE (8388608 / =
NFS_BLKSIZE)<br>=C2=A0#define QEMU_NFS_MAX_DEBUG_LEVEL 2<br>=C2=A0<br>+#if =
defined (_WIN32)<br>+#define nfs_stat __stat64<br>+typedef long long blkcnt=
_t;<br>+#else<br>+#define nfs_stat stat<br>+#endif<br>+<br>=C2=A0typedef st=
ruct NFSClient {<br>=C2=A0 =C2=A0 =C2=A0struct nfs_context *context;<br>=C2=
=A0 =C2=A0 =C2=A0struct nfsfh *fh;<br>@@ -70,7 +79,7 @@ typedef struct NFSR=
PC {<br>=C2=A0 =C2=A0 =C2=A0int ret;<br>=C2=A0 =C2=A0 =C2=A0int complete;<b=
r>=C2=A0 =C2=A0 =C2=A0QEMUIOVector *iov;<br>- =C2=A0 =C2=A0struct stat *st;=
<br>+ =C2=A0 =C2=A0struct nfs_stat *st;<br>=C2=A0 =C2=A0 =C2=A0Coroutine *c=
o;<br>=C2=A0 =C2=A0 =C2=A0NFSClient *client;<br>=C2=A0} NFSRPC;<br>@@ -418,=
11 +427,20 @@ static void nfs_file_close(BlockDriverState *bs)<br>=C2=A0 =
=C2=A0 =C2=A0nfs_client_close(client);<br>=C2=A0}<br>=C2=A0<br>+static blkc=
nt_t nfs_get_st_blocks(const struct nfs_stat *st)<br>+{<br>+#if defined(_WI=
N32)<br>+ =C2=A0 =C2=A0return (st-&gt;st_size + 511) / 512;<br>+#else<br>+ =
=C2=A0 =C2=A0return st-&gt;st_blocks;<br>+#endif<br>+}<br>+<br>=C2=A0static=
 int64_t nfs_client_open(NFSClient *client, BlockdevOptionsNfs *opts,<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int flags, int open_flags, Error **e=
rrp)<br>=C2=A0{<br>=C2=A0 =C2=A0 =C2=A0int64_t ret =3D -EINVAL;<br>- =C2=A0=
 =C2=A0struct stat st;<br>+ =C2=A0 =C2=A0struct nfs_stat st;<br>=C2=A0 =C2=
=A0 =C2=A0char *file =3D NULL, *strp =3D NULL;<br>=C2=A0<br>=C2=A0 =C2=A0 =
=C2=A0qemu_mutex_init(&amp;client-&gt;mutex);<br>@@ -548,7 +566,7 @@ static=
 int64_t nfs_client_open(NFSClient *client, BlockdevOptionsNfs *opts,<br>=
=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0ret =3D DIV_ROUND_UP=
(st.st_size, BDRV_SECTOR_SIZE);<br>- =C2=A0 =C2=A0client-&gt;st_blocks =3D =
st.st_blocks;<br>+ =C2=A0 =C2=A0client-&gt;st_blocks =3D nfs_get_st_blocks(=
&amp;st);<br>=C2=A0 =C2=A0 =C2=A0client-&gt;has_zero_init =3D S_ISREG(st.st=
_mode);<br>=C2=A0 =C2=A0 =C2=A0*strp =3D &#39;/&#39;;<br>=C2=A0 =C2=A0 =C2=
=A0goto out;<br>@@ -733,7 +751,7 @@ static int64_t nfs_get_allocated_file_s=
ize(BlockDriverState *bs)<br>=C2=A0{<br>=C2=A0 =C2=A0 =C2=A0NFSClient *clie=
nt =3D bs-&gt;opaque;<br>=C2=A0 =C2=A0 =C2=A0NFSRPC task =3D {0};<br>- =C2=
=A0 =C2=A0struct stat st;<br>+ =C2=A0 =C2=A0struct nfs_stat st;<br>=C2=A0<b=
r>=C2=A0 =C2=A0 =C2=A0if (bdrv_is_read_only(bs) &amp;&amp;<br>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0!(bs-&gt;open_flags &amp; BDRV_O_NOCACHE)) {<br>@@ -75=
0,7 +768,7 @@ static int64_t nfs_get_allocated_file_size(BlockDriverState *=
bs)<br>=C2=A0 =C2=A0 =C2=A0nfs_set_events(client);<br>=C2=A0 =C2=A0 =C2=A0B=
DRV_POLL_WHILE(bs, !task.complete);<br>=C2=A0<br>- =C2=A0 =C2=A0return (tas=
k.ret &lt; 0 ? task.ret : st.st_blocks * 512);<br>+ =C2=A0 =C2=A0return (ta=
sk.ret &lt; 0 ? task.ret : nfs_get_st_blocks(&amp;st) * 512);<br>=C2=A0}<br=
>=C2=A0<br>=C2=A0static int coroutine_fn<br>@@ -781,7 +799,7 @@ static int =
nfs_reopen_prepare(BDRVReopenState *state,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0BlockReopenQueue *queue, Error **errp)<br>=C2=A0{<br>=C2=A0 =C2=
=A0 =C2=A0NFSClient *client =3D state-&gt;bs-&gt;opaque;<br>- =C2=A0 =C2=A0=
struct stat st;<br>+ =C2=A0 =C2=A0struct nfs_stat st;<br>=C2=A0 =C2=A0 =C2=
=A0int ret =3D 0;<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0if (state-&gt;flags &amp=
; BDRV_O_RDWR &amp;&amp; bdrv_is_read_only(state-&gt;bs)) {<br>@@ -803,7 +8=
21,7 @@ static int nfs_reopen_prepare(BDRVReopenState *state,<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 n=
fs_get_error(client-&gt;context));<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return ret;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>- =C2=A0=
 =C2=A0 =C2=A0 =C2=A0client-&gt;st_blocks =3D st.st_blocks;<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0client-&gt;st_blocks =3D nfs_get_st_blocks(&amp;st);<br>=
=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0return 0;<br></div>
</div>

--00000000000042cd4b05af4377dd--

