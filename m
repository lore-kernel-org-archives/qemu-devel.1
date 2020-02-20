Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63747C11D00
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 09:32:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 003D52465D
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 09:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r/BoJVO9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 003D52465D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4iBq-0003u9-5f
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 04:32:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53088)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <coiby.xu@gmail.com>) id 1j4iAV-000352-Q9
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 04:30:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <coiby.xu@gmail.com>) id 1j4iAO-00041t-KY
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 04:30:51 -0500
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c]:46087)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <coiby.xu@gmail.com>) id 1j4iAN-00041J-TQ
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 04:30:44 -0500
Received: by mail-lf1-x12c.google.com with SMTP id z26so2483185lfg.13
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 01:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JGyidXbb0POVD6aPvFpMd5tybxKbqK1m+ZgYBeWfd6Q=;
 b=r/BoJVO9t43/igmNHQwlGUmYlyb8zMg0kvCzxtPLqRZWMes5+BuOn9/fAgRM0Zbqjf
 B976fmNk8whVib1n4qaqYTRRvyb/Xy+cLnKGywU38ctHe6ixX/QtE/iPKCLlBmw9c5UE
 sMSlzbHpPSG5ITxGlqY8N6QPrVW/6P12blijFKE14VcEws1KLpbYA8W5eHuJKh8X6fwt
 LSupVP2qO1JkliDkjdu6H0y6ndirOdCwIQ3/Jxrf0JiS3q7CGZ9IxczMRQV39k+Z179e
 wqJJI/YDzfN5SP6oFOyVSxSP4dp/Vllbs/I9lzE2QMeCK/4ck8gBmT6RpsILuM0LkD6n
 /tFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JGyidXbb0POVD6aPvFpMd5tybxKbqK1m+ZgYBeWfd6Q=;
 b=rbMYScNWGSpxb+W+RGIRR1yPBiF9l1SizMTNw1s2YUQzwwhx5ANbk+7vHsZhmJwovN
 3kRzn6LDj81w8wfPERQ/ELrSH5dkueJztohkDcbpgaH8XkHuohgwUhhB7DZ4peIQzPCf
 f6Am8SahIXUX4qAk3SEk1ICKBVCflDcS5Ba9rsObyda9AU+K/qkwcbm0UR3ltSHL0fCN
 YGCuOnkZJZ5Z7+vLmR7rbfhMZot0Lz49FxS8Vr9XnoF6LhtNc2xCag79qsxg7SfCosjD
 AH9dvbqPKvdXUX3ZsFwPIuqRMFrzcOOeOn5gHrCwMiMVbvVCC/zUzqtF/u/WgaE4kxFQ
 Czsw==
X-Gm-Message-State: APjAAAW4i5ancXVZXNMVynFE18OuygsHejWi9yylX3yaHf/ovURadFt6
 zlsPQvEaavbiuWp+OaG5ezGB8v/VuaifQ+LgGCc=
X-Google-Smtp-Source: APXvYqy+9rsg1Wxs+IW3u1Vz4XOJIY19wXhMV3SX38aI/ZSxZFAJzkDd2uu1Tc1Yf9RuR9Qw3n0H083zh/JbUC52GDs=
X-Received: by 2002:a19:4855:: with SMTP id v82mr15328326lfa.197.1582191041675; 
 Thu, 20 Feb 2020 01:30:41 -0800 (PST)
MIME-Version: 1.0
References: <20200114140620.10385-1-coiby.xu@gmail.com>
 <20200114140620.10385-2-coiby.xu@gmail.com>
 <20200116135609.GD9470@linux.fritz.box>
In-Reply-To: <20200116135609.GD9470@linux.fritz.box>
From: Coiby Xu <coiby.xu@gmail.com>
Date: Thu, 20 Feb 2020 17:30:04 +0800
Message-ID: <CAJAkqrXffq+rvZvioQG7y_o9jgryP0VoQT2LQL62j8xcnqu9Tw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] vhost-user block device backend
To: Kevin Wolf <kwolf@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000001863c059efe8fc3"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::12c
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

--00000000000001863c059efe8fc3
Content-Type: text/plain; charset="UTF-8"

> > +    vmsg->fd_num = 0;
> > +    for (cmsg = CMSG_FIRSTHDR(&msg);
> > +         cmsg != NULL;
> > +         cmsg = CMSG_NXTHDR(&msg, cmsg))
> > +    {
> > +        if (cmsg->cmsg_level == SOL_SOCKET && cmsg->cmsg_type ==
SCM_RIGHTS) {
> > +            fd_size = cmsg->cmsg_len - CMSG_LEN(0);
> > +            vmsg->fd_num = fd_size / sizeof(int);
> > +            memcpy(vmsg->fds, CMSG_DATA(cmsg), fd_size);
> > +            break;
> > +        }
> > +    }

> I think the fd passing part becomes easier when you use the proper
> qio_channel_readv_full() function. Its implementation is also a bit more
> careful than yours. For example, you forgot checking fd_size against
> VHOST_MEMORY_MAX_NREGIONS, allowing a buffer overflow in the memcpy(),
> and you don't adjust fd flags for the new file descriptors.

Oh, I used qio_channel_readv_full in v3&v4. But I still forgot checking
fd_size against  VHOST_MEMORY_MAX_NREGIONS. I'll fix this buffer overflow
issue in v5.

On Thu, Jan 16, 2020 at 9:56 PM Kevin Wolf <kwolf@redhat.com> wrote:

> Hi,
>
> I'm only doing a quick first review pointing out the more obvious
> things while I familiarise myself with your code. I intend to review it
> in more detail later (either in a second pass for this series, or when
> you post v3).
>
> Am 14.01.2020 um 15:06 hat Coiby Xu geschrieben:
> > By making use of libvhost, multiple block device drives can be exported
> and each drive can serve multiple clients simultaneously. Since
> vhost-user-server needs a block drive to be created first, delay the
> creation of this object.
> >
> > Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
>
> Please wrap the commit message at 72 characters.
>
> >  blockdev-vu.c              | 1008 ++++++++++++++++++++++++++++++++++++
> >  include/block/vhost-user.h |   46 ++
> >  vl.c                       |    4 +
> >  3 files changed, 1058 insertions(+)
> >  create mode 100644 blockdev-vu.c
> >  create mode 100644 include/block/vhost-user.h
>
> This adds a single, relatively big source file. I see at least two
> parts: The generic vhost-user infrastructure with connection handling
> etc. and the implementation of the specific vhost-user-blk device.
> Separating these into two files is probably a good idea.
>
> I would also suggest to put the files in a new subdirectory
> block/export/ and call them vhost-user.c/vhost-user-blk.c. The new
> header file can be in the same directory as it shouldn't be used by
> anyone else.
>
> > diff --git a/blockdev-vu.c b/blockdev-vu.c
> > new file mode 100644
> > index 0000000000..45f0bb43a7
> > --- /dev/null
> > +++ b/blockdev-vu.c
> > @@ -0,0 +1,1008 @@
>
> The LICENSE file clarifies that files without a license header are
> GPLv2+, so it's not strictly a problem, but I think it is good style to
> include a license header that explicitly tells so.
>
> > +#include "qemu/osdep.h"
> > +#include "block/vhost-user.h"
> > +#include "qapi/error.h"
> > +#include "qapi/qapi-types-sockets.h"
> > +#include "qapi/qapi-commands-block.h"
> > +
> > +#include "sysemu/block-backend.h"
> > +#include "qemu/main-loop.h"
> > +
> > +#include "qemu/units.h"
> > +
> > +#include "block/block.h"
> > +
> > +#include "qom/object_interfaces.h"
> > +
> > +#include <sys/eventfd.h>
> > +
> > +#include "hw/qdev-properties.h"
>
> Does the order of includes and the empty lines between them signify
> anything? If not, I suggest just sorting them alphabetically (and maybe
> using empty lines between different subdirectories if you like this
> better than a single large block).
>
> According to CODING_STYLE.rst, system headers like <sys/eventfd.h> come
> before all QEMU headers (except qemu/osdep.h, which always must come
> first).
>
> > +enum {
> > +    VHOST_USER_BLK_MAX_QUEUES = 8,
> > +};
> > +
> > +struct virtio_blk_inhdr {
> > +    unsigned char status;
> > +};
> > +
> > +
> > +static QTAILQ_HEAD(, VubDev) vub_devs =
> QTAILQ_HEAD_INITIALIZER(vub_devs);
> > +
> > +
> > +typedef struct VubReq {
> > +    VuVirtqElement *elem;
>
> Maybe worth a comment that this was allocated with plain malloc(), so
> you must use free() rather than g_free() (which would be the default in
> QEMU)?
>
> > +    int64_t sector_num;
> > +    size_t size;
> > +    struct virtio_blk_inhdr *in;
> > +    struct virtio_blk_outhdr out;
> > +    VuClient *client;
> > +    struct VuVirtq *vq;
> > +} VubReq;
>
> I'm not completely sure yet, but I think I would prefer VuBlock to Vub
> in the type names. Some may even prefer VhostUserBlock, but I can see
> that this would be quite lengthy.
>
> > +static void
> > +remove_watch(VuDev *vu_dev, int fd)
> > +{
> > +    VuClient *client;
> > +
> > +    g_assert(vu_dev);
> > +    g_assert(fd >= 0);
> > +
> > +    client = container_of(vu_dev, VuClient, parent);
> > +    aio_set_fd_handler(client->blk->ctx, fd, false, NULL, NULL, NULL,
> NULL);
> > +}
> > +
> > +static void close_client(VuClient *client)
> > +{
> > +    vu_deinit(&client->parent);
> > +    /** g_source_destroy(vub_device->parent.src); */
>
> Leftover from conversion?
>
> > +    client->sioc = NULL;
> > +    object_unref(OBJECT(client->ioc));
> > +    client->closed = true;
> > +
> > +}
> > +
> > +static void vub_panic_cb(VuDev *vu_dev, const char *buf)
>
> You use a lot of sprintf() before calling this function. Would it be
> worth taking a printf-like format parameter instead of buf and using a
> variable argument list?
>
> > +{
> > +    if (buf) {
> > +        g_warning("vu_panic: %s", buf);
>
> I think QEMU proper doesn't use g_warning() anywhere. This could be
> error_report() or warn_report(). (Or if you use a format string
> error_vreport() and warn_vreport().)
>
> > +    }
> > +
> > +    VuClient *client = container_of(vu_dev, VuClient, parent);
> > +    if (client->blk->exit_panic) {
> > +        client->blk->close = true;
> > +    }
> > +    if (!client->closed) {
> > +        close_client(client);
> > +    }
> > +}
> > +
> > +
> > +static void vub_req_complete(VubReq *req)
> > +{
> > +    VuDev *vu_dev = &req->client->parent;
> > +
> > +    /* IO size with 1 extra status byte */
> > +    vu_queue_push(vu_dev, req->vq, req->elem,
> > +                  req->size + 1);
>
> I think this fits in a single line.
>
> > +    vu_queue_notify(vu_dev, req->vq);
> > +
> > +    if (req->elem) {
> > +        free(req->elem);
> > +    }
> > +
> > +    g_free(req);
> > +}
> > +
> > +
> > +
> > +static int
> > +vub_discard_write_zeroes(VubReq *req, struct iovec *iov, uint32_t
> iovcnt,
> > +                         uint32_t type)
> > +{
> > +    struct virtio_blk_discard_write_zeroes *desc;
> > +    ssize_t size;
> > +    void *buf;
> > +
> > +    size = iov_size(iov, iovcnt);
> > +    if (size != sizeof(*desc)) {
> > +        fprintf(stderr, "Invalid size %ld, expect %ld\n", size,
> sizeof(*desc));
> > +        return -1;
>
> This would be error_report(), too. (More cases below, I'll ignore them
> now.)
>
> I would prefer consistent use of -errno instead of -1 for error cases if
> you don't mind. I guess this would be -EINVAL here. I won't mention it
> for all the other cases; if you want to make the change, you need to
> make it everywhere, obviously.
>
> > +    }
> > +    buf = g_new0(char, size);
> > +
> > +    iov_to_buf_full(iov, iovcnt, 0, buf, size);
>
> I think uint8_t describes better than char what we want here: A buffer
> of bytes.
>
> The empty line would make more sense to me above the g_new0() line than
> after it because it starts a new section that deals with the buffer. In
> general, the use of empty lines feels a bit inconsistent in this patch.
> You may want to go over them again.
>
> > +
> > +    #if defined(__linux__) && defined(BLKDISCARD) && defined(BLKZEROOUT)
>
> Preprocessor directives should be unindented.
>
> However, I don't think any of this code actually depends on Linux,
> BLKDISCARD or BLKZEROOUT. You can just call blk_pdiscard() and
> blk_pwrite_zeroes() and they will do whatever is necessary to perform
> the operation on the backend (which might not be a Linux block device,
> but could be a regular file or even using a network protocol like NBD).
>
> > +    VubDev *vdev_blk;
> > +    VuClient *client = container_of(dev, VuClient, parent);
> > +    vdev_blk = client->blk;
> > +    desc = (struct virtio_blk_discard_write_zeroes *)buf;
> > +    uint64_t range[2] = { le64toh(desc->sector) << 9,
> > +                          le32toh(desc->num_sectors) << 9 };
> > +    if (type == VIRTIO_BLK_T_DISCARD) {
> > +        if (blk_pdiscard(vdev_blk->blk, range[0], range[1]) == 0) {
> > +            g_free(buf);
> > +            return 0;
> > +        }
> > +    } else if (type == VIRTIO_BLK_T_WRITE_ZEROES) {
> > +        if (blk_pwrite_zeroes(vdev_blk->blk, range[0], range[1]) == 0) {
> > +            g_free(buf);
> > +            return 0;
> > +        }
>
> blk_pdiscard() and blk_pwrite_zeroes() are synchronous functions. In
> other words, the guest will be blocked until the I/O is complete. We
> cannot do this.
>
> I think you should let vub_virtio_process_req() run in a coroutine so
> that you can call blk_co_pdiscard() and blk_co_pwrite_zeroes() here.
>
> > +    }
> > +    #endif
> > +
> > +    g_free(buf);
> > +    return -1;
> > +}
> > +
> > +
> > +static void
> > +vub_flush(VubReq *req)
> > +{
> > +    VuClient *client = req->client;
> > +    blk_co_flush(client->blk->backend);
>
> You can't call blk_co_flush() from outside coroutine context. This code
> will be right after you move vub_virtio_process_req() to a coroutine,
> though (which will make this function a coroutine_fn).
>
> > +}
> > +
> > +
> > +#define NOT_DONE 0x7fffffff /* used while emulated sync operation in
> progress */
> > +typedef struct BlkRwCo {
> > +    BlockBackend *blk;
> > +    int64_t offset;
> > +    void *iobuf;
> > +    int ret;
> > +    BdrvRequestFlags flags;
> > +} BlkRwCo;
> > +
> > +static void blk_read_entry(void *opaque)
> > +{
> > +    BlkRwCo *rwco = opaque;
> > +    QEMUIOVector *qiov = rwco->iobuf;
> > +
> > +    rwco->ret = blk_co_preadv(rwco->blk, rwco->offset, qiov->size,
> > +                              qiov, rwco->flags);
> > +    aio_wait_kick();
> > +}
> > +
> > +
> > +static void blk_write_entry(void *opaque)
> > +{
> > +    BlkRwCo *rwco = opaque;
> > +    QEMUIOVector *qiov = rwco->iobuf;
> > +
> > +    rwco->ret = blk_co_pwritev(rwco->blk, rwco->offset, qiov->size,
> > +                              qiov, rwco->flags);
> > +    aio_wait_kick();
> > +}
> > +
> > +
> > +static int blk_prw(BlockBackend *blk, QEMUIOVector *qiov, int64_t
> offset,
> > +                   CoroutineEntry co_entry, BdrvRequestFlags flags)
> > +{
> > +
> > +    BlkRwCo rwco = {
> > +        .blk    = blk,
> > +        .offset = offset,
> > +        .iobuf  = qiov,
> > +        .flags  = flags,
> > +        .ret    = NOT_DONE,
> > +    };
> > +
> > +    if (qemu_in_coroutine()) {
> > +        /* Fast-path if already in coroutine context */
> > +        co_entry(&rwco);
> > +    } else {
> > +        Coroutine *co = qemu_coroutine_create(co_entry, &rwco);
> > +        bdrv_coroutine_enter(blk_bs(blk), co);
> > +        BDRV_POLL_WHILE(blk_bs(blk), rwco.ret == NOT_DONE);
> > +    }
> > +
> > +    return rwco.ret;
> > +}
>
> This is copy&paste from block-backend.c. We should certainly not do
> this. I think it will automatically go away when you can use
> blk_co_preadv() and blk_co_pwritev() directly.
>
> Note that the BDRV_POLL_WHILE() means that like above, we would be
> waiting for the request to complete. This would block the guest and
> would also not allow parallel requests, killing the I/O performance of
> our vhost-user export.
>
> > +
> > +static ssize_t
> > +vub_rwv(VubReq *req, struct iovec *iov,
> > +        uint32_t iovcnt,
> > +        CoroutineEntry co_entry)
>
> I don't understand the line wrapping here. :-)
>
> > +{
> > +    VuClient *client = req->client;
> > +    ssize_t rc;
> > +
> > +    if (!iovcnt) {
> > +        fprintf(stderr, "Invalid Read/Write IOV count\n");
> > +        return -1;
> > +    }
> > +
> > +    int64_t offset = req->sector_num * 512;
> > +    QEMUIOVector *qiov = g_new0(QEMUIOVector, 1);
> > +    qemu_iovec_init_external(qiov, iov, iovcnt);
> > +    rc = blk_prw(client->blk->backend, qiov, offset, co_entry, 0);
> > +
> > +    req->size = iov_size(iov, iovcnt);
>
> You can use qiov->size instead of duplicating this information into a
> separate VubReq field.
>
> > +    if (rc < 0) {
> > +        fprintf(stderr, "%s, Sector %"PRIu64", Size %lu failed with
> %s\n",
> > +                client->blk->name, req->sector_num, req->size,
> > +                strerror(errno));
> > +        return -1;
> > +    }
> > +
> > +    return rc;
> > +}
> > +
> > +static int vub_virtio_process_req(VuClient *client,
> > +                                     VuVirtq *vq)
>
> Indentation is off. This could be a single line anyway.
>
> > +{
> > +    VuDev *vu_dev = &client->parent;
> > +    VuVirtqElement *elem;
> > +    uint32_t type;
> > +    VubReq *req;
> > +
> > +    elem = vu_queue_pop(vu_dev, vq, sizeof(VuVirtqElement) +
> sizeof(VubReq));
> > +    if (!elem) {
> > +        return -1;
> > +    }
> > +
> > +    struct iovec *in_iov = elem->in_sg;
> > +    struct iovec *out_iov = elem->out_sg;
> > +    unsigned in_num = elem->in_num;
> > +    unsigned out_num = elem->out_num;
> > +    /* refer to hw/block/virtio_blk.c */
> > +    if (elem->out_num < 1 || elem->in_num < 1) {
> > +        fprintf(stderr, "virtio-blk request missing headers\n");
> > +        free(elem);
> > +        return -1;
> > +    }
> > +
> > +    req = g_new0(VubReq, 1);
> > +    req->client = client;
> > +    req->vq = vq;
> > +    req->elem = elem;
> > +
> > +    if (unlikely(iov_to_buf(out_iov, out_num, 0, &req->out,
> > +                            sizeof(req->out)) != sizeof(req->out))) {
> > +        fprintf(stderr, "virtio-blk request outhdr too short");
> > +        goto err;
> > +    }
> > +
> > +    iov_discard_front(&out_iov, &out_num, sizeof(req->out));
> > +
> > +    if (in_iov[in_num - 1].iov_len < sizeof(struct virtio_blk_inhdr)) {
> > +        fprintf(stderr, "virtio-blk request inhdr too short");
> > +        goto err;
> > +    }
> > +
> > +    /* We always touch the last byte, so just see how big in_iov is.  */
> > +    req->in = (void *)in_iov[in_num - 1].iov_base
> > +              + in_iov[in_num - 1].iov_len
> > +              - sizeof(struct virtio_blk_inhdr);
> > +    iov_discard_back(in_iov, &in_num, sizeof(struct virtio_blk_inhdr));
> > +
> > +
> > +    type = le32toh(req->out.type);
> > +    switch (type & ~VIRTIO_BLK_T_BARRIER) {
> > +    case VIRTIO_BLK_T_IN:
> > +    case VIRTIO_BLK_T_OUT: {
> > +        ssize_t ret = 0;
> > +        bool is_write = type & VIRTIO_BLK_T_OUT;
> > +        req->sector_num = le64toh(req->out.sector);
> > +        if (is_write) {
> > +            ret = vub_rwv(req, out_iov, out_num, blk_write_entry);
> > +        } else {
> > +            ret = vub_rwv(req, in_iov, in_num, blk_read_entry);
> > +        }
> > +        if (ret >= 0) {
> > +            req->in->status = VIRTIO_BLK_S_OK;
> > +        } else {
> > +            req->in->status = VIRTIO_BLK_S_IOERR;
> > +        }
> > +        vub_req_complete(req);
> > +        break;
> > +    }
> > +    case VIRTIO_BLK_T_FLUSH:
> > +        vub_flush(req);
> > +        req->in->status = VIRTIO_BLK_S_OK;
> > +        vub_req_complete(req);
> > +        break;
> > +    case VIRTIO_BLK_T_GET_ID: {
> > +        size_t size = MIN(iov_size(&elem->in_sg[0], in_num),
> > +                          VIRTIO_BLK_ID_BYTES);
> > +        snprintf(elem->in_sg[0].iov_base, size, "%s", "vhost_user_blk");
> > +        req->in->status = VIRTIO_BLK_S_OK;
> > +        req->size = elem->in_sg[0].iov_len;
> > +        vub_req_complete(req);
> > +        break;
> > +    }
> > +    case VIRTIO_BLK_T_DISCARD:
> > +    case VIRTIO_BLK_T_WRITE_ZEROES: {
> > +        int rc;
> > +        rc = vub_discard_write_zeroes(req, &elem->out_sg[1], out_num,
> type);
> > +        if (rc == 0) {
> > +            req->in->status = VIRTIO_BLK_S_OK;
> > +        } else {
> > +            req->in->status = VIRTIO_BLK_S_IOERR;
> > +        }
> > +        vub_req_complete(req);
> > +        break;
> > +    }
> > +    default:
> > +        req->in->status = VIRTIO_BLK_S_UNSUPP;
> > +        vub_req_complete(req);
> > +        break;
> > +    }
> > +
> > +    return 0;
> > +
> > +err:
> > +    free(elem);
> > +    g_free(req);
> > +    return -1;
> > +}
> > +
> > +
> > +static void vub_process_vq(VuDev *vu_dev, int idx)
> > +{
> > +    VuClient *client;
> > +    VuVirtq *vq;
> > +    int ret;
> > +
> > +    client = container_of(vu_dev, VuClient, parent);
> > +    assert(client);
> > +
> > +    vq = vu_get_queue(vu_dev, idx);
> > +    assert(vq);
> > +
> > +    while (1) {
> > +        ret = vub_virtio_process_req(client, vq);
> > +        if (ret) {
> > +            break;
> > +        }
> > +    }
> > +}
>
> I mentioned above moving vub_virtio_process_req() into a coroutine. Just
> creating a coroutine here and entering it wouldn't work, though.
>
> The best design is probably to get requests from the virtqueue in this
> function (what is currently the first half of vub_virtio_process_req())
> and then spawn a coroutine per request to actually execute them (roughly
> the switch in vub_virtio_process_req()).
>
> This way you'll get parallel requests and won't have to think about
> synchronising accesses to the virtqueue from multiple coroutines.
>
> > +
> > +static void vub_queue_set_started(VuDev *vu_dev, int idx, bool started)
> > +{
> > +    VuVirtq *vq;
> > +
> > +    assert(vu_dev);
> > +
> > +    vq = vu_get_queue(vu_dev, idx);
> > +    vu_set_queue_handler(vu_dev, vq, started ? vub_process_vq : NULL);
> > +}
> > +
> > +static uint64_t
> > +vub_get_features(VuDev *dev)
> > +{
> > +    uint64_t features;
> > +    VubDev *vdev_blk;
> > +
> > +    VuClient *client = container_of(dev, VuClient, parent);
> > +    vdev_blk = client->blk;
> > +
> > +    features = 1ull << VIRTIO_BLK_F_SIZE_MAX |
> > +               1ull << VIRTIO_BLK_F_SEG_MAX |
> > +               1ull << VIRTIO_BLK_F_TOPOLOGY |
> > +               1ull << VIRTIO_BLK_F_BLK_SIZE |
> > +               1ull << VIRTIO_BLK_F_FLUSH |
> > +               #if defined(__linux__) && defined(BLKDISCARD) &&
> defined(BLKZEROOUT)
> > +               1ull << VIRTIO_BLK_F_DISCARD |
> > +               1ull << VIRTIO_BLK_F_WRITE_ZEROES |
> > +               #endif
> > +               1ull << VIRTIO_BLK_F_CONFIG_WCE |
> > +               1ull << VIRTIO_F_VERSION_1 |
> > +               1ull << VIRTIO_RING_F_INDIRECT_DESC |
> > +               1ull << VIRTIO_RING_F_EVENT_IDX |
> > +               1ull << VHOST_USER_F_PROTOCOL_FEATURES;
> > +
> > +    if (!vdev_blk->writable) {
> > +        features |= 1ull << VIRTIO_BLK_F_RO;
> > +    }
> > +
> > +    return features;
> > +}
> > +
> > +static uint64_t
> > +vub_get_protocol_features(VuDev *dev)
> > +{
> > +    return 1ull << VHOST_USER_PROTOCOL_F_CONFIG |
> > +           1ull << VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD;
> > +}
> > +
> > +static int
> > +vub_get_config(VuDev *vu_dev, uint8_t *config, uint32_t len)
> > +{
> > +    VubDev *vdev_blk;
> > +
> > +    VuClient *client = container_of(vu_dev, VuClient, parent);
> > +    vdev_blk = client->blk;
> > +    memcpy(config, &vdev_blk->blkcfg, len);
> > +
> > +    return 0;
> > +}
> > +
> > +static int
> > +vub_set_config(VuDev *vu_dev, const uint8_t *data,
> > +               uint32_t offset, uint32_t size, uint32_t flags)
> > +{
> > +    VubDev *vdev_blk;
> > +
> > +    VuClient *client = container_of(vu_dev, VuClient, parent);
> > +    vdev_blk = client->blk;
> > +    uint8_t wce;
> > +
> > +    /* don't support live migration */
> > +    if (flags != VHOST_SET_CONFIG_TYPE_MASTER) {
> > +        return -1;
> > +    }
> > +
> > +
> > +    if (offset != offsetof(struct virtio_blk_config, wce) ||
> > +        size != 1) {
> > +        return -1;
> > +    }
> > +
> > +    wce = *data;
> > +    if (wce == vdev_blk->blkcfg.wce) {
> > +        /* Do nothing as same with old configuration */
> > +        return 0;
> > +    }
> > +
> > +    vdev_blk->blkcfg.wce = wce;
> > +    blk_set_enable_write_cache(vdev_blk->backend, true);
> > +    return 0;
> > +}
> > +
> > +
> > +/*
> > + * When the client disconnects, it send a VHOST_USER_NONE request
>
> s/send/sends/
>
> > + * and vu_process_message will simple call exit which cause the VM
> > + * to exit abruptly.
> > + * To avoid this issue,  process VHOST_USER_NONE request ahead
> > + * of vu_process_message.
> > + *
> > + */
> > +static int vub_process_msg(VuDev *dev, VhostUserMsg *vmsg, int
> *do_reply)
> > +{
> > +    if (vmsg->request == VHOST_USER_NONE) {
> > +        dev->panic(dev, "disconnect");
> > +        return true;
> > +    }
> > +    return false;
> > +}
> > +
> > +static void
> > +vmsg_close_fds(VhostUserMsg *vmsg)
> > +{
> > +    int i;
> > +    for (i = 0; i < vmsg->fd_num; i++) {
> > +        close(vmsg->fds[i]);
> > +    }
> > +}
> > +
> > +static bool
> > +vu_message_read_co(VuDev *vu_dev, int conn_fd, VhostUserMsg *vmsg)
> > +{
> > +    char control[CMSG_SPACE(VHOST_MEMORY_MAX_NREGIONS * sizeof(int))] =
> { };
> > +    struct iovec iov = {
> > +        .iov_base = (char *)vmsg,
> > +        .iov_len = VHOST_USER_HDR_SIZE,
> > +    };
> > +    struct msghdr msg = {
> > +        .msg_iov = &iov,
> > +        .msg_iovlen = 1,
> > +        .msg_control = control,
> > +        .msg_controllen = sizeof(control),
> > +    };
> > +    size_t fd_size;
> > +    struct cmsghdr *cmsg;
> > +    int rc;
> > +    char buffer[100];
> > +    VuClient *client = container_of(vu_dev, VuClient, parent);
> > +    QIOChannel *ioc = client->ioc;
> > +    do {
> > +        rc = recvmsg(conn_fd, &msg, 0);
>
> This should certainly use qio_channel_readv_full() rather than working
> directly with a socket fd?
>
> > +        if (rc < 0) {
> > +            if (errno == EAGAIN) {
> > +                if (qemu_in_coroutine()) {
> > +                    qio_channel_yield(ioc, G_IO_IN);
> > +                } else {
> > +                    qio_channel_wait(ioc, G_IO_IN);
> > +                }
> > +                continue;
> > +            } else if (errno == EINTR) {
> > +                continue;
> > +            }
> > +        }
> > +        break;
> > +    } while (true);
> > +
> > +    if (rc < 0) {
> > +        sprintf(buffer, "Error while recvmsg: %s", strerror(errno));
> > +        vub_panic_cb(vu_dev, buffer);
> > +        return false;
> > +    }
> > +
> > +    assert(rc == VHOST_USER_HDR_SIZE || rc == 0);
>
> Why do you think that there can't be short reads?
>
> > +    vmsg->fd_num = 0;
> > +    for (cmsg = CMSG_FIRSTHDR(&msg);
> > +         cmsg != NULL;
> > +         cmsg = CMSG_NXTHDR(&msg, cmsg))
> > +    {
> > +        if (cmsg->cmsg_level == SOL_SOCKET && cmsg->cmsg_type ==
> SCM_RIGHTS) {
> > +            fd_size = cmsg->cmsg_len - CMSG_LEN(0);
> > +            vmsg->fd_num = fd_size / sizeof(int);
> > +            memcpy(vmsg->fds, CMSG_DATA(cmsg), fd_size);
> > +            break;
> > +        }
> > +    }
>
> I think the fd passing part becomes easier when you use the proper
> qio_channel_readv_full() function. Its implementation is also a bit more
> careful than yours. For example, you forgot checking fd_size against
> VHOST_MEMORY_MAX_NREGIONS, allowing a buffer overflow in the memcpy(),
> and you don't adjust fd flags for the new file descriptors.
>
> > +    if (vmsg->size > sizeof(vmsg->payload)) {
> > +        sprintf(buffer,
> > +                "Error: too big message request: %d, size: vmsg->size:
> %u, "
> > +                "while sizeof(vmsg->payload) = %zu\n",
> > +                vmsg->request, vmsg->size, sizeof(vmsg->payload));
> > +        vub_panic_cb(vu_dev, buffer);
> > +        goto fail;
> > +    }
> > +
> > +    if (vmsg->size) {
> > +        do {
> > +            rc = read(conn_fd, &vmsg->payload, vmsg->size);
>
> qio_channel_readv_all_eof() already implements this whole loop and
> correctly handles short reads, too.
>
> > +            if (rc < 0) {
> > +                if (errno == EAGAIN) {
> > +                    if (qemu_in_coroutine()) {
> > +                        qio_channel_yield(ioc, G_IO_IN);
> > +                    } else {
> > +                        qio_channel_wait(ioc, G_IO_IN);
> > +                    }
> > +                    continue;
> > +                } else if (errno == EINTR) {
> > +                    continue;
> > +                }
> > +            }
> > +            break;
> > +        } while (true);
> > +
> > +        if (rc <= 0) {
> > +            sprintf(buffer, "Error while reading: %s", strerror(errno));
> > +            vub_panic_cb(vu_dev, buffer);
> > +            goto fail;
> > +        }
> > +
> > +        assert(rc == vmsg->size);
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
> > +static void vub_kick_cb(void *opaque)
> > +{
> > +    vu_watch_cb_data *data = (vu_watch_cb_data *) opaque;
> > +    int index = data->index;
> > +    VuDev *dev = data->vu_dev;
> > +    VuVirtq *vq = &dev->vq[index];
> > +    int sock = vq->kick_fd;
> > +    eventfd_t kick_data;
> > +    ssize_t rc;
> > +
> > +    rc = eventfd_read(sock, &kick_data);
> > +    if (rc == -1) {
> > +        char buffer[100];
> > +        sprintf(buffer, "kick eventfd_read(): %s", strerror(errno));
> > +        vub_panic_cb(dev, buffer);
> > +        g_free(data);
> > +        dev->remove_watch(dev, dev->vq[index].kick_fd);
> > +    } else {
> > +        if (vq->handler) {
> > +            vq->handler(dev, index);
> > +        }
> > +    }
> > +}
> > +
> > +static const VuDevIface vub_iface = {
> > +    .get_features = vub_get_features,
> > +    .queue_set_started = vub_queue_set_started,
> > +    .get_protocol_features = vub_get_protocol_features,
> > +    .get_config = vub_get_config,
> > +    .set_config = vub_set_config,
> > +    .process_msg = vub_process_msg,
> > +    .read_msg = vu_message_read_co,
> > +    .kick_callback = vub_kick_cb,
> > +};
>
> I would prefer the = signs to be aligned to the same column.
>
> > +
> > +void vub_free(VubDev *vub_dev, bool called_by_QOM)
> > +{
> > +    if (!vub_dev) {
> > +        return;
> > +    }
> > +
> > +    blk_unref(vub_dev->backend);
> > +    g_free(vub_dev->name);
> > +    g_free(vub_dev->unix_socket);
> > +
> > +    if (vub_dev->next.tqe_circ.tql_prev) {
> > +        /*
> > +         * if vub_dev->next.tqe_circ.tql_prev = null,
> > +         * vub_dev hasn't been inserted into the queue and
> > +         * vub_free is called by obj->instance_finalize.
> > +         */
> > +        QTAILQ_REMOVE(&vub_devs, vub_dev, next);
> > +    }
> > +    /*
> > +     * Needn't to free vub_dev if called by QOM
> > +     * because QOM will do the clean-up work.
> > +     */
> > +    if (!called_by_QOM) {
> > +        g_free(vub_dev);
> > +    }
> > +}
> > +
> > +static coroutine_fn void vu_client_trip(void *opaque)
> > +{
> > +    VuClient *client = opaque;
> > +
> > +    while (!client->closed) {
> > +        vu_dispatch(&client->parent);
> > +    }
> > +
> > +    QTAILQ_REMOVE(&client->blk->clients, client, next);
> > +
>
> Extra empty line.
>
> > +}
> > +
> > +static void vu_client_start(VuClient *client)
> > +{
> > +    Coroutine *co = qemu_coroutine_create(vu_client_trip, client);
> > +    qemu_coroutine_enter(co);
> > +}
> > +
> > +
> > +G_STATIC_ASSERT((int)G_IO_IN == (int)VU_WATCH_IN);
> > +G_STATIC_ASSERT((int)G_IO_OUT == (int)VU_WATCH_OUT);
> > +G_STATIC_ASSERT((int)G_IO_PRI == (int)VU_WATCH_PRI);
> > +G_STATIC_ASSERT((int)G_IO_ERR == (int)VU_WATCH_ERR);
> > +G_STATIC_ASSERT((int)G_IO_HUP == (int)VU_WATCH_HUP);
> > +
> > +static void
> > +set_watch(VuDev *vu_dev, int fd, int vu_evt,
> > +          vu_watch_cb_packed_data cb, void *pvt)
> > +{
> > +    /*
> > +     * since aio_dispatch can only pass one user data pointer to the
> > +     * callback function, pack VuDev, pvt into a struct
> > +     */
> > +    VuClient *client;
> > +
> > +    g_assert(vu_dev);
> > +    g_assert(fd >= 0);
> > +    g_assert(cb);
> > +    client = container_of(vu_dev, VuClient, parent);
> > +    vu_watch_cb_data *cb_data = g_new0(vu_watch_cb_data, 1);
> > +    cb_data->index = (intptr_t) pvt;
> > +    cb_data->vu_dev = vu_dev;
> > +    aio_set_fd_handler(client->blk->ctx, fd, false, (void *) cb,
> > +                       NULL, NULL, cb_data);
> > +}
> > +
> > +
> > +void vub_accept(QIONetListener *listener, QIOChannelSocket *sioc,
> > +                gpointer opaque)
> > +{
> > +    VuClient *client;
> > +    VubDev *vub_device = opaque;
> > +    client = g_new0(VuClient, 1);
> > +
> > +    if (!vu_init_packed_data(&client->parent, VHOST_USER_BLK_MAX_QUEUES,
> > +                             sioc->fd, vub_panic_cb, set_watch,
> > +                             remove_watch, &vub_iface)) {
> > +        fprintf(stderr, "Failed to initialized libvhost-user\n");
> > +        g_free(client);
> > +        return;
> > +    }
> > +
> > +    client->blk = vub_device;
> > +    client->refcount = 1;
> > +    client->sioc = sioc;
> > +    /*
> > +     * increase the object reference, so cioc will not freed by
> > +     * qio_net_listener_channel_func which will call
> object_unref(OBJECT(sioc))
> > +     */
> > +    object_ref(OBJECT(client->sioc));
> > +    qio_channel_set_name(QIO_CHANNEL(sioc), "vhost-user client");
> > +    client->ioc = QIO_CHANNEL(sioc);
> > +    object_ref(OBJECT(client->ioc));
> > +    object_ref(OBJECT(sioc));
> > +
> > +    qio_channel_set_blocking(QIO_CHANNEL(client->sioc), false, NULL);
> > +    client->closed = false;
> > +    QTAILQ_INSERT_TAIL(&client->blk->clients, client, next);
> > +    vu_client_start(client);
> > +}
> > +
> > +
> > +void
> > +vub_initialize_config(BlockDriverState *bs, struct virtio_blk_config
> *config)
> > +{
> > +    config->capacity = bdrv_getlength(bs) >> BDRV_SECTOR_BITS;
> > +    config->blk_size = BDRV_SECTOR_SIZE;
> > +    config->size_max = 65536;
> > +    config->seg_max = 128 - 2;
> > +    config->min_io_size = 1;
> > +    config->opt_io_size = 1;
> > +    config->num_queues = 1;
> > +    #if defined(__linux__) && defined(BLKDISCARD) && defined(BLKZEROOUT)
> > +    config->max_discard_sectors = 32768;
> > +    config->max_discard_seg = 1;
> > +    config->discard_sector_alignment = config->blk_size >> 9;
> > +    config->max_write_zeroes_sectors = 32768;
> > +    config->max_write_zeroes_seg = 1;
> > +    #endif
> > +}
> > +
> > +
> > +static VubDev *vub_new(VubDev *vub_device, const char *name,
> > +                       const char *unix_socket, bool writable, Error
> **errp)
> > +{
> > +
> > +    BlockBackend *blk;
> > +
> > +    /*
> > +     * Don't allow resize while the vhost user server is running,
> > +     * otherwise we don't care what happens with the node.
> > +     */
> > +    uint64_t perm = BLK_PERM_CONSISTENT_READ;
> > +    int ret;
> > +
> > +    AioContext *ctx;
> > +
> > +    BlockDriverState *bs = bdrv_lookup_bs(name,
> > +                                          name,
> > +                                          errp);
>
> This fits in a single line.
>
> > +
> > +    if (!bs) {
> > +        error_setg(errp,
> > +                   "No drive with name '%s'."
> > +                   " Please find the list of names with "
> > +                   "'info block'", name);
>
> This can probably be two lines instead of four.
>
> > +        return NULL;
> > +    }
> > +
> > +    if (bdrv_is_read_only(bs)) {
> > +        writable = false;
> > +    }
> > +
> > +    if (writable) {
> > +        perm |= BLK_PERM_WRITE;
> > +    }
> > +
> > +    ctx = bdrv_get_aio_context(bs);
> > +    aio_context_acquire(ctx);
> > +    bdrv_invalidate_cache(bs, NULL);
> > +    aio_context_release(ctx);
> > +
> > +    blk = blk_new(bdrv_get_aio_context(bs), perm,
> > +                  BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED |
> > +                  BLK_PERM_WRITE | BLK_PERM_GRAPH_MOD);
> > +    ret = blk_insert_bs(blk, bs, errp);
> > +
> > +    if (ret < 0) {
> > +        goto fail;
> > +    }
> > +
> > +
> > +    blk_set_enable_write_cache(blk, false);
> > +
> > +    blk_set_allow_aio_context_change(blk, true);
> > +
> > +
> > +    vub_device->name = g_strdup(name);
> > +    vub_device->unix_socket = g_strdup(unix_socket);
> > +    vub_device->writable = writable;
> > +    vub_device->blkcfg.wce = 0;
> > +    vub_device->backend = blk;
> > +    vub_device->ctx = ctx;
> > +    vub_initialize_config(bs, &vub_device->blkcfg);
> > +    return vub_device;
> > +
> > +fail:
> > +    blk_unref(blk);
> > +    return NULL;
> > +}
> > +
> > +void vhost_user_server_free(VubDev *vub_device, bool called_by_QOM)
> > +{
> > +    if (!vub_device) {
> > +        return;
> > +    }
> > +
> > +    VuClient *client, *next;
> > +    QTAILQ_FOREACH_SAFE(client, &vub_device->clients, next, next) {
> > +        if (!client->closed) {
> > +            close_client(client);
> > +        }
> > +    }
> > +
> > +    if (vub_device->listener) {
> > +        qio_net_listener_disconnect(vub_device->listener);
> > +        object_unref(OBJECT(vub_device->listener));
> > +    }
> > +    vub_free(vub_device, called_by_QOM);
> > +
> > +}
> > +
> > +
> > +VubDev *vub_dev_find(const char *name)
> > +{
> > +    VubDev *vub_device;
> > +    QTAILQ_FOREACH(vub_device, &vub_devs, next) {
> > +        if (strcmp(name, vub_device->name) == 0) {
> > +            return vub_device;
> > +        }
> > +    }
> > +
> > +    return NULL;
> > +}
> > +
> > +
> > +static VubDev *vub_dev_find_by_unix_socket(const char *unix_socket)
> > +{
> > +    VubDev *vub_device;
> > +    QTAILQ_FOREACH(vub_device, &vub_devs, next) {
> > +        if (strcmp(unix_socket, vub_device->unix_socket) == 0) {
> > +            return vub_device;
> > +        }
> > +    }
> > +
> > +    return NULL;
> > +}
> > +
> > +static void vhost_user_server_start(VubDev *vub_device, const char
> *unix_socket,
> > +                                    const char *name, bool writable,
> > +                                    Error **errp)
> > +{
> > +
> > +    if (vub_dev_find(name) || vub_dev_find_by_unix_socket(unix_socket))
> {
> > +        error_setg(errp, "Vhost user server with name '%s' or "
> > +                "with socket_path '%s' has already been started",
> > +                name, unix_socket);
> > +        return;
> > +    }
> > +
> > +
> > +    if (!vub_new(vub_device, name, unix_socket, writable, errp)) {
> > +        return;
> > +    }
> > +
> > +
> > +    vub_device->listener = qio_net_listener_new();
> > +
> > +    qio_net_listener_set_name(vub_device->listener,
> > +                              "vhost-user-backend-listener");
> > +
> > +    SocketAddress *addr = g_new0(SocketAddress, 1);
> > +    addr->u.q_unix.path = (char *) unix_socket;
> > +    addr->type = SOCKET_ADDRESS_TYPE_UNIX;
> > +    if (qio_net_listener_open_sync(vub_device->listener, addr, 1, errp)
> < 0) {
> > +        goto error;
> > +    }
> > +
> > +
> > +    QTAILQ_INSERT_TAIL(&vub_devs, vub_device, next);
> > +    QTAILQ_INIT(&vub_device->clients);
> > +
> > +    qio_net_listener_set_client_func(vub_device->listener,
> > +                                     vub_accept,
> > +                                     vub_device,
> > +                                     NULL);
> > +
> > +    return;
> > +
> > + error:
> > +    vub_free(vub_device, false);
> > +}
> > +
> > +static void vu_set_block_name(Object *obj, const char *value,
> > +                                           Error **errp)
> > +{
> > +    VubDev *vus = VHOST_USER_SERVER(obj);;
> > +
> > +    if (vus->name) {
> > +        error_setg(errp, "evdev property already set");
> > +        return;
> > +    }
> > +
> > +    vus->name = g_strdup(value);
> > +}
> > +
> > +static char *vu_get_block_name(Object *obj, Error **errp)
> > +{
> > +    VubDev *vus = VHOST_USER_SERVER(obj);
> > +    return g_strdup(vus->name);
> > +}
> > +
> > +
> > +static void vu_set_unix_socket(Object *obj, const char *value,
> > +                                            Error **errp)
> > +{
> > +    VubDev *vus = VHOST_USER_SERVER(obj);;
> > +
> > +    if (vus->unix_socket) {
> > +        error_setg(errp, "unix_socket property already set");
> > +        return;
> > +    }
> > +
> > +    vus->unix_socket = g_strdup(value);
> > +    vhost_user_server_start(vus, value, vus->name,
> > +                            vus->writable, errp);
> > +}
>
> This makes the unix-socket property magic in that it starts the server
> with the properties specified at this point. This means that this
> property must always be specified last.
>
> Maybe it would be better to use a boolean property (similar to qdev's
> "realized") that explicitly start and possibly stops the export.
>
> Writing to other properties should probably result in an error while the
> server is already running because these property changes won't take
> effect any more then.
>
> > +static char *vu_get_unix_socket(Object *obj, Error **errp)
> > +{
> > +    VubDev *vus = VHOST_USER_SERVER(obj);;
> > +    return g_strdup(vus->unix_socket);
> > +}
> > +
> > +static bool vu_get_block_writable(Object *obj, Error **errp)
> > +{
> > +    VubDev *vus = VHOST_USER_SERVER(obj);;
> > +    return vus->writable;
> > +}
> > +
> > +static void vu_set_block_writable(Object *obj, bool value, Error **errp)
> > +{
> > +    VubDev *vus = VHOST_USER_SERVER(obj);
> > +
> > +    vus->writable = value;
> > +}
> > +
> > +static void vhost_user_server_instance_init(Object *obj)
> > +{
> > +
> > +    object_property_add_bool(obj, "writable",
> > +                            vu_get_block_writable,
> > +                            vu_set_block_writable, NULL);
> > +
> > +    object_property_add_str(obj, "name",
> > +                            vu_get_block_name,
> > +                            vu_set_block_name, NULL);
> > +
> > +    object_property_add_str(obj, "unix_socket",
> > +                            vu_get_unix_socket,
> > +                            vu_set_unix_socket, NULL);
>
> These should probably be object_class_property_add_*() and be called in
> .class_init rather than .instance_init.
>
> "name" suggests that it's the name of the export rather than the block
> device to be exported. I would suggest "node-name" (and then actually
> only pass it as node-name to bdrv_lookup_bs()).
>
> I expect that in the long run, we'll want to accept a full SocketAddress
> rather than just a filename like in "unix_socket".
>
> > +}
> > +
> > +static void vhost_user_server_instance_finalize(Object *obj)
> > +{
> > +    VubDev *vus = VHOST_USER_SERVER(obj);
> > +    vhost_user_server_free(vus, true);
> > +    /* object_del shouldn't free this object struct */
> > +    obj->free = NULL;
> > +}
> > +
> > +static const TypeInfo vhost_user_server_info = {
> > +    .name = TYPE_VHOST_USER_SERVER,
> > +    .parent = TYPE_OBJECT,
> > +    .instance_size = sizeof(VuDev),
> > +    .instance_init = vhost_user_server_instance_init,
> > +    .instance_finalize = vhost_user_server_instance_finalize,
> > +    .interfaces = (InterfaceInfo[]) {
> > +        {TYPE_USER_CREATABLE},
> > +        {}
> > +    },
> > +};
> > +
> > +static void vhost_user_server_register_types(void)
> > +{
> > +    type_register_static(&vhost_user_server_info);
> > +}
> > +
> > +type_init(vhost_user_server_register_types)
> > +
>
> Extra empty line at the file end.
>
> In summary, I can see this going in the right direction, though in
> detail some more work will be needed.
>
> Kevin
>
>

-- 
*Best regards,*
*Coiby*

--00000000000001863c059efe8fc3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">&gt; &gt; + =C2=A0 =C2=A0vmsg-&gt;fd_num =3D 0;<br>&gt; &g=
t; + =C2=A0 =C2=A0for (cmsg =3D CMSG_FIRSTHDR(&amp;msg);<br>&gt; &gt; + =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 cmsg !=3D NULL;<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 cmsg =3D CMSG_NXTHDR(&amp;msg, cmsg))<br>&gt; &gt; + =C2=A0 =C2=
=A0{<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (cmsg-&gt;cmsg_level =3D=
=3D SOL_SOCKET &amp;&amp; cmsg-&gt;cmsg_type =3D=3D SCM_RIGHTS) {<br>&gt; &=
gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fd_size =3D cmsg-&gt;cmsg_le=
n - CMSG_LEN(0);<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vm=
sg-&gt;fd_num =3D fd_size / sizeof(int);<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0memcpy(vmsg-&gt;fds, CMSG_DATA(cmsg), fd_size);<br>=
&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>&gt; &gt; + =
=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>&gt; &gt; + =C2=A0 =C2=A0}<br><br>&gt; I th=
ink the fd passing part becomes easier when you use the proper<br>&gt; qio_=
channel_readv_full() function. Its implementation is also a bit more<br>&gt=
; careful than yours. For example, you forgot checking fd_size against<br>&=
gt; VHOST_MEMORY_MAX_NREGIONS, allowing a buffer overflow in the memcpy(),<=
br>&gt; and you don&#39;t adjust fd flags for the new file descriptors.<br>=
<div><br></div><div>Oh, I used=C2=A0qio_channel_readv_full in v3&amp;v4. Bu=
t I still forgot checking fd_size against=C2=A0 VHOST_MEMORY_MAX_NREGIONS. =
I&#39;ll fix this buffer overflow issue in v5.</div><br><div class=3D"gmail=
_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jan 16, 2020 at 9:56 =
PM Kevin Wolf &lt;<a href=3D"mailto:kwolf@redhat.com" target=3D"_blank">kwo=
lf@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">Hi,<br>
<br>
I&#39;m only doing a quick first review pointing out the more obvious<br>
things while I familiarise myself with your code. I intend to review it<br>
in more detail later (either in a second pass for this series, or when<br>
you post v3).<br>
<br>
Am 14.01.2020 um 15:06 hat Coiby Xu geschrieben:<br>
&gt; By making use of libvhost, multiple block device drives can be exporte=
d and each drive can serve multiple clients simultaneously. Since vhost-use=
r-server needs a block drive to be created first, delay the creation of thi=
s object.<br>
&gt; <br>
&gt; Signed-off-by: Coiby Xu &lt;<a href=3D"mailto:coiby.xu@gmail.com" targ=
et=3D"_blank">coiby.xu@gmail.com</a>&gt;<br>
<br>
Please wrap the commit message at 72 characters.<br>
<br>
&gt;=C2=A0 blockdev-vu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =
1008 ++++++++++++++++++++++++++++++++++++<br>
&gt;=C2=A0 include/block/vhost-user.h |=C2=A0 =C2=A046 ++<br>
&gt;=C2=A0 vl.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 4 +<br>
&gt;=C2=A0 3 files changed, 1058 insertions(+)<br>
&gt;=C2=A0 create mode 100644 blockdev-vu.c<br>
&gt;=C2=A0 create mode 100644 include/block/vhost-user.h<br>
<br>
This adds a single, relatively big source file. I see at least two<br>
parts: The generic vhost-user infrastructure with connection handling<br>
etc. and the implementation of the specific vhost-user-blk device.<br>
Separating these into two files is probably a good idea.<br>
<br>
I would also suggest to put the files in a new subdirectory<br>
block/export/ and call them vhost-user.c/vhost-user-blk.c. The new<br>
header file can be in the same directory as it shouldn&#39;t be used by<br>
anyone else.<br>
<br>
&gt; diff --git a/blockdev-vu.c b/blockdev-vu.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..45f0bb43a7<br>
&gt; --- /dev/null<br>
&gt; +++ b/blockdev-vu.c<br>
&gt; @@ -0,0 +1,1008 @@<br>
<br>
The LICENSE file clarifies that files without a license header are<br>
GPLv2+, so it&#39;s not strictly a problem, but I think it is good style to=
<br>
include a license header that explicitly tells so.<br>
<br>
&gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt; +#include &quot;block/vhost-user.h&quot;<br>
&gt; +#include &quot;qapi/error.h&quot;<br>
&gt; +#include &quot;qapi/qapi-types-sockets.h&quot;<br>
&gt; +#include &quot;qapi/qapi-commands-block.h&quot;<br>
&gt; +<br>
&gt; +#include &quot;sysemu/block-backend.h&quot;<br>
&gt; +#include &quot;qemu/main-loop.h&quot;<br>
&gt; +<br>
&gt; +#include &quot;qemu/units.h&quot;<br>
&gt; +<br>
&gt; +#include &quot;block/block.h&quot;<br>
&gt; +<br>
&gt; +#include &quot;qom/object_interfaces.h&quot;<br>
&gt; +<br>
&gt; +#include &lt;sys/eventfd.h&gt;<br>
&gt; +<br>
&gt; +#include &quot;hw/qdev-properties.h&quot;<br>
<br>
Does the order of includes and the empty lines between them signify<br>
anything? If not, I suggest just sorting them alphabetically (and maybe<br>
using empty lines between different subdirectories if you like this<br>
better than a single large block).<br>
<br>
According to CODING_STYLE.rst, system headers like &lt;sys/eventfd.h&gt; co=
me<br>
before all QEMU headers (except qemu/osdep.h, which always must come<br>
first).<br>
<br>
&gt; +enum {<br>
&gt; +=C2=A0 =C2=A0 VHOST_USER_BLK_MAX_QUEUES =3D 8,<br>
&gt; +};<br>
&gt; +<br>
&gt; +struct virtio_blk_inhdr {<br>
&gt; +=C2=A0 =C2=A0 unsigned char status;<br>
&gt; +};<br>
&gt; +<br>
&gt; +<br>
&gt; +static QTAILQ_HEAD(, VubDev) vub_devs =3D QTAILQ_HEAD_INITIALIZER(vub=
_devs);<br>
&gt; +<br>
&gt; +<br>
&gt; +typedef struct VubReq {<br>
&gt; +=C2=A0 =C2=A0 VuVirtqElement *elem;<br>
<br>
Maybe worth a comment that this was allocated with plain malloc(), so<br>
you must use free() rather than g_free() (which would be the default in<br>
QEMU)?<br>
<br>
&gt; +=C2=A0 =C2=A0 int64_t sector_num;<br>
&gt; +=C2=A0 =C2=A0 size_t size;<br>
&gt; +=C2=A0 =C2=A0 struct virtio_blk_inhdr *in;<br>
&gt; +=C2=A0 =C2=A0 struct virtio_blk_outhdr out;<br>
&gt; +=C2=A0 =C2=A0 VuClient *client;<br>
&gt; +=C2=A0 =C2=A0 struct VuVirtq *vq;<br>
&gt; +} VubReq;<br>
<br>
I&#39;m not completely sure yet, but I think I would prefer VuBlock to Vub<=
br>
in the type names. Some may even prefer VhostUserBlock, but I can see<br>
that this would be quite lengthy.<br>
<br>
&gt; +static void<br>
&gt; +remove_watch(VuDev *vu_dev, int fd)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 VuClient *client;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 g_assert(vu_dev);<br>
&gt; +=C2=A0 =C2=A0 g_assert(fd &gt;=3D 0);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 client =3D container_of(vu_dev, VuClient, parent);<br>
&gt; +=C2=A0 =C2=A0 aio_set_fd_handler(client-&gt;blk-&gt;ctx, fd, false, N=
ULL, NULL, NULL, NULL);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void close_client(VuClient *client)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 vu_deinit(&amp;client-&gt;parent);<br>
&gt; +=C2=A0 =C2=A0 /** g_source_destroy(vub_device-&gt;parent.src); */<br>
<br>
Leftover from conversion?<br>
<br>
&gt; +=C2=A0 =C2=A0 client-&gt;sioc =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 object_unref(OBJECT(client-&gt;ioc));<br>
&gt; +=C2=A0 =C2=A0 client-&gt;closed =3D true;<br>
&gt; +<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void vub_panic_cb(VuDev *vu_dev, const char *buf)<br>
<br>
You use a lot of sprintf() before calling this function. Would it be<br>
worth taking a printf-like format parameter instead of buf and using a<br>
variable argument list?<br>
<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 if (buf) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_warning(&quot;vu_panic: %s&quot;, buf);=
<br>
<br>
I think QEMU proper doesn&#39;t use g_warning() anywhere. This could be<br>
error_report() or warn_report(). (Or if you use a format string<br>
error_vreport() and warn_vreport().)<br>
<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 VuClient *client =3D container_of(vu_dev, VuClient, par=
ent);<br>
&gt; +=C2=A0 =C2=A0 if (client-&gt;blk-&gt;exit_panic) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 client-&gt;blk-&gt;close =3D true;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 if (!client-&gt;closed) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 close_client(client);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +<br>
&gt; +static void vub_req_complete(VubReq *req)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 VuDev *vu_dev =3D &amp;req-&gt;client-&gt;parent;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* IO size with 1 extra status byte */<br>
&gt; +=C2=A0 =C2=A0 vu_queue_push(vu_dev, req-&gt;vq, req-&gt;elem,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 req-&g=
t;size + 1);<br>
<br>
I think this fits in a single line.<br>
<br>
&gt; +=C2=A0 =C2=A0 vu_queue_notify(vu_dev, req-&gt;vq);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (req-&gt;elem) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 free(req-&gt;elem);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 g_free(req);<br>
&gt; +}<br>
&gt; +<br>
&gt; +<br>
&gt; +<br>
&gt; +static int<br>
&gt; +vub_discard_write_zeroes(VubReq *req, struct iovec *iov, uint32_t iov=
cnt,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0uint32_t type)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 struct virtio_blk_discard_write_zeroes *desc;<br>
&gt; +=C2=A0 =C2=A0 ssize_t size;<br>
&gt; +=C2=A0 =C2=A0 void *buf;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 size =3D iov_size(iov, iovcnt);<br>
&gt; +=C2=A0 =C2=A0 if (size !=3D sizeof(*desc)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &quot;Invalid size %ld, e=
xpect %ld\n&quot;, size, sizeof(*desc));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
<br>
This would be error_report(), too. (More cases below, I&#39;ll ignore them<=
br>
now.)<br>
<br>
I would prefer consistent use of -errno instead of -1 for error cases if<br=
>
you don&#39;t mind. I guess this would be -EINVAL here. I won&#39;t mention=
 it<br>
for all the other cases; if you want to make the change, you need to<br>
make it everywhere, obviously.<br>
<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 buf =3D g_new0(char, size);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 iov_to_buf_full(iov, iovcnt, 0, buf, size);<br>
<br>
I think uint8_t describes better than char what we want here: A buffer<br>
of bytes.<br>
<br>
The empty line would make more sense to me above the g_new0() line than<br>
after it because it starts a new section that deals with the buffer. In<br>
general, the use of empty lines feels a bit inconsistent in this patch.<br>
You may want to go over them again.<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 #if defined(__linux__) &amp;&amp; defined(BLKDISCARD) &=
amp;&amp; defined(BLKZEROOUT)<br>
<br>
Preprocessor directives should be unindented.<br>
<br>
However, I don&#39;t think any of this code actually depends on Linux,<br>
BLKDISCARD or BLKZEROOUT. You can just call blk_pdiscard() and<br>
blk_pwrite_zeroes() and they will do whatever is necessary to perform<br>
the operation on the backend (which might not be a Linux block device,<br>
but could be a regular file or even using a network protocol like NBD).<br>
<br>
&gt; +=C2=A0 =C2=A0 VubDev *vdev_blk;<br>
&gt; +=C2=A0 =C2=A0 VuClient *client =3D container_of(dev, VuClient, parent=
);<br>
&gt; +=C2=A0 =C2=A0 vdev_blk =3D client-&gt;blk;<br>
&gt; +=C2=A0 =C2=A0 desc =3D (struct virtio_blk_discard_write_zeroes *)buf;=
<br>
&gt; +=C2=A0 =C2=A0 uint64_t range[2] =3D { le64toh(desc-&gt;sector) &lt;&l=
t; 9,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 le32toh(desc-&gt;num_sectors) &lt;&lt; 9 };<br>
&gt; +=C2=A0 =C2=A0 if (type =3D=3D VIRTIO_BLK_T_DISCARD) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (blk_pdiscard(vdev_blk-&gt;blk, range[=
0], range[1]) =3D=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(buf);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 } else if (type =3D=3D VIRTIO_BLK_T_WRITE_ZEROES) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (blk_pwrite_zeroes(vdev_blk-&gt;blk, r=
ange[0], range[1]) =3D=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(buf);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
blk_pdiscard() and blk_pwrite_zeroes() are synchronous functions. In<br>
other words, the guest will be blocked until the I/O is complete. We<br>
cannot do this.<br>
<br>
I think you should let vub_virtio_process_req() run in a coroutine so<br>
that you can call blk_co_pdiscard() and blk_co_pwrite_zeroes() here.<br>
<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 #endif<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 g_free(buf);<br>
&gt; +=C2=A0 =C2=A0 return -1;<br>
&gt; +}<br>
&gt; +<br>
&gt; +<br>
&gt; +static void<br>
&gt; +vub_flush(VubReq *req)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 VuClient *client =3D req-&gt;client;<br>
&gt; +=C2=A0 =C2=A0 blk_co_flush(client-&gt;blk-&gt;backend);<br>
<br>
You can&#39;t call blk_co_flush() from outside coroutine context. This code=
<br>
will be right after you move vub_virtio_process_req() to a coroutine,<br>
though (which will make this function a coroutine_fn).<br>
<br>
&gt; +}<br>
&gt; +<br>
&gt; +<br>
&gt; +#define NOT_DONE 0x7fffffff /* used while emulated sync operation in =
progress */<br>
&gt; +typedef struct BlkRwCo {<br>
&gt; +=C2=A0 =C2=A0 BlockBackend *blk;<br>
&gt; +=C2=A0 =C2=A0 int64_t offset;<br>
&gt; +=C2=A0 =C2=A0 void *iobuf;<br>
&gt; +=C2=A0 =C2=A0 int ret;<br>
&gt; +=C2=A0 =C2=A0 BdrvRequestFlags flags;<br>
&gt; +} BlkRwCo;<br>
&gt; +<br>
&gt; +static void blk_read_entry(void *opaque)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 BlkRwCo *rwco =3D opaque;<br>
&gt; +=C2=A0 =C2=A0 QEMUIOVector *qiov =3D rwco-&gt;iobuf;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 rwco-&gt;ret =3D blk_co_preadv(rwco-&gt;blk, rwco-&gt;o=
ffset, qiov-&gt;size,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qiov, rwco-&gt;flags);<br>
&gt; +=C2=A0 =C2=A0 aio_wait_kick();<br>
&gt; +}<br>
&gt; +<br>
&gt; +<br>
&gt; +static void blk_write_entry(void *opaque)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 BlkRwCo *rwco =3D opaque;<br>
&gt; +=C2=A0 =C2=A0 QEMUIOVector *qiov =3D rwco-&gt;iobuf;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 rwco-&gt;ret =3D blk_co_pwritev(rwco-&gt;blk, rwco-&gt;=
offset, qiov-&gt;size,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qiov, rwco-&gt;flags);<br>
&gt; +=C2=A0 =C2=A0 aio_wait_kick();<br>
&gt; +}<br>
&gt; +<br>
&gt; +<br>
&gt; +static int blk_prw(BlockBackend *blk, QEMUIOVector *qiov, int64_t off=
set,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
CoroutineEntry co_entry, BdrvRequestFlags flags)<br>
&gt; +{<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 BlkRwCo rwco =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .blk=C2=A0 =C2=A0 =3D blk,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .offset =3D offset,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .iobuf=C2=A0 =3D qiov,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .flags=C2=A0 =3D flags,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .ret=C2=A0 =C2=A0 =3D NOT_DONE,<br>
&gt; +=C2=A0 =C2=A0 };<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (qemu_in_coroutine()) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Fast-path if already in coroutine cont=
ext */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 co_entry(&amp;rwco);<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 Coroutine *co =3D qemu_coroutine_create(c=
o_entry, &amp;rwco);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 bdrv_coroutine_enter(blk_bs(blk), co);<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 BDRV_POLL_WHILE(blk_bs(blk), rwco.ret =3D=
=3D NOT_DONE);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return rwco.ret;<br>
&gt; +}<br>
<br>
This is copy&amp;paste from block-backend.c. We should certainly not do<br>
this. I think it will automatically go away when you can use<br>
blk_co_preadv() and blk_co_pwritev() directly.<br>
<br>
Note that the BDRV_POLL_WHILE() means that like above, we would be<br>
waiting for the request to complete. This would block the guest and<br>
would also not allow parallel requests, killing the I/O performance of<br>
our vhost-user export.<br>
<br>
&gt; +<br>
&gt; +static ssize_t<br>
&gt; +vub_rwv(VubReq *req, struct iovec *iov,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t iovcnt,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 CoroutineEntry co_entry)<br>
<br>
I don&#39;t understand the line wrapping here. :-)<br>
<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 VuClient *client =3D req-&gt;client;<br>
&gt; +=C2=A0 =C2=A0 ssize_t rc;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!iovcnt) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &quot;Invalid Read/Write =
IOV count\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 int64_t offset =3D req-&gt;sector_num * 512;<br>
&gt; +=C2=A0 =C2=A0 QEMUIOVector *qiov =3D g_new0(QEMUIOVector, 1);<br>
&gt; +=C2=A0 =C2=A0 qemu_iovec_init_external(qiov, iov, iovcnt);<br>
&gt; +=C2=A0 =C2=A0 rc =3D blk_prw(client-&gt;blk-&gt;backend, qiov, offset=
, co_entry, 0);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 req-&gt;size =3D iov_size(iov, iovcnt);<br>
<br>
You can use qiov-&gt;size instead of duplicating this information into a<br=
>
separate VubReq field.<br>
<br>
&gt; +=C2=A0 =C2=A0 if (rc &lt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &quot;%s, Sector %&quot;P=
RIu64&quot;, Size %lu failed with %s\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 client-&gt;bl=
k-&gt;name, req-&gt;sector_num, req-&gt;size,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strerror(errn=
o));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return rc;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int vub_virtio_process_req(VuClient *client,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VuVirtq *vq)=
<br>
<br>
Indentation is off. This could be a single line anyway.<br>
<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 VuDev *vu_dev =3D &amp;client-&gt;parent;<br>
&gt; +=C2=A0 =C2=A0 VuVirtqElement *elem;<br>
&gt; +=C2=A0 =C2=A0 uint32_t type;<br>
&gt; +=C2=A0 =C2=A0 VubReq *req;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 elem =3D vu_queue_pop(vu_dev, vq, sizeof(VuVirtqElement=
) + sizeof(VubReq));<br>
&gt; +=C2=A0 =C2=A0 if (!elem) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 struct iovec *in_iov =3D elem-&gt;in_sg;<br>
&gt; +=C2=A0 =C2=A0 struct iovec *out_iov =3D elem-&gt;out_sg;<br>
&gt; +=C2=A0 =C2=A0 unsigned in_num =3D elem-&gt;in_num;<br>
&gt; +=C2=A0 =C2=A0 unsigned out_num =3D elem-&gt;out_num;<br>
&gt; +=C2=A0 =C2=A0 /* refer to hw/block/virtio_blk.c */<br>
&gt; +=C2=A0 =C2=A0 if (elem-&gt;out_num &lt; 1 || elem-&gt;in_num &lt; 1) =
{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &quot;virtio-blk request =
missing headers\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 free(elem);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 req =3D g_new0(VubReq, 1);<br>
&gt; +=C2=A0 =C2=A0 req-&gt;client =3D client;<br>
&gt; +=C2=A0 =C2=A0 req-&gt;vq =3D vq;<br>
&gt; +=C2=A0 =C2=A0 req-&gt;elem =3D elem;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (unlikely(iov_to_buf(out_iov, out_num, 0, &amp;req-&=
gt;out,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(req-&gt;out)) !=3D sizeof(req-&gt;out))=
) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &quot;virtio-blk request =
outhdr too short&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 iov_discard_front(&amp;out_iov, &amp;out_num, sizeof(re=
q-&gt;out));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (in_iov[in_num - 1].iov_len &lt; sizeof(struct virti=
o_blk_inhdr)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &quot;virtio-blk request =
inhdr too short&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* We always touch the last byte, so just see how big i=
n_iov is.=C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 req-&gt;in =3D (void *)in_iov[in_num - 1].iov_base<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 + in_iov[in_num - 1]=
.iov_len<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - sizeof(struct virt=
io_blk_inhdr);<br>
&gt; +=C2=A0 =C2=A0 iov_discard_back(in_iov, &amp;in_num, sizeof(struct vir=
tio_blk_inhdr));<br>
&gt; +<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 type =3D le32toh(req-&gt;out.type);<br>
&gt; +=C2=A0 =C2=A0 switch (type &amp; ~VIRTIO_BLK_T_BARRIER) {<br>
&gt; +=C2=A0 =C2=A0 case VIRTIO_BLK_T_IN:<br>
&gt; +=C2=A0 =C2=A0 case VIRTIO_BLK_T_OUT: {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ssize_t ret =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool is_write =3D type &amp; VIRTIO_BLK_T=
_OUT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 req-&gt;sector_num =3D le64toh(req-&gt;ou=
t.sector);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (is_write) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D vub_rwv(req, out_io=
v, out_num, blk_write_entry);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D vub_rwv(req, in_iov=
, in_num, blk_read_entry);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &gt;=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 req-&gt;in-&gt;status =3D V=
IRTIO_BLK_S_OK;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 req-&gt;in-&gt;status =3D V=
IRTIO_BLK_S_IOERR;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 vub_req_complete(req);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 case VIRTIO_BLK_T_FLUSH:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 vub_flush(req);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 req-&gt;in-&gt;status =3D VIRTIO_BLK_S_OK=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 vub_req_complete(req);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case VIRTIO_BLK_T_GET_ID: {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t size =3D MIN(iov_size(&amp;elem-&g=
t;in_sg[0], in_num),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 VIRTIO_BLK_ID_BYTES);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 snprintf(elem-&gt;in_sg[0].iov_base, size=
, &quot;%s&quot;, &quot;vhost_user_blk&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 req-&gt;in-&gt;status =3D VIRTIO_BLK_S_OK=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 req-&gt;size =3D elem-&gt;in_sg[0].iov_le=
n;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 vub_req_complete(req);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 case VIRTIO_BLK_T_DISCARD:<br>
&gt; +=C2=A0 =C2=A0 case VIRTIO_BLK_T_WRITE_ZEROES: {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int rc;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 rc =3D vub_discard_write_zeroes(req, &amp=
;elem-&gt;out_sg[1], out_num, type);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rc =3D=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 req-&gt;in-&gt;status =3D V=
IRTIO_BLK_S_OK;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 req-&gt;in-&gt;status =3D V=
IRTIO_BLK_S_IOERR;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 vub_req_complete(req);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 req-&gt;in-&gt;status =3D VIRTIO_BLK_S_UN=
SUPP;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 vub_req_complete(req);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +<br>
&gt; +err:<br>
&gt; +=C2=A0 =C2=A0 free(elem);<br>
&gt; +=C2=A0 =C2=A0 g_free(req);<br>
&gt; +=C2=A0 =C2=A0 return -1;<br>
&gt; +}<br>
&gt; +<br>
&gt; +<br>
&gt; +static void vub_process_vq(VuDev *vu_dev, int idx)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 VuClient *client;<br>
&gt; +=C2=A0 =C2=A0 VuVirtq *vq;<br>
&gt; +=C2=A0 =C2=A0 int ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 client =3D container_of(vu_dev, VuClient, parent);<br>
&gt; +=C2=A0 =C2=A0 assert(client);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 vq =3D vu_get_queue(vu_dev, idx);<br>
&gt; +=C2=A0 =C2=A0 assert(vq);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 while (1) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D vub_virtio_process_req(client, vq=
);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
<br>
I mentioned above moving vub_virtio_process_req() into a coroutine. Just<br=
>
creating a coroutine here and entering it wouldn&#39;t work, though.<br>
<br>
The best design is probably to get requests from the virtqueue in this<br>
function (what is currently the first half of vub_virtio_process_req())<br>
and then spawn a coroutine per request to actually execute them (roughly<br=
>
the switch in vub_virtio_process_req()).<br>
<br>
This way you&#39;ll get parallel requests and won&#39;t have to think about=
<br>
synchronising accesses to the virtqueue from multiple coroutines.<br>
<br>
&gt; +<br>
&gt; +static void vub_queue_set_started(VuDev *vu_dev, int idx, bool starte=
d)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 VuVirtq *vq;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 assert(vu_dev);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 vq =3D vu_get_queue(vu_dev, idx);<br>
&gt; +=C2=A0 =C2=A0 vu_set_queue_handler(vu_dev, vq, started ? vub_process_=
vq : NULL);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static uint64_t<br>
&gt; +vub_get_features(VuDev *dev)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 uint64_t features;<br>
&gt; +=C2=A0 =C2=A0 VubDev *vdev_blk;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 VuClient *client =3D container_of(dev, VuClient, parent=
);<br>
&gt; +=C2=A0 =C2=A0 vdev_blk =3D client-&gt;blk;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 features =3D 1ull &lt;&lt; VIRTIO_BLK_F_SIZE_MAX |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01ull &lt;&lt; =
VIRTIO_BLK_F_SEG_MAX |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01ull &lt;&lt; =
VIRTIO_BLK_F_TOPOLOGY |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01ull &lt;&lt; =
VIRTIO_BLK_F_BLK_SIZE |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01ull &lt;&lt; =
VIRTIO_BLK_F_FLUSH |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#if defined(__=
linux__) &amp;&amp; defined(BLKDISCARD) &amp;&amp; defined(BLKZEROOUT)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01ull &lt;&lt; =
VIRTIO_BLK_F_DISCARD |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01ull &lt;&lt; =
VIRTIO_BLK_F_WRITE_ZEROES |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#endif<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01ull &lt;&lt; =
VIRTIO_BLK_F_CONFIG_WCE |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01ull &lt;&lt; =
VIRTIO_F_VERSION_1 |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01ull &lt;&lt; =
VIRTIO_RING_F_INDIRECT_DESC |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01ull &lt;&lt; =
VIRTIO_RING_F_EVENT_IDX |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01ull &lt;&lt; =
VHOST_USER_F_PROTOCOL_FEATURES;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!vdev_blk-&gt;writable) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 features |=3D 1ull &lt;&lt; VIRTIO_BLK_F_=
RO;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return features;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static uint64_t<br>
&gt; +vub_get_protocol_features(VuDev *dev)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 return 1ull &lt;&lt; VHOST_USER_PROTOCOL_F_CONFIG |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01ull &lt;&lt; VHOST_USER_PRO=
TOCOL_F_INFLIGHT_SHMFD;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int<br>
&gt; +vub_get_config(VuDev *vu_dev, uint8_t *config, uint32_t len)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 VubDev *vdev_blk;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 VuClient *client =3D container_of(vu_dev, VuClient, par=
ent);<br>
&gt; +=C2=A0 =C2=A0 vdev_blk =3D client-&gt;blk;<br>
&gt; +=C2=A0 =C2=A0 memcpy(config, &amp;vdev_blk-&gt;blkcfg, len);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int<br>
&gt; +vub_set_config(VuDev *vu_dev, const uint8_t *data,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t offse=
t, uint32_t size, uint32_t flags)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 VubDev *vdev_blk;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 VuClient *client =3D container_of(vu_dev, VuClient, par=
ent);<br>
&gt; +=C2=A0 =C2=A0 vdev_blk =3D client-&gt;blk;<br>
&gt; +=C2=A0 =C2=A0 uint8_t wce;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* don&#39;t support live migration */<br>
&gt; +=C2=A0 =C2=A0 if (flags !=3D VHOST_SET_CONFIG_TYPE_MASTER) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (offset !=3D offsetof(struct virtio_blk_config, wce)=
 ||<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 size !=3D 1) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 wce =3D *data;<br>
&gt; +=C2=A0 =C2=A0 if (wce =3D=3D vdev_blk-&gt;blkcfg.wce) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Do nothing as same with old configurat=
ion */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 vdev_blk-&gt;blkcfg.wce =3D wce;<br>
&gt; +=C2=A0 =C2=A0 blk_set_enable_write_cache(vdev_blk-&gt;backend, true);=
<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * When the client disconnects, it send a VHOST_USER_NONE request<br>
<br>
s/send/sends/<br>
<br>
&gt; + * and vu_process_message will simple call exit which cause the VM<br=
>
&gt; + * to exit abruptly.<br>
&gt; + * To avoid this issue,=C2=A0 process VHOST_USER_NONE request ahead<b=
r>
&gt; + * of vu_process_message.<br>
&gt; + *<br>
&gt; + */<br>
&gt; +static int vub_process_msg(VuDev *dev, VhostUserMsg *vmsg, int *do_re=
ply)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 if (vmsg-&gt;request =3D=3D VHOST_USER_NONE) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev-&gt;panic(dev, &quot;disconnect&quot;=
);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 return false;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void<br>
&gt; +vmsg_close_fds(VhostUserMsg *vmsg)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 int i;<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; vmsg-&gt;fd_num; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 close(vmsg-&gt;fds[i]);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static bool<br>
&gt; +vu_message_read_co(VuDev *vu_dev, int conn_fd, VhostUserMsg *vmsg)<br=
>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 char control[CMSG_SPACE(VHOST_MEMORY_MAX_NREGIONS * siz=
eof(int))] =3D { };<br>
&gt; +=C2=A0 =C2=A0 struct iovec iov =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .iov_base =3D (char *)vmsg,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .iov_len =3D VHOST_USER_HDR_SIZE,<br>
&gt; +=C2=A0 =C2=A0 };<br>
&gt; +=C2=A0 =C2=A0 struct msghdr msg =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .msg_iov =3D &amp;iov,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .msg_iovlen =3D 1,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .msg_control =3D control,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .msg_controllen =3D sizeof(control),<br>
&gt; +=C2=A0 =C2=A0 };<br>
&gt; +=C2=A0 =C2=A0 size_t fd_size;<br>
&gt; +=C2=A0 =C2=A0 struct cmsghdr *cmsg;<br>
&gt; +=C2=A0 =C2=A0 int rc;<br>
&gt; +=C2=A0 =C2=A0 char buffer[100];<br>
&gt; +=C2=A0 =C2=A0 VuClient *client =3D container_of(vu_dev, VuClient, par=
ent);<br>
&gt; +=C2=A0 =C2=A0 QIOChannel *ioc =3D client-&gt;ioc;<br>
&gt; +=C2=A0 =C2=A0 do {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 rc =3D recvmsg(conn_fd, &amp;msg, 0);<br>
<br>
This should certainly use qio_channel_readv_full() rather than working<br>
directly with a socket fd?<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rc &lt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (errno =3D=3D EAGAIN) {<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (qemu_in_c=
oroutine()) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 qio_channel_yield(ioc, G_IO_IN);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 qio_channel_wait(ioc, G_IO_IN);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (errno =3D=3D EIN=
TR) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 } while (true);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (rc &lt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sprintf(buffer, &quot;Error while recvmsg=
: %s&quot;, strerror(errno));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 vub_panic_cb(vu_dev, buffer);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 assert(rc =3D=3D VHOST_USER_HDR_SIZE || rc =3D=3D 0);<b=
r>
<br>
Why do you think that there can&#39;t be short reads?<br>
<br>
&gt; +=C2=A0 =C2=A0 vmsg-&gt;fd_num =3D 0;<br>
&gt; +=C2=A0 =C2=A0 for (cmsg =3D CMSG_FIRSTHDR(&amp;msg);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cmsg !=3D NULL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cmsg =3D CMSG_NXTHDR(&amp;msg, cmsg=
))<br>
&gt; +=C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cmsg-&gt;cmsg_level =3D=3D SOL_SOCKET=
 &amp;&amp; cmsg-&gt;cmsg_type =3D=3D SCM_RIGHTS) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fd_size =3D cmsg-&gt;cmsg_l=
en - CMSG_LEN(0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vmsg-&gt;fd_num =3D fd_size=
 / sizeof(int);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memcpy(vmsg-&gt;fds, CMSG_D=
ATA(cmsg), fd_size);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
<br>
I think the fd passing part becomes easier when you use the proper<br>
qio_channel_readv_full() function. Its implementation is also a bit more<br=
>
careful than yours. For example, you forgot checking fd_size against<br>
VHOST_MEMORY_MAX_NREGIONS, allowing a buffer overflow in the memcpy(),<br>
and you don&#39;t adjust fd flags for the new file descriptors.<br>
<br>
&gt; +=C2=A0 =C2=A0 if (vmsg-&gt;size &gt; sizeof(vmsg-&gt;payload)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sprintf(buffer,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Error: =
too big message request: %d, size: vmsg-&gt;size: %u, &quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;while s=
izeof(vmsg-&gt;payload) =3D %zu\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vmsg-&gt;requ=
est, vmsg-&gt;size, sizeof(vmsg-&gt;payload));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 vub_panic_cb(vu_dev, buffer);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto fail;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (vmsg-&gt;size) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 do {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rc =3D read(conn_fd, &amp;v=
msg-&gt;payload, vmsg-&gt;size);<br>
<br>
qio_channel_readv_all_eof() already implements this whole loop and<br>
correctly handles short reads, too.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rc &lt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (errno =3D=
=3D EAGAIN) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 if (qemu_in_coroutine()) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 qio_channel_yield(ioc, G_IO_IN);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 qio_channel_wait(ioc, G_IO_IN);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 continue;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (er=
rno =3D=3D EINTR) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 continue;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } while (true);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rc &lt;=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sprintf(buffer, &quot;Error=
 while reading: %s&quot;, strerror(errno));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vub_panic_cb(vu_dev, buffer=
);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto fail;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(rc =3D=3D vmsg-&gt;size);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return true;<br>
&gt; +<br>
&gt; +fail:<br>
&gt; +=C2=A0 =C2=A0 vmsg_close_fds(vmsg);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return false;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void vub_kick_cb(void *opaque)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 vu_watch_cb_data *data =3D (vu_watch_cb_data *) opaque;=
<br>
&gt; +=C2=A0 =C2=A0 int index =3D data-&gt;index;<br>
&gt; +=C2=A0 =C2=A0 VuDev *dev =3D data-&gt;vu_dev;<br>
&gt; +=C2=A0 =C2=A0 VuVirtq *vq =3D &amp;dev-&gt;vq[index];<br>
&gt; +=C2=A0 =C2=A0 int sock =3D vq-&gt;kick_fd;<br>
&gt; +=C2=A0 =C2=A0 eventfd_t kick_data;<br>
&gt; +=C2=A0 =C2=A0 ssize_t rc;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 rc =3D eventfd_read(sock, &amp;kick_data);<br>
&gt; +=C2=A0 =C2=A0 if (rc =3D=3D -1) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 char buffer[100];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sprintf(buffer, &quot;kick eventfd_read()=
: %s&quot;, strerror(errno));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 vub_panic_cb(dev, buffer);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(data);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev-&gt;remove_watch(dev, dev-&gt;vq[inde=
x].kick_fd);<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (vq-&gt;handler) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vq-&gt;handler(dev, index);=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const VuDevIface vub_iface =3D {<br>
&gt; +=C2=A0 =C2=A0 .get_features =3D vub_get_features,<br>
&gt; +=C2=A0 =C2=A0 .queue_set_started =3D vub_queue_set_started,<br>
&gt; +=C2=A0 =C2=A0 .get_protocol_features =3D vub_get_protocol_features,<b=
r>
&gt; +=C2=A0 =C2=A0 .get_config =3D vub_get_config,<br>
&gt; +=C2=A0 =C2=A0 .set_config =3D vub_set_config,<br>
&gt; +=C2=A0 =C2=A0 .process_msg =3D vub_process_msg,<br>
&gt; +=C2=A0 =C2=A0 .read_msg =3D vu_message_read_co,<br>
&gt; +=C2=A0 =C2=A0 .kick_callback =3D vub_kick_cb,<br>
&gt; +};<br>
<br>
I would prefer the =3D signs to be aligned to the same column.<br>
<br>
&gt; +<br>
&gt; +void vub_free(VubDev *vub_dev, bool called_by_QOM)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 if (!vub_dev) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 blk_unref(vub_dev-&gt;backend);<br>
&gt; +=C2=A0 =C2=A0 g_free(vub_dev-&gt;name);<br>
&gt; +=C2=A0 =C2=A0 g_free(vub_dev-&gt;unix_socket);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (vub_dev-&gt;next.tqe_circ.tql_prev) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* if vub_dev-&gt;next.tqe_circ.tql_=
prev =3D null,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* vub_dev hasn&#39;t been inserted =
into the queue and<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* vub_free is called by obj-&gt;ins=
tance_finalize.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 QTAILQ_REMOVE(&amp;vub_devs, vub_dev, nex=
t);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* Needn&#39;t to free vub_dev if called by QOM<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0* because QOM will do the clean-up work.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 if (!called_by_QOM) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(vub_dev);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static coroutine_fn void vu_client_trip(void *opaque)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 VuClient *client =3D opaque;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 while (!client-&gt;closed) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 vu_dispatch(&amp;client-&gt;parent);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 QTAILQ_REMOVE(&amp;client-&gt;blk-&gt;clients, client, =
next);<br>
&gt; +<br>
<br>
Extra empty line.<br>
<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void vu_client_start(VuClient *client)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 Coroutine *co =3D qemu_coroutine_create(vu_client_trip,=
 client);<br>
&gt; +=C2=A0 =C2=A0 qemu_coroutine_enter(co);<br>
&gt; +}<br>
&gt; +<br>
&gt; +<br>
&gt; +G_STATIC_ASSERT((int)G_IO_IN =3D=3D (int)VU_WATCH_IN);<br>
&gt; +G_STATIC_ASSERT((int)G_IO_OUT =3D=3D (int)VU_WATCH_OUT);<br>
&gt; +G_STATIC_ASSERT((int)G_IO_PRI =3D=3D (int)VU_WATCH_PRI);<br>
&gt; +G_STATIC_ASSERT((int)G_IO_ERR =3D=3D (int)VU_WATCH_ERR);<br>
&gt; +G_STATIC_ASSERT((int)G_IO_HUP =3D=3D (int)VU_WATCH_HUP);<br>
&gt; +<br>
&gt; +static void<br>
&gt; +set_watch(VuDev *vu_dev, int fd, int vu_evt,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vu_watch_cb_packed_data cb, void *=
pvt)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* since aio_dispatch can only pass one user data =
pointer to the<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* callback function, pack VuDev, pvt into a struc=
t<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 VuClient *client;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 g_assert(vu_dev);<br>
&gt; +=C2=A0 =C2=A0 g_assert(fd &gt;=3D 0);<br>
&gt; +=C2=A0 =C2=A0 g_assert(cb);<br>
&gt; +=C2=A0 =C2=A0 client =3D container_of(vu_dev, VuClient, parent);<br>
&gt; +=C2=A0 =C2=A0 vu_watch_cb_data *cb_data =3D g_new0(vu_watch_cb_data, =
1);<br>
&gt; +=C2=A0 =C2=A0 cb_data-&gt;index =3D (intptr_t) pvt;<br>
&gt; +=C2=A0 =C2=A0 cb_data-&gt;vu_dev =3D vu_dev;<br>
&gt; +=C2=A0 =C2=A0 aio_set_fd_handler(client-&gt;blk-&gt;ctx, fd, false, (=
void *) cb,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0NULL, NULL, cb_data);<br>
&gt; +}<br>
&gt; +<br>
&gt; +<br>
&gt; +void vub_accept(QIONetListener *listener, QIOChannelSocket *sioc,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gpointer opaq=
ue)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 VuClient *client;<br>
&gt; +=C2=A0 =C2=A0 VubDev *vub_device =3D opaque;<br>
&gt; +=C2=A0 =C2=A0 client =3D g_new0(VuClient, 1);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!vu_init_packed_data(&amp;client-&gt;parent, VHOST_=
USER_BLK_MAX_QUEUES,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sioc-&gt;fd, vub_panic_cb, set_watch,<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0remove_watch, &amp;vub_iface)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &quot;Failed to initializ=
ed libvhost-user\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(client);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 client-&gt;blk =3D vub_device;<br>
&gt; +=C2=A0 =C2=A0 client-&gt;refcount =3D 1;<br>
&gt; +=C2=A0 =C2=A0 client-&gt;sioc =3D sioc;<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* increase the object reference, so cioc will not=
 freed by<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* qio_net_listener_channel_func which will call o=
bject_unref(OBJECT(sioc))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 object_ref(OBJECT(client-&gt;sioc));<br>
&gt; +=C2=A0 =C2=A0 qio_channel_set_name(QIO_CHANNEL(sioc), &quot;vhost-use=
r client&quot;);<br>
&gt; +=C2=A0 =C2=A0 client-&gt;ioc =3D QIO_CHANNEL(sioc);<br>
&gt; +=C2=A0 =C2=A0 object_ref(OBJECT(client-&gt;ioc));<br>
&gt; +=C2=A0 =C2=A0 object_ref(OBJECT(sioc));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qio_channel_set_blocking(QIO_CHANNEL(client-&gt;sioc), =
false, NULL);<br>
&gt; +=C2=A0 =C2=A0 client-&gt;closed =3D false;<br>
&gt; +=C2=A0 =C2=A0 QTAILQ_INSERT_TAIL(&amp;client-&gt;blk-&gt;clients, cli=
ent, next);<br>
&gt; +=C2=A0 =C2=A0 vu_client_start(client);<br>
&gt; +}<br>
&gt; +<br>
&gt; +<br>
&gt; +void<br>
&gt; +vub_initialize_config(BlockDriverState *bs, struct virtio_blk_config =
*config)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 config-&gt;capacity =3D bdrv_getlength(bs) &gt;&gt; BDR=
V_SECTOR_BITS;<br>
&gt; +=C2=A0 =C2=A0 config-&gt;blk_size =3D BDRV_SECTOR_SIZE;<br>
&gt; +=C2=A0 =C2=A0 config-&gt;size_max =3D 65536;<br>
&gt; +=C2=A0 =C2=A0 config-&gt;seg_max =3D 128 - 2;<br>
&gt; +=C2=A0 =C2=A0 config-&gt;min_io_size =3D 1;<br>
&gt; +=C2=A0 =C2=A0 config-&gt;opt_io_size =3D 1;<br>
&gt; +=C2=A0 =C2=A0 config-&gt;num_queues =3D 1;<br>
&gt; +=C2=A0 =C2=A0 #if defined(__linux__) &amp;&amp; defined(BLKDISCARD) &=
amp;&amp; defined(BLKZEROOUT)<br>
&gt; +=C2=A0 =C2=A0 config-&gt;max_discard_sectors =3D 32768;<br>
&gt; +=C2=A0 =C2=A0 config-&gt;max_discard_seg =3D 1;<br>
&gt; +=C2=A0 =C2=A0 config-&gt;discard_sector_alignment =3D config-&gt;blk_=
size &gt;&gt; 9;<br>
&gt; +=C2=A0 =C2=A0 config-&gt;max_write_zeroes_sectors =3D 32768;<br>
&gt; +=C2=A0 =C2=A0 config-&gt;max_write_zeroes_seg =3D 1;<br>
&gt; +=C2=A0 =C2=A0 #endif<br>
&gt; +}<br>
&gt; +<br>
&gt; +<br>
&gt; +static VubDev *vub_new(VubDev *vub_device, const char *name,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0const char *unix_socket, bool writable, Error **errp)<br>
&gt; +{<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 BlockBackend *blk;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* Don&#39;t allow resize while the vhost user ser=
ver is running,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0* otherwise we don&#39;t care what happens with t=
he node.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 uint64_t perm =3D BLK_PERM_CONSISTENT_READ;<br>
&gt; +=C2=A0 =C2=A0 int ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 AioContext *ctx;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 BlockDriverState *bs =3D bdrv_lookup_bs(name,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 name,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 errp);<br>
<br>
This fits in a single line.<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!bs) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
&quot;No drive with name &#39;%s&#39;.&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
&quot; Please find the list of names with &quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
&quot;&#39;info block&#39;&quot;, name);<br>
<br>
This can probably be two lines instead of four.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (bdrv_is_read_only(bs)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 writable =3D false;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (writable) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 perm |=3D BLK_PERM_WRITE;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 ctx =3D bdrv_get_aio_context(bs);<br>
&gt; +=C2=A0 =C2=A0 aio_context_acquire(ctx);<br>
&gt; +=C2=A0 =C2=A0 bdrv_invalidate_cache(bs, NULL);<br>
&gt; +=C2=A0 =C2=A0 aio_context_release(ctx);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 blk =3D blk_new(bdrv_get_aio_context(bs), perm,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BLK_PE=
RM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BLK_PE=
RM_WRITE | BLK_PERM_GRAPH_MOD);<br>
&gt; +=C2=A0 =C2=A0 ret =3D blk_insert_bs(blk, bs, errp);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (ret &lt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto fail;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 blk_set_enable_write_cache(blk, false);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 blk_set_allow_aio_context_change(blk, true);<br>
&gt; +<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 vub_device-&gt;name =3D g_strdup(name);<br>
&gt; +=C2=A0 =C2=A0 vub_device-&gt;unix_socket =3D g_strdup(unix_socket);<b=
r>
&gt; +=C2=A0 =C2=A0 vub_device-&gt;writable =3D writable;<br>
&gt; +=C2=A0 =C2=A0 vub_device-&gt;blkcfg.wce =3D 0;<br>
&gt; +=C2=A0 =C2=A0 vub_device-&gt;backend =3D blk;<br>
&gt; +=C2=A0 =C2=A0 vub_device-&gt;ctx =3D ctx;<br>
&gt; +=C2=A0 =C2=A0 vub_initialize_config(bs, &amp;vub_device-&gt;blkcfg);<=
br>
&gt; +=C2=A0 =C2=A0 return vub_device;<br>
&gt; +<br>
&gt; +fail:<br>
&gt; +=C2=A0 =C2=A0 blk_unref(blk);<br>
&gt; +=C2=A0 =C2=A0 return NULL;<br>
&gt; +}<br>
&gt; +<br>
&gt; +void vhost_user_server_free(VubDev *vub_device, bool called_by_QOM)<b=
r>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 if (!vub_device) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 VuClient *client, *next;<br>
&gt; +=C2=A0 =C2=A0 QTAILQ_FOREACH_SAFE(client, &amp;vub_device-&gt;clients=
, next, next) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!client-&gt;closed) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 close_client(client);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (vub_device-&gt;listener) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qio_net_listener_disconnect(vub_device-&g=
t;listener);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_unref(OBJECT(vub_device-&gt;listen=
er));<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 vub_free(vub_device, called_by_QOM);<br>
&gt; +<br>
&gt; +}<br>
&gt; +<br>
&gt; +<br>
&gt; +VubDev *vub_dev_find(const char *name)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 VubDev *vub_device;<br>
&gt; +=C2=A0 =C2=A0 QTAILQ_FOREACH(vub_device, &amp;vub_devs, next) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (strcmp(name, vub_device-&gt;name) =3D=
=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return vub_device;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return NULL;<br>
&gt; +}<br>
&gt; +<br>
&gt; +<br>
&gt; +static VubDev *vub_dev_find_by_unix_socket(const char *unix_socket)<b=
r>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 VubDev *vub_device;<br>
&gt; +=C2=A0 =C2=A0 QTAILQ_FOREACH(vub_device, &amp;vub_devs, next) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (strcmp(unix_socket, vub_device-&gt;un=
ix_socket) =3D=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return vub_device;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return NULL;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void vhost_user_server_start(VubDev *vub_device, const char *u=
nix_socket,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *name, =
bool writable,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Error **errp)<br>
&gt; +{<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (vub_dev_find(name) || vub_dev_find_by_unix_socket(u=
nix_socket)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Vhost user server =
with name &#39;%s&#39; or &quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;with so=
cket_path &#39;%s&#39; has already been started&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 name, unix_so=
cket);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!vub_new(vub_device, name, unix_socket, writable, e=
rrp)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 vub_device-&gt;listener =3D qio_net_listener_new();<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qio_net_listener_set_name(vub_device-&gt;listener,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;vhost-user-backend-listener&quot;=
);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 SocketAddress *addr =3D g_new0(SocketAddress, 1);<br>
&gt; +=C2=A0 =C2=A0 addr-&gt;u.q_unix.path =3D (char *) unix_socket;<br>
&gt; +=C2=A0 =C2=A0 addr-&gt;type =3D SOCKET_ADDRESS_TYPE_UNIX;<br>
&gt; +=C2=A0 =C2=A0 if (qio_net_listener_open_sync(vub_device-&gt;listener,=
 addr, 1, errp) &lt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 QTAILQ_INSERT_TAIL(&amp;vub_devs, vub_device, next);<br=
>
&gt; +=C2=A0 =C2=A0 QTAILQ_INIT(&amp;vub_device-&gt;clients);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qio_net_listener_set_client_func(vub_device-&gt;listene=
r,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vub_accept,<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vub_device,<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return;<br>
&gt; +<br>
&gt; + error:<br>
&gt; +=C2=A0 =C2=A0 vub_free(vub_device, false);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void vu_set_block_name(Object *obj, const char *value,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0Error **errp)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 VubDev *vus =3D VHOST_USER_SERVER(obj);;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (vus-&gt;name) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;evdev property alr=
eady set&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 vus-&gt;name =3D g_strdup(value);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static char *vu_get_block_name(Object *obj, Error **errp)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 VubDev *vus =3D VHOST_USER_SERVER(obj);<br>
&gt; +=C2=A0 =C2=A0 return g_strdup(vus-&gt;name);<br>
&gt; +}<br>
&gt; +<br>
&gt; +<br>
&gt; +static void vu_set_unix_socket(Object *obj, const char *value,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Error **errp)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 VubDev *vus =3D VHOST_USER_SERVER(obj);;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (vus-&gt;unix_socket) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;unix_socket proper=
ty already set&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 vus-&gt;unix_socket =3D g_strdup(value);<br>
&gt; +=C2=A0 =C2=A0 vhost_user_server_start(vus, value, vus-&gt;name,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vus-&gt;writable, errp);<br>
&gt; +}<br>
<br>
This makes the unix-socket property magic in that it starts the server<br>
with the properties specified at this point. This means that this<br>
property must always be specified last.<br>
<br>
Maybe it would be better to use a boolean property (similar to qdev&#39;s<b=
r>
&quot;realized&quot;) that explicitly start and possibly stops the export.<=
br>
<br>
Writing to other properties should probably result in an error while the<br=
>
server is already running because these property changes won&#39;t take<br>
effect any more then.<br>
<br>
&gt; +static char *vu_get_unix_socket(Object *obj, Error **errp)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 VubDev *vus =3D VHOST_USER_SERVER(obj);;<br>
&gt; +=C2=A0 =C2=A0 return g_strdup(vus-&gt;unix_socket);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static bool vu_get_block_writable(Object *obj, Error **errp)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 VubDev *vus =3D VHOST_USER_SERVER(obj);;<br>
&gt; +=C2=A0 =C2=A0 return vus-&gt;writable;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void vu_set_block_writable(Object *obj, bool value, Error **er=
rp)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 VubDev *vus =3D VHOST_USER_SERVER(obj);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 vus-&gt;writable =3D value;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void vhost_user_server_instance_init(Object *obj)<br>
&gt; +{<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 object_property_add_bool(obj, &quot;writable&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vu_get_block_writable,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vu_set_block_writable, NULL);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 object_property_add_str(obj, &quot;name&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vu_get_block_name,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vu_set_block_name, NULL);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 object_property_add_str(obj, &quot;unix_socket&quot;,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vu_get_unix_socket,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vu_set_unix_socket, NULL);<br>
<br>
These should probably be object_class_property_add_*() and be called in<br>
.class_init rather than .instance_init.<br>
<br>
&quot;name&quot; suggests that it&#39;s the name of the export rather than =
the block<br>
device to be exported. I would suggest &quot;node-name&quot; (and then actu=
ally<br>
only pass it as node-name to bdrv_lookup_bs()).<br>
<br>
I expect that in the long run, we&#39;ll want to accept a full SocketAddres=
s<br>
rather than just a filename like in &quot;unix_socket&quot;.<br>
<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void vhost_user_server_instance_finalize(Object *obj)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 VubDev *vus =3D VHOST_USER_SERVER(obj);<br>
&gt; +=C2=A0 =C2=A0 vhost_user_server_free(vus, true);<br>
&gt; +=C2=A0 =C2=A0 /* object_del shouldn&#39;t free this object struct */<=
br>
&gt; +=C2=A0 =C2=A0 obj-&gt;free =3D NULL;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const TypeInfo vhost_user_server_info =3D {<br>
&gt; +=C2=A0 =C2=A0 .name =3D TYPE_VHOST_USER_SERVER,<br>
&gt; +=C2=A0 =C2=A0 .parent =3D TYPE_OBJECT,<br>
&gt; +=C2=A0 =C2=A0 .instance_size =3D sizeof(VuDev),<br>
&gt; +=C2=A0 =C2=A0 .instance_init =3D vhost_user_server_instance_init,<br>
&gt; +=C2=A0 =C2=A0 .instance_finalize =3D vhost_user_server_instance_final=
ize,<br>
&gt; +=C2=A0 =C2=A0 .interfaces =3D (InterfaceInfo[]) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {TYPE_USER_CREATABLE},<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {}<br>
&gt; +=C2=A0 =C2=A0 },<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void vhost_user_server_register_types(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 type_register_static(&amp;vhost_user_server_info);<br>
&gt; +}<br>
&gt; +<br>
&gt; +type_init(vhost_user_server_register_types)<br>
&gt; +<br>
<br>
Extra empty line at the file end.<br>
<br>
In summary, I can see this going in the right direction, though in<br>
detail some more work will be needed.<br>
<br>
Kevin<br>
<br>
</blockquote></div></div><br clear=3D"all"><div><br></div>-- <br><div dir=
=3D"ltr"><div dir=3D"ltr"><div><div dir=3D"ltr"><div><i>Best regards,</i></=
div><font color=3D"#00cccc"><i>Coiby</i></font><div><font color=3D"#00cccc"=
><br></font></div></div></div></div></div>

--00000000000001863c059efe8fc3--

