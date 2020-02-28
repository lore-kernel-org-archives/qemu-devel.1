Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6A5C3F2CF
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 04:24:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF5FA246A1
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 04:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZPmQ1t9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF5FA246A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7XCm-0003cN-7V
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 23:24:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42961)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <coiby.xu@gmail.com>) id 1j7XC8-0003BN-Qk
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 23:24:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <coiby.xu@gmail.com>) id 1j7XC6-0006xu-JJ
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 23:24:12 -0500
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:36956)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <coiby.xu@gmail.com>) id 1j7XC6-0006wS-5l
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 23:24:10 -0500
Received: by mail-lj1-x243.google.com with SMTP id q23so1808571ljm.4
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 20:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DQ9Mfpmckzqs/B9Ka+GC/Se21imHd3/1COBjXmcxxLo=;
 b=FZPmQ1t9qRcc3r93dGtwt6D3GNFyQSZB/4zJm6etDI7p5Nwtv2t5PF55jG6xadgaWq
 8BYbEkLL/tZuLXXj10BxN/w8J2+clKF3mEIyWMeRtNbGE1QwDxAnAP2ZylAU4vkdNpdP
 x6lTcB1jArFJa4kLhimTJDLGob7uPLiAKEn9u6pSSznAAiBcfkbTkteeN45Ghj3VCskB
 QJW/Wg92GGKf9wucSQqtTviY2u5ctRgEl1T4BQWLZERH07Fp1etE1ccm+W00XZQ5nuTU
 2LhRRJPqwZmIkeuhsHCf8xcU8fA+BOCPzd6T/6j5R4cjax18BZPcsri1EFhBRIUDcSVG
 hOHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DQ9Mfpmckzqs/B9Ka+GC/Se21imHd3/1COBjXmcxxLo=;
 b=qSgLZuTJXXsPyJMqKMjyfc5ggZ4e92NVS2A51QfpMxmoTLif2WUGUaCeUtxEVo+CqF
 RHuOAVJIIVk3YFGhWIybMM63w+xiyuqYqWGP03YF1i6umdfAUeydaejRI23jqlQqkICC
 xsqeHIqMmzvCm9/1OcKo3ta1U3NFj7GTjUpnP06SP/M67ZxrEEP+zq6O5f2pRR5lL2Vs
 +3eXWGA3CfN3kMFKV6Fe1sUpqbJzolAxBNwji6c+VSoNQGdFCwf1PnopIw0L6KtgWw8I
 OE1dwvU/+2ngMvTjSBEEFBeFWUfz6juXalNkyKkLu9Gz9ibarlNMM6sv5uv4pUn3Pzjn
 m2eg==
X-Gm-Message-State: ANhLgQ1wNZxTGkDfWJdK0BtD7PsEicH2PZbakFy2HDf1bwAmn4B3ao/n
 impQ2iCGwY9A0cok91wLg7n3xtYkRvdmiFu+C7o=
X-Google-Smtp-Source: ADFU+vvVT/ow+WgLEV37glsNCRhNCJzdBGW4fzppya+OHBtlpUUaiO4iHmCPtlldcHAUO5Rr+DY9c9w7yg5rhm2BMFU=
X-Received: by 2002:a2e:3608:: with SMTP id d8mr1535961lja.152.1582863848058; 
 Thu, 27 Feb 2020 20:24:08 -0800 (PST)
MIME-Version: 1.0
References: <20200218050711.8133-1-coiby.xu@gmail.com>
 <20200218050711.8133-3-coiby.xu@gmail.com>
 <20200225154412.GC7632@linux.fritz.box>
In-Reply-To: <20200225154412.GC7632@linux.fritz.box>
From: Coiby Xu <coiby.xu@gmail.com>
Date: Fri, 28 Feb 2020 12:23:31 +0800
Message-ID: <CAJAkqrXsrJkwtX-sCdqsLCvn5xWkp8cBoWkjLTf_OKjKsB6MxQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] generic vhost user server
To: Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::243
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

> > +static coroutine_fn void vu_client_next_trip(VuClient *client);
> > +
> > +static coroutine_fn void vu_client_trip(void *opaque)
> > +{
> > +    VuClient *client = opaque;
> > +
> > +    vu_dispatch(&client->parent);
> > +    client->co_trip = NULL;
> > +    if (!client->closed) {
> > +        vu_client_next_trip(client);
> > +    }
> > +}

