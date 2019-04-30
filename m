Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779B9C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 09:59:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CDBE2075E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 09:59:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CDBE2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42434 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLPY2-0005Gn-HZ
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 05:59:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hLPWp-0004g0-8V
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 05:58:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hLPWn-0006wt-Bc
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 05:58:23 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42880)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hLPWl-0006vQ-N4
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 05:58:21 -0400
Received: by mail-wr1-f68.google.com with SMTP id l2so4601642wrb.9
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 02:58:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=JqvNWhoiLgTaapVUps6NoVSVPDcYl/TvDYuZmdCmR2M=;
	b=WujajRFbjLrTkQJuRnaWovd9jedMZVmkEoJ+6YvJSyTXWW8MW1r/98t69nn6ffeuJm
	Rx/efWgKPAicwwo721vlbWAobJbrxgaEdax6ISBd4T/NRk7mVdYxR7EaduEjAsCO2OYa
	FWHCH3AfiTCooVnC65Kuk/ADiZsl9BldiMIVbE+1ba0GdE4IB0JI8TK9C+OwcCDBNvga
	qfQeZJgYMXgz6OUmSa3MPa2RX0pe/xxoE3TAYrFLwHVhGRLc+eBt3L5YaLXv5cpTzAHO
	o23c3h3OUnZEkHxHBfar4oKKooURz3M2QSmeop2MsdsIIEj3rYOQvyG1Sp2UZ/yky5dF
	ERZA==
X-Gm-Message-State: APjAAAXB3syOhQ79tAn9UVsSaZQ/9ozqzN1KE89/iYQpEgnMIg6FuVuh
	Kp9B2rZ7ml9W7xYMKT1XBnZnaw==
X-Google-Smtp-Source: APXvYqxE9IEUdPc/VBazGMg2Y9oREdzV5jnv73bdruaJNf4DmQbThCo5p1uUY2XCREK/glSrwiVDDQ==
X-Received: by 2002:a5d:624f:: with SMTP id m15mr40758010wrv.102.1556618298647;
	Tue, 30 Apr 2019 02:58:18 -0700 (PDT)
Received: from steredhat (host35-203-static.12-87-b.business.telecomitalia.it.
	[87.12.203.35])
	by smtp.gmail.com with ESMTPSA id j3sm1807351wrg.72.2019.04.30.02.58.17
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 30 Apr 2019 02:58:17 -0700 (PDT)
Date: Tue, 30 Apr 2019 11:58:15 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <20190430095815.kzdqv4rnatw65hqw@steredhat>
References: <20190205090825.14059-1-dplotnikov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190205090825.14059-1-dplotnikov@virtuozzo.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH] [RFC] qcow2: add compression type feature
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, den@virtuozzo.com, qemu-devel@nongnu.org,
	qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430095815.HEvGriPnYVxHD8VzRdT7fzXO2-UvvYaWL04BC_GUQaQ@z>

Hi Denis,
few simple comments below regarding the CODING_STYLE (point 7. Comment style)

