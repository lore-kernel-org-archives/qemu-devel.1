Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E5AC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 13:44:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3DF72082F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 13:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MJdUY0T8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3DF72082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jluqD-0003SR-7h
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 09:44:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43150)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jlubw-0003CU-Ey
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 09:29:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34899
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jlubo-0007EB-Hp
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 09:29:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592486975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rPKEtUVMUhiX/QHnH0KXv+NE0zmZHHWWSZcafGMHXoA=;
 b=MJdUY0T81KRrXRAXOnkSdt0L+jBOUrprZbiZJvnlHOg6EflmhSLpelAiChZxiXR4xKBspf
 7caRFxwFCfx3BTxHoPmlcWHgTEOsrN7nqkiUrfYe8aYG9H7EPFyZprV9ZAlMwh28JE9L3K
 jDJb2HGIsZGvtQTVJ7Zp7FXCI9GCoO4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-s6GUOhVJOK6ipicLhGlSpQ-1; Thu, 18 Jun 2020 09:29:33 -0400
X-MC-Unique: s6GUOhVJOK6ipicLhGlSpQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8539E107BEF7;
 Thu, 18 Jun 2020 13:29:32 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-87.ams2.redhat.com [10.36.114.87])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6228A5BAC3;
 Thu, 18 Jun 2020 13:29:28 +0000 (UTC)
Date: Thu, 18 Jun 2020 15:29:26 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Coiby Xu <coiby.xu@gmail.com>
Subject: Re: [PATCH v9 2/5] generic vhost user server
Message-ID: <20200618132926.GC6012@linux.fritz.box>
References: <20200614183907.514282-1-coiby.xu@gmail.com>
 <20200614183907.514282-3-coiby.xu@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200614183907.514282-3-coiby.xu@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 01:21:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: bharatlkmlkvm@gmail.com, qemu-devel@nongnu.org, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 14.06.2020 um 20:39 hat Coiby Xu geschrieben:
