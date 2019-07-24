Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93E7C76186
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 17:49:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B390F2190F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 17:49:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B390F2190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqLO1-0004Q5-0z
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 13:49:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60622)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jdillama@redhat.com>) id 1hqLNp-0003xj-Ea
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 13:48:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jdillama@redhat.com>) id 1hqLNn-0006Fw-Nu
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 13:48:57 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38480)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jdillama@redhat.com>) id 1hqLNn-0006DZ-CY
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 13:48:55 -0400
Received: by mail-ed1-f68.google.com with SMTP id r12so13061207edo.5
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2019 10:48:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=xcZNayE5oU5dBtbAGsQUJ3Zj2ltDf7+hnDrNa5iSNTQ=;
 b=Bau7QWsU9P2PtfhUE6iUc8sYSYLKAJOtBAvT7CHSomL9wROb9wQMBMGJu84tVmwkYL
 DeTGvPpCzio0CsobiUehSyNuxasJ+vGOkrEwgxRC0hs2HvtLN6E1jiCT592wvhv+eLOo
 ZuKSZiI1HXgbPaGoE6nQR4BJOQgDWABw6acTaatUATqNoHP+BdI7gJpmNPtFc5rpKhkO
 2i0VR6OIYevFae9I3h2zO1rtXZmsE82dbkY2DNo/9GUqrqOKUjqISKiV+PmVGK/pBWvk
 6PcedDNlhRUVgERMz4cTlTjevbzgOCWHM1ZZCulVbi+UeeWfm8dxEsQNEymd8FWjCZB4
 tj5Q==
X-Gm-Message-State: APjAAAWTAkWtIDaSS1MU5SgokQuJ4NlvZ4i9lsKiXQvmxyalh9fhq071
 ZgMiNXCUT5thbqb3aQ18/w5gh4LWgQ0gTvMVbQhL5g==
X-Google-Smtp-Source: APXvYqyhmGEjeVgwzisYZ6T0q/v9sXXvBCXB5JsYKm395a0Qgn2eZY+8a56XnpzK3BShY91qHmp3DxzsmQnF0cJX2FQ=
X-Received: by 2002:a50:a56d:: with SMTP id z42mr73807008edb.241.1563990533638; 
 Wed, 24 Jul 2019 10:48:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190723071342.383909-1-sgarzare@redhat.com>
