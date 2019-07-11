Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77323C74A5B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 16:27:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F2FC20838
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 16:27:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F2FC20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlbvK-0002Vm-L9
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 12:27:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43539)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sgarzare@redhat.com>) id 1hlbv9-000235-Co
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 12:27:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1hlbv7-00061w-US
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 12:27:47 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52935)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hlbv7-000611-NM
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 12:27:45 -0400
Received: by mail-wm1-f67.google.com with SMTP id s3so6296609wms.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 09:27:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=gLm75UpBWKxeVn//o5qGC3qSF7nS0F+hQVemYJIPiGY=;
 b=h0HET67CQOt2af9SACrqmqYie+hHGY+UTGGeYOOAV1QvbnvBB1un6lhzlKTZt6mTK8
 lg4CHp6rAobYopCp+bm8glBcFO6V6ndk5P9ab0HXqD8w3zyXxCYm81yOMA9uQWJtFyui
 4X8c2HyR7wI31iDtF4FktZzRZ/WJ4Mdl6YO+T/bvOTn9Q0cX48UDv3jhQRzR9ZbavDS/
 CduOdrIF1TUOOMFLk4Pv9GlxCPpuFzLyXgdP09wwwRMTLccekHgfL1JUHxYIZmMKT/E+
 61FDLXvC7QXUwzsWW2w2Au9NGQt/GsG30ivHPTjPUGEU69Or3MY7+SQ3z4rydPjSDHbv
 FwdQ==
X-Gm-Message-State: APjAAAWlIuhu1H3PT8FMP7VuxFjl6oA28bhFaexEfGLIgb4MMvzChvX0
 0b0Gpk9nNr/GsSj0qvnFEE4MxQ==
X-Google-Smtp-Source: APXvYqzDBm3cyWyFFVx1OdmhEYs1TEYxqqEcW9Bbyx4f7IcCIu+XQoiv/0r4f1agrFh2NMt/QGmtwQ==
X-Received: by 2002:a1c:b146:: with SMTP id a67mr4923281wmf.124.1562862463928; 
 Thu, 11 Jul 2019 09:27:43 -0700 (PDT)
