Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C667C4CEC5
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 15:35:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6642C2075C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 15:35:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6642C2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8R8A-0001Cv-I2
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 11:35:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45359)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1i8R7P-0000lG-O6
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 11:34:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1i8R7M-0005Bl-9R
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 11:34:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46872)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1i8R7M-0005Ba-0T
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 11:34:44 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1276B4E4E6;
 Thu, 12 Sep 2019 15:34:43 +0000 (UTC)
Received: from localhost (ovpn-116-134.ams2.redhat.com [10.36.116.134])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9004F3DBB;
 Thu, 12 Sep 2019 15:34:37 +0000 (UTC)
Date: Thu, 12 Sep 2019 17:34:35 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jagannathan Raman <jag.raman@oracle.com>
Message-ID: <20190912153435.GM23174@stefanha-x1.localdomain>
References: <cover.1567534653.git.jag.raman@oracle.com>
 <51220007b0f8a34cc72ff2847f5deb1f85c9c0e4.1567534653.git.jag.raman@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="JvUS8mwutKMHKosv"
Content-Disposition: inline
In-Reply-To: <51220007b0f8a34cc72ff2847f5deb1f85c9c0e4.1567534653.git.jag.raman@oracle.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Thu, 12 Sep 2019 15:34:43 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC v3 PATCH 07/45] multi-process: define
 proxy-link object
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, john.g.johnson@oracle.com,
 mst@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com, quintela@redhat.com,
 armbru@redhat.com, kanth.ghatraju@oracle.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com,
 mreitz@redhat.com, ross.lagerwall@citrix.com, marcandre.lureau@gmail.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--JvUS8mwutKMHKosv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 03, 2019 at 04:37:33PM -0400, Jagannathan Raman wrote:
> diff --git a/include/io/proxy-link.h b/include/io/proxy-link.h
> new file mode 100644
> index 0000000..ee78cdd
> --- /dev/null
> +++ b/include/io/proxy-link.h
> @@ -0,0 +1,147 @@

Regarding naming: so far I've seen "remote", "mpqemu", and "proxy".
These concepts aren't well-defined and I'm not sure if they refer to the
same thing or are different.  ProxyLinkState should be named
MPQemuLinkState?

It's also unclear to me how tightly coupled this "proxy link" is to PCI
(since it has PCI Configuration Space commands and how it would be
cleanly extended to support other busses).

> +/*
> + * Communication channel between QEMU and remote device process
> + *
> + * Copyright 2019, Oracle and/or its affiliates.
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
> +#ifndef PROXY_LINK_H
> +#define PROXY_LINK_H
> +
> +#include <stddef.h>
> +#include <stdint.h>
> +#include <glib.h>
> +#include <pthread.h>
> +
> +#include "qemu/osdep.h"
> +#include "qom/object.h"
> +#include "qemu/thread.h"
> +
> +typedef struct ProxyLinkState ProxyLinkState;
> +
> +#define TYPE_PROXY_LINK "proxy-link"
> +#define PROXY_LINK(obj) \
> +    OBJECT_CHECK(ProxyLinkState, (obj), TYPE_PROXY_LINK)
> +
> +#define REMOTE_MAX_FDS 8
> +
> +#define PROC_HDR_SIZE offsetof(ProcMsg, data1.u64)
> +
> +/*
> + * proc_cmd_t enum type to specify the command to be executed on the remote
> + * device
> + *
> + * Following commands are supported:
> + * CONF_READ        PCI config. space read
> + * CONF_WRITE       PCI config. space write
> + *
> + */
> +typedef enum {
> +    INIT = 0,
> +    CONF_READ,
> +    CONF_WRITE,
> +    MAX,
> +} proc_cmd_t;
> +
> +/*
> + * ProcMsg Format of the message sent to the remote device from QEMU
> + *
> + * cmd         The remote command
> + * bytestream  Indicates if the data to be shared is structured (data1)
> + *             or unstructured (data2)
> + * size        Size of the data to be shared
> + * data1       Structured data
> + * fds         File descriptors to be shared with remote device
> + * data2       Unstructured data
> + *
> + */
> +typedef struct {
> +    proc_cmd_t cmd;
> +    int bytestream;

Please use bool.

> +    size_t size;
> +
> +    union {
> +        uint64_t u64;
> +    } data1;
> +
> +    int fds[REMOTE_MAX_FDS];
> +    int num_fds;
> +
> +    uint8_t *data2;
> +} ProcMsg;
> +
> +struct conf_data_msg {
> +    uint32_t addr;
> +    uint32_t val;
> +    int l;

Please pick a descriptive name for this field.

> +};
> +
> +/*
> + * ProcChannel defines the channel that make up the communication link
> + * between QEMU and remote process
> + *
> + * gsrc       GSource object to be used by loop
> + * gpfd       GPollFD object containing the socket & events to monitor
> + * sock       Socket to send/receive communication, same as the one in gpfd
> + * lock       Mutex to synchronize access to the channel
> + */

Please see the doc comment style in include/qom/object.h for examples of
how to format doc comments.

> +
> +typedef struct ProcChannel {
> +    GSource gsrc;
> +    GPollFD gpfd;
> +    int sock;
> +    QemuMutex lock;
> +} ProcChannel;
> +
> +typedef void (*proxy_link_callback)(GIOCondition cond, ProcChannel *chan);
> +
> +/*
> + * ProxyLinkState Instance info. of the communication
> + * link between QEMU and remote process. The Link could
> + * be made up of multiple channels.
> + *
> + * ctx        GMainContext to be used for communication
> + * loop       Main loop that would be used to poll for incoming data
> + * com        Communication channel to transport control messages
> + *
> + */
> +struct ProxyLinkState {
> +    Object obj;
> +
> +    GMainContext *ctx;
> +    GMainLoop *loop;
> +
> +    ProcChannel *com;
> +
> +    proxy_link_callback callback;
> +};
> +
> +ProxyLinkState *proxy_link_create(void);
> +void proxy_link_finalize(ProxyLinkState *s);
> +
> +void proxy_proc_send(ProxyLinkState *s, ProcMsg *msg, ProcChannel *chan);
> +int proxy_proc_recv(ProxyLinkState *s, ProcMsg *msg, ProcChannel *chan);
> +
> +void proxy_link_init_channel(ProxyLinkState *s, ProcChannel **chan, int fd);
> +void proxy_link_destroy_channel(ProcChannel *chan);
> +void proxy_link_set_callback(ProxyLinkState *s, proxy_link_callback callback);
> +void start_handler(ProxyLinkState *s);
> +
> +#endif
> diff --git a/io/Makefile.objs b/io/Makefile.objs
> index 9a20fce..ff88b46 100644
> --- a/io/Makefile.objs
> +++ b/io/Makefile.objs
> @@ -10,3 +10,5 @@ io-obj-y += channel-util.o
>  io-obj-y += dns-resolver.o
>  io-obj-y += net-listener.o
>  io-obj-y += task.o
> +
> +io-obj-$(CONFIG_MPQEMU) += proxy-link.o
> diff --git a/io/proxy-link.c b/io/proxy-link.c
> new file mode 100644
> index 0000000..5eb9718
> --- /dev/null
> +++ b/io/proxy-link.c
> @@ -0,0 +1,292 @@
> +/*
> + * Communication channel between QEMU and remote device process
> + *
> + * Copyright 2019, Oracle and/or its affiliates.
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
> +#include <assert.h>
> +#include <errno.h>
> +#include <pthread.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <sys/types.h>
> +#include <sys/socket.h>
> +#include <sys/un.h>
> +#include <unistd.h>
> +
> +#include "qemu/module.h"
> +#include "io/proxy-link.h"
> +#include "qemu/log.h"
> +
> +GSourceFuncs gsrc_funcs;
> +
> +static void proxy_link_inst_init(Object *obj)
> +{
> +    ProxyLinkState *s = PROXY_LINK(obj);
> +
> +    s->ctx = g_main_context_default();
> +    s->loop = g_main_loop_new(s->ctx, FALSE);
> +}
> +
> +static const TypeInfo proxy_link_info = {
> +    .name = TYPE_PROXY_LINK,
> +    .parent = TYPE_OBJECT,
> +    .instance_size = sizeof(ProxyLinkState),
> +    .instance_init = proxy_link_inst_init,
> +};
> +
> +static void proxy_link_register_types(void)
> +{
> +    type_register_static(&proxy_link_info);
> +}
> +
> +type_init(proxy_link_register_types)
> +
> +ProxyLinkState *proxy_link_create(void)
> +{
> +    return PROXY_LINK(object_new(TYPE_PROXY_LINK));
> +}
> +
> +void proxy_link_finalize(ProxyLinkState *s)
> +{
> +    g_main_loop_unref(s->loop);
> +    g_main_context_unref(s->ctx);
> +    g_main_loop_quit(s->loop);
> +
> +    proxy_link_destroy_channel(s->com);
> +
> +    object_unref(OBJECT(s));
> +}

It's strange that the destruction of ProxyLinkState does not use QEMU's
object system.  How about implementing .instance_finalize(), dropping
proxy_link_finalize(), and letting the caller unref ProxyLinkState like
a regular Object?

> +
> +void proxy_proc_send(ProxyLinkState *s, ProcMsg *msg, ProcChannel *chan)
> +{
> +    int rc;
> +    uint8_t *data;
> +    union {
> +        char control[CMSG_SPACE(REMOTE_MAX_FDS * sizeof(int))];
> +        struct cmsghdr align;
> +    } u;
> +    struct msghdr hdr;
> +    struct cmsghdr *chdr;
> +    int sock = chan->sock;
> +    QemuMutex *lock = &chan->lock;
> +
> +    struct iovec iov = {
> +        .iov_base = (char *) msg,
> +        .iov_len = PROC_HDR_SIZE,
> +    };
> +
> +    memset(&hdr, 0, sizeof(hdr));
> +    memset(&u, 0, sizeof(u));
> +
> +    hdr.msg_iov = &iov;
> +    hdr.msg_iovlen = 1;
> +
> +    if (msg->num_fds > REMOTE_MAX_FDS) {
> +        qemu_log_mask(LOG_REMOTE_DEBUG, "%s: Max FDs exceeded\n", __func__);
> +        return;
> +    }
> +
> +    if (msg->num_fds > 0) {
> +        size_t fdsize = msg->num_fds * sizeof(int);
> +
> +        hdr.msg_control = &u;
> +        hdr.msg_controllen = sizeof(u);
> +
> +        chdr = CMSG_FIRSTHDR(&hdr);
> +        chdr->cmsg_len = CMSG_LEN(fdsize);
> +        chdr->cmsg_level = SOL_SOCKET;
> +        chdr->cmsg_type = SCM_RIGHTS;
> +        memcpy(CMSG_DATA(chdr), msg->fds, fdsize);
> +        hdr.msg_controllen = CMSG_SPACE(fdsize);
> +    }
> +
> +    qemu_mutex_lock(lock);
> +
> +    do {
> +        rc = sendmsg(sock, &hdr, 0);
> +    } while (rc < 0 && (errno == EINTR || errno == EAGAIN));
> +
> +    if (rc < 0) {
> +        qemu_log_mask(LOG_REMOTE_DEBUG, "%s - sendmsg rc is %d, errno is %d,"
> +                      " sock %d\n", __func__, rc, errno, sock);
> +        qemu_mutex_unlock(lock);
> +        return;
> +    }
> +
> +    if (msg->bytestream) {
> +        data = msg->data2;
> +    } else {
> +        data = (uint8_t *)msg + PROC_HDR_SIZE;
> +    }
> +
> +    do {
> +        rc = write(sock, data, msg->size);
> +    } while (rc < 0 && (errno == EINTR || errno == EAGAIN));
> +
> +    qemu_mutex_unlock(lock);

Can this message be transmitted in a single sendmsg() by including 2
iovecs instead of just 1?  Then no locking is needed and only one
syscall is required.

> +}
> +
> +
> +int proxy_proc_recv(ProxyLinkState *s, ProcMsg *msg, ProcChannel *chan)
> +{
> +    int rc;
> +    uint8_t *data;
> +    union {
> +        char control[CMSG_SPACE(REMOTE_MAX_FDS * sizeof(int))];
> +        struct cmsghdr align;
> +    } u;
> +    struct msghdr hdr;
> +    struct cmsghdr *chdr;
> +    size_t fdsize;
> +    int sock = chan->sock;
> +    QemuMutex *lock = &chan->lock;
> +
> +    struct iovec iov = {
> +        .iov_base = (char *) msg,
> +        .iov_len = PROC_HDR_SIZE,
> +    };
> +
> +    memset(&hdr, 0, sizeof(hdr));
> +    memset(&u, 0, sizeof(u));
> +
> +    hdr.msg_iov = &iov;
> +    hdr.msg_iovlen = 1;
> +    hdr.msg_control = &u;
> +    hdr.msg_controllen = sizeof(u);
> +
> +    qemu_mutex_lock(lock);

Sockets are full-duplex (sending and receiving are independent).  Is it
necessary to use the same lock for both send and receive?

> +
> +    do {
> +        rc = recvmsg(sock, &hdr, 0);
> +    } while (rc < 0 && (errno == EINTR || errno == EAGAIN));
> +
> +    if (rc < 0) {
> +        qemu_log_mask(LOG_REMOTE_DEBUG, "%s - recvmsg rc is %d, errno is %d,"
> +                      " sock %d\n", __func__, rc, errno, sock);
> +        qemu_mutex_unlock(lock);
> +        return rc;
> +    }
> +
> +    msg->num_fds = 0;
> +    for (chdr = CMSG_FIRSTHDR(&hdr); chdr != NULL;
> +         chdr = CMSG_NXTHDR(&hdr, chdr)) {
> +        if ((chdr->cmsg_level == SOL_SOCKET) &&
> +            (chdr->cmsg_type == SCM_RIGHTS)) {
> +            fdsize = chdr->cmsg_len - CMSG_LEN(0);
> +            msg->num_fds = fdsize / sizeof(int);
> +            memcpy(msg->fds, CMSG_DATA(chdr), fdsize);

Please validate num_fds before memcpy to prevent the buffer overflow.

> +            break;
> +        }
> +    }
> +
> +    if (msg->size && msg->bytestream) {
> +        msg->data2 = calloc(1, msg->size);
> +        data = msg->data2;
> +    } else {
> +        data = (uint8_t *)&msg->data1;
> +    }
> +
> +    if (msg->size) {
> +        do {
> +            rc = read(sock, data, msg->size);
> +        } while (rc < 0 && (errno == EINTR || errno == EAGAIN));
> +    }

Please validate size to prevent the buffer overflow.

--JvUS8mwutKMHKosv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl16ZYsACgkQnKSrs4Gr
c8i3kwgAmaUqljM3C1g4G+bEJirz6trwrMmcAuZdb/tmjGIHTyFDclzs3T7oqULm
0yahOXvFHHgOp3eNfCyWOwl4VKNgCgJqbp++vIWsVrehfNQrigkFbAY5vP98vbs6
fpWOZWAgni/Xax6HXdxujU2w6qv979THRbBqney+Bl3oHuy6oAG6MhWNHMsd12pH
vtfVA06B2LeLNXgl7WCdK5Vhzah6QniTGquNKCYtKelh/Ql691mpAHphM2SDy+Vj
bCz+3aHW8U4Fcz+y0MCjXr9UXe6UnyALPnNABpEF5+Okc5Z18k7WI9jubLQ1JpVH
hZtWajm7Bd/O9P837hCpbaMUI3OVtw==
=FuSj
-----END PGP SIGNATURE-----

--JvUS8mwutKMHKosv--

