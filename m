Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C032C4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 15:38:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43FA0206C2
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 15:38:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43FA0206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAFZ9-0007f9-Mv
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 11:38:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34418)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iAFOl-0000OP-Bs
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 11:28:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iAFOk-0007GF-87
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 11:28:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50424)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1iAFOh-0007FM-MW; Tue, 17 Sep 2019 11:28:07 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C009A18CB8F4;
 Tue, 17 Sep 2019 15:28:05 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-202.ams2.redhat.com
 [10.36.116.202])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A3AAA6012E;
 Tue, 17 Sep 2019 15:27:57 +0000 (UTC)
Date: Tue, 17 Sep 2019 17:27:56 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <20190917152756.GG4824@localhost.localdomain>
References: <20190821165215.61406-1-vsementsov@virtuozzo.com>
 <20190821165215.61406-2-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821165215.61406-2-vsementsov@virtuozzo.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Tue, 17 Sep 2019 15:28:06 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v8 1/3] qemu-coroutine-sleep: introduce
 qemu_co_sleep_wake
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
Cc: fam@euphon.net, sheepdog@lists.wpkg.org, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org,
 namei.unix@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 21.08.2019 um 18:52 hat Vladimir Sementsov-Ogievskiy geschrieben:
> Introduce a function to gracefully wake a coroutine sleeping in
> qemu_co_sleep_ns().
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Hm, this has become a bit more complex with the new sleep_state, but
it's probably unavoidable even we need to timer_del() from the callback.

>  include/qemu/coroutine.h    | 17 ++++++++++++--
>  block/null.c                |  2 +-
>  block/sheepdog.c            |  2 +-
>  tests/test-bdrv-drain.c     |  6 ++---
>  tests/test-block-iothread.c |  2 +-
>  util/qemu-coroutine-sleep.c | 47 +++++++++++++++++++++++++++----------
>  6 files changed, 55 insertions(+), 21 deletions(-)
> 
> diff --git a/include/qemu/coroutine.h b/include/qemu/coroutine.h
> index 9801e7f5a4..96780a4902 100644
> --- a/include/qemu/coroutine.h
> +++ b/include/qemu/coroutine.h
> @@ -274,9 +274,22 @@ void qemu_co_rwlock_wrlock(CoRwlock *lock);
>  void qemu_co_rwlock_unlock(CoRwlock *lock);
>  
>  /**
> - * Yield the coroutine for a given duration
> + * Yield the coroutine for a given duration. During this yield @sleep_state (if
> + * not NULL) is set to opaque pointer, which may be used for
> + * qemu_co_sleep_wake(). Be careful, the pointer is set back to zero when timer
> + * shoots. Don't save obtained value to other variables and don't call
> + * qemu_co_sleep_wake from another aio context.
>   */
> -void coroutine_fn qemu_co_sleep_ns(QEMUClockType type, int64_t ns);
> +void coroutine_fn qemu_co_sleep_ns(QEMUClockType type, int64_t ns,
> +                                   void **sleep_state);

Let's make the typedef for QemuCoSleepState public so that we don't have
to use a void pointer here.

I wonder if it would make sense to rename this function and keep
qemu_co_sleep_ns() as a wrapper (maybe even just macro) so that most
callers don't have to add a NULL.

> +/**
> + * Wake a coroutine if it is sleeping by qemu_co_sleep_ns. Timer will be
> + * deleted. @sleep_state must be the variable which address was given to
> + * qemu_co_sleep_ns() and should be checked to be non-NULL before calling
> + * qemu_co_sleep_wake().
> + */
> +void qemu_co_sleep_wake(void *sleep_state);
>  
>  /**
>   * Yield until a file descriptor becomes readable

The actual implementation looks right to me, so with a public
QemuCoSleepState and optionally the wrapper:

Reviewed-by: Kevin Wolf <kwolf@redhat.com>

