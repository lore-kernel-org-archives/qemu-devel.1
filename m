Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 027A6C433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 07:46:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7775F206C0
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 07:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgGhlS/p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7775F206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDjwY-0004M9-IZ
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 03:46:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43388)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDjuS-00006I-Kp
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 03:43:52 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532]:32781)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDjuO-0003sL-CU
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 03:43:52 -0400
Received: by mail-pg1-x532.google.com with SMTP id e33so1464308pgm.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 00:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=H8XrF8Pb9GWB51Qq/Erw8qteOrJrg0KP5nGwFRkDrXA=;
 b=MgGhlS/pEz0BkLa5HNQZumnxoFHs2L91ynvwZ/aWelU62FuTrzy9DpAGI+FuttUe2B
 8G0PFkzsqF/tUNefYKi5zHm0S5nQopxwtEoLoQLXfFZSGa0dgHCnOKxXtcgWf1dAOH7e
 SPc9kEml2JZMy84d/g3IRiEiLtBqrKgV9vZibihswQleFOEnP50c3KsGtDpAYgpDvQVa
 e0e50yPxCEAysbb3L8lliIhXEIBsi5RqnKAFPDjGKIy8oZUgcK5rt8+7FEXZWl6oJbbh
 3d10rlO5UCOcdAxDvvwIZr6RqRCLrx6iTt5yPfy0nE01Sr6NLNP1T3vuLZFgb2A9VKKW
 bRTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=H8XrF8Pb9GWB51Qq/Erw8qteOrJrg0KP5nGwFRkDrXA=;
 b=VsiFdsVh+0SRX4Jaa7nvdQyD2Ei2Hs3haesOcR9NIYRl3s+dlNe4o83rCMtlEx4gLi
 h6OR2jmYge6LUkGD1XcUAWGrvemWE4hL4ao0ZUphHNp+CAW0IDB7h1qqDAccGivW2m5s
 iMlIKB/ctcM/YJLG80mcpWCzKlJkU6+wkJPAju7QXv56sASyWD5L4hDW8ihNOMViw4Mf
 kgzIjSjeY3yWnTdSyR2xgMxTUgIwCH0JZcU7430N5aSMNBsEiL1qMAiEySs/1txxWafM
 HggTPJrd9B1JBLnbxZVE0MY5p7VfESUCYz35HZr/HrBkFNPde6OrTEF3+JGeUFOczaQH
 BU0g==
X-Gm-Message-State: AOAM533csRUHbkfFomjBTGjs8CBNtTunfGhjO8N1yzbm5z1LVHAlXuAg
 nLhQpNviNJfxIQW/qCengz7SszOxEJnOmQEo
X-Google-Smtp-Source: ABdhPJxsbsX/06Oq+q7KLJH29b+x81/h7UNM6zh0A5N/X4tpFbMm18fLDZojvmJBw8J56nxl1TL1cg==
X-Received: by 2002:a62:d44e:0:b029:13c:1611:652f with SMTP id
 u14-20020a62d44e0000b029013c1611652fmr911552pfl.15.1599119025539; 
 Thu, 03 Sep 2020 00:43:45 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id o6sm1512472pju.25.2020.09.03.00.43.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 00:43:44 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 06/12] block: Fixes nfs on msys2/mingw
Date: Thu,  3 Sep 2020 15:43:07 +0800
Message-Id: <20200903074313.1498-7-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200903074313.1498-1-luoyonggang@gmail.com>
References: <20200903074313.1498-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x532.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 block/nfs.c | 1812 ++++++++++++++++++++++++++-------------------------
 1 file changed, 910 insertions(+), 902 deletions(-)

