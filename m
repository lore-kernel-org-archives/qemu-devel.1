Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD84C49ED8
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 15:16:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D1A121479
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 15:16:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D1A121479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7hsf-0005qq-Ac
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 11:16:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57713)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1i7hfM-0007SM-JC
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 11:02:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1i7hfL-0006NT-Hd
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 11:02:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33563)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1i7hfI-0006L4-T5; Tue, 10 Sep 2019 11:02:45 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EB6E4793C4;
 Tue, 10 Sep 2019 15:02:43 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-217.ams2.redhat.com
 [10.36.116.217])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DCEB360BF3;
 Tue, 10 Sep 2019 15:02:42 +0000 (UTC)
Date: Tue, 10 Sep 2019 17:02:41 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190910150241.GJ4446@localhost.localdomain>
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-24-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809161407.11920-24-mreitz@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Tue, 10 Sep 2019 15:02:43 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 23/42] blockdev: Use CAF in
 external_snapshot_prepare()
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
> This allows us to differentiate between filters and nodes with COW
> backing files: Filters cannot be used as overlays at all (for this
> function).
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Didn't we occasionally advertise blockdev-snapshot as the way to insert
filters on top at runtime? Though it seems it has always only worked for
filters that use bs->backing, among which I think there aren't any
user-creatable ones. So we're probably good.

Kevin

>  blockdev.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/blockdev.c b/blockdev.c
> index 29c6c6044a..c540802127 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -1664,7 +1664,12 @@ static void external_snapshot_prepare(BlkActionState *common,
>          goto out;
>      }
>  
> -    if (state->new_bs->backing != NULL) {
> +    if (state->new_bs->drv->is_filter) {
> +        error_setg(errp, "Filters cannot be used as overlays");
> +        goto out;
> +    }
> +
> +    if (bdrv_filtered_cow_child(state->new_bs)) {
>          error_setg(errp, "The overlay already has a backing image");
>          goto out;
>      }
> -- 
> 2.21.0
> 

