Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0108C34031
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 07:05:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89B8220659
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 07:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNjFwl+K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89B8220659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4fu7-0008A9-KZ
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 02:05:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32968)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <coiby.xu@gmail.com>) id 1j4ftR-0007Xw-LT
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 02:05:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <coiby.xu@gmail.com>) id 1j4ftN-00026u-Gk
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 02:05:05 -0500
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:40007)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <coiby.xu@gmail.com>) id 1j4ftM-00025a-VO
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 02:05:01 -0500
Received: by mail-lj1-x243.google.com with SMTP id n18so3030036ljo.7
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2020 23:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6SkCk9nEnxRFLBfjfx+HT6zYeI7nVqAF/sWTvS+jy8Q=;
 b=TNjFwl+KOaqJlxq32YyEDi9+xXuhNXd6aJT+fum84qZVeCbtVTnQdHjipg9taLblrd
 sg1gw1zEJVFug7WtsnWH6hFO93d/HMihcNUoOxqnCVkopGuO0MNfem4VKwV+w7vE1u2C
 6OP9SQrXxUyQYc2f6T9smLHTf9qM+r2mkz8++IVm8gwd+FCfOPkItqBtLLluK+oUISOe
 txfpsgoDbos6/tLvByr9DSR56gVhyl3tb/2f0KihvLZ93MPpegX0EMf4be/CXAHNyMnD
 S56EwJpd17PkzjyStVhO+7VMoHIk5C7gT1p9IDoQWgXlTVE7PGmPKgJOspqac0j055EG
 VA4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6SkCk9nEnxRFLBfjfx+HT6zYeI7nVqAF/sWTvS+jy8Q=;
 b=t0SaRbZne6bDyMnPaW6sptgATjRdVs/gB3X8OY2uSHAKFLU4NPD7ZvNnqOoS3tjQuW
 Bl9t6nNXDcVyS/36YpTXdc/Wf3ZZpaahMEb55VVQCsyiKWgm6oTPqW4DsvFjPtMpRYlR
 lyc7qGaG8PD7zTD5dmBBJFKBk0jJnWvE0INgnyCons3YpkoDWMH/wZ6wulUP+72yygFl
 sowpY0yl9+2Z9qNrThb7nISv87mvuEs+ErhWmpZsU9PYA0x33wf4YI5yw0MYHKp30g0j
 xqISa/AqXCJ9KyJaGZhaaW77FoR+qYgYxsGdwv5zCdQOFrRk7ro9gZDlAACN7WdML2Pr
 OdxA==
X-Gm-Message-State: APjAAAXaGkBmSibiQruqKo6gJcSFsOnyLGP68n7NlQQ2q5N/Me9WMxyZ
 LZhybEYTg/jib6Oy9e+08qQkJUUb4Iril++6NsM=
X-Google-Smtp-Source: APXvYqycLPPbnrr1/99ZFHRIcaXGL7GiXxKiMtmtFijO32S7OcEtycKgykI59MHGA8W1Pm5m9AlCGKBez4J7C/3xt9Q=
X-Received: by 2002:a2e:9955:: with SMTP id r21mr17601939ljj.283.1582182298393; 
 Wed, 19 Feb 2020 23:04:58 -0800 (PST)
MIME-Version: 1.0
References: <20200114140620.10385-1-coiby.xu@gmail.com>
 <20200114140620.10385-2-coiby.xu@gmail.com>
 <20200116135609.GD9470@linux.fritz.box>
In-Reply-To: <20200116135609.GD9470@linux.fritz.box>
From: Coiby Xu <coiby.xu@gmail.com>
Date: Thu, 20 Feb 2020 15:04:20 +0800
Message-ID: <CAJAkqrUiToke6aS_Ab8GHJga6onZvb7nZM-y_L2pgYqkiaQYeg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] vhost-user block device backend
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

Hi Kevin,

Thank you for reviewing my work in a rather detailed way.

> >  blockdev-vu.c              | 1008 ++++++++++++++++++++++++++++++++++++
> >  include/block/vhost-user.h |   46 ++
> >  vl.c                       |    4 +
> >  3 files changed, 1058 insertions(+)
> >  create mode 100644 blockdev-vu.c
> >  create mode 100644 include/block/vhost-user.h

