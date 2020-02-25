Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB344C35E01
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:45:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 702E52082F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ee10mmEu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 702E52082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6cOX-0001Zk-Kl
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 10:45:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34505)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j6cNk-0000ff-Q3
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:44:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j6cNi-0002Wg-8H
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:44:24 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28615
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j6cNi-0002WJ-1k
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:44:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582645461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nAIYK6gxGX5f0Xg/mLEf5GoceGUEXW5z884ZP4AOmPY=;
 b=ee10mmEuWcVlVonsvWXuTulczeo9ZW9Wdc0MZZXMqAXw3I92f47I4b+86sIgA0zTCxzWFP
 fnDmoVIq6zbn3oPaIeUVePi39yQzHFSHnBqx7TbOWIA+3xEzx6bZTbhtOjMiC2qHrHGuUA
 4bqeMxAhGMl4fRi8X6kWfVAO9X79kFA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-8pJ55I9ZP8KXsUP2cXEqcg-1; Tue, 25 Feb 2020 10:44:18 -0500
X-MC-Unique: 8pJ55I9ZP8KXsUP2cXEqcg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4D951078D63;
 Tue, 25 Feb 2020 15:44:17 +0000 (UTC)
Received: from linux.fritz.box (unknown [10.36.118.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EA64490A00;
 Tue, 25 Feb 2020 15:44:13 +0000 (UTC)
Date: Tue, 25 Feb 2020 16:44:12 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Coiby Xu <coiby.xu@gmail.com>
Subject: Re: [PATCH v4 2/5] generic vhost user server
Message-ID: <20200225154412.GC7632@linux.fritz.box>
References: <20200218050711.8133-1-coiby.xu@gmail.com>
 <20200218050711.8133-3-coiby.xu@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200218050711.8133-3-coiby.xu@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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

Am 18.02.2020 um 06:07 hat Coiby Xu geschrieben:
> Sharing QEMU devices via vhost-user protocol
>=20
> Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
> ---
>  util/Makefile.objs       |   3 +
>  util/vhost-user-server.c | 427 +++++++++++++++++++++++++++++++++++++++
>  util/vhost-user-server.h |  56 +++++
>  3 files changed, 486 insertions(+)
>  create mode 100644 util/vhost-user-server.c
>  create mode 100644 util/vhost-user-server.h
>=20
> diff --git a/util/vhost-user-server.h b/util/vhost-user-server.h
> new file mode 100644
> index 0000000000..ff6d3145cd
> --- /dev/null
> +++ b/util/vhost-user-server.h
> @@ -0,0 +1,56 @@
> +#include "io/channel-socket.h"
> +#include "io/channel-file.h"
> +#include "io/net-listener.h"
> +#include "contrib/libvhost-user/libvhost-user.h"
> +#include "standard-headers/linux/virtio_blk.h"
> +#include "qemu/error-report.h"
> +
> +typedef struct VuClient VuClient;

I find the terminology a bit confusing here: VuClient is really the
connection to a single client, but it's part of the server. The name
gives the impression as if this were client-side code. (This is
something that already tends to confuse me in the NBD code.)

I'm not sure what a better name could be, though. Maybe
VuServerConnevtion or VuExportClient or VuExportConnection?

> +typedef struct VuServer {
> +    QIONetListener *listener;
> +    AioContext *ctx;
> +    QTAILQ_HEAD(, VuClient) clients;
> +    void (*device_panic_notifier)(struct VuClient *client) ;
> +    int max_queues;
> +    const VuDevIface *vu_iface;
> +    /*
> +     * @ptr_in_device: VuServer pointer memory location in vhost-user de=
vice
> +     * struct, so later container_of can be used to get device destruct
> +     */
> +    void *ptr_in_device;
> +    bool close;
> +} VuServer;
> +
> +typedef struct kick_info {
> +    VuDev *vu_dev;

I suppose this could specifically be VuClient?

> +    int fd; /*kick fd*/
> +    long index; /*queue index*/
> +    QIOChannel *ioc; /*I/O channel for kick fd*/
> +    QIOChannelFile *fioc; /*underlying data channel for kick fd*/
> +    Coroutine *co;
> +} kick_info;
> +
> +struct VuClient {
> +    VuDev parent;
> +    VuServer *server;
> +    QIOChannel *ioc; /* The current I/O channel */
> +    QIOChannelSocket *sioc; /* The underlying data channel */
> +    Coroutine *co_trip;
> +    struct kick_info *kick_info;

If each struct kick_info (btw, QEMU coding style requires CamelCase) has
exactly one VuClient and each VuClient has exactly on kick_info, should
this be a single struct containing both?

[ Coming back from reading the code below - it's because this is in
fact an array. This should be made clear in the definition. ]

> +    QTAILQ_ENTRY(VuClient) next;
> +    bool closed;
> +};
> +
> +
> +VuServer *vhost_user_server_start(uint16_t max_queues,
> +                                  SocketAddress *unix_socket,
> +                                  AioContext *ctx,
> +                                  void *server_ptr,
> +                                  void *device_panic_notifier,
> +                                  const VuDevIface *vu_iface,
> +                                  Error **errp);
> +
> +void vhost_user_server_stop(VuServer *server);
> +
> +void change_vu_context(AioContext *ctx, VuServer *server);

Let's call this vhost_user_server_set_aio_context() for consistency.

> diff --git a/util/Makefile.objs b/util/Makefile.objs
> index 11262aafaf..5e450e501c 100644
> --- a/util/Makefile.objs
> +++ b/util/Makefile.objs
> @@ -36,6 +36,9 @@ util-obj-y +=3D readline.o
>  util-obj-y +=3D rcu.o
>  util-obj-$(CONFIG_MEMBARRIER) +=3D sys_membarrier.o
>  util-obj-y +=3D qemu-coroutine.o qemu-coroutine-lock.o qemu-coroutine-io=
.o
> +ifdef CONFIG_LINUX
> +util-obj-y +=3D vhost-user-server.o
> +endif
>  util-obj-y +=3D qemu-coroutine-sleep.o
>  util-obj-y +=3D qemu-co-shared-resource.o
>  util-obj-y +=3D coroutine-$(CONFIG_COROUTINE_BACKEND).o
> diff --git a/util/vhost-user-server.c b/util/vhost-user-server.c
> new file mode 100644
> index 0000000000..70ff6d6701
> --- /dev/null
> +++ b/util/vhost-user-server.c
> @@ -0,0 +1,427 @@
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
> +    for (i =3D 0; i < vmsg->fd_num; i++) {
> +        close(vmsg->fds[i]);
> +    }
> +}
> +
> +static void vmsg_unblock_fds(VhostUserMsg *vmsg)
> +{
> +    int i;
> +    for (i =3D 0; i < vmsg->fd_num; i++) {
> +        qemu_set_nonblock(vmsg->fds[i]);
> +    }
> +}
> +
> +
> +static void close_client(VuClient *client)
> +{
> +    vu_deinit(&client->parent);
> +    client->sioc =3D NULL;
> +    object_unref(OBJECT(client->ioc));
> +    client->closed =3D true;
> +
> +}
> +
> +static void panic_cb(VuDev *vu_dev, const char *buf)
> +{
> +    if (buf) {
> +        error_report("vu_panic: %s", buf);
> +    }
> +
> +    VuClient *client =3D container_of(vu_dev, VuClient, parent);
> +    VuServer *server =3D client->server;

Please put declarations at the start of the block.

> +    if (!client->closed) {
> +        close_client(client);
> +        QTAILQ_REMOVE(&server->clients, client, next);
> +    }
> +
> +    if (server->device_panic_notifier) {
> +        server->device_panic_notifier(client);
> +    }
> +}
> +
> +
> +
> +static bool coroutine_fn
> +vu_message_read(VuDev *vu_dev, int conn_fd, VhostUserMsg *vmsg)
> +{
> +    struct iovec iov =3D {
> +        .iov_base =3D (char *)vmsg,
> +        .iov_len =3D VHOST_USER_HDR_SIZE,
> +    };
> +    int rc, read_bytes =3D 0;
> +    /*
> +     * VhostUserMsg is a packed structure, gcc will complain about passi=
ng
> +     * pointer to a packed structure member if we pass &VhostUserMsg.fd_=
num
> +     * and &VhostUserMsg.fds directly when calling qio_channel_readv_ful=
l,
> +     * thus two temporary variables nfds and fds are used here.
> +     */
> +    size_t nfds =3D 0, nfds_t =3D 0;
> +    int *fds =3D NULL, *fds_t =3D NULL;
> +    VuClient *client =3D container_of(vu_dev, VuClient, parent);
> +    QIOChannel *ioc =3D client->ioc;
> +
> +    Error *erp;

The convention is to call this local_err. It should be initialised as
NULL.

> +    assert(qemu_in_coroutine());
> +    do {
> +        /*
> +         * qio_channel_readv_full may have short reads, keeping calling =
it
> +         * until getting VHOST_USER_HDR_SIZE or 0 bytes in total
> +         */
> +        rc =3D qio_channel_readv_full(ioc, &iov, 1, &fds_t, &nfds_t, &er=
p);
> +        if (rc < 0) {
> +            if (rc =3D=3D QIO_CHANNEL_ERR_BLOCK) {
> +                qio_channel_yield(ioc, G_IO_IN);
> +                continue;
> +            } else {
> +                error_report("Error while recvmsg: %s", strerror(errno))=
;

I don't think, qio_channel_*() promise anything about the value in
errno. (They also don't promise to use recvmsg().)

Instead, use error_report_err() because erp contains the real error
message.

> +                return false;
> +            }
> +        }
> +        read_bytes +=3D rc;
> +        fds =3D g_renew(int, fds_t, nfds + nfds_t);
> +        memcpy(fds + nfds, fds_t, nfds_t);
> +        nfds +=3D nfds_t;
> +        if (read_bytes =3D=3D VHOST_USER_HDR_SIZE || rc =3D=3D 0) {
> +            break;
> +        }
> +    } while (true);
> +
> +    vmsg->fd_num =3D nfds;
> +    memcpy(vmsg->fds, fds, nfds * sizeof(int));
> +    g_free(fds);
> +    /* qio_channel_readv_full will make socket fds blocking, unblock the=
m */
> +    vmsg_unblock_fds(vmsg);
> +    if (vmsg->size > sizeof(vmsg->payload)) {
> +        error_report("Error: too big message request: %d, "
> +                     "size: vmsg->size: %u, "
> +                     "while sizeof(vmsg->payload) =3D %zu",
> +                     vmsg->request, vmsg->size, sizeof(vmsg->payload));
> +        goto fail;
> +    }
> +
> +    struct iovec iov_payload =3D {
> +        .iov_base =3D (char *)&vmsg->payload,
> +        .iov_len =3D vmsg->size,
> +    };
> +    if (vmsg->size) {
> +        rc =3D qio_channel_readv_all_eof(ioc, &iov_payload, 1, &erp);
> +        if (rc =3D=3D -1) {
> +            error_report("Error while reading: %s", strerror(errno));

error_report_err() again.

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
> +static coroutine_fn void vu_client_next_trip(VuClient *client);
> +
> +static coroutine_fn void vu_client_trip(void *opaque)
> +{
> +    VuClient *client =3D opaque;
> +
> +    vu_dispatch(&client->parent);
> +    client->co_trip =3D NULL;
> +    if (!client->closed) {
> +        vu_client_next_trip(client);
> +    }
> +}

The last part is very untypical coroutine code: It says that we want to
spawn a new coroutine with vu_client_trip() as its entry point, and then
terminates the current one.

Why don't we just put the whole thing in a while (!client->closed) loop
and stay in the same coroutine instead of terminating the old one and
starting a new one all the time?

> +static coroutine_fn void vu_client_next_trip(VuClient *client)
> +{
> +    if (!client->co_trip) {
> +        client->co_trip =3D qemu_coroutine_create(vu_client_trip, client=
);
> +        aio_co_schedule(client->ioc->ctx, client->co_trip);
> +    }
> +}
> +
> +static void vu_client_start(VuClient *client)
> +{
> +    client->co_trip =3D qemu_coroutine_create(vu_client_trip, client);
> +    aio_co_enter(client->ioc->ctx, client->co_trip);
> +}

This is essentially a duplicate of vu_client_next_trip(). The only
place where it is called (vu_accept()) knows that client->co_trip is
already NULL, so it could just call vu_client_next_trip().

Or in fact, if vu_client_trip() gets turned into a loop, it's
vu_client_next_trip() that becomes unnecessary.

> +static void coroutine_fn vu_kick_cb_next(VuClient *client,
> +                                          kick_info *data);
> +
> +static void coroutine_fn vu_kick_cb(void *opaque)
> +{
> +    kick_info *data =3D (kick_info *) opaque;
> +    int index =3D data->index;
> +    VuDev *dev =3D data->vu_dev;
> +    VuClient *client;
> +    client =3D container_of(dev, VuClient, parent);
> +    VuVirtq *vq =3D &dev->vq[index];
> +    int sock =3D vq->kick_fd;
> +    if (sock =3D=3D -1) {
> +        return;
> +    }
> +    assert(sock =3D=3D data->fd);
> +    eventfd_t kick_data;
> +    ssize_t rc;
> +    /*
> +     * When eventfd is closed, the revent is POLLNVAL (=3DG_IO_NVAL) and
> +     * reading eventfd will return errno=3DEBADF (Bad file number).
> +     * Calling qio_channel_yield(ioc, G_IO_IN) will set reading handler
> +     * for QIOChannel, but aio_dispatch_handlers will only dispatch
> +     * G_IO_IN | G_IO_HUP | G_IO_ERR revents while ignoring
> +     * G_IO_NVAL (POLLNVAL) revents.
> +     *
> +     * Thus when eventfd is closed by vhost-user client, QEMU will ignor=
e
> +     * G_IO_NVAL and keeping polling by repeatedly calling qemu_poll_ns =
which
> +     * will lead to 100% CPU usage.
> +     *
> +     * To aovid this issue, make sure set_watch and remove_watch use the=
 same

s/aovid/avoid/

> +     * AIOContext for QIOChannel. Thus remove_watch will eventually succ=
efully
> +     * remove eventfd from the set of file descriptors polled for
> +     * corresponding GSource.
> +     */
> +    rc =3D read(sock, &kick_data, sizeof(eventfd_t));

Why not a QIOChannel function like for vu_message_read() above?

> +    if (rc !=3D sizeof(eventfd_t)) {
> +        if (errno =3D=3D EAGAIN) {
> +            qio_channel_yield(data->ioc, G_IO_IN);
> +        } else if (errno !=3D EINTR) {
> +            data->co =3D NULL;
> +            return;
> +        }
> +    } else {
> +        vq->handler(dev, index);
> +    }
> +    data->co =3D NULL;
> +    vu_kick_cb_next(client, data);

This can be a loop, too, instead of terminating the coroutine and
starting a new one for the same function.

> +}
> +
> +static void coroutine_fn vu_kick_cb_next(VuClient *client,
> +                                          kick_info *cb_data)
> +{
> +    if (!cb_data->co) {
> +        cb_data->co =3D qemu_coroutine_create(vu_kick_cb, cb_data);
> +        aio_co_schedule(client->ioc->ctx, cb_data->co);
> +    }
> +}

Kevin