On Tue, Feb 05, 2019 at 12:08:25PM +0300, Denis Plotnikov wrote:
> The patch adds some preparation parts for incompatible compression type
> feature into QCOW2 header that indicates that *all* compressed clusters
> must be (de)compressed using a certain compression type.
> 
> It is implied that the compression type is set on the image creation and
> can be changed only later by image convertion, thus the only compression
> algorithm is used for the image.
> 
> The plan is to add support for ZSTD and then may be something more effective
> in the future.
> 
> ZSDT compression algorithm consumes 3-5 times less CPU power with a
> comparable comression ratio with zlib. It would be wise to use it for
> data compression f.e. for backups.
> 
> The default compression is ZLIB.
> 
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> ---
>  block/qcow2.c | 25 +++++++++++++++++++++++++
>  block/qcow2.h | 26 ++++++++++++++++++++++----
>  2 files changed, 47 insertions(+), 4 deletions(-)
> 
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 8c91b92865..cb3d6cc1c0 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -73,6 +73,7 @@ typedef struct {
>  #define  QCOW2_EXT_MAGIC_FEATURE_TABLE 0x6803f857
>  #define  QCOW2_EXT_MAGIC_CRYPTO_HEADER 0x0537be77
>  #define  QCOW2_EXT_MAGIC_BITMAPS 0x23852875
> +#define  QCOW2_EXT_MAGIC_COMPRESSION_TYPE 0x434D5052
>  
>  static int coroutine_fn
>  qcow2_co_preadv_compressed(BlockDriverState *bs,
> @@ -397,6 +398,9 @@ static int qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
>  #endif
>              break;
>  
> +        case QCOW2_EXT_MAGIC_COMPRESSION_TYPE:
> +            /* Setting compression type to BDRVQcow2State->compression_type */
> +            /* from the image header is going to be here */

I'd use a multiline comment block here.

>          default:
>              /* unknown magic - save it in case we need to rewrite the header */
>              /* If you add a new feature, make sure to also update the fast
> @@ -2431,6 +2435,11 @@ int qcow2_update_header(BlockDriverState *bs)
>                  .bit  = QCOW2_COMPAT_LAZY_REFCOUNTS_BITNR,
>                  .name = "lazy refcounts",
>              },
> +            {
> +                .type = QCOW2_FEAT_TYPE_INCOMPATIBLE,
> +                .bit  = QCOW2_INCOMPAT_COMPRESSION_TYPE_BITNR,
> +                .name = "compression type",
> +            },
>          };
>  
>          ret = header_ext_add(buf, QCOW2_EXT_MAGIC_FEATURE_TABLE,
> @@ -2461,6 +2470,22 @@ int qcow2_update_header(BlockDriverState *bs)
>          buflen -= ret;
>      }
>  
> +    /* Compression type extension */
> +    if (s->compression_type != 0) {
> +        Qcow2CompressionTypeExt comp_header = {
> +            .compression_type = cpu_to_be32(s->compression_type),
> +        };
> +        ret = header_ext_add(buf, QCOW2_EXT_MAGIC_COMPRESSION_TYPE,
> +                             &comp_header,
> +                             cpu_to_be64(sizeof(comp_header)),
> +                             buflen);
> +        if (ret < 0) {
> +            goto fail;
> +        }
> +        buf += ret;
> +        buflen -= ret;
> +    }
> +
>      /* Keep unknown header extensions */
>      QLIST_FOREACH(uext, &s->unknown_header_ext, next) {
>          ret = header_ext_add(buf, uext->magic, uext->data, uext->len, buflen);
> diff --git a/block/qcow2.h b/block/qcow2.h
> index 32cce9eee2..fdde5bbefd 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -112,6 +112,10 @@
>  #define QCOW2_OPT_REFCOUNT_CACHE_SIZE "refcount-cache-size"
>  #define QCOW2_OPT_CACHE_CLEAN_INTERVAL "cache-clean-interval"
>  
> +/* Compression types */
> +#define QCOW2_COMPRESSION_TYPE_ZLIB    0
> +#define QCOW2_COMPRESSION_TYPE_ZSTD    1
> +
>  typedef struct QCowHeader {
>      uint32_t magic;
>      uint32_t version;
> @@ -197,10 +201,13 @@ enum {
>  
>  /* Incompatible feature bits */
>  enum {
> -    QCOW2_INCOMPAT_DIRTY_BITNR   = 0,
> -    QCOW2_INCOMPAT_CORRUPT_BITNR = 1,
> -    QCOW2_INCOMPAT_DIRTY         = 1 << QCOW2_INCOMPAT_DIRTY_BITNR,
> -    QCOW2_INCOMPAT_CORRUPT       = 1 << QCOW2_INCOMPAT_CORRUPT_BITNR,
> +    QCOW2_INCOMPAT_DIRTY_BITNR            = 0,
> +    QCOW2_INCOMPAT_CORRUPT_BITNR          = 1,
> +    QCOW2_INCOMPAT_COMPRESSION_TYPE_BITNR = 2,
> +    QCOW2_INCOMPAT_DIRTY                  = 1 << QCOW2_INCOMPAT_DIRTY_BITNR,
> +    QCOW2_INCOMPAT_CORRUPT                = 1 << QCOW2_INCOMPAT_CORRUPT_BITNR,
> +    QCOW2_INCOMPAT_COMPRESSION_TYPE       =
> +                                    1 << QCOW2_INCOMPAT_COMPRESSION_TYPE_BITNR,
>  
>      QCOW2_INCOMPAT_MASK          = QCOW2_INCOMPAT_DIRTY
>                                   | QCOW2_INCOMPAT_CORRUPT,
> @@ -256,6 +263,10 @@ typedef struct Qcow2BitmapHeaderExt {
>      uint64_t bitmap_directory_offset;
>  } QEMU_PACKED Qcow2BitmapHeaderExt;
>  
> +typedef struct Qcow2CompressionTypeExt {
> +    uint32_t compression_type;
> +} QEMU_PACKED Qcow2CompressionTypeExt;
> +
>  typedef struct BDRVQcow2State {
>      int cluster_bits;
>      int cluster_size;
> @@ -340,6 +351,13 @@ typedef struct BDRVQcow2State {
>  
>      CoQueue compress_wait_queue;
>      int nb_compress_threads;
> +    /**

I'd remove the second asterisk here.

> +     * Compression type used for the image. Default: 0 - ZLIB
> +     * The image compression type is set on image creation.
> +     * The only way to change the compression type is to convert the image
> +     * with the desired compresion type set
> +     */
> +    uint32_t compression_type;
>  } BDRVQcow2State;
>  
>  typedef struct Qcow2COWRegion {
> -- 
> 2.17.0
> 
> 

Thanks,
Stefano

