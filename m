Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8855DC43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 10:44:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 593F620675
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 10:44:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 593F620675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55491 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL3lf-0005tR-82
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 06:44:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hL3kJ-00051C-TH
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 06:42:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hL3fx-0004TZ-Tp
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 06:38:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57486)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hL3fw-0004SV-O1; Mon, 29 Apr 2019 06:38:20 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 022A359454;
	Mon, 29 Apr 2019 10:38:20 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-63.ams2.redhat.com
	[10.36.116.63])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D42117257;
	Mon, 29 Apr 2019 10:38:18 +0000 (UTC)
Date: Mon, 29 Apr 2019 12:38:16 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Anton Kuchin <antonkuchin@yandex-team.ru>
Message-ID: <20190429103816.GE8492@localhost.localdomain>
References: <57c36dca-c4d6-9b70-7799-0be96325d7c5@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <57c36dca-c4d6-9b70-7799-0be96325d7c5@yandex-team.ru>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Mon, 29 Apr 2019 10:38:20 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] aio context ownership during bdrv_close()
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
Cc: yc-core =?utf-8?B?KNGA0LDRgdGB0YvQu9C60LAp?= <yc-core@yandex-team.ru>,
	qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429103816.ykVQtQ0dhxGsOyZpA7ZxuPKnwKXugRbPOomSubNJ01o@z>

Am 26.04.2019 um 14:24 hat Anton Kuchin geschrieben:
> I can't figure out ownership of aio context during bdrv_close().
> 
> As far as I understand bdrv_unref() shold be called with acquired aio
> context to prevent concurrent operations (at least most usages in blockdev.c
> explicitly acquire and release context, but not all).

I think the theory is like this:

1. bdrv_unref() can only be called from the main thread

2. A block node for which bdrv_close() is called has no references. If
   there are no more parents that keep it in a non-default iothread,
   they should be in the main AioContext. So no locks need to be taken
   during bdrv_close().

In practice, 2. is not fully true today, even though block devices do
stop their dataplane and move the block nodes back to the main
AioContext on shutdown. I am currently working on some fixes related to
this, afterwards the situation should be better.

> But if refcount reaches zero and bs is going to be deleted in bdrv_close()
> we need to ensure that drain is finished data is flushed and there are no
> more pending coroutines and bottomhalves, so drain and flush functions can
> enter coroutine and perform yield in several places. As a result control
> returns to coroutine caller that will release aio context and when
> completion bh will continue cleanup process it will be executed without
> ownership of context. Is this a valid situation?

Do you have an example where this happens?

Normally, leaving the coroutine means that the AioContext lock is
released, but it is later reentered from the same AioContext, so the
lock will be taken again.

> Moreover if yield happens bs that is being deleted has zero refcount but is
> still present in lists graph_bdrv_states and all_bdrv_states and can be
> accidentally accessed. Shouldn't we remove it from these lists ASAP when
> deletion process starts as we do from monitor_bdrv_states?

Hm, I think it should only disappear when the image file is actually
closed. But in practice, it probably makes little difference either way.

Kevin

