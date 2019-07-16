Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F1AC76192
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 13:09:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC3E620880
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 13:09:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC3E620880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnNCt-0000Kq-OJ
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 09:09:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45003)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mlevitsk@redhat.com>) id 1hnNCT-000795-5B
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 09:08:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1hnNCS-0002i0-05
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 09:08:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59092)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1hnNCP-0002fR-QC; Tue, 16 Jul 2019 09:08:53 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 298AF2D1CE;
 Tue, 16 Jul 2019 13:08:53 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 479FE60141;
 Tue, 16 Jul 2019 13:08:50 +0000 (UTC)
Message-ID: <2463ad923311b0249198fc251432929fd7688650.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Date: Tue, 16 Jul 2019 16:08:50 +0300
In-Reply-To: <20190712173600.14554-4-mreitz@redhat.com>
References: <20190712173600.14554-1-mreitz@redhat.com>
 <20190712173600.14554-4-mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Tue, 16 Jul 2019 13:08:53 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 3/7] block: Use
 blk_truncate_for_formatting()
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2019-07-12 at 19:35 +0200, Max Reitz wrote:
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/parallels.c | 2 +-
>  block/qcow.c      | 2 +-
>  block/qcow2.c     | 2 +-
>  block/qed.c       | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/block/parallels.c b/block/parallels.c
> index 00fae125d1..a17b2d92f2 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -563,7 +563,7 @@ static int coroutine_fn parallels_co_create(BlockdevCreateOptions* opts,
>      blk_set_allow_write_beyond_eof(blk, true);
>  
>      /* Create image format */
> -    ret = blk_truncate(blk, 0, PREALLOC_MODE_OFF, errp);
> +    ret = blk_truncate_for_formatting(blk, 0, errp);
>      if (ret < 0) {
>          goto out;
>      }
> diff --git a/block/qcow.c b/block/qcow.c
> index 5bdf72ba33..86034135f9 100644
> --- a/block/qcow.c
> +++ b/block/qcow.c
> @@ -858,7 +858,7 @@ static int coroutine_fn qcow_co_create(BlockdevCreateOptions *opts,
>      blk_set_allow_write_beyond_eof(qcow_blk, true);
>  
>      /* Create image format */
> -    ret = blk_truncate(qcow_blk, 0, PREALLOC_MODE_OFF, errp);
> +    ret = blk_truncate_for_formatting(qcow_blk, 0, errp);
>      if (ret < 0) {
>          goto exit;
>      }
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 039bdc2f7e..f3e53c781d 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -3184,7 +3184,7 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
>      blk_set_allow_write_beyond_eof(blk, true);
>  
>      /* Clear the protocol layer and preallocate it if necessary */
> -    ret = blk_truncate(blk, 0, PREALLOC_MODE_OFF, errp);
> +    ret = blk_truncate_for_formatting(blk, 0, errp);
>      if (ret < 0) {
>          goto out;
>      }
> diff --git a/block/qed.c b/block/qed.c
> index 77c7cef175..ec244158b5 100644
> --- a/block/qed.c
> +++ b/block/qed.c
> @@ -673,7 +673,7 @@ static int coroutine_fn bdrv_qed_co_create(BlockdevCreateOptions *opts,
>      l1_size = header.cluster_size * header.table_size;
>  
>      /* File must start empty and grow, check truncate is supported */
> -    ret = blk_truncate(blk, 0, PREALLOC_MODE_OFF, errp);
> +    ret = blk_truncate_for_formatting(blk, 0, errp);
>      if (ret < 0) {
>          goto out;
>      }


Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky


