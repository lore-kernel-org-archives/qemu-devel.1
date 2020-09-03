Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF14C43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 08:29:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7382520767
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 08:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M8nig7ln"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7382520767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDkcO-0004y8-Vo
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 04:29:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kDkZo-0000y1-O1
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 04:26:36 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54653
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kDkZk-0000UP-8Z
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 04:26:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599121591;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=BvMPoL4hS3mNqmQuvpZBy0r4G59F0slnpb4Zx3S0OtE=;
 b=M8nig7lnXFbfc7w3VrNIebTLx3qj/l46iJKeOfa6FrMmOEeC8G565S8aanOw3ALJ8E84OF
 w+47WD1Yn7vJ59hoJpEOlADimLgg+7JEKgKK+re20tFOf34ERwCc2TAhfrBcj28naDYGOJ
 JAjgWowMksKmu93/19ZWuytby5J2RWY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-nKLApNC8M_6c-SvJVJPZ5g-1; Thu, 03 Sep 2020 04:26:26 -0400
X-MC-Unique: nKLApNC8M_6c-SvJVJPZ5g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6BFF281F00F;
 Thu,  3 Sep 2020 08:26:25 +0000 (UTC)
Received: from redhat.com (ovpn-114-170.ams2.redhat.com [10.36.114.170])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8939F78B40;
 Thu,  3 Sep 2020 08:26:23 +0000 (UTC)
Date: Thu, 3 Sep 2020 09:26:20 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Yonggang Luo <luoyonggang@gmail.com>
Subject: Re: [PATCH v3 06/12] block: Fixes nfs on msys2/mingw
Message-ID: <20200903082620.GD441291@redhat.com>
References: <20200903074313.1498-1-luoyonggang@gmail.com>
 <20200903074313.1498-7-luoyonggang@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200903074313.1498-7-luoyonggang@gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.004
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 04:23:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 03, 2020 at 03:43:07PM +0800, Yonggang Luo wrote:
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  block/nfs.c | 1812 ++++++++++++++++++++++++++-------------------------
>  1 file changed, 910 insertions(+), 902 deletions(-)

The diff for this file is totally messed up, adding/removing every
single line. I presume you've change line endings to DOS style,
so please revert that.