In-Reply-To: <20190723071342.383909-1-sgarzare@redhat.com>
From: Jason Dillaman <jdillama@redhat.com>
Date: Wed, 24 Jul 2019 13:48:42 -0400
Message-ID: <CA+aFP1BMUitx40WDT-fcWDjO62j3EsoSdg=3HF2b6c1EdwzUxg@mail.gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.208.68
Subject: Re: [Qemu-devel] [PATCH v3] block/rbd: add preallocation support
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
Reply-To: dillaman@redhat.com
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block <qemu-block@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Jason Dillaman <dillaman@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 23, 2019 at 3:13 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> This patch adds the support of preallocation (off/full) for the RBD
> block driver.
> If rbd_writesame() is available and supports zeroed buffers, we use
> it to quickly fill the image when full preallocation is required.
>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
> v3:
>  - rebased on master
>  - filled with zeroed buffer [Max]
>  - used rbd_writesame() only when we can disable the discard of zeroed
>    buffers
>  - added 'since: 4.2' in qapi/block-core.json [Max]
>  - used buffer as large as the "stripe unit"
> ---
>  block/rbd.c          | 202 ++++++++++++++++++++++++++++++++++++++++---
>  qapi/block-core.json |   5 +-
>  2 files changed, 192 insertions(+), 15 deletions(-)
>
> diff --git a/block/rbd.c b/block/rbd.c
> index 59757b3120..d923a5a26c 100644
> --- a/block/rbd.c
> +++ b/block/rbd.c
> @@ -64,6 +64,7 @@
>  #define OBJ_MAX_SIZE (1UL << OBJ_DEFAULT_OBJ_ORDER)
>
>  #define RBD_MAX_SNAPS 100
> +#define RBD_DEFAULT_CONCURRENT_OPS 10
>
>  /* The LIBRBD_SUPPORTS_IOVEC is defined in librbd.h */
>  #ifdef LIBRBD_SUPPORTS_IOVEC
> @@ -104,6 +105,7 @@ typedef struct BDRVRBDState {
>      char *image_name;
>      char *snap;
>      uint64_t image_size;
> +    bool ws_zero_supported; /* rbd_writesame() supports zeroed buffers */
>  } BDRVRBDState;
>
>  static int qemu_rbd_connect(rados_t *cluster, rados_ioctx_t *io_ctx,
> @@ -333,6 +335,155 @@ static void qemu_rbd_memset(RADOSCB *rcb, int64_t offs)
>      }
>  }
>
> +static int qemu_rbd_get_max_concurrent_ops(rados_t cluster)
> +{
> +    char buf[16];
> +    int ret, max_concurrent_ops;
> +
> +    ret = rados_conf_get(cluster, "rbd_concurrent_management_ops", buf,
> +                         sizeof(buf));
> +    if (ret < 0) {
> +        return RBD_DEFAULT_CONCURRENT_OPS;
> +    }
> +
> +    ret = qemu_strtoi(buf, NULL, 10, &max_concurrent_ops);
> +    if (ret < 0) {
> +        return RBD_DEFAULT_CONCURRENT_OPS;
> +    }
> +
> +    return max_concurrent_ops;
> +}
> +
> +static int qemu_rbd_do_truncate(rados_t cluster, rbd_image_t image,
> +                                int64_t offset, PreallocMode prealloc,
> +                                bool ws_zero_supported, Error **errp)
> +{
> +    uint64_t current_length;
> +    char *buf = NULL;
> +    int ret;
> +
> +    ret = rbd_get_size(image, &current_length);
> +    if (ret < 0) {
> +        error_setg_errno(errp, -ret, "Failed to get file length");
> +        goto out;
> +    }
> +
> +    if (current_length > offset && prealloc != PREALLOC_MODE_OFF) {
> +        error_setg(errp, "Cannot use preallocation for shrinking files");
> +        ret = -ENOTSUP;
> +        goto out;
> +    }
> +
> +    switch (prealloc) {
> +    case PREALLOC_MODE_FULL: {
> +        uint64_t buf_size, current_offset = current_length;
> +        ssize_t bytes;
> +
> +        ret = rbd_get_stripe_unit(image, &buf_size);
> +        if (ret < 0) {
> +            error_setg_errno(errp, -ret, "Failed to get stripe unit");
> +            goto out;
> +        }
> +
> +        ret = rbd_resize(image, offset);
> +        if (ret < 0) {
> +            error_setg_errno(errp, -ret, "Failed to resize file");
> +            goto out;
> +        }
> +
> +        buf = g_malloc0(buf_size);
> +
> +#ifdef LIBRBD_SUPPORTS_WRITESAME
> +        if (ws_zero_supported) {
> +            uint64_t writesame_max_size;
> +            int max_concurrent_ops;
> +
> +            max_concurrent_ops = qemu_rbd_get_max_concurrent_ops(cluster);
> +            /*
> +             * We limit the rbd_writesame() size to avoid to spawn more then
> +             * 'rbd_concurrent_management_ops' concurrent operations.
> +             */
> +            writesame_max_size = MIN(buf_size * max_concurrent_ops, INT_MAX);

In the most efficient world, the 'buf_size' would be some small, fixed
power of 2 value (like 512 bytes) since there isn't much need to send
extra zeroes. You would then want to writesame the full stripe period
(if possible), where a stripe period is the data block object size
(defaults to 4MiB and is availble via 'rbd_stat') * the stripe count.
In this case, the stripe count becomes the number of in-flight IOs.
Therefore, you could substitute its value w/ the max_concurrent_ops to
ensure you are issuing exactly max_concurrent_ops IOs per
rbd_writesame call.

> +
> +            while (offset - current_offset > buf_size) {
> +                bytes = MIN(offset - current_offset, writesame_max_size);
> +                /*
> +                 * rbd_writesame() supports only request where the size of the
> +                 * operation is multiple of buffer size.
> +                 */
> +                bytes -= bytes % buf_size;
> +
> +                bytes = rbd_writesame(image, current_offset, bytes, buf,
> +                                      buf_size, 0);

If the RBD in-memory cache is enabled during this operation, the
writesame will effectively just be turned into a write. Therefore,
when pre-allocating, you will want to disable the cache.

> +                if (bytes < 0) {
> +                    ret = bytes;
> +                    error_setg_errno(errp, -ret,
> +                                     "Failed to write for preallocation");
> +                    goto out;
> +                }
> +
> +                current_offset += bytes;
> +            }
> +        }
> +#endif /* LIBRBD_SUPPORTS_WRITESAME */
> +
> +        while (current_offset < offset) {
> +            bytes = rbd_write(image, current_offset,
> +                              MIN(offset - current_offset, buf_size), buf);
> +            if (bytes < 0) {
> +                ret = bytes;
> +                error_setg_errno(errp, -ret,
> +                                 "Failed to write for preallocation");
> +                goto out;
> +            }
> +
> +            current_offset += bytes;
> +        }
> +
> +        ret = rbd_flush(image);
> +        if (ret < 0) {
> +            error_setg_errno(errp, -ret, "Failed to flush the file");
> +            goto out;
> +        }
> +
> +        break;
> +    }
> +    case PREALLOC_MODE_OFF:
> +        ret = rbd_resize(image, offset);

I'm not familiar enough w/ the QEMU block code, but why would the
PREALLOC_MODE_FULL case not need to resize the image?

> +        if (ret < 0) {
> +            error_setg_errno(errp, -ret, "Failed to resize file");
> +            goto out;
> +        }
> +        break;
> +    default:
> +        error_setg(errp, "Unsupported preallocation mode: %s",
> +                   PreallocMode_str(prealloc));
> +        ret = -ENOTSUP;
> +        goto out;
> +    }
> +
> +    ret = 0;
> +
> +out:
> +    g_free(buf);
> +    return ret;
> +}
> +
> +static bool qemu_rbd_writesame_zero_supported(rados_t *cluster)
> +{
> +    int ret = 1;
> +
> +#ifdef LIBRBD_SUPPORTS_WRITESAME
> +    /*
> +     * When "rbd_discard_on_zeroed_write_same" is not available, rbd_writesame()
> +     * can discard requests with zeroed buffer.
> +     */
> +    ret = rados_conf_set(*cluster, "rbd_discard_on_zeroed_write_same", "false");
> +#endif
> +
> +    return ret == 0;
> +}
> +
>  static QemuOptsList runtime_opts = {
>      .name = "rbd",
>      .head = QTAILQ_HEAD_INITIALIZER(runtime_opts.head),
> @@ -378,6 +529,7 @@ static int qemu_rbd_do_create(BlockdevCreateOptions *options,
>      BlockdevCreateOptionsRbd *opts = &options->u.rbd;
>      rados_t cluster;
>      rados_ioctx_t io_ctx;
> +    rbd_image_t image;
>      int obj_order = 0;
>      int ret;
>
> @@ -406,13 +558,23 @@ static int qemu_rbd_do_create(BlockdevCreateOptions *options,
>          return ret;
>      }
>
> -    ret = rbd_create(io_ctx, opts->location->image, opts->size, &obj_order);
> +    ret = rbd_create(io_ctx, opts->location->image, 0, &obj_order);
>      if (ret < 0) {
>          error_setg_errno(errp, -ret, "error rbd create");
>          goto out;
>      }
>
> -    ret = 0;
> +    ret = rbd_open(io_ctx, opts->location->image, &image, NULL);
> +    if (ret < 0) {
> +        error_setg_errno(errp, -ret, "error rbd open");
> +        goto out;
> +    }
> +
> +    ret = qemu_rbd_do_truncate(cluster, image, opts->size, opts->preallocation,
> +                               qemu_rbd_writesame_zero_supported(&cluster),
> +                               errp);
> +
> +    rbd_close(image);
>  out:
>      rados_ioctx_destroy(io_ctx);
>      rados_shutdown(cluster);
> @@ -433,6 +595,7 @@ static int coroutine_fn qemu_rbd_co_create_opts(const char *filename,
>      BlockdevOptionsRbd *loc;
>      Error *local_err = NULL;
>      const char *keypairs, *password_secret;
> +    char *prealloc;
>      QDict *options = NULL;
>      int ret = 0;
>
> @@ -451,6 +614,16 @@ static int coroutine_fn qemu_rbd_co_create_opts(const char *filename,
>                                                     BLOCK_OPT_CLUSTER_SIZE, 0);
>      rbd_opts->has_cluster_size = (rbd_opts->cluster_size != 0);
>
> +    prealloc = qemu_opt_get_del(opts, BLOCK_OPT_PREALLOC);
> +    rbd_opts->preallocation = qapi_enum_parse(&PreallocMode_lookup, prealloc,
> +                                              PREALLOC_MODE_OFF, &local_err);
> +    g_free(prealloc);
> +    if (local_err) {
> +        ret = -EINVAL;
> +        error_propagate(errp, local_err);
> +        goto exit;
> +    }
> +
>      options = qdict_new();
>      qemu_rbd_parse_filename(filename, options, &local_err);
>      if (local_err) {
> @@ -770,6 +943,7 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
>
>      s->snap = g_strdup(opts->snapshot);
>      s->image_name = g_strdup(opts->image);
> +    s->ws_zero_supported = qemu_rbd_writesame_zero_supported(&s->cluster);
>
>      /* rbd_open is always r/w */
>      r = rbd_open(s->io_ctx, s->image_name, &s->image, s->snap);
> @@ -1089,21 +1263,16 @@ static int coroutine_fn qemu_rbd_co_truncate(BlockDriverState *bs,
>                                               PreallocMode prealloc,
>                                               Error **errp)
>  {
> -    int r;
> -
> -    if (prealloc != PREALLOC_MODE_OFF) {
> -        error_setg(errp, "Unsupported preallocation mode '%s'",
> -                   PreallocMode_str(prealloc));
> -        return -ENOTSUP;
> -    }
> +    BDRVRBDState *s = bs->opaque;
> +    int ret;
>
> -    r = qemu_rbd_resize(bs, offset);
> -    if (r < 0) {
> -        error_setg_errno(errp, -r, "Failed to resize file");
> -        return r;
> +    ret = qemu_rbd_do_truncate(s->cluster, s->image, offset, prealloc,
> +                               s->ws_zero_supported, errp);
> +    if (ret == 0) {
> +        s->image_size = offset;
>      }
>
> -    return 0;
> +    return ret;
>  }
>
>  static int qemu_rbd_snap_create(BlockDriverState *bs,
> @@ -1256,6 +1425,11 @@ static QemuOptsList qemu_rbd_create_opts = {
>              .type = QEMU_OPT_SIZE,
>              .help = "RBD object size"
>          },
> +        {
> +            .name = BLOCK_OPT_PREALLOC,
> +            .type = QEMU_OPT_STRING,
> +            .help = "Preallocation mode (allowed values: off, full)"
> +        },
>          {
>              .name = "password-secret",
>              .type = QEMU_OPT_STRING,
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 0d43d4f37c..ff55171f8d 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -4346,13 +4346,16 @@
>  #                   point to a snapshot.
>  # @size             Size of the virtual disk in bytes
>  # @cluster-size     RBD object size
> +# @preallocation    Preallocation mode for the new image (since: 4.2)
> +#                   (default: off; allowed values: off, full)
>  #
>  # Since: 2.12
>  ##
>  { 'struct': 'BlockdevCreateOptionsRbd',
>    'data': { 'location':         'BlockdevOptionsRbd',
>              'size':             'size',
> -            '*cluster-size' :   'size' } }
> +            '*cluster-size' :   'size',
> +            '*preallocation':   'PreallocMode' } }
>
>  ##
>  # @BlockdevVmdkSubformat:
> --
> 2.20.1
>


-- 
Jason

