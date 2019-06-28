Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F6EC4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 12:36:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC53C2083B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 12:36:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC53C2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgq7O-0005YC-LC
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 08:36:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35393)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hgq3r-000146-Lb
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:33:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hgq3p-0003y9-M3
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 08:33:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38562)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hgq3l-0003wk-RR; Fri, 28 Jun 2019 08:32:58 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0421083F3C;
 Fri, 28 Jun 2019 11:57:24 +0000 (UTC)
Received: from dhcp-200-226.str.redhat.com (dhcp-200-226.str.redhat.com
 [10.33.200.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 58F99608CA;
 Fri, 28 Jun 2019 11:57:22 +0000 (UTC)
Date: Fri, 28 Jun 2019 13:57:20 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <20190628115720.GH5179@dhcp-200-226.str.redhat.com>
References: <20190528143727.10529-1-dplotnikov@virtuozzo.com>
 <20190528143727.10529-4-dplotnikov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528143727.10529-4-dplotnikov@virtuozzo.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Fri, 28 Jun 2019 11:57:24 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v0 3/3] qcow2: add zstd cluster compression
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
> zstd significantly reduces cluster compression time.
> It provides better compression performance maintaining
> the same level of compression ratio in comparison with
> zlib, which, by the moment, has been the only compression
> method available.
> 
> The performance test results:
> Test compresses and decompresses qemu qcow2 image with just
> installed rhel-7.6 guest.
> Image cluster size: 64K. Image on disk size: 2.2G
> 
> The test was conducted with brd disk to reduce the influence
> of disk subsystem to the test results.
> The results is given in seconds.
> 
> compress cmd:
>   time ./qemu-img convert -O qcow2 -c -o compression_type=[zlib|zstd]
>                   src.img [zlib|zstd]_compressed.img
> decompress cmd
>   time ./qemu-img convert -O qcow2
>                   [zlib|zstd]_compressed.img uncompressed.img
> 
>            compression               decompression
>          zlib       zstd           zlib         zstd
> ------------------------------------------------------------
> real     65.5       16.3 (-75 %)    1.9          1.6 (-16 %)
> user     65.0       15.8            5.3          2.5
> sys       3.3        0.2            2.0          2.0
> 
> Both ZLIB and ZSTD gave the same compression ratio: 1.57
> compressed image size in both cases: 1.4G
> 
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> ---
>  block/qcow2.c | 82 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  configure     | 26 ++++++++++++++++
>  2 files changed, 108 insertions(+)
> 
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 90f15cc3c9..58901f9f79 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -26,6 +26,7 @@
>  
>  #define ZLIB_CONST
>  #include <zlib.h>
> +#include <zstd.h>
>  
>  #include "block/block_int.h"
>  #include "block/qdict.h"
> @@ -1553,6 +1554,9 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
>      case QCOW2_COMPRESSION_TYPE_ZLIB:
>          break;
>  
> +    case QCOW2_COMPRESSION_TYPE_ZSTD:
> +        break;

If we don't intend to add any code here, why not just add another case
label to the existing break?

>      default:
>          error_setg(errp, "Unknown compression type");
>          ret = -EINVAL;
> @@ -3286,6 +3290,9 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
>           *  ZLIB shouldn't be here since it's the default
>           */
>          switch (qcow2_opts->compression_type) {
> +        case QCOW2_COMPRESSION_TYPE_ZSTD:
> +            break;
> +
>          default:
>              error_setg_errno(errp, -EINVAL, "Unknown compression type");
>              goto out;
> @@ -4113,6 +4120,73 @@ static ssize_t zlib_decompress(void *dest, size_t dest_size,
>      return ret;
>  }
>  
> +/*
> + * zstd_compress()
> + *
> + * @dest - destination buffer, @dest_size bytes
> + * @src - source buffer, @src_size bytes
> + *
> + * Returns: compressed size on success
> + *          -1 on any error
> + */
> +
> +static ssize_t zstd_compress(void *dest, size_t dest_size,
> +                             const void *src, size_t src_size)
> +{
> +    /* steal some bytes to store compressed chunk size */
> +    size_t ret;

This ends up in a file, so this needs to be a fixed number of bytes.
size_t varies between different platforms, so it is not acceptable.

If I understand correctly, the maximum for this is the cluster size, so
uint32_t should be right.

This isn't plain the zstd compression format any more, so it needs to be
described in the qcow2 spec.

> +    size_t *c_size = dest;
> +    char *d_buf = dest;
> +    d_buf += sizeof(ret);

char *d_bug = dest + sizeof(ret);

> +    dest_size -= sizeof(ret);

We don't want to end up with an integer overflow, so before this:

    if (dest_size < sizeof(ret)) {
        return -ENOMEM;
    }

> +    ret = ZSTD_compress(d_buf, dest_size, src, src_size, 5);
> +
> +    if (ZSTD_isError(ret)) {
> +        return -1;
> +    }

Need an error code here, not just -1. In particular, we need to
distinguish cases where the buffer was too small and uncompressed data
should be written instead (ENOMEM) from real errors that should be
returned to the caller (EIO).

> +
> +    /* store the compressed chunk size in the very beginning of the buffer */
> +    *c_size = ret;
> +
> +    return ret + sizeof(ret);
> +}
> +
> +/*
> + * zstd_decompress()
> + *
> + * Decompress some data (not more than @src_size bytes) to produce exactly
> + * @dest_size bytes.
> + *
> + * @dest - destination buffer, @dest_size bytes
> + * @src - source buffer, @src_size bytes
> + *
> + * Returns: 0 on success
> + *          -1 on fail
> + */
> +
> +static ssize_t zstd_decompress(void *dest, size_t dest_size,
> +                             const void *src, size_t src_size)

Indentation is off.

> +{
> +    size_t ret;
> +    /*
> +     * zstd decompress wants to know the exact lenght of the data
> +     * for that purpose, zstd_compress stores the length in the
> +     * very beginning of the compressed buffer
> +     */
> +    const size_t *s_size = src;
> +    const char *s_buf = src;
> +    s_buf += sizeof(size_t);

Single line: const char *s_buf = src + sizeof(size_t);

Of course, size_t is wrong here, too. And above you used sizeof() on a
variable and here it's on the type. I think we should stay consistent.

You're lacking a check against src_size. A malicious image could make
use read beyond the end of the buffer. (Also consider that src_size
could be smaller than sizeof(size_t).)

> +    ret = ZSTD_decompress(dest, dest_size, s_buf, *s_size);
> +
> +    if (ZSTD_isError(ret)) {
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
>  #define MAX_COMPRESS_THREADS 4
>  
>  typedef ssize_t (*Qcow2CompressFunc)(void *dest, size_t dest_size,
> @@ -4189,6 +4263,10 @@ qcow2_co_compress(BlockDriverState *bs, void *dest, size_t dest_size,
>          fn = zlib_compress;
>          break;
>  
> +    case QCOW2_COMPRESSION_TYPE_ZSTD:
> +        fn = zstd_compress;
> +        break;
> +
>      default:
>          return -ENOTSUP;
>      }
> @@ -4208,6 +4286,10 @@ qcow2_co_decompress(BlockDriverState *bs, void *dest, size_t dest_size,
>          fn = zlib_decompress;
>          break;
>  
> +    case QCOW2_COMPRESSION_TYPE_ZSTD:
> +        fn = zstd_decompress;
> +        break;
> +
>      default:
>          return -ENOTSUP;
>      }
> diff --git a/configure b/configure
> index 1c563a7027..c90716189c 100755
> --- a/configure
> +++ b/configure
> @@ -433,6 +433,7 @@ opengl_dmabuf="no"
>  cpuid_h="no"
>  avx2_opt=""
>  zlib="yes"
> +zstd="yes"

This should be zstd="" so that a missing library will automatically
disable it instead of producing an error. (Building QEMU without zlib is
impossible, but building it without ZSTD should work.)

>  capstone=""
>  lzo=""
>  snappy=""
> @@ -1317,6 +1318,8 @@ for opt do
>    ;;
>    --disable-zlib-test) zlib="no"
>    ;;
> +  --disable-zstd-test) zstd="no"
> +  ;;

Instead of this one, after making the above change, options
--disable-zstd and --enable-zstd should be introduced that set
zstd="yes" (that actually does produce an error if it's not available)
or zstd="no".

>    --disable-lzo) lzo="no"
>    ;;
>    --enable-lzo) lzo="yes"
> @@ -3702,6 +3705,29 @@ EOF
>      fi
>  fi
>  
> +#########################################
> +# zstd check
> +
> +if test "$zstd" != "no" ; then
> +    if $pkg_config --exists libzstd; then
> +        zstd_cflags=$($pkg_config --cflags libzstd)
> +        zstd_libs=$($pkg_config --libs libzstd)
> +        QEMU_CFLAGS="$zstd_cflags $QEMU_CFLAGS"
> +        LIBS="$zstd_libs $LIBS"
> +    else
> +        cat > $TMPC << EOF
> +#include <zstd.h>
> +int main(void) { ZSTD_versionNumber(); return 0; }
> +EOF
> +        if compile_prog "" "-lzstd" ; then
> +            LIBS="$LIBS -lzstd"
> +        else
> +            error_exit "zstd check failed" \
> +                "Make sure to have the zstd libs and headers installed."
> +        fi

This needs to be changed, too, to get the desired behaviour. Model it
after bzip2 or lzo support checks:

    if compile_prog "" "-lbz2" ; then
        bzip2="yes"
    else
        if test "$bzip2" = "yes"; then
            feature_not_found "libbzip2" "Install libbzip2 devel"
        fi
        bzip2="no"
    fi

> +    fi
> +fi
> +
>  ##########################################
>  # SHA command probe for modules
>  if test "$modules" = yes; then

Kevin

