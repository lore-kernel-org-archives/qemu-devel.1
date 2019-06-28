Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B0EC5B579
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 10:24:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E8FF205ED
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 10:24:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E8FF205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgo3S-0005Zj-S0
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 06:24:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56838)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hgo2l-00053v-7A
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 06:23:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hgo2j-0000NC-Rc
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 06:23:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48614)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hgo2g-0000Ia-LN; Fri, 28 Jun 2019 06:23:42 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CDCAE8666A;
 Fri, 28 Jun 2019 10:23:35 +0000 (UTC)
Received: from dhcp-200-226.str.redhat.com (dhcp-200-226.str.redhat.com
 [10.33.200.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F91E1001B02;
 Fri, 28 Jun 2019 10:23:34 +0000 (UTC)
Date: Fri, 28 Jun 2019 12:23:33 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <20190628102333.GG5179@dhcp-200-226.str.redhat.com>
References: <20190528143727.10529-1-dplotnikov@virtuozzo.com>
 <20190528143727.10529-3-dplotnikov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528143727.10529-3-dplotnikov@virtuozzo.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Fri, 28 Jun 2019 10:23:35 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v0 2/3] qcow2: add compression type
 processing
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
Cc: vsementsov@virtuozzo.com, den@virtuozzo.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, armbru@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 28.05.2019 um 16:37 hat Denis Plotnikov geschrieben:
> With the patch, qcow2 is able to process image compression type
> defined in the image header and choose the corresponding method
> for clusters compressing.
> 
> Also, it rework the cluster compression code for adding more
> compression types.
> 
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> ---
>  block/qcow2.c | 103 ++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 92 insertions(+), 11 deletions(-)
> 
> diff --git a/block/qcow2.c b/block/qcow2.c
> index c4b5b93408..90f15cc3c9 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -400,11 +400,39 @@ static int qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
>              break;
>  
>          case QCOW2_EXT_MAGIC_COMPRESSION_TYPE:
> +            /* Compression type always goes with the compression type bit set */
> +            if (!(s->incompatible_features & QCOW2_INCOMPAT_COMPRESSION_TYPE)) {
> +                error_setg(errp,
> +                           "compression_type_ext: "
> +                           "expect compression type bit set");
> +                return -EINVAL;
> +            }
> +
> +            ret = bdrv_pread(bs->file, offset, &s->compression_type, ext.len);
> +            s->compression_type = be32_to_cpu(s->compression_type);
> +
> +            if (ret < 0) {
> +                error_setg_errno(errp, -ret,
> +                                 "ERROR: Could not read compression type");
> +                return ret;
> +            }
> +
>              /*
> -             * Setting compression type to BDRVQcow2State->compression_type
> -             * from the image header is going to be here
> +             * The default compression type is not allowed when the extension
> +             * is present. ZLIB is used as the default compression type.
> +             * When compression type extension header is present then
> +             * compression_type should have a value different from the default.
>               */
> -             break;
> +            if (s->compression_type == QCOW2_COMPRESSION_TYPE_ZLIB) {
> +                error_setg(errp,
> +                           "compression_type_ext:"
> +                           "invalid compression type %d",
> +                           QCOW2_COMPRESSION_TYPE_ZLIB);
> +            }

This is a restriction that the spec doesn't make, so strictly speaking
this implementation wouldn't be compliant to the spec.

We can discuss whether the code or the spec should be changed. At the
moment, I don't see a good reason to make the restriction

> +#ifdef DEBUG_EXT
> +            printf("Qcow2: image compression type %s\n", s->compression_type);
> +#endif
> +            break;
>  
>          case QCOW2_EXT_MAGIC_DATA_FILE:
>          {

We would save most of this code if we added a new field to the header
instead of adding a header extension. Not saying that we should
definitely do this, but let's discuss it at least.

> @@ -1492,6 +1520,9 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
>      QLIST_INIT(&s->cluster_allocs);
>      QTAILQ_INIT(&s->discards);
>  
> +    /* Set default compression type */
> +    s->compression_type = QCOW2_COMPRESSION_TYPE_ZLIB;
> +
>      /* read qcow2 extensions */
>      if (qcow2_read_extensions(bs, header.header_length, ext_end, NULL,
>                                flags, &update_header, &local_err)) {
> @@ -1500,6 +1531,34 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
>          goto fail;
>      }
>  
> +    /*
> +     * The compression type is set on the extension header processing
> +     * if the compression type extension header is present.
> +     * When the compression type is different from ZLIB (default) there
> +     * should be both the compression type bit and the compression
> +     * type extension header set. When the ZLIB (default) compression
> +     * type is used there should be neither the compression type bit nor
> +     * the compression type extension header set.
> +     */
> +
> +    if ((s->incompatible_features & QCOW2_INCOMPAT_COMPRESSION_TYPE) &
> +        (s->compression_type == QCOW2_COMPRESSION_TYPE_ZLIB)) {
> +        error_setg(errp, "Illegal compression type setting");
> +        ret = -EINVAL;
> +        goto fail;
> +    }

Almost the same restriction as above, implemented a second time.

The difference is that you get the first one only for compression type
extensions that specify zlib, and you get this one also for images that
have the compression type feature flag, but are missing the extension.

So in the current shape of the patch, this is in fact just the wrong
error message. It should be something like "compression type header
extension missing".

This restriction (if the flag is set, the header extension must be
present) actually makes sense to me. Switching to a new header field
would get rid of the whole case.

> +    /* Check available compression types */
> +    switch (s->compression_type) {
> +    case QCOW2_COMPRESSION_TYPE_ZLIB:
> +        break;
> +
> +    default:
> +        error_setg(errp, "Unknown compression type");
> +        ret = -EINVAL;
> +        goto fail;
> +    }
> +
>      /* Open external data file */
>      s->data_file = bdrv_open_child(NULL, options, "data-file", bs, &child_file,
>                                     true, &local_err);
> @@ -3970,7 +4029,7 @@ fail:
>  }
>  
>  /*
> - * qcow2_compress()
> + * zlib_compress()
>   *
>   * @dest - destination buffer, @dest_size bytes
>   * @src - source buffer, @src_size bytes
> @@ -3979,7 +4038,7 @@ fail:
>   *          -1 destination buffer is not enough to store compressed data
>   *          -2 on any other error
>   */
> -static ssize_t qcow2_compress(void *dest, size_t dest_size,
> +static ssize_t zlib_compress(void *dest, size_t dest_size,
>                                const void *src, size_t src_size)

Indentation is now off in the second line.

>  {
>      ssize_t ret;
> @@ -4013,7 +4072,7 @@ static ssize_t qcow2_compress(void *dest, size_t dest_size,
>  }
>  
>  /*
> - * qcow2_decompress()
> + * zlib_decompress()
>   *
>   * Decompress some data (not more than @src_size bytes) to produce exactly
>   * @dest_size bytes.

Should the description be changed, too? (qcow2_compress() doesn't have
any - should it have some?)

> @@ -4024,7 +4083,7 @@ static ssize_t qcow2_compress(void *dest, size_t dest_size,
>   * Returns: 0 on success
>   *          -1 on fail
>   */
> -static ssize_t qcow2_decompress(void *dest, size_t dest_size,
> +static ssize_t zlib_decompress(void *dest, size_t dest_size,
>                                  const void *src, size_t src_size)

Indentation again.

Maybe keep the qcow2_ prefix and make it qcow2_(de)compress_zlib()?

Kevin