> Sharing QEMU devices via vhost-user protocol.
> 
> Only one vhost-user client can connect to the server one time.
> 
> Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
> ---
>  util/Makefile.objs       |   1 +
>  util/vhost-user-server.c | 400 +++++++++++++++++++++++++++++++++++++++
>  util/vhost-user-server.h |  61 ++++++
>  3 files changed, 462 insertions(+)
>  create mode 100644 util/vhost-user-server.c
>  create mode 100644 util/vhost-user-server.h
> 
> diff --git a/util/Makefile.objs b/util/Makefile.objs
> index cc5e37177a..b4d4af06dc 100644
> --- a/util/Makefile.objs
> +++ b/util/Makefile.objs
> @@ -66,6 +66,7 @@ util-obj-y += hbitmap.o
>  util-obj-y += main-loop.o
>  util-obj-y += nvdimm-utils.o
>  util-obj-y += qemu-coroutine.o qemu-coroutine-lock.o qemu-coroutine-io.o
> +util-obj-$(CONFIG_LINUX) += vhost-user-server.o
>  util-obj-y += qemu-coroutine-sleep.o
>  util-obj-y += qemu-co-shared-resource.o
>  util-obj-y += qemu-sockets.o
> diff --git a/util/vhost-user-server.c b/util/vhost-user-server.c
> new file mode 100644
> index 0000000000..393beeb6b9
> --- /dev/null
> +++ b/util/vhost-user-server.c
> @@ -0,0 +1,400 @@
> +/*
> + * Sharing QEMU devices via vhost-user protocol
> + *
> + * Author: Coiby Xu <coiby.xu@gmail.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or
> + * later.  See the COPYING file in the top-level directory.
> + */
> +#include "qemu/osdep.h"
> +#include <sys/eventfd.h>
> +#include "qemu/main-loop.h"
> +#include "vhost-user-server.h"
> +
> +static void vmsg_close_fds(VhostUserMsg *vmsg)
> +{
> +    int i;
> +    for (i = 0; i < vmsg->fd_num; i++) {
> +        close(vmsg->fds[i]);
> +    }
> +}
> +
> +static void vmsg_unblock_fds(VhostUserMsg *vmsg)
> +{
> +    int i;
> +    for (i = 0; i < vmsg->fd_num; i++) {
> +        qemu_set_nonblock(vmsg->fds[i]);
> +    }
> +}
> +
> +static void vu_accept(QIONetListener *listener, QIOChannelSocket *sioc,
> +                      gpointer opaque);
> +
> +static void close_client(VuServer *server)
> +{
> +    vu_deinit(&server->vu_dev);
> +    object_unref(OBJECT(server->sioc));
> +    object_unref(OBJECT(server->ioc));
> +    server->sioc_slave = NULL;

Where is sioc_slave closed/freed?

> +    object_unref(OBJECT(server->ioc_slave));
> +    /*
> +     * Set the callback function for network listener so another
> +     * vhost-user client can connect to this server
> +     */
> +    qio_net_listener_set_client_func(server->listener,
> +                                     vu_accept,
> +                                     server,
> +                                     NULL);

If connecting another client to the server should work, don't we have to
set at least server->sioc = NULL so that vu_accept() won't error out?

> +}
> +
> +static void panic_cb(VuDev *vu_dev, const char *buf)
> +{
> +    VuServer *server = container_of(vu_dev, VuServer, vu_dev);
> +
> +    if (buf) {
> +        error_report("vu_panic: %s", buf);
> +    }
> +
> +    if (server->sioc) {
> +        close_client(server);
> +        server->sioc = NULL;
> +    }
> +
> +    if (server->device_panic_notifier) {
> +        server->device_panic_notifier(server);
> +    }
> +}
> +
> +static QIOChannel *slave_io_channel(VuServer *server, int fd,
> +                                    Error **local_err)
> +{
> +    if (server->sioc_slave) {
> +        if (fd == server->sioc_slave->fd) {
> +            return server->ioc_slave;
> +        }
> +    } else {
> +        server->sioc_slave = qio_channel_socket_new_fd(fd, local_err);
> +        if (!*local_err) {
> +            server->ioc_slave = QIO_CHANNEL(server->sioc_slave);
> +            return server->ioc_slave;
> +        }
> +    }
> +
> +    return NULL;
> +}
> +
> +static bool coroutine_fn
> +vu_message_read(VuDev *vu_dev, int conn_fd, VhostUserMsg *vmsg)
> +{
> +    struct iovec iov = {
> +        .iov_base = (char *)vmsg,
> +        .iov_len = VHOST_USER_HDR_SIZE,
> +    };
> +    int rc, read_bytes = 0;
> +    Error *local_err = NULL;
> +    /*
> +     * Store fds/nfds returned from qio_channel_readv_full into
> +     * temporary variables.
> +     *
> +     * VhostUserMsg is a packed structure, gcc will complain about passing
> +     * pointer to a packed structure member if we pass &VhostUserMsg.fd_num
> +     * and &VhostUserMsg.fds directly when calling qio_channel_readv_full,
> +     * thus two temporary variables nfds and fds are used here.
> +     */
> +    size_t nfds = 0, nfds_t = 0;
> +    int *fds_t = NULL;
> +    VuServer *server = container_of(vu_dev, VuServer, vu_dev);
> +    QIOChannel *ioc = NULL;
> +
> +    if (conn_fd == server->sioc->fd) {
> +        ioc = server->ioc;
> +    } else {
> +        /* Slave communication will also use this function to read msg */
> +        ioc = slave_io_channel(server, conn_fd, &local_err);
> +    }
> +
> +    if (!ioc) {
> +        error_report_err(local_err);
> +        goto fail;
> +    }
> +
> +    assert(qemu_in_coroutine());
> +    do {
> +        /*
> +         * qio_channel_readv_full may have short reads, keeping calling it
> +         * until getting VHOST_USER_HDR_SIZE or 0 bytes in total
> +         */
> +        rc = qio_channel_readv_full(ioc, &iov, 1, &fds_t, &nfds_t, &local_err);
> +        if (rc < 0) {
> +            if (rc == QIO_CHANNEL_ERR_BLOCK) {
> +                qio_channel_yield(ioc, G_IO_IN);
> +                continue;
> +            } else {
> +                error_report_err(local_err);
> +                return false;
> +            }
> +        }
> +        read_bytes += rc;
> +        if (nfds_t > 0) {
> +            if (nfds + nfds_t > G_N_ELEMENTS(vmsg->fds)) {
> +                error_report("A maximum of %d fds are allowed, "
> +                             "however got %lu fds now",
> +                             VHOST_MEMORY_MAX_NREGIONS, nfds + nfds_t);
> +                goto fail;
> +            }
> +            memcpy(vmsg->fds + nfds, fds_t,
> +                   nfds_t *sizeof(vmsg->fds[0]));
> +            nfds += nfds_t;
> +            g_free(fds_t);
> +        }
> +        if (read_bytes == VHOST_USER_HDR_SIZE || rc == 0) {
> +            break;
> +        }
> +        iov.iov_base = (char *)vmsg + read_bytes;
> +        iov.iov_len = VHOST_USER_HDR_SIZE - read_bytes;
> +    } while (true);
> +
> +    vmsg->fd_num = nfds;
> +    /* qio_channel_readv_full will make socket fds blocking, unblock them */
> +    vmsg_unblock_fds(vmsg);
> +    if (vmsg->size > sizeof(vmsg->payload)) {
> +        error_report("Error: too big message request: %d, "
> +                     "size: vmsg->size: %u, "
> +                     "while sizeof(vmsg->payload) = %zu",
> +                     vmsg->request, vmsg->size, sizeof(vmsg->payload));
> +        goto fail;
> +    }
> +
> +    struct iovec iov_payload = {
> +        .iov_base = (char *)&vmsg->payload,
> +        .iov_len = vmsg->size,
> +    };
> +    if (vmsg->size) {
> +        rc = qio_channel_readv_all_eof(ioc, &iov_payload, 1, &local_err);
> +        if (rc == -1) {
> +            error_report_err(local_err);
> +            goto fail;
> +        }
> +    }
> +
> +    return true;
> +
> +fail:
> +    vmsg_close_fds(vmsg);
> +
> +    return false;
> +}
> +
> +
> +static void vu_client_start(VuServer *server);
> +static coroutine_fn void vu_client_trip(void *opaque)
> +{
> +    VuServer *server = opaque;
> +
> +    while (!server->aio_context_changed && server->sioc) {
> +        vu_dispatch(&server->vu_dev);
> +    }
> +
> +    if (server->aio_context_changed && server->sioc) {
> +        server->aio_context_changed = false;
> +        vu_client_start(server);
> +    }
> +}

