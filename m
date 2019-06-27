Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9D0C48BD7
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 16:40:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12036208E3
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 16:40:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12036208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgXRQ-0000Ey-Bc
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 12:40:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50176)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hgXNc-0006Ib-Jx
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 12:36:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hgXNa-0003dn-B3
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 12:36:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38138)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>)
 id 1hgXNO-0003QW-2M; Thu, 27 Jun 2019 12:35:58 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0ADFB30860CD;
 Thu, 27 Jun 2019 16:35:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-169.ams2.redhat.com
 [10.36.117.169])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F2D71001B27;
 Thu, 27 Jun 2019 16:35:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1BE4711386A0; Thu, 27 Jun 2019 18:35:55 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
References: <20190528143727.10529-1-dplotnikov@virtuozzo.com>
 <20190528143727.10529-2-dplotnikov@virtuozzo.com>
Date: Thu, 27 Jun 2019 18:35:55 +0200
In-Reply-To: <20190528143727.10529-2-dplotnikov@virtuozzo.com> (Denis
 Plotnikov's message of "Tue, 28 May 2019 17:37:25 +0300")
Message-ID: <871rzfc7f8.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Thu, 27 Jun 2019 16:35:57 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v0 1/3] qcow2: introduce compression type
 feature
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, den@virtuozzo.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Doc & QAPI schema review only.

Denis Plotnikov <dplotnikov@virtuozzo.com> writes:

> The patch adds some preparation parts for incompatible compression type
> feature to QCOW2 header that indicates that *all* compressed clusters
> must be (de)compressed using a certain compression type.
>
> It is implied that the compression type is set on the image creation and
> can be changed only later by image conversion, thus compression type
> defines the only compression algorithm used for the image.
>
> The goal of the feature is to add support of other compression algorithms
> to qcow2. For example, ZSTD which is more effective on compression than ZLIB.
> It works roughly x2 faster than ZLIB providing a comparable compression ratio
> and therefore provide a performance advantage in backup scenarios.
>
> The default compression is ZLIB. Images created with ZLIB compression type
> is backward compatible with older qemu versions.
>
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> ---
>  block/qcow2.c             | 61 +++++++++++++++++++++++++++++++++++++++
>  block/qcow2.h             | 29 ++++++++++++++-----
>  docs/interop/qcow2.txt    | 37 +++++++++++++++++++++++-
>  include/block/block_int.h |  1 +
>  qapi/block-core.json      | 34 ++++++++++++++++++++--
>  5 files changed, 151 insertions(+), 11 deletions(-)
[...]
> diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
> index af5711e533..cebcbc4f2f 100644
> --- a/docs/interop/qcow2.txt
> +++ b/docs/interop/qcow2.txt
> @@ -109,7 +109,14 @@ in the description of a field.
                       Bit 0:      Dirty bit.  If this bit is set then refcounts
                                   may be inconsistent, make sure to scan L1/L2
                                   tables to repair refcounts before accessing the
                                   image.

                       Bit 1:      Corrupt bit.  If this bit is set then any data
                                   structure may be corrupt and the image must not
                                   be written to (unless for regaining
                                   consistency).

                       Bit 2:      External data file bit.  If this bit is set, an
                                   external data file is used. Guest clusters are
                                   then stored in the external data file. For such
                                   images, clusters in the external data file are
                                   not refcounted. The offset field in the
                                   Standard Cluster Descriptor must match the
                                   guest offset and neither compressed clusters
                                   nor internal snapshots are supported.

>                                  An External Data File Name header extension may
>                                  be present if this bit is set.
>  
> -                    Bits 3-63:  Reserved (set to 0)
> +                    Bit 3:      Compression type. If the bit is set, then the

"Compression type bit", for consistency with the other three.

> +                                type of compression the image uses is set in the
> +                                header extension. When the bit is set the
> +                                compression type extension header must be present.
> +                                When the bit is not set the compression type
> +                                header must absent.
> +
> +                    Bits 4-63:  Reserved (set to 0)
>  
>           80 -  87:  compatible_features
>                      Bitmask of compatible features. An implementation can
> @@ -175,6 +182,7 @@ be stored. Each extension has a structure like the following:
>                          0x23852875 - Bitmaps extension
>                          0x0537be77 - Full disk encryption header pointer
>                          0x44415441 - External data file name string
> +                        0x434D5052 - Compression type extension
>                          other      - Unknown header extension, can be safely
>                                       ignored
>  
> @@ -771,3 +779,30 @@ In the image file the 'enabled' state is reflected by the 'auto' flag. If this
>  flag is set, the software must consider the bitmap as 'enabled' and start
>  tracking virtual disk changes to this bitmap from the first write to the
>  virtual disk. If this flag is not set then the bitmap is disabled.
> +
> +
> +== Compression type extension ==
> +
> +The compression type extension is an optional header extension. It stores the
> +compression type used for disk clusters (de)compression.

s/clusters/cluster/

> +A single compression type is applied to all compressed disk clusters,
> +with no way to change compression types per cluster. Two clusters of the image
> +couldn't be compressed with different compression types.

Is the text after the first comma useful?

> +
> +The compression type is set on image creation. The only way to change
> +the compression type is to convert the image explicitly.

Suggest to scratch "explicitly".

> +
> +The compression type extension is present if and only if the incompatible
> +compression type bit is set.

Suggest "if the compression type bit (incompatible feature bit 3) is
set", for consistency with existing references to incompatible feature
bits.