diff --git a/block/nfs.c b/block/nfs.c
index 61a249a9fc..34b2cd5708 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -1,902 +1,910 @@
-/*
- * QEMU Block driver for native access to files on NFS shares
- *
- * Copyright (c) 2014-2017 Peter Lieven <pl@kamp.de>
- *
- * Permission is hereby granted, free of charge, to any person obtaining a=
 copy
- * of this software and associated documentation files (the "Software"), t=
o deal
- * in the Software without restriction, including without limitation the r=
ights
- * to use, copy, modify, merge, publish, distribute, sublicense, and/or se=
ll
- * copies of the Software, and to permit persons to whom the Software is
- * furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included=
 in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS=
 OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OT=
HER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING=
 FROM,
- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS =
IN
- * THE SOFTWARE.
- */
-
-#include "qemu/osdep.h"
-
-#include <poll.h>
-#include "qemu/config-file.h"
-#include "qemu/error-report.h"
-#include "qapi/error.h"
-#include "block/block_int.h"
-#include "block/qdict.h"
-#include "trace.h"
-#include "qemu/iov.h"
-#include "qemu/main-loop.h"
-#include "qemu/module.h"
-#include "qemu/option.h"
-#include "qemu/uri.h"
-#include "qemu/cutils.h"
-#include "sysemu/sysemu.h"
-#include "sysemu/replay.h"
-#include "qapi/qapi-visit-block-core.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qstring.h"
-#include "qapi/qobject-input-visitor.h"
-#include "qapi/qobject-output-visitor.h"
-#include <nfsc/libnfs.h>
-
-
-#define QEMU_NFS_MAX_READAHEAD_SIZE 1048576
-#define QEMU_NFS_MAX_PAGECACHE_SIZE (8388608 / NFS_BLKSIZE)
-#define QEMU_NFS_MAX_DEBUG_LEVEL 2
-
-typedef struct NFSClient {
-    struct nfs_context *context;
-    struct nfsfh *fh;
-    int events;
-    bool has_zero_init;
-    AioContext *aio_context;
-    QemuMutex mutex;
-    blkcnt_t st_blocks;
-    bool cache_used;
-    NFSServer *server;
-    char *path;
-    int64_t uid, gid, tcp_syncnt, readahead, pagecache, debug;
-} NFSClient;
-
-typedef struct NFSRPC {
-    BlockDriverState *bs;
-    int ret;
-    int complete;
-    QEMUIOVector *iov;
-    struct stat *st;
-    Coroutine *co;
-    NFSClient *client;
-} NFSRPC;
-
-static int nfs_parse_uri(const char *filename, QDict *options, Error **err=
p)
-{
-    URI *uri =3D NULL;
-    QueryParams *qp =3D NULL;
-    int ret =3D -EINVAL, i;
-
-    uri =3D uri_parse(filename);
-    if (!uri) {
-        error_setg(errp, "Invalid URI specified");
-        goto out;
-    }
-    if (g_strcmp0(uri->scheme, "nfs") !=3D 0) {
-        error_setg(errp, "URI scheme must be 'nfs'");
-        goto out;
-    }
-
-    if (!uri->server) {
-        error_setg(errp, "missing hostname in URI");
-        goto out;
-    }
-
-    if (!uri->path) {
-        error_setg(errp, "missing file path in URI");
-        goto out;
-    }
-
-    qp =3D query_params_parse(uri->query);
-    if (!qp) {
-        error_setg(errp, "could not parse query parameters");
-        goto out;
-    }
-
-    qdict_put_str(options, "server.host", uri->server);
-    qdict_put_str(options, "server.type", "inet");
-    qdict_put_str(options, "path", uri->path);
-
-    for (i =3D 0; i < qp->n; i++) {
-        unsigned long long val;
-        if (!qp->p[i].value) {
-            error_setg(errp, "Value for NFS parameter expected: %s",
-                       qp->p[i].name);
-            goto out;
-        }
-        if (parse_uint_full(qp->p[i].value, &val, 0)) {
-            error_setg(errp, "Illegal value for NFS parameter: %s",
-                       qp->p[i].name);
-            goto out;
-        }
-        if (!strcmp(qp->p[i].name, "uid")) {
-            qdict_put_str(options, "user", qp->p[i].value);
-        } else if (!strcmp(qp->p[i].name, "gid")) {
-            qdict_put_str(options, "group", qp->p[i].value);
-        } else if (!strcmp(qp->p[i].name, "tcp-syncnt")) {
-            qdict_put_str(options, "tcp-syn-count", qp->p[i].value);
-        } else if (!strcmp(qp->p[i].name, "readahead")) {
-            qdict_put_str(options, "readahead-size", qp->p[i].value);
-        } else if (!strcmp(qp->p[i].name, "pagecache")) {
-            qdict_put_str(options, "page-cache-size", qp->p[i].value);
-        } else if (!strcmp(qp->p[i].name, "debug")) {
-            qdict_put_str(options, "debug", qp->p[i].value);
-        } else {
-            error_setg(errp, "Unknown NFS parameter name: %s",
-                       qp->p[i].name);
-            goto out;
-        }
-    }
-    ret =3D 0;
-out:
-    if (qp) {
-        query_params_free(qp);
-    }
-    if (uri) {
-        uri_free(uri);
-    }
-    return ret;
-}
-
-static bool nfs_has_filename_options_conflict(QDict *options, Error **errp)
-{
-    const QDictEntry *qe;
-
-    for (qe =3D qdict_first(options); qe; qe =3D qdict_next(options, qe)) {
-        if (!strcmp(qe->key, "host") ||
-            !strcmp(qe->key, "path") ||
-            !strcmp(qe->key, "user") ||
-            !strcmp(qe->key, "group") ||
-            !strcmp(qe->key, "tcp-syn-count") ||
-            !strcmp(qe->key, "readahead-size") ||
-            !strcmp(qe->key, "page-cache-size") ||
-            !strcmp(qe->key, "debug") ||
-            strstart(qe->key, "server.", NULL))
-        {
-            error_setg(errp, "Option %s cannot be used with a filename",
-                       qe->key);
-            return true;
-        }
-    }
-
-    return false;
-}
-
-static void nfs_parse_filename(const char *filename, QDict *options,
-                               Error **errp)
-{
-    if (nfs_has_filename_options_conflict(options, errp)) {
-        return;
-    }
-
-    nfs_parse_uri(filename, options, errp);
-}
-
-static void nfs_process_read(void *arg);
-static void nfs_process_write(void *arg);
-
-/* Called with QemuMutex held.  */
-static void nfs_set_events(NFSClient *client)
-{
-    int ev =3D nfs_which_events(client->context);
-    if (ev !=3D client->events) {
-        aio_set_fd_handler(client->aio_context, nfs_get_fd(client->context=
),
-                           false,
-                           (ev & POLLIN) ? nfs_process_read : NULL,
-                           (ev & POLLOUT) ? nfs_process_write : NULL,
-                           NULL, client);
-
-    }
-    client->events =3D ev;
-}
-
-static void nfs_process_read(void *arg)
-{
-    NFSClient *client =3D arg;
-
-    qemu_mutex_lock(&client->mutex);
-    nfs_service(client->context, POLLIN);
-    nfs_set_events(client);
-    qemu_mutex_unlock(&client->mutex);
-}
-
-static void nfs_process_write(void *arg)
-{
-    NFSClient *client =3D arg;
-
-    qemu_mutex_lock(&client->mutex);
-    nfs_service(client->context, POLLOUT);
-    nfs_set_events(client);
-    qemu_mutex_unlock(&client->mutex);
-}
-
-static void nfs_co_init_task(BlockDriverState *bs, NFSRPC *task)
-{
-    *task =3D (NFSRPC) {
-        .co             =3D qemu_coroutine_self(),
-        .bs             =3D bs,
-        .client         =3D bs->opaque,
-    };
-}
-
-static void nfs_co_generic_bh_cb(void *opaque)
-{
-    NFSRPC *task =3D opaque;
-
-    task->complete =3D 1;
-    aio_co_wake(task->co);
-}
-
-/* Called (via nfs_service) with QemuMutex held.  */
-static void
-nfs_co_generic_cb(int ret, struct nfs_context *nfs, void *data,
-                  void *private_data)
-{
-    NFSRPC *task =3D private_data;
-    task->ret =3D ret;
-    assert(!task->st);
-    if (task->ret > 0 && task->iov) {
-        if (task->ret <=3D task->iov->size) {
-            qemu_iovec_from_buf(task->iov, 0, data, task->ret);
-        } else {
-            task->ret =3D -EIO;
-        }
-    }
-    if (task->ret < 0) {
-        error_report("NFS Error: %s", nfs_get_error(nfs));
-    }
-    replay_bh_schedule_oneshot_event(task->client->aio_context,
-                                     nfs_co_generic_bh_cb, task);
-}
-
-static int coroutine_fn nfs_co_preadv(BlockDriverState *bs, uint64_t offse=
t,
-                                      uint64_t bytes, QEMUIOVector *iov,
-                                      int flags)
-{
-    NFSClient *client =3D bs->opaque;
-    NFSRPC task;
-
-    nfs_co_init_task(bs, &task);
-    task.iov =3D iov;
-
-    WITH_QEMU_LOCK_GUARD(&client->mutex) {
-        if (nfs_pread_async(client->context, client->fh,
-                            offset, bytes, nfs_co_generic_cb, &task) !=3D =
0) {
-            return -ENOMEM;
-        }
-
-        nfs_set_events(client);
-    }
-    while (!task.complete) {
-        qemu_coroutine_yield();
-    }
-
-    if (task.ret < 0) {
-        return task.ret;
-    }
-
-    /* zero pad short reads */
-    if (task.ret < iov->size) {
-        qemu_iovec_memset(iov, task.ret, 0, iov->size - task.ret);
-    }
-
-    return 0;
-}
-
-static int coroutine_fn nfs_co_pwritev(BlockDriverState *bs, uint64_t offs=
et,
-                                       uint64_t bytes, QEMUIOVector *iov,
-                                       int flags)
-{
-    NFSClient *client =3D bs->opaque;
-    NFSRPC task;
-    char *buf =3D NULL;
-    bool my_buffer =3D false;
-
-    nfs_co_init_task(bs, &task);
-
-    if (iov->niov !=3D 1) {
-        buf =3D g_try_malloc(bytes);
-        if (bytes && buf =3D=3D NULL) {
-            return -ENOMEM;
-        }
-        qemu_iovec_to_buf(iov, 0, buf, bytes);
-        my_buffer =3D true;
-    } else {
-        buf =3D iov->iov[0].iov_base;
-    }
-
-    WITH_QEMU_LOCK_GUARD(&client->mutex) {
-        if (nfs_pwrite_async(client->context, client->fh,
-                             offset, bytes, buf,
-                             nfs_co_generic_cb, &task) !=3D 0) {
-            if (my_buffer) {
-                g_free(buf);
-            }
-            return -ENOMEM;
-        }
-
-        nfs_set_events(client);
-    }
-    while (!task.complete) {
-        qemu_coroutine_yield();
-    }
-
-    if (my_buffer) {
-        g_free(buf);
-    }
-
-    if (task.ret !=3D bytes) {
-        return task.ret < 0 ? task.ret : -EIO;
-    }
-
-    return 0;
-}
-
-static int coroutine_fn nfs_co_flush(BlockDriverState *bs)
-{
-    NFSClient *client =3D bs->opaque;
-    NFSRPC task;
-
-    nfs_co_init_task(bs, &task);
-
-    WITH_QEMU_LOCK_GUARD(&client->mutex) {
-        if (nfs_fsync_async(client->context, client->fh, nfs_co_generic_cb,
-                            &task) !=3D 0) {
-            return -ENOMEM;
-        }
-
-        nfs_set_events(client);
-    }
-    while (!task.complete) {
-        qemu_coroutine_yield();
-    }
-
-    return task.ret;
-}
-
-static void nfs_detach_aio_context(BlockDriverState *bs)
-{
-    NFSClient *client =3D bs->opaque;
-
-    aio_set_fd_handler(client->aio_context, nfs_get_fd(client->context),
-                       false, NULL, NULL, NULL, NULL);
-    client->events =3D 0;
-}
-
-static void nfs_attach_aio_context(BlockDriverState *bs,
-                                   AioContext *new_context)
-{
-    NFSClient *client =3D bs->opaque;
-
-    client->aio_context =3D new_context;
-    nfs_set_events(client);
-}
-
-static void nfs_client_close(NFSClient *client)
-{
-    if (client->context) {
-        qemu_mutex_lock(&client->mutex);
-        aio_set_fd_handler(client->aio_context, nfs_get_fd(client->context=
),
-                           false, NULL, NULL, NULL, NULL);
-        qemu_mutex_unlock(&client->mutex);
-        if (client->fh) {
-            nfs_close(client->context, client->fh);
-            client->fh =3D NULL;
-        }
-#ifdef LIBNFS_FEATURE_UMOUNT
-        nfs_umount(client->context);
-#endif
-        nfs_destroy_context(client->context);
-        client->context =3D NULL;
-    }
-    g_free(client->path);
-    qemu_mutex_destroy(&client->mutex);
-    qapi_free_NFSServer(client->server);
-    client->server =3D NULL;
-}
-
-static void nfs_file_close(BlockDriverState *bs)
-{
-    NFSClient *client =3D bs->opaque;
-    nfs_client_close(client);
-}
-
-static int64_t nfs_client_open(NFSClient *client, BlockdevOptionsNfs *opts,
-                               int flags, int open_flags, Error **errp)
-{
-    int64_t ret =3D -EINVAL;
-    struct stat st;
-    char *file =3D NULL, *strp =3D NULL;
-
-    qemu_mutex_init(&client->mutex);
-
-    client->path =3D g_strdup(opts->path);
-
-    strp =3D strrchr(client->path, '/');
-    if (strp =3D=3D NULL) {
-        error_setg(errp, "Invalid URL specified");
-        goto fail;
-    }
-    file =3D g_strdup(strp);
-    *strp =3D 0;
-
-    /* Steal the NFSServer object from opts; set the original pointer to N=
ULL
-     * to avoid use after free and double free. */
-    client->server =3D opts->server;
-    opts->server =3D NULL;
-
-    client->context =3D nfs_init_context();
-    if (client->context =3D=3D NULL) {
-        error_setg(errp, "Failed to init NFS context");
-        goto fail;
-    }
-
-    if (opts->has_user) {
-        client->uid =3D opts->user;
-        nfs_set_uid(client->context, client->uid);
-    }
-
-    if (opts->has_group) {
-        client->gid =3D opts->group;
-        nfs_set_gid(client->context, client->gid);
-    }
-
-    if (opts->has_tcp_syn_count) {
-        client->tcp_syncnt =3D opts->tcp_syn_count;
-        nfs_set_tcp_syncnt(client->context, client->tcp_syncnt);
-    }
-
-#ifdef LIBNFS_FEATURE_READAHEAD
-    if (opts->has_readahead_size) {
-        if (open_flags & BDRV_O_NOCACHE) {
-            error_setg(errp, "Cannot enable NFS readahead "
-                             "if cache.direct =3D on");
-            goto fail;
-        }
-        client->readahead =3D opts->readahead_size;
-        if (client->readahead > QEMU_NFS_MAX_READAHEAD_SIZE) {
-            warn_report("Truncating NFS readahead size to %d",
-                        QEMU_NFS_MAX_READAHEAD_SIZE);
-            client->readahead =3D QEMU_NFS_MAX_READAHEAD_SIZE;
-        }
-        nfs_set_readahead(client->context, client->readahead);
-#ifdef LIBNFS_FEATURE_PAGECACHE
-        nfs_set_pagecache_ttl(client->context, 0);
-#endif
-        client->cache_used =3D true;
-    }
-#endif
-
-#ifdef LIBNFS_FEATURE_PAGECACHE
-    if (opts->has_page_cache_size) {
-        if (open_flags & BDRV_O_NOCACHE) {
-            error_setg(errp, "Cannot enable NFS pagecache "
-                             "if cache.direct =3D on");
-            goto fail;
-        }
-        client->pagecache =3D opts->page_cache_size;
-        if (client->pagecache > QEMU_NFS_MAX_PAGECACHE_SIZE) {
-            warn_report("Truncating NFS pagecache size to %d pages",
-                        QEMU_NFS_MAX_PAGECACHE_SIZE);
-            client->pagecache =3D QEMU_NFS_MAX_PAGECACHE_SIZE;
-        }
-        nfs_set_pagecache(client->context, client->pagecache);
-        nfs_set_pagecache_ttl(client->context, 0);
-        client->cache_used =3D true;
-    }
-#endif
-
-#ifdef LIBNFS_FEATURE_DEBUG
-    if (opts->has_debug) {
-        client->debug =3D opts->debug;
-        /* limit the maximum debug level to avoid potential flooding
-         * of our log files. */
-        if (client->debug > QEMU_NFS_MAX_DEBUG_LEVEL) {
-            warn_report("Limiting NFS debug level to %d",
-                        QEMU_NFS_MAX_DEBUG_LEVEL);
-            client->debug =3D QEMU_NFS_MAX_DEBUG_LEVEL;
-        }
-        nfs_set_debug(client->context, client->debug);
-    }
-#endif
-
-    ret =3D nfs_mount(client->context, client->server->host, client->path);
-    if (ret < 0) {
-        error_setg(errp, "Failed to mount nfs share: %s",
-                   nfs_get_error(client->context));
-        goto fail;
-    }
-
-    if (flags & O_CREAT) {
-        ret =3D nfs_creat(client->context, file, 0600, &client->fh);
-        if (ret < 0) {
-            error_setg(errp, "Failed to create file: %s",
-                       nfs_get_error(client->context));
-            goto fail;
-        }
-    } else {
-        ret =3D nfs_open(client->context, file, flags, &client->fh);
-        if (ret < 0) {
-            error_setg(errp, "Failed to open file : %s",
-                       nfs_get_error(client->context));
-            goto fail;
-        }
-    }
-
-    ret =3D nfs_fstat(client->context, client->fh, &st);
-    if (ret < 0) {
-        error_setg(errp, "Failed to fstat file: %s",
-                   nfs_get_error(client->context));
-        goto fail;
-    }
-
-    ret =3D DIV_ROUND_UP(st.st_size, BDRV_SECTOR_SIZE);
-    client->st_blocks =3D st.st_blocks;
-    client->has_zero_init =3D S_ISREG(st.st_mode);
-    *strp =3D '/';
-    goto out;
-
-fail:
-    nfs_client_close(client);
-out:
-    g_free(file);
-    return ret;
-}
-
-static BlockdevOptionsNfs *nfs_options_qdict_to_qapi(QDict *options,
-                                                     Error **errp)
-{
-    BlockdevOptionsNfs *opts =3D NULL;
-    Visitor *v;
-    const QDictEntry *e;
-
-    v =3D qobject_input_visitor_new_flat_confused(options, errp);
-    if (!v) {
-        return NULL;
-    }
-
-    visit_type_BlockdevOptionsNfs(v, NULL, &opts, errp);
-    visit_free(v);
-    if (!opts) {
-        return NULL;
-    }
-
-    /* Remove the processed options from the QDict (the visitor processes
-     * _all_ options in the QDict) */
-    while ((e =3D qdict_first(options))) {
-        qdict_del(options, e->key);
-    }
-
-    return opts;
-}
-
-static int64_t nfs_client_open_qdict(NFSClient *client, QDict *options,
-                                     int flags, int open_flags, Error **er=
rp)
-{
-    BlockdevOptionsNfs *opts;
-    int ret;
-
-    opts =3D nfs_options_qdict_to_qapi(options, errp);
-    if (opts =3D=3D NULL) {
-        ret =3D -EINVAL;
-        goto fail;
-    }
-
-    ret =3D nfs_client_open(client, opts, flags, open_flags, errp);
-fail:
-    qapi_free_BlockdevOptionsNfs(opts);
-    return ret;
-}
-
-static int nfs_file_open(BlockDriverState *bs, QDict *options, int flags,
-                         Error **errp) {
-    NFSClient *client =3D bs->opaque;
-    int64_t ret;
-
-    client->aio_context =3D bdrv_get_aio_context(bs);
-
-    ret =3D nfs_client_open_qdict(client, options,
-                                (flags & BDRV_O_RDWR) ? O_RDWR : O_RDONLY,
-                                bs->open_flags, errp);
-    if (ret < 0) {
-        return ret;
-    }
-
-    bs->total_sectors =3D ret;
-    if (client->has_zero_init) {
-        bs->supported_truncate_flags =3D BDRV_REQ_ZERO_WRITE;
-    }
-    return 0;
-}
-
-static QemuOptsList nfs_create_opts =3D {
-    .name =3D "nfs-create-opts",
-    .head =3D QTAILQ_HEAD_INITIALIZER(nfs_create_opts.head),
-    .desc =3D {
-        {
-            .name =3D BLOCK_OPT_SIZE,
-            .type =3D QEMU_OPT_SIZE,
-            .help =3D "Virtual disk size"
-        },
-        { /* end of list */ }
-    }
-};
-
-static int nfs_file_co_create(BlockdevCreateOptions *options, Error **errp)
-{
-    BlockdevCreateOptionsNfs *opts =3D &options->u.nfs;
-    NFSClient *client =3D g_new0(NFSClient, 1);
-    int ret;
-
-    assert(options->driver =3D=3D BLOCKDEV_DRIVER_NFS);
-
-    client->aio_context =3D qemu_get_aio_context();
-
-    ret =3D nfs_client_open(client, opts->location, O_CREAT, 0, errp);
-    if (ret < 0) {
-        goto out;
-    }
-    ret =3D nfs_ftruncate(client->context, client->fh, opts->size);
-    nfs_client_close(client);
-
-out:
-    g_free(client);
-    return ret;
-}
-
-static int coroutine_fn nfs_file_co_create_opts(BlockDriver *drv,
-                                                const char *url,
-                                                QemuOpts *opts,
-                                                Error **errp)
-{
-    BlockdevCreateOptions *create_options;
-    BlockdevCreateOptionsNfs *nfs_opts;
-    QDict *options;
-    int ret;
-
-    create_options =3D g_new0(BlockdevCreateOptions, 1);
-    create_options->driver =3D BLOCKDEV_DRIVER_NFS;
-    nfs_opts =3D &create_options->u.nfs;
-
-    /* Read out options */
-    nfs_opts->size =3D ROUND_UP(qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE=
, 0),
-                              BDRV_SECTOR_SIZE);
-
-    options =3D qdict_new();
-    ret =3D nfs_parse_uri(url, options, errp);
-    if (ret < 0) {
-        goto out;
-    }
-
-    nfs_opts->location =3D nfs_options_qdict_to_qapi(options, errp);
-    if (nfs_opts->location =3D=3D NULL) {
-        ret =3D -EINVAL;
-        goto out;
-    }
-
-    ret =3D nfs_file_co_create(create_options, errp);
-    if (ret < 0) {
-        goto out;
-    }
-
-    ret =3D 0;
-out:
-    qobject_unref(options);
-    qapi_free_BlockdevCreateOptions(create_options);
-    return ret;
-}
-
-static int nfs_has_zero_init(BlockDriverState *bs)
-{
-    NFSClient *client =3D bs->opaque;
-    return client->has_zero_init;
-}
-
-/* Called (via nfs_service) with QemuMutex held.  */
-static void
-nfs_get_allocated_file_size_cb(int ret, struct nfs_context *nfs, void *dat=
a,
-                               void *private_data)
-{
-    NFSRPC *task =3D private_data;
-    task->ret =3D ret;
-    if (task->ret =3D=3D 0) {
-        memcpy(task->st, data, sizeof(struct stat));
-    }
-    if (task->ret < 0) {
-        error_report("NFS Error: %s", nfs_get_error(nfs));
-    }
-
-    /* Set task->complete before reading bs->wakeup.  */
-    atomic_mb_set(&task->complete, 1);
-    bdrv_wakeup(task->bs);
-}
-
-static int64_t nfs_get_allocated_file_size(BlockDriverState *bs)
-{
-    NFSClient *client =3D bs->opaque;
-    NFSRPC task =3D {0};
-    struct stat st;
-
-    if (bdrv_is_read_only(bs) &&
-        !(bs->open_flags & BDRV_O_NOCACHE)) {
-        return client->st_blocks * 512;
-    }
-
-    task.bs =3D bs;
-    task.st =3D &st;
-    if (nfs_fstat_async(client->context, client->fh, nfs_get_allocated_fil=
e_size_cb,
-                        &task) !=3D 0) {
-        return -ENOMEM;
-    }
-
-    nfs_set_events(client);
-    BDRV_POLL_WHILE(bs, !task.complete);
-
-    return (task.ret < 0 ? task.ret : st.st_blocks * 512);
-}
-
-static int coroutine_fn
-nfs_file_co_truncate(BlockDriverState *bs, int64_t offset, bool exact,
-                     PreallocMode prealloc, BdrvRequestFlags flags,
-                     Error **errp)
-{
-    NFSClient *client =3D bs->opaque;
-    int ret;
-
-    if (prealloc !=3D PREALLOC_MODE_OFF) {
-        error_setg(errp, "Unsupported preallocation mode '%s'",
-                   PreallocMode_str(prealloc));
-        return -ENOTSUP;
-    }
-
-    ret =3D nfs_ftruncate(client->context, client->fh, offset);
-    if (ret < 0) {
-        error_setg_errno(errp, -ret, "Failed to truncate file");
-        return ret;
-    }
-
-    return 0;
-}
-
-/* Note that this will not re-establish a connection with the NFS server
- * - it is effectively a NOP.  */
-static int nfs_reopen_prepare(BDRVReopenState *state,
-                              BlockReopenQueue *queue, Error **errp)
-{
-    NFSClient *client =3D state->bs->opaque;
-    struct stat st;
-    int ret =3D 0;
-
-    if (state->flags & BDRV_O_RDWR && bdrv_is_read_only(state->bs)) {
-        error_setg(errp, "Cannot open a read-only mount as read-write");
-        return -EACCES;
-    }
-
-    if ((state->flags & BDRV_O_NOCACHE) && client->cache_used) {
-        error_setg(errp, "Cannot disable cache if libnfs readahead or"
-                         " pagecache is enabled");
-        return -EINVAL;
-    }
-
-    /* Update cache for read-only reopens */
-    if (!(state->flags & BDRV_O_RDWR)) {
-        ret =3D nfs_fstat(client->context, client->fh, &st);
-        if (ret < 0) {
-            error_setg(errp, "Failed to fstat file: %s",
-                       nfs_get_error(client->context));
-            return ret;
-        }
-        client->st_blocks =3D st.st_blocks;
-    }
-
-    return 0;
-}
-
-static void nfs_refresh_filename(BlockDriverState *bs)
-{
-    NFSClient *client =3D bs->opaque;
-
-    if (client->uid && !client->gid) {
-        snprintf(bs->exact_filename, sizeof(bs->exact_filename),
-                 "nfs://%s%s?uid=3D%" PRId64, client->server->host, client=
->path,
-                 client->uid);
-    } else if (!client->uid && client->gid) {
-        snprintf(bs->exact_filename, sizeof(bs->exact_filename),
-                 "nfs://%s%s?gid=3D%" PRId64, client->server->host, client=
->path,
-                 client->gid);
-    } else if (client->uid && client->gid) {
-        snprintf(bs->exact_filename, sizeof(bs->exact_filename),
-                 "nfs://%s%s?uid=3D%" PRId64 "&gid=3D%" PRId64,
-                 client->server->host, client->path, client->uid, client->=
gid);
-    } else {
-        snprintf(bs->exact_filename, sizeof(bs->exact_filename),
-                 "nfs://%s%s", client->server->host, client->path);
-    }
-}
-
-static char *nfs_dirname(BlockDriverState *bs, Error **errp)
-{
-    NFSClient *client =3D bs->opaque;
-
-    if (client->uid || client->gid) {
-        bdrv_refresh_filename(bs);
-        error_setg(errp, "Cannot generate a base directory for NFS node '%=
s'",
-                   bs->filename);
-        return NULL;
-    }
-
-    return g_strdup_printf("nfs://%s%s/", client->server->host, client->pa=
th);
-}
-
-#ifdef LIBNFS_FEATURE_PAGECACHE
-static void coroutine_fn nfs_co_invalidate_cache(BlockDriverState *bs,
-                                                 Error **errp)
-{
-    NFSClient *client =3D bs->opaque;
-    nfs_pagecache_invalidate(client->context, client->fh);
-}
-#endif
-
-static const char *nfs_strong_runtime_opts[] =3D {
-    "path",
-    "user",
-    "group",
-    "server.",
-
-    NULL
-};
-
-static BlockDriver bdrv_nfs =3D {
-    .format_name                    =3D "nfs",
-    .protocol_name                  =3D "nfs",
-
-    .instance_size                  =3D sizeof(NFSClient),
-    .bdrv_parse_filename            =3D nfs_parse_filename,
-    .create_opts                    =3D &nfs_create_opts,
-
-    .bdrv_has_zero_init             =3D nfs_has_zero_init,
-    .bdrv_get_allocated_file_size   =3D nfs_get_allocated_file_size,
-    .bdrv_co_truncate               =3D nfs_file_co_truncate,
-
-    .bdrv_file_open                 =3D nfs_file_open,
-    .bdrv_close                     =3D nfs_file_close,
-    .bdrv_co_create                 =3D nfs_file_co_create,
-    .bdrv_co_create_opts            =3D nfs_file_co_create_opts,
-    .bdrv_reopen_prepare            =3D nfs_reopen_prepare,
-
-    .bdrv_co_preadv                 =3D nfs_co_preadv,
-    .bdrv_co_pwritev                =3D nfs_co_pwritev,
-    .bdrv_co_flush_to_disk          =3D nfs_co_flush,
-
-    .bdrv_detach_aio_context        =3D nfs_detach_aio_context,
-    .bdrv_attach_aio_context        =3D nfs_attach_aio_context,
-    .bdrv_refresh_filename          =3D nfs_refresh_filename,
-    .bdrv_dirname                   =3D nfs_dirname,
-
-    .strong_runtime_opts            =3D nfs_strong_runtime_opts,
-
-#ifdef LIBNFS_FEATURE_PAGECACHE
-    .bdrv_co_invalidate_cache       =3D nfs_co_invalidate_cache,
-#endif
-};
-
-static void nfs_block_init(void)
-{
-    bdrv_register(&bdrv_nfs);
-}
-
-block_init(nfs_block_init);
+/*=0D
+ * QEMU Block driver for native access to files on NFS shares=0D
+ *=0D
+ * Copyright (c) 2014-2017 Peter Lieven <pl@kamp.de>=0D
+ *=0D
+ * Permission is hereby granted, free of charge, to any person obtaining a=
 copy=0D
+ * of this software and associated documentation files (the "Software"), t=
o deal=0D
+ * in the Software without restriction, including without limitation the r=
ights=0D
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or se=
ll=0D
+ * copies of the Software, and to permit persons to whom the Software is=0D
+ * furnished to do so, subject to the following conditions:=0D
+ *=0D
+ * The above copyright notice and this permission notice shall be included=
 in=0D
+ * all copies or substantial portions of the Software.=0D
+ *=0D
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS=
 OR=0D
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,=0D
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL=
=0D
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OT=
HER=0D
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING=
 FROM,=0D
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS =
IN=0D
+ * THE SOFTWARE.=0D
+ */=0D
+=0D
+#include "qemu/osdep.h"=0D
+=0D
+#if !defined(_WIN32)=0D
+#include <poll.h>=0D
+#endif=0D
+#include "qemu/config-file.h"=0D
+#include "qemu/error-report.h"=0D
+#include "qapi/error.h"=0D
+#include "block/block_int.h"=0D
+#include "block/qdict.h"=0D
+#include "trace.h"=0D
+#include "qemu/iov.h"=0D
+#include "qemu/main-loop.h"=0D
+#include "qemu/module.h"=0D
+#include "qemu/option.h"=0D
+#include "qemu/uri.h"=0D
+#include "qemu/cutils.h"=0D
+#include "sysemu/sysemu.h"=0D
+#include "sysemu/replay.h"=0D
+#include "qapi/qapi-visit-block-core.h"=0D
+#include "qapi/qmp/qdict.h"=0D
+#include "qapi/qmp/qstring.h"=0D
+#include "qapi/qobject-input-visitor.h"=0D
+#include "qapi/qobject-output-visitor.h"=0D
+#include <nfsc/libnfs.h>=0D
+=0D
+=0D
+#define QEMU_NFS_MAX_READAHEAD_SIZE 1048576=0D
+#define QEMU_NFS_MAX_PAGECACHE_SIZE (8388608 / NFS_BLKSIZE)=0D
+#define QEMU_NFS_MAX_DEBUG_LEVEL 2=0D
+=0D
+#if defined (_WIN32)=0D
+#define nfs_stat __stat64=0D
+#else=0D
+#define nfs_stat stat=0D
+#endif=0D
+=0D
+typedef struct NFSClient {=0D
+    struct nfs_context *context;=0D
+    struct nfsfh *fh;=0D
+    int events;=0D
+    bool has_zero_init;=0D
+    AioContext *aio_context;=0D
+    QemuMutex mutex;=0D
+    int64_t st_size;=0D
+    bool cache_used;=0D
+    NFSServer *server;=0D
+    char *path;=0D
+    int64_t uid, gid, tcp_syncnt, readahead, pagecache, debug;=0D
+} NFSClient;=0D
+=0D
+typedef struct NFSRPC {=0D
+    BlockDriverState *bs;=0D
+    int ret;=0D
+    int complete;=0D
+    QEMUIOVector *iov;=0D
+    struct nfs_stat *st;=0D
+    Coroutine *co;=0D
+    NFSClient *client;=0D
+} NFSRPC;=0D
+=0D
+static int nfs_parse_uri(const char *filename, QDict *options, Error **err=
p)=0D
+{=0D
+    URI *uri =3D NULL;=0D
+    QueryParams *qp =3D NULL;=0D
+    int ret =3D -EINVAL, i;=0D
+=0D
+    uri =3D uri_parse(filename);=0D
+    if (!uri) {=0D
+        error_setg(errp, "Invalid URI specified");=0D
+        goto out;=0D
+    }=0D
+    if (g_strcmp0(uri->scheme, "nfs") !=3D 0) {=0D
+        error_setg(errp, "URI scheme must be 'nfs'");=0D
+        goto out;=0D
+    }=0D
+=0D
+    if (!uri->server) {=0D
+        error_setg(errp, "missing hostname in URI");=0D
+        goto out;=0D
+    }=0D
+=0D
+    if (!uri->path) {=0D
+        error_setg(errp, "missing file path in URI");=0D
+        goto out;=0D
+    }=0D
+=0D
+    qp =3D query_params_parse(uri->query);=0D
+    if (!qp) {=0D
+        error_setg(errp, "could not parse query parameters");=0D
+        goto out;=0D
+    }=0D
+=0D
+    qdict_put_str(options, "server.host", uri->server);=0D
+    qdict_put_str(options, "server.type", "inet");=0D
+    qdict_put_str(options, "path", uri->path);=0D
+=0D
+    for (i =3D 0; i < qp->n; i++) {=0D
+        unsigned long long val;=0D
+        if (!qp->p[i].value) {=0D
+            error_setg(errp, "Value for NFS parameter expected: %s",=0D
+                       qp->p[i].name);=0D
+            goto out;=0D
+        }=0D
+        if (parse_uint_full(qp->p[i].value, &val, 0)) {=0D
+            error_setg(errp, "Illegal value for NFS parameter: %s",=0D
+                       qp->p[i].name);=0D
+            goto out;=0D
+        }=0D
+        if (!strcmp(qp->p[i].name, "uid")) {=0D
+            qdict_put_str(options, "user", qp->p[i].value);=0D
+        } else if (!strcmp(qp->p[i].name, "gid")) {=0D
+            qdict_put_str(options, "group", qp->p[i].value);=0D
+        } else if (!strcmp(qp->p[i].name, "tcp-syncnt")) {=0D
+            qdict_put_str(options, "tcp-syn-count", qp->p[i].value);=0D
+        } else if (!strcmp(qp->p[i].name, "readahead")) {=0D
+            qdict_put_str(options, "readahead-size", qp->p[i].value);=0D
+        } else if (!strcmp(qp->p[i].name, "pagecache")) {=0D
+            qdict_put_str(options, "page-cache-size", qp->p[i].value);=0D
+        } else if (!strcmp(qp->p[i].name, "debug")) {=0D
+            qdict_put_str(options, "debug", qp->p[i].value);=0D
+        } else {=0D
+            error_setg(errp, "Unknown NFS parameter name: %s",=0D
+                       qp->p[i].name);=0D
+            goto out;=0D
+        }=0D
+    }=0D
+    ret =3D 0;=0D
+out:=0D
+    if (qp) {=0D
+        query_params_free(qp);=0D
+    }=0D
+    if (uri) {=0D
+        uri_free(uri);=0D
+    }=0D
+    return ret;=0D
+}=0D
+=0D
+static bool nfs_has_filename_options_conflict(QDict *options, Error **errp=
)=0D
+{=0D
+    const QDictEntry *qe;=0D
+=0D
+    for (qe =3D qdict_first(options); qe; qe =3D qdict_next(options, qe)) =
{=0D
+        if (!strcmp(qe->key, "host") ||=0D
+            !strcmp(qe->key, "path") ||=0D
+            !strcmp(qe->key, "user") ||=0D
+            !strcmp(qe->key, "group") ||=0D
+            !strcmp(qe->key, "tcp-syn-count") ||=0D
+            !strcmp(qe->key, "readahead-size") ||=0D
+            !strcmp(qe->key, "page-cache-size") ||=0D
+            !strcmp(qe->key, "debug") ||=0D
+            strstart(qe->key, "server.", NULL))=0D
+        {=0D
+            error_setg(errp, "Option %s cannot be used with a filename",=0D
+                       qe->key);=0D
+            return true;=0D
+        }=0D
+    }=0D
+=0D
+    return false;=0D
+}=0D
+=0D
+static void nfs_parse_filename(const char *filename, QDict *options,=0D
+                               Error **errp)=0D
+{=0D
+    if (nfs_has_filename_options_conflict(options, errp)) {=0D
+        return;=0D
+    }=0D
+=0D
+    nfs_parse_uri(filename, options, errp);=0D
+}=0D
+=0D
+static void nfs_process_read(void *arg);=0D
+static void nfs_process_write(void *arg);=0D
+=0D
+/* Called with QemuMutex held.  */=0D
+static void nfs_set_events(NFSClient *client)=0D
+{=0D
+    int ev =3D nfs_which_events(client->context);=0D
+    if (ev !=3D client->events) {=0D
+        aio_set_fd_handler(client->aio_context, nfs_get_fd(client->context=
),=0D
+                           false,=0D
+                           (ev & POLLIN) ? nfs_process_read : NULL,=0D
+                           (ev & POLLOUT) ? nfs_process_write : NULL,=0D
+                           NULL, client);=0D
+=0D
+    }=0D
+    client->events =3D ev;=0D
+}=0D
+=0D
+static void nfs_process_read(void *arg)=0D
+{=0D
+    NFSClient *client =3D arg;=0D
+=0D
+    qemu_mutex_lock(&client->mutex);=0D
+    nfs_service(client->context, POLLIN);=0D
+    nfs_set_events(client);=0D
+    qemu_mutex_unlock(&client->mutex);=0D
+}=0D
+=0D
+static void nfs_process_write(void *arg)=0D
+{=0D
+    NFSClient *client =3D arg;=0D
+=0D
+    qemu_mutex_lock(&client->mutex);=0D
+    nfs_service(client->context, POLLOUT);=0D
+    nfs_set_events(client);=0D
+    qemu_mutex_unlock(&client->mutex);=0D
+}=0D
+=0D
+static void nfs_co_init_task(BlockDriverState *bs, NFSRPC *task)=0D
+{=0D
+    *task =3D (NFSRPC) {=0D
+        .co             =3D qemu_coroutine_self(),=0D
+        .bs             =3D bs,=0D
+        .client         =3D bs->opaque,=0D
+    };=0D
+}=0D
+=0D
+static void nfs_co_generic_bh_cb(void *opaque)=0D
+{=0D
+    NFSRPC *task =3D opaque;=0D
+=0D
+    task->complete =3D 1;=0D
+    aio_co_wake(task->co);=0D
+}=0D
+=0D
+/* Called (via nfs_service) with QemuMutex held.  */=0D
+static void=0D
+nfs_co_generic_cb(int ret, struct nfs_context *nfs, void *data,=0D
+                  void *private_data)=0D
+{=0D
+    NFSRPC *task =3D private_data;=0D
+    task->ret =3D ret;=0D
+    assert(!task->st);=0D
+    if (task->ret > 0 && task->iov) {=0D
+        if (task->ret <=3D task->iov->size) {=0D
+            qemu_iovec_from_buf(task->iov, 0, data, task->ret);=0D
+        } else {=0D
+            task->ret =3D -EIO;=0D
+        }=0D
+    }=0D
+    if (task->ret < 0) {=0D
+        error_report("NFS Error: %s", nfs_get_error(nfs));=0D
+    }=0D
+    replay_bh_schedule_oneshot_event(task->client->aio_context,=0D
+                                     nfs_co_generic_bh_cb, task);=0D
+}=0D
+=0D
+static int coroutine_fn nfs_co_preadv(BlockDriverState *bs, uint64_t offse=
t,=0D
+                                      uint64_t bytes, QEMUIOVector *iov,=0D
+                                      int flags)=0D
+{=0D
+    NFSClient *client =3D bs->opaque;=0D
+    NFSRPC task;=0D
+=0D
+    nfs_co_init_task(bs, &task);=0D
+    task.iov =3D iov;=0D
+=0D
+    WITH_QEMU_LOCK_GUARD(&client->mutex) {=0D
+        if (nfs_pread_async(client->context, client->fh,=0D
+                            offset, bytes, nfs_co_generic_cb, &task) !=3D =
0) {=0D
+            return -ENOMEM;=0D
+        }=0D
+=0D
+        nfs_set_events(client);=0D
+    }=0D
+    while (!task.complete) {=0D
+        qemu_coroutine_yield();=0D
+    }=0D
+=0D
+    if (task.ret < 0) {=0D
+        return task.ret;=0D
+    }=0D
+=0D
+    /* zero pad short reads */=0D
+    if (task.ret < iov->size) {=0D
+        qemu_iovec_memset(iov, task.ret, 0, iov->size - task.ret);=0D
+    }=0D
+=0D
+    return 0;=0D
+}=0D
+=0D
+static int coroutine_fn nfs_co_pwritev(BlockDriverState *bs, uint64_t offs=
et,=0D
+                                       uint64_t bytes, QEMUIOVector *iov,=
=0D
+                                       int flags)=0D
+{=0D
+    NFSClient *client =3D bs->opaque;=0D
+    NFSRPC task;=0D
+    char *buf =3D NULL;=0D
+    bool my_buffer =3D false;=0D
+=0D
+    nfs_co_init_task(bs, &task);=0D
+=0D
+    if (iov->niov !=3D 1) {=0D
+        buf =3D g_try_malloc(bytes);=0D
+        if (bytes && buf =3D=3D NULL) {=0D
+            return -ENOMEM;=0D
+        }=0D
+        qemu_iovec_to_buf(iov, 0, buf, bytes);=0D
+        my_buffer =3D true;=0D
+    } else {=0D
+        buf =3D iov->iov[0].iov_base;=0D
+    }=0D
+=0D
+    WITH_QEMU_LOCK_GUARD(&client->mutex) {=0D
+        if (nfs_pwrite_async(client->context, client->fh,=0D
+                             offset, bytes, buf,=0D
+                             nfs_co_generic_cb, &task) !=3D 0) {=0D
+            if (my_buffer) {=0D
+                g_free(buf);=0D
+            }=0D
+            return -ENOMEM;=0D
+        }=0D
+=0D
+        nfs_set_events(client);=0D
+    }=0D
+    while (!task.complete) {=0D
+        qemu_coroutine_yield();=0D
+    }=0D
+=0D
+    if (my_buffer) {=0D
+        g_free(buf);=0D
+    }=0D
+=0D
+    if (task.ret !=3D bytes) {=0D
+        return task.ret < 0 ? task.ret : -EIO;=0D
+    }=0D
+=0D
+    return 0;=0D
+}=0D
+=0D
+static int coroutine_fn nfs_co_flush(BlockDriverState *bs)=0D
+{=0D
+    NFSClient *client =3D bs->opaque;=0D
+    NFSRPC task;=0D
+=0D
+    nfs_co_init_task(bs, &task);=0D
+=0D
+    WITH_QEMU_LOCK_GUARD(&client->mutex) {=0D
+        if (nfs_fsync_async(client->context, client->fh, nfs_co_generic_cb=
,=0D
+                            &task) !=3D 0) {=0D
+            return -ENOMEM;=0D
+        }=0D
+=0D
+        nfs_set_events(client);=0D
+    }=0D
+    while (!task.complete) {=0D
+        qemu_coroutine_yield();=0D
+    }=0D
+=0D
+    return task.ret;=0D
+}=0D
+=0D
+static void nfs_detach_aio_context(BlockDriverState *bs)=0D
+{=0D
+    NFSClient *client =3D bs->opaque;=0D
+=0D
+    aio_set_fd_handler(client->aio_context, nfs_get_fd(client->context),=0D
+                       false, NULL, NULL, NULL, NULL);=0D
+    client->events =3D 0;=0D
+}=0D
+=0D
+static void nfs_attach_aio_context(BlockDriverState *bs,=0D
+                                   AioContext *new_context)=0D
+{=0D
+    NFSClient *client =3D bs->opaque;=0D
+=0D
+    client->aio_context =3D new_context;=0D
+    nfs_set_events(client);=0D
+}=0D
+=0D
+static void nfs_client_close(NFSClient *client)=0D
+{=0D
+    if (client->context) {=0D
+        qemu_mutex_lock(&client->mutex);=0D
+        aio_set_fd_handler(client->aio_context, nfs_get_fd(client->context=
),=0D
+                           false, NULL, NULL, NULL, NULL);=0D
+        qemu_mutex_unlock(&client->mutex);=0D
+        if (client->fh) {=0D
+            nfs_close(client->context, client->fh);=0D
+            client->fh =3D NULL;=0D
+        }=0D
+#ifdef LIBNFS_FEATURE_UMOUNT=0D
+        nfs_umount(client->context);=0D
+#endif=0D
+        nfs_destroy_context(client->context);=0D
+        client->context =3D NULL;=0D
+    }=0D
+    g_free(client->path);=0D
+    qemu_mutex_destroy(&client->mutex);=0D
+    qapi_free_NFSServer(client->server);=0D
+    client->server =3D NULL;=0D
+}=0D
+=0D
+static void nfs_file_close(BlockDriverState *bs)=0D
+{=0D
+    NFSClient *client =3D bs->opaque;=0D
+    nfs_client_close(client);=0D
+}=0D
+=0D
+static int64_t nfs_client_open(NFSClient *client, BlockdevOptionsNfs *opts=
,=0D
+                               int flags, int open_flags, Error **errp)=0D
+{=0D
+    int64_t ret =3D -EINVAL;=0D
+    struct nfs_stat st;=0D
+    char *file =3D NULL, *strp =3D NULL;=0D
+=0D
+    qemu_mutex_init(&client->mutex);=0D
+=0D
+    client->path =3D g_strdup(opts->path);=0D
+=0D
+    strp =3D strrchr(client->path, '/');=0D
+    if (strp =3D=3D NULL) {=0D
+        error_setg(errp, "Invalid URL specified");=0D
+        goto fail;=0D
+    }=0D
+    file =3D g_strdup(strp);=0D
+    *strp =3D 0;=0D
+=0D
+    /* Steal the NFSServer object from opts; set the original pointer to N=
ULL=0D
+     * to avoid use after free and double free. */=0D
+    client->server =3D opts->server;=0D
+    opts->server =3D NULL;=0D
+=0D
+    client->context =3D nfs_init_context();=0D
+    if (client->context =3D=3D NULL) {=0D
+        error_setg(errp, "Failed to init NFS context");=0D
+        goto fail;=0D
+    }=0D
+=0D
+    if (opts->has_user) {=0D
+        client->uid =3D opts->user;=0D
+        nfs_set_uid(client->context, client->uid);=0D
+    }=0D
+=0D
+    if (opts->has_group) {=0D
+        client->gid =3D opts->group;=0D
+        nfs_set_gid(client->context, client->gid);=0D
+    }=0D
+=0D
+    if (opts->has_tcp_syn_count) {=0D
+        client->tcp_syncnt =3D opts->tcp_syn_count;=0D
+        nfs_set_tcp_syncnt(client->context, client->tcp_syncnt);=0D
+    }=0D
+=0D
+#ifdef LIBNFS_FEATURE_READAHEAD=0D
+    if (opts->has_readahead_size) {=0D
+        if (open_flags & BDRV_O_NOCACHE) {=0D
+            error_setg(errp, "Cannot enable NFS readahead "=0D
+                             "if cache.direct =3D on");=0D
+            goto fail;=0D
+        }=0D
+        client->readahead =3D opts->readahead_size;=0D
+        if (client->readahead > QEMU_NFS_MAX_READAHEAD_SIZE) {=0D
+            warn_report("Truncating NFS readahead size to %d",=0D
+                        QEMU_NFS_MAX_READAHEAD_SIZE);=0D
+            client->readahead =3D QEMU_NFS_MAX_READAHEAD_SIZE;=0D
+        }=0D
+        nfs_set_readahead(client->context, client->readahead);=0D
+#ifdef LIBNFS_FEATURE_PAGECACHE=0D
+        nfs_set_pagecache_ttl(client->context, 0);=0D
+#endif=0D
+        client->cache_used =3D true;=0D
+    }=0D
+#endif=0D
+=0D
+#ifdef LIBNFS_FEATURE_PAGECACHE=0D
+    if (opts->has_page_cache_size) {=0D
+        if (open_flags & BDRV_O_NOCACHE) {=0D
+            error_setg(errp, "Cannot enable NFS pagecache "=0D
+                             "if cache.direct =3D on");=0D
+            goto fail;=0D
+        }=0D
+        client->pagecache =3D opts->page_cache_size;=0D
+        if (client->pagecache > QEMU_NFS_MAX_PAGECACHE_SIZE) {=0D
+            warn_report("Truncating NFS pagecache size to %d pages",=0D
+                        QEMU_NFS_MAX_PAGECACHE_SIZE);=0D
+            client->pagecache =3D QEMU_NFS_MAX_PAGECACHE_SIZE;=0D
+        }=0D
+        nfs_set_pagecache(client->context, client->pagecache);=0D
+        nfs_set_pagecache_ttl(client->context, 0);=0D
+        client->cache_used =3D true;=0D
+    }=0D
+#endif=0D
+=0D
+#ifdef LIBNFS_FEATURE_DEBUG=0D
+    if (opts->has_debug) {=0D
+        client->debug =3D opts->debug;=0D
+        /* limit the maximum debug level to avoid potential flooding=0D
+         * of our log files. */=0D
+        if (client->debug > QEMU_NFS_MAX_DEBUG_LEVEL) {=0D
+            warn_report("Limiting NFS debug level to %d",=0D
+                        QEMU_NFS_MAX_DEBUG_LEVEL);=0D
+            client->debug =3D QEMU_NFS_MAX_DEBUG_LEVEL;=0D
+        }=0D
+        nfs_set_debug(client->context, client->debug);=0D
+    }=0D
+#endif=0D
+=0D
+    ret =3D nfs_mount(client->context, client->server->host, client->path)=
;=0D
+    if (ret < 0) {=0D
+        error_setg(errp, "Failed to mount nfs share: %s",=0D
+                   nfs_get_error(client->context));=0D
+        goto fail;=0D
+    }=0D
+=0D
+    if (flags & O_CREAT) {=0D
+        ret =3D nfs_creat(client->context, file, 0600, &client->fh);=0D
+        if (ret < 0) {=0D
+            error_setg(errp, "Failed to create file: %s",=0D
+                       nfs_get_error(client->context));=0D
+            goto fail;=0D
+        }=0D
+    } else {=0D
+        ret =3D nfs_open(client->context, file, flags, &client->fh);=0D
+        if (ret < 0) {=0D
+            error_setg(errp, "Failed to open file : %s",=0D
+                       nfs_get_error(client->context));=0D
+            goto fail;=0D
+        }=0D
+    }=0D
+=0D
+    ret =3D nfs_fstat(client->context, client->fh, &st);=0D
+    if (ret < 0) {=0D
+        error_setg(errp, "Failed to fstat file: %s",=0D
+                   nfs_get_error(client->context));=0D
+        goto fail;=0D
+    }=0D
+=0D
+    ret =3D DIV_ROUND_UP(st.st_size, BDRV_SECTOR_SIZE);=0D
+    client->st_size =3D st.st_size;=0D
+    client->has_zero_init =3D S_ISREG(st.st_mode);=0D
+    *strp =3D '/';=0D
+    goto out;=0D
+=0D
+fail:=0D
+    nfs_client_close(client);=0D
+out:=0D
+    g_free(file);=0D
+    return ret;=0D
+}=0D
+=0D
+static BlockdevOptionsNfs *nfs_options_qdict_to_qapi(QDict *options,=0D
+                                                     Error **errp)=0D
+{=0D
+    BlockdevOptionsNfs *opts =3D NULL;=0D
+    Visitor *v;=0D
+    const QDictEntry *e;=0D
+=0D
+    v =3D qobject_input_visitor_new_flat_confused(options, errp);=0D
+    if (!v) {=0D
+        return NULL;=0D
+    }=0D
+=0D
+    visit_type_BlockdevOptionsNfs(v, NULL, &opts, errp);=0D
+    visit_free(v);=0D
+    if (!opts) {=0D
+        return NULL;=0D
+    }=0D
+=0D
+    /* Remove the processed options from the QDict (the visitor processes=
=0D
+     * _all_ options in the QDict) */=0D
+    while ((e =3D qdict_first(options))) {=0D
+        qdict_del(options, e->key);=0D
+    }=0D
+=0D
+    return opts;=0D
+}=0D
+=0D
+static int64_t nfs_client_open_qdict(NFSClient *client, QDict *options,=0D
+                                     int flags, int open_flags, Error **er=
rp)=0D
+{=0D
+    BlockdevOptionsNfs *opts;=0D
+    int ret;=0D
+=0D
+    opts =3D nfs_options_qdict_to_qapi(options, errp);=0D
+    if (opts =3D=3D NULL) {=0D
+        ret =3D -EINVAL;=0D
+        goto fail;=0D
+    }=0D
+=0D
+    ret =3D nfs_client_open(client, opts, flags, open_flags, errp);=0D
+fail:=0D
+    qapi_free_BlockdevOptionsNfs(opts);=0D
+    return ret;=0D
+}=0D
+=0D
+static int nfs_file_open(BlockDriverState *bs, QDict *options, int flags,=
=0D
+                         Error **errp) {=0D
+    NFSClient *client =3D bs->opaque;=0D
+    int64_t ret;=0D
+=0D
+    client->aio_context =3D bdrv_get_aio_context(bs);=0D
+=0D
+    ret =3D nfs_client_open_qdict(client, options,=0D
+                                (flags & BDRV_O_RDWR) ? O_RDWR : O_RDONLY,=
=0D
+                                bs->open_flags, errp);=0D
+    if (ret < 0) {=0D
+        return ret;=0D
+    }=0D
+=0D
+    bs->total_sectors =3D ret;=0D
+    if (client->has_zero_init) {=0D
+        bs->supported_truncate_flags =3D BDRV_REQ_ZERO_WRITE;=0D
+    }=0D
+    return 0;=0D
+}=0D
+=0D
+static QemuOptsList nfs_create_opts =3D {=0D
+    .name =3D "nfs-create-opts",=0D
+    .head =3D QTAILQ_HEAD_INITIALIZER(nfs_create_opts.head),=0D
+    .desc =3D {=0D
+        {=0D
+            .name =3D BLOCK_OPT_SIZE,=0D
+            .type =3D QEMU_OPT_SIZE,=0D
+            .help =3D "Virtual disk size"=0D
+        },=0D
+        { /* end of list */ }=0D
+    }=0D
+};=0D
+=0D
+static int nfs_file_co_create(BlockdevCreateOptions *options, Error **errp=
)=0D
+{=0D
+    BlockdevCreateOptionsNfs *opts =3D &options->u.nfs;=0D
+    NFSClient *client =3D g_new0(NFSClient, 1);=0D
+    int ret;=0D
+=0D
+    assert(options->driver =3D=3D BLOCKDEV_DRIVER_NFS);=0D
+=0D
+    client->aio_context =3D qemu_get_aio_context();=0D
+=0D
+    ret =3D nfs_client_open(client, opts->location, O_CREAT, 0, errp);=0D
+    if (ret < 0) {=0D
+        goto out;=0D
+    }=0D
+    ret =3D nfs_ftruncate(client->context, client->fh, opts->size);=0D
+    nfs_client_close(client);=0D
+=0D
+out:=0D
+    g_free(client);=0D
+    return ret;=0D
+}=0D
+=0D
+static int coroutine_fn nfs_file_co_create_opts(BlockDriver *drv,=0D
+                                                const char *url,=0D
+                                                QemuOpts *opts,=0D
+                                                Error **errp)=0D
+{=0D
+    BlockdevCreateOptions *create_options;=0D
+    BlockdevCreateOptionsNfs *nfs_opts;=0D
+    QDict *options;=0D
+    int ret;=0D
+=0D
+    create_options =3D g_new0(BlockdevCreateOptions, 1);=0D
+    create_options->driver =3D BLOCKDEV_DRIVER_NFS;=0D
+    nfs_opts =3D &create_options->u.nfs;=0D
+=0D
+    /* Read out options */=0D
+    nfs_opts->size =3D ROUND_UP(qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE=
, 0),=0D
+                              BDRV_SECTOR_SIZE);=0D
+=0D
+    options =3D qdict_new();=0D
+    ret =3D nfs_parse_uri(url, options, errp);=0D
+    if (ret < 0) {=0D
+        goto out;=0D
+    }=0D
+=0D
+    nfs_opts->location =3D nfs_options_qdict_to_qapi(options, errp);=0D
+    if (nfs_opts->location =3D=3D NULL) {=0D
+        ret =3D -EINVAL;=0D
+        goto out;=0D
+    }=0D
+=0D
+    ret =3D nfs_file_co_create(create_options, errp);=0D
+    if (ret < 0) {=0D
+        goto out;=0D
+    }=0D
+=0D
+    ret =3D 0;=0D
+out:=0D
+    qobject_unref(options);=0D
+    qapi_free_BlockdevCreateOptions(create_options);=0D
+    return ret;=0D
+}=0D
+=0D
+static int nfs_has_zero_init(BlockDriverState *bs)=0D
+{=0D
+    NFSClient *client =3D bs->opaque;=0D
+    return client->has_zero_init;=0D
+}=0D
+=0D
+/* Called (via nfs_service) with QemuMutex held.  */=0D
+static void=0D
+nfs_get_allocated_file_size_cb(int ret, struct nfs_context *nfs, void *dat=
a,=0D
+                               void *private_data)=0D
+{=0D
+    NFSRPC *task =3D private_data;=0D
+    task->ret =3D ret;=0D
+    if (task->ret =3D=3D 0) {=0D
+        memcpy(task->st, data, sizeof(struct stat));=0D
+    }=0D
+    if (task->ret < 0) {=0D
+        error_report("NFS Error: %s", nfs_get_error(nfs));=0D
+    }=0D
+=0D
+    /* Set task->complete before reading bs->wakeup.  */=0D
+    atomic_mb_set(&task->complete, 1);=0D
+    bdrv_wakeup(task->bs);=0D
+}=0D
+=0D
+static int64_t nfs_get_allocated_file_size(BlockDriverState *bs)=0D
+{=0D
+    NFSClient *client =3D bs->opaque;=0D
+    NFSRPC task =3D {0};=0D
+    struct nfs_stat st;=0D
+=0D
+    if (bdrv_is_read_only(bs) &&=0D
+        !(bs->open_flags & BDRV_O_NOCACHE)) {=0D
+        return client->st_size;=0D
+    }=0D
+=0D
+    task.bs =3D bs;=0D
+    task.st =3D &st;=0D
+    if (nfs_fstat_async(client->context, client->fh, nfs_get_allocated_fil=
e_size_cb,=0D
+                        &task) !=3D 0) {=0D
+        return -ENOMEM;=0D
+    }=0D
+=0D
+    nfs_set_events(client);=0D
+    BDRV_POLL_WHILE(bs, !task.complete);=0D
+=0D
+    return (task.ret < 0 ? task.ret : st.st_size);=0D
+}=0D
+=0D
+static int coroutine_fn=0D
+nfs_file_co_truncate(BlockDriverState *bs, int64_t offset, bool exact,=0D
+                     PreallocMode prealloc, BdrvRequestFlags flags,=0D
+                     Error **errp)=0D
+{=0D
+    NFSClient *client =3D bs->opaque;=0D
+    int ret;=0D
+=0D
+    if (prealloc !=3D PREALLOC_MODE_OFF) {=0D
+        error_setg(errp, "Unsupported preallocation mode '%s'",=0D
+                   PreallocMode_str(prealloc));=0D
+        return -ENOTSUP;=0D
+    }=0D
+=0D
+    ret =3D nfs_ftruncate(client->context, client->fh, offset);=0D
+    if (ret < 0) {=0D
+        error_setg_errno(errp, -ret, "Failed to truncate file");=0D
+        return ret;=0D
+    }=0D
+=0D
+    return 0;=0D
+}=0D
+=0D
+/* Note that this will not re-establish a connection with the NFS server=0D
+ * - it is effectively a NOP.  */=0D
+static int nfs_reopen_prepare(BDRVReopenState *state,=0D
+                              BlockReopenQueue *queue, Error **errp)=0D
+{=0D
+    NFSClient *client =3D state->bs->opaque;=0D
+    struct nfs_stat st;=0D
+    int ret =3D 0;=0D
+=0D
+    if (state->flags & BDRV_O_RDWR && bdrv_is_read_only(state->bs)) {=0D
+        error_setg(errp, "Cannot open a read-only mount as read-write");=0D
+        return -EACCES;=0D
+    }=0D
+=0D
+    if ((state->flags & BDRV_O_NOCACHE) && client->cache_used) {=0D
+        error_setg(errp, "Cannot disable cache if libnfs readahead or"=0D
+                         " pagecache is enabled");=0D
+        return -EINVAL;=0D
+    }=0D
+=0D
+    /* Update cache for read-only reopens */=0D
+    if (!(state->flags & BDRV_O_RDWR)) {=0D
+        ret =3D nfs_fstat(client->context, client->fh, &st);=0D
+        if (ret < 0) {=0D
+            error_setg(errp, "Failed to fstat file: %s",=0D
+                       nfs_get_error(client->context));=0D
+            return ret;=0D
+        }=0D
+        client->st_size =3D st.st_size;=0D
+    }=0D
+=0D
+    return 0;=0D
+}=0D
+=0D
+static void nfs_refresh_filename(BlockDriverState *bs)=0D
+{=0D
+    NFSClient *client =3D bs->opaque;=0D
+=0D
+    if (client->uid && !client->gid) {=0D
+        snprintf(bs->exact_filename, sizeof(bs->exact_filename),=0D
+                 "nfs://%s%s?uid=3D%" PRId64, client->server->host, client=
->path,=0D
+                 client->uid);=0D
+    } else if (!client->uid && client->gid) {=0D
+        snprintf(bs->exact_filename, sizeof(bs->exact_filename),=0D
+                 "nfs://%s%s?gid=3D%" PRId64, client->server->host, client=
->path,=0D
+                 client->gid);=0D
+    } else if (client->uid && client->gid) {=0D
+        snprintf(bs->exact_filename, sizeof(bs->exact_filename),=0D
+                 "nfs://%s%s?uid=3D%" PRId64 "&gid=3D%" PRId64,=0D
+                 client->server->host, client->path, client->uid, client->=
gid);=0D
+    } else {=0D
+        snprintf(bs->exact_filename, sizeof(bs->exact_filename),=0D
+                 "nfs://%s%s", client->server->host, client->path);=0D
+    }=0D
+}=0D
+=0D
+static char *nfs_dirname(BlockDriverState *bs, Error **errp)=0D
+{=0D
+    NFSClient *client =3D bs->opaque;=0D
+=0D
+    if (client->uid || client->gid) {=0D
+        bdrv_refresh_filename(bs);=0D
+        error_setg(errp, "Cannot generate a base directory for NFS node '%=
s'",=0D
+                   bs->filename);=0D
+        return NULL;=0D
+    }=0D
+=0D
+    return g_strdup_printf("nfs://%s%s/", client->server->host, client->pa=
th);=0D
+}=0D
+=0D
+#ifdef LIBNFS_FEATURE_PAGECACHE=0D
+static void coroutine_fn nfs_co_invalidate_cache(BlockDriverState *bs,=0D
+                                                 Error **errp)=0D
+{=0D
+    NFSClient *client =3D bs->opaque;=0D
+    nfs_pagecache_invalidate(client->context, client->fh);=0D
+}=0D
+#endif=0D
+=0D
+static const char *nfs_strong_runtime_opts[] =3D {=0D
+    "path",=0D
+    "user",=0D
+    "group",=0D
+    "server.",=0D
+=0D
+    NULL=0D
+};=0D
+=0D
+static BlockDriver bdrv_nfs =3D {=0D
+    .format_name                    =3D "nfs",=0D
+    .protocol_name                  =3D "nfs",=0D
+=0D
+    .instance_size                  =3D sizeof(NFSClient),=0D
+    .bdrv_parse_filename            =3D nfs_parse_filename,=0D
+    .create_opts                    =3D &nfs_create_opts,=0D
+=0D
+    .bdrv_has_zero_init             =3D nfs_has_zero_init,=0D
+    .bdrv_get_allocated_file_size   =3D nfs_get_allocated_file_size,=0D
+    .bdrv_co_truncate               =3D nfs_file_co_truncate,=0D
+=0D
+    .bdrv_file_open                 =3D nfs_file_open,=0D
+    .bdrv_close                     =3D nfs_file_close,=0D
+    .bdrv_co_create                 =3D nfs_file_co_create,=0D
+    .bdrv_co_create_opts            =3D nfs_file_co_create_opts,=0D
+    .bdrv_reopen_prepare            =3D nfs_reopen_prepare,=0D
+=0D
+    .bdrv_co_preadv                 =3D nfs_co_preadv,=0D
+    .bdrv_co_pwritev                =3D nfs_co_pwritev,=0D
+    .bdrv_co_flush_to_disk          =3D nfs_co_flush,=0D
+=0D
+    .bdrv_detach_aio_context        =3D nfs_detach_aio_context,=0D
+    .bdrv_attach_aio_context        =3D nfs_attach_aio_context,=0D
+    .bdrv_refresh_filename          =3D nfs_refresh_filename,=0D
+    .bdrv_dirname                   =3D nfs_dirname,=0D
+=0D
+    .strong_runtime_opts            =3D nfs_strong_runtime_opts,=0D
+=0D
+#ifdef LIBNFS_FEATURE_PAGECACHE=0D
+    .bdrv_co_invalidate_cache       =3D nfs_co_invalidate_cache,=0D
+#endif=0D
+};=0D
+=0D
+static void nfs_block_init(void)=0D
+{=0D
+    bdrv_register(&bdrv_nfs);=0D
+}=0D
+=0D
+block_init(nfs_block_init);=0D
--=20
2.28.0.windows.1


