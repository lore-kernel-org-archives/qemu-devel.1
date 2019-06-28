Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C00C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 10:00:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 378A9208CB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 10:00:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 378A9208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgnfv-0001WW-7W
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 06:00:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51357)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hgnak-00052F-6a
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 05:54:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hgnai-0003ZU-F3
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 05:54:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45310)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hgnac-0003OF-7W; Fri, 28 Jun 2019 05:54:43 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6AC1F308FE8D;
 Fri, 28 Jun 2019 09:54:36 +0000 (UTC)
Received: from dhcp-200-226.str.redhat.com (dhcp-200-226.str.redhat.com
 [10.33.200.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DEF4460C64;
 Fri, 28 Jun 2019 09:54:34 +0000 (UTC)
Date: Fri, 28 Jun 2019 11:54:33 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <20190628095433.GD5179@dhcp-200-226.str.redhat.com>
References: <20190528143727.10529-1-dplotnikov@virtuozzo.com>
 <20190528143727.10529-2-dplotnikov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528143727.10529-2-dplotnikov@virtuozzo.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Fri, 28 Jun 2019 09:54:36 +0000 (UTC)
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
Cc: vsementsov@virtuozzo.com, den@virtuozzo.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, armbru@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 28.05.2019 um 16:37 hat Denis Plotnikov geschrieben:
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

> @@ -3119,6 +3123,10 @@
>  #                         an image, the data file name is loaded from the image
>  #                         file. (since 4.0)
>  #
> +# @compression-type:      compression method to use for image clusters compression
> +#                         The comression method is set on image creation and can
> +#                         be changed via image converting only. (since 4.1)
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

qcow2_open() doesn't actually parse this option (and it couldn't do
anything useful with it because the image is fixed to a single
compression type), so this shouldn't be added.

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
> +#
> +# Since: 4.1
> +##
> +{ 'enum': 'Qcow2CompressionType',
> +  'data': [ 'zlib', 'zstd' ] }

I think it would be cleaner to start with only 'zlib' here, like your C
code that doesn't implement anything for non-zlib compression types yet.

'zstd' can be added to the enum when it's actually implemented. This
will also make schema introspection provide the right information with a
build that includes this patch, but not the zstd compression type
patch.

Kevin