> 
> diff --git a/block/nfs.c b/block/nfs.c
> index 61a249a9fc..34b2cd5708 100644
> --- a/block/nfs.c
> +++ b/block/nfs.c
> @@ -1,902 +1,910 @@
> -/*
> - * QEMU Block driver for native access to files on NFS shares
> - *
> - * Copyright (c) 2014-2017 Peter Lieven <pl@kamp.de>
> - *
> - * Permission is hereby granted, free of charge, to any person obtaining a copy
> - * of this software and associated documentation files (the "Software"), to deal
> - * in the Software without restriction, including without limitation the rights
> - * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> - * copies of the Software, and to permit persons to whom the Software is
> - * furnished to do so, subject to the following conditions:
> - *
> - * The above copyright notice and this permission notice shall be included in
> - * all copies or substantial portions of the Software.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> - * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> - * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> - * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> - * THE SOFTWARE.
> - */
> -
> -#include "qemu/osdep.h"
> -
> -#include <poll.h>
> -#include "qemu/config-file.h"
> -#include "qemu/error-report.h"
> -#include "qapi/error.h"
> -#include "block/block_int.h"
> -#include "block/qdict.h"
> -#include "trace.h"
> -#include "qemu/iov.h"
> -#include "qemu/main-loop.h"
> -#include "qemu/module.h"
> -#include "qemu/option.h"
> -#include "qemu/uri.h"
> -#include "qemu/cutils.h"
> -#include "sysemu/sysemu.h"
> -#include "sysemu/replay.h"
> -#include "qapi/qapi-visit-block-core.h"
> -#include "qapi/qmp/qdict.h"
> -#include "qapi/qmp/qstring.h"
> -#include "qapi/qobject-input-visitor.h"
> -#include "qapi/qobject-output-visitor.h"
> -#include <nfsc/libnfs.h>
> -
> -
> -#define QEMU_NFS_MAX_READAHEAD_SIZE 1048576
> -#define QEMU_NFS_MAX_PAGECACHE_SIZE (8388608 / NFS_BLKSIZE)
> -#define QEMU_NFS_MAX_DEBUG_LEVEL 2
> -
> -typedef struct NFSClient {
> -    struct nfs_context *context;
> -    struct nfsfh *fh;
> -    int events;
> -    bool has_zero_init;
> -    AioContext *aio_context;
> -    QemuMutex mutex;
> -    blkcnt_t st_blocks;
> -    bool cache_used;
> -    NFSServer *server;
> -    char *path;
> -    int64_t uid, gid, tcp_syncnt, readahead, pagecache, debug;
> -} NFSClient;
> -
> -typedef struct NFSRPC {
> -    BlockDriverState *bs;
> -    int ret;
> -    int complete;
> -    QEMUIOVector *iov;
> -    struct stat *st;
> -    Coroutine *co;
> -    NFSClient *client;
> -} NFSRPC;
> -
> -static int nfs_parse_uri(const char *filename, QDict *options, Error **errp)
> -{
> -    URI *uri = NULL;
> -    QueryParams *qp = NULL;
> -    int ret = -EINVAL, i;
> -
> -    uri = uri_parse(filename);
> -    if (!uri) {
> -        error_setg(errp, "Invalid URI specified");
> -        goto out;
> -    }
> -    if (g_strcmp0(uri->scheme, "nfs") != 0) {
> -        error_setg(errp, "URI scheme must be 'nfs'");
> -        goto out;
> -    }
> -
> -    if (!uri->server) {
> -        error_setg(errp, "missing hostname in URI");
> -        goto out;
> -    }
> -
> -    if (!uri->path) {
> -        error_setg(errp, "missing file path in URI");
> -        goto out;
> -    }
> -
> -    qp = query_params_parse(uri->query);
> -    if (!qp) {
> -        error_setg(errp, "could not parse query parameters");
> -        goto out;
> -    }
> -
> -    qdict_put_str(options, "server.host", uri->server);
> -    qdict_put_str(options, "server.type", "inet");
> -    qdict_put_str(options, "path", uri->path);
> -
> -    for (i = 0; i < qp->n; i++) {
> -        unsigned long long val;
> -        if (!qp->p[i].value) {
> -            error_setg(errp, "Value for NFS parameter expected: %s",
> -                       qp->p[i].name);
> -            goto out;
> -        }
> -        if (parse_uint_full(qp->p[i].value, &val, 0)) {
> -            error_setg(errp, "Illegal value for NFS parameter: %s",
> -                       qp->p[i].name);
> -            goto out;
> -        }
> -        if (!strcmp(qp->p[i].name, "uid")) {
> -            qdict_put_str(options, "user", qp->p[i].value);
> -        } else if (!strcmp(qp->p[i].name, "gid")) {
> -            qdict_put_str(options, "group", qp->p[i].value);
> -        } else if (!strcmp(qp->p[i].name, "tcp-syncnt")) {
> -            qdict_put_str(options, "tcp-syn-count", qp->p[i].value);
> -        } else if (!strcmp(qp->p[i].name, "readahead")) {
> -            qdict_put_str(options, "readahead-size", qp->p[i].value);
> -        } else if (!strcmp(qp->p[i].name, "pagecache")) {
> -            qdict_put_str(options, "page-cache-size", qp->p[i].value);
> -        } else if (!strcmp(qp->p[i].name, "debug")) {
> -            qdict_put_str(options, "debug", qp->p[i].value);
> -        } else {
> -            error_setg(errp, "Unknown NFS parameter name: %s",
> -                       qp->p[i].name);
> -            goto out;
> -        }
> -    }
> -    ret = 0;
> -out:
> -    if (qp) {
> -        query_params_free(qp);
> -    }
> -    if (uri) {
> -        uri_free(uri);
> -    }
> -    return ret;
> -}
> -
> -static bool nfs_has_filename_options_conflict(QDict *options, Error **errp)
> -{
> -    const QDictEntry *qe;
> -
> -    for (qe = qdict_first(options); qe; qe = qdict_next(options, qe)) {
> -        if (!strcmp(qe->key, "host") ||
> -            !strcmp(qe->key, "path") ||
> -            !strcmp(qe->key, "user") ||
> -            !strcmp(qe->key, "group") ||
> -            !strcmp(qe->key, "tcp-syn-count") ||
> -            !strcmp(qe->key, "readahead-size") ||
> -            !strcmp(qe->key, "page-cache-size") ||
> -            !strcmp(qe->key, "debug") ||
> -            strstart(qe->key, "server.", NULL))
> -        {
> -            error_setg(errp, "Option %s cannot be used with a filename",
> -                       qe->key);
> -            return true;
> -        }
> -    }
> -
> -    return false;
> -}
> -
> -static void nfs_parse_filename(const char *filename, QDict *options,
> -                               Error **errp)
> -{
> -    if (nfs_has_filename_options_conflict(options, errp)) {
> -        return;
> -    }
> -
> -    nfs_parse_uri(filename, options, errp);
> -}
> -
> -static void nfs_process_read(void *arg);
> -static void nfs_process_write(void *arg);
> -
> -/* Called with QemuMutex held.  */
> -static void nfs_set_events(NFSClient *client)
> -{
> -    int ev = nfs_which_events(client->context);
> -    if (ev != client->events) {
> -        aio_set_fd_handler(client->aio_context, nfs_get_fd(client->context),
> -                           false,
> -                           (ev & POLLIN) ? nfs_process_read : NULL,
> -                           (ev & POLLOUT) ? nfs_process_write : NULL,
> -                           NULL, client);
> -
> -    }
> -    client->events = ev;
> -}
> -
> -static void nfs_process_read(void *arg)
> -{
> -    NFSClient *client = arg;
> -
> -    qemu_mutex_lock(&client->mutex);
> -    nfs_service(client->context, POLLIN);
> -    nfs_set_events(client);
> -    qemu_mutex_unlock(&client->mutex);
> -}
> -
> -static void nfs_process_write(void *arg)
> -{
> -    NFSClient *client = arg;
> -
> -    qemu_mutex_lock(&client->mutex);
> -    nfs_service(client->context, POLLOUT);
> -    nfs_set_events(client);
> -    qemu_mutex_unlock(&client->mutex);
> -}
> -
> -static void nfs_co_init_task(BlockDriverState *bs, NFSRPC *task)
> -{
> -    *task = (NFSRPC) {
> -        .co             = qemu_coroutine_self(),
> -        .bs             = bs,
> -        .client         = bs->opaque,
> -    };
> -}
> -
> -static void nfs_co_generic_bh_cb(void *opaque)
> -{
> -    NFSRPC *task = opaque;
> -
> -    task->complete = 1;
> -    aio_co_wake(task->co);
> -}
> -
> -/* Called (via nfs_service) with QemuMutex held.  */
> -static void
> -nfs_co_generic_cb(int ret, struct nfs_context *nfs, void *data,
> -                  void *private_data)
> -{
> -    NFSRPC *task = private_data;
> -    task->ret = ret;
> -    assert(!task->st);
> -    if (task->ret > 0 && task->iov) {
> -        if (task->ret <= task->iov->size) {
> -            qemu_iovec_from_buf(task->iov, 0, data, task->ret);
> -        } else {
> -            task->ret = -EIO;
> -        }
> -    }
> -    if (task->ret < 0) {
> -        error_report("NFS Error: %s", nfs_get_error(nfs));
> -    }
> -    replay_bh_schedule_oneshot_event(task->client->aio_context,
> -                                     nfs_co_generic_bh_cb, task);
> -}
> -
> -static int coroutine_fn nfs_co_preadv(BlockDriverState *bs, uint64_t offset,
> -                                      uint64_t bytes, QEMUIOVector *iov,
> -                                      int flags)
> -{
> -    NFSClient *client = bs->opaque;
> -    NFSRPC task;
> -
> -    nfs_co_init_task(bs, &task);
> -    task.iov = iov;
> -
> -    WITH_QEMU_LOCK_GUARD(&client->mutex) {
> -        if (nfs_pread_async(client->context, client->fh,
> -                            offset, bytes, nfs_co_generic_cb, &task) != 0) {
> -            return -ENOMEM;
> -        }
> -
> -        nfs_set_events(client);
> -    }
> -    while (!task.complete) {
> -        qemu_coroutine_yield();
> -    }
> -
> -    if (task.ret < 0) {
> -        return task.ret;
> -    }
> -
> -    /* zero pad short reads */
> -    if (task.ret < iov->size) {
> -        qemu_iovec_memset(iov, task.ret, 0, iov->size - task.ret);
> -    }
> -
> -    return 0;
> -}
> -
> -static int coroutine_fn nfs_co_pwritev(BlockDriverState *bs, uint64_t offset,
> -                                       uint64_t bytes, QEMUIOVector *iov,
> -                                       int flags)
> -{
> -    NFSClient *client = bs->opaque;
> -    NFSRPC task;
> -    char *buf = NULL;
> -    bool my_buffer = false;
> -
> -    nfs_co_init_task(bs, &task);
> -
> -    if (iov->niov != 1) {
> -        buf = g_try_malloc(bytes);
> -        if (bytes && buf == NULL) {
> -            return -ENOMEM;
> -        }
> -        qemu_iovec_to_buf(iov, 0, buf, bytes);
> -        my_buffer = true;
> -    } else {
> -        buf = iov->iov[0].iov_base;
> -    }
> -
> -    WITH_QEMU_LOCK_GUARD(&client->mutex) {
> -        if (nfs_pwrite_async(client->context, client->fh,
> -                             offset, bytes, buf,
> -                             nfs_co_generic_cb, &task) != 0) {
> -            if (my_buffer) {
> -                g_free(buf);
> -            }
> -            return -ENOMEM;
> -        }
> -
> -        nfs_set_events(client);
> -    }
> -    while (!task.complete) {
> -        qemu_coroutine_yield();
> -    }
> -
> -    if (my_buffer) {
> -        g_free(buf);
> -    }
> -
> -    if (task.ret != bytes) {
> -        return task.ret < 0 ? task.ret : -EIO;
> -    }
> -
> -    return 0;
> -}
> -
> -static int coroutine_fn nfs_co_flush(BlockDriverState *bs)
> -{
> -    NFSClient *client = bs->opaque;
> -    NFSRPC task;
> -
> -    nfs_co_init_task(bs, &task);
> -
> -    WITH_QEMU_LOCK_GUARD(&client->mutex) {
> -        if (nfs_fsync_async(client->context, client->fh, nfs_co_generic_cb,
> -                            &task) != 0) {
> -            return -ENOMEM;
> -        }
> -
> -        nfs_set_events(client);
> -    }
> -    while (!task.complete) {
> -        qemu_coroutine_yield();
> -    }
> -
> -    return task.ret;
> -}
> -
> -static void nfs_detach_aio_context(BlockDriverState *bs)
> -{
> -    NFSClient *client = bs->opaque;
> -
> -    aio_set_fd_handler(client->aio_context, nfs_get_fd(client->context),
> -                       false, NULL, NULL, NULL, NULL);
> -    client->events = 0;
> -}
> -
> -static void nfs_attach_aio_context(BlockDriverState *bs,
> -                                   AioContext *new_context)
> -{
> -    NFSClient *client = bs->opaque;
> -
> -    client->aio_context = new_context;
> -    nfs_set_events(client);
> -}
> -
> -static void nfs_client_close(NFSClient *client)
> -{
> -    if (client->context) {
> -        qemu_mutex_lock(&client->mutex);
> -        aio_set_fd_handler(client->aio_context, nfs_get_fd(client->context),
> -                           false, NULL, NULL, NULL, NULL);
> -        qemu_mutex_unlock(&client->mutex);
> -        if (client->fh) {
> -            nfs_close(client->context, client->fh);
> -            client->fh = NULL;
> -        }
> -#ifdef LIBNFS_FEATURE_UMOUNT
> -        nfs_umount(client->context);
> -#endif
> -        nfs_destroy_context(client->context);
> -        client->context = NULL;
> -    }
> -    g_free(client->path);
> -    qemu_mutex_destroy(&client->mutex);
> -    qapi_free_NFSServer(client->server);
> -    client->server = NULL;
> -}
> -
> -static void nfs_file_close(BlockDriverState *bs)
> -{
> -    NFSClient *client = bs->opaque;
> -    nfs_client_close(client);
> -}
> -
> -static int64_t nfs_client_open(NFSClient *client, BlockdevOptionsNfs *opts,
> -                               int flags, int open_flags, Error **errp)
> -{
> -    int64_t ret = -EINVAL;
> -    struct stat st;
> -    char *file = NULL, *strp = NULL;
> -
> -    qemu_mutex_init(&client->mutex);
> -
> -    client->path = g_strdup(opts->path);
> -
> -    strp = strrchr(client->path, '/');
> -    if (strp == NULL) {
> -        error_setg(errp, "Invalid URL specified");
> -        goto fail;
> -    }
> -    file = g_strdup(strp);
> -    *strp = 0;
> -
> -    /* Steal the NFSServer object from opts; set the original pointer to NULL
> -     * to avoid use after free and double free. */
> -    client->server = opts->server;
> -    opts->server = NULL;
> -
> -    client->context = nfs_init_context();
> -    if (client->context == NULL) {
> -        error_setg(errp, "Failed to init NFS context");
> -        goto fail;
> -    }
> -
> -    if (opts->has_user) {
> -        client->uid = opts->user;
> -        nfs_set_uid(client->context, client->uid);
> -    }
> -
> -    if (opts->has_group) {
> -        client->gid = opts->group;
> -        nfs_set_gid(client->context, client->gid);
> -    }
> -
> -    if (opts->has_tcp_syn_count) {
> -        client->tcp_syncnt = opts->tcp_syn_count;
> -        nfs_set_tcp_syncnt(client->context, client->tcp_syncnt);
> -    }
> -
> -#ifdef LIBNFS_FEATURE_READAHEAD
> -    if (opts->has_readahead_size) {
> -        if (open_flags & BDRV_O_NOCACHE) {
> -            error_setg(errp, "Cannot enable NFS readahead "
> -                             "if cache.direct = on");
> -            goto fail;
> -        }
> -        client->readahead = opts->readahead_size;
> -        if (client->readahead > QEMU_NFS_MAX_READAHEAD_SIZE) {
> -            warn_report("Truncating NFS readahead size to %d",
> -                        QEMU_NFS_MAX_READAHEAD_SIZE);
> -            client->readahead = QEMU_NFS_MAX_READAHEAD_SIZE;
> -        }
> -        nfs_set_readahead(client->context, client->readahead);
> -#ifdef LIBNFS_FEATURE_PAGECACHE
> -        nfs_set_pagecache_ttl(client->context, 0);
> -#endif
> -        client->cache_used = true;
> -    }
> -#endif
> -
> -#ifdef LIBNFS_FEATURE_PAGECACHE
> -    if (opts->has_page_cache_size) {
> -        if (open_flags & BDRV_O_NOCACHE) {
> -            error_setg(errp, "Cannot enable NFS pagecache "
> -                             "if cache.direct = on");
> -            goto fail;
> -        }
> -        client->pagecache = opts->page_cache_size;
> -        if (client->pagecache > QEMU_NFS_MAX_PAGECACHE_SIZE) {
> -            warn_report("Truncating NFS pagecache size to %d pages",
> -                        QEMU_NFS_MAX_PAGECACHE_SIZE);
> -            client->pagecache = QEMU_NFS_MAX_PAGECACHE_SIZE;
> -        }
> -        nfs_set_pagecache(client->context, client->pagecache);
> -        nfs_set_pagecache_ttl(client->context, 0);
> -        client->cache_used = true;
> -    }
> -#endif
> -
> -#ifdef LIBNFS_FEATURE_DEBUG
> -    if (opts->has_debug) {
> -        client->debug = opts->debug;
> -        /* limit the maximum debug level to avoid potential flooding
> -         * of our log files. */
> -        if (client->debug > QEMU_NFS_MAX_DEBUG_LEVEL) {
> -            warn_report("Limiting NFS debug level to %d",
> -                        QEMU_NFS_MAX_DEBUG_LEVEL);
> -            client->debug = QEMU_NFS_MAX_DEBUG_LEVEL;
> -        }
> -        nfs_set_debug(client->context, client->debug);
> -    }
> -#endif
> -
> -    ret = nfs_mount(client->context, client->server->host, client->path);
> -    if (ret < 0) {
> -        error_setg(errp, "Failed to mount nfs share: %s",
> -                   nfs_get_error(client->context));
> -        goto fail;
> -    }
> -
> -    if (flags & O_CREAT) {
> -        ret = nfs_creat(client->context, file, 0600, &client->fh);
> -        if (ret < 0) {
> -            error_setg(errp, "Failed to create file: %s",
> -                       nfs_get_error(client->context));
> -            goto fail;
> -        }
> -    } else {
> -        ret = nfs_open(client->context, file, flags, &client->fh);
> -        if (ret < 0) {
> -            error_setg(errp, "Failed to open file : %s",
> -                       nfs_get_error(client->context));
> -            goto fail;
> -        }
> -    }
> -
> -    ret = nfs_fstat(client->context, client->fh, &st);
> -    if (ret < 0) {
> -        error_setg(errp, "Failed to fstat file: %s",
> -                   nfs_get_error(client->context));
> -        goto fail;
> -    }
> -
> -    ret = DIV_ROUND_UP(st.st_size, BDRV_SECTOR_SIZE);
> -    client->st_blocks = st.st_blocks;
> -    client->has_zero_init = S_ISREG(st.st_mode);
> -    *strp = '/';
> -    goto out;
> -
> -fail:
> -    nfs_client_close(client);
> -out:
> -    g_free(file);
> -    return ret;
> -}
> -
> -static BlockdevOptionsNfs *nfs_options_qdict_to_qapi(QDict *options,
> -                                                     Error **errp)
> -{
> -    BlockdevOptionsNfs *opts = NULL;
> -    Visitor *v;
> -    const QDictEntry *e;
> -
> -    v = qobject_input_visitor_new_flat_confused(options, errp);
> -    if (!v) {
> -        return NULL;
> -    }
> -
> -    visit_type_BlockdevOptionsNfs(v, NULL, &opts, errp);
> -    visit_free(v);
> -    if (!opts) {
> -        return NULL;
> -    }
> -
> -    /* Remove the processed options from the QDict (the visitor processes
> -     * _all_ options in the QDict) */
> -    while ((e = qdict_first(options))) {
> -        qdict_del(options, e->key);
> -    }
> -
> -    return opts;
> -}
> -
> -static int64_t nfs_client_open_qdict(NFSClient *client, QDict *options,
> -                                     int flags, int open_flags, Error **errp)
> -{
> -    BlockdevOptionsNfs *opts;
> -    int ret;
> -
> -    opts = nfs_options_qdict_to_qapi(options, errp);
> -    if (opts == NULL) {
> -        ret = -EINVAL;
> -        goto fail;
> -    }
> -
> -    ret = nfs_client_open(client, opts, flags, open_flags, errp);
> -fail:
> -    qapi_free_BlockdevOptionsNfs(opts);
> -    return ret;
> -}
> -
> -static int nfs_file_open(BlockDriverState *bs, QDict *options, int flags,
> -                         Error **errp) {
> -    NFSClient *client = bs->opaque;
> -    int64_t ret;
> -
> -    client->aio_context = bdrv_get_aio_context(bs);
> -
> -    ret = nfs_client_open_qdict(client, options,
> -                                (flags & BDRV_O_RDWR) ? O_RDWR : O_RDONLY,
> -                                bs->open_flags, errp);
> -    if (ret < 0) {
> -        return ret;
> -    }
> -
> -    bs->total_sectors = ret;
> -    if (client->has_zero_init) {
> -        bs->supported_truncate_flags = BDRV_REQ_ZERO_WRITE;
> -    }
> -    return 0;
> -}
> -
> -static QemuOptsList nfs_create_opts = {
> -    .name = "nfs-create-opts",
> -    .head = QTAILQ_HEAD_INITIALIZER(nfs_create_opts.head),
> -    .desc = {
> -        {
> -            .name = BLOCK_OPT_SIZE,
> -            .type = QEMU_OPT_SIZE,
> -            .help = "Virtual disk size"
> -        },
> -        { /* end of list */ }
> -    }
> -};
> -
> -static int nfs_file_co_create(BlockdevCreateOptions *options, Error **errp)
> -{
> -    BlockdevCreateOptionsNfs *opts = &options->u.nfs;
> -    NFSClient *client = g_new0(NFSClient, 1);
> -    int ret;
> -
> -    assert(options->driver == BLOCKDEV_DRIVER_NFS);
> -
> -    client->aio_context = qemu_get_aio_context();
> -
> -    ret = nfs_client_open(client, opts->location, O_CREAT, 0, errp);
> -    if (ret < 0) {
> -        goto out;
> -    }
> -    ret = nfs_ftruncate(client->context, client->fh, opts->size);
> -    nfs_client_close(client);
> -
> -out:
> -    g_free(client);
> -    return ret;
> -}
> -
> -static int coroutine_fn nfs_file_co_create_opts(BlockDriver *drv,
> -                                                const char *url,
> -                                                QemuOpts *opts,
> -                                                Error **errp)
> -{
> -    BlockdevCreateOptions *create_options;
> -    BlockdevCreateOptionsNfs *nfs_opts;
> -    QDict *options;
> -    int ret;
> -
> -    create_options = g_new0(BlockdevCreateOptions, 1);
> -    create_options->driver = BLOCKDEV_DRIVER_NFS;
> -    nfs_opts = &create_options->u.nfs;
> -
> -    /* Read out options */
> -    nfs_opts->size = ROUND_UP(qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0),
> -                              BDRV_SECTOR_SIZE);
> -
> -    options = qdict_new();
> -    ret = nfs_parse_uri(url, options, errp);
> -    if (ret < 0) {
> -        goto out;
> -    }
> -
> -    nfs_opts->location = nfs_options_qdict_to_qapi(options, errp);
> -    if (nfs_opts->location == NULL) {
> -        ret = -EINVAL;
> -        goto out;
> -    }
> -
> -    ret = nfs_file_co_create(create_options, errp);
> -    if (ret < 0) {
> -        goto out;
> -    }
> -
> -    ret = 0;
> -out:
> -    qobject_unref(options);
> -    qapi_free_BlockdevCreateOptions(create_options);
> -    return ret;
> -}
> -
> -static int nfs_has_zero_init(BlockDriverState *bs)
> -{
> -    NFSClient *client = bs->opaque;
> -    return client->has_zero_init;
> -}
> -
> -/* Called (via nfs_service) with QemuMutex held.  */
> -static void
> -nfs_get_allocated_file_size_cb(int ret, struct nfs_context *nfs, void *data,
> -                               void *private_data)
> -{
> -    NFSRPC *task = private_data;
> -    task->ret = ret;
> -    if (task->ret == 0) {
> -        memcpy(task->st, data, sizeof(struct stat));
> -    }
> -    if (task->ret < 0) {
> -        error_report("NFS Error: %s", nfs_get_error(nfs));
> -    }
> -
> -    /* Set task->complete before reading bs->wakeup.  */
> -    atomic_mb_set(&task->complete, 1);
> -    bdrv_wakeup(task->bs);
> -}
> -
> -static int64_t nfs_get_allocated_file_size(BlockDriverState *bs)
> -{
> -    NFSClient *client = bs->opaque;
> -    NFSRPC task = {0};
> -    struct stat st;
> -
> -    if (bdrv_is_read_only(bs) &&
> -        !(bs->open_flags & BDRV_O_NOCACHE)) {
> -        return client->st_blocks * 512;
> -    }
> -
> -    task.bs = bs;
> -    task.st = &st;
> -    if (nfs_fstat_async(client->context, client->fh, nfs_get_allocated_file_size_cb,
> -                        &task) != 0) {
> -        return -ENOMEM;
> -    }
> -
> -    nfs_set_events(client);
> -    BDRV_POLL_WHILE(bs, !task.complete);
> -
> -    return (task.ret < 0 ? task.ret : st.st_blocks * 512);
> -}
> -
> -static int coroutine_fn
> -nfs_file_co_truncate(BlockDriverState *bs, int64_t offset, bool exact,
> -                     PreallocMode prealloc, BdrvRequestFlags flags,
> -                     Error **errp)
> -{
> -    NFSClient *client = bs->opaque;
> -    int ret;
> -
> -    if (prealloc != PREALLOC_MODE_OFF) {
> -        error_setg(errp, "Unsupported preallocation mode '%s'",
> -                   PreallocMode_str(prealloc));
> -        return -ENOTSUP;
> -    }
> -
> -    ret = nfs_ftruncate(client->context, client->fh, offset);
> -    if (ret < 0) {
> -        error_setg_errno(errp, -ret, "Failed to truncate file");
> -        return ret;
> -    }
> -
> -    return 0;
> -}
> -
> -/* Note that this will not re-establish a connection with the NFS server
> - * - it is effectively a NOP.  */
> -static int nfs_reopen_prepare(BDRVReopenState *state,
> -                              BlockReopenQueue *queue, Error **errp)
> -{
> -    NFSClient *client = state->bs->opaque;
> -    struct stat st;
> -    int ret = 0;
> -
> -    if (state->flags & BDRV_O_RDWR && bdrv_is_read_only(state->bs)) {
> -        error_setg(errp, "Cannot open a read-only mount as read-write");
> -        return -EACCES;
> -    }
> -
> -    if ((state->flags & BDRV_O_NOCACHE) && client->cache_used) {
> -        error_setg(errp, "Cannot disable cache if libnfs readahead or"
> -                         " pagecache is enabled");
> -        return -EINVAL;
> -    }
> -
> -    /* Update cache for read-only reopens */
> -    if (!(state->flags & BDRV_O_RDWR)) {
> -        ret = nfs_fstat(client->context, client->fh, &st);
> -        if (ret < 0) {
> -            error_setg(errp, "Failed to fstat file: %s",
> -                       nfs_get_error(client->context));
> -            return ret;
> -        }
> -        client->st_blocks = st.st_blocks;
> -    }
> -
> -    return 0;
> -}
> -
> -static void nfs_refresh_filename(BlockDriverState *bs)
> -{
> -    NFSClient *client = bs->opaque;
> -
> -    if (client->uid && !client->gid) {
> -        snprintf(bs->exact_filename, sizeof(bs->exact_filename),
> -                 "nfs://%s%s?uid=%" PRId64, client->server->host, client->path,
> -                 client->uid);
> -    } else if (!client->uid && client->gid) {
> -        snprintf(bs->exact_filename, sizeof(bs->exact_filename),
> -                 "nfs://%s%s?gid=%" PRId64, client->server->host, client->path,
> -                 client->gid);
> -    } else if (client->uid && client->gid) {
> -        snprintf(bs->exact_filename, sizeof(bs->exact_filename),
> -                 "nfs://%s%s?uid=%" PRId64 "&gid=%" PRId64,
> -                 client->server->host, client->path, client->uid, client->gid);
> -    } else {
> -        snprintf(bs->exact_filename, sizeof(bs->exact_filename),
> -                 "nfs://%s%s", client->server->host, client->path);
> -    }
> -}
> -
> -static char *nfs_dirname(BlockDriverState *bs, Error **errp)
> -{
> -    NFSClient *client = bs->opaque;
> -
> -    if (client->uid || client->gid) {
> -        bdrv_refresh_filename(bs);
> -        error_setg(errp, "Cannot generate a base directory for NFS node '%s'",
> -                   bs->filename);
> -        return NULL;
> -    }
> -
> -    return g_strdup_printf("nfs://%s%s/", client->server->host, client->path);
> -}
> -
> -#ifdef LIBNFS_FEATURE_PAGECACHE
> -static void coroutine_fn nfs_co_invalidate_cache(BlockDriverState *bs,
> -                                                 Error **errp)
> -{
> -    NFSClient *client = bs->opaque;
> -    nfs_pagecache_invalidate(client->context, client->fh);
> -}
> -#endif
> -
> -static const char *nfs_strong_runtime_opts[] = {
> -    "path",
> -    "user",
> -    "group",
> -    "server.",
> -
> -    NULL
> -};
> -
> -static BlockDriver bdrv_nfs = {
> -    .format_name                    = "nfs",
> -    .protocol_name                  = "nfs",
> -
> -    .instance_size                  = sizeof(NFSClient),
> -    .bdrv_parse_filename            = nfs_parse_filename,
> -    .create_opts                    = &nfs_create_opts,
> -
> -    .bdrv_has_zero_init             = nfs_has_zero_init,
> -    .bdrv_get_allocated_file_size   = nfs_get_allocated_file_size,
> -    .bdrv_co_truncate               = nfs_file_co_truncate,
> -
> -    .bdrv_file_open                 = nfs_file_open,
> -    .bdrv_close                     = nfs_file_close,
> -    .bdrv_co_create                 = nfs_file_co_create,
> -    .bdrv_co_create_opts            = nfs_file_co_create_opts,
> -    .bdrv_reopen_prepare            = nfs_reopen_prepare,
> -
> -    .bdrv_co_preadv                 = nfs_co_preadv,
> -    .bdrv_co_pwritev                = nfs_co_pwritev,
> -    .bdrv_co_flush_to_disk          = nfs_co_flush,
> -
> -    .bdrv_detach_aio_context        = nfs_detach_aio_context,
> -    .bdrv_attach_aio_context        = nfs_attach_aio_context,
> -    .bdrv_refresh_filename          = nfs_refresh_filename,
> -    .bdrv_dirname                   = nfs_dirname,
> -
> -    .strong_runtime_opts            = nfs_strong_runtime_opts,
> -
> -#ifdef LIBNFS_FEATURE_PAGECACHE
> -    .bdrv_co_invalidate_cache       = nfs_co_invalidate_cache,
> -#endif
> -};
> -
> -static void nfs_block_init(void)
> -{
> -    bdrv_register(&bdrv_nfs);
> -}
> -
> -block_init(nfs_block_init);
> +/*
> + * QEMU Block driver for native access to files on NFS shares
> + *
> + * Copyright (c) 2014-2017 Peter Lieven <pl@kamp.de>
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#if !defined(_WIN32)
> +#include <poll.h>
> +#endif
> +#include "qemu/config-file.h"
> +#include "qemu/error-report.h"
> +#include "qapi/error.h"
> +#include "block/block_int.h"
> +#include "block/qdict.h"
> +#include "trace.h"
> +#include "qemu/iov.h"
> +#include "qemu/main-loop.h"
> +#include "qemu/module.h"
> +#include "qemu/option.h"
> +#include "qemu/uri.h"
> +#include "qemu/cutils.h"
> +#include "sysemu/sysemu.h"
> +#include "sysemu/replay.h"
> +#include "qapi/qapi-visit-block-core.h"
> +#include "qapi/qmp/qdict.h"
> +#include "qapi/qmp/qstring.h"
> +#include "qapi/qobject-input-visitor.h"
> +#include "qapi/qobject-output-visitor.h"
> +#include <nfsc/libnfs.h>
> +
> +
> +#define QEMU_NFS_MAX_READAHEAD_SIZE 1048576
> +#define QEMU_NFS_MAX_PAGECACHE_SIZE (8388608 / NFS_BLKSIZE)
> +#define QEMU_NFS_MAX_DEBUG_LEVEL 2
> +
> +#if defined (_WIN32)
> +#define nfs_stat __stat64
> +#else
> +#define nfs_stat stat
> +#endif
> +
> +typedef struct NFSClient {
> +    struct nfs_context *context;
> +    struct nfsfh *fh;
> +    int events;
> +    bool has_zero_init;
> +    AioContext *aio_context;
> +    QemuMutex mutex;
> +    int64_t st_size;
> +    bool cache_used;
> +    NFSServer *server;
> +    char *path;
> +    int64_t uid, gid, tcp_syncnt, readahead, pagecache, debug;
> +} NFSClient;
> +
> +typedef struct NFSRPC {
> +    BlockDriverState *bs;
> +    int ret;
> +    int complete;
> +    QEMUIOVector *iov;
> +    struct nfs_stat *st;
> +    Coroutine *co;
> +    NFSClient *client;
> +} NFSRPC;
> +
> +static int nfs_parse_uri(const char *filename, QDict *options, Error **errp)
> +{
> +    URI *uri = NULL;
> +    QueryParams *qp = NULL;
> +    int ret = -EINVAL, i;
> +
> +    uri = uri_parse(filename);
> +    if (!uri) {
> +        error_setg(errp, "Invalid URI specified");
> +        goto out;
> +    }
> +    if (g_strcmp0(uri->scheme, "nfs") != 0) {
> +        error_setg(errp, "URI scheme must be 'nfs'");
> +        goto out;
> +    }
> +
> +    if (!uri->server) {
> +        error_setg(errp, "missing hostname in URI");
> +        goto out;
> +    }
> +
> +    if (!uri->path) {
> +        error_setg(errp, "missing file path in URI");
> +        goto out;
> +    }
> +
> +    qp = query_params_parse(uri->query);
> +    if (!qp) {
> +        error_setg(errp, "could not parse query parameters");
> +        goto out;
> +    }
> +
> +    qdict_put_str(options, "server.host", uri->server);
> +    qdict_put_str(options, "server.type", "inet");
> +    qdict_put_str(options, "path", uri->path);
> +
> +    for (i = 0; i < qp->n; i++) {
> +        unsigned long long val;
> +        if (!qp->p[i].value) {
> +            error_setg(errp, "Value for NFS parameter expected: %s",
> +                       qp->p[i].name);
> +            goto out;
> +        }
> +        if (parse_uint_full(qp->p[i].value, &val, 0)) {
> +            error_setg(errp, "Illegal value for NFS parameter: %s",
> +                       qp->p[i].name);
> +            goto out;
> +        }
> +        if (!strcmp(qp->p[i].name, "uid")) {
> +            qdict_put_str(options, "user", qp->p[i].value);
> +        } else if (!strcmp(qp->p[i].name, "gid")) {
> +            qdict_put_str(options, "group", qp->p[i].value);
> +        } else if (!strcmp(qp->p[i].name, "tcp-syncnt")) {
> +            qdict_put_str(options, "tcp-syn-count", qp->p[i].value);
> +        } else if (!strcmp(qp->p[i].name, "readahead")) {
> +            qdict_put_str(options, "readahead-size", qp->p[i].value);
> +        } else if (!strcmp(qp->p[i].name, "pagecache")) {
> +            qdict_put_str(options, "page-cache-size", qp->p[i].value);
> +        } else if (!strcmp(qp->p[i].name, "debug")) {
> +            qdict_put_str(options, "debug", qp->p[i].value);
> +        } else {
> +            error_setg(errp, "Unknown NFS parameter name: %s",
> +                       qp->p[i].name);
> +            goto out;
> +        }
> +    }
> +    ret = 0;
> +out:
> +    if (qp) {
> +        query_params_free(qp);
> +    }
> +    if (uri) {
> +        uri_free(uri);
> +    }
> +    return ret;
> +}
> +
> +static bool nfs_has_filename_options_conflict(QDict *options, Error **errp)
> +{
> +    const QDictEntry *qe;
> +
> +    for (qe = qdict_first(options); qe; qe = qdict_next(options, qe)) {
> +        if (!strcmp(qe->key, "host") ||
> +            !strcmp(qe->key, "path") ||
> +            !strcmp(qe->key, "user") ||
> +            !strcmp(qe->key, "group") ||
> +            !strcmp(qe->key, "tcp-syn-count") ||
> +            !strcmp(qe->key, "readahead-size") ||
> +            !strcmp(qe->key, "page-cache-size") ||
> +            !strcmp(qe->key, "debug") ||
> +            strstart(qe->key, "server.", NULL))
> +        {
> +            error_setg(errp, "Option %s cannot be used with a filename",
> +                       qe->key);
> +            return true;
> +        }
> +    }
> +
> +    return false;
> +}
> +
> +static void nfs_parse_filename(const char *filename, QDict *options,
> +                               Error **errp)
> +{
> +    if (nfs_has_filename_options_conflict(options, errp)) {
> +        return;
> +    }
> +
> +    nfs_parse_uri(filename, options, errp);
> +}
> +
> +static void nfs_process_read(void *arg);
> +static void nfs_process_write(void *arg);
> +
> +/* Called with QemuMutex held.  */
> +static void nfs_set_events(NFSClient *client)
> +{
> +    int ev = nfs_which_events(client->context);
> +    if (ev != client->events) {
> +        aio_set_fd_handler(client->aio_context, nfs_get_fd(client->context),
> +                           false,
> +                           (ev & POLLIN) ? nfs_process_read : NULL,
> +                           (ev & POLLOUT) ? nfs_process_write : NULL,
> +                           NULL, client);
> +
> +    }
> +    client->events = ev;
> +}
> +
> +static void nfs_process_read(void *arg)
> +{
> +    NFSClient *client = arg;
> +
> +    qemu_mutex_lock(&client->mutex);
> +    nfs_service(client->context, POLLIN);
> +    nfs_set_events(client);
> +    qemu_mutex_unlock(&client->mutex);
> +}
> +
> +static void nfs_process_write(void *arg)
> +{
> +    NFSClient *client = arg;
> +
> +    qemu_mutex_lock(&client->mutex);
> +    nfs_service(client->context, POLLOUT);
> +    nfs_set_events(client);
> +    qemu_mutex_unlock(&client->mutex);
> +}
> +
> +static void nfs_co_init_task(BlockDriverState *bs, NFSRPC *task)
> +{
> +    *task = (NFSRPC) {
> +        .co             = qemu_coroutine_self(),
> +        .bs             = bs,
> +        .client         = bs->opaque,
> +    };
> +}
> +
> +static void nfs_co_generic_bh_cb(void *opaque)
> +{
> +    NFSRPC *task = opaque;
> +
> +    task->complete = 1;
> +    aio_co_wake(task->co);
> +}
> +
> +/* Called (via nfs_service) with QemuMutex held.  */
> +static void
> +nfs_co_generic_cb(int ret, struct nfs_context *nfs, void *data,
> +                  void *private_data)
> +{
> +    NFSRPC *task = private_data;
> +    task->ret = ret;
> +    assert(!task->st);
> +    if (task->ret > 0 && task->iov) {
> +        if (task->ret <= task->iov->size) {
> +            qemu_iovec_from_buf(task->iov, 0, data, task->ret);
> +        } else {
> +            task->ret = -EIO;
> +        }
> +    }
> +    if (task->ret < 0) {
> +        error_report("NFS Error: %s", nfs_get_error(nfs));
> +    }
> +    replay_bh_schedule_oneshot_event(task->client->aio_context,
> +                                     nfs_co_generic_bh_cb, task);
> +}
> +
> +static int coroutine_fn nfs_co_preadv(BlockDriverState *bs, uint64_t offset,
> +                                      uint64_t bytes, QEMUIOVector *iov,
> +                                      int flags)
> +{
> +    NFSClient *client = bs->opaque;
> +    NFSRPC task;
> +
> +    nfs_co_init_task(bs, &task);
> +    task.iov = iov;
> +
> +    WITH_QEMU_LOCK_GUARD(&client->mutex) {
> +        if (nfs_pread_async(client->context, client->fh,
> +                            offset, bytes, nfs_co_generic_cb, &task) != 0) {
> +            return -ENOMEM;
> +        }
> +
> +        nfs_set_events(client);
> +    }
> +    while (!task.complete) {
> +        qemu_coroutine_yield();
> +    }
> +
> +    if (task.ret < 0) {
> +        return task.ret;
> +    }
> +
> +    /* zero pad short reads */
> +    if (task.ret < iov->size) {
> +        qemu_iovec_memset(iov, task.ret, 0, iov->size - task.ret);
> +    }
> +
> +    return 0;
> +}
> +
> +static int coroutine_fn nfs_co_pwritev(BlockDriverState *bs, uint64_t offset,
> +                                       uint64_t bytes, QEMUIOVector *iov,
> +                                       int flags)
> +{
> +    NFSClient *client = bs->opaque;
> +    NFSRPC task;
> +    char *buf = NULL;
> +    bool my_buffer = false;
> +
> +    nfs_co_init_task(bs, &task);
> +
> +    if (iov->niov != 1) {
> +        buf = g_try_malloc(bytes);
> +        if (bytes && buf == NULL) {
> +            return -ENOMEM;
> +        }
> +        qemu_iovec_to_buf(iov, 0, buf, bytes);
> +        my_buffer = true;
> +    } else {
> +        buf = iov->iov[0].iov_base;
> +    }
> +
> +    WITH_QEMU_LOCK_GUARD(&client->mutex) {
> +        if (nfs_pwrite_async(client->context, client->fh,
> +                             offset, bytes, buf,
> +                             nfs_co_generic_cb, &task) != 0) {
> +            if (my_buffer) {
> +                g_free(buf);
> +            }
> +            return -ENOMEM;
> +        }
> +
> +        nfs_set_events(client);
> +    }
> +    while (!task.complete) {
> +        qemu_coroutine_yield();
> +    }
> +
> +    if (my_buffer) {
> +        g_free(buf);
> +    }
> +
> +    if (task.ret != bytes) {
> +        return task.ret < 0 ? task.ret : -EIO;
> +    }
> +
> +    return 0;
> +}
> +
> +static int coroutine_fn nfs_co_flush(BlockDriverState *bs)
> +{
> +    NFSClient *client = bs->opaque;
> +    NFSRPC task;
> +
> +    nfs_co_init_task(bs, &task);
> +
> +    WITH_QEMU_LOCK_GUARD(&client->mutex) {
> +        if (nfs_fsync_async(client->context, client->fh, nfs_co_generic_cb,
> +                            &task) != 0) {
> +            return -ENOMEM;
> +        }
> +
> +        nfs_set_events(client);
> +    }
> +    while (!task.complete) {
> +        qemu_coroutine_yield();
> +    }
> +
> +    return task.ret;
> +}
> +
> +static void nfs_detach_aio_context(BlockDriverState *bs)
> +{
> +    NFSClient *client = bs->opaque;
> +
> +    aio_set_fd_handler(client->aio_context, nfs_get_fd(client->context),
> +                       false, NULL, NULL, NULL, NULL);
> +    client->events = 0;
> +}
> +
> +static void nfs_attach_aio_context(BlockDriverState *bs,
> +                                   AioContext *new_context)
> +{
> +    NFSClient *client = bs->opaque;
> +
> +    client->aio_context = new_context;
> +    nfs_set_events(client);
> +}
> +
> +static void nfs_client_close(NFSClient *client)
> +{
> +    if (client->context) {
> +        qemu_mutex_lock(&client->mutex);
> +        aio_set_fd_handler(client->aio_context, nfs_get_fd(client->context),
> +                           false, NULL, NULL, NULL, NULL);
> +        qemu_mutex_unlock(&client->mutex);
> +        if (client->fh) {
> +            nfs_close(client->context, client->fh);
> +            client->fh = NULL;
> +        }
> +#ifdef LIBNFS_FEATURE_UMOUNT
> +        nfs_umount(client->context);
> +#endif
> +        nfs_destroy_context(client->context);
> +        client->context = NULL;
> +    }
> +    g_free(client->path);
> +    qemu_mutex_destroy(&client->mutex);
> +    qapi_free_NFSServer(client->server);
> +    client->server = NULL;
> +}
> +
> +static void nfs_file_close(BlockDriverState *bs)
> +{
> +    NFSClient *client = bs->opaque;
> +    nfs_client_close(client);
> +}
> +
> +static int64_t nfs_client_open(NFSClient *client, BlockdevOptionsNfs *opts,
> +                               int flags, int open_flags, Error **errp)
> +{
> +    int64_t ret = -EINVAL;
> +    struct nfs_stat st;
> +    char *file = NULL, *strp = NULL;
> +
> +    qemu_mutex_init(&client->mutex);
> +
> +    client->path = g_strdup(opts->path);
> +
> +    strp = strrchr(client->path, '/');
> +    if (strp == NULL) {
> +        error_setg(errp, "Invalid URL specified");
> +        goto fail;
> +    }
> +    file = g_strdup(strp);
> +    *strp = 0;
> +
> +    /* Steal the NFSServer object from opts; set the original pointer to NULL
> +     * to avoid use after free and double free. */
> +    client->server = opts->server;
> +    opts->server = NULL;
> +
> +    client->context = nfs_init_context();
> +    if (client->context == NULL) {
> +        error_setg(errp, "Failed to init NFS context");
> +        goto fail;
> +    }
> +
> +    if (opts->has_user) {
> +        client->uid = opts->user;
> +        nfs_set_uid(client->context, client->uid);
> +    }
> +
> +    if (opts->has_group) {
> +        client->gid = opts->group;
> +        nfs_set_gid(client->context, client->gid);
> +    }
> +
> +    if (opts->has_tcp_syn_count) {
> +        client->tcp_syncnt = opts->tcp_syn_count;
> +        nfs_set_tcp_syncnt(client->context, client->tcp_syncnt);
> +    }
> +
> +#ifdef LIBNFS_FEATURE_READAHEAD
> +    if (opts->has_readahead_size) {
> +        if (open_flags & BDRV_O_NOCACHE) {
> +            error_setg(errp, "Cannot enable NFS readahead "
> +                             "if cache.direct = on");
> +            goto fail;
> +        }
> +        client->readahead = opts->readahead_size;
> +        if (client->readahead > QEMU_NFS_MAX_READAHEAD_SIZE) {
> +            warn_report("Truncating NFS readahead size to %d",
> +                        QEMU_NFS_MAX_READAHEAD_SIZE);
> +            client->readahead = QEMU_NFS_MAX_READAHEAD_SIZE;
> +        }
> +        nfs_set_readahead(client->context, client->readahead);
> +#ifdef LIBNFS_FEATURE_PAGECACHE
> +        nfs_set_pagecache_ttl(client->context, 0);
> +#endif
> +        client->cache_used = true;
> +    }
> +#endif
> +
> +#ifdef LIBNFS_FEATURE_PAGECACHE
> +    if (opts->has_page_cache_size) {
> +        if (open_flags & BDRV_O_NOCACHE) {
> +            error_setg(errp, "Cannot enable NFS pagecache "
> +                             "if cache.direct = on");
> +            goto fail;
> +        }
> +        client->pagecache = opts->page_cache_size;
> +        if (client->pagecache > QEMU_NFS_MAX_PAGECACHE_SIZE) {
> +            warn_report("Truncating NFS pagecache size to %d pages",
> +                        QEMU_NFS_MAX_PAGECACHE_SIZE);
> +            client->pagecache = QEMU_NFS_MAX_PAGECACHE_SIZE;
> +        }
> +        nfs_set_pagecache(client->context, client->pagecache);
> +        nfs_set_pagecache_ttl(client->context, 0);
> +        client->cache_used = true;
> +    }
> +#endif
> +
> +#ifdef LIBNFS_FEATURE_DEBUG
> +    if (opts->has_debug) {
> +        client->debug = opts->debug;
> +        /* limit the maximum debug level to avoid potential flooding
> +         * of our log files. */
> +        if (client->debug > QEMU_NFS_MAX_DEBUG_LEVEL) {
> +            warn_report("Limiting NFS debug level to %d",
> +                        QEMU_NFS_MAX_DEBUG_LEVEL);
> +            client->debug = QEMU_NFS_MAX_DEBUG_LEVEL;
> +        }
> +        nfs_set_debug(client->context, client->debug);
> +    }
> +#endif
> +
> +    ret = nfs_mount(client->context, client->server->host, client->path);
> +    if (ret < 0) {
> +        error_setg(errp, "Failed to mount nfs share: %s",
> +                   nfs_get_error(client->context));
> +        goto fail;
> +    }
> +
> +    if (flags & O_CREAT) {
> +        ret = nfs_creat(client->context, file, 0600, &client->fh);
> +        if (ret < 0) {
> +            error_setg(errp, "Failed to create file: %s",
> +                       nfs_get_error(client->context));
> +            goto fail;
> +        }
> +    } else {
> +        ret = nfs_open(client->context, file, flags, &client->fh);
> +        if (ret < 0) {
> +            error_setg(errp, "Failed to open file : %s",
> +                       nfs_get_error(client->context));
> +            goto fail;
> +        }
> +    }
> +
> +    ret = nfs_fstat(client->context, client->fh, &st);
> +    if (ret < 0) {
> +        error_setg(errp, "Failed to fstat file: %s",
> +                   nfs_get_error(client->context));
> +        goto fail;
> +    }
> +
> +    ret = DIV_ROUND_UP(st.st_size, BDRV_SECTOR_SIZE);
> +    client->st_size = st.st_size;
> +    client->has_zero_init = S_ISREG(st.st_mode);
> +    *strp = '/';
> +    goto out;
> +
> +fail:
> +    nfs_client_close(client);
> +out:
> +    g_free(file);
> +    return ret;
> +}
> +
> +static BlockdevOptionsNfs *nfs_options_qdict_to_qapi(QDict *options,
> +                                                     Error **errp)
> +{
> +    BlockdevOptionsNfs *opts = NULL;
> +    Visitor *v;
> +    const QDictEntry *e;
> +
> +    v = qobject_input_visitor_new_flat_confused(options, errp);
> +    if (!v) {
> +        return NULL;
> +    }
> +
> +    visit_type_BlockdevOptionsNfs(v, NULL, &opts, errp);
> +    visit_free(v);
> +    if (!opts) {
> +        return NULL;
> +    }
> +
> +    /* Remove the processed options from the QDict (the visitor processes
> +     * _all_ options in the QDict) */
> +    while ((e = qdict_first(options))) {
> +        qdict_del(options, e->key);
> +    }
> +
> +    return opts;
> +}
> +
> +static int64_t nfs_client_open_qdict(NFSClient *client, QDict *options,
> +                                     int flags, int open_flags, Error **errp)
> +{
> +    BlockdevOptionsNfs *opts;
> +    int ret;
> +
> +    opts = nfs_options_qdict_to_qapi(options, errp);
> +    if (opts == NULL) {
> +        ret = -EINVAL;
> +        goto fail;
> +    }
> +
> +    ret = nfs_client_open(client, opts, flags, open_flags, errp);
> +fail:
> +    qapi_free_BlockdevOptionsNfs(opts);
> +    return ret;
> +}
> +
> +static int nfs_file_open(BlockDriverState *bs, QDict *options, int flags,
> +                         Error **errp) {
> +    NFSClient *client = bs->opaque;
> +    int64_t ret;
> +
> +    client->aio_context = bdrv_get_aio_context(bs);
> +
> +    ret = nfs_client_open_qdict(client, options,
> +                                (flags & BDRV_O_RDWR) ? O_RDWR : O_RDONLY,
> +                                bs->open_flags, errp);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    bs->total_sectors = ret;
> +    if (client->has_zero_init) {
> +        bs->supported_truncate_flags = BDRV_REQ_ZERO_WRITE;
> +    }
> +    return 0;
> +}
> +
> +static QemuOptsList nfs_create_opts = {
> +    .name = "nfs-create-opts",
> +    .head = QTAILQ_HEAD_INITIALIZER(nfs_create_opts.head),
> +    .desc = {
> +        {
> +            .name = BLOCK_OPT_SIZE,
> +            .type = QEMU_OPT_SIZE,
> +            .help = "Virtual disk size"
> +        },
> +        { /* end of list */ }
> +    }
> +};
> +
> +static int nfs_file_co_create(BlockdevCreateOptions *options, Error **errp)
> +{
> +    BlockdevCreateOptionsNfs *opts = &options->u.nfs;
> +    NFSClient *client = g_new0(NFSClient, 1);
> +    int ret;
> +
> +    assert(options->driver == BLOCKDEV_DRIVER_NFS);
> +
> +    client->aio_context = qemu_get_aio_context();
> +
> +    ret = nfs_client_open(client, opts->location, O_CREAT, 0, errp);
> +    if (ret < 0) {
> +        goto out;
> +    }
> +    ret = nfs_ftruncate(client->context, client->fh, opts->size);
> +    nfs_client_close(client);
> +
> +out:
> +    g_free(client);
> +    return ret;
> +}
> +
> +static int coroutine_fn nfs_file_co_create_opts(BlockDriver *drv,
> +                                                const char *url,
> +                                                QemuOpts *opts,
> +                                                Error **errp)
> +{
> +    BlockdevCreateOptions *create_options;
> +    BlockdevCreateOptionsNfs *nfs_opts;
> +    QDict *options;
> +    int ret;
> +
> +    create_options = g_new0(BlockdevCreateOptions, 1);
> +    create_options->driver = BLOCKDEV_DRIVER_NFS;
> +    nfs_opts = &create_options->u.nfs;
> +
> +    /* Read out options */
> +    nfs_opts->size = ROUND_UP(qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0),
> +                              BDRV_SECTOR_SIZE);
> +
> +    options = qdict_new();
> +    ret = nfs_parse_uri(url, options, errp);
> +    if (ret < 0) {
> +        goto out;
> +    }
> +
> +    nfs_opts->location = nfs_options_qdict_to_qapi(options, errp);
> +    if (nfs_opts->location == NULL) {
> +        ret = -EINVAL;
> +        goto out;
> +    }
> +
> +    ret = nfs_file_co_create(create_options, errp);
> +    if (ret < 0) {
> +        goto out;
> +    }
> +
> +    ret = 0;
> +out:
> +    qobject_unref(options);
> +    qapi_free_BlockdevCreateOptions(create_options);
> +    return ret;
> +}
> +
> +static int nfs_has_zero_init(BlockDriverState *bs)
> +{
> +    NFSClient *client = bs->opaque;
> +    return client->has_zero_init;
> +}
> +
> +/* Called (via nfs_service) with QemuMutex held.  */
> +static void
> +nfs_get_allocated_file_size_cb(int ret, struct nfs_context *nfs, void *data,
> +                               void *private_data)
> +{
> +    NFSRPC *task = private_data;
> +    task->ret = ret;
> +    if (task->ret == 0) {
> +        memcpy(task->st, data, sizeof(struct stat));
> +    }
> +    if (task->ret < 0) {
> +        error_report("NFS Error: %s", nfs_get_error(nfs));
> +    }
> +
> +    /* Set task->complete before reading bs->wakeup.  */
> +    atomic_mb_set(&task->complete, 1);
> +    bdrv_wakeup(task->bs);
> +}
> +
> +static int64_t nfs_get_allocated_file_size(BlockDriverState *bs)
> +{
> +    NFSClient *client = bs->opaque;
> +    NFSRPC task = {0};
> +    struct nfs_stat st;
> +
> +    if (bdrv_is_read_only(bs) &&
> +        !(bs->open_flags & BDRV_O_NOCACHE)) {
> +        return client->st_size;
> +    }
> +
> +    task.bs = bs;
> +    task.st = &st;
> +    if (nfs_fstat_async(client->context, client->fh, nfs_get_allocated_file_size_cb,
> +                        &task) != 0) {
> +        return -ENOMEM;
> +    }
> +
> +    nfs_set_events(client);
> +    BDRV_POLL_WHILE(bs, !task.complete);
> +
> +    return (task.ret < 0 ? task.ret : st.st_size);
> +}
> +
> +static int coroutine_fn
> +nfs_file_co_truncate(BlockDriverState *bs, int64_t offset, bool exact,
> +                     PreallocMode prealloc, BdrvRequestFlags flags,
> +                     Error **errp)
> +{
> +    NFSClient *client = bs->opaque;
> +    int ret;
> +
> +    if (prealloc != PREALLOC_MODE_OFF) {
> +        error_setg(errp, "Unsupported preallocation mode '%s'",
> +                   PreallocMode_str(prealloc));
> +        return -ENOTSUP;
> +    }
> +
> +    ret = nfs_ftruncate(client->context, client->fh, offset);
> +    if (ret < 0) {
> +        error_setg_errno(errp, -ret, "Failed to truncate file");
> +        return ret;
> +    }
> +
> +    return 0;
> +}
> +
> +/* Note that this will not re-establish a connection with the NFS server
> + * - it is effectively a NOP.  */
> +static int nfs_reopen_prepare(BDRVReopenState *state,
> +                              BlockReopenQueue *queue, Error **errp)
> +{
> +    NFSClient *client = state->bs->opaque;
> +    struct nfs_stat st;
> +    int ret = 0;
> +
> +    if (state->flags & BDRV_O_RDWR && bdrv_is_read_only(state->bs)) {
> +        error_setg(errp, "Cannot open a read-only mount as read-write");
> +        return -EACCES;
> +    }
> +
> +    if ((state->flags & BDRV_O_NOCACHE) && client->cache_used) {
> +        error_setg(errp, "Cannot disable cache if libnfs readahead or"
> +                         " pagecache is enabled");
> +        return -EINVAL;
> +    }
> +
> +    /* Update cache for read-only reopens */
> +    if (!(state->flags & BDRV_O_RDWR)) {
> +        ret = nfs_fstat(client->context, client->fh, &st);
> +        if (ret < 0) {
> +            error_setg(errp, "Failed to fstat file: %s",
> +                       nfs_get_error(client->context));
> +            return ret;
> +        }
> +        client->st_size = st.st_size;
> +    }
> +
> +    return 0;
> +}
> +
> +static void nfs_refresh_filename(BlockDriverState *bs)
> +{
> +    NFSClient *client = bs->opaque;
> +
> +    if (client->uid && !client->gid) {
> +        snprintf(bs->exact_filename, sizeof(bs->exact_filename),
> +                 "nfs://%s%s?uid=%" PRId64, client->server->host, client->path,
> +                 client->uid);
> +    } else if (!client->uid && client->gid) {
> +        snprintf(bs->exact_filename, sizeof(bs->exact_filename),
> +                 "nfs://%s%s?gid=%" PRId64, client->server->host, client->path,
> +                 client->gid);
> +    } else if (client->uid && client->gid) {
> +        snprintf(bs->exact_filename, sizeof(bs->exact_filename),
> +                 "nfs://%s%s?uid=%" PRId64 "&gid=%" PRId64,
> +                 client->server->host, client->path, client->uid, client->gid);
> +    } else {
> +        snprintf(bs->exact_filename, sizeof(bs->exact_filename),
> +                 "nfs://%s%s", client->server->host, client->path);
> +    }
> +}
> +
> +static char *nfs_dirname(BlockDriverState *bs, Error **errp)
> +{
> +    NFSClient *client = bs->opaque;
> +
> +    if (client->uid || client->gid) {
> +        bdrv_refresh_filename(bs);
> +        error_setg(errp, "Cannot generate a base directory for NFS node '%s'",
> +                   bs->filename);
> +        return NULL;
> +    }
> +
> +    return g_strdup_printf("nfs://%s%s/", client->server->host, client->path);
> +}
> +
> +#ifdef LIBNFS_FEATURE_PAGECACHE
> +static void coroutine_fn nfs_co_invalidate_cache(BlockDriverState *bs,
> +                                                 Error **errp)
> +{
> +    NFSClient *client = bs->opaque;
> +    nfs_pagecache_invalidate(client->context, client->fh);
> +}
> +#endif
> +
> +static const char *nfs_strong_runtime_opts[] = {
> +    "path",
> +    "user",
> +    "group",
> +    "server.",
> +
> +    NULL
> +};
> +
> +static BlockDriver bdrv_nfs = {
> +    .format_name                    = "nfs",
> +    .protocol_name                  = "nfs",
> +
> +    .instance_size                  = sizeof(NFSClient),
> +    .bdrv_parse_filename            = nfs_parse_filename,
> +    .create_opts                    = &nfs_create_opts,
> +
> +    .bdrv_has_zero_init             = nfs_has_zero_init,
> +    .bdrv_get_allocated_file_size   = nfs_get_allocated_file_size,
> +    .bdrv_co_truncate               = nfs_file_co_truncate,
> +
> +    .bdrv_file_open                 = nfs_file_open,
> +    .bdrv_close                     = nfs_file_close,
> +    .bdrv_co_create                 = nfs_file_co_create,
> +    .bdrv_co_create_opts            = nfs_file_co_create_opts,
> +    .bdrv_reopen_prepare            = nfs_reopen_prepare,
> +
> +    .bdrv_co_preadv                 = nfs_co_preadv,
> +    .bdrv_co_pwritev                = nfs_co_pwritev,
> +    .bdrv_co_flush_to_disk          = nfs_co_flush,
> +
> +    .bdrv_detach_aio_context        = nfs_detach_aio_context,
> +    .bdrv_attach_aio_context        = nfs_attach_aio_context,
> +    .bdrv_refresh_filename          = nfs_refresh_filename,
> +    .bdrv_dirname                   = nfs_dirname,
> +
> +    .strong_runtime_opts            = nfs_strong_runtime_opts,
> +
> +#ifdef LIBNFS_FEATURE_PAGECACHE
> +    .bdrv_co_invalidate_cache       = nfs_co_invalidate_cache,
> +#endif
> +};
> +
> +static void nfs_block_init(void)
> +{
> +    bdrv_register(&bdrv_nfs);
> +}
> +
> +block_init(nfs_block_init);
> -- 
> 2.28.0.windows.1
> 
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


