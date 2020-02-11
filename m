Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE75FC352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 15:57:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8D2620714
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 15:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LKUvDsj0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8D2620714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1XuF-0003Q2-SM
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 10:56:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48683)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j1XtW-0002Vg-80
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 10:56:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j1XtV-0006OS-AH
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 10:56:14 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53493
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j1XtV-0006OD-6I
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 10:56:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581436572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xXH8nGiWwwHqFt/zI5lsREPaOPoiwC12mk6zevwfIUs=;
 b=LKUvDsj0V9YX74b3I7x/El50tzAi1SXiJuKki9kcfElnWiyEbgXk1fl0S1zvu0KsvkL1WI
 l3omEJbxX3yPSmQE8aV0xfjk5L0eCMTO67eTYFz3q5FZqTFSrrK9HRrr01YWYhWi2Vtqh/
 BrCq2vvfJ07NWhjPOx3jn/uhTBe7i44=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-0ktZBLgcN-GhD-d288acug-1; Tue, 11 Feb 2020 10:56:10 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B688A189F763;
 Tue, 11 Feb 2020 15:56:09 +0000 (UTC)
Received: from [10.3.116.180] (ovpn-116-180.phx2.redhat.com [10.3.116.180])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5171126E4C;
 Tue, 11 Feb 2020 15:56:09 +0000 (UTC)
Subject: Re: [PATCH v2 33/33] block: Drop @child_class from bdrv_child_perm()
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200204170848.614480-1-mreitz@redhat.com>
 <20200204170848.614480-34-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <9df21c8e-7726-f120-a075-7ee9b5ace6fd@redhat.com>
Date: Tue, 11 Feb 2020 09:56:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200204170848.614480-34-mreitz@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 0ktZBLgcN-GhD-d288acug-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/4/20 11:08 AM, Max Reitz wrote:
> Implementations should decide the necessary permissions based on @role.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   block.c                     | 45 ++++++++++++++++---------------------
>   block/backup-top.c          |  3 +--
>   block/blkdebug.c            |  3 +--
>   block/blklogwrites.c        |  3 +--
>   block/commit.c              |  1 -
>   block/copy-on-read.c        |  1 -
>   block/mirror.c              |  1 -
>   block/quorum.c              |  1 -
>   block/replication.c         |  1 -
>   block/vvfat.c               |  4 +---
>   include/block/block_int.h   |  4 +---
>   tests/test-bdrv-drain.c     | 19 +---------------
>   tests/test-bdrv-graph-mod.c |  1 -
>   13 files changed, 25 insertions(+), 62 deletions(-)

Nice diffstat.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