>                               When the bit is not set the compression type
> +header must be absent.

This sentence is redundant with "if and only if".  Suggest to drop it.

> +
> +When the compression type bit is not set and the compression type header

Suggest "not set, and".

> +extension is absent, ZLIB compression is used for compressed clusters.
> +This defines default image compression type: ZLIB.

I find this sentence confusing.  Can we drop it?

> +Qemu < 4.1 can use images created with compression type ZLIB without any
> +additional preparations and cannot use images created with compression
> +types != ZLIB.

Suggest "QEMU versions older than 4.1 can only use images created with
compression type ZLIB".

> +
> +Available compression types:
> +    0: ZLIB
> +    1: ZSTD

Please add brief explanations with pointers to additional information
for both.  Something like

       0: zlib compression, see <http://zlib.net/>
       1: zstd compression, see FIXME

Mention RFC 1950, 1951 and 1952 for zlib if you like.

> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index 01e855a066..814917baec 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -58,6 +58,7 @@
>  #define BLOCK_OPT_REFCOUNT_BITS     "refcount_bits"
>  #define BLOCK_OPT_DATA_FILE         "data_file"
>  #define BLOCK_OPT_DATA_FILE_RAW     "data_file_raw"
> +#define BLOCK_OPT_COMPRESSION_TYPE  "compression_type"
>  
>  #define BLOCK_PROBE_BUF_SIZE        512
>  
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 7ccbfff9d0..59610153fd 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -78,6 +78,9 @@
>  #
>  # @bitmaps: A list of qcow2 bitmap details (since 4.0)
>  #
> +# @compression-type: the compression method used for image clusters
> +#                    compression (since 4.1)

s/clusters/cluster/, I think.

More laconic: the image cluster compression method.

> +#
>  # Since: 1.7
>  ##
>  { 'struct': 'ImageInfoSpecificQCow2',
> @@ -89,7 +92,8 @@
>        '*corrupt': 'bool',
>        'refcount-bits': 'int',
>        '*encrypt': 'ImageInfoSpecificQCow2Encryption',
> -      '*bitmaps': ['Qcow2BitmapInfo']
> +      '*bitmaps': ['Qcow2BitmapInfo'],
> +      '*compression-type': 'Qcow2CompressionType'
>    } }
>  
>  ##
> @@ -3119,6 +3123,10 @@
>  #                         an image, the data file name is loaded from the image
>  #                         file. (since 4.0)
>  #
> +# @compression-type:      compression method to use for image clusters compression

Likewise.

> +#                         The comression method is set on image creation and can

Typo: s/comression/compression/

> +#                         be changed via image converting only. (since 4.1)

I.e. it can't be changed.  Perhaps: "The compression method is fixed at
image creation time.  To change it, you have to use qemu-img convert."

Hmm.  BlockdevOptionsQcow2 has the qcow2-specific options for -blockdev.
What does passing @compression-type to -blockdev mean?  The actual
compression type is determined by the qcow2 image...  Am I confused?

> +#
>  # Since: 2.9
>  ##
>  { 'struct': 'BlockdevOptionsQcow2',
> @@ -3134,7 +3142,8 @@
>              '*refcount-cache-size': 'int',
>              '*cache-clean-interval': 'int',
>              '*encrypt': 'BlockdevQcow2Encryption',
> -            '*data-file': 'BlockdevRef' } }
> +            '*data-file': 'BlockdevRef',
> +            '*compression-type': 'Qcow2CompressionType' } }
>  
>  ##
>  # @SshHostKeyCheckMode:
> @@ -4206,6 +4215,19 @@
>    'data': [ 'v2', 'v3' ] }
>  
>  
> +##
> +# @Qcow2CompressionType:
> +#
> +# Compression type used in qcow2 image file
> +#
> +# @zlib     : gzip compressor
> +# @zstd     : zstd compression

Two nits.  One, we don't normally put spaces before the colon.  Two,
compressor vs. compression.

But I'd suggest something like

    @zlib: zlib compression, see <http://zlib.net/>

Mention RFC 1950, 1951 and 1952 if you like.

Same for @zstd.

> +#
> +# Since: 4.1
> +##
> +{ 'enum': 'Qcow2CompressionType',
> +  'data': [ 'zlib', 'zstd' ] }
> +
>  ##
>  # @BlockdevCreateOptionsQcow2:
>  #
> @@ -4228,6 +4250,11 @@
>  # @preallocation    Preallocation mode for the new image (default: off)
>  # @lazy-refcounts   True if refcounts may be updated lazily (default: off)
>  # @refcount-bits    Width of reference counts in bits (default: 16)
> +# @compression-type Compression method used for image compressed clusters

More laconic: the image cluster compression method.

> +#                   (default: zlib(gzip), since 4.1).

The default is "zlib", not "zlib(gzip)".  If you want to explain what
zlib is, do it in Qcow2CompressionType's doc string.

> +#                   Available types:
> +#                       zlib
> +#                       zstd

Isn't this redundant?

>  #
>  # Since: 2.12
>  ##
> @@ -4243,7 +4270,8 @@
>              '*cluster-size':    'size',
>              '*preallocation':   'PreallocMode',
>              '*lazy-refcounts':  'bool',
> -            '*refcount-bits':   'int' } }
> +            '*refcount-bits':   'int',
> +            '*compression-type': 'Qcow2CompressionType' } }
>  
>  ##
>  # @BlockdevCreateOptionsQed:

