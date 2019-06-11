Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15AF9C4321B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 08:58:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2E1D20657
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 08:58:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2E1D20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53102 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hacbq-0001p6-7K
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 04:58:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57431)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hacX9-0004hm-SL
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 04:53:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hacX4-0006vP-7P
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 04:53:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57816)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hacWz-0006rA-MZ; Tue, 11 Jun 2019 04:53:25 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B54CF307D932;
 Tue, 11 Jun 2019 08:53:24 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-156.ams2.redhat.com
 [10.36.117.156])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AA4205D720;
 Tue, 11 Jun 2019 08:53:18 +0000 (UTC)
Date: Tue, 11 Jun 2019 10:53:17 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <20190611085317.GC8112@localhost.localdomain>
References: <20190411172709.205032-1-vsementsov@virtuozzo.com>
 <20190411172709.205032-6-vsementsov@virtuozzo.com>
 <20190607075740.GA5055@dhcp-200-226.str.redhat.com>
 <16b7ad42-611c-fc3e-2029-d491882b0750@virtuozzo.com>
 <20190607130210.GC5055@dhcp-200-226.str.redhat.com>
 <4e970256-1eb1-2d12-5d40-13341fd0890b@virtuozzo.com>
 <974c3f2d-e353-795a-8ca9-134447a311ec@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <974c3f2d-e353-795a-8ca9-134447a311ec@virtuozzo.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Tue, 11 Jun 2019 08:53:24 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
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

Am 07.06.2019 um 19:10 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 07.06.2019 18:52, Vladimir Sementsov-Ogievskiy wrote:
> > 07.06.2019 16:02, Kevin Wolf wrote:
> >> Am 07.06.2019 um 13:18 hat Vladimir Sementsov-Ogievskiy geschrieben:
> >>> 07.06.2019 10:57, Kevin Wolf wrote:
> >>>> Am 11.04.2019 um 19:27 hat Vladimir Sementsov-Ogievskiy geschriebe=
n:
> >>>>> Introduce a function to gracefully wake-up a coroutine, sleeping =
in
> >>>>> qemu_co_sleep_ns() sleep.
> >>>>>
> >>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo=
.com>
> >>>>
> >>>> You can simply reenter the coroutine while it has yielded in
> >>>> qemu_co_sleep_ns(). This is supported.
> >>>
> >>> No it doesn't. qemu_aio_coroutine_enter checks for scheduled field,
> >>> and aborts if it is set.
> >>
> >> Ah, yes, it has been broken since commit
> >>
> >> I actually tried to fix it once, but it turned out more complicated =
and
> >> I think we found a different solution for the problem at hand:
> >>
> >> =A0=A0=A0=A0 Subject: [PATCH for-2.11 0/4] Fix qemu-iotests failures
> >> =A0=A0=A0=A0 Message-Id: <20171128154350.21504-1-kwolf@redhat.com>
> >>
> >> In this case, I guess your approach with a new function to interrupt
> >> qemu_co_sleep_ns() is okay.
> >>
> >> Do we need to timer_del() when taking the shortcut? We don't necessa=
rily
> >> reenter the coroutine immediately, but might only be scheduling it. =
In
> >> this case, the timer could fire before qemu_co_sleep_ns() has run an=
d
> >> schedule the coroutine a second time
> >=20
> > No it will not, as we do cmpxchg, scheduled to NULL, so second call w=
ill do
> > nothing..
> >=20
> > But it seems unsafe, as even coroutine pointer may be stale when we c=
all
> > qemu_co_sleep_wake second time. So, we possibly should remove timer, =
but ..
> >=20
> >  =A0(ignoring co->scheduled again -
> >> maybe we should actually not do that in the timer callback path, but
> >> instead let it run into the assertion because it would be a bug for =
the
> >> timer callback to end up in this situation).
> >>
> >> Kevin
> >>
> >=20
> > Interesting, could there be a race condition, when we call qemu_co_sl=
eep_wake,
> > but co_sleep_cb already scheduled in some queue and will run soon? Th=
en removing
> > the timer will not help.
> >=20
> >=20
>=20
> Hmm, it's commented that timer_del is thread-safe..
>=20
> Hmm, so, if anyway want to return Timer pointer from qemu_co_sleep_ns, =
may be it's better
> to just call timer_mod(ts, 0) to shorten waiting instead of cheating wi=
th .scheduled?

This is probably slower than timer_del() and directly entering the
coroutine. Is there any advantage in using timer_mod()? I don't think
messing with .scheduled is too bad as it's set in the function just
below, so it pairs nicely enough.

Kevin

