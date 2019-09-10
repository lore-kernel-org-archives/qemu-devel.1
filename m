Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94A5C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 11:58:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E8DD2084D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 11:58:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E8DD2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7emo-0000yf-OR
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 07:58:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50647)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1i7el5-00086g-CT
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 07:56:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1i7el4-0007n2-98
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 07:56:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33252)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1i7el2-0007j1-4P; Tue, 10 Sep 2019 07:56:28 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4A1D41DC8;
 Tue, 10 Sep 2019 11:56:27 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-217.ams2.redhat.com
 [10.36.116.217])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3CD655D9D6;
 Tue, 10 Sep 2019 11:56:22 +0000 (UTC)
Date: Tue, 10 Sep 2019 13:56:20 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190910115620.GE4446@localhost.localdomain>
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-21-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809161407.11920-21-mreitz@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Tue, 10 Sep 2019 11:56:27 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 20/42] block/snapshot: Fix fallback
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 09.08.2019 um 18:13 hat Max Reitz geschrieben:
> If the top node's driver does not provide snapshot functionality and we
> want to fall back to a node down the chain, we need to snapshot all
> non-COW children.  For simplicity's sake, just do not fall back if there
> is more than one such child.
> 
> bdrv_snapshot_goto() becomes a bit weird because we may have to redirect
> the actual child pointer, so it only works if the fallback child is
> bs->file or bs->backing (and then we have to find out which it is).
> 
> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/snapshot.c | 100 +++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 79 insertions(+), 21 deletions(-)
> 
> diff --git a/block/snapshot.c b/block/snapshot.c
> index f2f48f926a..35403c167f 100644
> --- a/block/snapshot.c
> +++ b/block/snapshot.c
> @@ -146,6 +146,32 @@ bool bdrv_snapshot_find_by_id_and_name(BlockDriverState *bs,
>      return ret;
>  }
>  
> +/**
> + * Return the child BDS to which we can fall back if the given BDS
> + * does not support snapshots.
> + * Return NULL if there is no BDS to (safely) fall back to.
> + */
> +static BlockDriverState *bdrv_snapshot_fallback(BlockDriverState *bs)
> +{
> +    BlockDriverState *child_bs = NULL;
> +    BdrvChild *child;
> +
> +    QLIST_FOREACH(child, &bs->children, next) {
> +        if (child == bdrv_filtered_cow_child(bs)) {
> +            /* Ignore: COW children need not be included in snapshots */
> +            continue;
> +        }
> +
> +        if (child_bs) {
> +            /* Cannot fall back to a single child if there are multiple */
> +            return NULL;
> +        }
> +        child_bs = child->bs;
> +    }
> +
> +    return child_bs;
> +}

Why do we return child->bs here when bdrv_snapshot_goto() then needs to
reconstruct what the associated BdrvChild was? Wouldn't it make more
sense to return BdrvChild** from here and maybe have a small wrapper for
the other functions that only need a BDS?

Kevin