> > The last part is very untypical coroutine code: It says that we want to
spawn a new coroutine with vu_client_trip() as its entry point, and then
terminates the current one.

> > Why don't we just put the whole thing in a while (!client->closed) loop
and stay in the same coroutine instead of terminating the old one and
starting a new one all the time?

> > +static coroutine_fn void vu_client_next_trip(VuClient *client)
> > +{
> > +    if (!client->co_trip) {
> > +        client->co_trip = qemu_coroutine_create(vu_client_trip, client);
> > +        aio_co_schedule(client->ioc->ctx, client->co_trip);
> > +    }
> > +}
> > +
> > +static void vu_client_start(VuClient *client)
> > +{
> > +    client->co_trip = qemu_coroutine_create(vu_client_trip, client);
> > +    aio_co_enter(client->ioc->ctx, client->co_trip);
> > +}

> This is essentially a duplicate of vu_client_next_trip(). The only
place where it is called (vu_accept()) knows that client->co_trip is
already NULL, so it could just call vu_client_next_trip().

> Or in fact, if vu_client_trip() gets turned into a loop, it's
> vu_client_next_trip() that becomes unnecessary.

This part of code is an imitation of nbd_client_trip in nbd/server.c.
I think the reason to repeatedly create/start/terminate vu_client_trip
is to support BlockBackendAioNotifier. In v5, I will keep running the
spawned coroutine in a loop until being informed of the change of
AioContext of the block device backend, i.e. vu_client_trip will only
be restarted when the block device backend is attached to a different
AiOContext.

> > +    if (rc != sizeof(eventfd_t)) {
> > +        if (errno == EAGAIN) {
> > +            qio_channel_yield(data->ioc, G_IO_IN);
> > +        } else if (errno != EINTR) {
> > +            data->co = NULL;
> > +            return;
> > +        }
> > +    } else {
> > +        vq->handler(dev, index);
> > +    }
> > +    data->co = NULL;
> > +    vu_kick_cb_next(client, data);

> This can be a loop, too, instead of terminating the coroutine and
starting a new one for the same function.

In v5, I plan to use aio_set_fd_handler to set a read hander which is
a wrapper for vu_kick_cb to deal with kick events since eventfd
doesn't have the short read issue like socket. Thus vu_kick_cb in
libvhost-user can be re-used. My only concern is if this could lead to
worse performance in comparison to keep reading from eventfd until
getting EAGAIN errno.

On Tue, Feb 25, 2020 at 11:44 PM Kevin Wolf <kwolf@redhat.com> wrote:
>
> Am 18.02.2020 um 06:07 hat Coiby Xu geschrieben:
> > Sharing QEMU devices via vhost-user protocol
> >
> > Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
> > ---
> >  util/Makefile.objs       |   3 +
> >  util/vhost-user-server.c | 427 +++++++++++++++++++++++++++++++++++++++
> >  util/vhost-user-server.h |  56 +++++
> >  3 files changed, 486 insertions(+)
> >  create mode 100644 util/vhost-user-server.c
> >  create mode 100644 util/vhost-user-server.h
> >
> > diff --git a/util/vhost-user-server.h b/util/vhost-user-server.h
> > new file mode 100644
> > index 0000000000..ff6d3145cd
> > --- /dev/null
> > +++ b/util/vhost-user-server.h
> > @@ -0,0 +1,56 @@
> > +#include "io/channel-socket.h"
> > +#include "io/channel-file.h"
> > +#include "io/net-listener.h"
> > +#include "contrib/libvhost-user/libvhost-user.h"
> > +#include "standard-headers/linux/virtio_blk.h"
> > +#include "qemu/error-report.h"
> > +
> > +typedef struct VuClient VuClient;
>
> I find the terminology a bit confusing here: VuClient is really the
> connection to a single client, but it's part of the server. The name
> gives the impression as if this were client-side code. (This is
> something that already tends to confuse me in the NBD code.)
>
> I'm not sure what a better name could be, though. Maybe
> VuServerConnevtion or VuExportClient or VuExportConnection?
>
> > +typedef struct VuServer {
> > +    QIONetListener *listener;
> > +    AioContext *ctx;
> > +    QTAILQ_HEAD(, VuClient) clients;
> > +    void (*device_panic_notifier)(struct VuClient *client) ;
> > +    int max_queues;
> > +    const VuDevIface *vu_iface;
> > +    /*
> > +     * @ptr_in_device: VuServer pointer memory location in vhost-user device
> > +     * struct, so later container_of can be used to get device destruct
> > +     */
> > +    void *ptr_in_device;
> > +    bool close;
> > +} VuServer;
> > +
> > +typedef struct kick_info {
> > +    VuDev *vu_dev;
>
> I suppose this could specifically be VuClient?
>
> > +    int fd; /*kick fd*/
> > +    long index; /*queue index*/
> > +    QIOChannel *ioc; /*I/O channel for kick fd*/
> > +    QIOChannelFile *fioc; /*underlying data channel for kick fd*/
> > +    Coroutine *co;
> > +} kick_info;
> > +
> > +struct VuClient {
> > +    VuDev parent;
> > +    VuServer *server;
> > +    QIOChannel *ioc; /* The current I/O channel */
> > +    QIOChannelSocket *sioc; /* The underlying data channel */
> > +    Coroutine *co_trip;
> > +    struct kick_info *kick_info;
>
> If each struct kick_info (btw, QEMU coding style requires CamelCase) has
> exactly one VuClient and each VuClient has exactly on kick_info, should
> this be a single struct containing both?
>
> [ Coming back from reading the code below - it's because this is in
> fact an array. This should be made clear in the definition. ]
>
> > +    QTAILQ_ENTRY(VuClient) next;
> > +    bool closed;
> > +};
> > +
> > +
> > +VuServer *vhost_user_server_start(uint16_t max_queues,
> > +                                  SocketAddress *unix_socket,
> > +                                  AioContext *ctx,
> > +                                  void *server_ptr,
> > +                                  void *device_panic_notifier,
> > +                                  const VuDevIface *vu_iface,
> > +                                  Error **errp);
> > +
> > +void vhost_user_server_stop(VuServer *server);
> > +
> > +void change_vu_context(AioContext *ctx, VuServer *server);
>
> Let's call this vhost_user_server_set_aio_context() for consistency.
>
> > diff --git a/util/Makefile.objs b/util/Makefile.objs
> > index 11262aafaf..5e450e501c 100644
> > --- a/util/Makefile.objs
> > +++ b/util/Makefile.objs
> > @@ -36,6 +36,9 @@ util-obj-y += readline.o
> >  util-obj-y += rcu.o
> >  util-obj-$(CONFIG_MEMBARRIER) += sys_membarrier.o
> >  util-obj-y += qemu-coroutine.o qemu-coroutine-lock.o qemu-coroutine-io.o
> > +ifdef CONFIG_LINUX
> > +util-obj-y += vhost-user-server.o
> > +endif
> >  util-obj-y += qemu-coroutine-sleep.o
> >  util-obj-y += qemu-co-shared-resource.o
> >  util-obj-y += coroutine-$(CONFIG_COROUTINE_BACKEND).o
> > diff --git a/util/vhost-user-server.c b/util/vhost-user-server.c
> > new file mode 100644
> > index 0000000000..70ff6d6701
> > --- /dev/null
> > +++ b/util/vhost-user-server.c
> > @@ -0,0 +1,427 @@
> > +/*
> > + * Sharing QEMU devices via vhost-user protocol
> > + *
> > + * Author: Coiby Xu <coiby.xu@gmail.com>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or
> > + * later.  See the COPYING file in the top-level directory.
> > + */
> > +#include "qemu/osdep.h"
> > +#include <sys/eventfd.h>
> > +#include "qemu/main-loop.h"
> > +#include "vhost-user-server.h"
> > +
> > +static void vmsg_close_fds(VhostUserMsg *vmsg)
> > +{
> > +    int i;
> > +    for (i = 0; i < vmsg->fd_num; i++) {
> > +        close(vmsg->fds[i]);
> > +    }
> > +}
> > +
> > +static void vmsg_unblock_fds(VhostUserMsg *vmsg)
> > +{
> > +    int i;
> > +    for (i = 0; i < vmsg->fd_num; i++) {
> > +        qemu_set_nonblock(vmsg->fds[i]);
> > +    }
> > +}
> > +
> > +
> > +static void close_client(VuClient *client)
> > +{
> > +    vu_deinit(&client->parent);
> > +    client->sioc = NULL;
> > +    object_unref(OBJECT(client->ioc));
> > +    client->closed = true;
> > +
> > +}
> > +
> > +static void panic_cb(VuDev *vu_dev, const char *buf)
> > +{
> > +    if (buf) {
> > +        error_report("vu_panic: %s", buf);
> > +    }
> > +
> > +    VuClient *client = container_of(vu_dev, VuClient, parent);
> > +    VuServer *server = client->server;
>
> Please put declarations at the start of the block.
>
> > +    if (!client->closed) {
> > +        close_client(client);
> > +        QTAILQ_REMOVE(&server->clients, client, next);
> > +    }
> > +
> > +    if (server->device_panic_notifier) {
> > +        server->device_panic_notifier(client);
> > +    }
> > +}
> > +
> > +
> > +
> > +static bool coroutine_fn
> > +vu_message_read(VuDev *vu_dev, int conn_fd, VhostUserMsg *vmsg)
> > +{
> > +    struct iovec iov = {
> > +        .iov_base = (char *)vmsg,
> > +        .iov_len = VHOST_USER_HDR_SIZE,
> > +    };
> > +    int rc, read_bytes = 0;
> > +    /*
> > +     * VhostUserMsg is a packed structure, gcc will complain about passing
> > +     * pointer to a packed structure member if we pass &VhostUserMsg.fd_num
> > +     * and &VhostUserMsg.fds directly when calling qio_channel_readv_full,
> > +     * thus two temporary variables nfds and fds are used here.
> > +     */
> > +    size_t nfds = 0, nfds_t = 0;
> > +    int *fds = NULL, *fds_t = NULL;
> > +    VuClient *client = container_of(vu_dev, VuClient, parent);
> > +    QIOChannel *ioc = client->ioc;
> > +
> > +    Error *erp;
>
> The convention is to call this local_err. It should be initialised as
> NULL.
>
> > +    assert(qemu_in_coroutine());
> > +    do {
> > +        /*
> > +         * qio_channel_readv_full may have short reads, keeping calling it
> > +         * until getting VHOST_USER_HDR_SIZE or 0 bytes in total
> > +         */
> > +        rc = qio_channel_readv_full(ioc, &iov, 1, &fds_t, &nfds_t, &erp);
> > +        if (rc < 0) {
> > +            if (rc == QIO_CHANNEL_ERR_BLOCK) {
> > +                qio_channel_yield(ioc, G_IO_IN);
> > +                continue;
> > +            } else {
> > +                error_report("Error while recvmsg: %s", strerror(errno));
>
> I don't think, qio_channel_*() promise anything about the value in
> errno. (They also don't promise to use recvmsg().)
>
> Instead, use error_report_err() because erp contains the real error
> message.
>
> > +                return false;
> > +            }
> > +        }
> > +        read_bytes += rc;
> > +        fds = g_renew(int, fds_t, nfds + nfds_t);
> > +        memcpy(fds + nfds, fds_t, nfds_t);
> > +        nfds += nfds_t;
> > +        if (read_bytes == VHOST_USER_HDR_SIZE || rc == 0) {
> > +            break;
> > +        }
> > +    } while (true);
> > +
> > +    vmsg->fd_num = nfds;
> > +    memcpy(vmsg->fds, fds, nfds * sizeof(int));
> > +    g_free(fds);
> > +    /* qio_channel_readv_full will make socket fds blocking, unblock them */
> > +    vmsg_unblock_fds(vmsg);
> > +    if (vmsg->size > sizeof(vmsg->payload)) {
> > +        error_report("Error: too big message request: %d, "
> > +                     "size: vmsg->size: %u, "
> > +                     "while sizeof(vmsg->payload) = %zu",
> > +                     vmsg->request, vmsg->size, sizeof(vmsg->payload));
> > +        goto fail;
> > +    }
> > +
> > +    struct iovec iov_payload = {
> > +        .iov_base = (char *)&vmsg->payload,
> > +        .iov_len = vmsg->size,
> > +    };
> > +    if (vmsg->size) {
> > +        rc = qio_channel_readv_all_eof(ioc, &iov_payload, 1, &erp);
> > +        if (rc == -1) {
> > +            error_report("Error while reading: %s", strerror(errno));
>
> error_report_err() again.
>
> > +            goto fail;
> > +        }
> > +    }
> > +
> > +    return true;
> > +
> > +fail:
> > +    vmsg_close_fds(vmsg);
> > +
> > +    return false;
> > +}
> > +
> > +
> > +static coroutine_fn void vu_client_next_trip(VuClient *client);
> > +
> > +static coroutine_fn void vu_client_trip(void *opaque)
> > +{
> > +    VuClient *client = opaque;
> > +
> > +    vu_dispatch(&client->parent);
> > +    client->co_trip = NULL;
> > +    if (!client->closed) {
> > +        vu_client_next_trip(client);
> > +    }
> > +}
>
> The last part is very untypical coroutine code: It says that we want to
> spawn a new coroutine with vu_client_trip() as its entry point, and then
> terminates the current one.
>
> Why don't we just put the whole thing in a while (!client->closed) loop
> and stay in the same coroutine instead of terminating the old one and
> starting a new one all the time?
>
> > +static coroutine_fn void vu_client_next_trip(VuClient *client)
> > +{
> > +    if (!client->co_trip) {
> > +        client->co_trip = qemu_coroutine_create(vu_client_trip, client);
> > +        aio_co_schedule(client->ioc->ctx, client->co_trip);
> > +    }
> > +}
> > +
> > +static void vu_client_start(VuClient *client)
> > +{
> > +    client->co_trip = qemu_coroutine_create(vu_client_trip, client);
> > +    aio_co_enter(client->ioc->ctx, client->co_trip);
> > +}
>
> This is essentially a duplicate of vu_client_next_trip(). The only
> place where it is called (vu_accept()) knows that client->co_trip is
> already NULL, so it could just call vu_client_next_trip().
>
> Or in fact, if vu_client_trip() gets turned into a loop, it's
> vu_client_next_trip() that becomes unnecessary.
>
> > +static void coroutine_fn vu_kick_cb_next(VuClient *client,
> > +                                          kick_info *data);
> > +
> > +static void coroutine_fn vu_kick_cb(void *opaque)
> > +{
> > +    kick_info *data = (kick_info *) opaque;
> > +    int index = data->index;
> > +    VuDev *dev = data->vu_dev;
> > +    VuClient *client;
> > +    client = container_of(dev, VuClient, parent);
> > +    VuVirtq *vq = &dev->vq[index];
> > +    int sock = vq->kick_fd;
> > +    if (sock == -1) {
> > +        return;
> > +    }
> > +    assert(sock == data->fd);
> > +    eventfd_t kick_data;
> > +    ssize_t rc;
> > +    /*
> > +     * When eventfd is closed, the revent is POLLNVAL (=G_IO_NVAL) and
> > +     * reading eventfd will return errno=EBADF (Bad file number).
> > +     * Calling qio_channel_yield(ioc, G_IO_IN) will set reading handler
> > +     * for QIOChannel, but aio_dispatch_handlers will only dispatch
> > +     * G_IO_IN | G_IO_HUP | G_IO_ERR revents while ignoring
> > +     * G_IO_NVAL (POLLNVAL) revents.
> > +     *
> > +     * Thus when eventfd is closed by vhost-user client, QEMU will ignore
> > +     * G_IO_NVAL and keeping polling by repeatedly calling qemu_poll_ns which
> > +     * will lead to 100% CPU usage.
> > +     *
> > +     * To aovid this issue, make sure set_watch and remove_watch use the same
>
> s/aovid/avoid/
>
> > +     * AIOContext for QIOChannel. Thus remove_watch will eventually succefully
> > +     * remove eventfd from the set of file descriptors polled for
> > +     * corresponding GSource.
> > +     */
> > +    rc = read(sock, &kick_data, sizeof(eventfd_t));
>
> Why not a QIOChannel function like for vu_message_read() above?
>
> > +    if (rc != sizeof(eventfd_t)) {
> > +        if (errno == EAGAIN) {
> > +            qio_channel_yield(data->ioc, G_IO_IN);
> > +        } else if (errno != EINTR) {
> > +            data->co = NULL;
> > +            return;
> > +        }
> > +    } else {
> > +        vq->handler(dev, index);
> > +    }
> > +    data->co = NULL;
> > +    vu_kick_cb_next(client, data);
>
> This can be a loop, too, instead of terminating the coroutine and
> starting a new one for the same function.
>
> > +}
> > +
> > +static void coroutine_fn vu_kick_cb_next(VuClient *client,
> > +                                          kick_info *cb_data)
> > +{
> > +    if (!cb_data->co) {
> > +        cb_data->co = qemu_coroutine_create(vu_kick_cb, cb_data);
> > +        aio_co_schedule(client->ioc->ctx, cb_data->co);
> > +    }
> > +}
>
> Kevin
>


-- 
Best regards,
Coiby