This is somewhat convoluted, but ok. As soon as my patch "util/async:
Add aio_co_reschedule_self()" is merged, we can use it to simplify this
a bit.

> +static void vu_client_start(VuServer *server)
> +{
> +    server->co_trip = qemu_coroutine_create(vu_client_trip, server);
> +    aio_co_enter(server->ctx, server->co_trip);
> +}
> +
> +/*
> + * a wrapper for vu_kick_cb
> + *
> + * since aio_dispatch can only pass one user data pointer to the
> + * callback function, pack VuDev and pvt into a struct. Then unpack it
> + * and pass them to vu_kick_cb
> + */
> +static void kick_handler(void *opaque)
> +{
> +    KickInfo *kick_info = opaque;
> +    kick_info->cb(kick_info->vu_dev, 0, (void *) kick_info->index);
> +}
> +
> +
> +static void
> +set_watch(VuDev *vu_dev, int fd, int vu_evt,
> +          vu_watch_cb cb, void *pvt)
> +{
> +
> +    VuServer *server = container_of(vu_dev, VuServer, vu_dev);
> +    g_assert(vu_dev);
> +    g_assert(fd >= 0);
> +    long index = (intptr_t) pvt;
> +    g_assert(cb);
> +    KickInfo *kick_info = &server->kick_info[index];
> +    if (!kick_info->cb) {
> +        kick_info->fd = fd;
> +        kick_info->cb = cb;
> +        qemu_set_nonblock(fd);
> +        aio_set_fd_handler(server->ioc->ctx, fd, false, kick_handler,
> +                           NULL, NULL, kick_info);
> +        kick_info->vu_dev = vu_dev;
> +    }
> +}
> +
> +
> +static void remove_watch(VuDev *vu_dev, int fd)
> +{
> +    VuServer *server;
> +    int i;
> +    int index = -1;
> +    g_assert(vu_dev);
> +    g_assert(fd >= 0);
> +
> +    server = container_of(vu_dev, VuServer, vu_dev);
> +    for (i = 0; i < vu_dev->max_queues; i++) {
> +        if (server->kick_info[i].fd == fd) {
> +            index = i;
> +            break;
> +        }
> +    }
> +
> +    if (index == -1) {
> +        return;
> +    }
> +    server->kick_info[i].cb = NULL;
> +    aio_set_fd_handler(server->ioc->ctx, fd, false, NULL, NULL, NULL, NULL);
> +}
> +
> +
> +static void vu_accept(QIONetListener *listener, QIOChannelSocket *sioc,
> +                      gpointer opaque)
> +{
> +    VuServer *server = opaque;
> +
> +    if (server->sioc) {
> +        warn_report("Only one vhost-user client is allowed to "
> +                    "connect the server one time");
> +        return;
> +    }
> +
> +    if (!vu_init(&server->vu_dev, server->max_queues, sioc->fd, panic_cb,
> +                 vu_message_read, set_watch, remove_watch, server->vu_iface)) {
> +        error_report("Failed to initialized libvhost-user");
> +        return;
> +    }
> +
> +    /*
> +     * Unset the callback function for network listener to make another
> +     * vhost-user client keeping waiting until this client disconnects
> +     */
> +    qio_net_listener_set_client_func(server->listener,
> +                                     NULL,
> +                                     NULL,
> +                                     NULL);
> +    server->sioc = sioc;
> +    server->kick_info = g_new0(KickInfo, server->max_queues);
> +    /*
> +     * Increase the object reference, so sioc will not freed by
> +     * qio_net_listener_channel_func which will call object_unref(OBJECT(sioc))
> +     */
> +    object_ref(OBJECT(server->sioc));
> +    qio_channel_set_name(QIO_CHANNEL(sioc), "vhost-user client");
> +    server->ioc = QIO_CHANNEL(sioc);
> +    object_ref(OBJECT(server->ioc));
> +    qio_channel_attach_aio_context(server->ioc, server->ctx);
> +    qio_channel_set_blocking(QIO_CHANNEL(server->sioc), false, NULL);
> +    vu_client_start(server);
> +}
> +
> +
> +void vhost_user_server_stop(VuServer *server)
> +{
> +    if (!server) {
> +        return;
> +    }

There is no reason why the caller should even pass NULL.

> +    if (server->sioc) {
> +        close_client(server);
> +        object_unref(OBJECT(server->sioc));

close_client() already unrefs it. Do we really hold two references? If
so, why?

I can see that vu_accept() takes an extra reference, but the comment
there says this is because QIOChannel takes ownership.

> +    }
> +
> +    if (server->listener) {
> +        qio_net_listener_disconnect(server->listener);
> +        object_unref(OBJECT(server->listener));
> +    }
> +
> +    g_free(server->kick_info);

Don't we need to wait for co_trip to terminate somewhere? Probably
before freeing any objects because it could still use them.

I assume vhost_user_server_stop() is always called from the main thread
whereas co_trip runs in the server AioContext, so extra care is
necessary.

> +}
> +
> +static void detach_context(VuServer *server)
> +{
> +    int i;
> +    AioContext *ctx = server->ioc->ctx;
> +    qio_channel_detach_aio_context(server->ioc);
> +    for (i = 0; i < server->vu_dev.max_queues; i++) {
> +        if (server->kick_info[i].cb) {
> +            aio_set_fd_handler(ctx, server->kick_info[i].fd, false, NULL,
> +                               NULL, NULL, NULL);
> +        }
> +    }
> +}
> +
> +static void attach_context(VuServer *server, AioContext *ctx)
> +{
> +    int i;
> +    qio_channel_attach_aio_context(server->ioc, ctx);
> +    server->aio_context_changed = true;
> +    if (server->co_trip) {
> +        aio_co_schedule(ctx, server->co_trip);
> +    }
> +    for (i = 0; i < server->vu_dev.max_queues; i++) {
> +        if (server->kick_info[i].cb) {
> +            aio_set_fd_handler(ctx, server->kick_info[i].fd, false,
> +                               kick_handler, NULL, NULL,
> +                               &server->kick_info[i]);
> +        }
> +    }
> +}

