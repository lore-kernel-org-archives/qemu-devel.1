Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD685C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 13:09:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B69B3208E3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 13:09:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B69B3208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50942 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZEcl-0002Ua-VA
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 09:09:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59407)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hZEat-0000nK-OY
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 09:07:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hZEar-0003yL-Nv
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 09:07:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38518)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hZEVm-0002vm-J1; Fri, 07 Jun 2019 09:02:28 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5ADEF30860C7;
 Fri,  7 Jun 2019 13:02:15 +0000 (UTC)
Received: from dhcp-200-226.str.redhat.com (dhcp-200-226.str.redhat.com
 [10.33.200.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AA5418CBA0;
 Fri,  7 Jun 2019 13:02:11 +0000 (UTC)
Date: Fri, 7 Jun 2019 15:02:10 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <20190607130210.GC5055@dhcp-200-226.str.redhat.com>
References: <20190411172709.205032-1-vsementsov@virtuozzo.com>
 <20190411172709.205032-6-vsementsov@virtuozzo.com>
 <20190607075740.GA5055@dhcp-200-226.str.redhat.com>
 <16b7ad42-611c-fc3e-2029-d491882b0750@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16b7ad42-611c-fc3e-2029-d491882b0750@virtuozzo.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Fri, 07 Jun 2019 13:02:15 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 5/7] qemu-coroutine-sleep: introduce
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
Cc: Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 07.06.2019 um 13:18 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 07.06.2019 10:57, Kevin Wolf wrote:
> > Am 11.04.2019 um 19:27 hat Vladimir Sementsov-Ogievskiy geschrieben:
> >> Introduce a function to gracefully wake-up a coroutine, sleeping in
> >> qemu_co_sleep_ns() sleep.
> >>
> >> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> > 
> > You can simply reenter the coroutine while it has yielded in
> > qemu_co_sleep_ns(). This is supported.
> 
> No it doesn't. qemu_aio_coroutine_enter checks for scheduled field,
> and aborts if it is set.

Ah, yes, it has been broken since commit

I actually tried to fix it once, but it turned out more complicated and
I think we found a different solution for the problem at hand:

    Subject: [PATCH for-2.11 0/4] Fix qemu-iotests failures
    Message-Id: <20171128154350.21504-1-kwolf@redhat.com>

In this case, I guess your approach with a new function to interrupt
qemu_co_sleep_ns() is okay.

Do we need to timer_del() when taking the shortcut? We don't necessarily
reenter the coroutine immediately, but might only be scheduling it. In
this case, the timer could fire before qemu_co_sleep_ns() has run and
schedule the coroutine a second time (ignoring co->scheduled again -
maybe we should actually not do that in the timer callback path, but
instead let it run into the assertion because it would be a bug for the
timer callback to end up in this situation).

Kevin