> This adds a single, relatively big source file. I see at least two
parts: The generic vhost-user infrastructure with connection handling
etc. and the implementation of the specific vhost-user-blk device.
Separating these into two files is probably a good idea.

> I would also suggest to put the files in a new subdirectory
block/export/ and call them vhost-user.c/vhost-user-blk.c. The new
header file can be in the same directory as it shouldn't be used by
anyone else.

I've split blockdev-vu.c in two separate files but in a different subdirectory
 - backends/vhost-user-blk-server.c
 - util/vhost-user-server.c

> > +static QTAILQ_HEAD(, VubDev) vub_devs = QTAILQ_HEAD_INITIALIZER(vub_devs);
> > +
> > +
> > +typedef struct VubReq {
> > +    VuVirtqElement *elem;

> Maybe worth a comment that this was allocated with plain malloc(), so
> you must use free() rather than g_free() (which would be the default in
> QEMU)?

Although VuVirtqElement is created using malloc, VubReq is created using g_new0.


I missed several suggestions in v3 but in v4 all suggestions have been
applied. Thank you!
On Thu, Jan 16, 2020 at 9:56 PM Kevin Wolf <kwolf@redhat.com> wrote:
>
> Hi,
>
> I'm only doing a quick first review pointing out the more obvious
> things while I familiarise myself with your code. I intend to review it
> in more detail later (either in a second pass for this series, or when
> you post v3).
>
> Am 14.01.2020 um 15:06 hat Coiby Xu geschrieben:
> > By making use of libvhost, multiple block device drives can be exported and each drive can serve multiple clients simultaneously. Since vhost-user-server needs a block drive to be created first, delay the creation of this object.
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
> > +static QTAILQ_HEAD(, VubDev) vub_devs = QTAILQ_HEAD_INITIALIZER(vub_devs);
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
> > +    aio_set_fd_handler(client->blk->ctx, fd, false, NULL, NULL, NULL, NULL);
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
> > +vub_discard_write_zeroes(VubReq *req, struct iovec *iov, uint32_t iovcnt,
> > +                         uint32_t type)
> > +{
> > +    struct virtio_blk_discard_write_zeroes *desc;
> > +    ssize_t size;
> > +    void *buf;
> > +
> > +    size = iov_size(iov, iovcnt);
> > +    if (size != sizeof(*desc)) {
> > +        fprintf(stderr, "Invalid size %ld, expect %ld\n", size, sizeof(*desc));
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
> > +#define NOT_DONE 0x7fffffff /* used while emulated sync operation in progress */
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
> > +static int blk_prw(BlockBackend *blk, QEMUIOVector *qiov, int64_t offset,
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
> > +        fprintf(stderr, "%s, Sector %"PRIu64", Size %lu failed with %s\n",
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
> > +    elem = vu_queue_pop(vu_dev, vq, sizeof(VuVirtqElement) + sizeof(VubReq));
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
> > +        rc = vub_discard_write_zeroes(req, &elem->out_sg[1], out_num, type);
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
> > +               #if defined(__linux__) && defined(BLKDISCARD) && defined(BLKZEROOUT)
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
> > +static int vub_process_msg(VuDev *dev, VhostUserMsg *vmsg, int *do_reply)
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
> > +    char control[CMSG_SPACE(VHOST_MEMORY_MAX_NREGIONS * sizeof(int))] = { };
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
> > +        if (cmsg->cmsg_level == SOL_SOCKET && cmsg->cmsg_type == SCM_RIGHTS) {
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
> > +                "Error: too big message request: %d, size: vmsg->size: %u, "
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
> > +     * qio_net_listener_channel_func which will call object_unref(OBJECT(sioc))
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
> > +vub_initialize_config(BlockDriverState *bs, struct virtio_blk_config *config)
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
> > +                       const char *unix_socket, bool writable, Error **errp)
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
> > +static void vhost_user_server_start(VubDev *vub_device, const char *unix_socket,
> > +                                    const char *name, bool writable,
> > +                                    Error **errp)
> > +{
> > +
> > +    if (vub_dev_find(name) || vub_dev_find_by_unix_socket(unix_socket)) {
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
> > +    if (qio_net_listener_open_sync(vub_device->listener, addr, 1, errp) < 0) {
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


--
Best regards,
Coiby

