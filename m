Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4046C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 14:14:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9D5D23402
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 14:14:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9D5D23402
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i59ZL-0001hE-K1
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 10:14:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37663)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1i59YR-000100-H2
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 10:13:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1i59YP-0008Mj-Fi
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 10:13:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47776)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1i59YJ-0008FM-OF; Tue, 03 Sep 2019 10:12:59 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A6D1518C4264;
 Tue,  3 Sep 2019 14:12:58 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-195.ams2.redhat.com
 [10.36.116.195])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C101760A9F;
 Tue,  3 Sep 2019 14:12:56 +0000 (UTC)
Date: Tue, 3 Sep 2019 16:12:55 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <20190903141255.GL4582@localhost.localdomain>
References: <20190828125654.10544-1-dplotnikov@virtuozzo.com>
 <20190828125654.10544-4-dplotnikov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828125654.10544-4-dplotnikov@virtuozzo.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.62]); Tue, 03 Sep 2019 14:12:58 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 3/3] qcow2: add zstd cluster compression
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
 armbru@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 28.08.2019 um 14:56 hat Denis Plotnikov geschrieben:
> zstd significantly reduces cluster compression time.
> It provides better compression performance maintaining
> the same level of compression ratio in comparison with
> zlib, which, at the moment, has been the only compression
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
>  block/qcow2-threads.c  | 107 +++++++++++++++++++++++++++++++++++++++++
>  block/qcow2.c          |   7 +++
>  configure              |  34 +++++++++++++
>  docs/interop/qcow2.txt |  20 ++++++++
>  qapi/block-core.json   |   3 +-
>  5 files changed, 170 insertions(+), 1 deletion(-)
> 
> diff --git a/block/qcow2-threads.c b/block/qcow2-threads.c
> index 14b5bd76fb..f6643976f4 100644
> --- a/block/qcow2-threads.c
> +++ b/block/qcow2-threads.c
> @@ -28,6 +28,11 @@
>  #define ZLIB_CONST
>  #include <zlib.h>
>  
> +#ifdef CONFIG_ZSTD
> +#include <zstd.h>
> +#include <zstd_errors.h>
> +#endif
> +
>  #include "qcow2.h"
>  #include "block/thread-pool.h"
>  #include "crypto.h"
> @@ -165,6 +170,98 @@ static ssize_t qcow2_zlib_decompress(void *dest, size_t dest_size,
>      return ret;
>  }
>  
> +#ifdef CONFIG_ZSTD
> +/*
> + * qcow2_zstd_compress()
> + *
> + * Compress @src_size bytes of data using zstd compression method
> + *
> + * @dest - destination buffer, @dest_size bytes
> + * @src - source buffer, @src_size bytes
> + *
> + * Returns: compressed size on success
> + *          -ENOMEM destination buffer is not enough to store compressed data
> + *          -EIO    on any other error
> + */
> +
> +static ssize_t qcow2_zstd_compress(void *dest, size_t dest_size,
> +                                   const void *src, size_t src_size)
> +{
> +    ssize_t ret;
> +    uint32_t *c_size = dest;
> +    /* steal some bytes to store compressed chunk size */
> +    char *d_buf = ((char *) dest) + sizeof(*c_size);
> +
> +    /* snaity check that we can store the compressed data length */

sanity

> +    if (dest_size < sizeof(*c_size)) {
> +        return -ENOMEM;
> +    }
> +
> +    dest_size -= sizeof(*c_size);
> +
> +    ret = ZSTD_compress(d_buf, dest_size, src, src_size, 5);
> +
> +    if (ZSTD_isError(ret)) {
> +        if (ZSTD_getErrorCode(ret) == ZSTD_error_dstSize_tooSmall) {
> +            return -ENOMEM;
> +        } else {
> +            return -EIO;
> +        }
> +    }
> +
> +    /* store the compressed chunk size in the very beginning of the buffer */
> +    *c_size = cpu_to_be32(ret);
> +
> +    return ret + sizeof(*c_size);
> +}
> +
> +/*
> + * qcow2_zstd_decompress()
> + *
> + * Decompress some data (not more than @src_size bytes) to produce exactly
> + * @dest_size bytes using zstd compression method
> + *
> + * @dest - destination buffer, @dest_size bytes
> + * @src - source buffer, @src_size bytes
> + *
> + * Returns: 0 on success
> + *          -EIO on any error
> + */
> +
> +static ssize_t qcow2_zstd_decompress(void *dest, size_t dest_size,
> +                                     const void *src, size_t src_size)
> +{
> +    ssize_t ret;
> +    /*
> +     * zstd decompress wants to know the exact length of the data
> +     * for that purpose, on the compression the length is stored in
> +     * the very beginning of the compressed buffer
> +     */
> +    uint32_t s_size;
> +    const char *s_buf = ((const char *) src) + sizeof(s_size);
> +
> +    /* sanity check that we can read the content length */
> +    if (src_size < sizeof(s_size)) {
> +        return -EIO;
> +    }
> +
> +    s_size = be32_to_cpu( *(const uint32_t *) src);
> +
> +    /* sanity check that the buffer is big enough to read the content */
> +    if (src_size - sizeof(s_size) < s_size) {
> +        return -EIO;
> +    }
> +
> +    ret = ZSTD_decompress(dest, dest_size, s_buf, s_size);
> +
> +    if (ZSTD_isError(ret)) {
> +        return -EIO;
> +    }
> +
> +    return 0;
> +}
> +#endif
> +
>  static int qcow2_compress_pool_func(void *opaque)
>  {
>      Qcow2CompressData *data = opaque;
> @@ -216,6 +313,11 @@ qcow2_co_compress(BlockDriverState *bs, void *dest, size_t dest_size,
>          fn = qcow2_zlib_compress;
>          break;
>  
> +#ifdef CONFIG_ZSTD
> +    case QCOW2_COMPRESSION_TYPE_ZSTD:
> +        fn = qcow2_zstd_compress;
> +        break;
> +#endif
>      default:
>          return -ENOTSUP;
>      }
> @@ -248,6 +350,11 @@ qcow2_co_decompress(BlockDriverState *bs, void *dest, size_t dest_size,
>          fn = qcow2_zlib_decompress;
>          break;
>  
> +#ifdef CONFIG_ZSTD
> +    case QCOW2_COMPRESSION_TYPE_ZSTD:
> +        fn = qcow2_zstd_decompress;
> +        break;
> +#endif
>      default:
>          return -ENOTSUP;
>      }
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 2884b9d9f2..06f346e8cc 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -1201,6 +1201,9 @@ static int check_compression_type(BDRVQcow2State *s, Error **errp)
>  {
>      switch (s->compression_type) {
>      case QCOW2_COMPRESSION_TYPE_ZLIB:
> +#ifdef CONFIG_ZSTD
> +    case QCOW2_COMPRESSION_TYPE_ZSTD:
> +#endif
>          break;
>  
>      default:
> @@ -3293,6 +3296,10 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
>          qcow2_opts->compression_type != QCOW2_COMPRESSION_TYPE_ZLIB) {
>  
>          switch (qcow2_opts->compression_type) {
> +#ifdef CONFIG_ZSTD
> +        case QCOW2_COMPRESSION_TYPE_ZSTD:
> +            break;
> +#endif
>          default:
>              error_setg_errno(errp, -EINVAL, "Unknown compression type");
>              goto out;
> diff --git a/configure b/configure
> index 714e7fb6a1..111c34878d 100755
> --- a/configure
> +++ b/configure
> @@ -441,6 +441,7 @@ opengl_dmabuf="no"
>  cpuid_h="no"
>  avx2_opt=""
>  zlib="yes"
> +zstd=""
>  capstone=""
>  lzo=""
>  snappy=""
> @@ -1358,6 +1359,10 @@ for opt do
>    ;;
>    --disable-lzfse) lzfse="no"
>    ;;
> +  --enable-zstd) zstd="yes"
> +  ;;
> +  --disable-zstd) zstd="no"
> +  ;;
>    --enable-guest-agent) guest_agent="yes"
>    ;;
>    --disable-guest-agent) guest_agent="no"
> @@ -1812,6 +1817,7 @@ disabled with --disable-FEATURE, default is enabled if available:
>                    (for reading bzip2-compressed dmg images)
>    lzfse           support of lzfse compression library
>                    (for reading lzfse-compressed dmg images)
> +  zstd            support of zstd compression library
>    seccomp         seccomp support
>    coroutine-pool  coroutine freelist (better performance)
>    glusterfs       GlusterFS backend
> @@ -2407,6 +2413,30 @@ EOF
>      fi
>  fi
>  
> +#########################################
> +# zstd check
> +
> +if test "$zstd" == "yes" ; then