There is a lot of duplication between detach_context() and
attach_context(). I think implementing this directly in
vhost_user_server_set_aio_context() for both cases at once would result
in simpler code.

> +void vhost_user_server_set_aio_context(AioContext *ctx, VuServer *server)
> +{
> +    server->ctx = ctx ? ctx : qemu_get_aio_context();
> +    if (!server->sioc) {
> +        return;
> +    }
> +    if (ctx) {
> +        attach_context(server, ctx);
> +    } else {
> +        detach_context(server);
> +    }
> +}

What happens if the VuServer is already attached to an AioContext and
you change it to another AioContext? Shouldn't it be detached from the
old context and attached to the new one instead of only doing the
latter?

> +
> +bool vhost_user_server_start(VuServer *server,
> +                             SocketAddress *socket_addr,
> +                             AioContext *ctx,
> +                             uint16_t max_queues,
> +                             DevicePanicNotifierFn *device_panic_notifier,
> +                             const VuDevIface *vu_iface,
> +                             Error **errp)
> +{

I think this is the function that is supposed to initialise the VuServer
object, so would it be better to first zero it out completely?

Or alternatively assign it completely like this (which automatically
zeroes any unspecified field):

    *server = (VuServer) {
        .vu_iface       = vu_iface,
        .max_queues     = max_queues,
        ...
    }

> +    server->listener = qio_net_listener_new();
> +    if (qio_net_listener_open_sync(server->listener, socket_addr, 1,
> +                                   errp) < 0) {
> +        return false;
> +    }
> +
> +    qio_net_listener_set_name(server->listener, "vhost-user-backend-listener");
> +
> +    server->vu_iface = vu_iface;
> +    server->max_queues = max_queues;
> +    server->ctx = ctx;
> +    server->device_panic_notifier = device_panic_notifier;
> +    qio_net_listener_set_client_func(server->listener,
> +                                     vu_accept,
> +                                     server,
> +                                     NULL);
> +
> +    return true;
> +}
> diff --git a/util/vhost-user-server.h b/util/vhost-user-server.h
> new file mode 100644
> index 0000000000..5baf58f96a
> --- /dev/null
> +++ b/util/vhost-user-server.h
> @@ -0,0 +1,61 @@
> +/*
> + * Sharing QEMU devices via vhost-user protocol
> + *
> + * Author: Coiby Xu <coiby.xu@gmail.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or
> + * later.  See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef VHOST_USER_SERVER_H
> +#define VHOST_USER_SERVER_H
> +
> +#include "contrib/libvhost-user/libvhost-user.h"
> +#include "io/channel-socket.h"
> +#include "io/channel-file.h"
> +#include "io/net-listener.h"
> +#include "qemu/error-report.h"
> +#include "qapi/error.h"
> +#include "standard-headers/linux/virtio_blk.h"
> +
> +typedef struct KickInfo {
> +    VuDev *vu_dev;
> +    int fd; /*kick fd*/
> +    long index; /*queue index*/
> +    vu_watch_cb cb;
> +} KickInfo;
> +
> +typedef struct VuServer {
> +    QIONetListener *listener;
> +    AioContext *ctx;
> +    void (*device_panic_notifier)(struct VuServer *server) ;

Extra space before the semicolon.

> +    int max_queues;
> +    const VuDevIface *vu_iface;
> +    VuDev vu_dev;
> +    QIOChannel *ioc; /* The I/O channel with the client */
> +    QIOChannelSocket *sioc; /* The underlying data channel with the client */
> +    /* IOChannel for fd provided via VHOST_USER_SET_SLAVE_REQ_FD */
> +    QIOChannel *ioc_slave;
> +    QIOChannelSocket *sioc_slave;
> +    Coroutine *co_trip; /* coroutine for processing VhostUserMsg */
> +    KickInfo *kick_info; /* an array with the length of the queue number */

"an array with @max_queues elements"?

> +    /* restart coroutine co_trip if AIOContext is changed */
> +    bool aio_context_changed;
> +} VuServer;
> +
> +
> +typedef void DevicePanicNotifierFn(struct VuServer *server);
> +
> +bool vhost_user_server_start(VuServer *server,
> +                             SocketAddress *unix_socket,
> +                             AioContext *ctx,
> +                             uint16_t max_queues,
> +                             DevicePanicNotifierFn *device_panic_notifier,
> +                             const VuDevIface *vu_iface,
> +                             Error **errp);
> +
> +void vhost_user_server_stop(VuServer *server);
> +
> +void vhost_user_server_set_aio_context(AioContext *ctx, VuServer *server);
> +
> +#endif /* VHOST_USER_SERVER_H */

Kevin


