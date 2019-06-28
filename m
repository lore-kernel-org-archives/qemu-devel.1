Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F17C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 10:12:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C92120665
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 10:12:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C92120665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgnrb-0000Cu-Cp
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 06:12:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54584)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hgnqR-0007ob-7A
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 06:11:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hgnqQ-00069W-4U
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 06:11:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44258)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hgnqN-00066c-LC; Fri, 28 Jun 2019 06:10:59 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C82468666A;
 Fri, 28 Jun 2019 10:10:53 +0000 (UTC)
Received: from dhcp-200-226.str.redhat.com (dhcp-200-226.str.redhat.com
 [10.33.200.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4AB4060BEC;
 Fri, 28 Jun 2019 10:10:52 +0000 (UTC)
Date: Fri, 28 Jun 2019 12:10:50 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <20190628101050.GF5179@dhcp-200-226.str.redhat.com>
References: <20190528143727.10529-1-dplotnikov@virtuozzo.com>
 <20190528143727.10529-2-dplotnikov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528143727.10529-2-dplotnikov@virtuozzo.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Fri, 28 Jun 2019 10:10:53 +0000 (UTC)
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
> +A single compression type is applied to all compressed disk clusters,
> +with no way to change compression types per cluster. Two clusters of the image
> +couldn't be compressed with different compression types.
> +
> +The compression type is set on image creation. The only way to change
> +the compression type is to convert the image explicitly.
> +
> +The compression type extension is present if and only if the incompatible
> +compression type bit is set. When the bit is not set the compression type
> +header must be absent.
> +
> +When the compression type bit is not set and the compression type header
> +extension is absent, ZLIB compression is used for compressed clusters.
> +This defines default image compression type: ZLIB.
> +Qemu < 4.1 can use images created with compression type ZLIB without any
> +additional preparations and cannot use images created with compression
> +types != ZLIB.
> +
> +Available compression types:
> +    0: ZLIB
> +    1: ZSTD

This section shouldn't be added at the end of the document, but after
the last section that describes a header extension (I think this is
'Full disk encryption header pointer').

Also, let me mention that I'm not reviewing the documentation wording in
detail because Markus has already given a lot of good feedback that I
don't want to duplicate.

Kevin

