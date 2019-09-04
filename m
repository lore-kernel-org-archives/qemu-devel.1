Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B233C3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 16:18:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6153A21670
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 16:18:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6153A21670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5Xz8-0002oJ-DK
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 12:18:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40151)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1i5Xy3-000297-SR
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 12:17:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1i5Xy2-0003HD-SM
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 12:17:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56188)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1i5Xxu-0003Fu-3E; Wed, 04 Sep 2019 12:17:03 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 011BAC002966;
 Wed,  4 Sep 2019 16:17:01 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-221.ams2.redhat.com
 [10.36.116.221])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CCFCB194B2;
 Wed,  4 Sep 2019 16:16:59 +0000 (UTC)
Date: Wed, 4 Sep 2019 18:16:58 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190904161658.GD21246@localhost.localdomain>
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-5-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809161407.11920-5-mreitz@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Wed, 04 Sep 2019 16:17:01 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 04/42] block: Add child access functions
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
> There are BDS children that the general block layer code can access,
> namely bs->file and bs->backing.  Since the introduction of filters and
> external data files, their meaning is not quite clear.  bs->backing can
> be a COW source, or it can be an R/W-filtered child; bs->file can be an
> R/W-filtered child, it can be data and metadata storage, or it can be
> just metadata storage.
> 
> This overloading really is not helpful.  This patch adds function that
> retrieve the correct child for each exact purpose.  Later patches in
> this series will make use of them.  Doing so will allow us to handle
> filter nodes and external data files in a meaningful way.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Each time I look at this patch, I'm confused by the function names.
Maybe I should just ask what the idea there was, or more specifically:
What does the "filtered" in "filtered child" really mean?

Apparently any child of a filter node is "filtered" (which makes sense),
but also bs->backing of a qcow2 image, while bs->file of qcow2 isn't.
raw doesn't have any "filtered" child. What's the system behind this?

It looks like bdrv_filtered_child() is the right function to iterate
along a backing file chain, but I just still fail to connect that and
the name of the function in a meaningful way.

> +/*
> + * Return the child that @bs acts as an overlay for, and from which data may be
> + * copied in COW or COR operations.  Usually this is the backing file.
> + */

Or NULL, if no such child exists.

It's relatively obvious here, but for some of the functions further down
it would be really good to describe in which cases NULL is expected (or
that NULL is even a possible return value).

Kevin