Received: from steredhat (host122-201-dynamic.13-79-r.retail.telecomitalia.it.
 [79.13.201.122])
 by smtp.gmail.com with ESMTPSA id g19sm6211766wmg.10.2019.07.11.09.27.42
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 11 Jul 2019 09:27:43 -0700 (PDT)
Date: Thu, 11 Jul 2019 18:27:40 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Message-ID: <20190711162740.5p7znt5ernlw67nx@steredhat>
References: <20190711150940.17483-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190711150940.17483-1-mlevitsk@redhat.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3] LUKS: support preallocation
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
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 11, 2019 at 06:09:40PM +0300, Maxim Levitsky wrote:
> preallocation=off and preallocation=metadata
> both allocate luks header only, and preallocation=falloc/full
> is passed to underlying file.
> 
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1534951
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> 
> ---
> 
> Note that QMP support was only compile tested, since I am still learning
> on how to use it.
> 
> If there is some library/script/etc which makes it more high level,
> I would more that glad to hear about it. So far I used the qmp-shell
> 
> Also can I use qmp's blockdev-create outside a vm running?
> 
>  block/crypto.c       | 29 ++++++++++++++++++++++++++---
>  qapi/block-core.json |  5 ++++-
>  2 files changed, 30 insertions(+), 4 deletions(-)
> 
> diff --git a/block/crypto.c b/block/crypto.c
> index 8237424ae6..034a645652 100644
> --- a/block/crypto.c
> +++ b/block/crypto.c
> @@ -74,6 +74,7 @@ static ssize_t block_crypto_read_func(QCryptoBlock *block,
>  struct BlockCryptoCreateData {
>      BlockBackend *blk;
>      uint64_t size;
> +    PreallocMode prealloc;
>  };
>  
>  
> @@ -112,7 +113,7 @@ static ssize_t block_crypto_init_func(QCryptoBlock *block,
>       * available to the guest, so we must take account of that
>       * which will be used by the crypto header
>       */
> -    return blk_truncate(data->blk, data->size + headerlen, PREALLOC_MODE_OFF,
> +    return blk_truncate(data->blk, data->size + headerlen, data->prealloc,
>                          errp);
>  }
>  
> @@ -251,6 +252,7 @@ static int block_crypto_open_generic(QCryptoBlockFormat format,
>  static int block_crypto_co_create_generic(BlockDriverState *bs,
>                                            int64_t size,
>                                            QCryptoBlockCreateOptions *opts,
> +                                          PreallocMode prealloc,
>                                            Error **errp)
>  {
>      int ret;
> @@ -266,9 +268,14 @@ static int block_crypto_co_create_generic(BlockDriverState *bs,
>          goto cleanup;
>      }
>  
> +    if (prealloc == PREALLOC_MODE_METADATA) {
> +        prealloc = PREALLOC_MODE_OFF;
> +    }
> +
>      data = (struct BlockCryptoCreateData) {
>          .blk = blk,
>          .size = size,
> +        .prealloc = prealloc,
>      };
>  
>      crypto = qcrypto_block_create(opts, NULL,
> @@ -500,6 +507,7 @@ block_crypto_co_create_luks(BlockdevCreateOptions *create_options, Error **errp)
>      BlockdevCreateOptionsLUKS *luks_opts;
>      BlockDriverState *bs = NULL;
>      QCryptoBlockCreateOptions create_opts;
> +    PreallocMode preallocation = PREALLOC_MODE_OFF;
>      int ret;
>  
>      assert(create_options->driver == BLOCKDEV_DRIVER_LUKS);
> @@ -515,8 +523,11 @@ block_crypto_co_create_luks(BlockdevCreateOptions *create_options, Error **errp)
>          .u.luks = *qapi_BlockdevCreateOptionsLUKS_base(luks_opts),
>      };
>  
> +    if (luks_opts->has_preallocation)
> +        preallocation = luks_opts->preallocation;
> +
>      ret = block_crypto_co_create_generic(bs, luks_opts->size, &create_opts,
> -                                         errp);
> +                                         preallocation, errp);
>      if (ret < 0) {
>          goto fail;
>      }
> @@ -534,12 +545,24 @@ static int coroutine_fn block_crypto_co_create_opts_luks(const char *filename,
>      QCryptoBlockCreateOptions *create_opts = NULL;
>      BlockDriverState *bs = NULL;
>      QDict *cryptoopts;
> +    PreallocMode prealloc;
> +    char *buf = NULL;
>      int64_t size;
>      int ret;
> +    Error *local_err = NULL;
>  
>      /* Parse options */
>      size = qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0);
>  
> +    buf = qemu_opt_get_del(opts, BLOCK_OPT_PREALLOC);
> +    prealloc = qapi_enum_parse(&PreallocMode_lookup, buf,
> +                               PREALLOC_MODE_OFF, &local_err);
> +    g_free(buf);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return -EINVAL;
> +    }
> +
>      cryptoopts = qemu_opts_to_qdict_filtered(opts, NULL,
>                                               &block_crypto_create_opts_luks,
>                                               true);
> @@ -565,7 +588,7 @@ static int coroutine_fn block_crypto_co_create_opts_luks(const char *filename,
>      }
>  
>      /* Create format layer */
> -    ret = block_crypto_co_create_generic(bs, size, create_opts, errp);
> +    ret = block_crypto_co_create_generic(bs, size, create_opts, prealloc, errp);
>      if (ret < 0) {
>          goto fail;
>      }
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 0d43d4f37c..ebcfc9f903 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -4205,13 +4205,16 @@
>  #
>  # @file             Node to create the image format on
>  # @size             Size of the virtual disk in bytes
> +# @preallocation    Preallocation mode for the new image (default: off;
> +#                   allowed values: off/falloc/full

Should we add also "metadata" to allowed values? and "since: 4.2"?
I'd like to have (just to have similar documentation with others
preallocation parameters):

  # @preallocation    Preallocation mode for the new image (default: off;
  #                   allowed values: off, falloc, full, metadata; since: 4.2)


Thanks,
Stefano