This requires an explicit --enable-zstd for support to be enabled.

The behaviour should be like with other optional libraries:

--enable-zstd:  Enable zstd support, fail configure if the library is
                missing

--diable-zstd:  Disable zstd support, the library is not needed

default:        If libzstd is available, enable zstd support; otherwise
                disable it and continue building without std support

The default isn't correctly implemented yet.

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
> +            feature_not_found "zstd" "Install libzstd-devel"
> +        fi
> +    fi
> +else
> +    zstd="no"
> +fi
> +
>  ##########################################
>  # libseccomp check
>  
> @@ -6460,6 +6490,7 @@ echo "lzo support       $lzo"
>  echo "snappy support    $snappy"
>  echo "bzip2 support     $bzip2"
>  echo "lzfse support     $lzfse"
> +echo "zstd support      $zstd"
>  echo "NUMA host support $numa"
>  echo "libxml2           $libxml2"
>  echo "tcmalloc support  $tcmalloc"
> @@ -7306,6 +7337,9 @@ fi
>  if test "$sheepdog" = "yes" ; then
>    echo "CONFIG_SHEEPDOG=y" >> $config_host_mak
>  fi
> +if test "$zstd" = "yes" ; then
> +  echo "CONFIG_ZSTD=y" >> $config_host_mak
> +fi
>  
>  if test "$tcg_interpreter" = "yes"; then
>    QEMU_INCLUDES="-iquote \$(SRC_PATH)/tcg/tci $QEMU_INCLUDES"
> diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
> index e1be8bd5c3..4b0dc124f5 100644
> --- a/docs/interop/qcow2.txt
> +++ b/docs/interop/qcow2.txt
> @@ -181,6 +181,7 @@ in the description of a field.
>                      must be set.
>                      Available compression type values:
>                          0: zlib <https://www.zlib.net/> (default)
> +                        1: zstd <http://github.com/facebook/zstd>
>  
>  Directly after the image header, optional sections called header extensions can
>  be stored. Each extension has a structure like the following:
> @@ -536,6 +537,9 @@ Compressed Clusters Descriptor (x = 62 - (cluster_bits - 8)):
>                      Another compressed cluster may map to the tail of the final
>                      sector used by this compressed cluster.
>  
> +                    The layout of the compressed data depends on the compression
> +                    type used for the image (see compressed cluster layout).
> +
>  If a cluster is unallocated, read requests shall read the data from the backing
>  file (except if bit 0 in the Standard Cluster Descriptor is set). If there is
>  no backing file or the backing file is smaller than the image, they shall read
> @@ -788,3 +792,19 @@ In the image file the 'enabled' state is reflected by the 'auto' flag. If this
>  flag is set, the software must consider the bitmap as 'enabled' and start
>  tracking virtual disk changes to this bitmap from the first write to the
>  virtual disk. If this flag is not set then the bitmap is disabled.
> +
> +=== Compressed cluster layout ===
> +
> +The compressed cluster data may have a different layout depending on the
> +compression type used for the image, and store specific data for the particular
> +compression type.
> +
> +Compressed data layout for the available compression types:
> +(x = data_space_length - 1)
> +
> +    zlib <http://zlib.net/>:
> +        Byte  0 -  x:     the compressed data content
> +                          all the space provided used for compressed data
> +    zstd <http://github.com/facebook/zstd>:
> +        Byte  0 -  3:     the length of compressed data
> +              4 -  x:     the compressed data content

...in bytes

> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 2c002ca6a9..9e458d5b40 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -4283,11 +4283,12 @@
>  # Compression type used in qcow2 image file
>  #
>  # @zlib:  zlib compression, see <http://zlib.net/>
> +# @zstd:  zstd compression, see <http://github.com/facebook/zstd>
>  #
>  # Since: 4.2
>  ##
>  { 'enum': 'Qcow2CompressionType',
> -  'data': [ 'zlib' ] }
> +  'data': [ 'zlib', { 'name': 'zstd', 'if': 'defined(CONFIG_ZSTD)' } ] }
>  
>  ##
>  # @BlockdevCreateOptionsQcow2:

Kevin

