Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185AFC606B0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 06:19:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0F7A21537
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 06:19:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0F7A21537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkjSv-00036h-7K
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 02:19:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58661)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hkjSD-0002cl-I9
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 02:18:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hkjSC-00056k-38
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 02:18:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36712)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>)
 id 1hkjS9-00055P-DK; Tue, 09 Jul 2019 02:18:13 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id ABACE10F6F;
 Tue,  9 Jul 2019 06:18:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-111.ams2.redhat.com
 [10.36.116.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B734B1001B10;
 Tue,  9 Jul 2019 06:18:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 54D681138648; Tue,  9 Jul 2019 08:18:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
References: <20190704130949.14017-1-dplotnikov@virtuozzo.com>
 <20190704130949.14017-4-dplotnikov@virtuozzo.com>
Date: Tue, 09 Jul 2019 08:18:07 +0200
In-Reply-To: <20190704130949.14017-4-dplotnikov@virtuozzo.com> (Denis
 Plotnikov's message of "Thu, 4 Jul 2019 16:09:49 +0300")
Message-ID: <878st7afz4.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Tue, 09 Jul 2019 06:18:12 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 3/3] qcow2: add zstd cluster compression
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

Denis Plotnikov <dplotnikov@virtuozzo.com> writes:

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
[...]
> diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
> index 7cf068f814..4344e858cb 100644
> --- a/docs/interop/qcow2.txt
> +++ b/docs/interop/qcow2.txt
> @@ -538,6 +538,9 @@ Compressed Clusters Descriptor (x = 62 - (cluster_bits - 8)):
>                      Another compressed cluster may map to the tail of the final
>                      sector used by this compressed cluster.
>  
> +                    The layout of the compressed data depends on the compression
> +                    type used for the image (see compressed cluster layout).
> +
>  If a cluster is unallocated, read requests shall read the data from the backing
>  file (except if bit 0 in the Standard Cluster Descriptor is set). If there is
>  no backing file or the backing file is smaller than the image, they shall read
> @@ -790,3 +793,19 @@ In the image file the 'enabled' state is reflected by the 'auto' flag. If this
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
> +    zlib:
> +        Byte  0 -  x:     the compressed data content
> +                          all the space provided used for compressed data
> +    zstd:
> +        Byte  0 -  3:     the length of compressed data
> +              4 -  x:     the compressed data content

Adding <http://zlib.net/> and <http://github.com/facebook/zstd> here as
well wouldn't hurt, would it?

> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 835dd3c37f..2021e03a84 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -4215,11 +4215,12 @@
>  # Compression type used in qcow2 image file
>  #
>  # @zlib:  zlib compression, see <http://zlib.net/>
> +# @zstd:  zstd compression, see <http://github.com/facebook/zstd>
>  #
>  # Since: 4.1
>  ##
>  { 'enum': 'Qcow2CompressionType',
> -  'data': [ 'zlib' ] }
> +  'data': [ 'zlib', { 'name': 'zstd', 'if': 'defined(CONFIG_ZSTD)' } ] }
>  
>  ##
>  # @BlockdevCreateOptionsQcow2:

QAPI schema
Acked-by: Markus Armbruster <armbru@redhat.com>

