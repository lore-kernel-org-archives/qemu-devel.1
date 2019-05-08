Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E735C04AAD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 14:49:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA57821734
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 14:49:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA57821734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38430 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hONsi-0006DL-A5
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 10:49:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hONqI-0004z9-8A
	for qemu-devel@nongnu.org; Wed, 08 May 2019 10:46:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hONqH-0003sW-CA
	for qemu-devel@nongnu.org; Wed, 08 May 2019 10:46:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46142)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hONqF-0003rR-3b; Wed, 08 May 2019 10:46:43 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 662DE3079B82;
	Wed,  8 May 2019 14:46:42 +0000 (UTC)
Received: from dhcp-200-226.str.redhat.com (dhcp-200-226.str.redhat.com
	[10.33.200.226])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D1EC710027D4;
	Wed,  8 May 2019 14:46:40 +0000 (UTC)
Date: Wed, 8 May 2019 16:46:39 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190508144639.GH15525@dhcp-200-226.str.redhat.com>
References: <20190508140139.32722-1-mreitz@redhat.com>
	<20190508140139.32722-4-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190508140139.32722-4-mreitz@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Wed, 08 May 2019 14:46:42 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 3/3] iotests: Add test for rebase
 without input base
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 08.05.2019 um 16:01 hat Max Reitz geschrieben:
> This patch adds a test for rebasing an image that currently does not
> have a backing file.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/024     | 70 ++++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/024.out | 37 ++++++++++++++++++++
>  2 files changed, 107 insertions(+)
> 
> diff --git a/tests/qemu-iotests/024 b/tests/qemu-iotests/024
> index 23298c6f59..baf8ec9f28 100755
> --- a/tests/qemu-iotests/024
> +++ b/tests/qemu-iotests/024
> @@ -198,6 +198,76 @@ echo
>  # $BASE_OLD and $BASE_NEW)
>  $QEMU_IMG map "$OVERLAY" | _filter_qemu_img_map
>  
> +echo
> +echo "=== Test rebase without input base ==="
> +echo
> +
> +# Cluster allocations to be tested:
> +#
> +# Backing (new) 11 -- 11 -- 11 --
> +# COW image     22 22 11 11 -- --
> +#
> +# Expected result:
> +#
> +# COW image     22 22 11 11 00 --
> +#
> +# (Cluster 2 might be "--" after the rebase, too, but rebase just
> +#  compares the new backing file to the old one and disregards the
> +#  overlay.  Therefore, it will never discard overlay clusters.)

Is there a reason not to do that, though? I haven't tried it, but
shouldn't it be as easy as reading from blk instead of blk_old_backing?

Matter for another patch, though.

Kevin

