Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB846C31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 10:28:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C701720851
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 10:28:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C701720851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49984 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbjRA-0008JH-32
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 06:28:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52399)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hbjNn-0005HM-NE
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 06:24:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hbjHp-0005ut-0U
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 06:18:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49162)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hbjHb-0005nJ-0N; Fri, 14 Jun 2019 06:18:07 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 30E2CC04B93D;
 Fri, 14 Jun 2019 10:18:06 +0000 (UTC)
Received: from dhcp-200-226.str.redhat.com (dhcp-200-226.str.redhat.com
 [10.33.200.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CC3997C576;
 Fri, 14 Jun 2019 10:18:04 +0000 (UTC)
Date: Fri, 14 Jun 2019 12:18:03 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Zhang Chen <chen.zhang@intel.com>
Message-ID: <20190614101803.GG6042@dhcp-200-226.str.redhat.com>
References: <20190614092853.26551-1-chen.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614092853.26551-1-chen.zhang@intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Fri, 14 Jun 2019 10:18:06 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] block/replication.c: Fix crash issue after
 failover
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
Cc: vsementsov@virtuozzo.com, qemu-block <qemu-block@nongnu.org>,
 Xie Changlong <xiechanglong.d@gmail.com>, qemu-dev <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 14.06.2019 um 11:28 hat Zhang Chen geschrieben:
> From: Zhang Chen <chen.zhang@intel.com>
> 
> No block job on active disk after failover.
> In the replication_stop() function have canceled the block job,
> we check it again here.
> 
> Signed-off-by: Zhang Chen <chen.zhang@intel.com>
> ---
>  block/replication.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/block/replication.c b/block/replication.c
> index 3d4dedddfc..bdf2bf4bbc 100644
> --- a/block/replication.c
> +++ b/block/replication.c
> @@ -146,7 +146,9 @@ static void replication_close(BlockDriverState *bs)
>          replication_stop(s->rs, false, NULL);
>      }
>      if (s->stage == BLOCK_REPLICATION_FAILOVER) {
> -        job_cancel_sync(&s->active_disk->bs->job->job);
> +        if (s->secondary_disk->bs->job) {
> +            job_cancel_sync(&s->secondary_disk->bs->job->job);
> +        }

Why are you changing the code from active_disk to secondary_disk?

Also, please rebase on top of Vladimir's '[PATCH 0/4] block: drop
bs->job'.

Kevin

